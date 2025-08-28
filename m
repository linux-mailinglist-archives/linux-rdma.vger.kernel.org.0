Return-Path: <linux-rdma+bounces-12976-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28329B39BFF
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Aug 2025 13:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E411517F187
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Aug 2025 11:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD4930EF9A;
	Thu, 28 Aug 2025 11:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BwyYr8nX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B852E1C63
	for <linux-rdma@vger.kernel.org>; Thu, 28 Aug 2025 11:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756381932; cv=none; b=uAw/mWHf4wOqMW54A6eI5nb67iuDDg5KU/ccNcD6N7GMBI4j8vMMrbZkGSZEWz15wZ1kUfqAPmVxEUJsEpTHIjXkwOOTHeuOHHcAbjj0cSF8E5glzTcZkr7Z7F93eWAG/Dc513k7WybQV1WCiLBu0BkQAoKXxluNiu3bSiwhE2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756381932; c=relaxed/simple;
	bh=6MtDGQBsGfWcQrIYWzlZwnGEJx2O09jR+JHOk4MG+tA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sE1JEne1pKevEeELMud3RFxiuknm+kJxgWOxx456LKuu99lCQu2lJOy5q8EM4Xt+hUc+8DQDF/OyIR1O7vKHR3diK8ViOp7LNEg5MC24FZgdgp+b0LZNi8D6ZDn/S5mtybw2+tUmRUQqheTUhL7htnOTo2ECdNRq4M9tNvMk9Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BwyYr8nX; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b8fd314e-e1ca-4cc1-ba44-42f564137ef4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756381925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7k5onwaK6aWH5iM3V+gQf3/Qu7XTIBCWbmk6yW4KoQc=;
	b=BwyYr8nXa1WC/+DCv0AaJihjE9MPhDR6N5lhcqY06NlC3SfECzPvIe/zTTzNEFaG9TvhkY
	vnotZKPvvg28Up4qQ+CLTBYzFpzcqpXnwCaLPn8Jei/EMJcEt7gJLlBnU0SoS6nl1QXglZ
	qQZkAaV1USO73DjIkeQWMRtOOX6KSDA=
Date: Thu, 28 Aug 2025 12:51:55 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] eth: mlx4: Fix IS_ERR() vs NULL check bug in
 mlx4_en_create_rx_ring
To: Miaoqian Lin <linmq006@gmail.com>, Tariq Toukan <tariqt@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250828065050.21954-1-linmq006@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250828065050.21954-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 28/08/2025 07:50, Miaoqian Lin wrote:
> Replace NULL check with IS_ERR() check after calling page_pool_create()
> since this function returns error pointers (ERR_PTR).
> Using NULL check could lead to invalid pointer dereference.
> 
> Fixes: 8533b14b3d65 ("eth: mlx4: create a page pool for Rx")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ----
> Changes in v2:
> use err = PTR_ERR(ring->pp);
> v1 link: https://lore.kernel.org/all/20250805025057.3659898-1-linmq006@gmail.com
> ---
>   drivers/net/ethernet/mellanox/mlx4/en_rx.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> index 92a16ddb7d86..4728960c2c4e 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> @@ -267,8 +267,10 @@ int mlx4_en_create_rx_ring(struct mlx4_en_priv *priv,
>   	pp.dma_dir = priv->dma_dir;
>   
>   	ring->pp = page_pool_create(&pp);
> -	if (!ring->pp)
> +	if (!ring->pp) {
> +		err = PTR_ERR(ring->pp);
>   		goto err_ring;
> +	}

I don't see IS_ERR() check in this version, without it the code makes
no sense.

