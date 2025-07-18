Return-Path: <linux-rdma+bounces-12287-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73220B09987
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jul 2025 04:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B1401C47B8F
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jul 2025 02:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970D01E1E0B;
	Fri, 18 Jul 2025 02:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUbhD2D8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC2070825;
	Fri, 18 Jul 2025 02:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752804010; cv=none; b=vFXWr5a8iQlohNBfHx3mnub20Kyt1OeCHRz8X8zUr4R/tGMyfqG73gX5L4hcRked/vZB11Wb4uaTshTZbpz4VH66A/Ju8RoQDJMRCIeEl0sptUV4WPgTlb9HIR/xjtH4o7wRk7pCEh0ARYLdufpyRHfjAkuIPhHhYdVU4xNQ4Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752804010; c=relaxed/simple;
	bh=HK2GEmsHAnUtVvO6lfRZsKCw+PVLN5JlJ+8KAkUe3d0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OaTKUXSDhYpTLLAGwNiyumzm8UvqNK8SgntXZeCIrBvSW7bTOvYV6GZv/Acs+n+3JGuHCH8aj7QU+eQ7gKxY54KAI6esa+atuLjzu7ivHhCqjwpTnV4W7koHLhN2T24JhRx7VkUF920hcmT0cjBPehkx+5H734U7n5G9h37k8YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUbhD2D8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8B8C4CEE3;
	Fri, 18 Jul 2025 02:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752804009;
	bh=HK2GEmsHAnUtVvO6lfRZsKCw+PVLN5JlJ+8KAkUe3d0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mUbhD2D8B5ekUtOTKue/Y0+lWFsA/pqa9U75wlR2jp/pE2cyOsNiQoPN0mpHU328f
	 nkvocZ2MRNVsC4R53yrQ4ldujtGmqYAHEkZGoFVbLxVQrW7ijxWvtM23BPW3yjbdF4
	 3NbfoYgzKyR1wOcbWSJc4Vjuf6BdB88orwmuostl/6zkR7XPmkS3j43hKnTRi9WRdv
	 MaYzvkjci7dgtgfzcWcpw9ukNhqdf5iIH/j3zhzQB6xwfGsPdAwzmbCPbkPlEwIwOK
	 KaZwY2q2aoeND3/YuPP4EXOTJjfVSmnjVNAmds9irT0Y2hCQ+GU4KijsixlQmNsugG
	 nFNG7Br5gkpMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC99383BA3C;
	Fri, 18 Jul 2025 02:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V2 0/6] net/mlx5: misc changes 2025-07-16
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175280402949.2141855.15651541086934406662.git-patchwork-notify@kernel.org>
Date: Fri, 18 Jul 2025 02:00:29 +0000
References: <1752675472-201445-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1752675472-201445-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeed@kernel.org, gal@nvidia.com,
 leon@kernel.org, saeedm@nvidia.com, mbloch@nvidia.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Jul 2025 17:17:46 +0300 you wrote:
> Hi,
> 
> This series contains misc enhancements to the mlx5 driver.
> Find V1 here:
> https://lore.kernel.org/all/1752471585-18053-1-git-send-email-tariqt@nvidia.com/
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [net-next,V2,1/6] net/mlx5: HWS, Enable IPSec hardware offload in legacy mode
    https://git.kernel.org/netdev/net-next/c/159846ffbaf5
  - [net-next,V2,2/6] net/mlx5e: fix kdoc warning on eswitch.h
    https://git.kernel.org/netdev/net-next/c/394d31d52fb6
  - [net-next,V2,3/6] net/mlx5e: Properly access RCU protected qdisc_sleeping variable
    https://git.kernel.org/netdev/net-next/c/2a601b2d3562
  - [net-next,V2,4/6] net/mlx5e: SHAMPO, Cleanup reservation size formula
    (no matching commit)
  - [net-next,V2,5/6] net/mlx5e: SHAMPO, Remove mlx5e_shampo_get_log_hd_entry_size()
    (no matching commit)
  - [net-next,V2,6/6] net/mlx5e: Remove duplicate mkey from SHAMPO header
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



