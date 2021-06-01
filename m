Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246D23970BE
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jun 2021 11:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhFAJ7E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Jun 2021 05:59:04 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3319 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbhFAJ7D (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Jun 2021 05:59:03 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FvSBb3Hw1z1BGCc;
        Tue,  1 Jun 2021 17:52:39 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 17:57:20 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 1 Jun 2021 17:57:20 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, "Xi Wang" <wangxi11@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Support getting max QP number from firmware
Date:   Tue, 1 Jun 2021 17:57:07 +0800
Message-ID: <1622541427-42193-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

All functions of HIP09's ROCEE share on-chip resources for all QPs, the
driver needs configure the resource index and number for each function
during the init stage.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  5 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c    | 25 ++++----
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  3 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 88 +++++++++++++++++++++++++++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 10 ++++
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  2 +-
 6 files changed, 106 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index c6cacd2..2ae6dee 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -262,8 +262,6 @@ struct hns_roce_hem_table {
 	u32		type;
 	/* HEM array elment num */
 	unsigned long	num_hem;
-	/* HEM entry record obj total num */
-	unsigned long	num_obj;
 	/* Single obj size */
 	unsigned long	obj_size;
 	unsigned long	table_chunk_size;
@@ -742,6 +740,7 @@ struct hns_roce_caps {
 	u32		max_rq_sg;
 	u32		max_extend_sg;
 	u32		num_qps;
+	u32		num_pi_qps;
 	u32		reserved_qps;
 	int		num_qpc_timer;
 	int		num_cqc_timer;
@@ -1048,7 +1047,7 @@ static inline void hns_roce_write64_k(__le32 val[2], void __iomem *dest)
 static inline struct hns_roce_qp
 	*__hns_roce_qp_lookup(struct hns_roce_dev *hr_dev, u32 qpn)
 {
-	return xa_load(&hr_dev->qp_table_xa, qpn & (hr_dev->caps.num_qps - 1));
+	return xa_load(&hr_dev->qp_table_xa, qpn);
 }
 
 static inline void *hns_roce_buf_offset(struct hns_roce_buf *buf,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index 7fdeedd..ae20915 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -224,8 +224,7 @@ int hns_roce_calc_hem_mhop(struct hns_roce_dev *hr_dev,
 	chunk_ba_num = mhop->bt_chunk_size / BA_BYTE_LEN;
 	chunk_size = table->type < HEM_TYPE_MTT ? mhop->buf_chunk_size :
 			      mhop->bt_chunk_size;
-	table_idx = (*obj & (table->num_obj - 1)) /
-		     (chunk_size / table->obj_size);
+	table_idx = *obj / (chunk_size / table->obj_size);
 	switch (bt_num) {
 	case 3:
 		mhop->l2_idx = table_idx & (chunk_ba_num - 1);
@@ -578,8 +577,7 @@ int hns_roce_table_get(struct hns_roce_dev *hr_dev,
 	if (hns_roce_check_whether_mhop(hr_dev, table->type))
 		return hns_roce_table_mhop_get(hr_dev, table, obj);
 
-	i = (obj & (table->num_obj - 1)) / (table->table_chunk_size /
-	     table->obj_size);
+	i = obj / (table->table_chunk_size / table->obj_size);
 
 	mutex_lock(&table->mutex);
 
@@ -697,8 +695,7 @@ void hns_roce_table_put(struct hns_roce_dev *hr_dev,
 		return;
 	}
 
-	i = (obj & (table->num_obj - 1)) /
-	    (table->table_chunk_size / table->obj_size);
+	i = obj / (table->table_chunk_size / table->obj_size);
 
 	if (!refcount_dec_and_mutex_lock(&table->hem[i]->refcount,
 					 &table->mutex))
@@ -736,8 +733,8 @@ void *hns_roce_table_find(struct hns_roce_dev *hr_dev,
 
 	if (!hns_roce_check_whether_mhop(hr_dev, table->type)) {
 		obj_per_chunk = table->table_chunk_size / table->obj_size;
-		hem = table->hem[(obj & (table->num_obj - 1)) / obj_per_chunk];
-		idx_offset = (obj & (table->num_obj - 1)) % obj_per_chunk;
+		hem = table->hem[obj / obj_per_chunk];
+		idx_offset = obj % obj_per_chunk;
 		dma_offset = offset = idx_offset * table->obj_size;
 	} else {
 		u32 seg_size = 64; /* 8 bytes per BA and 8 BA per segment */
@@ -754,8 +751,7 @@ void *hns_roce_table_find(struct hns_roce_dev *hr_dev,
 			hem_idx = i;
 
 		hem = table->hem[hem_idx];
-		dma_offset = offset = (obj & (table->num_obj - 1)) * seg_size %
-				       mhop.bt_chunk_size;
+		dma_offset = offset = obj * seg_size % mhop.bt_chunk_size;
 		if (mhop.hop_num == 2)
 			dma_offset = offset = 0;
 	}
@@ -797,7 +793,7 @@ int hns_roce_init_hem_table(struct hns_roce_dev *hr_dev,
 	if (!hns_roce_check_whether_mhop(hr_dev, type)) {
 		table->table_chunk_size = hr_dev->caps.chunk_sz;
 		obj_per_chunk = table->table_chunk_size / obj_size;
-		num_hem = (nobj + obj_per_chunk - 1) / obj_per_chunk;
+		num_hem = DIV_ROUND_UP(nobj, obj_per_chunk);
 
 		table->hem = kcalloc(num_hem, sizeof(*table->hem), GFP_KERNEL);
 		if (!table->hem)
@@ -819,8 +815,9 @@ int hns_roce_init_hem_table(struct hns_roce_dev *hr_dev,
 		hop_num = mhop.hop_num;
 
 		obj_per_chunk = buf_chunk_size / obj_size;
-		num_hem = (nobj + obj_per_chunk - 1) / obj_per_chunk;
+		num_hem = DIV_ROUND_UP(nobj, obj_per_chunk);
 		bt_chunk_num = bt_chunk_size / BA_BYTE_LEN;
+
 		if (type >= HEM_TYPE_MTT)
 			num_bt_l0 = bt_chunk_num;
 
@@ -832,8 +829,7 @@ int hns_roce_init_hem_table(struct hns_roce_dev *hr_dev,
 		if (check_whether_bt_num_3(type, hop_num)) {
 			unsigned long num_bt_l1;
 
-			num_bt_l1 = (num_hem + bt_chunk_num - 1) /
-					     bt_chunk_num;
+			num_bt_l1 = DIV_ROUND_UP(num_hem, bt_chunk_num);
 			table->bt_l1 = kcalloc(num_bt_l1,
 					       sizeof(*table->bt_l1),
 					       GFP_KERNEL);
@@ -865,7 +861,6 @@ int hns_roce_init_hem_table(struct hns_roce_dev *hr_dev,
 
 	table->type = type;
 	table->num_hem = num_hem;
-	table->num_obj = nobj;
 	table->obj_size = obj_size;
 	table->lowmem = use_lowmem;
 	mutex_init(&table->mutex);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 0c836cc..c185d77 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -479,8 +479,7 @@ static int hns_roce_v1_set_hem(struct hns_roce_dev *hr_dev,
 	long end;
 
 	/* Find the HEM(Hardware Entry Memory) entry */
-	unsigned long i = (obj & (table->num_obj - 1)) /
-			  (table->table_chunk_size / table->obj_size);
+	unsigned long i = obj / (table->table_chunk_size / table->obj_size);
 
 	switch (table->type) {
 	case HEM_TYPE_QPC:
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index fbc45b9..4d3da31d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1675,6 +1675,29 @@ static int load_func_res_caps(struct hns_roce_dev *hr_dev, bool is_vf)
 	return 0;
 }
 
+static int load_ext_cfg_caps(struct hns_roce_dev *hr_dev, bool is_vf)
+{
+	struct hns_roce_cmq_desc desc;
+	struct hns_roce_cmq_req *req = (struct hns_roce_cmq_req *)desc.data;
+	struct hns_roce_caps *caps = &hr_dev->caps;
+	u32 func_num, qp_num;
+	int ret;
+
+	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_EXT_CFG, true);
+	ret = hns_roce_cmq_send(hr_dev, &desc, 1);
+	if (ret)
+		return ret;
+
+	func_num = is_vf ? 1 : max_t(u32, 1, hr_dev->func_num);
+	qp_num = hr_reg_read(req, EXT_CFG_QP_PI_NUM) / func_num;
+	caps->num_pi_qps = round_down(qp_num, HNS_ROCE_QP_BANK_NUM);
+
+	qp_num = hr_reg_read(req, EXT_CFG_QP_NUM) / func_num;
+	caps->num_qps = round_down(qp_num, HNS_ROCE_QP_BANK_NUM);
+
+	return 0;
+}
+
 static int load_pf_timer_res_caps(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_cmq_desc desc;
@@ -1695,27 +1718,48 @@ static int load_pf_timer_res_caps(struct hns_roce_dev *hr_dev)
 	return 0;
 }
 
-static int hns_roce_query_pf_resource(struct hns_roce_dev *hr_dev)
+static int query_func_resource_caps(struct hns_roce_dev *hr_dev, bool is_vf)
 {
 	struct device *dev = hr_dev->dev;
 	int ret;
 
-	ret = load_func_res_caps(hr_dev, false);
+	ret = load_func_res_caps(hr_dev, is_vf);
 	if (ret) {
-		dev_err(dev, "failed to load func caps, ret = %d.\n", ret);
+		dev_err(dev, "failed to load res caps, ret = %d (%s).\n", ret,
+			is_vf ? "vf" : "pf");
 		return ret;
 	}
 
+	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09) {
+		ret = load_ext_cfg_caps(hr_dev, is_vf);
+		if (ret)
+			dev_err(dev, "failed to load ext cfg, ret = %d (%s).\n",
+				ret, is_vf ? "vf" : "pf");
+	}
+
+	return ret;
+}
+
+static int hns_roce_query_pf_resource(struct hns_roce_dev *hr_dev)
+{
+	struct device *dev = hr_dev->dev;
+	int ret;
+
+	ret = query_func_resource_caps(hr_dev, false);
+	if (ret)
+		return ret;
+
 	ret = load_pf_timer_res_caps(hr_dev);
 	if (ret)
-		dev_err(dev, "failed to load timer res, ret = %d.\n", ret);
+		dev_err(dev, "failed to load pf timer resource, ret = %d.\n",
+			ret);
 
 	return ret;
 }
 
 static int hns_roce_query_vf_resource(struct hns_roce_dev *hr_dev)
 {
-	return load_func_res_caps(hr_dev, true);
+	return query_func_resource_caps(hr_dev, true);
 }
 
 static int __hns_roce_set_vf_switch_param(struct hns_roce_dev *hr_dev,
@@ -1802,6 +1846,24 @@ static int config_vf_hem_resource(struct hns_roce_dev *hr_dev, int vf_id)
 	return hns_roce_cmq_send(hr_dev, desc, 2);
 }
 
+static int config_vf_ext_resource(struct hns_roce_dev *hr_dev, u32 vf_id)
+{
+	struct hns_roce_cmq_desc desc;
+	struct hns_roce_cmq_req *req = (struct hns_roce_cmq_req *)desc.data;
+	struct hns_roce_caps *caps = &hr_dev->caps;
+
+	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_EXT_CFG, false);
+
+	hr_reg_write(req, EXT_CFG_VF_ID, vf_id);
+
+	hr_reg_write(req, EXT_CFG_QP_PI_NUM, caps->num_pi_qps);
+	hr_reg_write(req, EXT_CFG_QP_PI_IDX, vf_id * caps->num_pi_qps);
+	hr_reg_write(req, EXT_CFG_QP_NUM, caps->num_qps);
+	hr_reg_write(req, EXT_CFG_QP_IDX, vf_id * caps->num_qps);
+
+	return hns_roce_cmq_send(hr_dev, &desc, 1);
+}
+
 static int hns_roce_alloc_vf_resource(struct hns_roce_dev *hr_dev)
 {
 	u32 func_num = max_t(u32, 1, hr_dev->func_num);
@@ -1810,8 +1872,22 @@ static int hns_roce_alloc_vf_resource(struct hns_roce_dev *hr_dev)
 
 	for (vf_id = 0; vf_id < func_num; vf_id++) {
 		ret = config_vf_hem_resource(hr_dev, vf_id);
-		if (ret)
+		if (ret) {
+			dev_err(hr_dev->dev,
+				"failed to config vf-%u hem res, ret = %d.\n",
+				vf_id, ret);
 			return ret;
+		}
+
+		if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09) {
+			ret = config_vf_ext_resource(hr_dev, vf_id);
+			if (ret) {
+				dev_err(hr_dev->dev,
+					"failed to config vf-%u ext res, ret = %d.\n",
+					vf_id, ret);
+				return ret;
+			}
+		}
 	}
 
 	return 0;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index cd361c0..66269b3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -253,6 +253,7 @@ enum hns_roce_opcode_type {
 	HNS_ROCE_OPC_QUERY_VF_RES			= 0x850e,
 	HNS_ROCE_OPC_CFG_GMV_TBL			= 0x850f,
 	HNS_ROCE_OPC_CFG_GMV_BT				= 0x8510,
+	HNS_ROCE_OPC_EXT_CFG				= 0x8512,
 	HNS_SWITCH_PARAMETER_CFG			= 0x1033,
 };
 
@@ -1344,6 +1345,15 @@ struct hns_roce_func_clear {
 #define HNS_ROCE_V2_READ_FUNC_CLEAR_FLAG_INTERVAL	40
 #define HNS_ROCE_V2_READ_FUNC_CLEAR_FLAG_FAIL_WAIT	20
 
+/* Fields of HNS_ROCE_OPC_EXT_CFG */
+#define EXT_CFG_VF_ID CMQ_REQ_FIELD_LOC(31, 0)
+#define EXT_CFG_QP_PI_IDX CMQ_REQ_FIELD_LOC(45, 32)
+#define EXT_CFG_QP_PI_NUM CMQ_REQ_FIELD_LOC(63, 48)
+#define EXT_CFG_QP_NUM CMQ_REQ_FIELD_LOC(87, 64)
+#define EXT_CFG_QP_IDX CMQ_REQ_FIELD_LOC(119, 96)
+#define EXT_CFG_LLM_IDX CMQ_REQ_FIELD_LOC(139, 128)
+#define EXT_CFG_LLM_NUM CMQ_REQ_FIELD_LOC(156, 144)
+
 #define CFG_LLM_A_BA_L CMQ_REQ_FIELD_LOC(31, 0)
 #define CFG_LLM_A_BA_H CMQ_REQ_FIELD_LOC(63, 32)
 #define CFG_LLM_A_DEPTH CMQ_REQ_FIELD_LOC(76, 64)
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 9203cf1..6387f6f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -379,7 +379,7 @@ void hns_roce_qp_remove(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 		list_del(&hr_qp->rq_node);
 
 	xa_lock_irqsave(xa, flags);
-	__xa_erase(xa, hr_qp->qpn & (hr_dev->caps.num_qps - 1));
+	__xa_erase(xa, hr_qp->qpn);
 	xa_unlock_irqrestore(xa, flags);
 }
 
-- 
2.7.4

