Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D585B351028
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Apr 2021 09:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbhDAHfb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Apr 2021 03:35:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15566 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbhDAHfF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Apr 2021 03:35:05 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F9vzY1Y5vz17PRh;
        Thu,  1 Apr 2021 15:32:57 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Thu, 1 Apr 2021 15:34:52 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 3/3] RDMA/hns: Modify prints for mailbox and command queue
Date:   Thu, 1 Apr 2021 15:32:21 +0800
Message-ID: <1617262341-37571-4-git-send-email-liweihang@huawei.com>
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

From: Wenpeng Liang <liangwenpeng@huawei.com>

Use ratelimited print in mbox and cmq. And print mailbox operation if
mailbox fails because it's useful information for the user.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_cmd.c   | 21 +++++++++++++--------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |  9 +++++++--
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.c b/drivers/infiniband/hw/hns/hns_roce_cmd.c
index 46900d0..5c7bd0e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.c
@@ -54,14 +54,15 @@ static int __hns_roce_cmd_mbox_poll(struct hns_roce_dev *hr_dev, u64 in_param,
 				    u8 op_modifier, u16 op,
 				    unsigned int timeout)
 {
-	struct device *dev = hr_dev->dev;
 	int ret;
 
 	ret = hns_roce_cmd_mbox_post_hw(hr_dev, in_param, out_param,
 					in_modifier, op_modifier, op,
 					CMD_POLL_TOKEN, 0);
 	if (ret) {
-		dev_err(dev, "[cmd_poll]hns_roce_cmd_mbox_post_hw failed\n");
+		dev_err_ratelimited(hr_dev->dev,
+				    "failed to post mailbox %x in poll mode, ret = %d.\n",
+				    op, ret);
 		return ret;
 	}
 
@@ -127,19 +128,25 @@ static int __hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 	ret = hns_roce_cmd_mbox_post_hw(hr_dev, in_param, out_param,
 					in_modifier, op_modifier, op,
 					context->token, 1);
-	if (ret)
+	if (ret) {
+		dev_err_ratelimited(dev,
+				    "failed to post mailbox %x in event mode, ret = %d.\n",
+				    op, ret);
 		goto out;
+	}
 
 	if (!wait_for_completion_timeout(&context->done,
 					 msecs_to_jiffies(timeout))) {
-		dev_err(dev, "[cmd] token %x timeout, drop.\n", context->token);
+		dev_err_ratelimited(dev, "[cmd] token %x mailbox %x timeout.\n",
+				    context->token, op);
 		ret = -EBUSY;
 		goto out;
 	}
 
 	ret = context->result;
 	if (ret)
-		dev_err(dev, "[cmd] token %x error %d\n", context->token, ret);
+		dev_err_ratelimited(dev, "[cmd] token %x mailbox %x error %d\n",
+				    context->token, op, ret);
 
 out:
 	context->busy = 0;
@@ -195,12 +202,10 @@ int hns_roce_cmd_mbox(struct hns_roce_dev *hr_dev, u64 in_param, u64 out_param,
 
 int hns_roce_cmd_init(struct hns_roce_dev *hr_dev)
 {
-	struct device *dev = hr_dev->dev;
-
 	sema_init(&hr_dev->cmd.poll_sem, 1);
 	hr_dev->cmd.use_events = 0;
 	hr_dev->cmd.max_cmds = CMD_MAX_NUM;
-	hr_dev->cmd.pool = dma_pool_create("hns_roce_cmd", dev,
+	hr_dev->cmd.pool = dma_pool_create("hns_roce_cmd", hr_dev->dev,
 					   HNS_ROCE_MAILBOX_SIZE,
 					   HNS_ROCE_MAILBOX_SIZE, 0);
 	if (!hr_dev->cmd.pool)
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 783388b..0b281fc 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1151,6 +1151,9 @@ static int hns_roce_alloc_cmq_desc(struct hns_roce_dev *hr_dev,
 		ring->desc_dma_addr = 0;
 		kfree(ring->desc);
 		ring->desc = NULL;
+
+		dev_err_ratelimited(hr_dev->dev,
+				    "failed to map cmq desc addr.\n");
 		return -ENOMEM;
 	}
 
@@ -1225,14 +1228,16 @@ static int hns_roce_v2_cmq_init(struct hns_roce_dev *hr_dev)
 	/* Init CSQ */
 	ret = hns_roce_init_cmq_ring(hr_dev, TYPE_CSQ);
 	if (ret) {
-		dev_err(hr_dev->dev, "Init CSQ error, ret = %d.\n", ret);
+		dev_err_ratelimited(hr_dev->dev,
+				    "failed to init CSQ, ret = %d.\n", ret);
 		return ret;
 	}
 
 	/* Init CRQ */
 	ret = hns_roce_init_cmq_ring(hr_dev, TYPE_CRQ);
 	if (ret) {
-		dev_err(hr_dev->dev, "Init CRQ error, ret = %d.\n", ret);
+		dev_err_ratelimited(hr_dev->dev,
+				    "failed to init CRQ, ret = %d.\n", ret);
 		goto err_crq;
 	}
 
-- 
2.8.1

