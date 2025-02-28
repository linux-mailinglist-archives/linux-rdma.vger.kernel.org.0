Return-Path: <linux-rdma+bounces-8205-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8993A4943D
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2025 10:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07BE13A919E
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2025 08:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FE5254B1A;
	Fri, 28 Feb 2025 09:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbKeZtES"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1833F254867;
	Fri, 28 Feb 2025 08:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740733200; cv=none; b=FH/pRY+QqfVVAuFfv9wDOtfAKV+08GHXhdj5bZeMmFzoPXMb0ScD2ffzrgFZvPn8im+0rnSv+UWlrLduH7Wruu/MsvD83X287cY+kkYBn3alS0kDpckXmwwPNbnbMF5F52ZjVa0+z2Zkk4SUkX4Wm5DQT9YwRxvlnKN8nWhsbBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740733200; c=relaxed/simple;
	bh=kI3Z3wp8Ji5DPJmFPz7FRuOxsxH6WGI9IT1Imk0ZHkE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oMY2+LUX1DVqaSBoNw5e5HtSUfr0Ij+98UhofvwG7el+dddkYEN7GfAlgIP0mooZ9Bfb8abbMTvUC/hm7cWI+lqKX82PRTS6L9GzM0rAYpnahTNzCIKxsKNGab888/48eH5S1J2MRjuWEfpFtC7ZAGUbIlme7npz1rrY7HAOu9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbKeZtES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DA2C4CED6;
	Fri, 28 Feb 2025 08:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740733199;
	bh=kI3Z3wp8Ji5DPJmFPz7FRuOxsxH6WGI9IT1Imk0ZHkE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AbKeZtES77cwD1+ZtJ6ITeKjQyc3wMTZfRm/ECSYpmaqPIRPNmy2yBXTd1qCV9KZ7
	 wyoT5cSWrZvIGRnnYlomM2SBSZKFYKHO9LAkm0O5+RiqqYcxXzHVvQaIPqI5PQl4zV
	 mxmjqStGvr0f5JMMkiIzGv229+dX1y9Q6AMeFcnARIOSg02JAoc54ORwPxYxhkPwQt
	 tbn6VziBVnN8mUqhfYRf72yT5GVACc7i5LRvEZ51h/jdJ/SRpohK9/JaPtmj0gd+fT
	 zDNhMumqbrXSOiCx0lPQd/i+NgwxgsnM1MuyjqA4RV0bvioTSgjV8JG24Z8bKvaQAg
	 8TYXiGZ4fmtUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF92380CFF1;
	Fri, 28 Feb 2025 09:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] mlx5: Trust lockdown health syndrome
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174073323150.2067282.15443577671242720643.git-patchwork-notify@kernel.org>
Date: Fri, 28 Feb 2025 09:00:31 +0000
References: <20250226122543.147594-1-tariqt@nvidia.com>
In-Reply-To: <20250226122543.147594-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com, leon@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 26 Feb 2025 14:25:39 +0200 you wrote:
> Hi,
> 
> This series introduces a new error type in the health syndrome,
> specifically for trust lock-down.  Additionally, it exposes the CRR bit
> in the health buffer, which, when set, indicates that the error cannot
> be recovered without a process involving a cold reset. We add The CRR
> bit value to the health buffer info log and update it to be logged on
> any syndrome.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net/mlx5: Avoid report two health errors on same syndrome
    https://git.kernel.org/netdev/net-next/c/b5d7b2f04ebc
  - [net-next,2/4] net/mlx5: Log health buffer data on any syndrome
    https://git.kernel.org/netdev/net-next/c/6bdce277a326
  - [net-next,3/4] net/mlx5: Expose crr in health buffer
    https://git.kernel.org/netdev/net-next/c/63f26199721f
  - [net-next,4/4] net/mlx5: Add trust lockdown error to health syndrome print function
    https://git.kernel.org/netdev/net-next/c/680173b6bb6b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



