Return-Path: <linux-rdma+bounces-6091-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9049D8C95
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2024 20:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 842F31619BD
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2024 19:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5D617F4F6;
	Mon, 25 Nov 2024 19:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b="LTeTFaSj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6219016CD35;
	Mon, 25 Nov 2024 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732561425; cv=none; b=Dgfy663aBfznzFPHNifBksay/QSz+1bi+nMGPOopQpFh+3sH+IEtUEkcFH6ZEhOJ1jrhSSqUK/69CK+URT3pHeNmriK2yoUPQJrBIy3D8VICTlW4czxbhTgjWteUEuL3RwkcZb2BP5tzt49weYnMRyo89gfTzhg6LyJ/N5ZGcPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732561425; c=relaxed/simple;
	bh=9ku+h65M6+VPZXQ6WcZ4YG41rpM8CqLhibh84fYnn+8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=l76bcPMfZN7UeJ+YfMwsIFYPd7vWM3K7TxhmNJ+sn1PbgueUM8b0ZQlRrMK9mHfaISwfqEpte49lJPai/sXBo7jujlSM3GKUr3cEIG09ACXIa7FeCzE7Xr4X035aj4f29rZzKvVNI3hGnT/x6aVwMUasGPOKRyk++dWTgGddaxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org; spf=pass smtp.mailfrom=paranoici.org; dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b=LTeTFaSj; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paranoici.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paranoici.org;
	s=stigmate; t=1732560903;
	bh=M6fz4P98w3VjpGDNzAgndwqt7Oc1F7x0EIDpJAYrNRg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LTeTFaSjsi+/BQUPSsqAdLI8AEtwfQGMxUZ8eEcuPkk6wvHaTKv0ndgKYdkKI/JAU
	 XX4ISyAc+ixYINTWzTWBkicP+2ScOjirWRKrLqY7FPLns6m8K7dRk1XERDZu8rxIQX
	 E789k+ePHLEn7PmlVJIcBWYsMWfPHwXktXi/KCFg=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4Xxvyv0mqfz72WY;
	Mon, 25 Nov 2024 18:55:03 +0000 (UTC)
Received: from [198.167.222.108] (mx2.investici.org [198.167.222.108]) (Authenticated sender: invernomuto@paranoici.org) by localhost (Postfix) with ESMTPSA id 4Xxvyv0VjMz70Pd;
	Mon, 25 Nov 2024 18:55:03 +0000 (UTC)
Received: from frx by crunch with local (Exim 4.98)
	(envelope-from <invernomuto@paranoici.org>)
	id 1tFeEf-000000003J6-2q3L;
	Mon, 25 Nov 2024 19:55:01 +0100
Date: Mon, 25 Nov 2024 19:54:43 +0100
From: Francesco Poli <invernomuto@paranoici.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@debian.org>
Cc: 1086520@bugs.debian.org, Mark Zhang <markzhang@nvidia.com>, Leon
 Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: Bug#1086520: linux-image-6.11.2-amd64: makes opensm fail to
 start
Message-Id: <20241125195443.0ddf0d0176d7c34bd29942c7@paranoici.org>
In-Reply-To: <nvs4i2v7o6vn6zhmtq4sgazy2hu5kiulukxcntdelggmznnl7h@so3oul6uwgbl>
References: <173040083268.16618.7451145398661885923.reportbug@crunch>
	<jaw7557rpn2eln3dtb2xbv2gvzkzde6mfful7d2mf5mgc3wql7@wikm2a7a3kcv>
	<173040083268.16618.7451145398661885923.reportbug@crunch>
	<20241113231503.54d12ed5b5d0c8fa9b7d9806@paranoici.org>
	<3wfi2j7jn2f7rajabfcengubgtyt3wkuin6hqepdoe5dlvfhvn@2clhco3z6fuw>
	<173040083268.16618.7451145398661885923.reportbug@crunch>
	<20241118200616.865cb4c869e693b19529df36@paranoici.org>
	<nvs4i2v7o6vn6zhmtq4sgazy2hu5kiulukxcntdelggmznnl7h@so3oul6uwgbl>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA512";
 boundary="Signature=_Mon__25_Nov_2024_19_54_43_+0100_ms7K9=h3DEstPnbE"

--Signature=_Mon__25_Nov_2024_19_54_43_+0100_ms7K9=h3DEstPnbE
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Nov 2024 11:04:13 +0100 Uwe Kleine-K=C3=B6nig wrote:

[...]
> It looks like the commit that is biting you is
>=20
> https://git.kernel.org/linus/50660c5197f52b8137e223dc3ba8d43661179a1d
>=20
> So if you bisect, try 50660c5197f52b8137e223dc3ba8d43661179a1d and its
> parent 24943dcdc156cf294d97a36bf5c51168bf574c22 first.

I started to bisect.

The first surprise is that 50660c5197f52b8137e223dc3ba8d43661179a1d is
good...   :-o

  $ git checkout 50660c5197f52b8137e223dc3ba8d43661179a1d
  $ make -j 12 my_defconfig bindeb-pkg

  [install and reboot with this kernel version]

  # ls /sys/class/infiniband_mad/ -altrF
  total 0
  drwxr-xr-x 70 root root    0 Nov 25 12:05 ../
  -r--r--r--  1 root root 4096 Nov 25 12:05 abi_version
  lrwxrwxrwx  1 root root    0 Nov 25 12:05 umad0 -> ../../devices/pci0000:=
80/0000:80:01.1/0000:81:00.0/infiniband_mad/umad0/
  lrwxrwxrwx  1 root root    0 Nov 25 12:05 umad1 -> ../../devices/pci0000:=
80/0000:80:01.1/0000:81:00.1/infiniband_mad/umad1/
  lrwxrwxrwx  1 root root    0 Nov 25 12:08 issm1 -> ../../devices/pci0000:=
80/0000:80:01.1/0000:81:00.1/infiniband_mad/issm1/
  lrwxrwxrwx  1 root root    0 Nov 25 12:08 issm0 -> ../../devices/pci0000:=
80/0000:80:01.1/0000:81:00.0/infiniband_mad/issm0/
  drwxr-xr-x  2 root root    0 Nov 25 12:08 ./

  [InfiniBand works]

  $ git bisect start
  $ git bisect good
  $ git checkout v6.11
  $ make -j 12 my_defconfig bindeb-pkg

  [install and reboot with this kernel version]

  # ls /sys/class/infiniband_mad/ -altrF
  total 0
  drwxr-xr-x 70 root root    0 Nov 25 12:29 ../
  -r--r--r--  1 root root 4096 Nov 25 12:29 abi_version
  lrwxrwxrwx  1 root root    0 Nov 25 12:29 umad0 -> ../../devices/pci0000:=
80/0000:80:01.1/0000:81:00.0/infiniband_mad/umad0/
  lrwxrwxrwx  1 root root    0 Nov 25 12:29 umad1 -> ../../devices/pci0000:=
80/0000:80:01.1/0000:81:00.1/infiniband_mad/umad1/
  drwxr-xr-x  2 root root    0 Nov 25 12:30 ./

  [InfiniBand fails, because OpenSM fails to start]

  $ git bisect bad
  Bisecting: 7036 revisions left to test after this (roughly 13 steps)
  [b3ce7a30847a54a7f96a35e609303d8afecd460b] Merge tag 'drm-next-2024-07-18=
' of https://gitlab.freedesktop.org/drm/kernel
  $ make -j 12 my_defconfig bindeb-pkg


Woooha, 13 steps are a lot...

I went on until 10 steps are left:

  [test b3ce7a30847a54a7f96a35e609303d8afecd460b]
  $ git bisect good
  Bisecting: 3385 revisions left to test after this (roughly 12 steps)
  [fbc90c042cd1dc7258ebfebe6d226017e5b5ac8c] Merge tag 'mm-stable-2024-07-2=
1-14-50' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
 =20
  [test fbc90c042cd1dc7258ebfebe6d226017e5b5ac8c]
  $ git bisect bad
  Bisecting: 1763 revisions left to test after this (roughly 11 steps)
  [09ea8089abb5d851ce08a9b1a43706e42ef39db2] Merge tag 'staging-6.11-rc1' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging

  [test 09ea8089abb5d851ce08a9b1a43706e42ef39db2]
  $ git bisect bad
  Bisecting: 910 revisions left to test after this (roughly 10 steps)
  [4305ca0087dd99c3c3e0e2ac8a228b7e53a21c78] Merge tag 'scsi-misc' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi


Since I could not afford to keep the cluster out of service any longer
(each step takes at least 20 or 25 minutes: build + install + reboot +
check InfiniBand), I decided to return the cluster to service.

I will try to continue to bisect by testing the resulting kernels on a
compute node: there's no OpenSM there and it cannot run anyway, if
there's another OpenSM on the same InfiniBand network.
However, I can check whether those issm* symlinks are created in
/sys/class/infiniband_mad/=20
I really hope that this is enough to pinpoint the first bad
commit...

Any better ideas?


--=20
 http://www.inventati.org/frx/
 There's not a second to spare! To the laboratory!
..................................................... Francesco Poli .
 GnuPG key fpr =3D=3D CA01 1147 9CD2 EFDF FB82  3925 3E1C 27E1 1F69 BFFE

--Signature=_Mon__25_Nov_2024_19_54_43_+0100_ms7K9=h3DEstPnbE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEygERR5zS79/7gjklPhwn4R9pv/4FAmdEx/QACgkQPhwn4R9p
v/4ZXw/6Ap8I5PS6e6wKSo47UVJ0iB8+NqbtxpYGg8aB8f4tyE8An6TzsblP8Wtg
QRnJqBE594/mHipy3Ys/mtUHBRirqR179opRVPYFnY/qg/XHfQ6Yp3SD/Iopnckn
r/thVv5KcwQWhP4DhWynsopTV7I2rw5oob3LTEXGweVN4alXORBxp36J0e/kckgQ
J+tYyqV15vswbo60T1TyHsxaeYVh3YgZ9JPqhpqn5qiGTNyyaxP6nWJEt/f04K4P
4oX3qoHONyJd7eYeLbdyq11EPNECP6Fq+1UEpDvc10iTFiROSK69MW6l1ZmmEUyX
Ig4KGQH/7wXa6+09Xad9D7DHyCdKioyAYvBdDCW29ZglsgbNVO8LSvRg2FWRDJY+
Lkwfz4mLr+Kc4tS6HdSs1LiKeF5boNb/QuUt/3cjWBJlwF8b+dJ8usGd/VlsxmpA
zSQFdxfTph0V5rQ3DHtSMv9CKPx+D1oEfjY+k3Tl0u6rcJavaxn52kAjR2KrpVP7
sx0cDXmygpntn9+rk8PHJDwo6aMJH03vB2Uy6yPUVJuTlbK2xpQ6LfJEcbARsu08
r2HJlTK7JQkcWGsNMoIvKcmhX9eQXNX2+BuOUrS+UnLAIeoVEK3Wq6pFjrSoBqrb
47p3MEunzo5L8Zf/gYdBPqXYa3evIBAlRyMGXw9xhfbO3hzZJ8U=
=1imU
-----END PGP SIGNATURE-----

--Signature=_Mon__25_Nov_2024_19_54_43_+0100_ms7K9=h3DEstPnbE--

