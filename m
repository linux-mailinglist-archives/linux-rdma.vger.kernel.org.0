Return-Path: <linux-rdma+bounces-11967-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386F9AFCFF0
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 18:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9E73B9B2A
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 15:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6582E3367;
	Tue,  8 Jul 2025 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRcaajSE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C8B2E0B58;
	Tue,  8 Jul 2025 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990399; cv=none; b=s7vAFOv+wzFi4k+DQEznw0cyRh821traw15Jh2dDMsLXjOgfXEPdJr+kl63pwBpNdAtrMLH5Z/9NmwRp7tNGA1qJ1+LLNzgx30LL4MlEUOww+9r7TCxF5riGwjP5WomnnmKd6oo/BhmqoubNx0eZlad58PWY16PMAe+/fmneGqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990399; c=relaxed/simple;
	bh=PVtjGWbHxgxwh9Sjq5IV6QMU4TmKcrY2ABdzMpTe7C0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fmMpUBbCh2m6v+CEWBoj13OeEtHV1OP9gHMloMYQ3O5L6kNs+Y3m2oA6fb+bn19BDmFaKnIPKKHpC5vWz4xLXmFqFBQrjUlVppnsxuxCrZbqM4O1w41uo+LysQu0+87W//lh/5ZH7OZpghNF0NuAE07y+nb74NnUqgeqIRGD1+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRcaajSE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F4BC4CEED;
	Tue,  8 Jul 2025 15:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751990398;
	bh=PVtjGWbHxgxwh9Sjq5IV6QMU4TmKcrY2ABdzMpTe7C0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SRcaajSE7wM5jKY/za/I85TGN3JY88KOXnMYvjy7u9DSqqoIJ8jnQe1ycJ78tXbxY
	 RrLpHvED/l0mRz921k4uO2jEh1aI7LF2Rb1C98MJXYul1/Zg1yJZpvnjexZwbEAsT5
	 Gth7zTg+eK+UKurhT4qOSSbWaMo2YcksRxaMKRB3qXq9HKdKwwpb30B3PkaNVvJaGP
	 VvrjHaIGz39GcA+uihWVlYPNJCmpdf1WEuRcZqxF/xz8DHCJ/RqFY3sSEMJ5MfyUpu
	 nc4chBt+XJAS+f6xMcqOzlr0U60PCycTH27Q65QY6f8C7YgXr2hxq58mSX41ctaPwu
	 /R2sXrEyUd6fw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBCF380DBEE;
	Tue,  8 Jul 2025 16:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/6] net: Remove unused function parameters in
 skbuff.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175199042124.4117860.11392671467837095763.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 16:00:21 +0000
References: <20250702-splice-drop-unused-v3-0-55f68b60d2b7@rbox.co>
In-Reply-To: <20250702-splice-drop-unused-v3-0-55f68b60d2b7@rbox.co>
To: Michal Luczaj <mhal@rbox.co>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, ayush.sawal@chelsio.com,
 andrew+netdev@lunn.ch, dsahern@kernel.org, ncardwell@google.com,
 kuniyu@google.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 sidraya@linux.ibm.com, dust.li@linux.alibaba.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 02 Jul 2025 15:38:06 +0200 you wrote:
> Couple of cleanup patches to get rid of unused function parameters around
> skbuff.c, plus little things spotted along the way.
> 
> Offshoot of my question in [1], but way more contained. Found by adding
> "-Wunused-parameter -Wno-error" to KBUILD_CFLAGS and grepping for specific
> skbuff.c warnings.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/6] net: splice: Drop unused @pipe
    https://git.kernel.org/netdev/net-next/c/1024f1207161
  - [net-next,v3,2/6] net: splice: Drop unused @gfp
    https://git.kernel.org/netdev/net-next/c/25489a4f5564
  - [net-next,v3,3/6] net: splice: Drop nr_pages_max initialization
    (no matching commit)
  - [net-next,v3,4/6] net/smc: Drop nr_pages_max initialization
    (no matching commit)
  - [net-next,v3,5/6] net: skbuff: Drop unused @skb
    https://git.kernel.org/netdev/net-next/c/ad0ac6cd9c04
  - [net-next,v3,6/6] net: skbuff: Drop unused @skb
    https://git.kernel.org/netdev/net-next/c/ab34e14258cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



