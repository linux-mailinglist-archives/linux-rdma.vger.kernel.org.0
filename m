Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8C17BD444
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Oct 2023 09:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345391AbjJIHZh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Oct 2023 03:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345397AbjJIHZe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Oct 2023 03:25:34 -0400
Received: from out-194.mta0.migadu.com (out-194.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FCED8
        for <linux-rdma@vger.kernel.org>; Mon,  9 Oct 2023 00:25:32 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696835918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S5Kio6sMTzY+BJRABdcLxZmpsUee3tcybD4HaS/lpsc=;
        b=VZ2RvXO75CT/BjmWxBvRhVIAvB5aLw+OOwRa05S2wUqm+2PAlfTQWKMPG8sZ0u8oCF+p5k
        d9gIdG8+5ADLtR6sqHef73nbU04FAQLY7/whlLLKtXSWmK0NxG+PI/yCn2/GFQLMS+p49U
        jrSctw/AhprbKdtrXjKb+JlDaMSDY6c=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 09/19] RDMA/siw: Introduce SIW_STAG_MAX_INDEX
Date:   Mon,  9 Oct 2023 15:17:51 +0800
Message-Id: <20231009071801.10210-10-guoqing.jiang@linux.dev>
In-Reply-To: <20231009071801.10210-1-guoqing.jiang@linux.dev>
References: <20231009071801.10210-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add the macro to remove magic number in the code.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_mem.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
index 92c5776a9eed..ac4502fb0a96 100644
--- a/drivers/infiniband/sw/siw/siw_mem.c
+++ b/drivers/infiniband/sw/siw/siw_mem.c
@@ -13,18 +13,20 @@
 #include "siw.h"
 #include "siw_mem.h"
 
+/* Stag lookup is based on its index part only (24 bits). */
+#define SIW_STAG_MAX_INDEX	0x00ffffff
+
 /*
- * Stag lookup is based on its index part only (24 bits).
  * The code avoids special Stag of zero and tries to randomize
  * STag values between 1 and SIW_STAG_MAX_INDEX.
  */
 int siw_mem_add(struct siw_device *sdev, struct siw_mem *m)
 {
-	struct xa_limit limit = XA_LIMIT(1, 0x00ffffff);
+	struct xa_limit limit = XA_LIMIT(1, SIW_STAG_MAX_INDEX);
 	u32 id, next;
 
 	get_random_bytes(&next, 4);
-	next &= 0x00ffffff;
+	next &= SIW_STAG_MAX_INDEX;
 
 	if (xa_alloc_cyclic(&sdev->mem_xa, &id, m, limit, &next,
 	    GFP_KERNEL) < 0)
@@ -91,7 +93,7 @@ int siw_mr_add_mem(struct siw_mr *mr, struct ib_pd *pd, void *mem_obj,
 {
 	struct siw_device *sdev = to_siw_dev(pd->device);
 	struct siw_mem *mem = kzalloc(sizeof(*mem), GFP_KERNEL);
-	struct xa_limit limit = XA_LIMIT(1, 0x00ffffff);
+	struct xa_limit limit = XA_LIMIT(1, SIW_STAG_MAX_INDEX);
 	u32 id, next;
 
 	if (!mem)
@@ -107,7 +109,7 @@ int siw_mr_add_mem(struct siw_mr *mr, struct ib_pd *pd, void *mem_obj,
 	kref_init(&mem->ref);
 
 	get_random_bytes(&next, 4);
-	next &= 0x00ffffff;
+	next &= SIW_STAG_MAX_INDEX;
 
 	if (xa_alloc_cyclic(&sdev->mem_xa, &id, mem, limit, &next,
 	    GFP_KERNEL) < 0) {
-- 
2.35.3

