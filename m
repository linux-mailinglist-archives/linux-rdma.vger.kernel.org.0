Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC320E2379
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 21:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390393AbfJWTzb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 15:55:31 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13134 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390336AbfJWTzY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Oct 2019 15:55:24 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5db0b0300000>; Wed, 23 Oct 2019 12:55:28 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 23 Oct 2019 12:55:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 23 Oct 2019 12:55:22 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 23 Oct
 2019 19:55:18 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 23 Oct 2019 19:55:18 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5db0b0260000>; Wed, 23 Oct 2019 12:55:18 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH v3 1/3] mm/hmm: make full use of walk_page_range()
Date:   Wed, 23 Oct 2019 12:55:13 -0700
Message-ID: <20191023195515.13168-2-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191023195515.13168-1-rcampbell@nvidia.com>
References: <20191023195515.13168-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571860528; bh=fsfRCytms4fgE2F9rfEkyXVeGbVIXVlkX98FEecPdgw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Type:Content-Transfer-Encoding;
        b=D7OAAZ/ZXkoILKwvktfytV45lzptStVZotCq33THh72cKN5VW5RU+Sg5FlOKJBiGm
         XgqDTR8PwGyTtxsinAHeRqK6E3iTvYy60pC2f+U5qElNptNAOEHzD7bnVyaLTODMdM
         YaIxK7TOgVtSqmcvDINQDUPWVi5XE+i6LJMlGMpst+sGWmWkB1lBEM4zvJTmJZlaVV
         ChR3OaqMaXR88f9w3q9AKlNjf8TZlorIdKA1zXwqqnW4PK2KRrvr3eOcgo3o4xfigs
         8vcBpPEVZSFQV3HweIl9lCXSV8rc3HNo+jcj3WnA09GxaqpiyjyO7R02a0mPgM67zT
         lEnSKIkoinO3Q==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

hmm_range_fault() calls find_vma() and walk_page_range() in a loop.
This is unnecessary duplication since walk_page_range() calls find_vma()
in a loop already.
Simplify hmm_range_fault() by defining a walk_test() callback function
to filter unhandled vmas.
This also fixes a bug where hmm_range_fault() was not checking
start >=3D vma->vm_start before checking vma->vm_flags so hmm_range_fault()
could return an error based on the wrong vma for the requested range.
It also fixes a bug when the vma has no read access and the caller did
not request a fault, there shouldn't be any error return code.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Christoph Hellwig <hch@lst.de>
---
 mm/hmm.c | 126 +++++++++++++++++++++++++++----------------------------
 1 file changed, 63 insertions(+), 63 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 902f5fa6bf93..acf7a664b38c 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -252,18 +252,15 @@ static int hmm_vma_do_fault(struct mm_walk *walk, uns=
igned long addr,
 	return -EFAULT;
 }
=20
-static int hmm_pfns_bad(unsigned long addr,
-			unsigned long end,
-			struct mm_walk *walk)
+static int hmm_pfns_fill(unsigned long addr, unsigned long end,
+		struct hmm_range *range, enum hmm_pfn_value_e value)
 {
-	struct hmm_vma_walk *hmm_vma_walk =3D walk->private;
-	struct hmm_range *range =3D hmm_vma_walk->range;
 	uint64_t *pfns =3D range->pfns;
 	unsigned long i;
=20
 	i =3D (addr - range->start) >> PAGE_SHIFT;
 	for (; addr < end; addr +=3D PAGE_SIZE, i++)
-		pfns[i] =3D range->values[HMM_PFN_ERROR];
+		pfns[i] =3D range->values[value];
=20
 	return 0;
 }
@@ -584,7 +581,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		}
 		return 0;
 	} else if (!pmd_present(pmd))
-		return hmm_pfns_bad(start, end, walk);
+		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
=20
 	if (pmd_devmap(pmd) || pmd_trans_huge(pmd)) {
 		/*
@@ -612,7 +609,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 	 * recover.
 	 */
 	if (pmd_bad(pmd))
-		return hmm_pfns_bad(start, end, walk);
+		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
=20
 	ptep =3D pte_offset_map(pmdp, addr);
 	i =3D (addr - range->start) >> PAGE_SHIFT;
@@ -770,13 +767,51 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, uns=
igned long hmask,
 #define hmm_vma_walk_hugetlb_entry NULL
 #endif /* CONFIG_HUGETLB_PAGE */
=20
-static void hmm_pfns_clear(struct hmm_range *range,
-			   uint64_t *pfns,
-			   unsigned long addr,
-			   unsigned long end)
+static int hmm_vma_walk_test(unsigned long start, unsigned long end,
+			     struct mm_walk *walk)
 {
-	for (; addr < end; addr +=3D PAGE_SIZE, pfns++)
-		*pfns =3D range->values[HMM_PFN_NONE];
+	struct hmm_vma_walk *hmm_vma_walk =3D walk->private;
+	struct hmm_range *range =3D hmm_vma_walk->range;
+	struct vm_area_struct *vma =3D walk->vma;
+
+	/* If range is no longer valid, force retry. */
+	if (!range->valid)
+		return -EBUSY;
+
+	/*
+	 * Skip vma ranges that don't have struct page backing them or
+	 * map I/O devices directly.
+	 */
+	if (vma->vm_flags & (VM_IO | VM_PFNMAP | VM_MIXEDMAP))
+		return -EFAULT;
+
+	/*
+	 * If the vma does not allow read access, then assume that it does not
+	 * allow write access either. HMM does not support architectures
+	 * that allow write without read.
+	 */
+	if (!(vma->vm_flags & VM_READ)) {
+		bool fault, write_fault;
+
+		/*
+		 * Check to see if a fault is requested for any page in the
+		 * range.
+		 */
+		hmm_range_need_fault(hmm_vma_walk, range->pfns +
+					((start - range->start) >> PAGE_SHIFT),
+					(end - start) >> PAGE_SHIFT,
+					0, &fault, &write_fault);
+		if (fault || write_fault)
+			return -EFAULT;
+
+		hmm_pfns_fill(start, end, range, HMM_PFN_NONE);
+		hmm_vma_walk->last =3D end;
+
+		/* Skip this vma and continue processing the next vma. */
+		return 1;
+	}
+
+	return 0;
 }
=20
 /*
@@ -857,6 +892,7 @@ static const struct mm_walk_ops hmm_walk_ops =3D {
 	.pmd_entry	=3D hmm_vma_walk_pmd,
 	.pte_hole	=3D hmm_vma_walk_hole,
 	.hugetlb_entry	=3D hmm_vma_walk_hugetlb_entry,
+	.test_walk	=3D hmm_vma_walk_test,
 };
=20
 /**
@@ -889,63 +925,27 @@ static const struct mm_walk_ops hmm_walk_ops =3D {
  */
 long hmm_range_fault(struct hmm_range *range, unsigned int flags)
 {
-	const unsigned long device_vma =3D VM_IO | VM_PFNMAP | VM_MIXEDMAP;
-	unsigned long start =3D range->start, end;
-	struct hmm_vma_walk hmm_vma_walk;
+	unsigned long start =3D range->start;
+	struct hmm_vma_walk hmm_vma_walk =3D {
+		.range =3D range,
+		.last =3D start,
+		.flags =3D flags,
+	};
 	struct hmm *hmm =3D range->hmm;
-	struct vm_area_struct *vma;
 	int ret;
=20
 	lockdep_assert_held(&hmm->mmu_notifier.mm->mmap_sem);
=20
 	do {
-		/* If range is no longer valid force retry. */
-		if (!range->valid)
-			return -EBUSY;
-
-		vma =3D find_vma(hmm->mmu_notifier.mm, start);
-		if (vma =3D=3D NULL || (vma->vm_flags & device_vma))
-			return -EFAULT;
-
-		if (!(vma->vm_flags & VM_READ)) {
-			/*
-			 * If vma do not allow read access, then assume that it
-			 * does not allow write access, either. HMM does not
-			 * support architecture that allow write without read.
-			 */
-			hmm_pfns_clear(range, range->pfns,
-				range->start, range->end);
-			return -EPERM;
-		}
-
-		hmm_vma_walk.pgmap =3D NULL;
-		hmm_vma_walk.last =3D start;
-		hmm_vma_walk.flags =3D flags;
-		hmm_vma_walk.range =3D range;
-		end =3D min(range->end, vma->vm_end);
-
-		walk_page_range(vma->vm_mm, start, end, &hmm_walk_ops,
-				&hmm_vma_walk);
-
-		do {
-			ret =3D walk_page_range(vma->vm_mm, start, end,
-					&hmm_walk_ops, &hmm_vma_walk);
-			start =3D hmm_vma_walk.last;
+		ret =3D walk_page_range(hmm->mmu_notifier.mm, start, range->end,
+				      &hmm_walk_ops, &hmm_vma_walk);
+		start =3D hmm_vma_walk.last;
=20
-			/* Keep trying while the range is valid. */
-		} while (ret =3D=3D -EBUSY && range->valid);
+		/* Keep trying while the range is valid. */
+	} while (ret =3D=3D -EBUSY && range->valid);
=20
-		if (ret) {
-			unsigned long i;
-
-			i =3D (hmm_vma_walk.last - range->start) >> PAGE_SHIFT;
-			hmm_pfns_clear(range, &range->pfns[i],
-				hmm_vma_walk.last, range->end);
-			return ret;
-		}
-		start =3D end;
-
-	} while (start < range->end);
+	if (ret)
+		return ret;
=20
 	return (hmm_vma_walk.last - range->start) >> PAGE_SHIFT;
 }
--=20
2.20.1

