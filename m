Return-Path: <linux-rdma+bounces-8538-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F5EA5A46B
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 21:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A74188E87A
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 20:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205BC1DDC36;
	Mon, 10 Mar 2025 20:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPgpkCfn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB96E15B971;
	Mon, 10 Mar 2025 20:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637404; cv=none; b=Wnk6BWmUCKGIeqWcmetzQaVK2YTOsZZmiiZbdfIhEA4flc/s0m8eJq8YRVfl4T682eRLs3ZRzLmVnJyJZskcpXjg6bvHOpmBPteXg9sFkgjN3yfp49N8ZRspChQbv3SJKZljcIJ1u30oj5kUZLlcW9sCXXqAgj3HfuZaWSv93mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637404; c=relaxed/simple;
	bh=t215O0kbLEGKYUsjR9k966TRCLjdrURsEKhgKH7lyoA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oBVZWujRtbcACzGnEWPcN0B3jfv6dC4rpReD9ze7egOHE/Rqh1qrPwiGJK1sF4oE4kzkdESuSHXgBh8pPmuPo4QVUVEZcbk583SAJMemItBmA3vDo+lmRwdCpY77J5l1KHDxabE5it2msPnISBLWqcwIvFOGYFT0704SWs8vIcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPgpkCfn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED40C4CEE5;
	Mon, 10 Mar 2025 20:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741637404;
	bh=t215O0kbLEGKYUsjR9k966TRCLjdrURsEKhgKH7lyoA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SPgpkCfn8J3oi+5dC+rDPpD4U8BHdIJRFLVjpGj/M9ruPa7Bgj0u/X8qxd6Q2ZfjB
	 A36N2z3jkQLK3Qrii5jUmJ12NNWncuO2pkqaecUIIyfdacOiebnU+JIBLkHG/9Y0vK
	 Tlg5WmklBtbOdAIbqyVd8yaunYVd6k6FxW1xTDMFglxWMbWeFt4IL/pxzwKcCfjcZf
	 U1pxCq8qIjycQ+7ZFuclbdub/si8476rltDqDtSvS+wo2P40cFNMW1HQkCRziryU2p
	 IfXwqh8HNTnJ59SXrRlZfY+yL7GwJx5FbbM59zGDd5fk4LTnRp/Cqee64PFyLMbW4/
	 72/arJ0hGvCjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D42380DBDB;
	Mon, 10 Mar 2025 20:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net/mlx5: handle errors in mlx5_chains_create_table()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174163743837.3677954.1083328858519439655.git-patchwork-notify@kernel.org>
Date: Mon, 10 Mar 2025 20:10:38 +0000
References: <20250307021820.2646-1-vulab@iscas.ac.cn>
In-Reply-To: <20250307021820.2646-1-vulab@iscas.ac.cn>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Mar 2025 10:18:20 +0800 you wrote:
> In mlx5_chains_create_table(), the return value of mlx5_get_fdb_sub_ns()
> and mlx5_get_flow_namespace() must be checked to prevent NULL pointer
> dereferences. If either function fails, the function should log error
> message with mlx5_core_warn() and return error pointer.
> 
> Fixes: 39ac237ce009 ("net/mlx5: E-Switch, Refactor chains and priorities")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> 
> [...]

Here is the summary with links:
  - [net,v3] net/mlx5: handle errors in mlx5_chains_create_table()
    https://git.kernel.org/netdev/net/c/eab0396353be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



