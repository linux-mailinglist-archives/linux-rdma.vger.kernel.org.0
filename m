Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C26290481
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Oct 2020 13:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407047AbgJPL6i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Oct 2020 07:58:38 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8266 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406924AbgJPL6i (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Oct 2020 07:58:38 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f898ae10000>; Fri, 16 Oct 2020 04:58:25 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Oct
 2020 11:58:35 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 16 Oct 2020 11:58:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYMOpQL6WRRdbJJLHAs2DzuhC3sTupW+p38NnXQv5gk3qq7Br806REnJ7Pvf83ExLtBODSZfj/WvH8byxTtjY9d49N/stVjDy6ALHN9ZzkW2d5+X4BHDFOcxvuSrWaWdOg1c43bR+NEcW3vCdhwhcB0X0ZhAyUJKqUcLuwtEnikbFWpVqfRxq/qP40GWDIi5IUK4ZojMSv09aRVyjDL4ZIAd9qef0vFQNoLN2k4uownNvowmrGz9zjQecc4DWmGtJwiFcZ8r/TOwhfewHKlVMsceZaXsjj+sZEhoJJnfM45Fwc+rnTHgGGO/ZjYkT9QvSCPoUB3hCrOW11dpP/piqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEWBlRyVhUzMPfK9amD0zVB2jyHX/+jzpzGeYznczJI=;
 b=TNPQGFJ53DNqjMy9vycPCsjiXsGR3ifaK+Xhv44SSKJ/9xwnSbUqGV7u1u7hG+d+tlvd44ZEbH+pjWWRXCcwAk6IRZ9TogMlMV0V9TVDDe/B8G7D7vyK3vLi8DvH8vjUNK0TQYV4HjLckiZEEpXdJ7e+AnTUkPWpG6WsA3HjWSzGlAONelhTNJYCXz2uXOGcxa3NptmneZTF9+s1/K5aWDQ95uygOs0aeS6yb4J6rSo2Lv5nLoxe959R20gTyfYo3e52gRZ71ZQ1Til44wuC7qHKlxlDJsC7T39f/363G+b3djbFvPbv1oOzlE8j5HziJkIIbpaByJZ/Pt38ycAF1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3739.namprd12.prod.outlook.com (2603:10b6:5:1c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Fri, 16 Oct
 2020 11:58:33 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.020; Fri, 16 Oct 2020
 11:58:32 +0000
Date:   Fri, 16 Oct 2020 08:58:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Ursulin, Tvrtko" <tvrtko.ursulin@intel.com>,
        <tvrtko.ursulin@linux.intel.com>
CC:     Maor Gottlieb <maorg@nvidia.com>, Christoph Hellwig <hch@lst.de>,
        "Gal Pressman" <galpress@amazon.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "Leon Romanovsky" <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: dynamic-sg patch has broken rdma_rxe
Message-ID: <20201016115831.GI6219@nvidia.com>
References: <0fdfc60e-ea93-8cf2-b23a-ce5d07d5fe33@gmail.com>
 <20201014225125.GC5316@nvidia.com>
 <e2763434-2f4f-9971-ae9d-62bab62b2e93@nvidia.com>
 <63997d02-827c-5a0d-c6a1-427cbeb4ef27@amazon.com>
 <8cf4796d-4dcb-ef5a-83ac-e11134eac99b@nvidia.com>
 <20201016003127.GD6219@nvidia.com>
 <796ca31aed8f469c957cb850385b9d09@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <796ca31aed8f469c957cb850385b9d09@intel.com>
X-ClientProxiedBy: MN2PR20CA0040.namprd20.prod.outlook.com
 (2603:10b6:208:235::9) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR20CA0040.namprd20.prod.outlook.com (2603:10b6:208:235::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Fri, 16 Oct 2020 11:58:32 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kTONT-000SC9-9m; Fri, 16 Oct 2020 08:58:31 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602849505; bh=GEWBlRyVhUzMPfK9amD0zVB2jyHX/+jzpzGeYznczJI=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=PEkn2beznHEMUJ073OuGdO3dWa2KZrnGeWAa6WQLPol5T/KGjW5hu6LL7sgYmCd4u
         KSAt5E+gEEs5cRzNcS/ZvrRmoWT0rfZLomu4ozZL1TU3/u1+Cefub5IT8/g1nUA7uP
         sCuwDPUblWhrtktKQIq0Kj6Rxjsd2QuJXyhgHivUG/MiXyM4T3n0LVPZ0BB5HgqDiB
         q+IjSGxpdhNFOZhjgvmFHusAfKQoIOG4GE09EWfN0wBzq7VVisvN1ckdULx5fnFyyB
         V5+fwyrvRl0wfPNCRL/U/Wd/oCt0ePO9WP03JRJnlahyejGKkGP2auJEAUgefrj9oN
         noDW38UouY9uA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 16, 2020 at 08:29:11AM +0000, Ursulin, Tvrtko wrote:
> 
> Hi guys,
> 
> [I removed the mailing list from cc since from this email address) I
> can't reply properly inline. (tvrtko.ursulin@linux.intel.com works
> better.)]

I put it back
 
> However:
> 
> +	/* Avoid overflow when computing sg_len + PAGE_SIZE */
> +	max_segment = max_segment & PAGE_MASK;
> +	if (WARN_ON(max_segment < PAGE_SIZE))
>  		return ERR_PTR(-EINVAL);
> 
> Maybe it's too early for me but I don't get this. It appears the
> condition can only be true if the max_segment is smaller than page
> size as passed in to the function to _start with_. Don't see what
> does filtering out low bits achieves on top.

The entire problem is the algorithm in __sg_alloc_table_from_pages()
only limits sg_len to

   sg_len == N * PAGE_SIZE <= ALIGN_UP(max_segment, PAGE_SIZE);

ie it overshoots max_segment if it is unaligned.

It also badly malfunctions if the ALIGN_UP() overflows, eg for
ALIGN_UP(UINT_MAX).

This is all internal problems inside __sg_alloc_table_from_pages() and
has nothing to do with the scatter lists themselves.

Adding an ALIGN_DOWN guarentees this algorithm produces sg_len <=
max_segment in all cases.

> If the intent is to allow unaligned max_segment then also please
> change kerneldoc.

Sure
 
> Although TBH I don't get how unaligned max segment makes sense. List
> can end on an unaligned segment but surely shouldn't have then in
> the middle.

The max_segment should either be UINT_MAX because the caller doesn't
care, or come from the DMA max_segment_size which is a HW limitation
usually derived from the # of bits available to express a length.

Conflating the HW limitation with the system PAGE_SIZE is
nonsense. This is further confused because the only reason we have an
alignment restriction is due to this algorithm design, the SGL rules
don't prevent the use of unaligned lengths, or length smaller than
PAGE_SIZE, even in the interior.

Jason

From b03302028893ce7465ba7e8736abba1922469bc1 Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@nvidia.com>
Date: Fri, 16 Oct 2020 08:46:01 -0300
Subject: [PATCH] lib/scatterlist: Do not limit max_segment to PAGE_ALIGNED
 values

The main intention of the max_segment argument to
__sg_alloc_table_from_pages() is to match the DMA layer segment size set
by dma_set_max_seg_size().

Restricting the input to be page aligned makes it impossible to just
connect the DMA layer to this API.

The only reason for a page alignment here is because the algorithm will
overshoot the max_segment if it is not a multiple of PAGE_SIZE. Simply fix
the alignment before starting and don't expose this implementation detail
to the callers.

A future patch will completely remove SCATTERLIST_MAX_SEGMENT.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 lib/scatterlist.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index e102fdfaa75be7..ed2497c79a216b 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -404,7 +404,7 @@ static struct scatterlist *get_next_sg(struct sg_table *table,
  * @n_pages:	 Number of pages in the pages array
  * @offset:      Offset from start of the first page to the start of a buffer
  * @size:        Number of valid bytes in the buffer (after offset)
- * @max_segment: Maximum size of a scatterlist node in bytes (page aligned)
+ * @max_segment: Maximum size of a scatterlist element in bytes
  * @prv:	 Last populated sge in sgt
  * @left_pages:  Left pages caller have to set after this call
  * @gfp_mask:	 GFP allocation mask
@@ -435,7 +435,12 @@ struct scatterlist *__sg_alloc_table_from_pages(struct sg_table *sgt,
 	unsigned int added_nents = 0;
 	struct scatterlist *s = prv;
 
-	if (WARN_ON(!max_segment || offset_in_page(max_segment)))
+	/*
+	 * The algorithm below requires max_segment to be aligned to PAGE_SIZE
+	 * otherwise it can overshoot.
+	 */
+	max_segment = ALIGN_DOWN(max_segment, PAGE_SIZE);
+	if (WARN_ON(max_segment < PAGE_SIZE))
 		return ERR_PTR(-EINVAL);
 
 	if (IS_ENABLED(CONFIG_ARCH_NO_SG_CHAIN) && prv)
@@ -542,8 +547,7 @@ int sg_alloc_table_from_pages(struct sg_table *sgt, struct page **pages,
 			      unsigned long size, gfp_t gfp_mask)
 {
 	return PTR_ERR_OR_ZERO(__sg_alloc_table_from_pages(sgt, pages, n_pages,
-			offset, size, SCATTERLIST_MAX_SEGMENT,
-			NULL, 0, gfp_mask));
+			offset, size, UINT_MAX, NULL, 0, gfp_mask));
 }
 EXPORT_SYMBOL(sg_alloc_table_from_pages);
 
-- 
2.28.0

