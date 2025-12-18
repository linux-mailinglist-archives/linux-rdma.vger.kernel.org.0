Return-Path: <linux-rdma+bounces-15068-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B2CCCBEB7
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 14:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8282B3028F68
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 13:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE02733B6DE;
	Thu, 18 Dec 2025 13:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dy+80sNE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BB82F83A2;
	Thu, 18 Dec 2025 13:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766063008; cv=none; b=IreT1eqNcK4Pk0PR+gSCwoBD1uRZ0iyWvNcSLMH5v/k2CEdm3/B0KZOKeSaw3gjWVrSnsSViXUt2wpsi1FZO3+aeOoZOGHFKPUDKHxcRScml3PlRSJEi6wy2FVk4ZDNIufp1bDB0iyHU0JhqGAWAKAsWcmwzmdDL4R4s20Kum94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766063008; c=relaxed/simple;
	bh=VcQ8jEwxhX+R8hvX60yLjPYpobh9R0jIbJidY5mkfeU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tsud7UEpgcAX+lvW6mROfLCjQb0hoUsm5zz60ZkQcI6a+LPKWNIHxjT1IOHXPPDhRjZXZIjsDXnuit56Y7UvGYNReZfhQRx6Vca0393H+fJZydgPuyIqBg+cZ0D2E0Q+Vqby4ILouWAbQuUbzkCH5UOWJjHUbM5DNKA9UoFHkOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dy+80sNE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C1DC4CEFB;
	Thu, 18 Dec 2025 13:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766063008;
	bh=VcQ8jEwxhX+R8hvX60yLjPYpobh9R0jIbJidY5mkfeU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dy+80sNEV1BVFS50koXGFZ993SJTn6B3D/KMbzAw21TnlCWEgsUjlyJApOSaH0QX8
	 LuuW16+uuXPygjy16V1RF5oJNGaEE8XBQ5hyafYvaPcVUUWmabH6rgNp5/OtH38SG3
	 CPsEwbaduXBv4Einfj7ZwzSPWBYzLv1harepL2nE9aIO6+vYVfsPLbOwiJGxPRz6c9
	 3dL7TvQ9fl2UmUW/p+VQc3NMrrKUb1IT9+gIhH31WcQr2CqplOezrBvIM8OYGKhZM2
	 96hJr2ErHWY3Ukfbn1nDNdj2Pd8mXulTutONIv8lPLAftVnKROUhzwQA+kjbonsK6C
	 B/cMlOahuEVjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2AD0380A955;
	Thu, 18 Dec 2025 13:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/9] mlx5 misc fixes 2025-12-09
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176606281779.2943927.5802057198680861828.git-patchwork-notify@kernel.org>
Date: Thu, 18 Dec 2025 13:00:17 +0000
References: <1765284977-1363052-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1765284977-1363052-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 moshe@nvidia.com, leitao@debian.org, acassen@corp.free.fr

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 9 Dec 2025 14:56:08 +0200 you wrote:
> Hi,
> 
> This patchset provides misc bug fixes from the team to the mlx5 core and
> Eth drivers.
> 
> Thanks,
> Tariq.
> 
> [...]

Here is the summary with links:
  - [net,1/9] net/mlx5: fw reset, clear reset requested on drain_fw_reset
    https://git.kernel.org/netdev/net/c/89a898d63f6f
  - [net,2/9] net/mlx5: Drain firmware reset in shutdown callback
    https://git.kernel.org/netdev/net/c/5846a365fc64
  - [net,3/9] net/mlx5: fw_tracer, Validate format string parameters
    https://git.kernel.org/netdev/net/c/b35966042d20
  - [net,4/9] net/mlx5: fw_tracer, Handle escaped percent properly
    https://git.kernel.org/netdev/net/c/c0289f67f7d6
  - [net,5/9] net/mlx5: Serialize firmware reset with devlink
    https://git.kernel.org/netdev/net/c/367e501f8b09
  - [net,6/9] net/mlx5e: Use ip6_dst_lookup instead of ipv6_dst_lookup_flow for MAC init
    https://git.kernel.org/netdev/net/c/e35d7da8dd9e
  - [net,7/9] net/mlx5e: Trigger neighbor resolution for unresolved destinations
    https://git.kernel.org/netdev/net/c/9ab89bde13e5
  - [net,8/9] net/mlx5e: Do not update BQL of old txqs during channel reconfiguration
    https://git.kernel.org/netdev/net/c/c8591decd9db
  - [net,9/9] net/mlx5e: Don't include PSP in the hard MTU calculations
    https://git.kernel.org/netdev/net/c/4198a14c8c62

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



