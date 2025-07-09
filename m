Return-Path: <linux-rdma+bounces-11990-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12514AFDC16
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 02:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBD337AE94E
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 00:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4523FE4;
	Wed,  9 Jul 2025 00:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXJk9B/I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E8D20E6;
	Wed,  9 Jul 2025 00:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752019789; cv=none; b=Yf65depKDqXmQ7v8UASG8p5dcneQQQWSfHPndPNZpz90xjQM1WQC2y8nyyBKS48GcOFoT6UknuioPiYFdQLvnBt1bGbnpbuPqD5buQPoRjZfhwHMFYYbu24l4u3CqYQ7ykON3Z5y7S/L1JPbsxI739wEL0nmZWb2VRFZQRSbpHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752019789; c=relaxed/simple;
	bh=KPv8Lnl1evMmxjGd9pGNit0edxMSJwc/CpdmnqHBB7c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o7iCz5yzBdTWieRq0Zmc5UGgMv0puX6vhdIqnlKqs1V4ljTXBc8y0na1JRNUrWSuaPq+6pxns7MUs7w60yvxJ+8bNMcF2L5fxUzC21yCkuyjwxwmBrsQW0WblNqxE1n/4Id6jGguXZJdFPk7Rxl6rTsUdo85ySRthW1+1Lonhyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXJk9B/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450F3C4CEED;
	Wed,  9 Jul 2025 00:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752019788;
	bh=KPv8Lnl1evMmxjGd9pGNit0edxMSJwc/CpdmnqHBB7c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UXJk9B/IEfR6aa0mRE5BmI0d22bTeeEm8YF/5x8jOcww7IPUdEJTKHX2jmLnkPFFF
	 OPx/PMIBSfwfWOsAeVqCaFaX10z9bbFWA7nzLOpKsBOCk98UIr5J04BprPBD9balJd
	 eGUO7JKOBjDu5hJH+Ysw3moeFojM800LgRrkzqTD9MVuRZkZWged9gyfMxbxY61hFr
	 1uDsvFZGsiQlduYmXpQtvyVW0iIX3eVvIjLzO4iPjUSunQDaQq/h/Nf5ShGhk28ZBg
	 6apeamhLFgT9Y0uJCrCYOB0PSrPKc3VrZI0/LGEaBU1zpWJqlcx7sJSZQ66oPTDzVd
	 lDRUlsTYTdH5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E04380DBEE;
	Wed,  9 Jul 2025 00:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [pull-request] mlx5-next updates 2025-07-08
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175201981076.170871.6936040396989013420.git-patchwork-notify@kernel.org>
Date: Wed, 09 Jul 2025 00:10:10 +0000
References: <1752002102-11316-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1752002102-11316-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, leon@kernel.org, jgg@ziepe.ca,
 saeedm@nvidia.com, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, mbloch@nvidia.com

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 8 Jul 2025 22:15:02 +0300 you wrote:
> Hi,
> 
> The following pull-request contains common mlx5 updates
> for your *net-next* tree.
> Please pull and let me know of any problem.
> 
> This is V3.
> Find V2 here:
> https://lore.kernel.org/all/1751574385-24672-1-git-send-email-tariqt@nvidia.com/
> 
> [...]

Here is the summary with links:
  - [pull-request] mlx5-next updates 2025-07-08
    https://git.kernel.org/netdev/net-next/c/80b0dd1c4ed4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



