Return-Path: <linux-rdma+bounces-13801-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0394BC58DD
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Oct 2025 17:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B39119E346B
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Oct 2025 15:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3402F28EC;
	Wed,  8 Oct 2025 15:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nEImfvoi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F172ED16B
	for <linux-rdma@vger.kernel.org>; Wed,  8 Oct 2025 15:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759936911; cv=none; b=sgB61Gnb94YSX+FazY7Pag96nxVwYujNUdSjvXojZiOlpZoTk9Jafs9Hhql9iZ3CqZZOGE+z4B3GtZ9PVrqfCY5miow3hVBfgCJdf1fFDqrX3cPjn6xtCrgRa7SYGBPEDtefMnzbjGb0hlVnphfPZ/LLXTTP4+WeiXI/dn3hvs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759936911; c=relaxed/simple;
	bh=ecKGtBcssmAsD25710NuJEJAaZrg9hPPYN3pFhCJ6AY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X1EdHj5XEQStWSAksULV0olH2V/9AkXo6/oRkORmksmcG57HmkqAnSWl5XZQ5G8S8sFqhuUJh+Zg68G6DMUXSDQaGQJBgsohY4CmAthvn/cX2buFob+ksPBsgjZ4B21RTcjiRmPF2kCQey7cpPJK0yxPgwcFGTHVXyYFEhhPXvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nEImfvoi; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4df81016e59so70837311cf.3
        for <linux-rdma@vger.kernel.org>; Wed, 08 Oct 2025 08:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759936909; x=1760541709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VdvcJHdCzP+y1b69oKpmC8BZe0dizJUy2NZiOnbaMhg=;
        b=nEImfvoiHSr+nE48/dD0Rat1WOHfTMqOTUWoYhNdd5VjwvInX2pH8dciCZ0vzYVi3o
         3I8Z8iFbqfDJ4ihL8WnLM3fabDkeoN7pM3KONTsxY9ZCR/u/1QajAXWTLhAiL76VvLw6
         7bfAEbY28KwdiZ234r/EwCpHhy9+NdYuT0VsliobXS3nlnLWuRFDGy1dfmp/Hk7AzPzu
         SMjPuOY4hhaTS/qFxF2XCKR+YqYC3hzIPdUWfq6qIegXRBvYzHx3BHWWDSAxooKWxqhW
         kzKnhiOQ+UoZ9DBG5rFP5SC27Q4fC5mkkKqgz0wUeRrTdZPSPQ2RHdnU8UX3dmwdN3d1
         LK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759936909; x=1760541709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VdvcJHdCzP+y1b69oKpmC8BZe0dizJUy2NZiOnbaMhg=;
        b=FnzSlOL09jTEEU1+c8Lh5irpczpMbSQZqZjZfviFvDzmbrh9dKbAX3lLKWDFn+pk0z
         +C9+ZKSv2ZW3OwLn/65XWOHnpQuQdtWuKN2oB5mfu1DIfQ3l29ZfEeRsbHodjjw998KV
         09XJHn2wgbrF4m1FTymxMMLeu/9axR1HANKQZqo503PiBsXVEvwssVgt/0hwMh82RWMT
         Mc/AGpKUJVaKzG4eJzrpxq/Br1gi5YHEfj6EPj1kPRikQAZcUrRRgR95laXpern+BVeC
         2xLBDwxcwOqj1fzeDKyQWGDsvGdP2XgQ2kmvLYZSV7vpDZyuoSxqsYUVfJ1Gudc9Tq2W
         xg1g==
X-Forwarded-Encrypted: i=1; AJvYcCUFWVtXSHfgC440IljxCQzf/e//osgTy8asNQ4Bqec2hczTMb/vVWJByrvzjClpZ0SOZ4ClWh8JW8lW@vger.kernel.org
X-Gm-Message-State: AOJu0YykpAvUvDZfExUBzETwTyUb575GlqQ516qLgrQVTY7z5BL7wXUq
	8cG/XHUCAu7Hgz+Mdgitq+S/wsxM9Ry+4XWpTPB1/Oyq2U4XYmGVmqTSgGu3Tz9e6RwL4ewdj2N
	W7EE/Zi8rcis5mX48SfpFYfLW4AFSyttFsCgWEzUP
X-Gm-Gg: ASbGncsaq3Mmd0wFuNQ81PvHyWprnZuPN+u0ShpVmI+900moX1yk0yh5FKlZ1cNisrL
	j/YfmXL1uy+WX32SUCVcY0h6QfUytLQAzN6MmF9YnH2Gr+gF4sljmieo21xuvQN+nqun+/fe+3s
	+T/ztDwI4axs4UoR8tD/H10WuHLZi4C7HfrTxhcPt6o0Pvd80uvuMW90NeHGIKH/ZEryXbtYsCv
	ZoaquyU9HLLtZInm1abxUr+6WBZ0rRa9xfguBrsomLx4TdJD4oTMPy9Y4s/i7Xiq1g2l33d
X-Google-Smtp-Source: AGHT+IFnCXJF7a8mwX4u6M/G/DluGiMoMcD9a0V+zOvUBJbRksBjY0SPvGpDiJoMRCeGymuah5UrwX6yMOliI6hi0gs=
X-Received: by 2002:ac8:538d:0:b0:4e6:ee34:2f0d with SMTP id
 d75a77b69052e-4e6ee342fccmr31006471cf.76.1759936908728; Wed, 08 Oct 2025
 08:21:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003154724.GA15670@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <CANn89iJwkbxC5HvSKmk807K-3HY+YR1kt-LhcYwnoFLAaeVVow@mail.gmail.com> <9d886861-2e1f-4ea8-9f2c-604243bd751b@linux.microsoft.com>
In-Reply-To: <9d886861-2e1f-4ea8-9f2c-604243bd751b@linux.microsoft.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 8 Oct 2025 08:21:37 -0700
X-Gm-Features: AS18NWA4rjzPyXivisvXLvTjcjSNyre7mla4J_1tYNcVnh0bB68GXqduG9SI-w4
Message-ID: <CANn89iKwHWdUaeAsdSuZUXG-W8XwyM2oppQL9spKkex0p9-Azw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: mana: Linearize SKB if TX SGEs exceeds
 hardware limit
To: Aditya Garg <gargaditya@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com, 
	kotaranov@microsoft.com, horms@kernel.org, shradhagupta@linux.microsoft.com, 
	ernis@linux.microsoft.com, dipayanroy@linux.microsoft.com, 
	shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, gargaditya@microsoft.com, 
	ssengar@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 8:16=E2=80=AFAM Aditya Garg
<gargaditya@linux.microsoft.com> wrote:
>
> On 03-10-2025 21:45, Eric Dumazet wrote:
> > On Fri, Oct 3, 2025 at 8:47=E2=80=AFAM Aditya Garg
> > <gargaditya@linux.microsoft.com> wrote:
> >>
> >> The MANA hardware supports a maximum of 30 scatter-gather entries (SGE=
s)
> >> per TX WQE. In rare configurations where MAX_SKB_FRAGS + 2 exceeds thi=
s
> >> limit, the driver drops the skb. Add a check in mana_start_xmit() to
> >> detect such cases and linearize the SKB before transmission.
> >>
> >> Return NETDEV_TX_BUSY only for -ENOSPC from mana_gd_post_work_request(=
),
> >> send other errors to free_sgl_ptr to free resources and record the tx
> >> drop.
> >>
> >> Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
> >> Reviewed-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> >> ---
> >>   drivers/net/ethernet/microsoft/mana/mana_en.c | 26 +++++++++++++++--=
--
> >>   include/net/mana/gdma.h                       |  8 +++++-
> >>   include/net/mana/mana.h                       |  1 +
> >>   3 files changed, 29 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/n=
et/ethernet/microsoft/mana/mana_en.c
> >> index f4fc86f20213..22605753ca84 100644
> >> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> >> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> >> @@ -20,6 +20,7 @@
> >>
> >>   #include <net/mana/mana.h>
> >>   #include <net/mana/mana_auxiliary.h>
> >> +#include <linux/skbuff.h>
> >>
> >>   static DEFINE_IDA(mana_adev_ida);
> >>
> >> @@ -289,6 +290,19 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, =
struct net_device *ndev)
> >>          cq =3D &apc->tx_qp[txq_idx].tx_cq;
> >>          tx_stats =3D &txq->stats;
> >>
> >> +       BUILD_BUG_ON(MAX_TX_WQE_SGL_ENTRIES !=3D MANA_MAX_TX_WQE_SGL_E=
NTRIES);
> >> +       #if (MAX_SKB_FRAGS + 2 > MANA_MAX_TX_WQE_SGL_ENTRIES)
> >> +               if (skb_shinfo(skb)->nr_frags + 2 > MANA_MAX_TX_WQE_SG=
L_ENTRIES) {
> >> +                       netdev_info_once(ndev,
> >> +                                        "nr_frags %d exceeds max supp=
orted sge limit. Attempting skb_linearize\n",
> >> +                                        skb_shinfo(skb)->nr_frags);
> >> +                       if (skb_linearize(skb)) {
> >
> > This will fail in many cases.
> >
> > This sort of check is better done in ndo_features_check()
> >
> > Most probably this would occur for GSO packets, so can ask a software
> > segmentation
> > to avoid this big and risky kmalloc() by all means.
> >
> > Look at idpf_features_check()  which has something similar.
>
> Hi Eric,
> Thank you for your review. I understand your concerns regarding the use
> of skb_linearize() in the xmit path, as it can fail under memory
> pressure and introduces additional overhead in the transmit path. Based
> on your input, I will work on a v2 that will move the SGE limit check to
> the ndo_features_check() path and for GSO skbs exceding the hw limit
> will disable the NETIF_F_GSO_MASK to enforce software segmentation in
> kernel before the call to xmit.
> Also for non GSO skb exceeding the SGE hw limit should we go for using
> skb_linearize only then or would you suggest some other approach here?

I think that for non GSO, the linearization attempt is fine.

Note that this is extremely unlikely for non malicious users,
and MTU being usually small (9K or less),
the allocation will be much smaller than a GSO packet.

