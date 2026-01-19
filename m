Return-Path: <linux-rdma+bounces-15733-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C62D3B8F2
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jan 2026 22:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACCEA302280C
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jan 2026 21:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A382F2F6577;
	Mon, 19 Jan 2026 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STl1syTV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EC422652D;
	Mon, 19 Jan 2026 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856413; cv=none; b=YuGNjCeHJk0UTk77EQwG6jj8IHfdeRowhWOUtiQelgvqMlj0wMzvtYkdm79EuE6PfgelX4qvFnIuIZdB0eB1gEedGbWc7sgne+YMy9R8YrTfHib9ExWVvUetiTq0sa6b9i+Sl6gnIdelKa1q7clTuzaVCxgbkpNN7TlVbwxbD1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856413; c=relaxed/simple;
	bh=+24jvhpXOiiRVmskVzSHPuyS9zeJd1ku13wxtjJblfo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ItBHoI8jbKKNIViPhgZMOxb4p2xlT1SJAldDbxX+o5NpaehoMe315dnteRO4GSWCuuQoQnFT585KKR1nGTLX5s7KtYxGHBcCYX7qJFH5TsmlIBdT2OxrBW5mo7JtxcsKx7DIYQsMh21OGembN5BBA1nTNgacVe2+s9Tck6d0sTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STl1syTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCB7C116C6;
	Mon, 19 Jan 2026 21:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768856412;
	bh=+24jvhpXOiiRVmskVzSHPuyS9zeJd1ku13wxtjJblfo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=STl1syTVgj3phWlYj+9hg4eQJC6wfHTbdBkd9KK/wZdlwd6Z5DqbefsSNBtPCUJEx
	 eFvqdKgYZmvkuAuwCqtxI34KIuXCZPJQ3O3wbGzb97/k0V4WEkdo4472MlabsOkTCd
	 3IA7EbMk48e5nzlnGh1C7vgwmutrlkUJ3rJ8ydN8Vat9nI0N2hRU5MLjP6Vhmktsey
	 YbxkvzacrHists6lGo5LiDLb+L96clREjPR/RHDt+RSsWwPUFXnnkReW9xbxY9F8xG
	 qOgwD1PnbSBUHIT+3bYPkJONkT/QxVRrW62rpRr+8Gfpfm+ceAHff73qkThQyGkaJI
	 dQ6+5H12anBRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 01FF03806907;
	Mon, 19 Jan 2026 21:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V2 0/4] net/mlx5e: Save per-channel async ICOSQ
 in
 default
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176885641079.136413.11790985486873558102.git-patchwork-notify@kernel.org>
Date: Mon, 19 Jan 2026 21:00:10 +0000
References: <1768376800-1607672-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1768376800-1607672-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 witu@nvidia.com, toke@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Jan 2026 09:46:36 +0200 you wrote:
> Hi,
> 
> This is V2, find V1 here:
> https://lore.kernel.org/all/1762939749-1165658-1-git-send-email-tariqt@nvidia.com/
> 
> This series by William reduces the default number of SQs in a channel
> from 3 down to 2, by not creating the async ICOSQ (asynchronous
> internal-communication-operations send-queue).
> 
> [...]

Here is the summary with links:
  - [net-next,V2,1/4] net/mlx5e: Move async ICOSQ lock into ICOSQ struct
    https://git.kernel.org/netdev/net-next/c/ea945f4f3991
  - [net-next,V2,2/4] net/mlx5e: Use regular ICOSQ for triggering NAPI
    https://git.kernel.org/netdev/net-next/c/56aca3e0f730
  - [net-next,V2,3/4] net/mlx5e: Move async ICOSQ to dynamic allocation
    https://git.kernel.org/netdev/net-next/c/1b080bd74840
  - [net-next,V2,4/4] net/mlx5e: Conditionally create async ICOSQ
    https://git.kernel.org/netdev/net-next/c/abed42f9cd80

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



