Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8641E505A32
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Apr 2022 16:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243202AbiDROpp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Apr 2022 10:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243003AbiDROpi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Apr 2022 10:45:38 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F48B50B3F
        for <linux-rdma@vger.kernel.org>; Mon, 18 Apr 2022 06:30:57 -0700 (PDT)
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 23IDUpNq009654;
        Mon, 18 Apr 2022 22:30:51 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Mon, 18 Apr 2022 22:30:51 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 23IDUpAI009646
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 18 Apr 2022 22:30:51 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <0fadd34b-21cf-3a0d-a494-bde7b8dbc3ed@I-love.SAKURA.ne.jp>
Date:   Mon, 18 Apr 2022 22:30:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     OFED mailing list <linux-rdma@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] RDMA/core: Avoid flush_workqueue(system_unbound_wq) usage
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Flushing system-wide workqueues is dangerous and will be forbidden.
Replace system_unbound_wq with local ib_unbound_wq.

Link: https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Note: This patch is only compile tested.

 drivers/infiniband/core/device.c | 25 +++++++++++++++----------
 drivers/infiniband/core/ucma.c   |  2 +-
 drivers/infiniband/hw/mlx5/odp.c |  4 ++--
 include/rdma/ib_verbs.h          |  1 +
 4 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 4deb60a3b43f..75d9f592c6a1 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -58,6 +58,8 @@ struct workqueue_struct *ib_comp_wq;
 struct workqueue_struct *ib_comp_unbound_wq;
 struct workqueue_struct *ib_wq;
 EXPORT_SYMBOL_GPL(ib_wq);
+struct workqueue_struct *ib_unbound_wq;
+EXPORT_SYMBOL_GPL(ib_unbound_wq);
 
 /*
  * Each of the three rwsem locks (devices, clients, client_data) protects the
@@ -1602,7 +1604,7 @@ void ib_unregister_device_queued(struct ib_device *ib_dev)
 	WARN_ON(!refcount_read(&ib_dev->refcount));
 	WARN_ON(!ib_dev->ops.dealloc_driver);
 	get_device(&ib_dev->dev);
-	if (!queue_work(system_unbound_wq, &ib_dev->unregistration_work))
+	if (!queue_work(ib_unbound_wq, &ib_dev->unregistration_work))
 		put_device(&ib_dev->dev);
 }
 EXPORT_SYMBOL(ib_unregister_device_queued);
@@ -2751,27 +2753,28 @@ static const struct rdma_nl_cbs ibnl_ls_cb_table[RDMA_NL_LS_NUM_OPS] = {
 
 static int __init ib_core_init(void)
 {
-	int ret;
+	int ret = -ENOMEM;
 
 	ib_wq = alloc_workqueue("infiniband", 0, 0);
 	if (!ib_wq)
 		return -ENOMEM;
 
+	ib_unbound_wq = alloc_workqueue("ib-unb-wq", WQ_UNBOUND,
+					WQ_UNBOUND_MAX_ACTIVE);
+	if (!ib_unbound_wq)
+		goto err;
+
 	ib_comp_wq = alloc_workqueue("ib-comp-wq",
 			WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
-	if (!ib_comp_wq) {
-		ret = -ENOMEM;
-		goto err;
-	}
+	if (!ib_comp_wq)
+		goto err_unbound;
 
 	ib_comp_unbound_wq =
 		alloc_workqueue("ib-comp-unb-wq",
 				WQ_UNBOUND | WQ_HIGHPRI | WQ_MEM_RECLAIM |
 				WQ_SYSFS, WQ_UNBOUND_MAX_ACTIVE);
-	if (!ib_comp_unbound_wq) {
-		ret = -ENOMEM;
+	if (!ib_comp_unbound_wq)
 		goto err_comp;
-	}
 
 	ret = class_register(&ib_class);
 	if (ret) {
@@ -2831,6 +2834,8 @@ static int __init ib_core_init(void)
 	destroy_workqueue(ib_comp_unbound_wq);
 err_comp:
 	destroy_workqueue(ib_comp_wq);
+err_unbound:
+	destroy_workqueue(ib_unbound_wq);
 err:
 	destroy_workqueue(ib_wq);
 	return ret;
@@ -2852,7 +2857,7 @@ static void __exit ib_core_cleanup(void)
 	destroy_workqueue(ib_comp_wq);
 	/* Make sure that any pending umem accounting work is done. */
 	destroy_workqueue(ib_wq);
-	flush_workqueue(system_unbound_wq);
+	destroy_workqueue(ib_unbound_wq);
 	WARN_ON(!xa_empty(&clients));
 	WARN_ON(!xa_empty(&devices));
 }
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 9d6ac9dff39a..65c31c7a3af1 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -360,7 +360,7 @@ static int ucma_event_handler(struct rdma_cm_id *cm_id,
 	if (event->event == RDMA_CM_EVENT_DEVICE_REMOVAL) {
 		xa_lock(&ctx_table);
 		if (xa_load(&ctx_table, ctx->id) == ctx)
-			queue_work(system_unbound_wq, &ctx->close_work);
+			queue_work(ib_unbound_wq, &ctx->close_work);
 		xa_unlock(&ctx_table);
 	}
 	return 0;
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 41c964a45f89..7611a28a4573 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -220,7 +220,7 @@ static void destroy_unused_implicit_child_mr(struct mlx5_ib_mr *mr)
 
 	/* Freeing a MR is a sleeping operation, so bounce to a work queue */
 	INIT_WORK(&mr->odp_destroy.work, free_implicit_child_mr_work);
-	queue_work(system_unbound_wq, &mr->odp_destroy.work);
+	queue_work(ib_unbound_wq, &mr->odp_destroy.work);
 }
 
 static bool mlx5_ib_invalidate_range(struct mmu_interval_notifier *mni,
@@ -1818,6 +1818,6 @@ int mlx5_ib_advise_mr_prefetch(struct ib_pd *pd,
 		destroy_prefetch_work(work);
 		return rc;
 	}
-	queue_work(system_unbound_wq, &work->work);
+	queue_work(ib_unbound_wq, &work->work);
 	return 0;
 }
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index b0bc9de5e9a8..8be23c03f412 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -54,6 +54,7 @@ struct ib_port;
 struct hw_stats_device_data;
 
 extern struct workqueue_struct *ib_wq;
+extern struct workqueue_struct *ib_unbound_wq;
 extern struct workqueue_struct *ib_comp_wq;
 extern struct workqueue_struct *ib_comp_unbound_wq;
 
-- 
2.32.0

