Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934526D58DA
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Apr 2023 08:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbjDDGlX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Apr 2023 02:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjDDGlV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Apr 2023 02:41:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A369C1FC4
        for <linux-rdma@vger.kernel.org>; Mon,  3 Apr 2023 23:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680590480; x=1712126480;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zPUrmbtuWpXMF63jPzJcX8tPApFoVpSKkAiNopXkEmw=;
  b=C35nnzVQr50s5gcsvMLnsI/I+ij2k0fvHnUpF0p5HqtT2OfHgWyr/Gx6
   Q5c6vANEeTVQocMjmJJNtJa+M86ruEltl12Y96UYY5vV0YhDcXyJycpp8
   +6on9OONS2E0Hajd+y6NSBF66Ms/f5virXbiS+UA0P7gHiOTGLRM0nMNH
   spWjKSifGrZwN659Cf/pdO7JI4WLusPjmcR+oPJa7zxWWHCJvCE3MbcNs
   tLsjjlvrWgwrvS1/7jTkTAn3POV44Ri25iZtRuen6UWqqwktMig+MmtD4
   SV6mGEzNZ7pzsYeUWgJaWWt0rPrHYHVRhrkmp7+M7LlHrPzOsFzp7gpRh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="428389297"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="428389297"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 23:41:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="636407708"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="636407708"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga003.jf.intel.com with ESMTP; 03 Apr 2023 23:41:17 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com
Subject: [PATCHv2 1/1] RDMA/rxe: Fix the error "trying to register non-static key in rxe_cleanup_task"
Date:   Tue,  4 Apr 2023 14:38:48 +0800
Message-Id: <20230404063848.3844292-1-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

In the function rxe_create_qp(), rxe_qp_from_init() is called to
initialize qp, internally things like rxe_init_task are not setup until
rxe_qp_init_req().

If an error occures before this point then the unwind will call
rxe_cleanup() and eventually to rxe_qp_do_cleanup()/rxe_cleanup_task()
which will oops when trying to access the uninitialized spinlock.

If rxe_init_task is not executed, rxe_cleanup_task will not be called.

Reported-by: syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=fd85757b74b3eb59f904138486f755f71e090df8

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Fixes: 2d4b21e0a291 ("IB/rxe: Prevent from completer to operate on non valid QP")
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
V1 -> V2: Remove memset functions;
---
 drivers/infiniband/sw/rxe/rxe_qp.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index ab72db68b58f..a1746c4f5448 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -773,15 +773,20 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 
 	qp->valid = 0;
 	qp->qp_timeout_jiffies = 0;
-	rxe_cleanup_task(&qp->resp.task);
+
+	if (qp->resp.task.func)
+		rxe_cleanup_task(&qp->resp.task);
 
 	if (qp_type(qp) == IB_QPT_RC) {
 		del_timer_sync(&qp->retrans_timer);
 		del_timer_sync(&qp->rnr_nak_timer);
 	}
 
-	rxe_cleanup_task(&qp->req.task);
-	rxe_cleanup_task(&qp->comp.task);
+	if (qp->req.task.func)
+		rxe_cleanup_task(&qp->req.task);
+
+	if (qp->comp.task.func)
+		rxe_cleanup_task(&qp->comp.task);
 
 	/* flush out any receive wr's or pending requests */
 	if (qp->req.task.func)
-- 
2.27.0

