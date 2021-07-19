Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4313CCDBF
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jul 2021 08:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbhGSGEF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Jul 2021 02:04:05 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:47764
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S229916AbhGSGEE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Jul 2021 02:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=Q7+BGXYftvCRag2jvBdOV8u/ImPBworA0uRtGNa9n5w=; b=O
        6xxY12wmjSkSxdFAIsPHmL/5K61bxRfN5VyzvB14XwWxVAIP7q3TWdzBcN5IDd0u
        x00WpOeTkhvoQusi9So2WNUMj3wFgHOfCcPR8otiT4M5G0ff8C6mBSc421gj/07X
        /Nd4kP9NMa9c+LI9QCuSiY7+wKHRwAxFu6RBSWruaE=
Received: from localhost.localdomain (unknown [10.162.86.133])
        by app2 (Coremail) with SMTP id XQUFCgBn4GkYFfVgXUnoBA--.1807S3;
        Mon, 19 Jul 2021 14:00:56 +0800 (CST)
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH] RDMA/hfi1: Convert from atomic_t to refcount_t on hfi1_devdata->user_refcount
Date:   Mon, 19 Jul 2021 14:00:53 +0800
Message-Id: <1626674454-56075-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XQUFCgBn4GkYFfVgXUnoBA--.1807S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAFWkXrWDArykZF45trWxtFb_yoW5Kr4rpF
        4UKry5KFWFqF429a1ktayjvFWfXa4xJ3s5XF95t343uF13Zw4aqFnYkFyUXr95Jrn3Arya
        vr4j9FWUCa1xWaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
        648v4I1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
        8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
        xVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI
        8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r4j6FyUMIIF0xvEx4A2
        jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
        ZFpf9x0JUqFALUUUUU=
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

refcount_t type and corresponding API can protect refcounters from
accidental underflow and overflow and further use-after-free situations.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 drivers/infiniband/hw/hfi1/chip.c     | 2 +-
 drivers/infiniband/hw/hfi1/file_ops.c | 6 +++---
 drivers/infiniband/hw/hfi1/hfi.h      | 3 ++-
 drivers/infiniband/hw/hfi1/init.c     | 2 +-
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index c97544638367..50ffb8244625 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -15336,7 +15336,7 @@ int hfi1_init_dd(struct hfi1_devdata *dd)
 	init_completion(&dd->user_comp);
 
 	/* The user refcount starts with one to inidicate an active device */
-	atomic_set(&dd->user_refcount, 1);
+	refcount_set(&dd->user_refcount, 1);
 
 	goto bail;
 
diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index 955c3637980e..6dbfb794c255 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -194,7 +194,7 @@ static int hfi1_file_open(struct inode *inode, struct file *fp)
 	if (!((dd->flags & HFI1_PRESENT) && dd->kregbase1))
 		return -EINVAL;
 
-	if (!atomic_inc_not_zero(&dd->user_refcount))
+	if (!refcount_inc_not_zero(&dd->user_refcount))
 		return -ENXIO;
 
 	/* The real work is performed later in assign_ctxt() */
@@ -213,7 +213,7 @@ static int hfi1_file_open(struct inode *inode, struct file *fp)
 nomem:
 	kfree(fd);
 	fp->private_data = NULL;
-	if (atomic_dec_and_test(&dd->user_refcount))
+	if (refcount_dec_and_test(&dd->user_refcount))
 		complete(&dd->user_comp);
 	return -ENOMEM;
 }
@@ -711,7 +711,7 @@ static int hfi1_file_close(struct inode *inode, struct file *fp)
 	deallocate_ctxt(uctxt);
 done:
 
-	if (atomic_dec_and_test(&dd->user_refcount))
+	if (refcount_dec_and_test(&dd->user_refcount))
 		complete(&dd->user_comp);
 
 	cleanup_srcu_struct(&fdata->pq_srcu);
diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
index 31664f43c27f..6cf03d16a495 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -48,6 +48,7 @@
  *
  */
 
+#include <linux/refcount.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/dma-mapping.h>
@@ -1384,7 +1385,7 @@ struct hfi1_devdata {
 	/* Number of verbs contexts which have disabled ASPM */
 	atomic_t aspm_disabled_cnt;
 	/* Keeps track of user space clients */
-	atomic_t user_refcount;
+	refcount_t user_refcount;
 	/* Used to wait for outstanding user space clients before dev removal */
 	struct completion user_comp;
 
diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index 0986aa065418..0b2e19a335c5 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -1752,7 +1752,7 @@ static void wait_for_clients(struct hfi1_devdata *dd)
 	 * Remove the device init value and complete the device if there is
 	 * no clients or wait for active clients to finish.
 	 */
-	if (atomic_dec_and_test(&dd->user_refcount))
+	if (refcount_dec_and_test(&dd->user_refcount))
 		complete(&dd->user_comp);
 
 	wait_for_completion(&dd->user_comp);
-- 
2.7.4

