Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02A2E18C5B8
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 04:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgCTD1g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 23:27:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35370 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726596AbgCTD1g (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Mar 2020 23:27:36 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 515B23AD6294C5B97AA3;
        Fri, 20 Mar 2020 11:27:32 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Fri, 20 Mar 2020 11:27:26 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 04/10] RDMA/hns: Optimize hns_roce_alloc_vf_resource()
Date:   Fri, 20 Mar 2020 11:23:36 +0800
Message-ID: <1584674622-52773-5-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1584674622-52773-1-git-send-email-liweihang@huawei.com>
References: <1584674622-52773-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lijun Ou <oulijun@huawei.com>

The capbilities of hardware should be got at first and then used in
hns_roce_alloc_vf_resource(). Also removes an unnecessary if ... else
condition in it.

Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 143 +++++++++++++----------------
 1 file changed, 62 insertions(+), 81 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 518a649..aff7c5d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1432,82 +1432,63 @@ static int hns_roce_alloc_vf_resource(struct hns_roce_dev *hr_dev)
 			desc[i].flag |= cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
 		else
 			desc[i].flag &= ~cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
-
-		if (i == 0) {
-			roce_set_field(req_a->vf_qpc_bt_idx_num,
-				       VF_RES_A_DATA_1_VF_QPC_BT_IDX_M,
-				       VF_RES_A_DATA_1_VF_QPC_BT_IDX_S, 0);
-			roce_set_field(req_a->vf_qpc_bt_idx_num,
-				       VF_RES_A_DATA_1_VF_QPC_BT_NUM_M,
-				       VF_RES_A_DATA_1_VF_QPC_BT_NUM_S,
-				       HNS_ROCE_VF_QPC_BT_NUM);
-
-			roce_set_field(req_a->vf_srqc_bt_idx_num,
-				       VF_RES_A_DATA_2_VF_SRQC_BT_IDX_M,
-				       VF_RES_A_DATA_2_VF_SRQC_BT_IDX_S, 0);
-			roce_set_field(req_a->vf_srqc_bt_idx_num,
-				       VF_RES_A_DATA_2_VF_SRQC_BT_NUM_M,
-				       VF_RES_A_DATA_2_VF_SRQC_BT_NUM_S,
-				       HNS_ROCE_VF_SRQC_BT_NUM);
-
-			roce_set_field(req_a->vf_cqc_bt_idx_num,
-				       VF_RES_A_DATA_3_VF_CQC_BT_IDX_M,
-				       VF_RES_A_DATA_3_VF_CQC_BT_IDX_S, 0);
-			roce_set_field(req_a->vf_cqc_bt_idx_num,
-				       VF_RES_A_DATA_3_VF_CQC_BT_NUM_M,
-				       VF_RES_A_DATA_3_VF_CQC_BT_NUM_S,
-				       HNS_ROCE_VF_CQC_BT_NUM);
-
-			roce_set_field(req_a->vf_mpt_bt_idx_num,
-				       VF_RES_A_DATA_4_VF_MPT_BT_IDX_M,
-				       VF_RES_A_DATA_4_VF_MPT_BT_IDX_S, 0);
-			roce_set_field(req_a->vf_mpt_bt_idx_num,
-				       VF_RES_A_DATA_4_VF_MPT_BT_NUM_M,
-				       VF_RES_A_DATA_4_VF_MPT_BT_NUM_S,
-				       HNS_ROCE_VF_MPT_BT_NUM);
-
-			roce_set_field(req_a->vf_eqc_bt_idx_num,
-				       VF_RES_A_DATA_5_VF_EQC_IDX_M,
-				       VF_RES_A_DATA_5_VF_EQC_IDX_S, 0);
-			roce_set_field(req_a->vf_eqc_bt_idx_num,
-				       VF_RES_A_DATA_5_VF_EQC_NUM_M,
-				       VF_RES_A_DATA_5_VF_EQC_NUM_S,
-				       HNS_ROCE_VF_EQC_NUM);
-		} else {
-			roce_set_field(req_b->vf_smac_idx_num,
-				       VF_RES_B_DATA_1_VF_SMAC_IDX_M,
-				       VF_RES_B_DATA_1_VF_SMAC_IDX_S, 0);
-			roce_set_field(req_b->vf_smac_idx_num,
-				       VF_RES_B_DATA_1_VF_SMAC_NUM_M,
-				       VF_RES_B_DATA_1_VF_SMAC_NUM_S,
-				       HNS_ROCE_VF_SMAC_NUM);
-
-			roce_set_field(req_b->vf_sgid_idx_num,
-				       VF_RES_B_DATA_2_VF_SGID_IDX_M,
-				       VF_RES_B_DATA_2_VF_SGID_IDX_S, 0);
-			roce_set_field(req_b->vf_sgid_idx_num,
-				       VF_RES_B_DATA_2_VF_SGID_NUM_M,
-				       VF_RES_B_DATA_2_VF_SGID_NUM_S,
-				       HNS_ROCE_VF_SGID_NUM);
-
-			roce_set_field(req_b->vf_qid_idx_sl_num,
-				       VF_RES_B_DATA_3_VF_QID_IDX_M,
-				       VF_RES_B_DATA_3_VF_QID_IDX_S, 0);
-			roce_set_field(req_b->vf_qid_idx_sl_num,
-				       VF_RES_B_DATA_3_VF_SL_NUM_M,
-				       VF_RES_B_DATA_3_VF_SL_NUM_S,
-				       HNS_ROCE_VF_SL_NUM);
-
-			roce_set_field(req_b->vf_sccc_idx_num,
-				       VF_RES_B_DATA_4_VF_SCCC_BT_IDX_M,
-				       VF_RES_B_DATA_4_VF_SCCC_BT_IDX_S, 0);
-			roce_set_field(req_b->vf_sccc_idx_num,
-				       VF_RES_B_DATA_4_VF_SCCC_BT_NUM_M,
-				       VF_RES_B_DATA_4_VF_SCCC_BT_NUM_S,
-				       HNS_ROCE_VF_SCCC_BT_NUM);
-		}
 	}
 
+	roce_set_field(req_a->vf_qpc_bt_idx_num,
+		       VF_RES_A_DATA_1_VF_QPC_BT_IDX_M,
+		       VF_RES_A_DATA_1_VF_QPC_BT_IDX_S, 0);
+	roce_set_field(req_a->vf_qpc_bt_idx_num,
+		       VF_RES_A_DATA_1_VF_QPC_BT_NUM_M,
+		       VF_RES_A_DATA_1_VF_QPC_BT_NUM_S, HNS_ROCE_VF_QPC_BT_NUM);
+
+	roce_set_field(req_a->vf_srqc_bt_idx_num,
+		       VF_RES_A_DATA_2_VF_SRQC_BT_IDX_M,
+		       VF_RES_A_DATA_2_VF_SRQC_BT_IDX_S, 0);
+	roce_set_field(req_a->vf_srqc_bt_idx_num,
+		       VF_RES_A_DATA_2_VF_SRQC_BT_NUM_M,
+		       VF_RES_A_DATA_2_VF_SRQC_BT_NUM_S,
+		       HNS_ROCE_VF_SRQC_BT_NUM);
+
+	roce_set_field(req_a->vf_cqc_bt_idx_num,
+		       VF_RES_A_DATA_3_VF_CQC_BT_IDX_M,
+		       VF_RES_A_DATA_3_VF_CQC_BT_IDX_S, 0);
+	roce_set_field(req_a->vf_cqc_bt_idx_num,
+		       VF_RES_A_DATA_3_VF_CQC_BT_NUM_M,
+		       VF_RES_A_DATA_3_VF_CQC_BT_NUM_S, HNS_ROCE_VF_CQC_BT_NUM);
+
+	roce_set_field(req_a->vf_mpt_bt_idx_num,
+		       VF_RES_A_DATA_4_VF_MPT_BT_IDX_M,
+		       VF_RES_A_DATA_4_VF_MPT_BT_IDX_S, 0);
+	roce_set_field(req_a->vf_mpt_bt_idx_num,
+		       VF_RES_A_DATA_4_VF_MPT_BT_NUM_M,
+		       VF_RES_A_DATA_4_VF_MPT_BT_NUM_S, HNS_ROCE_VF_MPT_BT_NUM);
+
+	roce_set_field(req_a->vf_eqc_bt_idx_num, VF_RES_A_DATA_5_VF_EQC_IDX_M,
+		       VF_RES_A_DATA_5_VF_EQC_IDX_S, 0);
+	roce_set_field(req_a->vf_eqc_bt_idx_num, VF_RES_A_DATA_5_VF_EQC_NUM_M,
+		       VF_RES_A_DATA_5_VF_EQC_NUM_S, HNS_ROCE_VF_EQC_NUM);
+
+	roce_set_field(req_b->vf_smac_idx_num, VF_RES_B_DATA_1_VF_SMAC_IDX_M,
+		       VF_RES_B_DATA_1_VF_SMAC_IDX_S, 0);
+	roce_set_field(req_b->vf_smac_idx_num, VF_RES_B_DATA_1_VF_SMAC_NUM_M,
+		       VF_RES_B_DATA_1_VF_SMAC_NUM_S, HNS_ROCE_VF_SMAC_NUM);
+
+	roce_set_field(req_b->vf_sgid_idx_num, VF_RES_B_DATA_2_VF_SGID_IDX_M,
+		       VF_RES_B_DATA_2_VF_SGID_IDX_S, 0);
+	roce_set_field(req_b->vf_sgid_idx_num, VF_RES_B_DATA_2_VF_SGID_NUM_M,
+		       VF_RES_B_DATA_2_VF_SGID_NUM_S, HNS_ROCE_VF_SGID_NUM);
+
+	roce_set_field(req_b->vf_qid_idx_sl_num, VF_RES_B_DATA_3_VF_QID_IDX_M,
+		       VF_RES_B_DATA_3_VF_QID_IDX_S, 0);
+	roce_set_field(req_b->vf_qid_idx_sl_num, VF_RES_B_DATA_3_VF_SL_NUM_M,
+		       VF_RES_B_DATA_3_VF_SL_NUM_S, HNS_ROCE_VF_SL_NUM);
+
+	roce_set_field(req_b->vf_sccc_idx_num, VF_RES_B_DATA_4_VF_SCCC_BT_IDX_M,
+		       VF_RES_B_DATA_4_VF_SCCC_BT_IDX_S, 0);
+	roce_set_field(req_b->vf_sccc_idx_num, VF_RES_B_DATA_4_VF_SCCC_BT_NUM_M,
+		       VF_RES_B_DATA_4_VF_SCCC_BT_NUM_S,
+		       HNS_ROCE_VF_SCCC_BT_NUM);
+
 	return hns_roce_cmq_send(hr_dev, desc, 2);
 }
 
@@ -2001,13 +1982,6 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
 		}
 	}
 
-	ret = hns_roce_alloc_vf_resource(hr_dev);
-	if (ret) {
-		dev_err(hr_dev->dev, "Allocate vf resource fail, ret = %d.\n",
-			ret);
-		return ret;
-	}
-
 	hr_dev->vendor_part_id = hr_dev->pci_dev->device;
 	hr_dev->sys_image_guid = be64_to_cpu(hr_dev->ib_dev.node_guid);
 
@@ -2028,6 +2002,13 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
 	if (ret)
 		set_default_caps(hr_dev);
 
+	ret = hns_roce_alloc_vf_resource(hr_dev);
+	if (ret) {
+		dev_err(hr_dev->dev, "Allocate vf resource fail, ret = %d.\n",
+			ret);
+		return ret;
+	}
+
 	ret = hns_roce_v2_set_bt(hr_dev);
 	if (ret)
 		dev_err(hr_dev->dev, "Configure bt attribute fail, ret = %d.\n",
-- 
2.8.1

