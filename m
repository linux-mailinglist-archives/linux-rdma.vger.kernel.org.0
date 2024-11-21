Return-Path: <linux-rdma+bounces-6050-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB0E9D4AD1
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2024 11:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC00286BDF
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2024 10:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C741D279F;
	Thu, 21 Nov 2024 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Eyn2isdw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from master.debian.org (master.debian.org [82.195.75.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1991CFEDC;
	Thu, 21 Nov 2024 10:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732184585; cv=none; b=EZbSQlbb2s9rHWHwcmFup1WtzwNJyYuA27eklya8zGeZFEy097vFVdUoOu1e6jq4aextJ5mkxOv9j54ylQH5WTZKzR5NnaqB4/9aWAkGlebAL4i2On0fLnxUS0ayKa8UJl6FLvTAEXKYtFxdEUajK1LAlPk387n8kDBsJi/vp2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732184585; c=relaxed/simple;
	bh=YPZqpAxy7GCVvcdtXvolnWKZNRYVBf4yGsNDPr5iFM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGURQDKH/GuR/9G1l7H2e8jTUb2Bdndn7EzHTukn1yTdXHIt2KyLoHmnhzOas/UuVlhTpvT1m1pWYx5GgI/W9zG0uuTOCGzH5gI+fi6xcfJeusk9YRnRoLbxgr+Hf1detIos3aNvuJWKP0IfvlL+CXsN6s/yo21/ZOEj5P1c40c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=master.debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Eyn2isdw; arc=none smtp.client-ip=82.195.75.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=master.debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.master; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description;
	bh=ADhMWaYu2XGQ6+9qDOs+NTUdkqHg38q2DuFu48rxw4s=; b=Eyn2isdwa0VseUhA/yfY3MOikZ
	lkUIHyyEcGnCyh0fem/6aEJeuEj57Kg2kbV1yYWxwxBQbWOYaW9uxgzd5dMph8Zjg36IG4pM2wPVI
	FKxzDbmM8lBYug0M7KcF2EEQCzgVR+8/hkinXydA4BbgdiWCIKUu9GGOkQlTnai3zgFLr+9Xdw61H
	WPrlZCKIqHiJLzEu8+nOIdrHFeurXetlSVbnd2Q5B3FS1JYUSPCcl34n6pxsl72zLdqFnB6xTCF68
	N2nq2ajcS0U05SNHzru+JB7mVTcopAzw+/L+xemiehpLeWqos4i1FUJMXnyuh/yXwacY0N0wqqQA2
	Q2xiO/FA==;
Received: from ukleinek by master.debian.org with local (Exim 4.94.2)
	(envelope-from <ukleinek@master.debian.org>)
	id 1tE42o-006ID0-JD; Thu, 21 Nov 2024 10:04:14 +0000
Date: Thu, 21 Nov 2024 11:04:13 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To: Francesco Poli <invernomuto@paranoici.org>, 1086520@bugs.debian.org
Cc: Mark Zhang <markzhang@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Bug#1086520: linux-image-6.11.2-amd64: makes opensm fail to start
Message-ID: <nvs4i2v7o6vn6zhmtq4sgazy2hu5kiulukxcntdelggmznnl7h@so3oul6uwgbl>
References: <173040083268.16618.7451145398661885923.reportbug@crunch>
 <jaw7557rpn2eln3dtb2xbv2gvzkzde6mfful7d2mf5mgc3wql7@wikm2a7a3kcv>
 <173040083268.16618.7451145398661885923.reportbug@crunch>
 <20241113231503.54d12ed5b5d0c8fa9b7d9806@paranoici.org>
 <3wfi2j7jn2f7rajabfcengubgtyt3wkuin6hqepdoe5dlvfhvn@2clhco3z6fuw>
 <173040083268.16618.7451145398661885923.reportbug@crunch>
 <20241118200616.865cb4c869e693b19529df36@paranoici.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lxp75oumfys2vsey"
Content-Disposition: inline
In-Reply-To: <20241118200616.865cb4c869e693b19529df36@paranoici.org>


--lxp75oumfys2vsey
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Bug#1086520: linux-image-6.11.2-amd64: makes opensm fail to start
MIME-Version: 1.0

Hello Francesco,

[for the new-comers: This is about a regression in 6.11. Details
available at https://bugs.debian.org/1086520. The TL;DR; is that on
6.10.11 opensm works as expected, while it fails to start on 6.11.7.]

On Mon, Nov 18, 2024 at 08:06:16PM +0100, Francesco Poli wrote:
> On Mon, 18 Nov 2024 09:58:03 +0100 Uwe Kleine-K=F6nig wrote:
>=20
> [...]
> > On Wed, Nov 13, 2024 at 11:15:03PM +0100, Francesco Poli wrote:
> > > On Mon, 11 Nov 2024 11:22:26 +0100 Uwe Kleine-K=F6nig wrote:
> [...]
> > > > I guess the kernel provides a directory "/sys/class/infiniband_mad"=
=2E Do
> > > > its contents look different on 6.10.x and 6.11.x?
> > >=20
> > > I will look into this as soon as I can reboot the cluster head node.
>=20
> I looked into this, while testing the new Debian Linux kernel that has
> just migrated to testing (which, once again, makes opensm fail to
> start, just like other 6.11.x versions).
>=20
> With a working kernel:
>=20
>   $ uname -v
>   #1 SMP PREEMPT_DYNAMIC Debian 6.10.11-1 (2024-09-22)
>   $ ls -altrF /sys/class/infiniband_mad/
>   total 0
>   lrwxrwxrwx  1 root root    0 Nov  4 15:58 umad0 -> ../../devices/pci000=
0:80/0000:80:01.1/0000:81:00.0/infiniband_mad/umad0/
>   lrwxrwxrwx  1 root root    0 Nov  4 15:58 umad1 -> ../../devices/pci000=
0:80/0000:80:01.1/0000:81:00.1/infiniband_mad/umad1/
>   lrwxrwxrwx  1 root root    0 Nov 11 15:54 issm1 -> ../../devices/pci000=
0:80/0000:80:01.1/0000:81:00.1/infiniband_mad/issm1/
>   lrwxrwxrwx  1 root root    0 Nov 11 15:54 issm0 -> ../../devices/pci000=
0:80/0000:80:01.1/0000:81:00.0/infiniband_mad/issm0/
>   drwxr-xr-x  2 root root    0 Nov 11 15:54 ./
>   drwxr-xr-x 72 root root    0 Nov 11 15:54 ../
>   -r--r--r--  1 root root 4096 Nov 11 15:54 abi_version
>   $ cat /sys/class/infiniband_mad/abi_version=20
>   5
>=20
> With a kernel that makes opensm fail to start:
>=20
>   $ uname -v
>   #1 SMP PREEMPT_DYNAMIC Debian 6.11.7-1 (2024-11-09)
>   $ ls -altrF /sys/class/infiniband_mad/
>   total 0
>   drwxr-xr-x 73 root root    0 Nov 18 09:41 ../
>   -r--r--r--  1 root root 4096 Nov 18 09:41 abi_version
>   lrwxrwxrwx  1 root root    0 Nov 18 09:41 umad0 -> ../../devices/pci000=
0:80/0000:80:01.1/0000:81:00.0/infiniband_mad/umad0/
>   lrwxrwxrwx  1 root root    0 Nov 18 09:41 umad1 -> ../../devices/pci000=
0:80/0000:80:01.1/0000:81:00.1/infiniband_mad/umad1/
>   drwxr-xr-x  2 root root    0 Nov 18 09:43 ./
>   $ cat /sys/class/infiniband_mad/abi_version
>   5
>=20
> As you can see, a couple of files (symlinks) are missing here...

It looks like the commit that is biting you is

https://git.kernel.org/linus/50660c5197f52b8137e223dc3ba8d43661179a1d

So if you bisect, try 50660c5197f52b8137e223dc3ba8d43661179a1d and its
parent 24943dcdc156cf294d97a36bf5c51168bf574c22 first.

I don't know about infiniband, but I'd say: Either your machine doesn't
have these issmX devices and opensm should cope with that, or these
issmX devices are available then
50660c5197f52b8137e223dc3ba8d43661179a1d is buggy.

> Does this ring a bell?

It doesn't for me, but maybe Mark Zhang or someone else among the new
recipients has an idea?

Best regards
Uwe


--lxp75oumfys2vsey
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmc/BZoACgkQj4D7WH0S
/k4zqQgAsbt26Ykfm1Qaj7z6hMKpBGkZmxeAjRv8ol7WKvRI844thn3aWf7tDE3W
w8+0fXZge2/JAQHG/rBfplvl7fSvYl1w/JBkyX1TsX3S6kCZjPra9lT0O/jui34t
/YDpriU28ZK84yF6WwuKjMGqR8eYcW5uQNrukSdMm6XwV5HfYAKOHP7u/83NdN71
llzo3+mjzm9S6zQe60xy07r+yqtobKYV2T2CpefLKOh491hG363Q75I5xV6zCSd2
GQBfvy5frs+Brj1lqpnYaSCdnsIAS9nkL5QwYsvuV4L0Ie0ltoDoSNI01vclGI+y
5X/Z+t5L874w89JWKoObCRUDEA22qw==
=Tkh1
-----END PGP SIGNATURE-----

--lxp75oumfys2vsey--

