Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8631BE2373
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 21:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389667AbfJWTzW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 15:55:22 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19354 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbfJWTzW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Oct 2019 15:55:22 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5db0b0330000>; Wed, 23 Oct 2019 12:55:31 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 23 Oct 2019 12:55:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 23 Oct 2019 12:55:21 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 23 Oct
 2019 19:55:21 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 23 Oct
 2019 19:55:19 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 23 Oct 2019 19:55:19 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5db0b0270001>; Wed, 23 Oct 2019 12:55:19 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH v3 2/3] mm/hmm: allow snapshot of the special zero page
Date:   Wed, 23 Oct 2019 12:55:14 -0700
Message-ID: <20191023195515.13168-3-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191023195515.13168-1-rcampbell@nvidia.com>
References: <20191023195515.13168-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571860531; bh=EX0bbHxK/iAtD7z9QXzYOmMILzO2RoXi4bWaJEIf6tU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Type:Content-Transfer-Encoding;
        b=NSjudj3Amk7YhSyBkxDUUsM8HQ70EkOJRBtGC1+hAxxF4v1egWqIkh/zJZYNC1Q+S
         5w56SvKKzQknvOOP/RFwj+bE7kc3iWtQMG3FTES26Tke1g8A+6OhaLeMLWH90BOT3s
         Sm094urfKBVURhdYRBZX8UUDccf3ZVvEjbnVLpqArlgm2AAkGvlY9fbl3J8Dv/2tOO
         Yd9QEk80QBSQo3zjh/Sq1YI7oOGscc3SXK6JBnvxSNV7VQ6VIDbEfkBEw2Dtall2fV
         NVOBYn6SI+RatjZA3KAG5LhyXUK8AmQejMJHQeb+/AgW9UMpg7RmFmnYjescoBEuXi
         pHIHEZuEDeKSw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If a device driver like nouveau tries to use hmm_range_fault() to access
the special shared zero page in system memory, hmm_range_fault() will
return -EFAULT and kill the process.
Allow hmm_range_fault() to return success (0) when the CPU pagetable
entry points to the special shared zero page.
page_to_pfn() and pfn_to_page() are defined on the zero page so just
handle it like any other page.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
---
 mm/hmm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index acf7a664b38c..8c96c9ddcae5 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -529,8 +529,14 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, un=
signed long addr,
 		if (unlikely(!hmm_vma_walk->pgmap))
 			return -EBUSY;
 	} else if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pte_special(pte)) {
-		*pfn =3D range->values[HMM_PFN_SPECIAL];
-		return -EFAULT;
+		if (!is_zero_pfn(pte_pfn(pte))) {
+			*pfn =3D range->values[HMM_PFN_SPECIAL];
+			return -EFAULT;
+		}
+		/*
+		 * Since each architecture defines a struct page for the zero
+		 * page, just fall through and treat it like a normal page.
+		 */
 	}
=20
 	*pfn =3D hmm_device_entry_from_pfn(range, pte_pfn(pte)) | cpu_flags;
--=20
2.20.1

