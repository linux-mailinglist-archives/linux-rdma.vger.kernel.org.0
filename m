Return-Path: <linux-rdma+bounces-6189-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6298D9E19B7
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 11:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41208B29E91
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 09:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D0C1E009F;
	Tue,  3 Dec 2024 09:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPOKnCuu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB9D165EEB;
	Tue,  3 Dec 2024 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733219932; cv=none; b=cPyjIz0QpOgAudA8CVcdHWcH+tUQS7cIo7JQqpMZeHY/89Fs8Fid1kJ7MooLBEObX6tSHRbQxB4wOxjTGQyfoSvemRtH5uhpFPFaxJouR1ypB2ydShxKqOJ57eIEBXbUG7eZHlfFXkwaIO1iHpxkVi0gQajDnVslSOAeHLm5xLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733219932; c=relaxed/simple;
	bh=0lwgE7WC+1gxQP/K/bJyZwXnuJTzGI7HWnawVbsa/ag=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QezU7Mpy1tuwdKcqunbOczsdSD5Dj+djTfNKcanzDFZZdf3tNwfqQuAm6Q28PnzTHzyUetllOT4PGzopTz+LTMzTNPau+M0TC3f4DRktV3M67X62GELw1ddHudwDWxurnXpvIZ0fjfkP8lxzQuapgYL3hNmaOnXVMMNUPfbBjxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPOKnCuu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B02AC4CED6;
	Tue,  3 Dec 2024 09:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733219931;
	bh=0lwgE7WC+1gxQP/K/bJyZwXnuJTzGI7HWnawVbsa/ag=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OPOKnCuu7nblLPTibZvT8C40XFpjWFjG9u3fl7r8B0z9b6X3IAbOxFeD6tJ6bx0BB
	 Kc6+rEc+Z1KzCUkaW2So9+5ggZIjI5TZ9wnv19kts76ztD0dpBqbU9gjRHaSHIrBXf
	 nQDDgYLhqRo4nwEGOZVs4f/rORGyXkpkdK6YZG1p8LKQch0PAu0mV5fJtnsl0Qqccs
	 nAhLHwLEupH12FwaMJnfC52XF+gtAqOY4HmBQujO1bgs49kYkkvlTlpEluTD3Vg4HC
	 9Rb4WGwqMDWzMBgu0QqB0wfgjMyKMn1fMCAt2Atcvlez849lolHWXUPPAfr0/EVdMF
	 8i8rx2lDj3xvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1893806656;
	Tue,  3 Dec 2024 09:59:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] two fixes for SMC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173321994523.4135237.6293056111747884412.git-patchwork-notify@kernel.org>
Date: Tue, 03 Dec 2024 09:59:05 +0000
References: <20241127133014.100509-1-guwen@linux.alibaba.com>
In-Reply-To: <20241127133014.100509-1-guwen@linux.alibaba.com>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, horms@kernel.org,
 kgraul@linux.ibm.com, hwippel@linux.ibm.com, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 27 Nov 2024 21:30:12 +0800 you wrote:
> Hi, all
> 
> This patch set contains two bugfixes, to fix SMC warning and panic
> issues in race conditions.
> 
> Thanks!
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net/smc: initialize close_work early to avoid warning
    https://git.kernel.org/netdev/net/c/0541db8ee32c
  - [net,v2,2/2] net/smc: fix LGR and link use-after-free issue
    https://git.kernel.org/netdev/net/c/2c7f14ed9c19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



