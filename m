Return-Path: <linux-rdma+bounces-5203-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECA698FB56
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 02:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C5428224A
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 00:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6581D1F56;
	Fri,  4 Oct 2024 00:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASYwYzhW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844971D14F8;
	Fri,  4 Oct 2024 00:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728000034; cv=none; b=Dr6M+TT1tHRO7hl3W/n793pxrLm8d6b2X2K6c0S4s8BX1xm0LILp/2pVygdcBOTq19w0RjnSk7dzCjlzKFRx1ow6lwc6wABziSeFweqoAIKn6EY4Qmt5gkhYrXPPEK7AZWl10Enxsnljwsazna1FECh4+6WGBBat/UmaS8JpsOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728000034; c=relaxed/simple;
	bh=FJgSz8Q0Gg2vj8ui2TV2ie76jXIudkVW9NQHhbjtFk0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GWvG7YvpOMcwJPjxv22z4kyT3h8cm39Eet96mPG4AYd1WapV5BCBnSvdu4dLTsVz3DrFT0R14xEAJypugPeFd3rx1UjRj0f8olYSfFf4t+dcxjdPvD0KyI1SjdsdIcfCGZcD/XbI9fj/HY7QRVGbaxBlHrSTb7YKUiDinAR8j48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASYwYzhW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069D9C4CEC5;
	Fri,  4 Oct 2024 00:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728000034;
	bh=FJgSz8Q0Gg2vj8ui2TV2ie76jXIudkVW9NQHhbjtFk0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ASYwYzhWxsWyZ5AuV17YmHdN2AB0fId1HuYaH+TKwYOgccZHq1NpmRLkJJWrHVH4o
	 Y+2ZnMIDGvSVKfH5VJvsAeaOSRdGwOfVXHdCH/6tXC01K9hLIDbpK3lgGHgeZK8lZw
	 xHkuQG9Lg1jGhApC3ZZxPP5UIkt8yocjGI7YHHuOVWDOZ0f6jd/SyXAkKwzgqDjXm1
	 hpdI7iArQdfKqowuJ89dHz7823OHZ99StVosgdO09F6x5g2PYfnoJNVvA4v5qGUz8P
	 xw7DuJiHJg11sBk/jhUqH9HsSzKJqrrosEf3RPSCJ/Npvj+qavWtP/5ITPVQKuJQTv
	 Hw0IkFdYa2N9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0193803263;
	Fri,  4 Oct 2024 00:00:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/rds: remove unused struct 'rds_ib_dereg_odp_mr'
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172800003749.2035955.1490460545040983997.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 00:00:37 +0000
References: <20240930134358.48647-1-linux@treblig.org>
In-Reply-To: <20240930134358.48647-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: allison.henderson@oracle.com, edumazet@google.com, kuba@kernel.org,
 linux-rdma@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 yanjun.zhu@linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Sep 2024 14:43:58 +0100 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'rds_ib_dereg_odp_mr' has been unused since the original
> commit 2eafa1746f17 ("net/rds: Handle ODP mr
> registration/unregistration").
> 
> Remove it.
> 
> [...]

Here is the summary with links:
  - [net-next] net/rds: remove unused struct 'rds_ib_dereg_odp_mr'
    https://git.kernel.org/netdev/net-next/c/25ba2a5adab2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



