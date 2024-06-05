Return-Path: <linux-rdma+bounces-2919-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 584708FD913
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 23:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0816F1F21C85
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 21:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF96168C16;
	Wed,  5 Jun 2024 21:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5pD0t5O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ADA4962E;
	Wed,  5 Jun 2024 21:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717623032; cv=none; b=Y6c46dRH8iyB+/lS7gx20bMfWgL4A3sm7sxCKiEL0MgudXVPzDk/CR2vxr2+EBx2C1bxmzRkeCCMLb1wQgBa+taFmsq3ycWdzBdGKnamCpgX9dQW+HDB7c9SmTCuN8Bux557TFkE0YMo0ecTqlSfxs1vJYdmwfIpAeGwO8muxac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717623032; c=relaxed/simple;
	bh=QwvAko4zpRbQR4SDkAviF8HJEOiuHXqiAOvLvCo/Bds=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sIh6Sun1JhNYizxsFDrWIaGbu4iFTfy/+4eU9PpmmNpmMcL7TJWBa0/i25yWaqNFvwCDfmwZtffj5G3hoEpZ9I5Nid3vGO8zB0Mr/GmoA1Tb/D+OjTJVV8q8ecu00mJDyd/1zm81eJ5cBLhTIgu7jCmYG08r4En87jYiMyu261U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5pD0t5O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82FBFC32782;
	Wed,  5 Jun 2024 21:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717623031;
	bh=QwvAko4zpRbQR4SDkAviF8HJEOiuHXqiAOvLvCo/Bds=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B5pD0t5OThSfVYlbpjHSj9j9I4KAU1eHkpD6EuZ11w18FuvfvXQzbR5XGZ+qyUBUa
	 iZY+FSYz7DzWM03W9cdHPcZ4eL+lM2xulhJk81QVC1rZa2vYVzUcsTGtO4Mg2+ufjX
	 a+KDTs/hF3lxzknhvZwrwrrMF5kGKBCahtnDeyg1QGNStjCkQ+C/ZT7tZlk928UI+N
	 phiQCn/xuDyR7k6oW0zjQUntooeHwJUoI+greKeL41pYOg2tABvP4bHSA5G/1rNHfx
	 anZ/MdphWwVBWqF+cTJRcZypyRF5NqSM5euJB8GIXUqNiof+5jzr76JiNbrxdeyEhl
	 XDGPy7Adw3nfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6DCA4D3E997;
	Wed,  5 Jun 2024 21:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/mlx5: Fix tainted pointer delete is case of flow
 rules creation fail
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171762303144.24326.14850911837497875775.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 21:30:31 +0000
References: <20240604100552.25201-1-amishin@t-argos.ru>
In-Reply-To: <20240604100552.25201-1-amishin@t-argos.ru>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: mbloch@nvidia.com, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 maorg@nvidia.com, jacob.e.keller@intel.com, shayd@nvidia.com,
 jianbol@nvidia.com, ruanjinjie@huawei.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 4 Jun 2024 13:05:52 +0300 you wrote:
> In case of flow rule creation fail in mlx5_lag_create_port_sel_table(),
> instead of previously created rules, the tainted pointer is deleted
> deveral times.
> Fix this bug by using correct flow rules pointers.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> [...]

Here is the summary with links:
  - [net] net/mlx5: Fix tainted pointer delete is case of flow rules creation fail
    https://git.kernel.org/netdev/net/c/229bedbf62b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



