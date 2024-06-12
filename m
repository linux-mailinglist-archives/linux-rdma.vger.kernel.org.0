Return-Path: <linux-rdma+bounces-3078-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F02490599D
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2024 19:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21441F23959
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2024 17:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F756183098;
	Wed, 12 Jun 2024 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="uVDMFXK+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78248181BAA
	for <linux-rdma@vger.kernel.org>; Wed, 12 Jun 2024 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718212068; cv=none; b=gAkrz7hSSzGkgNS5cIW4rPkqtY99SoGZ/MQJJAewkecB/KmltHWlz1NbnfOZws5UAfcQfp1yEgLC1Rg/80GfI03PK2qPZ3adcnB2dKF4kJttd1Ft4P1z34zK++GlLdKk0V9ldpE6iITq5Zd2GF4EIMqYJi7e7mBu2f2KtRUkRFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718212068; c=relaxed/simple;
	bh=2ketfuSWqORe0WkSjOLYV/exnF2NBm63ivzZrHckAKA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oM59zQple7xsW+CS8kRSzJdlgV7Pp5f+zzdL9V+5mpNfcFugRuxfhHsWSjYbKEnx3/1R8QWOXHlD51uEm/ThU6Lr3CHhkA2adICWDlzda4q6+UnJnUd4lqODOwieGX75hoXLU4a1NZ2ZuKR5ilBlUpPVQAmintBL0cZrkmpCbo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=uVDMFXK+; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
	Date:Subject:To:From:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=2ketfuSWqORe0WkSjOLYV/exnF2NBm63ivzZrHckAKA=; b=uVDMFXK+IiC0ryxlDyZr0jV8Pa
	CoJcCR1i0AKFqWXBlrLSoSWQczdQ4TTXAf8N+LjXYgdDIltbrPR2L9WoNTwLjCw3it7CaLRVm8KAf
	ChhS+3l+cFUs3loxyXDhOymNtpCMeC7WcXFf2oIC/riVKVmsklgRULkC3DkNv92qLc2eDdQirDqKP
	AYSVpZWkg7qn82ci3muHsoxY01dM2h1Zkab+LDHT5IHnnHYz8ZZIebreGv9eIJTnJfQf/eCuHPG6X
	8bdEUswbmvV3JLDND2qtevGvb1Df64fBryc4M1QNIPiDpIVdKEmFxNLWf0c7JVQiwSItCiyVvHg7V
	ktD/upbA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <peb@debian.org>)
	id 1sHR8S-007yDT-FE
	for linux-rdma@vger.kernel.org; Wed, 12 Jun 2024 16:47:44 +0000
From: =?utf-8?Q?Pierre-Elliott_B=C3=A9cue?= <peb@debian.org>
To: linux-rdma@vger.kernel.org
Subject: What's the current status with bnxt_re-abi.h
Date: Wed, 12 Jun 2024 18:47:36 +0200
Message-ID: <87jziucdlj.fsf@daath.pimeys.fr>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Debian-User: peb

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello,

In bnxt_re-abi.h, the abi version mentioned is 1. It's used as it's in
all libibverbs to determine the min AND max supported ABI.

bnxt_re isn't currently mainlined in the kernel, and those eager to use
the driver need to rely on the one provided by broadcom on their
website.

The thing is, they bumped their ABI version multiple times (current is
6). In the current context, one can't use the manually compiled bnxt_re
driver with libibverbs as any call will error due to the bnxt_re abi
version being outside of min/max supported abi version.

What's the current situation regarding bnxt_re, should we consider
libibverb support of bnxt_re as deprecated?

Of course I could have missed something, sorry for that if that's the
case.

Bests,
=2D-=20
PEB

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE5CQeth7uIW7ehIz87iFbn7jEWwsFAmZp0SgPHHBlYkBkZWJp
YW4ub3JnAAoJEO4hW5+4xFsL0aYP/0H7Mp7hBV9vnKiy2H3G2sZ+JDF5Axh8wu/e
NaQGntZqnt1TCyVzSO/owpU6LUcZwWkMVoLbJ+5ZJP8qi8+1xxa9MoKdMeZHy0j8
eJwPc+ozuVrlYwvd5shnaiKz36M0iG10NjycAsx/uBJY4iSKsrXQmP6OljRewgSi
W1XPeyUyXW81RJN4lO4IxJGtuVqYGRdRDfSDE66C/u4aVP5YcctdlSW776Xf+8NN
OtOeTAScD9Xh/glUSvZ0wU7nzf1vAE5FUlXzgut57vhD1jYz19zcuY9jE5B9aki5
ga3ZwnYLoQTkmX6inudQIZcULe1RHKGcF7tMrhcxysK6ug+aPSGd67QvFGnFkwjr
VPZ8/bUbiByce3F6d/PJrul1kWl0to/Yr+r29b9UvOY2CWLcSWItqxDKuwqrrN4U
LuN4coORPTQoRWgZp0EyDhpufUkuDURdM0fSYlI7FW1G+GWtzNAsZq/FoVDlVRHk
FmR1xKly9kWzQ/7YUuOsh2gxVTBQs39CZw75IlwsytqgBTXRXk5S3CQ4SKMagCaZ
sDFt7jcm3BkJdvwWd1AoLOTU7Vkyr4auwFFCAI/dxG4h85htm1bkN+w+dCfpS/MO
uNGYvGPWO68wG1II13ck6knYD3WOFXBPwm350/2kqF43yExdhMzBUYbbhHDLKPNV
jlWQUqO/
=D5qW
-----END PGP SIGNATURE-----
--=-=-=--

