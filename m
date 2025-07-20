Return-Path: <linux-rdma+bounces-12324-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8263DB0B4D1
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Jul 2025 12:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2D243B0D6C
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Jul 2025 10:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F101E51EC;
	Sun, 20 Jul 2025 10:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxxmXSJQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F8A1C3F0C;
	Sun, 20 Jul 2025 10:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753006080; cv=none; b=WdCfbXCau2A5a1vZW0V/V4fsgLU9vZLXQKMTX6LJAssynclMcMndWqDuWnCPtdQ++n8MPgtYvPb3wK1MeFhtjcZj4LrergGQG4C0GidfAPBiH2/WoFCOb8sk8v4Fy5ouJ/EKutg1EATGODyKOHk1wDio9uAqrlKow76fuxImZx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753006080; c=relaxed/simple;
	bh=jGuiA3F5M7+pZb7wXV6GpqYCf6FykMW+7fOut1DPcZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WlZEOQq9oVRiC3iMVuzpOE3uRneCTp4q3JYw/3HvSVokV9wZqZhd/kjUuYmw2mD8TaYijZqVqQt+X+ig3720WV7weV6o4xzs/wKPOcAxCNtkarXsv6UD8xLgdCqsIoC2JaelGYlp+x30U4/jhWv7lnoZY7/tJwfJXm7feySJHWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxxmXSJQ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-454f428038eso28526655e9.2;
        Sun, 20 Jul 2025 03:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753006076; x=1753610876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MyOBF0WdA2Il+1cleuddEFHRL9/XxhU271iAXCoM7Gw=;
        b=IxxmXSJQjwf9gjPR0/U2maZQRjOHIIRzpB34FUlpPMUcvAXva4EXG4bhSYqSkqUHM1
         yK37SIgZSfErXhhZIguXnmbGhI+6xlVa2u6AN9mOsA4T/ITI5rF4XRCvv52UT2VEFXBP
         tiwPrmzduLj/LomepSdPjtujWEfodTY58wkBC6E9jCiVZw0b4EA5hTJ8J54m268ZQCof
         Qt7t4TiWduUQmB5+se1RLa6mDlvZaQMEBWUGw51enP1bfe1RlfvdkTk5asLcTFMLDI2i
         WG+KcNsQdUlehf6zUaPoEmgwM0yLiEK6OhOgkOEPuxQKkCvuo4x6dg8g1o86/48k0brC
         gWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753006076; x=1753610876;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MyOBF0WdA2Il+1cleuddEFHRL9/XxhU271iAXCoM7Gw=;
        b=ffImViYe5ratf39oKzlO6qFfBB9N8HsHI8meXtRp2E5qCb5n9G8AuUPFGhrjWmSDC9
         aY/q7G+OGlFijb2aICAIZPWZHyywMOqPB/7+qosjewUGG6401eG8T+Trk35MqrjuYEx2
         r0oyvq794RA2gQdPXKIQSib1vc11xR0XMhOuRoZkPYJiOhqDWx65/04PtqP9d1JUhqmJ
         bonkkWUqKchqeB3fdxUUonMtBf4Fm5wVaVbRkP+0Wa4rUU1om40W/sGxsoN2ovODamJF
         UAHb7sex8DEtUAVwODT/aI1U6ENWq9ti2lrm+cabzfwiiPV4FGdfm5U+QZq77G9+Yg1N
         dDyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKyt/k5XzI0rraCDCossGAaB2XQWqILRGV9tGaYRvx0zvY3f4YsIdGZ5vuMkPU+PTZZstcOSiY@vger.kernel.org, AJvYcCVI6WOYLihcbEgvw+rrVDWyhtYTU3LR96PH9g40n6BqUd2OxlQNtpjMmH/Sk433R7TeojM5j6Ea6kzZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyN++Fl/j5GY7nZ1DtODLog9IKcAm8svgHrXLz5/+tRxVbWPXGr
	aBPotA2bJB7Me6okW51NElFJLGRifjYXLG8flZE8v0o5CVgP7KyeYZLQ
X-Gm-Gg: ASbGnctfpUUvX9Auut+XSckgtlwftkS3vi9LKRbYdXiNtd9FyFPz/1UxJRVG/jApsZN
	KIqBN9sckJH65zdV2P2vn1bP1D85wjfuqZO74creb+2IkYQGnIIUcXIuMo+3bI9LY2l84B4AU7P
	PFcqNT2RjlxQ1FvY2/Semp6d3maSufUmfZx32Pbjl/7W1IoxrgyKQEC2b2Rt085jii8q/4NMPgH
	rzMrKt6oslea75xLiz71lzGqDU/spVVloi+Lcv023dnBAWrE0TUhkgLLxfRT8D9LtZIauWtqRfI
	wCukEJisHkM+00D+YGMmZB0YGwsngcipi2dft8EvzMtHw9uYJm3hauZrCaA3cRV1yfxeRsvqMmL
	w4hqDsLOBM7vgQznGcEnHgYJeM8Dr7l/i/a9AQVtIXyw2LX8=
X-Google-Smtp-Source: AGHT+IHd97Eul0//3HhdRlna1E3Hm1MEBHa87t0OtYvZWOsnuVOFRqxfTAMVTriftYFZkKdbfuuETg==
X-Received: by 2002:a05:600c:45d1:b0:456:1204:e7ec with SMTP id 5b1f17b1804b1-4562e372643mr196485285e9.10.1753006075864;
        Sun, 20 Jul 2025 03:07:55 -0700 (PDT)
Received: from [172.27.57.153] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2c013sm7165481f8f.33.2025.07.20.03.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jul 2025 03:07:55 -0700 (PDT)
Message-ID: <86099d0a-4a21-4854-a426-210caf534c0e@gmail.com>
Date: Sun, 20 Jul 2025 13:07:53 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 rdma-next 1/1] net/mlx5: Fix build -Wframe-larger-than
 warnings
To: Zhu Yanjun <yanjun.zhu@linux.dev>, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <20250711030359.4419-1-yanjun.zhu@linux.dev>
 <00c14908-a7d1-4832-a4bb-2a42dd55e602@linux.dev>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <00c14908-a7d1-4832-a4bb-2a42dd55e602@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18/07/2025 7:19, Zhu Yanjun wrote:
> Gently ping
> 
> Zhu Yanjun
> 
> 在 2025/7/10 20:03, Zhu Yanjun 写道:
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
>> ---
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
>> +    af_desc = kvzalloc(sizeof(*af_desc), GFP_KERNEL);
>> +    if (!af_desc)
>> +        return -ENOMEM;
>> +
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

Thanks for your patch.
You're targeting the wrong branch.

For mlx5_core patches, please target net-next.

