Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93F760DE6C
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Oct 2022 11:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbiJZJv6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Oct 2022 05:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbiJZJvy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Oct 2022 05:51:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48CEB7F40
        for <linux-rdma@vger.kernel.org>; Wed, 26 Oct 2022 02:51:51 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4My3qj06G0zmVJ5;
        Wed, 26 Oct 2022 17:46:57 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 17:51:50 +0800
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 17:51:49 +0800
From:   Haoyue Xu <xuhaoyue1@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <xuhaoyue1@hisilicon.com>
Subject: [PATCH v2 for-rc 2/5] RDMA/hns: Fix the problem of sge nums
Date:   Wed, 26 Oct 2022 17:50:51 +0800
Message-ID: <20221026095054.2384620-3-xuhaoyue1@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20221026095054.2384620-1-xuhaoyue1@hisilicon.com>
References: <20221026095054.2384620-1-xuhaoyue1@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Currently, the driver only uses max_send_sge to initialize sge num
when creating_qp. So, in the sq inline scenario, the driver may not
has enough sge to send data. For example, if max_send_sge is 16 and
max_inline_data is 1024, the driver needs 1024/16=64 sge to send data.
Therefore, the calculation method of sge num is modified to take the
maximum value of max_send_sge and max_inline_data/16 to solve this
problem.

Fixes: 05201e01be93 ("RDMA/hns: Refactor process of setting extended sge")
Fixes: 30b707886aeb ("RDMA/hns: Support inline data in extented sge space for RC")

Signed-off-by: Luoyouming <luoyouming@huawei.com>
Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |   3 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  12 +--
 drivers/infiniband/hw/hns/hns_roce_main.c   |  18 +++-
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 108 +++++++++++++++++---
 include/uapi/rdma/hns-abi.h                 |  17 +++
 5 files changed, 128 insertions(+), 30 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 723e55a7de8d..f701cc86896b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -202,6 +202,7 @@ struct hns_roce_ucontext {
 	struct list_head	page_list;
 	struct mutex		page_mutex;
 	struct hns_user_mmap_entry *db_mmap_entry;
+	u32			config;
 };
 
 struct hns_roce_pd {
@@ -334,6 +335,7 @@ struct hns_roce_wq {
 	u32		head;
 	u32		tail;
 	void __iomem	*db_reg;
+	u32		ext_sge_cnt;
 };
 
 struct hns_roce_sge {
@@ -635,6 +637,7 @@ struct hns_roce_qp {
 	struct list_head	rq_node; /* all recv qps are on a list */
 	struct list_head	sq_node; /* all send qps are on a list */
 	struct hns_user_mmap_entry *dwqe_mmap_entry;
+	u32			config;
 };
 
 struct hns_roce_ib_iboe {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 0937db738be7..65875b4cff13 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -187,14 +187,6 @@ static void set_atomic_seg(const struct ib_send_wr *wr,
 	hr_reg_write(rc_sq_wqe, RC_SEND_WQE_SGE_NUM, valid_num_sge);
 }
 
-static unsigned int get_std_sge_num(struct hns_roce_qp *qp)
-{
-	if (qp->ibqp.qp_type == IB_QPT_GSI || qp->ibqp.qp_type == IB_QPT_UD)
-		return 0;
-
-	return HNS_ROCE_SGE_IN_WQE;
-}
-
 static int fill_ext_sge_inl_data(struct hns_roce_qp *qp,
 				 const struct ib_send_wr *wr,
 				 unsigned int *sge_idx, u32 msg_len)
@@ -202,14 +194,12 @@ static int fill_ext_sge_inl_data(struct hns_roce_qp *qp,
 	struct ib_device *ibdev = &(to_hr_dev(qp->ibqp.device))->ib_dev;
 	unsigned int left_len_in_pg;
 	unsigned int idx = *sge_idx;
-	unsigned int std_sge_num;
 	unsigned int i = 0;
 	unsigned int len;
 	void *addr;
 	void *dseg;
 
-	std_sge_num = get_std_sge_num(qp);
-	if (msg_len > (qp->sq.max_gs - std_sge_num) * HNS_ROCE_SGE_SIZE) {
+	if (msg_len > qp->sq.ext_sge_cnt * HNS_ROCE_SGE_SIZE) {
 		ibdev_err(ibdev,
 			  "no enough extended sge space for inline data.\n");
 		return -EINVAL;
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index dcf89689a4c6..8ba68ac12388 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -354,10 +354,11 @@ static int hns_roce_alloc_uar_entry(struct ib_ucontext *uctx)
 static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 				   struct ib_udata *udata)
 {
-	int ret;
 	struct hns_roce_ucontext *context = to_hr_ucontext(uctx);
-	struct hns_roce_ib_alloc_ucontext_resp resp = {};
 	struct hns_roce_dev *hr_dev = to_hr_dev(uctx->device);
+	struct hns_roce_ib_alloc_ucontext_resp resp = {};
+	struct hns_roce_ib_alloc_ucontext ucmd = {};
+	int ret;
 
 	if (!hr_dev->active)
 		return -EAGAIN;
@@ -365,6 +366,19 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 	resp.qp_tab_size = hr_dev->caps.num_qps;
 	resp.srq_tab_size = hr_dev->caps.num_srqs;
 
+	ret = ib_copy_from_udata(&ucmd, udata,
+				 min(udata->inlen, sizeof(ucmd)));
+	if (ret)
+		return ret;
+
+	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)
+		context->config = ucmd.config & HNS_ROCE_EXSGE_FLAGS;
+
+	if (context->config & HNS_ROCE_EXSGE_FLAGS) {
+		resp.config |= HNS_ROCE_RSP_EXSGE_FLAGS;
+		resp.max_inline_data = hr_dev->caps.max_sq_inline;
+	}
+
 	ret = hns_roce_uar_alloc(hr_dev, &context->uar);
 	if (ret)
 		goto error_fail_uar_alloc;
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index f0bd82a18069..7354c9e61502 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -476,38 +476,110 @@ static int set_rq_size(struct hns_roce_dev *hr_dev, struct ib_qp_cap *cap,
 	return 0;
 }
 
-static u32 get_wqe_ext_sge_cnt(struct hns_roce_qp *qp)
+static u32 get_max_inline_data(struct hns_roce_dev *hr_dev,
+			       struct ib_qp_cap *cap)
 {
-	/* GSI/UD QP only has extended sge */
-	if (qp->ibqp.qp_type == IB_QPT_GSI || qp->ibqp.qp_type == IB_QPT_UD)
-		return qp->sq.max_gs;
-
-	if (qp->sq.max_gs > HNS_ROCE_SGE_IN_WQE)
-		return qp->sq.max_gs - HNS_ROCE_SGE_IN_WQE;
+	if (cap->max_inline_data) {
+		cap->max_inline_data = roundup_pow_of_two(
+					cap->max_inline_data);
+		return min(cap->max_inline_data,
+			   hr_dev->caps.max_sq_inline);
+	}
 
 	return 0;
 }
 
+static void update_inline_data(struct hns_roce_qp *hr_qp,
+			       struct ib_qp_cap *cap)
+{
+	u32 sge_num = hr_qp->sq.ext_sge_cnt;
+
+	if (hr_qp->config & HNS_ROCE_EXSGE_FLAGS) {
+		if (!(hr_qp->ibqp.qp_type == IB_QPT_GSI ||
+			hr_qp->ibqp.qp_type == IB_QPT_UD))
+			sge_num = max((u32)HNS_ROCE_SGE_IN_WQE, sge_num);
+
+		cap->max_inline_data = max(cap->max_inline_data,
+					sge_num * HNS_ROCE_SGE_SIZE);
+	}
+
+	hr_qp->max_inline_data = cap->max_inline_data;
+}
+
+static u32 get_sge_num_from_max_send_sge(bool is_ud_or_gsi,
+					 u32 max_send_sge)
+{
+	unsigned int std_sge_num;
+	unsigned int min_sge;
+
+	std_sge_num = is_ud_or_gsi ? 0 : HNS_ROCE_SGE_IN_WQE;
+	min_sge = is_ud_or_gsi ? 1 : 0;
+	return max_send_sge > std_sge_num ? (max_send_sge - std_sge_num) :
+				min_sge;
+}
+
+static unsigned int get_sge_num_from_max_inl_data(bool is_ud_or_gsi,
+						  u32 max_inline_data)
+{
+	unsigned int inline_sge;
+
+	inline_sge = roundup_pow_of_two(max_inline_data) / HNS_ROCE_SGE_SIZE;
+
+	/*
+	 * if max_inline_data less than
+	 * HNS_ROCE_SGE_IN_WQE * HNS_ROCE_SGE_SIZE,
+	 * In addition to ud's mode, no need to extend sge.
+	 */
+	if ((!is_ud_or_gsi) && (inline_sge <= HNS_ROCE_SGE_IN_WQE))
+		inline_sge = 0;
+
+	return inline_sge;
+}
+
 static void set_ext_sge_param(struct hns_roce_dev *hr_dev, u32 sq_wqe_cnt,
 			      struct hns_roce_qp *hr_qp, struct ib_qp_cap *cap)
 {
+	bool is_ud_or_gsi = (hr_qp->ibqp.qp_type == IB_QPT_GSI ||
+				hr_qp->ibqp.qp_type == IB_QPT_UD);
+	unsigned int std_sge_num;
+	u32 inline_ext_sge = 0;
+	u32 ext_wqe_sge_cnt;
 	u32 total_sge_cnt;
-	u32 wqe_sge_cnt;
+
+	cap->max_inline_data = get_max_inline_data(hr_dev, cap);
 
 	hr_qp->sge.sge_shift = HNS_ROCE_SGE_SHIFT;
+	std_sge_num = is_ud_or_gsi ? 0 : HNS_ROCE_SGE_IN_WQE;
+	ext_wqe_sge_cnt = get_sge_num_from_max_send_sge(is_ud_or_gsi,
+							cap->max_send_sge);
 
-	hr_qp->sq.max_gs = max(1U, cap->max_send_sge);
+	if (hr_qp->config & HNS_ROCE_EXSGE_FLAGS) {
+		inline_ext_sge = max(ext_wqe_sge_cnt,
+				 get_sge_num_from_max_inl_data(
+				 is_ud_or_gsi, cap->max_inline_data));
+		hr_qp->sq.ext_sge_cnt = inline_ext_sge ?
+					roundup_pow_of_two(inline_ext_sge) : 0;
 
-	wqe_sge_cnt = get_wqe_ext_sge_cnt(hr_qp);
+		hr_qp->sq.max_gs = max(1U, (hr_qp->sq.ext_sge_cnt + std_sge_num));
+		hr_qp->sq.max_gs = min(hr_qp->sq.max_gs, hr_dev->caps.max_sq_sg);
+
+		ext_wqe_sge_cnt = hr_qp->sq.ext_sge_cnt;
+	} else {
+		hr_qp->sq.max_gs = max(1U, cap->max_send_sge);
+		hr_qp->sq.max_gs = min(hr_qp->sq.max_gs, hr_dev->caps.max_sq_sg);
+		hr_qp->sq.ext_sge_cnt = hr_qp->sq.max_gs;
+	}
 
 	/* If the number of extended sge is not zero, they MUST use the
 	 * space of HNS_HW_PAGE_SIZE at least.
 	 */
-	if (wqe_sge_cnt) {
-		total_sge_cnt = roundup_pow_of_two(sq_wqe_cnt * wqe_sge_cnt);
+	if (ext_wqe_sge_cnt) {
+		total_sge_cnt = roundup_pow_of_two(sq_wqe_cnt * ext_wqe_sge_cnt);
 		hr_qp->sge.sge_cnt = max(total_sge_cnt,
 				(u32)HNS_HW_PAGE_SIZE / HNS_ROCE_SGE_SIZE);
 	}
+
+	update_inline_data(hr_qp, cap);
 }
 
 static int check_sq_size_with_integrity(struct hns_roce_dev *hr_dev,
@@ -556,6 +628,7 @@ static int set_user_sq_size(struct hns_roce_dev *hr_dev,
 
 	hr_qp->sq.wqe_shift = ucmd->log_sq_stride;
 	hr_qp->sq.wqe_cnt = cnt;
+	cap->max_send_sge = hr_qp->sq.max_gs;
 
 	return 0;
 }
@@ -986,13 +1059,9 @@ static int set_qp_param(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 			struct hns_roce_ib_create_qp *ucmd)
 {
 	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct hns_roce_ucontext *uctx;
 	int ret;
 
-	if (init_attr->cap.max_inline_data > hr_dev->caps.max_sq_inline)
-		init_attr->cap.max_inline_data = hr_dev->caps.max_sq_inline;
-
-	hr_qp->max_inline_data = init_attr->cap.max_inline_data;
-
 	if (init_attr->sq_sig_type == IB_SIGNAL_ALL_WR)
 		hr_qp->sq_signal_bits = IB_SIGNAL_ALL_WR;
 	else
@@ -1015,12 +1084,17 @@ static int set_qp_param(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 			return ret;
 		}
 
+		uctx = rdma_udata_to_drv_context(udata, struct hns_roce_ucontext,
+						ibucontext);
+		hr_qp->config = uctx->config;
 		ret = set_user_sq_size(hr_dev, &init_attr->cap, hr_qp, ucmd);
 		if (ret)
 			ibdev_err(ibdev,
 				  "failed to set user SQ size, ret = %d.\n",
 				  ret);
 	} else {
+		if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)
+			hr_qp->config = HNS_ROCE_EXSGE_FLAGS;
 		ret = set_kernel_sq_size(hr_dev, &init_attr->cap, hr_qp);
 		if (ret)
 			ibdev_err(ibdev,
diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
index f6fde06db4b4..017da74f56af 100644
--- a/include/uapi/rdma/hns-abi.h
+++ b/include/uapi/rdma/hns-abi.h
@@ -85,13 +85,30 @@ struct hns_roce_ib_create_qp_resp {
 	__aligned_u64 dwqe_mmap_key;
 };
 
+enum {
+	HNS_ROCE_EXSGE_FLAGS = 1 << 0,
+};
+
+enum {
+	HNS_ROCE_RSP_EXSGE_FLAGS = 1 << 0,
+};
+
+
 struct hns_roce_ib_alloc_ucontext_resp {
 	__u32	qp_tab_size;
 	__u32	cqe_size;
 	__u32	srq_tab_size;
 	__u32	reserved;
+	__u32	config;
+	__u32	max_inline_data;
 };
 
+struct hns_roce_ib_alloc_ucontext {
+	__u32 config;
+	__u32 reserved;
+};
+
+
 struct hns_roce_ib_alloc_pd_resp {
 	__u32 pdn;
 };
-- 
2.30.0

