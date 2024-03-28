Return-Path: <linux-rdma+bounces-1658-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 644A6890D66
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Mar 2024 23:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876F71C30FEC
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Mar 2024 22:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8C013CC77;
	Thu, 28 Mar 2024 22:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZDZEVmNh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46C313AD05
	for <linux-rdma@vger.kernel.org>; Thu, 28 Mar 2024 22:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663787; cv=none; b=dD7ZCB6SsRjgUOEeNBm/CdjzInGEEDPzDqGGrudaPt5EeJa7/7BNX0WiQUFjAw3PsFot71UYxxKsHKIPS7jvDjw+8+vn/iVIoANqsb1PuF6XMlJ6+Jz62TbtJ3awvOPZPwT7IIoiWDlWyH61T/ICtu7HzEw/nnslGriMrdD2l8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663787; c=relaxed/simple;
	bh=BOXlsNwnprUececioCWqQEsiqvtUYISmlVnkC/Wl+j8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYG7qkAXIasglCyWzUs+0yyvT5lFp7+MNYOXvD7SDzSwsHgPfGyd2np2jsM8afx4JW2Cdf2sCSASi2eRZxgEF/NFS0PkW9OrydOUc7p/bVBWOEYNrHeYnOfK/JJxPjeWsSrObXs482Y1iaxTKEt5k1AwtNx/YZRCQZRr3tlgjnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZDZEVmNh; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5684db9147dso1684447a12.2
        for <linux-rdma@vger.kernel.org>; Thu, 28 Mar 2024 15:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711663784; x=1712268584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+7Drz3KCpZvZH2UsNch2VNXZc69VVimkJhVMnXEUEw=;
        b=ZDZEVmNhwPHhD5UzejDM3aaPGVPKxmhcexqbZUzE/vP+5zSqALHbf1/vqt+Et4n3ED
         H5fwD6Le23S9LvTh4QCtvP8gV1mAVHYP7fcsYmCSGHZt3JYqsjQV3I4gxcrSzZcVxsUi
         i7I41x1BGWD4I3JAUmiZAhbWv2ZfNRiOXjDfs1Yvl+Zi72gfs4yqF8T3IohNOg6QzVsc
         MMwAeBCU+JBM+qVP9WOV+HAcqiDE4v7KB4hlnZ0IIM18u0wEmSP3eHZpL6wzvsY1Es6X
         mpkuwr8nUpm0vPtIEfKTEur4gkovWgsQbpqvqS2Yzs2viDAp1RFUAKsCXhWr0Zaw1oX/
         3NSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711663784; x=1712268584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+7Drz3KCpZvZH2UsNch2VNXZc69VVimkJhVMnXEUEw=;
        b=iU1nUvzDcXcGAGkDt3yYC4yLmc76zgJFQKYO3toepVE1NKeAGkCSEU7lq7QyTa9Nlm
         LhAysEPd/1vtU4p2O7DkhiUCA108Xm1Bz8WYyPnM2Swj/z0ylxev99Ysckp7hlQBzCr8
         nWG73e3+F7+eSIXOjToNs0JpIoJDuBn++q+IvPAtpwzr6aVOFgP209fztDR3ib+fRYv7
         tMFX9FPYBJj3r1SSpG4RJkq2vMIVV+PWIfiys4VZ8Z57X/L5FCry5/KQgJC3Hzl+gBr6
         fZ+ypxKjA2x/sn8HsFLeQMPFz1oVJ/Hr04tKphIHLwuHzrI4iAiIpviPWmck0GOGcaZv
         Lr8w==
X-Forwarded-Encrypted: i=1; AJvYcCWvdggWbfOXqhRJot6imw+XN76rQGDbuHHppQZ79QpC5eTkqQ4noVO/bhlta67QEQk4Cs+ePZghAChPJrn3VwsAeW4moAoH4y9mdQ==
X-Gm-Message-State: AOJu0YzXtJ5+HM24Z3FxFMxgqOw/rvk+p9QRY+1CiAF8SGZZULfyHJEJ
	ePHDHvddmLkt3Qb7oEDn4WH9KUMZJFmCOkBUoI1SxDqucpCfynOMJkWyTRZg3XGDJwOuYJp1y5c
	2IVbJKzbtLYW3k+Pt+xt3pB8vxy76re5bwvqw
X-Google-Smtp-Source: AGHT+IFlZjMDM+xUDBM0MqA1a/+L68VZiYm6JTYTrKDyQTRWVSkTX38SqjBvy4N9VKZ94M58Wndm1vGhgVCwh8IuY4w=
X-Received: by 2002:a50:931d:0:b0:564:f6d5:f291 with SMTP id
 m29-20020a50931d000000b00564f6d5f291mr308024eda.34.1711663783904; Thu, 28 Mar
 2024 15:09:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328143051.1069575-1-arnd@kernel.org> <20240328143051.1069575-9-arnd@kernel.org>
In-Reply-To: <20240328143051.1069575-9-arnd@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 28 Mar 2024 15:09:30 -0700
Message-ID: <CAFhGd8pTdJNzmxhUaCpDkWpYiAP0Gvm6K=o+w5uE-g20M7u3rA@mail.gmail.com>
Subject: Re: [PATCH 8/9] mlx5: stop warning for 64KB pages
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Maxim Mikityanskiy <maxtram95@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Arnd Bergmann <arnd@arndb.de>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 7:32=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> When building with 64KB pages, clang points out that xsk->chunk_size
> can never be PAGE_SIZE:

This is under W=3D1 right? Otherwise this is a mighty annoying warning.

>
> drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c:19:22: error: resu=
lt of comparison of constant 65536 with expression of type 'u16' (aka 'unsi=
gned short') is always false [-Werror,-Wtautological-constant-out-of-range-=
compare]
>         if (xsk->chunk_size > PAGE_SIZE ||
>             ~~~~~~~~~~~~~~~ ^ ~~~~~~~~~
>
> In older versions of this code, using PAGE_SIZE was the only
> possibility, so this would have never worked on 64KB page kernels,
> but the patch apparently did not address this case completely.
>
> As Maxim Mikityanskiy suggested, 64KB chunks are really not all that
> useful, so just shut up the warning by adding a cast.
>
> Fixes: 282c0c798f8e ("net/mlx5e: Allow XSK frames smaller than a page")
> Link: https://lore.kernel.org/netdev/20211013150232.2942146-1-arnd@kernel=
.org/
> Link: https://lore.kernel.org/lkml/a7b27541-0ebb-4f2d-bd06-270a4d404613@a=
pp.fastmail.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c b/dri=
vers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
> index 06592b9f0424..9240cfe25d10 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
> @@ -28,8 +28,10 @@ bool mlx5e_validate_xsk_param(struct mlx5e_params *par=
ams,
>                               struct mlx5e_xsk_param *xsk,
>                               struct mlx5_core_dev *mdev)
>  {
> -       /* AF_XDP doesn't support frames larger than PAGE_SIZE. */
> -       if (xsk->chunk_size > PAGE_SIZE || xsk->chunk_size < MLX5E_MIN_XS=
K_CHUNK_SIZE) {
> +       /* AF_XDP doesn't support frames larger than PAGE_SIZE,
> +        * and xsk->chunk_size is limited to 65535 bytes.
> +        */
> +       if ((size_t)xsk->chunk_size > PAGE_SIZE || xsk->chunk_size < MLX5=
E_MIN_XSK_CHUNK_SIZE) {
>                 mlx5_core_err(mdev, "XSK chunk size %u out of bounds [%u,=
 %lu]\n", xsk->chunk_size,
>                               MLX5E_MIN_XSK_CHUNK_SIZE, PAGE_SIZE);
>                 return false;
> --
> 2.39.2
>

