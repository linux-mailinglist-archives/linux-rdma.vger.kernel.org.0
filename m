Return-Path: <linux-rdma+bounces-3077-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7916A905927
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2024 18:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8079282BD7
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2024 16:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A1F1822C9;
	Wed, 12 Jun 2024 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="BEh7yi99"
X-Original-To: linux-rdma@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25374181CEE
	for <linux-rdma@vger.kernel.org>; Wed, 12 Jun 2024 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718211095; cv=none; b=LySMZLvk3zaoP237EmPTxkDEXf8UxU6W3zOcSiRbQ+XyM+0BcFSTYL/5oR7xcfXK0ctjol2scQAqKu86Usd6ILFiG51cmwu3Z/bUynBB27Ml1ojcmOwfpEN0fzJeKK526xlftMusdwsaoJbF6mYySkyp5pXQzPpfyTj0LMjpHHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718211095; c=relaxed/simple;
	bh=1aYudvM8cCvp16WoKBbeZwXpUAyDEDsHgfRhHSITuDk=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NGcSE3/VbDHCzx7yHwwlvJMqvafpzrAi2cYvaJrRwDWmWz21E4hLtW+bOyb88PxxKWXYz1BcFiiN/SAEfjl7vKmrFFXTonlEbDvBXAknocUQzCF+Q0HhMwFvac8ogbfUQOfw4uH5UvfTXw/150Opof2LGYq2ycAKrA3VAy/y6gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=BEh7yi99; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:To:From:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1aYudvM8cCvp16WoKBbeZwXpUAyDEDsHgfRhHSITuDk=; b=BEh7yi99eDsMYj+BH9uEhuskk7
	hbhzyyBTMxD6VNMqaHKm0y/bs1XgAFBYG1z3ohl0U9pKuG2Dvgr3PE3IMMzeyaHUKn+PxNi/sAt7j
	WMzWu1dN+N+bu680hSO6KxSAmOqLc89T3+ViBIo28vu7vEkKwHBUMt3FEhiYcgjQY9MW8D1BZtFYC
	QDFYhye2aQohgeTDE8bvXAVzwHSud+ohXU+/59v6xPlB+raysBBdM0VPusjzZx8A+pmT6sFbBzVDN
	zr7OmKo1HSejDlt48LLMZkG2V+VQ01w9PE0exfORXtT5sZswfQUkTyW03KDIdy1BH/G9sToCJ69hR
	yTDMSp/A==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <peb@debian.org>)
	id 1sHRC7-007yN5-CA
	for linux-rdma@vger.kernel.org; Wed, 12 Jun 2024 16:51:31 +0000
From: =?utf-8?Q?Pierre-Elliott_B=C3=A9cue?= <peb@debian.org>
To: linux-rdma@vger.kernel.org
Subject: Re: What's the current status with bnxt_re-abi.h
In-Reply-To: <87jziucdlj.fsf@daath.pimeys.fr> ("Pierre-Elliott =?utf-8?Q?B?=
 =?utf-8?Q?=C3=A9cue=22's?=
	message of "Wed, 12 Jun 2024 18:47:36 +0200")
References: <87jziucdlj.fsf@daath.pimeys.fr>
Date: Wed, 12 Jun 2024 18:51:23 +0200
Message-ID: <87frticdf8.fsf@daath.pimeys.fr>
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

Pierre-Elliott B=C3=A9cue <peb@debian.org> wrote on 12/06/2024 at 18:47:36+=
0200:

> Hello,
>
> In bnxt_re-abi.h, the abi version mentioned is 1. It's used as it's in
> all libibverbs to determine the min AND max supported ABI.
>
> bnxt_re isn't currently mainlined in the kernel,

Sorry, a word is missing: "Recent bnxt_re isn't currently mainlined"

> and those eager to use
> the driver need to rely on the one provided by broadcom on their
> website.
>
> The thing is, they bumped their ABI version multiple times (current is
> 6). In the current context, one can't use the manually compiled bnxt_re
> driver with libibverbs as any call will error due to the bnxt_re abi
> version being outside of min/max supported abi version.
>
> What's the current situation regarding bnxt_re, should we consider
> libibverb support of bnxt_re as deprecated?
>
> Of course I could have missed something, sorry for that if that's the
> case.
>
> Bests,

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE5CQeth7uIW7ehIz87iFbn7jEWwsFAmZp0gwPHHBlYkBkZWJp
YW4ub3JnAAoJEO4hW5+4xFsLlfsQAIJAQoyIfYA74lRhoHwiyoimuxulkbXDZGUK
GCanboRTjkoSFDtTbHBYlvsmeMsbdW3wOu94o3irAnlvzgIj+cq1U7KnrE/d0Lev
B92dINUfagKHblOylz6ntBSsHrK7bZUhvLaPgVE+w3WbV17flbwxvlNNrw1tjJZL
Hk6H23KXfcwazQ4tblCEbeBPFKl41VIbdjqBscVCZJ6dF9At+4nWMG3WKOdu3qMM
7sb6xODaCCAvjWTd9rtFgfbG3xR+fZZCQu5zS/Ks4zSokvCAPpi57Ay6fkQbLHpE
MLwJOjFpiA/Osqf4eBnbc/NUBZ8HPb8LaNBART7bMBldDlphrwRZT0cuHCGO6cdF
lhlnq5vwf936kOWGeJ9FY66LVWUhI57O6bMgMeDlfZrmqK0sUpPC4pvwrksj59AQ
+Q9hlhzEMC8JAjdmHuJNk7q9n5KWaE4phY57DcnNR3GclO4IhhA/I5nBAXUk2eYP
pe9npTrLeRNqnFhszNonk/AOfVCe9eq+OsyEmmJW5lpVShWgYR0Jweg7HRV0DKgi
H/tkCuggMfxnSWIbAxWlLiUK99lFTfdXx053FjFL28Gl8EP9pNH1ymmJNga7kZNb
BLf9FdL3Bz4VvOAyk4PBcqtP6Ug7M6eDxlvKig9dCi6qfvd5CEaAqSLPFAtUk4Xs
zcsmqQ5w
=18ad
-----END PGP SIGNATURE-----
--=-=-=--

