Return-Path: <linux-rdma+bounces-11749-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D207AED876
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 11:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17A953A54AE
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 09:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B44B23E358;
	Mon, 30 Jun 2025 09:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANBWgHI/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4052723C39A;
	Mon, 30 Jun 2025 09:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751275182; cv=none; b=dfT/RCBD/4G9enBKaHS3Ak+TnJZxsCW+UDZrBI0sqgoEhKXG3Y8i1qU31+R5sjEpU0oBeYr9mtvKXIx02z3sQRVjD+kCfbm7S2DmHthvkyRykF+5dtdBkVh2F0yqqGzfc/u19k0iTuHdWk25+a+dBi0FxvA8uf1kPO+VNn9gSQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751275182; c=relaxed/simple;
	bh=OaGFhytglZ8f3wf/FalzVY9HkEox8Uvz34SHduA0e50=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Tj6LFx10bUK6+kaZFVMpmyTgQrsfJ3yeLs817lO+CrboQCyrBG8+ms0sDAu2M60PdccbpkNz2xc0FRam7cxJp2BkjWvsKxRRLA3FQfof1e/BYIBSaJ9OfRyG7VWDO6P83+eXx+4ppLsNBJK+nG9T0vZG0EChuyIWjlF5s5m9oq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANBWgHI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36D5C4CEE3;
	Mon, 30 Jun 2025 09:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751275181;
	bh=OaGFhytglZ8f3wf/FalzVY9HkEox8Uvz34SHduA0e50=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ANBWgHI/r4OUflplYDYlTGpp+uLCHb0M5ibpUjRjWyK3PC8Dho7ZWoRL8XREVYBhx
	 5dUsV4im/PLWLzFrwIHQaM4qBFDf+y2gGFFg6ISuY4PJZoOuT+6f9q3T03o/JdfZI3
	 0zW9WJvP7laH2H58xyrTk2/dQg3a/KKP0pIfL2iNb07xmlLjrPOB1vdBlgRVW90eHS
	 /NzQuPKaM2FcpenHmIGvyEVEAzvQ07bsUtie8Gwf5VZKkdWc0m2woMyY7dxxsU9TBi
	 Vi6gAAa8njc754mFV1bwtXyfmJdbI160t8MJTwKLYdtL6fZI507yi1563QbeyUE4J5
	 f2jlMXReBdWJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DFC383BA00;
	Mon, 30 Jun 2025 09:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net/mlx5e: Fix error handling in RQ memory
 model
 registration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175127520701.3307680.6593592387964609243.git-patchwork-notify@kernel.org>
Date: Mon, 30 Jun 2025 09:20:07 +0000
References: <20250626053003.45807-1-wangfushuai@baidu.com>
In-Reply-To: <20250626053003.45807-1-wangfushuai@baidu.com>
To: Fushuai Wang <wangfushuai@baidu.com>
Cc: saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 yanjun.zhu@linux.dev, dtatulea@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 26 Jun 2025 13:30:03 +0800 you wrote:
> Currently when xdp_rxq_info_reg_mem_model() fails in the XSK path, the
> error handling incorrectly jumps to err_destroy_page_pool. While this
> may not cause errors, we should make it jump to the correct location.
> 
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Acked-by: Dragos Tatulea <dtatulea@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net/mlx5e: Fix error handling in RQ memory model registration
    https://git.kernel.org/netdev/net-next/c/7012d4f3c7a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



