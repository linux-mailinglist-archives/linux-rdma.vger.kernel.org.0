Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40FE337046
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Mar 2021 11:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhCKKmJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Mar 2021 05:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbhCKKlz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Mar 2021 05:41:55 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281EDC061574
        for <linux-rdma@vger.kernel.org>; Thu, 11 Mar 2021 02:41:55 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id x78so22662842oix.1
        for <linux-rdma@vger.kernel.org>; Thu, 11 Mar 2021 02:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/AIXNMQiOLSxyhvCergzcLlyBOuxPf9jvOK40afamlc=;
        b=kLFUzN9fa6SZc7zAOcW1U5FKYtngV0N8Ld3jTR9EusFhNd7avBOSmjgSnv3aooyvp0
         oH5WhYaB0ya2zWCmiPDknZbSNgC5x2sxkITPgSB3RJxlKK4JGsinfKySJLzl9KV+HSL7
         92E7926iHM2Xcy2nYf30GbhMpOtFGi4da9sCyu5ATmMnZHtbVO1IvcSjsZkZ9nZHix0n
         DvAt8be89L+luqfhrpj3GQIHb4ETfCYddwVTrTfreRPg8F7R1m9eorI9RWrwA2F5IcJT
         81N7crAdaW92ksnMkAVm/HJIB/dxfgghpEDLuyfOjBwUoLMm3bdsvWLzwKLeqVtQxvEZ
         eWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/AIXNMQiOLSxyhvCergzcLlyBOuxPf9jvOK40afamlc=;
        b=mkwbm/viX+M+NgqH1qaIoo5cv41V+aPzkPYhFPxfyae75SpFZqRxAHkjoCtVQFut4O
         WgXIlShamQPlDaZaLo00h6XG5pyJYCk23I9D2tWCKnZ/S4Y9X9xfqRb/TAch6xGoncoF
         9pHByt1Anxat9ZQ+As1ezX+KhxzD5lNkeczezj2T4JZ/L1SD0dbNJVB6a1RnspEas/3s
         8saSuUDFryrqzRr+XBUCI5G3h5wZyjt6FdDik+hXMFhtECZ42reDkUEGv48bqSf8omNi
         x+aSLA5WLszmFhyfTgmBtaWWZfNvGy5k1n6ayNmhjhYx9lmXGflQ37WmRy8f2n2pXhkS
         YBYA==
X-Gm-Message-State: AOAM530b6gKwZyVFG8gdi90K2l/I+1SyFWRrYLZspws4THVfDV+1xv5X
        A0eZB74t+0jUJw+ZdRQPrkfwhbZwFddy4bTai3zlh2/NmhteWg==
X-Google-Smtp-Source: ABdhPJymDuF9tNTB74BQyhhU7QEfMd1grFLD8u2wlPUyFdlEu0K4mHL9ZLxKqHfaVv9XWTPc7uR82icsWlkJt8jVAjs=
X-Received: by 2002:aca:3a41:: with SMTP id h62mr5728105oia.89.1615459314611;
 Thu, 11 Mar 2021 02:41:54 -0800 (PST)
MIME-Version: 1.0
References: <20210307221034.568606-1-yanjun.zhu@intel.com> <CAD=hENeqTTmpS5V+G646V0QvJFLVSd3Sq11ffQFcDXU-OSsQEg@mail.gmail.com>
 <YEUL2vdlWFEbZqLb@unreal> <CAD=hENcjqtXstsa3bbBCZVGF-XgAhPz-1tom68zm7WNatH2mZw@mail.gmail.com>
 <20210308121615.GW4247@nvidia.com>
In-Reply-To: <20210308121615.GW4247@nvidia.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 11 Mar 2021 18:41:43 +0800
Message-ID: <CAD=hENdymrkFV-_piiOKL-fK38SQh3sTAfc7+WPSky8mHtJ8DA@mail.gmail.com>
Subject: Re: Fwd: [PATCH 1/1] RDMA/umem: add back hugepage sg list
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        maorg@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 8, 2021 at 8:16 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Mon, Mar 08, 2021 at 06:13:52PM +0800, Zhu Yanjun wrote:
>
> > And I delved into the source code of __sg_alloc_table_from_pages. I
> > found that this function is related with ib_dma_max_seg_size. So
> > when ib_dma_max_seg_size is set to UINT_MAX, the sg dma address is
> > 4K (one page). When ib_dma_max_seg_size is set to SZ_2M, the sg dma
> > address is 2M now.
>
> That seems like a bug, you should fix it

Hi, Jason && Leon

I compared the function __sg_alloc_table_from_pages with ib_umem_add_sg_table.
In __sg_alloc_table_from_pages:

"
 449         if (prv) {
 450                 unsigned long paddr = (page_to_pfn(sg_page(prv))
* PAGE_SIZE +
 451                                        prv->offset + prv->length) /
 452                                       PAGE_SIZE;
 453
 454                 if (WARN_ON(offset))
 455                         return ERR_PTR(-EINVAL);
 456
 457                 /* Merge contiguous pages into the last SG */
 458                 prv_len = prv->length;
 459                 while (n_pages && page_to_pfn(pages[0]) == paddr) {
 460                         if (prv->length + PAGE_SIZE > max_segment)
 461                                 break;
 462                         prv->length += PAGE_SIZE;
 463                         paddr++;
 464                         pages++;
 465                         n_pages--;
 466                 }
 467                 if (!n_pages)
 468                         goto out;
 469         }

"
if prv->length + PAGE_SIZE > max_segment, then set another sg.
In the commit "RDMA/umem: Move to allocate SG table from pages",
max_segment is dma_get_max_seg_size.
Normally it is UINT_MAX. So in my host, prv->length + PAGE_SIZE is
usually less than max_segment
since length is unsigned int.

So the following has very few chance to execute.
"
 485         for (i = 0; i < chunks; i++) {
 ...
 490                 for (j = cur_page + 1; j < n_pages; j++) {
 491                         seg_len += PAGE_SIZE;
 492                         if (seg_len >= max_segment ||
 493                             page_to_pfn(pages[j]) !=
 494                             page_to_pfn(pages[j - 1]) + 1)
 495                                 break;
 496                 }
 497
 498                 /* Pass how many chunks might be left */
 499                 s = get_next_sg(sgt, s, chunks - i + left_pages, gfp_mask);
...
 510                 sg_set_page(s, pages[cur_page],
 511                             min_t(unsigned long, size,
chunk_size), offset);
 512                 added_nents++;
...
516         }
"

In the function ib_umem_add_sg_table, max_segment is used like the below:
"
               /* Squash N contiguous pages from page_list into current sge */
               if (update_cur_sg) {
                       if ((max_seg_sz - sg->length) >= (len << PAGE_SHIFT)) {
                               sg_set_page(sg, sg_page(sg),
                                           sg->length + (len << PAGE_SHIFT),
                                           0);
                               update_cur_sg = false;
                               continue;
                       }
                       update_cur_sg = false;
               }

               /* Squash N contiguous pages into next sge or first sge */
               if (!first)
                       sg = sg_next(sg);

               (*nents)++;
               sg_set_page(sg, first_page, len << PAGE_SHIFT, 0);
"
if (max_seg_sz - sg->length) >= (len << PAGE_SHIFT),
the function sg_next and sg_set_page are called several times.

The different usage of max_seg_sz/max_segment is the root cause that
sg_dma_addresses
are different from the function __sg_alloc_table_from_pages and
ib_umem_add_sg_table.

The following commit tries to fix this problem, please comment on it.

From 65472ef21146b0fb72d5eb3e2fe1277380d29446 Mon Sep 17 00:00:00 2001
From: Zhu Yanjun <zyjzyj2000@gmail.com>
Date: Thu, 11 Mar 2021 12:35:40 -0500
Subject: [PATCH 1/1] RDMA/umem: fix different sg_dma_address problem

After the commit 0c16d9635e3a ("RDMA/umem: Move to allocate
SG table from pages"), the returned sg list has the different dma
addresses compared with the removed the function ib_umem_add_sg_table.

The root cause is that max_seg_sz/max_segment has different usage in
the function ib_umem_add_sg_table and __sg_alloc_table_from_pages.

Fixes: 0c16d9635e3a ("RDMA/umem: Move to allocate SG table from pages")
Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
---
 drivers/infiniband/core/umem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 2dde99a9ba07..71188edbb45f 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -232,7 +232,9 @@ struct ib_umem *ib_umem_get(struct ib_device
*device, unsigned long addr,
                npages -= ret;
                sg = __sg_alloc_table_from_pages(&umem->sg_head, page_list, ret,
                                0, ret << PAGE_SHIFT,
-                               ib_dma_max_seg_size(device), sg, npages,
+                               min_t(unsigned int,
+                               ib_dma_max_seg_size(device), ret * PAGE_SIZE),
+                               sg, npages,
                                GFP_KERNEL);
                umem->sg_nents = umem->sg_head.nents;
                if (IS_ERR(sg)) {
--
2.27.0

>
> Jason
