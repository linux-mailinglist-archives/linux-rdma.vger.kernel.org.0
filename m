Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7E86CEBD6
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Mar 2023 16:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjC2OkG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Mar 2023 10:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjC2Ojt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Mar 2023 10:39:49 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4E572BD
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 07:36:43 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j24so16014538wrd.0
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 07:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680100601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wnbLglyJ3eA52OV8SdW6bu29+/Ammndwmng0PdQyq4=;
        b=ugq/1g9YBwG/1tf5t1LALgH0UrL4xYSqR0DVFa02ocSu6KLYuIvrce81O7jv1AiExo
         jovxehqKJ5gAiDoOdJZYaOJFlxfQM0u38hD/2V4cYqDKQLyn7tc2bwqtjNPQi8FtmRh0
         KU8K5C96Pu4zVi+okbNpDMuBqhPBPr8G938lWe5JnEVBSseaTDdAFWrLobXvsUBmveAL
         miFdgsoOMzJzCYa0XPO0dVmaGBwVu4NLBMZsJOi93M6TKKTWsVKvmIfblHMgtVXNTrre
         tzwtdYFGE9wBD7BXx5iODf2VShqMUbAHDPRxLpVTu0ahb3rDzbSmBLqZcenWSg6guBZF
         h5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680100601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wnbLglyJ3eA52OV8SdW6bu29+/Ammndwmng0PdQyq4=;
        b=sJNUYwde3FIo64ICLj1O+fUm5yvJNvB0kHRmIzNfckcb8dzmCjhdea4L1+LjdL2ote
         PChtzB3fbuTP4tQ6mKZRiSphQAW3Wxls9xkkDmcx08w20ObquVU8zRd+hB43Dd7aMdlo
         JFoUCgfCo2id4wpUF20ud+6OxSV1nnFWLJPcs/3KSArOAz36tFEaTNxUlq7CrXPmxDEL
         PsuJW3+PW+Zzj96yD1mxtojYHfseUVjCbaB3z448JAILOmMLfRocFERVuovBa0flxf/m
         lb/NE/nQ3fyywqVccgpHTVc5s+hfn7WwOzvlyw7a7dhPhkIpDRN/zN45V5kY9Nz1gJTx
         XWSQ==
X-Gm-Message-State: AAQBX9fPF1VroaVXJskuIyXrdGCqujTscQlikbDyJ4jfTWdBzdWs45cz
        MVg3GERFAQSQAybF7dUAgwpyuJZUCNpotRDdlMM=
X-Google-Smtp-Source: AKy350a8fGtpe6YiOteif9ADW5RFFaoTamblmODlSEVjE7hYvNNQvJ/qSwlgDM2jpXAfPd5v97uw7w==
X-Received: by 2002:a2e:3309:0:b0:295:733a:3463 with SMTP id d9-20020a2e3309000000b00295733a3463mr6031393ljc.29.1680099828081;
        Wed, 29 Mar 2023 07:23:48 -0700 (PDT)
Received: from fedora.. ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id u10-20020a2e854a000000b00295b597c8fasm5505492ljj.22.2023.03.29.07.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 07:23:47 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>
Cc:     linux-rdma@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 2/2] RDMA/rxe: Pass a pointer to virt_to_page()
Date:   Wed, 29 Mar 2023 16:23:41 +0200
Message-Id: <20230329142341.863175-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329142341.863175-1-linus.walleij@linaro.org>
References: <20230329142341.863175-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Like the other calls in this function virt_to_page() expects
a pointer, not an integer.

However since many architectures implement virt_to_pfn() as
a macro, this function becomes polymorphic and accepts both a
(unsigned long) and a (void *).

Fix this up with an explicit cast.

Then we need a second cast to (uintptr_t). This is because
the kernel robot builds this driver also for the PARISC,
yielding the following build error on PARISC when casting
(void *) to virt_to_page():

drivers/infiniband/sw/rxe/rxe_mr.c: In function 'rxe_set_page':
>> drivers/infiniband/sw/rxe/rxe_mr.c:216:42: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     216 |         struct page *page = virt_to_page((void *)(iova & mr->page_mask));
         |                                          ^
   include/asm-generic/memory_model.h:18:46: note: in definition of macro '__pfn_to_page'
      18 | #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
         |                                              ^~~
   arch/parisc/include/asm/page.h:179:45: note: in expansion of macro '__pa'
     179 | #define virt_to_page(kaddr)     pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
         |                                             ^~~~
   drivers/infiniband/sw/rxe/rxe_mr.c:216:29: note: in expansion of macro 'virt_to_page'
     216 |         struct page *page = virt_to_page((void *)(iova & mr->page_mask));
         |                             ^~~~~~~~~~~~

First: I think this happens because iova is u64 by design and
(void *) on PARISC is sometimes 32 bit.

Second: compilation of the SW RXE driver on PARISC is made possible
because it fulfills depends on INFINIBAND_VIRT_DMA since that is just
def_bool !HIGHMEM and PARISC does not have HIGHMEM.

By first casting iova to (uintptr_t) it is turned into a u32 on PARISC
or any other 32bit system and u64 on any 64BIT system.

Link: https://lore.kernel.org/linux-rdma/202303242000.HmTaa6yB-lkp@intel.com/
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Fix up confusion between virtual and physical addresses found
  by Jason in a separate patch.
- Fix up compilation on PARISC by additional cast.
  I don't know if this is the right solution, perhaps RDMA should
  rather depend on 64BIT if the subsystem is only for 64BIT
  systems?
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 8e8250652f9d..a5efb0575956 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -213,7 +213,7 @@ int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr)
 static int rxe_set_page(struct ib_mr *ibmr, u64 iova)
 {
 	struct rxe_mr *mr = to_rmr(ibmr);
-	struct page *page = virt_to_page(iova & mr->page_mask);
+	struct page *page = virt_to_page((void *)(uintptr_t)(iova & mr->page_mask));
 	bool persistent = !!(mr->access & IB_ACCESS_FLUSH_PERSISTENT);
 	int err;
 
-- 
2.34.1

