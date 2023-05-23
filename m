Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3154170D355
	for <lists+linux-rdma@lfdr.de>; Tue, 23 May 2023 07:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjEWFso (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 May 2023 01:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjEWFsn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 May 2023 01:48:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF6E109
        for <linux-rdma@vger.kernel.org>; Mon, 22 May 2023 22:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684820921; x=1716356921;
  h=from:to:cc:subject:date:message-id:reply-to:mime-version:
   content-transfer-encoding;
  bh=c2qr3XSAYYlAHELNcUAs3Pu4aRPgin/c5+8LWWXvpkE=;
  b=DIBb/ruQoraCjVRLe2MEA/SF5XEL4vXqrh9H4C6F+tUmjVFslHu2EHBI
   450W1BO3STVU5YvwOO8bkk/pEvBtMl60fov5rWILDqDTYF+aDstYZHQdi
   XXKL1iNzDlRu0AW9ki0vQ+G5K6O9UQR4xWGJmYZBTbWuhtuCdX3vI+nv3
   jMVy98PjHdr/xeE63SzeUh6Du4RubGqmbjbjvMtiIC3w+L2rmmYTOc7OM
   z0FqKhQtz7K1Vj/jWjoAAvFfHMN0iB6Q0fdV8xgJ3ZGxjDRdbunQXj3f0
   +yvXwtfftVzEJGvsG9NKc1kx2uygN+Q57U91+0WPIqOt1d7YA0nbrXaHr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="356367193"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="356367193"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 22:48:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="793612450"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="793612450"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by FMSMGA003.fm.intel.com with ESMTP; 22 May 2023 22:48:38 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        syzbot+eba589d8f49c73d356da@syzkaller.appspotmail.com
Subject: [PATCH 1/1] RDMA/rxe: Fix the use-before-initialization error of resp_pkts
Date:   Tue, 23 May 2023 13:47:39 +0800
Message-Id: <20230523054739.594384-1-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
Reply-To: 00000000000063657005fbf44fb2@google.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

In the following:
"
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 assign_lock_key kernel/locking/lockdep.c:982 [inline]
 register_lock_class+0xdb6/0x1120 kernel/locking/lockdep.c:1295
 __lock_acquire+0x10a/0x5df0 kernel/locking/lockdep.c:4951
 lock_acquire kernel/locking/lockdep.c:5691 [inline]
 lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5656
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
 skb_dequeue+0x20/0x180 net/core/skbuff.c:3639
 drain_resp_pkts drivers/infiniband/sw/rxe/rxe_comp.c:555 [inline]
 rxe_completer+0x250d/0x3cc0 drivers/infiniband/sw/rxe/rxe_comp.c:652
 rxe_qp_do_cleanup+0x1be/0x820 drivers/infiniband/sw/rxe/rxe_qp.c:761
 execute_in_process_context+0x3b/0x150 kernel/workqueue.c:3473
 __rxe_cleanup+0x21e/0x370 drivers/infiniband/sw/rxe/rxe_pool.c:233
 rxe_create_qp+0x3f6/0x5f0 drivers/infiniband/sw/rxe/rxe_verbs.c:583
...
"
This is a use-before-initialization problem.

In the following function
"
291 /* called by the create qp verb */
292 int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp,
struct rxe_pd *pd,
297 {
            ...
317         rxe_qp_init_misc(rxe, qp, init);
            ...
322
323         err = rxe_qp_init_resp(rxe, qp, init, udata, uresp);
324         if (err)
325                 goto err2;   <--- error

            ...

334 err2:
335         rxe_queue_cleanup(qp->sq.queue); <--- Goto here
336         qp->sq.queue = NULL;
"
In rxe_qp_init_resp, the error occurs before skb_queue_head_init.
So this call trace appeared.

Reported-by: syzbot+eba589d8f49c73d356da@syzkaller.appspotmail.com
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_qp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index c5451a4488ca..22ef6188d7b1 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -176,6 +176,9 @@ static void rxe_qp_init_misc(struct rxe_dev *rxe, struct rxe_qp *qp,
 	spin_lock_init(&qp->rq.producer_lock);
 	spin_lock_init(&qp->rq.consumer_lock);
 
+	skb_queue_head_init(&qp->req_pkts);
+	skb_queue_head_init(&qp->resp_pkts);
+
 	atomic_set(&qp->ssn, 0);
 	atomic_set(&qp->skb_out, 0);
 }
@@ -234,8 +237,6 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 	qp->req.opcode		= -1;
 	qp->comp.opcode		= -1;
 
-	skb_queue_head_init(&qp->req_pkts);
-
 	rxe_init_task(&qp->req.task, qp, rxe_requester);
 	rxe_init_task(&qp->comp.task, qp, rxe_completer);
 
@@ -279,8 +280,6 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
 		}
 	}
 
-	skb_queue_head_init(&qp->resp_pkts);
-
 	rxe_init_task(&qp->resp.task, qp, rxe_responder);
 
 	qp->resp.opcode		= OPCODE_NONE;
-- 
2.27.0

