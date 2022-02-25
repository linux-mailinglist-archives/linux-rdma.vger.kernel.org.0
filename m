Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D034C439C
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Feb 2022 12:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbiBYL1M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Feb 2022 06:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240020AbiBYL1K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Feb 2022 06:27:10 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A581AC299
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 03:26:23 -0800 (PST)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K4nVs26DdzdZS2;
        Fri, 25 Feb 2022 19:24:53 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Feb 2022 19:26:06 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Feb 2022 19:26:06 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH v2 for-next 4/9] RDMA/hns: Fix the wrong type of parameter "op" of the mailbox
Date:   Fri, 25 Feb 2022 19:25:54 +0800
Message-ID: <20220225112559.43300-5-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220225112559.43300-1-liangwenpeng@huawei.com>
References: <20220225112559.43300-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The "op" field of the mailbox occupies 8 bits, so the parameter "op"
should be of type u8.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/hns/hns_roce_cmd.c    | 12 ++++----
 drivers/infiniband/hw/hns/hns_roce_cmd.h    |  2 +-
 drivers/infiniband/hw/hns/hns_roce_device.h |  6 ++--
 drivers/infiniband/hw/hns/hns_roce_hem.c    |  4 +--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 33 ++++++++++-----------
 5 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.c b/drivers/infiniband/hw/hns/hns_roce_cmd.c
index 3642e9282b42..df11acd8030e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.c
@@ -39,7 +39,7 @@
 #define CMD_MAX_NUM 32
 
 static int hns_roce_cmd_mbox_post_hw(struct hns_roce_dev *hr_dev, u64 in_param,
-				     u64 out_param, u32 in_modifier, u16 op,
+				     u64 out_param, u32 in_modifier, u8 op,
 				     u16 token, int event)
 {
 	return hr_dev->hw->post_mbox(hr_dev, in_param, out_param, in_modifier,
@@ -49,7 +49,7 @@ static int hns_roce_cmd_mbox_post_hw(struct hns_roce_dev *hr_dev, u64 in_param,
 /* this should be called with "poll_sem" */
 static int __hns_roce_cmd_mbox_poll(struct hns_roce_dev *hr_dev, u64 in_param,
 				    u64 out_param, unsigned long in_modifier,
-				    u16 op)
+				    u8 op)
 {
 	int ret;
 
@@ -67,7 +67,7 @@ static int __hns_roce_cmd_mbox_poll(struct hns_roce_dev *hr_dev, u64 in_param,
 
 static int hns_roce_cmd_mbox_poll(struct hns_roce_dev *hr_dev, u64 in_param,
 				  u64 out_param, unsigned long in_modifier,
-				  u16 op)
+				  u8 op)
 {
 	int ret;
 
@@ -99,7 +99,7 @@ void hns_roce_cmd_event(struct hns_roce_dev *hr_dev, u16 token, u8 status,
 
 static int __hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 				    u64 out_param, unsigned long in_modifier,
-				    u16 op)
+				    u8 op)
 {
 	struct hns_roce_cmdq *cmd = &hr_dev->cmd;
 	struct hns_roce_cmd_context *context;
@@ -149,7 +149,7 @@ static int __hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 
 static int hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 				  u64 out_param, unsigned long in_modifier,
-				  u16 op)
+				  u8 op)
 {
 	int ret;
 
@@ -162,7 +162,7 @@ static int hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 }
 
 int hns_roce_cmd_mbox(struct hns_roce_dev *hr_dev, u64 in_param, u64 out_param,
-		      unsigned long in_modifier, u16 op)
+		      unsigned long in_modifier, u8 op)
 {
 	bool is_busy;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.h b/drivers/infiniband/hw/hns/hns_roce_cmd.h
index 23937b106aa5..7928790061b8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.h
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.h
@@ -140,7 +140,7 @@ enum {
 };
 
 int hns_roce_cmd_mbox(struct hns_roce_dev *hr_dev, u64 in_param, u64 out_param,
-		      unsigned long in_modifier, u16 op);
+		      unsigned long in_modifier, u8 op);
 
 struct hns_roce_cmd_mailbox *
 hns_roce_alloc_cmd_mailbox(struct hns_roce_dev *hr_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index f21c7aa43324..8dd7919f8698 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -852,7 +852,7 @@ struct hns_roce_hw {
 	int (*hw_init)(struct hns_roce_dev *hr_dev);
 	void (*hw_exit)(struct hns_roce_dev *hr_dev);
 	int (*post_mbox)(struct hns_roce_dev *hr_dev, u64 in_param,
-			 u64 out_param, u32 in_modifier, u16 op,
+			 u64 out_param, u32 in_modifier, u8 op,
 			 u16 token, int event);
 	int (*poll_mbox_done)(struct hns_roce_dev *hr_dev);
 	bool (*chk_mbox_avail)(struct hns_roce_dev *hr_dev, bool *is_busy);
@@ -872,10 +872,10 @@ struct hns_roce_hw {
 			  struct hns_roce_cq *hr_cq, void *mb_buf, u64 *mtts,
 			  dma_addr_t dma_handle);
 	int (*set_hem)(struct hns_roce_dev *hr_dev,
-		       struct hns_roce_hem_table *table, int obj, int step_idx);
+		       struct hns_roce_hem_table *table, int obj, u32 step_idx);
 	int (*clear_hem)(struct hns_roce_dev *hr_dev,
 			 struct hns_roce_hem_table *table, int obj,
-			 int step_idx);
+			 u32 step_idx);
 	int (*modify_qp)(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 			 int attr_mask, enum ib_qp_state cur_state,
 			 enum ib_qp_state new_state);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index 8917365cc6b8..ce1a0d2792a3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -488,7 +488,7 @@ static int set_mhop_hem(struct hns_roce_dev *hr_dev,
 			struct hns_roce_hem_index *index)
 {
 	struct ib_device *ibdev = &hr_dev->ib_dev;
-	int step_idx;
+	u32 step_idx;
 	int ret = 0;
 
 	if (index->inited & HEM_INDEX_L0) {
@@ -618,7 +618,7 @@ static void clear_mhop_hem(struct hns_roce_dev *hr_dev,
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	u32 hop_num = mhop->hop_num;
 	u32 chunk_ba_num;
-	int step_idx;
+	u32 step_idx;
 
 	index->inited = HEM_INDEX_BUF;
 	chunk_ba_num = mhop->bt_chunk_size / BA_BYTE_LEN;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index a79ca9d3c62f..63571abfc019 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1345,7 +1345,7 @@ static int hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 }
 
 static int config_hem_ba_to_hw(struct hns_roce_dev *hr_dev, unsigned long obj,
-			       dma_addr_t base_addr, u16 op)
+			       dma_addr_t base_addr, u8 op)
 {
 	struct hns_roce_cmd_mailbox *mbox = hns_roce_alloc_cmd_mailbox(hr_dev);
 	int ret;
@@ -2781,7 +2781,7 @@ static void hns_roce_v2_exit(struct hns_roce_dev *hr_dev)
 
 static int hns_roce_mbox_post(struct hns_roce_dev *hr_dev, u64 in_param,
 			      u64 out_param, u32 in_modifier,
-			      u16 op, u16 token, int event)
+			      u8 op, u16 token, int event)
 {
 	struct hns_roce_cmq_desc desc;
 	struct hns_roce_post_mbox *mb = (struct hns_roce_post_mbox *)desc.data;
@@ -2848,7 +2848,7 @@ static int v2_wait_mbox_complete(struct hns_roce_dev *hr_dev, u32 timeout,
 
 static int v2_post_mbox(struct hns_roce_dev *hr_dev, u64 in_param,
 			u64 out_param, u32 in_modifier,
-			u16 op, u16 token, int event)
+			u8 op, u16 token, int event)
 {
 	u8 status = 0;
 	int ret;
@@ -3818,9 +3818,9 @@ static int hns_roce_v2_poll_cq(struct ib_cq *ibcq, int num_entries,
 }
 
 static int get_op_for_set_hem(struct hns_roce_dev *hr_dev, u32 type,
-			      int step_idx, u16 *mbox_op)
+			      u32 step_idx, u8 *mbox_op)
 {
-	u16 op;
+	u8 op;
 
 	switch (type) {
 	case HEM_TYPE_QPC:
@@ -3872,10 +3872,10 @@ static int config_gmv_ba_to_hw(struct hns_roce_dev *hr_dev, unsigned long obj,
 }
 
 static int set_hem_to_hw(struct hns_roce_dev *hr_dev, int obj,
-			 dma_addr_t base_addr, u32 hem_type, int step_idx)
+			 dma_addr_t base_addr, u32 hem_type, u32 step_idx)
 {
 	int ret;
-	u16 op;
+	u8 op;
 
 	if (unlikely(hem_type == HEM_TYPE_GMV))
 		return config_gmv_ba_to_hw(hr_dev, obj, base_addr);
@@ -3892,7 +3892,7 @@ static int set_hem_to_hw(struct hns_roce_dev *hr_dev, int obj,
 
 static int hns_roce_v2_set_hem(struct hns_roce_dev *hr_dev,
 			       struct hns_roce_hem_table *table, int obj,
-			       int step_idx)
+			       u32 step_idx)
 {
 	struct hns_roce_hem_iter iter;
 	struct hns_roce_hem_mhop mhop;
@@ -3951,12 +3951,12 @@ static int hns_roce_v2_set_hem(struct hns_roce_dev *hr_dev,
 
 static int hns_roce_v2_clear_hem(struct hns_roce_dev *hr_dev,
 				 struct hns_roce_hem_table *table, int obj,
-				 int step_idx)
+				 u32 step_idx)
 {
-	struct device *dev = hr_dev->dev;
 	struct hns_roce_cmd_mailbox *mailbox;
+	struct device *dev = hr_dev->dev;
+	u8 op = 0xff;
 	int ret;
-	u16 op = 0xff;
 
 	if (!hns_roce_check_whether_mhop(hr_dev, table->type))
 		return 0;
@@ -5975,8 +5975,7 @@ static int alloc_eq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq)
 }
 
 static int hns_roce_v2_create_eq(struct hns_roce_dev *hr_dev,
-				 struct hns_roce_eq *eq,
-				 unsigned int eq_cmd)
+				 struct hns_roce_eq *eq, u8 eq_cmd)
 {
 	struct hns_roce_cmd_mailbox *mailbox;
 	int ret;
@@ -6105,14 +6104,14 @@ static int hns_roce_v2_init_eq_table(struct hns_roce_dev *hr_dev)
 	struct hns_roce_eq_table *eq_table = &hr_dev->eq_table;
 	struct device *dev = hr_dev->dev;
 	struct hns_roce_eq *eq;
-	unsigned int eq_cmd;
-	int irq_num;
-	int eq_num;
 	int other_num;
 	int comp_num;
 	int aeq_num;
-	int i;
+	int irq_num;
+	int eq_num;
+	u8 eq_cmd;
 	int ret;
+	int i;
 
 	other_num = hr_dev->caps.num_other_vectors;
 	comp_num = hr_dev->caps.num_comp_vectors;
-- 
2.33.0

