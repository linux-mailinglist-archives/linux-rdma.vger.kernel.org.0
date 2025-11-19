Return-Path: <linux-rdma+bounces-14616-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 15617C6C95B
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Nov 2025 04:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90DF24F1026
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Nov 2025 03:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6FB2EAB6F;
	Wed, 19 Nov 2025 03:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTzQJElP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2F420D4E9;
	Wed, 19 Nov 2025 03:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763522445; cv=none; b=hgHu8bXERTtf5IpV2K3C0inhGM/3v2KZBV07JIdwUIZOQLR3M1bFRV/U6LjkwcgcUfX4tvbG6sBX2ufkGXh+mpS1Hy790Y4C65WY9h2X3INq7zf0JF8q4IYfmqIwTslm+3B2A5QggXnSj4SqfzF9HYMWPeX+HoEnk1ARHFiOQfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763522445; c=relaxed/simple;
	bh=eOC6tGauOJdErGyxtuvSSvFZQ9jXZDFARNZhSFw4ZFQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IhRR4/dyUrELa1dUEYaLyPyVa+VjBRz5OFX7YlbF84pHLF6srHpPIbi8x1Rl3Mc2BI5DYMr+IaxfsCJOhgIBwFOpP8sEsbHPYJGyDMklnM9xVOwbv+8uIOSmFs623RdgWx5YmviY91bCl+MrM17KxBtmvTEoK2WApB/Xsd5tAoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTzQJElP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13676C113D0;
	Wed, 19 Nov 2025 03:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763522445;
	bh=eOC6tGauOJdErGyxtuvSSvFZQ9jXZDFARNZhSFw4ZFQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nTzQJElP4EsswwgfkWu6ebm4PWxZzkPD2YFciahz9ny7K83w8c8W/0wG+jNUzHVF4
	 v4KVvRiLSY/paBCwZgZDbeODXU/iMx6QMpXEH9eNgfI0liA6qkczDJN1ueah+E3K4S
	 aGKiAvmxs1qu3EJVsHoDsXZJmvHxr5cHi33Cy91fZs/mzzHvX/1h7mPlKLBXz56c53
	 a5SdC+KMfP6KQHbMzGkEouIFWTeFZExUBs/0g28wu2vyzXLZkKJrr91Zyw+pl7B9OY
	 RCAIgfRWQWtLIrh2kXUd+8KXxIkSFAJhZWPsWAM7wlEVzNFjxwk2UgLsUHETeCYO2M
	 zNeb8agFxjbOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF38380A955;
	Wed, 19 Nov 2025 03:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V3] net/mlx5: Clean up only new IRQ glue on
 request_irq()
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176352241025.205878.1321360381444626119.git-patchwork-notify@kernel.org>
Date: Wed, 19 Nov 2025 03:20:10 +0000
References: <1763381768-1234998-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1763381768-1234998-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 leonro@nvidia.com, cratiu@nvidia.com, moshe@nvidia.com,
 anand.a.khoje@oracle.com, elic@nvidia.com, jacob.e.keller@intel.com,
 manjunath.b.patil@oracle.com, pradyumn.rahar@oracle.com,
 qing.huang@oracle.com, rajesh.sivaramasubramaniom@oracle.com,
 rama.nichanamatlu@oracle.com, rohit.sajan.kumar@oracle.com, shayd@nvidia.com,
 mohith.k.kumar.thummaluru@oracle.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Nov 2025 14:16:08 +0200 you wrote:
> From: Pradyumn Rahar <pradyumn.rahar@oracle.com>
> 
> The mlx5_irq_alloc() function can inadvertently free the entire rmap
> and end up in a crash[1] when the other threads tries to access this,
> when request_irq() fails due to exhausted IRQ vectors. This commit
> modifies the cleanup to remove only the specific IRQ mapping that was
> just added.
> 
> [...]

Here is the summary with links:
  - [net,V3] net/mlx5: Clean up only new IRQ glue on request_irq() failure
    https://git.kernel.org/netdev/net/c/d47515af6ccc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



