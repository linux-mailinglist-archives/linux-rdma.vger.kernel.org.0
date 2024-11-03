Return-Path: <linux-rdma+bounces-5721-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D939BA880
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Nov 2024 23:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C93C1F21088
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Nov 2024 22:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23BF18C326;
	Sun,  3 Nov 2024 22:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Z0lAo4pm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE9018BC39
	for <linux-rdma@vger.kernel.org>; Sun,  3 Nov 2024 22:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730672337; cv=none; b=LIk/EzvH3WGRADxHExt2oK+g+Rfu0lvWIs05qLcJL5Fn0uylk5/1vC2kdw97A2BlXV9jAILHVzgkbJRnV1xIzJIJfMlkyRmnVdr1MrgDZS+EHNY04R+DazqUQw42p3oEisu4S66fN345s1SrGasqLR2eUexzSwNbvE1ofhHHSeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730672337; c=relaxed/simple;
	bh=YGawsJXB+jsEC2Okr4d21ol8xSluHNkz7XQ5YfM4hmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzqpN85KqPffnT3SCPm+Tt6kYlGCd+BK37dDm9428AXSLgMTxiOcWkSbdlmr0l1cfmzTrUzguEVt8LIDS4MZT36WyH+lejUFulfWRyCxKqX32Sm44FVPguTAJQShDOOGCau2Rl1GEQVJwDzrCutGgTd3c0yEKA8MkXKv3CN5ibs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Z0lAo4pm; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7eb068dbf51so554477a12.0
        for <linux-rdma@vger.kernel.org>; Sun, 03 Nov 2024 14:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1730672335; x=1731277135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DR6c/WPJN94TSRP9CTlobXAtJd4oqXafjQHarDgT3xg=;
        b=Z0lAo4pm9kE/AL/MM90CCrdbc1DMqNVaTcZF/rgDQgpKxHJF7ikrdnOVHBP9i0yA1O
         D7XOB58ITkxOPaQ0AH4oCWdWUT3g9BjRdB54RXkwGGmMf54GDRpWbnnyeXnLBOmDGnGt
         87/P6Q1YmWdZWkir9mk7RL8oq0GuwnVoF8w68cPlPUWSuefOVa4O1TaoHjiXVwp4oIM+
         zUq0+vi2/MBegEAIbdogQpQ4lvhTvK74SkxYt+60Njxpi0WnDNwqIRJDAkn37n3SriKU
         j0/O7j37FJqHo6jj7gjqOI6HTawQeskaWN67/OOKmoEirxnUskWvlzPlYH07ODDd4ygC
         DjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730672335; x=1731277135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DR6c/WPJN94TSRP9CTlobXAtJd4oqXafjQHarDgT3xg=;
        b=GjPXq2aYFWef3GYbW4juD6q0VV5czWOueMtrcDZ7o6Co+/xLPljawdNOflJkVJTtu3
         bVUfcyrgOYpEum6p6uYqst/ySl9UuN3YAD8iyxW+pCRK0QO22a1dUtCtUtBE7eoz9rXe
         J4F+HNFUZidP//Cq8nCW3EVVb7w/V9+NVIotrwxPTFyln/28Zj9iaGLe/tdzLihp59hJ
         sYY94+cEeNDP3JYDOHyvzQMlqiR0nWap+iWvUfZtw9TTSH1aZQuOfXf81oiGRjiyztTD
         t03ZJZshw+PjsdY+z5ZzMqQsYN/Sht10mTXTuodlo18Fv5ffhesvP4GzLx9+uLLXumda
         dVsg==
X-Forwarded-Encrypted: i=1; AJvYcCUvnLNz2vjhvP+exeqZzP4B0sXgL3xHX5FEbRX0Uk6SZAKIWgTcTS+jgaedAe4hE3skhAUmdoFUjfPq@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq5cF5IbIlGliK4M2de+xgdgJfUNk2wSEqyMj+pBd8sqn8Bofs
	/9fv3j6gF6YAbf/ciYyPqVssH5DHRVATuGgJeq0vAYPHM1itx9IJo0nOUnilFQOzImLNPYERSDP
	GNHOPlMpPeLcIkcFJ9fc020CjHSTZfo4lpn6jqx7VbV/pL8Tmg8o=
X-Google-Smtp-Source: AGHT+IExPA2hsiAKoyDZwRCgYk5UAZ7TEXffOizLQFxWQDP2pcqP6Jrb05184RINemMWnN8NpvwAMu6stmFhPCSnf1w=
X-Received: by 2002:a17:90a:77c5:b0:2e5:5a58:630 with SMTP id
 98e67ed59e1d1-2e8f11a8ba9mr15038332a91.5.1730672334564; Sun, 03 Nov 2024
 14:18:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101034647.51590-1-csander@purestorage.com>
 <20241101034647.51590-2-csander@purestorage.com> <CY8PR12MB71958512F168E2C172D0BE05DC502@CY8PR12MB7195.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB71958512F168E2C172D0BE05DC502@CY8PR12MB7195.namprd12.prod.outlook.com>
From: Caleb Sander <csander@purestorage.com>
Date: Sun, 3 Nov 2024 14:18:43 -0800
Message-ID: <CADUfDZofFwy12oZYTmm3TE314RM79EGsxV6bKEBRMVFv8C3jNg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] mlx5/core: deduplicate {mlx5_,}eq_update_ci()
To: Parav Pandit <parav@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 2, 2024 at 8:55=E2=80=AFPM Parav Pandit <parav@nvidia.com> wrot=
e:
>
>
>
> > From: Caleb Sander Mateos <csander@purestorage.com>
> > Sent: Friday, November 1, 2024 9:17 AM
> >
> > The logic of eq_update_ci() is duplicated in mlx5_eq_update_ci(). The o=
nly
> > additional work done by mlx5_eq_update_ci() is to increment
> > eq->cons_index. Call eq_update_ci() from mlx5_eq_update_ci() to avoid
> > the duplication.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  drivers/net/ethernet/mellanox/mlx5/core/eq.c | 9 +--------
> >  1 file changed, 1 insertion(+), 8 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> > b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> > index 859dcf09b770..078029c81935 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> > @@ -802,19 +802,12 @@ struct mlx5_eqe *mlx5_eq_get_eqe(struct
> > mlx5_eq *eq, u32 cc)  }  EXPORT_SYMBOL(mlx5_eq_get_eqe);
> >
> >  void mlx5_eq_update_ci(struct mlx5_eq *eq, u32 cc, bool arm)  {
> > -     __be32 __iomem *addr =3D eq->doorbell + (arm ? 0 : 2);
> > -     u32 val;
> > -
> >       eq->cons_index +=3D cc;
> > -     val =3D (eq->cons_index & 0xffffff) | (eq->eqn << 24);
> > -
> > -     __raw_writel((__force u32)cpu_to_be32(val), addr);
> > -     /* We still want ordering, just not swabbing, so add a barrier */
> > -     wmb();
> > +     eq_update_ci(eq, arm);
> Long ago I had similar rework patches to get rid of __raw_writel(), which=
 I never got chance to push,
>
> Eq_update_ci() is using full memory barrier.
> While mlx5_eq_update_ci() is using only write memory barrier.
>
> So it is not 100% deduplication by this patch.
> Please have a pre-patch improving eq_update_ci() to use wmb().
> Followed by this patch.

Right, patch 1/2 in this series is changing eq_update_ci() to use
writel() instead of __raw_writel() and avoid the memory barrier:
https://lore.kernel.org/lkml/20241101034647.51590-1-csander@purestorage.com=
/
Are you suggesting something different? If so, it would be great if
you could clarify what you mean.

Best,
Caleb

