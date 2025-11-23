Return-Path: <linux-rdma+bounces-14705-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0943EC7DF27
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 10:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ACD1B3475D2
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 09:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950F526E6F3;
	Sun, 23 Nov 2025 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zr4M6UiH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E495156678;
	Sun, 23 Nov 2025 09:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763891362; cv=none; b=HQnjF2KefE7D91JGzjb9VeivCStXWr6NAWbkgASnBQxN2y8YAJE5e39fQe93PnHzVcUOFe9AwHBdXFT/Hg89OSA8+nlA74y1yUvwnI4H8SDVRsC1/HeVFe5Oi4+bo1a1S2GsB6F5hxPN6npvyCLxuGe5nscwYT2192if3SwXqks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763891362; c=relaxed/simple;
	bh=knvIMThQwasPsrEa4wEo3hnXL5VoQcIoh8ZWCW4UgAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyccymOV1e7BtA5pJb2snEqili77nHAK6Qg0Um05wUZoiI7ppnXdSYfRvxeKQpil/VB9jgZj0i+p9s3zCbg3GqBHqT/SpbJy9JP3NlUQN1QGcMdolq4o0M7f5qyw7Oq1rJ2L9wV+hBGGgXYQXxErjEkv2iGpfaI6j6JBagO8uhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zr4M6UiH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF89C113D0;
	Sun, 23 Nov 2025 09:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763891360;
	bh=knvIMThQwasPsrEa4wEo3hnXL5VoQcIoh8ZWCW4UgAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zr4M6UiHcK/lBL6dY6kTdl53SvMGYOuz1O3K5RQh0wHogKh46qKwYgCaMQAq1nTMf
	 zZmUum0XB189Jl6aZS3w36u81kPXxbw+kEPkedx4UXwz1izkKHuB5N3h7E5xZW4+XW
	 vZ6UZTQ8uZGxzeeu7HOrFR7VFzi/aiMmWMjUkMqviPeBdtW8QuoOMuKlnTtOjIE4GG
	 n43wUz+MGUUYj0gc/H2S+7eZIVAfc6IUFc10eZ4cNaB1RlEUsJz3p+6oSqMKnnpGiL
	 G0JDZaNVGIOAJDqevF20gTThLWO7Jmoq89IE5JRem5lnnhtKyeejom5Tl/QCbQe4qb
	 HYC3OgyplwPQQ==
Date: Sun, 23 Nov 2025 11:49:15 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "yanjun.zhu" <yanjun.zhu@linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Maher Sanalla <msanalla@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: Re: [PATCH rdma-next 2/2] RDMA/mlx5: Add support for 1600_8x lane
 speed
Message-ID: <20251123094915.GC16619@unreal>
References: <20251120-speed-8-v1-0-e6a7efef8cb8@nvidia.com>
 <20251120-speed-8-v1-2-e6a7efef8cb8@nvidia.com>
 <3c2e6250-2451-41c3-a291-e7c5ae52ff62@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c2e6250-2451-41c3-a291-e7c5ae52ff62@linux.dev>

On Thu, Nov 20, 2025 at 02:44:20PM -0800, yanjun.zhu wrote:
> On 11/20/25 7:15 AM, Leon Romanovsky wrote:
> > From: Maher Sanalla <msanalla@nvidia.com>
> > 
> > Add a check for 1600G_8X link speed when querying PTYS and report it
> > back correctly when needed.
> 
> Amazing — 1600G is supported. I’m not sure whether this rate is supported
> only for InfiniBand or if it’s also available for RoCEv2. In any case,
> having such a high data rate is truly impressive.

It is both for InfiniBand and RoCE.

>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Thanks

> 
> Zhu Yanjun
> 
> > 
> > While at it, adjust mlx5 function which maps the speed rate from IB
> > spec values to internal driver values to be able to handle speeds
> > up to 1600Gbps.
> > 
> > Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
> > Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >   drivers/infiniband/hw/mlx5/main.c | 4 ++++
> >   drivers/infiniband/hw/mlx5/qp.c   | 5 +++--
> >   2 files changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> > index 90daa58126f4..40284bbb45d6 100644
> > --- a/drivers/infiniband/hw/mlx5/main.c
> > +++ b/drivers/infiniband/hw/mlx5/main.c
> > @@ -511,6 +511,10 @@ static int translate_eth_ext_proto_oper(u32 eth_proto_oper, u16 *active_speed,
> >   		*active_width = IB_WIDTH_4X;
> >   		*active_speed = IB_SPEED_XDR;
> >   		break;
> > +	case MLX5E_PROT_MASK(MLX5E_1600TAUI_8_1600TBASE_CR8_KR8):
> > +		*active_width = IB_WIDTH_8X;
> > +		*active_speed = IB_SPEED_XDR;
> > +		break;
> >   	default:
> >   		return -EINVAL;
> >   	}
> > diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
> > index 88724d15705d..69af20790481 100644
> > --- a/drivers/infiniband/hw/mlx5/qp.c
> > +++ b/drivers/infiniband/hw/mlx5/qp.c
> > @@ -3451,10 +3451,11 @@ int mlx5r_ib_rate(struct mlx5_ib_dev *dev, u8 rate)
> >   {
> >   	u32 stat_rate_support;
> > -	if (rate == IB_RATE_PORT_CURRENT || rate == IB_RATE_800_GBPS)
> > +	if (rate == IB_RATE_PORT_CURRENT || rate == IB_RATE_800_GBPS ||
> > +	    rate == IB_RATE_1600_GBPS)
> >   		return 0;
> > -	if (rate < IB_RATE_2_5_GBPS || rate > IB_RATE_800_GBPS)
> > +	if (rate < IB_RATE_2_5_GBPS || rate > IB_RATE_1600_GBPS)
> >   		return -EINVAL;
> >   	stat_rate_support = MLX5_CAP_GEN(dev->mdev, stat_rate_support);
> > 
> 
> 

