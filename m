Return-Path: <linux-rdma+bounces-6128-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6D59DACC5
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2024 18:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 577F8B220D5
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2024 17:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127F020103C;
	Wed, 27 Nov 2024 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b="DMH9Nj4x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13591F9EDC;
	Wed, 27 Nov 2024 17:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732730255; cv=none; b=fzzH3bgfLCAV/rpcu9Mi1ldLF5Hekx6dsrualEjwZkI10Cnes2txWd2eKPEzx2cCSRCF+22ZHYTRa9TddIAZ/bSxx8jfWI1nxXlzYi2E7gAnJOIbOd3qmOGFgVmHREmRGYH+6a/0ajBsFvYamBUl2wYPtqFMivTQUvMwtrEgpmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732730255; c=relaxed/simple;
	bh=ssc8+x45uYtdsQermSnlm21imfsLHCA0BpP4c3W5/bI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NoAJOtNVJRKFUs1OacBj7bKx37TpBlY3+DrYxLC1xfjPFlI23Z1xuixns3PPGcHV9+AkJGQQFRGCr3B1n83UshY1KVjwh/j28W8SibL29SMa2g0rf3QyamCXUDPfawl/kWji4bQ2ORAUBwefzO49/Qe1Vxw4LvqO+cWTZCCc2qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org; spf=pass smtp.mailfrom=paranoici.org; dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b=DMH9Nj4x; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paranoici.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paranoici.org;
	s=stigmate; t=1732729703;
	bh=TMfGlKmDkUlDGaT8cORJfVr29uuDvXsJrr1YxzKPkG0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DMH9Nj4x+2vNPPYFirP4R/1Qbzs67ztXHICUO/MZnNlJk6a8bEGQfvQ8Sf1kJj/HL
	 jK5tZFqS1QcRLXWBDemjfJ9Grk03LzaFXzvid03fXzwLiGz2uHwabv6AxJKeLpxUwm
	 CiwdGD8GQZrqkkqE4aWFPIQCc+/RCvc7LRCv234o=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4Xz6P3273nz11H3;
	Wed, 27 Nov 2024 17:48:23 +0000 (UTC)
Received: from [93.190.126.19] (mx1.investici.org [93.190.126.19]) (Authenticated sender: invernomuto@paranoici.org) by localhost (Postfix) with ESMTPSA id 4Xz6P31nF3z1144;
	Wed, 27 Nov 2024 17:48:23 +0000 (UTC)
Received: from frx by crunch with local (Exim 4.98)
	(envelope-from <invernomuto@paranoici.org>)
	id 1tGM9G-00000000CZc-0bFO;
	Wed, 27 Nov 2024 18:48:22 +0100
Date: Wed, 27 Nov 2024 18:48:03 +0100
From: Francesco Poli <invernomuto@paranoici.org>
To: Leon Romanovsky <leonro@nvidia.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@debian.org>,
 <1086520@bugs.debian.org>, Mark Zhang <markzhang@nvidia.com>,
 <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: Bug#1086520: linux-image-6.11.2-amd64: makes opensm fail to
 start
Message-Id: <20241127184803.75086499e71c6b1588a4fb5a@paranoici.org>
In-Reply-To: <20241125193837.GH160612@unreal>
References: <173040083268.16618.7451145398661885923.reportbug@crunch>
	<jaw7557rpn2eln3dtb2xbv2gvzkzde6mfful7d2mf5mgc3wql7@wikm2a7a3kcv>
	<173040083268.16618.7451145398661885923.reportbug@crunch>
	<20241113231503.54d12ed5b5d0c8fa9b7d9806@paranoici.org>
	<3wfi2j7jn2f7rajabfcengubgtyt3wkuin6hqepdoe5dlvfhvn@2clhco3z6fuw>
	<173040083268.16618.7451145398661885923.reportbug@crunch>
	<20241118200616.865cb4c869e693b19529df36@paranoici.org>
	<nvs4i2v7o6vn6zhmtq4sgazy2hu5kiulukxcntdelggmznnl7h@so3oul6uwgbl>
	<20241125195443.0ddf0d0176d7c34bd29942c7@paranoici.org>
	<20241125193837.GH160612@unreal>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA512";
 boundary="Signature=_Wed__27_Nov_2024_18_48_03_+0100_yjdnRe8fnuF.YdD8"

--Signature=_Wed__27_Nov_2024_18_48_03_+0100_yjdnRe8fnuF.YdD8
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Nov 2024 21:38:37 +0200 Leon Romanovsky wrote:

> On Mon, Nov 25, 2024 at 07:54:43PM +0100, Francesco Poli wrote:
[...]
> > I will try to continue to bisect by testing the resulting kernels on a
> > compute node: there's no OpenSM there and it cannot run anyway, if
> > there's another OpenSM on the same InfiniBand network.
> > However, I can check whether those issm* symlinks are created in
> > /sys/class/infiniband_mad/=20
> > I really hope that this is enough to pinpoint the first bad
> > commit...
>=20
> Yes, these symlinks should be there. Your test scenario is correct one.

OK, I have completed the bisect on a compute node without OpenSM, by
looking at the issm* symlinks, as I said.

See below.

>=20
> >=20
> > Any better ideas?
>=20
> I think that commit: 2a5db20fa532 ("RDMA/mlx5: Add support to multi-plane=
 device and port")
> is the one which is causing to troubles, which leads me to suspect FW.
[...]

Thanks to your guess about the possibly troublesome commit, the bisect was =
completed in a few steps:

  $ git checkout 2a5db20fa532
  $ make -j 12 my_defconfig bindeb-pkg
 =20
  [install this version on a compute node test image and reboot
  one compute node with that image: the InfiniBand network was
  working for that node, that's no surprise, since OpenSM was running
  on the head node, but no issm* symlink was created; please note
  that, surprisingly, the Ethernet network was not working, I mean
  that the Ethernet interfaces were not found by the kernel...]
 =20
  root@node # ls -altrF /sys/class/infiniband_mad/
  total 0
  drwxr-xr-x 60 root root    0 Nov 26 17:06 ../
  lrwxrwxrwx  1 root root    0 Nov 26 17:06 umad0 -> ../../devices/pci0000:=
00/0000:00:01.1/0000:01:00.0/infiniband_mad/umad0/
  -r--r--r--  1 root root 4096 Nov 26 17:06 abi_version
  lrwxrwxrwx  1 root root    0 Nov 26 17:06 umad1 -> ../../devices/pci0000:=
00/0000:00:01.1/0000:01:00.1/infiniband_mad/umad1/
  drwxr-xr-x  2 root root    0 Nov 26 17:08 ./
 =20
  $ git bisect bad
  Bisecting: 0 revisions left to test after this (roughly 0 steps)
  [65528cfb21fdb68de8ae6dccae19af180d93e143] net/mlx5: mlx5_ifc update for =
multi-plane support
  $ make -j 12 my_defconfig bindeb-pkg
 =20
  [install this version on the compute node test image and reboot
  one compute node with that image: the InfiniBand network again
  working for that node, issm* symlinks were created;
  Ethernet network again not working for that node...]
 =20
  root@node # ls -altrF /sys/class/infiniband_mad/
  total 0
  drwxr-xr-x 60 root root    0 Nov 26 17:31 ../
  lrwxrwxrwx  1 root root    0 Nov 26 17:31 umad0 -> ../../devices/pci0000:=
00/0000:00:01.1/0000:01:00.0/infiniband_mad/umad0/
  -r--r--r--  1 root root 4096 Nov 26 17:31 abi_version
  lrwxrwxrwx  1 root root    0 Nov 26 17:31 umad1 -> ../../devices/pci0000:=
00/0000:00:01.1/0000:01:00.1/infiniband_mad/umad1/
  lrwxrwxrwx  1 root root    0 Nov 26 17:36 issm1 -> ../../devices/pci0000:=
00/0000:00:01.1/0000:01:00.1/infiniband_mad/issm1/
  lrwxrwxrwx  1 root root    0 Nov 26 17:36 issm0 -> ../../devices/pci0000:=
00/0000:00:01.1/0000:01:00.0/infiniband_mad/issm0/
  drwxr-xr-x  2 root root    0 Nov 26 17:36 ./
 =20
  $ git bisect good
  2a5db20fa532198639671713c6213f96ff285b85 is the first bad commit
  commit 2a5db20fa532198639671713c6213f96ff285b85
  Author: Mark Zhang <markzhang@nvidia.com>
  Date:   Sun Jun 16 19:08:35 2024 +0300
 =20
      RDMA/mlx5: Add support to multi-plane device and port
 =20
      When multi-plane is supported, a logical port, which is aggregation of
      multiple physical plane ports, is exposed for data transmission.
      Compared with a normal mlx5 IB port, this logical port supports all
      functionalities except Subnet Management.
 =20
      Signed-off-by: Mark Zhang <markzhang@nvidia.com>
      Link: https://lore.kernel.org/r/7e37c06c9cb243be9ac79930cd17053903785=
b95.1718553901.git.leon@kernel.org
      Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
 =20
   drivers/infiniband/hw/mlx5/main.c               | 60 +++++++++++++++++++=
++----
   drivers/infiniband/hw/mlx5/mlx5_ib.h            |  2 +
   drivers/net/ethernet/mellanox/mlx5/core/vport.c |  1 +
   include/linux/mlx5/driver.h                     |  1 +
   4 files changed, 55 insertions(+), 9 deletions(-)


In other words, bingo!, your guess looks correct, the first bad commit
is the one you mentioned.


Now, I will try to upgrade the firmware of the InfiniBand NICs, as you
suggested, and check whether this solves the issue with the recent
Linux kernel versions.

Please confirm that the procedure to be followed is the one described in
<https://docs.nvidia.com/networking/display/ubuntu2204/firmware+burning>

Thanks for your time and patience, and for all the help you are kindly
providing!   :-)


--=20
 http://www.inventati.org/frx/
 There's not a second to spare! To the laboratory!
..................................................... Francesco Poli .
 GnuPG key fpr =3D=3D CA01 1147 9CD2 EFDF FB82  3925 3E1C 27E1 1F69 BFFE

--Signature=_Wed__27_Nov_2024_18_48_03_+0100_yjdnRe8fnuF.YdD8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEygERR5zS79/7gjklPhwn4R9pv/4FAmdHW1MACgkQPhwn4R9p
v/6QJRAAjYjCYH0ksnEdwq2Cj0PkDmAO2M5GpTH7Xg4i7ecErrvYyCGOXpKJ4Qog
1qv5BtVYVbcK9fcDa8CUhZehbNH+4nVg8qHHT0I2HRrhErJErP7EoudHUfc9WeDc
mRiXUQV9dg3hWY1PNMwees9RC81BADOO4GOEsme5rwuoL1P6zanR0plY5MmVbhj/
f9Cia8wZoun19miYeA5JsEHDODjdhqEcnAuubF5JBEem9ZRvSmhlJJHapT+Tsb4k
tu9iYg5+8AdCWQ0zTYJfR7bFgkbJ/kZNbk3e4KfXRgYXlukl89mS8+B0m2k+vbqt
x46jm3W4yoBuxoWbA6i/sfHVX7H8gu1C0/TTMQ/CXM/mD8eVnFAmrHF/wN2BI50S
OLPWrzSuVMzUxuW2qaUBaXaQLTwaOW+NVQb6IM5mknHY/GizskL6nP+aBomjSHo6
MqYdj/NaWInOn/uNvr8h7yYsBQlK5wyjiwF0wU/f4HnTIUda11ZQZxOvDuQSHv9p
ZdlwCsobdX97rl94Ty/oku96DAog/j6pKoFFDOcqXzCgEV11WU79KQ+6M0ACBf+/
PVCCLnf/UjuoogDuaOeQ6QtMelS0SVX6uzh70gWv71q3EF396EpxqS1OCTtVHkxf
buthBhNT6kDskVixMrBXwv2psypw7tGm7MqfzI4Ichf7IvzHYv0=
=PxeC
-----END PGP SIGNATURE-----

--Signature=_Wed__27_Nov_2024_18_48_03_+0100_yjdnRe8fnuF.YdD8--

