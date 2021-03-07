Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDE9330212
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Mar 2021 15:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhCGO3L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 7 Mar 2021 09:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhCGO2p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 7 Mar 2021 09:28:45 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4F3C06174A
        for <linux-rdma@vger.kernel.org>; Sun,  7 Mar 2021 06:28:45 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id z126so8211059oiz.6
        for <linux-rdma@vger.kernel.org>; Sun, 07 Mar 2021 06:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=nkHABVTHP/F/R/jc6dcztR6uC42f/T3Dv3LN/B9xvR4=;
        b=fntKwn9R4Z36DADOgUXadAPD8lJqnRtwTSHA6FGJjjR5ni6Kh5DBuI3a3ShtgxIFaB
         Az1N0HnWNnjMmj9p70tJn9kqd72YGMKN6yEaXPdXMZ5XT4xwVSj5b1EZLFxmKLjvu6+p
         rdakRBETpVewwtKO4cFu4dOBRprFMYOSOKho0SOW79n5R1hARpBO6gzsgj+EZDmhLmoB
         J2hSpG71A1mHIYX5/cyxI67UR65Zx8h544N4cgjCB01DZIVeiGLfWk3UrpQEQaYHYU2w
         r+rxXYnUw8Dr/5+HoChhC3Fx2bdVP4zKTxhUSsEAn5oDTNXb6qke/xTE/A53euQ9HEcL
         RAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=nkHABVTHP/F/R/jc6dcztR6uC42f/T3Dv3LN/B9xvR4=;
        b=bPmuG45dCJJwctMoLVhfvOxjIjz48Qrdop3n5jkcQArDaKtXzj388m4xnrnFgLkTcV
         1yWb6vShNFpwsYQJM+v4q9yyZmKEWjP/ci+RbrR+DQyEUy3B9H2UpnuOA+eNerb/h0er
         YEtWKNoW2RK25F7aMhg8amQpzJXL3ZwjeTz4ZUG7GEWCG/W7bT9sKK4aq8aGwgV4H69I
         xvppq7/4PP0TmYMSdNGtjs6kzgo7qYMOlZPK/bXP5DnuL6SIg/GxIYQJrvFe1i7cC8Mj
         Z8rWHFIzL5SGk3NDA7eLXbNjyxFreUavMuYDVrRXA6WxVoevXqUYs249e8cpnMvLDOnx
         5/Ag==
X-Gm-Message-State: AOAM531tvTq1xS/17sQhP7zD7wS4gjl7IZMLGcmChB/su3tI+6RhErLy
        WyI6SyYWer3fcwrQ3v02qbOODp/eEMpWDHjBgco=
X-Google-Smtp-Source: ABdhPJyxO/QpVuuv4ivPWMyPNOfjNruh/GusECVUE3+n95tFdwz1AMWvJ8soYRESWO/0Ibm+tyYInrIYYB5RKyOmQVQ=
X-Received: by 2002:a05:6808:656:: with SMTP id z22mr13440464oih.163.1615127324719;
 Sun, 07 Mar 2021 06:28:44 -0800 (PST)
MIME-Version: 1.0
References: <20210307221034.568606-1-yanjun.zhu@intel.com>
In-Reply-To: <20210307221034.568606-1-yanjun.zhu@intel.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Sun, 7 Mar 2021 22:28:33 +0800
Message-ID: <CAD=hENeqTTmpS5V+G646V0QvJFLVSd3Sq11ffQFcDXU-OSsQEg@mail.gmail.com>
Subject: Fwd: [PATCH 1/1] RDMA/umem: add back hugepage sg list
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        maorg@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <zyjzyj2000@gmail.com>

After the commit ("RDMA/umem: Move to allocate SG table from pages"),
the sg list from ib_ume_get is like the following:
"
sg_dma_address(sg):0x4b3c1ce000
sg_dma_address(sg):0x4c3c1cd000
sg_dma_address(sg):0x4d3c1cc000
sg_dma_address(sg):0x4e3c1cb000
"

But sometimes, we need sg list like the following:
"
sg_dma_address(sg):0x203b400000
sg_dma_address(sg):0x213b200000
sg_dma_address(sg):0x223b000000
sg_dma_address(sg):0x233ae00000
sg_dma_address(sg):0x243ac00000
"
The function ib_umem_add_sg_table can provide the sg list like the
second. And this function is removed in the commit ("RDMA/umem: Move
to allocate SG table from pages"). Now I add it back.

The new function is ib_umem_get to ib_umem_hugepage_get that calls
ib_umem_add_sg_table.

This function ib_umem_huagepage_get can get 4K, 2M sg list dma address.

Fixes: 0c16d9635e3a ("RDMA/umem: Move to allocate SG table from pages")
Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
---
 drivers/infiniband/core/umem.c | 197 +++++++++++++++++++++++++++++++++
 include/rdma/ib_umem.h         |   3 +
 2 files changed, 200 insertions(+)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 2dde99a9ba07..af8733788b1e 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -62,6 +62,203 @@ static void __ib_umem_release(struct ib_device
*dev, struct ib_umem *umem, int d
        sg_free_table(&umem->sg_head);
 }

+/* ib_umem_add_sg_table - Add N contiguous pages to scatter table
+ *
+ * sg: current scatterlist entry
+ * page_list: array of npage struct page pointers
+ * npages: number of pages in page_list
+ * max_seg_sz: maximum segment size in bytes
+ * nents: [out] number of entries in the scatterlist
+ *
+ * Return new end of scatterlist
+ */
+static struct scatterlist *ib_umem_add_sg_table(struct scatterlist *sg,
+                                               struct page **page_list,
+                                               unsigned long npages,
+                                               unsigned int max_seg_sz,
+                                               int *nents)
+{
+       unsigned long first_pfn;
+       unsigned long i = 0;
+       bool update_cur_sg = false;
+       bool first = !sg_page(sg);
+
+       /* Check if new page_list is contiguous with end of previous page_list.
+        * sg->length here is a multiple of PAGE_SIZE and sg->offset is 0.
+        */
+       if (!first && (page_to_pfn(sg_page(sg)) + (sg->length >> PAGE_SHIFT) ==
+                       page_to_pfn(page_list[0])))
+               update_cur_sg = true;
+
+       while (i != npages) {
+               unsigned long len;
+               struct page *first_page = page_list[i];
+
+               first_pfn = page_to_pfn(first_page);
+
+               /* Compute the number of contiguous pages we have starting
+                * at i
+                */
+               for (len = 0; i != npages &&
+                               first_pfn + len == page_to_pfn(page_list[i]) &&
+                               len < (max_seg_sz >> PAGE_SHIFT);
+                    len++)
+                       i++;
+
+               /* Squash N contiguous pages from page_list into current sge */
+               if (update_cur_sg) {
+                       if ((max_seg_sz - sg->length) >= (len << PAGE_SHIFT)) {
+                               sg_set_page(sg, sg_page(sg),
+                               sg->length + (len << PAGE_SHIFT),
+                               0);
+                               update_cur_sg = false;
+                               continue;
+                       }
+                       update_cur_sg = false;
+               }
+
+               /* Squash N contiguous pages into next sge or first sge */
+               if (!first)
+                       sg = sg_next(sg);
+
+               (*nents)++;
+               sg_set_page(sg, first_page, len << PAGE_SHIFT, 0);
+               first = false;
+       }
+
+       return sg;
+}
+
+/**
+ * ib_umem_hugepage_get - Pin and DMA map userspace memory.
+ *
+ * @device: IB device to connect UMEM
+ * @addr: userspace virtual address to start at
+ * @size: length of region to pin
+ * @access: IB_ACCESS_xxx flags for memory being pinned
+ */
+struct ib_umem *ib_umem_hugepage_get(struct ib_device *device,
+                                    unsigned long addr,
+                                    size_t size, int access)
+{
+       struct ib_umem *umem;
+       struct page **page_list;
+       unsigned long lock_limit;
+       unsigned long new_pinned;
+       unsigned long cur_base;
+       unsigned long dma_attr = 0;
+       struct mm_struct *mm;
+       unsigned long npages;
+       int ret;
+       struct scatterlist *sg;
+       unsigned int gup_flags = FOLL_WRITE;
+
+       /*
+        * If the combination of the addr and size requested for this memory
+        * region causes an integer overflow, return error.
+        */
+       if (((addr + size) < addr) ||
+           PAGE_ALIGN(addr + size) < (addr + size))
+               return ERR_PTR(-EINVAL);
+
+       if (!can_do_mlock())
+               return ERR_PTR(-EPERM);
+
+       if (access & IB_ACCESS_ON_DEMAND)
+               return ERR_PTR(-EOPNOTSUPP);
+
+       umem = kzalloc(sizeof(*umem), GFP_KERNEL);
+       if (!umem)
+               return ERR_PTR(-ENOMEM);
+       umem->ibdev      = device;
+       umem->length     = size;
+       umem->address    = addr;
+       umem->writable   = ib_access_writable(access);
+       umem->owning_mm = mm = current->mm;
+       mmgrab(mm);
+
+       page_list = (struct page **) __get_free_page(GFP_KERNEL);
+       if (!page_list) {
+               ret = -ENOMEM;
+               goto umem_kfree;
+       }
+
+       npages = ib_umem_num_pages(umem);
+       if (npages == 0 || npages > UINT_MAX) {
+               ret = -EINVAL;
+               goto out;
+       }
+
+       lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+
+       new_pinned = atomic64_add_return(npages, &mm->pinned_vm);
+       if (new_pinned > lock_limit && !capable(CAP_IPC_LOCK)) {
+               atomic64_sub(npages, &mm->pinned_vm);
+               ret = -ENOMEM;
+               goto out;
+       }
+
+       cur_base = addr & PAGE_MASK;
+
+       ret = sg_alloc_table(&umem->sg_head, npages, GFP_KERNEL);
+       if (ret)
+               goto vma;
+
+       if (!umem->writable)
+               gup_flags |= FOLL_FORCE;
+
+       sg = umem->sg_head.sgl;
+
+       while (npages) {
+               cond_resched();
+               ret = pin_user_pages_fast(cur_base,
+                                         min_t(unsigned long, npages,
+                                               PAGE_SIZE /
+                                         sizeof(struct page *)),
+                                         gup_flags | FOLL_LONGTERM, page_list);
+               if (ret < 0)
+                       goto umem_release;
+
+               cur_base += ret * PAGE_SIZE;
+               npages   -= ret;
+
+               sg = ib_umem_add_sg_table(sg, page_list, ret,
+                               dma_get_max_seg_size(device->dma_device),
+                               &umem->sg_nents);
+       }
+
+       sg_mark_end(sg);
+
+       if (access & IB_ACCESS_RELAXED_ORDERING)
+               dma_attr |= DMA_ATTR_WEAK_ORDERING;
+
+       umem->nmap =
+               ib_dma_map_sg_attrs(device, umem->sg_head.sgl, umem->sg_nents,
+                                   DMA_BIDIRECTIONAL, dma_attr);
+
+       if (!umem->nmap) {
+               ret = -ENOMEM;
+               goto umem_release;
+       }
+
+       ret = 0;
+       goto out;
+
+umem_release:
+       __ib_umem_release(device, umem, 0);
+vma:
+       atomic64_sub(ib_umem_num_pages(umem), &mm->pinned_vm);
+out:
+       free_page((unsigned long) page_list);
+umem_kfree:
+       if (ret) {
+               mmdrop(umem->owning_mm);
+               kfree(umem);
+       }
+       return ret ? ERR_PTR(ret) : umem;
+}
+EXPORT_SYMBOL(ib_umem_hugepage_get);
+
 /**
  * ib_umem_find_best_pgsz - Find best HW page size to use for this MR
  *
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 676c57f5ca80..fc6350ff21e6 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -96,6 +96,9 @@ static inline void
__rdma_umem_block_iter_start(struct ib_block_iter *biter,
             __rdma_block_iter_next(biter);)

 #ifdef CONFIG_INFINIBAND_USER_MEM
+struct ib_umem *ib_umem_hugepage_get(struct ib_device *device,
+                                    unsigned long addr,
+                                    size_t size, int access);

 struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
                            size_t size, int access);
--
2.25.1
