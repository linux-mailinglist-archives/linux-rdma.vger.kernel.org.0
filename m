Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7738674FEF6
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jul 2023 08:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjGLGDV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jul 2023 02:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjGLGDR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jul 2023 02:03:17 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040B5E49;
        Tue, 11 Jul 2023 23:03:03 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R16b63k2DzrRhZ;
        Wed, 12 Jul 2023 14:02:26 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 14:03:01 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-rc 2/3] RDMA/hns: Remove VF extend configuration
Date:   Wed, 12 Jul 2023 14:00:32 +0800
Message-ID: <20230712060033.15961-3-huangjunxian6@hisilicon.com>
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove VF extend configuration since the relative registers are
configured in firmware currently.

Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  1 -
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 84 +++------------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 10 ---
 3 files changed, 10 insertions(+), 85 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 84239b907de2..6084c1649000 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -714,7 +714,6 @@ struct hns_roce_caps {
 	u32		max_rq_sg;
 	u32		rsv0;
 	u32		num_qps;
-	u32		num_pi_qps;
 	u32		reserved_qps;
 	u32		num_srqs;
 	u32		max_wqes;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index fb3ce4af22b5..c4b92d8bd98a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1698,29 +1698,6 @@ static int load_func_res_caps(struct hns_roce_dev *hr_dev, bool is_vf)
 	return 0;
 }
 
-static int load_ext_cfg_caps(struct hns_roce_dev *hr_dev, bool is_vf)
-{
-	struct hns_roce_cmq_desc desc;
-	struct hns_roce_cmq_req *req = (struct hns_roce_cmq_req *)desc.data;
-	struct hns_roce_caps *caps = &hr_dev->caps;
-	u32 func_num, qp_num;
-	int ret;
-
-	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_EXT_CFG, true);
-	ret = hns_roce_cmq_send(hr_dev, &desc, 1);
-	if (ret)
-		return ret;
-
-	func_num = is_vf ? 1 : max_t(u32, 1, hr_dev->func_num);
-	qp_num = hr_reg_read(req, EXT_CFG_QP_PI_NUM) / func_num;
-	caps->num_pi_qps = round_down(qp_num, HNS_ROCE_QP_BANK_NUM);
-
-	qp_num = hr_reg_read(req, EXT_CFG_QP_NUM) / func_num;
-	caps->num_qps = round_down(qp_num, HNS_ROCE_QP_BANK_NUM);
-
-	return 0;
-}
-
 static int load_pf_timer_res_caps(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_cmq_desc desc;
@@ -1741,50 +1718,37 @@ static int load_pf_timer_res_caps(struct hns_roce_dev *hr_dev)
 	return 0;
 }
 
-static int query_func_resource_caps(struct hns_roce_dev *hr_dev, bool is_vf)
+static int hns_roce_query_pf_resource(struct hns_roce_dev *hr_dev)
 {
 	struct device *dev = hr_dev->dev;
 	int ret;
 
-	ret = load_func_res_caps(hr_dev, is_vf);
+	ret = load_func_res_caps(hr_dev, false);
 	if (ret) {
-		dev_err(dev, "failed to load res caps, ret = %d (%s).\n", ret,
-			is_vf ? "vf" : "pf");
+		dev_err(dev, "failed to load pf res caps, ret = %d.\n", ret);
 		return ret;
 	}
 
-	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09) {
-		ret = load_ext_cfg_caps(hr_dev, is_vf);
-		if (ret)
-			dev_err(dev, "failed to load ext cfg, ret = %d (%s).\n",
-				ret, is_vf ? "vf" : "pf");
-	}
+	ret = load_pf_timer_res_caps(hr_dev);
+	if (ret)
+		dev_err(dev, "failed to load pf timer resource, ret = %d.\n",
+			ret);
 
 	return ret;
 }
 
-static int hns_roce_query_pf_resource(struct hns_roce_dev *hr_dev)
+static int hns_roce_query_vf_resource(struct hns_roce_dev *hr_dev)
 {
 	struct device *dev = hr_dev->dev;
 	int ret;
 
-	ret = query_func_resource_caps(hr_dev, false);
+	ret = load_func_res_caps(hr_dev, true);
 	if (ret)
-		return ret;
-
-	ret = load_pf_timer_res_caps(hr_dev);
-	if (ret)
-		dev_err(dev, "failed to load pf timer resource, ret = %d.\n",
-			ret);
+		dev_err(dev, "failed to load vf res caps, ret = %d.\n", ret);
 
 	return ret;
 }
 
-static int hns_roce_query_vf_resource(struct hns_roce_dev *hr_dev)
-{
-	return query_func_resource_caps(hr_dev, true);
-}
-
 static int __hns_roce_set_vf_switch_param(struct hns_roce_dev *hr_dev,
 					  u32 vf_id)
 {
@@ -1867,24 +1831,6 @@ static int config_vf_hem_resource(struct hns_roce_dev *hr_dev, int vf_id)
 	return hns_roce_cmq_send(hr_dev, desc, 2);
 }
 
-static int config_vf_ext_resource(struct hns_roce_dev *hr_dev, u32 vf_id)
-{
-	struct hns_roce_cmq_desc desc;
-	struct hns_roce_cmq_req *req = (struct hns_roce_cmq_req *)desc.data;
-	struct hns_roce_caps *caps = &hr_dev->caps;
-
-	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_EXT_CFG, false);
-
-	hr_reg_write(req, EXT_CFG_VF_ID, vf_id);
-
-	hr_reg_write(req, EXT_CFG_QP_PI_NUM, caps->num_pi_qps);
-	hr_reg_write(req, EXT_CFG_QP_PI_IDX, vf_id * caps->num_pi_qps);
-	hr_reg_write(req, EXT_CFG_QP_NUM, caps->num_qps);
-	hr_reg_write(req, EXT_CFG_QP_IDX, vf_id * caps->num_qps);
-
-	return hns_roce_cmq_send(hr_dev, &desc, 1);
-}
-
 static int hns_roce_alloc_vf_resource(struct hns_roce_dev *hr_dev)
 {
 	u32 func_num = max_t(u32, 1, hr_dev->func_num);
@@ -1899,16 +1845,6 @@ static int hns_roce_alloc_vf_resource(struct hns_roce_dev *hr_dev)
 				vf_id, ret);
 			return ret;
 		}
-
-		if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09) {
-			ret = config_vf_ext_resource(hr_dev, vf_id);
-			if (ret) {
-				dev_err(hr_dev->dev,
-					"failed to config vf-%u ext res, ret = %d.\n",
-					vf_id, ret);
-				return ret;
-			}
-		}
 	}
 
 	return 0;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 2b87f0cf06ec..d9693f6cc802 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -219,7 +219,6 @@ enum hns_roce_opcode_type {
 	HNS_ROCE_OPC_QUERY_VF_RES			= 0x850e,
 	HNS_ROCE_OPC_CFG_GMV_TBL			= 0x850f,
 	HNS_ROCE_OPC_CFG_GMV_BT				= 0x8510,
-	HNS_ROCE_OPC_EXT_CFG				= 0x8512,
 	HNS_ROCE_QUERY_RAM_ECC				= 0x8513,
 	HNS_SWITCH_PARAMETER_CFG			= 0x1033,
 };
@@ -956,15 +955,6 @@ struct hns_roce_func_clear {
 #define HNS_ROCE_V2_READ_FUNC_CLEAR_FLAG_INTERVAL	40
 #define HNS_ROCE_V2_READ_FUNC_CLEAR_FLAG_FAIL_WAIT	20
 
-/* Fields of HNS_ROCE_OPC_EXT_CFG */
-#define EXT_CFG_VF_ID CMQ_REQ_FIELD_LOC(31, 0)
-#define EXT_CFG_QP_PI_IDX CMQ_REQ_FIELD_LOC(45, 32)
-#define EXT_CFG_QP_PI_NUM CMQ_REQ_FIELD_LOC(63, 48)
-#define EXT_CFG_QP_NUM CMQ_REQ_FIELD_LOC(87, 64)
-#define EXT_CFG_QP_IDX CMQ_REQ_FIELD_LOC(119, 96)
-#define EXT_CFG_LLM_IDX CMQ_REQ_FIELD_LOC(139, 128)
-#define EXT_CFG_LLM_NUM CMQ_REQ_FIELD_LOC(156, 144)
-
 #define CFG_LLM_A_BA_L CMQ_REQ_FIELD_LOC(31, 0)
 #define CFG_LLM_A_BA_H CMQ_REQ_FIELD_LOC(63, 32)
 #define CFG_LLM_A_DEPTH CMQ_REQ_FIELD_LOC(76, 64)
-- 
2.30.0

