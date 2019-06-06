Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC9BB37C70
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 20:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfFFSos (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 14:44:48 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41978 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfFFSos (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jun 2019 14:44:48 -0400
Received: by mail-qk1-f194.google.com with SMTP id c11so2117791qkk.8
        for <linux-rdma@vger.kernel.org>; Thu, 06 Jun 2019 11:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cKkqHG6lA8ec9OmOBivsmV6gRcE/obxU2CCqIDGlTpM=;
        b=jwj7m66yktUzAAVuBGGSCtyJS/egSnF1B/vxHFcHYcF2Uik/EqL4UNPU57byfvPnPV
         EUOhSE6Yc2ULsjPzk2Q0cPgGDWJT6t2SoK+wEhbAq1wIixyAii3w6eS/3F4aOcLSPwis
         wISfz8dx+YNMVHjshe7Qu1Sb1slKfIiBQMNHt3ytiNJzaiH2eoJOAMMz+9NSZ0N4cZIj
         IOJsM/44sVtvL3oMoPVTtng3fKxXbLORwQK9ZTj6pDXhMqEyH4epdWP8UfEJY1SfdN0a
         cUwOJj4KyRl8nUp5tdavSJ2m0nYwjfI9rz5uUmGGXTAadrKsObhys9ToUrWKVFbjE5E+
         wb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cKkqHG6lA8ec9OmOBivsmV6gRcE/obxU2CCqIDGlTpM=;
        b=B3+6rKr+N7nkiyEZO1C0owHtX/f6L7EQXgjdEFV9Frc3EVmgqRoZjMVBoVqa6uIlmj
         MHmmcYdgGskXzSNR+pZqRLBHBeFupo4hENKJ16arEZ+pBzrnjKfFxwv5D46TJDl8psM8
         9NEGhPY/guw4V77yLq1xWzsSoR2ro+wQwuMLgw9RxTQbUa2GDdLk3xljaUQOSyREk7KW
         +siN+/u4u7hzX9Z+F1UzOVf6aqYZjzgvswpcLdotClkm1YcBiHAcSysr+o6hshFEL8mP
         vnMmsF+MuVDTniY06aSq7CbU4TYdMOdu/GtBl+PsenjrKzQbzBXX6bqEBs20EqKqW4I7
         XdMg==
X-Gm-Message-State: APjAAAUU4bPI24w1ROXeQxP74Lvl2RVyuP43WKD+cZ2Tyul/ENs0vjqK
        SLeoBf6oceIDbR2MFfYDV7Iaiw==
X-Google-Smtp-Source: APXvYqwVkPweqvQyzdMm8hrdxDc8fcdFbLwJPBzLxuUMc6ON/X0Bc6zX6ARY8mPOX6I9iWyD4gOp2g==
X-Received: by 2002:a37:a0e:: with SMTP id 14mr21589009qkk.203.1559846687100;
        Thu, 06 Jun 2019 11:44:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id e66sm1557234qtb.55.2019.06.06.11.44.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 11:44:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hYxNV-0008IB-G5; Thu, 06 Jun 2019 15:44:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH v2 hmm 02/11] mm/hmm: Use hmm_mirror not mm as an argument for hmm_range_register
Date:   Thu,  6 Jun 2019 15:44:29 -0300
Message-Id: <20190606184438.31646-3-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606184438.31646-1-jgg@ziepe.ca>
References: <20190606184438.31646-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Ralph observes that hmm_range_register() can only be called by a driver
while a mirror is registered. Make this clear in the API by passing in the
mirror structure as a parameter.

This also simplifies understanding the lifetime model for struct hmm, as
the hmm pointer must be valid as part of a registered mirror so all we
need in hmm_register_range() is a simple kref_get.

Suggested-by: Ralph Campbell <rcampbell@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
v2
- Include the oneline patch to nouveau_svm.c
---
 drivers/gpu/drm/nouveau/nouveau_svm.c |  2 +-
 include/linux/hmm.h                   |  7 ++++---
 mm/hmm.c                              | 15 ++++++---------
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index 93ed43c413f0bb..8c92374afcf227 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -649,7 +649,7 @@ nouveau_svm_fault(struct nvif_notify *notify)
 		range.values = nouveau_svm_pfn_values;
 		range.pfn_shift = NVIF_VMM_PFNMAP_V0_ADDR_SHIFT;
 again:
-		ret = hmm_vma_fault(&range, true);
+		ret = hmm_vma_fault(&svmm->mirror, &range, true);
 		if (ret == 0) {
 			mutex_lock(&svmm->mutex);
 			if (!hmm_vma_range_done(&range)) {
diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 688c5ca7068795..2d519797cb134a 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -505,7 +505,7 @@ static inline bool hmm_mirror_mm_is_alive(struct hmm_mirror *mirror)
  * Please see Documentation/vm/hmm.rst for how to use the range API.
  */
 int hmm_range_register(struct hmm_range *range,
-		       struct mm_struct *mm,
+		       struct hmm_mirror *mirror,
 		       unsigned long start,
 		       unsigned long end,
 		       unsigned page_shift);
@@ -541,7 +541,8 @@ static inline bool hmm_vma_range_done(struct hmm_range *range)
 }
 
 /* This is a temporary helper to avoid merge conflict between trees. */
-static inline int hmm_vma_fault(struct hmm_range *range, bool block)
+static inline int hmm_vma_fault(struct hmm_mirror *mirror,
+				struct hmm_range *range, bool block)
 {
 	long ret;
 
@@ -554,7 +555,7 @@ static inline int hmm_vma_fault(struct hmm_range *range, bool block)
 	range->default_flags = 0;
 	range->pfn_flags_mask = -1UL;
 
-	ret = hmm_range_register(range, range->vma->vm_mm,
+	ret = hmm_range_register(range, mirror,
 				 range->start, range->end,
 				 PAGE_SHIFT);
 	if (ret)
diff --git a/mm/hmm.c b/mm/hmm.c
index 547002f56a163d..8796447299023c 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -925,13 +925,13 @@ static void hmm_pfns_clear(struct hmm_range *range,
  * Track updates to the CPU page table see include/linux/hmm.h
  */
 int hmm_range_register(struct hmm_range *range,
-		       struct mm_struct *mm,
+		       struct hmm_mirror *mirror,
 		       unsigned long start,
 		       unsigned long end,
 		       unsigned page_shift)
 {
 	unsigned long mask = ((1UL << page_shift) - 1UL);
-	struct hmm *hmm;
+	struct hmm *hmm = mirror->hmm;
 
 	range->valid = false;
 	range->hmm = NULL;
@@ -945,15 +945,12 @@ int hmm_range_register(struct hmm_range *range,
 	range->start = start;
 	range->end = end;
 
-	hmm = hmm_get_or_create(mm);
-	if (!hmm)
-		return -EFAULT;
-
 	/* Check if hmm_mm_destroy() was call. */
-	if (hmm->mm == NULL || hmm->dead) {
-		hmm_put(hmm);
+	if (hmm->mm == NULL || hmm->dead)
 		return -EFAULT;
-	}
+
+	range->hmm = hmm;
+	kref_get(&hmm->kref);
 
 	/* Initialize range to track CPU page table updates. */
 	mutex_lock(&hmm->lock);
-- 
2.21.0

