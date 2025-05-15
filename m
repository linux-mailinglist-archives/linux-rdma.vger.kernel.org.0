Return-Path: <linux-rdma+bounces-10361-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D96E1AB8A8B
	for <lists+linux-rdma@lfdr.de>; Thu, 15 May 2025 17:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 849023BA6C0
	for <lists+linux-rdma@lfdr.de>; Thu, 15 May 2025 15:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D8A215198;
	Thu, 15 May 2025 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lg/u3Pty"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0146818FC91;
	Thu, 15 May 2025 15:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747322403; cv=none; b=nl5G/Dl2LE40cEDG9q4Ch07HGl3GHDq0tqHbK2nxHvsZUAGd14lm48TKsMiyDRuinHghU3gI3bjlfd35krjP7chNFwRZZKVmqjUy0VoKQW1uXVK3h/PwhrqUzxn5MHn7XvaOX6HUn4JEveH8SqH+dnUaVkaPDK4SEzRRk0Da5ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747322403; c=relaxed/simple;
	bh=SBgb0vTlu2RtuW96PAdlVVB6BgteIAVWl6pfUjNz1v8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Tz7lg1AR1CNY8HkY5Yvp1aKAPeU8ph4nh4UXa9+kNCD1s7h04zHS//jQlNqpnZ8EZntUULymmyfmV99T8gyClNzh4ZTp+Vfgm/69vCZJb4KRFWunerfbJqa3uh3DCaKlKTafGYZ7ugHleJ9KHvGPo1ZAEpA3Fz5G9lX/aahg1Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lg/u3Pty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696A0C4CEE7;
	Thu, 15 May 2025 15:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747322402;
	bh=SBgb0vTlu2RtuW96PAdlVVB6BgteIAVWl6pfUjNz1v8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Lg/u3PtybrRTpI6u2kIoLESoUYc/WP1G8UP5ih6JsdCP1tWeZbTPGEoOKwCmeEAU+
	 IzvzUygvw5Ir5kTXOBE56761f+GGyy8KHqNtixosm3ZNcDv+LlcWO3W2UcCxJJ+/hW
	 B5hubuV0m+1qNWTqnuj4bTnxyAJfGH7qRci2GiyHvI3JAdU+/YEFy7/M5gLuj0F/Xd
	 d/23+xELdYcNW8uQ+eqFG/zN8eb6gaq1wxmdVCJ9zco1cqG+wpmyEvLWwU1lHjDfqj
	 +3pW6XuufRDjWtjB3onUdcAoPsCm7naK76PsfpO1iW6BdDxqyVsgcoUEBiQ4OGDhFx
	 lQosL80O9vPjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFC73806659;
	Thu, 15 May 2025 15:20:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net/mlx5: Use to_delayed_work()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174732243949.3145583.8227565924121305936.git-patchwork-notify@kernel.org>
Date: Thu, 15 May 2025 15:20:39 +0000
References: <20250514072419.2707578-1-nichen@iscas.ac.cn>
In-Reply-To: <20250514072419.2707578-1-nichen@iscas.ac.cn>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 May 2025 15:24:19 +0800 you wrote:
> Use to_delayed_work() instead of open-coding it.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
> Changelog:
> 
> v1 -> v2:
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net/mlx5: Use to_delayed_work()
    https://git.kernel.org/netdev/net-next/c/ee39bae6c141

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



