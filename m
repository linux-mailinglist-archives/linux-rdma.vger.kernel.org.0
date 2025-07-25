Return-Path: <linux-rdma+bounces-12486-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 896C4B12760
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Jul 2025 01:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16D01CE1D76
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jul 2025 23:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A4D262FDD;
	Fri, 25 Jul 2025 23:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcZmAadH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39CD262FD3;
	Fri, 25 Jul 2025 23:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485952; cv=none; b=a28fQ3rzo/XJTWMARvLWXR9grjKKbJWKNQ5VRsyXp2U+xc82oHN+2njTbnXOG/gAba/TLSXJTa0npXFGyIcmMbSV8hSrqnKNF0e2ZRT6dCP0dy9ZSF1MT8mvbbnyZfL1WZFT16KNMsxqvJITTwfzmdqnIj1gQLJ6rIUsLHl8uKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485952; c=relaxed/simple;
	bh=l51al/QFedVHOTi6PJmLhdwhub8Z0TdeLred9hEemnc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ivC0tyyXWqxAwcUcXvk2aKemSeYrURZahezSriF11cJI39gYAZEsqzUEyAmyCRHpiPusOhgzUu/7mLCACkcjcJBsYYFpmbXOHSUzcCO3HGhCtDtu81B0FrjuCfV3Trag6dBOuEgJGwWsBHKgxg+Tbri6r5icsQ4cit13qApiZvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcZmAadH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F12C4CEF5;
	Fri, 25 Jul 2025 23:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485951;
	bh=l51al/QFedVHOTi6PJmLhdwhub8Z0TdeLred9hEemnc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DcZmAadHRzsjZV9pZGPGuq7C0piaPvnN/7m4/Edeb8HushFebzIMANBZVQKJyq3wP
	 sUWzKY1jhIZ+5G66HMZZ329Tx0omlOxgZo8/XoiFiXakJbzukxRTl6UIA2wpnDT9KM
	 EGbKXcf4fdbpF5RvAeciLDSZe/SYDtU/Bt7IsBdrb1M+wgtKHbdh/JcMz5+rGJ7Xtk
	 6Qqqh4TnJTlv2yGWYbI7GN6OD0VKesA1/QerYemCjm+kEiR5PSo2lZMeIMXwxQBa87
	 xPbgSIF68DTMLSJ67a4JWiuywPTbBe2tvMxbSXRKmT8KK8TVJ51McNOQL9oQjGj0MI
	 MDG1eHBor1xSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CE0383BF4E;
	Fri, 25 Jul 2025 23:26:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V2 0/2] net/mlx5e: misc changes 2025-07-22
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175348596874.3366157.1851512921541763037.git-patchwork-notify@kernel.org>
Date: Fri, 25 Jul 2025 23:26:08 +0000
References: <1753194228-333722-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1753194228-333722-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeed@kernel.org, gal@nvidia.com,
 leon@kernel.org, saeedm@nvidia.com, mbloch@nvidia.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Jul 2025 17:23:46 +0300 you wrote:
> Hi,
> 
> This series contains misc enhancements to the mlx5e driver.
> This is V2. Previous one was deferred, find it here:
> https://lore.kernel.org/all/1752771792-265762-1-git-send-email-tariqt@nvidia.com/
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [net-next,V2,1/2] net/mlx5e: Support routed networks during IPsec MACs initialization
    https://git.kernel.org/netdev/net-next/c/71670f766b8f
  - [net-next,V2,2/2] net/mlx5e: Expose TIS via devlink tx reporter diagnose
    https://git.kernel.org/netdev/net-next/c/5474ca211819

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



