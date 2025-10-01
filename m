Return-Path: <linux-rdma+bounces-13749-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 919EDBAEE0A
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Oct 2025 02:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67FAF3ABA17
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Oct 2025 00:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5586F1A76BC;
	Wed,  1 Oct 2025 00:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWZ2TRDK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA131A239D;
	Wed,  1 Oct 2025 00:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759278625; cv=none; b=FKGIkUyzoFkiRv33V4xyybbfus+WRIKu8Ibi4wib8YlbyfAhNfKSB3fkaHSA2qBTKbkrjfp+I/PaoOGkwI3skqD6gEARw/L9BjUYCCgdiCLXSFTjKTb+tNVowUTd4GXJf9VG1LWyTuyQgisdm6utHFvrDTx/HGKzGqH23hESGoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759278625; c=relaxed/simple;
	bh=wZItWX+x0LGbQwKnFknuuh0aq7XRTSoTBsr985DKURE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HnEIqXTenKTmUs0l1bWE21yGwkWYHvwVbG8knH4vv6aCaSaaAi3xwBoNz2AHJrw56ZUfmYe3zGtFNANL08gudNc4yeabtpnpw9T71AtPnD5bCwuUJkEQOrYolLr5EpdOApQpnHLuv3HNj6Yd8tLF/kZMKWndXyqhPSjihXItNoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWZ2TRDK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CBEC113D0;
	Wed,  1 Oct 2025 00:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759278624;
	bh=wZItWX+x0LGbQwKnFknuuh0aq7XRTSoTBsr985DKURE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PWZ2TRDKhu+KQDsk8mHHExZ2PbJkbKUDH/KkDvKq80Fp4CUd0UI2UXmrAmUc66XuA
	 HjGNXQY7q5aP3HJgFOebBxIh0EmzdvzkNr6EAt0TLMKQjHLND4rtUdNtFUU4Qegokq
	 u/701e51tZoG0k8tDUDO3qxQbkuBk4qoPc+ABXmRcLNKNJPkD1z2t0w1job4Uve7f0
	 COWXtA4PdcoX4oTQy+72v80DR5QkiS+ggzFBOJGBusMOgDS2vLnoZ5QgI1/lSdA0G8
	 +m1ofqTa8U1YGZf80iiJ7qbY2vk/1FS0cx2dy61lJ5Amq4UgSMgvk4F+Gq0qwms6qA
	 cABynDoVZWbVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C4039D0C1A;
	Wed,  1 Oct 2025 00:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V2 0/7] net/mlx5: misc changes 2025-09-28
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175927861725.2249992.6200051562471636595.git-patchwork-notify@kernel.org>
Date: Wed, 01 Oct 2025 00:30:17 +0000
References: <1759094723-843774-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1759094723-843774-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 moshe@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Sep 2025 00:25:16 +0300 you wrote:
> Hi,
> 
> This series contains misc enhancements to the mlx5 driver.
> 
> Find V1 here:
> https://lore.kernel.org/all/1758531671-819655-1-git-send-email-tariqt@nvidia.com/
> 
> [...]

Here is the summary with links:
  - [net-next,V2,1/7] net/mlx5: HWS, Generalize complex matchers
    https://git.kernel.org/netdev/net-next/c/906154caa7d3
  - [net-next,V2,2/7] net/mlx5e: Prevent entering switchdev mode with inconsistent netns
    https://git.kernel.org/netdev/net-next/c/06fdc45f16c3
  - [net-next,V2,3/7] net/mlx5: Improve QoS error messages with actual depth values
    https://git.kernel.org/netdev/net-next/c/33dbaa54ef43
  - [net-next,V2,4/7] net/mlx5e: Remove unused mdev param from RSS indir init
    https://git.kernel.org/netdev/net-next/c/a3f69641cbbc
  - [net-next,V2,5/7] net/mlx5e: Introduce mlx5e_rss_init_params
    https://git.kernel.org/netdev/net-next/c/fc92cddd7a83
  - [net-next,V2,6/7] net/mlx5e: Introduce mlx5e_rss_params for RSS configuration
    https://git.kernel.org/netdev/net-next/c/c40a94ccfdc7
  - [net-next,V2,7/7] net/mlx5e: Use extack in set rxfh callback
    https://git.kernel.org/netdev/net-next/c/a833538d1d8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



