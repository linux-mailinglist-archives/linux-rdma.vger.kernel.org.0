Return-Path: <linux-rdma+bounces-13184-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2392B4A598
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 10:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2523A5B05
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 08:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D88B253951;
	Tue,  9 Sep 2025 08:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lh3LvbTw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C66824EF76;
	Tue,  9 Sep 2025 08:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757407206; cv=none; b=mgXvmlBYTAoMBB39sTWUgAENGWU3e/k2xl1Oe9knNN2ZWbMuWp60X4jUJZUVfE9v1K5cVD1XnMBpcsyPSHSZMOA0+l0ZGLhDw1KKmQSqCS1ClkNdpft006Ght6tRBLU8GlipyBUkFg2JIli1p6UWYuxInyeMIngoDYSfE7HzQsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757407206; c=relaxed/simple;
	bh=0SXPnVWGEx+NQgbCUVyYI/dp+J4/4AoHcZZOFxntKrU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rftrm9NFaeJI71f1+DjvWEaGg0Np/dyUTTZqQGAtQAKFKCdO/LBcGkjTfj67nIUHUr/F7d8p3EIMVOnizyzQ7EkxccMze9B/4OjzxW3CG6+yMUVFQXLjUrZBYceQ9HAs7uk823iphWM6sgrIO6fudkk5OUlKl7Z3jVlEdir+Izs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lh3LvbTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E82C4CEF4;
	Tue,  9 Sep 2025 08:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757407206;
	bh=0SXPnVWGEx+NQgbCUVyYI/dp+J4/4AoHcZZOFxntKrU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Lh3LvbTwEkRxA1/pCm4VkVFiVEdEzYngpt4yAGJToMByizLq3Bgxm0UB4K6cFP92P
	 Z3eU4jB7XdqrlIYI4yKzt0OAGbCPxAaOIrFIVIyZ5Am0uIb8iW3ngOAyUGGXXnYIjF
	 T+qu52GMx69QIrc5NSXgbKLmatM2Fubd9n6R55RW3xYr/QcwVgaS8HqZDgoJJvgyJE
	 53DorZyziGbfO0LOc+8j/DD2wsIoe/hyUEGGEbjYWdPCeO5ARisfQgWZWnN3QmHYEm
	 Ps13f3BwhZgFTgrsi4eiAZ6yeC6y513ar3DV13I2xGKHtXgWnlTd6XJgg1DQjMqBw2
	 UZn8980N8UiBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC8F383BF69;
	Tue,  9 Sep 2025 08:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V2 0/3] Support exposing raw cycle counters in
 PTP
 and mlx5
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175740720950.574960.2387950388692390401.git-patchwork-notify@kernel.org>
Date: Tue, 09 Sep 2025 08:40:09 +0000
References: <1755008228-88881-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1755008228-88881-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, richardcochran@gmail.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, gal@nvidia.com, tglx@linutronix.de,
 cjubran@nvidia.com, vladimir.oltean@nxp.com, dtatulea@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 12 Aug 2025 17:17:05 +0300 you wrote:
> Hi,
> 
> This series by Carolina adds support in ptp and usage in mlx5 for
> exposing the raw free-running cycle counter of PTP hardware clocks.
> 
> This is V2. Find previous one here:
> https://lore.kernel.org/all/1752556533-39218-1-git-send-email-tariqt@nvidia.com/
> 
> [...]

Here is the summary with links:
  - [net-next,V2,1/3] ptp: Add ioctl commands to expose raw cycle counter values
    https://git.kernel.org/netdev/net-next/c/faf23f54d366
  - [net-next,V2,2/3] net/mlx5: Extract MTCTR register read logic into helper function
    https://git.kernel.org/netdev/net-next/c/96c345c3c54c
  - [net-next,V2,3/3] net/mlx5: Support getcyclesx and getcrosscycles
    https://git.kernel.org/netdev/net-next/c/a3fb485505ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



