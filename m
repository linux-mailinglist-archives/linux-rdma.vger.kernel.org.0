Return-Path: <linux-rdma+bounces-15681-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E01D39C5A
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jan 2026 03:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D4113006A66
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jan 2026 02:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E66F23717F;
	Mon, 19 Jan 2026 02:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JV6aoHDO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033F28632B
	for <linux-rdma@vger.kernel.org>; Mon, 19 Jan 2026 02:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768789514; cv=none; b=FNUSmaxSZP6nh4ceupcUSg0PIQkKBS9AI0hkecPDhxIDU6IrQ7vJN2tnJeX6PM4manCHUdKDCrCmUxmcPp+VldtF90eqkjzxJ3LIZ81w8daiur0NCSCR736zrZO5gtVhNuKdTb+vWb7+8brcI/IePZ+8EL2odYZrMzRNcD0Nb6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768789514; c=relaxed/simple;
	bh=3yKFmu7DjLeWZeTyqIu6PkTM8TlaCXstB/fc1YEozDI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=s5j0unYEGPmAK306oDehtNRKe79Ysy2oxvF82eGrIqEEJwK9ae/CwmI0Ukx0h0UW70NHYLSIrkt2WRvtn4M0gwpU3QqhJMCjZ1ZJwu8SsLx+vfaw7jJarDDUd5gFrnyARNn6GAuqStwXl8My1JxYPqv9o63GFdC7FsAl5WWx8hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JV6aoHDO; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7bf4cf88-04cb-4d05-8bd0-174b8e879e1a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768789508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ywWX5nkajYEd3gCM3Bk2tyylSWjGTOsZ2s0sQfJZyA=;
	b=JV6aoHDOZCW9gYd9Uj77d235BpNJ8ztDgpSCdGexQ9dPAySQZWNGLivRURPLPFdnowrGrX
	PctP4cInBV7XF86Bo+8VJv+ww6cz0LYZA/zlvSWW4bxP25AdKmhxZKWTfM4VBXYpyCXGJs
	HSKPbphHDoMRXp3AdDE3VigH2IcLMWE=
Date: Sun, 18 Jan 2026 18:25:01 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC v2] RDMA/rxe: Fix iova-to-va conversion for MR page
 sizes != PAGE_SIZE
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: Li Zhijian <lizhijian@fujitsu.com>, linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, zyjzyj2000@gmail.com, jgg@ziepe.ca,
 leon@kernel.org, Yi Zhang <yi.zhang@redhat.com>
References: <20260116032753.2574363-1-lizhijian@fujitsu.com>
 <1bc84ed5-6e06-47fd-a85a-c85ac8cc4118@linux.dev>
In-Reply-To: <1bc84ed5-6e06-47fd-a85a-c85ac8cc4118@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2026/1/16 9:36, yanjun.zhu 写道:
> On 1/15/26 7:27 PM, Li Zhijian wrote:
>> The current implementation incorrectly handles memory regions (MRs) with
>> page sizes different from the system PAGE_SIZE. The core issue is that
>> rxe_set_page() is called with mr->page_size step increments, but the
>> page_list stores individual struct page pointers, each representing
>> PAGE_SIZE of memory.
>>
>> ib_sg_to_page() has ensured that when i>=1 either
>> a) SG[i-1].dma_end and SG[i].dma_addr are contiguous
>> or
>> b) SG[i-1].dma_end and SG[i].dma_addr are mr->page_size aligned.
>>
>> This leads to incorrect iova-to-va conversion in scenarios:
>>
>> 1) page_size < PAGE_SIZE (e.g., MR: 4K, system: 64K):
>>     ibmr->iova = 0x181800
>>     sg[0]: dma_addr=0x181800, len=0x800
>>     sg[1]: dma_addr=0x173000, len=0x1000
>>
>>     Access iova = 0x181800 + 0x810 = 0x182010
>>     Expected VA: 0x173010 (second SG, offset 0x10)
>>     Before fix:
>>       - index = (0x182010 >> 12) - (0x181800 >> 12) = 1
>>       - page_offset = 0x182010 & 0xFFF = 0x10
>>       - xarray[1] stores system page base 0x170000
>>       - Resulting VA: 0x170000 + 0x10 = 0x170010 (wrong)
>>
>> 2) page_size > PAGE_SIZE (e.g., MR: 64K, system: 4K):
>>     ibmr->iova = 0x18f800
>>     sg[0]: dma_addr=0x18f800, len=0x800
>>     sg[1]: dma_addr=0x170000, len=0x1000
>>
>>     Access iova = 0x18f800 + 0x810 = 0x190010
>>     Expected VA: 0x170010 (second SG, offset 0x10)
>>     Before fix:
>>       - index = (0x190010 >> 16) - (0x18f800 >> 16) = 1
>>       - page_offset = 0x190010 & 0xFFFF = 0x10
>>       - xarray[1] stores system page for dma_addr 0x170000
>>       - Resulting VA: system page of 0x170000 + 0x10 = 0x170010 (wrong)
>>
>> Yi Zhang reported a kernel panic[1] years ago related to this defect.
> 
> Thanks a lot.
> I am not sure if this problem also occurs on SIW or not.
> If yes, can you also add this fix to SIW?
> If not, can you explain why this problem does not occur on SIW?
> 
> I am just curious about this.

Thanks, Zhijian

Based on the latest linux upstream, that is, 6.19-rc5, I applied this 
commit. On x86_64, all the testcases can pass.

I do not have arm64 test environment. As such, it is difficult for me to 
verify whether the proglem that Yi Zhang reported is fixed or not.

IMO, it is good to keep this commit in linux upstream for some time. 
Thus, other developers can verify whether the mentioned problem is fix 
or not.

Br,
Zhu Yanjun

> 
> Best Regards,
> Zhu Yanjun
> 
> 
>>
>> Solution:
>> 1. Replace xarray with pre-allocated rxe_mr_page array for sequential
>>     indexing (all MR page indices are contiguous)
>> 2. Each rxe_mr_page stores both struct page* and offset within the
>>     system page
>> 3. Handle MR page_size != PAGE_SIZE relationships:
>>     - page_size > PAGE_SIZE: Split MR pages into multiple system pages
>>     - page_size <= PAGE_SIZE: Store offset within system page
>> 4. Add boundary checks and compatibility validation
>>
>> This ensures correct iova-to-va conversion regardless of MR page size
>> and system PAGE_SIZE relationship, while improving performance through
>> array-based sequential access.
>>
>> Tests on 4K and 64K PAGE_SIZE hosts:
>> - rdma-core/pytests
>>    $ ./build/bin/run_tests.py  --dev eth0_rxe
>> - blktest:
>>    $ TIMEOUT=30 QUICK_RUN=1 USE_RXE=1 NVMET_TRTYPES=rdma ./check nvme 
>> srp rnbd
>>
>> [1] https://lore.kernel.org/all/ 
>> CAHj4cs9XRqE25jyVw9rj9YugffLn5+f=1znaBEnu1usLOciD+g@mail.gmail.com/T/
>> Fixes: 592627ccbdff ("RDMA/rxe: Replace rxe_map and rxe_phys_buf by 
>> xarray")
>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
>>
>> ---
>> If this patch is too huge, it can be split it to 'convert xarray to 
>> normal array' first.
>>
>> V2:
>>   - convert xarray to normal array because all MR page indices are 
>> contiguous
>>   - Fix cases in 2+ SG entries and their dma_addr is not contiguous
>>   - Resize page_info to (num_buf * system_page_per_mr) if needed
>>   - remove set_page_per_mr(), unify back to rxe_set_page()
>> ---
>>   drivers/infiniband/sw/rxe/rxe_mr.c    | 281 +++++++++++++++++---------
>>   drivers/infiniband/sw/rxe/rxe_verbs.h |  10 +-
>>   2 files changed, 194 insertions(+), 97 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/ 
>> sw/rxe/rxe_mr.c
>> index 05710d785a7e..c71ab780e379 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
>> @@ -72,14 +72,46 @@ void rxe_mr_init_dma(int access, struct rxe_mr *mr)
>>       mr->ibmr.type = IB_MR_TYPE_DMA;
>>   }
>> +/*
>> + * Convert iova to page_info index. The page_info stores pages of size
>> + * PAGE_SIZE, but MRs can have different page sizes. This function
>> + * handles the conversion for all cases:
>> + *
>> + * 1. mr->page_size > PAGE_SIZE:
>> + *    The MR's iova may not be aligned to mr->page_size. We use the
>> + *    aligned base (iova & page_mask) as reference, then calculate
>> + *    which PAGE_SIZE sub-page the iova falls into.
>> + *
>> + * 2. mr->page_size <= PAGE_SIZE:
>> + *    Use simple shift arithmetic since each page_info entry corresponds
>> + *    to one or more MR pages.
>> + */
>>   static unsigned long rxe_mr_iova_to_index(struct rxe_mr *mr, u64 iova)
>>   {
>> -    return (iova >> mr->page_shift) - (mr->ibmr.iova >> mr->page_shift);
>> +    int idx;
>> +
>> +    if (mr_page_size(mr) > PAGE_SIZE)
>> +        idx = (iova - (mr->ibmr.iova & mr->page_mask)) >> PAGE_SHIFT;
>> +    else
>> +        idx = (iova >> mr->page_shift) -
>> +            (mr->ibmr.iova >> mr->page_shift);
>> +
>> +    WARN_ON(idx >= mr->nbuf);
>> +    return idx;
>>   }
>> +/*
>> + * Convert iova to offset within the page_info entry.
>> + *
>> + * For mr_page_size > PAGE_SIZE, the offset is within the system page.
>> + * For mr_page_size <= PAGE_SIZE, the offset is within the MR page size.
>> + */
>>   static unsigned long rxe_mr_iova_to_page_offset(struct rxe_mr *mr, 
>> u64 iova)
>>   {
>> -    return iova & (mr_page_size(mr) - 1);
>> +    if (mr_page_size(mr) > PAGE_SIZE)
>> +        return iova & (PAGE_SIZE - 1);
>> +    else
>> +        return iova & (mr_page_size(mr) - 1);
>>   }
>>   static bool is_pmem_page(struct page *pg)
>> @@ -93,37 +125,69 @@ static bool is_pmem_page(struct page *pg)
>>   static int rxe_mr_fill_pages_from_sgt(struct rxe_mr *mr, struct 
>> sg_table *sgt)
>>   {
>> -    XA_STATE(xas, &mr->page_list, 0);
>>       struct sg_page_iter sg_iter;
>>       struct page *page;
>>       bool persistent = !!(mr->access & IB_ACCESS_FLUSH_PERSISTENT);
>> +    WARN_ON(mr_page_size(mr) != PAGE_SIZE);
>> +
>>       __sg_page_iter_start(&sg_iter, sgt->sgl, sgt->orig_nents, 0);
>>       if (!__sg_page_iter_next(&sg_iter))
>>           return 0;
>> -    do {
>> -        xas_lock(&xas);
>> -        while (true) {
>> -            page = sg_page_iter_page(&sg_iter);
>> -
>> -            if (persistent && !is_pmem_page(page)) {
>> -                rxe_dbg_mr(mr, "Page can't be persistent\n");
>> -                xas_set_err(&xas, -EINVAL);
>> -                break;
>> -            }
>> +    while (true) {
>> +        page = sg_page_iter_page(&sg_iter);
>> -            xas_store(&xas, page);
>> -            if (xas_error(&xas))
>> -                break;
>> -            xas_next(&xas);
>> -            if (!__sg_page_iter_next(&sg_iter))
>> -                break;
>> +        if (persistent && !is_pmem_page(page)) {
>> +            rxe_dbg_mr(mr, "Page can't be persistent\n");
>> +            return -EINVAL;
>>           }
>> -        xas_unlock(&xas);
>> -    } while (xas_nomem(&xas, GFP_KERNEL));
>> -    return xas_error(&xas);
>> +        mr->page_info[mr->nbuf].page = page;
>> +        mr->page_info[mr->nbuf].offset = 0;
>> +        mr->nbuf++;
>> +
>> +        if (!__sg_page_iter_next(&sg_iter))
>> +            break;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int __alloc_mr_page_info(struct rxe_mr *mr, int num_pages)
>> +{
>> +    mr->page_info = kcalloc(num_pages, sizeof(struct rxe_mr_page),
>> +                GFP_KERNEL);
>> +    if (!mr->page_info)
>> +        return -ENOMEM;
>> +
>> +    mr->max_allowed_buf = num_pages;
>> +    mr->nbuf = 0;
>> +
>> +    return 0;
>> +}
>> +
>> +static int alloc_mr_page_info(struct rxe_mr *mr, int num_pages)
>> +{
>> +    int ret;
>> +
>> +    WARN_ON(mr->num_buf);
>> +    ret = __alloc_mr_page_info(mr, num_pages);
>> +    if (ret)
>> +        return ret;
>> +
>> +    mr->num_buf = num_pages;
>> +
>> +    return 0;
>> +}
>> +
>> +static void free_mr_page_info(struct rxe_mr *mr)
>> +{
>> +    if (!mr->page_info)
>> +        return;
>> +
>> +    kfree(mr->page_info);
>> +    mr->page_info = NULL;
>>   }
>>   int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
>> @@ -134,8 +198,6 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 
>> start, u64 length,
>>       rxe_mr_init(access, mr);
>> -    xa_init(&mr->page_list);
>> -
>>       umem = ib_umem_get(&rxe->ib_dev, start, length, access);
>>       if (IS_ERR(umem)) {
>>           rxe_dbg_mr(mr, "Unable to pin memory region err = %d\n",
>> @@ -143,46 +205,24 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 
>> start, u64 length,
>>           return PTR_ERR(umem);
>>       }
>> +    err = alloc_mr_page_info(mr, ib_umem_num_pages(umem));
>> +    if (err)
>> +        goto err2;
>> +
>>       err = rxe_mr_fill_pages_from_sgt(mr, &umem->sgt_append.sgt);
>> -    if (err) {
>> -        ib_umem_release(umem);
>> -        return err;
>> -    }
>> +    if (err)
>> +        goto err1;
>>       mr->umem = umem;
>>       mr->ibmr.type = IB_MR_TYPE_USER;
>>       mr->state = RXE_MR_STATE_VALID;
>>       return 0;
>> -}
>> -
>> -static int rxe_mr_alloc(struct rxe_mr *mr, int num_buf)
>> -{
>> -    XA_STATE(xas, &mr->page_list, 0);
>> -    int i = 0;
>> -    int err;
>> -
>> -    xa_init(&mr->page_list);
>> -
>> -    do {
>> -        xas_lock(&xas);
>> -        while (i != num_buf) {
>> -            xas_store(&xas, XA_ZERO_ENTRY);
>> -            if (xas_error(&xas))
>> -                break;
>> -            xas_next(&xas);
>> -            i++;
>> -        }
>> -        xas_unlock(&xas);
>> -    } while (xas_nomem(&xas, GFP_KERNEL));
>> -
>> -    err = xas_error(&xas);
>> -    if (err)
>> -        return err;
>> -
>> -    mr->num_buf = num_buf;
>> -
>> -    return 0;
>> +err1:
>> +    free_mr_page_info(mr);
>> +err2:
>> +    ib_umem_release(umem);
>> +    return err;
>>   }
>>   int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr)
>> @@ -192,7 +232,7 @@ int rxe_mr_init_fast(int max_pages, struct rxe_mr 
>> *mr)
>>       /* always allow remote access for FMRs */
>>       rxe_mr_init(RXE_ACCESS_REMOTE, mr);
>> -    err = rxe_mr_alloc(mr, max_pages);
>> +    err = alloc_mr_page_info(mr, max_pages);
>>       if (err)
>>           goto err1;
>> @@ -205,26 +245,43 @@ int rxe_mr_init_fast(int max_pages, struct 
>> rxe_mr *mr)
>>       return err;
>>   }
>> +/*
>> + * I) MRs with page_size >= PAGE_SIZE,
>> + * Split a large MR page (mr->page_size) into multiple PAGE_SIZE
>> + * sub-pages and store them in page_info, offset is always 0.
>> + *
>> + * Called when mr->page_size > PAGE_SIZE. Each call to rxe_set_page()
>> + * represents one mr->page_size region, which we must split into
>> + * (mr->page_size >> PAGE_SHIFT) individual pages.
>> + *
>> + * II) MRs with page_size < PAGE_SIZE,
>> + * Save each PAGE_SIZE page and its offset within the system page in 
>> page_info.
>> + */
>>   static int rxe_set_page(struct ib_mr *ibmr, u64 dma_addr)
>>   {
>>       struct rxe_mr *mr = to_rmr(ibmr);
>> -    struct page *page = ib_virt_dma_to_page(dma_addr);
>>       bool persistent = !!(mr->access & IB_ACCESS_FLUSH_PERSISTENT);
>> -    int err;
>> +    u32 i, pages_per_mr = mr_page_size(mr) >> PAGE_SHIFT;
>> -    if (persistent && !is_pmem_page(page)) {
>> -        rxe_dbg_mr(mr, "Page cannot be persistent\n");
>> -        return -EINVAL;
>> -    }
>> +    pages_per_mr = MAX(1, pages_per_mr);
>> -    if (unlikely(mr->nbuf == mr->num_buf))
>> -        return -ENOMEM;
>> +    for (i = 0; i < pages_per_mr; i++) {
>> +        u64 addr = dma_addr + i * PAGE_SIZE;
>> +        struct page *sub_page = ib_virt_dma_to_page(addr);
>> -    err = xa_err(xa_store(&mr->page_list, mr->nbuf, page, GFP_KERNEL));
>> -    if (err)
>> -        return err;
>> +        if (unlikely(mr->nbuf >= mr->max_allowed_buf))
>> +            return -ENOMEM;
>> +
>> +        if (persistent && !is_pmem_page(sub_page)) {
>> +            rxe_dbg_mr(mr, "Page cannot be persistent\n");
>> +            return -EINVAL;
>> +        }
>> +
>> +        mr->page_info[mr->nbuf].page = sub_page;
>> +        mr->page_info[mr->nbuf].offset = addr & (PAGE_SIZE - 1);
>> +        mr->nbuf++;
>> +    }
>> -    mr->nbuf++;
>>       return 0;
>>   }
>> @@ -234,6 +291,31 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct 
>> scatterlist *sgl,
>>       struct rxe_mr *mr = to_rmr(ibmr);
>>       unsigned int page_size = mr_page_size(mr);
>> +    /*
>> +     * Ensure page_size and PAGE_SIZE are compatible for mapping.
>> +     * We require one to be a multiple of the other for correct
>> +     * iova-to-page conversion.
>> +     */
>> +    if (!IS_ALIGNED(page_size, PAGE_SIZE) &&
>> +        !IS_ALIGNED(PAGE_SIZE, page_size)) {
>> +        rxe_dbg_mr(mr, "MR page size %u must be compatible with 
>> PAGE_SIZE %lu\n",
>> +               page_size, PAGE_SIZE);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (mr_page_size(mr) > PAGE_SIZE) {
>> +        /* resize page_info if needed */
>> +        u32 map_mr_pages = (page_size >> PAGE_SHIFT) * mr->num_buf;
>> +
>> +        if (map_mr_pages > mr->max_allowed_buf) {
>> +            rxe_dbg_mr(mr, "requested pages %u exceed max %u\n",
>> +                   map_mr_pages, mr->max_allowed_buf);
>> +            free_mr_page_info(mr);
>> +            if (__alloc_mr_page_info(mr, map_mr_pages))
>> +                return -ENOMEM;
>> +        }
>> +    }
>> +
>>       mr->nbuf = 0;
>>       mr->page_shift = ilog2(page_size);
>>       mr->page_mask = ~((u64)page_size - 1);
>> @@ -244,30 +326,30 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct 
>> scatterlist *sgl,
>>   static int rxe_mr_copy_xarray(struct rxe_mr *mr, u64 iova, void *addr,
>>                     unsigned int length, enum rxe_mr_copy_dir dir)
>>   {
>> -    unsigned int page_offset = rxe_mr_iova_to_page_offset(mr, iova);
>> -    unsigned long index = rxe_mr_iova_to_index(mr, iova);
>>       unsigned int bytes;
>> -    struct page *page;
>> -    void *va;
>> +    u8 *va;
>>       while (length) {
>> -        page = xa_load(&mr->page_list, index);
>> -        if (!page)
>> +        unsigned long index = rxe_mr_iova_to_index(mr, iova);
>> +        struct rxe_mr_page *info = &mr->page_info[index];
>> +        unsigned int page_offset = rxe_mr_iova_to_page_offset(mr, iova);
>> +
>> +        if (!info->page)
>>               return -EFAULT;
>> -        bytes = min_t(unsigned int, length,
>> -                mr_page_size(mr) - page_offset);
>> -        va = kmap_local_page(page);
>> +        page_offset += info->offset;
>> +        bytes = min_t(unsigned int, length, PAGE_SIZE - page_offset);
>> +        va = kmap_local_page(info->page);
>> +
>>           if (dir == RXE_FROM_MR_OBJ)
>>               memcpy(addr, va + page_offset, bytes);
>>           else
>>               memcpy(va + page_offset, addr, bytes);
>>           kunmap_local(va);
>> -        page_offset = 0;
>>           addr += bytes;
>> +        iova += bytes;
>>           length -= bytes;
>> -        index++;
>>       }
>>       return 0;
>> @@ -425,9 +507,6 @@ int copy_data(
>>   static int rxe_mr_flush_pmem_iova(struct rxe_mr *mr, u64 iova, 
>> unsigned int length)
>>   {
>> -    unsigned int page_offset;
>> -    unsigned long index;
>> -    struct page *page;
>>       unsigned int bytes;
>>       int err;
>>       u8 *va;
>> @@ -437,15 +516,17 @@ static int rxe_mr_flush_pmem_iova(struct rxe_mr 
>> *mr, u64 iova, unsigned int leng
>>           return err;
>>       while (length > 0) {
>> -        index = rxe_mr_iova_to_index(mr, iova);
>> -        page = xa_load(&mr->page_list, index);
>> -        page_offset = rxe_mr_iova_to_page_offset(mr, iova);
>> -        if (!page)
>> +        unsigned long index = rxe_mr_iova_to_index(mr, iova);
>> +        struct rxe_mr_page *info = &mr->page_info[index];
>> +        unsigned int page_offset = rxe_mr_iova_to_page_offset(mr, iova);
>> +
>> +        if (!info->page)
>>               return -EFAULT;
>> -        bytes = min_t(unsigned int, length,
>> -                  mr_page_size(mr) - page_offset);
>> -        va = kmap_local_page(page);
>> +        page_offset += info->offset;
>> +        bytes = min_t(unsigned int, length, PAGE_SIZE - page_offset);
>> +
>> +        va = kmap_local_page(info->page);
>>           arch_wb_cache_pmem(va + page_offset, bytes);
>>           kunmap_local(va);
>> @@ -500,6 +581,7 @@ enum resp_states rxe_mr_do_atomic_op(struct rxe_mr 
>> *mr, u64 iova, int opcode,
>>       } else {
>>           unsigned long index;
>>           int err;
>> +        struct rxe_mr_page *info;
>>           err = mr_check_range(mr, iova, sizeof(value));
>>           if (err) {
>> @@ -508,9 +590,12 @@ enum resp_states rxe_mr_do_atomic_op(struct 
>> rxe_mr *mr, u64 iova, int opcode,
>>           }
>>           page_offset = rxe_mr_iova_to_page_offset(mr, iova);
>>           index = rxe_mr_iova_to_index(mr, iova);
>> -        page = xa_load(&mr->page_list, index);
>> -        if (!page)
>> +        info = &mr->page_info[index];
>> +        if (!info->page)
>>               return RESPST_ERR_RKEY_VIOLATION;
>> +
>> +        page_offset += info->offset;
>> +        page = info->page;
>>       }
>>       if (unlikely(page_offset & 0x7)) {
>> @@ -549,6 +634,7 @@ enum resp_states rxe_mr_do_atomic_write(struct 
>> rxe_mr *mr, u64 iova, u64 value)
>>       } else {
>>           unsigned long index;
>>           int err;
>> +        struct rxe_mr_page *info;
>>           /* See IBA oA19-28 */
>>           err = mr_check_range(mr, iova, sizeof(value));
>> @@ -558,9 +644,12 @@ enum resp_states rxe_mr_do_atomic_write(struct 
>> rxe_mr *mr, u64 iova, u64 value)
>>           }
>>           page_offset = rxe_mr_iova_to_page_offset(mr, iova);
>>           index = rxe_mr_iova_to_index(mr, iova);
>> -        page = xa_load(&mr->page_list, index);
>> -        if (!page)
>> +        info = &mr->page_info[index];
>> +        if (!info->page)
>>               return RESPST_ERR_RKEY_VIOLATION;
>> +
>> +        page_offset += info->offset;
>> +        page = info->page;
>>       }
>>       /* See IBA A19.4.2 */
>> @@ -724,5 +813,5 @@ void rxe_mr_cleanup(struct rxe_pool_elem *elem)
>>       ib_umem_release(mr->umem);
>>       if (mr->ibmr.type != IB_MR_TYPE_DMA)
>> -        xa_destroy(&mr->page_list);
>> +        free_mr_page_info(mr);
>>   }
>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/ 
>> infiniband/sw/rxe/rxe_verbs.h
>> index f94ce85eb807..fb149f37e91d 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
>> @@ -335,6 +335,11 @@ static inline int rkey_is_mw(u32 rkey)
>>       return (index >= RXE_MIN_MW_INDEX) && (index <= RXE_MAX_MW_INDEX);
>>   }
>> +struct rxe_mr_page {
>> +    struct page        *page;
>> +    unsigned int        offset; /* offset in system page */
>> +};
>> +
>>   struct rxe_mr {
>>       struct rxe_pool_elem    elem;
>>       struct ib_mr        ibmr;
>> @@ -350,10 +355,13 @@ struct rxe_mr {
>>       unsigned int        page_shift;
>>       u64            page_mask;
>> +    /* size of page_info when mr allocated */
>>       u32            num_buf;
>> +    /* real size of page_info */
>> +    u32            max_allowed_buf;
>>       u32            nbuf;
>> -    struct xarray        page_list;
>> +    struct rxe_mr_page    *page_info;
>>   };
>>   static inline unsigned int mr_page_size(struct rxe_mr *mr)
> 

-- 
Best Regards,
Yanjun.Zhu


