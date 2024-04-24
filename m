Return-Path: <linux-rdma+bounces-2054-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 285248B0C77
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 16:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8551C228F6
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 14:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081D915E7E9;
	Wed, 24 Apr 2024 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nB1GSJJb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B198E15B15C;
	Wed, 24 Apr 2024 14:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713968900; cv=none; b=jCsDVQoAOHV/L7kOY8hXLn12xV5iNyKe3flvV5KIynDqv4TQLMIXWIYt3RLwgzyCpC6mvdAucSufZTuwipUti7pWw21fAti35LniFHnCya2y7zyHpX5gw4TExL/Emjf6Tu1Z+cI3RxJcROBE9YtrMjrDGLHE1fwhBpUmiKHMK4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713968900; c=relaxed/simple;
	bh=0bXj55cRRwgJmp1/Upxrw4MJ5bCblTkPE847LyJTv2E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fNq2/s+6EZZVkighKt7aMZkXazHSnb4DkjIRtwVpzG4WYXDf3dQJdzbsZwLLDNnSOl5yyxl4B1+hNtPUdst+CbJzXvj96aBa0wbNwh5Mrt1TKyLIKkHGeSEK0wg+DSgbOaGH/7KaaU/ljQuIXNXApZlvmxSpV0TnxePQJcCtp1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nB1GSJJb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDCEC113CD;
	Wed, 24 Apr 2024 14:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713968900;
	bh=0bXj55cRRwgJmp1/Upxrw4MJ5bCblTkPE847LyJTv2E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nB1GSJJbUfdncCQjgrtZ3L06InY0W628g/6DvkX25FfUkmkPG60pqJFLKMFaCXw8A
	 1BnfAZH46DoQeN4JylqyKQimXYhD1H7sOwIPkdXsSVjzc27i8Jf/LgeMClX44SVXCV
	 At0+LCdQybDKZJvnkUJDSX1DabRHpUUz2O13E0MkkLw1Q7Pq5SPCVFSqFFCOz3POGB
	 4hzwulFHQfI++UhU4V6exonvtCSz6Ut8/efkCYQNL+02LkKwKq/ubkcd0jOKW8CiaZ
	 lqXxw0fVIK2mEcUaLqKQEB33SPxBHwSQj9Gkce1c1IG80NlzMybqmQoBHsAVwM7eDT
	 EdKK5MTw/MI0Q==
Date: Wed, 24 Apr 2024 07:28:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tariqt@nvidia.com,
 saeedm@nvidia.com, mkarsten@uwaterloo.ca, gal@nvidia.com,
 nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "open list:MELLANOX
 MLX4 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next 3/3] net/mlx4: support per-queue statistics via
 netlink
Message-ID: <20240424072818.2c68a1ab@kernel.org>
In-Reply-To: <ZiieqiuqNiy_W0mr@LQ3V64L9R2>
References: <20240423194931.97013-1-jdamato@fastly.com>
	<20240423194931.97013-4-jdamato@fastly.com>
	<Zig5RZOkzhGITL7V@LQ3V64L9R2>
	<20240423175718.4ad4dc5a@kernel.org>
	<ZiieqiuqNiy_W0mr@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Apr 2024 22:54:50 -0700 Joe Damato wrote:
> On Tue, Apr 23, 2024 at 05:57:18PM -0700, Jakub Kicinski wrote:
> > On Tue, 23 Apr 2024 12:42:13 -1000 Joe Damato wrote: =20
> > > I realized in this case, I'll need to set the fields initialized to 0=
xff
> > > above to 0 before doing the increments below. =20
> >=20
> > I don't know mlx4 very well, but glancing at the code - are you sure we
> > need to loop over the queues is the "base" callbacks?
> >=20
> > The base callbacks are for getting "historical" data, i.e. info which
> > was associated with queues which are no longer present. You seem to
> > sweep all queues, so I'd have expected "base" to just set the values=20
> > to 0. And the real values to come from the per-queue callbacks. =20
>=20
> Hmm. Sorry I must have totally misunderstood what the purpose of "base"
> was. I've just now more closely looked at bnxt which (maybe?) is the only
> driver that implements base and I think maybe I kind of get it now.
>=20
> For some reason, I thought it meant "the total stats of all queues"; I di=
dn't
> know it was intended to provide "historical" data as you say.
>=20
> Making it set everything to 0 makes sense to me. I suppose I could also s=
imply
> omit it? What do you think?

The base is used to figure out which stats are reported when we dump=20
a summary for the whole device. So you gotta set them to 0.

> > The init to 0xff looks quite sus. =20
>=20
> Yes the init to 0xff is wrong, too. I noticed that, as well.
>=20
> Here's what I have listed so far in my changelog for the v2 (which I have=
n't
> sent yet), but perhaps the maintainers of mlx4 can weigh in?
>=20
> v1 -> v2:
>  - Patch 1/3 now initializes dropped to 0.
>  - Patch 3/3 includes several changes:
>    - mlx4_get_queue_stats_rx and mlx4_get_queue_stats_tx check if i is
>      valid before proceeding.
>    - All initialization to 0xff for stats fields has been omit. The
>      network stack does this before calling into the driver functions, so
>      I've adjusted the driver functions to only set values if there is
>      data to set, leaving the network stack's 0xff in place if not.
>    - mlx4_get_base_stats sets all stats to 0 (no locking etc needed).

All the ones you report right? Not just zero the struct.
Any day now (tm) someone will add a lot more stats to the struct
so the init should be selective only to the stats that are actually
supported.

> Let me know if that sounds vaguely correct?
>=20
> > Also what does this:
> >  =20
> > >	if (!priv->port_up || mlx4_is_master(priv->mdev->dev)) =20
> >=20
> > do? =F0=9F=A4=94=EF=B8=8F what's a "master" in this context? =20
>=20
> I have a guess, but I'd rather let the Mellanox folks provide the official
> answer :)

My guess is that on multi-port only one of the netdevs is "in charge"
of the PCIe function. But these are queue stat, PCIe ownership may
matter for refresh but not for having the stats. So my guess must be
wrong..

> > > Sorry about that; just realized that now and will fix that in the v2 =
(along
> > > with any other feedback I get), probably something:
> > >=20
> > >   if (priv->rx_ring_num) {
> > >           rx->packets =3D 0;
> > >           rx->bytes =3D 0;
> > >           rx->alloc_fail =3D 0;
> > >   }
> > >=20
> > > Here for the RX side and see below for the TX side. =20
> >=20
> > FWIW I added a simple test for making sure queue stats match interface
> > stats, it's tools/testing/selftests/drivers/net/stats.py
> >=20
> > You have to export NETIF=3D$name to make it run on a real interface.
> >=20
> > To copy the tests to a remote machine I do:
> >=20
> > make -C tools/testing/selftests/ TARGETS=3D"net drivers/net drivers/net=
/hw" install INSTALL_PATH=3D/tmp/ksft-net-drv
> > rsync -ra --delete /tmp/ksft-net-drv root@${machine}:/root/
> >=20
> > HTH =20
>=20
> Thanks, this is a great help actually.
>=20
> I have a similar changeset for mlx5 (which is hardware I do have access t=
o)
> that adds the per-queue stats stuff so I'll definitely give your test a t=
ry.
>=20
> Seeing as I made a lot of errors in this series, I'll hold off on sending=
 the
> mlx5 series until this mlx4 series is fixed and accepted, that way I can
> produce a much better v1 for mlx5.

mlx5 would be awesome! But no pressure on sending ASAP. I was writing a
test for page pool allocation failures, which depends on qstat to check
if driver actually saw the errors (I'll send it later today), and I
couldn't confirm it working on mlx5 :(

