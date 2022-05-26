Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2776E533A9D
	for <lists+linux-rdma@lfdr.de>; Wed, 25 May 2022 12:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbiEYK2L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 May 2022 06:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbiEYK2J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 May 2022 06:28:09 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B53939B7
        for <linux-rdma@vger.kernel.org>; Wed, 25 May 2022 03:28:08 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="254276779"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="254276779"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 03:28:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="548944861"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga006.jf.intel.com with ESMTP; 25 May 2022 03:28:05 -0700
From:   yanjun.zhu@linux.dev
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, yanjun.zhu@linux.dev
Cc:     syzbot+833061116fa28df97f3b@syzkaller.appspotmail.com
Subject: [PATCH 1/1] RDMA/rxe: Fix qp error handler
Date:   Wed, 25 May 2022 22:54:38 -0400
Message-Id: <20220526025438.572870-1-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

Move the qp error handler to be near the rxe_create_qp.

Reported-by: syzbot+833061116fa28df97f3b@syzkaller.appspotmail.com
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_qp.c    | 14 ++++++++++----
 drivers/infiniband/sw/rxe/rxe_verbs.c |  1 -
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 22e9b85344c3..f73ca567a8b3 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -220,8 +220,7 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 			   &qp->sq.queue->ip);
 
 	if (err) {
-		vfree(qp->sq.queue->buf);
-		kfree(qp->sq.queue);
+		rxe_queue_cleanup(qp->sq.queue);
 		qp->sq.queue = NULL;
 		return err;
 	}
@@ -277,8 +276,7 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
 				   qp->rq.queue->buf, qp->rq.queue->buf_size,
 				   &qp->rq.queue->ip);
 		if (err) {
-			vfree(qp->rq.queue->buf);
-			kfree(qp->rq.queue);
+			rxe_queue_cleanup(qp->rq.queue);
 			qp->rq.queue = NULL;
 			return err;
 		}
@@ -341,6 +339,14 @@ int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
 	return 0;
 
 err2:
+	if (qp_type(qp) == IB_QPT_RC) {
+		del_timer_sync(&qp->retrans_timer);
+		del_timer_sync(&qp->rnr_nak_timer);
+	}
+
+	rxe_cleanup_task(&qp->req.task);
+	rxe_cleanup_task(&qp->comp.task);
+
 	rxe_queue_cleanup(qp->sq.queue);
 	qp->sq.queue = NULL;
 err1:
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 9d995854a174..d0bc195b572f 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -432,7 +432,6 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 	return 0;
 
 qp_init:
-	rxe_put(qp);
 	return err;
 }
 
-- 
2.31.1

