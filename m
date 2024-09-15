Return-Path: <linux-rdma+bounces-4955-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5C39797B7
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Sep 2024 18:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 049371F217C3
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Sep 2024 16:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A7A1CB31D;
	Sun, 15 Sep 2024 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvjXp2kT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0840E1CB30C;
	Sun, 15 Sep 2024 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726416092; cv=none; b=HVW2O2d4dQw6H0ygKowBTeOF3uaebIEtJRBz5LN3Cpm0bvRmymW5DDIWciDVg+0H2QeBGycpDPIWHdN2/8x/wqPh0/V5eeg4tVJx9VtsbHYLynLjMR2wMfTsB4LVtl8K9+j8MhRdeXNH5X2ysqwN/kI3sko18FoWMcrzNNlgH2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726416092; c=relaxed/simple;
	bh=cibyBFGMS7msaw33cXdIprdo/qBLubbm15FuCFfyyIA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZSTgZyYBzZRrBoflzADtNPb4HuJ8FQZ1gCagzeIMWnl9xw02hFd9HFCIT18+DMexs+OVsXPPBNhzRnRW+4Q+Rh8XKCssKJ31HewAFTfRnNzOnzYB+fobEQEKFLN4mCpPcFuWtpjjDR3ZCnYuak76hgwiD7FpogqeihR1ysN8e3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvjXp2kT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844D8C4CEC3;
	Sun, 15 Sep 2024 16:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726416090;
	bh=cibyBFGMS7msaw33cXdIprdo/qBLubbm15FuCFfyyIA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NvjXp2kTkE+L1Uq0Nqp3UX7/d8YtuODyOIMvFmPxEMJM1hNQwDPeKrV6NJa8yVIMr
	 hT35Wph/WaOF0lQpGonmsz8JEXef3ndFKuSABoQzXYc4G0VxIX+hjlR4WTMrufUyG2
	 sM3WNORu2Kh54OIjjLnTNsqrGhJfjHiH12UNQN6B+h8iMe/Cdvie3sXxR1ZEnpKIX/
	 wujnEvav5RpA/jaYgibeHzwNzOFl0NTsDwZAtSlDoDeKLRZVwqTFiM51lC0/XbGBuk
	 Buk+2xixvtzq34BgE7e7/NoygefuhUr0ipkHvmaWK+keeMLWlwlQXnxziCq6mJsb6f
	 1DrOV/K0NwDvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EE23804C85;
	Sun, 15 Sep 2024 16:01:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/mlx5: HWS, check the correct variable in
 hws_send_ring_alloc_sq()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172641609175.3111582.206406906140072030.git-patchwork-notify@kernel.org>
Date: Sun, 15 Sep 2024 16:01:31 +0000
References: <da822315-02b7-4f5b-9c86-0d5176c5069d@stanley.mountain>
In-Reply-To: <da822315-02b7-4f5b-9c86-0d5176c5069d@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: kliteyn@nvidia.com, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 igozlan@nvidia.com, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 14 Sep 2024 12:58:26 +0300 you wrote:
> There is a copy and paste bug so this code checks "sq->dep_wqe" where
> "sq->wr_priv" was intended.  It could result in a NULL pointer
> dereference.
> 
> Fixes: 2ca62599aa0b ("net/mlx5: HWS, added send engine and context handling")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net/mlx5: HWS, check the correct variable in hws_send_ring_alloc_sq()
    https://git.kernel.org/netdev/net-next/c/be461814aa4c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



