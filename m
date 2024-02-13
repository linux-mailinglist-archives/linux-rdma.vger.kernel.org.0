Return-Path: <linux-rdma+bounces-1010-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E0985269F
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Feb 2024 02:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B645D2884DB
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Feb 2024 01:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1095822EF6;
	Tue, 13 Feb 2024 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euyajDF5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE35622EEF;
	Tue, 13 Feb 2024 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707786028; cv=none; b=DGFJk5r2RJXG53q+UXoCLIYHwMeAKiAnuL04OsdJ+O0zEssaZdcIecrXBtFTOJAHZ12pwqs4Ut96F9hysWuKTBrjJUQou5mX4ubXU34jLp6BfWABwIOX7YUkGHxpfClsIS6A/O9jV5axyfw3ORd/+DWYAFQhySpeGZFGpRkbT/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707786028; c=relaxed/simple;
	bh=DeFvXgMJs2jrx0WVg5vaFA6wFwnJT16WI3dFiDV1II8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ohBHuP4+ZKPhmMeWuY4kZu8WAnXO2s4Fta9UUVd4VP8iEZvxhsvrwZSzg4A82QvIZR4fhVFCd9Yvh91zoTERwpRKOl/zKZUBJFTYVYBQr0n1dszrm0kf4wXpEOorpmqD99RUX65yDq1vi1OEP33aAk9tQ8rTIiiwdOIZJF589Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euyajDF5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 459DDC43390;
	Tue, 13 Feb 2024 01:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707786028;
	bh=DeFvXgMJs2jrx0WVg5vaFA6wFwnJT16WI3dFiDV1II8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=euyajDF5ZFS+RfAZ6FaEqcrdr14EsVEsksM/wejI9WJ3J/SK2lNgsWH1gxjZwmMtt
	 yQ6UIK6S/shD5MrSw01AHoOyAEdWufWNLCccEWrvZFBI/BCRy0/oozDPgaTC3u6OT1
	 f46X2RfT7G7gZqw2cNjTQH4Z5+h8+UfVK7fFgxft0CWaJSty+UoX5jxIwWD6xs7WAo
	 3Sf/x7ctB+uqtbAgwi3TuxACE6hPeVwT8OnBTgALlg/oWtiZf3peu1euKO96d6km8J
	 NaQhvSneyASbl6k+zZzv76o9To4E5EJltS2MZ4XV4c6F4lNg/M9RIJNZSEXWFiPTZd
	 Bevy0zcYNIgLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B189D84BC6;
	Tue, 13 Feb 2024 01:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net/mlx5e: link NAPI instances to queues and IRQs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170778602817.24441.17425446527268970551.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 01:00:28 +0000
References: <20240209202312.30181-1-jdamato@fastly.com>
In-Reply-To: <20240209202312.30181-1-jdamato@fastly.com>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tariqt@nvidia.com,
 rrameshbabu@nvidia.com, saeedm@nvidia.com, leon@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, gal@nvidia.com, vadim.fedorenko@linux.dev,
 linux-rdma@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  9 Feb 2024 20:23:08 +0000 you wrote:
> Make mlx5 compatible with the newly added netlink queue GET APIs.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
> v3 -> v4:
>   - Use sq->netdev and sq->cq.napi to get the netdev and NAPI structures in
>     mlx5e_activate_txqsq and mlx5e_deactivate_txqsq as requested by Tariq
>     Toukan [1]
>   - Only set or unset NETDEV_QUEUE_TYPE_RX when the MLX5E_PTP_STATE_RX bit
>     is on in mlx5e_ptp_activate_channel and mlx5e_ptp_deactivate_channel as
>     requested by Rahul Rameshbabu [2]
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net/mlx5e: link NAPI instances to queues and IRQs
    https://git.kernel.org/netdev/net-next/c/f25e7b82635f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



