Return-Path: <linux-rdma+bounces-3117-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7823E906843
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 11:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37C81F212CB
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 09:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D0113D8B2;
	Thu, 13 Jun 2024 09:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="S1+K8c0x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB4F3209
	for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2024 09:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718270046; cv=none; b=GWrNXpmma8ayr/cha05J9RuOsWZt70puBz+YdI8P3EbceDFZNnLMaGEH4paFpS81xuxk20UNkcy+Sa9tRFyyiEi7VYDzUzJ3F4OUxYyQ1/QNmg2bDpLpv2Qbh24WxErS39eVaIK6Pc1outf+4mRarvcRtc5+lihtFXLHhuhu+jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718270046; c=relaxed/simple;
	bh=+L31CUPtDzLW+4iy17ZcIRsQ7MERUkoM6CkzxLFnoBY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uaO8uw9LvqypDv+unRxjj9xIA6ARIbrrrQspnl+x438Y1gAbQJOd94v3q8iSQpfHY4LhUNtCLk4qRzKO2HOq4XB46uAo3P05KsOlP/Qoi+xq55l+kyHZAO7Lv8q3D4jj7dBVQmCjGsvvNP5LtTRtZJzlSG2CSBRyY9TqaVReRN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=S1+K8c0x; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zD+fd5rJm/Ms1nTDUvIgdyLd8SBHOR0IPgCjJui0vsw=; b=S1+K8c0xRIMVIsMpJkLRy7HKMD
	zZQEWEWrewzSeGb7BG0DB2Y5GmGYQ83P2To+VjqZzYdI6UrmTJSUrfWCN6xaisOCnqLwQsmrgc4C2
	Z99PX8pwPgJGOVsT2VMtfTZrr7d0FhMqxWCF4f0zv/yVazHbS36yiBjm/ZyKvnDcisgsnW3HRiCKs
	Rng/FH5nfom6tHVIhAfjHkEkHnaUU+ksmBMEJzE7YzGCOcsQc3IqeaCkIZK6qfTaBMv/cV00UrmbN
	fxZdkbrKlDokuUoHrqpFAGv/TWuibuT0M3lxEGYgWPldb+ENzSkFUhpzxlmVOA80TIiWdTJ8pYzp/
	cFdAnHRQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <peb@debian.org>)
	id 1sHgWv-008ZFX-Mu; Thu, 13 Jun 2024 09:14:01 +0000
From: =?utf-8?Q?Pierre-Elliott_B=C3=A9cue?= <peb@debian.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org
Subject: Re: What's the current status with bnxt_re-abi.h
In-Reply-To: <CA+sbYW3YQW0jMBRv4hrQQ48JkLNEHuA_dhgTTqfd+zqGxx20kg@mail.gmail.com>
	(Selvin Xavier's message of "Thu, 13 Jun 2024 14:19:00 +0530")
References: <87jziucdlj.fsf@daath.pimeys.fr> <87frticdf8.fsf@daath.pimeys.fr>
	<CA+sbYW1bONzFsrKAD+NLbBEuSDvqdZ+mPT1srwXrp67go6GRaQ@mail.gmail.com>
	<a4281961-3b17-4cbd-9a6f-1d0ddcd26be8@debian.org>
	<CA+sbYW3YQW0jMBRv4hrQQ48JkLNEHuA_dhgTTqfd+zqGxx20kg@mail.gmail.com>
Date: Thu, 13 Jun 2024 11:13:54 +0200
Message-ID: <87bk45b3xp.fsf@daath.pimeys.fr>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Selvin Xavier <selvin.xavier@broadcom.com> wrote on 13/06/2024 at 10:49:00+=
0200:

> On Wed, Jun 12, 2024 at 11:59=E2=80=AFPM Pierre-Elliott B=C3=A9cue <peb@d=
ebian.org> wrote:
>
>  De : Selvin Xavier <selvin.xavier@broadcom.com>
>  =C3=80 : Pierre-Elliott B=C3=A9cue <peb@debian.org>
>  Cc : linux-rdma@vger.kernel.org
>  Date : 12 juin 2024 19:18:34
>  Objet : Re: What's the current status with bnxt_re-abi.h
>
>  > Hi,
>  > bnxt_re-abi.h in linux kernel and rdma-core uses abi version 1. We
>  > dont bump up the version in upstream and backward compatibility is
>  > maintained using the comp_mask field of the interface structures.
>  >=20
>  > If you are using the latest drivers maintained in the Broadcom site
>  > (which uses ABI version 6), you need to use the libbnxt_re hosted in
>  > the Broacom site itself. We maintain compatibility between the Out of
>  > tree driver and Out of tree library.
>  >=20
>  > Thanks,
>  > Selvin
>  >=20
>  > On Wed, Jun 12, 2024 at 10:21=E2=80=AFPM Pierre-Elliott B=C3=A9cue <pe=
b@debian.org> wrote:
>  >>=20
>  >> Pierre-Elliott B=C3=A9cue <peb@debian.org> wrote on 12/06/2024 at 18:=
47:36+0200:
>  >>=20
>  >>> Hello,
>  >>>=20
>  >>> In bnxt_re-abi.h, the abi version mentioned is 1. It's used as it's =
in
>  >>> all libibverbs to determine the min AND max supported ABI.
>  >>>=20
>  >>> bnxt_re isn't currently mainlined in the kernel,
>  >>=20
>  >> Sorry, a word is missing: "Recent bnxt_re isn't currently mainlined"
>  >>=20
>  >>> and those eager to use
>  >>> the driver need to rely on the one provided by broadcom on their
>  >>> website.
>  >>>=20
>  >>> The thing is, they bumped their ABI version multiple times (current =
is
>  >>> 6). In the current context, one can't use the manually compiled bnxt=
_re
>  >>> driver with libibverbs as any call will error due to the bnxt_re abi
>  >>> version being outside of min/max supported abi version.
>  >>>=20
>  >>> What's the current situation regarding bnxt_re, should we consider
>  >>> libibverb support of bnxt_re as deprecated?
>  >>>=20
>  >>> Of course I could have missed something, sorry for that if that's the
>  >>> case.
>  >>>=20
>  >>> Bests,
>  Hey Selvin,
>
>  Thanks a lot for clarifying this.
>
>  I built libbnxt_re, but the thing is, I can't use the usual infiniband t=
ooling (ib_write_bw) et al without using libibverbs which is still the
>  linux-rdma one.
>
>  Do you have an alternative to suggest that I should consider?
>
> It should work fine with the libibverbs installed by
> linux-rdma-core.

Due to the ABI version being 1 in rdma-core, no. libibverbs verifies
that the current driver ABI version (6 for bnxt_re from broadcom's
website) is between ops->match_min_abi_version and
ops->match_max_abi_version, both values for bnxt_re are set to the ABI
version (1).

https://github.com/linux-rdma/rdma-core/blob/master/libibverbs/init.c#L363-=
L372

So when trying to use tooling from rdma-core (like ib_write_bw), the
match_device function returns false and the card can't be used.

> The Broadcom support team can help you with the
> necessary instructions. I will forward your mail to them and they will
> help.

I already interacted with the support team, and I'm not confident they
can help. But thanks. :)

>  Also, would a RDMA+SRIOV-capable broadcom card with the latest firmware =
(229 something) work fine with the drivers shipped in
>  rdma-core.
>
>  If so maybe I should use what's provided by the kernel and rdma-core.
>
> The drivers shipped with rdma-core and kernel should work for most of
> your use cases. I suggest you try this.

Ack, I'll try and compare perfs. Thanks!
=2D-=20
PEB

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE5CQeth7uIW7ehIz87iFbn7jEWwsFAmZquFMPHHBlYkBkZWJp
YW4ub3JnAAoJEO4hW5+4xFsL0ycP/0q+lpztMLMGKsi7+2Pe0/5JStJ1PnbxV4h5
cQYcHkYdDJ//tPFeVRhwUjiyUK7iR5ukFEVc71tM0LsTBkI1t2cvBsYQc0Prak+V
EfLlyS8hiwD9pLHvlsMEkBpoiJBV/CycXYafiT/s9HD3fLCIxpNsp6Fhp+RrMZuW
8HRovB7UBJO4XTawIlrud1awc0P8kbBJgHJSTZQac3L1EhSRt8v8SpUfF0hU+pkG
M2SH9LEHXV7GzXJdOETmvmwZe4yhbCivIatsBz97fSiopwwS2YQf/67nkTLGfu2S
AYgWj/VpSZlEkZWrrv/nbC19GpYbbv1k6sfYe0UvSbW+T5oKPSCbIPZM1j4WW72R
vbyoIp11u8CUl6F3DgvT9GkJLfnUtO6dT8nkmHmJDnj48vJI1SzYFr08nGEQu2my
7kH5OlV4qopmqNiH6ynwLRxilllazVZXnevh/knNhcfIosGHgun6ryxTy4c913pG
mvD6ML4WWMIPjRBtvcaYp9Bu7bHMG5tMfXSzbvCL507+OmY6/6U7zhOt1hTBuTuv
icbnJdgWd3JTWiJV7nNfNZ6jbXJgSddi8RU165ZlGbunCYZGIYKl5Wx9GvTiY/HO
v5XDPqZNSv+1i7UVSMETqFjQhjpzhOQVg7PAI2RAKwEEwbGwlyU8e6nNc39G6FiN
KkOAtRCG
=Qn3j
-----END PGP SIGNATURE-----
--=-=-=--

