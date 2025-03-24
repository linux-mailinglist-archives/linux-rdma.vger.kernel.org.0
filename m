Return-Path: <linux-rdma+bounces-8925-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA51A6E4AC
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Mar 2025 21:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A07188C6AB
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Mar 2025 20:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8641DDC33;
	Mon, 24 Mar 2025 20:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jr7zAuPA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251261C7015;
	Mon, 24 Mar 2025 20:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742849404; cv=none; b=WQeN0DmJiDiKFtBzJW+TIB+oUSkjYJFo2iffr6kCygZgC2QWjk3RtyPJLTNeEcTMTlYIIiUtUxFHb81b0ewACMVkx9oG2Ixh48f+2bhNX1/CWCjWMteHDMn3ioe98L///O5sEQTPAX+6CVmd8b/Gru3vkGd42YG/g13dV+VwNR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742849404; c=relaxed/simple;
	bh=+E1a6f1BfRt3NaOdySFh4oT5oXF9cFDxHWIgqvGj654=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C1B25Q0Mt+S5gNwyXZWVFmJOiz7ly2W6Q6+P9OPxCq0HKCd1WdXJl1QlIYwkIX+/uAZzAn2ZbfH17CWaxlGPLptZDVzP79Na9aG9sXlLhsHrat7XzFIKkp7y61P/ILwQb4JdFbmZWZRURBwmXTbhEQ6HRg3/I6uI/IWSJUUEB3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jr7zAuPA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8477AC4CEE4;
	Mon, 24 Mar 2025 20:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742849403;
	bh=+E1a6f1BfRt3NaOdySFh4oT5oXF9cFDxHWIgqvGj654=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Jr7zAuPABm3xoichu2mNDjLuSrufijSM1rJg315XTKy7nMzfSeEFHbuNIhddxTCLv
	 jDa4EJuqQ6f+gRH1cNi2OOQ1NiJwrF+OMnUqVu4xdrgonqcNkyAkUxO2X/AVVlYWpG
	 PJmVDRAdWBpf20/gM1SqUU9R5X5bUMRTO88clS2rRhvkTRyAnTMzVLPzw1xEsXo4q3
	 W7NKsQvBpg3dsArq09m0BFd0hYCxJMB+vVCi/WyNClQv5G6oRQaNJlIfn7UntfZ78D
	 Qn1PzjtOufoLhxA2tdLF2ZUDvibqEtwuPG1f0ys3tNlfWGgulwlFzZJgQ8zDZBy+SF
	 LpDuKZGeZLyPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ED15B380664D;
	Mon, 24 Mar 2025 20:50:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] mlx5 cleanups 2025-03-19
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174284943974.4167801.17963287974570911086.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 20:50:39 +0000
References: <1742412199-159596-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1742412199-159596-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, gal@nvidia.com,
 leonro@nvidia.com, saeedm@nvidia.com, leon@kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, moshe@nvidia.com, mbloch@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Mar 2025 21:23:16 +0200 you wrote:
> Hi,
> 
> This series contains small cleanups to the mlx5 core and Eth drivers.
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net/mlx5: Remove NULL check before dev_{put, hold}
    https://git.kernel.org/netdev/net-next/c/42cd8dee3a1b
  - [net-next,2/3] net/mlx5e: Use right API to free bitmap memory
    https://git.kernel.org/netdev/net-next/c/cac48eb6d383
  - [net-next,3/3] net/mlx5e: Always select CONFIG_PAGE_POOL_STATS
    https://git.kernel.org/netdev/net-next/c/cba38d1235ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



