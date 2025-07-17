Return-Path: <linux-rdma+bounces-12283-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE533B094E1
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 21:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3169C1C4839D
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 19:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611272FE397;
	Thu, 17 Jul 2025 19:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgvTO6yi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162322FE321;
	Thu, 17 Jul 2025 19:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752779988; cv=none; b=CwBLYEp/Z7FZFD1Dl9HkI907trlwpN9RLPwd6UdWRZu1e9V+5EztsRmKB+a+vRJjY7rct3amkSURUfZi+8UmXlQZJbCq650sTGdSjFeNx7N7+JThXkp6Z/kFGm1tBHj81H+LhR03ypF11fjFQOMp8255RkEPVys277B6ArisjEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752779988; c=relaxed/simple;
	bh=pb/j8Q5qVbV5DQi8rmEfVT/4W8kYDiyQSOcCQSIcqqU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=twkO07wy0JH645OCbo4KpHvtvHkzubLSAFRlvB2gq0pgpgd376ikGNBfU/1GiOW/tos+pVg3OBWlZRfCaQ/H5JoTIuFz/NMyK5Dk8Ook9ryaChGSh3QDZVjSXRoCCHquh1nbJYI05QlUGJ5yDkvUG8Xhs1PbdBfiz8N8Nz/76aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgvTO6yi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C215C4CEE3;
	Thu, 17 Jul 2025 19:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752779987;
	bh=pb/j8Q5qVbV5DQi8rmEfVT/4W8kYDiyQSOcCQSIcqqU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OgvTO6yia1qhArh65Z/fn/iEOXQwmAdbq99QDPNyrvv08foI3wcNIfKnHvBYyvpvf
	 Qj4/e1K/BzxSmWcWtbpIlOVIrPuq4WfDDIhy9vYPq5Vh3sjCvTcej8QKndIhW58qtZ
	 EOY3gmCW75pztjT2Zw46gy7DpJZK2LTz/n4od9iq2Z52dg+IZr8pgFJtFEwZaLwiXx
	 eqAKB2noQFAXJZeU+XERI4lZ9pzgcMwESzku1XLqKTTSH6/Z4q6BGhddZn2P3vz65M
	 ZJ54MtEvo2d3dGNMkbj7YiT6efUqm3zaZPZjG7d7HU9AaXoTWMv++6a7jUoVVA6paG
	 alL99IubscXjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD17383BAC1;
	Thu, 17 Jul 2025 19:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/mlx5e: TX, Fix dma unmapping for devmem tx
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175278000627.2046530.16940004452982858685.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 19:20:06 +0000
References: <1752649242-147678-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1752649242-147678-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 dtatulea@nvidia.com, almasrymina@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Jul 2025 10:00:42 +0300 you wrote:
> From: Dragos Tatulea <dtatulea@nvidia.com>
> 
> net_iovs should have the dma address set to 0 so that
> netmem_dma_unmap_page_attrs() correctly skips the unmap. This was
> not done in mlx5 when support for devmem tx was added and resulted
> in the splat below when the platform iommu was enabled.
> 
> [...]

Here is the summary with links:
  - [net-next] net/mlx5e: TX, Fix dma unmapping for devmem tx
    https://git.kernel.org/netdev/net-next/c/870bc1aaa0f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



