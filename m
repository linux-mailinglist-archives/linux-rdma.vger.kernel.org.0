Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81018450D6
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 02:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbfFNAo5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 20:44:57 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38821 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfFNAo4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jun 2019 20:44:56 -0400
Received: by mail-qk1-f194.google.com with SMTP id a27so629156qkk.5
        for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2019 17:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=op2+qqBk6rWtrVzX85Tdji9xbKocy11Zcttde2t5Nu8=;
        b=D30mf9PGmOmg9I5/9g0MzWxEXedyBaWkkmnNqAl4FA9d0B5THPVVzTtCux6VHVWP76
         xPxHkBZrtAGHIjR/J+Se6HOXwAs75X6jrsndrpgNBnZ6e5GoT5vB7IpW5/KkPufHsMig
         /lKj49pcdbL5F8wiFJWjPLmrYeiEWCPItURysc/SGIc3LsiunwY9uiqrmWElrd7Qwv6Q
         mtT1IaGjA4RD5yCV1MA+3beQzN1ULDnUdoMUn+fqlk7WTzzxYo8IKqJG0BdnDdhGjwPC
         zYmW3IXzrRRtAS559siQ/AodNBiqOD7M6e4S7LJU7trsqP+0KuWPmBGt4JAQ6K2dl3hp
         FojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=op2+qqBk6rWtrVzX85Tdji9xbKocy11Zcttde2t5Nu8=;
        b=ZlSy2/Po2CdHKIeKQMffA3jQUnqWgAtHEPS0+7ipNa+9b7kZap2ze0Z0z0slp2FEKl
         TAAZXVIAnNx2h9/+NiBRn6DzYGVTkbN+pm3BBhjk/PlzlduIds3d2r8yBelgq4r9TlNJ
         NBQUfh0NPNoBf8Ii+/dJxU2IerUMWtVW7lmDoOl8OlJktZhclJuF4T838ZcxpuCN2lLx
         WMJKBtMUHpDqstkRQHpWg2u/Zi80NPgqvfNBCGjLh1eVsJ6ZWMo+KFtQQg51uKYjERcK
         wZxyJ+s7YqME38D33XS38pwZE6s6dYj8Y9krJzmB1GssvBq2xCSr4tC3r9d/SofKi2N6
         79KA==
X-Gm-Message-State: APjAAAW7I6zQCTIDabhggmPvgwTiRxxjn+8GhPlsoz8k/AGu1DYmacRk
        /5gLzmMgcY66j0J5j2HodPBNHQ==
X-Google-Smtp-Source: APXvYqzHD04DoOdk3O8JWoFpyfnlVsPMz9EOodeX9LHTjciArgHYxwJEEoe/sklf3HM5JZVxOOzqsA==
X-Received: by 2002:a37:490c:: with SMTP id w12mr71905018qka.327.1560473095502;
        Thu, 13 Jun 2019 17:44:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id s134sm759219qke.51.2019.06.13.17.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 17:44:54 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hbaKr-0005Je-Km; Thu, 13 Jun 2019 21:44:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v3 hmm 02/12] mm/hmm: Use hmm_mirror not mm as an argument for hmm_range_register
Date:   Thu, 13 Jun 2019 21:44:40 -0300
Message-Id: <20190614004450.20252-3-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190614004450.20252-1-jgg@ziepe.ca>
References: <20190614004450.20252-1-jgg@ziepe.ca>
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
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Tested-by: Philip Yang <Philip.Yang@amd.com>
---
v2
- Include the oneline patch to nouveau_svm.c
---
 drivers/gpu/drm/nouveau/nouveau_svm.c |  2 +-
 include/linux/hmm.h                   |  7 ++++---
 mm/hmm.c                              | 13 ++++---------
 3 files changed, 9 insertions(+), 13 deletions(-)

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
index cb01cf1fa3c08b..1fba6979adf460 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -496,7 +496,7 @@ static inline bool hmm_mirror_mm_is_alive(struct hmm_mirror *mirror)
  * Please see Documentation/vm/hmm.rst for how to use the range API.
  */
 int hmm_range_register(struct hmm_range *range,
-		       struct mm_struct *mm,
+		       struct hmm_mirror *mirror,
 		       unsigned long start,
 		       unsigned long end,
 		       unsigned page_shift);
@@ -532,7 +532,8 @@ static inline bool hmm_vma_range_done(struct hmm_range *range)
 }
 
 /* This is a temporary helper to avoid merge conflict between trees. */
-static inline int hmm_vma_fault(struct hmm_range *range, bool block)
+static inline int hmm_vma_fault(struct hmm_mirror *mirror,
+				struct hmm_range *range, bool block)
 {
 	long ret;
 
@@ -545,7 +546,7 @@ static inline int hmm_vma_fault(struct hmm_range *range, bool block)
 	range->default_flags = 0;
 	range->pfn_flags_mask = -1UL;
 
-	ret = hmm_range_register(range, range->vma->vm_mm,
+	ret = hmm_range_register(range, mirror,
 				 range->start, range->end,
 				 PAGE_SHIFT);
 	if (ret)
diff --git a/mm/hmm.c b/mm/hmm.c
index f6956d78e3cb25..22a97ada108b4e 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -914,13 +914,13 @@ static void hmm_pfns_clear(struct hmm_range *range,
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
@@ -934,20 +934,15 @@ int hmm_range_register(struct hmm_range *range,
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
 
 	/* Initialize range to track CPU page table updates. */
 	mutex_lock(&hmm->lock);
 
 	range->hmm = hmm;
+	kref_get(&hmm->kref);
 	list_add_rcu(&range->list, &hmm->ranges);
 
 	/*
-- 
2.21.0

