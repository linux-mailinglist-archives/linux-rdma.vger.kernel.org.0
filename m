Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A5B707A7D
	for <lists+linux-rdma@lfdr.de>; Thu, 18 May 2023 09:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjERHB6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 May 2023 03:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjERHB4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 May 2023 03:01:56 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 18 May 2023 00:01:54 PDT
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCDA2D4F
        for <linux-rdma@vger.kernel.org>; Thu, 18 May 2023 00:01:54 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="116573297"
X-IronPort-AV: E=Sophos;i="5.99,284,1677510000"; 
   d="scan'208";a="116573297"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 16:00:50 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id ED7FDD3EB7
        for <linux-rdma@vger.kernel.org>; Thu, 18 May 2023 16:00:47 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (m3003.s.css.fujitsu.com [10.128.233.114])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 3729DD969E
        for <linux-rdma@vger.kernel.org>; Thu, 18 May 2023 16:00:47 +0900 (JST)
Received: from localhost.localdomain (unknown [10.118.237.106])
        by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 129EA2041EEB;
        Thu, 18 May 2023 16:00:47 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     linux-rdma@vger.kernel.org, jgg@nvidia.com, rpearsonhpe@gmail.com
Cc:     leonro@nvidia.com, zyjzyj2000@gmail.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH jgg-for-next] RDMA/rxe: Fix comments about removed tasklets
Date:   Thu, 18 May 2023 16:00:27 +0900
Message-Id: <20230518070027.942715-1-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The commit 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for rxe tasks")
removed tasklets and replaced them with a workqueue, but relevant comments
are still remaining in the source code.

Fixes: 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for rxe tasks")
Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c  | 2 +-
 drivers/infiniband/sw/rxe/rxe_param.h | 2 +-
 drivers/infiniband/sw/rxe/rxe_req.c   | 2 +-
 drivers/infiniband/sw/rxe/rxe_resp.c  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index db18ace74d2b..0c0ae214c3a9 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -826,7 +826,7 @@ int rxe_completer(struct rxe_qp *qp)
 	}
 
 	/* A non-zero return value will cause rxe_do_task to
-	 * exit its loop and end the tasklet. A zero return
+	 * exit its loop and end the work item. A zero return
 	 * will continue looping and return to rxe_completer
 	 */
 done:
diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 7b41d79e72b2..d2f57ead78ad 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -112,7 +112,7 @@ enum rxe_device_param {
 	RXE_INFLIGHT_SKBS_PER_QP_HIGH	= 64,
 	RXE_INFLIGHT_SKBS_PER_QP_LOW	= 16,
 
-	/* Max number of interations of each tasklet
+	/* Max number of interations of each work item
 	 * before yielding the cpu to let other
 	 * work make progress
 	 */
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 65134a9aefe7..400840c913a9 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -853,7 +853,7 @@ int rxe_requester(struct rxe_qp *qp)
 	update_state(qp, &pkt);
 
 	/* A non-zero return value will cause rxe_do_task to
-	 * exit its loop and end the tasklet. A zero return
+	 * exit its loop and end the work item. A zero return
 	 * will continue looping and return to rxe_requester
 	 */
 done:
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 68f6cd188d8e..b92c41cdb620 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -1654,7 +1654,7 @@ int rxe_responder(struct rxe_qp *qp)
 	}
 
 	/* A non-zero return value will cause rxe_do_task to
-	 * exit its loop and end the tasklet. A zero return
+	 * exit its loop and end the work item. A zero return
 	 * will continue looping and return to rxe_responder
 	 */
 done:
-- 
2.39.1

