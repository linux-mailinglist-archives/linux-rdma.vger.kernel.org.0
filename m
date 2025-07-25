Return-Path: <linux-rdma+bounces-12485-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB630B12394
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jul 2025 20:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE01C54763B
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jul 2025 18:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D422F0047;
	Fri, 25 Jul 2025 18:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JI2ioduS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2205B2F003A;
	Fri, 25 Jul 2025 18:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753466997; cv=none; b=ZvfwY6j4aQsU3zmukMSYw4uJA0AYt8Gw+pxByZyXuHKARSp4LN9gRPbF+2krGagE1Al1kbUY4zKHxrDmaBvgfUYaklMZJRYYt4yxUv8mAxBpqbJOcHRJMGIhyeAmYvriaSJ8SK+Z7tQuYvv1y88hcLRjqFP/SvPWotZ1hqCOanw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753466997; c=relaxed/simple;
	bh=Laml1HlQJoAWNJtRlKHNmyqy8H0av5BgGSav64V2zQw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lkis/ePyEpjp/S+fKVJ1aRajk6yqTb5S9+LL22yqaMV7ul8rDQvY96Hr3xXtZSPwFfdPPGH+QqowiRYGMWHNHcbCQVSx7TQjeiqcjpzuQxQY9fLuyiv4Ra5CPgDHokX1AHFUKIhqayU1cYWHZZRYnx/IWNinpnWVINs13hl/WFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JI2ioduS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10E9C4CEF4;
	Fri, 25 Jul 2025 18:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753466995;
	bh=Laml1HlQJoAWNJtRlKHNmyqy8H0av5BgGSav64V2zQw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JI2ioduSLpO4AgNC9vCX+3JnnTncsnwSiFBrJXJXuXblA/qVWvNUJ9ACeumqzViSO
	 H5m46bEsO2Hbcw89sPZaHZVKQbGLndoXwJzin8dQv0DARi+dQY8PHN35+C03YDCWD4
	 Q4RfWwvBMKjo4pSvD9GcMxxugeWxl1bafT2WSLzpGxeUOwMWU1J+ZX0PPtsamtC/fd
	 kIqaujYc/ieRtFnW8/3BFs3Zwk/SZuBVAeV+SgW7pPSJxPUa58EkVLa012LjL3re9t
	 VD3IBQtVYa0v1zbakmQzwQXOzENHlFlwUzQ7ETVJ8vGKA9IXYML/Xvl3LHbkZ+EYNR
	 jXVozJe8qymXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C29383BF5B;
	Fri, 25 Jul 2025 18:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] mlx5e misc fixes 2025-07-23
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175346701324.3223523.11413105271220735975.git-patchwork-notify@kernel.org>
Date: Fri, 25 Jul 2025 18:10:13 +0000
References: <1753256672-337784-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1753256672-337784-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Jul 2025 10:44:29 +0300 you wrote:
> Hi,
> 
> This small patchset provides misc bug fixes from the team to the mlx5e
> driver.
> 
> Thanks,
> Tariq.
> 
> [...]

Here is the summary with links:
  - [net,1/3] net/mlx5e: Clear Read-Only port buffer size in PBMC before update
    https://git.kernel.org/netdev/net/c/fd4b97246a23
  - [net,2/3] net/mlx5e: Remove skb secpath if xfrm state is not found
    https://git.kernel.org/netdev/net/c/6d19c44b5c6d
  - [net,3/3] net/mlx5e: Fix potential deadlock by deferring RX timeout recovery
    https://git.kernel.org/netdev/net/c/e80d65561571

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



