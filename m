Return-Path: <linux-rdma+bounces-9436-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20446A890C8
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 02:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93D093A6C12
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 00:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE71450F2;
	Tue, 15 Apr 2025 00:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMrnYIHg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C571E6FC5;
	Tue, 15 Apr 2025 00:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744677598; cv=none; b=g5lyYPSSLkBet8wvbUy69Braw6GnalfLc8lk8fgY6M2T5QDLWKcci4SQvJCOeLbozeyuqQ8xmGX09iyJWSORoZc111pICz+WMGqrwHeXOk+cCotifdWbVMzDFHr3v1vXyjjjJXfmH8qCQWdocGpmJIV90SWrFqRwKA+lXVT4x/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744677598; c=relaxed/simple;
	bh=jm59Kd4n8nU3mu9HjsB5IBz7u5eAGxEsIKZyMkLDR4E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vt6czvCMgXGpERIT7JXrdoPqDeB0zB5ODE8b4cm2YkiA7wta3pcatrh/kdTcR14OwgXNcmwqrznQbBLv3Y/eArgSdObSl12JInCVRiXWc2p/PY2U0HMGNMnPQ6kRNmN9X90Hcx+fAxhaDfWDun90MwXedfE3VuXI+YBMtG5EPlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMrnYIHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962EDC4CEE2;
	Tue, 15 Apr 2025 00:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744677598;
	bh=jm59Kd4n8nU3mu9HjsB5IBz7u5eAGxEsIKZyMkLDR4E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dMrnYIHgpT8fX2uaV8N2MeK38NFjDOTxDjhuOR064O1f5F4HUg/tIRnUugwdBgpgq
	 OTSBBsHW9hLKqgyPjR13HA0Z6kmCUftT1MKsyFWXWarm7L5OfLcd/niLaikpBfGayT
	 kDdqsokUhvr+99BBLBbkLmWjLtBf/NeyG7Ci7isSbN3K8dccLDojQ1LE8MD1//r0EL
	 /6urBlIH2vhN7cMHQZpsevAAoTx9kkLbGzTmoI+SxWHPcNtAFuMby4pTqMN0yYyDax
	 8TsYVrJM9+twnknYplt8wCOGh0R9zTryre5T+lMZ9f+8uNmIl9ozF67eOMfGAtygTa
	 o7X7S8sZrqmFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE60F3822D1A;
	Tue, 15 Apr 2025 00:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V2 00/12] net/mlx5: HWS, Refactor action STE handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174467763650.2087322.969290056857712388.git-patchwork-notify@kernel.org>
Date: Tue, 15 Apr 2025 00:40:36 +0000
References: <1744312662-356571-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1744312662-356571-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, gal@nvidia.com,
 leonro@nvidia.com, saeedm@nvidia.com, leon@kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, moshe@nvidia.com, mbloch@nvidia.com,
 vdogaru@nvidia.com, kliteyn@nvidia.com, michal.kubiak@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Apr 2025 22:17:30 +0300 you wrote:
> This patch series by Vlad refactors how action STEs are handled for
> hardware steering.
> 
> See detailed description by Vlad below.
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [net-next,V2,01/12] net/mlx5: HWS, Fix matcher action template attach
    https://git.kernel.org/netdev/net-next/c/36ef2575e78d
  - [net-next,V2,02/12] net/mlx5: HWS, Remove unused element array
    https://git.kernel.org/netdev/net-next/c/b2ae16214ffe
  - [net-next,V2,03/12] net/mlx5: HWS, Make pool single resource
    https://git.kernel.org/netdev/net-next/c/38956bea7349
  - [net-next,V2,04/12] net/mlx5: HWS, Refactor pool implementation
    https://git.kernel.org/netdev/net-next/c/d171ce3d9888
  - [net-next,V2,05/12] net/mlx5: HWS, Cleanup after pool refactoring
    https://git.kernel.org/netdev/net-next/c/43a2038c6d8a
  - [net-next,V2,06/12] net/mlx5: HWS, Add fullness tracking to pool
    https://git.kernel.org/netdev/net-next/c/045626947665
  - [net-next,V2,07/12] net/mlx5: HWS, Fix pool size optimization
    https://git.kernel.org/netdev/net-next/c/a68334f9750f
  - [net-next,V2,08/12] net/mlx5: HWS, Implement action STE pool
    https://git.kernel.org/netdev/net-next/c/983d01b2ce0a
  - [net-next,V2,09/12] net/mlx5: HWS, Use the new action STE pool
    https://git.kernel.org/netdev/net-next/c/593a9470a856
  - [net-next,V2,10/12] net/mlx5: HWS, Cleanup matcher action STE table
    https://git.kernel.org/netdev/net-next/c/22174f16f121
  - [net-next,V2,11/12] net/mlx5: HWS, Free unused action STE tables
    https://git.kernel.org/netdev/net-next/c/864531ca2072
  - [net-next,V2,12/12] net/mlx5: HWS, Export action STE tables to debugfs
    https://git.kernel.org/netdev/net-next/c/3db55f8cc8d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



