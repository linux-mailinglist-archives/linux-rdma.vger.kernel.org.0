Return-Path: <linux-rdma+bounces-12392-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B754B0DA88
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jul 2025 15:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260A117BBEA
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jul 2025 13:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE2C2E9EC1;
	Tue, 22 Jul 2025 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCJOT+Us"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532472D1F61;
	Tue, 22 Jul 2025 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753189726; cv=none; b=eCE4ogzMCeq1cbuEElHgoWHbf76KUx3NkOgTwoh5Oae1ClprA2O7WbkA3sK0RJ+pufn7yy82wnu99XpbW1ze5zOsT8B1rofZmqFF1KFIGHSlNtlUO298Pw1vCjUiyqi/2wWGt3pG5uGYJ8NpA5w2lpxSfgFDb7XDtIsMaWAo6rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753189726; c=relaxed/simple;
	bh=Yw3gMZ8H8ecMljzqRHEmWRpote+62s8Ps5y5Qru0XrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k35CkmfBtEt4PAyZncJYUPmReDrq0+n6/6fL1l6qtd4Nn3wG4chh/wbykywicRluQR8gRoRKBEgfM3126OlzkTdu8LAHKaS/pOrFDo4nlJk8Xre9qhgsL+TRNK7grlcXlwsXRaHDA8qrUR7yx52HQXQMe7kvvT8Ib1QcK84Ht4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCJOT+Us; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4561a4a8bf2so61042045e9.1;
        Tue, 22 Jul 2025 06:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753189722; x=1753794522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kwz4joFyhlVaDP5hJIfQU8STatgQeHN2CSLbrAnfCT4=;
        b=iCJOT+UsBH7KXYS7Rfb8LhvuMylwRYCOTcYu8ji3jYvYtMuHHK4DATrn6gY0wz+ome
         QVY/DqNAH0eGeCEEwJH8NOTNWysEHXaSwful4V+AEa5Nhg+PAkSzBvL1eSFt946VDz54
         vNYqXk7wjNj2pSade9ol3B8U/6izEgtOje28B/noY5SDQxOCNxeHbWbuMzeO44EvfhQL
         /mXULDVC9GISo8+MvZINezuo2zfHKU6uqhlE+iLuMix8rVxDVDezhxBtxHVAlCJEJWU+
         8h8zgpKST2aG3rAhQKbodrwnan2F9/OOHUN32KrCw3ewmWDkuDHREHrFX024jyNXDqCn
         BZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753189722; x=1753794522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kwz4joFyhlVaDP5hJIfQU8STatgQeHN2CSLbrAnfCT4=;
        b=czNhLu1BcNIP/mijp+dDlvRcPnIulNHD2mKZQcwCEZOjfxXNnZSYIDvGmL/P0GZoke
         esflBbl/7yKIUdr809o2dmbMrvQKa61ceuh4uYWaErwpCiDkd9J5RGMOHlBSBH8lJK7z
         UxMaeynqeyI0UObQ/8c3ODP9xcVL9Vc/CtHm9NMIPE87qRE9QgqwulwGg73oZ/Lye+Xu
         jJ5biXK3ZSpA7NyYsKWVNSrICcPUZsI+jbojwNRf1kj+ty3AElN5vNqh4nMZH761rb2h
         jbi1Tero9HcVFxO42gIkEgMlcmwsSmlBhWfU5HyMuwUtphTadiJ2jS313e7vGyZN+69n
         SHzg==
X-Forwarded-Encrypted: i=1; AJvYcCU0TyKvtCxbwZJojClbCDapaS9Jt4OZl/fm5NRD1iSk3dBGuNV0GpWtk3zieMR3fLkp0OX2p+Td@vger.kernel.org, AJvYcCVr7vETvWhJ+VCNmeUvT39yibu4AXjIZE5Ohf0XHfOPf6LWHbNEn5DzLASRxCoH3uXpXtA4YrUta0HZ@vger.kernel.org
X-Gm-Message-State: AOJu0YySj56MUeKt/s40y8WdFoIAqxgtK4UhCKNzM9yUCHVeJcmmKYAM
	/A3CngC6iQ0Mee5/C3gfQhJjLtjjRgZxmoFirjycF7gHTdyL6xMOD1NP
X-Gm-Gg: ASbGncuhGetOifM4kFNsvT/jufWrkrbndxiTpq1F8lyAXejL0qeRBrfvdb784uMAat1
	8ZUXP5XmnsonuIOEblo7OqovlbeXbcch4ZTNdSx86rAgvPHyvoy4bT18wOvBpFyAVwT9uYljID2
	9HbjbCwP4Q1Rk9sw6WGL4jJVVVNDBGHl9P9x2bo18ApIZVYDplmjDO1LbukqMWJMXpulzV2gQ5L
	vtZv+KMeQj2tmyT158IYLqCdmTwtWTyzzo3gPJzyF3oeXiWsiUDBTJAnvuPdeexvYdPweurOfWO
	fLadEaMRLQvJ3NvfzwJTQ11Kn7zMyfJfe5/UdG+awaadLJ4lBEgI46vtbMhHSbmFbxH1Bvzq3Fj
	fuIygGr/qdyCI4X1mSjp1b/TwFmapG/veq1A+mUr35fquhA==
X-Google-Smtp-Source: AGHT+IFlK//Mr/fL/HWuXhaaQaTpEoI4GsVEUuP88MDoe6jN0XSpYUO2B08jfzWeWx86kWIvaguDew==
X-Received: by 2002:a05:600c:1c10:b0:456:1f09:6846 with SMTP id 5b1f17b1804b1-4562e3771e4mr190817285e9.25.1753189721908;
        Tue, 22 Jul 2025 06:08:41 -0700 (PDT)
Received: from [172.27.60.70] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca487a5sm13412375f8f.42.2025.07.22.06.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 06:08:41 -0700 (PDT)
Message-ID: <3fb3a939-4e4c-4fb1-8bb8-d0affe06a92c@gmail.com>
Date: Tue, 22 Jul 2025 16:08:39 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 net-next 1/1] net/mlx5: Fix build -Wframe-larger-than
 warnings
To: Zhu Yanjun <yanjun.zhu@linux.dev>, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org
Cc: Junxian Huang <huangjunxian6@hisilicon.com>
References: <20250722031304.32225-1-yanjun.zhu@linux.dev>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250722031304.32225-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 22/07/2025 6:13, Zhu Yanjun wrote:
> When building, the following warnings will appear.
> "
> pci_irq.c: In function ‘mlx5_ctrl_irq_request’:
> pci_irq.c:494:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> pci_irq.c: In function ‘mlx5_irq_request_vector’:
> pci_irq.c:561:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> eq.c: In function ‘comp_irq_request_sf’:
> eq.c:897:1: warning: the frame size of 1080 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> irq_affinity.c: In function ‘irq_pool_request_irq’:
> irq_affinity.c:74:1: warning: the frame size of 1048 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> "
> 
> These warnings indicate that the stack frame size exceeds 1024 bytes in
> these functions.
> 
> To resolve this, instead of allocating large memory buffers on the stack,
> it is better to use kvzalloc to allocate memory dynamically on the heap.
> This approach reduces stack usage and eliminates these frame size warnings.
> 
> Acked-by: Junxian Huang <huangjunxian6@hisilicon.com>
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
> v3 -> v4: Relocate the kvzalloc call to a more appropriate place following Tariq's advice.
> v2 -> v3: No changes, just send out target net-next;
> v1 -> v2: Add kvfree to error handler;
> 
> 1. This commit only build tests;
> 2. All the changes are on configuration path, will not make difference
> on the performance;
> 3. This commit is just to fix build warnings, not error or bug fixes. So
> not Fixes tag.
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/eq.c  | 22 ++++++----
>   .../mellanox/mlx5/core/irq_affinity.c         | 15 +++++--
>   .../net/ethernet/mellanox/mlx5/core/pci_irq.c | 40 +++++++++++++------
>   3 files changed, 55 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> index 66dce17219a6..1ab77159409d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> @@ -876,19 +876,25 @@ static int comp_irq_request_sf(struct mlx5_core_dev *dev, u16 vecidx)
>   {
>   	struct mlx5_irq_pool *pool = mlx5_irq_table_get_comp_irq_pool(dev);
>   	struct mlx5_eq_table *table = dev->priv.eq_table;
> -	struct irq_affinity_desc af_desc = {};
> +	struct irq_affinity_desc *af_desc;
>   	struct mlx5_irq *irq;
>   
> -	/* In case SF irq pool does not exist, fallback to the PF irqs*/
> +	/* In case SF irq pool does not exist, fallback to the PF irqs */
>   	if (!mlx5_irq_pool_is_sf_pool(pool))
>   		return comp_irq_request_pci(dev, vecidx);
>   
> -	af_desc.is_managed = false;
> -	cpumask_copy(&af_desc.mask, cpu_online_mask);
> -	cpumask_andnot(&af_desc.mask, &af_desc.mask, &table->used_cpus);
> -	irq = mlx5_irq_affinity_request(dev, pool, &af_desc);
> -	if (IS_ERR(irq))
> +	af_desc = kvzalloc(sizeof(*af_desc), GFP_KERNEL);
> +	if (!af_desc)
> +		return -ENOMEM;
> +
> +	af_desc->is_managed = false;
> +	cpumask_copy(&af_desc->mask, cpu_online_mask);
> +	cpumask_andnot(&af_desc->mask, &af_desc->mask, &table->used_cpus);
> +	irq = mlx5_irq_affinity_request(dev, pool, af_desc);
> +	if (IS_ERR(irq)) {
> +		kvfree(af_desc);
>   		return PTR_ERR(irq);
> +	}
>   
>   	cpumask_or(&table->used_cpus, &table->used_cpus, mlx5_irq_get_affinity_mask(irq));
>   	mlx5_core_dbg(pool->dev, "IRQ %u mapped to cpu %*pbl, %u EQs on this irq\n",
> @@ -896,6 +902,8 @@ static int comp_irq_request_sf(struct mlx5_core_dev *dev, u16 vecidx)
>   		      cpumask_pr_args(mlx5_irq_get_affinity_mask(irq)),
>   		      mlx5_irq_read_locked(irq) / MLX5_EQ_REFS_PER_IRQ);
>   
> +	kvfree(af_desc);
> +
>   	return xa_err(xa_store(&table->comp_irqs, vecidx, irq, GFP_KERNEL));
>   }
>   
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
> index 2691d88cdee1..03a6b86d1444 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
> @@ -47,7 +47,7 @@ static int cpu_get_least_loaded(struct mlx5_irq_pool *pool,
>   static struct mlx5_irq *
>   irq_pool_request_irq(struct mlx5_irq_pool *pool, struct irq_affinity_desc *af_desc)
>   {
> -	struct irq_affinity_desc auto_desc = {};
> +	struct irq_affinity_desc *auto_desc;
>   	struct mlx5_irq *irq;
>   	u32 irq_index;
>   	int err;
> @@ -55,21 +55,30 @@ irq_pool_request_irq(struct mlx5_irq_pool *pool, struct irq_affinity_desc *af_de
>   	err = xa_alloc(&pool->irqs, &irq_index, NULL, pool->xa_num_irqs, GFP_KERNEL);
>   	if (err)
>   		return ERR_PTR(err);
> +
> +	auto_desc = kvzalloc(sizeof(*auto_desc), GFP_KERNEL);
> +	if (!auto_desc)
> +		return ERR_PTR(-ENOMEM);

Missing xa_erase.

> +
>   	if (pool->irqs_per_cpu) {
>   		if (cpumask_weight(&af_desc->mask) > 1)
>   			/* if req_mask contain more then one CPU, set the least loadad CPU
>   			 * of req_mask
>   			 */
>   			cpumask_set_cpu(cpu_get_least_loaded(pool, &af_desc->mask),
> -					&auto_desc.mask);
> +					&auto_desc->mask);
>   		else
>   			cpu_get(pool, cpumask_first(&af_desc->mask));
>   	}
> +
>   	irq = mlx5_irq_alloc(pool, irq_index,
> -			     cpumask_empty(&auto_desc.mask) ? af_desc : &auto_desc,
> +			     cpumask_empty(&auto_desc->mask) ? af_desc : auto_desc,
>   			     NULL);
>   	if (IS_ERR(irq))
>   		xa_erase(&pool->irqs, irq_index);
> +
> +	kvfree(auto_desc);
> +
>   	return irq;
>   }
>   
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> index 40024cfa3099..692ef9c2f729 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> @@ -470,26 +470,32 @@ void mlx5_ctrl_irq_release(struct mlx5_core_dev *dev, struct mlx5_irq *ctrl_irq)
>   struct mlx5_irq *mlx5_ctrl_irq_request(struct mlx5_core_dev *dev)
>   {
>   	struct mlx5_irq_pool *pool = ctrl_irq_pool_get(dev);
> -	struct irq_affinity_desc af_desc;
> +	struct irq_affinity_desc *af_desc;
>   	struct mlx5_irq *irq;
>   
> -	cpumask_copy(&af_desc.mask, cpu_online_mask);
> -	af_desc.is_managed = false;
> +	af_desc = kvzalloc(sizeof(*af_desc), GFP_KERNEL);
> +	if (!af_desc)
> +		return ERR_PTR(-ENOMEM);
> +
> +	cpumask_copy(&af_desc->mask, cpu_online_mask);
> +	af_desc->is_managed = false;
>   	if (!mlx5_irq_pool_is_sf_pool(pool)) {
>   		/* In case we are allocating a control IRQ from a pci device's pool.
>   		 * This can happen also for a SF if the SFs pool is empty.
>   		 */
>   		if (!pool->xa_num_irqs.max) {
> -			cpumask_clear(&af_desc.mask);
> +			cpumask_clear(&af_desc->mask);
>   			/* In case we only have a single IRQ for PF/VF */
> -			cpumask_set_cpu(cpumask_first(cpu_online_mask), &af_desc.mask);
> +			cpumask_set_cpu(cpumask_first(cpu_online_mask), &af_desc->mask);
>   		}
>   		/* Allocate the IRQ in index 0. The vector was already allocated */
> -		irq = irq_pool_request_vector(pool, 0, &af_desc, NULL);
> +		irq = irq_pool_request_vector(pool, 0, af_desc, NULL);
>   	} else {
> -		irq = mlx5_irq_affinity_request(dev, pool, &af_desc);
> +		irq = mlx5_irq_affinity_request(dev, pool, af_desc);
>   	}
>   
> +	kvfree(af_desc);
> +
>   	return irq;
>   }
>   
> @@ -548,16 +554,26 @@ struct mlx5_irq *mlx5_irq_request_vector(struct mlx5_core_dev *dev, u16 cpu,
>   {
>   	struct mlx5_irq_table *table = mlx5_irq_table_get(dev);
>   	struct mlx5_irq_pool *pool = table->pcif_pool;
> -	struct irq_affinity_desc af_desc;
>   	int offset = MLX5_IRQ_VEC_COMP_BASE;
> +	struct irq_affinity_desc *af_desc;
> +	struct mlx5_irq *irq;
> +
> +	af_desc = kvzalloc(sizeof(*af_desc), GFP_KERNEL);
> +	if (!af_desc)
> +		return ERR_PTR(-ENOMEM);
>   
>   	if (!pool->xa_num_irqs.max)
>   		offset = 0;
>   
> -	af_desc.is_managed = false;
> -	cpumask_clear(&af_desc.mask);
> -	cpumask_set_cpu(cpu, &af_desc.mask);
> -	return mlx5_irq_request(dev, vecidx + offset, &af_desc, rmap);
> +	af_desc->is_managed = false;
> +	cpumask_clear(&af_desc->mask);
> +	cpumask_set_cpu(cpu, &af_desc->mask);
> +
> +	irq = mlx5_irq_request(dev, vecidx + offset, af_desc, rmap);
> +
> +	kvfree(af_desc);
> +
> +	return irq;
>   }
>   
>   static struct mlx5_irq_pool *


