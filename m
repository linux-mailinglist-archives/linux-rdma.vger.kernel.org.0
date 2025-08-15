Return-Path: <linux-rdma+bounces-12775-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E530DB2853D
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Aug 2025 19:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C6CAE484E
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Aug 2025 17:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F552309B9;
	Fri, 15 Aug 2025 17:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wkb0R+eh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986533176E2
	for <linux-rdma@vger.kernel.org>; Fri, 15 Aug 2025 17:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755279451; cv=none; b=OAvl6by2vQogOdB+k8Ch1auYmIIytoVj5k/GepSPeQxhIJg8mrxza5RuIAlfH7FIhlDyf4pNoD8OgYwvKnSx3xZ92Xh5SRDy+uiqyoGMpB4PP7ZYYNYawBeSXX/Z1CLytpJbWs2RBbJlD1Fc6FRd81GZ2Db1naelYkt8p7IAohE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755279451; c=relaxed/simple;
	bh=KIXaRrabWkI94cBABbOOQhZm5gakqOBxiKGhfpvK4bU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W0W+7jjmiDb0TCG08ZKny+nX3xKiTYbNlnsTnXSomo6jm2uSq0tI3Q3c/jjfmg8pGjXDZc6JYfXYFWf0NE90Q0pgKgNafweXmhzdOLsshPb8YhbGinAkvqmYozJtDDG7RrlQv7yVQtama4dSCkblZAUvBcckUcOrEfebW8a1ZUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wkb0R+eh; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55cef2f624fso426e87.1
        for <linux-rdma@vger.kernel.org>; Fri, 15 Aug 2025 10:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755279448; x=1755884248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVkGL7jBRLKf6+d6hhcuO3q92nCLqGME9TaVEfeECYI=;
        b=wkb0R+ehUO23VlC7TenvD+t2JKaQJteL++RmRCRofUjTsmunzO7PL4GNwuVi7lPcIt
         JIAF2unaTtJKmB5RxkCoOnFq19ybhgRKBvpdHTfnu1ISZYtGrEKOosBVme+wkyZuuPMg
         Ewz6RQCYyRRveKTq5taNZKJXJ0f34vdqAtR8Xah5xasOZC1DDC48g/EV8t4a992TELnd
         pX4gtUkWLLSVpE3G1F0XdqTeVmznbJl+KWWYbK6+Xkrz5V87mpWi3vC1ftbsPUzaZf8b
         O9+QeBllX7yzHgj/cD3AuJnNKOX9ECt8nPUL5YGrfrFnPzQJTIOuVZo//9BT5VobYsBU
         wWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755279448; x=1755884248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVkGL7jBRLKf6+d6hhcuO3q92nCLqGME9TaVEfeECYI=;
        b=tyGmw//NXkZGGFJ6DMJtfsyzXVsDOR54MLwcXdkEn1qQ9sGS2Wib8lehTnnNo+gZ4J
         xC//i+vmLMltvbY4zizsWnP9dwxkjusYJ+5wuhaQSStDsTHBJdE2GZ9F9WgnfvnxRqvE
         7pbkifOhh3kzJFUkPzGSlSZwipLpWAdsyi5FlsD2E0bq616+l88ZA3cZtFYU5HMTP7tB
         1O5BKoJkHaCCBMN9rkAEgaqsF2e2Nl22Ep08KV7Jx7MOhhSrg2Bi473lAObq22xTIRf6
         Yy1bF4Xa6sU1JIMrTBRn+sdljT8d63Jgy9n/z6gsG+hMh6NWVjHpwg/gWJ7kCw2HbfmZ
         UCTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp7p3Sp9VtbXAXazMDWLNJrxjSAR3NxiGd+eA1K4oC+S7seRRxODGXNoIKkj/LbhbYaVAk/GatlhPA@vger.kernel.org
X-Gm-Message-State: AOJu0YyJqr3adKPZOmzp7QO9vD7ufTD9ofAwpPi2/cG839XtfNPA2Fa6
	T0M4CRtLu1nQGkDqYry6dRrzsL6/cehCv96zn2wrPYh7iOvRNhDemCuNrzkOzlUz7aWz/6orBrV
	VGRd3iP0dQvoQ/D7DDCB1XSD3YDGOr60FmJnW9MW2
X-Gm-Gg: ASbGncuEI4LNXY3iRG/3BOMiaRR/wNKrDnf1GcS7Iqp5v4sK0+KSwqfATmfKdN2zroB
	zrNdAtrmirE4ldoAD95saI+s3/Fq0Stb/CzkvaTGfLHgMu8M/ldHnHX/DPUiO+e4lErj5UsxUIH
	zdiD4JfRGpj3Lz5fpl7kbx1fwBza/fmVgOzkXzBY1xOhEDYhDR+BqdUPuletSOx7vSHsQULH0q6
	hr3WeaHKtLUcRJJTdF3VvLl8D5CGgaPt79nefFclykJ
X-Google-Smtp-Source: AGHT+IF815aVMWdvRLDwiej+y4Cx3WJIQ4E2duZu4/2qWl0QtPxHw64kH4aIcMw784zTTXX6YinwEhcRSU5ux9YqIKo=
X-Received: by 2002:a05:6512:1291:b0:55c:f06b:e042 with SMTP id
 2adb3069b0e04-55cf06be062mr142027e87.1.1755279447479; Fri, 15 Aug 2025
 10:37:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815110401.2254214-2-dtatulea@nvidia.com> <20250815110401.2254214-6-dtatulea@nvidia.com>
In-Reply-To: <20250815110401.2254214-6-dtatulea@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 15 Aug 2025 10:37:15 -0700
X-Gm-Features: Ac12FXz0bX47lSXrHztHZ5UkfOYR_EvbTsCS-UKorkPh-bL-sJzn-Nb-eZJOYk0
Message-ID: <CAHS8izO327v1ZXnpqiyBRyO1ntgycVBG9ZLGMdCv4tg_5wBWng@mail.gmail.com>
Subject: Re: [RFC net-next v3 4/7] net/mlx5e: add op for getting netdev DMA device
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: asml.silence@gmail.com, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	cratiu@nvidia.com, parav@nvidia.com, Christoph Hellwig <hch@infradead.org>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 4:07=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> For zero-copy (devmem, io_uring), the netdev DMA device used
> is the parent device of the net device. However that is not
> always accurate for mlx5 devices:
> - SFs: The parent device is an auxdev.
> - Multi-PF netdevs: The DMA device should be determined by
>   the queue.
>
> This change implements the DMA device queue API that returns the DMA
> device appropriately for all cases.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/en_main.c | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/=
net/ethernet/mellanox/mlx5/core/en_main.c
> index 21bb88c5d3dc..0e48065a46eb 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -5625,12 +5625,36 @@ static int mlx5e_queue_start(struct net_device *d=
ev, void *newq,
>         return 0;
>  }
>
> +static struct device *mlx5e_queue_get_dma_dev(struct net_device *dev,
> +                                             int queue_index)
> +{
> +       struct mlx5e_priv *priv =3D netdev_priv(dev);
> +       struct mlx5e_channels *channels;
> +       struct device *pdev =3D NULL;
> +       struct mlx5e_channel *ch;
> +
> +       channels =3D &priv->channels;
> +
> +       mutex_lock(&priv->state_lock);
> +
> +       if (queue_index >=3D channels->num)
> +               goto out;
> +
> +       ch =3D channels->c[queue_index];
> +       pdev =3D ch->pdev;

This code assumes priv is initialized, and probably that the device is
up/running/registered. At first I thought that was fine, but now that
I look at the code more closely, netdev_nl_bind_rx_doit checks if the
device is present but doesn't seem to check that the device is
registered.

I wonder if we should have a generic check in netdev_nl_bind_rx_doit
for NETDEV_REGISTERED, and if not, does this code handle unregistered
netdev correctly (like netdev_priv and priv->channels are valid even
for unregistered mlx5 devices)?


--=20
Thanks,
Mina

