Return-Path: <linux-rdma+bounces-12351-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 079DDB0BCCA
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 08:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12B997A414C
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 06:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDEB27FB2E;
	Mon, 21 Jul 2025 06:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9NUT0Hp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D4227E05F;
	Mon, 21 Jul 2025 06:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753079836; cv=none; b=qbdlePAklYsS5PErlcTYUO2e+lIj3TjjdtryRr2w38C09Wb084LArq6C2joBgl8erivFnV2BL6f4K13SB6pPUf2PHUW9izbVA0PScsb+jyIG4cCi05tePXpFfn6EOoqx16Rq//6SqsDNW1nk1V3kmEEO0crT39BrfyC1woHaH44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753079836; c=relaxed/simple;
	bh=6JHqbgSymbDH3c6jE1m6mbPu/7G8iSkWEUY3vi510Xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UB/RBAYc87b91C+7Q34G+nDywpGFiXn98D6WPI/U9IF4kpNRdkkla05490+T9jGpKMK8+AiF51WENI80M/qYNoxp5BOPaHgSX97wAuaIdfypIEsOZrrBPYVs4aojmHiw9qDK5pZx1ocMrTdDLnhON0msMl2D6Uap69fVOgmKA30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9NUT0Hp; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45619d70c72so37316465e9.0;
        Sun, 20 Jul 2025 23:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753079832; x=1753684632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sXTNOF4KFV28cQXMK1Lk7BerkO9mexqmD/nfJUgjfjU=;
        b=c9NUT0HpCcVCw18uYmdZqcVADLkXjlssdhQu+aFcs5nCJLSPGv7GXNXsZKOwWAte3O
         86bG/X8QRdlceHG7UlMIjGQ5Wm5LTD3o22VdT8OtkLsmDkru4Qh5Ir8JWb2vFw8BWqg2
         QHK63J2n+GtC9Kn/11N8AV5D+4YGdXH/E1kryTI0TgeEcK2GA98ewT7tQ1ymiJyQ8WiD
         nU7NevWCgE8vp9twdU0SQMHPw9yzc5sVex4+Y/Trol1+TulxLRA/q7EMM6aeqCvzX6T+
         vF1sMd4KyMyYLd2LZJszOlagKZH08qWYGlHHBJN6Md4QwBqW39dl/w1x47LRJjtttLxc
         p57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753079832; x=1753684632;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sXTNOF4KFV28cQXMK1Lk7BerkO9mexqmD/nfJUgjfjU=;
        b=MSjQsVcdFBaR+3/zvE1RshRn/rLF/gbY0Xkfs1t1wpFcfsK/+m6DknTyx2XAXkvFjD
         8vPyaTFM72RPsHcVhDJDyTXhjnUeMiY7Yasxg1SKYBATWgtDWfzFHWwMBRQOX8YnUF/d
         CqnfGS7k0ulLMD12RMpAzx7m4MZ7kkNep/xrqKAhn6822+wQTw5dJMqeC8Rdr3RWeESB
         jQV/xtO2phmIkNu6Zd9scejOYEG5DJXpFXE1cXeHF5YTAyWSTSuW7aqIAd/v4rNrAViy
         Nu1w7uGxRe5qgh2V1LX/M/PpEUkB19Q4E6g6Ch2XF5HQJtpFPuMunkBZ/nQvc9fkz7Z7
         Dmew==
X-Forwarded-Encrypted: i=1; AJvYcCUaoKNyBGvYyBfiqJGAd0SF5CuPfD1msyEi/bSCsigvofbzOhBXMb7vZz/VXZlMx6GwUZT9UJsx@vger.kernel.org, AJvYcCXIxynnf1DJmx21BluVgj2W9cbieWy2UHkGUAJ9pA/Y+xc9ShlRcLSJ+cEoOiNNPwVRxpRyqHd0wn6p@vger.kernel.org
X-Gm-Message-State: AOJu0YzGj626p6HSsfPyoTDFCigkYvTMT2R85djieIF3DRZq3DX3jSU4
	VoAomZLVQKWpdPhm5be3kDFeocGr/TG+iNe6fv/iYw6FmcSzMcrN2c9y
X-Gm-Gg: ASbGncuDH6bBkzTEq2FbWDuP5J59SWAvoMnMMJVNN97M0epgPVffwSkdF54rsD7QsbY
	ly3AWl1QXHy8idrAc/n3FKrHMQPCHUjHskpnQspSiMDMVVoM5H5SVruOI09BKQ3VlrQRBh2l5Wb
	wTM6/7K+EqHgCLrIRUD8RMgLOTt6cpPx4SkiPIo0fcBGcWoMHGyrYh3ZtsmEo0a+/KJx19F+UXH
	FHFopekDILD57Ymuoket2mz/WNW/3m9NjDxbGNZoDMemYeDiYU4DFUUDIzqnkca8xkFmB6+iP0J
	ztZSvy93VeHIbnuBa3/UDoopqMJqxNQFZQH+yFL19+igHrkA0OSI1B9bKppQyhhT/6Q/Vo73x+4
	lBrCAL9z0W1GOAlDkFapQQhnELEwn8dNQ/XP1mGvn2oM=
X-Google-Smtp-Source: AGHT+IFmOdeTCHtfdxB8X2g9F2gbLY8T0s52TuQSTwrB17PwpyjaQjAq0Llqep9eVUrKW8Yw9vHa5Q==
X-Received: by 2002:a05:600c:8216:b0:456:ed3:a488 with SMTP id 5b1f17b1804b1-45637a7679bmr143787205e9.1.1753079831242;
        Sun, 20 Jul 2025 23:37:11 -0700 (PDT)
Received: from [10.80.3.86] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca25437sm9190734f8f.10.2025.07.20.23.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jul 2025 23:37:10 -0700 (PDT)
Message-ID: <8aa75912-d1e3-4865-a723-ae1517e9322c@gmail.com>
Date: Mon, 21 Jul 2025 09:37:09 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 next-next 1/1] net/mlx5: Fix build -Wframe-larger-than
 warnings
To: Zhu Yanjun <yanjun.zhu@linux.dev>, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <20250720160849.508014-1-yanjun.zhu@linux.dev>
 <48c13c2c-56f2-42f7-9a03-d5bdfd8e8dfb@linux.dev>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <48c13c2c-56f2-42f7-9a03-d5bdfd8e8dfb@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 21/07/2025 1:41, Zhu Yanjun wrote:
> 在 2025/7/20 9:08, Zhu Yanjun 写道:
>> When building, the following warnings will appear.
>> "
>> pci_irq.c: In function ‘mlx5_ctrl_irq_request’:
>> pci_irq.c:494:1: warning: the frame size of 1040 bytes is larger than 
>> 1024 bytes [-Wframe-larger-than=]
>>
>> pci_irq.c: In function ‘mlx5_irq_request_vector’:
>> pci_irq.c:561:1: warning: the frame size of 1040 bytes is larger than 
>> 1024 bytes [-Wframe-larger-than=]
>>
>> eq.c: In function ‘comp_irq_request_sf’:
>> eq.c:897:1: warning: the frame size of 1080 bytes is larger than 1024 
>> bytes [-Wframe-larger-than=]
>>
>> irq_affinity.c: In function ‘irq_pool_request_irq’:
>> irq_affinity.c:74:1: warning: the frame size of 1048 bytes is larger 
>> than 1024 bytes [-Wframe-larger-than=]
>> "
>>
>> These warnings indicate that the stack frame size exceeds 1024 bytes in
>> these functions.
>>
>> To resolve this, instead of allocating large memory buffers on the stack,
>> it is better to use kvzalloc to allocate memory dynamically on the heap.
>> This approach reduces stack usage and eliminates these frame size 
>> warnings.
>>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Sorry. Missing the following Acked-by.
> 
> Acked-by: Junxian Huang <huangjunxian6@hisilicon.com>
> 
> Zhu Yanjun
> 
>> ---
>> v2 -> v3: No changes, just send out target net-next;

You wrote next-next by mistake.

>> v1 -> v2: Add kvfree to error handler;
>>
>> 1. This commit only build tests;
>> 2. All the changes are on configuration path, will not make difference
>> on the performance;
>> 3. This commit is just to fix build warnings, not error or bug fixes. So
>> not Fixes tag.
>> ---
>>   drivers/net/ethernet/mellanox/mlx5/core/eq.c  | 24 +++++++----
>>   .../mellanox/mlx5/core/irq_affinity.c         | 19 +++++++--
>>   .../net/ethernet/mellanox/mlx5/core/pci_irq.c | 40 +++++++++++++------
>>   3 files changed, 60 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/ 
>> net/ethernet/mellanox/mlx5/core/eq.c
>> index dfb079e59d85..4938dd7c3a09 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
>> @@ -873,19 +873,29 @@ static int comp_irq_request_sf(struct 
>> mlx5_core_dev *dev, u16 vecidx)
>>   {
>>       struct mlx5_irq_pool *pool = mlx5_irq_table_get_comp_irq_pool(dev);
>>       struct mlx5_eq_table *table = dev->priv.eq_table;
>> -    struct irq_affinity_desc af_desc = {};
>> +    struct irq_affinity_desc *af_desc;
>>       struct mlx5_irq *irq;

Keep an empty line.

>> +    af_desc = kvzalloc(sizeof(*af_desc), GFP_KERNEL);
>> +    if (!af_desc)
>> +        return -ENOMEM;
>> +

Better move the alloc after the early-return block 
(mlx5_irq_pool_is_sf_pool).

>>       /* In case SF irq pool does not exist, fallback to the PF irqs*/
>> -    if (!mlx5_irq_pool_is_sf_pool(pool))
>> +    if (!mlx5_irq_pool_is_sf_pool(pool)) {
>> +        kvfree(af_desc);
>>           return comp_irq_request_pci(dev, vecidx);
>> +    }
>> -    af_desc.is_managed = false;
>> -    cpumask_copy(&af_desc.mask, cpu_online_mask);
>> -    cpumask_andnot(&af_desc.mask, &af_desc.mask, &table->used_cpus);
>> -    irq = mlx5_irq_affinity_request(dev, pool, &af_desc);
>> -    if (IS_ERR(irq))
>> +    af_desc->is_managed = false;
>> +    cpumask_copy(&af_desc->mask, cpu_online_mask);
>> +    cpumask_andnot(&af_desc->mask, &af_desc->mask, &table->used_cpus);
>> +    irq = mlx5_irq_affinity_request(dev, pool, af_desc);
>> +    if (IS_ERR(irq)) {
>> +        kvfree(af_desc);
>>           return PTR_ERR(irq);
>> +    }
>> +
>> +    kvfree(af_desc);

I would free it only before return.

>>       cpumask_or(&table->used_cpus, &table->used_cpus, 
>> mlx5_irq_get_affinity_mask(irq));
>>       mlx5_core_dbg(pool->dev, "IRQ %u mapped to cpu %*pbl, %u EQs on 
>> this irq\n",
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c b/ 
>> drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
>> index 2691d88cdee1..82d3c2568244 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
>> @@ -47,29 +47,40 @@ static int cpu_get_least_loaded(struct 
>> mlx5_irq_pool *pool,
>>   static struct mlx5_irq *
>>   irq_pool_request_irq(struct mlx5_irq_pool *pool, struct 
>> irq_affinity_desc *af_desc)
>>   {
>> -    struct irq_affinity_desc auto_desc = {};
>> +    struct irq_affinity_desc *auto_desc;
>>       struct mlx5_irq *irq;
>>       u32 irq_index;
>>       int err;
>> +    auto_desc = kvzalloc(sizeof(*auto_desc), GFP_KERNEL);
>> +    if (!auto_desc)
>> +        return ERR_PTR(-ENOMEM);
>> +
>>       err = xa_alloc(&pool->irqs, &irq_index, NULL, pool->xa_num_irqs, 
>> GFP_KERNEL);
>> -    if (err)
>> +    if (err) {
>> +        kvfree(auto_desc);
>>           return ERR_PTR(err);
>> +    }
>> +
>>       if (pool->irqs_per_cpu) {
>>           if (cpumask_weight(&af_desc->mask) > 1)
>>               /* if req_mask contain more then one CPU, set the least 
>> loadad CPU
>>                * of req_mask
>>                */
>>               cpumask_set_cpu(cpu_get_least_loaded(pool, &af_desc->mask),
>> -                    &auto_desc.mask);
>> +                    &auto_desc->mask);
>>           else
>>               cpu_get(pool, cpumask_first(&af_desc->mask));
>>       }
>> +
>>       irq = mlx5_irq_alloc(pool, irq_index,
>> -                 cpumask_empty(&auto_desc.mask) ? af_desc : &auto_desc,
>> +                 cpumask_empty(&auto_desc->mask) ? af_desc : auto_desc,
>>                    NULL);
>>       if (IS_ERR(irq))
>>           xa_erase(&pool->irqs, irq_index);
>> +
>> +    kvfree(auto_desc);
>> +
>>       return irq;
>>   }
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/ 
>> drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
>> index 40024cfa3099..48aad94b0a5d 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
>> @@ -470,26 +470,32 @@ void mlx5_ctrl_irq_release(struct mlx5_core_dev 
>> *dev, struct mlx5_irq *ctrl_irq)
>>   struct mlx5_irq *mlx5_ctrl_irq_request(struct mlx5_core_dev *dev)
>>   {
>>       struct mlx5_irq_pool *pool = ctrl_irq_pool_get(dev);
>> -    struct irq_affinity_desc af_desc;
>> +    struct irq_affinity_desc *af_desc;
>>       struct mlx5_irq *irq;
>> -    cpumask_copy(&af_desc.mask, cpu_online_mask);
>> -    af_desc.is_managed = false;
>> +    af_desc = kvzalloc(sizeof(*af_desc), GFP_KERNEL);
>> +    if (!af_desc)
>> +        return ERR_PTR(-ENOMEM);
>> +
>> +    cpumask_copy(&af_desc->mask, cpu_online_mask);
>> +    af_desc->is_managed = false;
>>       if (!mlx5_irq_pool_is_sf_pool(pool)) {
>>           /* In case we are allocating a control IRQ from a pci 
>> device's pool.
>>            * This can happen also for a SF if the SFs pool is empty.
>>            */
>>           if (!pool->xa_num_irqs.max) {
>> -            cpumask_clear(&af_desc.mask);
>> +            cpumask_clear(&af_desc->mask);
>>               /* In case we only have a single IRQ for PF/VF */
>> -            cpumask_set_cpu(cpumask_first(cpu_online_mask), 
>> &af_desc.mask);
>> +            cpumask_set_cpu(cpumask_first(cpu_online_mask), &af_desc- 
>> >mask);
>>           }
>>           /* Allocate the IRQ in index 0. The vector was already 
>> allocated */
>> -        irq = irq_pool_request_vector(pool, 0, &af_desc, NULL);
>> +        irq = irq_pool_request_vector(pool, 0, af_desc, NULL);
>>       } else {
>> -        irq = mlx5_irq_affinity_request(dev, pool, &af_desc);
>> +        irq = mlx5_irq_affinity_request(dev, pool, af_desc);
>>       }
>> +    kvfree(af_desc);
>> +
>>       return irq;
>>   }
>> @@ -548,16 +554,26 @@ struct mlx5_irq *mlx5_irq_request_vector(struct 
>> mlx5_core_dev *dev, u16 cpu,
>>   {
>>       struct mlx5_irq_table *table = mlx5_irq_table_get(dev);
>>       struct mlx5_irq_pool *pool = table->pcif_pool;
>> -    struct irq_affinity_desc af_desc;
>> +    struct irq_affinity_desc *af_desc;

While here, fix broken RCT.

>>       int offset = MLX5_IRQ_VEC_COMP_BASE;
>> +    struct mlx5_irq *irq;
>> +
>> +    af_desc = kvzalloc(sizeof(*af_desc), GFP_KERNEL);
>> +    if (!af_desc)
>> +        return ERR_PTR(-ENOMEM);
>>       if (!pool->xa_num_irqs.max)
>>           offset = 0;
>> -    af_desc.is_managed = false;
>> -    cpumask_clear(&af_desc.mask);
>> -    cpumask_set_cpu(cpu, &af_desc.mask);
>> -    return mlx5_irq_request(dev, vecidx + offset, &af_desc, rmap);
>> +    af_desc->is_managed = false;
>> +    cpumask_clear(&af_desc->mask);
>> +    cpumask_set_cpu(cpu, &af_desc->mask);
>> +
>> +    irq = mlx5_irq_request(dev, vecidx + offset, af_desc, rmap);
>> +
>> +    kvfree(af_desc);
>> +
>> +    return irq;
>>   }
>>   static struct mlx5_irq_pool *
> 
> 


