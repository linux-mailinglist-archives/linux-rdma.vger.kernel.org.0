Return-Path: <linux-rdma+bounces-10662-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6BAAC2FD3
	for <lists+linux-rdma@lfdr.de>; Sat, 24 May 2025 15:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E7799E1E3F
	for <lists+linux-rdma@lfdr.de>; Sat, 24 May 2025 13:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7DC1CEAD6;
	Sat, 24 May 2025 13:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ax0B6g3N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAA07E9;
	Sat, 24 May 2025 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748092551; cv=none; b=sv78oLQv9SyH+/LHWAcBSlPZsJfDoE07+x9zSr29ZBSDId0ySDJ6kAObI2y7BJuCmPuD3C1mrkPxoP/eWpsqSbO7NCtn7R0p931mKD/P7ZplivFULr9SzaRf1Vr2ZrJNhK1QWaEKuF+rMUTIcYjSYwMaf4Q1OXteYqaDjInFuGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748092551; c=relaxed/simple;
	bh=vLcHHKUQEgddGQiMZdUg/Ge3HUsIo0jn4qXtL0dcuiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KzHtijdUsiuh+RKI6UQcNKV1ulCBaVMlmU8qFcUy1oGX8kxN4mgtV0HESEJTdoAtL3VIva733okm9oAI2Z98UVJmApFBHk6XXacb7e3iPxTr7EsGYz4tRH/WbBtaEMFgcKlnngk6cMYlbaqtVuS/TbdXB0KS4Yuc5qFT5QPfSjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ax0B6g3N; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3112beaa623so118157a91.2;
        Sat, 24 May 2025 06:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748092549; x=1748697349; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9qrfev+FmiUJFqYOfv5bYcixbTHUXGEoxf24Yu+cbgs=;
        b=ax0B6g3NvQLTqSn8LLgDSQzgg3MLew8pGw1AbxqP0XaB9EeRCGFnXD1/pnaDQ9wUXi
         Yr5ZUIJBw0W4cXV4MdIjKGNveVyibqsX5G1d5WSkmgcKAtVJa8o0CFY4CTQTjCfE8/DN
         V9HjzSFLXpdd7QlMre803v+U1WsqT702EtckhZ334UxxgMUvfxV0zAjVKASkCYDqdkRx
         x0IKdkqRzr9I0gD2I11PwQFI9Jo9SGgY+LKSMjrZGyCAwN5uU37/k5PvINq0+EFJR01L
         nmH+0DIifAHgCzI+yMJD9yuzUZE1EPl1hhWXJ9nBTSN6sw7+PLMxl+nX1ZCBKGhKKCKg
         d8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748092549; x=1748697349;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9qrfev+FmiUJFqYOfv5bYcixbTHUXGEoxf24Yu+cbgs=;
        b=DAl6AcmhurIlEXhYquna/R96rxQXQ/6ernF9AFSqXQI1k5Y7MhJIa0phOAM3nnqm/c
         JvnNzYqcHbFY5AqZ7zQERa5RXtsYfytVkrPhN0k3Dcn53RdwePUmJkGAw6plDZ+XhCRI
         fs59Ok3upEcxLRBbBhyE1m+NulFd3yp9icGbqJzAZkv5ZqQAxz7IJESH4SZOLeNplzcj
         Wx/H0SEgKBrqaJyJ3BXMF1ZxhlOv40pjZ3S/HzRa1pnH5CNzQFM0uBuZbBzoalz32it5
         86TFjllJJ2k5QcJaAJ6aHZjjrCAwN2Rf0dffvk//HUcpNrM6W9ZtZSbkJXXkG/lnNnUr
         kAQA==
X-Forwarded-Encrypted: i=1; AJvYcCUkNrUQ9j0DBoECkMjrI0B1JG1tTDDzsLequJ106Lx6mk/P31fTq7cUA9WliKKBov5vBvbF+c354X/pXu4=@vger.kernel.org, AJvYcCVLlhs7/jIGNUgNZW0chK9/g+z7ME5iyDiy9cYLQy/akIvxHzsfNsxsyzTs6C3R20A8rn+E6K335DHwUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZxa82gUCrnsx766F6QdfdppiUJ82B4Y8WEP/6g3xmPAaKWmub
	ScX8tJ4vut63p/ljEgr0LQRRx5hVon56xbvAb6jO8Qqqe6Vld194aesQ
X-Gm-Gg: ASbGnctNycSBJmmN5lDF43Ux3aZSKCZgCitjX5hw5jOCgjXG22WGJwu0vLjQtpiXxlu
	V/o8aXAg6NHaGj/uIbuSaa0JnRiroFdPaBjOHVCtM+oPYtc1cnI5vgEekky9WmKZE1kKh4Pzq8j
	lyuruSSsjJT5Fp/Bmm05ES60kIt65w1KO6zqRuuAPmGH9Fgmn3KSpf2tN/Qta4RES94vd+ETGaK
	0Aay3ePVcBiiEzLwCnxcXa7d7GQ0nh6sTT8Ot39B023Gle6trjqJhKaLKmzMrdTO2uitDDJmpsB
	6zIa4oSFWalS9TUzekDDXyuoOuk19Y2+Um39UyMTfuMXnLxOww39e/97ZJT46VlcrkArlLasy9c
	RosYS4bNsfeVd71v0QNlWYxL5kk8=
X-Google-Smtp-Source: AGHT+IEf0MtmsIg3fXFeAxOxn1z87LOsYCgCy9TBgMDOAL0jf8N2CC/qlFlfnXE9UXYcNOciz9kdmQ==
X-Received: by 2002:a17:90b:52c6:b0:303:75a7:26a4 with SMTP id 98e67ed59e1d1-3110f333fa4mr4308197a91.7.1748092548842;
        Sat, 24 May 2025 06:15:48 -0700 (PDT)
Received: from [192.168.11.2] (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3110b9a447bsm1520492a91.3.2025.05.24.06.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 May 2025 06:15:48 -0700 (PDT)
Message-ID: <95b1875c-fe87-4941-9242-551fb9546ccc@gmail.com>
Date: Sat, 24 May 2025 22:15:43 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v1] RDMA/core: Avoid hmm_dma_map_alloc() for
 virtual DMA devices
To: Zhu Yanjun <yanjun.zhu@linux.dev>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
 zyjzyj2000@gmail.com
Cc: hch@infradead.org
References: <20250523184701.11004-1-dskmtsd@gmail.com>
 <bfb143ad-9a98-4832-ba1b-25bfe5879e46@linux.dev>
 <c71dcd9b-ab75-4f13-8170-71c71d911779@linux.dev>
Content-Language: en-US
From: Daisuke Matsuda <dskmtsd@gmail.com>
In-Reply-To: <c71dcd9b-ab75-4f13-8170-71c71d911779@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2025/05/24 16:52, Zhu Yanjun wrote:
> 在 2025/5/24 9:31, Zhu Yanjun 写道:
>> 在 2025/5/23 20:47, Daisuke Matsuda 写道:
>>> Drivers such as rxe, which use virtual DMA, must not call into the DMA
>>> mapping core since they lack physical DMA capabilities. Otherwise, a NULL
>>> pointer dereference is observed as shown below. This patch ensures the RDMA
>>> core handles virtual and physical DMA paths appropriately.
>>>
>>> This fixes the following kernel oops:
>>>
>>>   BUG: kernel NULL pointer dereference, address: 00000000000002fc
>>>   #PF: supervisor read access in kernel mode
>>>   #PF: error_code(0x0000) - not-present page
>>>   PGD 1028eb067 P4D 1028eb067 PUD 105da0067 PMD 0
>>>   Oops: Oops: 0000 [#1] SMP NOPTI
>>>   CPU: 3 UID: 1000 PID: 1854 Comm: python3 Tainted: G W           6.15.0-rc1+ #11 PREEMPT(voluntary)
>>>   Tainted: [W]=WARN
>>>   Hardware name: Trigkey Key N/Key N, BIOS KEYN101 09/02/2024
>>>   RIP: 0010:hmm_dma_map_alloc+0x25/0x100
>>>   Code: 90 90 90 90 90 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 49 89 d6 49 c1 e6 0c 41 55 41 54 53 49 39 ce 0f 82 c6 00 00 00 49 89 fc <f6> 87 fc 02 00 00 20 0f 84 af 00 00 00 49 89 f5 48 89 d3 49 89 cf
>>>   RSP: 0018:ffffd3d3420eb830 EFLAGS: 00010246
>>>   RAX: 0000000000001000 RBX: ffff8b727c7f7400 RCX: 0000000000001000
>>>   RDX: 0000000000000001 RSI: ffff8b727c7f74b0 RDI: 0000000000000000
>>>   RBP: ffffd3d3420eb858 R08: 0000000000000000 R09: 0000000000000000
>>>   R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>>>   R13: 00007262a622a000 R14: 0000000000001000 R15: ffff8b727c7f74b0
>>>   FS:  00007262a62a1080(0000) GS:ffff8b762ac3e000(0000) knlGS:0000000000000000
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
>>>    ? __pfx_ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x10/0x10 [ib_uverbs]
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
>>>   Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
>>>   RSP: 002b:00007fffd08c3960 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>>>   RAX: ffffffffffffffda RBX: 00007fffd08c39f0 RCX: 00007262a6124ded
>>>   RDX: 00007fffd08c3a10 RSI: 00000000c0181b01 RDI: 0000000000000007
>>>   RBP: 00007fffd08c39b0 R08: 0000000014107820 R09: 00007fffd08c3b44
>>>   R10: 000000000000000c R11: 0000000000000246 R12: 00007fffd08c3b44
>>>   R13: 000000000000000c R14: 00007fffd08c3b58 R15: 0000000014107960
>>>    </TASK>
>>>
>>> Fixes: 1efe8c0670d6 ("RDMA/core: Convert UMEM ODP DMA mapping to caching IOVA and page linkage")
>>> Closes: https://lore.kernel.org/ all/3e8f343f-7d66-4f7a-9f08-3910623e322f@gmail.com/
>>> Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
>>> ---
>>>   drivers/infiniband/core/device.c   | 24 ++++++++++++++++++++++++
>>>   drivers/infiniband/core/umem_odp.c |  6 +++---
>>>   include/rdma/ib_verbs.h            | 12 ++++++++++++
>>>   3 files changed, 39 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/ core/device.c
>>> index b4e3e4beb7f4..8be4797c66ec 100644
>>> --- a/drivers/infiniband/core/device.c
>>> +++ b/drivers/infiniband/core/device.c
>>> @@ -2864,6 +2864,30 @@ int ib_dma_virt_map_sg(struct ib_device *dev, struct scatterlist *sg, int nents)
>>>       return nents;
>>>   }
>>>   EXPORT_SYMBOL(ib_dma_virt_map_sg);
>>> +int ib_dma_virt_map_alloc(struct device *dev, struct hmm_dma_map *map,
>>> +              size_t nr_entries, size_t dma_entry_size)
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
>>> +    map->dma_list = kvcalloc(nr_entries, sizeof(*map->dma_list),
>>> +                 GFP_KERNEL | __GFP_NOWARN);
>>> +    if (!map->dma_list)
>>> +        goto err_dma;
>>> +
>>> +    return 0;
>>> +
>>> +err_dma:
>>> +    kvfree(map->pfn_list);
>>> +    return -ENOMEM;
>>> +}
>>> +EXPORT_SYMBOL(ib_dma_virt_map_alloc);
>>>   #endif /* CONFIG_INFINIBAND_VIRT_DMA */
>>>   static const struct rdma_nl_cbs ibnl_ls_cb_table[RDMA_NL_LS_NUM_OPS] = {
>>> diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/ core/umem_odp.c
>>> index 51d518989914..aa03f3fc84d0 100644
>>> --- a/drivers/infiniband/core/umem_odp.c
>>> +++ b/drivers/infiniband/core/umem_odp.c
>>> @@ -75,9 +75,9 @@ static int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
>>>       if (unlikely(end < page_size))
>>>           return -EOVERFLOW;
>>> -    ret = hmm_dma_map_alloc(dev->dma_device, &umem_odp->map,
>>> -                (end - start) >> PAGE_SHIFT,
>>> -                1 << umem_odp->page_shift);
>>> +    ret = ib_dma_map_alloc(dev, &umem_odp->map,
>>> +                   (end - start) >> PAGE_SHIFT,
>>> +                   1 << umem_odp->page_shift);
>>>       if (ret)
>>>           return ret;
>>> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
>>> index b06a0ed81bdd..10813f348b99 100644
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
>>> @@ -4221,6 +4222,17 @@ static inline void ib_dma_unmap_sg_attrs(struct ib_device *dev,
>>>                      dma_attrs);
>>>   }
>>> +int ib_dma_virt_map_alloc(struct device *dev, struct hmm_dma_map *map,
>>> +              size_t nr_entries, size_t dma_entry_size);
>>> +static inline int ib_dma_map_alloc(struct ib_device *dev, struct hmm_dma_map *map,
>>> +                   size_t nr_entries, size_t dma_entry_size)
>>> +{
>>> +    if (ib_uses_virt_dma(dev))
>>> +        return ib_dma_virt_map_alloc(dev->dma_device, map, nr_entries,
>>> +                         dma_entry_size);
>>
>> Other emulated RDMA devices driver also call ib_dma_virt_map_alloc?
>> Only rxe will call ib_dma_virt_map_alloc?

Only rxe will call ib_dma_virt_map_alloc()
because currently only mlx5 and rxe will use ib_dma_map_alloc().

> 
> As I know, other emulated RDMA driver also implemented ODP, and with the current hmm_dma_map_alloc, it can work well.
> So in the above "if (ib_uses_virt_dma(dev))", changed to if (rxe_dev), then go to call ib_dma_virt_map_alloc.

Only mlx5 and rxe support ODP. While hmm_dma_map_alloc() works fine for mlx5,
it cannot be used for any drivers under drivers/infiniband/sw/ because they all set
dma_device to NULL in ib_register_device().

So changing the condition to if (rxe_dev) makes the code too specific.
To my understanding, it's generally discouraged to add code in the RDMA core
that targets a specific implementation.

I have just realized that we can remove an argument "struct device"
from ib_dma_virt_map_alloc(). I will post the v2 to fix this.

Thanks,
Daisuke

> 
> Yanjun.Zhu
> 
>>
>> Zhu Yanjun
>>
>>> +    return hmm_dma_map_alloc(dev->dma_device, map, nr_entries, dma_entry_size);
>>> +}
>>> +
>>>   /**
>>>    * ib_dma_map_sgtable_attrs - Map a scatter/gather table to DMA addresses
>>>    * @dev: The device for which the DMA addresses are to be created
>>
> 


