Return-Path: <linux-rdma+bounces-9384-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C71A8684E
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 23:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1614B8A5F0F
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 21:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0017829CB3D;
	Fri, 11 Apr 2025 21:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYxJQbql"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB61429C357;
	Fri, 11 Apr 2025 21:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744406995; cv=none; b=NdS7IUoeEx2gVRR+nsT6DYZTeJ7R1eHLNCxhhjfbUYgyTcOUc6Flz4l3qBn9R9KEZXKFl4pc4ePMU3+jbGCfT8cGX5Asl1In8QtpUxcsY8yr81X878NOb+Et9OJt992FAnbpkorHJaGQLKXat8FZuXjlTGh8NG7FzAzQBsXUOs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744406995; c=relaxed/simple;
	bh=+ChOOLxL7cFGhKxXGQdKLkWWQdy6VsFX3CQDM1wx2fM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KGJ7e34PcL1nunNhfo+gs7tm7ozTHJssugGq3TiTmeqnsnE40mX6Xvz/Vb6GZ8vQCldp+ZLCEHoYMYMuNrP2CHKauRHXsQ3c+xAwEuUFn8UZ8upPxlRv/mIcs58rZ+FcH2lHePR0Dz0Sf8JSD4KT0K+odXbsB62zDy8TaCblA7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYxJQbql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20594C4CEE2;
	Fri, 11 Apr 2025 21:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744406995;
	bh=+ChOOLxL7cFGhKxXGQdKLkWWQdy6VsFX3CQDM1wx2fM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lYxJQbqlhw/sRFLZu2o5Ivliss7ugOFi+6xfm/5uPzF3Iuiu2lgfVH8QUA2EU9J0Y
	 rw8PxEi17SzRkoz2u3ScGHAe7aIjHvPj1cbqRRlUqYNvNeLtwSf5JBpPeXi+g9ya6D
	 PEeoeJGx0pQC+mwAY4eUHdp4S/kD15H2mUFUKcMta8D6xhwnT2ghKe8ncwNwhFYze+
	 b1soZRI6rUN8oVoB0jKbgBKn5H/mlOuFHgFUSq9r/j5PZ1n15sHw9jCweDlTaVVffr
	 +moWQuyusKPV3e1kmlq2Sx2rmBJV4pz1cvBarEjfmMVvteedmCU5Ho63K9Ydv/QQKC
	 WJbZQBrWrLj8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE8B38111E2;
	Fri, 11 Apr 2025 21:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] smc: Fix lockdep false-positive for IPPROTO_SMC.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174440703276.491439.12735611254481125457.git-patchwork-notify@kernel.org>
Date: Fri, 11 Apr 2025 21:30:32 +0000
References: <20250407170332.26959-1-kuniyu@amazon.com>
In-Reply-To: <20250407170332.26959-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, dust.li@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 syzbot+be6f4b383534d88989f7@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 7 Apr 2025 10:03:17 -0700 you wrote:
> SMC consists of two sockets: smc_sock and kernel TCP socket.
> 
> Currently, there are two ways of creating the sockets, and syzbot reported
> a lockdep splat [0] for the newer way introduced by commit d25a92ccae6b
> ("net/smc: Introduce IPPROTO_SMC").
> 
>   socket(AF_SMC             , SOCK_STREAM, SMCPROTO_SMC or SMCPROTO_SMC6)
>   socket(AF_INET or AF_INET6, SOCK_STREAM, IPPROTO_SMC)
> 
> [...]

Here is the summary with links:
  - [v1,net] smc: Fix lockdep false-positive for IPPROTO_SMC.
    https://git.kernel.org/netdev/net/c/752e2217d789

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



