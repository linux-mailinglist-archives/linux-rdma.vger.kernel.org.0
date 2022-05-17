Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BF6529773
	for <lists+linux-rdma@lfdr.de>; Tue, 17 May 2022 04:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiEQClM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 May 2022 22:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238564AbiEQClG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 May 2022 22:41:06 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17132271E
        for <linux-rdma@vger.kernel.org>; Mon, 16 May 2022 19:41:05 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="271155752"
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="271155752"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 19:41:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="596860035"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga008.jf.intel.com with ESMTP; 16 May 2022 19:41:03 -0700
From:   yanjun.zhu@linux.dev
To:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev
Subject: [PATCH 1/1] RDMA/rxe: Compact the function free_rd_atomic_resource
Date:   Tue, 17 May 2022 15:08:00 -0400
Message-Id: <20220517190800.122757-1-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

Compact the function and move it to the header file.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_loc.h  | 11 ++++++++++-
 drivers/infiniband/sw/rxe/rxe_qp.c   | 15 ++-------------
 drivers/infiniband/sw/rxe/rxe_resp.c |  4 ++--
 3 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 409efeecd581..6517b4f104b1 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -145,7 +145,16 @@ static inline int rcv_wqe_size(int max_sge)
 		max_sge * sizeof(struct ib_sge);
 }
 
-void free_rd_atomic_resource(struct rxe_qp *qp, struct resp_res *res);
+static inline void free_rd_atomic_resource(struct resp_res *res)
+{
+	if (res->type == RXE_ATOMIC_MASK) {
+		kfree_skb(res->atomic.skb);
+	} else if (res->type == RXE_READ_MASK) {
+		if (res->read.mr)
+			rxe_drop_ref(res->read.mr);
+	}
+	res->type = 0;
+}
 
 static inline void rxe_advance_resp_resource(struct rxe_qp *qp)
 {
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 5f270cbf18c6..b29208852bc4 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -126,24 +126,13 @@ static void free_rd_atomic_resources(struct rxe_qp *qp)
 		for (i = 0; i < qp->attr.max_dest_rd_atomic; i++) {
 			struct resp_res *res = &qp->resp.resources[i];
 
-			free_rd_atomic_resource(qp, res);
+			free_rd_atomic_resource(res);
 		}
 		kfree(qp->resp.resources);
 		qp->resp.resources = NULL;
 	}
 }
 
-void free_rd_atomic_resource(struct rxe_qp *qp, struct resp_res *res)
-{
-	if (res->type == RXE_ATOMIC_MASK) {
-		kfree_skb(res->atomic.skb);
-	} else if (res->type == RXE_READ_MASK) {
-		if (res->read.mr)
-			rxe_drop_ref(res->read.mr);
-	}
-	res->type = 0;
-}
-
 static void cleanup_rd_atomic_resources(struct rxe_qp *qp)
 {
 	int i;
@@ -152,7 +141,7 @@ static void cleanup_rd_atomic_resources(struct rxe_qp *qp)
 	if (qp->resp.resources) {
 		for (i = 0; i < qp->attr.max_dest_rd_atomic; i++) {
 			res = &qp->resp.resources[i];
-			free_rd_atomic_resource(qp, res);
+			free_rd_atomic_resource(res);
 		}
 	}
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index c369d78fc8e8..923a71ff305c 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -663,7 +663,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 		 */
 		res = &qp->resp.resources[qp->resp.res_head];
 
-		free_rd_atomic_resource(qp, res);
+		free_rd_atomic_resource(res);
 		rxe_advance_resp_resource(qp);
 
 		res->type		= RXE_READ_MASK;
@@ -977,7 +977,7 @@ static int send_atomic_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	}
 
 	res = &qp->resp.resources[qp->resp.res_head];
-	free_rd_atomic_resource(qp, res);
+	free_rd_atomic_resource(res);
 	rxe_advance_resp_resource(qp);
 
 	skb_get(skb);
-- 
2.30.2

