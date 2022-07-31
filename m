Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E91585AAB
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Jul 2022 16:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbiG3OJd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 30 Jul 2022 10:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiG3OJc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 30 Jul 2022 10:09:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239A717591
        for <linux-rdma@vger.kernel.org>; Sat, 30 Jul 2022 07:09:31 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="289688563"
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="289688563"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 07:09:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="743813446"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jul 2022 07:09:29 -0700
From:   yanjun.zhu@linux.dev
To:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev
Cc:     syzbot+833061116fa28df97f3b@syzkaller.appspotmail.com
Subject: [PATCHv4 1/1] RDMA/rxe: Fix qp error handler
Date:   Sun, 31 Jul 2022 02:36:21 -0400
Message-Id: <20220731063621.298405-1-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

This problem is in this link:
news://nntp.lore.kernel.org:119/0000000000006ed46805dfaded18@google.com

this is an error unwind problem.

In the function rxe_create_qp, rxe_qp_from_init is called to initialize qp.
rxe_qp_init_req is called by rxe_qp_from_init. If an error occurs before
spin_lock_init in rxe_qp_init_req, several spin locks are not initialized.
Then rxe_create_qp finally calls rxe_cleanup(qp) to handle errors.

In the end, rxe_qp_do_cleanup is called. In this function, rxe_cleanup_task
will call spin_lock_bh. But task->state_lock is not initialized.

As such, an uninitialized spin lock is called by spin_lock_bh.

rxe_create_qp {
        ...
        err = rxe_qp_from_init(rxe, qp, pd, init, uresp, ibqp->pd, udata);
        if (err)
                goto qp_init;
        ...
        return 0;

qp_init:
        rxe_cleanup(qp);
        return err;
}

rxe_qp_do_cleanup {
  ...
  rxe_cleanup_task {
    ...
    spin_lock_bh(&task->state_lock);
    ...
  }
}

rxe_qp_from_init {
...
        rxe_qp_init_misc(rxe, qp, init);

        err = rxe_qp_init_req{
                ...
                spin_lock_init(&qp->sq.sq_lock);
                ...
                rxe_init_task{
                  ...
                  spin_lock_init(&task->state_lock);
                  ...
                }
              }
        if (err)
                goto err1;

        err = rxe_qp_init_resp {
                ...
                spin_lock_init(&qp->rq.producer_lock);
                spin_lock_init(&qp->rq.consumer_lock);
                ...
                rxe_init_task {
                  ...
                  spin_lock_init(&task->state_lock);
                  ...
                }
              }

        if (err)
                goto err2;
...
        return 0;

err2:
        ...
err1:
        ...
        return err;
}

About 7 spin locks in qp creation needs to be initialized. Now these
spin locks are initialized in the function rxe_qp_init_misc. This
will avoid the error "initialize spin locks before use".

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Reported-by: syzbot+833061116fa28df97f3b@syzkaller.appspotmail.com
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_qp.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index b79e1b43454e..7a223583cf8b 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -174,6 +174,14 @@ static void rxe_qp_init_misc(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	spin_lock_init(&qp->state_lock);
 
+	spin_lock_init(&qp->req.task.state_lock);
+	spin_lock_init(&qp->resp.task.state_lock);
+	spin_lock_init(&qp->comp.task.state_lock);
+
+	spin_lock_init(&qp->sq.sq_lock);
+	spin_lock_init(&qp->rq.producer_lock);
+	spin_lock_init(&qp->rq.consumer_lock);
+
 	atomic_set(&qp->ssn, 0);
 	atomic_set(&qp->skb_out, 0);
 }
@@ -233,7 +241,6 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 	qp->req.opcode		= -1;
 	qp->comp.opcode		= -1;
 
-	spin_lock_init(&qp->sq.sq_lock);
 	skb_queue_head_init(&qp->req_pkts);
 
 	rxe_init_task(rxe, &qp->req.task, qp,
@@ -284,9 +291,6 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
 		}
 	}
 
-	spin_lock_init(&qp->rq.producer_lock);
-	spin_lock_init(&qp->rq.consumer_lock);
-
 	skb_queue_head_init(&qp->resp_pkts);
 
 	rxe_init_task(rxe, &qp->resp.task, qp,
-- 
2.27.0

