Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7682034B405
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Mar 2021 04:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhC0DYZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Mar 2021 23:24:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14567 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbhC0DYT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Mar 2021 23:24:19 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F6kdt5K8MzPrjX;
        Sat, 27 Mar 2021 11:21:38 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 11:24:02 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 5/5] RDMA/hns: Simplify command fields for HEM base address configuration
Date:   Sat, 27 Mar 2021 11:21:34 +0800
Message-ID: <1616815294-13434-6-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1616815294-13434-1-git-send-email-liweihang@huawei.com>
References: <1616815294-13434-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Use hr_reg_write() instead of roce_set_field() to simplify codes about
configuring HEM BA.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 139 +++++++++++------------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 104 +++++++--------------
 2 files changed, 83 insertions(+), 160 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 5d499df..431a137 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1796,71 +1796,46 @@ static int hns_roce_alloc_vf_resource(struct hns_roce_dev *hr_dev)
 
 static int hns_roce_v2_set_bt(struct hns_roce_dev *hr_dev)
 {
-	u8 srqc_hop_num = hr_dev->caps.srqc_hop_num;
-	u8 qpc_hop_num = hr_dev->caps.qpc_hop_num;
-	u8 cqc_hop_num = hr_dev->caps.cqc_hop_num;
-	u8 mpt_hop_num = hr_dev->caps.mpt_hop_num;
-	u8 sccc_hop_num = hr_dev->caps.sccc_hop_num;
-	struct hns_roce_cfg_bt_attr *req;
 	struct hns_roce_cmq_desc desc;
+	struct hns_roce_cmq_req *req = (struct hns_roce_cmq_req *)desc.data;
+	struct hns_roce_caps *caps = &hr_dev->caps;
 
 	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_CFG_BT_ATTR, false);
-	req = (struct hns_roce_cfg_bt_attr *)desc.data;
-	memset(req, 0, sizeof(*req));
 
-	roce_set_field(req->vf_qpc_cfg, CFG_BT_ATTR_DATA_0_VF_QPC_BA_PGSZ_M,
-		       CFG_BT_ATTR_DATA_0_VF_QPC_BA_PGSZ_S,
-		       hr_dev->caps.qpc_ba_pg_sz + PG_SHIFT_OFFSET);
-	roce_set_field(req->vf_qpc_cfg, CFG_BT_ATTR_DATA_0_VF_QPC_BUF_PGSZ_M,
-		       CFG_BT_ATTR_DATA_0_VF_QPC_BUF_PGSZ_S,
-		       hr_dev->caps.qpc_buf_pg_sz + PG_SHIFT_OFFSET);
-	roce_set_field(req->vf_qpc_cfg, CFG_BT_ATTR_DATA_0_VF_QPC_HOPNUM_M,
-		       CFG_BT_ATTR_DATA_0_VF_QPC_HOPNUM_S,
-		       qpc_hop_num == HNS_ROCE_HOP_NUM_0 ? 0 : qpc_hop_num);
-
-	roce_set_field(req->vf_srqc_cfg, CFG_BT_ATTR_DATA_1_VF_SRQC_BA_PGSZ_M,
-		       CFG_BT_ATTR_DATA_1_VF_SRQC_BA_PGSZ_S,
-		       hr_dev->caps.srqc_ba_pg_sz + PG_SHIFT_OFFSET);
-	roce_set_field(req->vf_srqc_cfg, CFG_BT_ATTR_DATA_1_VF_SRQC_BUF_PGSZ_M,
-		       CFG_BT_ATTR_DATA_1_VF_SRQC_BUF_PGSZ_S,
-		       hr_dev->caps.srqc_buf_pg_sz + PG_SHIFT_OFFSET);
-	roce_set_field(req->vf_srqc_cfg, CFG_BT_ATTR_DATA_1_VF_SRQC_HOPNUM_M,
-		       CFG_BT_ATTR_DATA_1_VF_SRQC_HOPNUM_S,
-		       srqc_hop_num == HNS_ROCE_HOP_NUM_0 ? 0 : srqc_hop_num);
-
-	roce_set_field(req->vf_cqc_cfg, CFG_BT_ATTR_DATA_2_VF_CQC_BA_PGSZ_M,
-		       CFG_BT_ATTR_DATA_2_VF_CQC_BA_PGSZ_S,
-		       hr_dev->caps.cqc_ba_pg_sz + PG_SHIFT_OFFSET);
-	roce_set_field(req->vf_cqc_cfg, CFG_BT_ATTR_DATA_2_VF_CQC_BUF_PGSZ_M,
-		       CFG_BT_ATTR_DATA_2_VF_CQC_BUF_PGSZ_S,
-		       hr_dev->caps.cqc_buf_pg_sz + PG_SHIFT_OFFSET);
-	roce_set_field(req->vf_cqc_cfg, CFG_BT_ATTR_DATA_2_VF_CQC_HOPNUM_M,
-		       CFG_BT_ATTR_DATA_2_VF_CQC_HOPNUM_S,
-		       cqc_hop_num == HNS_ROCE_HOP_NUM_0 ? 0 : cqc_hop_num);
-
-	roce_set_field(req->vf_mpt_cfg, CFG_BT_ATTR_DATA_3_VF_MPT_BA_PGSZ_M,
-		       CFG_BT_ATTR_DATA_3_VF_MPT_BA_PGSZ_S,
-		       hr_dev->caps.mpt_ba_pg_sz + PG_SHIFT_OFFSET);
-	roce_set_field(req->vf_mpt_cfg, CFG_BT_ATTR_DATA_3_VF_MPT_BUF_PGSZ_M,
-		       CFG_BT_ATTR_DATA_3_VF_MPT_BUF_PGSZ_S,
-		       hr_dev->caps.mpt_buf_pg_sz + PG_SHIFT_OFFSET);
-	roce_set_field(req->vf_mpt_cfg, CFG_BT_ATTR_DATA_3_VF_MPT_HOPNUM_M,
-		       CFG_BT_ATTR_DATA_3_VF_MPT_HOPNUM_S,
-		       mpt_hop_num == HNS_ROCE_HOP_NUM_0 ? 0 : mpt_hop_num);
-
-	roce_set_field(req->vf_sccc_cfg,
-		       CFG_BT_ATTR_DATA_4_VF_SCCC_BA_PGSZ_M,
-		       CFG_BT_ATTR_DATA_4_VF_SCCC_BA_PGSZ_S,
-		       hr_dev->caps.sccc_ba_pg_sz + PG_SHIFT_OFFSET);
-	roce_set_field(req->vf_sccc_cfg,
-		       CFG_BT_ATTR_DATA_4_VF_SCCC_BUF_PGSZ_M,
-		       CFG_BT_ATTR_DATA_4_VF_SCCC_BUF_PGSZ_S,
-		       hr_dev->caps.sccc_buf_pg_sz + PG_SHIFT_OFFSET);
-	roce_set_field(req->vf_sccc_cfg,
-		       CFG_BT_ATTR_DATA_4_VF_SCCC_HOPNUM_M,
-		       CFG_BT_ATTR_DATA_4_VF_SCCC_HOPNUM_S,
-		       sccc_hop_num ==
-			      HNS_ROCE_HOP_NUM_0 ? 0 : sccc_hop_num);
+	hr_reg_write(req, CFG_BT_ATTR_QPC_BA_PGSZ,
+		     caps->qpc_ba_pg_sz + PG_SHIFT_OFFSET);
+	hr_reg_write(req, CFG_BT_ATTR_QPC_BUF_PGSZ,
+		     caps->qpc_buf_pg_sz + PG_SHIFT_OFFSET);
+	hr_reg_write(req, CFG_BT_ATTR_QPC_HOPNUM,
+		     to_hr_hem_hopnum(caps->qpc_hop_num, caps->num_qps));
+
+	hr_reg_write(req, CFG_BT_ATTR_SRQC_BA_PGSZ,
+		     caps->srqc_ba_pg_sz + PG_SHIFT_OFFSET);
+	hr_reg_write(req, CFG_BT_ATTR_SRQC_BUF_PGSZ,
+		     caps->srqc_buf_pg_sz + PG_SHIFT_OFFSET);
+	hr_reg_write(req, CFG_BT_ATTR_SRQC_HOPNUM,
+		     to_hr_hem_hopnum(caps->srqc_hop_num, caps->num_srqs));
+
+	hr_reg_write(req, CFG_BT_ATTR_CQC_BA_PGSZ,
+		     caps->cqc_ba_pg_sz + PG_SHIFT_OFFSET);
+	hr_reg_write(req, CFG_BT_ATTR_CQC_BUF_PGSZ,
+		     caps->cqc_buf_pg_sz + PG_SHIFT_OFFSET);
+	hr_reg_write(req, CFG_BT_ATTR_CQC_HOPNUM,
+		     to_hr_hem_hopnum(caps->cqc_hop_num, caps->num_cqs));
+
+	hr_reg_write(req, CFG_BT_ATTR_MPT_BA_PGSZ,
+		     caps->mpt_ba_pg_sz + PG_SHIFT_OFFSET);
+	hr_reg_write(req, CFG_BT_ATTR_MPT_BUF_PGSZ,
+		     caps->mpt_buf_pg_sz + PG_SHIFT_OFFSET);
+	hr_reg_write(req, CFG_BT_ATTR_MPT_HOPNUM,
+		     to_hr_hem_hopnum(caps->mpt_hop_num, caps->num_mtpts));
+
+	hr_reg_write(req, CFG_BT_ATTR_SCCC_BA_PGSZ,
+		     caps->sccc_ba_pg_sz + PG_SHIFT_OFFSET);
+	hr_reg_write(req, CFG_BT_ATTR_SCCC_BUF_PGSZ,
+		     caps->sccc_buf_pg_sz + PG_SHIFT_OFFSET);
+	hr_reg_write(req, CFG_BT_ATTR_SCCC_HOPNUM,
+		     to_hr_hem_hopnum(caps->sccc_hop_num, caps->num_qps));
 
 	return hns_roce_cmq_send(hr_dev, &desc, 1);
 }
@@ -2276,50 +2251,37 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 	return 0;
 }
 
-static int hns_roce_config_qpc_size(struct hns_roce_dev *hr_dev)
+static int config_hem_entry_size(struct hns_roce_dev *hr_dev, u32 type, u32 val)
 {
 	struct hns_roce_cmq_desc desc;
-	struct hns_roce_cfg_entry_size *cfg_size =
-				  (struct hns_roce_cfg_entry_size *)desc.data;
+	struct hns_roce_cmq_req *req = (struct hns_roce_cmq_req *)desc.data;
 
 	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_CFG_ENTRY_SIZE,
 				      false);
 
-	cfg_size->type = cpu_to_le32(HNS_ROCE_CFG_QPC_SIZE);
-	cfg_size->size = cpu_to_le32(hr_dev->caps.qpc_sz);
-
-	return hns_roce_cmq_send(hr_dev, &desc, 1);
-}
-
-static int hns_roce_config_sccc_size(struct hns_roce_dev *hr_dev)
-{
-	struct hns_roce_cmq_desc desc;
-	struct hns_roce_cfg_entry_size *cfg_size =
-				  (struct hns_roce_cfg_entry_size *)desc.data;
-
-	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_CFG_ENTRY_SIZE,
-				      false);
-
-	cfg_size->type = cpu_to_le32(HNS_ROCE_CFG_SCCC_SIZE);
-	cfg_size->size = cpu_to_le32(hr_dev->caps.sccc_sz);
+	hr_reg_write(req, CFG_HEM_ENTRY_SIZE_TYPE, type);
+	hr_reg_write(req, CFG_HEM_ENTRY_SIZE_VALUE, val);
 
 	return hns_roce_cmq_send(hr_dev, &desc, 1);
 }
 
 static int hns_roce_config_entry_size(struct hns_roce_dev *hr_dev)
 {
+	struct hns_roce_caps *caps = &hr_dev->caps;
 	int ret;
 
 	if (hr_dev->pci_dev->revision < PCI_REVISION_ID_HIP09)
 		return 0;
 
-	ret = hns_roce_config_qpc_size(hr_dev);
+	ret = config_hem_entry_size(hr_dev, HNS_ROCE_CFG_QPC_SIZE,
+				    caps->qpc_sz);
 	if (ret) {
 		dev_err(hr_dev->dev, "failed to cfg qpc sz, ret = %d.\n", ret);
 		return ret;
 	}
 
-	ret = hns_roce_config_sccc_size(hr_dev);
+	ret = config_hem_entry_size(hr_dev, HNS_ROCE_CFG_SCCC_SIZE,
+				    caps->sccc_sz);
 	if (ret)
 		dev_err(hr_dev->dev, "failed to cfg sccc sz, ret = %d.\n", ret);
 
@@ -3834,16 +3796,15 @@ static int config_gmv_ba_to_hw(struct hns_roce_dev *hr_dev, unsigned long obj,
 			       dma_addr_t base_addr)
 {
 	struct hns_roce_cmq_desc desc;
-	struct hns_roce_cfg_gmv_bt *gmv_bt =
-				(struct hns_roce_cfg_gmv_bt *)desc.data;
+	struct hns_roce_cmq_req *req = (struct hns_roce_cmq_req *)desc.data;
+	u32 idx = obj / (HNS_HW_PAGE_SIZE / hr_dev->caps.gmv_entry_sz);
 	u64 addr = to_hr_hw_page_addr(base_addr);
 
 	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_CFG_GMV_BT, false);
 
-	gmv_bt->gmv_ba_l = cpu_to_le32(lower_32_bits(addr));
-	gmv_bt->gmv_ba_h = cpu_to_le32(upper_32_bits(addr));
-	gmv_bt->gmv_bt_idx = cpu_to_le32(obj /
-		(HNS_HW_PAGE_SIZE / hr_dev->caps.gmv_entry_sz));
+	hr_reg_write(req, CFG_GMV_BT_BA_L, lower_32_bits(addr));
+	hr_reg_write(req, CFG_GMV_BT_BA_H, upper_32_bits(addr));
+	hr_reg_write(req, CFG_GMV_BT_IDX, idx);
 
 	return hns_roce_cmq_send(hr_dev, &desc, 1);
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index e6a1138..d9a89ec 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -1595,59 +1595,36 @@ struct hns_roce_mbox_status {
 
 #define MB_ST_COMPLETE_SUCC 1
 
-struct hns_roce_cfg_bt_attr {
-	__le32 vf_qpc_cfg;
-	__le32 vf_srqc_cfg;
-	__le32 vf_cqc_cfg;
-	__le32 vf_mpt_cfg;
-	__le32 vf_sccc_cfg;
-	__le32 rsv;
+/* Fields of HNS_ROCE_OPC_CFG_BT_ATTR */
+#define CFG_BT_ATTR_QPC_BA_PGSZ CMQ_REQ_FIELD_LOC(3, 0)
+#define CFG_BT_ATTR_QPC_BUF_PGSZ CMQ_REQ_FIELD_LOC(7, 4)
+#define CFG_BT_ATTR_QPC_HOPNUM CMQ_REQ_FIELD_LOC(9, 8)
+#define CFG_BT_ATTR_SRQC_BA_PGSZ CMQ_REQ_FIELD_LOC(35, 32)
+#define CFG_BT_ATTR_SRQC_BUF_PGSZ CMQ_REQ_FIELD_LOC(39, 36)
+#define CFG_BT_ATTR_SRQC_HOPNUM CMQ_REQ_FIELD_LOC(41, 40)
+#define CFG_BT_ATTR_CQC_BA_PGSZ CMQ_REQ_FIELD_LOC(67, 64)
+#define CFG_BT_ATTR_CQC_BUF_PGSZ CMQ_REQ_FIELD_LOC(71, 68)
+#define CFG_BT_ATTR_CQC_HOPNUM CMQ_REQ_FIELD_LOC(73, 72)
+#define CFG_BT_ATTR_MPT_BA_PGSZ CMQ_REQ_FIELD_LOC(99, 96)
+#define CFG_BT_ATTR_MPT_BUF_PGSZ CMQ_REQ_FIELD_LOC(103, 100)
+#define CFG_BT_ATTR_MPT_HOPNUM CMQ_REQ_FIELD_LOC(105, 104)
+#define CFG_BT_ATTR_SCCC_BA_PGSZ CMQ_REQ_FIELD_LOC(131, 128)
+#define CFG_BT_ATTR_SCCC_BUF_PGSZ CMQ_REQ_FIELD_LOC(135, 132)
+#define CFG_BT_ATTR_SCCC_HOPNUM CMQ_REQ_FIELD_LOC(137, 136)
+
+/* Fields of HNS_ROCE_OPC_CFG_ENTRY_SIZE */
+#define CFG_HEM_ENTRY_SIZE_TYPE CMQ_REQ_FIELD_LOC(31, 0)
+enum {
+	HNS_ROCE_CFG_QPC_SIZE = BIT(0),
+	HNS_ROCE_CFG_SCCC_SIZE = BIT(1),
 };
 
-#define CFG_BT_ATTR_DATA_0_VF_QPC_BA_PGSZ_S 0
-#define CFG_BT_ATTR_DATA_0_VF_QPC_BA_PGSZ_M GENMASK(3, 0)
-
-#define CFG_BT_ATTR_DATA_0_VF_QPC_BUF_PGSZ_S 4
-#define CFG_BT_ATTR_DATA_0_VF_QPC_BUF_PGSZ_M GENMASK(7, 4)
-
-#define CFG_BT_ATTR_DATA_0_VF_QPC_HOPNUM_S 8
-#define CFG_BT_ATTR_DATA_0_VF_QPC_HOPNUM_M GENMASK(9, 8)
-
-#define CFG_BT_ATTR_DATA_1_VF_SRQC_BA_PGSZ_S 0
-#define CFG_BT_ATTR_DATA_1_VF_SRQC_BA_PGSZ_M GENMASK(3, 0)
-
-#define CFG_BT_ATTR_DATA_1_VF_SRQC_BUF_PGSZ_S 4
-#define CFG_BT_ATTR_DATA_1_VF_SRQC_BUF_PGSZ_M GENMASK(7, 4)
-
-#define CFG_BT_ATTR_DATA_1_VF_SRQC_HOPNUM_S 8
-#define CFG_BT_ATTR_DATA_1_VF_SRQC_HOPNUM_M GENMASK(9, 8)
-
-#define CFG_BT_ATTR_DATA_2_VF_CQC_BA_PGSZ_S 0
-#define CFG_BT_ATTR_DATA_2_VF_CQC_BA_PGSZ_M GENMASK(3, 0)
-
-#define CFG_BT_ATTR_DATA_2_VF_CQC_BUF_PGSZ_S 4
-#define CFG_BT_ATTR_DATA_2_VF_CQC_BUF_PGSZ_M GENMASK(7, 4)
-
-#define CFG_BT_ATTR_DATA_2_VF_CQC_HOPNUM_S 8
-#define CFG_BT_ATTR_DATA_2_VF_CQC_HOPNUM_M GENMASK(9, 8)
-
-#define CFG_BT_ATTR_DATA_3_VF_MPT_BA_PGSZ_S 0
-#define CFG_BT_ATTR_DATA_3_VF_MPT_BA_PGSZ_M GENMASK(3, 0)
-
-#define CFG_BT_ATTR_DATA_3_VF_MPT_BUF_PGSZ_S 4
-#define CFG_BT_ATTR_DATA_3_VF_MPT_BUF_PGSZ_M GENMASK(7, 4)
-
-#define CFG_BT_ATTR_DATA_3_VF_MPT_HOPNUM_S 8
-#define CFG_BT_ATTR_DATA_3_VF_MPT_HOPNUM_M GENMASK(9, 8)
-
-#define CFG_BT_ATTR_DATA_4_VF_SCCC_BA_PGSZ_S 0
-#define CFG_BT_ATTR_DATA_4_VF_SCCC_BA_PGSZ_M GENMASK(3, 0)
+#define CFG_HEM_ENTRY_SIZE_VALUE CMQ_REQ_FIELD_LOC(191, 160)
 
-#define CFG_BT_ATTR_DATA_4_VF_SCCC_BUF_PGSZ_S 4
-#define CFG_BT_ATTR_DATA_4_VF_SCCC_BUF_PGSZ_M GENMASK(7, 4)
-
-#define CFG_BT_ATTR_DATA_4_VF_SCCC_HOPNUM_S 8
-#define CFG_BT_ATTR_DATA_4_VF_SCCC_HOPNUM_M GENMASK(9, 8)
+/* Fields of HNS_ROCE_OPC_CFG_GMV_BT */
+#define CFG_GMV_BT_BA_L CMQ_REQ_FIELD_LOC(31, 0)
+#define CFG_GMV_BT_BA_H CMQ_REQ_FIELD_LOC(51, 32)
+#define CFG_GMV_BT_IDX CMQ_REQ_FIELD_LOC(95, 64)
 
 struct hns_roce_cfg_sgid_tb {
 	__le32	table_idx_rsv;
@@ -1658,17 +1635,6 @@ struct hns_roce_cfg_sgid_tb {
 	__le32	vf_sgid_type_rsv;
 };
 
-enum {
-	HNS_ROCE_CFG_QPC_SIZE = BIT(0),
-	HNS_ROCE_CFG_SCCC_SIZE = BIT(1),
-};
-
-struct hns_roce_cfg_entry_size {
-	__le32	type;
-	__le32	rsv[4];
-	__le32	size;
-};
-
 #define CFG_SGID_TB_TABLE_IDX_S 0
 #define CFG_SGID_TB_TABLE_IDX_M GENMASK(7, 0)
 
@@ -1687,16 +1653,6 @@ struct hns_roce_cfg_smac_tb {
 #define CFG_SMAC_TB_VF_SMAC_H_S 0
 #define CFG_SMAC_TB_VF_SMAC_H_M GENMASK(15, 0)
 
-struct hns_roce_cfg_gmv_bt {
-	__le32 gmv_ba_l;
-	__le32 gmv_ba_h;
-	__le32 gmv_bt_idx;
-	__le32 rsv[3];
-};
-
-#define CFG_GMV_BA_H_S 0
-#define CFG_GMV_BA_H_M GENMASK(19, 0)
-
 struct hns_roce_cfg_gmv_tb_a {
 	__le32 vf_sgid_l;
 	__le32 vf_sgid_ml;
@@ -1884,6 +1840,12 @@ struct hns_roce_query_pf_caps_e {
 #define V2_QUERY_PF_CAPS_E_RSV_LKEYS_S 0
 #define V2_QUERY_PF_CAPS_E_RSV_LKEYS_M GENMASK(19, 0)
 
+struct hns_roce_cmq_req {
+	__le32 data[6];
+};
+
+#define CMQ_REQ_FIELD_LOC(h, l) FIELD_LOC(struct hns_roce_cmq_req, h, l)
+
 struct hns_roce_cmq_desc {
 	__le16 opcode;
 	__le16 flag;
-- 
2.8.1

