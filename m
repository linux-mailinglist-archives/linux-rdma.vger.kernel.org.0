Return-Path: <linux-rdma+bounces-5770-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1319BD1B2
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 17:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6181F2511C
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 16:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19118183CC5;
	Tue,  5 Nov 2024 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="OvaeSaCR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910F515380B
	for <linux-rdma@vger.kernel.org>; Tue,  5 Nov 2024 16:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822799; cv=none; b=uEEa5nilQ8NzwPD7IiJ6HXdXnwPmGF4Q4GRw1BhVpf+Vj4P9Njb5rkVMd98Ra70gX6+87Hq+ZJxmHZRa9rwa0RX9bP7MDiB3aGFIcQT+GhxL2Iw8BQgsUUPBuDvnmJeVgcHQ2+8xoytWjUmeqh1q+uLOTiOeQyDlzCThCnvHIF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822799; c=relaxed/simple;
	bh=YRiHww1+NhlFVyCrv9IfzoyKUfIeSR3WjAcec84h3z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GOi0oN1AQZ30RNgFF1drlFPvwD2JDPbRurxSQNbnNlvzpb3V5H5v8NOXSMh9L75G8/0GzJn0x1A4KJDCoFV3HP2J8KxeAwkg8+LFKwAArrhRsPWq4JV+cEyyN0tiWbgNMaaqxxxm/0107gfGrcVPOEEdxVhVuMGqBYyAJ+lX/PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=OvaeSaCR; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e2af4dca5cso866228a91.3
        for <linux-rdma@vger.kernel.org>; Tue, 05 Nov 2024 08:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1730822797; x=1731427597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pe6tzS7Jefr2wBTMmepj7J7ch7Fwi7LgaTG2DrXOEMs=;
        b=OvaeSaCRQACEi+CdUZKNh+b5NywDO9h4uldWJOlonufc4UvO/TT11SJbIE9n24lfH3
         UltYT2VUgdl5UA17HZjN0T+/ciBzzFtTRHUhg2u+RYw2FDrykZAWSaeBF0KDOOQHHCWj
         FYb9tnGVCaZB/ocld80GdaD9Usi4jf+0FG7SWz3qmiWnCy3thoFEBVDqsjcIFYlCe228
         mNdphrY1MB4PKzU2q9mv+8EomkGPT0uNLhvGaRUN4klO3odB//gxn4FQ68iyhfM7VkRr
         kBcdTQ6ZQCHS031u9wqQNWnIH+G1WjFtNPSeFD36ubvmn1gUDYiHKmM0tGtXfbZIYPK7
         X5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730822797; x=1731427597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pe6tzS7Jefr2wBTMmepj7J7ch7Fwi7LgaTG2DrXOEMs=;
        b=Up0S91Kz1Ao6/JLF8j8VjM7DCRxp50Mz7Rl7CePV6l3xxTXicuGzcyhOSm2WbjbTCm
         DEru9P5sBODkLNeX+Z/WUK7PrVRC67ivx31hi28A5vZ479C1CGe45MScLZ9oIMDSNoRC
         4ys8um33mdAIaOlEIowS08Ga3ORok7OF9XvsaP1o0PQbzP13vvhWTlkAMqF1w4ydoRG/
         aBckqk3scdy9y9tCulD1Z4Joiml6ZBf4rVitbChJr95GM2VhGY/wRfCcWTMfuYnTgmEf
         4eGpd9yXApqPSlqNEmnbzV7Fx44y0IlLxii/OASf4j1cnei09E2iyjQxzOc8vASjBrHt
         NOKA==
X-Forwarded-Encrypted: i=1; AJvYcCVc12snswiaqhD20ZJFpxEwctwWTOBS2K7luA0q4rJc0b5DWBEVevQxM8Kpn5czJ2NbshryMPniRqR2@vger.kernel.org
X-Gm-Message-State: AOJu0YwPUA36T/Gg/SXjcV+DI+aLfKYBIhVZqah4VxMDcmPhzOljaiXV
	HCzT2+z7zHawcynU88xTpskTZ44NWbrGw/78YfZt6qM38G6E65RWCN45Avgj1gdhznfaztYn+M3
	49rfxCYyKSRAatWEdiJ3hmgedoxNRnTq1yMdzNg==
X-Google-Smtp-Source: AGHT+IFzsqY6OWMTeowTywyKfQhYAOXP+M/+Yjr6GgpGfWTfSDkoFlv1jXVRkyP3zd7O8FLbk4JHiwux2suOsS1uRP4=
X-Received: by 2002:a17:90b:1d84:b0:2e2:de92:2d52 with SMTP id
 98e67ed59e1d1-2e8f11d607amr18357252a91.9.1730822796788; Tue, 05 Nov 2024
 08:06:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101034647.51590-1-csander@purestorage.com>
 <20241101034647.51590-2-csander@purestorage.com> <CY8PR12MB71958512F168E2C172D0BE05DC502@CY8PR12MB7195.namprd12.prod.outlook.com>
 <CADUfDZofFwy12oZYTmm3TE314RM79EGsxV6bKEBRMVFv8C3jNg@mail.gmail.com> <CY8PR12MB71953FD36C70ACACEBE3DBA1DC522@CY8PR12MB7195.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB71953FD36C70ACACEBE3DBA1DC522@CY8PR12MB7195.namprd12.prod.outlook.com>
From: Caleb Sander <csander@purestorage.com>
Date: Tue, 5 Nov 2024 08:06:25 -0800
Message-ID: <CADUfDZqanDo+v_jap7pQire86QkfaDQE4HvhvVBb64YqKNgRHg@mail.gmail.com>
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

On Mon, Nov 4, 2024 at 9:22=E2=80=AFPM Parav Pandit <parav@nvidia.com> wrot=
e:
>
>
>
> > From: Caleb Sander <csander@purestorage.com>
> > Sent: Monday, November 4, 2024 3:49 AM
> >
> > On Sat, Nov 2, 2024 at 8:55=E2=80=AFPM Parav Pandit <parav@nvidia.com> =
wrote:
> > >
> > >
> > >
> > > > From: Caleb Sander Mateos <csander@purestorage.com>
> > > > Sent: Friday, November 1, 2024 9:17 AM
> > > >
> > > > The logic of eq_update_ci() is duplicated in mlx5_eq_update_ci().
> > > > The only additional work done by mlx5_eq_update_ci() is to incremen=
t
> > > > eq->cons_index. Call eq_update_ci() from mlx5_eq_update_ci() to
> > > > eq->avoid
> > > > the duplication.
> > > >
> > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > > ---
> > > >  drivers/net/ethernet/mellanox/mlx5/core/eq.c | 9 +--------
> > > >  1 file changed, 1 insertion(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> > > > b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> > > > index 859dcf09b770..078029c81935 100644
> > > > --- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> > > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> > > > @@ -802,19 +802,12 @@ struct mlx5_eqe *mlx5_eq_get_eqe(struct
> > > > mlx5_eq *eq, u32 cc)  }  EXPORT_SYMBOL(mlx5_eq_get_eqe);
> > > >
> > > >  void mlx5_eq_update_ci(struct mlx5_eq *eq, u32 cc, bool arm)  {
> > > > -     __be32 __iomem *addr =3D eq->doorbell + (arm ? 0 : 2);
> > > > -     u32 val;
> > > > -
> > > >       eq->cons_index +=3D cc;
> > > > -     val =3D (eq->cons_index & 0xffffff) | (eq->eqn << 24);
> > > > -
> > > > -     __raw_writel((__force u32)cpu_to_be32(val), addr);
> > > > -     /* We still want ordering, just not swabbing, so add a barrie=
r */
> > > > -     wmb();
> > > > +     eq_update_ci(eq, arm);
> > > Long ago I had similar rework patches to get rid of __raw_writel(),
> > > which I never got chance to push,
> > >
> > > Eq_update_ci() is using full memory barrier.
> > > While mlx5_eq_update_ci() is using only write memory barrier.
> > >
> > > So it is not 100% deduplication by this patch.
> > > Please have a pre-patch improving eq_update_ci() to use wmb().
> > > Followed by this patch.
> >
> > Right, patch 1/2 in this series is changing eq_update_ci() to use
> > writel() instead of __raw_writel() and avoid the memory barrier:
> > https://lore.kernel.org/lkml/20241101034647.51590-1-
> > csander@purestorage.com/
> This patch has two bugs.
> 1. writel() writes the MMIO space in LE order. EQ updates are in BE order=
.
> So this will break on ppc64 BE.

Okay, so this should be writel(cpu_to_le32(val), addr)?

>
> 2. writel() issues the barrier BEFORE the raw_writel().
> As opposed to that eq update needs to have a barrier AFTER the writel().
> Likely to synchronize with other CQ related pointers update.

I was referencing this prior discussion about the memory barrier:
https://lore.kernel.org/netdev/CALzJLG8af0SMfA1C8U8r_Fddb_ZQhvEZd6=3D2a97dO=
oBcgLA0xg@mail.gmail.com/
From Saeed's message, it sounds like the memory barrier is only used
to ensure the ordering of writes to the doorbell register, not the
ordering of the doorbell write relative to any other writes. If some
other write needs to be ordered after the doorbell write, please
explain what it is. As Gal Pressman pointed out, a wmb() at the end of
a function doesn't make much sense, as there are no further writes in
the function to order. If the doorbell write needs to be ordered
before some other write in a caller function, the memory barrier
should probably move to the caller.

>
> > Are you suggesting something different? If so, it would be great if you=
 could
> > clarify what you mean.
> >
> So I was suggesting to keep __raw_writel() as is and replace mb() with wm=
b().

wmb() would certainly be cheaper than mb(), but I would like to
understand the requirement for the barrier in the first place. The
fence instruction is very expensive.

Thanks,
Caleb

