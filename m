Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0912A4C9DFE
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Mar 2022 07:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239748AbiCBGtb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Mar 2022 01:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239750AbiCBGt1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Mar 2022 01:49:27 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14D6B2D47
        for <linux-rdma@vger.kernel.org>; Tue,  1 Mar 2022 22:48:42 -0800 (PST)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K7l5l4LhczBrJn;
        Wed,  2 Mar 2022 14:46:51 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 14:48:40 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 14:48:40 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH v3 for-next 5/9] RDMA/hns: Refactor mailbox functions
Date:   Wed, 2 Mar 2022 14:48:26 +0800
Message-ID: <20220302064830.61706-6-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220302064830.61706-1-liangwenpeng@huawei.com>
References: <20220302064830.61706-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

From: Chengchang Tang <tangchengchang@huawei.com>

The current mailbox functions have too many parameters, making the code
difficult to maintain. So construct a new structure mbox_msg to pass the
information needed by mailbox.

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/hns/hns_roce_cmd.c      |  73 ++++++------
 drivers/infiniband/hw/hns/hns_roce_cmd.h      |   2 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c       |   9 +-
 drivers/infiniband/hw/hns/hns_roce_device.h   |  14 ++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    | 111 +++++++++---------
 .../infiniband/hw/hns/hns_roce_hw_v2_dfx.c    |   4 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c       |  13 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c      |   6 +-
 8 files changed, 120 insertions(+), 112 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.c b/drivers/infiniband/hw/hns/hns_roce_cmd.c
index df11acd8030e..7e37066b272d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.c
@@ -38,42 +38,36 @@
 #define CMD_POLL_TOKEN 0xffff
 #define CMD_MAX_NUM 32
 
-static int hns_roce_cmd_mbox_post_hw(struct hns_roce_dev *hr_dev, u64 in_param,
-				     u64 out_param, u32 in_modifier, u8 op,
-				     u16 token, int event)
+static int hns_roce_cmd_mbox_post_hw(struct hns_roce_dev *hr_dev,
+				     struct hns_roce_mbox_msg *mbox_msg)
 {
-	return hr_dev->hw->post_mbox(hr_dev, in_param, out_param, in_modifier,
-				     op, token, event);
+	return hr_dev->hw->post_mbox(hr_dev, mbox_msg);
 }
 
 /* this should be called with "poll_sem" */
-static int __hns_roce_cmd_mbox_poll(struct hns_roce_dev *hr_dev, u64 in_param,
-				    u64 out_param, unsigned long in_modifier,
-				    u8 op)
+static int __hns_roce_cmd_mbox_poll(struct hns_roce_dev *hr_dev,
+				    struct hns_roce_mbox_msg *mbox_msg)
 {
 	int ret;
 
-	ret = hns_roce_cmd_mbox_post_hw(hr_dev, in_param, out_param,
-					in_modifier, op, CMD_POLL_TOKEN, 0);
+	ret = hns_roce_cmd_mbox_post_hw(hr_dev, mbox_msg);
 	if (ret) {
 		dev_err_ratelimited(hr_dev->dev,
 				    "failed to post mailbox 0x%x in poll mode, ret = %d.\n",
-				    op, ret);
+				    mbox_msg->cmd, ret);
 		return ret;
 	}
 
 	return hr_dev->hw->poll_mbox_done(hr_dev);
 }
 
-static int hns_roce_cmd_mbox_poll(struct hns_roce_dev *hr_dev, u64 in_param,
-				  u64 out_param, unsigned long in_modifier,
-				  u8 op)
+static int hns_roce_cmd_mbox_poll(struct hns_roce_dev *hr_dev,
+				  struct hns_roce_mbox_msg *mbox_msg)
 {
 	int ret;
 
 	down(&hr_dev->cmd.poll_sem);
-	ret = __hns_roce_cmd_mbox_poll(hr_dev, in_param, out_param, in_modifier,
-				       op);
+	ret = __hns_roce_cmd_mbox_poll(hr_dev, mbox_msg);
 	up(&hr_dev->cmd.poll_sem);
 
 	return ret;
@@ -97,9 +91,8 @@ void hns_roce_cmd_event(struct hns_roce_dev *hr_dev, u16 token, u8 status,
 	complete(&context->done);
 }
 
-static int __hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
-				    u64 out_param, unsigned long in_modifier,
-				    u8 op)
+static int __hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev,
+				    struct hns_roce_mbox_msg *mbox_msg)
 {
 	struct hns_roce_cmdq *cmd = &hr_dev->cmd;
 	struct hns_roce_cmd_context *context;
@@ -120,19 +113,19 @@ static int __hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 
 	reinit_completion(&context->done);
 
-	ret = hns_roce_cmd_mbox_post_hw(hr_dev, in_param, out_param,
-					in_modifier, op, context->token, 1);
+	mbox_msg->token = context->token;
+	ret = hns_roce_cmd_mbox_post_hw(hr_dev, mbox_msg);
 	if (ret) {
 		dev_err_ratelimited(dev,
 				    "failed to post mailbox 0x%x in event mode, ret = %d.\n",
-				    op, ret);
+				    mbox_msg->cmd, ret);
 		goto out;
 	}
 
 	if (!wait_for_completion_timeout(&context->done,
 				msecs_to_jiffies(HNS_ROCE_CMD_TIMEOUT_MSECS))) {
 		dev_err_ratelimited(dev, "[cmd] token 0x%x mailbox 0x%x timeout.\n",
-				    context->token, op);
+				    context->token, mbox_msg->cmd);
 		ret = -EBUSY;
 		goto out;
 	}
@@ -140,42 +133,50 @@ static int __hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 	ret = context->result;
 	if (ret)
 		dev_err_ratelimited(dev, "[cmd] token 0x%x mailbox 0x%x error %d.\n",
-				    context->token, op, ret);
+				    context->token, mbox_msg->cmd, ret);
 
 out:
 	context->busy = 0;
 	return ret;
 }
 
-static int hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
-				  u64 out_param, unsigned long in_modifier,
-				  u8 op)
+static int hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev,
+				  struct hns_roce_mbox_msg *mbox_msg)
 {
 	int ret;
 
 	down(&hr_dev->cmd.event_sem);
-	ret = __hns_roce_cmd_mbox_wait(hr_dev, in_param, out_param, in_modifier,
-				       op);
+	ret = __hns_roce_cmd_mbox_wait(hr_dev, mbox_msg);
 	up(&hr_dev->cmd.event_sem);
 
 	return ret;
 }
 
 int hns_roce_cmd_mbox(struct hns_roce_dev *hr_dev, u64 in_param, u64 out_param,
-		      unsigned long in_modifier, u8 op)
+		      u8 cmd, unsigned long tag)
 {
+	struct hns_roce_mbox_msg mbox_msg = {};
 	bool is_busy;
 
 	if (hr_dev->hw->chk_mbox_avail)
 		if (!hr_dev->hw->chk_mbox_avail(hr_dev, &is_busy))
 			return is_busy ? -EBUSY : 0;
 
-	if (hr_dev->cmd.use_events)
-		return hns_roce_cmd_mbox_wait(hr_dev, in_param, out_param,
-					      in_modifier, op);
-	else
-		return hns_roce_cmd_mbox_poll(hr_dev, in_param, out_param,
-					      in_modifier, op);
+	mbox_msg.in_param = in_param;
+	mbox_msg.out_param = out_param;
+	mbox_msg.cmd = cmd;
+	mbox_msg.tag = tag;
+
+	if (hr_dev->cmd.use_events) {
+		mbox_msg.event_en = 1;
+
+		return hns_roce_cmd_mbox_wait(hr_dev, &mbox_msg);
+	} else {
+		mbox_msg.event_en = 0;
+		mbox_msg.token = CMD_POLL_TOKEN;
+
+		return hns_roce_cmd_mbox_poll(hr_dev, &mbox_msg);
+	}
 }
 
 int hns_roce_cmd_init(struct hns_roce_dev *hr_dev)
diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.h b/drivers/infiniband/hw/hns/hns_roce_cmd.h
index 7928790061b8..759da8981c71 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.h
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.h
@@ -140,7 +140,7 @@ enum {
 };
 
 int hns_roce_cmd_mbox(struct hns_roce_dev *hr_dev, u64 in_param, u64 out_param,
-		      unsigned long in_modifier, u8 op);
+		      u8 cmd, unsigned long tag);
 
 struct hns_roce_cmd_mailbox *
 hns_roce_alloc_cmd_mailbox(struct hns_roce_dev *hr_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 22bd9e066a38..a335fa8481a5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -139,9 +139,8 @@ static int alloc_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 
 	hr_dev->hw->write_cqc(hr_dev, hr_cq, mailbox->buf, mtts, dma_handle);
 
-	/* Send mailbox to hw */
-	ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, hr_cq->cqn,
-				HNS_ROCE_CMD_CREATE_CQC);
+	ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0,
+				HNS_ROCE_CMD_CREATE_CQC, hr_cq->cqn);
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
 	if (ret) {
 		ibdev_err(ibdev,
@@ -174,8 +173,8 @@ static void free_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 	struct device *dev = hr_dev->dev;
 	int ret;
 
-	ret = hns_roce_cmd_mbox(hr_dev, 0, 0, hr_cq->cqn,
-				HNS_ROCE_CMD_DESTROY_CQC);
+	ret = hns_roce_cmd_mbox(hr_dev, 0, 0, HNS_ROCE_CMD_DESTROY_CQC,
+				hr_cq->cqn);
 	if (ret)
 		dev_err(dev, "DESTROY_CQ failed (%d) for CQN %06lx\n", ret,
 			hr_cq->cqn);
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 8dd7919f8698..5e4a3536c41b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -561,6 +561,15 @@ struct hns_roce_cmd_mailbox {
 	dma_addr_t		dma;
 };
 
+struct hns_roce_mbox_msg {
+	u64 in_param;
+	u64 out_param;
+	u8 cmd;
+	u32 tag;
+	u16 token;
+	u8 event_en;
+};
+
 struct hns_roce_dev;
 
 struct hns_roce_rinl_sge {
@@ -851,9 +860,8 @@ struct hns_roce_hw {
 	int (*hw_profile)(struct hns_roce_dev *hr_dev);
 	int (*hw_init)(struct hns_roce_dev *hr_dev);
 	void (*hw_exit)(struct hns_roce_dev *hr_dev);
-	int (*post_mbox)(struct hns_roce_dev *hr_dev, u64 in_param,
-			 u64 out_param, u32 in_modifier, u8 op,
-			 u16 token, int event);
+	int (*post_mbox)(struct hns_roce_dev *hr_dev,
+			 struct hns_roce_mbox_msg *mbox_msg);
 	int (*poll_mbox_done)(struct hns_roce_dev *hr_dev);
 	bool (*chk_mbox_avail)(struct hns_roce_dev *hr_dev, bool *is_busy);
 	int (*set_gid)(struct hns_roce_dev *hr_dev, int gid_index,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 63571abfc019..55c49d358f76 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1344,16 +1344,17 @@ static int hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 	return ret;
 }
 
-static int config_hem_ba_to_hw(struct hns_roce_dev *hr_dev, unsigned long obj,
-			       dma_addr_t base_addr, u8 op)
+static int config_hem_ba_to_hw(struct hns_roce_dev *hr_dev,
+			       dma_addr_t base_addr, u8 cmd, unsigned long tag)
 {
-	struct hns_roce_cmd_mailbox *mbox = hns_roce_alloc_cmd_mailbox(hr_dev);
+	struct hns_roce_cmd_mailbox *mbox;
 	int ret;
 
+	mbox = hns_roce_alloc_cmd_mailbox(hr_dev);
 	if (IS_ERR(mbox))
 		return PTR_ERR(mbox);
 
-	ret = hns_roce_cmd_mbox(hr_dev, base_addr, mbox->dma, obj, op);
+	ret = hns_roce_cmd_mbox(hr_dev, base_addr, mbox->dma, cmd, tag);
 	hns_roce_free_cmd_mailbox(hr_dev, mbox);
 	return ret;
 }
@@ -2779,21 +2780,21 @@ static void hns_roce_v2_exit(struct hns_roce_dev *hr_dev)
 		free_dip_list(hr_dev);
 }
 
-static int hns_roce_mbox_post(struct hns_roce_dev *hr_dev, u64 in_param,
-			      u64 out_param, u32 in_modifier,
-			      u8 op, u16 token, int event)
+static int hns_roce_mbox_post(struct hns_roce_dev *hr_dev,
+			      struct hns_roce_mbox_msg *mbox_msg)
 {
 	struct hns_roce_cmq_desc desc;
 	struct hns_roce_post_mbox *mb = (struct hns_roce_post_mbox *)desc.data;
 
 	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_POST_MB, false);
 
-	mb->in_param_l = cpu_to_le32(in_param);
-	mb->in_param_h = cpu_to_le32(in_param >> 32);
-	mb->out_param_l = cpu_to_le32(out_param);
-	mb->out_param_h = cpu_to_le32(out_param >> 32);
-	mb->cmd_tag = cpu_to_le32(in_modifier << 8 | op);
-	mb->token_event_en = cpu_to_le32(event << 16 | token);
+	mb->in_param_l = cpu_to_le32(mbox_msg->in_param);
+	mb->in_param_h = cpu_to_le32(mbox_msg->in_param >> 32);
+	mb->out_param_l = cpu_to_le32(mbox_msg->out_param);
+	mb->out_param_h = cpu_to_le32(mbox_msg->out_param >> 32);
+	mb->cmd_tag = cpu_to_le32(mbox_msg->tag << 8 | mbox_msg->cmd);
+	mb->token_event_en = cpu_to_le32(mbox_msg->event_en << 16 |
+					 mbox_msg->token);
 
 	return hns_roce_cmq_send(hr_dev, &desc, 1);
 }
@@ -2846,9 +2847,8 @@ static int v2_wait_mbox_complete(struct hns_roce_dev *hr_dev, u32 timeout,
 	return ret;
 }
 
-static int v2_post_mbox(struct hns_roce_dev *hr_dev, u64 in_param,
-			u64 out_param, u32 in_modifier,
-			u8 op, u16 token, int event)
+static int v2_post_mbox(struct hns_roce_dev *hr_dev,
+			struct hns_roce_mbox_msg *mbox_msg)
 {
 	u8 status = 0;
 	int ret;
@@ -2864,8 +2864,7 @@ static int v2_post_mbox(struct hns_roce_dev *hr_dev, u64 in_param,
 	}
 
 	/* Post new message to mbox */
-	ret = hns_roce_mbox_post(hr_dev, in_param, out_param, in_modifier,
-				 op, token, event);
+	ret = hns_roce_mbox_post(hr_dev, mbox_msg);
 	if (ret)
 		dev_err_ratelimited(hr_dev->dev,
 				    "failed to post mailbox, ret = %d.\n", ret);
@@ -3818,38 +3817,38 @@ static int hns_roce_v2_poll_cq(struct ib_cq *ibcq, int num_entries,
 }
 
 static int get_op_for_set_hem(struct hns_roce_dev *hr_dev, u32 type,
-			      u32 step_idx, u8 *mbox_op)
+			      u32 step_idx, u8 *mbox_cmd)
 {
-	u8 op;
+	u8 cmd;
 
 	switch (type) {
 	case HEM_TYPE_QPC:
-		op = HNS_ROCE_CMD_WRITE_QPC_BT0;
+		cmd = HNS_ROCE_CMD_WRITE_QPC_BT0;
 		break;
 	case HEM_TYPE_MTPT:
-		op = HNS_ROCE_CMD_WRITE_MPT_BT0;
+		cmd = HNS_ROCE_CMD_WRITE_MPT_BT0;
 		break;
 	case HEM_TYPE_CQC:
-		op = HNS_ROCE_CMD_WRITE_CQC_BT0;
+		cmd = HNS_ROCE_CMD_WRITE_CQC_BT0;
 		break;
 	case HEM_TYPE_SRQC:
-		op = HNS_ROCE_CMD_WRITE_SRQC_BT0;
+		cmd = HNS_ROCE_CMD_WRITE_SRQC_BT0;
 		break;
 	case HEM_TYPE_SCCC:
-		op = HNS_ROCE_CMD_WRITE_SCCC_BT0;
+		cmd = HNS_ROCE_CMD_WRITE_SCCC_BT0;
 		break;
 	case HEM_TYPE_QPC_TIMER:
-		op = HNS_ROCE_CMD_WRITE_QPC_TIMER_BT0;
+		cmd = HNS_ROCE_CMD_WRITE_QPC_TIMER_BT0;
 		break;
 	case HEM_TYPE_CQC_TIMER:
-		op = HNS_ROCE_CMD_WRITE_CQC_TIMER_BT0;
+		cmd = HNS_ROCE_CMD_WRITE_CQC_TIMER_BT0;
 		break;
 	default:
 		dev_warn(hr_dev->dev, "failed to check hem type %u.\n", type);
 		return -EINVAL;
 	}
 
-	*mbox_op = op + step_idx;
+	*mbox_cmd = cmd + step_idx;
 
 	return 0;
 }
@@ -3875,7 +3874,7 @@ static int set_hem_to_hw(struct hns_roce_dev *hr_dev, int obj,
 			 dma_addr_t base_addr, u32 hem_type, u32 step_idx)
 {
 	int ret;
-	u8 op;
+	u8 cmd;
 
 	if (unlikely(hem_type == HEM_TYPE_GMV))
 		return config_gmv_ba_to_hw(hr_dev, obj, base_addr);
@@ -3883,11 +3882,11 @@ static int set_hem_to_hw(struct hns_roce_dev *hr_dev, int obj,
 	if (unlikely(hem_type == HEM_TYPE_SCCC && step_idx))
 		return 0;
 
-	ret = get_op_for_set_hem(hr_dev, hem_type, step_idx, &op);
+	ret = get_op_for_set_hem(hr_dev, hem_type, step_idx, &cmd);
 	if (ret < 0)
 		return ret;
 
-	return config_hem_ba_to_hw(hr_dev, obj, base_addr, op);
+	return config_hem_ba_to_hw(hr_dev, base_addr, cmd, obj);
 }
 
 static int hns_roce_v2_set_hem(struct hns_roce_dev *hr_dev,
@@ -3950,12 +3949,12 @@ static int hns_roce_v2_set_hem(struct hns_roce_dev *hr_dev,
 }
 
 static int hns_roce_v2_clear_hem(struct hns_roce_dev *hr_dev,
-				 struct hns_roce_hem_table *table, int obj,
-				 u32 step_idx)
+				 struct hns_roce_hem_table *table,
+				 int tag, u32 step_idx)
 {
 	struct hns_roce_cmd_mailbox *mailbox;
 	struct device *dev = hr_dev->dev;
-	u8 op = 0xff;
+	u8 cmd = 0xff;
 	int ret;
 
 	if (!hns_roce_check_whether_mhop(hr_dev, table->type))
@@ -3963,16 +3962,16 @@ static int hns_roce_v2_clear_hem(struct hns_roce_dev *hr_dev,
 
 	switch (table->type) {
 	case HEM_TYPE_QPC:
-		op = HNS_ROCE_CMD_DESTROY_QPC_BT0;
+		cmd = HNS_ROCE_CMD_DESTROY_QPC_BT0;
 		break;
 	case HEM_TYPE_MTPT:
-		op = HNS_ROCE_CMD_DESTROY_MPT_BT0;
+		cmd = HNS_ROCE_CMD_DESTROY_MPT_BT0;
 		break;
 	case HEM_TYPE_CQC:
-		op = HNS_ROCE_CMD_DESTROY_CQC_BT0;
+		cmd = HNS_ROCE_CMD_DESTROY_CQC_BT0;
 		break;
 	case HEM_TYPE_SRQC:
-		op = HNS_ROCE_CMD_DESTROY_SRQC_BT0;
+		cmd = HNS_ROCE_CMD_DESTROY_SRQC_BT0;
 		break;
 	case HEM_TYPE_SCCC:
 	case HEM_TYPE_QPC_TIMER:
@@ -3985,14 +3984,13 @@ static int hns_roce_v2_clear_hem(struct hns_roce_dev *hr_dev,
 		return 0;
 	}
 
-	op += step_idx;
+	cmd += step_idx;
 
 	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
 	if (IS_ERR(mailbox))
 		return PTR_ERR(mailbox);
 
-	/* configure the tag and op */
-	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, obj, op);
+	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, cmd, tag);
 
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
 	return ret;
@@ -4016,8 +4014,8 @@ static int hns_roce_v2_qp_modify(struct hns_roce_dev *hr_dev,
 	memcpy(mailbox->buf, context, qpc_size);
 	memcpy(mailbox->buf + qpc_size, qpc_mask, qpc_size);
 
-	ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, hr_qp->qpn,
-				HNS_ROCE_CMD_MODIFY_QPC);
+	ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0,
+				HNS_ROCE_CMD_MODIFY_QPC, hr_qp->qpn);
 
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
 
@@ -5090,8 +5088,8 @@ static int hns_roce_v2_query_qpc(struct hns_roce_dev *hr_dev,
 	if (IS_ERR(mailbox))
 		return PTR_ERR(mailbox);
 
-	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, hr_qp->qpn,
-				HNS_ROCE_CMD_QUERY_QPC);
+	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, HNS_ROCE_CMD_QUERY_QPC,
+				hr_qp->qpn);
 	if (ret)
 		goto out;
 
@@ -5457,8 +5455,8 @@ static int hns_roce_v2_modify_srq(struct ib_srq *ibsrq,
 		hr_reg_write(srq_context, SRQC_LIMIT_WL, srq_attr->srq_limit);
 		hr_reg_clear(srqc_mask, SRQC_LIMIT_WL);
 
-		ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, srq->srqn,
-					HNS_ROCE_CMD_MODIFY_SRQC);
+		ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0,
+					HNS_ROCE_CMD_MODIFY_SRQC, srq->srqn);
 		hns_roce_free_cmd_mailbox(hr_dev, mailbox);
 		if (ret) {
 			ibdev_err(&hr_dev->ib_dev,
@@ -5484,8 +5482,8 @@ static int hns_roce_v2_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
 		return PTR_ERR(mailbox);
 
 	srq_context = mailbox->buf;
-	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, srq->srqn,
-				HNS_ROCE_CMD_QUERY_SRQC);
+	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma,
+				HNS_ROCE_CMD_QUERY_SRQC, srq->srqn);
 	if (ret) {
 		ibdev_err(&hr_dev->ib_dev,
 			  "failed to process cmd of querying SRQ, ret = %d.\n",
@@ -5535,8 +5533,8 @@ static int hns_roce_v2_modify_cq(struct ib_cq *cq, u16 cq_count, u16 cq_period)
 	hr_reg_write(cq_context, CQC_CQ_PERIOD, cq_period);
 	hr_reg_clear(cqc_mask, CQC_CQ_PERIOD);
 
-	ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, hr_cq->cqn,
-				HNS_ROCE_CMD_MODIFY_CQC);
+	ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0,
+				HNS_ROCE_CMD_MODIFY_CQC, hr_cq->cqn);
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
 	if (ret)
 		ibdev_err(&hr_dev->ib_dev,
@@ -5863,13 +5861,14 @@ static void hns_roce_v2_destroy_eqc(struct hns_roce_dev *hr_dev, u32 eqn)
 {
 	struct device *dev = hr_dev->dev;
 	int ret;
+	u8 cmd;
 
 	if (eqn < hr_dev->caps.num_comp_vectors)
-		ret = hns_roce_cmd_mbox(hr_dev, 0, 0, eqn & HNS_ROCE_V2_EQN_M,
-					HNS_ROCE_CMD_DESTROY_CEQC);
+		cmd = HNS_ROCE_CMD_DESTROY_CEQC;
 	else
-		ret = hns_roce_cmd_mbox(hr_dev, 0, 0, eqn & HNS_ROCE_V2_EQN_M,
-					HNS_ROCE_CMD_DESTROY_AEQC);
+		cmd = HNS_ROCE_CMD_DESTROY_AEQC;
+
+	ret = hns_roce_cmd_mbox(hr_dev, 0, 0, cmd, eqn & HNS_ROCE_V2_EQN_M);
 	if (ret)
 		dev_err(dev, "[mailbox cmd] destroy eqc(%u) failed.\n", eqn);
 }
@@ -5993,7 +5992,7 @@ static int hns_roce_v2_create_eq(struct hns_roce_dev *hr_dev,
 	if (ret)
 		goto err_cmd_mbox;
 
-	ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, eq->eqn, eq_cmd);
+	ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, eq_cmd, eq->eqn);
 	if (ret) {
 		dev_err(hr_dev->dev, "[mailbox cmd] create eqc failed.\n");
 		goto err_cmd_mbox;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2_dfx.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2_dfx.c
index 107288150e3f..f7a75a7cda74 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2_dfx.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2_dfx.c
@@ -18,8 +18,8 @@ int hns_roce_v2_query_cqc_info(struct hns_roce_dev *hr_dev, u32 cqn,
 		return PTR_ERR(mailbox);
 
 	cq_context = mailbox->buf;
-	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, cqn,
-				HNS_ROCE_CMD_QUERY_CQC);
+	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, HNS_ROCE_CMD_QUERY_CQC,
+				cqn);
 	if (ret) {
 		dev_err(hr_dev->dev, "QUERY cqc cmd process error\n");
 		goto err_mailbox;
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 62a57cae800c..22ff78a5a1a7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -51,15 +51,15 @@ static int hns_roce_hw_create_mpt(struct hns_roce_dev *hr_dev,
 				  struct hns_roce_cmd_mailbox *mailbox,
 				  unsigned long mpt_index)
 {
-	return hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, mpt_index,
-				 HNS_ROCE_CMD_CREATE_MPT);
+	return hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0,
+				 HNS_ROCE_CMD_CREATE_MPT, mpt_index);
 }
 
 int hns_roce_hw_destroy_mpt(struct hns_roce_dev *hr_dev,
 			    unsigned long mpt_index)
 {
-	return hns_roce_cmd_mbox(hr_dev, 0, 0, mpt_index,
-				 HNS_ROCE_CMD_DESTROY_MPT);
+	return hns_roce_cmd_mbox(hr_dev, 0, 0, HNS_ROCE_CMD_DESTROY_MPT,
+				 mpt_index);
 }
 
 static int alloc_mr_key(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr)
@@ -300,8 +300,9 @@ struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start,
 		return ERR_CAST(mailbox);
 
 	mtpt_idx = key_to_hw_index(mr->key) & (hr_dev->caps.num_mtpts - 1);
-	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, mtpt_idx,
-				HNS_ROCE_CMD_QUERY_MPT);
+
+	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, HNS_ROCE_CMD_QUERY_MPT,
+				mtpt_idx);
 	if (ret)
 		goto free_cmd_mbox;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 1fef5d630485..f270563aca97 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -63,14 +63,14 @@ static int hns_roce_hw_create_srq(struct hns_roce_dev *dev,
 				  struct hns_roce_cmd_mailbox *mailbox,
 				  unsigned long srq_num)
 {
-	return hns_roce_cmd_mbox(dev, mailbox->dma, 0, srq_num,
-				 HNS_ROCE_CMD_CREATE_SRQ);
+	return hns_roce_cmd_mbox(dev, mailbox->dma, 0, HNS_ROCE_CMD_CREATE_SRQ,
+				 srq_num);
 }
 
 static int hns_roce_hw_destroy_srq(struct hns_roce_dev *dev,
 				   unsigned long srq_num)
 {
-	return hns_roce_cmd_mbox(dev, 0, 0, srq_num, HNS_ROCE_CMD_DESTROY_SRQ);
+	return hns_roce_cmd_mbox(dev, 0, 0, HNS_ROCE_CMD_DESTROY_SRQ, srq_num);
 }
 
 static int alloc_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
-- 
2.33.0

