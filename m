Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5245857FF01
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Jul 2022 14:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbiGYM32 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Jul 2022 08:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbiGYM31 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Jul 2022 08:29:27 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614251573A
        for <linux-rdma@vger.kernel.org>; Mon, 25 Jul 2022 05:29:26 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="287696161"
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="287696161"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 05:29:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="926880629"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by fmsmga005.fm.intel.com with ESMTP; 25 Jul 2022 05:29:24 -0700
From:   yanjun.zhu@linux.dev
To:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev
Cc:     syzbot+833061116fa28df97f3b@syzkaller.appspotmail.com
Subject: [PATCHv3 1/1] RDMA/rxe: Fix qp error handler
Date:   Tue, 26 Jul 2022 00:56:31 -0400
Message-Id: <20220726045631.183632-1-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

About 7 spin locks in qp creation needs to be initialized. Now these
spin locks are initialized in the function rxe_qp_init_misc. This
will avoid the error "initialize spin locks before use".

Reported-by: syzbot+833061116fa28df97f3b@syzkaller.appspotmail.com
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
V2->V3: Keep the spin_lock_init in rxe_init_task for future use.
---
 drivers/infiniband/sw/rxe/rxe_qp.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 22e9b85344c3..ae8c51ef2db6 100644
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
2.34.1

