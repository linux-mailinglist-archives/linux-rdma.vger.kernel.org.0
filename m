Return-Path: <linux-rdma+bounces-12472-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF62CB11624
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jul 2025 04:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CCC6AE027B
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jul 2025 01:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF98720408A;
	Fri, 25 Jul 2025 02:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLYhLvz1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8D1157493;
	Fri, 25 Jul 2025 02:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753408807; cv=none; b=HBe5aOuNLv2u7izizVanA869+i9Fs0HpMBPL6BVoIZ9GZB+O6vBWEh5K7Jy8toOYQdKM9MUqYhAJRAyu+067W+QwT1YRxQUmvVdnYPaTMX6Ygis2GSGlMetc7RPWotSyxHtObbXDDTGKG20EIYoLjI32liA/l3bOPu3jm7K/MZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753408807; c=relaxed/simple;
	bh=zkocS31WlYFiDnA6xSJ3YUmK9DpQdv9esaDls4Mu1YY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MwNxmNLuDDl1KTbc9LPg3+DeC2ZgCMXGUinhaBC5YyXGtI5jawnF6ZzZF7N0ypA1Dad+a3RJt0z+rXf5aknAQ+xSyQMHbTL4JV+7Lddp4BOXaY0CJWIidPdxcsDfRIZqqV6sxGsjrq4PMVuU7I2I6si+6GJ0R0wNgXFJp40ev4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLYhLvz1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1119AC4CEEF;
	Fri, 25 Jul 2025 02:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753408807;
	bh=zkocS31WlYFiDnA6xSJ3YUmK9DpQdv9esaDls4Mu1YY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TLYhLvz1dHo2F48eaMcp4ZBEs4BJ33A0j2rllmR3a0FHLs1EjxAwPqWqCP57LFCHx
	 sfZ1CYf0Ka0bOEk5oMdgj7gYx8Q1O5PsSNdqJvYpccT05w0L68DRpYPOGlTqLKgPUl
	 UOmYD7o5lYP44YtYcP/yEFoRs9NGVxUSgV2ahAXHUpyvBNZAYVmavyBbkm/FxUDfwT
	 s/40TKzrqVKocptbza7z40NxLxLtRXliGOwXCXVKAbLg6AgSwXA4MnRKhFYseIq8Jw
	 OOQyomsdgmRn1iIfmZMOdHYV5f63KciANcQkHa68+JLrCtUcv3yvXuSLgdsi1EAHaJ
	 5j94m73vOhIFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAB60383BF4E;
	Fri, 25 Jul 2025 02:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv4 net-next 1/1] net/mlx5: Fix build -Wframe-larger-than
 warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175340882474.2604761.13345976638958207304.git-patchwork-notify@kernel.org>
Date: Fri, 25 Jul 2025 02:00:24 +0000
References: <20250722212023.244296-1-yanjun.zhu@linux.dev>
In-Reply-To: <20250722212023.244296-1-yanjun.zhu@linux.dev>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, huangjunxian6@hisilicon.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Jul 2025 14:20:23 -0700 you wrote:
> When building, the following warnings will appear.
> "
> pci_irq.c: In function ‘mlx5_ctrl_irq_request’:
> pci_irq.c:494:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> pci_irq.c: In function ‘mlx5_irq_request_vector’:
> pci_irq.c:561:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> [...]

Here is the summary with links:
  - [PATCHv4,net-next,1/1] net/mlx5: Fix build -Wframe-larger-than warnings
    https://git.kernel.org/netdev/net-next/c/433501270549

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



