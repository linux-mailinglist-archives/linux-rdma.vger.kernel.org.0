Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFF554CCDA
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jun 2022 17:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241794AbiFOP26 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jun 2022 11:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243040AbiFOP2Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jun 2022 11:28:24 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD45520BDD
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jun 2022 08:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Message-Id:Date:Cc:To:From;
        bh=uhlPF86eIyB2XWzVT6cUueNapFDGhTlydRZCxMCvo9U=; b=TTnRBRTBvcWoK0tpKHn0F6sDTd
        UTqyLwuI1d2pkDPZLbFrOa2JaI9MF+30IzVUJBX9OTvyqaAbvNjFLpmvlrYU2o9WYs81iDXEsO+fg
        oimy/rLdoov9814kRn08VRsBP4o3cApJPGEUj/LU1RCqxsTAEk+9CmQeoQQ0R/hm2GEzRyVx9pDPY
        Zigd2wLwzLU4cGqvsrag1er6193HIqkETZk3YF9AXBMdZ2mJnUBc52u9l3KDfQnhYcbUmK/W+LpeA
        8JnAaMHU8N2nwCJsrzYJJ6YS5H1YWKPTrN8ZRvQ2Brf0p+eoFd94q6Zt1pAm4iGgiRmoHF4u45VdL
        zfgUWVvL3NKjHEjL65CPVGU+s6R09Kr2TzTXo6kBmU9jZ2UW2NDwcMF86EyJXbYujhbMSkJzE8oFF
        EKUemeoUOm/P7oa1MHYpCvO4dJrBWX2mEGIRAlT/Fn6K46RIF29ydc7mkPxDxwOdtNT2rjySB8a0x
        HJIdBboGwPcVljbcB/ujrZXL;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1o1Uvg-005rtq-Ai; Wed, 15 Jun 2022 15:27:36 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Cc:     Stefan Metzmacher <metze@samba.org>
Subject: [PATCH v2 05/14] rdma/siw: use __siw_cep_terminate_upcall() for SIW_CM_WORK_PEER_CLOSE
Date:   Wed, 15 Jun 2022 17:26:43 +0200
Message-Id: <31498ba0d4fde312d6bdc94072f64e29380bc966.1655305567.git.metze@samba.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1655305567.git.metze@samba.org>
References: <cover.1655305567.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 4387cdf99cf9..3160f3fc4ca8 100644
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
@@ -1076,41 +1117,11 @@ static void siw_cm_work_handler(struct work_struct *w)
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
2.34.1

