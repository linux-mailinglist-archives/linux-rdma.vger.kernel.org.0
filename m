Return-Path: <linux-rdma+bounces-7930-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AD3A3EAA8
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 03:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9EB17A1C2B
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 02:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C035D1D7E42;
	Fri, 21 Feb 2025 02:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIq+ckPR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A92286298;
	Fri, 21 Feb 2025 02:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740104213; cv=none; b=EvXfGolEZ3bEacFXf2VjsfVfGxua+apyD5XhPD30jWRKxaS6/+fNLilEKNLBiWHtrAOOkJg6eJO2u+xIiRYkjM78wf+GWxeLOdtNDh8HmGH0l6+1q67a87hq/cYdYYaAUTjwOlwyZB/bXCJLMvg88tO5/Sv/Dt1F1bsXrLNLWIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740104213; c=relaxed/simple;
	bh=o3JKye7arQ4J7Brh3Ykt9V8vrJUz48NShx31kO1YIaY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pCuSDVjC/4ApOjiivXRuyaMVkzQ6CaEpm9TIoMJyJuG83xcyobNdyIuXqxHPDIaaiKgSb5AwQQ8COV48Joe9hFtMHhjwlYIElfPrW5lVk4DGT67trVEkIwgHKSxcM64peErp+GeoyusF5/bFhgYA8bdNLHZoyqrsb0G4247XHz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIq+ckPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6562C4CED1;
	Fri, 21 Feb 2025 02:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740104212;
	bh=o3JKye7arQ4J7Brh3Ykt9V8vrJUz48NShx31kO1YIaY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EIq+ckPRMiuJmCIXJPgD5Ir5otb8cO7wENAwM5sxOG2PB2vdBGtECpRl6ahWkODl+
	 SlfMHJf6+bZ57rtGOvaQ+W/TRxVbfxGqp/uU1F6UP6r9UFIngU6n7t2Mc2QnzsjM23
	 6XeggBXDmIC4jN0miJu/HSLuMacdf+Hf7Qg8dNA+oPm14PcVKCWLDdYLt52rkGHjPj
	 YLDQM9FopikIARHIUSvT40SAtEThv60JtNxfBGWhkRClAImyyQtzoidj7PE9vI7PM0
	 9PbtltfRu8sAIijlLGimlV8XEQna+9xcVyLDZSgO7oPWh9D0xIDRgVDrODWZ6UYDvK
	 OEsbzhFcZXLjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADED3806641;
	Fri, 21 Feb 2025 02:17:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] mlx5 misc enhancements 2025-02-19
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174010424373.1545236.17261875042123733524.git-patchwork-notify@kernel.org>
Date: Fri, 21 Feb 2025 02:17:23 +0000
References: <20250219114112.403808-1-tariqt@nvidia.com>
In-Reply-To: <20250219114112.403808-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, gal@nvidia.com,
 mbloch@nvidia.com, saeedm@nvidia.com, leon@kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Feb 2025 13:41:07 +0200 you wrote:
> Hi,
> 
> This small series enhances the mlx5 ethtool link speed code (no
> functional change), in addition to a Kconfig description enhancement.
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] net/mlx5: Bridge, correct config option description
    https://git.kernel.org/netdev/net-next/c/3fe090ad0250
  - [net-next,2/5] net/mlx5e: Refactor ptys2ethtool_adver_link()
    https://git.kernel.org/netdev/net-next/c/5246fd3fc232
  - [net-next,3/5] net/mlx5e: Introduce ptys2ethtool_process_link()
    https://git.kernel.org/netdev/net-next/c/64d97f891961
  - [net-next,4/5] net/mlx5e: Change eth_proto parameter naming
    https://git.kernel.org/netdev/net-next/c/9ca3bf013a0e
  - [net-next,5/5] net/mlx5e: Separate extended link modes request from link modes type selection
    https://git.kernel.org/netdev/net-next/c/9c362aafda8b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



