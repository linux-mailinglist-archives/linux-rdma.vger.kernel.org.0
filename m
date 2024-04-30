Return-Path: <linux-rdma+bounces-2150-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0268F8B6E66
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 11:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833811F26A8C
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 09:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AA2127E2F;
	Tue, 30 Apr 2024 09:33:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D8522618;
	Tue, 30 Apr 2024 09:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714469617; cv=none; b=eCHiemaXcXZKovLJPKS+GhoXHYTBSNE0bFg4AgU/Fs61aHwThjlAj7B9l63Y5+9nwQiumhfj1wMsbg2LJ4kvzK+1lTU5PHDcPqdgZMmj/zcwcutdQCjgFGzQnjhVCj3RWI/rbH5KnvwJIRThjok7qzZlrkI/QJ8uIhg9YiG3YT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714469617; c=relaxed/simple;
	bh=vrrEnvdkzinjQ/X6lgYzn2WXgTn7QF8lzjK1lrF3XB8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bY7cIHmhVcVNqBUR86/HfoFUhri4epllBkQF+6jRlEN8hOosZS1dbp5K3+PK4KXVwTq+UsUUNMSVamEBf/l386MqZVmGwxeki8zLq6T8VYQ3Wg859eUXq68g2EJkRS7/djmIUrpbR8yO5A/qRDtTA2Kn29ajKF1l7Eu7KM8+/+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VTFKg0hPXz1RDWK;
	Tue, 30 Apr 2024 17:30:15 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id E18E0140109;
	Tue, 30 Apr 2024 17:33:24 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 17:33:24 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next] RDMA/hns: Support flexible WQE buffer page size
Date: Tue, 30 Apr 2024 17:28:45 +0800
Message-ID: <20240430092845.4058786-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500006.china.huawei.com (7.221.188.68)

From: Chengchang Tang <tangchengchang@huawei.com>

Currently, driver fixedly allocates 4K pages for userspace WQE buffer
and results in HW reading WQE with a granularity of 4K even in a 64K
system. HW has to switch pages every 4K, leading to a loss of performance.

In order to improve performance, add support for userspace to allocate
flexible WQE buffer page size between 4K to system PAGESIZE.

For old-version userspace driver that does not support this feature,
the kernel driver will use a fixed 4K pagesize.

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_main.c |  5 ++++
 drivers/infiniband/hw/hns/hns_roce_qp.c   | 32 ++++++++++++++---------
 include/uapi/rdma/hns-abi.h               |  5 +++-
 3 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 4cb0af733587..19b13c79b67b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -405,6 +405,11 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)
 		resp.congest_type = hr_dev->caps.cong_cap;
 
+	if (ucmd.config & HNS_ROCE_UCTX_DYN_QP_PGSZ_FLAGS) {
+		context->config |= HNS_ROCE_UCTX_DYN_QP_PGSZ_FLAGS;
+		resp.config |=  HNS_ROCE_RSP_UCTX_DYN_QP_PGSZ_FLAGS;
+	}
+
 	ret = hns_roce_uar_alloc(hr_dev, &context->uar);
 	if (ret)
 		goto error_out;
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index db34665d1dfb..df8aba6a7840 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -643,18 +643,21 @@ static int set_user_sq_size(struct hns_roce_dev *hr_dev,
 }
 
 static int set_wqe_buf_attr(struct hns_roce_dev *hr_dev,
-			    struct hns_roce_qp *hr_qp,
+			    struct hns_roce_qp *hr_qp, u8 page_shift,
 			    struct hns_roce_buf_attr *buf_attr)
 {
+	unsigned int page_size = BIT(page_shift);
 	int buf_size;
 	int idx = 0;
 
 	hr_qp->buff_size = 0;
 
+	if (page_shift > PAGE_SHIFT || page_shift < HNS_HW_PAGE_SHIFT)
+		return -EOPNOTSUPP;
+
 	/* SQ WQE */
 	hr_qp->sq.offset = 0;
-	buf_size = to_hr_hem_entries_size(hr_qp->sq.wqe_cnt,
-					  hr_qp->sq.wqe_shift);
+	buf_size = ALIGN(hr_qp->sq.wqe_cnt << hr_qp->sq.wqe_shift, page_size);
 	if (buf_size > 0 && idx < ARRAY_SIZE(buf_attr->region)) {
 		buf_attr->region[idx].size = buf_size;
 		buf_attr->region[idx].hopnum = hr_dev->caps.wqe_sq_hop_num;
@@ -664,8 +667,7 @@ static int set_wqe_buf_attr(struct hns_roce_dev *hr_dev,
 
 	/* extend SGE WQE in SQ */
 	hr_qp->sge.offset = hr_qp->buff_size;
-	buf_size = to_hr_hem_entries_size(hr_qp->sge.sge_cnt,
-					  hr_qp->sge.sge_shift);
+	buf_size = ALIGN(hr_qp->sge.sge_cnt << hr_qp->sge.sge_shift, page_size);
 	if (buf_size > 0 && idx < ARRAY_SIZE(buf_attr->region)) {
 		buf_attr->region[idx].size = buf_size;
 		buf_attr->region[idx].hopnum = hr_dev->caps.wqe_sge_hop_num;
@@ -675,8 +677,7 @@ static int set_wqe_buf_attr(struct hns_roce_dev *hr_dev,
 
 	/* RQ WQE */
 	hr_qp->rq.offset = hr_qp->buff_size;
-	buf_size = to_hr_hem_entries_size(hr_qp->rq.wqe_cnt,
-					  hr_qp->rq.wqe_shift);
+	buf_size = ALIGN(hr_qp->rq.wqe_cnt << hr_qp->rq.wqe_shift, page_size);
 	if (buf_size > 0 && idx < ARRAY_SIZE(buf_attr->region)) {
 		buf_attr->region[idx].size = buf_size;
 		buf_attr->region[idx].hopnum = hr_dev->caps.wqe_rq_hop_num;
@@ -687,8 +688,8 @@ static int set_wqe_buf_attr(struct hns_roce_dev *hr_dev,
 	if (hr_qp->buff_size < 1)
 		return -EINVAL;
 
-	buf_attr->page_shift = HNS_HW_PAGE_SHIFT + hr_dev->caps.mtt_buf_pg_sz;
 	buf_attr->region_count = idx;
+	buf_attr->page_shift = page_shift;
 
 	return 0;
 }
@@ -744,20 +745,27 @@ static int hns_roce_qp_has_rq(struct ib_qp_init_attr *attr)
 
 static int alloc_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 			struct ib_qp_init_attr *init_attr,
-			struct ib_udata *udata, unsigned long addr)
+			struct ib_udata *udata,
+			struct hns_roce_ib_create_qp *ucmd)
 {
+	struct hns_roce_ucontext *uctx = rdma_udata_to_drv_context(udata,
+					 struct hns_roce_ucontext, ibucontext);
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_buf_attr buf_attr = {};
+	u8 page_shift = HNS_HW_PAGE_SHIFT;
 	int ret;
 
-	ret = set_wqe_buf_attr(hr_dev, hr_qp, &buf_attr);
+	if (uctx && (uctx->config & HNS_ROCE_UCTX_DYN_QP_PGSZ_FLAGS))
+		page_shift = ucmd->pageshift;
+
+	ret = set_wqe_buf_attr(hr_dev, hr_qp, page_shift, &buf_attr);
 	if (ret) {
 		ibdev_err(ibdev, "failed to split WQE buf, ret = %d.\n", ret);
 		goto err_inline;
 	}
 	ret = hns_roce_mtr_create(hr_dev, &hr_qp->mtr, &buf_attr,
 				  PAGE_SHIFT + hr_dev->caps.mtt_ba_pg_sz,
-				  udata, addr);
+				  udata, ucmd->buf_addr);
 	if (ret) {
 		ibdev_err(ibdev, "failed to create WQE mtr, ret = %d.\n", ret);
 		goto err_inline;
@@ -1152,7 +1160,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 		}
 	}
 
-	ret = alloc_qp_buf(hr_dev, hr_qp, init_attr, udata, ucmd.buf_addr);
+	ret = alloc_qp_buf(hr_dev, hr_qp, init_attr, udata, &ucmd);
 	if (ret) {
 		ibdev_err(ibdev, "failed to alloc QP buffer, ret = %d.\n", ret);
 		goto err_buf;
diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
index 94e861870e27..c5211b8dbf91 100644
--- a/include/uapi/rdma/hns-abi.h
+++ b/include/uapi/rdma/hns-abi.h
@@ -90,7 +90,8 @@ struct hns_roce_ib_create_qp {
 	__u8    log_sq_bb_count;
 	__u8    log_sq_stride;
 	__u8    sq_no_prefetch;
-	__u8    reserved[5];
+	__u8    pageshift;
+	__u8    reserved[4];
 	__aligned_u64 sdb_addr;
 	__aligned_u64 comp_mask; /* Use enum hns_roce_create_qp_comp_mask */
 	__aligned_u64 create_flags;
@@ -119,12 +120,14 @@ enum {
 	HNS_ROCE_EXSGE_FLAGS = 1 << 0,
 	HNS_ROCE_RQ_INLINE_FLAGS = 1 << 1,
 	HNS_ROCE_CQE_INLINE_FLAGS = 1 << 2,
+	HNS_ROCE_UCTX_DYN_QP_PGSZ_FLAGS = 1 << 3,
 };
 
 enum {
 	HNS_ROCE_RSP_EXSGE_FLAGS = 1 << 0,
 	HNS_ROCE_RSP_RQ_INLINE_FLAGS = 1 << 1,
 	HNS_ROCE_RSP_CQE_INLINE_FLAGS = 1 << 2,
+	HNS_ROCE_RSP_UCTX_DYN_QP_PGSZ_FLAGS = 1 << 3,
 };
 
 struct hns_roce_ib_alloc_ucontext_resp {
-- 
2.30.0


