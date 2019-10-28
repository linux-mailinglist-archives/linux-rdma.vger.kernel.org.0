Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F156E79BA
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 21:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbfJ1UKs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 16:10:48 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45709 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbfJ1UKs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 16:10:48 -0400
Received: by mail-qk1-f194.google.com with SMTP id q70so9742624qke.12
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 13:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HY8VkDw3eNXkN3ve3RU1KQeIU43sa/wg6eleBANnW0s=;
        b=DEr56Hh74X+X72AV3xFwB6L9JnBevGoNetIPQYOP/zd2/Yqv+xW0QpRIlNYHPORLpb
         oQEYkPMf4Lal5RDCcNxJl8AJ7ze8/fRAkBBJODYY12IZB6jSoMY/va88pG9h2W8WqUOR
         37mptL5bDe0UcHD8ZJ6M37AhsomlQ64wZvaR8kLiBLvpO4rdwxODI52hYTY6cYK3kbfn
         KfvRbvYIffFczb6KVSKFN4d3pyp1+Qb0QW1ESq9SRe188VhVqmT3emeOA8NR0UzHL3Et
         zm5fH13BimjlZKpgLBRiIrFmvRL+pQnMJMLkYtEvLA09BG+LXZe63sB5laWjspNVkK68
         BKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HY8VkDw3eNXkN3ve3RU1KQeIU43sa/wg6eleBANnW0s=;
        b=SDdyXWnrqj5KK7AhjR/D0JEYxxHHdJdFHxKZ26fQLfw1kclj8oReTeR5LHYn69de4q
         mYVSNTXJB2o5qVEOKnU5699PNovTGkDq9uF8Lv/10E0lo85ZMkApmuNhXTHpuWSmiwZ4
         yWr1sOhbkrlS8JU+YHhpdhn6lE2y16Zuj8d5wjmAR3XmZphVGxx25NnaeR7E4DQIUkTQ
         SUjRbqkmUEgFVUQWPR1trSh5A0WZdkTdcbsiJMPj10IjrfVfcRf2F1Pxlrp1dB5BnLaE
         RmMlAl2cc+PLmnFhxqNTUX9GKA+G7zHNQxAgFjSj1ALLiAWiF73Xu4OYsydXLK69E9xt
         xIsQ==
X-Gm-Message-State: APjAAAXfF9RwJrpHuc2Cozc0DkYTeGCBa6TEKXNkQWSvD+BOjmob/T0B
        EiCIYTkMjhuvYUdq8Lc0sysbyA==
X-Google-Smtp-Source: APXvYqwif0aVeBBMbFc9Yj1JzTl7fNWCptP6HcE8ZUm49PZ2JWsZu6LE81XhNg4T5SkIR5YG7CpXEg==
X-Received: by 2002:a05:620a:74b:: with SMTP id i11mr17365591qki.397.1572293447074;
        Mon, 28 Oct 2019 13:10:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id o3sm3980109qkf.97.2019.10.28.13.10.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 13:10:43 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iPBLf-0001gG-5c; Mon, 28 Oct 2019 17:10:43 -0300
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
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH v2 03/15] mm/hmm: allow hmm_range to be used with a mmu_range_notifier or hmm_mirror
Date:   Mon, 28 Oct 2019 17:10:20 -0300
Message-Id: <20191028201032.6352-4-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028201032.6352-1-jgg@ziepe.ca>
References: <20191028201032.6352-1-jgg@ziepe.ca>
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

Where the hmm_range_valid should not have succeeded.

Adding the required sequence count would make it nearly identical to the
new mmu_range_notifier. Instead replace the hmm_mirror stuff with
mmu_range_notifier.

Co-existence of the two APIs is the first step.

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 include/linux/hmm.h |  5 +++++
 mm/hmm.c            | 25 +++++++++++++++++++------
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 3fec513b9c00f1..8ac1fd6a81af8f 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -145,6 +145,9 @@ enum hmm_pfn_value_e {
 /*
  * struct hmm_range - track invalidation lock on virtual address range
  *
+ * @notifier: an optional mmu_range_notifier
+ * @notifier_seq: when notifier is used this is the result of
+ *                mmu_range_read_begin()
  * @hmm: the core HMM structure this range is active against
  * @vma: the vm area struct for the range
  * @list: all range lock are on a list
@@ -159,6 +162,8 @@ enum hmm_pfn_value_e {
  * @valid: pfns array did not change since it has been fill by an HMM function
  */
 struct hmm_range {
+	struct mmu_range_notifier *notifier;
+	unsigned long		notifier_seq;
 	struct hmm		*hmm;
 	struct list_head	list;
 	unsigned long		start;
diff --git a/mm/hmm.c b/mm/hmm.c
index 902f5fa6bf93ad..22ac3595771feb 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -852,6 +852,14 @@ void hmm_range_unregister(struct hmm_range *range)
 }
 EXPORT_SYMBOL(hmm_range_unregister);
 
+static bool needs_retry(struct hmm_range *range)
+{
+	if (range->notifier)
+		return mmu_range_check_retry(range->notifier,
+					     range->notifier_seq);
+	return !range->valid;
+}
+
 static const struct mm_walk_ops hmm_walk_ops = {
 	.pud_entry	= hmm_vma_walk_pud,
 	.pmd_entry	= hmm_vma_walk_pmd,
@@ -892,18 +900,23 @@ long hmm_range_fault(struct hmm_range *range, unsigned int flags)
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
 
@@ -933,7 +946,7 @@ long hmm_range_fault(struct hmm_range *range, unsigned int flags)
 			start = hmm_vma_walk.last;
 
 			/* Keep trying while the range is valid. */
-		} while (ret == -EBUSY && range->valid);
+		} while (ret == -EBUSY && !needs_retry(range));
 
 		if (ret) {
 			unsigned long i;
@@ -991,7 +1004,7 @@ long hmm_range_dma_map(struct hmm_range *range, struct device *device,
 			continue;
 
 		/* Check if range is being invalidated */
-		if (!range->valid) {
+		if (needs_retry(range)) {
 			ret = -EBUSY;
 			goto unmap;
 		}
-- 
2.23.0

