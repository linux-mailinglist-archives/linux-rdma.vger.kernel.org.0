Return-Path: <linux-rdma+bounces-14274-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B70A8C38BDB
	for <lists+linux-rdma@lfdr.de>; Thu, 06 Nov 2025 02:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998541A23558
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Nov 2025 01:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B9823D7DF;
	Thu,  6 Nov 2025 01:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvm36Yvv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B432623B63F;
	Thu,  6 Nov 2025 01:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762393841; cv=none; b=KAewqAoAgKwmgQPOIJne4MrV5xRIvhaFGn3upDAT94wPYauQ2mZl2D52fSNwXV38jHnr+nsLRRdtXs6FwhTU8DArrpqBDxijjTrgsRULeaioj/wGjv4h1yPFMYVuFG+EnHS4m7Z0Z6fntW3Lx71DO8Aqk1YoSULOfnwh8WRDTkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762393841; c=relaxed/simple;
	bh=lNkBiARZtn/rKskJaEUZ4Wqa4m4tkJPpwzva2NxnKBU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f/+Em1PF+2JFR57MgHIqAK6cQ+1QwC/4VAGDIJSTfiWogZDum7nRmiw0Q1terPam2qfY1AR1COrKsxyq7V2L/h387JOLiDFjRskdtWSjkqDN68goavHKFDkq/LMKQzcWeyjaRd0EcPO8GL8k7A0S8jvvGiFb9KlH3T60OZpzfnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvm36Yvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CC0C4CEF8;
	Thu,  6 Nov 2025 01:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762393841;
	bh=lNkBiARZtn/rKskJaEUZ4Wqa4m4tkJPpwzva2NxnKBU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cvm36YvvGML8N0jW9IhuxhCHYKSG9tF7bZrsc8REFl8755kA0n1fmQkoAE7UFUB+3
	 2P0oatr6lGLbhp5uYIl3+NIh03F3q6QU6IloJCtr1gr7GwRa/cUth+DJscV4IcehyV
	 +H+LTj1rZiPXNiY7puJP6w9Rzo5n01UKIxIa3riRS1ODbaun1gqvWqmmketA/XNiGr
	 uN26cfL3YBh3eqRf5Z6gh1JTrZdHhx0HZ6555Q2RFDK0UOkLYcw9SzPh9Og/uTE1jK
	 n+V0Et17j/Ni7IEP2mX3eZ0hGdQNbHRy/PRwq10TxgACfnOryJiFnybr+Rfvfw7ag6
	 R00x1Es+m8M4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD6A380AAF5;
	Thu,  6 Nov 2025 01:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/mlx5e: Fix return value in case of module EEPROM
 read
 error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176239381424.3828781.3734885280355871994.git-patchwork-notify@kernel.org>
Date: Thu, 06 Nov 2025 01:50:14 +0000
References: <1762265736-1028868-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1762265736-1028868-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 alazar@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 4 Nov 2025 16:15:36 +0200 you wrote:
> From: Gal Pressman <gal@nvidia.com>
> 
> mlx5e_get_module_eeprom_by_page() has weird error handling.
> 
> First, it is treating -EINVAL as a special case, but it is unclear why.
> 
> Second, it tries to fail "gracefully" by returning the number of bytes
> read even in case of an error. This results in wrongly returning
> success (0 return value) if the error occurs before any bytes were
> read.
> 
> [...]

Here is the summary with links:
  - [net] net/mlx5e: Fix return value in case of module EEPROM read error
    https://git.kernel.org/netdev/net/c/d1c94bc5b90c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



