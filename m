Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F67DD7EA4
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2019 20:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfJOSQd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Oct 2019 14:16:33 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39449 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfJOSQd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Oct 2019 14:16:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id s17so9965909plp.6
        for <linux-rdma@vger.kernel.org>; Tue, 15 Oct 2019 11:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cpXvWgqC++htg5t4tfaxCh8tm+v/06g7WiSmKM05mvw=;
        b=JuyClk7PKCaLwoQ+105chr3B4/YZVWePEMx44i+al/c0waHUPFVmcMJsk69iurM8xR
         TqIwh/dWh7/bezrzPA7KI4qy1RM9p4IWVXMg7fLRvoeynPIE47WqsqslPXSo0Nocyp8b
         S+/SYVDKWfxiXPCAFo7rRERONWIezL1LF4kOXzYqimZaG7E71vm9BsTxd6TJBsVwKqYW
         LBpwbsRaDkCFam+Aap+a3+qNpe/qW0b8h9rg7ONtiZhkEE9NnE0x3yb081fUXtFapyMg
         +2aW6MdXKqWTKPnnE77vavOkmbSBi9iBgcYZl0B6Q0XT/ieElII5zYsv38J1WN9BsZGN
         t/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cpXvWgqC++htg5t4tfaxCh8tm+v/06g7WiSmKM05mvw=;
        b=XQ2GL/wVG/UvoOr20IWtnKJ9ys2HO8+Hd3FCToee8Rw3kc41PofXEqfAYxGXljJqej
         MVNJVZ8LGAx9wMHRV13dxY1t7a8J8DI1Y2Iylz8ACT7OduyKPqs7puS5+aA8OoBduIq2
         S7N0om9R21HGtW6HLVWvw21whxOy+YC2SWsQZQr5flDcqveOQi4HAghzvbU7XH7hpwMS
         4A7lSPbWuEDZhCRS9FW7g4DNYD0UDrbloaGCjObC5OmQysg9QXnprpdZ2oWj33WTUQJj
         h/MlN62rih9Z70AYPSwrFfd8hB17uUG81cfRx31vaaRKnvYaC2OYj2uTMHO0CHYobeXc
         823g==
X-Gm-Message-State: APjAAAWKc+ZF9SnRRywBjQyIICc29+JCytPm/jvV01V1HcM1waKGj6+c
        BVsZzGcxp5jcmeaPDgwlZU8WrA==
X-Google-Smtp-Source: APXvYqylDFeyHP+orjZdFPigy5QgoSehDBF4HXwVxw56pNjg/wm3jT8eRKmoaCJljZuzzdfaqS/x2A==
X-Received: by 2002:a17:902:820f:: with SMTP id x15mr37595901pln.288.1571163392460;
        Tue, 15 Oct 2019 11:16:32 -0700 (PDT)
Received: from ziepe.ca ([24.114.26.129])
        by smtp.gmail.com with ESMTPSA id u9sm19594pjb.4.2019.10.15.11.16.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Oct 2019 11:16:32 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iKRJT-0002Bw-Ay; Tue, 15 Oct 2019 15:12:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH hmm 03/15] mm/hmm: allow hmm_range to be used with a mmu_range_notifier or hmm_mirror
Date:   Tue, 15 Oct 2019 15:12:30 -0300
Message-Id: <20191015181242.8343-4-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015181242.8343-1-jgg@ziepe.ca>
References: <20191015181242.8343-1-jgg@ziepe.ca>
MIME-Version: 1.0
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

