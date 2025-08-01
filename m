Return-Path: <linux-rdma+bounces-12573-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CE1B188E1
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Aug 2025 23:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 167031C83656
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Aug 2025 21:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFBD28DB78;
	Fri,  1 Aug 2025 21:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWCDkr5y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D66220680;
	Fri,  1 Aug 2025 21:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754084395; cv=none; b=jqd4Qpnpkc/JihH2TL+0iFVMpidGE7Jct96nxeyf5GFKygSRTCfztLna5oOTN+Z/NZniylgQhgCDXToT14GHBveZ89y7CpIUU3KXGKiZjIAy4lr8En3TpDl54TO70Gn5WQUK1Z79aN0dOQ9II3MxpQpo6jI23FiruT3z0JTqw8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754084395; c=relaxed/simple;
	bh=gU6AkxBeU6Ey08y46Gg6l6o4z/dGQiCsh8KIZLUBQds=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gB3stLZ25eCSCozpYZv7oWZczilbfAeVACPmJZoj56MUwzCXJfEXOd9T+bn0wtHIXy6eFGpkMpPa/1D3saH7S4J/VaZ/He9WjEBfYEiC/Ku1GYnyDrctGpyEYx5kB6PJyeny5vhqsb6XGx+xw31isS+PUqHnK34BKeVpqQ4Bk/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWCDkr5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F37C4CEE7;
	Fri,  1 Aug 2025 21:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754084395;
	bh=gU6AkxBeU6Ey08y46Gg6l6o4z/dGQiCsh8KIZLUBQds=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MWCDkr5y4F8PAd1KfeK7b9DZULmjJ4jdLQjue0sRs+1AaI40WAA45hmjVYbRuVHZ8
	 bTKwF5DaUevPQ9G52y5CGAfh4Q1DgFR/1YiraRZievXHiq8TYftgmajzVlAawzJX/P
	 HKM9A3XvnO/LZ4mt7TpRScFfmRxG/rwGebBxk8ywjwzAOkP0DfaydErJ0qltdl6zWo
	 fu8n0ih9sliGO1tNGg2RBhNuH1Q4Ejsv+mtSAC1aF5C0+K4VkzhzqzKpqINO37V4zH
	 oVCZ8z9pGg6kR+UtFvcMabywZHB7bZx6DM+1gdUM0NYxSeg17XbLSPykWs1z04O0gk
	 IRKd/Q32+4RLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EDE383BF56;
	Fri,  1 Aug 2025 21:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/mlx5: Correctly set gso_segs when LRO is used
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175408441027.4089984.2960748466316299557.git-patchwork-notify@kernel.org>
Date: Fri, 01 Aug 2025 21:40:10 +0000
References: <20250729-mlx5_gso_segs-v1-1-b48c480c1c12@openai.com>
In-Reply-To: <20250729-mlx5_gso_segs-v1-1-b48c480c1c12@openai.com>
To: Christoph Paasch <cpaasch@openai.com>
Cc: saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, amirv@mellanox.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, gal@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Jul 2025 11:34:00 -0700 you wrote:
> From: Christoph Paasch <cpaasch@openai.com>
> 
> When gso_segs is left at 0, a number of assumptions will end up being
> incorrect throughout the stack.
> 
> For example, in the GRO-path, we set NAPI_GRO_CB()->count to gso_segs.
> So, if a non-LRO'ed packet followed by an LRO'ed packet is being
> processed in GRO, the first one will have NAPI_GRO_CB()->count set to 1 and
> the next one to 0 (in dev_gro_receive()).
> Since commit 531d0d32de3e
> ("net/mlx5: Correctly set gso_size when LRO is used")
> these packets will get merged (as their gso_size now matches).
> So, we end up in gro_complete() with NAPI_GRO_CB()->count == 1 and thus
> don't call inet_gro_complete(). Meaning, checksum-validation in
> tcp_checksum_complete() will fail with a "hw csum failure".
> 
> [...]

Here is the summary with links:
  - [net] net/mlx5: Correctly set gso_segs when LRO is used
    https://git.kernel.org/netdev/net/c/77bf1c55b2ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



