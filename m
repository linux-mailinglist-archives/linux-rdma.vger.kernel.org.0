Return-Path: <linux-rdma+bounces-14776-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7989CC87A04
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Nov 2025 01:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 250A5353E01
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Nov 2025 00:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994C32F3611;
	Wed, 26 Nov 2025 00:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIAQVN+E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C69B189F20;
	Wed, 26 Nov 2025 00:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764118244; cv=none; b=lEAK04PddEf60REQa8y6Jk5vX+iwCJ8YmPvP0RU3pQG/TSm6ju0QKcxOcVg5nTKbTMQlrmuN19qbaprDhBX2HOL+GRTwqs7YU9td29MmXS5tsh48VeFCYqZmYTMGUcI8llAht55P+AjXu4uTcfREffJPbw8wbAFfzn5gwM9HhIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764118244; c=relaxed/simple;
	bh=IGG/k9VEnN2vUXPkStO/Qf5dnnQWnJmhlvvuRgu4Z/w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E9yxtxujrlv1Vji09t+aqc37dyh5COLsz37tJNnGZ7GSsGiv+8SypiDTVLbgmkocs0aSxux+zQz78FtOHpG3JNiSGsdrK7X1FbXWeV+mxdgZbIB6j73dbtcX84Mix6jTP4UxSH1u4brjvcuzLm/DDY5EQpD/I1x6HjpDDscC0Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIAQVN+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B747BC4CEF1;
	Wed, 26 Nov 2025 00:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764118243;
	bh=IGG/k9VEnN2vUXPkStO/Qf5dnnQWnJmhlvvuRgu4Z/w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YIAQVN+EOCCGCRHjs21hEALOQ3D1uJir4A2oUbmZpfYW4Cq2GxTgkk19QicohEzMm
	 wXdzJ6U+zxF32COBa8X2PcJJvvS4vybc8QvuuaelHpPrYQWrxIuMLXyDieCuiSjlGm
	 ATyYhw8hatylrIlHRkL4o2YRG/jRdgA7ALjfwkr4uLR/0zPTHmcgVcMmtvHfcLp+z6
	 4UrnFx4gQ4cUOhNwI9cUMkNAAs6ITpiotAVV/E2m29JTIvxb4wdZSkrtGR7GnZ0GiW
	 7Xfng+9o/zFcfMInUPapL9zwzhDJow7SRbX741EOcgUzX0HHZSWH9TFlWtTzTeiqoa
	 2CezF1qpnKfjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E0D380AAE9;
	Wed, 26 Nov 2025 00:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/mlx5e: Fix validation logic in rate limiting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176411820601.971301.9105241183448628229.git-patchwork-notify@kernel.org>
Date: Wed, 26 Nov 2025 00:50:06 +0000
References: <20251124180043.2314428-1-dcostantino@meta.com>
In-Reply-To: <20251124180043.2314428-1-dcostantino@meta.com>
To: Danielle Costantino <dcostantino@meta.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, gal@nvidia.com,
 tariqt@nvidia.com, pabeni@redhat.com, saeedm@nvidia.com,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Nov 2025 10:00:43 -0800 you wrote:
> The rate limiting validation condition currently checks the output
> variable max_bw_value[i] instead of the input value
> maxrate->tc_maxrate[i]. This causes the validation to compare an
> uninitialized or stale value rather than the actual requested rate.
> 
> The condition should check the input rate to properly validate against
> the upper limit:
> 
> [...]

Here is the summary with links:
  - [net] net/mlx5e: Fix validation logic in rate limiting
    https://git.kernel.org/netdev/net/c/d2099d9f16db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



