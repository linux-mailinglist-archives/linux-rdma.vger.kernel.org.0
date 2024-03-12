Return-Path: <linux-rdma+bounces-1400-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C572E879283
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Mar 2024 11:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DD8FB22E08
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Mar 2024 10:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E880C79942;
	Tue, 12 Mar 2024 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGqoYx7/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6D778B44
	for <linux-rdma@vger.kernel.org>; Tue, 12 Mar 2024 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710240789; cv=none; b=sjBUlbtSpxp/wwFvJQnpOPg2cNBLScwcxXJNxMM2LbSLE6mQ3bYFYO965z60aNppewd/oB/0FMi6PEFRLwLC9hImubq59g5P2B2yvy/n7zeMQV8MsjqG7s+UCbo5PlcyK/9rB2GuN3ZKImBPjNlAzaRzFuEUAOAiRWxXvpA3NNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710240789; c=relaxed/simple;
	bh=1w/vOUM3OVHnKop/q6D4qm65wszVGAL/bGQ6vCZWu6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fj0v06ef869m6x4j6ltTsTv3hLhbz24kV4Barj3PFRoHZgmFVe2/JvUz0/mM6KPqUjNSKF8rIgeo4eYdFZYflgwTPdT554fNEdnX2Selab9i+ENA0+B/STwSka2r5gAaBCXzh63x3XCrZKLyLR22FBuFmyqERPCLDPTu5BOZKK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGqoYx7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC6CC43394;
	Tue, 12 Mar 2024 10:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710240789;
	bh=1w/vOUM3OVHnKop/q6D4qm65wszVGAL/bGQ6vCZWu6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LGqoYx7/ssw1GyC7LHGtmycN3ncMN3Rq5PTXQllcD3FQL/j89k2TSmWi1am2ZumH+
	 k2erIVgdGJo0UDHkHZu+Aq0CDV1VMNzCA4P34oKrsJZxscKbZR2sEDuT5sRSGL0+gS
	 bG0MDNLL19OSCN/q45zmYaewEcWyz8+ITMxJ4fybZoNrJwqtPc6qXe230hn/UO4Dhg
	 +6tJas5GobMcBAcxCH09AJb9BY0yysPFzIatc1RO/ofdmGDAQdM8jdbDJ2wIW6WoGh
	 ZL8Mu4nhBs1Ou1BwgOqZlAsvsv4KyzCCC7CEWebTrBTJuPPuuTc7R9/TZGfWR9yb5y
	 vfTazgI84B2Wg==
Date: Tue, 12 Mar 2024 12:53:05 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Boshi Yu <boshiyu@alibaba-inc.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, chengyou@linux.alibaba.com,
	KaiShen@linux.alibaba.com
Subject: Re: [PATCH for-next 3/3] RDMA/erdma: Remove unnecessary __GFP_ZERO
 flag
Message-ID: <20240312105305.GR12921@unreal>
References: <20240311113821.22482-1-boshiyu@alibaba-inc.com>
 <20240311113821.22482-4-boshiyu@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311113821.22482-4-boshiyu@alibaba-inc.com>

On Mon, Mar 11, 2024 at 07:38:21PM +0800, Boshi Yu wrote:
> From: Boshi Yu <boshiyu@linux.alibaba.com>
> 
> The dma_alloc_coherent() interface automatically zero the memory returned.

Can you please point to the DMA code which does that?

> Thus, we do not need to specify the __GFP_ZERO flag explicitly when we call
> dma_alloc_coherent().
> 
> Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
> Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/erdma/erdma_cmdq.c | 6 ++----
>  drivers/infiniband/hw/erdma/erdma_eq.c   | 6 ++----
>  2 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/erdma/erdma_cmdq.c b/drivers/infiniband/hw/erdma/erdma_cmdq.c
> index 0ac2683cfccf..43ff40b5a09d 100644
> --- a/drivers/infiniband/hw/erdma/erdma_cmdq.c
> +++ b/drivers/infiniband/hw/erdma/erdma_cmdq.c
> @@ -127,8 +127,7 @@ static int erdma_cmdq_cq_init(struct erdma_dev *dev)
>  
>  	cq->depth = cmdq->sq.depth;
>  	cq->qbuf = dma_alloc_coherent(&dev->pdev->dev, cq->depth << CQE_SHIFT,
> -				      &cq->qbuf_dma_addr,
> -				      GFP_KERNEL | __GFP_ZERO);
> +				      &cq->qbuf_dma_addr, GFP_KERNEL);
>  	if (!cq->qbuf)
>  		return -ENOMEM;
>  
> @@ -162,8 +161,7 @@ static int erdma_cmdq_eq_init(struct erdma_dev *dev)
>  
>  	eq->depth = cmdq->max_outstandings;
>  	eq->qbuf = dma_alloc_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT,
> -				      &eq->qbuf_dma_addr,
> -				      GFP_KERNEL | __GFP_ZERO);
> +				      &eq->qbuf_dma_addr, GFP_KERNEL);
>  	if (!eq->qbuf)
>  		return -ENOMEM;
>  
> diff --git a/drivers/infiniband/hw/erdma/erdma_eq.c b/drivers/infiniband/hw/erdma/erdma_eq.c
> index 0a4746e6d05c..84ccdd8144c9 100644
> --- a/drivers/infiniband/hw/erdma/erdma_eq.c
> +++ b/drivers/infiniband/hw/erdma/erdma_eq.c
> @@ -87,8 +87,7 @@ int erdma_aeq_init(struct erdma_dev *dev)
>  	eq->depth = ERDMA_DEFAULT_EQ_DEPTH;
>  
>  	eq->qbuf = dma_alloc_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT,
> -				      &eq->qbuf_dma_addr,
> -				      GFP_KERNEL | __GFP_ZERO);
> +				      &eq->qbuf_dma_addr, GFP_KERNEL);
>  	if (!eq->qbuf)
>  		return -ENOMEM;
>  
> @@ -237,8 +236,7 @@ static int erdma_ceq_init_one(struct erdma_dev *dev, u16 ceqn)
>  
>  	eq->depth = ERDMA_DEFAULT_EQ_DEPTH;
>  	eq->qbuf = dma_alloc_coherent(&dev->pdev->dev, eq->depth << EQE_SHIFT,
> -				      &eq->qbuf_dma_addr,
> -				      GFP_KERNEL | __GFP_ZERO);
> +				      &eq->qbuf_dma_addr, GFP_KERNEL);
>  	if (!eq->qbuf)
>  		return -ENOMEM;
>  
> -- 
> 2.39.3
> 
> 

