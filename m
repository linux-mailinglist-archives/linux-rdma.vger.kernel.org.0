Return-Path: <linux-rdma+bounces-4944-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6E2978CD6
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Sep 2024 04:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BCF51C22A8A
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Sep 2024 02:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D68A11187;
	Sat, 14 Sep 2024 02:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8ceM4LN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B30D528;
	Sat, 14 Sep 2024 02:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726282091; cv=none; b=Rt6mqNqT8GYNoLAYYLcIm4zcdJBU6FvKoDTlTL/gK/hD0wsaR+ZWl9nGRUOBSnXv95kAl/yjtt85pHNDLE1uGVkL9mg7etFFHHHk3P3JryC+B0BI2sIOiN6uVpeI689fDbb2djrvh3C8JiBS0Iv1XsPm3oMUEMTXuaLaDbmt9Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726282091; c=relaxed/simple;
	bh=psOnc9lX8p2RZFbBh6tZB4DPvTDWI4x0mWJHIOlZTcM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PAzvwNLwGiadW9sVHOXNOBiUOuX9qVtdr7acgipPeAvFjUmfp/oyKjwWWlCYdxvvBjdEkmHUMq52BV8wX5xf1dbxMo5WScvAZqJUm5TH379lEP0Tq8RXDTojdVt5LRrBDYW8qoQU0Xm1V2Aqobxlzp2E4aVorNDvc245nXjhpC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8ceM4LN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22943C4CEC0;
	Sat, 14 Sep 2024 02:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726282090;
	bh=psOnc9lX8p2RZFbBh6tZB4DPvTDWI4x0mWJHIOlZTcM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a8ceM4LNLedZMHPRJJKl+ItlPTN4H7bkHtA7yYt+LYvlDCWyJc2FPrXGn4/zCF2M5
	 JM6+2jlC0Hm0Gz0b26wd2sQRMhAn2d99VZuNGanC4mH7zWOCdkqHVl9DXRCyWEp/0H
	 Himu0H8K40OO58H1fpZFSj2vHzs2CijZEgFl5Tn2w9ReU+flU0Qfnlr43Xiv0UaG3n
	 O21tVnHh6lHYxlWIIbNF+TudggqAelyxGIehPPGkBkbwffkERSxf+UpP6dzdXKnjOW
	 bnIPJhuQO7a+YUZ9nAgRUA9sIIfa5ffQt95LjsmA+U9bE8C+BOc5izaWPUyFqfyo7f
	 4covHkaSj8QYg==
Date: Fri, 13 Sep 2024 19:48:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Krzysztof =?UTF-8?B?T2zEmWR6a2k=?= <ole@ans.pl>
Cc: Ido Schimmel <idosch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Yishai Hadas
 <yishaih@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] mlx4/mlx5: {mlx4,mlx5e}_en_get_module_info
 cleanup
Message-ID: <20240913194808.43932def@kernel.org>
In-Reply-To: <6b979753-9f5a-410c-9fe3-d2366976e316@ans.pl>
References: <14a24f93-f8d6-4bc7-8b87-86489bcedb28@ans.pl>
	<20240913135510.1c760f97@kernel.org>
	<6b979753-9f5a-410c-9fe3-d2366976e316@ans.pl>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Sep 2024 19:12:01 -0700 Krzysztof Ol=C4=99dzki wrote:
> On 13.09.2024 at=C2=A013:55, Jakub Kicinski wrote:
> > On Wed, 11 Sep 2024 23:38:45 -0700 Krzysztof Ol=C4=99dzki wrote: =20
> >> Use SFF8024 constants defined in linux/sfp.h instead of private ones.
> >>
> >> Make mlx4_en_get_module_info() and mlx5e_get_module_info() to look
> >> as close as possible to each other.
> >>
> >> Simplify the logic for selecting SFF_8436 vs SFF_8636. =20
> >=20
> > Minor process suggestion, I think you may be sending the patches one by
> > one. It's best to format them into a new directory and send all at once
> > with git send-email. Add a cover letter, too.
> >  =20
>=20
> Thanks, yes, will do for v2. I assume this needs to wait for about
> two weeks for net-next to re-open?

The cleanups - yes, but if patch 3 works you should make it independent
and send as a fix (and trees never close for fixes).

