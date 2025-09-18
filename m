Return-Path: <linux-rdma+bounces-13507-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3ADEB874FB
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Sep 2025 01:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E1B1C86F2B
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 23:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB082FDC50;
	Thu, 18 Sep 2025 23:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NefzThXk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565FD3148D9;
	Thu, 18 Sep 2025 23:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758236416; cv=none; b=j+CdSrC+T/gSQNymwWFcY9busihgHrL/QCd7szSOdIBX2z0FuDP9IG570dGS/Ss26b7hCwjEiVc4qanLZwtZfFjJWyTH2cQv0r5oFax8RC1pKRQ/75vbAtJsL/lTxovzaRNX61B7h2SUiXQ3FEt1Qgml5b0j92zlAreyucnDriI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758236416; c=relaxed/simple;
	bh=q2apUNbIoJYtUW8uvJSz+vUsPpZ/T3HqQwF1KsydVHI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=legHhK60Rqv5jJj6YeHr05Kwi+HTdbzu+Rd7c9QCjjKZxPL1bLOW3FQQpOO+Dkl19AYG98fpBAayjSPBolXDnWNibcxFJqG3mrqCQLTptfotEc7d2Q8l12cVdVD7zeuLInAbVOxOw445ZS5A10PZbDQUMPw/jd298PP/boSjCPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NefzThXk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35ABC4CEE7;
	Thu, 18 Sep 2025 23:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758236415;
	bh=q2apUNbIoJYtUW8uvJSz+vUsPpZ/T3HqQwF1KsydVHI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NefzThXkwQ0esMBzCJtcU36YreEBKq3a10fKMmCzxAhqdaYlj6xWQXFc4TfuBIDEj
	 fyDlduMjJuqQcmf3GXZoVsxt5POcK+DGwIFuA99OE6lYyFiw9aGvsgEBYA67JioAgY
	 /ZUF8WFf+beZ03ckar6rraCwlilWXw6doPbwO35zu6BbW8KoE0rhyw17+1VRPeggXA
	 4esRXg00zYhxdRAkuGnrQVdTfz8m5m5caAcQcZaqYgipuZYBRmDA5e0rvtYatOBELi
	 34ARaYy7sjimyel4s6UqfAjzD4Ktieitm5OYJ4wImECfwcoVeGs+epqiVzvtWDaNLq
	 6XNewbHmvnEGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFDC39D0C20;
	Thu, 18 Sep 2025 23:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [pull-request] mlx5-next updates 2025-09-17
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175823641549.2980045.8544368124292888168.git-patchwork-notify@kernel.org>
Date: Thu, 18 Sep 2025 23:00:15 +0000
References: <1758104780-642426-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1758104780-642426-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, sd@queasysnail.net,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, cjubran@nvidia.com

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Sep 2025 13:26:20 +0300 you wrote:
> Hi,
> 
> The following pull-request contains common mlx5 update
> patch for your *net-next* tree.
> Please pull and let me know of any problem.
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [pull-request] mlx5-next updates 2025-09-17
    https://git.kernel.org/netdev/net-next/c/38c5b9c38be8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



