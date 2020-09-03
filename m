Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10BED25C236
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 16:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgICOJD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 10:09:03 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60916 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729083AbgICOIq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Sep 2020 10:08:46 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D27BEFDB6552F9C7DF89;
        Thu,  3 Sep 2020 21:17:20 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 3 Sep 2020 21:17:11 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v3 for-next 4/4] RDMA/hns: Add support for SCCC in size of 64 Bytes
Date:   Thu, 3 Sep 2020 21:16:07 +0800
Message-ID: <1599138967-17621-5-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1599138967-17621-1-git-send-email-liweihang@huawei.com>
References: <1599138967-17621-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yangyang Li <liyangyang20@huawei.com>

For HIP09, size of SCCC (Soft Congestion Control Context) is increased to
64 Bytes from 32 Bytes. The hardware will get the configuration of SCCC
from driver instead of using a fixed value.

Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  2 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c    |  2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 30 +++++++++++++++++++++++++----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  8 ++++++--
 drivers/infiniband/hw/hns/hns_roce_main.c   |  6 +++---
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  2 +-
 6 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index ddf54d2..7bee2de 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -811,7 +811,7 @@ struct hns_roce_caps {
 	int		irrl_entry_sz;
 	int		trrl_entry_sz;
 	int		cqc_entry_sz;
-	int		sccc_entry_sz;
+	int		sccc_sz;
 	int		qpc_timer_entry_sz;
 	int		cqc_timer_entry_sz;
 	int		srqc_entry_sz;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index c8db6f8..c10966f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -1027,7 +1027,7 @@ void hns_roce_cleanup_hem(struct hns_roce_dev *hr_dev)
 	if (hr_dev->caps.cqc_timer_entry_sz)
 		hns_roce_cleanup_hem_table(hr_dev,
 					   &hr_dev->cqc_timer_table);
-	if (hr_dev->caps.sccc_entry_sz)
+	if (hr_dev->caps.sccc_sz)
 		hns_roce_cleanup_hem_table(hr_dev,
 					   &hr_dev->qp_table.sccc_table);
 	if (hr_dev->caps.trrl_entry_sz)
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 2e2cfb4..82bf495 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1762,7 +1762,7 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 	caps->cqc_timer_buf_pg_sz = 0;
 	caps->cqc_timer_hop_num   = HNS_ROCE_HOP_NUM_0;
 
-	caps->sccc_entry_sz	  = HNS_ROCE_V2_SCCC_ENTRY_SZ;
+	caps->sccc_sz = HNS_ROCE_V2_SCCC_SZ;
 	caps->sccc_ba_pg_sz	  = 0;
 	caps->sccc_buf_pg_sz	  = 0;
 	caps->sccc_hop_num	  = HNS_ROCE_SCCC_HOP_NUM;
@@ -1872,7 +1872,7 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 	caps->cqc_entry_sz	     = resp_b->cqc_entry_sz;
 	caps->srqc_entry_sz	     = resp_b->srqc_entry_sz;
 	caps->idx_entry_sz	     = resp_b->idx_entry_sz;
-	caps->sccc_entry_sz	     = resp_b->scc_ctx_entry_sz;
+	caps->sccc_sz		     = resp_b->sccc_sz;
 	caps->max_mtu		     = resp_b->max_mtu;
 	caps->qpc_sz		     = HNS_ROCE_V2_QPC_SZ;
 	caps->min_cqes		     = resp_b->min_cqes;
@@ -1997,6 +1997,7 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 		caps->aeqe_size = HNS_ROCE_V3_EQE_SIZE;
 		caps->cqe_sz = HNS_ROCE_V3_CQE_SIZE;
 		caps->qpc_sz = HNS_ROCE_V3_QPC_SZ;
+		caps->sccc_sz = HNS_ROCE_V3_SCCC_SZ;
 	}
 
 	calc_pg_sz(caps->num_qps, caps->qpc_sz, caps->qpc_hop_num,
@@ -2016,7 +2017,7 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 	caps->qpc_timer_hop_num = HNS_ROCE_HOP_NUM_0;
 	caps->cqc_timer_hop_num = HNS_ROCE_HOP_NUM_0;
 
-	calc_pg_sz(caps->num_qps, caps->sccc_entry_sz,
+	calc_pg_sz(caps->num_qps, caps->sccc_sz,
 		   caps->sccc_hop_num, caps->sccc_bt_num,
 		   &caps->sccc_buf_pg_sz, &caps->sccc_ba_pg_sz,
 		   HEM_TYPE_SCCC);
@@ -2051,6 +2052,21 @@ static int hns_roce_config_qpc_size(struct hns_roce_dev *hr_dev)
 	return hns_roce_cmq_send(hr_dev, &desc, 1);
 }
 
+static int hns_roce_config_sccc_size(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_cmq_desc desc;
+	struct hns_roce_cfg_entry_size *cfg_size =
+				  (struct hns_roce_cfg_entry_size *)desc.data;
+
+	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_CFG_ENTRY_SIZE,
+				      false);
+
+	cfg_size->type = cpu_to_le32(HNS_ROCE_CFG_SCCC_SIZE);
+	cfg_size->size = cpu_to_le32(hr_dev->caps.sccc_sz);
+
+	return hns_roce_cmq_send(hr_dev, &desc, 1);
+}
+
 static int hns_roce_config_entry_size(struct hns_roce_dev *hr_dev)
 {
 	int ret;
@@ -2059,8 +2075,14 @@ static int hns_roce_config_entry_size(struct hns_roce_dev *hr_dev)
 		return 0;
 
 	ret = hns_roce_config_qpc_size(hr_dev);
-	if (ret)
+	if (ret) {
 		dev_err(hr_dev->dev, "failed to cfg qpc sz, ret = %d.\n", ret);
+		return ret;
+	}
+
+	ret = hns_roce_config_sccc_size(hr_dev);
+	if (ret)
+		dev_err(hr_dev->dev, "failed to cfg sccc sz, ret = %d.\n", ret);
 
 	return ret;
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 32c5ddc..a964d04 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -85,7 +85,10 @@
 #define HNS_ROCE_V2_MTPT_ENTRY_SZ		64
 #define HNS_ROCE_V2_MTT_ENTRY_SZ		64
 #define HNS_ROCE_V2_IDX_ENTRY_SZ		4
-#define HNS_ROCE_V2_SCCC_ENTRY_SZ		32
+
+#define HNS_ROCE_V2_SCCC_SZ			32
+#define HNS_ROCE_V3_SCCC_SZ			64
+
 #define HNS_ROCE_V2_QPC_TIMER_ENTRY_SZ		PAGE_SIZE
 #define HNS_ROCE_V2_CQC_TIMER_ENTRY_SZ		PAGE_SIZE
 #define HNS_ROCE_V2_PAGE_SIZE_SUPPORTED		0xFFFFF000
@@ -1544,6 +1547,7 @@ struct hns_roce_cfg_sgid_tb {
 
 enum {
 	HNS_ROCE_CFG_QPC_SIZE = BIT(0),
+	HNS_ROCE_CFG_SCCC_SIZE = BIT(1),
 };
 
 struct hns_roce_cfg_entry_size {
@@ -1596,7 +1600,7 @@ struct hns_roce_query_pf_caps_b {
 	u8 cqc_entry_sz;
 	u8 srqc_entry_sz;
 	u8 idx_entry_sz;
-	u8 scc_ctx_entry_sz;
+	u8 sccc_sz;
 	u8 max_mtu;
 	__le16 qpc_sz;
 	__le16 qpc_timer_entry_sz;
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index a0551c9..ad0ce11c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -640,11 +640,11 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 		}
 	}
 
-	if (hr_dev->caps.sccc_entry_sz) {
+	if (hr_dev->caps.sccc_sz) {
 		ret = hns_roce_init_hem_table(hr_dev,
 					      &hr_dev->qp_table.sccc_table,
 					      HEM_TYPE_SCCC,
-					      hr_dev->caps.sccc_entry_sz,
+					      hr_dev->caps.sccc_sz,
 					      hr_dev->caps.num_qps, 1);
 		if (ret) {
 			dev_err(dev,
@@ -684,7 +684,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 		hns_roce_cleanup_hem_table(hr_dev, &hr_dev->qpc_timer_table);
 
 err_unmap_ctx:
-	if (hr_dev->caps.sccc_entry_sz)
+	if (hr_dev->caps.sccc_sz)
 		hns_roce_cleanup_hem_table(hr_dev,
 					   &hr_dev->qp_table.sccc_table);
 err_unmap_srq:
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 975281f..a343930 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -288,7 +288,7 @@ static int alloc_qpc(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 		}
 	}
 
-	if (hr_dev->caps.sccc_entry_sz) {
+	if (hr_dev->caps.sccc_sz) {
 		/* Alloc memory for SCC CTX */
 		ret = hns_roce_table_get(hr_dev, &qp_table->sccc_table,
 					 hr_qp->qpn);
-- 
2.8.1

