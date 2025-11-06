Return-Path: <linux-rdma+bounces-14275-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF60C38C7D
	for <lists+linux-rdma@lfdr.de>; Thu, 06 Nov 2025 03:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54B091A215E5
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Nov 2025 02:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7E5223705;
	Thu,  6 Nov 2025 02:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxSpHeax"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F7442AB7;
	Thu,  6 Nov 2025 02:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762394456; cv=none; b=YUeMjL6vmHyCrknSKgYE6+tV8vuN14hB8FAO9aKu7V4+eyOxYMBOEzTR43QP4J5uVr3RiNZ5hddoLJU2FnSIiZ1CGtLKQFnr55qHuEvo9T+tvGf6QjoMLXbxQIY60coNeNl51Zeu6fxLCyRzpaVjRUruh8woXiN0kGntVl+dpD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762394456; c=relaxed/simple;
	bh=kzLtt6qwyBNSg7lFnyPPmRWw++wOlJmkZoguF9KUNpo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iqNh6l/TA18VJPrHYoVs12ZnX7KUR8CJMguzYMWHzbvHeWIMd9gDc5RFLwb3eQJv2RK5eC1RuW3YIJADDeVcaoUGJXosbux1b6NvaWH2BvnVV4hJn7Yp3sUoyDKegst9Q4FA05Xlg8JvbN6p39w8G3Ljhl9FahTMyr7pi/dLzoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxSpHeax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4545C4CEF5;
	Thu,  6 Nov 2025 02:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762394455;
	bh=kzLtt6qwyBNSg7lFnyPPmRWw++wOlJmkZoguF9KUNpo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cxSpHeaxSVTdp+PI9qsOAM0wftYnAbpoZbYDrN0od1oiNOqLBvn+9SPxMg2JpQyWd
	 o6a5oGr1GyLHIvUJJy5mno5iW9biBoR+BYHNPNNBVUs9AhZu/Vk+vhnEqe0RRIxxHa
	 jn9fPjN6QBv9p9Ha2ZTLoeoJrNHan12b+m4CdrvaRxzmK6mQeY4EA+vO4mhI965yst
	 7+opVfgcoZjNisWX06ZAptrUKkvp6FR/1P+qUYn+GQP1jnCJDd4Uy6ZQ+2Q86KYWdE
	 n5DhMPJNujux2NhedAGI8d4RNAsqnFMWDntRE3K3zAn2T1Qr1heDLz0Cg/VfE4hFqs
	 8BRwY5wWHBn0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B4D380AAF5;
	Thu,  6 Nov 2025 02:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V2 0/3] net/mlx5e: SHAMPO fixes for 64KB page size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176239442873.3831359.7427376111702037221.git-patchwork-notify@kernel.org>
Date: Thu, 06 Nov 2025 02:00:28 +0000
References: <1762238915-1027590-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1762238915-1027590-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 dtatulea@nvidia.com, horms@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 4 Nov 2025 08:48:32 +0200 you wrote:
> Hi,
> 
> This series by Dragos contains fixes for HW-GRO issues found on systems
> with 64KB page size.
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [net,V2,1/3] net/mlx5e: SHAMPO, Fix header mapping for 64K pages
    https://git.kernel.org/netdev/net/c/665a7e13c220
  - [net,V2,2/3] net/mlx5e: SHAMPO, Fix skb size check for 64K pages
    https://git.kernel.org/netdev/net/c/bacd8d80181e
  - [net,V2,3/3] net/mlx5e: SHAMPO, Fix header formulas for higher MTUs and 64K pages
    https://git.kernel.org/netdev/net/c/d8a7ed9586c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



