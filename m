Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1F84B0757
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Feb 2022 08:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbiBJHhS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Feb 2022 02:37:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbiBJHhN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Feb 2022 02:37:13 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2519BF4
        for <linux-rdma@vger.kernel.org>; Wed,  9 Feb 2022 23:37:14 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1644478633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=evxpqzsNzQqSQfp0HWLeS9ofh9hXhS2Uc635wtLFMsU=;
        b=kQhZE9E4LUYUdBY2L4ETEDKzT2o28Q42X1UmDYhe3Ia1acahLMPFR7sAro4+Pg2/rXl/wg
        oobLrcoRoF9C0SV+a158/k2HOH6uRwnexclOC2yqk8glwNmJNmUP6ic5XakC7pIXcG8jik
        hlvwYD2SGD6AMgMs4und9OPCzPwHRAI=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, rpearsonhpe@gmail.com
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 3/3] RDMA/rxe: Replace spin_lock_bh with spin_lock_irqsave in post_one_send
Date:   Thu, 10 Feb 2022 15:36:55 +0800
Message-Id: <20220210073655.42281-4-guoqing.jiang@linux.dev>
In-Reply-To: <20220210073655.42281-1-guoqing.jiang@linux.dev>
References: <20220210073655.42281-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Same as __rxe_add_index, the lock need to be fully IRQ safe, otherwise
below calltrace appears.

[  763.942623] ------------[ cut here ]------------
[  763.943171] WARNING: CPU: 5 PID: 97 at kernel/softirq.c:363 __local_bh_enable_ip+0xb1/0x110
[ ... ]
[  763.947276] CPU: 5 PID: 97 Comm: kworker/5:2 Kdump: loaded Tainted: G           OEL    5.17.0-rc3-57-default #17
[  763.947575] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
[  763.947893] Workqueue: ib_cm cm_work_handler [ib_cm]
[  763.948075] RIP: 0010:__local_bh_enable_ip+0xb1/0x110
[  763.948232] Code: e8 54 ae 04 00 e8 7f 4e 20 00 fb 66 0f 1f 44 00 00 65 8b 05 b1 03 f3 56 85 c0 74 51 5b 5d c3 65 8b 05 3f 0f f3 56
85 c0 75 8e <0f> 0b eb 8a e8 76 4c 20 00 eb 99 48 89 ef e8 9c 8d 0b 00 eb a2 48
[  763.948736] RSP: 0018:ffff888004a970e8 EFLAGS: 00010046
[  763.948897] RAX: 0000000000000000 RBX: 0000000000000201 RCX: dffffc0000000000
[  763.949095] RDX: 0000000000000007 RSI: 0000000000000201 RDI: ffffffffab95dbac
[  763.949292] RBP: ffffffffc127c269 R08: ffffffffa91059da R09: ffff88800afde323
[  763.949556] R10: ffffed10015fbc64 R11: 0000000000000001 R12: ffffc900005a2000
[  763.949781] R13: 0000000000000000 R14: 0000000000000000 R15: ffff88800afde000
[  763.949982] FS:  0000000000000000(0000) GS:ffff888104c80000(0000) knlGS:0000000000000000
[  763.950205] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  763.950367] CR2: 00007f85ec3f5b18 CR3: 0000000116216005 CR4: 0000000000770ee0
[  763.956480] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  763.962608] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  763.968785] PKRU: 55555554
[  763.974707] Call Trace:
[  763.980557]  <TASK>
[  763.986377]  rxe_post_send+0x569/0x8e0 [rdma_rxe]
[  763.992340]  ib_send_mad+0x4c1/0x850 [ib_core]
[  763.998442]  ? ib_register_mad_agent+0x1710/0x1710 [ib_core]
[  764.004486]  ? __kmalloc+0x21d/0x3a0
[  764.010465]  ib_post_send_mad+0x28c/0x10b0 [ib_core]
[  764.016480]  ? lock_is_held_type+0xe4/0x140
[  764.022359]  ? find_held_lock+0x85/0xa0
[  764.028230]  ? lock_release+0x24e/0x450
[  764.034061]  ? timeout_sends+0x420/0x420 [ib_core]
[  764.039879]  ? ib_create_send_mad+0x541/0x670 [ib_core]
[  764.045604]  ? do_raw_spin_unlock+0x86/0xf0
[  764.051178]  ? preempt_count_sub+0x14/0xc0
[  764.056851]  ? lock_is_held_type+0xe4/0x140
[  764.062412]  ib_send_cm_rep+0x47a/0x860 [ib_cm]
[  764.067965]  rdma_accept+0x44c/0x5e0 [rdma_cm]
[  764.073381]  ? cma_rep_recv+0x330/0x330 [rdma_cm]
[  764.078762]  ? rcu_read_lock_sched_held+0x3f/0x60
[  764.084072]  ? trace_kmalloc+0x29/0xd0
[  764.089185]  ? __kmalloc+0x1c5/0x3a0
[  764.094185]  ? rtrs_iu_alloc+0x12b/0x260 [rtrs_core]
[  764.099075]  rtrs_srv_rdma_cm_handler+0x7ba/0xcf0 [rtrs_server]
[  764.103917]  ? rtrs_srv_inv_rkey_done+0x100/0x100 [rtrs_server]
[  764.108563]  ? find_held_lock+0x85/0xa0
[  764.113033]  ? lock_release+0x24e/0x450
[  764.117452]  ? rdma_restrack_add+0x9c/0x220 [ib_core]
[  764.121797]  ? rcu_read_lock_sched_held+0x3f/0x60
[  764.125961]  cma_cm_event_handler+0x77/0x2c0 [rdma_cm]
[  764.130061]  cma_ib_req_handler+0xbd5/0x23f0 [rdma_cm]
[  764.134027]  ? cma_cancel_operation+0x1f0/0x1f0 [rdma_cm]
[  764.137950]  ? lockdep_lock+0xb4/0x170
[  764.141667]  ? _find_first_zero_bit+0x28/0x50
[  764.145486]  ? mark_held_locks+0x65/0x90
[  764.149002]  cm_process_work+0x2f/0x210 [ib_cm]
[  764.152413]  ? _raw_spin_unlock_irq+0x35/0x50
[  764.155763]  ? cm_queue_work_unlock+0x40/0x110 [ib_cm]
[  764.159080]  cm_req_handler+0xf7f/0x2030 [ib_cm]
[  764.162522]  ? cm_lap_handler+0xba0/0xba0 [ib_cm]
[  764.165847]  ? lockdep_hardirqs_on_prepare+0x220/0x220
[  764.169155]  cm_work_handler+0x6ce/0x37c0 [ib_cm]
[  764.172497]  ? lock_acquire+0x182/0x410
[  764.175771]  ? lock_release+0x450/0x450
[  764.178925]  ? lock_downgrade+0x3c0/0x3c0
[  764.182148]  ? ib_cm_init_qp_attr+0xa90/0xa90 [ib_cm]
[  764.185511]  ? mark_held_locks+0x24/0x90
[  764.188692]  ? lock_is_held_type+0xe4/0x140
[  764.191876]  process_one_work+0x5a8/0xa80
[  764.195034]  ? lock_release+0x450/0x450
[  764.198208]  ? pwq_dec_nr_in_flight+0x100/0x100
[  764.201433]  ? rwlock_bug.part.0+0x60/0x60
[  764.204660]  ? _raw_spin_lock_irq+0x54/0x60
[  764.207835]  worker_thread+0x2b5/0x760
[  764.210920]  ? process_one_work+0xa80/0xa80
[  764.214014]  kthread+0x169/0x1a0
[  764.217033]  ? kthread_complete_and_exit+0x20/0x20
[  764.220205]  ret_from_fork+0x1f/0x30
[  764.223467]  </TASK>
[  764.226482] irq event stamp: 55805
[  764.229527] hardirqs last  enabled at (55803): [<ffffffffaa179c6d>] _raw_spin_unlock_irqrestore+0x2d/0x60
[  764.232779] hardirqs last disabled at (55804): [<ffffffffaa179a10>] _raw_spin_lock_irqsave+0x60/0x70
[  764.236052] softirqs last  enabled at (55794): [<ffffffffc127cb68>] rxe_post_recv+0xb8/0x120 [rdma_rxe]
[  764.239428] softirqs last disabled at (55805): [<ffffffffc127beeb>] rxe_post_send+0x1eb/0x8e0 [rdma_rxe]
[  764.242740] ---[ end trace 0000000000000000 ]---

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 9f0aef4b649d..0056418425a1 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -644,12 +644,13 @@ static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 	struct rxe_sq *sq = &qp->sq;
 	struct rxe_send_wqe *send_wqe;
 	int full;
+	unsigned long flags;
 
 	err = validate_send_wr(qp, ibwr, mask, length);
 	if (err)
 		return err;
 
-	spin_lock_bh(&qp->sq.sq_lock);
+	spin_lock_irqsave(&qp->sq.sq_lock, flags);
 
 	full = queue_full(sq->queue, QUEUE_TYPE_TO_DRIVER);
 
@@ -663,7 +664,7 @@ static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 
 	queue_advance_producer(sq->queue, QUEUE_TYPE_TO_DRIVER);
 
-	spin_unlock_bh(&qp->sq.sq_lock);
+	spin_unlock_irqrestore(&qp->sq.sq_lock, flags);
 
 	return 0;
 }
-- 
2.26.2

