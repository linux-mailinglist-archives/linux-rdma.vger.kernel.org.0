Return-Path: <linux-rdma+bounces-15581-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7889BD2417E
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jan 2026 12:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 342FA3007D86
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jan 2026 11:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F64374178;
	Thu, 15 Jan 2026 11:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDLhYB2S"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C03D18AFD;
	Thu, 15 Jan 2026 11:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768475619; cv=none; b=JVRmyrJdXcRNLRdMzBpoU0pr4veta3Syl4qPwUtU7kIK8U5cdlFVwZHp3FVpiGYIlBdLbCdOwcqhcBp7TNT32MmLmYYGlQQq3Ws7ig4cVP1HNWXfbULJLKXo7L/3879mV71xIENfPEWCWcUZMHeIk9zIw9PLijtWdQrzu6Z5oMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768475619; c=relaxed/simple;
	bh=lrOWhi0ZXiQSDbUZ2b/clYrZAbRkQ08r0GnFK8TGVb8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cvt9cfpt36nC56d1IfnorQIEJA0P4ulo4jHDWhcWJjFC69WxsRldatRb7sdQFjlsT7I3H0x8oAy91qXjnzzdb18cKurVTuaa94cvjU2STNFJPE3MR4FEHnIVwqoN8eRFFvHGEdeoyqmaww/FIcLhuWQQjVMvjsf4JvhdBFA0FGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDLhYB2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22279C116D0;
	Thu, 15 Jan 2026 11:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768475619;
	bh=lrOWhi0ZXiQSDbUZ2b/clYrZAbRkQ08r0GnFK8TGVb8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nDLhYB2SDUO6m6G7cSvDixR73wwMqFgEm6Drs8feOzMxK7HM7huSDE9dCpapCL6DT
	 mGSLDdJOedYJQDPa+sZnpT2xo0txxml1MWiCpSKrh7o37MtvZzWBFItGl2cIa2qENR
	 /d778umFekRWiuvjRr97dOIdTfpQSVQQOca5xkBmQyICSHYtFSPnp//1rlo2a4YrBc
	 RzNRp3rDM3SvSF2WzpJBUBLNf7iDJK+79JEYBuFWSRHSobQdy3GzbgNt3WXOT2phlw
	 tu7UUal44+T6On1Xdgvz1br+Zoz1h+YVGCPHH+QmvWc4EOgIvo1nS6L2TrGtWtfGHf
	 au/Ts5IB9qAMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id A44943809A3D;
	Thu, 15 Jan 2026 11:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V2 0/3] Introduce and use netif_xmit_timeout_ms()
 helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176847541141.3946378.12441502657710309903.git-patchwork-notify@kernel.org>
Date: Thu, 15 Jan 2026 11:10:11 +0000
References: <1768209383-1546791-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1768209383-1546791-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, shenjian15@huawei.com,
 salil.mehta@huawei.com, shaojijie@huawei.com, saeedm@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, gal@nvidia.com,
 moshe@nvidia.com, shshitrit@nvidia.com, ychemla@nvidia.com, jhs@mojatatu.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 12 Jan 2026 11:16:20 +0200 you wrote:
> Hi,
> 
> This is V2, find V1 here:
> https://lore.kernel.org/all/1764054776-1308696-1-git-send-email-tariqt@nvidia.com/
> 
> This series by Shahar introduces a new helper function
> netif_xmit_timeout_ms() to check if a TX queue has timed out and report
> the timeout duration.
> It also encapsulates the check for whether the TX queue is stopped.
> 
> [...]

Here is the summary with links:
  - [net-next,V2,1/3] net: Introduce netif_xmit_timeout_ms() helper
    https://git.kernel.org/netdev/net-next/c/cfbc8b6babf2
  - [net-next,V2,2/3] net: hns3: Use netif_xmit_timeout_ms() helper
    https://git.kernel.org/netdev/net-next/c/3ae02d659773
  - [net-next,V2,3/3] net/mlx5e: Refine TX timeout handling to skip non-timed-out SQ
    https://git.kernel.org/netdev/net-next/c/b0ba734516d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



