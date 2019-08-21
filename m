Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDE6797A88
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 15:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfHUNR6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 09:17:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38404 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728278AbfHUNR6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 09:17:58 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EEA79FB470096FE06FC7;
        Wed, 21 Aug 2019 21:17:53 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Wed, 21 Aug 2019 21:17:46 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-next 1/9] RDMA/hns: Refactor cmd init and mode selection for hip08
Date:   Wed, 21 Aug 2019 21:14:28 +0800
Message-ID: <1566393276-42555-2-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1566393276-42555-1-git-send-email-oulijun@huawei.com>
References: <1566393276-42555-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixian Liu <liuyixian@huawei.com>

This patch refactor the initialization of cmd, and also for the cmd
mode selection on event and poll mode.

Signed-off-by: Yixian Liu <liuyixian@huawei.com>
Signed-off-by: Lang Chen <chenglang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_cmd.c  | 14 ++++----------
 drivers/infiniband/hw/hns/hns_roce_main.c | 18 ++++++++----------
 2 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.c b/drivers/infiniband/hw/hns/hns_roce_cmd.c
index ade26fa..547002f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.c
@@ -251,23 +251,17 @@ int hns_roce_cmd_use_events(struct hns_roce_dev *hr_dev)
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
 
-	for (i = 0; i < hr_cmd->max_cmds; ++i)
-		down(&hr_cmd->event_sem);
-
-	kfree(hr_cmd->context);
-	up(&hr_cmd->poll_sem);
+	if (hr_cmd->use_events) {
+		kfree(hr_cmd->context);
+		hr_cmd->use_events = 0;
+	}
 }
 
 struct hns_roce_cmd_mailbox
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 1b757cc..f3b2f67 100644
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
 
@@ -928,12 +930,10 @@ int hns_roce_init(struct hns_roce_dev *hr_dev)
 		goto error_failed_setup_hca;
 	}
 
-	if (hr_dev->hw->hw_init) {
-		ret = hr_dev->hw->hw_init(hr_dev);
-		if (ret) {
-			dev_err(dev, "hw_init failed!\n");
-			goto error_failed_engine_init;
-		}
+	ret = hr_dev->hw->hw_init(hr_dev);
+	if (ret) {
+		dev_err(dev, "hw_init failed!\n");
+		goto error_failed_engine_init;
 	}
 
 	ret = hns_roce_register_device(hr_dev);
@@ -955,8 +955,6 @@ int hns_roce_init(struct hns_roce_dev *hr_dev)
 error_failed_init_hem:
 	if (hr_dev->cmd_mod)
 		hns_roce_cmd_use_polling(hr_dev);
-
-error_failed_use_event:
 	hr_dev->hw->cleanup_eq(hr_dev);
 
 error_failed_eq_table:
-- 
2.8.1

