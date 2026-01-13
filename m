Return-Path: <linux-rdma+bounces-15534-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A07FED1B635
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 22:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1E9333007646
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 21:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720AD318BAB;
	Tue, 13 Jan 2026 21:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kux567s+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349F4632;
	Tue, 13 Jan 2026 21:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768339590; cv=none; b=EqnMxHMRSBlHHchRYusd0TF1Hw8JcT/EkKK7y0roDpq4BCNDXonq05OSK9myFhpGoJhv5S1BqOtH225fXsjPltlZJemjhPmt93QWyLrwstza5CMjQ2qVfBZtHUK1bWDBze2q28QM0az2vEMLxxbpzxVvmee/ugKfKzz1N2f65uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768339590; c=relaxed/simple;
	bh=DSpGbkss/5fbHFcpztSVDDE/5IHICOG994oOnN1kB9g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s/66N6LzZ4+N4Mx6gp1j94eeUW5eUeNZA1pzUo2E1ZJWsFGMrc2T0E2ZHMadJyeWjCeeUV7xBRyPNNMrolKn0NPkdUveWshdrUkKDDQ73zys8k1rz8k51hHmvxf9X3CXZW3Jq1ILnGZ03c9RdMgUec7FWhOAJMo8sAJ/b7ywgIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kux567s+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02E8C116C6;
	Tue, 13 Jan 2026 21:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768339590;
	bh=DSpGbkss/5fbHFcpztSVDDE/5IHICOG994oOnN1kB9g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kux567s+wJGIxOaiydgPz9mtcsAN0i4v2Txv5Apc9iuFfEP1UAfszB8X2nfEag23K
	 hVzvo0aXrRmqIEQuIqqgqM7GImcNI5v0GcvsYTw6+0DcOlgy/CYFE5+iLB1aBarpTq
	 VZ9FZcSTxp0tLmQIV27c+ESUzRxFczBTRZ+o39Y7s3g3/PrqyGAlg9Zzg7GnmKrUqi
	 LQuP1U+qoXuxa4No+xbiw/hWogv5nrWrbqmL4YnSpPwpyvBrJUZ/O4sULaoIRcDhju
	 9gaL6cXXjjD4kB7BBPEh3hc/h1v5ZrCk2bKcOV/tbp3ka7QqVDBVUGG3NKktZz5fnu
	 GqLGmZwqLlB3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 789C23808200;
	Tue, 13 Jan 2026 21:23:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [pull-request] mlx5-next updates 2026-01-13
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176833938330.2413578.6783157955963748240.git-patchwork-notify@kernel.org>
Date: Tue, 13 Jan 2026 21:23:03 +0000
References: <1768299471-1603093-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1768299471-1603093-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 alazar@nvidia.com, ohartoov@nvidia.com

Hello:

This pull request was applied to bpf/bpf-next.git (net)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Jan 2026 12:17:51 +0200 you wrote:
> Hi,
> 
> The following pull-request contains common mlx5 updates
> for your *net-next* tree.
> Please pull and let me know of any problem.
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [pull-request] mlx5-next updates 2026-01-13
    https://git.kernel.org/bpf/bpf-next/c/c9dfb92de073

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



