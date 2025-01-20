Return-Path: <linux-rdma+bounces-7119-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54029A17298
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jan 2025 19:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E6873A5C59
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jan 2025 18:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CED51EE03B;
	Mon, 20 Jan 2025 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMmDHcC7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264AD1E3DFC;
	Mon, 20 Jan 2025 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737396890; cv=none; b=VNBAzuMWW9X4OG2SMTpgl8MGNjiQXyEuRMUQZWtEbqTc9zPWf/NQwwfqbn1hkDRUTTkhsGuqog/mkxttqQJvRsY5lVCupVNrvl8jUMia3tHiaj1aEA7gheH2qwK0QGdt1esdgB42YBXfSIDGTlLsa0HNOcjpsnYCyOf82R5LxjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737396890; c=relaxed/simple;
	bh=mJa6dRqKfkUDaAJ6rtP7VypU1mRHddFGfCARmjYgz6c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fos0HnkqWmzoM2KVrEtprQfruhcP5sQtZBaJ2mJVk47wEgLXfjZi3g604AfcTUru1yxRLFphm1SkWoUO6QExomL0g2ljFvcPE0TIQoKcbCneg2cqXYSgAVpYQjhBKdWKGT/R/N6aG677IanZ97LpFWaU70ZTYvMik7UpthXEel0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMmDHcC7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D43C4CEDD;
	Mon, 20 Jan 2025 18:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737396889;
	bh=mJa6dRqKfkUDaAJ6rtP7VypU1mRHddFGfCARmjYgz6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gMmDHcC7fwGDHqTCPSIo7xLZ9gYV5ReyHxFbXN0t1888Nfnf0Mv7Ovf0tTUeIF7wY
	 GdWR+Z7UY80Yk2wqAlNL10sFN2ZHQ+mb7vCR8YPPj+Zc33QLAgJmGHP6Qkqt3veeKY
	 SZHrel+rWyUyTXqs4Nbfm7bvS94Dv6QL1eE1EVMHepBmL4y/0L09fX3x/fJ+/Ujb8G
	 WRDfQDzPP4HKQzWpxcgcR2eIkIZKWyapm7S13bGwTbAamSdYthCjLhmvTtyXffdlJQ
	 GP+WTabWqwc9NoyGrG3EfpmvLIHQMg9ZjPmuKiumtHE8lP3ghxHuvvryqBsdtjRNrx
	 8iFwJX1LynKoA==
Date: Mon, 20 Jan 2025 10:14:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, Tariq Toukan
 <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>,
 netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, linux-rdma@vger.kernel.org, Cosmin Ratiu
 <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V5 07/11] devlink: Extend devlink rate API with
 traffic classes bandwidth management
Message-ID: <20250120101447.1711b641@kernel.org>
In-Reply-To: <1e886aaf-e1eb-4f1a-b7ef-f63b350a3320@nvidia.com>
References: <20241204220931.254964-1-tariqt@nvidia.com>
	<20241204220931.254964-8-tariqt@nvidia.com>
	<20241206181056.3d323c0e@kernel.org>
	<89652b98-65a8-4a97-a2e2-6c36acf7c663@gmail.com>
	<20241209132734.2039dead@kernel.org>
	<1e886aaf-e1eb-4f1a-b7ef-f63b350a3320@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Jan 2025 13:55:58 +0200 Carolina Jubran wrote:
> On 09/12/2024 23:27, Jakub Kicinski wrote:
> > On Mon, 9 Dec 2024 23:03:04 +0200 Tariq Toukan wrote: =20
> >> If we enforce by policy we need to use the constant 7, not the macro
> >> IEEE_8021QAZ_MAX_TCS-1.
> >> I'll keep it. =20
> >=20
> > The spec should support using "foreign constants"
> > Off the top of my head - you can define the ieee-8021qaz-max-tcs contant
> > as if you were defining a devlink constant, then add a header:
> > attribute. This will tell C codegen to include that header instead of
> > generating the definition.
> >  =20
>=20
> Hi Jakub,
>=20
> I tried implementing this as you suggested, but it seems that the only=20
> supported definition types are ['const', 'enum', 'flags', 'struct'],=20
> while the max value in checks only accepts patterns matching=20
> ^[su](8|16|32|64)-(min|max)$.
>=20
>  From what I see, it doesn=E2=80=99t currently support using a const valu=
e for=20
> the max or min checks. Let me know if I=E2=80=99m missing something or if=
=20
> there=E2=80=99s an alternative way to achieve this.

Ah, I thought we already implemented this, sorry.
Can you try the two patches from the top of this branch?

https://github.com/kuba-moo/linux/tree/ynl-limits

