Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7740733033D
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Mar 2021 18:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhCGRUX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 7 Mar 2021 12:20:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:50846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232629AbhCGRUI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 7 Mar 2021 12:20:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBDC264F94;
        Sun,  7 Mar 2021 17:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615137608;
        bh=MGBLF0BUyy3+6HPdFNqV3MyPaw6qic2Xcn13coW8Wh0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kf+X+ne3zhZP6QMiJlCEIC7zGsYErFA8aoJrRL4cHp/DWcBlKymzMh3kkeht3wfmP
         IgAVixeKp/GnA0joTNVMvt+qn8ZeLCCgPHZ0APCL8fxsGLxne2/qzv7egbhdxW9/Mf
         2hDIO8H69/boZBAanAgJlRYOpr/QY5ZY0zWkpKzCsCWYaogKA2zVCfWB1AUmhU3AxT
         3sgC1NuoA5cKk7rBW+jwsqwxvUiTrnzr8rUPgEeJpzIwyF+FbkXcrd9TBaK4gVHF/L
         /CaIKGdCTQlOVAQE1GGVYriAzE7FCNnuVMSk1W8zE5dgATUkEklEdijEZ8wNDOdH7t
         RjSOF527PxPeA==
Date:   Sun, 7 Mar 2021 19:20:04 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        maorg@nvidia.com
Subject: Re: Fwd: [PATCH 1/1] RDMA/umem: add back hugepage sg list
Message-ID: <YEULROAvpIaLcnXp@unreal>
References: <20210307221034.568606-1-yanjun.zhu@intel.com>
 <CAD=hENeqTTmpS5V+G646V0QvJFLVSd3Sq11ffQFcDXU-OSsQEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENeqTTmpS5V+G646V0QvJFLVSd3Sq11ffQFcDXU-OSsQEg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Please use git send-email to send patches.

Also don't write 1/1 for single patch.

Thanks

On Sun, Mar 07, 2021 at 10:28:33PM +0800, Zhu Yanjun wrote:
> From: Zhu Yanjun <zyjzyj2000@gmail.com>
>
> After the commit ("RDMA/umem: Move to allocate SG table from pages"),
> the sg list from ib_ume_get is like the following:
> "
> sg_dma_address(sg):0x4b3c1ce000
> sg_dma_address(sg):0x4c3c1cd000
> sg_dma_address(sg):0x4d3c1cc000
> sg_dma_address(sg):0x4e3c1cb000
> "
>
> But sometimes, we need sg list like the following:
> "
> sg_dma_address(sg):0x203b400000
> sg_dma_address(sg):0x213b200000
> sg_dma_address(sg):0x223b000000
> sg_dma_address(sg):0x233ae00000
> sg_dma_address(sg):0x243ac00000
> "
> The function ib_umem_add_sg_table can provide the sg list like the
> second. And this function is removed in the commit ("RDMA/umem: Move
> to allocate SG table from pages"). Now I add it back.
>
> The new function is ib_umem_get to ib_umem_hugepage_get that calls
> ib_umem_add_sg_table.
>
> This function ib_umem_huagepage_get can get 4K, 2M sg list dma address.
>
> Fixes: 0c16d9635e3a ("RDMA/umem: Move to allocate SG table from pages")
> Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> ---
>  drivers/infiniband/core/umem.c | 197 +++++++++++++++++++++++++++++++++
>  include/rdma/ib_umem.h         |   3 +
>  2 files changed, 200 insertions(+)
>
> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> index 2dde99a9ba07..af8733788b1e 100644
> --- a/drivers/infiniband/core/umem.c
> +++ b/drivers/infiniband/core/umem.c
> @@ -62,6 +62,203 @@ static void __ib_umem_release(struct ib_device
> *dev, struct ib_umem *umem, int d
>         sg_free_table(&umem->sg_head);
>  }
>
> +/* ib_umem_add_sg_table - Add N contiguous pages to scatter table
> + *
> + * sg: current scatterlist entry
> + * page_list: array of npage struct page pointers
> + * npages: number of pages in page_list
> + * max_seg_sz: maximum segment size in bytes
> + * nents: [out] number of entries in the scatterlist
> + *
> + * Return new end of scatterlist
> + */
> +static struct scatterlist *ib_umem_add_sg_table(struct scatterlist *sg,
> +                                               struct page **page_list,
> +                                               unsigned long npages,
> +                                               unsigned int max_seg_sz,
> +                                               int *nents)
> +{
> +       unsigned long first_pfn;
> +       unsigned long i = 0;
> +       bool update_cur_sg = false;
> +       bool first = !sg_page(sg);
> +
> +       /* Check if new page_list is contiguous with end of previous page_list.
> +        * sg->length here is a multiple of PAGE_SIZE and sg->offset is 0.
> +        */
> +       if (!first && (page_to_pfn(sg_page(sg)) + (sg->length >> PAGE_SHIFT) ==
> +                       page_to_pfn(page_list[0])))
> +               update_cur_sg = true;
> +
> +       while (i != npages) {
> +               unsigned long len;
> +               struct page *first_page = page_list[i];
> +
> +               first_pfn = page_to_pfn(first_page);
> +
> +               /* Compute the number of contiguous pages we have starting
> +                * at i
> +                */
> +               for (len = 0; i != npages &&
> +                               first_pfn + len == page_to_pfn(page_list[i]) &&
> +                               len < (max_seg_sz >> PAGE_SHIFT);
> +                    len++)
> +                       i++;
> +
> +               /* Squash N contiguous pages from page_list into current sge */
> +               if (update_cur_sg) {
> +                       if ((max_seg_sz - sg->length) >= (len << PAGE_SHIFT)) {
> +                               sg_set_page(sg, sg_page(sg),
> +                               sg->length + (len << PAGE_SHIFT),
> +                               0);
> +                               update_cur_sg = false;
> +                               continue;
> +                       }
> +                       update_cur_sg = false;
> +               }
> +
> +               /* Squash N contiguous pages into next sge or first sge */
> +               if (!first)
> +                       sg = sg_next(sg);
> +
> +               (*nents)++;
> +               sg_set_page(sg, first_page, len << PAGE_SHIFT, 0);
> +               first = false;
> +       }
> +
> +       return sg;
> +}
> +
> +/**
> + * ib_umem_hugepage_get - Pin and DMA map userspace memory.
> + *
> + * @device: IB device to connect UMEM
> + * @addr: userspace virtual address to start at
> + * @size: length of region to pin
> + * @access: IB_ACCESS_xxx flags for memory being pinned
> + */
> +struct ib_umem *ib_umem_hugepage_get(struct ib_device *device,
> +                                    unsigned long addr,
> +                                    size_t size, int access)
> +{
> +       struct ib_umem *umem;
> +       struct page **page_list;
> +       unsigned long lock_limit;
> +       unsigned long new_pinned;
> +       unsigned long cur_base;
> +       unsigned long dma_attr = 0;
> +       struct mm_struct *mm;
> +       unsigned long npages;
> +       int ret;
> +       struct scatterlist *sg;
> +       unsigned int gup_flags = FOLL_WRITE;
> +
> +       /*
> +        * If the combination of the addr and size requested for this memory
> +        * region causes an integer overflow, return error.
> +        */
> +       if (((addr + size) < addr) ||
> +           PAGE_ALIGN(addr + size) < (addr + size))
> +               return ERR_PTR(-EINVAL);
> +
> +       if (!can_do_mlock())
> +               return ERR_PTR(-EPERM);
> +
> +       if (access & IB_ACCESS_ON_DEMAND)
> +               return ERR_PTR(-EOPNOTSUPP);
> +
> +       umem = kzalloc(sizeof(*umem), GFP_KERNEL);
> +       if (!umem)
> +               return ERR_PTR(-ENOMEM);
> +       umem->ibdev      = device;
> +       umem->length     = size;
> +       umem->address    = addr;
> +       umem->writable   = ib_access_writable(access);
> +       umem->owning_mm = mm = current->mm;
> +       mmgrab(mm);
> +
> +       page_list = (struct page **) __get_free_page(GFP_KERNEL);
> +       if (!page_list) {
> +               ret = -ENOMEM;
> +               goto umem_kfree;
> +       }
> +
> +       npages = ib_umem_num_pages(umem);
> +       if (npages == 0 || npages > UINT_MAX) {
> +               ret = -EINVAL;
> +               goto out;
> +       }
> +
> +       lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> +
> +       new_pinned = atomic64_add_return(npages, &mm->pinned_vm);
> +       if (new_pinned > lock_limit && !capable(CAP_IPC_LOCK)) {
> +               atomic64_sub(npages, &mm->pinned_vm);
> +               ret = -ENOMEM;
> +               goto out;
> +       }
> +
> +       cur_base = addr & PAGE_MASK;
> +
> +       ret = sg_alloc_table(&umem->sg_head, npages, GFP_KERNEL);
> +       if (ret)
> +               goto vma;
> +
> +       if (!umem->writable)
> +               gup_flags |= FOLL_FORCE;
> +
> +       sg = umem->sg_head.sgl;
> +
> +       while (npages) {
> +               cond_resched();
> +               ret = pin_user_pages_fast(cur_base,
> +                                         min_t(unsigned long, npages,
> +                                               PAGE_SIZE /
> +                                         sizeof(struct page *)),
> +                                         gup_flags | FOLL_LONGTERM, page_list);
> +               if (ret < 0)
> +                       goto umem_release;
> +
> +               cur_base += ret * PAGE_SIZE;
> +               npages   -= ret;
> +
> +               sg = ib_umem_add_sg_table(sg, page_list, ret,
> +                               dma_get_max_seg_size(device->dma_device),
> +                               &umem->sg_nents);
> +       }
> +
> +       sg_mark_end(sg);
> +
> +       if (access & IB_ACCESS_RELAXED_ORDERING)
> +               dma_attr |= DMA_ATTR_WEAK_ORDERING;
> +
> +       umem->nmap =
> +               ib_dma_map_sg_attrs(device, umem->sg_head.sgl, umem->sg_nents,
> +                                   DMA_BIDIRECTIONAL, dma_attr);
> +
> +       if (!umem->nmap) {
> +               ret = -ENOMEM;
> +               goto umem_release;
> +       }
> +
> +       ret = 0;
> +       goto out;
> +
> +umem_release:
> +       __ib_umem_release(device, umem, 0);
> +vma:
> +       atomic64_sub(ib_umem_num_pages(umem), &mm->pinned_vm);
> +out:
> +       free_page((unsigned long) page_list);
> +umem_kfree:
> +       if (ret) {
> +               mmdrop(umem->owning_mm);
> +               kfree(umem);
> +       }
> +       return ret ? ERR_PTR(ret) : umem;
> +}
> +EXPORT_SYMBOL(ib_umem_hugepage_get);
> +
>  /**
>   * ib_umem_find_best_pgsz - Find best HW page size to use for this MR
>   *
> diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
> index 676c57f5ca80..fc6350ff21e6 100644
> --- a/include/rdma/ib_umem.h
> +++ b/include/rdma/ib_umem.h
> @@ -96,6 +96,9 @@ static inline void
> __rdma_umem_block_iter_start(struct ib_block_iter *biter,
>              __rdma_block_iter_next(biter);)
>
>  #ifdef CONFIG_INFINIBAND_USER_MEM
> +struct ib_umem *ib_umem_hugepage_get(struct ib_device *device,
> +                                    unsigned long addr,
> +                                    size_t size, int access);
>
>  struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
>                             size_t size, int access);
> --
> 2.25.1
