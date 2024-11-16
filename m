Return-Path: <linux-rdma+bounces-6010-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EE59CFCB7
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Nov 2024 05:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C908C1F243F2
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Nov 2024 04:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C0718C933;
	Sat, 16 Nov 2024 04:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mY2EEm0J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905EA383;
	Sat, 16 Nov 2024 04:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731732625; cv=none; b=bqRGcz5ZShPVo9dvC0JA3RCJlOcwPSoli0MoTMwnSvOyZTnS5AE90xIwxahMOuqIQSkXYmhwDrK1dXSIz10wl5pJltSOkcUQ9Yze/dljC/tmnjArf2AzQ4yWWIAZ9t5Q7/0m5PtR2Mq1KAA1Sgc/AItE+0MrWVpOBjgSOMhMjIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731732625; c=relaxed/simple;
	bh=Wp/3bTUuSZIVpMwOJ6l+z2mAz641RZAgyosNJpjEb4Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mFyH/t3IouChf41Xj61deUPOP2vR1cR3NkUlbSJVTnN9O9cuTVfsG/+8LwIQat2jdaYOZmxhliLEn8hpSJVPpy3hWYfJcVxptGnU3iHAQWpFPvGXWOjr85KlKa3GrKPRWjGuJ1hpCZA+mgwnzzDiFs6TwXPtsb2gfylN6eqDTI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mY2EEm0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23286C4CEC3;
	Sat, 16 Nov 2024 04:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731732625;
	bh=Wp/3bTUuSZIVpMwOJ6l+z2mAz641RZAgyosNJpjEb4Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mY2EEm0JZF7PECRRkdxV9ePm9QayaLcaijOtgRGQ+d7caHvZInlZvRA2U0ynJwQ0S
	 LWmmd6w71pcsl9p/rWv9qywk1VSv/4SS0pdKFkiGVGMaKmt7OlQ3ZYDBdCEBUGvR0a
	 OC5dFXx+OpiFoTWEmtrcVSvyr6+2Q9sQhWzZfkZmIdKzrMYPhoi44DSXfM7aaDjpxT
	 mIddaftJ/H5cXi6YlGZ/xd2FpVRxk7tLqNXuRQ9BOH336ijlgC3G//Wsl6OTZCr6Uy
	 KJQ3/PPQHZ2oVnTLw7r6/FF6O/D0Z4cxU2MhCwTKpsxRq80lKRiREgDTLf4v5m+pGc
	 lN0nUdpgagdVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341AB3809A80;
	Sat, 16 Nov 2024 04:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 iproute2-next 0/5] Add RDMA monitor support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173173263601.2832829.1658766515617859389.git-patchwork-notify@kernel.org>
Date: Sat, 16 Nov 2024 04:50:36 +0000
References: <20241112095802.2355220-1-cmeioahs@nvidia.com>
In-Reply-To: <20241112095802.2355220-1-cmeioahs@nvidia.com>
To: Chiara Meiohas <cmeioahs@nvidia.com>
Cc: dsahern@gmail.com, leonro@nvidia.com, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, jgg@nvidia.com, stephen@networkplumber.org,
 cmeiohas@nvidia.com

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Tue, 12 Nov 2024 11:57:57 +0200 you wrote:
> From: Chiara Meiohas <cmeiohas@nvidia.com>
> 
> This series adds support to a new command to monitor IB events
> and expands the rdma-sys command to indicate whether this new
> functionality is supported.
> We've also included a fix for a typo in rdma-link man page.
> 
> [...]

Here is the summary with links:
  - [v3,iproute2-next,1/5] rdma: Add support for rdma monitor
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=e0add1aff50a
  - [v3,iproute2-next,2/5] rdma: Expose whether RDMA monitoring is supported
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=be24be7405ed
  - [v3,iproute2-next,3/5] rdma: Fix typo in rdma-link man page
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=98a224f3f920
  - [v3,iproute2-next,4/5] rdma: update uapi headers
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=629e65d2fa1f
  - [v3,iproute2-next,5/5] rdma: Add IB device and net device rename events
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=380a95109c39

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



