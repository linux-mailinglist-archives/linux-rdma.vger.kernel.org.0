Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1ABB375D86
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 01:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbhEFXio (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 19:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbhEFXim (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 19:38:42 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80452C061574
        for <linux-rdma@vger.kernel.org>; Thu,  6 May 2021 16:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-Id:Date:Cc:To:From;
        bh=i6YFyx6pmnhV20spuCC88gFr4SLp3rkIU6d9LlynQF0=; b=OfVLs3kNyc3UACC6MaKV991rNj
        7yeyzQnYKQnLV0ija9vUbDQQH23gSGNJ8xLf+EO5Wwon8E9yetCeT0t/ozsxHQaAtnZBkzg4zmv7h
        DoGULdPw1VnKTBYswfcLgAcaUREFtJ1cBEsqP8/eKd070erbXQC0quJnvT5z7cW+wsUoSlU518VvI
        74f+DgUC8rXLzUbSciUIA86lyCvBXDEesjluLab2JzfkZ2SnKvvClu8oFWbh9INIbsx9f82LJOfJd
        5DjpKRkDvZhU1kqUuJSvNyhiR6RKPjjJuminvrCRXgRB4Prv9nQZs8tqY+R8Ptj2E6XV1+OISndMr
        vOtbIVBccQqoKNAzsxrqzO+ObgkOD46lmmHovOHqMTDanQrdQOiAGptdHerQoRf+YTksWWbwu3Otq
        DCu+FGrQpGS1gBRRoBI/nFHLIqpou9yrkkhZL+WQBjHLdo4Hfyw9Z6hRNhPXheLsJZt4gHxGrFxz0
        8lji8HXlUoxzFtlGIY0cD6lD;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lenYr-0004Jc-Hq; Thu, 06 May 2021 23:37:41 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 07/31] rdma/siw: split out a __siw_cep_terminate_upcall() function
Date:   Fri,  7 May 2021 01:36:13 +0200
Message-Id: <8d6af83bbaf4647290d25c7ba0017a5a8059f107.1620343860.git.metze@samba.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620343860.git.metze@samba.org>
References: <cover.1620343860.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There are multiple places where should have the same logic.
Having one helper function to be used in all places
makes it easier to extended the logic.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 53 ++++++++++++++++++------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 2cc2863bd427..c91a74271b9b 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -103,6 +103,37 @@ static void siw_socket_disassoc(struct socket *s)
 	}
 }
 
+/*
+ * The caller needs to deal with siw_cep_set_inuse()
+ * and siw_cep_set_free()
+ */
+static void __siw_cep_terminate_upcall(struct siw_cep *cep,
+				       int reply_status)
+{
+	if (cep->qp && cep->qp->term_info.valid)
+		siw_send_terminate(cep->qp);
+
+	switch (cep->state) {
+	case SIW_EPSTATE_AWAIT_MPAREP:
+		siw_cm_upcall(cep, IW_CM_EVENT_CONNECT_REPLY,
+			      reply_status);
+		break;
+
+	case SIW_EPSTATE_RDMA_MODE:
+		siw_cm_upcall(cep, IW_CM_EVENT_CLOSE, 0);
+		break;
+
+	case SIW_EPSTATE_IDLE:
+	case SIW_EPSTATE_LISTENING:
+	case SIW_EPSTATE_CONNECTING:
+	case SIW_EPSTATE_AWAIT_MPAREQ:
+	case SIW_EPSTATE_RECVD_MPAREQ:
+	case SIW_EPSTATE_CLOSED:
+	default:
+		break;
+	}
+}
+
 static void siw_rtr_data_ready(struct sock *sk)
 {
 	struct siw_cep *cep;
@@ -395,29 +426,9 @@ void siw_qp_cm_drop(struct siw_qp *qp, int schedule)
 		}
 		siw_dbg_cep(cep, "immediate close, state %d\n", cep->state);
 
-		if (qp->term_info.valid)
-			siw_send_terminate(qp);
+		__siw_cep_terminate_upcall(cep, -EINVAL);
 
 		if (cep->cm_id) {
-			switch (cep->state) {
-			case SIW_EPSTATE_AWAIT_MPAREP:
-				siw_cm_upcall(cep, IW_CM_EVENT_CONNECT_REPLY,
-					      -EINVAL);
-				break;
-
-			case SIW_EPSTATE_RDMA_MODE:
-				siw_cm_upcall(cep, IW_CM_EVENT_CLOSE, 0);
-				break;
-
-			case SIW_EPSTATE_IDLE:
-			case SIW_EPSTATE_LISTENING:
-			case SIW_EPSTATE_CONNECTING:
-			case SIW_EPSTATE_AWAIT_MPAREQ:
-			case SIW_EPSTATE_RECVD_MPAREQ:
-			case SIW_EPSTATE_CLOSED:
-			default:
-				break;
-			}
 			cep->cm_id->rem_ref(cep->cm_id);
 			cep->cm_id = NULL;
 			siw_cep_put(cep);
-- 
2.25.1

