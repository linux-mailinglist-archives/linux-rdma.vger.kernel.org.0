Return-Path: <linux-rdma+bounces-1893-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 568D78A0689
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Apr 2024 05:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D94A0B272FB
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Apr 2024 03:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08CA13B5BD;
	Thu, 11 Apr 2024 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lec+4hoU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885C823BF;
	Thu, 11 Apr 2024 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712805028; cv=none; b=KLpTu8TK2RRSR/X+jgnnwSD0z91aTTwFtEiy4J9F1TmBFTTweSuC1qUz9HG49pVBJOEa/6wt6ne0Y1vkr+sej3t65CECvUuOYzDSOTCJzssRkftkHt7cfCaw1Hu048oRMg2t0Xc7ge+PdsKvNFRL5LCtG8fOhcuSDHsqJJa6738=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712805028; c=relaxed/simple;
	bh=P8nxzAEA4Dw6TBYmeOxg5YUdM3nJA/0Pc9gCOyu1Zbg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XIxpgIoz0exRYzIU3hkyR5H+MPBegD1858z+1zEalPklFrrATg91cTNei+qPnzpAgiVxNIBVpZT8PyOOmiWomlt62kdpw+Kb/Uwi3X3inUs2ppA/tHBmXHKosHBspZGj1vHmqnm8yqg9J/ofdby0XPxLUbhvmXCY5OPrSJA1CPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lec+4hoU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02ECAC43390;
	Thu, 11 Apr 2024 03:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712805028;
	bh=P8nxzAEA4Dw6TBYmeOxg5YUdM3nJA/0Pc9gCOyu1Zbg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Lec+4hoUd4oVHwXOqyVxGNRueuB501laIGKqdoUEdjKZLcFZnl6zvsZLvYLVw7bY1
	 efs4NzktCLySJo0vMSIJNO8uSpJxXHRZ6dx5/+AgUrOVtowTbR4oraa2bMfcC75A3t
	 gjFKs9No7WjrFfE4wtr6e9ZTMrZDP7JOxLPQzaSPxlFi4tCNL/JoRZnqakAxY9HCVb
	 vy6BPZ/y5a3tjUYz5Ekv00O4x/HY61N7TTxbCPTPvdnohE33CwaYTikUPtEeqo8Fn2
	 G7I7KNcBctlzp2xy6v7+zgWMAk+nbvGFTgw8kIsb64U7W0TMSxef6HGhHp7tsSIcdx
	 Vd/8APLEkPB4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5746C395F6;
	Thu, 11 Apr 2024 03:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] [v4] net/mlx5: fix possible stack overflows
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171280502793.8263.1076847804424712922.git-patchwork-notify@kernel.org>
Date: Thu, 11 Apr 2024 03:10:27 +0000
References: <20240408074142.3007036-1-arnd@kernel.org>
In-Reply-To: <20240408074142.3007036-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, arnd@arndb.de,
 horms@kernel.org, jiri@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kliteyn@nvidia.com, valex@nvidia.com,
 jiri@resnulli.us, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Apr 2024 09:41:10 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A couple of debug functions use a 512 byte temporary buffer and call another
> function that has another buffer of the same size, which in turn exceeds the
> usual warning limit for excessive stack usage:
> 
> drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c:1073:1: error: stack frame size (1448) exceeds limit (1024) in 'dr_dump_start' [-Werror,-Wframe-larger-than]
> dr_dump_start(struct seq_file *file, loff_t *pos)
> drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c:1009:1: error: stack frame size (1120) exceeds limit (1024) in 'dr_dump_domain' [-Werror,-Wframe-larger-than]
> dr_dump_domain(struct seq_file *file, struct mlx5dr_domain *dmn)
> drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c:705:1: error: stack frame size (1104) exceeds limit (1024) in 'dr_dump_matcher_rx_tx' [-Werror,-Wframe-larger-than]
> dr_dump_matcher_rx_tx(struct seq_file *file, bool is_rx,
> 
> [...]

Here is the summary with links:
  - [v4] net/mlx5: fix possible stack overflows
    https://git.kernel.org/netdev/net/c/fe87922cee61

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



