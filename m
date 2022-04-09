Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE38B4FA0FE
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Apr 2022 03:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiDIBVB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Apr 2022 21:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiDIBVA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Apr 2022 21:21:00 -0400
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8CBFA6398;
        Fri,  8 Apr 2022 18:18:53 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [10.15.192.164])
        by mail-app2 (Coremail) with SMTP id by_KCgBXj0zz3lBi0_JhAQ--.24619S2;
        Sat, 09 Apr 2022 09:18:46 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     linux-kernel@vger.kernel.org
Cc:     linux-rdma@vger.kernel.org, jgg@ziepe.ca, shiraz.saleem@intel.com,
        mustafa.ismail@intel.com, dan.carpenter@oracle.com,
        Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH V5 09/11] drivers: infiniband: hw: Fix deadlock in irdma_cleanup_cm_core()
Date:   Sat,  9 Apr 2022 09:18:42 +0800
Message-Id: <20220409011842.45858-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgBXj0zz3lBi0_JhAQ--.24619S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw13Ar15Xw1rZryxtF43Jrb_yoW8AF4xpr
        WDW34akryq9F42ka18Xw1kZF9xXwn5XFWqvryvv395ZFn7XFyUAFnFyr1jqFZ8JF9Fgrn3
        GF1FvryrCF9Ivr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkI1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v
        1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgAPAVZdtZGdgQAUsr
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is a deadlock in irdma_cleanup_cm_core(), which is shown
below:

   (Thread 1)              |      (Thread 2)
                           | irdma_schedule_cm_timer()
irdma_cleanup_cm_core()    |  add_timer()
 spin_lock_irqsave() //(1) |  (wait a time)
 ...                       | irdma_cm_timer_tick()
 del_timer_sync()          |  spin_lock_irqsave() //(2)
 (wait timer to stop)      |  ...

We hold cm_core->ht_lock in position (1) of thread 1 and
use del_timer_sync() to wait timer to stop, but timer handler
also need cm_core->ht_lock in position (2) of thread 2.
As a result, irdma_cleanup_cm_core() will block forever.

This patch removes the check of timer_pending() in
irdma_cleanup_cm_core(), because the del_timer_sync()
function will just return directly if there isn't a
pending timer. As a result, the lock is redundant,
because there is no resource it could protect.

Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
Changes in V5:
  - Remove mod_timer() in irdma_schedule_cm_timer and irdma_cm_timer_tick.

 drivers/infiniband/hw/irdma/cm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
index dedb3b7edd8..4b6b1065f85 100644
--- a/drivers/infiniband/hw/irdma/cm.c
+++ b/drivers/infiniband/hw/irdma/cm.c
@@ -3251,10 +3251,7 @@ void irdma_cleanup_cm_core(struct irdma_cm_core *cm_core)
 	if (!cm_core)
 		return;
 
-	spin_lock_irqsave(&cm_core->ht_lock, flags);
-	if (timer_pending(&cm_core->tcp_timer))
-		del_timer_sync(&cm_core->tcp_timer);
-	spin_unlock_irqrestore(&cm_core->ht_lock, flags);
+	del_timer_sync(&cm_core->tcp_timer);
 
 	destroy_workqueue(cm_core->event_wq);
 	cm_core->dev->ws_reset(&cm_core->iwdev->vsi);
-- 
2.17.1

