Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19086E0ADC
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Apr 2023 11:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjDMJ7R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Apr 2023 05:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjDMJ7R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Apr 2023 05:59:17 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B2465BC
        for <linux-rdma@vger.kernel.org>; Thu, 13 Apr 2023 02:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681379956; x=1712915956;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EzvdQ+MSLRXo6lKvnQkcNKLkFuQPWMmevwF9ger/1Dg=;
  b=X/WJEwUkrm2OYQf2yGvvRm31uxRlWn63hlI5lSObTRxpqEmFdZPuBlFJ
   ViCafStPiMHI45ECXJen+gOCqC/nu/HMazvvZo3UyKb6oQI10QWy9GD9/
   QDWbCgMi7PUX6uC4UNarQkj1sbgpt4HHjYcS7/5n3Wmu7A1hPpL+1ffig
   EKxdLDK3fyu2NS+6Yx3dEEvyI2AThGIyrMwjIJ9JL+3chNCxWiezqxOBD
   jlngLbphMFt2MU8W7MZJ8CsxmQY9U7iJ2PpnQsks8BUF6EgbBCcQtd45C
   ms/g21q7xoxhxasuxoz6oNrxEyCpuYDGqCnqFH4Er/UIHcRz6jTW8Psn5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="406979627"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="406979627"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 02:59:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="935534048"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="935534048"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by fmsmga006.fm.intel.com with ESMTP; 13 Apr 2023 02:59:13 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com,
        Zhu Yanjun <yanjun.zhu@intel.com>
Subject: [PATCH rdma-next v3 1/1] RDMA/rxe: Fix the error "trying to register non-static key in rxe_cleanup_task"
Date:   Thu, 13 Apr 2023 17:56:16 +0800
Message-Id: <20230413095616.1365762-1-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
Signed-off-by: Zhu Yanjun <yanjun.zhu@intel.com>
---
V2 -> V3: Rebase to rdma-next;
V1 -> V2: Remove memset functions;
---
 drivers/infiniband/sw/rxe/rxe_qp.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 49891f8ed4e6..d5de5ba6940f 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -761,9 +761,14 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 		del_timer_sync(&qp->rnr_nak_timer);
 	}
 
-	rxe_cleanup_task(&qp->resp.task);
-	rxe_cleanup_task(&qp->req.task);
-	rxe_cleanup_task(&qp->comp.task);
+	if (qp->resp.task.func)
+		rxe_cleanup_task(&qp->resp.task);
+
+	if (qp->req.task.func)
+		rxe_cleanup_task(&qp->req.task);
+
+	if (qp->comp.task.func)
+		rxe_cleanup_task(&qp->comp.task);
 
 	/* flush out any receive wr's or pending requests */
 	rxe_requester(qp);
-- 
2.27.0

