Return-Path: <linux-rdma+bounces-10694-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4A4AC35FC
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 19:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11E4A173477
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 17:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9D024A058;
	Sun, 25 May 2025 17:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mPtDb4eN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3772613FD86
	for <linux-rdma@vger.kernel.org>; Sun, 25 May 2025 17:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748195099; cv=none; b=US2I6znYuBgiEGVG/1j7HeJL+HmDCfi/misav61i582MxjTFNkCw52k/DSG2GsKdB0V+JPl2Np5FH9aX5DoNZtiqsR/6QNpCCpEjdO6Jby0l9NK8XQlAGkinWxcdIu2sAvT2hfM3vQtqGryuZBZ4vvVjoF9iPY7ZHV+PN8IbbMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748195099; c=relaxed/simple;
	bh=nWsLzmIJWGS1Xl7vBXPSHkgM/qkaZf1/zzniqjOnEvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ToeouRRQ+4btDv5d7IXsfcANkkb1SjCsBWVRqrZ8vY3y887DSwk2lFsXh22RqIoPM26s5yarfIxphH+2st1GJF6WNA0cjOGfCCgNYvSHSRQGGyydziOWpAFPMR+EBfuCXbkG4umHRHmT1u2rcstikqv02XBzBFdt25Vzx0x9Zc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mPtDb4eN; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-231ba6da557so208235ad.1
        for <linux-rdma@vger.kernel.org>; Sun, 25 May 2025 10:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748195097; x=1748799897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IANK8/D/9AjR/6N4kd6bQcHsSXv8BeLUuMW3H+pxVUU=;
        b=mPtDb4eNBivZF0hJDssGRtx7CJDaZX7hVn3Ay+TSjnT0SQE/Xopvv3EMLrb7wuVQWm
         ZHJGLFEtVYnIFjAAN2FevnIQPDH87PKdWhzwuif/hxapidQ3q2TXT5hZ6UMK1tB97+Mx
         F133VItWdsnuhvUD6GN7xRHf8irqBsbvXLGcvZLY7t5nQDgxy/9u7I3rPUGAsqY0bUHm
         8TsDLQedK8sac4CmB3Y8u4WX3vtJnKuaMc3Q4RYdsbmzqVeSzW+Tggr8x3g1ZWb+zn3p
         3RC28c6PoSb4YARXBZTmogAQh4ESIsc2CDrvDd3CRvGydpI4XGGH4eb/s34MS7IOKTGm
         OAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748195097; x=1748799897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IANK8/D/9AjR/6N4kd6bQcHsSXv8BeLUuMW3H+pxVUU=;
        b=r4ugxpoCshaUXRrdzJ6e+62zkvJle5ZGkemI3DusjKXomb9OlmDJVu1kCsOzIoTxs1
         /c6KxrzYM5XuML85O1Tpc/DLSVX4CJ6cIjIuQiLrNLumNU9Oz2UoZ3LzrM7CEXa4DxET
         ZpK72SsGO7AdhSxibyzXREXQQZPzzlKfAkyivWG6KxWtuk8LZqX7lzi1B3uaCxgpIbxz
         5VB8GVo0WTO4B6d4LJbJZCX2TxvyGJYwoK54s/AJroNVM/eRiokQKTN452xFniU1K863
         x88JzJMH+QzawKUyTA1/Tk227kLgdz/oaDV/fboKticZQUywSVyM50CStyqmxTjuxn43
         gI4w==
X-Forwarded-Encrypted: i=1; AJvYcCU5LQfySXbqg1tYm2YK1LwJ5UaBvuodsYaplSd71ktv7z4xKfnnBztKMAxSsJMkCoJIf3d3lMl1MBvA@vger.kernel.org
X-Gm-Message-State: AOJu0YztaJ+/oqKc9ZXA0/gu1vBkDp8sqM0TnKSCp9UPOITtape5yLzw
	JBRGfCVLLx2LQm1KiaX8xCTVqPBUfb/yRNX3gQ+oki0t4JTEkKZS3SNYEccZkjJJWbiYBZer/Uv
	MGxVnzais3pSCFjHwToGblC21g8AfjcxXJqQw3aHW
X-Gm-Gg: ASbGnctr3ogabd6SkkrZ+zc+WMJhUzt1dawZn9tA/CaI5jsPWLq2BfsKZv6CaL2vWTh
	gO635Og58rfvaEqpChtBx0CR8vsgZepZFHkR3mLXWdo4ERCtvkRq8hRsRaf7wHIL+eUNkLwN0uf
	Pmlwit5Dz9OPxEUeKHW3C5XgEW8YxUD6Dpc/3dxwdfOwgw
X-Google-Smtp-Source: AGHT+IGz7qYD3MLOkzKDUyyKjvvaPiJliOPXfnWKADod9dQ7d/qlG43TQQsvx5FNMeaXBQeuBvwVCG+Tbr8M3sTA7m0=
X-Received: by 2002:a17:902:d2c9:b0:216:4d90:47af with SMTP id
 d9443c01a7336-2341b559cb1mr1954595ad.29.1748195097126; Sun, 25 May 2025
 10:44:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
 <1747950086-1246773-3-git-send-email-tariqt@nvidia.com> <CAHS8izOUs-CEAzuBrE9rz_X5XHqJmWfrar8VtzrFJrS9=8zQLw@mail.gmail.com>
 <c677zoajklqi3dg7wtnyw65licssvxxt3lmz5hvzfw3sm6w32g@pfd2ynqjkyov>
In-Reply-To: <c677zoajklqi3dg7wtnyw65licssvxxt3lmz5hvzfw3sm6w32g@pfd2ynqjkyov>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 25 May 2025 10:44:43 -0700
X-Gm-Features: AX0GCFtdXkYKEpP6898csQCklxhoo91C4IqEXyK-lWaxbO_kBhPkxPiVpqQr_ws
Message-ID: <CAHS8izMM9Hgk12zhoc+ify1MBwepqByHKC3k1gB5daH=ancgqA@mail.gmail.com>
Subject: Re: [PATCH net-next V2 02/11] net: Add skb_can_coalesce for netmem
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 25, 2025 at 6:04=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> On Thu, May 22, 2025 at 04:09:35PM -0700, Mina Almasry wrote:
> > On Thu, May 22, 2025 at 2:43=E2=80=AFPM Tariq Toukan <tariqt@nvidia.com=
> wrote:
> > >
> > > From: Dragos Tatulea <dtatulea@nvidia.com>
> > >
> > > Allow drivers that have moved over to netmem to do fragment coalescin=
g.
> > >
> > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> > > Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> > > ---
> > >  include/linux/skbuff.h | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > > index 5520524c93bf..e8e2860183b4 100644
> > > --- a/include/linux/skbuff.h
> > > +++ b/include/linux/skbuff.h
> > > @@ -3887,6 +3887,18 @@ static inline bool skb_can_coalesce(struct sk_=
buff *skb, int i,
> > >         return false;
> > >  }
> > >
> > > +static inline bool skb_can_coalesce_netmem(struct sk_buff *skb, int =
i,
> > > +                                          const netmem_ref netmem, i=
nt off)
> > > +{
> > > +       if (i) {
> > > +               const skb_frag_t *frag =3D &skb_shinfo(skb)->frags[i =
- 1];
> > > +
> > > +               return netmem =3D=3D skb_frag_netmem(frag) &&
> > > +                      off =3D=3D skb_frag_off(frag) + skb_frag_size(=
frag);
> > > +       }
> > > +       return false;
> > > +}
> > > +
> >
> > Can we limit the code duplication by changing skb_can_coalesce to call
> > skb_can_coalesce_netmem? Or is that too bad for perf?
> >
> > static inline bool skb_can_coalesce(struct sk_buff *skb, int i, const
> > struct page *page, int off) {
> >     skb_can_coalesce_netmem(skb, i, page_to_netmem(page), off);
> > }
> >
> > It's always safe to cast a page to netmem.
> >
> I think it makes sense and I don't see an issue with perf as everything
> stays inline and the cast should be free.
>
> As netmems are used only for rx and skb_zcopy() seems to be used
> only for tx (IIUC), maybe it makes sense to keep the skb_zcopy() check
> within skb_can_coalesce(). Like below. Any thoughts?
>

[net|dev]mems can now be in the TX path too:
https://lore.kernel.org/netdev/20250508004830.4100853-1-almasrymina@google.=
com/

And even without explicit TX support, IIUC from Kuba RX packets can
always be looped back to the TX path via forwarding or tc and what
not. So let's leave the skb_zcopy check in the common path for now
unless we're sure the move is safe.

--=20
Thanks,
Mina

