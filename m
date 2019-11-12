Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED621F9A7A
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2019 21:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKLUW4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Nov 2019 15:22:56 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34918 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfKLUWz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Nov 2019 15:22:55 -0500
Received: by mail-qt1-f193.google.com with SMTP id n4so16618118qte.2
        for <linux-rdma@vger.kernel.org>; Tue, 12 Nov 2019 12:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LnkAv+iMLBMvlxFpCUEV0XkR28K5MHEmxHckti3wqpM=;
        b=j2l7IUJdqB5K/eDQVUavlGzX7aJ/ZiPkS1yEN2IJtHVZrrCehSLhfQr7M+8cMjxgCr
         ZscponRTH+KICL748W2mp4Sqz3kyUnHh62I2CS0yQvwd24pGk5OnQ3+I/QxcyS7voy6J
         GvhBrTWztilOuY+S2RfoGj+IE1GYk7niaam0rTVWWRk2c/xKYBa3LSRGpsqijaidDvht
         qXeYOwWb+eFndzehMcQtUDxSnuQAzllrqQMMQa/pIhD5iEHz9mX5deTKSKMKCEXrTIFD
         ZjwFpobxsN/NtOgIGZiooNAHBZUyhl3c/c1AvOqey8/ZP0YvuN7STvUkXVmoCwyCq0j3
         iOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LnkAv+iMLBMvlxFpCUEV0XkR28K5MHEmxHckti3wqpM=;
        b=nwhzcuHkKIJ4H1ZZ76I+q9ZPj53RVbzGENY0Tgvb1JPUOC/WjWPUTvEutg3FrQICO9
         nnHURDm+Oa0sxfIh7u0H5hHWYV/a3J6kUqjoPLFwSnylWO7Es8a7N0RRh0UraPmBQhGY
         xhVFEWsDXfJEa4bnVEugTbSRHr39Y0rBsj18nyUefwQavx7Ikd/oBVNn4x/mHIw7CFhP
         LT3/cSMWQ9//+uPiek83NBrOwnt3oldkbT8HvbIBIXcPNZbrO0xQIPLs6x94mCD3DjXA
         gIqq8dUs1eo48JfUzIMoi86GhA2otaa/H+WRu2lQZFC3onTnLualWvUxqrImmoN9ajU7
         rHZw==
X-Gm-Message-State: APjAAAXSukWw2fVQbFD8dBLTnsgBdFc2UgWMOkv3zPyH1t7BLDZQXzIH
        4gEtkPkyCyx63909CzYpPuvIEg==
X-Google-Smtp-Source: APXvYqw6qliK2wZJ/FUk7ArzuqacA0YzehJQI0koFeIUELWZpshcb9zAxOBz88vcUQ7sqd+EHHHmrw==
X-Received: by 2002:ac8:60da:: with SMTP id i26mr34434892qtm.43.1573590173007;
        Tue, 12 Nov 2019 12:22:53 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id a70sm4290549qkg.1.2019.11.12.12.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Nov 2019 12:22:48 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iUcgZ-0003kT-JQ; Tue, 12 Nov 2019 16:22:47 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Petr Cvek <petrcvekcz@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        nouveau@lists.freedesktop.org, xen-devel@lists.xenproject.org,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v3 10/14] drm/amdgpu: Call find_vma under mmap_sem
Date:   Tue, 12 Nov 2019 16:22:27 -0400
Message-Id: <20191112202231.3856-11-jgg@ziepe.ca>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112202231.3856-1-jgg@ziepe.ca>
References: <20191112202231.3856-1-jgg@ziepe.ca>
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
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
Tested-by: Philip Yang <Philip.Yang@amd.com>
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
2.24.0

