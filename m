Return-Path: <linux-rdma+bounces-6472-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CED9EE747
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 14:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE2EA18883DF
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 13:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75A2213E91;
	Thu, 12 Dec 2024 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoFmKCK5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855322135BE;
	Thu, 12 Dec 2024 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734008415; cv=none; b=f0IIlNwF4TNfkLK7JloCcr5aqwV/ZSA5rDWPcij/LqlFf8+vYizrGlBQ4Mh1Xy5ccaBXeqaMYEOg2YKJ41k3xhZH+4nQejbgrdCCaZLbROQ1i5LiD+ewT/M2hcFi7CnXLnvaAdRzUzgCp/lVuqnAy2prcftaG/0sbfBnypk9smA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734008415; c=relaxed/simple;
	bh=gCszh6ieTcAWNN1ZKvCTr91ve5Jd7QMeeXcGc472jL4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bVZa6L+1iIIlc7FVmic9Hg8wwtJDRJJdY1CPMJ1rElAt+76xmhH9xKT/8k2rcqao0I/bTrKy8l8xyMwXjIgk3iHD7/ji4W3nGLYIIwIpUfxK2IV8RMxPXubnUVRG0HgJN+owrYHWJJDxudPBMM+xxhTnQcCXiU+qohCznjZvZa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoFmKCK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1538DC4CECE;
	Thu, 12 Dec 2024 13:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734008415;
	bh=gCszh6ieTcAWNN1ZKvCTr91ve5Jd7QMeeXcGc472jL4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QoFmKCK5/X1cobfRcFONkWWeBP+oWmH+If3d9lDT0h8otWFNVpvEnb9R0I57fyh3o
	 aBQvt4fjocuGDshxHZKidStCCzPoYPZiuPPspPtGJm5Oc7hE+Uc+dD7KHeg/IRq5Sc
	 eiEm/IlJEPl6WhG9NXyopO6b5Um4outhNCWfoSzghqc6VBGgJH0egU6pNvr0UXDjsk
	 SDQ/bnzWtLclArDUFhY2/TcygVsJ1STZp1LGEp/KCRBCzLx+WqHr6dyGENS1GPvXQh
	 zO4V35aNLNE2hul1RzL+TREY2zHA7lu/wV87Sa0/M1eMEaAnDVh8FpxfJMA/JnSqBQ
	 u4gfo9cHN2x+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7140B380A959;
	Thu, 12 Dec 2024 13:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next RESEND v3 0/2] net/smc: Two features for smc-r
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173400843115.2294712.16537890153664787173.git-patchwork-notify@kernel.org>
Date: Thu, 12 Dec 2024 13:00:31 +0000
References: <20241211023055.89610-1-guangguan.wang@linux.alibaba.com>
In-Reply-To: <20241211023055.89610-1-guangguan.wang@linux.alibaba.com>
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, pasic@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 11 Dec 2024 10:30:53 +0800 you wrote:
> v2 -> v3:
> (https://lore.kernel.org/netdev/20241202125203.48821-1-guangguan.wang@linux.alibaba.com/)
> Patch #1 add 'Reviewed-by' tag.
> Patch #2 remove the condition when IPV6 is disabled, and change the
> condition to an easier understanding way. Correct the typo and add
> 'Reviewed-by' tag.
> 
> [...]

Here is the summary with links:
  - [net-next,RESEND,v3,1/2] net/smc: support SMC-R V2 for rdma devices with max_recv_sge equals to 1
    https://git.kernel.org/netdev/net-next/c/27ef6a9981fe
  - [net-next,RESEND,v3,2/2] net/smc: support ipv4 mapped ipv6 addr client for smc-r v2
    https://git.kernel.org/netdev/net-next/c/c12b2704a678

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



