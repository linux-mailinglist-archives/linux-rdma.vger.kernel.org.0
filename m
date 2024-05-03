Return-Path: <linux-rdma+bounces-2247-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFD18BAFA4
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 17:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E53421C221EA
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 15:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04B24F8BB;
	Fri,  3 May 2024 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qm2Q8RYo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEB4A955;
	Fri,  3 May 2024 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714749628; cv=none; b=rl8eqPQmYRfiI92772ccnlb0bVL9ssCUPgyuWorJgfs1JYoH3MnXN6QA4GgufYs+6udpNWsAATE9sXg69+9Gfw1JuPrTjFKXDRZDi+sIw0PLYMJsmwI8LPxL+1GgGHSIhLgSBPQ6pf8audOJtBS56Xit+urJn8dvHDGogwptdkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714749628; c=relaxed/simple;
	bh=99vnTIpgfp2UODuk9ex+yfRHusyD8Psew4U7hb/tsyc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UNsn8bl6yA1WTa1aEYcrR9LylJonl+nYe1Hp6mfPdVUX+9sQrEhtIayhQqjnL1OoNcQRolr4sLtC3Ug+5YrpIi+6Sa5k7RVO5x5UH0GThdNJ22IJ5UBG85VWToXVG50XKt9EbEui6mUqVEtyQsNlO0nsY1lVMHgChb5Ou300CJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qm2Q8RYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CD0BC32789;
	Fri,  3 May 2024 15:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714749628;
	bh=99vnTIpgfp2UODuk9ex+yfRHusyD8Psew4U7hb/tsyc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qm2Q8RYoixjRDBOJu3k+Pksnz8MLfS/RK1OoaHSFuNpVGuQ44En3gy6gdXROqfObh
	 1bOp1qjPiO72vPwKAQm1KnK/5DCIM55UkXNwhoFlxXj2wv2SXaC4nl//ffjAUc3LjS
	 aK1hZ7K5dVhi0PO2+ww/P/ypQ8hN4c11o/7zRP6eHbm77Lz7JdNjTTEv8NVZZ+lV2U
	 H1Q/v+5yb0q7IEtxLbWtlzjgyQJKiRFfsEas4tKxLMBT/bmZSZpJtGyqMOKw5hIP8P
	 BT6YISVghOObmhKQYc0jw7uuSRzgoFtKAhURROrEUnrtxi+Ly+zLy1lx0xxw0VHmp2
	 l/Z4IfSkEnLaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18F10C433A2;
	Fri,  3 May 2024 15:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next 0/2] Extend rdmatool to print driver QPs too
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171474962809.564.7254054203723498127.git-patchwork-notify@kernel.org>
Date: Fri, 03 May 2024 15:20:28 +0000
References: <cover.1714472040.git.leonro@nvidia.com>
In-Reply-To: <cover.1714472040.git.leonro@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: dsahern@gmail.com, leonro@nvidia.com, cmeiohas@nvidia.com, jgg@nvidia.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Tue, 30 Apr 2024 13:18:18 +0300 you wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> This series is complimentary to the kernel patches that exposed to the
> userspace the driver-specific QPs.
> 
> https://lore.kernel.org/all/2607bb3ddec3cae3443c2ea19e9f700825d20a98.1713268997.git.leon@kernel.org
> 
> [...]

Here is the summary with links:
  - [iproute2-next,1/2] rdma: update uapi header
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=e459ea4392c4
  - [iproute2-next,2/2] rdma: Add an option to display driver-specific QPs in the rdma tool
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=57d7a8fd904c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



