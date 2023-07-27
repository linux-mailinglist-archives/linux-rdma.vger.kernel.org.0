Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91C07655B0
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 16:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbjG0OPT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 10:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbjG0OPS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 10:15:18 -0400
Received: from out-100.mta0.migadu.com (out-100.mta0.migadu.com [91.218.175.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2E42D5E
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 07:15:17 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690466650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bRgBlOvgMtJkKPvZ+rZA/rDDK35v+k0caMBtftQig+8=;
        b=obcU1LVOyFROKIouJPPv/Hfx/g7xRbWF4X3W681fBfOPXvccqvl0AKD8EIPdFIEuHKBlAp
        dK+hVU1Igrb0Naoe+kTo7khTMI6kJPfbvcmWYYjZzEJQsM9BZQCBk2BIRN+Y+rg9U/3iOB
        Zy8RTjcVSmRouLzTurdN8EJ17BcixyM=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 5/5] RDMA/siw: Don't call wake_up unconditionally in siw_stop_tx_thread
Date:   Thu, 27 Jul 2023 22:03:49 +0800
Message-Id: <20230727140349.25369-6-guoqing.jiang@linux.dev>
In-Reply-To: <20230727140349.25369-1-guoqing.jiang@linux.dev>
References: <20230727140349.25369-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In case siw module can't be inserted successfully, and if the kthread
(siw_run_sq) is not run which means wait_queue_head (tx_task->waiting)
is not initialized. Then siw_stop_tx_thread is called from siw_init_module,
so below trace appeared.

kernel: BUG: spinlock bad magic on CPU#0, modprobe/2073
kernel:  lock: 0xffff88babbd380e8, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
kernel: CPU: 0 PID: 2073 Comm: modprobe Tainted: G           OE      6.5.0-rc3+ #16
kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552c-rebuilt.opensuse.org 04/01/2014
kernel: Call Trace:
kernel:  <TASK>
kernel:  dump_stack_lvl+0x77/0xd0
kernel:  dump_stack+0x10/0x20
kernel:  spin_bug+0xa5/0xd0
kernel:  do_raw_spin_lock+0x90/0xd0
kernel:  _raw_spin_lock_irqsave+0x56/0x80
kernel:  ? __wake_up_common_lock+0x63/0xd0
kernel:  __wake_up_common_lock+0x63/0xd0
kernel:  __wake_up+0x13/0x30
kernel:  siw_stop_tx_thread+0x49/0x70 [siw]
kernel:  siw_init_module+0x15b/0xff0 [siw]
kernel:  ? __pfx_siw_init_module+0x10/0x10 [siw]
kernel:  do_one_initcall+0x60/0x390
...
kernel:  </TASK>
kernel: BUG: kernel NULL pointer dereference, address: 0000000000000000

To prevent the issue, add 'running' to tx_task_t, which is set to after
siw_run_sq is triggered. Then only wake up waitqueue after it is true.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_qp_tx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 7c7a51d36d0c..70acc4cd553f 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -1204,14 +1204,18 @@ static void siw_sq_resume(struct siw_qp *qp)
 struct tx_task_t {
 	struct llist_head active;
 	wait_queue_head_t waiting;
+	bool running;
 };
 
 static DEFINE_PER_CPU(struct tx_task_t, siw_tx_task_g);
 
 void siw_stop_tx_thread(int nr_cpu)
 {
+	struct tx_task_t *tx_task = &per_cpu(siw_tx_task_g, nr_cpu);
+
 	kthread_stop(siw_tx_thread[nr_cpu]);
-	wake_up(&per_cpu(siw_tx_task_g, nr_cpu).waiting);
+	if (tx_task->running)
+		wake_up(&per_cpu(siw_tx_task_g, nr_cpu).waiting);
 }
 
 int siw_run_sq(void *data)
@@ -1223,6 +1227,7 @@ int siw_run_sq(void *data)
 
 	init_llist_head(&tx_task->active);
 	init_waitqueue_head(&tx_task->waiting);
+	tx_task->running = true;
 
 	while (1) {
 		struct llist_node *fifo_list = NULL;
-- 
2.34.1

