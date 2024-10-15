Return-Path: <linux-rdma+bounces-5406-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DE299DB25
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2024 03:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2485A1C21160
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2024 01:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1BE14A60D;
	Tue, 15 Oct 2024 01:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQcyO9tx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38073BBF6;
	Tue, 15 Oct 2024 01:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728954632; cv=none; b=Tc08MVL4PYvWVkcEZCvzDxcF3CzqBBfcKCRk0cJzCYuOWfxDJUvv9bNVLM6D7NpsMHD17MpGdJ7gUCVGZb4xStoLSauGlYdXDhcGnEgfETM3wNygaK07ElOCqyT8482GzxaU3dTaeoNbQfVkfah1pvhsn0WPxx+hd1enRJ4E6M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728954632; c=relaxed/simple;
	bh=rVAgkhvYvFX2PSpXyOhsMPNCZ0R/2JRF6RV4qQPo9lw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D83PhVx0x2gnmJyWjB5E0mtc6G8w/UL2XLZtbr4dP2Plt+DnsUB4QfC3D5nCOXylgM/BBUc0sAu5Ty7qXXrCSr81MbHMzSwm3R4BN1yhA3D/C2eeRc9MYiuA7QQZnSUbp7VrAOy0yra9UEWjV6fwguObnl+shTz3KxhQBzkNUZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQcyO9tx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63710C4CEC3;
	Tue, 15 Oct 2024 01:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728954631;
	bh=rVAgkhvYvFX2PSpXyOhsMPNCZ0R/2JRF6RV4qQPo9lw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TQcyO9tx7sGkph8gD0p2y1qkrVqIIl8T6mDtLXWikymynriRzqHdQ9pWvlrVTrZ31
	 ewDVc8rXNJbEUomVxFSqQ2maMjmsRc1BFljrLaUsYr7L7or8JZ8B/iNrwg9dGkPte0
	 ajU4Sqbe+GWQrlYJCM4sYJO/h1ksHVaa4FY4xSd646gVUinpoWTbwo0QJJT5n6nQNE
	 2u2h4qnrTTroW4Q14iij3m52GmTVrNepA5VicXIqKHDgWOnFuPnpTYTIr3sxrg8++X
	 Q2RwH3QH9miTeHUiRRb4uESBR6iOhxP03uuTWdjRGoJMc719DZeytIb3KwR420mIW8
	 Z4Aeb0tG9luyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE12C3822E4C;
	Tue, 15 Oct 2024 01:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v6 0/9] Add support for per-NAPI config via netlink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172895463623.686374.12703675923446130811.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 01:10:36 +0000
References: <20241011184527.16393-1-jdamato@fastly.com>
In-Reply-To: <20241011184527.16393-1-jdamato@fastly.com>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com,
 sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
 edumazet@google.com, aleksander.lobakin@intel.com, leitao@debian.org,
 danielj@nvidia.com, dsahern@kernel.org, davem@davemloft.net,
 donald.hunter@gmail.com, kuba@kernel.org, hawk@kernel.org, jiri@resnulli.us,
 johannes.berg@intel.com, corbet@lwn.net, leon@kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, lorenzo@kernel.org, michael.chan@broadcom.com,
 almasrymina@google.com, pabeni@redhat.com, saeedm@nvidia.com,
 bigeasy@linutronix.de, tariqt@nvidia.com, xuanzhuo@linux.alibaba.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Oct 2024 18:44:55 +0000 you wrote:
> Greetings:
> 
> Welcome to v6. Minor changes from v5 [1], please see changelog below.
> 
> There were no explicit comments from reviewers on the call outs in my
> v5, so I'm retaining them from my previous cover letter just in case :)
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/9] net: napi: Make napi_defer_hard_irqs per-NAPI
    https://git.kernel.org/netdev/net-next/c/f15e3b3ddb9f
  - [net-next,v6,2/9] netdev-genl: Dump napi_defer_hard_irqs
    https://git.kernel.org/netdev/net-next/c/516010460011
  - [net-next,v6,3/9] net: napi: Make gro_flush_timeout per-NAPI
    https://git.kernel.org/netdev/net-next/c/acb8d4ed5661
  - [net-next,v6,4/9] netdev-genl: Dump gro_flush_timeout
    https://git.kernel.org/netdev/net-next/c/0137891e7457
  - [net-next,v6,5/9] net: napi: Add napi_config
    https://git.kernel.org/netdev/net-next/c/86e25f40aa1e
  - [net-next,v6,6/9] netdev-genl: Support setting per-NAPI config values
    https://git.kernel.org/netdev/net-next/c/1287c1ae0fc2
  - [net-next,v6,7/9] bnxt: Add support for persistent NAPI config
    https://git.kernel.org/netdev/net-next/c/419365227496
  - [net-next,v6,8/9] mlx5: Add support for persistent NAPI config
    https://git.kernel.org/netdev/net-next/c/2a3372cafe02
  - [net-next,v6,9/9] mlx4: Add support for persistent NAPI config to RX CQs
    https://git.kernel.org/netdev/net-next/c/c9191eaa7285

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



