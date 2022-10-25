Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A77460CA6F
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Oct 2022 12:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiJYKxp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Oct 2022 06:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbiJYKxo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Oct 2022 06:53:44 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389F7181978
        for <linux-rdma@vger.kernel.org>; Tue, 25 Oct 2022 03:53:42 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MxTHz15MCzJnBZ;
        Tue, 25 Oct 2022 18:50:55 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 18:53:40 +0800
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 18:53:40 +0800
From:   Haoyue Xu <xuhaoyue1@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <xuhaoyue1@hisilicon.com>
Subject: [PATCH 4/5] RDMA/hns: Remove rq inline in kernel
Date:   Tue, 25 Oct 2022 18:52:43 +0800
Message-ID: <20221025105244.204570-5-xuhaoyue1@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20221025105244.204570-1-xuhaoyue1@hisilicon.com>
References: <20221025105244.204570-1-xuhaoyue1@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

From: Luoyouming <luoyouming@huawei.com>

The kernel space does not support the rq inline feature anymore,
so remove the code associated with rq inline.

Signed-off-by: Luoyouming <luoyouming@huawei.com>
Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 16 ------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 53 -----------------
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 64 ---------------------
 3 files changed, 133 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 9ce053fe737d..3f6f328d3a3e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -569,21 +569,6 @@ struct hns_roce_mbox_msg {
 
 struct hns_roce_dev;
 
-struct hns_roce_rinl_sge {
-	void			*addr;
-	u32			len;
-};
-
-struct hns_roce_rinl_wqe {
-	struct hns_roce_rinl_sge *sg_list;
-	u32			 sge_cnt;
-};
-
-struct hns_roce_rinl_buf {
-	struct hns_roce_rinl_wqe *wqe_list;
-	u32			 wqe_cnt;
-};
-
 enum {
 	HNS_ROCE_FLUSH_FLAG = 0,
 };
@@ -634,7 +619,6 @@ struct hns_roce_qp {
 	/* 0: flush needed, 1: unneeded */
 	unsigned long		flush_flag;
 	struct hns_roce_work	flush_work;
-	struct hns_roce_rinl_buf rq_inl_buf;
 	struct list_head	node; /* all qps are on a list */
 	struct list_head	rq_node; /* all recv qps are on a list */
 	struct list_head	sq_node; /* all send qps are on a list */
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index b936bf6e58cc..19e326bda936 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -821,22 +821,10 @@ static void fill_recv_sge_to_wqe(const struct ib_recv_wr *wr, void *wqe,
 static void fill_rq_wqe(struct hns_roce_qp *hr_qp, const struct ib_recv_wr *wr,
 			u32 wqe_idx, u32 max_sge)
 {
-	struct hns_roce_rinl_sge *sge_list;
 	void *wqe = NULL;
-	u32 i;
 
 	wqe = hns_roce_get_recv_wqe(hr_qp, wqe_idx);
 	fill_recv_sge_to_wqe(wr, wqe, max_sge, hr_qp->rq.rsv_sge);
-
-	/* rq support inline data */
-	if (hr_qp->rq_inl_buf.wqe_cnt) {
-		sge_list = hr_qp->rq_inl_buf.wqe_list[wqe_idx].sg_list;
-		hr_qp->rq_inl_buf.wqe_list[wqe_idx].sge_cnt = (u32)wr->num_sge;
-		for (i = 0; i < wr->num_sge; i++) {
-			sge_list[i].addr = (void *)(u64)wr->sg_list[i].addr;
-			sge_list[i].len = wr->sg_list[i].length;
-		}
-	}
 }
 
 static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
@@ -3612,39 +3600,6 @@ static int hns_roce_v2_req_notify_cq(struct ib_cq *ibcq,
 	return 0;
 }
 
-static int hns_roce_handle_recv_inl_wqe(struct hns_roce_v2_cqe *cqe,
-					struct hns_roce_qp *qp,
-					struct ib_wc *wc)
-{
-	struct hns_roce_rinl_sge *sge_list;
-	u32 wr_num, wr_cnt, sge_num;
-	u32 sge_cnt, data_len, size;
-	void *wqe_buf;
-
-	wr_num = hr_reg_read(cqe, CQE_WQE_IDX);
-	wr_cnt = wr_num & (qp->rq.wqe_cnt - 1);
-
-	sge_list = qp->rq_inl_buf.wqe_list[wr_cnt].sg_list;
-	sge_num = qp->rq_inl_buf.wqe_list[wr_cnt].sge_cnt;
-	wqe_buf = hns_roce_get_recv_wqe(qp, wr_cnt);
-	data_len = wc->byte_len;
-
-	for (sge_cnt = 0; (sge_cnt < sge_num) && (data_len); sge_cnt++) {
-		size = min(sge_list[sge_cnt].len, data_len);
-		memcpy((void *)sge_list[sge_cnt].addr, wqe_buf, size);
-
-		data_len -= size;
-		wqe_buf += size;
-	}
-
-	if (unlikely(data_len)) {
-		wc->status = IB_WC_LOC_LEN_ERR;
-		return -EAGAIN;
-	}
-
-	return 0;
-}
-
 static int sw_comp(struct hns_roce_qp *hr_qp, struct hns_roce_wq *wq,
 		   int num_entries, struct ib_wc *wc)
 {
@@ -3868,10 +3823,8 @@ static inline bool is_rq_inl_enabled(struct ib_wc *wc, u32 hr_opcode,
 
 static int fill_recv_wc(struct ib_wc *wc, struct hns_roce_v2_cqe *cqe)
 {
-	struct hns_roce_qp *qp = to_hr_qp(wc->qp);
 	u32 hr_opcode;
 	int ib_opcode;
-	int ret;
 
 	wc->byte_len = le32_to_cpu(cqe->byte_cnt);
 
@@ -3896,12 +3849,6 @@ static int fill_recv_wc(struct ib_wc *wc, struct hns_roce_v2_cqe *cqe)
 	else
 		wc->opcode = ib_opcode;
 
-	if (is_rq_inl_enabled(wc, hr_opcode, cqe)) {
-		ret = hns_roce_handle_recv_inl_wqe(cqe, qp, wc);
-		if (unlikely(ret))
-			return ret;
-	}
-
 	wc->sl = hr_reg_read(cqe, CQE_SL);
 	wc->src_qp = hr_reg_read(cqe, CQE_RMT_QPN);
 	wc->slid = 0;
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 6aac59c54ac7..a6ce4b2f4090 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -433,7 +433,6 @@ static int set_rq_size(struct hns_roce_dev *hr_dev, struct ib_qp_cap *cap,
 	if (!has_rq) {
 		hr_qp->rq.wqe_cnt = 0;
 		hr_qp->rq.max_gs = 0;
-		hr_qp->rq_inl_buf.wqe_cnt = 0;
 		cap->max_recv_wr = 0;
 		cap->max_recv_sge = 0;
 
@@ -463,12 +462,6 @@ static int set_rq_size(struct hns_roce_dev *hr_dev, struct ib_qp_cap *cap,
 				    hr_qp->rq.max_gs);
 
 	hr_qp->rq.wqe_cnt = cnt;
-	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RQ_INLINE &&
-	    hr_qp->ibqp.qp_type != IB_QPT_UD &&
-	    hr_qp->ibqp.qp_type != IB_QPT_GSI)
-		hr_qp->rq_inl_buf.wqe_cnt = cnt;
-	else
-		hr_qp->rq_inl_buf.wqe_cnt = 0;
 
 	cap->max_recv_wr = cnt;
 	cap->max_recv_sge = hr_qp->rq.max_gs - hr_qp->rq.rsv_sge;
@@ -739,49 +732,6 @@ static int hns_roce_qp_has_rq(struct ib_qp_init_attr *attr)
 	return 1;
 }
 
-static int alloc_rq_inline_buf(struct hns_roce_qp *hr_qp,
-			       struct ib_qp_init_attr *init_attr)
-{
-	u32 max_recv_sge = init_attr->cap.max_recv_sge;
-	u32 wqe_cnt = hr_qp->rq_inl_buf.wqe_cnt;
-	struct hns_roce_rinl_wqe *wqe_list;
-	int i;
-
-	/* allocate recv inline buf */
-	wqe_list = kcalloc(wqe_cnt, sizeof(struct hns_roce_rinl_wqe),
-			   GFP_KERNEL);
-	if (!wqe_list)
-		goto err;
-
-	/* Allocate a continuous buffer for all inline sge we need */
-	wqe_list[0].sg_list = kcalloc(wqe_cnt, (max_recv_sge *
-				      sizeof(struct hns_roce_rinl_sge)),
-				      GFP_KERNEL);
-	if (!wqe_list[0].sg_list)
-		goto err_wqe_list;
-
-	/* Assign buffers of sg_list to each inline wqe */
-	for (i = 1; i < wqe_cnt; i++)
-		wqe_list[i].sg_list = &wqe_list[0].sg_list[i * max_recv_sge];
-
-	hr_qp->rq_inl_buf.wqe_list = wqe_list;
-
-	return 0;
-
-err_wqe_list:
-	kfree(wqe_list);
-
-err:
-	return -ENOMEM;
-}
-
-static void free_rq_inline_buf(struct hns_roce_qp *hr_qp)
-{
-	if (hr_qp->rq_inl_buf.wqe_list)
-		kfree(hr_qp->rq_inl_buf.wqe_list[0].sg_list);
-	kfree(hr_qp->rq_inl_buf.wqe_list);
-}
-
 static int alloc_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 			struct ib_qp_init_attr *init_attr,
 			struct ib_udata *udata, unsigned long addr)
@@ -790,18 +740,6 @@ static int alloc_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 	struct hns_roce_buf_attr buf_attr = {};
 	int ret;
 
-	if (!udata && hr_qp->rq_inl_buf.wqe_cnt) {
-		ret = alloc_rq_inline_buf(hr_qp, init_attr);
-		if (ret) {
-			ibdev_err(ibdev,
-				  "failed to alloc inline buf, ret = %d.\n",
-				  ret);
-			return ret;
-		}
-	} else {
-		hr_qp->rq_inl_buf.wqe_list = NULL;
-	}
-
 	ret = set_wqe_buf_attr(hr_dev, hr_qp, &buf_attr);
 	if (ret) {
 		ibdev_err(ibdev, "failed to split WQE buf, ret = %d.\n", ret);
@@ -821,7 +759,6 @@ static int alloc_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 	return 0;
 
 err_inline:
-	free_rq_inline_buf(hr_qp);
 
 	return ret;
 }
@@ -829,7 +766,6 @@ static int alloc_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 static void free_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 {
 	hns_roce_mtr_destroy(hr_dev, &hr_qp->mtr);
-	free_rq_inline_buf(hr_qp);
 }
 
 static inline bool user_qp_has_sdb(struct hns_roce_dev *hr_dev,
-- 
2.30.0

