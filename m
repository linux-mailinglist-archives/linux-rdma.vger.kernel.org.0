Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974837BD436
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Oct 2023 09:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344984AbjJIHXf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Oct 2023 03:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbjJIHXe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Oct 2023 03:23:34 -0400
Received: from out-205.mta0.migadu.com (out-205.mta0.migadu.com [91.218.175.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B663C5
        for <linux-rdma@vger.kernel.org>; Mon,  9 Oct 2023 00:23:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696835903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0dHTip36EaYVwALNXMnE+j2uahD4AvqObnkv+G/5ILA=;
        b=suEdyTblSJzzrdtBMCXfN+78ITie3ySfiq9L53CHApIHyYOqLCBkmxYxQpP6y5VxYSSKG3
        XAcTGoNuxQ/ALWZBsQwNsrdwoy/inEsq7kllypquENPohwOrKxq0jOlQh2miHWphlomddL
        zqqWkxP/QCLIRNWYZq0ZdLR9b0q+7l4=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 04/19] RDMA/siw: Remove goto lable in siw_mmap
Date:   Mon,  9 Oct 2023 15:17:46 +0800
Message-Id: <20231009071801.10210-5-guoqing.jiang@linux.dev>
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

Remove unnecessary label since the failure case only need to
print warning message.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw_verbs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index c5c27db9c2fe..dcd69fc01176 100644
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

