Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96A6A2814D
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2019 17:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbfEWPel (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 May 2019 11:34:41 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34488 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730752AbfEWPel (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 May 2019 11:34:41 -0400
Received: by mail-qk1-f194.google.com with SMTP id t64so3869067qkh.1
        for <linux-rdma@vger.kernel.org>; Thu, 23 May 2019 08:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZePMKZ7jqBhopBdwVcCn1CrsRsr5VRg48k9A7BJXYb4=;
        b=jv6BZA8C1NV02Y1wmdXHZ90xqpN8v3U2iUJqYKuvZM/jGdctWUbv+nypqASupEpUuN
         vIJUJzSEQT+oiGmCOeMcLnf/zJZZJYkp9fMkQWdbVn6lbTE2PWKG+0XU8rQzC0Hq7Y+X
         r1gaLm6hZu3mcuSUXfzmFexbK/YKvGzQEV5NqwCdYopvQ50bAWFzwmX3JWwZuuR6KItI
         LqdMy9kYprQxYkWCbGlKs8lxcUTCSD7OTwxmzLrQKpMbz0TWlcMw3K9W6VInHK08n7Qd
         2fajaOkWWQEZaJr0X7BQVoog4kSz1uBsRTCfvef4Gw8N0ebsa2yCNtTsdP4xqFS6YoQD
         xjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZePMKZ7jqBhopBdwVcCn1CrsRsr5VRg48k9A7BJXYb4=;
        b=QfJuAOVWtuUDpgz5haLXG9T3BTp8/NaMlB3P+P6ZIKvjRgJYxArdSdkcPesh/n76sb
         El915RBW63AKw89OIol7QAEKDff7Yj3rgykABLxAG10cDeyzxpUMbt3y+W2QC6Ppfxkc
         osgLVAt9T4I49pcOqW8704goZo4lzSHSlI5Xs83Ihg/z+XTM4joNz5uIsuFeAiRBOmIK
         B5VMbn3y0MdYoXeKu9Ki8W0rJxisXLl3om+df+GYlGPcVRZwW+FziGVpAFK2OPtoGR96
         K/WtosfwT0UXEqiuD1J5UYPkd70Fnkel+daAPIKtg0F8zZm9+1fKd98/0cQ9I9jXuKPf
         bhPA==
X-Gm-Message-State: APjAAAXSFDdEooE4xf7gQxzADb3oWN9bk3VnK2KcfRhEPisKT624t8zC
        41GyCUOHHlBsC9RPzZK8Nk5lgY9Gt7c=
X-Google-Smtp-Source: APXvYqzE9Wf6pPLXAKTOOnViH6zjZXhhQeJF2uy5/0EwAhBMsAqbYZTx1jGzOFC4t22sUwexJeiqqQ==
X-Received: by 2002:ae9:e208:: with SMTP id c8mr74383498qkc.154.1558625680068;
        Thu, 23 May 2019 08:34:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id x10sm2553300qkl.84.2019.05.23.08.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 08:34:38 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTpjp-0004zH-Uv; Thu, 23 May 2019 12:34:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [RFC PATCH 02/11] mm/hmm: Use hmm_mirror not mm as an argument for hmm_register_range
Date:   Thu, 23 May 2019 12:34:27 -0300
Message-Id: <20190523153436.19102-3-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523153436.19102-1-jgg@ziepe.ca>
References: <20190523153436.19102-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Ralph observes that hmm_register_range() can only be called by a driver
while a mirror is registered. Make this clear in the API by passing in the
mirror structure as a parameter.

This also simplifies understanding the lifetime model for struct hmm, as
the hmm pointer must be valid as part of a registered mirror so all we
need in hmm_register_range() is a simple kref_get.

Suggested-by: Ralph Campbell <rcampbell@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 include/linux/hmm.h |  7 ++++---
 mm/hmm.c            | 14 +++++---------
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 8b91c90d3b88cb..87d29e085a69f7 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -503,7 +503,7 @@ static inline bool hmm_mirror_mm_is_alive(struct hmm_mirror *mirror)
  * Please see Documentation/vm/hmm.rst for how to use the range API.
  */
 int hmm_range_register(struct hmm_range *range,
-		       struct mm_struct *mm,
+		       struct hmm_mirror *mirror,
 		       unsigned long start,
 		       unsigned long end,
 		       unsigned page_shift);
@@ -539,7 +539,8 @@ static inline bool hmm_vma_range_done(struct hmm_range *range)
 }
 
 /* This is a temporary helper to avoid merge conflict between trees. */
-static inline int hmm_vma_fault(struct hmm_range *range, bool block)
+static inline int hmm_vma_fault(struct hmm_mirror *mirror,
+				struct hmm_range *range, bool block)
 {
 	long ret;
 
@@ -552,7 +553,7 @@ static inline int hmm_vma_fault(struct hmm_range *range, bool block)
 	range->default_flags = 0;
 	range->pfn_flags_mask = -1UL;
 
-	ret = hmm_range_register(range, range->vma->vm_mm,
+	ret = hmm_range_register(range, mirror,
 				 range->start, range->end,
 				 PAGE_SHIFT);
 	if (ret)
diff --git a/mm/hmm.c b/mm/hmm.c
index 824e7e160d8167..fa1b04fcfc2549 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -927,7 +927,7 @@ static void hmm_pfns_clear(struct hmm_range *range,
  * Track updates to the CPU page table see include/linux/hmm.h
  */
 int hmm_range_register(struct hmm_range *range,
-		       struct mm_struct *mm,
+		       struct hmm_mirror *mirror,
 		       unsigned long start,
 		       unsigned long end,
 		       unsigned page_shift)
@@ -935,7 +935,6 @@ int hmm_range_register(struct hmm_range *range,
 	unsigned long mask = ((1UL << page_shift) - 1UL);
 
 	range->valid = false;
-	range->hmm = NULL;
 
 	if ((start & mask) || (end & mask))
 		return -EINVAL;
@@ -946,15 +945,12 @@ int hmm_range_register(struct hmm_range *range,
 	range->start = start;
 	range->end = end;
 
-	range->hmm = hmm_get_or_create(mm);
-	if (!range->hmm)
-		return -EFAULT;
-
 	/* Check if hmm_mm_destroy() was call. */
-	if (range->hmm->mm == NULL || range->hmm->dead) {
-		hmm_put(range->hmm);
+	if (mirror->hmm->mm == NULL || mirror->hmm->dead)
 		return -EFAULT;
-	}
+
+	range->hmm = mirror->hmm;
+	kref_get(&range->hmm->kref);
 
 	/* Initialize range to track CPU page table update */
 	mutex_lock(&range->hmm->lock);
-- 
2.21.0

