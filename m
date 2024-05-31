Return-Path: <linux-rdma+bounces-2718-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB2F8D56D6
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 02:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616FC2894F9
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 00:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D6E15B3;
	Fri, 31 May 2024 00:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILCAb2Ic"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE828A2D;
	Fri, 31 May 2024 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717114831; cv=none; b=MBlbi8X97t9vut9r/A+zLlQzKjVjMWmA1av5EKlrYW0CHDLOkefM2JHFzbZK/NI28d4/i8LbuuFrO/hIkiskcLf2+5oTrNhQEBCbRbFUJKcr1Zka0RAVwvETWq6+Egf7c+QKAXNYwXoRbDlcnvyXZZ3/rfP76BeVxqC3mDeqbcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717114831; c=relaxed/simple;
	bh=j0HvBqn5IKZiXp3LRFTLsljJRdzd49X2RalUE+YYhfk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jt/yaIYMJiL1hazKjIQY6lwfx9jSIP2xK3n8Rpii1nZQS5Q+NeqL33ABW/tiilfA70U8AR5jNQ1wgQTGk3Sn9mQqtOAvuvXhliIW8+g/aUmMqc52JhNgtd/UH+kdd/ezHoy47Ty2aa/tKqbxk0xJ5R+MBVPtHcoY+V2wNSUoAmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILCAb2Ic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA90EC32786;
	Fri, 31 May 2024 00:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717114831;
	bh=j0HvBqn5IKZiXp3LRFTLsljJRdzd49X2RalUE+YYhfk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ILCAb2IccRj9vrmoq5Kpj6TYbP/Xp0UuBC5hdzu/5iKlTD4GztOJ5i3P5k8Og1UYb
	 KSy6G6Ab9Jue0IaSHqkWhxKvF0hsRCGlsPDOP9i3fxM91POfVKk2fqT0sPjdL2lOp6
	 AH1X1NH6GWtQfHb3ZiUa26U/zs4lyYGTQEugdDuo/FJgMYZirZjbCN0G2nuRy5GoPo
	 TFu7spm3Wj5paR25ckZR1dhbNpN0DzJSteAaNAv+ii1+4jQoud/969YVXNzSjDdxKz
	 jgU41pPS3cRueFc8Y7F6z4C8+z2QOA2Q5OtqS0BxKd8AkXn8xUDh1LAqeK6cygZkJv
	 7kv5kcskKWAVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D837ACF21F3;
	Fri, 31 May 2024 00:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/3] mlx4: Add support for netdev-genl API
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171711483088.6873.3753766001129411194.git-patchwork-notify@kernel.org>
Date: Fri, 31 May 2024 00:20:30 +0000
References: <20240528181139.515070-1-jdamato@fastly.com>
In-Reply-To: <20240528181139.515070-1-jdamato@fastly.com>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, nalramli@fastly.com,
 mkarsten@uwaterloo.ca, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-rdma@vger.kernel.org, pabeni@redhat.com,
 tariqt@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 May 2024 18:11:35 +0000 you wrote:
> Greetings:
> 
> Welcome to v6.
> 
> There are no functional changes from v5, which I mistakenly sent right
> after net-next was closed (oops). This revision, however, includes
> Tariq's Reviewed-by tags of the v5 in each commit message. See the
> changelog below.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/3] net/mlx4: Track RX allocation failures in a stat
    https://git.kernel.org/netdev/net-next/c/6166bb0cacb6
  - [net-next,v6,2/3] net/mlx4: link NAPI instances to queues and IRQs
    https://git.kernel.org/netdev/net-next/c/64b62146ba9e
  - [net-next,v6,3/3] net/mlx4: support per-queue statistics via netlink
    https://git.kernel.org/netdev/net-next/c/a5602c6edf7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



