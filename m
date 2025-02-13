Return-Path: <linux-rdma+bounces-7692-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBDFA333DD
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 01:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86BBD3A88AE
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 00:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1CA4A01;
	Thu, 13 Feb 2025 00:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EsMkzTfH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A888BEE
	for <linux-rdma@vger.kernel.org>; Thu, 13 Feb 2025 00:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739405455; cv=none; b=DHD01ov3Oei+CZ+5SNDhJRaXTQQjvke8KlGHZwgz1bHSmpeP3d4OrpjNMgxNnX/VDv6+m8653ug7lnGZMoP/714NHvxzwl0jQBG0RDvOc3HwwBCR2tCu5PWr4Nd7yGVZl+QVGwsuLTCBkjVccKsetEx0lF8Qgmlv4fUXUYtNI2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739405455; c=relaxed/simple;
	bh=SifCzjX4GY5GN2rUJ8a5yh5rfxDC24HGCOd98DeaIb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7AnC84eorpOEE3SBo84jnwAcZC9aQHxF4ywib7GUIOgnwSz+3dIH5KL+1xXDIckZOGeKbi87YeAk0obN5Ycjh88csusr4T8HXjx5Q2MzNAGyaTje8ifMV2iR20E9Do/g4BeErQcwl6eyLwZ6L3RAHVvPeUFesjx3DWOMzNeQGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EsMkzTfH; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4bb0e7e6cceso54541137.1
        for <linux-rdma@vger.kernel.org>; Wed, 12 Feb 2025 16:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739405452; x=1740010252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+WfHu/v5u/KfWiPWoeUIJ/AgU1PcO3O1k2ZFWW7w5c=;
        b=EsMkzTfHZfKB8K2EWd4Cf1dwoDqLwkqBc5i0SbeyEeZG4DMz20nWPT10xodcREXCQ5
         NPaN9UGXB9apCvROxz8FfI8hptTTNaJtsu2Mjv8X6SVYoToUEWI2BckhaVyfze+1ukOF
         6THGobEFoAZAMUD2vL/GiN2MReNLSzLJXtm2DZyOS1ulJTsbghlpMuOLPWdbCfkShKIC
         CplAZGNVF8qBtslAkTifgMwcBQ+vzv3wo0vcTs9o30zD6bCN96K2uTIiHpIKKjwgEvsM
         IEZnqoz8haawfWup/d/rrFIuHm65zYeKYsgS5QXrNRDHU812FFQwl1LqeifO6MzI8N1m
         YKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739405452; x=1740010252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+WfHu/v5u/KfWiPWoeUIJ/AgU1PcO3O1k2ZFWW7w5c=;
        b=jhhCv2r6LLvSXQbd6oyuS8cLFsDGB/RM9un9FKzz5P4VzVBxhE6CsmjaY/IAUzspx0
         ml+ECVgxXQLJonG38jBhy6CeIu2sNxGbJyuct+g/lGHitBkBiSn23CMYR3F5f1irpwzF
         mDTQSk2uP2kyTXgppvQ28+eYzVuIA2yqsRyq21f7kGIePH/vFOTq0wg/BKl1C6EYd/ge
         83DD1iv/c55SLXUVR5Xc+mcscQBGVsztQLmYMXnAUfCwsN4EUdkI74zIULC5R0rDfgtG
         1BuWfI7RWSixhPdF0SCl14kp5dq9XL1gScaffYOmY7r9mKI7QuoNBLiP9J7N6DrPLNQd
         l9Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWjV5OOHWpYIQT/mJaSJefGRCOHO4J3eVLRJyls/lM7ISbIstkizX5zCbvOv8QzQQAFOq7WEgE5ojHz@vger.kernel.org
X-Gm-Message-State: AOJu0YyB3tBBaW7n2KW4EEZUlhPJJMlHVKr3HXT0ncFaNkJlLTu0MRY7
	DLCGxnnC5QiOFJcv5G1EDKB7M2z400BYb8BqfFpzVvbjGa1+FQQkwCsJPqNLj1DndU2U/6BChMf
	r2ev91ZEJPe2vZQXgnnmZZOTontlUFOu65PRt
X-Gm-Gg: ASbGncuq0eLuDvBCFUNvitspWrXOPvkjDnAjghsKy2aIlDSMu4xk/NKBPFYuBWWFE0E
	CVElI6aqDgHanvl4FIwu5NdLOH+jAbG97xVo7TB9RK8h0Vkue8uW6yGBlR2loAE5f4oMuk5jAU5
	YN6R4Xe4W8J+3EX7kDoDnW9Fefzw==
X-Google-Smtp-Source: AGHT+IEUmixnq02JlWKfwvEaLZDC3tHu+8a5G6UODHmdG4Lm1heidGpNx7OzILYgZRHUPwr+ZA1zRmmMlpPG+CZd8NQ=
X-Received: by 2002:a05:6102:2ad4:b0:4bb:5d61:1288 with SMTP id
 ada2fe7eead31-4bbf231f56fmr6157553137.23.1739405452181; Wed, 12 Feb 2025
 16:10:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210174504.work.075-kees@kernel.org> <3biiqfwwvlbkvo5tx56nmcl4rzbq5w7u3kxn5f5ctwsolxpubo@isskxigmypwz>
 <d11de4d4-1205-43d0-8a7d-a43d55a4f3eb@gmail.com>
In-Reply-To: <d11de4d4-1205-43d0-8a7d-a43d55a4f3eb@gmail.com>
From: Justin Stitt <justinstitt@google.com>
Date: Wed, 12 Feb 2025 16:10:40 -0800
X-Gm-Features: AWEUYZktjfLB0-Uv9mkLV-i_REAZ7bFxF9SxqOc292IN5aDUReN9RqbNh26rT8M
Message-ID: <CAFhGd8om_1W7inq+V4a4EP3e5y1y+qw7C3wi3DR4WpspYzZenQ@mail.gmail.com>
Subject: Re: [PATCH] net/mlx4_core: Avoid impossible mlx4_db_alloc() order value
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Yishai Hadas <yishaih@nvidia.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 6:22=E2=80=AFAM Tariq Toukan <ttoukan.linux@gmail.c=
om> wrote:
>
>
>
> On 11/02/2025 2:01, Justin Stitt wrote:
> > On Mon, Feb 10, 2025 at 09:45:05AM -0800, Kees Cook wrote:
> >> GCC can see that the value range for "order" is capped, but this leads
> >> it to consider that it might be negative, leading to a false positive
> >> warning (with GCC 15 with -Warray-bounds -fdiagnostics-details):
> >>
> >> ../drivers/net/ethernet/mellanox/mlx4/alloc.c:691:47: error: array sub=
script -1 is below array bounds of 'long unsigned int *[2]' [-Werror=3Darra=
y-bounds=3D]
> >>    691 |                 i =3D find_first_bit(pgdir->bits[o], MLX4_DB_=
PER_PAGE >> o);
> >>        |                                    ~~~~~~~~~~~^~~
> >>    'mlx4_alloc_db_from_pgdir': events 1-2
> >>    691 |                 i =3D find_first_bit(pgdir->bits[o], MLX4_DB_=
PER_PAGE >> o);                        |                     ^~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>        |                     |                         |              =
                                     |                     |               =
          (2) out of array bounds here
> >>        |                     (1) when the condition is evaluated to tr=
ue                             In file included from ../drivers/net/etherne=
t/mellanox/mlx4/mlx4.h:53,
> >>                   from ../drivers/net/ethernet/mellanox/mlx4/alloc.c:4=
2:
> >> ../include/linux/mlx4/device.h:664:33: note: while referencing 'bits'
> >>    664 |         unsigned long          *bits[2];
> >>        |                                 ^~~~
> >>
> >> Switch the argument to unsigned int, which removes the compiler needin=
g
> >> to consider negative values.
> >>
> >> Signed-off-by: Kees Cook <kees@kernel.org>
> >> ---
> >> Cc: Tariq Toukan <tariqt@nvidia.com>
> >> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> >> Cc: "David S. Miller" <davem@davemloft.net>
> >> Cc: Eric Dumazet <edumazet@google.com>
> >> Cc: Jakub Kicinski <kuba@kernel.org>
> >> Cc: Paolo Abeni <pabeni@redhat.com>
> >> Cc: Yishai Hadas <yishaih@nvidia.com>
> >> Cc: netdev@vger.kernel.org
> >> Cc: linux-rdma@vger.kernel.org
> >> ---
> >>   drivers/net/ethernet/mellanox/mlx4/alloc.c | 6 +++---
> >>   include/linux/mlx4/device.h                | 2 +-
> >>   2 files changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/mellanox/mlx4/alloc.c b/drivers/net/=
ethernet/mellanox/mlx4/alloc.c
> >> index b330020dc0d6..f2bded847e61 100644
> >> --- a/drivers/net/ethernet/mellanox/mlx4/alloc.c
> >> +++ b/drivers/net/ethernet/mellanox/mlx4/alloc.c
> >> @@ -682,9 +682,9 @@ static struct mlx4_db_pgdir *mlx4_alloc_db_pgdir(s=
truct device *dma_device)
> >>   }
> >>
> >>   static int mlx4_alloc_db_from_pgdir(struct mlx4_db_pgdir *pgdir,
> >> -                                struct mlx4_db *db, int order)
> >> +                                struct mlx4_db *db, unsigned int orde=
r)
> >>   {
> >> -    int o;
> >> +    unsigned int o;
> >>      int i;
> >>
> >>      for (o =3D order; o <=3D 1; ++o) {
> >
> >    ^ Knowing now that @order can only be 0 or 1 can this for loop (and
> >    goto) be dropped entirely?
> >
>
> Maybe I'm missing something...
> Can you please explain why you think this can be dropped?

I meant "rewritten to use two if statements" instead of "dropped". I
think "replaced" or "refactored" was the word I wanted.

>
>
> >    The code is already short and sweet so I don't feel strongly either
> >    way.
> >
> >> @@ -712,7 +712,7 @@ static int mlx4_alloc_db_from_pgdir(struct mlx4_db=
_pgdir *pgdir,
> >>      return 0;
> >>   }
> >>
> >> -int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, int order=
)
> >> +int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, unsigned =
int order)
> >>   {
> >>      struct mlx4_priv *priv =3D mlx4_priv(dev);
> >>      struct mlx4_db_pgdir *pgdir;
> >> diff --git a/include/linux/mlx4/device.h b/include/linux/mlx4/device.h
> >> index 27f42f713c89..86f0f2a25a3d 100644
> >> --- a/include/linux/mlx4/device.h
> >> +++ b/include/linux/mlx4/device.h
> >> @@ -1135,7 +1135,7 @@ int mlx4_write_mtt(struct mlx4_dev *dev, struct =
mlx4_mtt *mtt,
> >>   int mlx4_buf_write_mtt(struct mlx4_dev *dev, struct mlx4_mtt *mtt,
> >>                     struct mlx4_buf *buf);
> >>
> >> -int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, int order=
);
> >> +int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, unsigned =
int order);
> >>   void mlx4_db_free(struct mlx4_dev *dev, struct mlx4_db *db);
> >>
> >>   int mlx4_alloc_hwq_res(struct mlx4_dev *dev, struct mlx4_hwq_resourc=
es *wqres,
> >> --
> >> 2.34.1
> >>
> >
> > Justin
> >
>

