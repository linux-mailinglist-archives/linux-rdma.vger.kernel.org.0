Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1007D59B2D6
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Aug 2022 10:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiHUItV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Aug 2022 04:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiHUItT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 Aug 2022 04:49:19 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B7625281
        for <linux-rdma@vger.kernel.org>; Sun, 21 Aug 2022 01:49:17 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10445"; a="276266522"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="276266522"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2022 01:49:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="637791433"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga008.jf.intel.com with ESMTP; 21 Aug 2022 01:49:14 -0700
From:   yanjun.zhu@linux.dev
To:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev, zyjzyj2000@gmail.com
Cc:     syzbot+ab99dc4c6e961eed8b8e@syzkaller.appspotmail.com
Subject: [PATCH 1/3] RDMA/rxe: Fix "kernel NULL pointer dereference" error
Date:   Sun, 21 Aug 2022 21:16:13 -0400
Message-Id: <20220822011615.805603-2-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220822011615.805603-1-yanjun.zhu@linux.dev>
References: <20220822011615.805603-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

When rxe_queue_init in the function rxe_qp_init_req fails,
both qp->req.task.func and qp->req.task.arg are not initialized.

Because of creation of qp fails, the function rxe_create_qp will
call rxe_qp_do_cleanup to handle allocated resource.

Before calling __rxe_do_task, both qp->req.task.func and
qp->req.task.arg should be checked.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Reported-by: syzbot+ab99dc4c6e961eed8b8e@syzkaller.appspotmail.com
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_qp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 516bf9b95e48..f10b461b9963 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -797,7 +797,9 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 	rxe_cleanup_task(&qp->comp.task);
 
 	/* flush out any receive wr's or pending requests */
-	__rxe_do_task(&qp->req.task);
+	if (qp->req.task.func && qp->req.task.arg)
+		__rxe_do_task(&qp->req.task);
+
 	if (qp->sq.queue) {
 		__rxe_do_task(&qp->comp.task);
 		__rxe_do_task(&qp->req.task);
-- 
2.31.1

