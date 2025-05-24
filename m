Return-Path: <linux-rdma+bounces-10665-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62949AC2FEC
	for <lists+linux-rdma@lfdr.de>; Sat, 24 May 2025 15:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA789E03C8
	for <lists+linux-rdma@lfdr.de>; Sat, 24 May 2025 13:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F241D7E41;
	Sat, 24 May 2025 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bp0aVTOY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E437E9
	for <linux-rdma@vger.kernel.org>; Sat, 24 May 2025 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748094804; cv=none; b=pzWJt32lvKf7KKEMyuFdsY5vO0VbVcu+emmHX5x5P/XzMx6AgDTqzulDi6Gd2fnrklIrAmrlpCu4Pk3zLahQJjG/8FsM3ay3uDQTDFUT2JSaH2R3PpC1lwk/2PeA3549sXf7acjQWKIWlYkKcllUvuxbS1NHhGM9jsdn8onyRAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748094804; c=relaxed/simple;
	bh=azLNJMoJgHs7cJEbtjwSPshfeaRBs+GRrvXkxggzSEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gUy3+FnqPeNxK611/umkGzm8xMQI0B3PM667PGHNNOp9SkA91HLMIWRm2gRdUCPjjmMCNijLoBYWmJu06nbHzkNdbl+ExbQEbRLenx6LKmq5qyuxJ0dFK4T2NoNVuBlmlAH98PTuHdaOGuVEEeBN2pf5AQjlwoBuHnjvcGArhSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bp0aVTOY; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6d0c8757-274d-4148-9f40-8e752e846987@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748094798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C5nhc8hWoT/wQNGyULW2ojsB0ysmV6JLeIcNI4KAIN0=;
	b=bp0aVTOYL1B053VfGu7HS4gts2RoEhRjc9PGHNRNjie88/v4XDHZ2ywkrOqjOObic7Uv+M
	tqyTTRxAgLNqlSso8/ymsGwrzTZITmeveiQCrgyyhpwfwUBfLSVScfEkyw07imFtstMlHq
	MdDJfR6mRdt7/5huXQsqxu6cXs8A1S8=
Date: Sat, 24 May 2025 15:53:15 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next v1] RDMA/core: Avoid hmm_dma_map_alloc() for
 virtual DMA devices
To: Daisuke Matsuda <dskmtsd@gmail.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
 zyjzyj2000@gmail.com
Cc: hch@infradead.org
References: <20250523184701.11004-1-dskmtsd@gmail.com>
 <bfb143ad-9a98-4832-ba1b-25bfe5879e46@linux.dev>
 <c71dcd9b-ab75-4f13-8170-71c71d911779@linux.dev>
 <95b1875c-fe87-4941-9242-551fb9546ccc@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <95b1875c-fe87-4941-9242-551fb9546ccc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/5/24 15:15, Daisuke Matsuda 写道:
> 
> On 2025/05/24 16:52, Zhu Yanjun wrote:
>> 在 2025/5/24 9:31, Zhu Yanjun 写道:
>>> 在 2025/5/23 20:47, Daisuke Matsuda 写道:
>>>> Drivers such as rxe, which use virtual DMA, must not call into the DMA
>>>> mapping core since they lack physical DMA capabilities. Otherwise, a 
>>>> NULL
>>>> pointer dereference is observed as shown below. This patch ensures 
>>>> the RDMA
>>>> core handles virtual and physical DMA paths appropriately.
>>>>
>>>> This fixes the following kernel oops:
>>>>
>>>>   BUG: kernel NULL pointer dereference, address: 00000000000002fc
>>>>   #PF: supervisor read access in kernel mode
>>>>   #PF: error_code(0x0000) - not-present page
>>>>   PGD 1028eb067 P4D 1028eb067 PUD 105da0067 PMD 0
>>>>   Oops: Oops: 0000 [#1] SMP NOPTI
>>>>   CPU: 3 UID: 1000 PID: 1854 Comm: python3 Tainted: G W           
>>>> 6.15.0-rc1+ #11 PREEMPT(voluntary)
>>>>   Tainted: [W]=WARN
>>>>   Hardware name: Trigkey Key N/Key N, BIOS KEYN101 09/02/2024
>>>>   RIP: 0010:hmm_dma_map_alloc+0x25/0x100
>>>>   Code: 90 90 90 90 90 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 49 89 
>>>> d6 49 c1 e6 0c 41 55 41 54 53 49 39 ce 0f 82 c6 00 00 00 49 89 fc 
>>>> <f6> 87 fc 02 00 00 20 0f 84 af 00 00 00 49 89 f5 48 89 d3 49 89 cf
>>>>   RSP: 0018:ffffd3d3420eb830 EFLAGS: 00010246
>>>>   RAX: 0000000000001000 RBX: ffff8b727c7f7400 RCX: 0000000000001000
>>>>   RDX: 0000000000000001 RSI: ffff8b727c7f74b0 RDI: 0000000000000000
>>>>   RBP: ffffd3d3420eb858 R08: 0000000000000000 R09: 0000000000000000
>>>>   R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>>>>   R13: 00007262a622a000 R14: 0000000000001000 R15: ffff8b727c7f74b0
>>>>   FS:  00007262a62a1080(0000) GS:ffff8b762ac3e000(0000) 
>>>> knlGS:0000000000000000
>>>>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>   CR2: 00000000000002fc CR3: 000000010a1f0004 CR4: 0000000000f72ef0
>>>>   PKRU: 55555554
>>>>   Call Trace:
>>>>    <TASK>
>>>>    ib_init_umem_odp+0xb6/0x110 [ib_uverbs]
>>>>    ib_umem_odp_get+0xf0/0x150 [ib_uverbs]
>>>>    rxe_odp_mr_init_user+0x71/0x170 [rdma_rxe]
>>>>    rxe_reg_user_mr+0x217/0x2e0 [rdma_rxe]
>>>>    ib_uverbs_reg_mr+0x19e/0x2e0 [ib_uverbs]
>>>>    ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0xd9/0x150 [ib_uverbs]
>>>>    ib_uverbs_cmd_verbs+0xd19/0xee0 [ib_uverbs]
>>>>    ? mmap_region+0x63/0xd0
>>>>    ? __pfx_ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x10/0x10 
>>>> [ib_uverbs]
>>>>    ib_uverbs_ioctl+0xba/0x130 [ib_uverbs]
>>>>    __x64_sys_ioctl+0xa4/0xe0
>>>>    x64_sys_call+0x1178/0x2660
>>>>    do_syscall_64+0x7e/0x170
>>>>    ? syscall_exit_to_user_mode+0x4e/0x250
>>>>    ? do_syscall_64+0x8a/0x170
>>>>    ? do_syscall_64+0x8a/0x170
>>>>    ? syscall_exit_to_user_mode+0x4e/0x250
>>>>    ? do_syscall_64+0x8a/0x170
>>>>    ? syscall_exit_to_user_mode+0x4e/0x250
>>>>    ? do_syscall_64+0x8a/0x170
>>>>    ? do_user_addr_fault+0x1d2/0x8d0
>>>>    ? irqentry_exit_to_user_mode+0x43/0x250
>>>>    ? irqentry_exit+0x43/0x50
>>>>    ? exc_page_fault+0x93/0x1d0
>>>>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>   RIP: 0033:0x7262a6124ded
>>>>   Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 
>>>> 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 
>>>> <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
>>>>   RSP: 002b:00007fffd08c3960 EFLAGS: 00000246 ORIG_RAX: 
>>>> 0000000000000010
>>>>   RAX: ffffffffffffffda RBX: 00007fffd08c39f0 RCX: 00007262a6124ded
>>>>   RDX: 00007fffd08c3a10 RSI: 00000000c0181b01 RDI: 0000000000000007
>>>>   RBP: 00007fffd08c39b0 R08: 0000000014107820 R09: 00007fffd08c3b44
>>>>   R10: 000000000000000c R11: 0000000000000246 R12: 00007fffd08c3b44
>>>>   R13: 000000000000000c R14: 00007fffd08c3b58 R15: 0000000014107960
>>>>    </TASK>
>>>>
>>>> Fixes: 1efe8c0670d6 ("RDMA/core: Convert UMEM ODP DMA mapping to 
>>>> caching IOVA and page linkage")
>>>> Closes: https://lore.kernel.org/ 
>>>> all/3e8f343f-7d66-4f7a-9f08-3910623e322f@gmail.com/
>>>> Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
>>>> ---
>>>>   drivers/infiniband/core/device.c   | 24 ++++++++++++++++++++++++
>>>>   drivers/infiniband/core/umem_odp.c |  6 +++---
>>>>   include/rdma/ib_verbs.h            | 12 ++++++++++++
>>>>   3 files changed, 39 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/ 
>>>> core/device.c
>>>> index b4e3e4beb7f4..8be4797c66ec 100644
>>>> --- a/drivers/infiniband/core/device.c
>>>> +++ b/drivers/infiniband/core/device.c
>>>> @@ -2864,6 +2864,30 @@ int ib_dma_virt_map_sg(struct ib_device *dev, 
>>>> struct scatterlist *sg, int nents)
>>>>       return nents;
>>>>   }
>>>>   EXPORT_SYMBOL(ib_dma_virt_map_sg);
>>>> +int ib_dma_virt_map_alloc(struct device *dev, struct hmm_dma_map *map,
>>>> +              size_t nr_entries, size_t dma_entry_size)
>>>> +{
>>>> +    if (!(nr_entries * PAGE_SIZE / dma_entry_size))
>>>> +        return -EINVAL;
>>>> +
>>>> +    map->dma_entry_size = dma_entry_size;
>>>> +    map->pfn_list = kvcalloc(nr_entries, sizeof(*map->pfn_list),
>>>> +                 GFP_KERNEL | __GFP_NOWARN);
>>>> +    if (!map->pfn_list)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    map->dma_list = kvcalloc(nr_entries, sizeof(*map->dma_list),
>>>> +                 GFP_KERNEL | __GFP_NOWARN);
>>>> +    if (!map->dma_list)
>>>> +        goto err_dma;
>>>> +
>>>> +    return 0;
>>>> +
>>>> +err_dma:
>>>> +    kvfree(map->pfn_list);
>>>> +    return -ENOMEM;
>>>> +}
>>>> +EXPORT_SYMBOL(ib_dma_virt_map_alloc);
>>>>   #endif /* CONFIG_INFINIBAND_VIRT_DMA */
>>>>   static const struct rdma_nl_cbs 
>>>> ibnl_ls_cb_table[RDMA_NL_LS_NUM_OPS] = {
>>>> diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/ 
>>>> infiniband/ core/umem_odp.c
>>>> index 51d518989914..aa03f3fc84d0 100644
>>>> --- a/drivers/infiniband/core/umem_odp.c
>>>> +++ b/drivers/infiniband/core/umem_odp.c
>>>> @@ -75,9 +75,9 @@ static int ib_init_umem_odp(struct ib_umem_odp 
>>>> *umem_odp,
>>>>       if (unlikely(end < page_size))
>>>>           return -EOVERFLOW;
>>>> -    ret = hmm_dma_map_alloc(dev->dma_device, &umem_odp->map,
>>>> -                (end - start) >> PAGE_SHIFT,
>>>> -                1 << umem_odp->page_shift);
>>>> +    ret = ib_dma_map_alloc(dev, &umem_odp->map,
>>>> +                   (end - start) >> PAGE_SHIFT,
>>>> +                   1 << umem_odp->page_shift);
>>>>       if (ret)
>>>>           return ret;
>>>> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
>>>> index b06a0ed81bdd..10813f348b99 100644
>>>> --- a/include/rdma/ib_verbs.h
>>>> +++ b/include/rdma/ib_verbs.h
>>>> @@ -36,6 +36,7 @@
>>>>   #include <linux/irqflags.h>
>>>>   #include <linux/preempt.h>
>>>>   #include <linux/dim.h>
>>>> +#include <linux/hmm-dma.h>
>>>>   #include <uapi/rdma/ib_user_verbs.h>
>>>>   #include <rdma/rdma_counter.h>
>>>>   #include <rdma/restrack.h>
>>>> @@ -4221,6 +4222,17 @@ static inline void 
>>>> ib_dma_unmap_sg_attrs(struct ib_device *dev,
>>>>                      dma_attrs);
>>>>   }
>>>> +int ib_dma_virt_map_alloc(struct device *dev, struct hmm_dma_map *map,
>>>> +              size_t nr_entries, size_t dma_entry_size);
>>>> +static inline int ib_dma_map_alloc(struct ib_device *dev, struct 
>>>> hmm_dma_map *map,
>>>> +                   size_t nr_entries, size_t dma_entry_size)
>>>> +{
>>>> +    if (ib_uses_virt_dma(dev))
>>>> +        return ib_dma_virt_map_alloc(dev->dma_device, map, nr_entries,
>>>> +                         dma_entry_size);
>>>
>>> Other emulated RDMA devices driver also call ib_dma_virt_map_alloc?
>>> Only rxe will call ib_dma_virt_map_alloc?
> 
> Only rxe will call ib_dma_virt_map_alloc()
> because currently only mlx5 and rxe will use ib_dma_map_alloc().
> 
>>
>> As I know, other emulated RDMA driver also implemented ODP, and with 
>> the current hmm_dma_map_alloc, it can work well.
>> So in the above "if (ib_uses_virt_dma(dev))", changed to if (rxe_dev), 
>> then go to call ib_dma_virt_map_alloc.
> 
> Only mlx5 and rxe support ODP. While hmm_dma_map_alloc() works fine for 
> mlx5,

No. Other private emulated RDMA driver also supports ODP, but it is not 
in the directory drivers/infiniband/sw/. It also call ib_dma_map_alloc 
and works well with hmm_dma_map_alloc.

Up to you because the driver is not in kernel. I do not have strong 
preference.

> it cannot be used for any drivers under drivers/infiniband/sw/ because 
> they all set
> dma_device to NULL in ib_register_device().
> 
> So changing the condition to if (rxe_dev) makes the code too specific.
> To my understanding, it's generally discouraged to add code in the RDMA 
> core
> that targets a specific implementation.
> 
> I have just realized that we can remove an argument "struct device"
> from ib_dma_virt_map_alloc(). I will post the v2 to fix this.

Please go ahead.

Zhu Yanjun

> 
> Thanks,
> Daisuke
> 
>>
>> Yanjun.Zhu
>>
>>>
>>> Zhu Yanjun
>>>
>>>> +    return hmm_dma_map_alloc(dev->dma_device, map, nr_entries, 
>>>> dma_entry_size);
>>>> +}
>>>> +
>>>>   /**
>>>>    * ib_dma_map_sgtable_attrs - Map a scatter/gather table to DMA 
>>>> addresses
>>>>    * @dev: The device for which the DMA addresses are to be created
>>>
>>
> 


