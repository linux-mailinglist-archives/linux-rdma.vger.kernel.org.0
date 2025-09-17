Return-Path: <linux-rdma+bounces-13432-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4749B7D81F
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 14:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7994C1685A3
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 00:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01F81E7C27;
	Wed, 17 Sep 2025 00:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjMKnxuk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCE21D5154;
	Wed, 17 Sep 2025 00:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758069618; cv=none; b=CEnPhZ55O+tk8fReUGNVgF5qGDIpjddkCGo/p3pP239U3MmmRt2zaVmYKXZajjr1Sh+XbQXKyKMDnw6k4s/iXEI19jIXrXa1qouYPeXRa1koG4Di3yzjfjuVv17AhAtw7lDXdeAkNqJDKUkZCUKA4LIbuAqw19qhNr5Ahv+khjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758069618; c=relaxed/simple;
	bh=lI7PrmrMSWJqPMm3/ESEmX4G7a4Ta4Fz95qEalWdt9w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t/8KYBSXq165d9CG2q9hMBgh5qC2xvLZbYDKlz95n6FsSBEzSr9rj95dYI5dHHGB8vLCKb+ROZFD1zxd+zmnkCYCtHaPcUcgRhuy5CX3ByEKy3n0CpJ16/MSROm3K6Ex5lG9TpfJo0+VpuGww8xLBjth3zqg1uIcW4OCeKOqdSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjMKnxuk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0FEC4CEF9;
	Wed, 17 Sep 2025 00:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758069617;
	bh=lI7PrmrMSWJqPMm3/ESEmX4G7a4Ta4Fz95qEalWdt9w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mjMKnxukj89yKbZkLYQXy8PH14YzULZpgL9tWUYgoVB57I0xtMPVR3a4sceaCCtWG
	 7vaIBNmoThzh6DTIlYkpxIN7poNvv1OAtKfBE8DDNmxkSTAcaVuXKDPJpxopsVNtLZ
	 Mnar9gHyudAxWw3nHjMNliaqKaQCBuD6ZTa26WbQ7iPaq2ZNJ5RSg0dYDHq3HF4xH8
	 b2wvXEQjAgVAZGrl8+vqxdwNtQKsFlFMUbZRq8w4IOPc8WFK9zbGTC2NmacfZnWyBn
	 Mu34eAcb9a68EbtbIVuJemnsqehMjnL1eUudK8iQXnqL6JepeHNpDf8qXeXMTTvHFp
	 sGuJLn5YfEEAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E4739D0C1A;
	Wed, 17 Sep 2025 00:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V2 0/4] net/mlx5: Refactor devcom and add net
 namespace support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175806961898.1416090.3647009458377785354.git-patchwork-notify@kernel.org>
Date: Wed, 17 Sep 2025 00:40:18 +0000
References: <1757940070-618661-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1757940070-618661-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 parav@nvidia.com, shayd@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Sep 2025 15:41:06 +0300 you wrote:
> Hi,
> 
> This series by Shay improves the mlx5 devcom infrastructure by
> introducing a structured matching attribute interface, relocating
> certain devcom registration flows to more appropriate locations, and
> adding net namespace awareness to the devcom framework and its users.
> 
> [...]

Here is the summary with links:
  - [net-next,V2,1/4] net/mlx5: Refactor devcom to use match attributes
    https://git.kernel.org/netdev/net-next/c/f05a82fbcc64
  - [net-next,V2,2/4] net/mlx5: Lag, move devcom registration to LAG layer
    https://git.kernel.org/netdev/net-next/c/5a977b5833b7
  - [net-next,V2,3/4] net/mlx5: Add net namespace support to devcom
    https://git.kernel.org/netdev/net-next/c/95f73447c269
  - [net-next,V2,4/4] net/mlx5: Lag, add net namespace support
    https://git.kernel.org/netdev/net-next/c/d654d3fc2066

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



