Return-Path: <linux-rdma+bounces-9533-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A32B0A92FC6
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 04:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9702447726
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 02:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D22267737;
	Fri, 18 Apr 2025 02:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wv1nb967"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BB12676D9;
	Fri, 18 Apr 2025 02:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744942204; cv=none; b=Ux0o6XpHOs7ZIdwaV/mOa/MBIuSWYN9kUOgDrqzFdOhPHlRie7ByWISR9EV/grEWuouG5IQEVwvKwf4SpKcQuzsiv4XonukqZvmU7CaL8MfrQGSzRgvdbHnMvcbcCcCFi2eDHiBVYn5o/TfkXgXDigTTKlEaWj2XhBMucOMstTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744942204; c=relaxed/simple;
	bh=PpRacgllJKUtEyNh7DV2tgxWNcLsd+Hr9ZdJP3sEvco=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GY8QnMTZHjeGOn3IZ0pMotVRGgTkDVQOpnN5g6AGqQ194ofPa2ux8JK57MFXA3vV4i0Sn3BZURoqzCmJzqti61vjgkIBiU8K3vI9ND/LbB9mmFKG+ASu9qt+Yv8K7FiWya8Mwqhy+92I+RSNdBX3Xe+ST7SiZDs/1fwC2fuQF1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wv1nb967; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE02C4CEE4;
	Fri, 18 Apr 2025 02:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744942204;
	bh=PpRacgllJKUtEyNh7DV2tgxWNcLsd+Hr9ZdJP3sEvco=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Wv1nb967t2rvT83vym2pcqWeKrWtIOY73KhHtf6cYuY5JD5b3sAFQB2oIyvd/jWZc
	 ANv9AOaSkje8WEHMkzKT+jLBZ/X9UrUFA0XYEIN+S1zfUNckMJU52pmSyGktceYfvT
	 xvPlegrWctHJD1sEK06ktBQTdIDV9DEp2f6KJryfnahQgEYv/3lb2eI/l/WLuMhRaQ
	 S5lP7jnCOfZxSDq1g8TpGmtcOHwmlx6ag2zRa3vXZklaAoSfbVd8pOm/DhQnrguL33
	 lnI59at69bkx71CpXPmdXpamz0sW02u+IXrNVo6aig5bITYPFkv8+NYmJjPiyitVgD
	 t64t2xFQZgBVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC9D380AAEB;
	Fri, 18 Apr 2025 02:10:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/mlx5e: ethtool: Fix formatting of
 ptp_rq0_csum_complete_tail_slow
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174494224231.79616.3135067905524243512.git-patchwork-notify@kernel.org>
Date: Fri, 18 Apr 2025 02:10:42 +0000
References: <20250416020109.work.297-kees@kernel.org>
In-Reply-To: <20250416020109.work.297-kees@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Apr 2025 19:01:14 -0700 you wrote:
> The new GCC 15 warning -Wunterminated-string-initialization reports:
> 
> In file included from drivers/net/ethernet/mellanox/mlx5/core/en.h:55,
>                  from drivers/net/ethernet/mellanox/mlx5/core/en_stats.c:34:
> drivers/net/ethernet/mellanox/mlx5/core/en_stats.h:57:46: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (33 chars into 32 available) [-Wunterminated-string-initialization]
>    57 | #define MLX5E_DECLARE_PTP_RQ_STAT(type, fld) "ptp_rq%d_"#fld, offsetof(type, fld)
>       |                                              ^~~~~~~~~~~
> drivers/net/ethernet/mellanox/mlx5/core/en_stats.c:2279:11: note: in expansion of macro 'MLX5E_DECLARE_PTP_RQ_STAT'
>  2279 |         { MLX5E_DECLARE_PTP_RQ_STAT(struct mlx5e_rq_stats, csum_complete_tail_slow) },
>       |           ^~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - net/mlx5e: ethtool: Fix formatting of ptp_rq0_csum_complete_tail_slow
    https://git.kernel.org/netdev/net-next/c/cfba1d1b61ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



