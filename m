Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094EB7BD43E
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Oct 2023 09:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345399AbjJIHZf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Oct 2023 03:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbjJIHZd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Oct 2023 03:25:33 -0400
Received: from out-205.mta0.migadu.com (out-205.mta0.migadu.com [IPv6:2001:41d0:1004:224b::cd])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F2DB6
        for <linux-rdma@vger.kernel.org>; Mon,  9 Oct 2023 00:25:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696835933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OMSTh555TediJZ2XBFHFYP1jKLzfqt9rQZ98RWepIeg=;
        b=DZGp2sdjUofB/5FAAcE9k18FdBWBi6FPEcZTuPNaXe2UG659jANtOQvJLoLVHKQ71JbxD+
        2ivJ55RkbfO5KufRyNq3tlk+J5g2lrOhiQdyMzTJdaY5XIO3HGnDrhxEaYlxNe1RFdVbuR
        1WD1fP0s4u5OtjmgTmaqFSXCofn8HZY=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 14/19] RDMA/siw: Simplify siw_mem_id2obj
Date:   Mon,  9 Oct 2023 15:17:56 +0800
Message-Id: <20231009071801.10210-15-guoqing.jiang@linux.dev>
In-Reply-To: <20231009071801.10210-1-guoqing.jiang@linux.dev>
References: <20231009071801.10210-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

