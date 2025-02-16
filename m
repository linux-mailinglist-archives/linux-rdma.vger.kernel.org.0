Return-Path: <linux-rdma+bounces-7779-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC78A373E4
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Feb 2025 12:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E3841890906
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Feb 2025 11:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28C718DB02;
	Sun, 16 Feb 2025 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iuj+7qei"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761B23209;
	Sun, 16 Feb 2025 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739704037; cv=none; b=mWG66wmj1h3OmHnKuDY2pAEGMKKPvGZYfOi6Y8IC6MyBbpaae60rXbCSaGdKp5lLCdCAyUirHxNiWJBLmNG4CLCOyRbCI1+GIBzuY20qN2s5KWMpiSo318DfQFVGQe/UBgOdaqWDC7+lf9kBoLEuuGztbntyOOjk+1GF7eFtEE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739704037; c=relaxed/simple;
	bh=Uk6rLoER8BRIA7iCbn8kKYYcjuD4hDrsTvEO8AmLDFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIA0wrNlweijzZABAhTPAHma9u0mndLidwzVCAfdeq7xkHSkQTiZscHTUijO0j6OAC+V9Yhra6tG9Rs0Ak5UUmkQ3HfqmvZB3k2zauGW5t5s4HA/q3W0qjes3yMpwf+qxFcB5cyb58iHc/31FFhMVCtpS6O9/9cdcPT1wY0k1so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iuj+7qei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08955C4CEDD;
	Sun, 16 Feb 2025 11:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739704036;
	bh=Uk6rLoER8BRIA7iCbn8kKYYcjuD4hDrsTvEO8AmLDFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iuj+7qei6zcPfTh3qOoDezjkO34QekJqHIdM6/d+4DBfpRS2vnXYyEdLPfzxfzwin
	 OdUkhcBIZVIXIERPlgZMgC3YM2uySi/ffPGKarWx9Fsr1AL+D4AJGE71efsicDUs1j
	 +9yAdBE1sQtZffUDZCbeQjtHM1zwyXN6vutu0OscvkByjBBk4nqPCV5ZePJxnmMT9O
	 H17A3qTgTZNOlHfwh3qcZvCk/IaNL+hUUXEhYNsJ9KzE8rEOeQM3r2RFVLbsPhHEvC
	 JmJygg65bFuQJLnBK9owt5d2kAbYvwrq0NBESuPY+4mm8a2k6iXhB9KFJG/Vlc6CtS
	 yp9zUJuh6Z8AQ==
Date: Sun, 16 Feb 2025 13:07:11 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
Subject: Re: [PATCH ipsec-next 4/5] xfrm: provide common xdo_dev_offload_ok
 callback implementation
Message-ID: <20250216110711.GU17863@unreal>
References: <cover.1738778580.git.leon@kernel.org>
 <d2aa8f840b0c81e33239e2a4b126730ae40864f1.1738778580.git.leon@kernel.org>
 <647895d9-e8d1-4921-b5ba-b38b2176604e@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <647895d9-e8d1-4921-b5ba-b38b2176604e@linux.dev>

On Sun, Feb 16, 2025 at 10:33:59AM +0100, Zhu Yanjun wrote:
> 在 2025/2/5 19:20, Leon Romanovsky 写道:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Almost all drivers except bond and nsim had same check if device
> > can perform XFRM offload on that specific packet. The check was that
> > packet doesn't have IPv4 options and IPv6 extensions.
> > 
> > In NIC drivers, the IPv4 HELEN comparison was slightly different, but
> > the intent was to check for the same conditions. So let's chose more
> > strict variant as a common base.
> > 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >   Documentation/networking/xfrm_device.rst      |  3 ++-
> >   drivers/net/bonding/bond_main.c               | 16 +++++---------
> >   .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   | 21 -------------------
> >   .../inline_crypto/ch_ipsec/chcr_ipsec.c       | 16 --------------
> >   .../net/ethernet/intel/ixgbe/ixgbe_ipsec.c    | 21 -------------------
> >   drivers/net/ethernet/intel/ixgbevf/ipsec.c    | 21 -------------------
> >   .../marvell/octeontx2/nic/cn10k_ipsec.c       | 15 -------------
> >   .../mellanox/mlx5/core/en_accel/ipsec.c       | 16 --------------
> >   .../net/ethernet/netronome/nfp/crypto/ipsec.c | 11 ----------
> >   drivers/net/netdevsim/ipsec.c                 | 11 ----------
> >   drivers/net/netdevsim/netdevsim.h             |  1 -
> >   net/xfrm/xfrm_device.c                        | 15 +++++++++++++
> >   12 files changed, 22 insertions(+), 145 deletions(-)
> > 
> > diff --git a/Documentation/networking/xfrm_device.rst b/Documentation/networking/xfrm_device.rst
> > index 66f6e9a9b59a..39bb98939d1f 100644
> > --- a/Documentation/networking/xfrm_device.rst
> > +++ b/Documentation/networking/xfrm_device.rst
> > @@ -126,7 +126,8 @@ been setup for offload, it first calls into xdo_dev_offload_ok() with
> >   the skb and the intended offload state to ask the driver if the offload
> >   will serviceable.  This can check the packet information to be sure the
> >   offload can be supported (e.g. IPv4 or IPv6, no IPv4 options, etc) and
> > -return true of false to signify its support.
> > +return true of false to signify its support. In case driver doesn't implement
> 
> In this commit, remove the functions cxgb4_ipsec_offload_ok,
> ch_ipsec_offload_ok, ixgbe_ipsec_offload_ok, ixgbevf_ipsec_offload_ok,
> cn10k_ipsec_offload_ok, mlx5e_ipsec_offload_ok, nfp_net_ipsec_offload_ok and
> nsim_ipsec_offload_ok, use the function xfrm_dev_offload_ok to do the same
> work.
> 
> But in the file xfrm_device.rst, "return true or false to signify its
> support"?

This sentence continued in the xfrm_device.rst: "...  In case driver doesn't implement
this callback, the stack provides reasonable defaults."

> 
> of --> should be "or"
> 
> Thanks a lot.
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Thanks

> 
> Zhu Yanjun
> 
> > +this callback, the stack provides reasonable defaults.
> >   Crypto offload mode:
> >   When ready to send, the driver needs to inspect the Tx packet for the
> > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> > index e45bba240cbc..bfb55c23380b 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -676,22 +676,16 @@ static void bond_ipsec_free_sa(struct xfrm_state *xs)
> >   static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)

