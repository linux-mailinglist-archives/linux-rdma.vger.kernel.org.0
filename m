Return-Path: <linux-rdma+bounces-8053-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6A8A4330E
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 03:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79541189F351
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 02:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C731519B4;
	Tue, 25 Feb 2025 02:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnyaCnvM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF15628E3F;
	Tue, 25 Feb 2025 02:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740450605; cv=none; b=QXJUcxY7LdV/5QPtsQFg1AGNvLRq/0+EO0cZyNvzp2cUIvfzzesOemZVulEddL6urzW8jZP9x3yILGEVHntqjzTbOjq8Gzs832garOnIriXObnY4v9fzUmVHT2iHs+cAxdUnQapvDqjqRXlzCbEPsHJjesyBRvCxTncAL02Qemc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740450605; c=relaxed/simple;
	bh=SZSuXVLjjSMXNnUi5YM5/yiVN6XNKTPvopWsPMzHCZg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rVNwLzSJRk2uJp/B/EoGEDBC30GQ2SC8+8w9rgOJ4pr8oSpzOaLLLFEHi8DRoYd04QTiH4zTmsQ0V9S1QwIVm70f2yHhfb5o4j2zoUGDAsE/Z0JIWbi+U1cmPJ79R9mLT10zIazHnYDy6fXMQzrtRZMcihq2LqPdNax241FjSvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnyaCnvM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADC8C4AF09;
	Tue, 25 Feb 2025 02:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740450605;
	bh=SZSuXVLjjSMXNnUi5YM5/yiVN6XNKTPvopWsPMzHCZg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VnyaCnvMuICuar+2aspmQQ/3XyEWjahjYded4FZ7O3xKZiKYsQ971oBuQWe/l52zn
	 P3aj9Gsu4NWhnYsHCfy4o8MGhhY8JlgwzioGHHywdTz+GkdEnL83jVc1+BG9rVfQOx
	 WGxqpDPnt5kAqr71knEkPQDdIpIyc91wSWylPvrrIkCjG7ivZjpze+qOyALmt9ph5t
	 VK+1yyKsO3eA1JehpCzmVj3GR62fIAIYBAkK7XfN+j7bUvGqe7JeUJUgm87rrmQx9R
	 88NFdoDvCTuJcwKvz7TnciuUXmTc+Gv4gw/FixSo4ajYJov3VmrOQQoSrFey73GN6m
	 oxUo+2uCpe+NQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C38380CFD8;
	Tue, 25 Feb 2025 02:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH net-next] net/mlx5: Use secs_to_jiffies() instead of
 msecs_to_jiffies()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174045063700.3682145.1145479825846035545.git-patchwork-notify@kernel.org>
Date: Tue, 25 Feb 2025 02:30:37 +0000
References: <20250221085350.198024-3-thorsten.blum@linux.dev>
In-Reply-To: <20250221085350.198024-3-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kliteyn@nvidia.com, mbloch@nvidia.com,
 igozlan@nvidia.com, jacob.e.keller@intel.com, saeed@kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Feb 2025 09:53:22 +0100 you wrote:
> Use secs_to_jiffies() and simplify the code.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Saeed Mahameed <saeed@kernel.org>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Resend with "net-next" in the title as suggested by Jacob and Saeed.
> 
> [...]

Here is the summary with links:
  - [RESEND,net-next] net/mlx5: Use secs_to_jiffies() instead of msecs_to_jiffies()
    https://git.kernel.org/netdev/net-next/c/8f3f4464ff08

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



