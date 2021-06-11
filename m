Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DF73A3F0F
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Jun 2021 11:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhFKJch (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Jun 2021 05:32:37 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:5389 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbhFKJcg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Jun 2021 05:32:36 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G1b832Q1Cz6w6S;
        Fri, 11 Jun 2021 17:26:43 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 17:30:37 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 11 Jun 2021 17:30:36 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Jiaran Zhang <zhangjiaran@huawei.com>,
        Lang Cheng <chenglang@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Solve the problem that dma_pool is used during the reset
Date:   Fri, 11 Jun 2021 17:30:11 +0800
Message-ID: <1623403811-38752-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jiaran Zhang <zhangjiaran@huawei.com>

During the reset, the driver calls dma_pool_destroy() to release the
dma_pool resources. If the dma_pool_free interface is called during the
modify_qp operation, an exception will occur. The completion
synchronization mechanism is used to ensure that dma_pool_destroy() is
executed after the dma_pool_free operation is complete.

Signed-off-by: Jiaran Zhang <zhangjiaran@huawei.com>
Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_cmd.c    | 24 +++++++++++++++++++++++-
 drivers/infiniband/hw/hns/hns_roce_device.h |  2 ++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.c b/drivers/infiniband/hw/hns/hns_roce_cmd.c
index 8f68cc3..e7293ca 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.c
@@ -198,11 +198,20 @@ int hns_roce_cmd_init(struct hns_roce_dev *hr_dev)
 	if (!hr_dev->cmd.pool)
 		return -ENOMEM;
 
+	init_completion(&hr_dev->cmd.can_free);
+
+	refcount_set(&hr_dev->cmd.refcnt, 1);
+
 	return 0;
 }
 
 void hns_roce_cmd_cleanup(struct hns_roce_dev *hr_dev)
 {
+	if (refcount_dec_and_test(&hr_dev->cmd.refcnt))
+		complete(&hr_dev->cmd.can_free);
+
+	wait_for_completion(&hr_dev->cmd.can_free);
+
 	dma_pool_destroy(hr_dev->cmd.pool);
 }
 
@@ -248,13 +257,22 @@ hns_roce_alloc_cmd_mailbox(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_cmd_mailbox *mailbox;
 
-	mailbox = kmalloc(sizeof(*mailbox), GFP_KERNEL);
+	mailbox = kzalloc(sizeof(*mailbox), GFP_KERNEL);
 	if (!mailbox)
 		return ERR_PTR(-ENOMEM);
 
+	/* If refcnt is 0, it means dma_pool has been destroyed. */
+	if (!refcount_inc_not_zero(&hr_dev->cmd.refcnt)) {
+		kfree(mailbox);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	mailbox->buf =
 		dma_pool_alloc(hr_dev->cmd.pool, GFP_KERNEL, &mailbox->dma);
 	if (!mailbox->buf) {
+		if (refcount_dec_and_test(&hr_dev->cmd.refcnt))
+			complete(&hr_dev->cmd.can_free);
+
 		kfree(mailbox);
 		return ERR_PTR(-ENOMEM);
 	}
@@ -269,5 +287,9 @@ void hns_roce_free_cmd_mailbox(struct hns_roce_dev *hr_dev,
 		return;
 
 	dma_pool_free(hr_dev->cmd.pool, mailbox->buf, mailbox->dma);
+
+	if (refcount_dec_and_test(&hr_dev->cmd.refcnt))
+		complete(&hr_dev->cmd.can_free);
+
 	kfree(mailbox);
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 7d00d4c..5187e3f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -570,6 +570,8 @@ struct hns_roce_cmdq {
 	 * close device, switch into poll mode(non event mode)
 	 */
 	u8			use_events;
+	refcount_t		refcnt;
+	struct completion	can_free;
 };
 
 struct hns_roce_cmd_mailbox {
-- 
2.7.4

