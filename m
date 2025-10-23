Return-Path: <linux-rdma+bounces-14023-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC36C01C86
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 16:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC6DF4EA1AE
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 14:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B77732E752;
	Thu, 23 Oct 2025 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCLbUkYN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD48E32E6A7;
	Thu, 23 Oct 2025 14:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761229838; cv=none; b=SjdkFUhB6gF2y7SQtEQyXqssjLgQAUf978iignVlSQmxVMGjrRCt4CWbz7mnc35R0EYaDiD2rNUx2Dc6Y9+b4OCiR1Hrw2pOYMb1RSc86HdUcfHpaJw/jnCxOkXoBaOf84dsMhQUCycx4qBvZl/ZvLtSbKDRDIsiiYEK15/08TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761229838; c=relaxed/simple;
	bh=iMyrw87T/G4ZaU6ZmgUalIVzak0E6HRz5LjPpsf7ryc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HEdBNQV4dTHo17Db2xuVoWw7iZXEt7m9rLx5dvcP9HNty0VDH6K1evJ/Bo/LjqFjIHWSJTksrhr0cvlEKlabXvbH3J7HuDIboVcuNA705bCByVN3JaPZDx4i82OUABLIAe51i75eh0lLmNc3EvmG9ZRgJ009hcZSCosVeJ/CO9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCLbUkYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A78C4CEE7;
	Thu, 23 Oct 2025 14:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761229837;
	bh=iMyrw87T/G4ZaU6ZmgUalIVzak0E6HRz5LjPpsf7ryc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MCLbUkYNQfDRPocz9Gm5sgNvj5LBrFbcxBlfV0F1M0BFY/yoWoiKYHYVhu2ltTCHh
	 gzOz+OxJAnUE99Hw/NX0K+mfrpEwJ/vB/kKjnjRasmNdQalYxjVVaR6vZ6y3+SNDeX
	 clfT5/DIqbale74QVk/pGuag8QbrT96Bcybwt7NLUonRdVMWKrPsLCP9EMsgxoMLvp
	 y6OmsoRvMrCSj+BD4LE1H+ur7IuR+J0HgDLfZiYfqy+BTzYtOsJxIT60BIppjmlndM
	 emLAEaKDDXt3MVTbGgCnnhDKnclZpmQeEBg8LQOAEdFjinMOgCc1PQ0+b7Q1nY7jba
	 CxDPpLw3VO0gA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C203809A97;
	Thu, 23 Oct 2025 14:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] mlx5 misc fixes 2025-10-22
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176122981799.3105055.12421671916328980048.git-patchwork-notify@kernel.org>
Date: Thu, 23 Oct 2025 14:30:17 +0000
References: <1761136182-918470-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1761136182-918470-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Oct 2025 15:29:38 +0300 you wrote:
> Hi,
> 
> This patchset provides misc bug fixes from the team to the mlx5 core and
> Eth drivers.
> 
> Thanks,
> Tariq.
> 
> [...]

Here is the summary with links:
  - [net,1/4] net/mlx5: Add PPHCR to PCAM supported registers mask
    https://git.kernel.org/netdev/net/c/bb65e0c141f8
  - [net,2/4] net/mlx5e: Skip PPHCR register query if not supported by the device
    https://git.kernel.org/netdev/net/c/d58a9a917aa3
  - [net,3/4] net/mlx5: Refactor devcom to return NULL on failure
    https://git.kernel.org/netdev/net/c/8f82f89550da
  - [net,4/4] net/mlx5: Fix IPsec cleanup over MPV device
    https://git.kernel.org/netdev/net/c/664f76be38a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



