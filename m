Return-Path: <linux-rdma+bounces-8651-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CAFA5F418
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 13:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3897189EE89
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 12:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4352C266599;
	Thu, 13 Mar 2025 12:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eP310P8n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05DDFC0B;
	Thu, 13 Mar 2025 12:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868409; cv=none; b=rbGEh3WW4p+bLPG+nfXMFiqGEP6A9jdYX2GQ08c27fzJjB9FGONvOYht4SWIEuAXu7Z1KPpfg6WWRrq2Op9tJTLdsci1MWCcP2I96idhTRHAYm66bBr6jv41+NvslqAGEKTN0+Rm7nU5yFCiloUoNqlu8gBaYbhNGIsIWXTZxl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868409; c=relaxed/simple;
	bh=uqFaBSHIs6hkpHAepTQUQWUex2GHDEOlYVmk4sFY0oE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IModOGShfQkU3aRrOvbvMbmCW+pxnFUg4Vlcc5EaQS3rScC+U+dgCA3bVJTbm6KibzQVGMKpYdk9S6rMbCeahUDCBfRXEnNhd91w6udzrL5U5veNsmFSq42NhNK3t9W96fsLHp5ZgaZY9NMiV917KQNbG/ZZ7DAcgWXS/lqfV5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eP310P8n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E75C4CEDD;
	Thu, 13 Mar 2025 12:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741868408;
	bh=uqFaBSHIs6hkpHAepTQUQWUex2GHDEOlYVmk4sFY0oE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eP310P8nPsrfZu0rtZD6xG7FK3e5o9rKliwQp1gQBO339+T1RqyCDZD2G0LD5wcud
	 JhmyGLFWYuvN/qsevv8ocEQX/oYzpUJONLlxxAMSnTSvodyjcSTmGOJekTwxgNk+Ix
	 lBCly7Niqz+ZyQcm1Fqv31PXDVgDuKgCPja0kMNx5ThAqqPw1oylMUrMbCcoaAAkNQ
	 jPsg9JnSI9G0grfDBs2e2TXNdhZVFAapmZRMfIrAdHwPEw2jXu5KBZItRiYIaRxvxx
	 SGxJbh/UHQGuIEogUns6zc/S+YOSdS6nuBQ5KPqAzUYEsDrGsT+Vd/EqHFyHb7EbsP
	 pKZ3McP8B/oCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D543806651;
	Thu, 13 Mar 2025 12:20:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/6] mlx5 misc fixes 2025-03-10
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174186844301.1489828.15120756086422441476.git-patchwork-notify@kernel.org>
Date: Thu, 13 Mar 2025 12:20:43 +0000
References: <1741644104-97767-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1741644104-97767-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, gal@nvidia.com, mbloch@nvidia.com,
 moshe@nvidia.com, saeedm@nvidia.com, leon@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 11 Mar 2025 00:01:38 +0200 you wrote:
> Hi,
> 
> This patchset provides misc bug fixes from the team to the mlx5 core and
> Eth drivers.
> 
> Thanks,
> Tariq.
> 
> [...]

Here is the summary with links:
  - [net,1/6] net/mlx5: DR, use the right action structs for STEv3
    https://git.kernel.org/netdev/net/c/03ebae199255
  - [net,2/6] net/mlx5: HWS, Rightsize bwc matcher priority
    https://git.kernel.org/netdev/net/c/521992337f67
  - [net,3/6] net/mlx5: Fix incorrect IRQ pool usage when releasing IRQs
    https://git.kernel.org/netdev/net/c/32d2724db5b2
  - [net,4/6] net/mlx5: Lag, Check shared fdb before creating MultiPort E-Switch
    https://git.kernel.org/netdev/net/c/32966984bee1
  - [net,5/6] net/mlx5: Bridge, fix the crash caused by LAG state check
    https://git.kernel.org/netdev/net/c/4b8eeed4fb10
  - [net,6/6] net/mlx5e: Prevent bridge link show failure for non-eswitch-allowed devices
    https://git.kernel.org/netdev/net/c/e92df790d07a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



