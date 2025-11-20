Return-Path: <linux-rdma+bounces-14669-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2C2C768B2
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 23:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81D9D4E2C5B
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 22:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA222FF17D;
	Thu, 20 Nov 2025 22:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LHE59xlp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54D72EDD7E
	for <linux-rdma@vger.kernel.org>; Thu, 20 Nov 2025 22:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763678669; cv=none; b=kX9csv7cA5nY/MWAVcgklvNX3nAgcg7ZlTgkmy2jQKaJndof+76wEL2XCFoyzLOonGaMNCSb0xv2UL95VE+dFUGsS1Y3qR7FplA21tTSf136OQBLEWdABsNvpl00AmiSjFa1iF1Z3heaiuYvlzftNSDbNSPr84u/4pTiH5+xVfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763678669; c=relaxed/simple;
	bh=Cn3/YI2g1QjNFBXyovaJ14XmvicwPL+AZl8EZDLq6lU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aOdEU1+uZzhd0JZ1PmF44QbGHV2V7c32Ab6DAALQPXJfGL+uEwVTf95pyQbEvOMylz10GyLCnd7QenDj5DwmEIb+1GXOfmLlrnrO2qSCCX4Z2xgBKnFs/dMibWM8sC2fFWxpz8wfj+36E0cTk9QwF7hq9ndt2X5CCcLoRvjXgMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LHE59xlp; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3c2e6250-2451-41c3-a291-e7c5ae52ff62@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763678663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JyVeu2NFxVm6OMmka8PJga4CPruvRFxfrFqFgWKqp8s=;
	b=LHE59xlp2gcB3GF/FT22Bj9topmUGat4gTuR/yCgHkpWVY0F3AD3zCJSmOOMOCU5NmXA6Q
	Oa9kf7XGaQ5Av15KqBcM1GUxvMuliaQ6npVLkpjbu7ZiX00Tipmegk/uzidLmqkmDBlBLV
	WMW6/Lvd6S4Eie85SoWczIQP1J6OFuw=
Date: Thu, 20 Nov 2025 14:44:20 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next 2/2] RDMA/mlx5: Add support for 1600_8x lane
 speed
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Maher Sanalla <msanalla@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>
References: <20251120-speed-8-v1-0-e6a7efef8cb8@nvidia.com>
 <20251120-speed-8-v1-2-e6a7efef8cb8@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20251120-speed-8-v1-2-e6a7efef8cb8@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/20/25 7:15 AM, Leon Romanovsky wrote:
> From: Maher Sanalla <msanalla@nvidia.com>
> 
> Add a check for 1600G_8X link speed when querying PTYS and report it
> back correctly when needed.

Amazing — 1600G is supported. I’m not sure whether this rate is 
supported only for InfiniBand or if it’s also available for RoCEv2. In 
any case, having such a high data rate is truly impressive.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> 
> While at it, adjust mlx5 function which maps the speed rate from IB
> spec values to internal driver values to be able to handle speeds
> up to 1600Gbps.
> 
> Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
> Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>   drivers/infiniband/hw/mlx5/main.c | 4 ++++
>   drivers/infiniband/hw/mlx5/qp.c   | 5 +++--
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index 90daa58126f4..40284bbb45d6 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -511,6 +511,10 @@ static int translate_eth_ext_proto_oper(u32 eth_proto_oper, u16 *active_speed,
>   		*active_width = IB_WIDTH_4X;
>   		*active_speed = IB_SPEED_XDR;
>   		break;
> +	case MLX5E_PROT_MASK(MLX5E_1600TAUI_8_1600TBASE_CR8_KR8):
> +		*active_width = IB_WIDTH_8X;
> +		*active_speed = IB_SPEED_XDR;
> +		break;
>   	default:
>   		return -EINVAL;
>   	}
> diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
> index 88724d15705d..69af20790481 100644
> --- a/drivers/infiniband/hw/mlx5/qp.c
> +++ b/drivers/infiniband/hw/mlx5/qp.c
> @@ -3451,10 +3451,11 @@ int mlx5r_ib_rate(struct mlx5_ib_dev *dev, u8 rate)
>   {
>   	u32 stat_rate_support;
>   
> -	if (rate == IB_RATE_PORT_CURRENT || rate == IB_RATE_800_GBPS)
> +	if (rate == IB_RATE_PORT_CURRENT || rate == IB_RATE_800_GBPS ||
> +	    rate == IB_RATE_1600_GBPS)
>   		return 0;
>   
> -	if (rate < IB_RATE_2_5_GBPS || rate > IB_RATE_800_GBPS)
> +	if (rate < IB_RATE_2_5_GBPS || rate > IB_RATE_1600_GBPS)
>   		return -EINVAL;
>   
>   	stat_rate_support = MLX5_CAP_GEN(dev->mdev, stat_rate_support);
> 


