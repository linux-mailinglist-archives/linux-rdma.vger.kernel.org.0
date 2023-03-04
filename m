Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710496AA8DF
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Mar 2023 10:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjCDJRa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 4 Mar 2023 04:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCDJR3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 4 Mar 2023 04:17:29 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EF014212
        for <linux-rdma@vger.kernel.org>; Sat,  4 Mar 2023 01:17:27 -0800 (PST)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PTK1l3PNlz9tG8;
        Sat,  4 Mar 2023 17:15:23 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 4 Mar 2023 17:17:24 +0800
From:   Haoyue Xu <xuhaoyue1@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <xuhaoyue1@hisilicon.com>
Subject: [PATCH 1/2] RDMA/hns: Add new command to support query vf caps
Date:   Sat, 4 Mar 2023 17:15:54 +0800
Message-ID: <20230304091555.2241298-2-xuhaoyue1@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230304091555.2241298-1-xuhaoyue1@hisilicon.com>
References: <20230304091555.2241298-1-xuhaoyue1@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixing Liu <liuyixing1@huawei.com>

The current resource query for vf caps is driven
by the driver, which is unreasonable. This patch
adds a new command HNS_ROCE_OPC_QUERY_PF_CAPS_NUM
to support obtaining vf caps information from firmware.

Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 95 ++++++++++++----------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  1 +
 2 files changed, 55 insertions(+), 41 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index dbf97fe5948f..9aa83010575e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2239,7 +2239,7 @@ static void apply_func_caps(struct hns_roce_dev *hr_dev)
 	set_hem_page_size(hr_dev);
 }
 
-static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
+static int hns_roce_query_caps(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_cmq_desc desc[HNS_ROCE_QUERY_PF_CAPS_CMD_NUM];
 	struct hns_roce_caps *caps = &hr_dev->caps;
@@ -2248,15 +2248,17 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 	struct hns_roce_query_pf_caps_c *resp_c;
 	struct hns_roce_query_pf_caps_d *resp_d;
 	struct hns_roce_query_pf_caps_e *resp_e;
+	enum hns_roce_opcode_type cmd;
 	int ctx_hop_num;
 	int pbl_hop_num;
 	int ret;
 	int i;
 
+	cmd = hr_dev->is_vf ? HNS_ROCE_OPC_QUERY_VF_CAPS_NUM :
+	      HNS_ROCE_OPC_QUERY_PF_CAPS_NUM;
+
 	for (i = 0; i < HNS_ROCE_QUERY_PF_CAPS_CMD_NUM; i++) {
-		hns_roce_cmq_setup_basic_desc(&desc[i],
-					      HNS_ROCE_OPC_QUERY_PF_CAPS_NUM,
-					      true);
+		hns_roce_cmq_setup_basic_desc(&desc[i], cmd, true);
 		if (i < (HNS_ROCE_QUERY_PF_CAPS_CMD_NUM - 1))
 			desc[i].flag |= cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
 		else
@@ -2273,35 +2275,33 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 	resp_d = (struct hns_roce_query_pf_caps_d *)desc[3].data;
 	resp_e = (struct hns_roce_query_pf_caps_e *)desc[4].data;
 
-	caps->local_ca_ack_delay     = resp_a->local_ca_ack_delay;
-	caps->max_sq_sg		     = le16_to_cpu(resp_a->max_sq_sg);
-	caps->max_sq_inline	     = le16_to_cpu(resp_a->max_sq_inline);
-	caps->max_rq_sg		     = le16_to_cpu(resp_a->max_rq_sg);
+	caps->local_ca_ack_delay = resp_a->local_ca_ack_delay;
+	caps->max_sq_sg = le16_to_cpu(resp_a->max_sq_sg);
+	caps->max_sq_inline = le16_to_cpu(resp_a->max_sq_inline);
+	caps->max_rq_sg = le16_to_cpu(resp_a->max_rq_sg);
 	caps->max_rq_sg = roundup_pow_of_two(caps->max_rq_sg);
-	caps->max_srq_sges	     = le16_to_cpu(resp_a->max_srq_sges);
+	caps->max_srq_sges = le16_to_cpu(resp_a->max_srq_sges);
 	caps->max_srq_sges = roundup_pow_of_two(caps->max_srq_sges);
-	caps->num_aeq_vectors	     = resp_a->num_aeq_vectors;
-	caps->num_other_vectors	     = resp_a->num_other_vectors;
-	caps->max_sq_desc_sz	     = resp_a->max_sq_desc_sz;
-	caps->max_rq_desc_sz	     = resp_a->max_rq_desc_sz;
-	caps->cqe_sz		     = resp_a->cqe_sz;
-
-	caps->mtpt_entry_sz	     = resp_b->mtpt_entry_sz;
-	caps->irrl_entry_sz	     = resp_b->irrl_entry_sz;
-	caps->trrl_entry_sz	     = resp_b->trrl_entry_sz;
-	caps->cqc_entry_sz	     = resp_b->cqc_entry_sz;
-	caps->srqc_entry_sz	     = resp_b->srqc_entry_sz;
-	caps->idx_entry_sz	     = resp_b->idx_entry_sz;
-	caps->sccc_sz		     = resp_b->sccc_sz;
-	caps->max_mtu		     = resp_b->max_mtu;
-	caps->qpc_sz		     = le16_to_cpu(resp_b->qpc_sz);
-	caps->min_cqes		     = resp_b->min_cqes;
-	caps->min_wqes		     = resp_b->min_wqes;
-	caps->page_size_cap	     = le32_to_cpu(resp_b->page_size_cap);
-	caps->pkey_table_len[0]	     = resp_b->pkey_table_len;
-	caps->phy_num_uars	     = resp_b->phy_num_uars;
-	ctx_hop_num		     = resp_b->ctx_hop_num;
-	pbl_hop_num		     = resp_b->pbl_hop_num;
+	caps->num_aeq_vectors = resp_a->num_aeq_vectors;
+	caps->num_other_vectors = resp_a->num_other_vectors;
+	caps->max_sq_desc_sz = resp_a->max_sq_desc_sz;
+	caps->max_rq_desc_sz = resp_a->max_rq_desc_sz;
+
+	caps->mtpt_entry_sz = resp_b->mtpt_entry_sz;
+	caps->irrl_entry_sz = resp_b->irrl_entry_sz;
+	caps->trrl_entry_sz = resp_b->trrl_entry_sz;
+	caps->cqc_entry_sz = resp_b->cqc_entry_sz;
+	caps->srqc_entry_sz = resp_b->srqc_entry_sz;
+	caps->idx_entry_sz = resp_b->idx_entry_sz;
+	caps->sccc_sz = resp_b->sccc_sz;
+	caps->max_mtu = resp_b->max_mtu;
+	caps->min_cqes = resp_b->min_cqes;
+	caps->min_wqes = resp_b->min_wqes;
+	caps->page_size_cap = le32_to_cpu(resp_b->page_size_cap);
+	caps->pkey_table_len[0] = resp_b->pkey_table_len;
+	caps->phy_num_uars = resp_b->phy_num_uars;
+	ctx_hop_num = resp_b->ctx_hop_num;
+	pbl_hop_num = resp_b->pbl_hop_num;
 
 	caps->num_pds = 1 << hr_reg_read(resp_c, PF_CAPS_C_NUM_PDS);
 
@@ -2324,8 +2324,6 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 	caps->ceqe_depth = 1 << hr_reg_read(resp_d, PF_CAPS_D_CEQ_DEPTH);
 	caps->num_comp_vectors = hr_reg_read(resp_d, PF_CAPS_D_NUM_CEQS);
 	caps->aeqe_depth = 1 << hr_reg_read(resp_d, PF_CAPS_D_AEQ_DEPTH);
-	caps->default_aeq_arm_st = hr_reg_read(resp_d, PF_CAPS_D_AEQ_ARM_ST);
-	caps->default_ceq_arm_st = hr_reg_read(resp_d, PF_CAPS_D_CEQ_ARM_ST);
 	caps->reserved_pds = hr_reg_read(resp_d, PF_CAPS_D_RSV_PDS);
 	caps->num_uars = 1 << hr_reg_read(resp_d, PF_CAPS_D_NUM_UARS);
 	caps->reserved_qps = hr_reg_read(resp_d, PF_CAPS_D_RSV_QPS);
@@ -2336,10 +2334,6 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 	caps->reserved_cqs = hr_reg_read(resp_e, PF_CAPS_E_RSV_CQS);
 	caps->reserved_srqs = hr_reg_read(resp_e, PF_CAPS_E_RSV_SRQS);
 	caps->reserved_lkey = hr_reg_read(resp_e, PF_CAPS_E_RSV_LKEYS);
-	caps->default_ceq_max_cnt = le16_to_cpu(resp_e->ceq_max_cnt);
-	caps->default_ceq_period = le16_to_cpu(resp_e->ceq_period);
-	caps->default_aeq_max_cnt = le16_to_cpu(resp_e->aeq_max_cnt);
-	caps->default_aeq_period = le16_to_cpu(resp_e->aeq_period);
 
 	caps->qpc_hop_num = ctx_hop_num;
 	caps->sccc_hop_num = ctx_hop_num;
@@ -2357,6 +2351,19 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 	if (!(caps->page_size_cap & PAGE_SIZE))
 		caps->page_size_cap = HNS_ROCE_V2_PAGE_SIZE_SUPPORTED;
 
+	if (!hr_dev->is_vf) {
+		caps->cqe_sz = resp_a->cqe_sz;
+		caps->qpc_sz = le16_to_cpu(resp_b->qpc_sz);
+		caps->default_aeq_arm_st =
+				hr_reg_read(resp_d, PF_CAPS_D_AEQ_ARM_ST);
+		caps->default_ceq_arm_st =
+				hr_reg_read(resp_d, PF_CAPS_D_CEQ_ARM_ST);
+		caps->default_ceq_max_cnt = le16_to_cpu(resp_e->ceq_max_cnt);
+		caps->default_ceq_period = le16_to_cpu(resp_e->ceq_period);
+		caps->default_aeq_max_cnt = le16_to_cpu(resp_e->aeq_max_cnt);
+		caps->default_aeq_period = le16_to_cpu(resp_e->aeq_period);
+	}
+
 	return 0;
 }
 
@@ -2404,7 +2411,11 @@ static int hns_roce_v2_vf_profile(struct hns_roce_dev *hr_dev)
 
 	hr_dev->func_num = 1;
 
-	set_default_caps(hr_dev);
+	ret = hns_roce_query_caps(hr_dev);
+	if (ret) {
+		dev_err(dev, "failed to query VF caps, ret = %d.\n", ret);
+		return ret;
+	}
 
 	ret = hns_roce_query_vf_resource(hr_dev);
 	if (ret) {
@@ -2444,9 +2455,11 @@ static int hns_roce_v2_pf_profile(struct hns_roce_dev *hr_dev)
 		return ret;
 	}
 
-	ret = hns_roce_query_pf_caps(hr_dev);
-	if (ret)
-		set_default_caps(hr_dev);
+	ret = hns_roce_query_caps(hr_dev);
+	if (ret) {
+		dev_err(dev, "failed to query PF caps, ret = %d.\n", ret);
+		return ret;
+	}
 
 	ret = hns_roce_query_pf_resource(hr_dev);
 	if (ret) {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index af9d00225cdf..f3ebe953c6ce 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -232,6 +232,7 @@ enum hns_roce_opcode_type {
 	HNS_ROCE_OPC_QUERY_FUNC_INFO			= 0x8407,
 	HNS_ROCE_OPC_QUERY_PF_CAPS_NUM                  = 0x8408,
 	HNS_ROCE_OPC_CFG_ENTRY_SIZE			= 0x8409,
+	HNS_ROCE_OPC_QUERY_VF_CAPS_NUM			= 0x8410,
 	HNS_ROCE_OPC_CFG_SGID_TB			= 0x8500,
 	HNS_ROCE_OPC_CFG_SMAC_TB			= 0x8501,
 	HNS_ROCE_OPC_POST_MB				= 0x8504,
-- 
2.33.0

