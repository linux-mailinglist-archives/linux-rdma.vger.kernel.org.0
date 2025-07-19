Return-Path: <linux-rdma+bounces-12315-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F78B0AD10
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Jul 2025 02:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E05B7A84A7
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Jul 2025 00:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C947260F;
	Sat, 19 Jul 2025 00:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/aVtXQ3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602C24A23;
	Sat, 19 Jul 2025 00:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752886191; cv=none; b=EtswwzCWRkLDHWk26rtvXZjn+zLQ2bsIgIxxFm9KBOgsbLttrTEoJnbLIjIfSe9jCYYuUqspo6BxdI1rbSjsGLPBjnGBcA6zCenkS533t5Y/5LZF76CKt7FDcEXv+zQvq6GlW3ilrAgM+eEM8pZCw8piF1AqXsfwb8L4YVHUOQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752886191; c=relaxed/simple;
	bh=DW8vjxBQp6/eikh2tKufwXCbRHKBXNUGD4AN0/Iianw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p69aNW9Q1WWoVGuPET524FoROktrxtmhgb4Z/KGhPLt+IP3kdQawJt82eG6ooPGC5kr46ZrrYc8iPHOvzs5nlJ0kcH9P5j8Np7SDX4uJPUEKU+IcgRAcUIoW4VvW5ZazuMFvL3lqKU/dAzm/9g90eTuLFbVQbyq2nbm1f3B3MXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/aVtXQ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95D0C4CEEB;
	Sat, 19 Jul 2025 00:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752886190;
	bh=DW8vjxBQp6/eikh2tKufwXCbRHKBXNUGD4AN0/Iianw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P/aVtXQ3C1ITgUv7pz+/u6+L0KtqxvbcSFD7MsfN4waZVfp0zbvDbeep5flKDlart
	 FJcJcPSSIU0M0xrNd/xbFqJV3tGHpkV4cZhmwOqHLtWIfzo7r6hfaRbYbFMXOCwBeS
	 PK48kzuM/gGfisJxnoeTthlLYn5xhonKe5wHSv2NVybkoXw6zZR6M+O+Aclq6Nps55
	 r87/HukW680sqgbcxesURWClNGfoa2cPN/7HfhBm5RSRfuMChlXg3dc2+MiUU/YoFT
	 7zQD0XWP9bgOdKp7BQUi0Ymi/+GoY1f/gycBAQSKT/g77AIDK8DhJ3Crg0qlcV2j0R
	 wd23iZ+V4MwGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD6C383BA3C;
	Sat, 19 Jul 2025 00:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] mlx5 misc fixes 2025-07-17
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175288621044.2839493.14619363729044720272.git-patchwork-notify@kernel.org>
Date: Sat, 19 Jul 2025 00:50:10 +0000
References: <1752753970-261832-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1752753970-261832-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeed@kernel.org, gal@nvidia.com,
 leon@kernel.org, saeedm@nvidia.com, mbloch@nvidia.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Jul 2025 15:06:08 +0300 you wrote:
> Hi,
> 
> This small patchset provides misc bug fixes from the team to the mlx5
> driver.
> 
> Thanks,
> Tariq.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net/mlx5: Fix memory leak in cmd_exec()
    https://git.kernel.org/netdev/net/c/3afa3ae3db52
  - [net,2/2] net/mlx5: E-Switch, Fix peer miss rules to use peer eswitch
    https://git.kernel.org/netdev/net/c/5b4c56ad4da0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



