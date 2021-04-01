Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16210351026
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Apr 2021 09:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbhDAHfb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Apr 2021 03:35:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15564 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbhDAHfB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Apr 2021 03:35:01 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F9vzS10WSz17PQM;
        Thu,  1 Apr 2021 15:32:52 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Thu, 1 Apr 2021 15:34:51 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 1/3] RDMA/hns: Enable all CMDQ context
Date:   Thu, 1 Apr 2021 15:32:19 +0800
Message-ID: <1617262341-37571-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617262341-37571-1-git-send-email-liweihang@huawei.com>
References: <1617262341-37571-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Fix error of cmd's context number calculation algorithm to enable all of
32 cmd entries and support 32 concurrent accesses.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_cmd.c    | 62 ++++++++++++-----------------
 drivers/infiniband/hw/hns/hns_roce_device.h |  6 +--
 2 files changed, 27 insertions(+), 41 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.c b/drivers/infiniband/hw/hns/hns_roce_cmd.c
index 339e3fd..46900d0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.c
@@ -38,22 +38,14 @@
 
 #define CMD_POLL_TOKEN 0xffff
 #define CMD_MAX_NUM 32
-#define CMD_TOKEN_MASK 0x1f
 
 static int hns_roce_cmd_mbox_post_hw(struct hns_roce_dev *hr_dev, u64 in_param,
 				     u64 out_param, u32 in_modifier,
 				     u8 op_modifier, u16 op, u16 token,
 				     int event)
 {
-	struct hns_roce_cmdq *cmd = &hr_dev->cmd;
-	int ret;
-
-	mutex_lock(&cmd->hcr_mutex);
-	ret = hr_dev->hw->post_mbox(hr_dev, in_param, out_param, in_modifier,
-				    op_modifier, op, token, event);
-	mutex_unlock(&cmd->hcr_mutex);
-
-	return ret;
+	return hr_dev->hw->post_mbox(hr_dev, in_param, out_param, in_modifier,
+				     op_modifier, op, token, event);
 }
 
 /* this should be called with "poll_sem" */
@@ -96,15 +88,18 @@ void hns_roce_cmd_event(struct hns_roce_dev *hr_dev, u16 token, u8 status,
 	struct hns_roce_cmd_context *context =
 		&hr_dev->cmd.context[token % hr_dev->cmd.max_cmds];
 
-	if (token != context->token)
+	if (unlikely(token != context->token)) {
+		dev_err_ratelimited(hr_dev->dev,
+				    "[cmd] invalid ae token %x,context token is %x!\n",
+				    token, context->token);
 		return;
+	}
 
 	context->result = (status == HNS_ROCE_CMD_SUCCESS) ? 0 : (-EIO);
 	context->out_param = out_param;
 	complete(&context->done);
 }
 
-/* this should be called with "use_events" */
 static int __hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 				    u64 out_param, unsigned long in_modifier,
 				    u8 op_modifier, u16 op,
@@ -116,13 +111,18 @@ static int __hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 	int ret;
 
 	spin_lock(&cmd->context_lock);
-	WARN_ON(cmd->free_head < 0);
-	context = &cmd->context[cmd->free_head];
-	context->token += cmd->token_mask + 1;
-	cmd->free_head = context->next;
+
+	do {
+		context = &cmd->context[cmd->free_head];
+		cmd->free_head = context->next;
+	} while (context->busy);
+
+	context->busy = 1;
+	context->token += cmd->max_cmds;
+
 	spin_unlock(&cmd->context_lock);
 
-	init_completion(&context->done);
+	reinit_completion(&context->done);
 
 	ret = hns_roce_cmd_mbox_post_hw(hr_dev, in_param, out_param,
 					in_modifier, op_modifier, op,
@@ -130,30 +130,19 @@ static int __hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 	if (ret)
 		goto out;
 
-	/*
-	 * It is timeout when wait_for_completion_timeout return 0
-	 * The return value is the time limit set in advance
-	 * how many seconds showing
-	 */
 	if (!wait_for_completion_timeout(&context->done,
 					 msecs_to_jiffies(timeout))) {
-		dev_err(dev, "[cmd]wait_for_completion_timeout timeout\n");
+		dev_err(dev, "[cmd] token %x timeout, drop.\n", context->token);
 		ret = -EBUSY;
 		goto out;
 	}
 
 	ret = context->result;
-	if (ret) {
-		dev_err(dev, "[cmd]event mod cmd process error!err=%d\n", ret);
-		goto out;
-	}
+	if (ret)
+		dev_err(dev, "[cmd] token %x error %d\n", context->token, ret);
 
 out:
-	spin_lock(&cmd->context_lock);
-	context->next = cmd->free_head;
-	cmd->free_head = context - cmd->context;
-	spin_unlock(&cmd->context_lock);
-
+	context->busy = 0;
 	return ret;
 }
 
@@ -208,7 +197,6 @@ int hns_roce_cmd_init(struct hns_roce_dev *hr_dev)
 {
 	struct device *dev = hr_dev->dev;
 
-	mutex_init(&hr_dev->cmd.hcr_mutex);
 	sema_init(&hr_dev->cmd.poll_sem, 1);
 	hr_dev->cmd.use_events = 0;
 	hr_dev->cmd.max_cmds = CMD_MAX_NUM;
@@ -239,16 +227,16 @@ int hns_roce_cmd_use_events(struct hns_roce_dev *hr_dev)
 	for (i = 0; i < hr_cmd->max_cmds; ++i) {
 		hr_cmd->context[i].token = i;
 		hr_cmd->context[i].next = i + 1;
+		init_completion(&hr_cmd->context[i].done);
 	}
-
-	hr_cmd->context[hr_cmd->max_cmds - 1].next = -1;
+	hr_cmd->context[hr_cmd->max_cmds - 1].next = 0;
 	hr_cmd->free_head = 0;
 
 	sema_init(&hr_cmd->event_sem, hr_cmd->max_cmds);
 	spin_lock_init(&hr_cmd->context_lock);
 
-	hr_cmd->token_mask = CMD_TOKEN_MASK;
 	hr_cmd->use_events = 1;
+	down(&hr_cmd->poll_sem);
 
 	return 0;
 }
@@ -259,6 +247,8 @@ void hns_roce_cmd_use_polling(struct hns_roce_dev *hr_dev)
 
 	kfree(hr_cmd->context);
 	hr_cmd->use_events = 0;
+
+	up(&hr_cmd->poll_sem);
 }
 
 struct hns_roce_cmd_mailbox *
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index eb2ccb8..9c20c3a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -556,6 +556,7 @@ struct hns_roce_cmd_context {
 	int			next;
 	u64			out_param;
 	u16			token;
+	u16			busy;
 };
 
 struct hns_roce_cmdq {
@@ -572,11 +573,6 @@ struct hns_roce_cmdq {
 	int			free_head;
 	struct hns_roce_cmd_context *context;
 	/*
-	 * Result of get integer part
-	 * which max_comds compute according a power of 2
-	 */
-	u16			token_mask;
-	/*
 	 * Process whether use event mode, init default non-zero
 	 * After the event queue of cmd event ready,
 	 * can switch into event mode
-- 
2.8.1

