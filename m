Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 571F815A1F0
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2020 08:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbgBLH1E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Feb 2020 02:27:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:59798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728329AbgBLH1E (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Feb 2020 02:27:04 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F6C22082F;
        Wed, 12 Feb 2020 07:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581492423;
        bh=pCoeSZfs2f8IrNoSWugPCwW+l4OU/Emg1V08aXOXa40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=alNDbwJn3WpCUCoR2zONWosXN+sorXckm91RE8HeKu9u7Uqi8W4CyCQxa69tUOh+k
         MTppj5ttaHGmVmwgShYWVyyun72kqOh+vsZZG02hKd1Mz+6dKWPThPBP4uDUfvtwAc
         8+PX0nnemL39Ge3c+vTLtE8StKV1tYL03Oq3DA0E=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Erez Shitrit <erezsh@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Maor Gottlieb <maorg@mellanox.com>,
        Michael Guralnik <michaelgur@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Valentine Fatiev <valentinef@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Yonatan Cohen <yonatanc@mellanox.com>,
        Zhu Yanjun <yanjunz@mellanox.com>
Subject: [PATCH rdma-rc 7/9] RDMA/rxe: Fix soft lockup problem due to using tasklets in softirq
Date:   Wed, 12 Feb 2020 09:26:33 +0200
Message-Id: <20200212072635.682689-8-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200212072635.682689-1-leon@kernel.org>
References: <20200212072635.682689-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjunz@mellanox.com>

When run stress tests with RXE, the following Call Traces often occur
"
watchdog: BUG: soft lockup - CPU#2 stuck for 22s! [swapper/2:0]
...
Call Trace:
<IRQ>
create_object+0x3f/0x3b0
kmem_cache_alloc_node_trace+0x129/0x2d0
__kmalloc_reserve.isra.52+0x2e/0x80
__alloc_skb+0x83/0x270
rxe_init_packet+0x99/0x150 [rdma_rxe]
rxe_requester+0x34e/0x11a0 [rdma_rxe]
rxe_do_task+0x85/0xf0 [rdma_rxe]
tasklet_action_common.isra.21+0xeb/0x100
__do_softirq+0xd0/0x298
irq_exit+0xc5/0xd0
smp_apic_timer_interrupt+0x68/0x120
apic_timer_interrupt+0xf/0x20
</IRQ>
...
"
The root cause is that tasklet is actually a softirq. In a tasklet handler,
another softirq handler is triggered. Usually these softirq handlers run
on the same cpu core. So this will cause "soft lockup Bug".

Fixes: 8700e3e7c485 ("Soft RoCE driver")
CC: Yossef Efraim <yossefe@mellanox.com>
Signed-off-by: Zhu Yanjun <yanjunz@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 116cafc9afcf..4bc88708b355 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -329,7 +329,7 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
 					qp->comp.psn = pkt->psn;
 					if (qp->req.wait_psn) {
 						qp->req.wait_psn = 0;
-						rxe_run_task(&qp->req.task, 1);
+						rxe_run_task(&qp->req.task, 0);
 					}
 				}
 				return COMPST_ERROR_RETRY;
@@ -463,7 +463,7 @@ static void do_complete(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	 */
 	if (qp->req.wait_fence) {
 		qp->req.wait_fence = 0;
-		rxe_run_task(&qp->req.task, 1);
+		rxe_run_task(&qp->req.task, 0);
 	}
 }
 
@@ -479,7 +479,7 @@ static inline enum comp_state complete_ack(struct rxe_qp *qp,
 		if (qp->req.need_rd_atomic) {
 			qp->comp.timeout_retry = 0;
 			qp->req.need_rd_atomic = 0;
-			rxe_run_task(&qp->req.task, 1);
+			rxe_run_task(&qp->req.task, 0);
 		}
 	}
 
@@ -725,7 +725,7 @@ int rxe_completer(void *arg)
 							RXE_CNT_COMP_RETRY);
 					qp->req.need_retry = 1;
 					qp->comp.started_retry = 1;
-					rxe_run_task(&qp->req.task, 1);
+					rxe_run_task(&qp->req.task, 0);
 				}
 
 				if (pkt) {
-- 
2.24.1

