Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFA06DC5B2
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Apr 2023 12:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjDJKX7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Apr 2023 06:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJKX6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Apr 2023 06:23:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0E6131
        for <linux-rdma@vger.kernel.org>; Mon, 10 Apr 2023 03:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681122237; x=1712658237;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U/h/gRBiCysWhGa2aQNNiGF/auGOipnd2VIw1M2ytpQ=;
  b=D01o8o4lxZ6XCl1gKpjbYraV/Ca73cZ3lMvra/xsz7wXugihGTL1TB1a
   Bw2wIBHrMumXbnbtHrpR/N5SjY7fEZ710mHAI8G/3sHpkMEMuHZUSbqyD
   XS3n8HWfTd/MBdh99G7fSVtpRmlRL8FH/bjI1smQ6FTuE2nKNEsXHoVUD
   OcP3QPz6pluEm3oPqbcP/C8kjjWh3Hopy+Z0PNkeZEA1wLLiVmcnad26Y
   aShNhhiLLCveiWKhCM06BUd2/pZNGE3butVGRvt1N5GhKBAAD1xQ2WJJF
   uqqmkKfJdgYRm3yyuDj5liQqQ6gDDvDsG70Q+8q8gX6q4hAs6ET1pyB7S
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10675"; a="342092729"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="342092729"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 03:23:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10675"; a="638428430"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="638428430"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga003.jf.intel.com with ESMTP; 10 Apr 2023 03:23:55 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH 1/1] RDMA/rxe: Add function name to the logs
Date:   Mon, 10 Apr 2023 18:21:05 +0800
Message-Id: <20230410102105.1084967-1-yanjun.zhu@intel.com>
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

Add the function names to the pr_ logs. As such, if some bugs occur,
with function names, it is easy to locate the bugs.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe.h       |  2 +-
 drivers/infiniband/sw/rxe/rxe_queue.h | 12 ++++--------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index 2415f3704f57..43742d2f32de 100644
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
index c711cb98b949..5d6e17b00e60 100644
--- a/drivers/infiniband/sw/rxe/rxe_queue.h
+++ b/drivers/infiniband/sw/rxe/rxe_queue.h
@@ -185,8 +185,7 @@ static inline void queue_advance_producer(struct rxe_queue *q,
 	case QUEUE_TYPE_FROM_CLIENT:
 		/* used by rxe, client owns the index */
 		if (WARN_ON(1))
-			pr_warn("%s: attempt to advance client index\n",
-				__func__);
+			pr_warn("attempt to advance client index\n");
 		break;
 	case QUEUE_TYPE_TO_CLIENT:
 		/* used by rxe which owns the index */
@@ -206,8 +205,7 @@ static inline void queue_advance_producer(struct rxe_queue *q,
 	case QUEUE_TYPE_TO_ULP:
 		/* used by ulp, rxe owns the index */
 		if (WARN_ON(1))
-			pr_warn("%s: attempt to advance driver index\n",
-				__func__);
+			pr_warn("attempt to advance driver index\n");
 		break;
 	}
 }
@@ -228,14 +226,12 @@ static inline void queue_advance_consumer(struct rxe_queue *q,
 	case QUEUE_TYPE_TO_CLIENT:
 		/* used by rxe, client owns the index */
 		if (WARN_ON(1))
-			pr_warn("%s: attempt to advance client index\n",
-				__func__);
+			pr_warn("attempt to advance client index\n");
 		break;
 	case QUEUE_TYPE_FROM_ULP:
 		/* used by ulp, rxe owns the index */
 		if (WARN_ON(1))
-			pr_warn("%s: attempt to advance driver index\n",
-				__func__);
+			pr_warn("attempt to advance driver index\n");
 		break;
 	case QUEUE_TYPE_TO_ULP:
 		/* used by ulp which owns the index */
-- 
2.27.0

