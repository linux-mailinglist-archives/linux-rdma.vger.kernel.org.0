Return-Path: <linux-rdma+bounces-10896-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38754AC7C43
	for <lists+linux-rdma@lfdr.de>; Thu, 29 May 2025 12:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49B5E7B5335
	for <lists+linux-rdma@lfdr.de>; Thu, 29 May 2025 10:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DDD28E5E3;
	Thu, 29 May 2025 10:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ev8XGIlR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD00328DF38;
	Thu, 29 May 2025 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748515794; cv=none; b=s08HoU/T1XUmy/EJ/8M3tBG0wYiuTJfKcJwkzgH9Y1hKPmEk25qjIKxt8GSqZbm/pObmyRrWqrgvnzAxgNAvyhQSlMY/1E/OuqpkjPFdCoJR6WVbkhUDxBDCG7GUe4xFACSaNbYBd2/zV4hsTtoHsdU2vHJkQpliKIxU2pk9I84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748515794; c=relaxed/simple;
	bh=kP+ItR+ZhfBHSCRX9z/XmYHxCmXQM664CNPpLcFD+bk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q8KahWd1RUHhlGaDVnthoWK4wD2znbWrdFisxp6g+H4T4sIzJwSXbyBiygtRCmwOoy6g+2pLhCvu4ApyXVXgWZtNuH7DlUpMUOh/uf1eFb/olCAxhtEtyhrHbp9IkvFuzKkAS9b7p6Kltg0S25QTMWq1b4xgJnWDJypV6doRzvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ev8XGIlR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324DDC4CEEB;
	Thu, 29 May 2025 10:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748515794;
	bh=kP+ItR+ZhfBHSCRX9z/XmYHxCmXQM664CNPpLcFD+bk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ev8XGIlRAO/IW4Zp24DZZkIKagA4e0JBHBLpdAIiI4UobxLfjOBdtyUU/G3/zDxgu
	 d7Wv7BrjLYZHoc8lTNf5lLIbDtSf4gpVvmQLY7pLNFuDg1vV2Pgs4QejGhHmK1B78U
	 Rp4nTMWGQf6YyHwdmwN8dxGQvq5nb1xNjhHsNuTjOPRCf5FzfG5ReA5FW5Vj5UNvWP
	 9RL3zMIpaaLcLtz6EBN97pMFvZqVBvCJ5NGimL+EIvhWn/U0lOintgTpyg87JKOye3
	 9q9j731d+Sa0+hu7hsHbAqGEy+QkHCwLegZWcDoUpdKue/0GuQlfjoACJIF2Tgwxnr
	 z9wb6IJStN7jQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CD3380664F;
	Thu, 29 May 2025 10:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net/mlx4_en: Prevent potential integer overflow
 calculating Hz
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174851582800.3224950.5138416129241395167.git-patchwork-notify@kernel.org>
Date: Thu, 29 May 2025 10:50:28 +0000
References: <aDbFHe19juIJKjsb@stanley.mountain>
In-Reply-To: <aDbFHe19juIJKjsb@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: eugenia@mellanox.com, tariqt@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ogerlitz@mellanox.com, matanb@mellanox.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 28 May 2025 11:11:09 +0300 you wrote:
> The "freq" variable is in terms of MHz and "max_val_cycles" is in terms
> of Hz.  The fact that "max_val_cycles" is a u64 suggests that support
> for high frequency is intended but the "freq_khz * 1000" would overflow
> the u32 type if we went above 4GHz.  Use unsigned long long type for the
> mutliplication to prevent that.
> 
> Fixes: 31c128b66e5b ("net/mlx4_en: Choose time-stamping shift value according to HW frequency")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> [...]

Here is the summary with links:
  - [v2,net] net/mlx4_en: Prevent potential integer overflow calculating Hz
    https://git.kernel.org/netdev/net/c/54d34165b4f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



