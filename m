Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F83974FEF3
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jul 2023 08:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjGLGDT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jul 2023 02:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjGLGDS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jul 2023 02:03:18 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E724F1BD5;
        Tue, 11 Jul 2023 23:03:04 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R16Y6074hzPkG3;
        Wed, 12 Jul 2023 14:00:41 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 14:03:01 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-rc 3/3] RDMA/hns: Add check and adjust for function resource values
Date:   Wed, 12 Jul 2023 14:00:33 +0800
Message-ID: <20230712060033.15961-4-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230712060033.15961-1-huangjunxian6@hisilicon.com>
References: <20230712060033.15961-1-huangjunxian6@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently, RoCE driver gets function resource values from firmware
without validity check. As these resources are mostly related to memory,
an invalid value may lead to serious consequence such as kernel panic.

This patch adds check for these resource values and adjusts the invalid
ones.

Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 116 ++++++++++++++++++++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  37 +++++++
 2 files changed, 149 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index c4b92d8bd98a..dae0e6959fa0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1650,6 +1650,98 @@ static int hns_roce_config_global_param(struct hns_roce_dev *hr_dev)
 	return hns_roce_cmq_send(hr_dev, &desc, 1);
 }
 
+static const struct hns_roce_bt_num {
+	u32 res_offset;
+	u32 min;
+	u32 max;
+	enum hns_roce_res_invalid_flag invalid_flag;
+	enum hns_roce_res_revision revision;
+	bool vf_support;
+} bt_num_table[] = {
+	{RES_OFFSET_IN_CAPS(qpc_bt_num), 1,
+	 MAX_QPC_BT_NUM, QPC_BT_NUM_INVALID_FLAG, RES_FOR_ALL, true},
+	{RES_OFFSET_IN_CAPS(srqc_bt_num), 1,
+	 MAX_SRQC_BT_NUM, SRQC_BT_NUM_INVALID_FLAG, RES_FOR_ALL, true},
+	{RES_OFFSET_IN_CAPS(cqc_bt_num), 1,
+	 MAX_CQC_BT_NUM, CQC_BT_NUM_INVALID_FLAG, RES_FOR_ALL, true},
+	{RES_OFFSET_IN_CAPS(mpt_bt_num), 1,
+	 MAX_MPT_BT_NUM, MPT_BT_NUM_INVALID_FLAG, RES_FOR_ALL, true},
+	{RES_OFFSET_IN_CAPS(sl_num), 1,
+	 MAX_SL_NUM, QID_NUM_INVALID_FLAG, RES_FOR_ALL, true},
+	{RES_OFFSET_IN_CAPS(sccc_bt_num), 1,
+	 MAX_SCCC_BT_NUM, SCCC_BT_NUM_INVALID_FLAG, RES_FOR_ALL, true},
+	{RES_OFFSET_IN_CAPS(qpc_timer_bt_num), 1,
+	 MAX_QPC_TIMER_BT_NUM, QPC_TIMER_BT_NUM_INVALID_FLAG,
+	 RES_FOR_ALL, false},
+	{RES_OFFSET_IN_CAPS(cqc_timer_bt_num), 1,
+	 MAX_CQC_TIMER_BT_NUM, CQC_TIMER_BT_NUM_INVALID_FLAG,
+	 RES_FOR_ALL, false},
+	{RES_OFFSET_IN_CAPS(gmv_bt_num), 1,
+	 MAX_GMV_BT_NUM, GMV_BT_NUM_INVALID_FLAG,
+	 RES_FOR_HIP09, true},
+	{RES_OFFSET_IN_CAPS(smac_bt_num), 1,
+	 MAX_SMAC_BT_NUM, SMAC_BT_NUM_INVALID_FLAG,
+	 RES_FOR_HIP08, true},
+	{RES_OFFSET_IN_CAPS(sgid_bt_num), 1,
+	 MAX_SGID_BT_NUM, SGID_BT_NUM_INVALID_FLAG,
+	 RES_FOR_HIP08, true},
+};
+
+static inline bool check_res_is_supported(struct hns_roce_dev *hr_dev,
+					  struct hns_roce_bt_num *bt_num_entry)
+{
+	if (!bt_num_entry->vf_support && hr_dev->is_vf)
+		return false;
+
+	if (bt_num_entry->revision == RES_FOR_HIP09 &&
+	    hr_dev->pci_dev->revision <= PCI_REVISION_ID_HIP08)
+		return false;
+
+	if (bt_num_entry->revision == RES_FOR_HIP08 &&
+	    hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)
+		return false;
+
+	return true;
+}
+
+static inline void adjust_eqc_bt_num(struct hns_roce_caps *caps,
+				     u16 *invalid_flag)
+{
+	if (caps->eqc_bt_num < caps->num_comp_vectors + caps->num_aeq_vectors ||
+	    caps->eqc_bt_num > MAX_EQC_BT_NUM) {
+		caps->eqc_bt_num = caps->eqc_bt_num > MAX_EQC_BT_NUM ?
+				   MAX_EQC_BT_NUM : caps->num_comp_vectors +
+						    caps->num_aeq_vectors;
+		*invalid_flag |= 1 << EQC_BT_NUM_INVALID_FLAG;
+	}
+}
+
+static u16 adjust_res_caps(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_caps *caps = &hr_dev->caps;
+	u16 invalid_flag = 0;
+	u32 min, max;
+	u32 *res;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(bt_num_table); i++) {
+		if (!check_res_is_supported(hr_dev, &bt_num_table[i]))
+			continue;
+
+		res = (u32 *)((void *)caps + bt_num_table[i].res_offset);
+		min = bt_num_table[i].min;
+		max = bt_num_table[i].max;
+		if (*res < min || *res > max) {
+			*res = *res < min ? min : max;
+			invalid_flag |= 1 << bt_num_table[i].invalid_flag;
+		}
+	}
+
+	adjust_eqc_bt_num(caps, &invalid_flag);
+
+	return invalid_flag;
+}
+
 static int load_func_res_caps(struct hns_roce_dev *hr_dev, bool is_vf)
 {
 	struct hns_roce_cmq_desc desc[2];
@@ -1730,11 +1822,19 @@ static int hns_roce_query_pf_resource(struct hns_roce_dev *hr_dev)
 	}
 
 	ret = load_pf_timer_res_caps(hr_dev);
-	if (ret)
+	if (ret) {
 		dev_err(dev, "failed to load pf timer resource, ret = %d.\n",
 			ret);
+		return ret;
+	}
 
-	return ret;
+	ret = adjust_res_caps(hr_dev);
+	if (ret)
+		dev_warn(dev,
+			 "invalid resource values have been adjusted, invalid_flag = 0x%x.\n",
+			 ret);
+
+	return 0;
 }
 
 static int hns_roce_query_vf_resource(struct hns_roce_dev *hr_dev)
@@ -1743,10 +1843,18 @@ static int hns_roce_query_vf_resource(struct hns_roce_dev *hr_dev)
 	int ret;
 
 	ret = load_func_res_caps(hr_dev, true);
-	if (ret)
+	if (ret) {
 		dev_err(dev, "failed to load vf res caps, ret = %d.\n", ret);
+		return ret;
+	}
 
-	return ret;
+	ret = adjust_res_caps(hr_dev);
+	if (ret)
+		dev_warn(dev,
+			 "invalid resource values have been adjusted, invalid_flag = 0x%x.\n",
+			 ret);
+
+	return 0;
 }
 
 static int __hns_roce_set_vf_switch_param(struct hns_roce_dev *hr_dev,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index d9693f6cc802..c2d46383c88c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -972,6 +972,43 @@ struct hns_roce_func_clear {
 #define CFG_GLOBAL_PARAM_1US_CYCLES CMQ_REQ_FIELD_LOC(9, 0)
 #define CFG_GLOBAL_PARAM_UDP_PORT CMQ_REQ_FIELD_LOC(31, 16)
 
+enum hns_roce_res_invalid_flag {
+	QPC_BT_NUM_INVALID_FLAG,
+	SRQC_BT_NUM_INVALID_FLAG,
+	CQC_BT_NUM_INVALID_FLAG,
+	MPT_BT_NUM_INVALID_FLAG,
+	EQC_BT_NUM_INVALID_FLAG,
+	SMAC_BT_NUM_INVALID_FLAG,
+	SGID_BT_NUM_INVALID_FLAG,
+	QID_NUM_INVALID_FLAG,
+	SCCC_BT_NUM_INVALID_FLAG,
+	GMV_BT_NUM_INVALID_FLAG,
+	QPC_TIMER_BT_NUM_INVALID_FLAG,
+	CQC_TIMER_BT_NUM_INVALID_FLAG,
+};
+
+enum hns_roce_res_revision {
+	RES_FOR_HIP08,
+	RES_FOR_HIP09,
+	RES_FOR_ALL,
+};
+
+#define RES_OFFSET_IN_CAPS(res) \
+	(offsetof(struct hns_roce_caps, res))
+
+#define MAX_QPC_BT_NUM 2048
+#define MAX_SRQC_BT_NUM 512
+#define MAX_CQC_BT_NUM 512
+#define MAX_MPT_BT_NUM 512
+#define MAX_EQC_BT_NUM 512
+#define MAX_SMAC_BT_NUM 256
+#define MAX_SGID_BT_NUM 256
+#define MAX_SL_NUM 8
+#define MAX_SCCC_BT_NUM 512
+#define MAX_GMV_BT_NUM 256
+#define MAX_QPC_TIMER_BT_NUM 1728
+#define MAX_CQC_TIMER_BT_NUM 1600
+
 /*
  * Fields of HNS_ROCE_OPC_QUERY_PF_RES, HNS_ROCE_OPC_QUERY_VF_RES
  * and HNS_ROCE_OPC_ALLOC_VF_RES
-- 
2.30.0

