Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5ED62B14F
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Nov 2022 03:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiKPCbQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Nov 2022 21:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiKPCbP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Nov 2022 21:31:15 -0500
Received: from out199-14.us.a.mail.aliyun.com (out199-14.us.a.mail.aliyun.com [47.90.199.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0499929828
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 18:31:13 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VUvYiyu_1668565869;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VUvYiyu_1668565869)
          by smtp.aliyun-inc.com;
          Wed, 16 Nov 2022 10:31:10 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-next 1/3] RDMA/erdma: Add a workqueue for WRs reflushing
Date:   Wed, 16 Nov 2022 10:31:05 +0800
Message-Id: <20221116023107.82835-2-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20221116023107.82835-1-chengyou@linux.alibaba.com>
References: <20221116023107.82835-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ERDMA driver use a workqueue for asynchronous reflush command posting.
Implement the lifecycle of this workqueue.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma.h      |  1 +
 drivers/infiniband/hw/erdma/erdma_main.c | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma.h b/drivers/infiniband/hw/erdma/erdma.h
index bb23d897c710..7bd053a1147a 100644
--- a/drivers/infiniband/hw/erdma/erdma.h
+++ b/drivers/infiniband/hw/erdma/erdma.h
@@ -190,6 +190,7 @@ struct erdma_dev {
 	struct net_device *netdev;
 	struct pci_dev *pdev;
 	struct notifier_block netdev_nb;
+	struct workqueue_struct *reflush_wq;
 
 	resource_size_t func_bar_addr;
 	resource_size_t func_bar_len;
diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
index e44b06fea595..5dc31e5df5cb 100644
--- a/drivers/infiniband/hw/erdma/erdma_main.c
+++ b/drivers/infiniband/hw/erdma/erdma_main.c
@@ -521,13 +521,22 @@ static int erdma_ib_device_add(struct pci_dev *pdev)
 
 	u64_to_ether_addr(mac, dev->attrs.peer_addr);
 
+	dev->reflush_wq = alloc_workqueue("erdma-reflush-wq", WQ_UNBOUND,
+					  WQ_UNBOUND_MAX_ACTIVE);
+	if (!dev->reflush_wq) {
+		ret = -ENOMEM;
+		goto err_alloc_workqueue;
+	}
+
 	ret = erdma_device_register(dev);
 	if (ret)
-		goto err_out;
+		goto err_register;
 
 	return 0;
 
-err_out:
+err_register:
+	destroy_workqueue(dev->reflush_wq);
+err_alloc_workqueue:
 	xa_destroy(&dev->qp_xa);
 	xa_destroy(&dev->cq_xa);
 
@@ -543,6 +552,7 @@ static void erdma_ib_device_remove(struct pci_dev *pdev)
 	unregister_netdevice_notifier(&dev->netdev_nb);
 	ib_unregister_device(&dev->ibdev);
 
+	destroy_workqueue(dev->reflush_wq);
 	erdma_res_cb_free(dev);
 	xa_destroy(&dev->qp_xa);
 	xa_destroy(&dev->cq_xa);
-- 
2.27.0

