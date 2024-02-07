Return-Path: <linux-rdma+bounces-942-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3BF84C322
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 04:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C05B1C24FA4
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 03:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4894410957;
	Wed,  7 Feb 2024 03:33:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F677101C4;
	Wed,  7 Feb 2024 03:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707276803; cv=none; b=WheYTX/m5ufqVYF3j9Yi9brtHdJqc+ayOQAgkUCCG9nGvctDp3GKMAImonz3cHj9yo12z9VS8Pa3hzqXb3Dnn0+sUHVTy6S3HDkqlOD54iM9I29sEPmeZKi7hC+T+oxxLBPbEDWn9eaTSRVRKC/PRPiLjZjHRDUwOIFNkRsBL1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707276803; c=relaxed/simple;
	bh=dvqAjBUxSIHK7bIQQ1NvbcPuPs08Cu4BN+2/zSyHInE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FfbfseUqh5d78Jf81q9BRBsMgvoow+hL4E/l4sev9UaNW0dUDgVtLnAqRw+G/m1a+6IZjwmBavFMj5oDLB+IYFZOxgXS6FYWbK3rmWyDIzDU55Tc5Pwxk3dx8Z3fKnkWKbaqD+vom0nYiXeQta718mqclC2iHBDRGSysk1/JqE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TV5Jp4jRZz1xnJq;
	Wed,  7 Feb 2024 11:32:10 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id D34F61A0178;
	Wed,  7 Feb 2024 11:33:17 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 11:33:17 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next 2/2] RDMA/hns: Support configuring congestion control algorithm with QP granularity
Date: Wed, 7 Feb 2024 11:29:10 +0800
Message-ID: <20240207032910.3959426-3-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240207032910.3959426-1-huangjunxian6@hisilicon.com>
References: <20240207032910.3959426-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500006.china.huawei.com (7.221.188.68)

Support userspace configuring congestion control algorithm with
QP granularity. If the algorithm is not specified in userspace,
use the default one.

Besides, add a restriction that only DCQCN is supported for UD.

Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h | 26 +++++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 15 ++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  3 +-
 drivers/infiniband/hw/hns/hns_roce_main.c   |  3 +
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 71 +++++++++++++++++++++
 include/uapi/rdma/hns-abi.h                 | 17 +++++
 6 files changed, 118 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 1a8516019516..55f2f54e15fb 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -594,6 +594,21 @@ struct hns_roce_work {
 	u32 queue_num;
 };
 
+enum hns_roce_scc_algo {
+	HNS_ROCE_SCC_ALGO_DCQCN = 0,
+	HNS_ROCE_SCC_ALGO_LDCP,
+	HNS_ROCE_SCC_ALGO_HC3,
+	HNS_ROCE_SCC_ALGO_DIP,
+	HNS_ROCE_SCC_ALGO_TOTAL,
+};
+
+enum hns_roce_cong_type {
+	CONG_TYPE_DCQCN = 1 << HNS_ROCE_SCC_ALGO_DCQCN,
+	CONG_TYPE_LDCP = 1 << HNS_ROCE_SCC_ALGO_LDCP,
+	CONG_TYPE_HC3 = 1 << HNS_ROCE_SCC_ALGO_HC3,
+	CONG_TYPE_DIP = 1 << HNS_ROCE_SCC_ALGO_DIP,
+};
+
 struct hns_roce_qp {
 	struct ib_qp		ibqp;
 	struct hns_roce_wq	rq;
@@ -637,6 +652,7 @@ struct hns_roce_qp {
 	struct list_head	sq_node; /* all send qps are on a list */
 	struct hns_user_mmap_entry *dwqe_mmap_entry;
 	u32			config;
+	enum hns_roce_cong_type	cong_type;
 };
 
 struct hns_roce_ib_iboe {
@@ -708,13 +724,6 @@ struct hns_roce_eq_table {
 	struct hns_roce_eq	*eq;
 };
 
-enum cong_type {
-	CONG_TYPE_DCQCN,
-	CONG_TYPE_LDCP,
-	CONG_TYPE_HC3,
-	CONG_TYPE_DIP,
-};
-
 struct hns_roce_caps {
 	u64		fw_ver;
 	u8		num_ports;
@@ -844,7 +853,8 @@ struct hns_roce_caps {
 	u16		default_aeq_period;
 	u16		default_aeq_arm_st;
 	u16		default_ceq_arm_st;
-	enum cong_type	cong_type;
+	u8		cong_cap;
+	enum hns_roce_cong_type	default_cong_type;
 };
 
 enum hns_roce_device_state {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 8907c30598ab..21532f213b0f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2209,11 +2209,12 @@ static int hns_roce_query_caps(struct hns_roce_dev *hr_dev)
 	caps->max_wqes = 1 << le16_to_cpu(resp_c->sq_depth);
 
 	caps->num_srqs = 1 << hr_reg_read(resp_d, PF_CAPS_D_NUM_SRQS);
-	caps->cong_type = hr_reg_read(resp_d, PF_CAPS_D_CONG_TYPE);
+	caps->cong_cap = hr_reg_read(resp_d, PF_CAPS_D_CONG_CAP);
 	caps->max_srq_wrs = 1 << le16_to_cpu(resp_d->srq_depth);
 	caps->ceqe_depth = 1 << hr_reg_read(resp_d, PF_CAPS_D_CEQ_DEPTH);
 	caps->num_comp_vectors = hr_reg_read(resp_d, PF_CAPS_D_NUM_CEQS);
 	caps->aeqe_depth = 1 << hr_reg_read(resp_d, PF_CAPS_D_AEQ_DEPTH);
+	caps->default_cong_type = hr_reg_read(resp_d, PF_CAPS_D_DEFAULT_ALG);
 	caps->reserved_pds = hr_reg_read(resp_d, PF_CAPS_D_RSV_PDS);
 	caps->num_uars = 1 << hr_reg_read(resp_d, PF_CAPS_D_NUM_UARS);
 	caps->reserved_qps = hr_reg_read(resp_d, PF_CAPS_D_RSV_QPS);
@@ -4737,10 +4738,10 @@ enum {
 static int check_cong_type(struct ib_qp *ibqp,
 			   struct hns_roce_congestion_algorithm *cong_alg)
 {
-	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
+	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
 
 	/* different congestion types match different configurations */
-	switch (hr_dev->caps.cong_type) {
+	switch (hr_qp->cong_type) {
 	case CONG_TYPE_DCQCN:
 		cong_alg->alg_sel = CONG_DCQCN;
 		cong_alg->alg_sub_sel = UNSUPPORT_CONG_LEVEL;
@@ -4766,10 +4767,7 @@ static int check_cong_type(struct ib_qp *ibqp,
 		cong_alg->wnd_mode_sel = WND_LIMIT;
 		break;
 	default:
-		ibdev_warn(&hr_dev->ib_dev,
-			   "invalid type(%u) for congestion selection.\n",
-			   hr_dev->caps.cong_type);
-		hr_dev->caps.cong_type = CONG_TYPE_DCQCN;
+		hr_qp->cong_type = CONG_TYPE_DCQCN;
 		cong_alg->alg_sel = CONG_DCQCN;
 		cong_alg->alg_sub_sel = UNSUPPORT_CONG_LEVEL;
 		cong_alg->dip_vld = DIP_INVALID;
@@ -4788,6 +4786,7 @@ static int fill_cong_field(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 	struct hns_roce_congestion_algorithm cong_field;
 	struct ib_device *ibdev = ibqp->device;
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibdev);
+	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
 	u32 dip_idx = 0;
 	int ret;
 
@@ -4800,7 +4799,7 @@ static int fill_cong_field(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 		return ret;
 
 	hr_reg_write(context, QPC_CONG_ALGO_TMPL_ID, hr_dev->cong_algo_tmpl_id +
-		     hr_dev->caps.cong_type * HNS_ROCE_CONG_SIZE);
+		     ilog2(hr_qp->cong_type) * HNS_ROCE_CONG_SIZE);
 	hr_reg_clear(qpc_mask, QPC_CONG_ALGO_TMPL_ID);
 	hr_reg_write(&context->ext, QPCEX_CONG_ALG_SEL, cong_field.alg_sel);
 	hr_reg_clear(&qpc_mask->ext, QPCEX_CONG_ALG_SEL);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index cd97cbee682a..359a74672ba1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -1214,12 +1214,13 @@ struct hns_roce_query_pf_caps_d {
 #define PF_CAPS_D_RQWQE_HOP_NUM PF_CAPS_D_FIELD_LOC(21, 20)
 #define PF_CAPS_D_EX_SGE_HOP_NUM PF_CAPS_D_FIELD_LOC(23, 22)
 #define PF_CAPS_D_SQWQE_HOP_NUM PF_CAPS_D_FIELD_LOC(25, 24)
-#define PF_CAPS_D_CONG_TYPE PF_CAPS_D_FIELD_LOC(29, 26)
+#define PF_CAPS_D_CONG_CAP PF_CAPS_D_FIELD_LOC(29, 26)
 #define PF_CAPS_D_CEQ_DEPTH PF_CAPS_D_FIELD_LOC(85, 64)
 #define PF_CAPS_D_NUM_CEQS PF_CAPS_D_FIELD_LOC(95, 86)
 #define PF_CAPS_D_AEQ_DEPTH PF_CAPS_D_FIELD_LOC(117, 96)
 #define PF_CAPS_D_AEQ_ARM_ST PF_CAPS_D_FIELD_LOC(119, 118)
 #define PF_CAPS_D_CEQ_ARM_ST PF_CAPS_D_FIELD_LOC(121, 120)
+#define PF_CAPS_D_DEFAULT_ALG PF_CAPS_D_FIELD_LOC(127, 122)
 #define PF_CAPS_D_RSV_PDS PF_CAPS_D_FIELD_LOC(147, 128)
 #define PF_CAPS_D_NUM_UARS PF_CAPS_D_FIELD_LOC(155, 148)
 #define PF_CAPS_D_RSV_QPS PF_CAPS_D_FIELD_LOC(179, 160)
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index b55fe6911f9f..e5b678814f58 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -394,6 +394,9 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 			resp.config |= HNS_ROCE_RSP_CQE_INLINE_FLAGS;
 	}
 
+	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)
+		resp.congest_type  = hr_dev->caps.cong_cap;
+
 	ret = hns_roce_uar_alloc(hr_dev, &context->uar);
 	if (ret)
 		goto error_out;
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 31b147210688..e22911d6b6a9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1004,6 +1004,70 @@ static void free_kernel_wrid(struct hns_roce_qp *hr_qp)
 	kfree(hr_qp->sq.wrid);
 }
 
+static void default_congest_type(struct hns_roce_dev *hr_dev,
+				 struct hns_roce_qp *hr_qp)
+{
+	struct hns_roce_caps *caps = &hr_dev->caps;
+
+	if (hr_qp->ibqp.qp_type == IB_QPT_UD ||
+	    hr_qp->ibqp.qp_type == IB_QPT_GSI)
+		hr_qp->cong_type = CONG_TYPE_DCQCN;
+	else
+		hr_qp->cong_type = 1 << caps->default_cong_type;
+}
+
+static int set_congest_type(struct hns_roce_qp *hr_qp,
+			    struct hns_roce_ib_create_qp *ucmd)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(hr_qp->ibqp.device);
+
+	switch (ucmd->cong_type_flags) {
+	case HNS_ROCE_CREATE_QP_FLAGS_DCQCN:
+		hr_qp->cong_type = CONG_TYPE_DCQCN;
+		break;
+	case HNS_ROCE_CREATE_QP_FLAGS_LDCP:
+		hr_qp->cong_type = CONG_TYPE_LDCP;
+		break;
+	case HNS_ROCE_CREATE_QP_FLAGS_HC3:
+		hr_qp->cong_type = CONG_TYPE_HC3;
+		break;
+	case HNS_ROCE_CREATE_QP_FLAGS_DIP:
+		hr_qp->cong_type = CONG_TYPE_DIP;
+		break;
+	default:
+		hr_qp->cong_type = 0;
+	}
+
+	if (!(hr_qp->cong_type & hr_dev->caps.cong_cap)) {
+		ibdev_err_ratelimited(&hr_dev->ib_dev,
+				      "Unsupported congest type 0x%x, cong_cap = 0x%x.\n",
+				      hr_qp->cong_type, hr_dev->caps.cong_cap);
+		return -EOPNOTSUPP;
+	}
+
+	if (hr_qp->ibqp.qp_type == IB_QPT_UD &&
+	    !(hr_qp->cong_type & CONG_TYPE_DCQCN)) {
+		ibdev_err_ratelimited(&hr_dev->ib_dev,
+				      "Only DCQCN supported for UD. Unsupported congest type 0x%x.\n",
+				      hr_qp->cong_type);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int set_congest_param(struct hns_roce_dev *hr_dev,
+			     struct hns_roce_qp *hr_qp,
+			     struct hns_roce_ib_create_qp *ucmd)
+{
+	if (ucmd->comp_mask & HNS_ROCE_CREATE_QP_MASK_CONGEST_TYPE)
+		return set_congest_type(hr_qp, ucmd);
+
+	default_congest_type(hr_dev, hr_qp);
+
+	return 0;
+}
+
 static int set_qp_param(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 			struct ib_qp_init_attr *init_attr,
 			struct ib_udata *udata,
@@ -1026,6 +1090,9 @@ static int set_qp_param(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 		return ret;
 	}
 
+	if (init_attr->qp_type == IB_QPT_XRC_TGT)
+		default_congest_type(hr_dev, hr_qp);
+
 	if (udata) {
 		ret = ib_copy_from_udata(ucmd, udata,
 					 min(udata->inlen, sizeof(*ucmd)));
@@ -1043,6 +1110,10 @@ static int set_qp_param(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 			ibdev_err(ibdev,
 				  "failed to set user SQ size, ret = %d.\n",
 				  ret);
+
+		ret = set_congest_param(hr_dev, hr_qp, ucmd);
+		if (ret)
+			return ret;
 	} else {
 		if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)
 			hr_qp->config = HNS_ROCE_EXSGE_FLAGS;
diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
index c996e151081e..757095a6c6fc 100644
--- a/include/uapi/rdma/hns-abi.h
+++ b/include/uapi/rdma/hns-abi.h
@@ -81,6 +81,9 @@ struct hns_roce_ib_create_qp {
 	__u8    sq_no_prefetch;
 	__u8    reserved[5];
 	__aligned_u64 sdb_addr;
+	__aligned_u64 comp_mask; /* Use enum hns_roce_create_qp_comp_mask */
+	__aligned_u64 create_flags;
+	__aligned_u64 cong_type_flags;
 };
 
 enum hns_roce_qp_cap_flags {
@@ -107,6 +110,17 @@ enum {
 	HNS_ROCE_RSP_CQE_INLINE_FLAGS = 1 << 2,
 };
 
+enum hns_roce_congest_type_flags {
+	HNS_ROCE_CREATE_QP_FLAGS_DCQCN = 1 << 0,
+	HNS_ROCE_CREATE_QP_FLAGS_LDCP = 1 << 1,
+	HNS_ROCE_CREATE_QP_FLAGS_HC3 = 1 << 2,
+	HNS_ROCE_CREATE_QP_FLAGS_DIP = 1 << 3,
+};
+
+enum hns_roce_create_qp_comp_mask {
+	HNS_ROCE_CREATE_QP_MASK_CONGEST_TYPE = 1 << 1,
+};
+
 struct hns_roce_ib_alloc_ucontext_resp {
 	__u32	qp_tab_size;
 	__u32	cqe_size;
@@ -114,6 +128,9 @@ struct hns_roce_ib_alloc_ucontext_resp {
 	__u32	reserved;
 	__u32	config;
 	__u32	max_inline_data;
+	__u8	reserved0;
+	__u8	congest_type;
+	__u8	reserved1[6];
 };
 
 struct hns_roce_ib_alloc_ucontext {
-- 
2.30.0


