Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3587C7B6C
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Oct 2023 04:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjJMCBZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Oct 2023 22:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjJMCBY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Oct 2023 22:01:24 -0400
Received: from out-192.mta0.migadu.com (out-192.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC43CE0
        for <linux-rdma@vger.kernel.org>; Thu, 12 Oct 2023 19:01:21 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697162479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OMSTh555TediJZ2XBFHFYP1jKLzfqt9rQZ98RWepIeg=;
        b=dojnEssmnHqaWkTvqS7aj50HZ/Wy+jVuf/kbxvAA3Qa+hEMDLP0R0QPeZt4aiwCo+7eI4j
        xyh3egATgdf98h3JKcbvut0BiN061+AzT4TUq4jYfm9sqq68Qvbe0XhdA0lziTOmEy6UIU
        1Z7Ks62YApfFSkEJHYLTqYav7ejUWfI=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V2 14/20] RDMA/siw: Simplify siw_mem_id2obj
Date:   Fri, 13 Oct 2023 10:00:47 +0800
Message-Id: <20231013020053.2120-15-guoqing.jiang@linux.dev>
In-Reply-To: <20231013020053.2120-1-guoqing.jiang@linux.dev>
References: <20231013020053.2120-1-guoqing.jiang@linux.dev>
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

We can set mm then return it.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_mem.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
index ac4502fb0a96..2d62f947d330 100644
--- a/drivers/infiniband/sw/siw/siw_mem.c
+++ b/drivers/infiniband/sw/siw/siw_mem.c
@@ -53,13 +53,11 @@ struct siw_mem *siw_mem_id2obj(struct siw_device *sdev, int stag_index)
 
 	rcu_read_lock();
 	mem = xa_load(&sdev->mem_xa, stag_index);
-	if (likely(mem && kref_get_unless_zero(&mem->ref))) {
-		rcu_read_unlock();
-		return mem;
-	}
+	if (likely(mem && !kref_get_unless_zero(&mem->ref)))
+		mem = NULL;
 	rcu_read_unlock();
 
-	return NULL;
+	return mem;
 }
 
 static void siw_free_plist(struct siw_page_chunk *chunk, int num_pages,
-- 
2.35.3

