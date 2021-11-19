Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F4345703D
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Nov 2021 15:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbhKSOJo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Nov 2021 09:09:44 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:28158 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbhKSOJn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Nov 2021 09:09:43 -0500
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Hwdhk0G6dz8vQt;
        Fri, 19 Nov 2021 22:04:54 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 19 Nov 2021 22:06:40 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 19 Nov 2021 22:06:39 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH for-next 1/9] RDMA/hns: Correct the hex print format
Date:   Fri, 19 Nov 2021 22:02:00 +0800
Message-ID: <20211119140208.40416-2-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211119140208.40416-1-liangwenpeng@huawei.com>
References: <20211119140208.40416-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xinhao Liu <liuxinhao5@hisilicon.com>

The hex printf format should be "0xff" instead of "ff".

Signed-off-by: Xinhao Liu <liuxinhao5@hisilicon.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_cmd.c   | 10 +++++-----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.c b/drivers/infiniband/hw/hns/hns_roce_cmd.c
index 84f3f2b5f097..3f7fb7508585 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.c
@@ -61,7 +61,7 @@ static int __hns_roce_cmd_mbox_poll(struct hns_roce_dev *hr_dev, u64 in_param,
 					CMD_POLL_TOKEN, 0);
 	if (ret) {
 		dev_err_ratelimited(hr_dev->dev,
-				    "failed to post mailbox %x in poll mode, ret = %d.\n",
+				    "failed to post mailbox 0x%x in poll mode, ret = %d.\n",
 				    op, ret);
 		return ret;
 	}
@@ -91,7 +91,7 @@ void hns_roce_cmd_event(struct hns_roce_dev *hr_dev, u16 token, u8 status,
 
 	if (unlikely(token != context->token)) {
 		dev_err_ratelimited(hr_dev->dev,
-				    "[cmd] invalid ae token %x,context token is %x!\n",
+				    "[cmd] invalid ae token 0x%x, context token is 0x%x.\n",
 				    token, context->token);
 		return;
 	}
@@ -130,14 +130,14 @@ static int __hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 					context->token, 1);
 	if (ret) {
 		dev_err_ratelimited(dev,
-				    "failed to post mailbox %x in event mode, ret = %d.\n",
+				    "failed to post mailbox 0x%x in event mode, ret = %d.\n",
 				    op, ret);
 		goto out;
 	}
 
 	if (!wait_for_completion_timeout(&context->done,
 					 msecs_to_jiffies(timeout))) {
-		dev_err_ratelimited(dev, "[cmd] token %x mailbox %x timeout.\n",
+		dev_err_ratelimited(dev, "[cmd] token 0x%x mailbox 0x%x timeout.\n",
 				    context->token, op);
 		ret = -EBUSY;
 		goto out;
@@ -145,7 +145,7 @@ static int __hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 
 	ret = context->result;
 	if (ret)
-		dev_err_ratelimited(dev, "[cmd] token %x mailbox %x error %d\n",
+		dev_err_ratelimited(dev, "[cmd] token 0x%x mailbox 0x%x error %d.\n",
 				    context->token, op, ret);
 
 out:
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 9bfbaddd1763..1c3307d57b06 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1295,7 +1295,7 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 				continue;
 
 			dev_err_ratelimited(hr_dev->dev,
-					    "Cmdq IO error, opcode = %x, return = %x\n",
+					    "Cmdq IO error, opcode = 0x%x, return = 0x%x.\n",
 					    desc->opcode, desc_ret);
 			ret = -EIO;
 		}
-- 
2.33.0

