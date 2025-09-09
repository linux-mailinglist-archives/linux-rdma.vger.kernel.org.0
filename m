Return-Path: <linux-rdma+bounces-13213-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 337FCB502A1
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 18:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D73444E31B5
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 16:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BB235336E;
	Tue,  9 Sep 2025 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nE6B5w0v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C3735334E;
	Tue,  9 Sep 2025 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435407; cv=none; b=B4Clmt/dZjTfmAkSduXz5TVeQLLCMDxTjEcCGw6AQZ9JnIOT11nX6u3ho/lawROJz8MbzOy45JgXoY24LbK0QctGUBctf3G7DBgi4FqTcZrI0dNZUiJaLjI416OdaIRS0erxUdECXgi9XAsfNR7C6cZmDNpFsm2jsJaIHVXS3O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435407; c=relaxed/simple;
	bh=1FrTFQegLMPf4rExfQJSq3w/87niSAf4DZz4h61zS/w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eSX4HzrukqIw6d5G6xcfAQnGMgIhklboMAj2M3EIVeQT6sw/ygLqmQznH5gmBXZ7m8tw9G7oFrcr5DTdc0bH5bwYOw3a9IjXVsgX/1tY0bqqBtKIxrMdpGDFT7fkjSsqkD7X3bFmfYm3CzcmXbL82BbREv6A69ipMKrntNuuYOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nE6B5w0v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2080C4CEFC;
	Tue,  9 Sep 2025 16:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757435406;
	bh=1FrTFQegLMPf4rExfQJSq3w/87niSAf4DZz4h61zS/w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nE6B5w0v/sgqM11ozGC28AQMUao7r8u/u85YbLptE9mfKcOOUq8M+g2Hthsb1JjGC
	 ImDzhdRW5kl0YgcMSKPnt2C/MtY9sal2zKFk4kzoLyBBItmTIbAI40ozxa7kIGbliK
	 vWOgDhbUQhcA787HP+3qLotwfcNmKSli8KUt/AorMeRg+y1aEHAd78kKYTrp7vkKJ0
	 cyQ1O4pE73fjmOiPMfCEEGGdpqOFWkBj41QQVrHXsbXxIjjeRJFjPLldIc9eENNK+m
	 gls/zwh1vyA/d1zZYEd8d//qR6CONzbHdLvhFinNEBjlpNRWkWm3rreMh4GrzYbEvB
	 ukyIjc0Epanjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EE0383BF6C;
	Tue,  9 Sep 2025 16:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [pull-request] mlx5-next updates 2025-09-09
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175743541000.739384.14810234356517103146.git-patchwork-notify@kernel.org>
Date: Tue, 09 Sep 2025 16:30:10 +0000
References: <1757413460-539097-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1757413460-539097-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 9 Sep 2025 13:24:20 +0300 you wrote:
> Hi,
> 
> The following pull-request contains a common mlx5 update
> patch for your *net-next* tree.
> Please pull and let me know of any problem.
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [pull-request] mlx5-next updates 2025-09-09
    https://git.kernel.org/netdev/net-next/c/3b4296f5893d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



