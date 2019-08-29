Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9639A13FC
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2019 10:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfH2IpE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Aug 2019 04:45:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45112 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725990AbfH2IpE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Aug 2019 04:45:04 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D435DEC08ECDA0C1C58A;
        Thu, 29 Aug 2019 16:45:00 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Thu, 29 Aug 2019 16:44:54 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 1/2] RDMA/hns: Optimize cmd init and mode selection for hip08
Date:   Thu, 29 Aug 2019 16:41:41 +0800
Message-ID: <1567068102-56919-2-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1567068102-56919-1-git-send-email-liweihang@hisilicon.com>
References: <1567068102-56919-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixian Liu <liuyixian@huawei.com>

There are two modes for mailbox command (cmd) queue, i.e., event mode and
poll mode. For each mode, we use corresponding semaphores to protect the
cmd queue resource competition, so called event_sem and poll_sem. During
cmd init, both semaphores are initialized and poll mode is selected.
Thus, there is no need to up poll_sema again in cmd_use_polling.

Furthermore, there is no need to down the sema of the other side while
switching mode. This patch aims to decouple the switch between event
mode and poll mode of cmd.

Signed-off-by: Yixian Liu <liuyixian@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_cmd.c  | 10 +---------
 drivers/infiniband/hw/hns/hns_roce_main.c |  8 ++++----
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.c b/drivers/infiniband/hw/hns/hns_roce_cmd.c
index ade26fa..455d533 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.c
@@ -251,23 +251,15 @@ int hns_roce_cmd_use_events(struct hns_roce_dev *hr_dev)
 	hr_cmd->token_mask = CMD_TOKEN_MASK;
 	hr_cmd->use_events = 1;
 
-	down(&hr_cmd->poll_sem);
-
 	return 0;
 }
 
 void hns_roce_cmd_use_polling(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_cmdq *hr_cmd = &hr_dev->cmd;
-	int i;
-
-	hr_cmd->use_events = 0;
-
-	for (i = 0; i < hr_cmd->max_cmds; ++i)
-		down(&hr_cmd->event_sem);
 
 	kfree(hr_cmd->context);
-	up(&hr_cmd->poll_sem);
+	hr_cmd->use_events = 0;
 }
 
 struct hns_roce_cmd_mailbox
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 1b757cc..b5d196c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -902,6 +902,7 @@ int hns_roce_init(struct hns_roce_dev *hr_dev)
 		goto error_failed_cmd_init;
 	}
 
+	/* EQ depends on poll mode, event mode depends on EQ */
 	ret = hr_dev->hw->init_eq(hr_dev);
 	if (ret) {
 		dev_err(dev, "eq init failed!\n");
@@ -911,8 +912,9 @@ int hns_roce_init(struct hns_roce_dev *hr_dev)
 	if (hr_dev->cmd_mod) {
 		ret = hns_roce_cmd_use_events(hr_dev);
 		if (ret) {
-			dev_err(dev, "Switch to event-driven cmd failed!\n");
-			goto error_failed_use_event;
+			dev_warn(dev,
+				 "Cmd event  mode failed, set back to poll!\n");
+			hns_roce_cmd_use_polling(hr_dev);
 		}
 	}
 
@@ -955,8 +957,6 @@ int hns_roce_init(struct hns_roce_dev *hr_dev)
 error_failed_init_hem:
 	if (hr_dev->cmd_mod)
 		hns_roce_cmd_use_polling(hr_dev);
-
-error_failed_use_event:
 	hr_dev->hw->cleanup_eq(hr_dev);
 
 error_failed_eq_table:
-- 
2.8.1

