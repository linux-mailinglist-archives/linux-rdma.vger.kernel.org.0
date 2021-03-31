Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B92F34932B
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 14:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhCYNgr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 09:36:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13699 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhCYNgk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Mar 2021 09:36:40 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F5mKN5StCzpVLW;
        Thu, 25 Mar 2021 21:34:00 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Mar 2021 21:36:22 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 2/2] RDMA/hns: Support congestion control type selection according to the FW
Date:   Thu, 25 Mar 2021 21:33:56 +0800
Message-ID: <1616679236-7795-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1616679236-7795-1-git-send-email-liweihang@huawei.com>
References: <1616679236-7795-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yangyang Li <liyangyang20@huawei.com>

The type of congestion control algorithm includes DCQCN, LDCP, HC3 and
DIP. The driver will select one of them according to the firmware when
querying PF capabilities, and then set the related configuration fields
into QPC.

Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  10 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 164 ++++++++++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  27 ++++-
 drivers/infiniband/hw/hns/hns_roce_main.c   |   2 +
 4 files changed, 200 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 869548e..30c2c86 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -735,6 +735,13 @@ struct hns_roce_eq_table {
 	void __iomem		**eqc_base; /* only for hw v1 */
 };
 
+enum cong_type {
+	CONG_TYPE_DCQCN,
+	CONG_TYPE_LDCP,
+	CONG_TYPE_HC3,
+	CONG_TYPE_DIP,
+};
+
 struct hns_roce_caps {
 	u64		fw_ver;
 	u8		num_ports;
@@ -865,6 +872,7 @@ struct hns_roce_caps {
 	u16		default_aeq_period;
 	u16		default_aeq_arm_st;
 	u16		default_ceq_arm_st;
+	enum cong_type	cong_type;
 };
 
 struct hns_roce_dfx_hw {
@@ -959,6 +967,8 @@ struct hns_roce_dev {
 	enum hns_roce_device_state state;
 	struct list_head	qp_list; /* list of all qps on this dev */
 	spinlock_t		qp_list_lock; /* protect qp_list */
+	struct list_head	dip_list; /* list of all dest ips on this dev */
+	spinlock_t		dip_list_lock; /* protect dip_list */
 
 	struct list_head        pgdir_list;
 	struct mutex            pgdir_mutex;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index a3ea34c..2583e46 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2097,7 +2097,11 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 	caps->num_srqs = 1 << roce_get_field(resp_d->wq_hop_num_max_srqs,
 					     V2_QUERY_PF_CAPS_D_NUM_SRQS_M,
 					     V2_QUERY_PF_CAPS_D_NUM_SRQS_S);
+	caps->cong_type = roce_get_field(resp_d->wq_hop_num_max_srqs,
+					 V2_QUERY_PF_CAPS_D_CONG_TYPE_M,
+					 V2_QUERY_PF_CAPS_D_CONG_TYPE_S);
 	caps->max_srq_wrs = 1 << le16_to_cpu(resp_d->srq_depth);
+
 	caps->ceqe_depth = 1 << roce_get_field(resp_d->num_ceqs_ceq_depth,
 					       V2_QUERY_PF_CAPS_D_CEQ_DEPTH_M,
 					       V2_QUERY_PF_CAPS_D_CEQ_DEPTH_S);
@@ -2534,6 +2538,22 @@ static void hns_roce_free_link_table(struct hns_roce_dev *hr_dev,
 			  link_tbl->table.map);
 }
 
+static void free_dip_list(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_dip *hr_dip;
+	struct hns_roce_dip *tmp;
+	unsigned long flags;
+
+	spin_lock_irqsave(&hr_dev->dip_list_lock, flags);
+
+	list_for_each_entry_safe(hr_dip, tmp, &hr_dev->dip_list, node) {
+		list_del(&hr_dip->node);
+		kfree(hr_dip);
+	}
+
+	spin_unlock_irqrestore(&hr_dev->dip_list_lock, flags);
+}
+
 static int get_hem_table(struct hns_roce_dev *hr_dev)
 {
 	unsigned int qpc_count;
@@ -2633,6 +2653,9 @@ static void hns_roce_v2_exit(struct hns_roce_dev *hr_dev)
 
 	hns_roce_free_link_table(hr_dev, &priv->tpq);
 	hns_roce_free_link_table(hr_dev, &priv->tsq);
+
+	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP09)
+		free_dip_list(hr_dev);
 }
 
 static int hns_roce_query_mbox_status(struct hns_roce_dev *hr_dev)
@@ -4501,6 +4524,143 @@ static inline u16 get_udp_sport(u32 fl, u32 lqpn, u32 rqpn)
 	return rdma_flow_label_to_udp_sport(fl);
 }
 
+static int get_dip_ctx_idx(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
+			   u32 *dip_idx)
+{
+	const struct ib_global_route *grh = rdma_ah_read_grh(&attr->ah_attr);
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
+	struct hns_roce_dip *hr_dip;
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&hr_dev->dip_list_lock, flags);
+
+	list_for_each_entry(hr_dip, &hr_dev->dip_list, node) {
+		if (!memcmp(grh->dgid.raw, hr_dip->dgid, 16))
+			goto out;
+	}
+
+	/* If no dgid is found, a new dip and a mapping between dgid and
+	 * dip_idx will be created.
+	 */
+	hr_dip = kzalloc(sizeof(*hr_dip), GFP_KERNEL);
+	if (!hr_dip) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	memcpy(hr_dip->dgid, grh->dgid.raw, sizeof(grh->dgid.raw));
+	hr_dip->dip_idx = *dip_idx = ibqp->qp_num;
+	list_add_tail(&hr_dip->node, &hr_dev->dip_list);
+
+out:
+	spin_unlock_irqrestore(&hr_dev->dip_list_lock, flags);
+	return ret;
+}
+
+enum {
+	CONG_DCQCN,
+	CONG_WINDOW,
+};
+
+enum {
+	UNSUPPORT_CONG_LEVEL,
+	SUPPORT_CONG_LEVEL,
+};
+
+enum {
+	CONG_LDCP,
+	CONG_HC3,
+};
+
+enum {
+	DIP_INVALID,
+	DIP_VALID,
+};
+
+static int check_cong_type(struct ib_qp *ibqp,
+			   struct hns_roce_congestion_algorithm *cong_alg)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
+
+	/* different congestion types match different configurations */
+	switch (hr_dev->caps.cong_type) {
+	case CONG_TYPE_DCQCN:
+		cong_alg->alg_sel = CONG_DCQCN;
+		cong_alg->alg_sub_sel = UNSUPPORT_CONG_LEVEL;
+		cong_alg->dip_vld = DIP_INVALID;
+		break;
+	case CONG_TYPE_LDCP:
+		cong_alg->alg_sel = CONG_WINDOW;
+		cong_alg->alg_sub_sel = CONG_LDCP;
+		cong_alg->dip_vld = DIP_INVALID;
+		break;
+	case CONG_TYPE_HC3:
+		cong_alg->alg_sel = CONG_WINDOW;
+		cong_alg->alg_sub_sel = CONG_HC3;
+		cong_alg->dip_vld = DIP_INVALID;
+		break;
+	case CONG_TYPE_DIP:
+		cong_alg->alg_sel = CONG_DCQCN;
+		cong_alg->alg_sub_sel = UNSUPPORT_CONG_LEVEL;
+		cong_alg->dip_vld = DIP_VALID;
+		break;
+	default:
+		ibdev_err(&hr_dev->ib_dev,
+			  "error type(%u) for congestion selection.\n",
+			  hr_dev->caps.cong_type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int fill_cong_field(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
+			   struct hns_roce_v2_qp_context *context,
+			   struct hns_roce_v2_qp_context *qpc_mask)
+{
+	const struct ib_global_route *grh = rdma_ah_read_grh(&attr->ah_attr);
+	struct hns_roce_congestion_algorithm cong_field;
+	struct ib_device *ibdev = ibqp->device;
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibdev);
+	u32 dip_idx = 0;
+	int ret;
+
+	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08 ||
+	    grh->sgid_attr->gid_type == IB_GID_TYPE_ROCE)
+		return 0;
+
+	ret = check_cong_type(ibqp, &cong_field);
+	if (ret)
+		return ret;
+
+	hr_reg_write(context, QPC_CONG_ALGO_TMPL_ID, hr_dev->cong_algo_tmpl_id +
+		     hr_dev->caps.cong_type * HNS_ROCE_CONG_SIZE);
+	hr_reg_write(qpc_mask, QPC_CONG_ALGO_TMPL_ID, 0);
+	hr_reg_write(&context->ext, QPCEX_CONG_ALG_SEL, cong_field.alg_sel);
+	hr_reg_write(&qpc_mask->ext, QPCEX_CONG_ALG_SEL, 0);
+	hr_reg_write(&context->ext, QPCEX_CONG_ALG_SUB_SEL,
+		     cong_field.alg_sub_sel);
+	hr_reg_write(&qpc_mask->ext, QPCEX_CONG_ALG_SUB_SEL, 0);
+	hr_reg_write(&context->ext, QPCEX_DIP_CTX_IDX_VLD, cong_field.dip_vld);
+	hr_reg_write(&qpc_mask->ext, QPCEX_DIP_CTX_IDX_VLD, 0);
+
+	/* if dip is disabled, there is no need to set dip idx */
+	if (cong_field.dip_vld == 0)
+		return 0;
+
+	ret = get_dip_ctx_idx(ibqp, attr, &dip_idx);
+	if (ret) {
+		ibdev_err(ibdev, "failed to fill cong field, ret = %d.\n", ret);
+		return ret;
+	}
+
+	hr_reg_write(&context->ext, QPCEX_DIP_CTX_IDX, dip_idx);
+	hr_reg_write(&qpc_mask->ext, QPCEX_DIP_CTX_IDX, 0);
+
+	return 0;
+}
+
 static int hns_roce_v2_set_path(struct ib_qp *ibqp,
 				const struct ib_qp_attr *attr,
 				int attr_mask,
@@ -4584,6 +4744,10 @@ static int hns_roce_v2_set_path(struct ib_qp *ibqp,
 	roce_set_field(qpc_mask->byte_24_mtu_tc, V2_QPC_BYTE_24_HOP_LIMIT_M,
 		       V2_QPC_BYTE_24_HOP_LIMIT_S, 0);
 
+	ret = fill_cong_field(ibqp, attr, context, qpc_mask);
+	if (ret)
+		return ret;
+
 	roce_set_field(context->byte_24_mtu_tc, V2_QPC_BYTE_24_TC_M,
 		       V2_QPC_BYTE_24_TC_S, get_tclass(&attr->ah_attr.grh));
 	roce_set_field(qpc_mask->byte_24_mtu_tc, V2_QPC_BYTE_24_TC_M,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index aa87b1c..a0e036f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -145,6 +145,8 @@
 
 #define HNS_ROCE_CMQ_SCC_CLR_DONE_CNT		5
 
+#define HNS_ROCE_CONG_SIZE 64
+
 #define check_whether_last_step(hop_num, step_idx) \
 	((step_idx == 0 && hop_num == HNS_ROCE_HOP_NUM_0) || \
 	(step_idx == 1 && hop_num == 1) || \
@@ -575,6 +577,10 @@ struct hns_roce_v2_qp_context {
 	struct hns_roce_v2_qp_context_ex ext;
 };
 
+#define QPC_FIELD_LOC(h, l) FIELD_LOC(struct hns_roce_v2_qp_context, h, l)
+
+#define QPC_CONG_ALGO_TMPL_ID QPC_FIELD_LOC(455, 448)
+
 #define	V2_QPC_BYTE_4_TST_S 0
 #define V2_QPC_BYTE_4_TST_M GENMASK(2, 0)
 
@@ -666,9 +672,6 @@ struct hns_roce_v2_qp_context {
 #define	V2_QPC_BYTE_56_LP_PKTN_INI_S 28
 #define V2_QPC_BYTE_56_LP_PKTN_INI_M GENMASK(31, 28)
 
-#define	V2_QPC_BYTE_60_TEMPID_S 0
-#define V2_QPC_BYTE_60_TEMPID_M GENMASK(7, 0)
-
 #define V2_QPC_BYTE_60_SCC_TOKEN_S 8
 #define V2_QPC_BYTE_60_SCC_TOKEN_M GENMASK(26, 8)
 
@@ -943,6 +946,10 @@ struct hns_roce_v2_qp_context {
 
 #define QPCEX_FIELD_LOC(h, l) FIELD_LOC(struct hns_roce_v2_qp_context_ex, h, l)
 
+#define QPCEX_CONG_ALG_SEL QPCEX_FIELD_LOC(0, 0)
+#define QPCEX_CONG_ALG_SUB_SEL QPCEX_FIELD_LOC(1, 1)
+#define QPCEX_DIP_CTX_IDX_VLD QPCEX_FIELD_LOC(2, 2)
+#define QPCEX_DIP_CTX_IDX QPCEX_FIELD_LOC(22, 3)
 #define QPCEX_STASH QPCEX_FIELD_LOC(82, 82)
 
 #define	V2_QP_RWE_S 1 /* rdma write enable */
@@ -1808,6 +1815,14 @@ struct hns_roce_query_pf_caps_d {
 #define V2_QUERY_PF_CAPS_D_SQWQE_HOP_NUM_S 24
 #define V2_QUERY_PF_CAPS_D_SQWQE_HOP_NUM_M GENMASK(25, 24)
 
+#define V2_QUERY_PF_CAPS_D_CONG_TYPE_S 26
+#define V2_QUERY_PF_CAPS_D_CONG_TYPE_M GENMASK(29, 26)
+
+struct hns_roce_congestion_algorithm {
+	u8 alg_sel;
+	u8 alg_sub_sel;
+	u8 dip_vld;
+};
 
 #define V2_QUERY_PF_CAPS_D_CEQ_DEPTH_S 0
 #define V2_QUERY_PF_CAPS_D_CEQ_DEPTH_M GENMASK(21, 0)
@@ -1943,6 +1958,12 @@ struct hns_roce_eq_context {
 	__le32	rsv[5];
 };
 
+struct hns_roce_dip {
+	u8 dgid[GID_LEN_V2];
+	u8 dip_idx;
+	struct list_head node;	/* all dips are on a list */
+};
+
 #define HNS_ROCE_AEQ_DEFAULT_BURST_NUM	0x0
 #define HNS_ROCE_AEQ_DEFAULT_INTERVAL	0x0
 #define HNS_ROCE_CEQ_DEFAULT_BURST_NUM	0x0
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 1a747f7..563fc88 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -910,6 +910,8 @@ int hns_roce_init(struct hns_roce_dev *hr_dev)
 
 	INIT_LIST_HEAD(&hr_dev->qp_list);
 	spin_lock_init(&hr_dev->qp_list_lock);
+	INIT_LIST_HEAD(&hr_dev->dip_list);
+	spin_lock_init(&hr_dev->dip_list_lock);
 
 	ret = hns_roce_register_device(hr_dev);
 	if (ret)
-- 
2.8.1

