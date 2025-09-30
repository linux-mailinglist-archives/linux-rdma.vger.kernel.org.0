Return-Path: <linux-rdma+bounces-13736-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6309FBAD398
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 16:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF7267A2F76
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 14:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E058303CAE;
	Tue, 30 Sep 2025 14:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ywm0q/Zm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC8C303A05;
	Tue, 30 Sep 2025 14:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243213; cv=none; b=QFlTjiIomc2Z3zCft2KepVYrDrXporvP5avNfqIHAhTiSMg1KDgG1tdLYVjqC2ygY+tsv/wj9Bfavao0LT10w9T+g3h2FDOtz+TwpZ0lgVy7QQwkEgVLSwllZBoKZZ+elA9qGGlDGNntM9q3xbaG9svoV+jPPyucT9DHXJ8y8NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243213; c=relaxed/simple;
	bh=UA+XDBzx2YBIspAMKgow/QpNI2YZuV5l0p6uuAm4Chs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gGdhaHEmogAfX0dP9uWUgnKRhjpiumX+RQ4ZjqcsHC9pHKYDJfz+7aHEBTWlYuR47h4xDYFaOe7uxG8jXtoM4qH0GwUSjNikcKur2JnY4BUROS35DQpZoOF5iORu6PRIN5qteWHiL/WvSfnTOxrflJ53TnlaYxet/BuFLiIfgmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ywm0q/Zm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB19FC4CEF0;
	Tue, 30 Sep 2025 14:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759243212;
	bh=UA+XDBzx2YBIspAMKgow/QpNI2YZuV5l0p6uuAm4Chs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ywm0q/ZmX6YArgMnz4SGHDnao9f2ZsokBcOTvVpSKAjQK8kS5BIe5o2nqNtmUxS6V
	 8LaflFqNuk07cRSSQjiAr2C9jVZvMEwkb9w/x5qXrm4AzA1fLkmrkchE/kaYg4fxJz
	 1hPjEwfeUw854bdo6S8udFb4P709WnRmaDyznP6Le5E3zyJ40nkfY442V9+Dqa5Ya8
	 UQfwMLM0e0ARKy6r7qLA8bTAWyD/+2z0PxreOe6UV4RDKp/Z+WDokNCAiv1kzJP9UJ
	 5feGicuL5DyCVE4MVwykuTcfbjig5Ui1D5iy6YW+3g20665TVamhjmQe7JVwoX9/Dn
	 guPqU15UoF9Xw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B3739D0C1A;
	Tue, 30 Sep 2025 14:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] Revert "net/mlx5e: Update and set Xon/Xoff upon MTU
 set"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175924320601.2006533.5473877884260155875.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 14:40:06 +0000
References: <20250929181529.1848157-1-kuba@kernel.org>
In-Reply-To: <20250929181529.1848157-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 alazar@nvidia.com, linux-rdma@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 29 Sep 2025 11:15:29 -0700 you wrote:
> This reverts commit ceddedc969f0532b7c62ca971ee50d519d2bc0cb.
> 
> Commit in question breaks the mapping of PGs to pools for some SKUs.
> Specifically multi-host NICs seem to be shipped with a custom buffer
> configuration which maps the lossy PG to pool 4. But the bad commit
> overrides this with pool 0 which does not have sufficient buffer space
> reserved. Resulting in ~40% packet loss. The commit also breaks BMC /
> OOB connection completely (100% packet loss).
> 
> [...]

Here is the summary with links:
  - [net] Revert "net/mlx5e: Update and set Xon/Xoff upon MTU set"
    https://git.kernel.org/netdev/net-next/c/6f5dacf88a32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



