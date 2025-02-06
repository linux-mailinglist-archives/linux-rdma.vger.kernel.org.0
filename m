Return-Path: <linux-rdma+bounces-7487-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CB8A2AB33
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2025 15:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B99A07A3788
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2025 14:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D54B1C701B;
	Thu,  6 Feb 2025 14:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsLd0ut8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3542A610C;
	Thu,  6 Feb 2025 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738851995; cv=none; b=MUQC7mdG/mRzls6Hzb9Nai96fKWbYNlSdHXFji1LsbIeithzlnDXKwHU25CIVuGEqHFKHMTlUNC7Shiv9ELDLzfbVrY9i726jus9BEzUlHZBkQBXYrrPyCB1nnddxubPeeFpsA2bpXALyqR12+tmu1fArwKxfvyjv62bkaSYaGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738851995; c=relaxed/simple;
	bh=PaYho1V012rs8ReQRCNuW1GskgxiLwS+MzDcZOTtoDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwBnVTyHO8orhIIj50HdCfWw0n9Wjxl9RmHE+jvx5QHbaMxsD024MZCuh3e9prkTImbe56z2ZwCPuhfJiSVoBng0wAk1lJGELn+Yf64tKp4ufAZATDjsbDZ44PGJ2QnQy6bJ0xf6++1xLdjL2PjNlTZl5BHvfsarZAVA/25RlcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsLd0ut8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC85C4CEDF;
	Thu,  6 Feb 2025 14:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738851994;
	bh=PaYho1V012rs8ReQRCNuW1GskgxiLwS+MzDcZOTtoDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RsLd0ut8C8HHGUz6yhYWOHGcDEib3EbCPJzBJmttfnn28R8FDNzQkcTKGbLzr+hmX
	 p3JkdL6HPtStvfnL3QTFQt5EnEa7BV/9hiYgxQ/FABJ92gUZkWz613Ff4I3+lO2Uaj
	 bbXzQY+2VhRbOx6t6HpmOyPmNKJU8ZbcSYWznFNRGE4zDOuDDgYpXbabu4MvcMRrIX
	 x1Abjk6F+AL4a2i2vzFMRw7h4IVqvK9nR+UmVEEaruPxkO4uI3WFdBFZetrZrAoiU9
	 nbvTiCOcrYKYyHnOGNm5fk1Lae4tF9mp0LnFVypcJiM9JgSi2udzoLbXBIxqXqn545
	 I8/PhBaXaT0jg==
Date: Thu, 6 Feb 2025 16:26:29 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Bharat Bhushan <bharatb.linux@gmail.com>
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
Subject: Re: [PATCH ipsec-next 1/5] xfrm: delay initialization of offload
 path till its actually requested
Message-ID: <20250206142629.GQ74886@unreal>
References: <cover.1738778580.git.leon@kernel.org>
 <e536ca28cd1686dfbb613de7ccfc01fbe5a734e4.1738778580.git.leon@kernel.org>
 <CAAeCc_kfRt8LhKgRmLsaaSmJs94hjH85DxCjEnJA6OQc5S5XXw@mail.gmail.com>
 <20250206085443.GO74886@unreal>
 <CAAeCc_n-xXBdfyAkRh0KEnvKuuJSHtPQB0umzeSL2aNzJFPXGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAeCc_n-xXBdfyAkRh0KEnvKuuJSHtPQB0umzeSL2aNzJFPXGQ@mail.gmail.com>

On Thu, Feb 06, 2025 at 07:29:13PM +0530, Bharat Bhushan wrote:
> On Thu, Feb 6, 2025 at 2:24 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Thu, Feb 06, 2025 at 02:16:08PM +0530, Bharat Bhushan wrote:
> > > Hi Leon,
> > >
> > > On Wed, Feb 5, 2025 at 11:50 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > >
> > > > XFRM offload path is probed even if offload isn't needed at all. Let's
> > > > make sure that x->type_offload pointer stays NULL for such path to
> > > > reduce ambiguity.
> > > >
> > > > Fixes: 9d389d7f84bb ("xfrm: Add a xfrm type offload.")
> > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > > ---
> > > >  include/net/xfrm.h     | 12 +++++++++++-
> > > >  net/xfrm/xfrm_device.c | 14 +++++++++-----
> > > >  net/xfrm/xfrm_state.c  | 22 +++++++++-------------
> > > >  net/xfrm/xfrm_user.c   |  2 +-
> > > >  4 files changed, 30 insertions(+), 20 deletions(-)
> >
> > <...>
> >
> > > > +       x->type_offload = xfrm_get_type_offload(x->id.proto, x->props.family);
> > > > +       if (!x->type_offload) {
> >
> > <...>
> >
> > > > +               xfrm_put_type_offload(x->type_offload);
> > > > +               x->type_offload = NULL;
> > >
> > > We always set type_offload to NULL. Can we move type_offload = NULL in
> > > xfrm_put_type_offload() ?
> >
> > We can, but it will require change to xfrm_get_type_offload() too,
> > otherwise we will get asymmetrical get/put.
> 
> "x->type_offload = NULL" is always set after the put() function. so I
> thought that maybe moving "x->type_offload = NULL" to the put()
> function would simplify.
> Yes, get/put will be asymmetric. Maybe setting "x->type_offload" can
> be done in get/put().
> Anyway it is not a major comment. ignore if this does not simplify.

Thanks, let's wait for other comments. If I need respin the series, I'll
change the functions to the proposed below.

Thanks


> 
> Thanks
> -Bharat
> 
> >
> > Do you want something like that?
> > int xfrm_get_type_offload(struct xfrm_state *x);
> > void xfrm_put_type_offload(struct xfrm_state *x);
> >
> > Thansk
> >
> > >
> > > Thanks
> > > -Bharat
> > >
> > > >                 /* User explicitly requested packet offload mode and configured
> > > >                  * policy in addition to the XFRM state. So be civil to users,
> > > >                  * and return an error instead of taking fallback path.
> > > > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > > > index ad2202fa82f3..568fe8df7741 100644
> > > > --- a/net/xfrm/xfrm_state.c
> > > > +++ b/net/xfrm/xfrm_state.c
> > > > @@ -424,11 +424,12 @@ void xfrm_unregister_type_offload(const struct xfrm_type_offload *type,
> > > >  }
> > > >  EXPORT_SYMBOL(xfrm_unregister_type_offload);
> > > >
> > > > -static const struct xfrm_type_offload *
> > > > -xfrm_get_type_offload(u8 proto, unsigned short family, bool try_load)
> > > > +const struct xfrm_type_offload *xfrm_get_type_offload(u8 proto,
> > > > +                                                     unsigned short family)
> > > >  {
> > > >         const struct xfrm_type_offload *type = NULL;
> > > >         struct xfrm_state_afinfo *afinfo;
> > > > +       bool try_load = true;
> > > >
> > > >  retry:
> > > >         afinfo = xfrm_state_get_afinfo(family);
> > > > @@ -456,11 +457,7 @@ xfrm_get_type_offload(u8 proto, unsigned short family, bool try_load)
> > > >
> > > >         return type;
> > > >  }
> > > > -
> > > > -static void xfrm_put_type_offload(const struct xfrm_type_offload *type)
> > > > -{
> > > > -       module_put(type->owner);
> > > > -}
> > > > +EXPORT_SYMBOL(xfrm_get_type_offload);
> > > >
> > > >  static const struct xfrm_mode xfrm4_mode_map[XFRM_MODE_MAX] = {
> > > >         [XFRM_MODE_BEET] = {
> > > > @@ -609,8 +606,6 @@ static void ___xfrm_state_destroy(struct xfrm_state *x)
> > > >         kfree(x->coaddr);
> > > >         kfree(x->replay_esn);
> > > >         kfree(x->preplay_esn);
> > > > -       if (x->type_offload)
> > > > -               xfrm_put_type_offload(x->type_offload);
> > > >         if (x->type) {
> > > >                 x->type->destructor(x);
> > > >                 xfrm_put_type(x->type);
> > > > @@ -784,6 +779,9 @@ void xfrm_dev_state_free(struct xfrm_state *x)
> > > >         struct xfrm_dev_offload *xso = &x->xso;
> > > >         struct net_device *dev = READ_ONCE(xso->dev);
> > > >
> > > > +       xfrm_put_type_offload(x->type_offload);
> > > > +       x->type_offload = NULL;
> > > > +
> > > >         if (dev && dev->xfrmdev_ops) {
> > > >                 spin_lock_bh(&xfrm_state_dev_gc_lock);
> > > >                 if (!hlist_unhashed(&x->dev_gclist))
> > > > @@ -3122,7 +3120,7 @@ u32 xfrm_state_mtu(struct xfrm_state *x, int mtu)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(xfrm_state_mtu);
> > > >
> > > > -int __xfrm_init_state(struct xfrm_state *x, bool init_replay, bool offload,
> > > > +int __xfrm_init_state(struct xfrm_state *x, bool init_replay,
> > > >                       struct netlink_ext_ack *extack)
> > > >  {
> > > >         const struct xfrm_mode *inner_mode;
> > > > @@ -3178,8 +3176,6 @@ int __xfrm_init_state(struct xfrm_state *x, bool init_replay, bool offload,
> > > >                 goto error;
> > > >         }
> > > >
> > > > -       x->type_offload = xfrm_get_type_offload(x->id.proto, family, offload);
> > > > -
> > > >         err = x->type->init_state(x, extack);
> > > >         if (err)
> > > >                 goto error;
> > > > @@ -3229,7 +3225,7 @@ int xfrm_init_state(struct xfrm_state *x)
> > > >  {
> > > >         int err;
> > > >
> > > > -       err = __xfrm_init_state(x, true, false, NULL);
> > > > +       err = __xfrm_init_state(x, true, NULL);
> > > >         if (!err)
> > > >                 x->km.state = XFRM_STATE_VALID;
> > > >
> > > > diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> > > > index 08c6d6f0179f..82a768500999 100644
> > > > --- a/net/xfrm/xfrm_user.c
> > > > +++ b/net/xfrm/xfrm_user.c
> > > > @@ -907,7 +907,7 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
> > > >                         goto error;
> > > >         }
> > > >
> > > > -       err = __xfrm_init_state(x, false, attrs[XFRMA_OFFLOAD_DEV], extack);
> > > > +       err = __xfrm_init_state(x, false, extack);
> > > >         if (err)
> > > >                 goto error;
> > > >
> > > > --
> > > > 2.48.1
> > > >
> > > >
> > >

