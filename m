Return-Path: <linux-rdma+bounces-6107-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE3B9D9250
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2024 08:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB0C1B24769
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2024 07:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC79194AF3;
	Tue, 26 Nov 2024 07:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b="s9PJacUo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12B11898FC;
	Tue, 26 Nov 2024 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732605522; cv=none; b=M8kecIsLuaigTr+u7CXfFfVY3+J2PvjzQ4PArMlXr/2YRR9kyn/V4PRzVUqhi6SAWmLECZ8NSHZ2mUI2tRGUQ+sg6GERQxfUepA7PPK9B0OASgttSRinUeIHirMGfQtXPBx9at92zp0mY/PNsE76UStY73L+Z1Sf1pH2IPSgHOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732605522; c=relaxed/simple;
	bh=3WG+rsDl8ssfKYzOttBsssvHgdqZSvcUE4T0kx9jmG8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hNLSGkyA/NMIEsriHqRM/61SO90TEuZ8Ehb6UmaJVPzbjOAMJCDb/3ZP08UbNR9NFpEVBhu2zIz7PbzyadOqY40FKNHIBOLGTDS+7XCcTGn7gF18wJDqhpcmF4jALiOqfKtPa366ODiNqfip7Uue4uJ3aJ4cG5F7iNIwxBctsl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org; spf=pass smtp.mailfrom=paranoici.org; dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b=s9PJacUo; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paranoici.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paranoici.org;
	s=stigmate; t=1732605514;
	bh=C5ms5roH9t6g5LU0Y7op/suniBU+rWLbq1V6yV3ku2k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s9PJacUoPpikDhzNuIv5tVm15U0dfq9TCjUELSzG8f91NPGfQTK17u0QuWojqzv8p
	 wUy0jCazqgNirKkYbJtfgxjZA9Cj452a+2VzY6c11MpezlvmoTmnURq8YI0FPC0Ksm
	 vpKI+fj/DEAP69zTQHiavVhA873Pus1DBDw/y9+8=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4XyDSp35mzz6vVZ;
	Tue, 26 Nov 2024 07:18:34 +0000 (UTC)
Received: from [198.167.222.108] (mx2.investici.org [198.167.222.108]) (Authenticated sender: invernomuto@paranoici.org) by localhost (Postfix) with ESMTPSA id 4XyDSp2nwKz6vTY;
	Tue, 26 Nov 2024 07:18:34 +0000 (UTC)
Received: from frx by crunch with local (Exim 4.98)
	(envelope-from <invernomuto@paranoici.org>)
	id 1tFpqC-000000001vc-48NX;
	Tue, 26 Nov 2024 08:18:32 +0100
Date: Tue, 26 Nov 2024 08:18:24 +0100
From: Francesco Poli <invernomuto@paranoici.org>
To: Mark Zhang <markzhang@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?=
 =?UTF-8?B?Zw==?= <ukleinek@debian.org>, 1086520@bugs.debian.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Bug#1086520: linux-image-6.11.2-amd64: makes opensm fail to
 start
Message-Id: <20241126081824.afd7197d3a54c5242c4bb4b5@paranoici.org>
In-Reply-To: <cd4ea02f-bcb8-4494-a26e-81cdf6c684bf@nvidia.com>
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
	<cd4ea02f-bcb8-4494-a26e-81cdf6c684bf@nvidia.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA512";
 boundary="Signature=_Tue__26_Nov_2024_08_18_24_+0100_milZIYpp=r8ZwzMM"

--Signature=_Tue__26_Nov_2024_08_18_24_+0100_milZIYpp=r8ZwzMM
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 26 Nov 2024 09:21:37 +0800 Mark Zhang wrote:

[...]
> Yes looks like FW reports vport.num_plane > 0. What is your hw type and=20
> FW version ("ethtool -i <netdev_of_the_ibdev>")? I don't think it=20
> supports multiplane.

  $ /sbin/ethtool -i ibp129s0f0
  driver: mlx5_core[ib_ipoib]
  version: 6.10.11-amd64
  firmware-version: 20.40.1000 (MT_0000000224)
  expansion-rom-version:=20
  bus-info: 0000:81:00.0
  supports-statistics: yes
  supports-test: yes
  supports-eeprom-access: no
  supports-register-dump: no
  supports-priv-flags: yes

Please note that I determined <netdev_of_the_ibdev> by looking at
the output of 'ibv_devices': I hope this is a correct way to answer
your question.




--=20
 http://www.inventati.org/frx/
 There's not a second to spare! To the laboratory!
..................................................... Francesco Poli .
 GnuPG key fpr =3D=3D CA01 1147 9CD2 EFDF FB82  3925 3E1C 27E1 1F69 BFFE

--Signature=_Tue__26_Nov_2024_08_18_24_+0100_milZIYpp=r8ZwzMM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEygERR5zS79/7gjklPhwn4R9pv/4FAmdFdkEACgkQPhwn4R9p
v/42txAAlpTMgd77CdbAemqg2q22E7oNHCa9AUjWDzcHFN9yMNVbyGf1hntpyjYp
e6iMRLNGywypVygonJZQXa/oCQBiCf6QQpZ39F061LhhzamcbVL/zlsEnV7h6c1H
U36i9O18ws8pFUrN3E/2fAAWfDlujHS1iQkECLW24yzYTfNLRriLKApRvZjzyVrR
PaiDbbVKDFMZ9LuaOkWr+fQg51l22ds+mUGvtBEBAKxz/aFFhM6b5BOAu6Gj4qEn
qnKhl1I/lTB9843JqR5DVwz/kWnG5KoAK2DICXgz/QpyygEGxQ3aGyvn/yyiK/G7
tbWE7rW+rGvg9L8q1e5n6ncmvSQW41nZLYEuBcZZ1SBa0wP7d1jPuedwFVkNhOkk
SI4VriRig04i/zk0O3YamwPpw992eIeZyinsvw2xOwoc5B2KNPCnHRaeTO4F7EJl
fDE5VkelZVCuMr8/hBzLw4XfzlnNoHY3BmMbNJslmCvFBX0k+adqF6No5e3JPllO
cJyFNjjC9WD/y4Y8pV5KymvWS3gQiw36y3iq9q0tR80dzah/PShbiHZUHCpPElBW
TGiSuPAx8t7lp4ci+HnZ0DfHdWEg1qo/apaWkTV3KlYMVZmNxyYTW3R8R98lhe+u
ILofzAsyTWJS0CKjPiIHzOcUPesS+vc1k7vtFkyclhPNoNs40gk=
=PMEd
-----END PGP SIGNATURE-----

--Signature=_Tue__26_Nov_2024_08_18_24_+0100_milZIYpp=r8ZwzMM--

