Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6CF6C7CAF
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Mar 2023 11:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjCXKdO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Mar 2023 06:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjCXKdA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Mar 2023 06:33:00 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AEC5BBD
        for <linux-rdma@vger.kernel.org>; Fri, 24 Mar 2023 03:32:57 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y20so1626102lfj.2
        for <linux-rdma@vger.kernel.org>; Fri, 24 Mar 2023 03:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679653975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4w85vdTpPV048TMUrlEPnGE9wxPnfOtBb7FkH1i9q8U=;
        b=wJB5GKMEvZfQ80fUFgO12RGm063cU4UKgYhYxWcFxeoS0HzWoeFkzvlf9sUk1MvVzH
         QmpfoZc0pPbHbgr8ZE/QwetlGydk9hy+nk87IcxF6C+DpfS5l5S60DnEHzSX7I1DcWqc
         SqC9svWL8iLh+dFkMzxvrUFWqoyAG0rdTFFmAbPRPz+28PXwXayzPr8It4eLzkLAj579
         ++7QD90B+M4Wn5xMrfShpdgDz3zeakJ0vfyzxRu9nLyH6YZHVFJ6RtWy4OQi6LwLz+Bd
         QjcspYChsrqJzWsmmRhjNc3vDo3qVCh46o4bkIcTxYB+16mjdnC3GNsxvNvqvAz6/+IO
         M7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679653975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4w85vdTpPV048TMUrlEPnGE9wxPnfOtBb7FkH1i9q8U=;
        b=f5mhXYtR8TvEXQnPEkJS7UDmcs+AnLlnzv4J0hT/SodwzukwUKIAL4WN/v5GPBJrJI
         DU/RP+ny1Wnb8Nh/TQBWDvizTW/Kl7GiBFO+6ewisORSQyDcOK3nuK66Gq+xkrOoOYD+
         clkFS2RY0eCCoz23RwQPmM9N6lEr1lh7aQWHk/0lOGL3Z1+xEMyWhqFXGSxzA/X6IbPF
         StOof66wdQnZsxk9veOSGtpYe35MrKmayR7yUZB9A3V/WjFSl/LvnYQZ1TwmC3PgNmoH
         zVI9JjByfEyxXVSIpdIHgdGdc1TXqAMYF/8pnrXnkJoweFauXbz92c5jm3EU4ugsHgf5
         ip/A==
X-Gm-Message-State: AAQBX9fl82zbUfJSkKJLBAsctY4RkehB29sWCTBMwucyP1+p2nzd6Vzy
        /YJSSOs0C/J5bT9vfxMn7wNgdg==
X-Google-Smtp-Source: AKy350an7fvBS5NUDqeaULSmqbiv2TJ4dG5+nllh0neOaEcfiyAfFNdzsMuydjxiGxenLhcKVm178w==
X-Received: by 2002:ac2:4146:0:b0:4ea:e688:a052 with SMTP id c6-20020ac24146000000b004eae688a052mr761845lfi.31.1679653975200;
        Fri, 24 Mar 2023 03:32:55 -0700 (PDT)
Received: from fedora.. ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id u6-20020ac251c6000000b004db39e80733sm3276412lfm.155.2023.03.24.03.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 03:32:54 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Bernard Metzler <BMT@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] RDMA/rxe: Pass a pointer to virt_to_page()
Date:   Fri, 24 Mar 2023 11:32:52 +0100
Message-Id: <20230324103252.712107-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.39.2
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

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index b10aa1580a64..5c90d83002f0 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -213,7 +213,7 @@ int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr)
 static int rxe_set_page(struct ib_mr *ibmr, u64 iova)
 {
 	struct rxe_mr *mr = to_rmr(ibmr);
-	struct page *page = virt_to_page(iova & mr->page_mask);
+	struct page *page = virt_to_page((void *)(iova & mr->page_mask));
 	bool persistent = !!(mr->access & IB_ACCESS_FLUSH_PERSISTENT);
 	int err;
 
@@ -288,7 +288,7 @@ static void rxe_mr_copy_dma(struct rxe_mr *mr, u64 iova, void *addr,
 	u8 *va;
 
 	while (length) {
-		page = virt_to_page(iova & mr->page_mask);
+		page = virt_to_page((void *)(iova & mr->page_mask));
 		bytes = min_t(unsigned int, length,
 				PAGE_SIZE - page_offset);
 		va = kmap_local_page(page);
@@ -488,7 +488,7 @@ int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
 
 	if (mr->ibmr.type == IB_MR_TYPE_DMA) {
 		page_offset = iova & (PAGE_SIZE - 1);
-		page = virt_to_page(iova & PAGE_MASK);
+		page = virt_to_page((void *)(iova & PAGE_MASK));
 	} else {
 		unsigned long index;
 		int err;
@@ -545,7 +545,7 @@ int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
 
 	if (mr->ibmr.type == IB_MR_TYPE_DMA) {
 		page_offset = iova & (PAGE_SIZE - 1);
-		page = virt_to_page(iova & PAGE_MASK);
+		page = virt_to_page((void *)(iova & PAGE_MASK));
 	} else {
 		unsigned long index;
 		int err;
-- 
2.34.1

