Return-Path: <linux-rdma+bounces-12014-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51641AFF812
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 06:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038B24E7BD9
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 04:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A271D283C9C;
	Thu, 10 Jul 2025 04:28:43 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D203218ADD;
	Thu, 10 Jul 2025 04:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752121723; cv=none; b=MBWWhGUYq+5gkjwyYDtuF2zI4PFJ4uEqcXDx+BioMEJpjiWNiIriwEtohfEovf6nmLImG/g4KpOz8ySAIT0Bi8R/CZxW463BfdKWUFEIVRTFBnPyBfpW7zBYaFDTtqQXwcH1iGGZZQUAxIYyVwstx8Ybiy3Ts/jqtj+jk/zXhwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752121723; c=relaxed/simple;
	bh=NWDbmNIOk0XVhueW1XFdGPKZRxU7ecjO9hudaef+tBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N+ViMaXEm3oYGGiVkqk9mTFTeTLNAxAm/WbGFsna2/rUapqZRZSxcgJgFm3IcxuYmnAdH+6eby+VPC8NGHV1E3P8QlwWXMyBvaP1yfdjwCNd/nwsOGWkM2dH4em7eDGIbhcmdQcmm7/3i+DdKGZzc2g019SgAw/aGt/xZ8Yg/JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4bd1Vt0DMGz1d209;
	Thu, 10 Jul 2025 12:06:30 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id AE57B140202;
	Thu, 10 Jul 2025 12:09:09 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Jul 2025 12:09:09 +0800
Message-ID: <844e996e-09dd-7f1e-cc21-25be65137152@hisilicon.com>
Date: Thu, 10 Jul 2025 12:09:08 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH rdma-next 1/1] net/mlx5: Fix build -Wframe-larger-than
 warnings
Content-Language: en-US
To: Zhu Yanjun <yanjun.zhu@linux.dev>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<tariqt@nvidia.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>
References: <20250710034948.34179-1-yanjun.zhu@linux.dev>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20250710034948.34179-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2025/7/10 11:49, Zhu Yanjun wrote:
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
> 1. Only build tests;
> 2. It is not a bug fix. Thus no Fixes tag;
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/eq.c  | 16 +++++---
>  .../mellanox/mlx5/core/irq_affinity.c         | 15 +++++--
>  .../net/ethernet/mellanox/mlx5/core/pci_irq.c | 40 +++++++++++++------
>  3 files changed, 51 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> index dfb079e59d85..66ce61eee804 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> @@ -873,20 +873,26 @@ static int comp_irq_request_sf(struct mlx5_core_dev *dev, u16 vecidx)
>  {
>  	struct mlx5_irq_pool *pool = mlx5_irq_table_get_comp_irq_pool(dev);
>  	struct mlx5_eq_table *table = dev->priv.eq_table;
> -	struct irq_affinity_desc af_desc = {};
> +	struct irq_affinity_desc *af_desc;
>  	struct mlx5_irq *irq;
>  
> +	af_desc = kvzalloc(sizeof(*af_desc), GFP_KERNEL);
> +	if (!af_desc)
> +		return -ENOMEM;
> +
>  	/* In case SF irq pool does not exist, fallback to the PF irqs*/
>  	if (!mlx5_irq_pool_is_sf_pool(pool))
>  		return comp_irq_request_pci(dev, vecidx);

...

>  
> -	af_desc.is_managed = false;
> -	cpumask_copy(&af_desc.mask, cpu_online_mask);
> -	cpumask_andnot(&af_desc.mask, &af_desc.mask, &table->used_cpus);
> -	irq = mlx5_irq_affinity_request(dev, pool, &af_desc);
> +	af_desc->is_managed = false;
> +	cpumask_copy(&af_desc->mask, cpu_online_mask);
> +	cpumask_andnot(&af_desc->mask, &af_desc->mask, &table->used_cpus);
> +	irq = mlx5_irq_affinity_request(dev, pool, af_desc);
>  	if (IS_ERR(irq))
>  		return PTR_ERR(irq);

...

>  
> +	kvfree(af_desc);
> +
>  	cpumask_or(&table->used_cpus, &table->used_cpus, mlx5_irq_get_affinity_mask(irq));
>  	mlx5_core_dbg(pool->dev, "IRQ %u mapped to cpu %*pbl, %u EQs on this irq\n",
>  		      pci_irq_vector(dev->pdev, mlx5_irq_get_index(irq)),
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
> index 2691d88cdee1..929f93853843 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
> @@ -47,29 +47,38 @@ static int cpu_get_least_loaded(struct mlx5_irq_pool *pool,
>  static struct mlx5_irq *
>  irq_pool_request_irq(struct mlx5_irq_pool *pool, struct irq_affinity_desc *af_desc)
>  {
> -	struct irq_affinity_desc auto_desc = {};
> +	struct irq_affinity_desc *auto_desc;
>  	struct mlx5_irq *irq;
>  	u32 irq_index;
>  	int err;
>  
> +	auto_desc = kvzalloc(sizeof(*auto_desc), GFP_KERNEL);
> +	if (!auto_desc)
> +		return ERR_PTR(-ENOMEM);
> +
>  	err = xa_alloc(&pool->irqs, &irq_index, NULL, pool->xa_num_irqs, GFP_KERNEL);
>  	if (err)
>  		return ERR_PTR(err);

You forgot to free the kvzalloc() memory in these error branches

Junxian

> +
>  	if (pool->irqs_per_cpu) {
>  		if (cpumask_weight(&af_desc->mask) > 1)
>  			/* if req_mask contain more then one CPU, set the least loadad CPU
>  			 * of req_mask
>  			 */
>  			cpumask_set_cpu(cpu_get_least_loaded(pool, &af_desc->mask),
> -					&auto_desc.mask);
> +					&auto_desc->mask);
>  		else
>  			cpu_get(pool, cpumask_first(&af_desc->mask));
>  	}
> +
>  	irq = mlx5_irq_alloc(pool, irq_index,
> -			     cpumask_empty(&auto_desc.mask) ? af_desc : &auto_desc,
> +			     cpumask_empty(&auto_desc->mask) ? af_desc : auto_desc,
>  			     NULL);
>  	if (IS_ERR(irq))
>  		xa_erase(&pool->irqs, irq_index);
> +
> +	kvfree(auto_desc);
> +
>  	return irq;
>  }
>  
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> index 40024cfa3099..48aad94b0a5d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> @@ -470,26 +470,32 @@ void mlx5_ctrl_irq_release(struct mlx5_core_dev *dev, struct mlx5_irq *ctrl_irq)
>  struct mlx5_irq *mlx5_ctrl_irq_request(struct mlx5_core_dev *dev)
>  {
>  	struct mlx5_irq_pool *pool = ctrl_irq_pool_get(dev);
> -	struct irq_affinity_desc af_desc;
> +	struct irq_affinity_desc *af_desc;
>  	struct mlx5_irq *irq;
>  
> -	cpumask_copy(&af_desc.mask, cpu_online_mask);
> -	af_desc.is_managed = false;
> +	af_desc = kvzalloc(sizeof(*af_desc), GFP_KERNEL);
> +	if (!af_desc)
> +		return ERR_PTR(-ENOMEM);
> +
> +	cpumask_copy(&af_desc->mask, cpu_online_mask);
> +	af_desc->is_managed = false;
>  	if (!mlx5_irq_pool_is_sf_pool(pool)) {
>  		/* In case we are allocating a control IRQ from a pci device's pool.
>  		 * This can happen also for a SF if the SFs pool is empty.
>  		 */
>  		if (!pool->xa_num_irqs.max) {
> -			cpumask_clear(&af_desc.mask);
> +			cpumask_clear(&af_desc->mask);
>  			/* In case we only have a single IRQ for PF/VF */
> -			cpumask_set_cpu(cpumask_first(cpu_online_mask), &af_desc.mask);
> +			cpumask_set_cpu(cpumask_first(cpu_online_mask), &af_desc->mask);
>  		}
>  		/* Allocate the IRQ in index 0. The vector was already allocated */
> -		irq = irq_pool_request_vector(pool, 0, &af_desc, NULL);
> +		irq = irq_pool_request_vector(pool, 0, af_desc, NULL);
>  	} else {
> -		irq = mlx5_irq_affinity_request(dev, pool, &af_desc);
> +		irq = mlx5_irq_affinity_request(dev, pool, af_desc);
>  	}
>  
> +	kvfree(af_desc);
> +
>  	return irq;
>  }
>  
> @@ -548,16 +554,26 @@ struct mlx5_irq *mlx5_irq_request_vector(struct mlx5_core_dev *dev, u16 cpu,
>  {
>  	struct mlx5_irq_table *table = mlx5_irq_table_get(dev);
>  	struct mlx5_irq_pool *pool = table->pcif_pool;
> -	struct irq_affinity_desc af_desc;
> +	struct irq_affinity_desc *af_desc;
>  	int offset = MLX5_IRQ_VEC_COMP_BASE;
> +	struct mlx5_irq *irq;
> +
> +	af_desc = kvzalloc(sizeof(*af_desc), GFP_KERNEL);
> +	if (!af_desc)
> +		return ERR_PTR(-ENOMEM);
>  
>  	if (!pool->xa_num_irqs.max)
>  		offset = 0;
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
>  }
>  
>  static struct mlx5_irq_pool *

