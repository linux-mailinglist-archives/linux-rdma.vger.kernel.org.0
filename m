Return-Path: <linux-rdma+bounces-11277-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 127CCAD7CA6
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 22:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 469533B36A7
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 20:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BA92DCC09;
	Thu, 12 Jun 2025 20:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MEiW5nBN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4A01B4F1F
	for <linux-rdma@vger.kernel.org>; Thu, 12 Jun 2025 20:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749761262; cv=none; b=UsqzeQw4gwOZwkq1mvPLlgwcESJH5ADyoXgkN+holYOd6WSgp8GszMILGcdv8/Jz35Ij15F+c8Z9JiPqGojFtDfvhAUXwld/oQJxI1kMgs6hlik55nIvvBu3XL917W4xFnOamwc5IDWRBUQe8GoaxaOO4I0lrk6YyVxP1Cxd14Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749761262; c=relaxed/simple;
	bh=AS3GrOSonbp9zk0Fa7DpmuxsDZ28EABxhA5RZzrO9pE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/E40m/FbfdTPWDxjEZm4WHaEi4ZVAzEOYzzzeE9roHweASYAOIFrPRHfTKMKxWpNDvDPHENhvgMaRLUCRdhEGsuiQY8VMAkq8N1dWFLTxIgjyTRBViA2uxrxYC32tuZBNkznx9owfRe1ilpcmf5zuYrIi9rB114XiYvn6UyN6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MEiW5nBN; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-235e389599fso69635ad.0
        for <linux-rdma@vger.kernel.org>; Thu, 12 Jun 2025 13:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749761257; x=1750366057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nr6kooDbksDJJfxzyC1WbIX3H7ZZ58tLys9ggXzUeA4=;
        b=MEiW5nBNJVmhSyrlp538SY8kqa/Sv93YQR9JC0ln68o2HTZ1UMiECmL+FU818Y53RX
         jJhsgcCc14Hy1FOCuu21GOdPFa3iywZAFECERp4JJ4N04qj/dcFnSGwmMGw7IWsGV6LI
         nTROSBQGtaA4l668fQaUOpiKo+Bvd0rCJYsAs9pjaiJIGzPdyXxmmciy8mMz/LiiSno9
         6v2JIwZA8ctGzbkOPpwnK34CRF73KTYN5Fy/GhrKdsg18w81GynqSWlWWXcFrtkspRRm
         rVrauDvYBeGoc7gBVL8N7AU4bYE7UaGv8pPHd+OKmSazCMVBN26a4fmTZm8l3HikmFWq
         WS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749761257; x=1750366057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nr6kooDbksDJJfxzyC1WbIX3H7ZZ58tLys9ggXzUeA4=;
        b=WOBB8oXwWCwKX5dQ1kiSyM3K92efOnLWK/3S2c6M8zXy+t0aHvuO7BVwT5srXdJLi9
         Rz4e6lRmXQouDsRlyWKn5HC6ZbbhuFe7VeTwlgoD2KHP8gVAJNJGOfiDfQvVqAxuWCgm
         eulSZebIbOdsmJfFe1Qi0caVpfB5yxe0bUrnsb3eT540aZ47QDtnITuepE7C77ansARw
         VMpZNgISN8b4kWnXY8LhNwXswy7nKkim+nDkqudddCMmjrupGXyq9Scmrqj7BLlUMQqs
         0BguXPpDDjnxdcT/ZD76Go+8pymNyn2tnWlpiXEv7maJHjKoBUkZ50YGA+pX/cdYpOwe
         YzhA==
X-Forwarded-Encrypted: i=1; AJvYcCWitI3U9D2X/S4rKLeeLS+3oLDVkV3wWqDPengr8hpaGI9/VXDN9u6jZnhEFA6GMQIJgogCrUA/atWH@vger.kernel.org
X-Gm-Message-State: AOJu0YwxtwHK6mpumWnDPHjAiy4l5f9E//HLc7KguNUsuh/waqzXTLDI
	4ef/pgRM2Xq90CfUtD1AXiScwic/oGujlaQTOH4LyjrVmaZRox/Sy6uuSDe1CLrhQICCE7l92ye
	r16Dqso3lsgl+vPP+RBDzAOxyrLDFO8fRnBekHSFq
X-Gm-Gg: ASbGncvKaZ4p/GyePKA4LEnUF7GItTG6MxlZHtReeHpDNWUpY0JzvtE+J5MeMwbS+zC
	tGiWfdaEXjpIilPn/wyIDKAfjxfgC1QoX/u3ZGZVxFSzgB6fduQz+7xhePNCplK0E1tddU3Ghc1
	jc6yaRAmioQlvHxjNaRklvGOp/eq/BKPHHVF1+h42Hcq1L4MaktGnrBANQu3gCIcdBFO8ZLFF/v
	g==
X-Google-Smtp-Source: AGHT+IEHoeUeqPp+cnSpet6RlgQGrs8OfW2u94ffFxvnZOLY+RPrDzdl21M2RwfhrxNi9bgdnG9KgQPYqe5L7gJzi1I=
X-Received: by 2002:a17:903:185:b0:231:d0ef:e8ff with SMTP id
 d9443c01a7336-2365e85307amr600125ad.8.1749761256479; Thu, 12 Jun 2025
 13:47:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610150950.1094376-1-mbloch@nvidia.com> <20250610150950.1094376-9-mbloch@nvidia.com>
 <CAHS8izOEn+C5QexSPZT3_ekUr2zR1dm9R6OsoGBPaqg5MFvBRQ@mail.gmail.com> <6nd3d7z5dmpzpegbwfkhszmtjqmsb4af5ts36mpv5m6jfavo23@lwijppu24jjf>
In-Reply-To: <6nd3d7z5dmpzpegbwfkhszmtjqmsb4af5ts36mpv5m6jfavo23@lwijppu24jjf>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 12 Jun 2025 13:47:24 -0700
X-Gm-Features: AX0GCFuekM7pseu4CUTgDEgxUud4AkQ-D4uoz7Py55DS2ZIX3Eg9EwW7G8lnVfc
Message-ID: <CAHS8izNyFtcWd0wPGoCdZXtZkjqWk6VgLAyk4anfCQjGP2uk-w@mail.gmail.com>
Subject: Re: [PATCH net-next v4 08/11] net/mlx5e: Add support for UNREADABLE
 netmem page pools
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Mark Bloch <mbloch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, saeedm@nvidia.com, gal@nvidia.com, 
	leonro@nvidia.com, tariqt@nvidia.com, Leon Romanovsky <leon@kernel.org>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Cosmin Ratiu <cratiu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 1:46=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> On Wed, Jun 11, 2025 at 10:16:18PM -0700, Mina Almasry wrote:
> > On Tue, Jun 10, 2025 at 8:20=E2=80=AFAM Mark Bloch <mbloch@nvidia.com> =
wrote:
> > >
> > > From: Saeed Mahameed <saeedm@nvidia.com>
> > >
> > > On netdev_rx_queue_restart, a special type of page pool maybe expecte=
d.
> > >
> > > In this patch declare support for UNREADABLE netmem iov pages in the
> > > pool params only when header data split shampo RQ mode is enabled, al=
so
> > > set the queue index in the page pool params struct.
> > >
> > > Shampo mode requirement: Without header split rx needs to peek at the=
 data,
> > > we can't do UNREADABLE_NETMEM.
> > >
> > > The patch also enables the use of a separate page pool for headers wh=
en
> > > a memory provider is installed for the queue, otherwise the same comm=
on
> > > page pool continues to be used.
> > >
> > > Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> > > Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> > > Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> > > Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> > > ---
> > >  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/driv=
ers/net/ethernet/mellanox/mlx5/core/en_main.c
> > > index 5e649705e35f..a51e204bd364 100644
> > > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > > @@ -749,7 +749,9 @@ static void mlx5e_rq_shampo_hd_info_free(struct m=
lx5e_rq *rq)
> > >
> > >  static bool mlx5_rq_needs_separate_hd_pool(struct mlx5e_rq *rq)
> > >  {
> > > -       return false;
> > > +       struct netdev_rx_queue *rxq =3D __netif_get_rx_queue(rq->netd=
ev, rq->ix);
> > > +
> > > +       return !!rxq->mp_params.mp_ops;
> >
> > This is kinda assuming that all future memory providers will return
> > unreadable memory, which is not a restriction I have in mind... in
> > theory there is nothing wrong with memory providers that feed readable
> > pages. Technically the right thing to do here is to define a new
> > helper page_pool_is_readable() and have the mp report to the pp if
> > it's all readable or not.
> >
> The API is already there: page_pool_is_unreadable(). But it uses the
> same logic...
>

Ugh, I was evidently not paying attention when that was added. I guess
everyone thinks memory provider =3D=3D unreadable memory. I think it's
more a coincidence that the first 2 memory providers give unreadable
memory. Whatever I guess; it's good enough for now :D

> However, having a pp level API is a bit limiting: as Cosmin pointed out,
> mlx5 can't use it because it needs to know in advance if this page_pool
> is for unreadable memory to correctly size the data page_pool (with or
> without headers).
>

Yeah, in that case mlx5 would do something like:

return !rxq->mp_params.mp_ops->is_readable();

If we decided that mp's could report if they're readable or not. For
now I guess assuming all mps are unreadable is fine.


--=20
Thanks,
Mina

