Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F77375D88
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 01:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhEFXi4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 19:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbhEFXi4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 19:38:56 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A48C061574
        for <linux-rdma@vger.kernel.org>; Thu,  6 May 2021 16:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-Id:Date:Cc:To:From;
        bh=4ghGPwbtdUNVmzIv9YdNxgZyOiZxvzy9M884OuRyLjg=; b=zEEJQ2tzQ4wWoZ1dZc3wYvIo/D
        noJLphrg2jHEy9jq1wb+SGbEhpjHr4DM6uAHKRpfD+DoGHZbH4b6I0rJnvkSFJXk9/WqoZH/CZNIf
        ZNguuFoaWDOEr02GeQ28BrLccKVbCQHqL9q/zn61rRAbqUGmyYI5x2n4WpG2WQCFXvcjnz11+HM3A
        PvrIucwqDiFGp0bIBjX4Ztqe8mC52euBrft5lnq0g+sUrxrbT5kBEzv82uxtCR95oxgdJ9CUnLJrX
        UyeOXDTB365zby+ccreCp5OVtiO8VCGuH9QDRfDxipixet8rCBlbFkTH4L591cKeyP6R2ma1KGHKi
        F6o4QMlEO3IzkMXkuZnz7CvIaWuY8liyHFgaUwmnNu1QFuUlkLvqTRK93wt34+3M77EMLyNfe85ca
        f/Z+8GdImG4+NPaRP0czkh/ZM9TjqJWmsmv3D+roz0otvAhD0v13nQJ6zGIogHfX0xJXfqYi7zrr5
        HdJF4iuM/NOpQuo1vjnejyVQ;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lenZ5-0004KC-87; Thu, 06 May 2021 23:37:55 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 09/31] rdma/siw: use __siw_cep_terminate_upcall() for SIW_CM_WORK_PEER_CLOSE
Date:   Fri,  7 May 2021 01:36:15 +0200
Message-Id: <8cf78b479cca333caf82eca812d421c61675d776.1620343860.git.metze@samba.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620343860.git.metze@samba.org>
References: <cover.1620343860.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It's easier to have generic logic in just one place.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 89 +++++++++++++++++-------------
 1 file changed, 50 insertions(+), 39 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index b7e7f637bd03..5338be450285 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -110,26 +110,67 @@ static void siw_socket_disassoc(struct socket *s)
 static void __siw_cep_terminate_upcall(struct siw_cep *cep,
 				       int reply_status)
 {
-	if (cep->qp && cep->qp->term_info.valid)
-		siw_send_terminate(cep->qp);
+	bool suspended = false;
+
+	if (cep->qp) {
+		struct siw_qp *qp = cep->qp;
+
+		if (qp->term_info.valid)
+			siw_send_terminate(qp);
+
+		if (qp->rx_stream.rx_suspend || qp->tx_ctx.tx_suspend)
+			suspended = true;
+	} else {
+		suspended = true;
+	}
 
 	switch (cep->state) {
 	case SIW_EPSTATE_AWAIT_MPAREP:
+		/*
+		 * MPA reply not received, but connection drop,
+		 * or timeout.
+		 */
 		siw_cm_upcall(cep, IW_CM_EVENT_CONNECT_REPLY,
 			      reply_status);
 		break;
 
 	case SIW_EPSTATE_RDMA_MODE:
+		/*
+		 * NOTE: IW_CM_EVENT_DISCONNECT is given just
+		 *       to transition IWCM into CLOSING.
+		 */
+		WARN(!suspended, "SIW_EPSTATE_RDMA_MODE called without suspended\n");
+		siw_cm_upcall(cep, IW_CM_EVENT_DISCONNECT, 0);
 		siw_cm_upcall(cep, IW_CM_EVENT_CLOSE, 0);
 		break;
 
+	case SIW_EPSTATE_RECVD_MPAREQ:
+		/*
+		 * Wait for the ulp/CM to call accept/reject
+		 */
+		siw_dbg_cep(cep, "mpa req recvd, wait for ULP\n");
+		WARN(!suspended, "SIW_EPSTATE_RECVD_MPAREQ called without suspended\n");
+		break;
+
+	case SIW_EPSTATE_AWAIT_MPAREQ:
+		/*
+		 * Socket close before MPA request received.
+		 */
+		siw_dbg_cep(cep, "no mpareq: drop listener\n");
+		if (cep->listen_cep)
+			siw_cep_put(cep->listen_cep);
+		cep->listen_cep = NULL;
+		break;
+
 	case SIW_EPSTATE_IDLE:
 	case SIW_EPSTATE_LISTENING:
 	case SIW_EPSTATE_CONNECTING:
-	case SIW_EPSTATE_AWAIT_MPAREQ:
-	case SIW_EPSTATE_RECVD_MPAREQ:
 	case SIW_EPSTATE_CLOSED:
 	default:
+		/*
+		 * for other states there is no connection
+		 * known to the IWCM.
+		 */
 		break;
 	}
 }
@@ -1077,41 +1118,11 @@ static void siw_cm_work_handler(struct work_struct *w)
 		break;
 
 	case SIW_CM_WORK_PEER_CLOSE:
-		if (cep->cm_id) {
-			if (cep->state == SIW_EPSTATE_AWAIT_MPAREP) {
-				/*
-				 * MPA reply not received, but connection drop
-				 */
-				siw_cm_upcall(cep, IW_CM_EVENT_CONNECT_REPLY,
-					      -ECONNRESET);
-			} else if (cep->state == SIW_EPSTATE_RDMA_MODE) {
-				/*
-				 * NOTE: IW_CM_EVENT_DISCONNECT is given just
-				 *       to transition IWCM into CLOSING.
-				 */
-				siw_cm_upcall(cep, IW_CM_EVENT_DISCONNECT, 0);
-				siw_cm_upcall(cep, IW_CM_EVENT_CLOSE, 0);
-			}
-			/*
-			 * for other states there is no connection
-			 * known to the IWCM.
-			 */
-		} else {
-			if (cep->state == SIW_EPSTATE_RECVD_MPAREQ) {
-				/*
-				 * Wait for the ulp/CM to call accept/reject
-				 */
-				siw_dbg_cep(cep,
-					    "mpa req recvd, wait for ULP\n");
-			} else if (cep->state == SIW_EPSTATE_AWAIT_MPAREQ) {
-				/*
-				 * Socket close before MPA request received.
-				 */
-				siw_dbg_cep(cep, "no mpareq: drop listener\n");
-				siw_cep_put(cep->listen_cep);
-				cep->listen_cep = NULL;
-			}
-		}
+		/*
+		 * Peer closed the connection: TCP_CLOSE*
+		 */
+		__siw_cep_terminate_upcall(cep, -ECONNRESET);
+
 		release_cep = 1;
 		break;
 
-- 
2.25.1

