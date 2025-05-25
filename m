Return-Path: <linux-rdma+bounces-10692-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCEBAC351E
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 16:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90D2F1892DCC
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 14:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2301F09BD;
	Sun, 25 May 2025 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ahP5FpmE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA371F4CB8
	for <linux-rdma@vger.kernel.org>; Sun, 25 May 2025 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748182693; cv=none; b=QaAmM5uM0D35WtfRf90ORx6TuANLyVySDxGjPDaGznBX2fNqa9v01C3Lf3cBCbFT7CW1Lbo821L5HM2tWd5z9JctVBIvpq6ESfD1LeZz/e2Pbf97zSqzc/sA8/4QNU4a1D3g3w+jj/dNAXrbExOH37FE8YioXrXiRZ6DxFwIaqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748182693; c=relaxed/simple;
	bh=rT/1zF9t3ApJzwGv9UF2/4CCNSrhDvl14JYAnpUsA+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lL8m+iGu2tuhdHSl7bBEPDE6n8J8z+w6pPcZ0W410DkjPN2Z8p6+C2Hj6FIWqj62Yepz0N3KgCMSqsRfie29+IZtFnmhJNvRobL9B6Fy55dfEGvVEAOLTBxYorMubLZRRG0IxVgkU3Rnh0LVYOVqA5jC/M4E3w7yY9Wxt+QIEjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ahP5FpmE; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <621d1173-abe4-4eb7-9098-79b9a3e1c266@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748182679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMkRaioxqYyh6tp5UUGkklO/SWTZWWyfPj36Z74vxHo=;
	b=ahP5FpmE3UVI+3dZHg1sgqpXK/ZBE0V6gXbBXHfiapRDiVbHCzseWciq5WfoaVW547E4XO
	04qeo1ATCOWVAxZXdFdrR5RiUJcdx5JarbhOOzyljHZxu2ORmYr78LJ9zgg6ftsr+BuUac
	3hEBEgpa+JPeXnVv7b8zogaWDaTsUnk=
Date: Sun, 25 May 2025 16:17:56 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next v3] RDMA/core: Avoid hmm_dma_map_alloc() for
 virtual DMA devices
To: Daisuke Matsuda <dskmtsd@gmail.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
 zyjzyj2000@gmail.com
Cc: hch@infradead.org
References: <20250524144328.4361-1-dskmtsd@gmail.com>
 <c8d6bfb6-570c-48b2-be62-188e11353c5a@linux.dev>
 <b10304c8-c951-4ade-ad57-515df6bd4221@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <b10304c8-c951-4ade-ad57-515df6bd4221@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/5/25 8:03, Daisuke Matsuda 写道:
> 
> 
> On 2025/05/25 14:22, Zhu Yanjun wrote:
>> 在 2025/5/24 16:43, Daisuke Matsuda 写道:
>>> Drivers such as rxe, which use virtual DMA, must not call into the DMA
>>> mapping core since they lack physical DMA capabilities. Otherwise, a 
>>> NULL
>>> pointer dereference is observed as shown below. This patch ensures 
>>> the RDMA
>>> core handles virtual and physical DMA paths appropriately.
>>>
>>> This fixes the following kernel oops:
>>>
>>>   BUG: kernel NULL pointer dereference, address: 00000000000002fc
>>>   #PF: supervisor read access in kernel mode
>>>   #PF: error_code(0x0000) - not-present page
>>>   PGD 1028eb067 P4D 1028eb067 PUD 105da0067 PMD 0
>>>   Oops: Oops: 0000 [#1] SMP NOPTI
>>>   CPU: 3 UID: 1000 PID: 1854 Comm: python3 Tainted: G        
>>> W           6.15.0-rc1+ #11 PREEMPT(voluntary)
>>>   Tainted: [W]=WARN
>>>   Hardware name: Trigkey Key N/Key N, BIOS KEYN101 09/02/2024
>>>   RIP: 0010:hmm_dma_map_alloc+0x25/0x100
>>>   Code: 90 90 90 90 90 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 49 89 
>>> d6 49 c1 e6 0c 41 55 41 54 53 49 39 ce 0f 82 c6 00 00 00 49 89 fc 
>>> <f6> 87 fc 02 00 00 20 0f 84 af 00 00 00 49 89 f5 48 89 d3 49 89 cf
>>>   RSP: 0018:ffffd3d3420eb830 EFLAGS: 00010246
>>>   RAX: 0000000000001000 RBX: ffff8b727c7f7400 RCX: 0000000000001000
>>>   RDX: 0000000000000001 RSI: ffff8b727c7f74b0 RDI: 0000000000000000
>>>   RBP: ffffd3d3420eb858 R08: 0000000000000000 R09: 0000000000000000
>>>   R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>>>   R13: 00007262a622a000 R14: 0000000000001000 R15: ffff8b727c7f74b0
>>>   FS:  00007262a62a1080(0000) GS:ffff8b762ac3e000(0000) 
>>> knlGS:0000000000000000
>>>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>   CR2: 00000000000002fc CR3: 000000010a1f0004 CR4: 0000000000f72ef0
>>>   PKRU: 55555554
>>>   Call Trace:
>>>    <TASK>
>>>    ib_init_umem_odp+0xb6/0x110 [ib_uverbs]
>>>    ib_umem_odp_get+0xf0/0x150 [ib_uverbs]
>>>    rxe_odp_mr_init_user+0x71/0x170 [rdma_rxe]
>>>    rxe_reg_user_mr+0x217/0x2e0 [rdma_rxe]
>>>    ib_uverbs_reg_mr+0x19e/0x2e0 [ib_uverbs]
>>>    ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0xd9/0x150 [ib_uverbs]
>>>    ib_uverbs_cmd_verbs+0xd19/0xee0 [ib_uverbs]
>>>    ? mmap_region+0x63/0xd0
>>>    ? __pfx_ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x10/0x10 
>>> [ib_uverbs]
>>>    ib_uverbs_ioctl+0xba/0x130 [ib_uverbs]
>>>    __x64_sys_ioctl+0xa4/0xe0
>>>    x64_sys_call+0x1178/0x2660
>>>    do_syscall_64+0x7e/0x170
>>>    ? syscall_exit_to_user_mode+0x4e/0x250
>>>    ? do_syscall_64+0x8a/0x170
>>>    ? do_syscall_64+0x8a/0x170
>>>    ? syscall_exit_to_user_mode+0x4e/0x250
>>>    ? do_syscall_64+0x8a/0x170
>>>    ? syscall_exit_to_user_mode+0x4e/0x250
>>>    ? do_syscall_64+0x8a/0x170
>>>    ? do_user_addr_fault+0x1d2/0x8d0
>>>    ? irqentry_exit_to_user_mode+0x43/0x250
>>>    ? irqentry_exit+0x43/0x50
>>>    ? exc_page_fault+0x93/0x1d0
>>>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>   RIP: 0033:0x7262a6124ded
>>>   Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 
>>> 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 
>>> <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
>>>   RSP: 002b:00007fffd08c3960 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>>>   RAX: ffffffffffffffda RBX: 00007fffd08c39f0 RCX: 00007262a6124ded
>>>   RDX: 00007fffd08c3a10 RSI: 00000000c0181b01 RDI: 0000000000000007
>>>   RBP: 00007fffd08c39b0 R08: 0000000014107820 R09: 00007fffd08c3b44
>>>   R10: 000000000000000c R11: 0000000000000246 R12: 00007fffd08c3b44
>>>   R13: 000000000000000c R14: 00007fffd08c3b58 R15: 0000000014107960
>>>    </TASK>
>>>
>>> Fixes: 1efe8c0670d6 ("RDMA/core: Convert UMEM ODP DMA mapping to 
>>> caching IOVA and page linkage")
>>> Closes: https://lore.kernel.org/ 
>>> all/3e8f343f-7d66-4f7a-9f08-3910623e322f@gmail.com/
>>> Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
>>
>> I tried to apply this commit to the following rdma branch.
>> But I failed. The error is as below:
>>
>> "
>> Applying: RDMA/core: Avoid hmm_dma_map_alloc() for virtual DMA devices
>> error: patch failed: drivers/infiniband/core/umem_odp.c:75
>> error: drivers/infiniband/core/umem_odp.c: patch does not apply
>> Patch failed at 0001 RDMA/core: Avoid hmm_dma_map_alloc() for virtual 
>> DMA devices
>> hint: Use 'git am --show-current-patch=diff' to see the failed patch
>> When you have resolved this problem, run "git am --continue".
>> If you prefer to skip this patch, run "git am --skip" instead.
>> To restore the original branch and stop patching, run "git am --abort".
>>
>> "
>>
>> The remote branch is remotes/rdma/rdma-next
>> The head commit is 3b6a1e410c7f RDMA/mlx5: Fix CC counters query for MPV
>>
>> I am not sure if I use the correct repository and branch or not.
> 
> Thank you for trying the patch.
> 
> The change is meant to be applied to 'for-next' branch,
> which contains patches from the following series:
> [PATCH v10 00/24] Provide a new two step DMA mapping API
> https://lore.kernel.org/linux-rdma/cover.1745831017.git.leon@kernel.org/
> 
> cf. https://kernel.googlesource.com/pub/scm/linux/kernel/git/rdma/rdma/

Exactly. With the above link and for-next branch, this commit can be 
applied successfully.

Thanks,

Zhu Yanjun

> 
> Thanks,
> Daisuke
> 
>>
>> Best Regards,
>> Zhu Yanjun
>>
>>> ---
>>>   drivers/infiniband/core/device.c   | 17 +++++++++++++++++
>>>   drivers/infiniband/core/umem_odp.c | 11 ++++++++---
>>>   include/rdma/ib_verbs.h            |  4 ++++
>>>   3 files changed, 29 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/ 
>>> core/device.c
>>> index b4e3e4beb7f4..abb8fed292c0 100644
>>> --- a/drivers/infiniband/core/device.c
>>> +++ b/drivers/infiniband/core/device.c
>>> @@ -2864,6 +2864,23 @@ int ib_dma_virt_map_sg(struct ib_device *dev, 
>>> struct scatterlist *sg, int nents)
>>>       return nents;
>>>   }
>>>   EXPORT_SYMBOL(ib_dma_virt_map_sg);
>>> +int ib_dma_virt_map_alloc(struct hmm_dma_map *map, size_t nr_entries,
>>> +              size_t dma_entry_size)
>>> +{
>>> +    if (!(nr_entries * PAGE_SIZE / dma_entry_size))
>>> +        return -EINVAL;
>>> +
>>> +    map->dma_entry_size = dma_entry_size;
>>> +    map->pfn_list = kvcalloc(nr_entries, sizeof(*map->pfn_list),
>>> +                 GFP_KERNEL | __GFP_NOWARN);
>>> +    if (!map->pfn_list)
>>> +        return -ENOMEM;
>>> +
>>> +    map->dma_list = NULL;
>>> +
>>> +    return 0;
>>> +}
>>> +EXPORT_SYMBOL(ib_dma_virt_map_alloc);
>>>   #endif /* CONFIG_INFINIBAND_VIRT_DMA */
>>>   static const struct rdma_nl_cbs 
>>> ibnl_ls_cb_table[RDMA_NL_LS_NUM_OPS] = {
>>> diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/ 
>>> core/umem_odp.c
>>> index 51d518989914..a5b17be0894a 100644
>>> --- a/drivers/infiniband/core/umem_odp.c
>>> +++ b/drivers/infiniband/core/umem_odp.c
>>> @@ -75,9 +75,14 @@ static int ib_init_umem_odp(struct ib_umem_odp 
>>> *umem_odp,
>>>       if (unlikely(end < page_size))
>>>           return -EOVERFLOW;
>>> -    ret = hmm_dma_map_alloc(dev->dma_device, &umem_odp->map,
>>> -                (end - start) >> PAGE_SHIFT,
>>> -                1 << umem_odp->page_shift);
>>> +    if (ib_uses_virt_dma(dev))
>>> +        ret = ib_dma_virt_map_alloc(&umem_odp->map,
>>> +                        (end - start) >> PAGE_SHIFT,
>>> +                        1 << umem_odp->page_shift);
>>> +    else
>>> +        ret = hmm_dma_map_alloc(dev->dma_device, &umem_odp->map,
>>> +                    (end - start) >> PAGE_SHIFT,
>>> +                    1 << umem_odp->page_shift);
>>>       if (ret)
>>>           return ret;
>>> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
>>> index b06a0ed81bdd..9ea41f288736 100644
>>> --- a/include/rdma/ib_verbs.h
>>> +++ b/include/rdma/ib_verbs.h
>>> @@ -36,6 +36,7 @@
>>>   #include <linux/irqflags.h>
>>>   #include <linux/preempt.h>
>>>   #include <linux/dim.h>
>>> +#include <linux/hmm-dma.h>
>>>   #include <uapi/rdma/ib_user_verbs.h>
>>>   #include <rdma/rdma_counter.h>
>>>   #include <rdma/restrack.h>
>>> @@ -4221,6 +4222,9 @@ static inline void ib_dma_unmap_sg_attrs(struct 
>>> ib_device *dev,
>>>                      dma_attrs);
>>>   }
>>> +int ib_dma_virt_map_alloc(struct hmm_dma_map *map, size_t nr_entries,
>>> +              size_t dma_entry_size);
>>> +
>>>   /**
>>>    * ib_dma_map_sgtable_attrs - Map a scatter/gather table to DMA 
>>> addresses
>>>    * @dev: The device for which the DMA addresses are to be created
>>
> 


