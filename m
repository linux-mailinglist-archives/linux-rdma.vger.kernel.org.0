Return-Path: <linux-rdma+bounces-11514-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AF0AE29DB
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Jun 2025 17:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C60174639
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Jun 2025 15:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2485721D3CD;
	Sat, 21 Jun 2025 15:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZ2ot+2g"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E3F21ABB1;
	Sat, 21 Jun 2025 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750519787; cv=none; b=qckKBhnUdmlBKtHOG+AR+gB03+A3V98/xUtX7F90vZr75+SC1VH0alvPPJfmnJRFjwLAiqoA/D2xb5SDTcTFwtDBo14J/Ip7baSyTMQUKtVMYwgG6qEJdbxWYdBhlASrQ10+Ngx+BUCghP1FYXsS2CXOwpkvE/vzTfTN1olGsAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750519787; c=relaxed/simple;
	bh=rzjydfOSLQH+xXfNYU5MJSXV5HgwBmNsKXpObnPBNto=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T/mLiCuw5AajqreTtSiepN0uhz3LtowWxrzfJbZRD4g/tm0VWvT/8o8/bZ3StGfJmbQJahkVlYenJSq/DeXrAqoSJbQhjt6feU1mYSeyhPjnt+KqD2jXOL/lRkamvojCY5aT8ppQXqejmIwDGq+E/MsKQ/hoX3iWsd3Iqp7Y3ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZ2ot+2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4F5C4CEEE;
	Sat, 21 Jun 2025 15:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750519787;
	bh=rzjydfOSLQH+xXfNYU5MJSXV5HgwBmNsKXpObnPBNto=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SZ2ot+2gsZ9mGgDbe2AWQRPX8LrFkmdQVeVUd30TFFBPAxhdRg6iTm5DzABpVz6sC
	 42zr4GgVU9BlZrAEVCUZKDIJWgtB5QhRou3Xql/+Unr51VmzOsbw4ARxGTtAywtTz3
	 BWfItMlAQstvFXVIVnLD6AzpdhXJgGBYDZ7eJ+hGTrbvgPTCGJXwfN8FuWUe31Ys32
	 AzLq+9wdxoZJpXN79EnZU9omFY1JVi0oijhvf50lsLWPhPSjJT3gRNSZ6UIYt1gh6r
	 T12RAzbDKgymqvPEOhA2CQu0+xIXu/SMGukhvLKO0rkp4/WBAvbcKS5P0rcibR54oD
	 w3CdspeIhSW7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EED38111DD;
	Sat, 21 Jun 2025 15:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/smc: remove unused function
 smc_lo_supports_v2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175051981474.1884019.7334590250896024661.git-patchwork-notify@kernel.org>
Date: Sat, 21 Jun 2025 15:30:14 +0000
References: <20250619030854.1536676-1-wangliang74@huawei.com>
In-Reply-To: <20250619030854.1536676-1-wangliang74@huawei.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 yuehaibing@huawei.com, zhangchangzhong@huawei.com,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Jun 2025 11:08:54 +0800 you wrote:
> The smcd_ops->supports_v2 is only called in smcd_register_dev(), which
> calls function smcd_supports_v2 for ism. For loopback-ism, function
> smc_lo_supports_v2 is unused, remove it.
> 
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>  net/smc/smc_loopback.c | 6 ------
>  1 file changed, 6 deletions(-)

Here is the summary with links:
  - [net-next] net/smc: remove unused function smc_lo_supports_v2
    https://git.kernel.org/netdev/net-next/c/091d019adce0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



