Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6221C507C72
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Apr 2022 00:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344618AbiDSWVx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Apr 2022 18:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239117AbiDSWVw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Apr 2022 18:21:52 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FF322520
        for <linux-rdma@vger.kernel.org>; Tue, 19 Apr 2022 15:19:08 -0700 (PDT)
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 23JMJ0hs050403;
        Wed, 20 Apr 2022 07:19:00 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Wed, 20 Apr 2022 07:19:00 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 23JMJ0Si050399
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 20 Apr 2022 07:19:00 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <252cefb0-a400-83f6-2032-333d69f52c1b@I-love.SAKURA.ne.jp>
Date:   Wed, 20 Apr 2022 07:18:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: [PATCH v2] RDMA/core: Avoid flush_workqueue(system_unbound_wq) usage
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>
References: <0fadd34b-21cf-3a0d-a494-bde7b8dbc3ed@I-love.SAKURA.ne.jp>
 <20220419210134.GO64706@ziepe.ca>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220419210134.GO64706@ziepe.ca>
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

On 2022/04/20 6:01, Jason Gunthorpe wrote:
> The flush_work exists because of this:
> 
>> @@ -1602,7 +1604,7 @@ void ib_unregister_device_queued(struct ib_device *ib_dev)
>>  	WARN_ON(!refcount_read(&ib_dev->refcount));
>>  	WARN_ON(!ib_dev->ops.dealloc_driver);
>>  	get_device(&ib_dev->dev);
>> -	if (!queue_work(system_unbound_wq, &ib_dev->unregistration_work))
>> +	if (!queue_work(ib_unbound_wq, &ib_dev->unregistration_work))
>>  		put_device(&ib_dev->dev);
>>  }
> 
> Which fires off a work that must be completed before the module is
> unloaded.

I see. Here is an updated patch.

> 
> It seems like a big waste to create an entire WQ just for a single
> infrequent user like this.

No need to worry about resource wasting, for creating a WQ without
WQ_MEM_RECLAIM flag consumes little memory.

> 
> Is there some other solution?

No.

From 731f7f167a95946cac52da6cf5964a2904a9164c Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Wed, 20 Apr 2022 07:10:50 +0900
Subject: [PATCH v2] RDMA/core: Avoid flush_workqueue(system_unbound_wq) usage

Flushing system-wide workqueues is dangerous and will be forbidden.
Replace system_unbound_wq with local ib_unbound_wq.

Link: https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Changes in v2:
  Need to use local ib_unbound_wq only when unloading, pointed by Jason Gunthorpe <jgg@ziepe.ca>.

 drivers/infiniband/core/device.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 4deb60a3b43f..f0fdf4dbb458 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -58,6 +58,7 @@ struct workqueue_struct *ib_comp_wq;
 struct workqueue_struct *ib_comp_unbound_wq;
 struct workqueue_struct *ib_wq;
 EXPORT_SYMBOL_GPL(ib_wq);
+static struct workqueue_struct *ib_unbound_wq;
 
 /*
  * Each of the three rwsem locks (devices, clients, client_data) protects the
@@ -1602,7 +1603,7 @@ void ib_unregister_device_queued(struct ib_device *ib_dev)
 	WARN_ON(!refcount_read(&ib_dev->refcount));
 	WARN_ON(!ib_dev->ops.dealloc_driver);
 	get_device(&ib_dev->dev);
-	if (!queue_work(system_unbound_wq, &ib_dev->unregistration_work))
+	if (!queue_work(ib_unbound_wq, &ib_dev->unregistration_work))
 		put_device(&ib_dev->dev);
 }
 EXPORT_SYMBOL(ib_unregister_device_queued);
@@ -2751,27 +2752,28 @@ static const struct rdma_nl_cbs ibnl_ls_cb_table[RDMA_NL_LS_NUM_OPS] = {
 
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
@@ -2831,6 +2833,8 @@ static int __init ib_core_init(void)
 	destroy_workqueue(ib_comp_unbound_wq);
 err_comp:
 	destroy_workqueue(ib_comp_wq);
+err_unbound:
+	destroy_workqueue(ib_unbound_wq);
 err:
 	destroy_workqueue(ib_wq);
 	return ret;
@@ -2852,7 +2856,7 @@ static void __exit ib_core_cleanup(void)
 	destroy_workqueue(ib_comp_wq);
 	/* Make sure that any pending umem accounting work is done. */
 	destroy_workqueue(ib_wq);
-	flush_workqueue(system_unbound_wq);
+	destroy_workqueue(ib_unbound_wq);
 	WARN_ON(!xa_empty(&clients));
 	WARN_ON(!xa_empty(&devices));
 }
-- 
2.32.0


