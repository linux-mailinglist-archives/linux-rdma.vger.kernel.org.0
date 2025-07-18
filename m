Return-Path: <linux-rdma+bounces-12290-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1293DB09AE7
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jul 2025 07:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B1777B5D2E
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jul 2025 05:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238191DF73C;
	Fri, 18 Jul 2025 05:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C74LoXD8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9EF1C84C0
	for <linux-rdma@vger.kernel.org>; Fri, 18 Jul 2025 05:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752816195; cv=none; b=DO8Qp6vL9c677WAvTlM0HPCtuewFFGAGmM43z+aUNYdIWMC9j1nmzOWaNkNt1KdaHAVG9jbVGRauor3it1kuLnm+nauMVGRNM7kLigFzYVVO6+q/tnJZFnHmqCBqng3csOwpVGD3JJl5zUUZIzG+97hdko5P+zsdtBOJ6BhS6qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752816195; c=relaxed/simple;
	bh=4DJJ/i7QFb1LSTnaBqgu6cNocc9w9pNR6BT8RrdnAVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cCLpZ3J3RTWBaEif65Eno+EVK+0uGc5QjmlLVf3NxtW5H0AECtRFoIOppjDfkAOdN/WZoyw0hLxZdNnd+ZiKANqVkb5w60YZ5vkEAKZ7dfvz/LpCJuYUtxnZRa636TA8qtwXmPhcDyh+DWbifI8CTLGlbC2kxf9ZLRK4+nFOLkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C74LoXD8; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <23477274-08dd-459b-a56b-27004cb5ba46@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752816189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xc+zKbjIyWybav9MJlg4lp+6ghbS95VQM+GMFGD8WUc=;
	b=C74LoXD8GiHY9cR3EyoaNt8fEeUjC/nDCCO96o4YD5oDumktuUYh4xnAdyXsL0LsFhjbpC
	EKAaIJ54RXYOMuw+71zNoLodBcnyY0Vl1Uwd8XkUHPFHqgmbZ1g1F2iudrwNtvJQKLkOgj
	4s1zfi3yEyDm7GX649bPBXkl91x+SHo=
Date: Thu, 17 Jul 2025 22:22:52 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/3] net/mlx5: Allocate cpu_mask on heap to fix
 frame size warning for large NR_CPUS
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shay Drory <shayd@nvidia.com>
References: <1752771792-265762-1-git-send-email-tariqt@nvidia.com>
 <1752771792-265762-3-git-send-email-tariqt@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <1752771792-265762-3-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/7/17 10:03, Tariq Toukan 写道:
> From: Shay Drory <shayd@nvidia.com>
> 
> When NR_CPUS is set to 8192 or higher, the current implementation that
> allocates struct cpu_mask on the stack leads to a compiler warning
> about the frame size[1].
> 
> This patch addresses the issue by moving the allocation of struct
> cpu_mask to the heap.
> 
> [1]
> drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c: In function ‘irq_pool_request_irq’:
> drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c:70:1: warning:
> the frame size of 1048 bytes is larger than 1024 bytes
> [-Wframe-larger-than=]
>     70 | }
>        | ^
> drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c: In function ‘mlx5_ctrl_irq_request’:
> drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c:478:1: warning: the
> frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>    478 | }
>        | ^
> drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c: In function ‘mlx5_irq_request_vector’:
> drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c:597:1: warning: the
> frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>    597 | }
>        | ^
> 
> drivers/net/ethernet/mellanox/mlx5/core/eq.c: In function ‘comp_irq_request_sf’:
> drivers/net/ethernet/mellanox/mlx5/core/eq.c:925:1: warning: the frame
> size of 1064 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>    925 | }
>        | ^
> 
> drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c: In function ‘irq_pool_request_irq’:
> drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c:74:1: warning:
> the frame size of 1048 bytes is larger than 1024 bytes
> [-Wframe-larger-than=]
>     74 | }
>        | ^
> 

https://patchwork.kernel.org/project/linux-rdma/patch/20250711030359.4419-1-yanjun.zhu@linux.dev/

This commit appears to be the same as the one above.
Does the issue addressed in this commit still occur after the previous 
one is applied?

Thanks,
Yanjun.Zhu

> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Reported-by: Arnd Bergmann <arnd@kernel.org>
> Closes: https://lore.kernel.org/all/20250620111010.3364606-1-arnd@kernel.org
> Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/eq.c  | 19 +++++++---
>   .../mellanox/mlx5/core/irq_affinity.c         | 21 ++++++++---
>   .../net/ethernet/mellanox/mlx5/core/pci_irq.c | 37 +++++++++++++------
>   3 files changed, 53 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> index 66dce17219a6..779efc186255 100644
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
>   	/* In case SF irq pool does not exist, fallback to the PF irqs*/
>   	if (!mlx5_irq_pool_is_sf_pool(pool))
>   		return comp_irq_request_pci(dev, vecidx);
>   
> -	af_desc.is_managed = false;
> -	cpumask_copy(&af_desc.mask, cpu_online_mask);
> -	cpumask_andnot(&af_desc.mask, &af_desc.mask, &table->used_cpus);
> -	irq = mlx5_irq_affinity_request(dev, pool, &af_desc);
> -	if (IS_ERR(irq))
> +	af_desc = kzalloc(sizeof(*af_desc), GFP_KERNEL);
> +	if (!af_desc)
> +		return -ENOMEM;
> +
> +	af_desc->is_managed = false;
> +	cpumask_copy(&af_desc->mask, cpu_online_mask);
> +	cpumask_andnot(&af_desc->mask, &af_desc->mask, &table->used_cpus);
> +	irq = mlx5_irq_affinity_request(dev, pool, af_desc);
> +	if (IS_ERR(irq)) {
> +		kfree(af_desc);
>   		return PTR_ERR(irq);
> +	}
>   
>   	cpumask_or(&table->used_cpus, &table->used_cpus, mlx5_irq_get_affinity_mask(irq));
>   	mlx5_core_dbg(pool->dev, "IRQ %u mapped to cpu %*pbl, %u EQs on this irq\n",
> @@ -896,6 +902,7 @@ static int comp_irq_request_sf(struct mlx5_core_dev *dev, u16 vecidx)
>   		      cpumask_pr_args(mlx5_irq_get_affinity_mask(irq)),
>   		      mlx5_irq_read_locked(irq) / MLX5_EQ_REFS_PER_IRQ);
>   
> +	kfree(af_desc);
>   	return xa_err(xa_store(&table->comp_irqs, vecidx, irq, GFP_KERNEL));
>   }
>   
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
> index 2691d88cdee1..d0a845579d33 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
> @@ -47,29 +47,38 @@ static int cpu_get_least_loaded(struct mlx5_irq_pool *pool,
>   static struct mlx5_irq *
>   irq_pool_request_irq(struct mlx5_irq_pool *pool, struct irq_affinity_desc *af_desc)
>   {
> -	struct irq_affinity_desc auto_desc = {};
> +	struct irq_affinity_desc *auto_desc;
>   	struct mlx5_irq *irq;
>   	u32 irq_index;
>   	int err;
>   
> +	auto_desc = kzalloc(sizeof(*auto_desc), GFP_KERNEL);
> +	if (!auto_desc)
> +		return ERR_PTR(-ENOMEM);
> +
>   	err = xa_alloc(&pool->irqs, &irq_index, NULL, pool->xa_num_irqs, GFP_KERNEL);
> -	if (err)
> -		return ERR_PTR(err);
> +	if (err) {
> +		irq = ERR_PTR(err);
> +		goto out;
> +	}
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
>   	irq = mlx5_irq_alloc(pool, irq_index,
> -			     cpumask_empty(&auto_desc.mask) ? af_desc : &auto_desc,
> -			     NULL);
> +			     cpumask_empty(&auto_desc->mask) ?
> +			     af_desc : auto_desc, NULL);
>   	if (IS_ERR(irq))
>   		xa_erase(&pool->irqs, irq_index);
> +
> +out:
> +	kfree(auto_desc);
>   	return irq;
>   }
>   
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> index 40024cfa3099..ac00aa29e61a 100644
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
> +	af_desc = kzalloc(sizeof(*af_desc), GFP_KERNEL);
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
> +			cpumask_set_cpu(cpumask_first(cpu_online_mask),
> +					&af_desc->mask);
>   		}
>   		/* Allocate the IRQ in index 0. The vector was already allocated */
> -		irq = irq_pool_request_vector(pool, 0, &af_desc, NULL);
> +		irq = irq_pool_request_vector(pool, 0, af_desc, NULL);
>   	} else {
> -		irq = mlx5_irq_affinity_request(dev, pool, &af_desc);
> +		irq = mlx5_irq_affinity_request(dev, pool, af_desc);
>   	}
>   
> +	kfree(af_desc);
>   	return irq;
>   }
>   
> @@ -548,16 +554,23 @@ struct mlx5_irq *mlx5_irq_request_vector(struct mlx5_core_dev *dev, u16 cpu,
>   {
>   	struct mlx5_irq_table *table = mlx5_irq_table_get(dev);
>   	struct mlx5_irq_pool *pool = table->pcif_pool;
> -	struct irq_affinity_desc af_desc;
>   	int offset = MLX5_IRQ_VEC_COMP_BASE;
> +	struct irq_affinity_desc *af_desc;
> +	struct mlx5_irq *irq;
> +
> +	af_desc = kzalloc(sizeof(*af_desc), GFP_KERNEL);
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
> +	irq = mlx5_irq_request(dev, vecidx + offset, af_desc, rmap);
> +	kfree(af_desc);
> +	return irq;
>   }
>   
>   static struct mlx5_irq_pool *


