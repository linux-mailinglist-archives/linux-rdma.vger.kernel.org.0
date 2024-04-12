Return-Path: <linux-rdma+bounces-1927-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A18588A2AFA
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Apr 2024 11:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A3E1F223C3
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Apr 2024 09:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DED453E13;
	Fri, 12 Apr 2024 09:20:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A8D51C54;
	Fri, 12 Apr 2024 09:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913653; cv=none; b=Si9yWTDAnqBPPOHC9P3CZemV3bSlPYMPwGFrzq+KkEww1e1HzKq2sP/PlX3MUjoljLUX4B1C5EqaS113waj5VinANw1IGuSOCw53bG/ikXTdaWeHOCVlCJEKBppHQ5HcmwvraTgzBTsKxhLXvx5jM+SVidCyZ2V87OE8yU+9x9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913653; c=relaxed/simple;
	bh=wAVsZ5Fzr9jjeuifcdweWGm46o6fFTpOvodSAYMIbnQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SUGIjfsW9aS7VW0eDd698PpmU4JLgNScQQzqYnp7ML8t7lv5IhdDW7Uhi79LfqkCCoqtEDaoQGENBEy75nzBYlCJtNS7GI9k7O3BWhfnJTeM3w+qkZyfNd6n2OQloQVBPWFbu5w9GqJCcPBQL/kKNJ0dkIZyoeQrXTxTry+060w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VG9vs5lLpztSdM;
	Fri, 12 Apr 2024 17:18:01 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id BB43B140123;
	Fri, 12 Apr 2024 17:20:47 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 17:20:47 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next 02/10] RDMA/hns: Remove unused parameters and variables
Date: Fri, 12 Apr 2024 17:16:08 +0800
Message-ID: <20240412091616.370789-3-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240412091616.370789-1-huangjunxian6@hisilicon.com>
References: <20240412091616.370789-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500006.china.huawei.com (7.221.188.68)

From: Chengchang Tang <tangchengchang@huawei.com>

Remove unused parameters and variables.

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_alloc.c  |  3 +--
 drivers/infiniband/hw/hns/hns_roce_device.h |  5 ++---
 drivers/infiniband/hw/hns/hns_roce_hem.c    | 13 +++++--------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 20 +++++++-------------
 drivers/infiniband/hw/hns/hns_roce_mr.c     |  4 ++--
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  4 +---
 drivers/infiniband/hw/hns/hns_roce_srq.c    |  4 ++--
 7 files changed, 20 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index 11a78ceae568..950c133d4220 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -153,8 +153,7 @@ int hns_roce_get_kmem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
 	return total;
 }
 
-int hns_roce_get_umem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
-			   int buf_cnt, struct ib_umem *umem,
+int hns_roce_get_umem_bufs(dma_addr_t *bufs, int buf_cnt, struct ib_umem *umem,
 			   unsigned int page_shift)
 {
 	struct ib_block_iter biter;
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 78b4d19ff848..37888f78849d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -925,8 +925,7 @@ struct hns_roce_hw {
 	int (*rereg_write_mtpt)(struct hns_roce_dev *hr_dev,
 				struct hns_roce_mr *mr, int flags,
 				void *mb_buf);
-	int (*frmr_write_mtpt)(struct hns_roce_dev *hr_dev, void *mb_buf,
-			       struct hns_roce_mr *mr);
+	int (*frmr_write_mtpt)(void *mb_buf, struct hns_roce_mr *mr);
 	int (*mw_write_mtpt)(void *mb_buf, struct hns_roce_mw *mw);
 	void (*write_cqc)(struct hns_roce_dev *hr_dev,
 			  struct hns_roce_cq *hr_cq, void *mb_buf, u64 *mtts,
@@ -1232,7 +1231,7 @@ struct hns_roce_buf *hns_roce_buf_alloc(struct hns_roce_dev *hr_dev, u32 size,
 int hns_roce_get_kmem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
 			   int buf_cnt, struct hns_roce_buf *buf,
 			   unsigned int page_shift);
-int hns_roce_get_umem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
+int hns_roce_get_umem_bufs(dma_addr_t *bufs,
 			   int buf_cnt, struct ib_umem *umem,
 			   unsigned int page_shift);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index a4b3f19161dc..a9ea55506779 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -986,15 +986,13 @@ static void hem_list_free_all(struct hns_roce_dev *hr_dev,
 	}
 }
 
-static void hem_list_link_bt(struct hns_roce_dev *hr_dev, void *base_addr,
-			     u64 table_addr)
+static void hem_list_link_bt(void *base_addr, u64 table_addr)
 {
 	*(u64 *)(base_addr) = table_addr;
 }
 
 /* assign L0 table address to hem from root bt */
-static void hem_list_assign_bt(struct hns_roce_dev *hr_dev,
-			       struct hns_roce_hem_item *hem, void *cpu_addr,
+static void hem_list_assign_bt(struct hns_roce_hem_item *hem, void *cpu_addr,
 			       u64 phy_addr)
 {
 	hem->addr = cpu_addr;
@@ -1163,8 +1161,7 @@ static int hem_list_alloc_mid_bt(struct hns_roce_dev *hr_dev,
 		if (level > 1) {
 			pre = hem_ptrs[level - 1];
 			step = (cur->start - pre->start) / step * BA_BYTE_LEN;
-			hem_list_link_bt(hr_dev, pre->addr + step,
-					 cur->dma_addr);
+			hem_list_link_bt(pre->addr + step, cur->dma_addr);
 		}
 	}
 
@@ -1222,7 +1219,7 @@ static int alloc_fake_root_bt(struct hns_roce_dev *hr_dev, void *cpu_base,
 	if (!hem)
 		return -ENOMEM;
 
-	hem_list_assign_bt(hr_dev, hem, cpu_base, phy_base);
+	hem_list_assign_bt(hem, cpu_base, phy_base);
 	list_add(&hem->list, branch_head);
 	list_add(&hem->sibling, leaf_head);
 
@@ -1245,7 +1242,7 @@ static int setup_middle_bt(struct hns_roce_dev *hr_dev, void *cpu_base,
 	/* if exist mid bt, link L1 to L0 */
 	list_for_each_entry_safe(hem, temp_hem, branch_head, list) {
 		offset = (hem->start - r->offset) / step * BA_BYTE_LEN;
-		hem_list_link_bt(hr_dev, cpu_base + offset, hem->dma_addr);
+		hem_list_link_bt(cpu_base + offset, hem->dma_addr);
 		total++;
 	}
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 30ac5fb5ab16..e3f87090bad0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3304,8 +3304,7 @@ static int hns_roce_v2_rereg_write_mtpt(struct hns_roce_dev *hr_dev,
 	return ret;
 }
 
-static int hns_roce_v2_frmr_write_mtpt(struct hns_roce_dev *hr_dev,
-				       void *mb_buf, struct hns_roce_mr *mr)
+static int hns_roce_v2_frmr_write_mtpt(void *mb_buf, struct hns_roce_mr *mr)
 {
 	dma_addr_t pbl_ba = hns_roce_get_mtr_ba(&mr->pbl_mtr);
 	struct hns_roce_v2_mpt_entry *mpt_entry;
@@ -4216,8 +4215,7 @@ static void set_access_flags(struct hns_roce_qp *hr_qp,
 }
 
 static void set_qpc_wqe_cnt(struct hns_roce_qp *hr_qp,
-			    struct hns_roce_v2_qp_context *context,
-			    struct hns_roce_v2_qp_context *qpc_mask)
+			    struct hns_roce_v2_qp_context *context)
 {
 	hr_reg_write(context, QPC_SGE_SHIFT,
 		     to_hr_hem_entries_shift(hr_qp->sge.sge_cnt,
@@ -4239,7 +4237,6 @@ static inline int get_pdn(struct ib_pd *ib_pd)
 }
 
 static void modify_qp_reset_to_init(struct ib_qp *ibqp,
-				    const struct ib_qp_attr *attr,
 				    struct hns_roce_v2_qp_context *context,
 				    struct hns_roce_v2_qp_context *qpc_mask)
 {
@@ -4258,7 +4255,7 @@ static void modify_qp_reset_to_init(struct ib_qp *ibqp,
 
 	hr_reg_write(context, QPC_RQWS, ilog2(hr_qp->rq.max_gs));
 
-	set_qpc_wqe_cnt(hr_qp, context, qpc_mask);
+	set_qpc_wqe_cnt(hr_qp, context);
 
 	/* No VLAN need to set 0xFFF */
 	hr_reg_write(context, QPC_VLAN_ID, 0xfff);
@@ -4299,7 +4296,6 @@ static void modify_qp_reset_to_init(struct ib_qp *ibqp,
 }
 
 static void modify_qp_init_to_init(struct ib_qp *ibqp,
-				   const struct ib_qp_attr *attr,
 				   struct hns_roce_v2_qp_context *context,
 				   struct hns_roce_v2_qp_context *qpc_mask)
 {
@@ -4619,8 +4615,7 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	return 0;
 }
 
-static int modify_qp_rtr_to_rts(struct ib_qp *ibqp,
-				const struct ib_qp_attr *attr, int attr_mask,
+static int modify_qp_rtr_to_rts(struct ib_qp *ibqp, int attr_mask,
 				struct hns_roce_v2_qp_context *context,
 				struct hns_roce_v2_qp_context *qpc_mask)
 {
@@ -5034,15 +5029,14 @@ static int hns_roce_v2_set_abs_fields(struct ib_qp *ibqp,
 
 	if (cur_state == IB_QPS_RESET && new_state == IB_QPS_INIT) {
 		memset(qpc_mask, 0, hr_dev->caps.qpc_sz);
-		modify_qp_reset_to_init(ibqp, attr, context, qpc_mask);
+		modify_qp_reset_to_init(ibqp, context, qpc_mask);
 	} else if (cur_state == IB_QPS_INIT && new_state == IB_QPS_INIT) {
-		modify_qp_init_to_init(ibqp, attr, context, qpc_mask);
+		modify_qp_init_to_init(ibqp, context, qpc_mask);
 	} else if (cur_state == IB_QPS_INIT && new_state == IB_QPS_RTR) {
 		ret = modify_qp_init_to_rtr(ibqp, attr, attr_mask, context,
 					    qpc_mask, udata);
 	} else if (cur_state == IB_QPS_RTR && new_state == IB_QPS_RTS) {
-		ret = modify_qp_rtr_to_rts(ibqp, attr, attr_mask, context,
-					   qpc_mask);
+		ret = modify_qp_rtr_to_rts(ibqp, attr_mask, context, qpc_mask);
 	}
 
 	return ret;
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 9e05b57a2d67..ab58b71bc0ed 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -162,7 +162,7 @@ static int hns_roce_mr_enable(struct hns_roce_dev *hr_dev,
 	if (mr->type != MR_TYPE_FRMR)
 		ret = hr_dev->hw->write_mtpt(hr_dev, mailbox->buf, mr);
 	else
-		ret = hr_dev->hw->frmr_write_mtpt(hr_dev, mailbox->buf, mr);
+		ret = hr_dev->hw->frmr_write_mtpt(mailbox->buf, mr);
 	if (ret) {
 		dev_err(dev, "failed to write mtpt, ret = %d.\n", ret);
 		goto err_page;
@@ -756,7 +756,7 @@ static int mtr_map_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr)
 		return -ENOMEM;
 
 	if (mtr->umem)
-		npage = hns_roce_get_umem_bufs(hr_dev, pages, page_count,
+		npage = hns_roce_get_umem_bufs(pages, page_count,
 					       mtr->umem, page_shift);
 	else
 		npage = hns_roce_get_kmem_bufs(hr_dev, pages, page_count,
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index cac3fe588672..dc3cb26f434e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1118,7 +1118,6 @@ static int set_qp_param(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 }
 
 static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
-				     struct ib_pd *ib_pd,
 				     struct ib_qp_init_attr *init_attr,
 				     struct ib_udata *udata,
 				     struct hns_roce_qp *hr_qp)
@@ -1272,7 +1271,6 @@ int hns_roce_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *init_attr,
 	struct ib_device *ibdev = qp->device;
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibdev);
 	struct hns_roce_qp *hr_qp = to_hr_qp(qp);
-	struct ib_pd *pd = qp->pd;
 	int ret;
 
 	ret = check_qp_type(hr_dev, init_attr->qp_type, !!udata);
@@ -1287,7 +1285,7 @@ int hns_roce_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *init_attr,
 		hr_qp->phy_port = hr_dev->iboe.phy_port[hr_qp->port];
 	}
 
-	ret = hns_roce_create_qp_common(hr_dev, pd, init_attr, udata, hr_qp);
+	ret = hns_roce_create_qp_common(hr_dev, init_attr, udata, hr_qp);
 	if (ret)
 		ibdev_err(ibdev, "create QP type 0x%x failed(%d)\n",
 			  init_attr->qp_type, ret);
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 4abae9477854..e4705ccdfa65 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -250,7 +250,7 @@ static void free_srq_wqe_buf(struct hns_roce_dev *hr_dev,
 	hns_roce_mtr_destroy(hr_dev, &srq->buf_mtr);
 }
 
-static int alloc_srq_wrid(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
+static int alloc_srq_wrid(struct hns_roce_srq *srq)
 {
 	srq->wrid = kvmalloc_array(srq->wqe_cnt, sizeof(u64), GFP_KERNEL);
 	if (!srq->wrid)
@@ -366,7 +366,7 @@ static int alloc_srq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
 		goto err_idx;
 
 	if (!udata) {
-		ret = alloc_srq_wrid(hr_dev, srq);
+		ret = alloc_srq_wrid(srq);
 		if (ret)
 			goto err_wqe_buf;
 	}
-- 
2.30.0


