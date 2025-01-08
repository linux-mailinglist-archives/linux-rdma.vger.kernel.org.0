Return-Path: <linux-rdma+bounces-6901-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8B0A05816
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2025 11:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE5BB1886C49
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2025 10:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118721F7586;
	Wed,  8 Jan 2025 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="gUJbR3m3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC5F18B463;
	Wed,  8 Jan 2025 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736331930; cv=none; b=FGRPJ9olmSitNGxJcakRaLhqnegrd9WwRDgESTjxEdtscmtIxaVgHhEH2jFpkCMmr7/2Y1ilRZzsDz+VaIof/CcK6S9V1tB5DK37krv6yj77JYpSJvtncG3pLTZd6Hc+gtAlcIezsAtan1p2aHNUBhJBZP5+xa4C4fH9dfMbBBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736331930; c=relaxed/simple;
	bh=3cZ55hodolcBonWydC/oE7gQh6CX1J5FFqedEknJZJQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9sGrMATHMWkGtcz9/DyGMBkZhLIGOLKNVL81dPUy7/eRsNUssXltdmoSu26CsJjwiE0jl3wKuk1b+U0SVoG8OZs6/2qRekdaScooD/yFI+SfwP6mmphSAU7fq3PzuiXG69puvBe0IkvSdkMclc2Cp7SWQdrVpRztzalCfT3KDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=gUJbR3m3; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 74B8020842;
	Wed,  8 Jan 2025 11:25:25 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RUVdqUoOIaqi; Wed,  8 Jan 2025 11:25:24 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id DC64720839;
	Wed,  8 Jan 2025 11:25:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com DC64720839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1736331924;
	bh=usGPeQ402tsz9Fi75tKbQFlNSZtqq/m5TNddeEQ1ofg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=gUJbR3m3btQZajtjq8qboCjn8896kCM0S6a2Sw6gXB2ufHgD0U6BPKA28Dgtzvdoe
	 eCYwAncSUsaOxq9XIozt+Tu0OvoAsH1gTE00/IbjuDZClIvo3G0uaMMNsL3SmTPNI1
	 A2YYoGoGING3SVYrv4KxMOh0tjwdeAmCQipxy52Z0MNIHZFUKy42nJvxOZiCbyXfOX
	 n3UKdGzGaTifhipYMyOFIybRVJRnHRsTRwBpnyUWclczfev6akSA+WRPWo65xP/RTJ
	 hCRP3GpWvDGjD7JbR7g0LlFA3KlSZS3kp1YYx7WAhhp6tpQg+zLTIjlHI+N0mHlsin
	 Ltib/SSRC/gmA==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 8 Jan 2025 11:25:24 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Jan
 2025 11:25:24 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 0F9DC3183F0A; Wed,  8 Jan 2025 11:25:24 +0100 (CET)
Date: Wed, 8 Jan 2025 11:25:23 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Jianbo Liu <jianbol@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"Eric Dumazet" <edumazet@google.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, Jakub Kicinski <kuba@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "Potnuri Bharat Teja" <bharat@chelsio.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH ipsec-next 1/2] xfrm: Support ESN context update to
 hardware for TX
Message-ID: <Z35Sk688mOcePbJE@gauss3.secunet.de>
References: <874f965d786606b0b4351c976f50271349f68b03.1734611621.git.leon@kernel.org>
 <20250107102204.GB87447@unreal>
 <Z30WcStdG5Z4tDru@gauss3.secunet.de>
 <20250107120905.GD87447@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250107120905.GD87447@unreal>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, Jan 07, 2025 at 02:09:05PM +0200, Leon Romanovsky wrote:
> On Tue, Jan 07, 2025 at 12:56:33PM +0100, Steffen Klassert wrote:
> > On Tue, Jan 07, 2025 at 12:22:04PM +0200, Leon Romanovsky wrote:
> > > On Thu, Dec 19, 2024 at 02:37:29PM +0200, Leon Romanovsky wrote:
> > > > From: Jianbo Liu <jianbol@nvidia.com>
> > > > 
> > > > Previously xfrm_dev_state_advance_esn() was added for RX only. But
> > > > it's possible that ESN context also need to be synced to hardware for
> > > > TX, so call it for outbound in this patch.
> > > > 
> > > > Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > > ---
> > > >  Documentation/networking/xfrm_device.rst                 | 3 ++-
> > > >  drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c          | 3 +++
> > > >  drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c | 3 +++
> > > >  net/xfrm/xfrm_replay.c                                   | 1 +
> > > >  4 files changed, 9 insertions(+), 1 deletion(-)
> > > 
> > > Steffen,
> > > 
> > > This is kindly reminder.
> > 
> > Sorry for the dealy, the holidays came faster than expected :)
> > 
> > > > diff --git a/net/xfrm/xfrm_replay.c b/net/xfrm/xfrm_replay.c
> > > > index bc56c6305725..e500aebbad22 100644
> > > > --- a/net/xfrm/xfrm_replay.c
> > > > +++ b/net/xfrm/xfrm_replay.c
> > > > @@ -729,6 +729,7 @@ static int xfrm_replay_overflow_offload_esn(struct xfrm_state *x, struct sk_buff
> > > >  		}
> > > >  
> > > >  		replay_esn->oseq = oseq;
> > > > +		xfrm_dev_state_advance_esn(x);
> > 
> > This is the only line of code that this patchset adds
> > to the xfrm stack, so merging this through mlx5 might
> > create less conflicts.
> > 
> > In case you want to do that, you can add my 'Acked-by'
> > to this patch. Otherwise I'll pull it into the ipsec-next
> > tree tomorrow.
> 
> Let's do it through your tree, please. IMHO, it is more appropriate.

Ok, series applied to ipsec-next, thanks everyone!

