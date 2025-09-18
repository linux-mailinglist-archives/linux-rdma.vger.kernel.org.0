Return-Path: <linux-rdma+bounces-13498-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 037BDB85698
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 17:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B4EA7AF586
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 14:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9584730F953;
	Thu, 18 Sep 2025 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBJcwxCQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F62130E843;
	Thu, 18 Sep 2025 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207618; cv=none; b=eXr2nM451ieFTqj3uaW6LwZePvdj9O8f0+0PJG9kml8VWZEI0NXcwvse65hwKh0wMkAvT3vJ/5Hos/nAZpfOuz9gQpmMFu4IBumGpXp0FHnK+Pb+1TAei7cuAJOjj9S+mD6RBU9bWeiEIwvEOPa1yAgsTDMXDxnKYxq2VpOwFyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207618; c=relaxed/simple;
	bh=1yE3K/gFGSr2+CqHRxA2dW3tN70Sq5/qQtXHtQf+Z18=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fxiSMBvLBiKOUq/bDFnO7cHNDAkBilitpu4t2598S3SXtKxXvD3Wi3W/QfvQ/4LhbSyfsid6ZJItmB/QtIX9HcyAAET5Shzg+FAKU4xOInr11dy26sZU61YJugzoCFYGHtPnx4u350UVk/fk6jRQ7Y53rm2NApAXziaih3LECLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBJcwxCQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB744C4CEEB;
	Thu, 18 Sep 2025 15:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758207617;
	bh=1yE3K/gFGSr2+CqHRxA2dW3tN70Sq5/qQtXHtQf+Z18=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KBJcwxCQidNzYvGqwfCNY0NWrvRANGNQaouZXHlYMEiwcpHv4xPzz0AJGOlHlSaCK
	 2BKxNAgOGqWk0Yh7cBMbp1T1h/6mCTRSazn1G9gKj7Bi3cxoSYxAH2QO37ceJFi0oa
	 M3SAw5jta2RycFDyTc70NnL+WjHdHMzumrORQBGcrwwWt35HWKcIAq1FXdH4BYgQYx
	 rU4z+SRp42M7dFv3IuTbnKQSh/hWCaa78cKhmA0zHCIRlaJN5SSWcL00TGaaSo5D9A
	 GAz+5PcZX1iz3bPMaxlRk5yQJWL053rOGYWyyXN7PcGNny8nshWymWma9n9GAsUhx9
	 h47P5pTpBILtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEF039D0C28;
	Thu, 18 Sep 2025 15:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] Revert "net/mlx5e: Update and set Xon/Xoff upon port
 speed set"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175820761749.2450229.177550446664906635.git-patchwork-notify@kernel.org>
Date: Thu, 18 Sep 2025 15:00:17 +0000
References: <1758116934-644173-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1758116934-644173-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 alazar@nvidia.com, daniel.zahka@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Sep 2025 16:48:54 +0300 you wrote:
> This reverts commit d24341740fe48add8a227a753e68b6eedf4b385a.
> It caused a degradation, reported by Jakub here:
> https://lore.kernel.org/all/20250910170011.70528106@kernel.org/
> 
> Fixes: d24341740fe4 ("net/mlx5e: Update and set Xon/Xoff upon port speed set")
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net] Revert "net/mlx5e: Update and set Xon/Xoff upon port speed set"
    https://git.kernel.org/netdev/net/c/3fbfe251cc9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



