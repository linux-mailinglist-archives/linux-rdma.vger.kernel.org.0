Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77F0505BF2
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Apr 2022 17:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243553AbiDRPxZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Apr 2022 11:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346066AbiDRPwj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Apr 2022 11:52:39 -0400
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6430A13D22;
        Mon, 18 Apr 2022 08:33:31 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [10.15.192.164])
        by mail-app3 (Coremail) with SMTP id cC_KCgD3ScrDhF1i+V5vAg--.33517S2;
        Mon, 18 Apr 2022 23:33:27 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     linux-kernel@vger.kernel.org, shiraz.saleem@intel.com
Cc:     mustafa.ismail@intel.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH V6] RDMA/irdma: Fix deadlock in irdma_cleanup_cm_core()
Date:   Mon, 18 Apr 2022 23:33:22 +0800
Message-Id: <20220418153322.42524-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgD3ScrDhF1i+V5vAg--.33517S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw13Ar15Xw1rZryxtF43Jrb_yoW8ArWrpr
        WDWw1Skryq9F42ka18Xw1kAF9xXw1kXa9Fvryqv395ZFn5XFyUAFnFyr10qFZ8JF9Fgr4f
        GF1FvryrCasIvr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAg0EAVZdtZQIiwADsg
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
Changes in V6:
  - Change subject line prefixed with "RDMA/irdma: ".

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

