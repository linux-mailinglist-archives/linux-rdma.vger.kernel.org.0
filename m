Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859497C7B5F
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Oct 2023 04:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjJMCBN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Oct 2023 22:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJMCBM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Oct 2023 22:01:12 -0400
Received: from out-195.mta0.migadu.com (out-195.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D990CC
        for <linux-rdma@vger.kernel.org>; Thu, 12 Oct 2023 19:01:10 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697162468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Jh0JS9DcmK7UEerPwdfSHQuTCX6NLKyOtlWVu1icbA=;
        b=UnUD8BU/YF8wxGmh/hVIxcHuyvTOemkGYSBZbtnCOlzch1V6W5mo9BgpFtb8Ivld3LX91t
        LldW3Gxq2i6BMoXMxt2nzMfCNy+XjNa2/u/zztb5lUAPsYDfR0IalL/mV/NHdcQpVxiMlQ
        xBvq5XilK3lYolDxrN6/sm3yIO64SRs=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V2 04/20] RDMA/siw: Remove goto lable in siw_mmap
Date:   Fri, 13 Oct 2023 10:00:37 +0800
Message-Id: <20231013020053.2120-5-guoqing.jiang@linux.dev>
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

Remove unnecesary label since the failure case only need to
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

