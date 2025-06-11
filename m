Return-Path: <linux-rdma+bounces-11217-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CC5AD61E7
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Jun 2025 23:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FFBD188CE6A
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Jun 2025 21:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCF5246781;
	Wed, 11 Jun 2025 21:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIhOLYFE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11240218591;
	Wed, 11 Jun 2025 21:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749678608; cv=none; b=ajN24+wTVyaAY8MiSKM0ypd01LYySkkQfZN2qOE8E1QNFKcLK7ENkD0i8Jvgtz3XktXMB2Li+vRsWIDdkgZEYCjLTbFzUw842s0cDl4ZyXlRWn67B2Ww9eJj/LTSK7lfXl6Hb8Qg8oy1syoTyiO/AuxXh9dEoRPBeqeSi5lBB40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749678608; c=relaxed/simple;
	bh=t7g7nDWGInSfgmZbN0xOrHOEo4ASBz/pYBaLiletTrY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LPIvyaLlgpQ33/tkO5JSFOTQmP4PPOtLiMtLoemUKO4EdRM0e2aw9PY5jFBW2NyfqXk9d4+NhG11Y3eTHbN55evZOFp0urlxppar9OVK5ZeSjnIjiE4LAf/DOwFVYuxEq4CuK5g/n5273hwD7Xs9bVtgsFNawKFK493KGjTUXGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIhOLYFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC95FC4CEEE;
	Wed, 11 Jun 2025 21:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749678607;
	bh=t7g7nDWGInSfgmZbN0xOrHOEo4ASBz/pYBaLiletTrY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aIhOLYFEKe+qk2YVj08IfRhzzvcdXR7sX1AVx2qR0C3bjo8ALEO/QTWq62kHTIaSf
	 LwxlCNYG3e0qZP1eOrIyKpRBSHt0HYl+WCqeAyOpmjjH6REHDJSJOeZZI/PWcSV1wO
	 CLIRJvk3Udh4k6YxNn/OXqxBogfgHkLUhafPtN1vGTuvw/eeGwBsNlb0yq6gTD7BQP
	 TKtg2im351+CZIDrFhY7DMf+IFOWtvwrDrfFSG4wV9Bkjgnl5nj9a1EMfK4lkR3xfF
	 iJ1Cri+Wyl3+GxgJwVNV9xIgzxSgXZqYv4njIhL0KmwGpIdYE0jriHUjZ7eRmUAMGU
	 89Hq/gniZ6rdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D05380DBE9;
	Wed, 11 Jun 2025 21:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/9] mlx5 misc fixes 2025-06-10
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174967863800.3499598.6852687009576458740.git-patchwork-notify@kernel.org>
Date: Wed, 11 Jun 2025 21:50:38 +0000
References: <20250610151514.1094735-1-mbloch@nvidia.com>
In-Reply-To: <20250610151514.1094735-1-mbloch@nvidia.com>
To: Mark Bloch <mbloch@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com,
 leon@kernel.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Jun 2025 18:15:05 +0300 you wrote:
> This patchset includes misc fixes from the team for the mlx5 core
> and Ethernet drivers.
> 
> Thanks,
> Mark
> 
> Amir Tzin (1):
>   net/mlx5: Fix ECVF vports unload on shutdown flow
> 
> [...]

Here is the summary with links:
  - [net,1/9] net/mlx5: Ensure fw pages are always allocated on same NUMA
    https://git.kernel.org/netdev/net/c/f37258133c1e
  - [net,2/9] net/mlx5: Fix ECVF vports unload on shutdown flow
    https://git.kernel.org/netdev/net/c/687560d8a9a2
  - [net,3/9] net/mlx5: Fix return value when searching for existing flow group
    https://git.kernel.org/netdev/net/c/8ec40e3f1f72
  - [net,4/9] net/mlx5: HWS, Init mutex on the correct path
    https://git.kernel.org/netdev/net/c/a002602676cd
  - [net,5/9] net/mlx5: HWS, fix missing ip_version handling in definer
    https://git.kernel.org/netdev/net/c/b5e3c76f35ee
  - [net,6/9] net/mlx5: HWS, make sure the uplink is the last destination
    https://git.kernel.org/netdev/net/c/b8335829518e
  - [net,7/9] net/mlx5e: Properly access RCU protected qdisc_sleeping variable
    (no matching commit)
  - [net,8/9] net/mlx5e: Fix leak of Geneve TLV option object
    https://git.kernel.org/netdev/net/c/aa9c44b84209
  - [net,9/9] net/mlx5e: Fix number of lanes to UNKNOWN when using data_rate_oper
    https://git.kernel.org/netdev/net/c/875d7c160d60

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



