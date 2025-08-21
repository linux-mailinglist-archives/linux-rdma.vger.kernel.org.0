Return-Path: <linux-rdma+bounces-12857-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B24B2FE4E
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Aug 2025 17:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A3C3B56F5
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Aug 2025 15:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C21271472;
	Thu, 21 Aug 2025 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzU5OQ7p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0FB26F478;
	Thu, 21 Aug 2025 15:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789607; cv=none; b=kin9by2wsTOHb3AFDWfsNlelcLlvNO4vd2Gwt1hPL5hpvO0uvZHU7GKLUUp3O3tzwZZDuuPwUmXS8Tf75gYvl3HAFLdAUotDQoQvUahMhIsT5NxpzcPepeDE4nIJADrgYvi59qiYumhJf47pOgRkgi5/usJ/JiKfXCzfEkrt8a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789607; c=relaxed/simple;
	bh=UcWfbi0iEkHH1+i77ePdo2DIJTciIamgyhLpHY/OeH0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IbJtRK8z9x+LTGHaDy9oXA1daiERAfJVrEmVXz74R37e6qdnNuNQMeAeD7frNhDn7VR7198UixEKWZdK2eErcu2xshBq0/xAby7IicXFyCTvRBh7/WLWGRk1b6tUn7ULSy3wJztD236uram88Ys/mteYYfivmEH0E7ntQyeB08w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzU5OQ7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE233C4CEEB;
	Thu, 21 Aug 2025 15:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755789606;
	bh=UcWfbi0iEkHH1+i77ePdo2DIJTciIamgyhLpHY/OeH0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nzU5OQ7pRM5+tru7wQGM31jdSyerDgdNvIeQdfBwij15soBJzFYvNwnmgwK/Y2MJs
	 x3QGG0r+OQ4R4XmMBkKCpldxJrIhJttKuOv/0C2uxQlqtwpYaptP9V+HJhs7fvUpVM
	 SIuWWQX08p5OeWzzAgWAr3YJf5y4blkb1U2kkn7gdj6y1rZlMeZUHvkKqlVjs1SYHU
	 yQb5Ox8q8wSHAyMFMhD/omDzkOgWsIk0hxLM/59//Tgyh+izV0C4d3ehP75TA0Voer
	 SGVYtU1H6qBM6XzwGN0/pIxR7Fzbm6VBFtk+F3xhHxkZL2J8twKp3/s6lZRDSnLQcJ
	 GSRLks9w2RzOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D7E383BF5B;
	Thu, 21 Aug 2025 15:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 net 0/8] mlx5 misx fixes 2025-08-20
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175578961600.1082285.18104026294621476330.git-patchwork-notify@kernel.org>
Date: Thu, 21 Aug 2025 15:20:16 +0000
References: <20250820133209.389065-1-mbloch@nvidia.com>
In-Reply-To: <20250820133209.389065-1-mbloch@nvidia.com>
To: Mark Bloch <mbloch@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, przemyslaw.kitszel@intel.com,
 tariqt@nvidia.com, leon@kernel.org, saeedm@nvidia.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, gal@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 Aug 2025 16:32:01 +0300 you wrote:
> Hi,
> 
> This patchset provides misc bug fixes from the team to the mlx5 core and
> Eth drivers.
> 
> v1: https://lore.kernel.org/all/1755095476-414026-1-git-send-email-tariqt@nvidia.com/
> 
> [...]

Here is the summary with links:
  - [V2,net,1/8] net/mlx5: Base ECVF devlink port attrs from 0
    https://git.kernel.org/netdev/net/c/bc17455bc843
  - [V2,net,2/8] net/mlx5: Remove default QoS group and attach vports directly to root TSAR
    https://git.kernel.org/netdev/net/c/330f0f6713a3
  - [V2,net,3/8] net/mlx5e: Preserve tc-bw during parent changes
    https://git.kernel.org/netdev/net/c/e8f973576ca5
  - [V2,net,4/8] net/mlx5: Destroy vport QoS element when no configuration remains
    https://git.kernel.org/netdev/net/c/b697ef4d1d13
  - [V2,net,5/8] net/mlx5: Fix QoS reference leak in vport enable error path
    https://git.kernel.org/netdev/net/c/3c114fb2afe4
  - [V2,net,6/8] net/mlx5: Restore missing scheduling node cleanup on vport enable failure
    https://git.kernel.org/netdev/net/c/51b17c98e3db
  - [V2,net,7/8] net/mlx5e: Query FW for buffer ownership
    https://git.kernel.org/netdev/net/c/451d2849ea66
  - [V2,net,8/8] net/mlx5e: Preserve shared buffer capacity during headroom updates
    https://git.kernel.org/netdev/net/c/8b0587a885fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



