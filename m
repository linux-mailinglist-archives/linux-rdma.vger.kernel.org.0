Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322416E6232
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Apr 2023 14:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjDRMa6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Apr 2023 08:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjDRMap (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Apr 2023 08:30:45 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B61FD300
        for <linux-rdma@vger.kernel.org>; Tue, 18 Apr 2023 05:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681821024; x=1713357024;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=G9PzDfWdHrv+v0Jlu3F6EwDNc5vcUSwLDpHWQWPpK1c=;
  b=WeURYnB/5omsiMHA5P3mF1fQPPIdzAlWwQEC3YNQr+xb/FP0+3wMQAFP
   fGcHijGFAsFC9G/+7a3MLyylBCZ11dNf6EdYjfLVJd0AWxanSga3xrvEL
   SVkJ7iAYs6AhxfdRdVjVgw/GOKvEKmyVx8BfdU5PFdrY6r8cMx31y9fvT
   KBszLcLCtjHQYG7QItgMHn/vrKR8WZv76LziU7g+tEZQj2990hjeFKu2j
   OlqlNr48VMqKigl3Iyf2GBEsA6japfb7KZSamwYKitp8RvRM/0yiJYvhc
   6xHgNUZcEWIzot6CPATgHOpf9q2di8dwJKHkCP9/hCnUL22Z6QFxHmrvU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="410374721"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="410374721"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 05:29:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="760339623"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="760339623"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by fmsmga004.fm.intel.com with ESMTP; 18 Apr 2023 05:29:23 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH 1/1] RDMA/rxe: Add function name to the logs
Date:   Tue, 18 Apr 2023 20:26:11 +0800
Message-Id: <20230418122611.1436836-1-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

Add the function names to the pr_ logs. As such, if some bugs occur,
with function names, it is easy to locate the bugs.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe.h       |  2 +-
 drivers/infiniband/sw/rxe/rxe_queue.h | 16 ++++------------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index d33dd6cf83d3..f897d0ac1216 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -10,7 +10,7 @@
 #ifdef pr_fmt
 #undef pr_fmt
 #endif
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#define pr_fmt(fmt) KBUILD_MODNAME ": %s: " fmt, __func__
 
 #include <linux/skbuff.h>
 
diff --git a/drivers/infiniband/sw/rxe/rxe_queue.h b/drivers/infiniband/sw/rxe/rxe_queue.h
index c711cb98b949..11bba08ca5f9 100644
--- a/drivers/infiniband/sw/rxe/rxe_queue.h
+++ b/drivers/infiniband/sw/rxe/rxe_queue.h
@@ -184,9 +184,7 @@ static inline void queue_advance_producer(struct rxe_queue *q,
 	switch (type) {
 	case QUEUE_TYPE_FROM_CLIENT:
 		/* used by rxe, client owns the index */
-		if (WARN_ON(1))
-			pr_warn("%s: attempt to advance client index\n",
-				__func__);
+		WARN_ON(1);
 		break;
 	case QUEUE_TYPE_TO_CLIENT:
 		/* used by rxe which owns the index */
@@ -205,9 +203,7 @@ static inline void queue_advance_producer(struct rxe_queue *q,
 		break;
 	case QUEUE_TYPE_TO_ULP:
 		/* used by ulp, rxe owns the index */
-		if (WARN_ON(1))
-			pr_warn("%s: attempt to advance driver index\n",
-				__func__);
+		WARN_ON(1);
 		break;
 	}
 }
@@ -227,15 +223,11 @@ static inline void queue_advance_consumer(struct rxe_queue *q,
 		break;
 	case QUEUE_TYPE_TO_CLIENT:
 		/* used by rxe, client owns the index */
-		if (WARN_ON(1))
-			pr_warn("%s: attempt to advance client index\n",
-				__func__);
+		WARN_ON(1);
 		break;
 	case QUEUE_TYPE_FROM_ULP:
 		/* used by ulp, rxe owns the index */
-		if (WARN_ON(1))
-			pr_warn("%s: attempt to advance driver index\n",
-				__func__);
+		WARN_ON(1);
 		break;
 	case QUEUE_TYPE_TO_ULP:
 		/* used by ulp which owns the index */
-- 
2.27.0

