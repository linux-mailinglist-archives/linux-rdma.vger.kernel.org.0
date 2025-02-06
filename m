Return-Path: <linux-rdma+bounces-7486-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7802A2AA8A
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2025 14:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBB6A7A2A14
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2025 13:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B731C701B;
	Thu,  6 Feb 2025 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjtA9e/D"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CF31C7003;
	Thu,  6 Feb 2025 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738850369; cv=none; b=J0n7qRUfaR4XBi6l6XRHAb9OGocB7SX3VYbTlVrxXZT6bkKV24Suc67VdmX980CKzspf7fw8EGMJXDFWHxaqNtYQbk2s56lWUNi5mRQyvSC02zq4Ca9s8A/9QJ0e1kvmbAIdRhVjl+w423az5VAPSM/qI2FTbsHpi/jaMezLmZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738850369; c=relaxed/simple;
	bh=/8T0ISoh6DtyVHsrNW7Gm3mjILIJdd5Ay57tRPWwflY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HKfmb7qwqPyFC3avTCYYFShlZ7Xp5pdm+Eoqw0Hykb+vdlaaTgbx5m8C8sUU4vNnVVMnvK6ojfZS4P3VgrKfEclUVEWjbc2bsCxkeh4QsGAxne67/gflunjWgBg9fxjdwYJlqIepCBXRu3beGRKV3vHUD9X5ZlB67i2ZRcrkaiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjtA9e/D; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6f7031ea11cso9261007b3.2;
        Thu, 06 Feb 2025 05:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738850366; x=1739455166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JkSmWPOCb+asYOBVa33NM1TSxlPpxpo4SUCa1fCfjBE=;
        b=cjtA9e/DK/WqlXszFc+e+jYmSC9YuW/eQjYZFoYZXTnfWSqABKY0o4aRw0V+JncYvt
         LhANkeY04fRzKazt6+yBr2swhHoOo/vNgEp0dfHuJN7Ah7owpyKckiEHzt0TOozHZtPb
         YzgI+8uKW3uhKCcT+VFcyS93mv4ORl37y1wYx7Shad9u00qmXp40pQIuCmDtv/Xxi8wt
         5UJvgKbHLI//i+qL7H2jGDv+VyrjuMTr83BMW/rdmysHkhwrbSLjFAhirWIxl4p5tL8D
         DESh0/vCCYM/32lXvmAWiqhCm+H5zho1TTGVHuiEnsBdZABd8L8m8Z9GOQkv1AbQ0P1+
         4++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738850366; x=1739455166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JkSmWPOCb+asYOBVa33NM1TSxlPpxpo4SUCa1fCfjBE=;
        b=mwpqy398GcwdXMs9PV2iet5QBpY6+8TL95im0CwewHyXDCE850kfFCYWqRL96Tt4SM
         BlLJYylyNC+3hGNUPeF21/d+ztdq7EE8T2MYbWRjatwc86s1SkEAeaCB4VHV+LLWCLih
         AqeG5U0nLcfE9icPurP89GYINf+VBkpkv1qe17Y7NrvjZ6WL1gPy4ZHnDs3tyB9I0TNp
         pB25s/7fAcr8rzRn/axpJR5PxNXQa68HD8Zqaa8//6SDIvuQBBxPcdrHcVfsqpVWa16x
         2LhrQUQx5eGDBsqpmBmvxik1q0JMD0cRZj68vnFLVwWCIEKXem1guSUBsZj7pfl0905O
         +VgA==
X-Forwarded-Encrypted: i=1; AJvYcCVHpsPGJ+nj16JwiphaA6EBsHw+SL3Ib/Lc4U5+gAp1BEvpEl/CiynrbqzL+Yx9ncfBDNPgSPTY2nMU7g==@vger.kernel.org, AJvYcCVWNecQBLuK9fzFwfdSoSWkWKAuU5Wpc5ealjdKsjGG2FcdRgmwwsF+MWhgZHRqTdGOXdTYbEPo@vger.kernel.org, AJvYcCXFxrVXtdZXmX+3sytFSvfIV9Q/lFjkh+Zt1Vezfi0WjFnbr19UOfZ8RgI8fmg5GPv0llcPF6WvBfI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya66r4Fcr1BQZaB+hPXIT1DEuetK1ap0aAwirPx3Oe6U6+S7Gt
	QyfThEvd8qqacWA9EPOwY/NxB/Th6CCPqfYdT4cf2LvqqV2CrjxtW9mLnhxc32yDDE2SdrbL9oP
	L/a19ZPu1Ot+PIzmKy+UKbAJFXUM=
X-Gm-Gg: ASbGncuUeQ3P/eCr/ZOybl1kei3KoKpDmi8WJDjcoovDI7mMnGZ6qibDeAemIuLmY6r
	89A9A1L+pPQr+LIFbfXLp9qVSqU11pY9bWzvjNX7jdan+zbIqmixik0cTrSz0GiItI2THugA=
X-Google-Smtp-Source: AGHT+IF7QbK88hZIUeOKhP4HUXqRLH/FEPzNp2ncgTrNDqmPPHmt8VMgtwE7tmJot/sChcYQOaDAf5nDVMxooT+csZ0=
X-Received: by 2002:a05:690c:4907:b0:6f4:8207:c68d with SMTP id
 00721157ae682-6f989e3b297mr68197967b3.3.1738850366360; Thu, 06 Feb 2025
 05:59:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738778580.git.leon@kernel.org> <e536ca28cd1686dfbb613de7ccfc01fbe5a734e4.1738778580.git.leon@kernel.org>
 <CAAeCc_kfRt8LhKgRmLsaaSmJs94hjH85DxCjEnJA6OQc5S5XXw@mail.gmail.com> <20250206085443.GO74886@unreal>
In-Reply-To: <20250206085443.GO74886@unreal>
From: Bharat Bhushan <bharatb.linux@gmail.com>
Date: Thu, 6 Feb 2025 19:29:13 +0530
X-Gm-Features: AWEUYZkAMS0xeWv1xX-sqj7qXRsmFL_3wRd3BZAL4CFL2zz343S8a3XHEeWSvn8
Message-ID: <CAAeCc_n-xXBdfyAkRh0KEnvKuuJSHtPQB0umzeSL2aNzJFPXGQ@mail.gmail.com>
Subject: Re: [PATCH ipsec-next 1/5] xfrm: delay initialization of offload path
 till its actually requested
To: Leon Romanovsky <leon@kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Ayush Sawal <ayush.sawal@chelsio.com>, Bharat Bhushan <bbhushan2@marvell.com>, 
	Eric Dumazet <edumazet@google.com>, Geetha sowjanya <gakula@marvell.com>, 
	hariprasad <hkelam@marvell.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>, 
	Jay Vosburgh <jv@jvosburgh.net>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Louis Peens <louis.peens@corigine.com>, 
	netdev@vger.kernel.org, oss-drivers@corigine.com, 
	Paolo Abeni <pabeni@redhat.com>, Potnuri Bharat Teja <bharat@chelsio.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Subbaraya Sundeep <sbhatta@marvell.com>, Sunil Goutham <sgoutham@marvell.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Ilia Lin <ilia.lin@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 2:24=E2=80=AFPM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Thu, Feb 06, 2025 at 02:16:08PM +0530, Bharat Bhushan wrote:
> > Hi Leon,
> >
> > On Wed, Feb 5, 2025 at 11:50=E2=80=AFPM Leon Romanovsky <leon@kernel.or=
g> wrote:
> > >
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > >
> > > XFRM offload path is probed even if offload isn't needed at all. Let'=
s
> > > make sure that x->type_offload pointer stays NULL for such path to
> > > reduce ambiguity.
> > >
> > > Fixes: 9d389d7f84bb ("xfrm: Add a xfrm type offload.")
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > ---
> > >  include/net/xfrm.h     | 12 +++++++++++-
> > >  net/xfrm/xfrm_device.c | 14 +++++++++-----
> > >  net/xfrm/xfrm_state.c  | 22 +++++++++-------------
> > >  net/xfrm/xfrm_user.c   |  2 +-
> > >  4 files changed, 30 insertions(+), 20 deletions(-)
>
> <...>
>
> > > +       x->type_offload =3D xfrm_get_type_offload(x->id.proto, x->pro=
ps.family);
> > > +       if (!x->type_offload) {
>
> <...>
>
> > > +               xfrm_put_type_offload(x->type_offload);
> > > +               x->type_offload =3D NULL;
> >
> > We always set type_offload to NULL. Can we move type_offload =3D NULL i=
n
> > xfrm_put_type_offload() ?
>
> We can, but it will require change to xfrm_get_type_offload() too,
> otherwise we will get asymmetrical get/put.

"x->type_offload =3D NULL" is always set after the put() function. so I
thought that maybe moving "x->type_offload =3D NULL" to the put()
function would simplify.
Yes, get/put will be asymmetric. Maybe setting "x->type_offload" can
be done in get/put().
Anyway it is not a major comment. ignore if this does not simplify.

Thanks
-Bharat

>
> Do you want something like that?
> int xfrm_get_type_offload(struct xfrm_state *x);
> void xfrm_put_type_offload(struct xfrm_state *x);
>
> Thansk
>
> >
> > Thanks
> > -Bharat
> >
> > >                 /* User explicitly requested packet offload mode and =
configured
> > >                  * policy in addition to the XFRM state. So be civil =
to users,
> > >                  * and return an error instead of taking fallback pat=
h.
> > > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > > index ad2202fa82f3..568fe8df7741 100644
> > > --- a/net/xfrm/xfrm_state.c
> > > +++ b/net/xfrm/xfrm_state.c
> > > @@ -424,11 +424,12 @@ void xfrm_unregister_type_offload(const struct =
xfrm_type_offload *type,
> > >  }
> > >  EXPORT_SYMBOL(xfrm_unregister_type_offload);
> > >
> > > -static const struct xfrm_type_offload *
> > > -xfrm_get_type_offload(u8 proto, unsigned short family, bool try_load=
)
> > > +const struct xfrm_type_offload *xfrm_get_type_offload(u8 proto,
> > > +                                                     unsigned short =
family)
> > >  {
> > >         const struct xfrm_type_offload *type =3D NULL;
> > >         struct xfrm_state_afinfo *afinfo;
> > > +       bool try_load =3D true;
> > >
> > >  retry:
> > >         afinfo =3D xfrm_state_get_afinfo(family);
> > > @@ -456,11 +457,7 @@ xfrm_get_type_offload(u8 proto, unsigned short f=
amily, bool try_load)
> > >
> > >         return type;
> > >  }
> > > -
> > > -static void xfrm_put_type_offload(const struct xfrm_type_offload *ty=
pe)
> > > -{
> > > -       module_put(type->owner);
> > > -}
> > > +EXPORT_SYMBOL(xfrm_get_type_offload);
> > >
> > >  static const struct xfrm_mode xfrm4_mode_map[XFRM_MODE_MAX] =3D {
> > >         [XFRM_MODE_BEET] =3D {
> > > @@ -609,8 +606,6 @@ static void ___xfrm_state_destroy(struct xfrm_sta=
te *x)
> > >         kfree(x->coaddr);
> > >         kfree(x->replay_esn);
> > >         kfree(x->preplay_esn);
> > > -       if (x->type_offload)
> > > -               xfrm_put_type_offload(x->type_offload);
> > >         if (x->type) {
> > >                 x->type->destructor(x);
> > >                 xfrm_put_type(x->type);
> > > @@ -784,6 +779,9 @@ void xfrm_dev_state_free(struct xfrm_state *x)
> > >         struct xfrm_dev_offload *xso =3D &x->xso;
> > >         struct net_device *dev =3D READ_ONCE(xso->dev);
> > >
> > > +       xfrm_put_type_offload(x->type_offload);
> > > +       x->type_offload =3D NULL;
> > > +
> > >         if (dev && dev->xfrmdev_ops) {
> > >                 spin_lock_bh(&xfrm_state_dev_gc_lock);
> > >                 if (!hlist_unhashed(&x->dev_gclist))
> > > @@ -3122,7 +3120,7 @@ u32 xfrm_state_mtu(struct xfrm_state *x, int mt=
u)
> > >  }
> > >  EXPORT_SYMBOL_GPL(xfrm_state_mtu);
> > >
> > > -int __xfrm_init_state(struct xfrm_state *x, bool init_replay, bool o=
ffload,
> > > +int __xfrm_init_state(struct xfrm_state *x, bool init_replay,
> > >                       struct netlink_ext_ack *extack)
> > >  {
> > >         const struct xfrm_mode *inner_mode;
> > > @@ -3178,8 +3176,6 @@ int __xfrm_init_state(struct xfrm_state *x, boo=
l init_replay, bool offload,
> > >                 goto error;
> > >         }
> > >
> > > -       x->type_offload =3D xfrm_get_type_offload(x->id.proto, family=
, offload);
> > > -
> > >         err =3D x->type->init_state(x, extack);
> > >         if (err)
> > >                 goto error;
> > > @@ -3229,7 +3225,7 @@ int xfrm_init_state(struct xfrm_state *x)
> > >  {
> > >         int err;
> > >
> > > -       err =3D __xfrm_init_state(x, true, false, NULL);
> > > +       err =3D __xfrm_init_state(x, true, NULL);
> > >         if (!err)
> > >                 x->km.state =3D XFRM_STATE_VALID;
> > >
> > > diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> > > index 08c6d6f0179f..82a768500999 100644
> > > --- a/net/xfrm/xfrm_user.c
> > > +++ b/net/xfrm/xfrm_user.c
> > > @@ -907,7 +907,7 @@ static struct xfrm_state *xfrm_state_construct(st=
ruct net *net,
> > >                         goto error;
> > >         }
> > >
> > > -       err =3D __xfrm_init_state(x, false, attrs[XFRMA_OFFLOAD_DEV],=
 extack);
> > > +       err =3D __xfrm_init_state(x, false, extack);
> > >         if (err)
> > >                 goto error;
> > >
> > > --
> > > 2.48.1
> > >
> > >
> >

