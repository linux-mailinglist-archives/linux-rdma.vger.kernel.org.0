Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66A45047DD
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Apr 2022 15:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbiDQNRA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 Apr 2022 09:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiDQNRA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 17 Apr 2022 09:17:00 -0400
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED7D4BA5;
        Sun, 17 Apr 2022 06:14:23 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [10.15.192.164])
        by mail-app4 (Coremail) with SMTP id cS_KCgA3rqWmElxiir9bAQ--.56903S2;
        Sun, 17 Apr 2022 21:14:18 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     linux-kernel@vger.kernel.org
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org,
        Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH V5] drivers: infiniband: hw: Fix deadlock in irdma_cleanup_cm_core()
Date:   Sun, 17 Apr 2022 21:14:14 +0800
Message-Id: <20220417131414.98144-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cS_KCgA3rqWmElxiir9bAQ--.56903S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw13Ar15Xw1rZryxtF43Jrb_yoW8AF4xpr
        WDW34akryq9F42ka18Xw1kZF9xXwn5XFWqvryvv395ZFn7XFyUAFnFyr1jqFZ8JF9Fgrn3
        GF1FvryrCF9Ivr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkI1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_
        JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxF
        aVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJw
        CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1a9aPUUUUU==
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgoDAVZdtZOq7gAMsv
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

