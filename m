Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99953527B8
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Apr 2021 11:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhDBJA7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Apr 2021 05:00:59 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16329 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbhDBJA6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Apr 2021 05:00:58 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FBYr860SCz9vsZ;
        Fri,  2 Apr 2021 16:58:48 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Fri, 2 Apr 2021 17:00:47 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Wei Xu <xuwei5@hisilicon.com>,
        Shengming Shu <shushengming1@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 3/6] RDMA/hns: Reserve the resource for the VFs
Date:   Fri, 2 Apr 2021 16:58:13 +0800
Message-ID: <1617353896-40727-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617353896-40727-1-git-send-email-liweihang@huawei.com>
References: <1617353896-40727-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wei Xu <xuwei5@hisilicon.com>

Query the resource including EQC/SMAC/SGID from the firmware in the PF
and distribute fairly among all the functions belong to the PF.

Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Shengming Shu <shushengming1@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  3 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 83 ++++++++++++++++++++---------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  2 -
 3 files changed, 60 insertions(+), 28 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 3a5378e..37d6f01 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -809,6 +809,9 @@ struct hns_roce_caps {
 	u32		cqc_bt_num;
 	u32		cqc_timer_bt_num;
 	u32		mpt_bt_num;
+	u32		eqc_bt_num;
+	u32		smac_bt_num;
+	u32		sgid_bt_num;
 	u32		sccc_bt_num;
 	u32		gmv_bt_num;
 	u32		qpc_ba_pg_sz;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 5c0d341..4cc08aa 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1647,8 +1647,10 @@ static int hns_roce_query_pf_resource(struct hns_roce_dev *hr_dev)
 	struct hns_roce_cmq_req *r_b = (struct hns_roce_cmq_req *)desc[1].data;
 	enum hns_roce_opcode_type opcode = HNS_ROCE_OPC_QUERY_PF_RES;
 	struct hns_roce_caps *caps = &hr_dev->caps;
+	u32 func_num;
 	int ret;
 
+	func_num = hr_dev->func_num ? hr_dev->func_num : 1;
 	hns_roce_cmq_setup_basic_desc(&desc[0], opcode, true);
 	desc[0].flag |= cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
 	hns_roce_cmq_setup_basic_desc(&desc[1], opcode, true);
@@ -1657,13 +1659,16 @@ static int hns_roce_query_pf_resource(struct hns_roce_dev *hr_dev)
 	if (ret)
 		return ret;
 
-	caps->qpc_bt_num = hr_reg_read(r_a, FUNC_RES_A_QPC_BT_NUM);
-	caps->srqc_bt_num = hr_reg_read(r_a, FUNC_RES_A_SRQC_BT_NUM);
-	caps->cqc_bt_num = hr_reg_read(r_a, FUNC_RES_A_CQC_BT_NUM);
-	caps->mpt_bt_num = hr_reg_read(r_a, FUNC_RES_A_MPT_BT_NUM);
-	caps->sccc_bt_num = hr_reg_read(r_b, FUNC_RES_B_SCCC_BT_NUM);
-	caps->sl_num = hr_reg_read(r_b, FUNC_RES_B_QID_NUM);
-	caps->gmv_bt_num = hr_reg_read(r_b, FUNC_RES_B_GMV_BT_NUM);
+	caps->qpc_bt_num = hr_reg_read(r_a, FUNC_RES_A_QPC_BT_NUM) / func_num;
+	caps->srqc_bt_num = hr_reg_read(r_a, FUNC_RES_A_SRQC_BT_NUM) / func_num;
+	caps->cqc_bt_num = hr_reg_read(r_a, FUNC_RES_A_CQC_BT_NUM) / func_num;
+	caps->mpt_bt_num = hr_reg_read(r_a, FUNC_RES_A_MPT_BT_NUM) / func_num;
+	caps->eqc_bt_num = hr_reg_read(r_a, FUNC_RES_A_EQC_BT_NUM) / func_num;
+	caps->smac_bt_num = hr_reg_read(r_b, FUNC_RES_B_SMAC_NUM) / func_num;
+	caps->sgid_bt_num = hr_reg_read(r_b, FUNC_RES_B_SGID_NUM) / func_num;
+	caps->sccc_bt_num = hr_reg_read(r_b, FUNC_RES_B_SCCC_BT_NUM) / func_num;
+	caps->sl_num = hr_reg_read(r_b, FUNC_RES_B_QID_NUM) / func_num;
+	caps->gmv_bt_num = hr_reg_read(r_b, FUNC_RES_B_GMV_BT_NUM) / func_num;
 
 	return 0;
 }
@@ -1713,39 +1718,65 @@ static int hns_roce_set_vf_switch_param(struct hns_roce_dev *hr_dev, int vf_id)
 	return hns_roce_cmq_send(hr_dev, &desc, 1);
 }
 
-static int hns_roce_alloc_vf_resource(struct hns_roce_dev *hr_dev)
+static int __hns_roce_alloc_vf_resource(struct hns_roce_dev *hr_dev, int vf_id)
 {
 	struct hns_roce_cmq_desc desc[2];
 	struct hns_roce_cmq_req *r_a = (struct hns_roce_cmq_req *)desc[0].data;
 	struct hns_roce_cmq_req *r_b = (struct hns_roce_cmq_req *)desc[1].data;
 	enum hns_roce_opcode_type opcode = HNS_ROCE_OPC_ALLOC_VF_RES;
+	struct hns_roce_caps *caps = &hr_dev->caps;
 
 	hns_roce_cmq_setup_basic_desc(&desc[0], opcode, false);
 	desc[0].flag |= cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
 	hns_roce_cmq_setup_basic_desc(&desc[1], opcode, false);
 
-	hr_reg_write(r_a, FUNC_RES_A_QPC_BT_NUM, HNS_ROCE_VF_QPC_BT_NUM);
-	hr_reg_write(r_a, FUNC_RES_A_QPC_BT_IDX, 0);
-	hr_reg_write(r_a, FUNC_RES_A_SRQC_BT_NUM, HNS_ROCE_VF_SRQC_BT_NUM);
-	hr_reg_write(r_a, FUNC_RES_A_SRQC_BT_IDX, 0);
-	hr_reg_write(r_a, FUNC_RES_A_CQC_BT_NUM, HNS_ROCE_VF_CQC_BT_NUM);
-	hr_reg_write(r_a, FUNC_RES_A_CQC_BT_IDX, 0);
-	hr_reg_write(r_a, FUNC_RES_A_MPT_BT_NUM, HNS_ROCE_VF_MPT_BT_NUM);
-	hr_reg_write(r_a, FUNC_RES_A_MPT_BT_IDX, 0);
-	hr_reg_write(r_a, FUNC_RES_A_EQC_BT_NUM, HNS_ROCE_VF_EQC_NUM);
-	hr_reg_write(r_a, FUNC_RES_A_EQC_BT_IDX, 0);
-	hr_reg_write(r_b, FUNC_RES_B_SMAC_NUM, HNS_ROCE_VF_SMAC_NUM);
-	hr_reg_write(r_b, FUNC_RES_B_SMAC_IDX, 0);
-	hr_reg_write(r_b, FUNC_RES_B_SGID_NUM, HNS_ROCE_VF_SGID_NUM);
-	hr_reg_write(r_b, FUNC_RES_B_SGID_IDX, 0);
-	hr_reg_write(r_b, FUNC_RES_V_QID_NUM, HNS_ROCE_VF_SL_NUM);
-	hr_reg_write(r_b, FUNC_RES_B_QID_IDX, 0);
-	hr_reg_write(r_b, FUNC_RES_B_SCCC_BT_NUM, HNS_ROCE_VF_SCCC_BT_NUM);
-	hr_reg_write(r_b, FUNC_RES_B_SCCC_BT_IDX, 0);
+	hr_reg_write(r_a, FUNC_RES_A_VF_ID, vf_id);
+
+	hr_reg_write(r_a, FUNC_RES_A_QPC_BT_NUM, caps->qpc_bt_num);
+	hr_reg_write(r_a, FUNC_RES_A_QPC_BT_IDX, vf_id * caps->qpc_bt_num);
+	hr_reg_write(r_a, FUNC_RES_A_SRQC_BT_NUM, caps->srqc_bt_num);
+	hr_reg_write(r_a, FUNC_RES_A_SRQC_BT_IDX, vf_id * caps->srqc_bt_num);
+	hr_reg_write(r_a, FUNC_RES_A_CQC_BT_NUM, caps->cqc_bt_num);
+	hr_reg_write(r_a, FUNC_RES_A_CQC_BT_IDX, vf_id * caps->cqc_bt_num);
+	hr_reg_write(r_a, FUNC_RES_A_MPT_BT_NUM, caps->mpt_bt_num);
+	hr_reg_write(r_a, FUNC_RES_A_MPT_BT_IDX, vf_id * caps->mpt_bt_num);
+	hr_reg_write(r_a, FUNC_RES_A_EQC_BT_NUM, caps->eqc_bt_num);
+	hr_reg_write(r_a, FUNC_RES_A_EQC_BT_IDX, vf_id * caps->eqc_bt_num);
+	hr_reg_write(r_b, FUNC_RES_V_QID_NUM, caps->sl_num);
+	hr_reg_write(r_b, FUNC_RES_B_QID_IDX, vf_id * caps->sl_num);
+	hr_reg_write(r_b, FUNC_RES_B_SCCC_BT_NUM, caps->sccc_bt_num);
+	hr_reg_write(r_b, FUNC_RES_B_SCCC_BT_IDX, vf_id * caps->sccc_bt_num);
+
+	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09) {
+		hr_reg_write(r_b, FUNC_RES_V_GMV_BT_NUM, caps->gmv_bt_num);
+		hr_reg_write(r_b, FUNC_RES_B_GMV_BT_IDX,
+			     vf_id * caps->gmv_bt_num);
+	} else {
+		hr_reg_write(r_b, FUNC_RES_B_SGID_NUM, caps->sgid_bt_num);
+		hr_reg_write(r_b, FUNC_RES_B_SGID_IDX,
+			     vf_id * caps->sgid_bt_num);
+		hr_reg_write(r_b, FUNC_RES_B_SMAC_NUM, caps->smac_bt_num);
+		hr_reg_write(r_b, FUNC_RES_B_SMAC_IDX,
+			     vf_id * caps->smac_bt_num);
+	}
 
 	return hns_roce_cmq_send(hr_dev, desc, 2);
 }
 
+static int hns_roce_alloc_vf_resource(struct hns_roce_dev *hr_dev)
+{
+	int vf_id;
+	int ret;
+
+	for (vf_id = 0; vf_id < hr_dev->func_num; vf_id++) {
+		ret = __hns_roce_alloc_vf_resource(hr_dev, vf_id);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int hns_roce_v2_set_bt(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_cmq_desc desc;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 535587f..efd33ae 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -40,9 +40,7 @@
 #define HNS_ROCE_VF_SRQC_BT_NUM			64
 #define HNS_ROCE_VF_CQC_BT_NUM			64
 #define HNS_ROCE_VF_MPT_BT_NUM			64
-#define HNS_ROCE_VF_EQC_NUM			64
 #define HNS_ROCE_VF_SMAC_NUM			32
-#define HNS_ROCE_VF_SGID_NUM			32
 #define HNS_ROCE_VF_SL_NUM			8
 #define HNS_ROCE_VF_GMV_BT_NUM			256
 
-- 
2.8.1

