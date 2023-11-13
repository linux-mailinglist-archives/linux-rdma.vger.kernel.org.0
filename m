Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6745D7E9B9B
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Nov 2023 12:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjKML55 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Nov 2023 06:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjKML5z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Nov 2023 06:57:55 -0500
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [IPv6:2001:41d0:203:375::b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381A4D75
        for <linux-rdma@vger.kernel.org>; Mon, 13 Nov 2023 03:57:51 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699876669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g+z1MOkaT0nmdWOz0kUotEwomxW5n9NeESrKS5ACmn4=;
        b=RxGwDzn8qqYd1+1xhFH+1IOAwss6fn3ULrBS6q9raiZSUywXyAtjIKXB4Hhrsyfn6zbMCo
        4rwvX+R6ZdUpHf7OcaWjSjrLltJtFUKS/BxeTC3lX5/NcKrGiueguG+4xO/8DUP31wW95O
        D2Qo5zSNf+3VzOQ9NUuVHWdOyY8661A=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V5 12/17] RDMA/siw: Cleanup siw_accept
Date:   Mon, 13 Nov 2023 19:57:21 +0800
Message-Id: <20231113115726.12762-13-guoqing.jiang@linux.dev>
In-Reply-To: <20231113115726.12762-1-guoqing.jiang@linux.dev>
References: <20231113115726.12762-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

With the initialization of rv and the two added label, we can
simplifiy code a bit.

Acked-by: Bernard Metzler <bmt@zurich.ibm.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_cm.c | 41 ++++++++++--------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 36fd459b136c..5e9a591eec58 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1558,7 +1558,7 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	struct siw_cep *cep = (struct siw_cep *)id->provider_data;
 	struct siw_qp *qp;
 	struct siw_qp_attrs qp_attrs;
-	int rv, max_priv_data = MPA_MAX_PRIVDATA;
+	int rv = -EINVAL, max_priv_data = MPA_MAX_PRIVDATA;
 	bool wait_for_peer_rts = false;
 
 	siw_cep_set_inuse(cep);
@@ -1574,24 +1574,17 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 
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
@@ -1605,9 +1598,7 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
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
@@ -1617,9 +1608,7 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
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
@@ -1628,9 +1617,7 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
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
@@ -1639,8 +1626,7 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 				params->ird = cep->ird;
 			else {
 				rv = -ENOMEM;
-				up_write(&qp->state_lock);
-				goto error;
+				goto error_unlock;
 			}
 		}
 		if (cep->mpa.v2_ctrl.ord &
@@ -1687,7 +1673,6 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 				   SIW_QP_ATTR_ORD | SIW_QP_ATTR_IRD |
 				   SIW_QP_ATTR_MPA);
 	up_write(&qp->state_lock);
-
 	if (rv)
 		goto error;
 
@@ -1710,6 +1695,9 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	siw_cep_set_free(cep);
 
 	return 0;
+
+error_unlock:
+	up_write(&qp->state_lock);
 error:
 	siw_socket_disassoc(cep->sock);
 	sock_release(cep->sock);
@@ -1724,9 +1712,8 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
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

