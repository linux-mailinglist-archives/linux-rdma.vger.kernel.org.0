Return-Path: <linux-rdma+bounces-12010-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1342DAFF6E5
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 04:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F6A1C83B9E
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 02:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992B827F187;
	Thu, 10 Jul 2025 02:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+O5+HW2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D01621C190;
	Thu, 10 Jul 2025 02:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752115191; cv=none; b=amNyEgd5CkM/Ub510RCbjP1eoRWgqyDwy3krmqnkZKbBd4VOpzF2A4Mf2YInVIG0YfekVSYEhUwHf1gPUCXaqY7D9wUTJScxaKX1+XATw+Me5DviIDKFfLfanlwZAVmkuUQ6paH+aPmgwJjPeHVMzQVucxXQCtwBm7rLfSzAoMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752115191; c=relaxed/simple;
	bh=r9cERJLQckVDliYE6WC2ZseWVdstUwuHmZ56Rk6/G1s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g7G5HaUBBRqrxa4FiLvFn7jyBOr4TLRu83TLEs23Y+xdCnr4HoLbSFPuId59+qkyJ1CUyU7V/5fCOCFuj55gD2sDsHTjoUtfUsnST3AF9PKNgI1AiylcTIrk0o9U6SlOHd5mm0WWh4qzSGYGfn+7xvbcxd36PL+g5iZw8TwVdjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+O5+HW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA433C4CEEF;
	Thu, 10 Jul 2025 02:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752115190;
	bh=r9cERJLQckVDliYE6WC2ZseWVdstUwuHmZ56Rk6/G1s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u+O5+HW2on9nxG0cIIhMyfd8TCZk+x8bCVlGlbe3Ef8XrryO1HGbXpJOFiuCV3q9Z
	 tvHY60HTCliiFGsuTdfaF7jsVOmE6D3iZBwwqt9V/ts5IQORrtSgbaWBB3ywfbWnty
	 /gAkpTARsWsKeOYzB9DF18e+ebZqX2heDkcm8fk4jjozo66b0kLtKCgRbzGaC0EaZw
	 16TOajwtPLs0PXNch0voBzfp8oTFqx4XQn1WIqr4wsYIClUNwtAzF8cFZe/dhtALbb
	 hCQUX3tK1w5FuaKSwfZ/sLiuLyY0pPSzIcU+Xk46VcA4vzie0Zabxw80tp3mS4N1D7
	 3R9/eJiQ6qdiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E13383B261;
	Thu, 10 Jul 2025 02:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] Converge on using secs_to_jiffies() part
 two
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175211521326.965283.15095098837073664793.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jul 2025 02:40:13 +0000
References: 
 <20250707-netdev-secs-to-jiffies-part-2-v2-0-b7817036342f@linux.microsoft.com>
In-Reply-To: 
 <20250707-netdev-secs-to-jiffies-part-2-v2-0-b7817036342f@linux.microsoft.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
 sidraya@linux.ibm.com, wenjia@linux.ibm.com, mjambigi@linux.ibm.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, akpm@linux-foundation.org, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 07 Jul 2025 15:03:31 -0700 you wrote:
> This is the second series (part 1*) that converts users of msecs_to_jiffies() that
> either use the multiply pattern of either of:
> - msecs_to_jiffies(N*1000) or
> - msecs_to_jiffies(N*MSEC_PER_SEC)
> 
> where N is a constant or an expression, to avoid the multiplication.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net/smc: convert timeouts to secs_to_jiffies()
    https://git.kernel.org/netdev/net-next/c/4814f9110ec6
  - [net-next,v2,2/2] net: ipconfig: convert timeouts to secs_to_jiffies()
    https://git.kernel.org/netdev/net-next/c/31326d98416e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



