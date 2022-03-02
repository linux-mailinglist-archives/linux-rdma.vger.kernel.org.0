Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB11F4C9DFA
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Mar 2022 07:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbiCBGt1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Mar 2022 01:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239744AbiCBGt0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Mar 2022 01:49:26 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DD8B2525
        for <linux-rdma@vger.kernel.org>; Tue,  1 Mar 2022 22:48:41 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4K7l2S4SWLz1GByx;
        Wed,  2 Mar 2022 14:44:00 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 14:48:40 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 14:48:39 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH v3 for-next 1/9] RDMA/hns: Remove the unused parameter "op_modifier" in mailbox
Date:   Wed, 2 Mar 2022 14:48:22 +0800
Message-ID: <20220302064830.61706-2-liangwenpeng@huawei.com>
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

The parameter "op_modifier" is only used for HIP06. It is useless for HIP08
and later versions. After removing HIP06, this parameter is no longer used,
so remove it.

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/hns/hns_roce_cmd.c      | 36 ++++++++-----------
 drivers/infiniband/hw/hns/hns_roce_cmd.h      |  3 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c       |  4 +--
 drivers/infiniband/hw/hns/hns_roce_device.h   |  2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    | 26 +++++++-------
 .../infiniband/hw/hns/hns_roce_hw_v2_dfx.c    |  2 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c       |  6 ++--
 drivers/infiniband/hw/hns/hns_roce_srq.c      |  4 +--
 8 files changed, 37 insertions(+), 46 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.c b/drivers/infiniband/hw/hns/hns_roce_cmd.c
index 4b693d542ace..ab89e70b6f04 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.c
@@ -39,25 +39,22 @@
 #define CMD_MAX_NUM 32
 
 static int hns_roce_cmd_mbox_post_hw(struct hns_roce_dev *hr_dev, u64 in_param,
-				     u64 out_param, u32 in_modifier,
-				     u8 op_modifier, u16 op, u16 token,
-				     int event)
+				     u64 out_param, u32 in_modifier, u16 op,
+				     u16 token, int event)
 {
 	return hr_dev->hw->post_mbox(hr_dev, in_param, out_param, in_modifier,
-				     op_modifier, op, token, event);
+				     op, token, event);
 }
 
 /* this should be called with "poll_sem" */
 static int __hns_roce_cmd_mbox_poll(struct hns_roce_dev *hr_dev, u64 in_param,
 				    u64 out_param, unsigned long in_modifier,
-				    u8 op_modifier, u16 op,
-				    unsigned int timeout)
+				    u16 op, unsigned int timeout)
 {
 	int ret;
 
 	ret = hns_roce_cmd_mbox_post_hw(hr_dev, in_param, out_param,
-					in_modifier, op_modifier, op,
-					CMD_POLL_TOKEN, 0);
+					in_modifier, op, CMD_POLL_TOKEN, 0);
 	if (ret) {
 		dev_err_ratelimited(hr_dev->dev,
 				    "failed to post mailbox 0x%x in poll mode, ret = %d.\n",
@@ -70,13 +67,13 @@ static int __hns_roce_cmd_mbox_poll(struct hns_roce_dev *hr_dev, u64 in_param,
 
 static int hns_roce_cmd_mbox_poll(struct hns_roce_dev *hr_dev, u64 in_param,
 				  u64 out_param, unsigned long in_modifier,
-				  u8 op_modifier, u16 op, unsigned int timeout)
+				  u16 op, unsigned int timeout)
 {
 	int ret;
 
 	down(&hr_dev->cmd.poll_sem);
 	ret = __hns_roce_cmd_mbox_poll(hr_dev, in_param, out_param, in_modifier,
-				       op_modifier, op, timeout);
+				       op, timeout);
 	up(&hr_dev->cmd.poll_sem);
 
 	return ret;
@@ -102,8 +99,7 @@ void hns_roce_cmd_event(struct hns_roce_dev *hr_dev, u16 token, u8 status,
 
 static int __hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 				    u64 out_param, unsigned long in_modifier,
-				    u8 op_modifier, u16 op,
-				    unsigned int timeout)
+				    u16 op, unsigned int timeout)
 {
 	struct hns_roce_cmdq *cmd = &hr_dev->cmd;
 	struct hns_roce_cmd_context *context;
@@ -125,8 +121,7 @@ static int __hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 	reinit_completion(&context->done);
 
 	ret = hns_roce_cmd_mbox_post_hw(hr_dev, in_param, out_param,
-					in_modifier, op_modifier, op,
-					context->token, 1);
+					in_modifier, op, context->token, 1);
 	if (ret) {
 		dev_err_ratelimited(dev,
 				    "failed to post mailbox 0x%x in event mode, ret = %d.\n",
@@ -154,21 +149,20 @@ static int __hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 
 static int hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 				  u64 out_param, unsigned long in_modifier,
-				  u8 op_modifier, u16 op, unsigned int timeout)
+				  u16 op, unsigned int timeout)
 {
 	int ret;
 
 	down(&hr_dev->cmd.event_sem);
 	ret = __hns_roce_cmd_mbox_wait(hr_dev, in_param, out_param, in_modifier,
-				       op_modifier, op, timeout);
+				       op, timeout);
 	up(&hr_dev->cmd.event_sem);
 
 	return ret;
 }
 
 int hns_roce_cmd_mbox(struct hns_roce_dev *hr_dev, u64 in_param, u64 out_param,
-		      unsigned long in_modifier, u8 op_modifier, u16 op,
-		      unsigned int timeout)
+		      unsigned long in_modifier, u16 op, unsigned int timeout)
 {
 	bool is_busy;
 
@@ -178,12 +172,10 @@ int hns_roce_cmd_mbox(struct hns_roce_dev *hr_dev, u64 in_param, u64 out_param,
 
 	if (hr_dev->cmd.use_events)
 		return hns_roce_cmd_mbox_wait(hr_dev, in_param, out_param,
-					      in_modifier, op_modifier, op,
-					      timeout);
+					      in_modifier, op, timeout);
 	else
 		return hns_roce_cmd_mbox_poll(hr_dev, in_param, out_param,
-					      in_modifier, op_modifier, op,
-					      timeout);
+					      in_modifier, op, timeout);
 }
 
 int hns_roce_cmd_init(struct hns_roce_dev *hr_dev)
diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.h b/drivers/infiniband/hw/hns/hns_roce_cmd.h
index 8025e7f657fa..3055996935d5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.h
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.h
@@ -140,8 +140,7 @@ enum {
 };
 
 int hns_roce_cmd_mbox(struct hns_roce_dev *hr_dev, u64 in_param, u64 out_param,
-		      unsigned long in_modifier, u8 op_modifier, u16 op,
-		      unsigned int timeout);
+		      unsigned long in_modifier, u16 op, unsigned int timeout);
 
 struct hns_roce_cmd_mailbox *
 hns_roce_alloc_cmd_mailbox(struct hns_roce_dev *hr_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 55057dcbb2dc..6fbfa262e6c7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -140,7 +140,7 @@ static int alloc_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 	hr_dev->hw->write_cqc(hr_dev, hr_cq, mailbox->buf, mtts, dma_handle);
 
 	/* Send mailbox to hw */
-	ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, hr_cq->cqn, 0,
+	ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, hr_cq->cqn,
 			HNS_ROCE_CMD_CREATE_CQC, HNS_ROCE_CMD_TIMEOUT_MSECS);
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
 	if (ret) {
@@ -174,7 +174,7 @@ static void free_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 	struct device *dev = hr_dev->dev;
 	int ret;
 
-	ret = hns_roce_cmd_mbox(hr_dev, 0, 0, hr_cq->cqn, 1,
+	ret = hns_roce_cmd_mbox(hr_dev, 0, 0, hr_cq->cqn,
 				HNS_ROCE_CMD_DESTROY_CQC,
 				HNS_ROCE_CMD_TIMEOUT_MSECS);
 	if (ret)
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 1e0bae136997..6da996f46cf3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -852,7 +852,7 @@ struct hns_roce_hw {
 	int (*hw_init)(struct hns_roce_dev *hr_dev);
 	void (*hw_exit)(struct hns_roce_dev *hr_dev);
 	int (*post_mbox)(struct hns_roce_dev *hr_dev, u64 in_param,
-			 u64 out_param, u32 in_modifier, u8 op_modifier, u16 op,
+			 u64 out_param, u32 in_modifier, u16 op,
 			 u16 token, int event);
 	int (*poll_mbox_done)(struct hns_roce_dev *hr_dev,
 			      unsigned int timeout);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index b33e948fd060..c86cf75c4caa 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1353,7 +1353,7 @@ static int config_hem_ba_to_hw(struct hns_roce_dev *hr_dev, unsigned long obj,
 	if (IS_ERR(mbox))
 		return PTR_ERR(mbox);
 
-	ret = hns_roce_cmd_mbox(hr_dev, base_addr, mbox->dma, obj, 0, op,
+	ret = hns_roce_cmd_mbox(hr_dev, base_addr, mbox->dma, obj, op,
 				HNS_ROCE_CMD_TIMEOUT_MSECS);
 	hns_roce_free_cmd_mailbox(hr_dev, mbox);
 	return ret;
@@ -2781,7 +2781,7 @@ static void hns_roce_v2_exit(struct hns_roce_dev *hr_dev)
 }
 
 static int hns_roce_mbox_post(struct hns_roce_dev *hr_dev, u64 in_param,
-			      u64 out_param, u32 in_modifier, u8 op_modifier,
+			      u64 out_param, u32 in_modifier,
 			      u16 op, u16 token, int event)
 {
 	struct hns_roce_cmq_desc desc;
@@ -2848,7 +2848,7 @@ static int v2_wait_mbox_complete(struct hns_roce_dev *hr_dev, u32 timeout,
 }
 
 static int v2_post_mbox(struct hns_roce_dev *hr_dev, u64 in_param,
-			u64 out_param, u32 in_modifier, u8 op_modifier,
+			u64 out_param, u32 in_modifier,
 			u16 op, u16 token, int event)
 {
 	u8 status = 0;
@@ -2866,7 +2866,7 @@ static int v2_post_mbox(struct hns_roce_dev *hr_dev, u64 in_param,
 
 	/* Post new message to mbox */
 	ret = hns_roce_mbox_post(hr_dev, in_param, out_param, in_modifier,
-				 op_modifier, op, token, event);
+				 op, token, event);
 	if (ret)
 		dev_err_ratelimited(hr_dev->dev,
 				    "failed to post mailbox, ret = %d.\n", ret);
@@ -3992,7 +3992,7 @@ static int hns_roce_v2_clear_hem(struct hns_roce_dev *hr_dev,
 		return PTR_ERR(mailbox);
 
 	/* configure the tag and op */
-	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, obj, 0, op,
+	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, obj, op,
 				HNS_ROCE_CMD_TIMEOUT_MSECS);
 
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
@@ -4017,7 +4017,7 @@ static int hns_roce_v2_qp_modify(struct hns_roce_dev *hr_dev,
 	memcpy(mailbox->buf, context, qpc_size);
 	memcpy(mailbox->buf + qpc_size, qpc_mask, qpc_size);
 
-	ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, hr_qp->qpn, 0,
+	ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, hr_qp->qpn,
 				HNS_ROCE_CMD_MODIFY_QPC,
 				HNS_ROCE_CMD_TIMEOUT_MSECS);
 
@@ -5092,7 +5092,7 @@ static int hns_roce_v2_query_qpc(struct hns_roce_dev *hr_dev,
 	if (IS_ERR(mailbox))
 		return PTR_ERR(mailbox);
 
-	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, hr_qp->qpn, 0,
+	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, hr_qp->qpn,
 				HNS_ROCE_CMD_QUERY_QPC,
 				HNS_ROCE_CMD_TIMEOUT_MSECS);
 	if (ret)
@@ -5460,7 +5460,7 @@ static int hns_roce_v2_modify_srq(struct ib_srq *ibsrq,
 		hr_reg_write(srq_context, SRQC_LIMIT_WL, srq_attr->srq_limit);
 		hr_reg_clear(srqc_mask, SRQC_LIMIT_WL);
 
-		ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, srq->srqn, 0,
+		ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, srq->srqn,
 					HNS_ROCE_CMD_MODIFY_SRQC,
 					HNS_ROCE_CMD_TIMEOUT_MSECS);
 		hns_roce_free_cmd_mailbox(hr_dev, mailbox);
@@ -5488,7 +5488,7 @@ static int hns_roce_v2_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
 		return PTR_ERR(mailbox);
 
 	srq_context = mailbox->buf;
-	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, srq->srqn, 0,
+	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, srq->srqn,
 				HNS_ROCE_CMD_QUERY_SRQC,
 				HNS_ROCE_CMD_TIMEOUT_MSECS);
 	if (ret) {
@@ -5540,7 +5540,7 @@ static int hns_roce_v2_modify_cq(struct ib_cq *cq, u16 cq_count, u16 cq_period)
 	hr_reg_write(cq_context, CQC_CQ_PERIOD, cq_period);
 	hr_reg_clear(cqc_mask, CQC_CQ_PERIOD);
 
-	ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, hr_cq->cqn, 1,
+	ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, hr_cq->cqn,
 				HNS_ROCE_CMD_MODIFY_CQC,
 				HNS_ROCE_CMD_TIMEOUT_MSECS);
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
@@ -5872,11 +5872,11 @@ static void hns_roce_v2_destroy_eqc(struct hns_roce_dev *hr_dev, u32 eqn)
 
 	if (eqn < hr_dev->caps.num_comp_vectors)
 		ret = hns_roce_cmd_mbox(hr_dev, 0, 0, eqn & HNS_ROCE_V2_EQN_M,
-					0, HNS_ROCE_CMD_DESTROY_CEQC,
+					HNS_ROCE_CMD_DESTROY_CEQC,
 					HNS_ROCE_CMD_TIMEOUT_MSECS);
 	else
 		ret = hns_roce_cmd_mbox(hr_dev, 0, 0, eqn & HNS_ROCE_V2_EQN_M,
-					0, HNS_ROCE_CMD_DESTROY_AEQC,
+					HNS_ROCE_CMD_DESTROY_AEQC,
 					HNS_ROCE_CMD_TIMEOUT_MSECS);
 	if (ret)
 		dev_err(dev, "[mailbox cmd] destroy eqc(%u) failed.\n", eqn);
@@ -6002,7 +6002,7 @@ static int hns_roce_v2_create_eq(struct hns_roce_dev *hr_dev,
 	if (ret)
 		goto err_cmd_mbox;
 
-	ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, eq->eqn, 0,
+	ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, eq->eqn,
 				eq_cmd, HNS_ROCE_CMD_TIMEOUT_MSECS);
 	if (ret) {
 		dev_err(hr_dev->dev, "[mailbox cmd] create eqc failed.\n");
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2_dfx.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2_dfx.c
index 5a97b5a0b7be..bce3a67b0b2d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2_dfx.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2_dfx.c
@@ -18,7 +18,7 @@ int hns_roce_v2_query_cqc_info(struct hns_roce_dev *hr_dev, u32 cqn,
 		return PTR_ERR(mailbox);
 
 	cq_context = mailbox->buf;
-	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, cqn, 0,
+	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, cqn,
 				HNS_ROCE_CMD_QUERY_CQC,
 				HNS_ROCE_CMD_TIMEOUT_MSECS);
 	if (ret) {
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 2ee06b906b60..e0ec839f2f6f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -51,7 +51,7 @@ static int hns_roce_hw_create_mpt(struct hns_roce_dev *hr_dev,
 				  struct hns_roce_cmd_mailbox *mailbox,
 				  unsigned long mpt_index)
 {
-	return hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, mpt_index, 0,
+	return hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, mpt_index,
 				 HNS_ROCE_CMD_CREATE_MPT,
 				 HNS_ROCE_CMD_TIMEOUT_MSECS);
 }
@@ -61,7 +61,7 @@ int hns_roce_hw_destroy_mpt(struct hns_roce_dev *hr_dev,
 			    unsigned long mpt_index)
 {
 	return hns_roce_cmd_mbox(hr_dev, 0, mailbox ? mailbox->dma : 0,
-				 mpt_index, !mailbox, HNS_ROCE_CMD_DESTROY_MPT,
+				 mpt_index, HNS_ROCE_CMD_DESTROY_MPT,
 				 HNS_ROCE_CMD_TIMEOUT_MSECS);
 }
 
@@ -303,7 +303,7 @@ struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start,
 		return ERR_CAST(mailbox);
 
 	mtpt_idx = key_to_hw_index(mr->key) & (hr_dev->caps.num_mtpts - 1);
-	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, mtpt_idx, 0,
+	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, mtpt_idx,
 				HNS_ROCE_CMD_QUERY_MPT,
 				HNS_ROCE_CMD_TIMEOUT_MSECS);
 	if (ret)
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index e64ef6903fb4..525e1eba263a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -63,7 +63,7 @@ static int hns_roce_hw_create_srq(struct hns_roce_dev *dev,
 				  struct hns_roce_cmd_mailbox *mailbox,
 				  unsigned long srq_num)
 {
-	return hns_roce_cmd_mbox(dev, mailbox->dma, 0, srq_num, 0,
+	return hns_roce_cmd_mbox(dev, mailbox->dma, 0, srq_num,
 				 HNS_ROCE_CMD_CREATE_SRQ,
 				 HNS_ROCE_CMD_TIMEOUT_MSECS);
 }
@@ -73,7 +73,7 @@ static int hns_roce_hw_destroy_srq(struct hns_roce_dev *dev,
 				   unsigned long srq_num)
 {
 	return hns_roce_cmd_mbox(dev, 0, mailbox ? mailbox->dma : 0, srq_num,
-				 mailbox ? 0 : 1, HNS_ROCE_CMD_DESTROY_SRQ,
+				 HNS_ROCE_CMD_DESTROY_SRQ,
 				 HNS_ROCE_CMD_TIMEOUT_MSECS);
 }
 
-- 
2.33.0

