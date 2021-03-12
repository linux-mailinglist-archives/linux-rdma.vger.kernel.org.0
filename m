Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33D433893F
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Mar 2021 10:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbhCLJvL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Mar 2021 04:51:11 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:13911 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbhCLJuy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Mar 2021 04:50:54 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DxgyB3c8ZzkY4M;
        Fri, 12 Mar 2021 17:49:22 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Fri, 12 Mar 2021 17:50:47 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next 1/2] RDMA/hns: Support query information of functions from FW
Date:   Fri, 12 Mar 2021 17:48:26 +0800
Message-ID: <1615542507-40018-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1615542507-40018-1-git-send-email-liweihang@huawei.com>
References: <1615542507-40018-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wei Xu <xuwei5@hisilicon.com>

Add a new type of command to query mac id of functions from the firmware,
it is used to select the template of congestion algorithm. More info will
be supported in the future.

Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Shengming Shu <shushengming1@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 28 ++++++++++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  7 +++++++
 3 files changed, 36 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 1a95fb7..869548e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1001,6 +1001,7 @@ struct hns_roce_dev {
 	void			*priv;
 	struct workqueue_struct *irq_workq;
 	const struct hns_roce_dfx_hw *dfx;
+	u32 cong_algo_tmpl_id;
 };
 
 static inline struct hns_roce_dev *to_hr_dev(struct ib_device *ib_dev)
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 8f73d006..816006d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1537,6 +1537,27 @@ static int hns_roce_query_fw_ver(struct hns_roce_dev *hr_dev)
 	return 0;
 }
 
+static int hns_roce_query_func_info(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_pf_func_info *resp;
+	struct hns_roce_cmq_desc desc;
+	int ret;
+
+	if (hr_dev->pci_dev->revision < PCI_REVISION_ID_HIP09)
+		return 0;
+
+	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_QUERY_FUNC_INFO,
+				      true);
+	ret = hns_roce_cmq_send(hr_dev, &desc, 1);
+	if (ret)
+		return ret;
+
+	resp = (struct hns_roce_pf_func_info *)desc.data;
+	hr_dev->cong_algo_tmpl_id = le32_to_cpu(resp->own_mac_id);
+
+	return 0;
+}
+
 static int hns_roce_config_global_param(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_cfg_global_param *req;
@@ -2279,6 +2300,13 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
 		return ret;
 	}
 
+	ret = hns_roce_query_func_info(hr_dev);
+	if (ret) {
+		dev_err(hr_dev->dev, "Query function info fail, ret = %d.\n",
+			ret);
+		return ret;
+	}
+
 	ret = hns_roce_config_global_param(hr_dev);
 	if (ret) {
 		dev_err(hr_dev->dev, "Configure global param fail, ret = %d.\n",
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index ffdae15..74a1c15 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -235,6 +235,7 @@ enum hns_roce_opcode_type {
 	HNS_ROCE_OPC_CFG_EXT_LLM			= 0x8403,
 	HNS_ROCE_OPC_CFG_TMOUT_LLM			= 0x8404,
 	HNS_ROCE_OPC_QUERY_PF_TIMER_RES			= 0x8406,
+	HNS_ROCE_OPC_QUERY_FUNC_INFO			= 0x8407,
 	HNS_ROCE_OPC_QUERY_PF_CAPS_NUM                  = 0x8408,
 	HNS_ROCE_OPC_CFG_ENTRY_SIZE			= 0x8409,
 	HNS_ROCE_OPC_CFG_SGID_TB			= 0x8500,
@@ -1469,6 +1470,12 @@ struct hns_roce_pf_timer_res_a {
 #define PF_RES_DATA_2_PF_CQC_TIMER_BT_NUM_S 16
 #define PF_RES_DATA_2_PF_CQC_TIMER_BT_NUM_M GENMASK(27, 16)
 
+struct hns_roce_pf_func_info {
+	__le32 rsv1;
+	__le32 own_mac_id;
+	__le32 rsv2[4];
+};
+
 struct hns_roce_vf_res_a {
 	__le32 vf_id;
 	__le32 vf_qpc_bt_idx_num;
-- 
2.8.1

