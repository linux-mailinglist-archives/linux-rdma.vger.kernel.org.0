Return-Path: <linux-rdma+bounces-14853-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 67856C998C6
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Dec 2025 00:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0FA7C343678
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Dec 2025 23:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0952288C34;
	Mon,  1 Dec 2025 23:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sz0NTG6a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D5C239E6F;
	Mon,  1 Dec 2025 23:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764630807; cv=none; b=AfFLABf1duF02AdGbkOR44/fNeWzWJ6rH1K3KHsbqCUMJq1bsLFTC6tDoDXApA2r1vwYezkQekFydbtVCh8Qa365lzSAeiu/v3HcMPoxxS5NKf9G6vKhexMrn6uIbBXwlDjadLDLwXxQmgV2BLxV/YS44JJjIC1+/WPTUADNEKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764630807; c=relaxed/simple;
	bh=mWJAQdnoyAzPnrQwzmhgfgx0mLbipG74unRztfT12xg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ewf/mBTSlraRKQM4zbkP3kJS0rd/cnTCOx7abVYCMmVZApGf6rxGiZ1saW1HRxNmBd8oZmMxjvP6fJtovOX3Kqo7WMvzO4cd2bOnVH2NxIkrPeHBjF1fTbS6Np/ylIDDHwHvnAnIeSYCJw8sse8o8I5yNFWYT96LNHiGRItCOng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sz0NTG6a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0D3C4CEF1;
	Mon,  1 Dec 2025 23:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764630807;
	bh=mWJAQdnoyAzPnrQwzmhgfgx0mLbipG74unRztfT12xg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sz0NTG6azbuISIqR3rr4HdjUudOL+bmq4oDAweJUUJEfJC3uXVXsiL3o3Ko2ksOQM
	 BUdD13SgPWiSfJCzWOMdlOHLz6m0yATlZ1wN55gWRIz3OOZfxWMx4pYPeBkFYqLxkx
	 k5eFfuzx6Lo/2HeOhAWTjWb0FBkgF9quNytoAeu7ilcU6VtARzgGkf7WtLazJN/XSY
	 6bpoiH8Hljo4H2sN25/4L+GFZm4ae9XhSVa2uAxJZ7CfOotHZNZO+SQCTzmWjVw640
	 YZq9OGmScJRD9kt1qclm5VkQ8fF7atE5Furtd0x1pnwfC1SWcYC2OW8NOy5xIIelvd
	 Sbpn8IrKMj8eg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B6F6381196A;
	Mon,  1 Dec 2025 23:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] net/mlx5e: Enhance DCBNL get/set maxrate
 code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176463062704.2589368.12037913186826280602.git-patchwork-notify@kernel.org>
Date: Mon, 01 Dec 2025 23:10:27 +0000
References: <1764498334-1327918-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1764498334-1327918-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 moshe@nvidia.com, noren@nvidia.com, dcostantino@meta.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 30 Nov 2025 12:25:30 +0200 you wrote:
> Hi,
> 
> This series by Gal introduces multiple small code quality improvements
> for the DCBNL operations mlx5e_dcbnl_ieee_[gs]etmaxrate().
> 
> No functional change.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net/mlx5e: Use u64 instead of __u64 in ieee_setmaxrate
    https://git.kernel.org/netdev/net-next/c/e1de33c377b6
  - [net-next,2/4] net/mlx5e: Rename upper_limit_mbps to upper_limit_100mbps
    https://git.kernel.org/netdev/net-next/c/e1098bb02f2d
  - [net-next,3/4] net/mlx5e: Use U8_MAX instead of hard coded magic number
    https://git.kernel.org/netdev/net-next/c/53f7a7712851
  - [net-next,4/4] net/mlx5e: Use standard unit definitions for bandwidth conversion
    https://git.kernel.org/netdev/net-next/c/87a5112bfc40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



