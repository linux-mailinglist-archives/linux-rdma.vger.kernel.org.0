Return-Path: <linux-rdma+bounces-12409-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 115FCB0EA30
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 07:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 215644E57DD
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 05:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F180C2472B5;
	Wed, 23 Jul 2025 05:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IokmkRya"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19564182D3
	for <linux-rdma@vger.kernel.org>; Wed, 23 Jul 2025 05:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753250001; cv=none; b=Jv3yZUTjXMj8466YRVVr5ko9FWqwoQ5vznHgKBrsZZuuRcmqCT403S6F1CGKJN0GsqYrIsR2QrBEcehxcXEkjofsVEmF+WhVJRWyFxzLYR7e7b5Dzdg43cbjVO8DZAapqEzHQGQLY9AdnHJsDp8qBNhuwbS++6enfMdwiqRVD3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753250001; c=relaxed/simple;
	bh=s4+FuOI4siPdnLr5uWM5sWaAVjDBRyXNC3Ep8lfp5RA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mixe+NUWdlDPwVaIxE6b5bghkowUw8J/M57lJn4vla+9A7XUzzEwW4jGEG0xeB/chZ8OUgnWZxiIZ/Qrk6aWN8uDA5f3Z0y3CeKFgkwkPY34k36wKKT5/vouFaXlEZEQ9o1f7Zm+nGGIQOyO4L3Li61KXSADpBV4cuZr/XE8q7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IokmkRya; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a7f7d147-b401-4964-bec5-37786538fe11@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753249997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=76aBVI/j/HBXiHUQ9BAybwDxsNF7a3NeAHh4w+bZ6K8=;
	b=IokmkRyaOhy+vJjnwVK2joIEId1GGFfx/WzJeIKF2/wNVlo/odRIh+XVHLJn5O45+sKX7b
	mhZZZCdzGIMkoE2Z20fFOdYqOGQ5Fw5AccITZA8Hn9fxFPTVaRr0BE0xHxxzilHUHMxH4E
	ZzEuEyAcIQKK7OYYN5867JvPSSeZOMg=
Date: Tue, 22 Jul 2025 22:53:00 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv4 net-next 1/1] net/mlx5: Fix build -Wframe-larger-than
 warnings
To: Tariq Toukan <ttoukan.linux@gmail.com>, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: Junxian Huang <huangjunxian6@hisilicon.com>
References: <20250722031304.32225-1-yanjun.zhu@linux.dev>
 <3fb3a939-4e4c-4fb1-8bb8-d0affe06a92c@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <3fb3a939-4e4c-4fb1-8bb8-d0affe06a92c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/7/22 6:08, Tariq Toukan 写道:
>> +    auto_desc = kvzalloc(sizeof(*auto_desc), GFP_KERNEL);
>> +    if (!auto_desc)
>> +        return ERR_PTR(-ENOMEM);
> 
> Missing xa_erase.

It's a minor oversight. I will address it and resend the patch without 
incrementing the version number.

Zhu Yanjun>
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
>> index 40024cfa3099..692ef9c2f729 100644
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
>>       int offset = MLX5_IRQ_VEC_COMP_BASE;
>> +    struct irq_affinity_desc *af_desc;
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


