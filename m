Return-Path: <linux-rdma+bounces-6240-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEED19E42A7
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 18:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC802850EF
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 17:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5B12165FE;
	Wed,  4 Dec 2024 17:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b="fJn7q2lb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7C6215F74;
	Wed,  4 Dec 2024 17:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332987; cv=none; b=R11gcHJ0mLKvUhNc2nt1iZ8Ghedm8triLNzcKl2oikJRU8dIBBRlhhIDdlVNf5jJsCpanssAx+fRu3boSzPR01LWGKn3IVXmwkGDyetYSaltW3jVxAkFBNbcdHHSRTGFGl6fOUZLCmKMEWMd8Bsji/qu+YLHHNrRPVI/cDXbaHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332987; c=relaxed/simple;
	bh=8HO3mm3jNM/ZIi+ulQAkDTTq+p4TEOdSZ5DMUDAq2Vg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NWS5tHJADo4oYKCLMvmJTmy8jgazd+ocE447RVL4NL0zWuYhs0Tw1TVA+x9Z9WoR3Td38DQcoucpBXUtyU0mKVTQlWoFs/AIbWm4xnL3ZV34d8EV67md+9pvn6TbDvjQiPxQSu8BO2ENWFK/VkgQYfFO+FSs02W6u/s/sexXQLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org; spf=pass smtp.mailfrom=paranoici.org; dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b=fJn7q2lb; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paranoici.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paranoici.org;
	s=stigmate; t=1733332478;
	bh=0QrBbFQ1Yk43wtEVuPMTkfoJbcLfYpa5h2xyKqF9TXQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fJn7q2lb6Sq30r4i7Hi1Idj/7Fj1J3PmPVtm/N7w9ggFeeYS6lWZ65FwuKrpRkF+K
	 OIQ10ChwvBTbmF0gZWZyxven9Hcs5bhfJqy2jjLlnXDWRUYrjK/srEWd7Yiohr1cdS
	 lJiDni5XC+IMba7+VMn3aNxn4Z6EyzxIvGN2+UQk=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4Y3PJt0MCvz6vVX;
	Wed,  4 Dec 2024 17:14:38 +0000 (UTC)
Received: from [198.167.222.108] (mx2.investici.org [198.167.222.108]) (Authenticated sender: invernomuto@paranoici.org) by localhost (Postfix) with ESMTPSA id 4Y3PJs70sJz6vVW;
	Wed,  4 Dec 2024 17:14:37 +0000 (UTC)
Received: from frx by crunch with local (Exim 4.98)
	(envelope-from <invernomuto@paranoici.org>)
	id 1tIsxQ-000000003X3-30eO;
	Wed, 04 Dec 2024 18:14:36 +0100
Date: Wed, 4 Dec 2024 18:13:56 +0100
From: Francesco Poli <invernomuto@paranoici.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@debian.org>
Cc: Leon Romanovsky <leonro@nvidia.com>, 1086520-done@bugs.debian.org, Mark
 Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: Bug#1086520: linux-image-6.11.2-amd64: makes opensm fail to
 start
Message-Id: <20241204181356.932c49619598e04d8ad412e0@paranoici.org>
In-Reply-To: <acpo6ocggcl66fjdllk5zrfs2vwiivpetd5ierdek5ruxvdbyl@tfbc3mfnp23o>
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
	<acpo6ocggcl66fjdllk5zrfs2vwiivpetd5ierdek5ruxvdbyl@tfbc3mfnp23o>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA512";
 boundary="Signature=_Wed__4_Dec_2024_18_13_56_+0100_OXoMkKkJzsj06Qbl"

--Signature=_Wed__4_Dec_2024_18_13_56_+0100_OXoMkKkJzsj06Qbl
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Dec 2024 17:37:05 +0100 Uwe Kleine-K=C3=B6nig wrote:

> Hello Francesco,

Hello Uwe,

[...]
> I wonder if you could test a firmware upgrade or the above patch. Would
> be nice to know if there are still some things to do for us (=3D Debian
> kernel team) here.

Yes, I've finally got around to upgrading the firmware.

And today I had a time window, where I could reboot the cluster head
node.
After the reboot, the InfiniBand network works correctly:

  $ uname -v
  #1 SMP PREEMPT_DYNAMIC Debian 6.11.10-1 (2024-11-23)
  $ ls -altrF /sys/class/infiniband_mad/
  total 0
  lrwxrwxrwx  1 root root    0 Dec  4 10:15 umad0 -> ../../devices/pci0000:=
80/0000:80:01.1/0000:81:00.0/infiniband_mad/umad0/
  lrwxrwxrwx  1 root root    0 Dec  4 10:15 umad1 -> ../../devices/pci0000:=
80/0000:80:01.1/0000:81:00.1/infiniband_mad/umad1/
  drwxr-xr-x  2 root root    0 Dec  4 10:17 ./
  drwxr-xr-x 73 root root    0 Dec  4 10:17 ../
  -r--r--r--  1 root root 4096 Dec  4 10:17 abi_version
  lrwxrwxrwx  1 root root    0 Dec  4 18:08 issm1 -> ../../devices/pci0000:=
80/0000:80:01.1/0000:81:00.1/infiniband_mad/issm1/
  lrwxrwxrwx  1 root root    0 Dec  4 18:08 issm0 -> ../../devices/pci0000:=
80/0000:80:01.1/0000:81:00.0/infiniband_mad/issm0/
  # ethtool -i ibp129s0f0
  driver: mlx5_core[ib_ipoib]
  version: 6.11.10-amd64
  firmware-version: 20.43.1014 (MT_0000000224)
  expansion-rom-version:
  bus-info: 0000:81:00.0
  supports-statistics: yes
  supports-test: yes
  supports-eeprom-access: no
  supports-register-dump: no
  supports-priv-flags: yes
  # ethtool -i ibp129s0f1
  driver: mlx5_core[ib_ipoib]
  version: 6.11.10-amd64
  firmware-version: 20.43.1014 (MT_0000000224)
  expansion-rom-version:
  bus-info: 0000:81:00.1
  supports-statistics: yes
  supports-test: yes
  supports-eeprom-access: no
  supports-register-dump: no
  supports-priv-flags: yes
  $ ps aux | grep opens[m]
  root        1150  0.0  0.0 1560776 3636 ?        Ssl  10:15   0:00 /usr/s=
bin/opensm --guid 0x9c63c00300033240 --log_file /var/log/opensm.0x9c63c0030=
0033240.log


>=20
> If everything is fine for you, I'd like to close this bug.

I am closing the Debian bug report right now.
Thanks to everyone who has been involved for the great and kind help!

>=20
> Best regards

Have a nice evening.   :-)

--=20
 http://www.inventati.org/frx/
 There's not a second to spare! To the laboratory!
..................................................... Francesco Poli .
 GnuPG key fpr =3D=3D CA01 1147 9CD2 EFDF FB82  3925 3E1C 27E1 1F69 BFFE

--Signature=_Wed__4_Dec_2024_18_13_56_+0100_OXoMkKkJzsj06Qbl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEygERR5zS79/7gjklPhwn4R9pv/4FAmdQjdQACgkQPhwn4R9p
v/6AoA//TkOwnWjH5D4ks5SUi1DDiHU1IFfS/ix9o3TA2oWmP9/tQzIWV/ACfbbK
5QBHtVb6lFSte9kIxSgc/mXP06PicFpsxOjByJ4Kwq8dlz9ksQqC/biF0h0PmKZt
hRFVC0F69vDgUeUhREOQn6a3KscUv6pl9bEkUBmMjcXmdLkgPaFkMWt4jlopXhig
w2U7vKhLFo+caw1WM3e4OJpF6iPXF4G6lyEOvXIo7zKohVwChVjH5rwUuIXmd0Q2
ltvu8ZGcx0+wor5zoUORt1hYLXjOZ4jtJLAEgrvZNoa6eUGw1NPaNInwyjDo2hFS
EidbgtJY3UFa3mytTbkQO4alfagC52CfjmxJfNC3dGqyBDHS5j2uXPB0V5NWbDWq
lX7k1DcfBS9rJgNs+kBL5/aoU1KHWSCqdUbniomv3iba5thfmWpHF+mki5cJr/6+
VIkARDEnLuk86nVm8dOVwm/jFLyerDXP6XzAdUjw4xPeBzib+dPlaD29r39YrvMf
aRqSe8azvg7t+XFGpmfbXTnGgCUgv/YIACUtrs/ffif8ffTl9FC+8xMsgCH638J3
nP7Sd1yVPzynZHshH1lGv+k7VSAZqGq2550hdAvmXs4pUPt/ow/3A2tBdNo8j00U
GbZtEnbMp/i1nOZB/NOaTdmyT0Y5VEqqPmdkfL1KKASTSVK59Zw=
=aoBA
-----END PGP SIGNATURE-----

--Signature=_Wed__4_Dec_2024_18_13_56_+0100_OXoMkKkJzsj06Qbl--

