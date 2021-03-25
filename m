Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B33A34932A
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 14:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhCYNgm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 09:36:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14543 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbhCYNgf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Mar 2021 09:36:35 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F5mKH21yNzPlB0;
        Thu, 25 Mar 2021 21:33:55 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Mar 2021 21:36:22 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 1/2] RDMA/hns: Support query information of functions from FW
Date:   Thu, 25 Mar 2021 21:33:55 +0800
Message-ID: <1616679236-7795-2-git-send-email-liweihang@huawei.com>
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

From: Wei Xu <xuwei5@hisilicon.com>

Add a new type of command to query mac id of functions from the firmware,
it is used to select the template of congestion algorithm. More info will
be supported in the future.

Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Shengming Shu <shushengming1@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 26 ++++++++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 11 ++++++++++-
 3 files changed, 37 insertions(+), 1 deletion(-)

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
index 8f73d006..a3ea34c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1537,6 +1537,25 @@ static int hns_roce_query_fw_ver(struct hns_roce_dev *hr_dev)
 	return 0;
 }
 
+static int hns_roce_query_func_info(struct hns_roce_dev *hr_dev)
+{
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
+	hr_dev->cong_algo_tmpl_id = le32_to_cpu(desc.func_info.own_mac_id);
+
+	return 0;
+}
+
 static int hns_roce_config_global_param(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_cfg_global_param *req;
@@ -2279,6 +2298,13 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
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
index ffdae15..aa87b1c 100644
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
@@ -1866,7 +1867,15 @@ struct hns_roce_cmq_desc {
 	__le16 flag;
 	__le16 retval;
 	__le16 rsv;
-	__le32 data[6];
+	union {
+		__le32 data[6];
+		struct {
+			__le32 rsv1;
+			__le32 own_mac_id;
+			__le32 rsv2[4];
+		} func_info;
+	};
+
 };
 
 #define HNS_ROCE_V2_GO_BIT_TIMEOUT_MSECS	10000
-- 
2.8.1

