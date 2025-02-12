Return-Path: <linux-rdma+bounces-7687-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8178A32EB6
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 19:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B5B3A7809
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 18:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A4E25A2CA;
	Wed, 12 Feb 2025 18:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqwa+ufn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD0C1D516D;
	Wed, 12 Feb 2025 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739385025; cv=none; b=iAiXGfTirSRHogcrBFbdqAowtZdVNXW8Gwdt8GClNUy5muDWvFHJmXBGMN9s37NgJdNE1ZDLymMH66ZsUdU/th2ZBuv+zr3jeJbGwL4u5Qp07rNbX176SRZ614CZwfc1EpCiGI0dRhnqhzv849MYsyoDzd+4X1jadSlighH0KCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739385025; c=relaxed/simple;
	bh=IwYdqSQJRgLMoeK/GduEZ3/5ddSRX0H7Vbfl6aPdU38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/vWZtfCLY38Rt7VFWdUtO6wIwo+vOxCGheQ+rPMrpxliCoLIfPLDpNwnEn+LUUD9dLPKHTNdpL8kdHYkCZVN73aR6+q/jwb6lzgQe7oovJMf9e0RI1TNgjSz8RBgOhHpcY1GDPOsrUwht7hRdGCuLX1rCwQ8Ym1eI7xDrolELg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqwa+ufn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68581C4CEE2;
	Wed, 12 Feb 2025 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739385025;
	bh=IwYdqSQJRgLMoeK/GduEZ3/5ddSRX0H7Vbfl6aPdU38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hqwa+ufnSv0IcEn77bHXu6UWAhbLM9qwv4zwh4whoZENjzMlpT3DQrM5ng9LpHoPA
	 J3ZtEZtegITE0Z30rG9vSqDjJTFUJ8M6Ad2WPXj2nqBbQu4uuRDOeWd5q04Kc4fzbX
	 pliIvYE/3XLJhBtBlRni1rbJLOgqD7sg0XiiCI0OyXlpUJOjZaDSHYmV+RIYZbgIrt
	 YqkRZbETkwETttlGxPI6oJ+KCpbyZYDyjf5B4gHGZknk+nguQFLazHEkIi4KQxnsfP
	 s55AEti2WyAo5wvzb4aOz9Q1t/J5b0b2apm71AXEkzK3GIotVmkSlrNBuS87HWJf+E
	 DQauwx8FDeysA==
Date: Wed, 12 Feb 2025 20:30:20 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Ayush Sawal <ayush.sawal@chelsio.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Eric Dumazet <edumazet@google.com>,
	Geetha sowjanya <gakula@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
	Jay Vosburgh <jv@jvosburgh.net>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
	Louis Peens <louis.peens@corigine.com>, netdev@vger.kernel.org,
	oss-drivers@corigine.com, Paolo Abeni <pabeni@redhat.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Ilia Lin <ilia.lin@kernel.org>
Subject: Re: [PATCH ipsec-next 2/5] xfrm: simplify SA initialization routine
Message-ID: <20250212183020.GJ17863@unreal>
References: <cover.1738778580.git.leon@kernel.org>
 <dcadf7c144207017104657f85d512889a2d1a09e.1738778580.git.leon@kernel.org>
 <Z6yMgPSfPzgGHTkD@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6yMgPSfPzgGHTkD@gauss3.secunet.de>

On Wed, Feb 12, 2025 at 12:56:48PM +0100, Steffen Klassert wrote:
> On Wed, Feb 05, 2025 at 08:20:21PM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > SA replay mode is initialized differently for user-space and
> > kernel-space users, but the call to xfrm_init_replay() existed in
> > common path with boolean protection. That caused to situation where
> > we have two different function orders.
> > 
> > So let's rewrite the SA initialization flow to have same order for
> > both in-kernel and user-space callers.
> > 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  include/net/xfrm.h    |  3 +--
> >  net/xfrm/xfrm_state.c | 22 ++++++++++------------
> >  net/xfrm/xfrm_user.c  |  2 +-
> >  3 files changed, 12 insertions(+), 15 deletions(-)
> > 
> > diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> > index 28355a5be5b9..58f8f7661ec4 100644
> > --- a/include/net/xfrm.h
> > +++ b/include/net/xfrm.h
> > @@ -1770,8 +1770,7 @@ void xfrm_spd_getinfo(struct net *net, struct xfrmk_spdinfo *si);
> >  u32 xfrm_replay_seqhi(struct xfrm_state *x, __be32 net_seq);
> >  int xfrm_init_replay(struct xfrm_state *x, struct netlink_ext_ack *extack);
> >  u32 xfrm_state_mtu(struct xfrm_state *x, int mtu);
> > -int __xfrm_init_state(struct xfrm_state *x, bool init_replay,
> > -		      struct netlink_ext_ack *extack);
> > +int __xfrm_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack);
> >  int xfrm_init_state(struct xfrm_state *x);
> >  int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type);
> >  int xfrm_input_resume(struct sk_buff *skb, int nexthdr);
> > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > index 568fe8df7741..42799b0946a3 100644
> > --- a/net/xfrm/xfrm_state.c
> > +++ b/net/xfrm/xfrm_state.c
> > @@ -3120,8 +3120,7 @@ u32 xfrm_state_mtu(struct xfrm_state *x, int mtu)
> >  }
> >  EXPORT_SYMBOL_GPL(xfrm_state_mtu);
> >  
> > -int __xfrm_init_state(struct xfrm_state *x, bool init_replay,
> > -		      struct netlink_ext_ack *extack)
> > +int __xfrm_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack)
> 
> The whole point of having __xfrm_init_state was to
> sepatate codepaths that need init_replay and those
> who don't need it. That was a bandaid for something,
> unfortunately I don't remenber for what.
> 
> If we don't need that anymore, maybe we can merge
> __xfrm_init_state into xfrm_init_state, as it was
> before.

Main difference between __xfrm_init_state and xfrm_init_state is that
latter is called without extack, which doesn't exist in kernel path.

E.g  xfrm_init_state(struct xfrm_state *x) vs. __xfrm_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack).
So if we merge them, we will need to change all xfrm_init_state()
callers to provide extack == NULL.

IMHO, such churn of changing xfrm_init_state() callers is not worth it for now.

Thanks

> 
> The rest of the patchset looks OK to me.

