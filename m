Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AAB56632B
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Jul 2022 08:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiGEG0t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jul 2022 02:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiGEG0o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Jul 2022 02:26:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD41210FEE
        for <linux-rdma@vger.kernel.org>; Mon,  4 Jul 2022 23:26:43 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="263056999"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="263056999"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 23:26:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="649957465"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jul 2022 23:26:42 -0700
From:   yanjun.zhu@linux.dev
To:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev
Subject: [PATCHv2 1/1] RDMA/rxe: Fix BUG: KASAN: null-ptr-deref in rxe_qp_do_cleanup
Date:   Tue,  5 Jul 2022 18:54:14 -0400
Message-Id: <20220705225414.315478-1-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

The function rxe_create_qp calls rxe_qp_from_init. If some error
occurs, the error handler of function rxe_qp_from_init will set
both scq and rcq to NULL.

Then rxe_create_qp calls rxe_put to handle qp. In the end,
rxe_qp_do_cleanup is called by rxe_put. rxe_qp_do_cleanup directly
accesses scq and rcq before checking them. This will cause 
null-ptr-deref error.

The call graph is as below:

rxe_create_qp {
  ...
  rxe_qp_from_init {
    ...
  err1:
    ...
    qp->rcq = NULL;  <---rcq is set to NULL
    qp->scq = NULL;  <---scq is set to NULL
    ...
  }
        
qp_init:
  rxe_put{
    ...
    rxe_qp_do_cleanup {
      ...
      atomic_dec(&qp->scq->num_wq); <--- scq is accessed
      ...
      atomic_dec(&qp->rcq->num_wq); <--- rcq is accessed
    }
}

Fixes: 4703b4f0d94a ("RDMA/rxe: Enforce IBA C11-17")
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
V1->V2: Describe the error flows.
---
 drivers/infiniband/sw/rxe/rxe_qp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 22e9b85344c3..b79e1b43454e 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -804,13 +804,15 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 	if (qp->rq.queue)
 		rxe_queue_cleanup(qp->rq.queue);
 
-	atomic_dec(&qp->scq->num_wq);
-	if (qp->scq)
+	if (qp->scq) {
+		atomic_dec(&qp->scq->num_wq);
 		rxe_put(qp->scq);
+	}
 
-	atomic_dec(&qp->rcq->num_wq);
-	if (qp->rcq)
+	if (qp->rcq) {
+		atomic_dec(&qp->rcq->num_wq);
 		rxe_put(qp->rcq);
+	}
 
 	if (qp->pd)
 		rxe_put(qp->pd);
-- 
2.34.1

