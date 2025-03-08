Return-Path: <linux-rdma+bounces-8490-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6701EA57812
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Mar 2025 04:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9823216EB9C
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Mar 2025 03:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D0615687D;
	Sat,  8 Mar 2025 03:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtI6ClCJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED91C182CD;
	Sat,  8 Mar 2025 03:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741405801; cv=none; b=gMobw2IchNtohtcbImqOHqemzYjLyeVkp0EFfB2Bk8EPAGyPDcsangc6DWShFaiygLzcRNAvBy8+vyav6u25UaoFvYunU20eEASMCDJXfEw15vaH/jxgOChdYH93MHMty6J9QirwekKRNM1Wa4sMQ9gvLD28EQlLmBjK4Kjxq+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741405801; c=relaxed/simple;
	bh=rXVk1NNsXgoR01sqZOrkf8glmBEmvFoNZ+oznebMTyY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KizLI1IdWMofIeh6O/FkpRJx16Eu6ZI5Z3B7f+pJJB3LGPzzqLvgJebOIcq3HvYxQnxrMrCqydnzRLPSTqRIZ6igGhLxTX4G113jewHl2v8klfr1k/0rcrqfQO9Bmoq6l28l8l/CrPtC2JzXTm4l0dYSVV8SkxJIVEFJaWvLz0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtI6ClCJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68393C4CEE0;
	Sat,  8 Mar 2025 03:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741405800;
	bh=rXVk1NNsXgoR01sqZOrkf8glmBEmvFoNZ+oznebMTyY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dtI6ClCJ66REtVA7fPUkETnmhxQD9GZA3yq1sO76HbzR/X0wgVz1xk4ywKFFSn76h
	 MCNasCHJ/NkcdweOtpT1aJMbABbhMrr2H/Ybg1MFEYa2w5MJ2Osup2Ur2kD6JUdmtk
	 cIfNyfISmZ5T48LUyJTxTZAg46ivsWtP8KL8ALC81kf1KWoRrkd77WeIw5E2H9epbd
	 4Nt5gbFK23651g+ENn/EtJQH92e8Q2ReKt35JJncc8Kg3AoG4lQ71lFjbGbRuZYzjX
	 pbJOnAraG+O5vTGBhPbo05Jel+a6uMFaL03Sk70mjxMq2TnLF9xmGA0d+A2/G8ILCZ
	 ao04f5bdasQ4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34005380CFFB;
	Sat,  8 Mar 2025 03:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net RESEND] net/mlx5: Fill out devlink dev info only for PFs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174140583400.2568613.926443029938293816.git-patchwork-notify@kernel.org>
Date: Sat, 08 Mar 2025 03:50:34 +0000
References: <20250306212529.429329-1-tariqt@nvidia.com>
In-Reply-To: <20250306212529.429329-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com, mbloch@nvidia.com, jiri@resnulli.us,
 leon@kernel.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, jiri@nvidia.com,
 kalesh-anakkur.purayil@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 6 Mar 2025 23:25:29 +0200 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Firmware version query is supported on the PFs. Due to this
> following kernel warning log is observed:
> 
> [  188.590344] mlx5_core 0000:08:00.2: mlx5_fw_version_query:816:(pid 1453): fw query isn't supported by the FW
> 
> [...]

Here is the summary with links:
  - [net,RESEND] net/mlx5: Fill out devlink dev info only for PFs
    https://git.kernel.org/netdev/net/c/d749d901b216

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



