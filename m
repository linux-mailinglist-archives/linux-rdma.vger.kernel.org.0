Return-Path: <linux-rdma+bounces-5817-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B939BFA52
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 00:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2DE1C210BB
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2024 23:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE30320E00C;
	Wed,  6 Nov 2024 23:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XMm0UrpW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C6220D51B
	for <linux-rdma@vger.kernel.org>; Wed,  6 Nov 2024 23:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730936658; cv=none; b=jsUa0+UgqP+vWx8feib19k2ngMFwBcc9ipn7SXGDW3yd8pg+COQl/QBNtQRXHE8oSxtCnnph2rQin1ZT/1v32l5zhJ3cz6aQS421sA3Ea9+eYKlVkHsk9aSvANJ51UqnV2G0HtHusp0OfHVUhJdVdD6ZXu7+nXqk8w7KGU8Ffvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730936658; c=relaxed/simple;
	bh=lSxaigboPLXHNcddz2sY56eN7f1c39zsSqkEN3I8a4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pE8V26fN063gdKQf3U50zfQJMikXwO9BlFQFSUxGfctvSt12bkhFtoZCE0kaAWpujLgeb3TYdDG7Nd8gquaTar2WV4CWvZJ7ARwXJj0E54dCKDFtzyHf68CKOaqTs4mdNLbRgLECH6WGIWhvpVqSSstqCHdHAo2KMcRUEdvtmpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XMm0UrpW; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e56750bb13so48125a91.2
        for <linux-rdma@vger.kernel.org>; Wed, 06 Nov 2024 15:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1730936656; x=1731541456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPXJsl8fLkTdJ5MrNMMlzw9z0f/yutenIKxxBRJC7Ks=;
        b=XMm0UrpWuVqnuuAaqgGDs7cdITimrNeenLyZ0gwcKNTNrUzCyXielur17h5iwj3l5F
         Tncul6SeOOPoFbu81xdkAJBAFmOLfGdkyqsWEMYtHcNnpvzKb+HkWuClvGANIZG3R8Mw
         SNHOZ99fu0gr7Bop6SRDHmpN1s46bi0Eygj1ys5dUoRsbi1w+uKOJAN0qZ6OscuxaSqD
         CR7mCbKG88bvdDYvMs8dG6IMDCz+y07GFnHigDsHG3T24KrlTPKOXQLqB5xT6ty1NLvV
         2bFZMS+rcE4AaO5nGS/jjlK6qu7ebVqFyvei6AWqlLKgmmhtlCZw92/hbBqP8iBubbv4
         2zRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730936656; x=1731541456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPXJsl8fLkTdJ5MrNMMlzw9z0f/yutenIKxxBRJC7Ks=;
        b=Odo2cBMvQslT17YHp1YRcgvT0+jwB1lBjWeeI6saloPDDPCo6H/PICTAO+pAoISYLS
         Yb6+cCzykV8wBbEw1kSlY8H8x3iZDW5tRMjmsewxVzhss4PST6AWeIgHS79E9XQqjhaK
         m6nmLS23lALps4kaxRNreCzXv8/7o/U74TIhW+JtBD2e2ujlA0l+S1yWn+vffU5Yye68
         hl9FnWdD9LhZMFDRTya44v75KxC2uuveNu5H/KN7wS18/9r+PPF0nZE8kba2ja4TZow4
         yzDVL1anGskN5VZqRWYrA2++dyNXluHhdk/cqdLZd7VKfx3Bxo0/2x8sq81ZimxVXtdt
         z4Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXjDnMDTqCZnLllXdj7a/M45iAUPrm5Np6mfR//PK5GmnNQy5jqabmDleHx/WkLW5gH27YNa2o1jnz/@vger.kernel.org
X-Gm-Message-State: AOJu0YwGvHCCTWHk5/cIOnUEPyWOxrBaMgIwibBAODeZ3J+91BdosRff
	+SAaii6lGJn5b/bHUin1sx4wBX4iLH+Rb8xDh8/TWyEfid5mvsz++EdfFFIYLQYIleH6TzJE5nv
	eMwLbA1t2+fz7Mp1+L2f2t7TB0jhO/eUGW5Romw==
X-Google-Smtp-Source: AGHT+IEfTLGxMRTgZVBrGwFKA9oioUe6XiP0kU3ZXwnrA2Gb+QVba1IpxfUk/kA/lH7d6J1l+V4TSFC0vo8qJ2jirVQ=
X-Received: by 2002:a17:90a:e7c2:b0:2e2:ada8:2984 with SMTP id
 98e67ed59e1d1-2e9a4b22b1bmr587838a91.4.1730936656020; Wed, 06 Nov 2024
 15:44:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101034647.51590-1-csander@purestorage.com>
 <20241101034647.51590-2-csander@purestorage.com> <CY8PR12MB71958512F168E2C172D0BE05DC502@CY8PR12MB7195.namprd12.prod.outlook.com>
 <CADUfDZofFwy12oZYTmm3TE314RM79EGsxV6bKEBRMVFv8C3jNg@mail.gmail.com>
 <CY8PR12MB71953FD36C70ACACEBE3DBA1DC522@CY8PR12MB7195.namprd12.prod.outlook.com>
 <CADUfDZqanDo+v_jap7pQire86QkfaDQE4HvhvVBb64YqKNgRHg@mail.gmail.com> <CY8PR12MB7195FDC4A280F4CD7EA219ABDC532@CY8PR12MB7195.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB7195FDC4A280F4CD7EA219ABDC532@CY8PR12MB7195.namprd12.prod.outlook.com>
From: Caleb Sander <csander@purestorage.com>
Date: Wed, 6 Nov 2024 15:44:04 -0800
Message-ID: <CADUfDZon6QbURp7TqB6dvE4Ewb_To2EDyUTQ=spNCorXDy0DbQ@mail.gmail.com>
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

On Tue, Nov 5, 2024 at 9:44=E2=80=AFPM Parav Pandit <parav@nvidia.com> wrot=
e:
>
>
> > From: Caleb Sander <csander@purestorage.com>
> > Sent: Tuesday, November 5, 2024 9:36 PM
> >
> > On Mon, Nov 4, 2024 at 9:22=E2=80=AFPM Parav Pandit <parav@nvidia.com> =
wrote:
> > >
> > >
> > >
> > > > From: Caleb Sander <csander@purestorage.com>
> > > > Sent: Monday, November 4, 2024 3:49 AM
> > > >
> > > > On Sat, Nov 2, 2024 at 8:55=E2=80=AFPM Parav Pandit <parav@nvidia.c=
om> wrote:
> > > > >
> > > > >
> > > > >
> > > > > > From: Caleb Sander Mateos <csander@purestorage.com>
> > > > > > Sent: Friday, November 1, 2024 9:17 AM
> > > > > >
> > > > > > The logic of eq_update_ci() is duplicated in mlx5_eq_update_ci(=
).
> > > > > > The only additional work done by mlx5_eq_update_ci() is to
> > > > > > increment
> > > > > > eq->cons_index. Call eq_update_ci() from mlx5_eq_update_ci() to
> > > > > > eq->avoid
> > > > > > the duplication.
> > > > > >
> > > > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > > > > ---
> > > > > >  drivers/net/ethernet/mellanox/mlx5/core/eq.c | 9 +--------
> > > > > >  1 file changed, 1 insertion(+), 8 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> > > > > > b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> > > > > > index 859dcf09b770..078029c81935 100644
> > > > > > --- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> > > > > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> > > > > > @@ -802,19 +802,12 @@ struct mlx5_eqe *mlx5_eq_get_eqe(struct
> > > > > > mlx5_eq *eq, u32 cc)  }  EXPORT_SYMBOL(mlx5_eq_get_eqe);
> > > > > >
> > > > > >  void mlx5_eq_update_ci(struct mlx5_eq *eq, u32 cc, bool arm)  =
{
> > > > > > -     __be32 __iomem *addr =3D eq->doorbell + (arm ? 0 : 2);
> > > > > > -     u32 val;
> > > > > > -
> > > > > >       eq->cons_index +=3D cc;
> > > > > > -     val =3D (eq->cons_index & 0xffffff) | (eq->eqn << 24);
> > > > > > -
> > > > > > -     __raw_writel((__force u32)cpu_to_be32(val), addr);
> > > > > > -     /* We still want ordering, just not swabbing, so add a ba=
rrier */
> > > > > > -     wmb();
> > > > > > +     eq_update_ci(eq, arm);
> > > > > Long ago I had similar rework patches to get rid of
> > > > > __raw_writel(), which I never got chance to push,
> > > > >
> > > > > Eq_update_ci() is using full memory barrier.
> > > > > While mlx5_eq_update_ci() is using only write memory barrier.
> > > > >
> > > > > So it is not 100% deduplication by this patch.
> > > > > Please have a pre-patch improving eq_update_ci() to use wmb().
> > > > > Followed by this patch.
> > > >
> > > > Right, patch 1/2 in this series is changing eq_update_ci() to use
> > > > writel() instead of __raw_writel() and avoid the memory barrier:
> > > > https://lore.kernel.org/lkml/20241101034647.51590-1-
> > > > csander@purestorage.com/
> > > This patch has two bugs.
> > > 1. writel() writes the MMIO space in LE order. EQ updates are in BE o=
rder.
> > > So this will break on ppc64 BE.
> >
> > Okay, so this should be writel(cpu_to_le32(val), addr)?
> >
> That would break the x86 side because device should receive in BE format =
regardless of cpu endianness.
> Above code will write in the LE format.
>
> So an API foo_writel() need which does
> a. write memory barrier
> b. write to MMIO space but without endineness conversion.

Got it, thanks. writel(bswap_32(val, addr)) should work, then? I
suppose it may introduce a second bswap on BE architectures, but
that's probably worth it to avoid the memory barrier.

>
> > >
> > > 2. writel() issues the barrier BEFORE the raw_writel().
> > > As opposed to that eq update needs to have a barrier AFTER the writel=
().
> > > Likely to synchronize with other CQ related pointers update.
> >
> > I was referencing this prior discussion about the memory barrier:
> > https://lore.kernel.org/netdev/CALzJLG8af0SMfA1C8U8r_Fddb_ZQhvEZd6=3D2
> > a97dOoBcgLA0xg@mail.gmail.com/
> > From Saeed's message, it sounds like the memory barrier is only used to
> > ensure the ordering of writes to the doorbell register, not the orderin=
g of the
> > doorbell write relative to any other writes. If some other write needs =
to be
> > ordered after the doorbell write, please explain what it is.
> Not write, reading of the CQE likely requires read barrier.

But mlx5_eq_update_ci() is already using wmb(), which only imposes an
ordering on writes. So if the existing code is correct, the memory
barrier cannot be required to order the doorbell write with respect to
a read of the CQE.

>
> > As Gal Pressman
> > pointed out, a wmb() at the end of a function doesn't make much sense, =
as
> > there are no further writes in the function to order. If the doorbell w=
rite needs
> > to be ordered before some other write in a caller function, the memory =
barrier
> > should probably move to the caller.
> It is the two EQ doorbell writes that needs to be ordered with respect to=
 each other.
> So please audit the code for CQE processing ensure that there is read bar=
rier after valid bit.
> And removal of this read barrier does not affect there.
>
> It would be best if you can test on ARM (non x86_64) platform for this ch=
ange.

Unfortunately I don't have access to any platform besides x86_64 with
ConnectX cards.

>
> >
> > >
> > > > Are you suggesting something different? If so, it would be great if
> > > > you could clarify what you mean.
> > > >
> > > So I was suggesting to keep __raw_writel() as is and replace mb() wit=
h
> > wmb().
> >
> > wmb() would certainly be cheaper than mb(), but I would like to underst=
and
> > the requirement for the barrier in the first place. The fence instructi=
on is very
> > expensive.
> >
> To order two doorbell writes of the same EQ.

Right, I understand why the memory barrier is needed with the existing
__raw_writel(), as it provides no ordering guarantees. But writel()
seems to guarantee the necessary ordering of writes to the EQ's
doorbell. This is the relevant documentation from memory-barriers.txt
(I assume the mutual exclusion of interrupt handlers is equivalent to
holding a spinlock):

2. A writeX() issued by a CPU thread holding a spinlock is ordered
   before a writeX() to the same peripheral from another CPU thread
   issued after a later acquisition of the same spinlock. This ensures
   that MMIO register writes to a particular device issued while holding
   a spinlock will arrive in an order consistent with acquisitions of
   the lock.

Do you still think the barrier is necessary if writel() is used instead?

If you feel strongly about keeping the wmb(), I can do that. It's
certainly an improvement over the full memory barrier. But fences are
quite expensive, so I would prefer to remove it if it's not necessary
for correctness.

Thanks,
Caleb

