Return-Path: <linux-rdma+bounces-10778-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E32AC5EC1
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 03:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 231FE3B2A61
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 01:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0206E1EF38C;
	Wed, 28 May 2025 01:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsX4TH5j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65CF1EE7BE;
	Wed, 28 May 2025 01:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748395219; cv=none; b=Ejrk/wRTx9Aw9t/Z6Nmtg4/py2ekEk/dSiJB3jDUR/zO4/YD2RyWrQXKwTQeoVNjhnIxKdgJ47bBGHmcRYKnuyvkxb7QqhfUPR7tvmyuApwIIdR96siHUCYq9krxAiS14QBjNDY7dLVbDJDHry2YGwP+aKYrVJRL7qb3frZgDP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748395219; c=relaxed/simple;
	bh=tf2eN1NSxXBp6thc/aiZCb1w13OZWvzEQmOaH9edm08=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ntko+ekA7GkadG70wDsDMdvNcK0U5T6Q4bHt+t6Gugb5mRm7V5cpmVzhp1p1TdkUBpewrIF6wlB2MWgYtFUrfuVHrJA/13sP8/5Ia+s9T57QzqSNC8DuM80KlnA3CMaBNJ4UaGcpSRniEsQjlJnb/jcsNmZqpgpawbiVpLUvhQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsX4TH5j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863F2C4CEE9;
	Wed, 28 May 2025 01:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748395219;
	bh=tf2eN1NSxXBp6thc/aiZCb1w13OZWvzEQmOaH9edm08=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KsX4TH5j8FUJxyS2DmLQri4ddYJbAabtM4RmcvD7ptMhNvnDQvWr+hSzz/xHIG0H9
	 QC+H3MzwLdWa7p2kGak3jwC5/VP9tK6gHm6qI1bHCtcSvzvCGJEC1qZtlaAxPP0NGy
	 DdblQoHmzyJHZPywVgL3y3EqecKfy2gZhKOdJl8KrgKiD4qJVbZP7Johw7Y7Z8mpVF
	 lLpOCnV9mWf6aX4sRrWnTB60iXWVwmhXOPxmje0OlBo3CwWnHy+33Ni7bAMOmzXEYr
	 7kvYNIIZYwO3EP5Nge+5CZjEMhI8r16BkvWUHtC3lEF/V3BRbjKVGNssNazHVwcF+n
	 9fDB5u093+MGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD05380AAE2;
	Wed, 28 May 2025 01:20:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/mlx5: HWS, Fix an error code in
 mlx5hws_bwc_rule_create_complex()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174839525349.1849945.8234116859810090724.git-patchwork-notify@kernel.org>
Date: Wed, 28 May 2025 01:20:53 +0000
References: <aDCbjNcquNC68Hyj@stanley.mountain>
In-Reply-To: <aDCbjNcquNC68Hyj@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: kliteyn@nvidia.com, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, cratiu@nvidia.com, mbloch@nvidia.com,
 vdogaru@nvidia.com, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 May 2025 19:00:12 +0300 you wrote:
> This was intended to be negative -ENOMEM but the '-' character was left
> off accidentally.  This typo doesn't affect runtime because the caller
> treats all non-zero returns the same.
> 
> Fixes: 17e0accac577 ("net/mlx5: HWS, support complex matchers")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net/mlx5: HWS, Fix an error code in mlx5hws_bwc_rule_create_complex()
    https://git.kernel.org/netdev/net-next/c/a540ee75945a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



