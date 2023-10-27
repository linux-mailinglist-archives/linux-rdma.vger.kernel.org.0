Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E117D8D21
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Oct 2023 04:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjJ0Cdw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Oct 2023 22:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjJ0Cdw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Oct 2023 22:33:52 -0400
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [IPv6:2001:41d0:203:375::b2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9AC1AC
        for <linux-rdma@vger.kernel.org>; Thu, 26 Oct 2023 19:33:49 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698374028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dXCo7obIKr4cN5luExDLz7kHRzEJHi4LQT1yu9jd0j8=;
        b=J/1aWEV0qtCSnqpM+YRO9tBq230dAmVMH3fLxSOKglTmfpMrr/xGn43Hr/8tVcFEiWQJh/
        6LM1hqbkfwERR4s0kLUY8V0MJs0UXg5LEiOUBxtzl0KMko2GTZ4SdR/K2bkDzFRTkz92od
        DFQ1dpnP/lQwXbuiP78gP8+WFCVBeBE=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V3 04/18] RDMA/siw: Remove goto lable in siw_mmap
Date:   Fri, 27 Oct 2023 10:33:14 +0800
Message-Id: <20231027023328.30347-5-guoqing.jiang@linux.dev>
In-Reply-To: <20231027023328.30347-1-guoqing.jiang@linux.dev>
References: <20231027023328.30347-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

