Return-Path: <linux-rdma+bounces-6881-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9833EA03EB8
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 13:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B574F7A2091
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 12:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E2E1F0E34;
	Tue,  7 Jan 2025 12:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4EfRNyx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8491F03C8;
	Tue,  7 Jan 2025 12:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251755; cv=none; b=qekc/0bxJdvx4eh3TUdO1QbEkwMwbn/kM6JqxMBA7KbzhCvRxcj49ApO0zV9ITq7VHovhH9QTEaWed9IWUpgoScUbM10m8s3pA0ckPq2KmeNlFfhVlO+/RD0QN/BevD0F+r2aM6k9+Z4e1X2LHWxG2O7OdA0AETrjmWCAsp2pkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251755; c=relaxed/simple;
	bh=+5ef2Fp0GMi4xhvxB1Nhjiyc//qlEA2F/+VH7beBIcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVTZJi5zrVwa3qUMbv5vV5HCWSOPirhZ2kYe1vxmnfjnJFA0uQpC90D+MRZ6O3PPwNoGJbaiMmWf7W/wOFeTnUZn7SySIHFB+VrnSsvckiD/QAWl42xfYINazxbGX2Ym5ZQjbrVT4b7/lrMN+lmopaJ8jQmPfdk2/Vfdh+d/VGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4EfRNyx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED9CC4CEDD;
	Tue,  7 Jan 2025 12:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736251751;
	bh=+5ef2Fp0GMi4xhvxB1Nhjiyc//qlEA2F/+VH7beBIcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u4EfRNyxgibp6VAJDNRA74GyB7n8NQ6kTM8Y7K/87UH4V5xkh/t1OC6Y+v7u83MSO
	 RjwxF66M7yN7v8F16L5TFwJ8mPsEnSVPmD99+CYCtFdW6eAELRuc7odgvEU6rPb2mR
	 tcZj8LRgtolTlei/5FBPn7d5j290vtK+843QABHvRghZQ8iskVSSzeZ2OQWO7bKk7e
	 1dO5HtqXylvt/vQIk59XPy9jd4U2cYkJN2OFlTULvB0hBfIWbDDobHnEtvbfO38cLU
	 3MKN+ZnqV5XY8KoNindZ1JOsF6IIBfRPnWWoa+635OpkmyKAIDhNMiNyOLHVSLJDmm
	 VwlYWErflU+Lw==
Date: Tue, 7 Jan 2025 14:09:05 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Jianbo Liu <jianbol@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH ipsec-next 1/2] xfrm: Support ESN context update to
 hardware for TX
Message-ID: <20250107120905.GD87447@unreal>
References: <874f965d786606b0b4351c976f50271349f68b03.1734611621.git.leon@kernel.org>
 <20250107102204.GB87447@unreal>
 <Z30WcStdG5Z4tDru@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z30WcStdG5Z4tDru@gauss3.secunet.de>

On Tue, Jan 07, 2025 at 12:56:33PM +0100, Steffen Klassert wrote:
> On Tue, Jan 07, 2025 at 12:22:04PM +0200, Leon Romanovsky wrote:
> > On Thu, Dec 19, 2024 at 02:37:29PM +0200, Leon Romanovsky wrote:
> > > From: Jianbo Liu <jianbol@nvidia.com>
> > > 
> > > Previously xfrm_dev_state_advance_esn() was added for RX only. But
> > > it's possible that ESN context also need to be synced to hardware for
> > > TX, so call it for outbound in this patch.
> > > 
> > > Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > ---
> > >  Documentation/networking/xfrm_device.rst                 | 3 ++-
> > >  drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c          | 3 +++
> > >  drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c | 3 +++
> > >  net/xfrm/xfrm_replay.c                                   | 1 +
> > >  4 files changed, 9 insertions(+), 1 deletion(-)
> > 
> > Steffen,
> > 
> > This is kindly reminder.
> 
> Sorry for the dealy, the holidays came faster than expected :)
> 
> > > diff --git a/net/xfrm/xfrm_replay.c b/net/xfrm/xfrm_replay.c
> > > index bc56c6305725..e500aebbad22 100644
> > > --- a/net/xfrm/xfrm_replay.c
> > > +++ b/net/xfrm/xfrm_replay.c
> > > @@ -729,6 +729,7 @@ static int xfrm_replay_overflow_offload_esn(struct xfrm_state *x, struct sk_buff
> > >  		}
> > >  
> > >  		replay_esn->oseq = oseq;
> > > +		xfrm_dev_state_advance_esn(x);
> 
> This is the only line of code that this patchset adds
> to the xfrm stack, so merging this through mlx5 might
> create less conflicts.
> 
> In case you want to do that, you can add my 'Acked-by'
> to this patch. Otherwise I'll pull it into the ipsec-next
> tree tomorrow.

Let's do it through your tree, please. IMHO, it is more appropriate.

Thanks

