Return-Path: <linux-rdma+bounces-12400-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 170DEB0E818
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 03:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CF7E1C886D4
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 01:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9261991DD;
	Wed, 23 Jul 2025 01:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/mO1gft"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71E814AD2B;
	Wed, 23 Jul 2025 01:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753234217; cv=none; b=u230dnD3FnVAOJJ7Hw2NirkFlh6fZSxO9aqhkn54ux4ZiJ6jQjfE4ZJqbRyLnzdOdleg/k9MNn038D8xH2eKAWa2ufaPNohpp97KxE9i/M48JDxHJGvChob+zzMBgdzpF6jn+1u/xzbVoC9rUh9Se4qxiLmfDmYZe376srJh8jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753234217; c=relaxed/simple;
	bh=4838LBuED1RKEU44f3tZgp9qmR8UcWkI2E2Kz7DrVPI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UF1LcehOMnqsMKZxp1OM2jJoYcil1FAvUQQCOhc3RcoxcbeuMsWkCrV2UTKloCM88CYeZWi2aR7deGOqKaj/PuQvGQHvYbIRlX3HxoVxGmVqXeNaj9lfjnpNdehlW9ElopD8qMzXdJ4iuy9w1nKLARr1XDiBlOncnEhN8vohZkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/mO1gft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF4EC4CEEB;
	Wed, 23 Jul 2025 01:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753234217;
	bh=4838LBuED1RKEU44f3tZgp9qmR8UcWkI2E2Kz7DrVPI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V/mO1gftrXtijsCG7jFJR136aYuVy+tWFMUsvrGkhfZxiQ/VvtC+l/zREkccFLt38
	 mVTjVaGhtEngjSVgRgUGeMp86FPDYP4n1xzKE5Kda8rIabbBPZpsNw69Qdc+3Jr9K2
	 5GpTyXFC+3F7xtgoHGosCN722kAMxg/F0ZH0UTvrStZJ3t0jgBm7EpzkhrpabM5EY6
	 VKCWheLSVA/W6e0TMp5RU6tMzRgHkwNiTjfv9gVg6blQ6bYRk+ZOgJQp7h0rRYLBo+
	 Eam4gFmW7Rp49T3H8Sj9XJLwykQjaUVx2wPA/As69NF8MMy/GKOixs8UQpDVXo/oOW
	 HMWCbjLR9j9PQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD5F383BF5D;
	Wed, 23 Jul 2025 01:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V3 0/3] net/mlx5: misc changes 2025-07-21
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175323423556.1016544.17877785294390139794.git-patchwork-notify@kernel.org>
Date: Wed, 23 Jul 2025 01:30:35 +0000
References: <1753081999-326247-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1753081999-326247-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, lkayal@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Jul 2025 10:13:16 +0300 you wrote:
> Hi,
> 
> This series by Lama contains misc enhancements to the SHAMPO parameters.
> 
> Find V2 here:
> https://lore.kernel.org/all/1752675472-201445-1-git-send-email-tariqt@nvidia.com/
> 
> [...]

Here is the summary with links:
  - [net-next,V3,1/3] net/mlx5e: SHAMPO, Cleanup reservation size formula
    https://git.kernel.org/netdev/net-next/c/bc2d44b83f2b
  - [net-next,V3,2/3] net/mlx5e: SHAMPO, Remove mlx5e_shampo_get_log_hd_entry_size()
    https://git.kernel.org/netdev/net-next/c/eee529c0044e
  - [net-next,V3,3/3] net/mlx5e: Remove duplicate mkey from SHAMPO header
    https://git.kernel.org/netdev/net-next/c/eeaf11464f38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



