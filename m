Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EBF7E9B93
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Nov 2023 12:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjKML5o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Nov 2023 06:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjKML5n (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Nov 2023 06:57:43 -0500
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [IPv6:2001:41d0:203:375::b8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728B9D75
        for <linux-rdma@vger.kernel.org>; Mon, 13 Nov 2023 03:57:40 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699876658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g49tWtGbX+pjibhFIwlJFXWpAHJXBF2g1TRqh+JAP4o=;
        b=qwtEskGd7UJKyjnEIk6G2n3HxQQ4WTH7ksE+54vXZUMdXjgwIZpPfHuhbgugQwnRiYgLt8
        HShHWQQEuBnTFyDrlskm4ltRVAWvSfar5TZxf5Okhv3i2x3jnWopjUN5qTK2583ms1ED/s
        gfPntnQ1egEQuNFBFAG0vRxKxY8CpSs=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V5 04/17] RDMA/siw: Remove goto lable in siw_mmap
Date:   Mon, 13 Nov 2023 19:57:13 +0800
Message-Id: <20231113115726.12762-5-guoqing.jiang@linux.dev>
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

Let's remove it since the failure case only falls through
to the useless label.

Acked-by: Bernard Metzler <bmt@zurich.ibm.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_verbs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 27f7dda89e49..aad0a7d8789f 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -66,12 +66,9 @@ int siw_mmap(struct ib_ucontext *ctx, struct vm_area_struct *vma)
 	entry = to_siw_mmap_entry(rdma_entry);
 
 	rv = remap_vmalloc_range(vma, entry->address, 0);
-	if (rv) {
+	if (rv)
 		pr_warn("remap_vmalloc_range failed: %lu, %zu\n", vma->vm_pgoff,
 			size);
-		goto out;
-	}
-out:
 	rdma_user_mmap_entry_put(rdma_entry);
 
 	return rv;
-- 
2.35.3

