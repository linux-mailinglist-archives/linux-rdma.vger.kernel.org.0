Return-Path: <linux-rdma+bounces-2225-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B41278BA4F9
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 03:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A58A1F22460
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 01:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23C1125C9;
	Fri,  3 May 2024 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+/SUTZA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69396E556;
	Fri,  3 May 2024 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714700429; cv=none; b=JgJdnbRYhnTMebZfuvxWE2+vnf6jXBL+4SE1jvKaPGd6oQQEp6JNN6KIqQNvk9+gFNXanQBYvAdMX7C4SaQXjaDpyhL7DE7H+XjpLRQVdUUvB+F3X2KwmG/TOIqmQJ+Dv2O3olMEHxQDaQvg5PlO4SxjnZHcGrvtbBUEjMVLx68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714700429; c=relaxed/simple;
	bh=APb8kPNe4Hg1SPW8kYNVM5C42jOxnKGFjcGj9GeVUdw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CbfJCxElx3SLc1lK815DOaeCW7JbQoINpyfyWjZNNUuwoB8LLXNK8KOIB9dzAFwxhxRPHmnI/7kjJMPJhhYtT+y5t6/zWL3huKha4hFLCfC3e3h1Fmzpuj3Fg+gy6vbIcH3gp4KcjrKxQx1Wp9kszP5affY7UKYsAhaBJKltvT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+/SUTZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1132BC4AF1C;
	Fri,  3 May 2024 01:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714700429;
	bh=APb8kPNe4Hg1SPW8kYNVM5C42jOxnKGFjcGj9GeVUdw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F+/SUTZAUlmmE5JAdyzW7f/nVZlsiR6zLrhUmNbcPI2goVXR3moqhcYu+G8akZ0iT
	 Z41T1PiT/WVO0Tbe+TOi9tkcs4D3/m2DwSMdwHV1KjwCKzOopoodnirjLVfdXVyNfJ
	 pkBpC61CSQWs5+ZlkbJ/8jwrbKvksco6COy3xgzwv5URemyL5JWO3R0/dy6LNS3g/W
	 x94R9U5cOS/dTJBYuccn6MjFWd1NUwClV/1jsBIi8REBnYozYjypMDep4ykBCwNM8j
	 bdV2AmecaK3yXZEN+V2JuHZKaSxcEybPo9Cga6dE6BgvwBcrNKUdF+pKkiBNk2YtYI
	 uO0wIN5122uJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED771C4333E;
	Fri,  3 May 2024 01:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND net-next v5] IB/hfi1: allocate dummy net_device
 dynamically
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171470042896.13840.3413595720317631413.git-patchwork-notify@kernel.org>
Date: Fri, 03 May 2024 01:40:28 +0000
References: <20240430162213.746492-1-leitao@debian.org>
In-Reply-To: <20240430162213.746492-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
 leon@kernel.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Apr 2024 09:22:11 -0700 you wrote:
> Embedding net_device into structures prohibits the usage of flexible
> arrays in the net_device structure. For more details, see the discussion
> at [1].
> 
> Un-embed the net_device from struct hfi1_netdev_rx by converting it
> into a pointer. Then use the leverage alloc_netdev() to allocate the
> net_device object at hfi1_alloc_rx().
> 
> [...]

Here is the summary with links:
  - [RESEND,net-next,v5] IB/hfi1: allocate dummy net_device dynamically
    https://git.kernel.org/netdev/net-next/c/1c8f43f477d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



