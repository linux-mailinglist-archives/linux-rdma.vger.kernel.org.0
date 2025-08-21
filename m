Return-Path: <linux-rdma+bounces-12863-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E93B309B4
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 00:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24FE620DE9
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Aug 2025 22:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C1C2E9EAC;
	Thu, 21 Aug 2025 22:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="IgKfbTV+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A562D7DE1
	for <linux-rdma@vger.kernel.org>; Thu, 21 Aug 2025 22:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755817184; cv=none; b=aqtiFnYu8gXgIddnkXG1ds9PcGKf/FGXbkKpGT+eC/flummiAY751FLnt2yEj1WBnXDHMnJdtKBwXVLM8qcP0xeVuUqCUsczHWBkFgS1zBjRPh57YXdHDTwIJ3X/MGQVA3yoBtUtZK6riZlvPkoqQ9P/vWWzZ4bVuZQg4ieBMJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755817184; c=relaxed/simple;
	bh=yxDOO9UuJTgm7GnRUIkjV6RDjLlytWBOXaWxIMHzX2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tbyt6JemwASA7Z7fQuvjj/jrlVHDiE/kRyqy+F/8UEOWn5l1oyQaebw6V/VD/seNi4u9kIx3LdzuMXphrmWweMLj0BcXaycfqQvZUy56LBYgySmuY+A89XXLmdRuSntEoEmFuVFCNRzSoDL09c9hORjZUXMqDfT4/YJ8smbaspQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=IgKfbTV+; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-333f92d682bso12631021fa.3
        for <linux-rdma@vger.kernel.org>; Thu, 21 Aug 2025 15:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1755817180; x=1756421980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LS+hI7j6rloI0x5/njHW4ZZUbpoU+gH5BK6q7Ls9zmo=;
        b=IgKfbTV+eFWCjjtWb4ahABsGmnnwWXqgs87DvlBHI7zSLJpP3UFbegDE9Fc26vb6Ni
         xsPUxuIcpsz89N+xtgLetYhw+seiisJJifX3N2KzM/4/N/y3pPORrsf9MBDnvB2SmPq6
         wozsBd9ZHMW2wZf7CLq99aVcDa4REFIq4yW2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755817180; x=1756421980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LS+hI7j6rloI0x5/njHW4ZZUbpoU+gH5BK6q7Ls9zmo=;
        b=EHPzmqpLXRj8734Ali+4HVmKhmhINDaarhZWeO27M9vXie8+V/lDIFzwur1h/sXNNT
         8gEe3R6sjbmHmKF7qANe8kwUE2a849zycA+BHx6ltmRCunBMrJNnYzCxEgwdLJ+dieFM
         OAUoTEN6WzuVpK02x6RGK2OEMWGdDjTp8c7Iu06jKtGK9eKg45bDlYr5eRQ587d4+rb+
         Q/U5jaNGDZWnYZC7YLZp68psojQGrCreq7fJqczwvgDyu6P8Vc8qULRuA2dWbREQ1o8X
         M+KFf+Ha/NEGUMbcM3fNw6Ff0+gp+iZdj02fUtUoLpyz54hykEh7L/V69cP42TAa54Ro
         MFvA==
X-Forwarded-Encrypted: i=1; AJvYcCXN1es8/nBUqmj/HR/FCx6DkOzIFKFmkmVJ0Uj34ECVrsBq5parQZ5fr1sjNo5GOQy9TsVQjjoXXgGZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwwVzDXkNaQyi7koj01Rg/mRjaG2fcyFeQDvClwtarHUsJPqqjM
	fHkGxk31teq6KJXgZEaXgiG1AcBPWYaJ97sa7rDs9kLe7ZSaON3LMihkpFqPy8WOxP33dV3I7IL
	STrwMhGsFO5tuZqw/KDNVcn4rhiOsX8vbo7JOe70o8g==
X-Gm-Gg: ASbGncvJxK+aw2O+gbPXUiyZQmEwdqQFrEA0FjKvOS/iLMERdnAK8COoHd7Cda1FQ91
	rKYAjJIZPz+5X0+J/rihEdXbjefk16DAWlJgv0PAzV+zEmWYNgn5x4dzz1naJzfwhMNdITnCTMR
	xx8EffulcF/GRYtavw6Shwbz/zm3HYBcS7OO14IqI7xIKOZXZ7yKqbXxPRV/SRPaVbzxXsyGJTw
	Covdk4b5KPzlKUuqOUe8qC1VsUnHlUvIsTK6cyMnKeowPrzKtkBBr/v+L4tGwc=
X-Google-Smtp-Source: AGHT+IFktp37fZovN1VW+3Y8td0N1JNBmuFdxFgOZgHKlsmmyWjIbeeNnFdC4BYyNz6sf0RIy5CALsax2Cu2eiA20HE=
X-Received: by 2002:a2e:9087:0:b0:32b:7ce4:be22 with SMTP id
 38308e7fff4ca-33650f3dcf8mr1973981fa.27.1755817180560; Thu, 21 Aug 2025
 15:59:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250816-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v2-0-b11b30bc2d10@openai.com>
 <20250816-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v2-2-b11b30bc2d10@openai.com>
 <6dguqontvbisoypbfxw5xyscyqhvskk5avf7gwqgwajc4ic75a@id3pume2f4hw> <20250819171505.4ebbac36@kernel.org>
In-Reply-To: <20250819171505.4ebbac36@kernel.org>
From: Christoph Paasch <cpaasch@openai.com>
Date: Thu, 21 Aug 2025 15:59:29 -0700
X-Gm-Features: Ac12FXyKesdKjuswg80zK_q7kZhV_1jNFCS4hNzofJVDACG1mUgrvsrJlrInegE
Message-ID: <CADg4-L__JBO8j4tVnG8-DxCdmbUWQQqXjgb1W3qb4=29F1c=HA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net/mlx5: Avoid copying payload to the
 skb's linear part
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Gal Pressman <gal@nvidia.com>, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 5:15=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 19 Aug 2025 09:58:54 +0000 Dragos Tatulea wrote:
> > > @@ -2009,10 +2040,14 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx=
5e_rq *rq, struct mlx5e_mpw_info *w
> > >     u32 linear_frame_sz;
> > >     u16 linear_data_len;
> > >     u16 linear_hr;
> > > +   u16 headlen;
> > >     void *va;
> > >
> > >     prog =3D rcu_dereference(rq->xdp_prog);
> > >
> > > +   headlen =3D min3(mlx5e_cqe_estimate_hdr_len(cqe), cqe_bcnt,
> > > +                  (u16)MLX5E_RX_MAX_HEAD);
> > > +
> > How about keeping the old calculation for XDP and do this one for
> > non-xdp in the following if/else block?
> >
> > This way XDP perf will not be impacted by the extra call to
> > mlx5e_cqe_estimate_hdr_len().
>
> Perhaps move it further down for XDP?
> Ideally attaching a program which returns XDP_PASS shouldn't impact
> normal TCP perf.

Yes, makes sense!

Will do that and resubmit.


Thanks,
Christoph

