Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F75D62B150
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Nov 2022 03:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiKPCbU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Nov 2022 21:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiKPCbS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Nov 2022 21:31:18 -0500
Received: from out199-14.us.a.mail.aliyun.com (out199-14.us.a.mail.aliyun.com [47.90.199.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1416D29379
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 18:31:16 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VUvYizu_1668565872;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VUvYizu_1668565872)
          by smtp.aliyun-inc.com;
          Wed, 16 Nov 2022 10:31:13 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-next 3/3] RDMA/erdma: Notify the latest PI to FW for reflushing when necessary
Date:   Wed, 16 Nov 2022 10:31:07 +0800
Message-Id: <20221116023107.82835-4-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20221116023107.82835-1-chengyou@linux.alibaba.com>
References: <20221116023107.82835-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Firmware is responsible for flushing WRs in HW, and it's a little
difficult for firmware to get the latest PI of QPs, especially for RQs
after QP state being changed to ERROR. So we introduce a new CMDQ
command, by which driver can notify to latest PI to FW, and then FW can
flush all posted WRs.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_qp.c    | 30 ++++++++++++++++-------
 drivers/infiniband/hw/erdma/erdma_verbs.h |  5 ++++
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_qp.c b/drivers/infiniband/hw/erdma/erdma_qp.c
index 521e97258de7..d088d6bef431 100644
--- a/drivers/infiniband/hw/erdma/erdma_qp.c
+++ b/drivers/infiniband/hw/erdma/erdma_qp.c
@@ -120,6 +120,7 @@ static int erdma_modify_qp_state_to_stop(struct erdma_qp *qp,
 int erdma_modify_qp_internal(struct erdma_qp *qp, struct erdma_qp_attrs *attrs,
 			     enum erdma_qp_attr_mask mask)
 {
+	bool need_reflush = false;
 	int drop_conn, ret = 0;
 
 	if (!mask)
@@ -135,6 +136,7 @@ int erdma_modify_qp_internal(struct erdma_qp *qp, struct erdma_qp_attrs *attrs,
 			ret = erdma_modify_qp_state_to_rts(qp, attrs, mask);
 		} else if (attrs->state == ERDMA_QP_STATE_ERROR) {
 			qp->attrs.state = ERDMA_QP_STATE_ERROR;
+			need_reflush = true;
 			if (qp->cep) {
 				erdma_cep_put(qp->cep);
 				qp->cep = NULL;
@@ -145,17 +147,12 @@ int erdma_modify_qp_internal(struct erdma_qp *qp, struct erdma_qp_attrs *attrs,
 	case ERDMA_QP_STATE_RTS:
 		drop_conn = 0;
 
-		if (attrs->state == ERDMA_QP_STATE_CLOSING) {
+		if (attrs->state == ERDMA_QP_STATE_CLOSING ||
+		    attrs->state == ERDMA_QP_STATE_TERMINATE ||
+		    attrs->state == ERDMA_QP_STATE_ERROR) {
 			ret = erdma_modify_qp_state_to_stop(qp, attrs, mask);
 			drop_conn = 1;
-		} else if (attrs->state == ERDMA_QP_STATE_TERMINATE) {
-			qp->attrs.state = ERDMA_QP_STATE_TERMINATE;
-			ret = erdma_modify_qp_state_to_stop(qp, attrs, mask);
-			drop_conn = 1;
-		} else if (attrs->state == ERDMA_QP_STATE_ERROR) {
-			ret = erdma_modify_qp_state_to_stop(qp, attrs, mask);
-			qp->attrs.state = ERDMA_QP_STATE_ERROR;
-			drop_conn = 1;
+			need_reflush = true;
 		}
 
 		if (drop_conn)
@@ -180,6 +177,12 @@ int erdma_modify_qp_internal(struct erdma_qp *qp, struct erdma_qp_attrs *attrs,
 		break;
 	}
 
+	if (need_reflush && !ret && rdma_is_kernel_res(&qp->ibqp.res)) {
+		qp->flags |= ERDMA_QP_IN_FLUSHING;
+		mod_delayed_work(qp->dev->reflush_wq, &qp->reflush_dwork,
+				 usecs_to_jiffies(100));
+	}
+
 	return ret;
 }
 
@@ -527,6 +530,10 @@ int erdma_post_send(struct ib_qp *ibqp, const struct ib_send_wr *send_wr,
 	}
 	spin_unlock_irqrestore(&qp->lock, flags);
 
+	if (unlikely(qp->flags & ERDMA_QP_IN_FLUSHING))
+		mod_delayed_work(qp->dev->reflush_wq, &qp->reflush_dwork,
+				 usecs_to_jiffies(100));
+
 	return ret;
 }
 
@@ -580,5 +587,10 @@ int erdma_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *recv_wr,
 	}
 
 	spin_unlock_irqrestore(&qp->lock, flags);
+
+	if (unlikely(qp->flags & ERDMA_QP_IN_FLUSHING))
+		mod_delayed_work(qp->dev->reflush_wq, &qp->reflush_dwork,
+				 usecs_to_jiffies(100));
+
 	return ret;
 }
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/infiniband/hw/erdma/erdma_verbs.h
index 9f341d032069..e0a993bc032a 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.h
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
@@ -173,6 +173,10 @@ enum erdma_qp_attr_mask {
 	ERDMA_QP_ATTR_MPA = (1 << 7)
 };
 
+enum erdma_qp_flags {
+	ERDMA_QP_IN_FLUSHING = (1 << 0),
+};
+
 struct erdma_qp_attrs {
 	enum erdma_qp_state state;
 	enum erdma_cc_alg cc; /* Congestion control algorithm */
@@ -197,6 +201,7 @@ struct erdma_qp {
 	struct erdma_cep *cep;
 	struct rw_semaphore state_lock;
 
+	unsigned long flags;
 	struct delayed_work reflush_dwork;
 
 	union {
-- 
2.27.0

