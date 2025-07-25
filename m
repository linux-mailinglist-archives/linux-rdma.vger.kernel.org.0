Return-Path: <linux-rdma+bounces-12468-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80412B11504
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jul 2025 02:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0857C4E4F03
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jul 2025 00:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539BA1373;
	Fri, 25 Jul 2025 00:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yubfi/yx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D54634;
	Fri, 25 Jul 2025 00:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753402214; cv=none; b=PXT0EucRYQoCX6SXoi+a2fHvom9VZvSc5EqQLzdsgkBRyT9U07M0SvttT/dChhnGu8W2o1s+iRWfmc9E/Qsmno/MYmGBCiDZN0tXH2gvSCxGNj01UhBZ/c3202VsOTtxwKb83oVdRw8jfpBrJK+gXrbcOdn5JRlEFBp7jL6jgtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753402214; c=relaxed/simple;
	bh=Efr02ucghVvgSDn8C24njX+4voOe5UznirPQXWvnDzk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EkYbVvyCUmbgt1UcVgEzuaUn/j1qJiZA84gxf2xLge8iWdZxsUWovcvvriTalG+gibDctrlcfoUD+b7i0qsy88AZecK4NCuF4jgrRz9WsH0Tw8ghT40w4LYrvG5JOxyCi5i58dwUqD/74MXLY9TdkQN8T4wwboOsWwj9amaHLXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yubfi/yx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C794C4CEED;
	Fri, 25 Jul 2025 00:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753402213;
	bh=Efr02ucghVvgSDn8C24njX+4voOe5UznirPQXWvnDzk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yubfi/yxAM3CCWJCHIwvB4ZciDHFX+FvkC+gpWLrp0y7BMH/0tT5k++48ChpPTqJ/
	 4iN8qXIyppWRWsOrgDLLRISLbDrH4rwbgeHMMp1OFsQn2OkgMsGylgayJN+0Y/N4Bw
	 jBWU49qtKLt2bZTr5gn7Lwf61N8UE8J373uX9cEq2aJPDwe8aE09P9tNXb0UVT/zYZ
	 13sm94F8Qip51ieaK7g8Amupe9wXYKFUE47ONq6/2AOitnsMsHhjjLp0bjaOiy+5kM
	 A4vejS5beOwQIx32BiEDFYqtF1qSl5pA3exUk6nNxCh5RTbazzASBLu0g9ZHNISD2y
	 XjrmJtxf3recQ==
Date: Thu, 24 Jul 2025 17:10:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Jiri Pirko <jiri@resnulli.us>,
 Jiri Pirko <jiri@nvidia.com>, Saeed Mahameed <saeed@kernel.org>, Gal
 Pressman <gal@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Shahar
 Shitrit <shshitrit@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Brett Creeley <brett.creeley@amd.com>,
 Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, Cai Huoqing <cai.huoqing@linux.dev>, Tony
 Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Sunil Goutham <sgoutham@marvell.com>, Linu
 Cherian <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, Jerin
 Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>, Mark
 Bloch <mbloch@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
 <petrm@nvidia.com>, Manish Chopra <manishc@marvell.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 0/5] Expose grace period delay for devlink
 health reporter
Message-ID: <20250724171011.2e8ebca4@kernel.org>
In-Reply-To: <6892bb46-e2eb-4373-9ac0-6c43eca78b8e@gmail.com>
References: <1752768442-264413-1-git-send-email-tariqt@nvidia.com>
	<20250718174737.1d1177cd@kernel.org>
	<6892bb46-e2eb-4373-9ac0-6c43eca78b8e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Jul 2025 13:46:08 +0300 Tariq Toukan wrote:
> Design alternatives considered:
>=20
> 1. Recover all queues upon any error:
>     A brute-force approach that recovers all queues on any error.
>     While simple, it is overly aggressive and disrupts unaffected queues
>     unnecessarily. Also, because this is handled entirely within the
>     driver, it leads to a driver-specific implementation rather than a
>     generic one.
>=20
> 2. Per-queue reporter:
>     This design would isolate recovery handling per SQ or RQ, effectively
>     removing interdependencies between queues. While conceptually clean,
>     it introduces significant scalability challenges as the number of
>     queues grows, as well as synchronization challenges across multiple
>     reporters.
>=20
> 3. Error aggregation with delayed handling:
>     Errors arriving during the grace period are saved and processed after
>     it ends. While addressing the issue of related errors whose recovery
>     is aborted as grace period started, this adds complexity due to
>     synchronization needs and contradicts the assumption that no errors
>     should occur during a healthy system=E2=80=99s grace period. Also, th=
is
>     breaks the important role of grace period in preventing an infinite
>     loop of immediate error detection following recovery. In such cases
>     we want to stop.
>=20
> 4. Allowing a fixed burst of errors before starting grace period:
>     Allows a set number of recoveries before the grace period begins.
>     However, it also requires limiting the error reporting window.
>     To keep the design simple, the burst threshold becomes redundant.

We're talking about burst on order of 100s, right? The implementation
is quite simple, store an array the size of burst in which you can
save recovery timestamps (in a circular fashion). On error, count
how many entries are in the past N msecs.

It's a clear generalization of current scheme which can be thought of
as having an array of size 1 (only one most recent recovery time is
saved).

> The grace period delay design was chosen for its simplicity and
> precision in addressing the problem at hand. It effectively captures
> the temporal correlation of related errors and aligns with the original
> intent of the grace period as a stabilization window where further
> errors are unexpected, and if they do occur, they indicate an abnormal
> system state.

Admittedly part of what I find extremely confusing when thinking about
this API is that the period when recovery is **not** allowed is called
"grace period". Now we add something called "grace period delay" in
some places in the code referred to as "reporter_delay"..

It may be more palatable if we named the first period "error burst
period" and, well, the later I suppose it's too late to rename..

