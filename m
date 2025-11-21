Return-Path: <linux-rdma+bounces-14672-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A4DC7726D
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Nov 2025 04:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1386B4E6FC3
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Nov 2025 03:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A762EFD8C;
	Fri, 21 Nov 2025 03:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJjTAyST"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2C22EC55D;
	Fri, 21 Nov 2025 03:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763695250; cv=none; b=YKHaxDvk5Uk2NvuFapHInYDzSMO54HlwjzVp3TJRthvrz3farYU1JD/VNR6/QSLj2ON6YG5xD0cMvMzWX9NTcoiFHkbw9D63Lbq9VYNykFuLML04FI3Wa207FFRDv3aVBUYBWJn4ry+5Q+wu56j/oWHVPfojN9xVEwYRFMIsFcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763695250; c=relaxed/simple;
	bh=CJIKfc1Nqd88lRsKzRVjuHrSjJutSjzWzdhWad5u9Vs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Upk92gkzVA8f3Ul76K/iLr8VgL6CPyRHW3uwcSMXXh3gX9I4noxvr5ObX+fsvKGg4ar5rKmEJe8zKKCTfNX1XjxiVD1ZmIRwfV/QSAHQn/MxX5M8n5EyPDPhySYUdZuDmFqo8i7INh3epqASJNk81XTQnWwHkIO53B/D4wLJX4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJjTAyST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E505C116C6;
	Fri, 21 Nov 2025 03:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763695250;
	bh=CJIKfc1Nqd88lRsKzRVjuHrSjJutSjzWzdhWad5u9Vs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MJjTAySTaL4LZ254SCFBk62aiSvSeSIUldIUS3cQDv6VVzPM/EAyJDuntlFvWYYML
	 NlL19MUHmWq9niVOmYgmvSN41e3oi99u8qdvjPIdFN9vlQdwzSNJXZRbKLQ3MQjfTX
	 aMJmlQz8MluDEpqWpziDzqLQU/lEDDzB9lXpQAJyqbpvqVGQJQFAlGyDbW8wRyjtak
	 aqIhDLe+CENQrIqauX45U3jIAjpI2+SFzstqtEkJOpJkWR6evseawjJS+ztOPBFDEB
	 Gha0djlIt/pMu8k+113x1CzcsZH+hfDtNyoBRT196wNllVJPHlYz23lfBw1DeDUuuI
	 J2b0wzekzpRUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 345B53A41007;
	Fri, 21 Nov 2025 03:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/6] devlink: net/mlx5: implement
 swp_l4_csum_mode
 via devlink params
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176369521502.1881381.16790594395316376229.git-patchwork-notify@kernel.org>
Date: Fri, 21 Nov 2025 03:20:15 +0000
References: <20251119025038.651131-1-daniel.zahka@gmail.com>
In-Reply-To: <20251119025038.651131-1-daniel.zahka@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 schalla@marvell.com, bbhushan2@marvell.com, herbert@gondor.apana.org.au,
 brett.creeley@amd.com, andrew+netdev@lunn.ch, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, sgoutham@marvell.com, lcherian@marvell.com,
 gakula@marvell.com, jerinj@marvell.com, hkelam@marvell.com,
 sbhatta@marvell.com, tariqt@nvidia.com, saeedm@nvidia.com, leon@kernel.org,
 mbloch@nvidia.com, idosch@nvidia.com, petrm@nvidia.com, manishc@marvell.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, s-vadapalli@ti.com,
 rogerq@kernel.org, loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, olteanv@gmail.com,
 michal.swiatkowski@linux.intel.com, aleksandr.loktionov@intel.com,
 david.m.ertman@intel.com, vdumitrescu@nvidia.com, rmk+kernel@armlinux.org.uk,
 alexander.sverdlin@gmail.com, lorenzo@kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Nov 2025 18:50:30 -0800 you wrote:
> This series introduces a new devlink feature for querying param
> default values, and resetting params to their default values. This
> feature is then used to implement a new mlx5 driver param.
> 
> The series starts with two pure refactor patches: one that passes
> through the extack to devlink_param::get() implementations. And a
> second small refactor that prepares the netlink tlv handling code in
> the devlink_param::get() path to better handle default parameter
> values.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/6] devlink: pass extack through to devlink_param::get()
    https://git.kernel.org/netdev/net-next/c/011d133bb988
  - [net-next,v5,2/6] devlink: refactor devlink_nl_param_value_fill_one()
    https://git.kernel.org/netdev/net-next/c/17a42aa465c0
  - [net-next,v5,3/6] devlink: support default values for param-get and param-set
    https://git.kernel.org/netdev/net-next/c/2a367002ed32
  - [net-next,v5,4/6] net/mlx5: implement swp_l4_csum_mode via devlink params
    https://git.kernel.org/netdev/net-next/c/b11d358bf8c3
  - [net-next,v5,5/6] netdevsim: register a new devlink param with default value interface
    https://git.kernel.org/netdev/net-next/c/72924056ebac
  - [net-next,v5,6/6] selftest: netdevsim: test devlink default params
    https://git.kernel.org/netdev/net-next/c/8be656cfb931

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



