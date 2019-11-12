Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81D81F9A73
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2019 21:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfKLUWv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Nov 2019 15:22:51 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35959 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfKLUWv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Nov 2019 15:22:51 -0500
Received: by mail-qk1-f195.google.com with SMTP id d13so15696239qko.3
        for <linux-rdma@vger.kernel.org>; Tue, 12 Nov 2019 12:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RW58zr8YTNVHuTBfIVxZyU6EJd/oHLVvWKcypECtMjs=;
        b=mSX+wJ+8VUX1382IHhLVx6fBdAWs6gXvU0I32j+wK2yrM6ZkKGtovH1/NPjehZ8ovE
         1T0Z0w4CHSgxOjOWg78rUMLlihvA2VQuqm44HX3C/1ZLAMQjsARlaHNBCW9gz6N48wKJ
         y9PM2onSIWQgFDrhE8sOQPU0nJxnAlm4dGvf735qGtY5kABa7ifc2bFJa2gjCHgJHDWB
         H9uN853ltamgQii1TxpifGWrSt8UcwbEHZ/zxACuyEsslH7wGCXdsqUB6pj/D0T30D1q
         5KfZ1V6veRSoxZqHsr/Z2Op+C435uIf2bvVnVSct0GKZjzoJD+J9DajjzRnO10FRijpY
         fRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RW58zr8YTNVHuTBfIVxZyU6EJd/oHLVvWKcypECtMjs=;
        b=NZLD/1ZnfqTE22GfAnKROoM2tinYz1582upX4r79rMC3Jq2gGdX9IK//6J/YV+d0Th
         jPlwCsXYhE0oG70zE7L7sYEFG0ZHKOcQ2Qc5XxaeafdtCY2bsrxLpYsZ68Wl5uDpnyr+
         MbZaZEoZ7SRgOIP4FD8SCtbMaLCtnkqcUwZAvwJJ5/d7urO1P+hvf/z4qqQyzk+hj5vN
         g63ZWQwmp11EG+oAEho4jvmGMgrK8DJ619BCRLO2Qy5EmfdHGmhBTuO4P/vVfO2zZcU+
         aMG8lzEMvP7JeUl/6Vj23f1n7Jau5JlJ6wJZcDt6gU8c8eEfN8ASC71qkKtLKbP8LTbm
         1SUA==
X-Gm-Message-State: APjAAAWTAysi/Oowam6IKZR+5ZT4RalQSQgtgcMnIfFNSNrP9sbhCoKN
        jPXZ2H7ccYtyXOx4yeR3rYH8jsNny5c=
X-Google-Smtp-Source: APXvYqwQcC+LL9E9LKfiZNHrcVJ95fvA4RxWhxexVl340jx3LOfHzjk66AKsaYtFFr6K39s9sLHHzA==
X-Received: by 2002:a05:620a:110f:: with SMTP id o15mr14029771qkk.127.1573590169690;
        Tue, 12 Nov 2019 12:22:49 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id p33sm13643736qtf.80.2019.11.12.12.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Nov 2019 12:22:48 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iUcgZ-0003jm-8M; Tue, 12 Nov 2019 16:22:47 -0400
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
Subject: [PATCH v3 03/14] mm/hmm: allow hmm_range to be used with a mmu_interval_notifier or hmm_mirror
Date:   Tue, 12 Nov 2019 16:22:20 -0400
Message-Id: <20191112202231.3856-4-jgg@ziepe.ca>
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

hmm_mirror's handling of ranges does not use a sequence count which
results in this bug:

         CPU0                                   CPU1
                                     hmm_range_wait_until_valid(range)
                                         valid == true
                                     hmm_range_fault(range)
hmm_invalidate_range_start()
   range->valid = false
hmm_invalidate_range_end()
   range->valid = true
                                     hmm_range_valid(range)
                                          valid == true

Where the hmm_range_valid() should not have succeeded.

Adding the required sequence count would make it nearly identical to the
new mmu_interval_notifier. Instead replace the hmm_mirror stuff with
mmu_interval_notifier.

Co-existence of the two APIs is the first step.

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
Tested-by: Philip Yang <Philip.Yang@amd.com>
Tested-by: Ralph Campbell <rcampbell@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 include/linux/hmm.h |  5 +++++
 mm/hmm.c            | 25 +++++++++++++++++++------
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 3fec513b9c00f1..fbb35c78637e57 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -145,6 +145,9 @@ enum hmm_pfn_value_e {
 /*
  * struct hmm_range - track invalidation lock on virtual address range
  *
+ * @notifier: an optional mmu_interval_notifier
+ * @notifier_seq: when notifier is used this is the result of
+ *                mmu_interval_read_begin()
  * @hmm: the core HMM structure this range is active against
  * @vma: the vm area struct for the range
  * @list: all range lock are on a list
@@ -159,6 +162,8 @@ enum hmm_pfn_value_e {
  * @valid: pfns array did not change since it has been fill by an HMM function
  */
 struct hmm_range {
+	struct mmu_interval_notifier *notifier;
+	unsigned long		notifier_seq;
 	struct hmm		*hmm;
 	struct list_head	list;
 	unsigned long		start;
diff --git a/mm/hmm.c b/mm/hmm.c
index 6b0136665407a3..8d060c5dabe37b 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -858,6 +858,14 @@ void hmm_range_unregister(struct hmm_range *range)
 }
 EXPORT_SYMBOL(hmm_range_unregister);
 
+static bool needs_retry(struct hmm_range *range)
+{
+	if (range->notifier)
+		return mmu_interval_check_retry(range->notifier,
+						range->notifier_seq);
+	return !range->valid;
+}
+
 static const struct mm_walk_ops hmm_walk_ops = {
 	.pud_entry	= hmm_vma_walk_pud,
 	.pmd_entry	= hmm_vma_walk_pmd,
@@ -898,18 +906,23 @@ long hmm_range_fault(struct hmm_range *range, unsigned int flags)
 	const unsigned long device_vma = VM_IO | VM_PFNMAP | VM_MIXEDMAP;
 	unsigned long start = range->start, end;
 	struct hmm_vma_walk hmm_vma_walk;
-	struct hmm *hmm = range->hmm;
+	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	int ret;
 
-	lockdep_assert_held(&hmm->mmu_notifier.mm->mmap_sem);
+	if (range->notifier)
+		mm = range->notifier->mm;
+	else
+		mm = range->hmm->mmu_notifier.mm;
+
+	lockdep_assert_held(&mm->mmap_sem);
 
 	do {
 		/* If range is no longer valid force retry. */
-		if (!range->valid)
+		if (needs_retry(range))
 			return -EBUSY;
 
-		vma = find_vma(hmm->mmu_notifier.mm, start);
+		vma = find_vma(mm, start);
 		if (vma == NULL || (vma->vm_flags & device_vma))
 			return -EFAULT;
 
@@ -939,7 +952,7 @@ long hmm_range_fault(struct hmm_range *range, unsigned int flags)
 			start = hmm_vma_walk.last;
 
 			/* Keep trying while the range is valid. */
-		} while (ret == -EBUSY && range->valid);
+		} while (ret == -EBUSY && !needs_retry(range));
 
 		if (ret) {
 			unsigned long i;
@@ -997,7 +1010,7 @@ long hmm_range_dma_map(struct hmm_range *range, struct device *device,
 			continue;
 
 		/* Check if range is being invalidated */
-		if (!range->valid) {
+		if (needs_retry(range)) {
 			ret = -EBUSY;
 			goto unmap;
 		}
-- 
2.24.0

