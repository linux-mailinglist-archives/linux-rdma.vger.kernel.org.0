Return-Path: <linux-rdma+bounces-14250-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F165C339FA
	for <lists+linux-rdma@lfdr.de>; Wed, 05 Nov 2025 02:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7038464610
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Nov 2025 01:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A41226D14;
	Wed,  5 Nov 2025 01:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWtTGfB0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0141C01;
	Wed,  5 Nov 2025 01:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762305642; cv=none; b=rapxZXp11Cf0lqkOJ5NflQpu83GiG87Y5rmLMKvotzfoeMzITTl9ZWrpBIygbCJ90fr7/Rmq7qU2euck7T9yvOJF1Uzwp+jhbIc6CUHpTrRz9cHUZMovUBwXwTt63Owe8mOdkDhN+5iJEU/nzMzUbb/aIMd0lUs6XO38/y4EkOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762305642; c=relaxed/simple;
	bh=PSVlqZwXnnGN8qZr9cuQ31q2STWtg6ryhmbZfLVJajc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KfIbE/IvPNNSUPnd1y86hfiioXHjp4vtWNhl8WLLJaYaXcfPVDf96dzvDOLZ8IAEBL7CbZjpj+lgUo+VjX1me5YgW/ELsMDIOAe3ado2QXyiKeXmq3k0D6yyh1zS+AVZsuXbw1XAgMjHBsyK0UVF3FFd+UMOyqolUGpaRddcXX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWtTGfB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A693FC4CEF7;
	Wed,  5 Nov 2025 01:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762305641;
	bh=PSVlqZwXnnGN8qZr9cuQ31q2STWtg6ryhmbZfLVJajc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cWtTGfB0ZJkOxRJGB2SJlPyBAyAt1j2XBGInqUqkcSfwzjyr5DFcEBXR2CkRubTnB
	 Whw+gFr/BM5IlSIlt/E5dKa9JJy1OUCVqw383v1JPXps3pqX+Nn9XZfQgcW3dVOy3b
	 Ci1rWZYg0LDEQ5Pv8DLMcHPN1xoFYUxGxFmY3SM6z4WnJUTvwjd+e1BzRB99Jkgrkn
	 piXfpZ1n1p7I9sdtTmHY5Ojr03gZPtZM1uqmwdvJlIrf5t0VzfLwIl0N+8Q0B155hG
	 oo3yMmjrsp9CHzeqCWVgKcQl63byu/dbVEKcEDTgZtKrmLCFdLu7qQejlunYFYnePr
	 WIOyaCOWiFmFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEB6380AA54;
	Wed,  5 Nov 2025 01:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V2 0/7] net/mlx5e: Reduce interface downtime on
 configuration change
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176230561550.3049609.2299589262372697174.git-patchwork-notify@kernel.org>
Date: Wed, 05 Nov 2025 01:20:15 +0000
References: <1761831159-1013140-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1761831159-1013140-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 cjubran@nvidia.com, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Oct 2025 15:32:32 +0200 you wrote:
> Hi,
> 
> This series significantly reduces the interface downtime while swapping
> channels during a configuration change, on capable devices.
> 
> Here we remove an old requirement on operations ordering that became
> obsolete on recent capable devices. This helps cutting the downtime by a
> factor of magnitude, ~80% in our example.
> 
> [...]

Here is the summary with links:
  - [net-next,V2,1/7] net/mlx5e: Enhance function structures for self loopback prevention application
    https://git.kernel.org/netdev/net-next/c/091400a5d411
  - [net-next,V2,2/7] net/mlx5e: Use TIR API in mlx5e_modify_tirs_lb()
    https://git.kernel.org/netdev/net-next/c/5c51a86122b2
  - [net-next,V2,3/7] net/mlx5e: Allow setting self loopback prevention bits on TIR init
    https://git.kernel.org/netdev/net-next/c/99b002018f6a
  - [net-next,V2,4/7] net/mlx5: IPoIB, set self loopback prevention in TIR init
    https://git.kernel.org/netdev/net-next/c/a4c81e72f132
  - [net-next,V2,5/7] net/mlx5e: Do not re-apply TIR loopback configuration if not necessary
    https://git.kernel.org/netdev/net-next/c/477c352adda4
  - [net-next,V2,6/7] net/mlx5e: Pass old channels as argument to mlx5e_switch_priv_channels
    https://git.kernel.org/netdev/net-next/c/911e3a37b024
  - [net-next,V2,7/7] net/mlx5e: Defer channels closure to reduce interface down time
    https://git.kernel.org/netdev/net-next/c/3b88a535a8e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



