Return-Path: <linux-rdma+bounces-9761-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D512A99E90
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Apr 2025 04:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CF5C7ADE2A
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Apr 2025 01:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253141F37C3;
	Thu, 24 Apr 2025 02:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p00vge3+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEC71E1E1C;
	Thu, 24 Apr 2025 02:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745460001; cv=none; b=PuA9o9OnOAZFHIGAHEU4xIprmlTh4ANH5oQx2Wxiia05Bd3r8w5a8vaElS38VKKXcMLerLTKMgzXJUEbtx7Vy5w+dBgtykPn/o8rU2J/wsqAI7FDyhOm4Jk7esQGyCprQZujpjnx5jp3z+Vx+qITQ+876B71zuc4r95ZjdAgyAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745460001; c=relaxed/simple;
	bh=7/55K0+vpUW12+5r1ow/V8WILVzRW6B3foMUi3Psn0c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LFm3FL+byi2u6UHEsB4WzwOpzur6zeF/nBZPQ+RvRLfKkYPZwQZlqUUqe7Sbru0CNqlSr70LxLvM7Ukc1fOjBpN2xBB9TzLE/gXorZEx8vBiImFtbBRJCSwrXgd9+VcK8G8V8mpI2BvxfXRnT5x2LKsH/7yWY3ChojOgSdUXi3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p00vge3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A575C4CEE2;
	Thu, 24 Apr 2025 02:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745460001;
	bh=7/55K0+vpUW12+5r1ow/V8WILVzRW6B3foMUi3Psn0c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p00vge3+zeKFnNSchG3Yi9mkePdZCi0cTffF3MhOX0oamDjEBDcW29FqSMzHCUoQZ
	 iDi4E39aKC9SzL85UAM0KtXYGk6fAUFNMh5e3I5vcJZxc4b5Mi/OD4gBTbWLE7ONDZ
	 qXPqMbIaQMep8PhWcIJklLPRRxZf9JKV5jaxmlYsB9JSs9WYP5cdXXJRYB3FIdwMon
	 9ooKNBh4iGfSC8d7h8ejKFf91qrG6hc13z/9tITZgsHbbBr1kqA9hjCuelWc42BKWO
	 oSbdCd+dNSsv+iQTMqbkddiPyM3hAH+Hb7WCj+9HPvZJPcsSu3M/lGevRsWq8sI6xf
	 nCyExc43zzP2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF9B380CED9;
	Thu, 24 Apr 2025 02:00:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net/mlx5: HWS, Improve IP version handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174546003948.2831734.1789243432503891447.git-patchwork-notify@kernel.org>
Date: Thu, 24 Apr 2025 02:00:39 +0000
References: <20250422092540.182091-1-mbloch@nvidia.com>
In-Reply-To: <20250422092540.182091-1-mbloch@nvidia.com>
To: Mark Bloch <mbloch@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 tariqt@nvidia.com, leon@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Apr 2025 12:25:37 +0300 you wrote:
> This small series hardens our checks against a single matcher containing
> rules that match on IPv4 and IPv6. This scenario is not supported by
> hardware steering and the implementation now signals this instead of
> failing silently.
> 
> Patches:
> * Patch 1 forbids a single definer to match on mixed IP versions for
>   source and destination address.
> * Patch 2 reproduces a couple of firmware checks: it forbids creating
>   a definer that matches on IP address without matching on IP version,
>   and also disallows matching on IPv6 addresses and the IPv4 IHL fields
>   in the same definer.
> * Patch 3 forbids mixing rules that match on IPv4 and IPv6 addresses in
>   the same matcher. The underlying definer mechanism does not support
>   that.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net/mlx5: HWS, Fix IP version decision
    https://git.kernel.org/netdev/net-next/c/5f2f8d8b6800
  - [net-next,2/3] net/mlx5: HWS, Harden IP version definer checks
    https://git.kernel.org/netdev/net-next/c/6991a975e416
  - [net-next,3/3] net/mlx5: HWS, Disallow matcher IP version mixing
    https://git.kernel.org/netdev/net-next/c/f41f3edf0b15

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



