Return-Path: <linux-rdma+bounces-7479-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 724F5A2A375
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2025 09:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3237167527
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2025 08:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2F5214231;
	Thu,  6 Feb 2025 08:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpdJp5PT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93236163;
	Thu,  6 Feb 2025 08:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738831582; cv=none; b=TADhEkzjSSA1kx/TDGlSRvOrp3qy1BFkNrUni/BaMFqpxx3DI4Z5LjagVET7g9pos3JAxAyX+sjgEUHInDC9sHINlnmAPEelP5F6nMO2YDl2CmT6S81wvEJrAhb2NNknOx2eBNagDULk1xP2a5dSM3I2h1525J5eCWj/q9HZetk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738831582; c=relaxed/simple;
	bh=IAiTciPvdIP2WnYFSwJejvd1JoLA6W0q2++HzT6PUjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2aSoKkYC5X9asbaDscIVVgqSW3sShI6iQyrwwG22/3NxwDnWkzL5UBX4K+rXjlnCvAgORTeowdU9G26mw+0ezNYQ/ZZYXR0cYuzPpP9pc6XIZrKuYU0F50EAz5z1DJtmEY/9VCimeaaRcrcPYx9ayq/AO0Dt+6dUrO2SP1T+9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpdJp5PT; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6f768e9be1aso15044167b3.0;
        Thu, 06 Feb 2025 00:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738831579; x=1739436379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3XBaUKrT/1hQhJVYaeQ/iTYgSEZTAUQE8cvCrT/xK8=;
        b=FpdJp5PTzQyIGR6ZONzJTaR+Gdo5/qDAba0Lwb5zNJkrUqV9KDQz6aSJkwgSmafLC1
         v0ls6h6UaEtyyQmzWFdnFHjmzrS+A3dynuCZvDa66fQxSDeMU1PHYiO6R7/BeUBjp2Td
         PKarr9U0lsywds9Rbfxec9ZNNghDKSV3MJ8eomQRFacXKdW+eE2Z/zIwhIhbtYEaZ102
         G75ZIlHHrumF7aymWXzz88wksDFVqDeDI/bT3AIcH7yGrnis2xhOPpSLaWeJvbQDVmGe
         xS4RaLgnuzPAfYhkrVpmh7FFJYpfQWWuCZAjQgIw62JHBviec7lbzZtAD2HKQb9leAsL
         bTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738831579; x=1739436379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3XBaUKrT/1hQhJVYaeQ/iTYgSEZTAUQE8cvCrT/xK8=;
        b=AdCoL/CND8Gp9gsZC87DAOvzI9priKSeo2NnJxM3+j3rKsNb2WcFrtzkBrN0XjGY1t
         GAcTVuncqROoMKXfIQeBMKzHIoEbuOquIf+gpfOv8Na1twqMixdmltftuS3E2KDe1/Z7
         exFmy/7UK2yXZiFsXEKsDhSWgjthEXn/bdvxMrKYLGyVE+01wr3bV559TZX7o+uN96PI
         ZY51QHFbSfFyaJvizq7vgObKn1N0eUHLRtmVBMpheT2DdfLeqMw5SdJ+kWSYV+sHLh45
         vTMRB5mK2tFkgl3+l7x+D2Pk82eYB67Vqc7ddgBLeC5N6Oa/XEvvIPuGxTa82tc0l34D
         ph+g==
X-Forwarded-Encrypted: i=1; AJvYcCUb1Kx9gkXSNB1LqgSWwvsNj2SIGt/7ezF6pXRZFt7cYu5xar5bzNKVV09Rbbt+QbB+ygk8cuUl@vger.kernel.org, AJvYcCUfW4BaqdffXMMmxFAYZ4LsZ4AVBFlEiCinNM79ndeZgLgGmSS3eb1zKONWos7j45n5HjUSRHQXuOE=@vger.kernel.org, AJvYcCWJHozFuwESzPtrFL/qkD/5DnrMkeR0jcJmzQ7t6l0jg1FycKxF6rrlfL3PXnmGTabVqG9d67YSaDNlJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyX0I/ryVu0F0FmR34I/kxCJ5gZpPCNefAsWnwa26WlqkLBHicu
	x5rsBwPhqKWy5rQ96it62RMZRpEbUMylsnBEjrtytgQlZT6mgKotw5o8JFPbKSSMEzktnsoCYpH
	a/WCd3Nnz+rLcG5GTwE8hZEcQmMA=
X-Gm-Gg: ASbGnctCUm533pWPXvfSL8NnzkpfrF9WhjzzIWhl2LLyqMeE5LoXceqqO55haGKHqOU
	VlkTl1NZKEFPZYpZl87uTAMDYJ/crrnwGrSdmBLPiBQBVrPY3Kf7lbvkcmLdUn3yoZI5DXNk1
X-Google-Smtp-Source: AGHT+IHlYR0Zc+BAJP/A0hhKu9kjrN2V2QsyHX5Z8jg+7GABYOGH/px7fkCyHAuejCjFPZU4qbzWOL2mVuYSGnHzdSI=
X-Received: by 2002:a05:690c:62c1:b0:6f7:9f95:d916 with SMTP id
 00721157ae682-6f99a618f37mr23145587b3.16.1738831579416; Thu, 06 Feb 2025
 00:46:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738778580.git.leon@kernel.org> <e536ca28cd1686dfbb613de7ccfc01fbe5a734e4.1738778580.git.leon@kernel.org>
In-Reply-To: <e536ca28cd1686dfbb613de7ccfc01fbe5a734e4.1738778580.git.leon@kernel.org>
From: Bharat Bhushan <bharatb.linux@gmail.com>
Date: Thu, 6 Feb 2025 14:16:08 +0530
X-Gm-Features: AWEUYZmguP9vZm_NGHalzZfLh9uJ-aw1wjN_NXnWeY6O7H3_MnQ8VHc2Z6HpMSk
Message-ID: <CAAeCc_kfRt8LhKgRmLsaaSmJs94hjH85DxCjEnJA6OQc5S5XXw@mail.gmail.com>
Subject: Re: [PATCH ipsec-next 1/5] xfrm: delay initialization of offload path
 till its actually requested
To: Leon Romanovsky <leon@kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>, Eric Dumazet <edumazet@google.com>, 
	Geetha sowjanya <gakula@marvell.com>, hariprasad <hkelam@marvell.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, intel-wired-lan@lists.osuosl.org, 
	Jakub Kicinski <kuba@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>, Jonathan Corbet <corbet@lwn.net>, 
	linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Louis Peens <louis.peens@corigine.com>, netdev@vger.kernel.org, oss-drivers@corigine.com, 
	Paolo Abeni <pabeni@redhat.com>, Potnuri Bharat Teja <bharat@chelsio.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Subbaraya Sundeep <sbhatta@marvell.com>, Sunil Goutham <sgoutham@marvell.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Ilia Lin <ilia.lin@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Leon,

On Wed, Feb 5, 2025 at 11:50=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> From: Leon Romanovsky <leonro@nvidia.com>
>
> XFRM offload path is probed even if offload isn't needed at all. Let's
> make sure that x->type_offload pointer stays NULL for such path to
> reduce ambiguity.
>
> Fixes: 9d389d7f84bb ("xfrm: Add a xfrm type offload.")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  include/net/xfrm.h     | 12 +++++++++++-
>  net/xfrm/xfrm_device.c | 14 +++++++++-----
>  net/xfrm/xfrm_state.c  | 22 +++++++++-------------
>  net/xfrm/xfrm_user.c   |  2 +-
>  4 files changed, 30 insertions(+), 20 deletions(-)
>
> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index ed4b83696c77..28355a5be5b9 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -464,6 +464,16 @@ struct xfrm_type_offload {
>
>  int xfrm_register_type_offload(const struct xfrm_type_offload *type, uns=
igned short family);
>  void xfrm_unregister_type_offload(const struct xfrm_type_offload *type, =
unsigned short family);
> +const struct xfrm_type_offload *xfrm_get_type_offload(u8 proto,
> +                                                     unsigned short fami=
ly);
> +static inline void xfrm_put_type_offload(const struct xfrm_type_offload =
*type)
> +{
> +       if (!type)
> +               return;
> +
> +       module_put(type->owner);
> +}
> +
>
>  /**
>   * struct xfrm_mode_cbs - XFRM mode callbacks
> @@ -1760,7 +1770,7 @@ void xfrm_spd_getinfo(struct net *net, struct xfrmk=
_spdinfo *si);
>  u32 xfrm_replay_seqhi(struct xfrm_state *x, __be32 net_seq);
>  int xfrm_init_replay(struct xfrm_state *x, struct netlink_ext_ack *extac=
k);
>  u32 xfrm_state_mtu(struct xfrm_state *x, int mtu);
> -int __xfrm_init_state(struct xfrm_state *x, bool init_replay, bool offlo=
ad,
> +int __xfrm_init_state(struct xfrm_state *x, bool init_replay,
>                       struct netlink_ext_ack *extack);
>  int xfrm_init_state(struct xfrm_state *x);
>  int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_t=
ype);
> diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> index d1fa94e52cea..e01a7f5a4c75 100644
> --- a/net/xfrm/xfrm_device.c
> +++ b/net/xfrm/xfrm_device.c
> @@ -244,11 +244,6 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_=
state *x,
>         xfrm_address_t *daddr;
>         bool is_packet_offload;
>
> -       if (!x->type_offload) {
> -               NL_SET_ERR_MSG(extack, "Type doesn't support offload");
> -               return -EINVAL;
> -       }
> -
>         if (xuo->flags &
>             ~(XFRM_OFFLOAD_IPV6 | XFRM_OFFLOAD_INBOUND | XFRM_OFFLOAD_PAC=
KET)) {
>                 NL_SET_ERR_MSG(extack, "Unrecognized flags in offload req=
uest");
> @@ -310,6 +305,13 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_=
state *x,
>                 return -EINVAL;
>         }
>
> +       x->type_offload =3D xfrm_get_type_offload(x->id.proto, x->props.f=
amily);
> +       if (!x->type_offload) {
> +               NL_SET_ERR_MSG(extack, "Type doesn't support offload");
> +               dev_put(dev);
> +               return -EINVAL;
> +       }
> +
>         xso->dev =3D dev;
>         netdev_tracker_alloc(dev, &xso->dev_tracker, GFP_ATOMIC);
>         xso->real_dev =3D dev;
> @@ -332,6 +334,8 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_s=
tate *x,
>                 netdev_put(dev, &xso->dev_tracker);
>                 xso->type =3D XFRM_DEV_OFFLOAD_UNSPECIFIED;
>
> +               xfrm_put_type_offload(x->type_offload);
> +               x->type_offload =3D NULL;

We always set type_offload to NULL. Can we move type_offload =3D NULL in
xfrm_put_type_offload() ?

Thanks
-Bharat

>                 /* User explicitly requested packet offload mode and conf=
igured
>                  * policy in addition to the XFRM state. So be civil to u=
sers,
>                  * and return an error instead of taking fallback path.
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index ad2202fa82f3..568fe8df7741 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -424,11 +424,12 @@ void xfrm_unregister_type_offload(const struct xfrm=
_type_offload *type,
>  }
>  EXPORT_SYMBOL(xfrm_unregister_type_offload);
>
> -static const struct xfrm_type_offload *
> -xfrm_get_type_offload(u8 proto, unsigned short family, bool try_load)
> +const struct xfrm_type_offload *xfrm_get_type_offload(u8 proto,
> +                                                     unsigned short fami=
ly)
>  {
>         const struct xfrm_type_offload *type =3D NULL;
>         struct xfrm_state_afinfo *afinfo;
> +       bool try_load =3D true;
>
>  retry:
>         afinfo =3D xfrm_state_get_afinfo(family);
> @@ -456,11 +457,7 @@ xfrm_get_type_offload(u8 proto, unsigned short famil=
y, bool try_load)
>
>         return type;
>  }
> -
> -static void xfrm_put_type_offload(const struct xfrm_type_offload *type)
> -{
> -       module_put(type->owner);
> -}
> +EXPORT_SYMBOL(xfrm_get_type_offload);
>
>  static const struct xfrm_mode xfrm4_mode_map[XFRM_MODE_MAX] =3D {
>         [XFRM_MODE_BEET] =3D {
> @@ -609,8 +606,6 @@ static void ___xfrm_state_destroy(struct xfrm_state *=
x)
>         kfree(x->coaddr);
>         kfree(x->replay_esn);
>         kfree(x->preplay_esn);
> -       if (x->type_offload)
> -               xfrm_put_type_offload(x->type_offload);
>         if (x->type) {
>                 x->type->destructor(x);
>                 xfrm_put_type(x->type);
> @@ -784,6 +779,9 @@ void xfrm_dev_state_free(struct xfrm_state *x)
>         struct xfrm_dev_offload *xso =3D &x->xso;
>         struct net_device *dev =3D READ_ONCE(xso->dev);
>
> +       xfrm_put_type_offload(x->type_offload);
> +       x->type_offload =3D NULL;
> +
>         if (dev && dev->xfrmdev_ops) {
>                 spin_lock_bh(&xfrm_state_dev_gc_lock);
>                 if (!hlist_unhashed(&x->dev_gclist))
> @@ -3122,7 +3120,7 @@ u32 xfrm_state_mtu(struct xfrm_state *x, int mtu)
>  }
>  EXPORT_SYMBOL_GPL(xfrm_state_mtu);
>
> -int __xfrm_init_state(struct xfrm_state *x, bool init_replay, bool offlo=
ad,
> +int __xfrm_init_state(struct xfrm_state *x, bool init_replay,
>                       struct netlink_ext_ack *extack)
>  {
>         const struct xfrm_mode *inner_mode;
> @@ -3178,8 +3176,6 @@ int __xfrm_init_state(struct xfrm_state *x, bool in=
it_replay, bool offload,
>                 goto error;
>         }
>
> -       x->type_offload =3D xfrm_get_type_offload(x->id.proto, family, of=
fload);
> -
>         err =3D x->type->init_state(x, extack);
>         if (err)
>                 goto error;
> @@ -3229,7 +3225,7 @@ int xfrm_init_state(struct xfrm_state *x)
>  {
>         int err;
>
> -       err =3D __xfrm_init_state(x, true, false, NULL);
> +       err =3D __xfrm_init_state(x, true, NULL);
>         if (!err)
>                 x->km.state =3D XFRM_STATE_VALID;
>
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index 08c6d6f0179f..82a768500999 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -907,7 +907,7 @@ static struct xfrm_state *xfrm_state_construct(struct=
 net *net,
>                         goto error;
>         }
>
> -       err =3D __xfrm_init_state(x, false, attrs[XFRMA_OFFLOAD_DEV], ext=
ack);
> +       err =3D __xfrm_init_state(x, false, extack);
>         if (err)
>                 goto error;
>
> --
> 2.48.1
>
>

