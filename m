Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6AB6D7EA5
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2019 20:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731834AbfJOSQf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Oct 2019 14:16:35 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43725 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfJOSQe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Oct 2019 14:16:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id i32so12612263pgl.10
        for <linux-rdma@vger.kernel.org>; Tue, 15 Oct 2019 11:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F2P8/bWutEEexpXtgY3Ri54G2hYwzd51MYRSkoxVUFY=;
        b=AaI6zcoXb9y8wHRXAkK1VS7bCrbUdWouuVyY6gjZrKTtcQT1f9NTbxZoCGV2igOt58
         Hoknkm4WnIkfuQk9Rp9K15Dz/ZC1/p916c32tuqr/CGeXCXN4z8DPNSjznQTdigjjDl3
         gatSw9oqkyrSqTGQ3r3g6s47kZTtPeEnB3akei3bsWFCnbAKc65GcpRB8NGeBsGmst80
         TNz3kgeYGq0EAH8hHALVUUXDSXUCc7+/icuPT8zmQDmwvqR37fPXC3iFYLqPPzHYJLWr
         IRmCNEVjik9lbYHEDBdg+ayNFKX79wsrhJv+tgs3ucEqbgNZP4YTOzO2R9UKFWjGbCVL
         mxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F2P8/bWutEEexpXtgY3Ri54G2hYwzd51MYRSkoxVUFY=;
        b=IEKxlOC+b9NNUh6eBy5v3Vvh5riHIMCheICPxUylVZUTDkWuKnrgFCx/OwfSyg1Km1
         BWrftnoA3JmeS/HKXmfSlUGq46mmpfUrdJ7CqOzfCzRAoV24VGRcu6bdTpWeBPeXd/9s
         Gd667uYou8jopVahWCWjy2LuPOAsS7Q/dVqfRB9QrhYS23uqgxleKHxvO5cyW46O4Qup
         sk4tU7a5qjM4yEeBzVEPQpsiM/pKLQlE/2o1QdHQfmAPAdHBQIUDPnf7JYz73zqD6UWK
         21kiqlmjhBIKGUeQlcaL6FapuyH3hpcCQG+3ZMSZPLoGgXxt+QcwsqZBpScJCG2ZeACd
         k/bg==
X-Gm-Message-State: APjAAAV4c701MpWiNE/nxmgEroyiI19frzFnvC940Ok7Jz60sVcsI6tt
        fDrfOzloKMMNVV7WXafAtpBbYw==
X-Google-Smtp-Source: APXvYqwvtUQJH3GpUYBytG2xLT5sSPQT5rLCc3Ie8xi2zPK4TIkuo6wjteJGwDYGFUM1QCJsNVRHNQ==
X-Received: by 2002:a62:5ec6:: with SMTP id s189mr39679838pfb.169.1571163394083;
        Tue, 15 Oct 2019 11:16:34 -0700 (PDT)
Received: from ziepe.ca ([24.114.26.129])
        by smtp.gmail.com with ESMTPSA id o15sm14016pjs.14.2019.10.15.11.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Oct 2019 11:16:33 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iKRJT-0002Cf-NJ; Tue, 15 Oct 2019 15:12:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>
Subject: [PATCH hmm 12/15] drm/amdgpu: Call find_vma under mmap_sem
Date:   Tue, 15 Oct 2019 15:12:39 -0300
Message-Id: <20191015181242.8343-13-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015181242.8343-1-jgg@ziepe.ca>
References: <20191015181242.8343-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

find_vma() must be called under the mmap_sem, reorganize this code to
do the vma check after entering the lock.

Further, fix the unlocked use of struct task_struct's mm, instead use
the mm from hmm_mirror which has an active mm_grab. Also the mm_grab
must be converted to a mm_get before acquiring mmap_sem or calling
find_vma().

Fixes: 66c45500bfdc ("drm/amdgpu: use new HMM APIs and helpers")
Fixes: 0919195f2b0d ("drm/amdgpu: Enable amdgpu_ttm_tt_get_user_pages in worker threads")
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: David (ChunMing) Zhou <David1.Zhou@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 37 ++++++++++++++-----------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index dff41d0a85fe96..c0e41f1f0c2365 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -35,6 +35,7 @@
 #include <linux/hmm.h>
 #include <linux/pagemap.h>
 #include <linux/sched/task.h>
+#include <linux/sched/mm.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/swap.h>
@@ -788,7 +789,7 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
 	struct hmm_mirror *mirror = bo->mn ? &bo->mn->mirror : NULL;
 	struct ttm_tt *ttm = bo->tbo.ttm;
 	struct amdgpu_ttm_tt *gtt = (void *)ttm;
-	struct mm_struct *mm = gtt->usertask->mm;
+	struct mm_struct *mm;
 	unsigned long start = gtt->userptr;
 	struct vm_area_struct *vma;
 	struct hmm_range *range;
@@ -796,25 +797,14 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
 	uint64_t *pfns;
 	int r = 0;
 
-	if (!mm) /* Happens during process shutdown */
-		return -ESRCH;
-
 	if (unlikely(!mirror)) {
 		DRM_DEBUG_DRIVER("Failed to get hmm_mirror\n");
-		r = -EFAULT;
-		goto out;
+		return -EFAULT;
 	}
 
-	vma = find_vma(mm, start);
-	if (unlikely(!vma || start < vma->vm_start)) {
-		r = -EFAULT;
-		goto out;
-	}
-	if (unlikely((gtt->userflags & AMDGPU_GEM_USERPTR_ANONONLY) &&
-		vma->vm_file)) {
-		r = -EPERM;
-		goto out;
-	}
+	mm = mirror->hmm->mmu_notifier.mm;
+	if (!mmget_not_zero(mm)) /* Happens during process shutdown */
+		return -ESRCH;
 
 	range = kzalloc(sizeof(*range), GFP_KERNEL);
 	if (unlikely(!range)) {
@@ -847,6 +837,17 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
 	hmm_range_wait_until_valid(range, HMM_RANGE_DEFAULT_TIMEOUT);
 
 	down_read(&mm->mmap_sem);
+	vma = find_vma(mm, start);
+	if (unlikely(!vma || start < vma->vm_start)) {
+		r = -EFAULT;
+		goto out_unlock;
+	}
+	if (unlikely((gtt->userflags & AMDGPU_GEM_USERPTR_ANONONLY) &&
+		vma->vm_file)) {
+		r = -EPERM;
+		goto out_unlock;
+	}
+
 	r = hmm_range_fault(range, 0);
 	up_read(&mm->mmap_sem);
 
@@ -865,15 +866,19 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
 	}
 
 	gtt->range = range;
+	mmput(mm);
 
 	return 0;
 
+out_unlock:
+	up_read(&mm->mmap_sem);
 out_free_pfns:
 	hmm_range_unregister(range);
 	kvfree(pfns);
 out_free_ranges:
 	kfree(range);
 out:
+	mmput(mm);
 	return r;
 }
 
-- 
2.23.0

