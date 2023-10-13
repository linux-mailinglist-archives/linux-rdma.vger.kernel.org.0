Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E227C7B6A
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Oct 2023 04:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjJMCB1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Oct 2023 22:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjJMCBZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Oct 2023 22:01:25 -0400
Received: from out-204.mta0.migadu.com (out-204.mta0.migadu.com [IPv6:2001:41d0:1004:224b::cc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61B6EE
        for <linux-rdma@vger.kernel.org>; Thu, 12 Oct 2023 19:01:22 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697162480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8YrQW/vSanECN6+zUBJZXBEMJmJ65MhLL45Un+N//xk=;
        b=H86I+6JVFMT7KiPnM5Op5TovlcXnSvfjhMG3w5qGq7t7waE23zmpuCconYjKUPNSwXsB5x
        6YgEvvKGaiWhA/nLPkeRjkSQlFROHxZg2sYKroS0dJz/wm6g+DUs2Poig6wiad02MLZwl4
        mzWoTrhOoT5fszoiGLOhYGs3diMkF98=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V2 15/20] RDMA/siw: Cleanup siw_accept
Date:   Fri, 13 Oct 2023 10:00:48 +0800
Message-Id: <20231013020053.2120-16-guoqing.jiang@linux.dev>
In-Reply-To: <20231013020053.2120-1-guoqing.jiang@linux.dev>
References: <20231013020053.2120-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

With the initialization of rv and the two added label, we can
simplifiy code a bit.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_cm.c | 41 ++++++++++--------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 21303bad1281..4dbdcae46a78 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1548,7 +1548,7 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	struct siw_cep *cep = (struct siw_cep *)id->provider_data;
 	struct siw_qp *qp;
 	struct siw_qp_attrs qp_attrs;
-	int rv, max_priv_data = MPA_MAX_PRIVDATA;
+	int rv = -EINVAL, max_priv_data = MPA_MAX_PRIVDATA;
 	bool wait_for_peer_rts = false;
 
 	siw_cep_set_inuse(cep);
@@ -1564,24 +1564,17 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 
 	if (cep->state != SIW_EPSTATE_RECVD_MPAREQ) {
 		siw_dbg_cep(cep, "out of state\n");
-
-		siw_cep_set_free_and_put(cep);
-
-		return -ECONNRESET;
+		rv = -ECONNRESET;
+		goto free_cep;
 	}
 	qp = siw_qp_id2obj(sdev, params->qpn);
 	if (!qp) {
 		WARN(1, "[QP %d] does not exist\n", params->qpn);
-		siw_cep_set_free_and_put(cep);
-
-		return -EINVAL;
+		goto free_cep;
 	}
 	down_write(&qp->state_lock);
-	if (qp->attrs.state > SIW_QP_STATE_RTR) {
-		rv = -EINVAL;
-		up_write(&qp->state_lock);
-		goto error;
-	}
+	if (qp->attrs.state > SIW_QP_STATE_RTR)
+		goto error_unlock;
 	siw_dbg_cep(cep, "[QP %d]\n", params->qpn);
 
 	if (try_gso && cep->mpa.hdr.params.bits & MPA_RR_FLAG_GSO_EXP) {
@@ -1595,9 +1588,7 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 			"[QP %u]: ord %d (max %d), ird %d (max %d)\n",
 			qp_id(qp), params->ord, sdev->attrs.max_ord,
 			params->ird, sdev->attrs.max_ird);
-		rv = -EINVAL;
-		up_write(&qp->state_lock);
-		goto error;
+		goto error_unlock;
 	}
 	if (cep->enhanced_rdma_conn_est)
 		max_priv_data -= sizeof(struct mpa_v2_data);
@@ -1607,9 +1598,7 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 			cep,
 			"[QP %u]: private data length: %d (max %d)\n",
 			qp_id(qp), params->private_data_len, max_priv_data);
-		rv = -EINVAL;
-		up_write(&qp->state_lock);
-		goto error;
+		goto error_unlock;
 	}
 	if (cep->enhanced_rdma_conn_est) {
 		if (params->ord > cep->ord) {
@@ -1618,9 +1607,7 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 			} else {
 				cep->ird = params->ird;
 				cep->ord = params->ord;
-				rv = -EINVAL;
-				up_write(&qp->state_lock);
-				goto error;
+				goto error_unlock;
 			}
 		}
 		if (params->ird < cep->ird) {
@@ -1629,8 +1616,7 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 				params->ird = cep->ird;
 			else {
 				rv = -ENOMEM;
-				up_write(&qp->state_lock);
-				goto error;
+				goto error_unlock;
 			}
 		}
 		if (cep->mpa.v2_ctrl.ord &
@@ -1677,7 +1663,6 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 				   SIW_QP_ATTR_ORD | SIW_QP_ATTR_IRD |
 				   SIW_QP_ATTR_MPA);
 	up_write(&qp->state_lock);
-
 	if (rv)
 		goto error;
 
@@ -1700,6 +1685,9 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	siw_cep_set_free(cep);
 
 	return 0;
+
+error_unlock:
+	up_write(&qp->state_lock);
 error:
 	siw_socket_disassoc(cep->sock);
 	sock_release(cep->sock);
@@ -1714,9 +1702,8 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	}
 	cep->qp = NULL;
 	siw_qp_put(qp);
-
+free_cep:
 	siw_cep_set_free_and_put(cep);
-
 	return rv;
 }
 
-- 
2.35.3

