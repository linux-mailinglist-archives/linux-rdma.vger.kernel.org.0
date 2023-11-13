Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A3A7E9B97
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Nov 2023 12:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjKML5v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Nov 2023 06:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjKML5u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Nov 2023 06:57:50 -0500
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [IPv6:2001:41d0:203:375::b6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D881D7F
        for <linux-rdma@vger.kernel.org>; Mon, 13 Nov 2023 03:57:46 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699876664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FnKaBa/bKg8eNtFtRNf19x2NKMWYAJFyod2cCc7BFp0=;
        b=sDaTMAVwpbnimBpsEiIZ9Tix4NYi4F8IaFJGRMEijzvR6IVYFShvi+8e4ElvmjN7uwZbhU
        KVXDQ+Gu0+cmM0BaDwTxlNkKav2z8vNPC28MCVAqgTEQyOy8kpThOwMKyRDPYuE/pAYcfy
        T2stoUp3ZZ+ZL608mMNFljCvydiHbZw=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V5 08/17] RDMA/siw: Introduce SIW_STAG_MAX_INDEX
Date:   Mon, 13 Nov 2023 19:57:17 +0800
Message-Id: <20231113115726.12762-9-guoqing.jiang@linux.dev>
In-Reply-To: <20231113115726.12762-1-guoqing.jiang@linux.dev>
References: <20231113115726.12762-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add the macro to remove magic number in the code.

Acked-by: Bernard Metzler <bmt@zurich.ibm.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_mem.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
index 2110ceb0603c..dcb963607c8b 100644
--- a/drivers/infiniband/sw/siw/siw_mem.c
+++ b/drivers/infiniband/sw/siw/siw_mem.c
@@ -14,18 +14,20 @@
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
@@ -81,7 +83,7 @@ int siw_mr_add_mem(struct siw_mr *mr, struct ib_pd *pd, void *mem_obj,
 {
 	struct siw_device *sdev = to_siw_dev(pd->device);
 	struct siw_mem *mem = kzalloc(sizeof(*mem), GFP_KERNEL);
-	struct xa_limit limit = XA_LIMIT(1, 0x00ffffff);
+	struct xa_limit limit = XA_LIMIT(1, SIW_STAG_MAX_INDEX);
 	u32 id, next;
 
 	if (!mem)
@@ -97,7 +99,7 @@ int siw_mr_add_mem(struct siw_mr *mr, struct ib_pd *pd, void *mem_obj,
 	kref_init(&mem->ref);
 
 	get_random_bytes(&next, 4);
-	next &= 0x00ffffff;
+	next &= SIW_STAG_MAX_INDEX;
 
 	if (xa_alloc_cyclic(&sdev->mem_xa, &id, mem, limit, &next,
 	    GFP_KERNEL) < 0) {
-- 
2.35.3

