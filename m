Return-Path: <linux-rdma+bounces-7767-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F90A35A64
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2025 10:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1E6716FFCF
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2025 09:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1134023F439;
	Fri, 14 Feb 2025 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="nwIkIr6/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31A923A994;
	Fri, 14 Feb 2025 09:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739525387; cv=none; b=XH7sMNVvshjRUXQflsdYq+yoXf0wz7+b5ByOzeRz4DZ4uv79iX8D4R8t71lnrOB/7zQYk4WM++UG5YVHs3mGTRAh5pUQSune6FHBeqiHa8ChrunlCXxHtZMVBLEwqNlWlDB+WrVRtOsh3Nn0/dkqiEJnQVVToJ7J5b4JxU6/WxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739525387; c=relaxed/simple;
	bh=Me+hpIWRhhrK/f735YQpcBw7dzwWKtEUL7DZe290uYs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrLO7ZthKD6vpoJGaaPV+PK8nDmSxks92xc0MRCPKLNayTnFinYFHCdPP+2mbJ+XRYW++wyhs+y7IjkZFtnNhyxOiQ07ttPVEPSTR8wQw6qBSqnFAMa2WY04+WyFlpLEAAgWWe951hO6tHKY4teXogHG2fBN3hfIPgqml3WAonE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=nwIkIr6/; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 8E8DD207BE;
	Fri, 14 Feb 2025 10:29:37 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3pmxnVF2Uw53; Fri, 14 Feb 2025 10:29:36 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id D702820561;
	Fri, 14 Feb 2025 10:29:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com D702820561
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1739525376;
	bh=fhrJLVONWyN7lozy7dAfShs/BOPSfryeG22TLnl5EA0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=nwIkIr6/lFy/+/yC8ca/y5f7qR7zJgV70vLW7VuHr60QRWAKT5o7XJUFrbjbVj4Zz
	 yPOxD5YzQP0kXHxe9O9p/8oT0Bgtg0atJtSj0/6u0ysLHaAfCkfo1RAu17uvyTZxtn
	 oV8ReSd6wdie7LLjmkIb3P0cEV4L5itbMXHvUyqXfaA/ZPV2XlFnTo1Xjt9JV+mtIs
	 MNAmk4RrYST8wIVXuSrDi8irJgTXUvLXn8AjIewO2hcJrfx8IRpZ/fB3H3/eWBaqa7
	 tk4H838MtBHD5p+CQF+qLAiwo8nOwjVZxVGWNW63BX0+I/PJJ4hhThu6vSByIGHkhN
	 xALe/QFZSanPQ==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Feb 2025 10:29:36 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 10:29:36 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id EAE3E31840A6; Fri, 14 Feb 2025 10:29:35 +0100 (CET)
Date: Fri, 14 Feb 2025 10:29:35 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Ayush Sawal
	<ayush.sawal@chelsio.com>, Bharat Bhushan <bbhushan2@marvell.com>, "Eric
 Dumazet" <edumazet@google.com>, Geetha sowjanya <gakula@marvell.com>,
	hariprasad <hkelam@marvell.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	<intel-wired-lan@lists.osuosl.org>, Jakub Kicinski <kuba@kernel.org>, "Jay
 Vosburgh" <jv@jvosburgh.net>, Jonathan Corbet <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Louis Peens
	<louis.peens@corigine.com>, <netdev@vger.kernel.org>,
	<oss-drivers@corigine.com>, Paolo Abeni <pabeni@redhat.com>, "Potnuri Bharat
 Teja" <bharat@chelsio.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>, Tariq Toukan <tariqt@nvidia.com>, "Tony
 Nguyen" <anthony.l.nguyen@intel.com>, Ilia Lin <ilia.lin@kernel.org>
Subject: Re: [PATCH ipsec-next 2/5] xfrm: simplify SA initialization routine
Message-ID: <Z68M/4jka5FwrvLV@gauss3.secunet.de>
References: <cover.1738778580.git.leon@kernel.org>
 <dcadf7c144207017104657f85d512889a2d1a09e.1738778580.git.leon@kernel.org>
 <Z6yMgPSfPzgGHTkD@gauss3.secunet.de>
 <20250212183020.GJ17863@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250212183020.GJ17863@unreal>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, Feb 12, 2025 at 08:30:20PM +0200, Leon Romanovsky wrote:
> On Wed, Feb 12, 2025 at 12:56:48PM +0100, Steffen Klassert wrote:
> > On Wed, Feb 05, 2025 at 08:20:21PM +0200, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > SA replay mode is initialized differently for user-space and
> > > kernel-space users, but the call to xfrm_init_replay() existed in
> > > common path with boolean protection. That caused to situation where
> > > we have two different function orders.
> > > 
> > > So let's rewrite the SA initialization flow to have same order for
> > > both in-kernel and user-space callers.
> > > 
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > ---
> > >  include/net/xfrm.h    |  3 +--
> > >  net/xfrm/xfrm_state.c | 22 ++++++++++------------
> > >  net/xfrm/xfrm_user.c  |  2 +-
> > >  3 files changed, 12 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> > > index 28355a5be5b9..58f8f7661ec4 100644
> > > --- a/include/net/xfrm.h
> > > +++ b/include/net/xfrm.h
> > > @@ -1770,8 +1770,7 @@ void xfrm_spd_getinfo(struct net *net, struct xfrmk_spdinfo *si);
> > >  u32 xfrm_replay_seqhi(struct xfrm_state *x, __be32 net_seq);
> > >  int xfrm_init_replay(struct xfrm_state *x, struct netlink_ext_ack *extack);
> > >  u32 xfrm_state_mtu(struct xfrm_state *x, int mtu);
> > > -int __xfrm_init_state(struct xfrm_state *x, bool init_replay,
> > > -		      struct netlink_ext_ack *extack);
> > > +int __xfrm_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack);
> > >  int xfrm_init_state(struct xfrm_state *x);
> > >  int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type);
> > >  int xfrm_input_resume(struct sk_buff *skb, int nexthdr);
> > > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > > index 568fe8df7741..42799b0946a3 100644
> > > --- a/net/xfrm/xfrm_state.c
> > > +++ b/net/xfrm/xfrm_state.c
> > > @@ -3120,8 +3120,7 @@ u32 xfrm_state_mtu(struct xfrm_state *x, int mtu)
> > >  }
> > >  EXPORT_SYMBOL_GPL(xfrm_state_mtu);
> > >  
> > > -int __xfrm_init_state(struct xfrm_state *x, bool init_replay,
> > > -		      struct netlink_ext_ack *extack)
> > > +int __xfrm_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack)
> > 
> > The whole point of having __xfrm_init_state was to
> > sepatate codepaths that need init_replay and those
> > who don't need it. That was a bandaid for something,
> > unfortunately I don't remenber for what.
> > 
> > If we don't need that anymore, maybe we can merge
> > __xfrm_init_state into xfrm_init_state, as it was
> > before.
> 
> Main difference between __xfrm_init_state and xfrm_init_state is that
> latter is called without extack, which doesn't exist in kernel path.

That split happened ~ 15 years ago, we did not have extack back than.
But I'm also ok with keeping it if extack is a reason for it.

Do you plan to respin, or should I take the patchset as is?

Thanks!

