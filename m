Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCEB59F68F
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Aug 2022 11:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbiHXJm5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Aug 2022 05:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236069AbiHXJm4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Aug 2022 05:42:56 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B8E4D27D
        for <linux-rdma@vger.kernel.org>; Wed, 24 Aug 2022 02:42:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VN7-D7M_1661334172;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VN7-D7M_1661334172)
          by smtp.aliyun-inc.com;
          Wed, 24 Aug 2022 17:42:53 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-next 1/2] RDMA/erdma: Introduce internal post_send/post_recv for qp drain
Date:   Wed, 24 Aug 2022 17:42:50 +0800
Message-Id: <20220824094251.23190-2-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220824094251.23190-1-chengyou@linux.alibaba.com>
References: <20220824094251.23190-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

For erdma, hardware won't process newly posted send WRs or recv WRs
after QP state changed to error, and no flush cqes will generated
for them. So, internal post_send and post_recv functions are introduced
to prevent the new send WRs or recv WRs.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_main.c  |  4 +-
 drivers/infiniband/hw/erdma/erdma_qp.c    | 45 ++++++++++++++++++++---
 drivers/infiniband/hw/erdma/erdma_verbs.h | 17 +++++++--
 3 files changed, 55 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
index 07e743d24847..4921ebc1286d 100644
--- a/drivers/infiniband/hw/erdma/erdma_main.c
+++ b/drivers/infiniband/hw/erdma/erdma_main.c
@@ -460,8 +460,8 @@ static const struct ib_device_ops erdma_device_ops = {
 	.mmap = erdma_mmap,
 	.mmap_free = erdma_mmap_free,
 	.modify_qp = erdma_modify_qp,
-	.post_recv = erdma_post_recv,
-	.post_send = erdma_post_send,
+	.post_recv = erdma_post_recv_nodrain,
+	.post_send = erdma_post_send_nodrain,
 	.poll_cq = erdma_poll_cq,
 	.query_device = erdma_query_device,
 	.query_gid = erdma_query_gid,
diff --git a/drivers/infiniband/hw/erdma/erdma_qp.c b/drivers/infiniband/hw/erdma/erdma_qp.c
index bc3ec22a62c5..abf8b134d076 100644
--- a/drivers/infiniband/hw/erdma/erdma_qp.c
+++ b/drivers/infiniband/hw/erdma/erdma_qp.c
@@ -475,8 +475,8 @@ static void kick_sq_db(struct erdma_qp *qp, u16 pi)
 	writeq(db_data, qp->kern_qp.hw_sq_db);
 }
 
-int erdma_post_send(struct ib_qp *ibqp, const struct ib_send_wr *send_wr,
-		    const struct ib_send_wr **bad_send_wr)
+static int erdma_post_send(struct ib_qp *ibqp, const struct ib_send_wr *send_wr,
+			   const struct ib_send_wr **bad_send_wr, bool drain)
 {
 	struct erdma_qp *qp = to_eqp(ibqp);
 	int ret = 0;
@@ -488,6 +488,16 @@ int erdma_post_send(struct ib_qp *ibqp, const struct ib_send_wr *send_wr,
 		return -EINVAL;
 
 	spin_lock_irqsave(&qp->lock, flags);
+
+	if (unlikely(qp->flags & ERDMA_QP_FLAGS_TX_STOPPED)) {
+		*bad_send_wr = send_wr;
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (unlikely(drain))
+		qp->flags |= ERDMA_QP_FLAGS_TX_STOPPED;
+
 	sq_pi = qp->kern_qp.sq_pi;
 
 	while (wr) {
@@ -507,11 +517,19 @@ int erdma_post_send(struct ib_qp *ibqp, const struct ib_send_wr *send_wr,
 
 		wr = wr->next;
 	}
-	spin_unlock_irqrestore(&qp->lock, flags);
 
+out:
+	spin_unlock_irqrestore(&qp->lock, flags);
 	return ret;
 }
 
+int erdma_post_send_nodrain(struct ib_qp *ibqp,
+			    const struct ib_send_wr *send_wr,
+			    const struct ib_send_wr **bad_send_wr)
+{
+	return erdma_post_send(ibqp, send_wr, bad_send_wr, false);
+}
+
 static int erdma_post_recv_one(struct erdma_qp *qp,
 			       const struct ib_recv_wr *recv_wr)
 {
@@ -542,8 +560,8 @@ static int erdma_post_recv_one(struct erdma_qp *qp,
 	return 0;
 }
 
-int erdma_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *recv_wr,
-		    const struct ib_recv_wr **bad_recv_wr)
+static int erdma_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *recv_wr,
+			   const struct ib_recv_wr **bad_recv_wr, bool drain)
 {
 	const struct ib_recv_wr *wr = recv_wr;
 	struct erdma_qp *qp = to_eqp(ibqp);
@@ -552,6 +570,15 @@ int erdma_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *recv_wr,
 
 	spin_lock_irqsave(&qp->lock, flags);
 
+	if (unlikely(qp->flags & ERDMA_QP_FLAGS_RX_STOPPED)) {
+		ret = -EINVAL;
+		*bad_recv_wr = recv_wr;
+		goto out;
+	}
+
+	if (unlikely(drain))
+		qp->flags |= ERDMA_QP_FLAGS_RX_STOPPED;
+
 	while (wr) {
 		ret = erdma_post_recv_one(qp, wr);
 		if (ret) {
@@ -561,6 +588,14 @@ int erdma_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *recv_wr,
 		wr = wr->next;
 	}
 
+out:
 	spin_unlock_irqrestore(&qp->lock, flags);
 	return ret;
 }
+
+int erdma_post_recv_nodrain(struct ib_qp *ibqp,
+			    const struct ib_recv_wr *recv_wr,
+			    const struct ib_recv_wr **bad_recv_wr)
+{
+	return erdma_post_recv(ibqp, recv_wr, bad_recv_wr, false);
+}
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/infiniband/hw/erdma/erdma_verbs.h
index c7baddb1f292..f4148fbac878 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.h
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
@@ -195,6 +195,12 @@ struct erdma_qp_attrs {
 	u8 pd_len;
 };
 
+enum erdma_qp_flags {
+	ERDMA_QP_FLAGS_DRAIN_ISSUED = (1 << 0),
+	ERDMA_QP_FLAGS_TX_STOPPED = (1 << 1),
+	ERDMA_QP_FLAGS_RX_STOPPED = (1 << 2),
+};
+
 struct erdma_qp {
 	struct ib_qp ibqp;
 	struct kref ref;
@@ -202,6 +208,7 @@ struct erdma_qp {
 	struct erdma_dev *dev;
 	struct erdma_cep *cep;
 	struct rw_semaphore state_lock;
+	unsigned long flags;
 
 	union {
 		struct erdma_kqp kern_qp;
@@ -328,10 +335,12 @@ void erdma_mmap_free(struct rdma_user_mmap_entry *rdma_entry);
 void erdma_qp_get_ref(struct ib_qp *ibqp);
 void erdma_qp_put_ref(struct ib_qp *ibqp);
 struct ib_qp *erdma_get_ibqp(struct ib_device *dev, int id);
-int erdma_post_send(struct ib_qp *ibqp, const struct ib_send_wr *send_wr,
-		    const struct ib_send_wr **bad_send_wr);
-int erdma_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *recv_wr,
-		    const struct ib_recv_wr **bad_recv_wr);
+int erdma_post_send_nodrain(struct ib_qp *ibqp,
+			    const struct ib_send_wr *send_wr,
+			    const struct ib_send_wr **bad_send_wr);
+int erdma_post_recv_nodrain(struct ib_qp *ibqp,
+			    const struct ib_recv_wr *recv_wr,
+			    const struct ib_recv_wr **bad_recv_wr);
 int erdma_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc);
 struct ib_mr *erdma_ib_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 				u32 max_num_sg);
-- 
2.27.0

