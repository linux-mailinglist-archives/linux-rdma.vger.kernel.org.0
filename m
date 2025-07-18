Return-Path: <linux-rdma+bounces-12289-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FF5B09A7B
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jul 2025 06:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69A573BBD5F
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jul 2025 04:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2250819F13F;
	Fri, 18 Jul 2025 04:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YdmhMfdJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253EC10942
	for <linux-rdma@vger.kernel.org>; Fri, 18 Jul 2025 04:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752812380; cv=none; b=VTyx7ElYXYGaR9cs9VLCWqgVz5qJCbGG421vZWUHbKN0fwZouhZaIQZV2GcYct3p9BozmW0GdzGMXhzkCK5ORqKI65KXJMtNuONB0k/Fjb95o1TvoBrtl8u5aIMgJNm8LO7GvmmqJMlW4m2MjsIKP74Zstwd/8s16tj8LoOskZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752812380; c=relaxed/simple;
	bh=MyoxiHTXx41A/YhteeEMeQgFRlUneVlxGw3R2pA7Eoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JjRnZHMJTAcO+PzHaAgr0Sjh0+k4jtd3CMjt80SYkFHpOK+uWIyhVD4W84sYUNTCkRBAPVMRRqzD5uIfnzkHgVja7Dj76b766bNEWRtCaNmSq33RBYm+OcaIN+8ba0kb+//Y8Z7I/9na+f3yFDdKSiHs+RRczRxlaFIcRDEWF18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YdmhMfdJ; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <00c14908-a7d1-4832-a4bb-2a42dd55e602@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752812375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bEloQbrA9zox8wvU3L8lx2FQrAgJ9PTpTicpkqM4rGk=;
	b=YdmhMfdJaQ4+UPZFct5c3rAFEU88lErww1iq+GqPmzG4F8vfONNu7VWQTo3XJNDA8lKqxY
	ZjY9PTwedV1IqHFxXeSJt56JI1xwVljEweGlqAwjN7Ggy/w8tQUWyTu7X3AaVd2OEGVDdc
	dYGR5wIrLwrsvMk7GV8xImLVTVtSwgo=
Date: Thu, 17 Jul 2025 21:19:18 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv2 rdma-next 1/1] net/mlx5: Fix build -Wframe-larger-than
 warnings
To: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20250711030359.4419-1-yanjun.zhu@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250711030359.4419-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Gently ping

Zhu Yanjun

在 2025/7/10 20:03, Zhu Yanjun 写道:
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
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
> v1 -> v2: Add kvfree to error handler;
> 
> 1. This commit only build tests;
> 2. All the changes are on configuration path, will not make difference
> on the performance;
> 3. This commit is just to fix build warnings, not error or bug fixes. So
> not Fixes tag.
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/eq.c  | 24 +++++++----
>   .../mellanox/mlx5/core/irq_affinity.c         | 19 +++++++--
>   .../net/ethernet/mellanox/mlx5/core/pci_irq.c | 40 +++++++++++++------
>   3 files changed, 60 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> index dfb079e59d85..4938dd7c3a09 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> @@ -873,19 +873,29 @@ static int comp_irq_request_sf(struct mlx5_core_dev *dev, u16 vecidx)
>   {
>   	struct mlx5_irq_pool *pool = mlx5_irq_table_get_comp_irq_pool(dev);
>   	struct mlx5_eq_table *table = dev->priv.eq_table;
> -	struct irq_affinity_desc af_desc = {};
> +	struct irq_affinity_desc *af_desc;
>   	struct mlx5_irq *irq;
>   
> +	af_desc = kvzalloc(sizeof(*af_desc), GFP_KERNEL);
> +	if (!af_desc)
> +		return -ENOMEM;
> +
>   	/* In case SF irq pool does not exist, fallback to the PF irqs*/
> -	if (!mlx5_irq_pool_is_sf_pool(pool))
> +	if (!mlx5_irq_pool_is_sf_pool(pool)) {
> +		kvfree(af_desc);
>   		return comp_irq_request_pci(dev, vecidx);
> +	}
>   
> -	af_desc.is_managed = false;
> -	cpumask_copy(&af_desc.mask, cpu_online_mask);
> -	cpumask_andnot(&af_desc.mask, &af_desc.mask, &table->used_cpus);
> -	irq = mlx5_irq_affinity_request(dev, pool, &af_desc);
> -	if (IS_ERR(irq))
> +	af_desc->is_managed = false;
> +	cpumask_copy(&af_desc->mask, cpu_online_mask);
> +	cpumask_andnot(&af_desc->mask, &af_desc->mask, &table->used_cpus);
> +	irq = mlx5_irq_affinity_request(dev, pool, af_desc);
> +	if (IS_ERR(irq)) {
> +		kvfree(af_desc);
>   		return PTR_ERR(irq);
> +	}
> +
> +	kvfree(af_desc);
>   
>   	cpumask_or(&table->used_cpus, &table->used_cpus, mlx5_irq_get_affinity_mask(irq));
>   	mlx5_core_dbg(pool->dev, "IRQ %u mapped to cpu %*pbl, %u EQs on this irq\n",
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
> index 2691d88cdee1..82d3c2568244 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
> @@ -47,29 +47,40 @@ static int cpu_get_least_loaded(struct mlx5_irq_pool *pool,
>   static struct mlx5_irq *
>   irq_pool_request_irq(struct mlx5_irq_pool *pool, struct irq_affinity_desc *af_desc)
>   {
> -	struct irq_affinity_desc auto_desc = {};
> +	struct irq_affinity_desc *auto_desc;
>   	struct mlx5_irq *irq;
>   	u32 irq_index;
>   	int err;
>   
> +	auto_desc = kvzalloc(sizeof(*auto_desc), GFP_KERNEL);
> +	if (!auto_desc)
> +		return ERR_PTR(-ENOMEM);
> +
>   	err = xa_alloc(&pool->irqs, &irq_index, NULL, pool->xa_num_irqs, GFP_KERNEL);
> -	if (err)
> +	if (err) {
> +		kvfree(auto_desc);
>   		return ERR_PTR(err);
> +	}
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
> index 40024cfa3099..48aad94b0a5d 100644
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
> +	struct irq_affinity_desc *af_desc;
>   	int offset = MLX5_IRQ_VEC_COMP_BASE;
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


