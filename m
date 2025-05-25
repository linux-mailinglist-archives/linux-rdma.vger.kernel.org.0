Return-Path: <linux-rdma+bounces-10672-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 130CEAC328E
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 08:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5CBF3A9104
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 06:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5BE1537A7;
	Sun, 25 May 2025 06:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+lyDtZ4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F69B1805B;
	Sun, 25 May 2025 06:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748152993; cv=none; b=tE80ICHQeZhWI4uy5OcPo5TI+FmFdYZxb85MaUET0vo/XxN4+gRTIXc741da/nADoWTdgDyqpd8nfMzVflT7LBnY2npVxoFyDHspDlSs/ZQskPUdPIO/dSmRs5UxMknuP8DwCjTkG/NxdUt4Qod+rSNKBw/gc+OuPmt8yTrViZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748152993; c=relaxed/simple;
	bh=DgVw/STSCSQ8BUTYHfgGgfYqeIInYciC6jnAaezwkDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JeQse5W/RzylLPYSR0AMBl8HhlYrr+C3Pxgm44hWorlhATIKzd7hbzTv5uXmZE64xrScPTPdr3C2W4ADx3mFDVev6CC3vfYIq4ioONt0VrdWiJqrzzdRvfOysicQtz/o/Xkj3KnhL3hMqtEXwm7+NOx53DEjTaBc3lcldXpXb0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+lyDtZ4; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-31133c5add7so336240a91.0;
        Sat, 24 May 2025 23:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748152990; x=1748757790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gwHKu6gQHgNhrle/vb/19Syza1S76WfU28p88BMrqJM=;
        b=i+lyDtZ4Era59wCYGE8IWDCYsZXdtfUoIUzVe95tTw0kF/cV2xu/tE3Ua9qSHGobnW
         rFrnYsZNIRAQaz9GhXo4LQpFCMB+s5eZ797/Xcn2rRUYBCXt2UNkD8iUVA3R1lt3l4II
         ETNvDm4LjvvKTP5Rj2FlDCamhSmte3ZmrqX6svuow1YGr3fzUFgmXp0rAXTPPhHcBPy/
         5JGUjFqbVp5774BrJZ4YT28tpMTNOZ6pSR5BrFX/c+wqJP/JVZz/eIX0QAmYxlo5NfuC
         mH6BlN28AbOY7gAo5hHKghzaW3F/j3Bc/PFm90VW8ZHoq0Xjbm6ntGt5aGWMAthl1XNY
         h3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748152990; x=1748757790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gwHKu6gQHgNhrle/vb/19Syza1S76WfU28p88BMrqJM=;
        b=XqIOE/aLxtfbJtunxgp/hD7Hh1H2Ir5nlKHjLdx9iIfUtdAW7Jye9e86/IzoWZuRsF
         oYXuOCxNf7q4RvmNtc10AaloOfCHTSUuSiVk+6pb8qwnDPl9pZNmbzq4stbTXfcdwpn+
         xFjqjGKKwv71aOVVScZ2IBuv++sI2AtGb+MTvqRuiqVLfE37v+xF+Ge9ScoFL1v+SlJJ
         QJ9S+Fm3vy99XWLx9KjJ7CydtPMRiXav297r0NQ4JQ0NddouyX2N7f4UCkwpH/nNVY07
         5OqrpEYXGibwEFbqlFNDF3VTH8mCHniLLyK2OEZrEihZwtR4rGlqZFHoEUPU+NCrsbyL
         PxIg==
X-Forwarded-Encrypted: i=1; AJvYcCX8Pox2JtnrT93f3hNLQXuJ6fjPM9jNpdvyRiuavQv6fCmmSUDiqY6ElB0LkFQyKpZAqoliMxGHrjHK6Gg=@vger.kernel.org, AJvYcCXjsTCEC7q8LUo4aRxYUs9+k25TwTJcB1KNJjwPFdJ9m1Lt8DJCAEjxMSPzsQnyUsTkaoFq9LBhogLbPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhFxEJKBmwYF9aP3mwQEykx64nvQ4c+vwvlPlPulcCZ4ZyAVi/
	8qFsNef2CRppeTv279M+vl5P3gViAFeFmpqy/juQzmZtDetqODO8rMF6
X-Gm-Gg: ASbGncsAS4Cz4U9i0+1BUfTbTrzlgbahqVdnSxbC1MdMC+ZlaguKZNpRopU3lamK6f9
	aeYMUn/gPGJOTEPgAPSkTD3rOslQe66AvHSpP6MSIJrGS4eMwRppFqWxdkFfrpIpNWXFvWHEFGK
	MY04UNhaP2HEQnqcVWjbDxy7kyjj19ubul8I6R+XWM3mrjACQpw/l9M2jHx382uFZ0x+fnfA7sO
	093r1VPVWikb3ZKnhydJP0d4BYQVNVFk0zkRgdscza1+XpEIwwbDoL2UMfUrWE1l/XBEHyYyRSM
	bUysmwzk8zH0KCzqzunYQeUxLvT/qEQeLXlNOb/hJchbu0VsmCXg37QH3A3Xb2hw6ObcL3Mflnu
	XsgVdV5ve2ipTX8IZdKTfnhvGvB4=
X-Google-Smtp-Source: AGHT+IGjvXibgVEY9eW9T+uPXo1nz7ElbDYUuM13tZ50QP5MshIH2BxHQQuDnJNM0Ds3OCFDYTgF8A==
X-Received: by 2002:a17:90b:3c90:b0:2ef:31a9:95c6 with SMTP id 98e67ed59e1d1-3110f30f0d6mr9475196a91.14.1748152990279;
        Sat, 24 May 2025 23:03:10 -0700 (PDT)
Received: from [192.168.11.2] (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-310cec3f320sm5482823a91.9.2025.05.24.23.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 May 2025 23:03:09 -0700 (PDT)
Message-ID: <b10304c8-c951-4ade-ad57-515df6bd4221@gmail.com>
Date: Sun, 25 May 2025 15:03:07 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3] RDMA/core: Avoid hmm_dma_map_alloc() for
 virtual DMA devices
To: Zhu Yanjun <yanjun.zhu@linux.dev>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
 zyjzyj2000@gmail.com
Cc: hch@infradead.org
References: <20250524144328.4361-1-dskmtsd@gmail.com>
 <c8d6bfb6-570c-48b2-be62-188e11353c5a@linux.dev>
Content-Language: en-US
From: Daisuke Matsuda <dskmtsd@gmail.com>
In-Reply-To: <c8d6bfb6-570c-48b2-be62-188e11353c5a@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/05/25 14:22, Zhu Yanjun wrote:
> 在 2025/5/24 16:43, Daisuke Matsuda 写道:
>> Drivers such as rxe, which use virtual DMA, must not call into the DMA
>> mapping core since they lack physical DMA capabilities. Otherwise, a NULL
>> pointer dereference is observed as shown below. This patch ensures the RDMA
>> core handles virtual and physical DMA paths appropriately.
>>
>> This fixes the following kernel oops:
>>
>>   BUG: kernel NULL pointer dereference, address: 00000000000002fc
>>   #PF: supervisor read access in kernel mode
>>   #PF: error_code(0x0000) - not-present page
>>   PGD 1028eb067 P4D 1028eb067 PUD 105da0067 PMD 0
>>   Oops: Oops: 0000 [#1] SMP NOPTI
>>   CPU: 3 UID: 1000 PID: 1854 Comm: python3 Tainted: G        W           6.15.0-rc1+ #11 PREEMPT(voluntary)
>>   Tainted: [W]=WARN
>>   Hardware name: Trigkey Key N/Key N, BIOS KEYN101 09/02/2024
>>   RIP: 0010:hmm_dma_map_alloc+0x25/0x100
>>   Code: 90 90 90 90 90 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 49 89 d6 49 c1 e6 0c 41 55 41 54 53 49 39 ce 0f 82 c6 00 00 00 49 89 fc <f6> 87 fc 02 00 00 20 0f 84 af 00 00 00 49 89 f5 48 89 d3 49 89 cf
>>   RSP: 0018:ffffd3d3420eb830 EFLAGS: 00010246
>>   RAX: 0000000000001000 RBX: ffff8b727c7f7400 RCX: 0000000000001000
>>   RDX: 0000000000000001 RSI: ffff8b727c7f74b0 RDI: 0000000000000000
>>   RBP: ffffd3d3420eb858 R08: 0000000000000000 R09: 0000000000000000
>>   R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>>   R13: 00007262a622a000 R14: 0000000000001000 R15: ffff8b727c7f74b0
>>   FS:  00007262a62a1080(0000) GS:ffff8b762ac3e000(0000) knlGS:0000000000000000
>>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>   CR2: 00000000000002fc CR3: 000000010a1f0004 CR4: 0000000000f72ef0
>>   PKRU: 55555554
>>   Call Trace:
>>    <TASK>
>>    ib_init_umem_odp+0xb6/0x110 [ib_uverbs]
>>    ib_umem_odp_get+0xf0/0x150 [ib_uverbs]
>>    rxe_odp_mr_init_user+0x71/0x170 [rdma_rxe]
>>    rxe_reg_user_mr+0x217/0x2e0 [rdma_rxe]
>>    ib_uverbs_reg_mr+0x19e/0x2e0 [ib_uverbs]
>>    ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0xd9/0x150 [ib_uverbs]
>>    ib_uverbs_cmd_verbs+0xd19/0xee0 [ib_uverbs]
>>    ? mmap_region+0x63/0xd0
>>    ? __pfx_ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x10/0x10 [ib_uverbs]
>>    ib_uverbs_ioctl+0xba/0x130 [ib_uverbs]
>>    __x64_sys_ioctl+0xa4/0xe0
>>    x64_sys_call+0x1178/0x2660
>>    do_syscall_64+0x7e/0x170
>>    ? syscall_exit_to_user_mode+0x4e/0x250
>>    ? do_syscall_64+0x8a/0x170
>>    ? do_syscall_64+0x8a/0x170
>>    ? syscall_exit_to_user_mode+0x4e/0x250
>>    ? do_syscall_64+0x8a/0x170
>>    ? syscall_exit_to_user_mode+0x4e/0x250
>>    ? do_syscall_64+0x8a/0x170
>>    ? do_user_addr_fault+0x1d2/0x8d0
>>    ? irqentry_exit_to_user_mode+0x43/0x250
>>    ? irqentry_exit+0x43/0x50
>>    ? exc_page_fault+0x93/0x1d0
>>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>   RIP: 0033:0x7262a6124ded
>>   Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
>>   RSP: 002b:00007fffd08c3960 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>>   RAX: ffffffffffffffda RBX: 00007fffd08c39f0 RCX: 00007262a6124ded
>>   RDX: 00007fffd08c3a10 RSI: 00000000c0181b01 RDI: 0000000000000007
>>   RBP: 00007fffd08c39b0 R08: 0000000014107820 R09: 00007fffd08c3b44
>>   R10: 000000000000000c R11: 0000000000000246 R12: 00007fffd08c3b44
>>   R13: 000000000000000c R14: 00007fffd08c3b58 R15: 0000000014107960
>>    </TASK>
>>
>> Fixes: 1efe8c0670d6 ("RDMA/core: Convert UMEM ODP DMA mapping to caching IOVA and page linkage")
>> Closes: https://lore.kernel.org/all/3e8f343f-7d66-4f7a-9f08-3910623e322f@gmail.com/
>> Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
> 
> I tried to apply this commit to the following rdma branch.
> But I failed. The error is as below:
> 
> "
> Applying: RDMA/core: Avoid hmm_dma_map_alloc() for virtual DMA devices
> error: patch failed: drivers/infiniband/core/umem_odp.c:75
> error: drivers/infiniband/core/umem_odp.c: patch does not apply
> Patch failed at 0001 RDMA/core: Avoid hmm_dma_map_alloc() for virtual DMA devices
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> 
> "
> 
> The remote branch is remotes/rdma/rdma-next
> The head commit is 3b6a1e410c7f RDMA/mlx5: Fix CC counters query for MPV
> 
> I am not sure if I use the correct repository and branch or not.

Thank you for trying the patch.

The change is meant to be applied to 'for-next' branch,
which contains patches from the following series:
[PATCH v10 00/24] Provide a new two step DMA mapping API
https://lore.kernel.org/linux-rdma/cover.1745831017.git.leon@kernel.org/

cf. https://kernel.googlesource.com/pub/scm/linux/kernel/git/rdma/rdma/

Thanks,
Daisuke

> 
> Best Regards,
> Zhu Yanjun
> 
>> ---
>>   drivers/infiniband/core/device.c   | 17 +++++++++++++++++
>>   drivers/infiniband/core/umem_odp.c | 11 ++++++++---
>>   include/rdma/ib_verbs.h            |  4 ++++
>>   3 files changed, 29 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
>> index b4e3e4beb7f4..abb8fed292c0 100644
>> --- a/drivers/infiniband/core/device.c
>> +++ b/drivers/infiniband/core/device.c
>> @@ -2864,6 +2864,23 @@ int ib_dma_virt_map_sg(struct ib_device *dev, struct scatterlist *sg, int nents)
>>       return nents;
>>   }
>>   EXPORT_SYMBOL(ib_dma_virt_map_sg);
>> +int ib_dma_virt_map_alloc(struct hmm_dma_map *map, size_t nr_entries,
>> +              size_t dma_entry_size)
>> +{
>> +    if (!(nr_entries * PAGE_SIZE / dma_entry_size))
>> +        return -EINVAL;
>> +
>> +    map->dma_entry_size = dma_entry_size;
>> +    map->pfn_list = kvcalloc(nr_entries, sizeof(*map->pfn_list),
>> +                 GFP_KERNEL | __GFP_NOWARN);
>> +    if (!map->pfn_list)
>> +        return -ENOMEM;
>> +
>> +    map->dma_list = NULL;
>> +
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL(ib_dma_virt_map_alloc);
>>   #endif /* CONFIG_INFINIBAND_VIRT_DMA */
>>   static const struct rdma_nl_cbs ibnl_ls_cb_table[RDMA_NL_LS_NUM_OPS] = {
>> diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
>> index 51d518989914..a5b17be0894a 100644
>> --- a/drivers/infiniband/core/umem_odp.c
>> +++ b/drivers/infiniband/core/umem_odp.c
>> @@ -75,9 +75,14 @@ static int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
>>       if (unlikely(end < page_size))
>>           return -EOVERFLOW;
>> -    ret = hmm_dma_map_alloc(dev->dma_device, &umem_odp->map,
>> -                (end - start) >> PAGE_SHIFT,
>> -                1 << umem_odp->page_shift);
>> +    if (ib_uses_virt_dma(dev))
>> +        ret = ib_dma_virt_map_alloc(&umem_odp->map,
>> +                        (end - start) >> PAGE_SHIFT,
>> +                        1 << umem_odp->page_shift);
>> +    else
>> +        ret = hmm_dma_map_alloc(dev->dma_device, &umem_odp->map,
>> +                    (end - start) >> PAGE_SHIFT,
>> +                    1 << umem_odp->page_shift);
>>       if (ret)
>>           return ret;
>> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
>> index b06a0ed81bdd..9ea41f288736 100644
>> --- a/include/rdma/ib_verbs.h
>> +++ b/include/rdma/ib_verbs.h
>> @@ -36,6 +36,7 @@
>>   #include <linux/irqflags.h>
>>   #include <linux/preempt.h>
>>   #include <linux/dim.h>
>> +#include <linux/hmm-dma.h>
>>   #include <uapi/rdma/ib_user_verbs.h>
>>   #include <rdma/rdma_counter.h>
>>   #include <rdma/restrack.h>
>> @@ -4221,6 +4222,9 @@ static inline void ib_dma_unmap_sg_attrs(struct ib_device *dev,
>>                      dma_attrs);
>>   }
>> +int ib_dma_virt_map_alloc(struct hmm_dma_map *map, size_t nr_entries,
>> +              size_t dma_entry_size);
>> +
>>   /**
>>    * ib_dma_map_sgtable_attrs - Map a scatter/gather table to DMA addresses
>>    * @dev: The device for which the DMA addresses are to be created
> 


