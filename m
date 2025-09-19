Return-Path: <linux-rdma+bounces-13520-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D99B8BA4F
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Sep 2025 01:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 213F55A6C86
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Sep 2025 23:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C542D8DC3;
	Fri, 19 Sep 2025 23:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfwkLyLX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A272D876C;
	Fri, 19 Sep 2025 23:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758325811; cv=none; b=QSMtor2qJDhnMDgbiosAgW2Nvol2dZfZzzQjSINpKU1nJ7AsgzMAIhsakG5oS0sNvAczjT5vUC6DZGNzv6dBmlw034pQ+OraBdQHPjH2OO9rtwO5EQ4wSa0JPDQ7z1Yxvn6+V2WooVDooV2l85gcWeZd84OcdaQZFuUcI4vdttk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758325811; c=relaxed/simple;
	bh=Mven0v1f4pqNZ/CroJLqThdc+h3oIN6ufsVFBvnrOqo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oKBRQltUMhwWZs3OjDmL+cp2QquATQ1hp7mKO2OMVRDxX2ihbYOo+lPzVhcjYkY4MebyIdG9wYZVZ9j3czLVsTSIPaQzL/OeMz2gM9Z5lWgz6oIY3kF3kOvni5r7kWKyDEEhwC0zlW/3ng0ThkYJQH0wGGzs1ybvT2EUI1lU6+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfwkLyLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E29C4CEFD;
	Fri, 19 Sep 2025 23:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758325810;
	bh=Mven0v1f4pqNZ/CroJLqThdc+h3oIN6ufsVFBvnrOqo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GfwkLyLX1sLqcUxYe5LgkkVJhYty7aj10jdAurO9uWfVxLpZsijgHFSAcqcNuq73s
	 9wPmWFd4cPaXgfX1ihG9pO35czSGMIPAYFiMLZtBDHJLsUmKeddW/7Eq8x2pO5b0cA
	 i+cF2dtBFQVOqO2GucCc047e1eAaDBPzaezkksB7Jgi/JIOXWTOOVbIO80hDAZID+n
	 qSHDUFQARAXHPZl3iaXEv5mBp64jqiMXXl0ou7OGaNsYgXj9iWzShuztPsVzf/IcT0
	 mD6fCvZ3YgTNci3ciOyBFs/KfO2xCSLWRi1va43YTrP2t6UfhH1bv/PaKMzS9QGA06
	 24yB3A29fqLJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D7739D0C20;
	Fri, 19 Sep 2025 23:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/smc: fix warning in smc_rx_splice() when calling
 get_page()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175832580899.3740319.9945359805753300205.git-patchwork-notify@kernel.org>
Date: Fri, 19 Sep 2025 23:50:08 +0000
References: <20250917184220.801066-1-sidraya@linux.ibm.com>
In-Reply-To: <20250917184220.801066-1-sidraya@linux.ibm.com>
To: Sidraya Jayagond <sidraya@linux.ibm.com>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 pabeni@redhat.com, horms@kernel.org, alibuda@linux.alibaba.com,
 dust.li@linux.alibaba.com, wenjia@linux.ibm.com, mjambigi@linux.ibm.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Sep 2025 20:42:20 +0200 you wrote:
> smc_lo_register_dmb() allocates DMB buffers with kzalloc(), which are
> later passed to get_page() in smc_rx_splice(). Since kmalloc memory is
> not page-backed, this triggers WARN_ON_ONCE() in get_page() and prevents
> holding a refcount on the buffer. This can lead to use-after-free if
> the memory is released before splice_to_pipe() completes.
> 
> Use folio_alloc() instead, ensuring DMBs are page-backed and safe for
> get_page().
> 
> [...]

Here is the summary with links:
  - [net] net/smc: fix warning in smc_rx_splice() when calling get_page()
    https://git.kernel.org/netdev/net/c/a35c04de2565

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



