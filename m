Return-Path: <linux-rdma+bounces-12813-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A52B2B019
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Aug 2025 20:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 668AF564205
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Aug 2025 18:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60D22773E0;
	Mon, 18 Aug 2025 18:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="whZP111d"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB6825D533
	for <linux-rdma@vger.kernel.org>; Mon, 18 Aug 2025 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541106; cv=none; b=P78koDYQAK36HgbAzgxx9HLtEDEttUQpknv3wfLL8noOEVoSbXK0/8W7EFqWu3O75mDQe510/hqP2luCqkzgIBwbUTK/clVnDMoOhq9KvTV1hOyL2I1cohgPHhIeoMRZFqgKvSBmYZZqaFxuNJ+6EEsqKnwMoXtwlVDzcnaRmzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541106; c=relaxed/simple;
	bh=MN6cMEgwQsI9LU7L5DTRfKs2G4F7QGv63KzoSuBphFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p5g59qi5g+WyLCBdUoydXv52tW7kgBFoyTGk8FoqUdqNZOpbVcucLknXJBPYL68I6TKhUWXwgmybHjnXEIvtyq38WZ9PzudOKBfDwkHtiMGVenjigps3q1p+YdS894jDGSyeCH7YGjb5omG1ZdDBhaqiNbhBo3e+Aud+2acZS+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=whZP111d; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55cc715d0easo1255e87.0
        for <linux-rdma@vger.kernel.org>; Mon, 18 Aug 2025 11:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755541103; x=1756145903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWR/SbaxqayRTD44wtFfLeF4GeVcOog9WH0lYeaW0Bk=;
        b=whZP111dGGJjKbnvTu+26xDruGuckzCeh7COcoy+vugK0Xm5ehmvm5SYzgDi+PcQiE
         qUtSkUXQFijFC7C64i5ErUmK3YGC8l0G34PpgHH7UI2mSN1vLWyQvNYCqzX1wAR/AI2v
         lG7HPDoAlXnbqjbWoWyoQSkLssTCvDArhXIlZnn0PeVzjHI005wV24RW2emTnqvghPON
         d6YIFMjeT/yLP/SD4HyAiS4ZquRD8uPHfHQCfoww/Dz5u6vWprZc9H1lgS17CebvYkdk
         1yDGH6n/qnGM3/jsUG2E8Zdz2QuXSroaMjWgWKSNOXaDe5COm5UBb+ZDschVsDFcJivf
         Ys+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755541103; x=1756145903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWR/SbaxqayRTD44wtFfLeF4GeVcOog9WH0lYeaW0Bk=;
        b=TdBp9jeOzY2pOU2dWe8XxN3VTYxTvluDwQVeczK9PGhJDfU7nX8Fk9H+VP3Gh2Mjex
         Fmur9rvrNpzBO0YQW+ywbaw7JesomhhykTYnRtOVxKoNrZvSe+lCPLjqNXcteFza+/OU
         lR0e/4kokhDilZ4D206RrEA6k8wqIIA7bEJltJCpobkTk/I8QUCrMLqaUEIiwBEfXj1L
         4Vt0VcCQ1KLB+tG8kkM7vsvFGnzLQ3aBb6JPq0+AIr3vpmeCgP7mW7z70x4W7toZdtua
         ssItayH6gjT0eq2Dqm/ljCbD0aPgLMC7Tt0qj9A5A+RFuMUXsXaxOGOHpGTf119EwAkD
         oeCw==
X-Forwarded-Encrypted: i=1; AJvYcCX2hqhX9fMYI6tZqIKlVF4izzct/ZnSRkyTfo/9SNt9I9f6CrRcPB/mmxjMJ/XpgLRsq7jCuqhYz49x@vger.kernel.org
X-Gm-Message-State: AOJu0YwSWKyJlu9ZG2/x2TZta5N+hjE0XBYqwdtxfSeO/6XzUXwMIf/e
	sqyDEinC7BaRj3q65ootD9bnuZLL2eW9KVEp2lAWDoK3cYF92mHFpadGAkxqJBAPwEdl/g2v4QL
	zg++34dZ4p8Ws74VSKRHUz8HkXg27IpMsrF/EQPmO
X-Gm-Gg: ASbGncuStUl6U+ay24eTaLk2XNTwt0bfElTqyH6MbpSTtUY/Yad0mR7klrc2t7TvzZ0
	9t1JndmLzvGli3b++xWe6dbtlxJFTaC5SLskdWPKbauEVXd+UI3pDBRrhGCJgvG4QHRnl2+sZvH
	K2hxxzPZIrUPZZyxL6JTwHG4pLVYKHfjY5zShZ8xs+oBLNv/J6SuJghiCo0vQ7ffqlpptlEBlTG
	6z/gQWoDSEXgi8dNkDOjStEgHBPtjSbzJNZ7Oe6lDINAu3t
X-Google-Smtp-Source: AGHT+IHs2hDwNnShp2o5vXlAxIJDY3ZyuELs6Qbn9swcDZaVjFbHPjN6aHjnakTgYOX9eOvexrRF6+S71VUKA4qKz/A=
X-Received: by 2002:a05:6512:1c3:b0:55b:9f89:928b with SMTP id
 2adb3069b0e04-55e001125d4mr11794e87.1.1755541102509; Mon, 18 Aug 2025
 11:18:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815110401.2254214-2-dtatulea@nvidia.com> <20250815110401.2254214-6-dtatulea@nvidia.com>
 <CAHS8izO327v1ZXnpqiyBRyO1ntgycVBG9ZLGMdCv4tg_5wBWng@mail.gmail.com> <jvbtvbmgqspgfc7q2bprtdtigrhdsrjqf3un2wvxnbydngyc7r@y2sgbxgqkdyi>
In-Reply-To: <jvbtvbmgqspgfc7q2bprtdtigrhdsrjqf3un2wvxnbydngyc7r@y2sgbxgqkdyi>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 18 Aug 2025 11:18:10 -0700
X-Gm-Features: Ac12FXyie8zJRkeTDcLtpvBJzFcHj52yCohewjEDLantFzz9m9oBZlFv4CV91bE
Message-ID: <CAHS8izNWStDWNfNro3oX1v5mwyzK_xmA0YfffqSeB0JZwArK7w@mail.gmail.com>
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

On Mon, Aug 18, 2025 at 10:40=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> On Fri, Aug 15, 2025 at 10:37:15AM -0700, Mina Almasry wrote:
> > On Fri, Aug 15, 2025 at 4:07=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia=
.com> wrote:
> > >
> > > For zero-copy (devmem, io_uring), the netdev DMA device used
> > > is the parent device of the net device. However that is not
> > > always accurate for mlx5 devices:
> > > - SFs: The parent device is an auxdev.
> > > - Multi-PF netdevs: The DMA device should be determined by
> > >   the queue.
> > >
> > > This change implements the DMA device queue API that returns the DMA
> > > device appropriately for all cases.
> > >
> > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > ---
> > >  .../net/ethernet/mellanox/mlx5/core/en_main.c | 24 +++++++++++++++++=
++
> > >  1 file changed, 24 insertions(+)
> > >
> > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/driv=
ers/net/ethernet/mellanox/mlx5/core/en_main.c
> > > index 21bb88c5d3dc..0e48065a46eb 100644
> > > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > > @@ -5625,12 +5625,36 @@ static int mlx5e_queue_start(struct net_devic=
e *dev, void *newq,
> > >         return 0;
> > >  }
> > >
> > > +static struct device *mlx5e_queue_get_dma_dev(struct net_device *dev=
,
> > > +                                             int queue_index)
> > > +{
> > > +       struct mlx5e_priv *priv =3D netdev_priv(dev);
> > > +       struct mlx5e_channels *channels;
> > > +       struct device *pdev =3D NULL;
> > > +       struct mlx5e_channel *ch;
> > > +
> > > +       channels =3D &priv->channels;
> > > +
> > > +       mutex_lock(&priv->state_lock);
> > > +
> > > +       if (queue_index >=3D channels->num)
> > > +               goto out;
> > > +
> > > +       ch =3D channels->c[queue_index];
> > > +       pdev =3D ch->pdev;
> >
> > This code assumes priv is initialized, and probably that the device is
> > up/running/registered. At first I thought that was fine, but now that
> > I look at the code more closely, netdev_nl_bind_rx_doit checks if the
> > device is present but doesn't seem to check that the device is
> > registered.
> >
> > I wonder if we should have a generic check in netdev_nl_bind_rx_doit
> > for NETDEV_REGISTERED, and if not, does this code handle unregistered
> > netdev correctly (like netdev_priv and priv->channels are valid even
> > for unregistered mlx5 devices)?
> >
> netdev_get_by_index_lock() returns non-NULL only when the device is in
> state NETDEV_REGISTERED or NETREG_UNINITIALIZED. So I think  that this
> check should suffice.
>

Ack, thanks for checking. For the patch:

Reviewed-by: Mina Almasry <almasrymina@google.com>



--=20
Thanks,
Mina

