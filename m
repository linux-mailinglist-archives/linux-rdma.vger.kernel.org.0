Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7763DD0E0
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Aug 2021 08:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbhHBHAD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Aug 2021 03:00:03 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:13221 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbhHBHAD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Aug 2021 03:00:03 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GdTQX6Clvz1CRWf;
        Mon,  2 Aug 2021 14:59:48 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 14:59:51 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 14:59:51 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>, Yangyang Li <liyangyang20@huawei.com>
Subject: [PATCH for-rc] RDMA/hns: Fix the double unlock problem of poll_sem
Date:   Mon, 2 Aug 2021 14:56:14 +0800
Message-ID: <1627887374-20019-1-git-send-email-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yangyang Li <liyangyang20@huawei.com>

If hns_roce_cmd_use_events() fails then it means that the poll_sem is not
obtained, but the poll_sem is released in hns_roce_cmd_use_polling(), this
will cause an unlock problem.

This is the static checker warning:
	drivers/infiniband/hw/hns/hns_roce_main.c:926 hns_roce_init()
	error: double unlocked '&hr_dev->cmd.poll_sem' (orig line 879)

Event mode and polling mode are mutually exclusive and resources are
separated, so there is no need to process polling mode resources in
event mode.

The initial mode of cmd is polling mode, so even if cmd fails to switch to
event mode, it is not necessary to switch to polling mode.

Fixes: a389d016c030 ("RDMA/hns: Enable all CMDQ context")
Fixes: 3d50503b3b33 ("RDMA/hns: Optimize cmd init and mode selection for hip08")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_cmd.c  | 7 +++----
 drivers/infiniband/hw/hns/hns_roce_main.c | 4 +---
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.c b/drivers/infiniband/hw/hns/hns_roce_cmd.c
index 8f68cc3..84f3f2b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.c
@@ -213,8 +213,10 @@ int hns_roce_cmd_use_events(struct hns_roce_dev *hr_dev)

 	hr_cmd->context =
 		kcalloc(hr_cmd->max_cmds, sizeof(*hr_cmd->context), GFP_KERNEL);
-	if (!hr_cmd->context)
+	if (!hr_cmd->context) {
+		hr_dev->cmd_mod = 0;
 		return -ENOMEM;
+	}

 	for (i = 0; i < hr_cmd->max_cmds; ++i) {
 		hr_cmd->context[i].token = i;
@@ -228,7 +230,6 @@ int hns_roce_cmd_use_events(struct hns_roce_dev *hr_dev)
 	spin_lock_init(&hr_cmd->context_lock);

 	hr_cmd->use_events = 1;
-	down(&hr_cmd->poll_sem);

 	return 0;
 }
@@ -239,8 +240,6 @@ void hns_roce_cmd_use_polling(struct hns_roce_dev *hr_dev)

 	kfree(hr_cmd->context);
 	hr_cmd->use_events = 0;
-
-	up(&hr_cmd->poll_sem);
 }

 struct hns_roce_cmd_mailbox *
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 078a971..cc6eab1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -873,11 +873,9 @@ int hns_roce_init(struct hns_roce_dev *hr_dev)

 	if (hr_dev->cmd_mod) {
 		ret = hns_roce_cmd_use_events(hr_dev);
-		if (ret) {
+		if (ret)
 			dev_warn(dev,
 				 "Cmd event  mode failed, set back to poll!\n");
-			hns_roce_cmd_use_polling(hr_dev);
-		}
 	}

 	ret = hns_roce_init_hem(hr_dev);
--
2.8.1

