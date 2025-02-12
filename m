Return-Path: <linux-rdma+bounces-7674-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA5DA32594
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 13:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85429168BE1
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 12:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A73020B7EE;
	Wed, 12 Feb 2025 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="H8LhtKPM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FD42B9BC;
	Wed, 12 Feb 2025 12:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739361962; cv=none; b=gIQ4TSq8/fqEo7P5mRIYPFsxGnqSfhhjlbcNvWC2QaEvp4E/jNH+EoDvH0nf75TAIDjwKULIfNTAYvO7zWX1CkzGM8rJEeXmU4svmFiqAOWNPXkCgD3LUv5VZBxZZZAUktIeY4UpCEelPXVVr3hvPBNTwpmLt3ANFygGoTl74QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739361962; c=relaxed/simple;
	bh=TI8/Q3t5v0VoV3IWR89k/0yjGP6TH8lHBsK3hpbcDe4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFaT41r8/pnJkzqSBsRLzhAX2Uo3BrPObqj+OmXKoId+ZSS1S+JMbWCggR5krwOhGNO4uYawR1G9jAWzL9VQXgkzq6skDEY6UOHlPahloQxKdXUxK08JsgIrljqX/exNVbLwEvMoswfNgGFY/26aTf8+QA6mrsANFADW1/nVeHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=H8LhtKPM; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id C5D8420764;
	Wed, 12 Feb 2025 12:56:49 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x6xrKQmUOPbC; Wed, 12 Feb 2025 12:56:49 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 1411420728;
	Wed, 12 Feb 2025 12:56:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 1411420728
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1739361409;
	bh=CnhdflWo6BOsOWBkNahHfp8/uF7zvZ4noMRNZpBJqbE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=H8LhtKPMeBJTKVru2BDAXXdyfOEwaUGkqH4JYXi0D5WgBLhPvP313J96qZT13qMW6
	 QeFFlqbNsSSMOHZ3BoWTkXpe+MxB0sQijG2NE35tASEvSEGGFyNr24hm+YWWrL3PtV
	 vHQcSK5B1vIzliTp6Jc4WckAvieZiGDESYm4+hNz7l3gCudLZv2A1J3VtJcjsvhcKL
	 0DF2FxB9pm0WMZK76DEL2U9yd29dRQ3v8zofCDTZroZgQGRBxu4M9k3rGBEjf1opv7
	 Y1BThxrk6/NZYsBa8fHnYG6w4/k6sHE+dLSuKU5fhDhU9bAL3r6zYkztA7nn3Lszjf
	 VlkbL/wBIXR8Q==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Feb 2025 12:56:48 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Feb
 2025 12:56:48 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 118F53182AB3; Wed, 12 Feb 2025 12:56:48 +0100 (CET)
Date: Wed, 12 Feb 2025 12:56:48 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Leon Romanovsky <leonro@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Ayush Sawal <ayush.sawal@chelsio.com>, Bharat Bhushan
	<bbhushan2@marvell.com>, Eric Dumazet <edumazet@google.com>, Geetha sowjanya
	<gakula@marvell.com>, hariprasad <hkelam@marvell.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <intel-wired-lan@lists.osuosl.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>, Jonathan Corbet
	<corbet@lwn.net>, <linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	Louis Peens <louis.peens@corigine.com>, <netdev@vger.kernel.org>,
	<oss-drivers@corigine.com>, Paolo Abeni <pabeni@redhat.com>, "Potnuri Bharat
 Teja" <bharat@chelsio.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>, Tariq Toukan <tariqt@nvidia.com>, "Tony
 Nguyen" <anthony.l.nguyen@intel.com>, Ilia Lin <ilia.lin@kernel.org>
Subject: Re: [PATCH ipsec-next 2/5] xfrm: simplify SA initialization routine
Message-ID: <Z6yMgPSfPzgGHTkD@gauss3.secunet.de>
References: <cover.1738778580.git.leon@kernel.org>
 <dcadf7c144207017104657f85d512889a2d1a09e.1738778580.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dcadf7c144207017104657f85d512889a2d1a09e.1738778580.git.leon@kernel.org>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, Feb 05, 2025 at 08:20:21PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> SA replay mode is initialized differently for user-space and
> kernel-space users, but the call to xfrm_init_replay() existed in
> common path with boolean protection. That caused to situation where
> we have two different function orders.
> 
> So let's rewrite the SA initialization flow to have same order for
> both in-kernel and user-space callers.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  include/net/xfrm.h    |  3 +--
>  net/xfrm/xfrm_state.c | 22 ++++++++++------------
>  net/xfrm/xfrm_user.c  |  2 +-
>  3 files changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index 28355a5be5b9..58f8f7661ec4 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -1770,8 +1770,7 @@ void xfrm_spd_getinfo(struct net *net, struct xfrmk_spdinfo *si);
>  u32 xfrm_replay_seqhi(struct xfrm_state *x, __be32 net_seq);
>  int xfrm_init_replay(struct xfrm_state *x, struct netlink_ext_ack *extack);
>  u32 xfrm_state_mtu(struct xfrm_state *x, int mtu);
> -int __xfrm_init_state(struct xfrm_state *x, bool init_replay,
> -		      struct netlink_ext_ack *extack);
> +int __xfrm_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack);
>  int xfrm_init_state(struct xfrm_state *x);
>  int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type);
>  int xfrm_input_resume(struct sk_buff *skb, int nexthdr);
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 568fe8df7741..42799b0946a3 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -3120,8 +3120,7 @@ u32 xfrm_state_mtu(struct xfrm_state *x, int mtu)
>  }
>  EXPORT_SYMBOL_GPL(xfrm_state_mtu);
>  
> -int __xfrm_init_state(struct xfrm_state *x, bool init_replay,
> -		      struct netlink_ext_ack *extack)
> +int __xfrm_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack)

The whole point of having __xfrm_init_state was to
sepatate codepaths that need init_replay and those
who don't need it. That was a bandaid for something,
unfortunately I don't remenber for what.

If we don't need that anymore, maybe we can merge
__xfrm_init_state into xfrm_init_state, as it was
before.

The rest of the patchset looks OK to me.

