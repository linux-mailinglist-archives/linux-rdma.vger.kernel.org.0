Return-Path: <linux-rdma+bounces-3875-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6133931B3A
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2024 21:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70B241F22D60
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2024 19:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E839139D00;
	Mon, 15 Jul 2024 19:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHMNd++A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1FA71B3A;
	Mon, 15 Jul 2024 19:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721073034; cv=none; b=fBBT7YnyAZiNNqkDWH9x/HZeTHjzJei8BNrbJxvwzw5bitOKGysk0X8H/VuJMtaE2PS1mXzLiIp/fX4tmkbEjJuaCVee/p/w25kMTUP/B/+V8gAcE/eGKhMcWGOYUYHtJCLPzbkpBotgt+N/YKTdF1eMztzfmCZAcVx1Mk0gjp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721073034; c=relaxed/simple;
	bh=g+dmIMX6lXjBSHP7MOuzpqAv8psnN/6mhAgo4RhOcAs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qt/z8TEZl1ocR41g4C6wZFVFWbRkvueD1wDH60Gm/4Es/cbuOqKKxEPhXubvrQVndqjL2q/txtzmGEbwU4dav4ppatck5+eBL9joMLJH/BO7gq3u4yBPc08oRjRJHXZbzVc1fAcWGtpzpsfliYqt0+n9Ph7OTHdFgh59veI+Vn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHMNd++A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81A4DC4AF0B;
	Mon, 15 Jul 2024 19:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721073034;
	bh=g+dmIMX6lXjBSHP7MOuzpqAv8psnN/6mhAgo4RhOcAs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rHMNd++Af7TvZbOm7CuTVISiGsamul48riqDx2BPloH517OCA79ms+cBmhI0k1axW
	 aMnwxujyCBcQOAL9n/7PjyMwWoHgxErYAVn628QnSzjwqe5w5rZ3qvWk3LkOaH05Go
	 I2Td+aGaIBl+pMoTzhWxibCvExsfAV7mVqZmpDG2CQQOgrYs1FRt7wLhf1Pk9eoNEh
	 8PZbsXxtY+awA1A0ljUhhvuUdwo5+7eSYhQWCaOgRuL9E2p4wPBnZO+MtsXZMQJRAv
	 T8eX2M9GnP92DPQ6gOJS26e6Mfpbb8EpxhAFxakFolj4qZW7wABu8s7EaaemZ1JmpY
	 P66JnDolAy5HA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6EA2EC4332E;
	Mon, 15 Jul 2024 19:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL mlx5-next] Introduce auxiliary bus IRQs sysfs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172107303444.9322.7675483931380584580.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jul 2024 19:50:34 +0000
References: <20240711213140.256997-1-saeed@kernel.org>
In-Reply-To: <20240711213140.256997-1-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, jgg@nvidia.com, saeedm@nvidia.com,
 linux-rdma@vger.kernel.org, leonro@nvidia.com, netdev@vger.kernel.org,
 gregkh@linuxfoundation.org, przemyslaw.kitszel@intel.com, parav@nvidia.com,
 shayd@nvidia.com

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jul 2024 14:31:38 -0700 you wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> Hi Jakub and Greg,
> 
> Following the review of v10 and Greg's request to send this via netdev.
> This is a pull request that includes the 2 patches of adding IRQs sysfs
> to aux dev subsystem based on mlx5-next tree (6.10-rc3).
> 
> [...]

Here is the summary with links:
  - [GIT,PULL,mlx5-next] Introduce auxiliary bus IRQs sysfs
    https://git.kernel.org/netdev/net-next/c/dd3cd3ca691d
  - [mlx5-next,2/2] net/mlx5: Expose SFs IRQs
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



