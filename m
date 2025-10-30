Return-Path: <linux-rdma+bounces-14142-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D1979C200EF
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Oct 2025 13:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 533C334CF5D
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Oct 2025 12:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5060E32B9B5;
	Thu, 30 Oct 2025 12:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9RtIYgy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DC626AC3;
	Thu, 30 Oct 2025 12:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828037; cv=none; b=PZ4Eus55o4x1KFJ9bLo7103j1HHuQYWDDl5U0LsUDWoGBx5eKJckCG56qmbwjmytQWSDyvSWVR6Wbn1G1+jRq6QFVwBm5XVSiIA6Q9C8Sw0H91iX24ph6GHqQmf68K6NmXbMuvZDK0Y9v7f30TwsO+QIZpI5e3Px5I63QEcKbD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828037; c=relaxed/simple;
	bh=Vwti+Oyqhh3Vszbl9HbC46xxrM6AGGSoT0/ulRpfj74=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vr6X7neMUo9gicLC2s0jOrlBayb3ibqsweJYu/fI259LZSTiGiOLctu3/cXH1ZyURddChD+9ae9foUxbMH9A8UMt0QO0zz4KzXdC5LwK7tV20NV3ZH2R5UbQf2j2/+N7Cou5hDe5TWWOg6KwLO2JahVqGaMdOQYImAqi4vvPZaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9RtIYgy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A1CC4CEF1;
	Thu, 30 Oct 2025 12:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761828036;
	bh=Vwti+Oyqhh3Vszbl9HbC46xxrM6AGGSoT0/ulRpfj74=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o9RtIYgyvHzfQjqglILBG0OitmyfsCh0DVy1RNTpjIkhMR/gbFVlqfNvGgAPxXwYi
	 44Utyug2eNkfAgYyMfNutwHXbCgrMXfjcnohEW1jyNcac02ylUOqDoMdIGwa1QxERo
	 2v/hpcu8nWiq/X/0R6rfWagSphb1ATQ/SH5BDS0FOXj/JzSBVfgGTKdbASAw96W9H9
	 GBJ+ajWNmKuATFZhku3HIVfNT13jCYsi2rQ3NVwBSrXnz6n35KIz3VS2U5BUSSqoen
	 kruzgbmrDQrfgUtiib5Zi/JnmNR+eMk1pNXfNs9qkd+UmpkDr4kkEC1ZiHOYVzKkyq
	 RfYLD1Jww3JfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E8B3A72A60;
	Thu, 30 Oct 2025 12:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/2] net/smc: make wr buffer count
 configurable 
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176182801326.3832937.9219593539259854803.git-patchwork-notify@kernel.org>
Date: Thu, 30 Oct 2025 12:40:13 +0000
References: <20251027224856.2970019-1-pasic@linux.ibm.com>
In-Reply-To: <20251027224856.2970019-1-pasic@linux.ibm.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, sidraya@linux.ibm.com,
 wenjia@linux.ibm.com, mjambigi@linux.ibm.com, tonylu@linux.alibaba.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org, guwen@linux.alibaba.com,
 guangguan.wang@linux.alibaba.com, bagasdotme@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 27 Oct 2025 23:48:54 +0100 you wrote:
> The current value of SMC_WR_BUF_CNT is 16 which leads to heavy
> contention on the wr_tx_wait workqueue of the SMC-R linkgroup and its
> spinlock when many connections are competing for the work request
> buffers. Currently up to 256 connections per linkgroup are supported.
> 
> To make things worse when finally a buffer becomes available and
> smc_wr_tx_put_slot() signals the linkgroup's wr_tx_wait wq, because
> WQ_FLAG_EXCLUSIVE is not used all the waiters get woken up, most of the
> time a single one can proceed, and the rest is contending on the
> spinlock of the wq to go to sleep again.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/2] net/smc: make wr buffer count configurable
    https://git.kernel.org/netdev/net-next/c/aef3cdb47bbb
  - [net-next,v6,2/2] net/smc: handle -ENOMEM from smc_wr_alloc_link_mem gracefully
    https://git.kernel.org/netdev/net-next/c/8f736087e52f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



