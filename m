Return-Path: <linux-rdma+bounces-6239-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 991299E3FFA
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 17:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 420FF165C2F
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 16:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934CD20CCC7;
	Wed,  4 Dec 2024 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="eKahpvPI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from master.debian.org (master.debian.org [82.195.75.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795324A28;
	Wed,  4 Dec 2024 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733330594; cv=none; b=jJfDd3vmU/BFGTcIRQoQvRz1BxyedqOaWYwnFC6fqMuROfI9/uRRPVNqfhkaMxXtKbmfWg771KtHsWo7jZIxkmo6jcpkZn/GYrvTs/F4+NNp8CyDSjX+uiDtuPrqNeN9q8xun2b2ABIcR/P4PPyEBH8jdrKxgp2MpRkTLv+B0KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733330594; c=relaxed/simple;
	bh=4tT1xTsxXZUI5Me8CpxOiXh3OyZEi6xFVGPDWXNILGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLrNSjFfbyDr15Pdf6jPPcetAqEdRigytn4yJTBV31uZb4LFwU7dV97DshsrQNGUwMQy2csl1wYQvUj6/wKI5oIvC4lsA4PrhQSeS1tzKAF/80jLlOkAMildveBZgYkRkrHfrEmMjL7FY0m1KYTbC052GO9xKfLSYQSraBebXcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=master.debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=eKahpvPI; arc=none smtp.client-ip=82.195.75.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=master.debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.master; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description;
	bh=hSp0xWyYxAqanUPupWSJ2QUcd1qQP8zfPnZwqCrb51E=; b=eKahpvPI8v0ItV9zLwcMXCsJoT
	pq9msAVeID6nZD5j+pNM05LsGkW2k+b5XRWG/Ydr2413QMs4hmH4NoHpcXbVjw0HLCfqjrSR+RUyn
	8msd5D2TckXIBokSoptmKw1di8McWLybY16z1cdRbMYbpLOyJMF0l5JFc2om3qqeSFrTQ73s5DZX5
	tsd731J6rxoOSoPqAVGlTxtp6gITnP+yXQZhFX7UCAPQy/qav13XGotVAIb87ifdNpQp7Hfgano+4
	xt0HM4bzEqaL1HNEnP8YFxG3zSfxz1QNsP1Sp1NTnt9SOfxscHPVV6OdZhjKUGiIB7NqWE1QrxNtQ
	670fg5HQ==;
Received: from ukleinek by master.debian.org with local (Exim 4.94.2)
	(envelope-from <ukleinek@master.debian.org>)
	id 1tIsN8-00EObM-IS; Wed, 04 Dec 2024 16:37:06 +0000
Date: Wed, 4 Dec 2024 17:37:05 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To: Francesco Poli <invernomuto@paranoici.org>
Cc: Leon Romanovsky <leonro@nvidia.com>, 
	"1086520@bugs.debian.org Mark Zhang" <markzhang@nvidia.com>, linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Bug#1086520: linux-image-6.11.2-amd64: makes opensm fail to start
Message-ID: <acpo6ocggcl66fjdllk5zrfs2vwiivpetd5ierdek5ruxvdbyl@tfbc3mfnp23o>
References: <20241113231503.54d12ed5b5d0c8fa9b7d9806@paranoici.org>
 <3wfi2j7jn2f7rajabfcengubgtyt3wkuin6hqepdoe5dlvfhvn@2clhco3z6fuw>
 <173040083268.16618.7451145398661885923.reportbug@crunch>
 <20241118200616.865cb4c869e693b19529df36@paranoici.org>
 <nvs4i2v7o6vn6zhmtq4sgazy2hu5kiulukxcntdelggmznnl7h@so3oul6uwgbl>
 <20241125195443.0ddf0d0176d7c34bd29942c7@paranoici.org>
 <20241125193837.GH160612@unreal>
 <20241127184803.75086499e71c6b1588a4fb5a@paranoici.org>
 <173040083268.16618.7451145398661885923.reportbug@crunch>
 <20241127200413.GE1245331@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eq7qn5hdhaesruc2"
Content-Disposition: inline
In-Reply-To: <20241127200413.GE1245331@unreal>


--eq7qn5hdhaesruc2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Bug#1086520: linux-image-6.11.2-amd64: makes opensm fail to start
MIME-Version: 1.0

Hello Francesco,

On Wed, Nov 27, 2024 at 10:04:13PM +0200, Leon Romanovsky wrote:
> On Wed, Nov 27, 2024 at 06:48:03PM +0100, Francesco Poli wrote:
> > On Mon, 25 Nov 2024 21:38:37 +0200 Leon Romanovsky wrote:
> >=20
> > > On Mon, Nov 25, 2024 at 07:54:43PM +0100, Francesco Poli wrote:
> > [...]
> > > > I will try to continue to bisect by testing the resulting kernels o=
n a
> > > > compute node: there's no OpenSM there and it cannot run anyway, if
> > > > there's another OpenSM on the same InfiniBand network.
> > > > However, I can check whether those issm* symlinks are created in
> > > > /sys/class/infiniband_mad/=20
> > > > I really hope that this is enough to pinpoint the first bad
> > > > commit...
> > >=20
> > > Yes, these symlinks should be there. Your test scenario is correct on=
e.
> >=20
> > OK, I have completed the bisect on a compute node without OpenSM, by
> > looking at the issm* symlinks, as I said.
> >=20
> > See below.
> >=20
> > >=20
> > > >=20
> > > > Any better ideas?
> > >=20
> > > I think that commit: 2a5db20fa532 ("RDMA/mlx5: Add support to multi-p=
lane device and port")
> > > is the one which is causing to troubles, which leads me to suspect FW.
> > [...]
> >=20
> > Thanks to your guess about the possibly troublesome commit, the bisect =
was completed in a few steps:
> >=20
> >   $ git checkout 2a5db20fa532
> >   $ make -j 12 my_defconfig bindeb-pkg
> >  =20
> >   [install this version on a compute node test image and reboot
> >   one compute node with that image: the InfiniBand network was
> >   working for that node, that's no surprise, since OpenSM was running
> >   on the head node, but no issm* symlink was created; please note
> >   that, surprisingly, the Ethernet network was not working, I mean
> >   that the Ethernet interfaces were not found by the kernel...]
> >  =20
> >   root@node # ls -altrF /sys/class/infiniband_mad/
> >   total 0
> >   drwxr-xr-x 60 root root    0 Nov 26 17:06 ../
> >   lrwxrwxrwx  1 root root    0 Nov 26 17:06 umad0 -> ../../devices/pci0=
000:00/0000:00:01.1/0000:01:00.0/infiniband_mad/umad0/
> >   -r--r--r--  1 root root 4096 Nov 26 17:06 abi_version
> >   lrwxrwxrwx  1 root root    0 Nov 26 17:06 umad1 -> ../../devices/pci0=
000:00/0000:00:01.1/0000:01:00.1/infiniband_mad/umad1/
> >   drwxr-xr-x  2 root root    0 Nov 26 17:08 ./
> >  =20
> >   $ git bisect bad
> >   Bisecting: 0 revisions left to test after this (roughly 0 steps)
> >   [65528cfb21fdb68de8ae6dccae19af180d93e143] net/mlx5: mlx5_ifc update =
for multi-plane support
> >   $ make -j 12 my_defconfig bindeb-pkg
> >  =20
> >   [install this version on the compute node test image and reboot
> >   one compute node with that image: the InfiniBand network again
> >   working for that node, issm* symlinks were created;
> >   Ethernet network again not working for that node...]
> >  =20
> >   root@node # ls -altrF /sys/class/infiniband_mad/
> >   total 0
> >   drwxr-xr-x 60 root root    0 Nov 26 17:31 ../
> >   lrwxrwxrwx  1 root root    0 Nov 26 17:31 umad0 -> ../../devices/pci0=
000:00/0000:00:01.1/0000:01:00.0/infiniband_mad/umad0/
> >   -r--r--r--  1 root root 4096 Nov 26 17:31 abi_version
> >   lrwxrwxrwx  1 root root    0 Nov 26 17:31 umad1 -> ../../devices/pci0=
000:00/0000:00:01.1/0000:01:00.1/infiniband_mad/umad1/
> >   lrwxrwxrwx  1 root root    0 Nov 26 17:36 issm1 -> ../../devices/pci0=
000:00/0000:00:01.1/0000:01:00.1/infiniband_mad/issm1/
> >   lrwxrwxrwx  1 root root    0 Nov 26 17:36 issm0 -> ../../devices/pci0=
000:00/0000:00:01.1/0000:01:00.0/infiniband_mad/issm0/
> >   drwxr-xr-x  2 root root    0 Nov 26 17:36 ./
> >  =20
> >   $ git bisect good
> >   2a5db20fa532198639671713c6213f96ff285b85 is the first bad commit
> >   commit 2a5db20fa532198639671713c6213f96ff285b85
> >   Author: Mark Zhang <markzhang@nvidia.com>
> >   Date:   Sun Jun 16 19:08:35 2024 +0300
> >  =20
> >       RDMA/mlx5: Add support to multi-plane device and port
> >  =20
> >       When multi-plane is supported, a logical port, which is aggregati=
on of
> >       multiple physical plane ports, is exposed for data transmission.
> >       Compared with a normal mlx5 IB port, this logical port supports a=
ll
> >       functionalities except Subnet Management.
> >  =20
> >       Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> >       Link: https://lore.kernel.org/r/7e37c06c9cb243be9ac79930cd1705390=
3785b95.1718553901.git.leon@kernel.org
> >       Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> >  =20
> >    drivers/infiniband/hw/mlx5/main.c               | 60 +++++++++++++++=
++++++----
> >    drivers/infiniband/hw/mlx5/mlx5_ib.h            |  2 +
> >    drivers/net/ethernet/mellanox/mlx5/core/vport.c |  1 +
> >    include/linux/mlx5/driver.h                     |  1 +
> >    4 files changed, 55 insertions(+), 9 deletions(-)
> >=20
> >=20
> > In other words, bingo!, your guess looks correct, the first bad commit
> > is the one you mentioned.
> >=20
> >=20
> > Now, I will try to upgrade the firmware of the InfiniBand NICs, as you
> > suggested, and check whether this solves the issue with the recent
> > Linux kernel versions.
> >=20
> > Please confirm that the procedure to be followed is the one described in
> > <https://docs.nvidia.com/networking/display/ubuntu2204/firmware+burning>
>=20
> Yes, it looks correct procedure.
> If you didn't upgrade FW, this diff will achieve same result for you:
>=20
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/ml=
x5/main.c
> index c2314797afc9..110ce177c305 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -2846,7 +2846,7 @@ static int mlx5_ib_get_plane_num(struct mlx5_core_d=
ev *mdev, u8 *num_plane)
>         if (err)
>                 return err;
>=20
> -       *num_plane =3D vport_ctx.num_plane;
> +       *num_plane =3D (vport_ctx.num_plane > 1) ? vport_ctx.num_plane : =
0;
>         return 0;
>  }
>=20
> The culprit of your issue that in some FW versions, the vport_ctx.num_pla=
ne
> was 1 and not 0 for devices which don't support that mode, while for the =
driver
> everything that is not 0 means supported.

I wonder if you could test a firmware upgrade or the above patch. Would
be nice to know if there are still some things to do for us (=3D Debian
kernel team) here.

If everything is fine for you, I'd like to close this bug.

Best regards
Uwe

--eq7qn5hdhaesruc2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdQhS4ACgkQj4D7WH0S
/k78mggAgQeh/GCn2XHHJQ4qCF+fi4lbYa4h5vWY3TeUfVkO5sd3qEXjcnYYi2D8
XjMPToRyBws3qsHdtzVP70mHZJIPbtSf2Ah22n4PUtf1St/j+o6MkgUWgviYPiO2
y0Ayux/2aFXLhdTHuM44jXVkGJU5nCv9gpO9aiSb8wdwy3Kif0vzgAnj1uXxbNXC
/sfCk9lhOz6HQZGldDNL5fudAMFWwt3DJb0BxpvVe8XzE9Uradsh7pUWs7K6rRLj
yurlX9SxYhQ0oWycTsmHxcvwz5ltdXQ4Veb3gJbsLntmDofsiMHw1YhJqKPUCMVp
jrGokmLt57u6GaWz+ZKnhC40q9vVNQ==
=RBHV
-----END PGP SIGNATURE-----

--eq7qn5hdhaesruc2--

