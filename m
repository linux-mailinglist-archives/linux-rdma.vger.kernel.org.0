Return-Path: <linux-rdma+bounces-14101-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAABC14114
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 11:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F08319810A6
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 10:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4743E30499B;
	Tue, 28 Oct 2025 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcB1AJel"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE30302CB1;
	Tue, 28 Oct 2025 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646835; cv=none; b=kIQX++TCSlROsuog8KjubkhVpLl9AEq2cu/v4UL8q3t9Ik5oYFoBdd+rWnlMcDQHtCt7ArGOWkv+2ax8CVeQx/isoLlL7cvsoxcP9F9Ku2VRevV2IcFi9tGmyP3O6QWEsJ/4sVesqTya6cKhJbz+hNq4QSNCHgThDubXAb8Mo9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646835; c=relaxed/simple;
	bh=/ZGGElVkmrssyomY9MBMCZEbRRne70902mcBE26YqzA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hmK+ZDgvCVcqwqyUFh4eWV9ZuXh2XMnECwCl+u2t/dbUoLqA/xo0We1RYoifr9IWDO3vp3LxpKBGC/NJD0bOn89ej7xuem/m71JWYIYpad+nEHzeamAR/1x86AqrdQE5bRggUESxcTKB3ub5J8giK+llLBmuHhEHIsJD1Jo52p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcB1AJel; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D93DC4CEE7;
	Tue, 28 Oct 2025 10:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761646834;
	bh=/ZGGElVkmrssyomY9MBMCZEbRRne70902mcBE26YqzA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kcB1AJel/RrtAn0vptmZ40UIZOyPhOlKgG7ITkhD8rvDUlTJu593lrPrRApeSnoq4
	 WDdv+fEcl8irg+MAwgQ2L9P6LTXQlmngMVrvsnqQo0q+2P0hifJX4zXuS/quBXMbFk
	 TcM5r1HRaKhKjJ6j/IKmTVJtR5rlO6+AYMZYm+GYpDd1nEh7UCv5irkszZ91QkybHX
	 qb4/UYGGj5auvIYTki1kcpkF/4d62KsIOjzR4Jp38mprYb4poMbpNkD5pjqFw/2yDy
	 c8kCdm85SygTD83PSL4+Eudb5HOMhVZ82Wnwj3/XHEc2dSOnlZ2gEkItO999qlfPTA
	 oF9n8V5ivMSWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE3639EF974;
	Tue, 28 Oct 2025 10:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] net/mlx5: Add balance ID support for LAG
 multiplane groups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176164681250.2170827.16598265878649252759.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 10:20:12 +0000
References: <1761211020-925651-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1761211020-925651-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 moshe@nvidia.com, shayd@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 23 Oct 2025 12:16:55 +0300 you wrote:
> Hi,
> 
> This series adds balance ID support for MLX5 LAG in multiplane
> configurations.
> 
> See detailed description by Mark below [1].
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] net/mlx5: Use common mlx5_same_hw_devs function
    https://git.kernel.org/netdev/net-next/c/211de28b1caf
  - [net-next,2/5] net/mlx5: Add software system image GUID infrastructure
    https://git.kernel.org/netdev/net-next/c/7718f2a8b87a
  - [net-next,3/5] net/mlx5: Refactor PTP clock devcom pairing
    https://git.kernel.org/netdev/net-next/c/cd36818c34ac
  - [net-next,4/5] net/mlx5: Refactor HCA cap 2 setting
    https://git.kernel.org/netdev/net-next/c/075e85a1261e
  - [net-next,5/5] net/mlx5: Add balance ID support for LAG multiplane groups
    https://git.kernel.org/netdev/net-next/c/20d78ead9477

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



