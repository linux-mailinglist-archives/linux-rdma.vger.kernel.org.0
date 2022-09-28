Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C275ED4DF
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Sep 2022 08:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbiI1G2e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Sep 2022 02:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbiI1G2d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Sep 2022 02:28:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03441E45AC
        for <linux-rdma@vger.kernel.org>; Tue, 27 Sep 2022 23:28:31 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mcmf64DM2zHtjj;
        Wed, 28 Sep 2022 14:23:42 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 14:28:30 +0800
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 14:28:29 +0800
From:   Haoyue Xu <xuhaoyue1@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>, <zyjzyj2000@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>, <xuhaoyue1@hisilicon.com>,
        <linyunsheng@huawei.com>
Subject: [PATCH for-next] RDMA/rxe: cleanup some error handling in rxe_verbs.c
Date:   Wed, 28 Sep 2022 14:27:43 +0800
Message-ID: <20220928062743.4029492-1-xuhaoyue1@hisilicon.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

Instead of 'goto and return', just return directly to
simplify the error handling, and avoid some unnecessary
return value check.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 80 ++++++++-------------------
 1 file changed, 23 insertions(+), 57 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index da1c484798dd..78ee89bcf877 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -238,7 +238,6 @@ static int rxe_destroy_ah(struct ib_ah *ibah, u32 flags)
 
 static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr)
 {
-	int err;
 	int i;
 	u32 length;
 	struct rxe_recv_wqe *recv_wqe;
@@ -246,15 +245,11 @@ static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr)
 	int full;
 
 	full = queue_full(rq->queue, QUEUE_TYPE_TO_DRIVER);
-	if (unlikely(full)) {
-		err = -ENOMEM;
-		goto err1;
-	}
+	if (unlikely(full))
+		return -ENOMEM;
 
-	if (unlikely(num_sge > rq->max_sge)) {
-		err = -EINVAL;
-		goto err1;
-	}
+	if (unlikely(num_sge > rq->max_sge))
+		return -EINVAL;
 
 	length = 0;
 	for (i = 0; i < num_sge; i++)
@@ -276,9 +271,6 @@ static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr)
 	queue_advance_producer(rq->queue, QUEUE_TYPE_TO_DRIVER);
 
 	return 0;
-
-err1:
-	return err;
 }
 
 static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
@@ -344,10 +336,7 @@ static int rxe_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 	if (err)
 		return err;
 
-	err = rxe_srq_from_attr(rxe, srq, attr, mask, &ucmd, udata);
-	if (err)
-		return err;
-	return 0;
+	return rxe_srq_from_attr(rxe, srq, attr, mask, &ucmd, udata);
 }
 
 static int rxe_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
@@ -454,11 +443,11 @@ static int rxe_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 
 	err = rxe_qp_chk_attr(rxe, qp, attr, mask);
 	if (err)
-		goto err1;
+		return err;
 
 	err = rxe_qp_from_attr(qp, attr, mask, udata);
 	if (err)
-		goto err1;
+		return err;
 
 	if ((mask & IB_QP_AV) && (attr->ah_attr.ah_flags & IB_AH_GRH))
 		qp->src_port = rdma_get_udp_sport(attr->ah_attr.grh.flow_label,
@@ -466,9 +455,6 @@ static int rxe_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 						  qp->attr.dest_qp_num);
 
 	return 0;
-
-err1:
-	return err;
 }
 
 static int rxe_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
@@ -502,24 +488,21 @@ static int validate_send_wr(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 	struct rxe_sq *sq = &qp->sq;
 
 	if (unlikely(num_sge > sq->max_sge))
-		goto err1;
+		return -EINVAL;
 
 	if (unlikely(mask & WR_ATOMIC_MASK)) {
 		if (length < 8)
-			goto err1;
+			return -EINVAL;
 
 		if (atomic_wr(ibwr)->remote_addr & 0x7)
-			goto err1;
+			return -EINVAL;
 	}
 
 	if (unlikely((ibwr->send_flags & IB_SEND_INLINE) &&
 		     (length > sq->max_inline)))
-		goto err1;
+		return -EINVAL;
 
 	return 0;
-
-err1:
-	return -EINVAL;
 }
 
 static void init_send_wr(struct rxe_qp *qp, struct rxe_send_wr *wr,
@@ -737,14 +720,12 @@ static int rxe_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 
 	if (unlikely((qp_state(qp) < IB_QPS_INIT) || !qp->valid)) {
 		*bad_wr = wr;
-		err = -EINVAL;
-		goto err1;
+		return -EINVAL;
 	}
 
 	if (unlikely(qp->srq)) {
 		*bad_wr = wr;
-		err = -EINVAL;
-		goto err1;
+		return -EINVAL;
 	}
 
 	spin_lock_irqsave(&rq->producer_lock, flags);
@@ -763,7 +744,6 @@ static int rxe_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 	if (qp->resp.state == QP_STATE_ERROR)
 		rxe_run_task(&qp->resp.task, 1);
 
-err1:
 	return err;
 }
 
@@ -828,16 +808,9 @@ static int rxe_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 
 	err = rxe_cq_chk_attr(rxe, cq, cqe, 0);
 	if (err)
-		goto err1;
-
-	err = rxe_cq_resize_queue(cq, cqe, uresp, udata);
-	if (err)
-		goto err1;
-
-	return 0;
+		return err;
 
-err1:
-	return err;
+	return rxe_cq_resize_queue(cq, cqe, uresp, udata);
 }
 
 static int rxe_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
@@ -921,26 +894,22 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 	struct rxe_mr *mr;
 
 	mr = rxe_alloc(&rxe->mr_pool);
-	if (!mr) {
-		err = -ENOMEM;
-		goto err2;
-	}
-
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
 
 	rxe_get(pd);
 
 	err = rxe_mr_init_user(pd, start, length, iova, access, mr);
 	if (err)
-		goto err3;
+		goto err1;
 
 	rxe_finalize(mr);
 
 	return &mr->ibmr;
 
-err3:
+err1:
 	rxe_put(pd);
 	rxe_cleanup(mr);
-err2:
 	return ERR_PTR(err);
 }
 
@@ -956,25 +925,22 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 		return ERR_PTR(-EINVAL);
 
 	mr = rxe_alloc(&rxe->mr_pool);
-	if (!mr) {
-		err = -ENOMEM;
-		goto err1;
-	}
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
 
 	rxe_get(pd);
 
 	err = rxe_mr_init_fast(pd, max_num_sg, mr);
 	if (err)
-		goto err2;
+		goto err1;
 
 	rxe_finalize(mr);
 
 	return &mr->ibmr;
 
-err2:
+err1:
 	rxe_put(pd);
 	rxe_cleanup(mr);
-err1:
 	return ERR_PTR(err);
 }
 
-- 
2.30.0

