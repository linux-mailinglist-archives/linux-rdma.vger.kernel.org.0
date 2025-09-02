Return-Path: <linux-rdma+bounces-13036-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 415A0B3FA12
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 11:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793EC1A86CA3
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 09:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D244B2749D5;
	Tue,  2 Sep 2025 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbF/+8Ds"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5F03D987;
	Tue,  2 Sep 2025 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804801; cv=none; b=t+IbAU8zmWi3AXK/6HS8GWXll/aHEAIWO1+yCFBpBzHJtMn1tejA5aNBmyNnjfNETiI0HZuZyMDU8Y1X3WRTA8381S5qr4bRM4EVReco7hjs9LHpI3p5VR5976kYbi5cDaQqj3RtVnNEZbQZ7hF1n6jncSzMvNfad2BMFXxaweg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804801; c=relaxed/simple;
	bh=wKR52cRFmx4LPIyaXK8F3b5ICW0tMKE2gjRVGKIRxno=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G2Sa3KG5Bomw9pqNUn9WwuNHpMcMDk67QrUIkmDnxS29UFo2oooK03Am1JhNqc94VmNfAOTtBK0+8SpUnXfIGy8m+J0+7n3Af/ZUfcmLvMns5Q8uvjEorTPLtkGfuVEPp8DZW6Mn2Wwcs2EyZ53jWZRLBCsSuLLwWzKQgpm+xJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbF/+8Ds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0A9C4CEED;
	Tue,  2 Sep 2025 09:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756804800;
	bh=wKR52cRFmx4LPIyaXK8F3b5ICW0tMKE2gjRVGKIRxno=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UbF/+8Ds2pWgbk0aXSJZtsJ3JRHiVNYJnzxQw3HdpaSHSFTOEqqsyUBZ8TGow0oDc
	 XEJ9p3kj/SB2Es/ThYa1COxf+JfjPSXw5dAjImnOYY9UbkHSB6T9kBEIoBUWGeyggx
	 g+S6kC4Nl5LhH/RH50rGeXZhvAlBmIvAapyX1rAB96FpqIG7XNinu8XgFF45hWcBVj
	 O1B/jnQ/IAbeMn7fxLSvjRqt5yfToFXyLqXiJaV9IyAw1E1rBo9pqX/0p6gZwVCKZT
	 3FkgshJ1Evy4lQh93j3poaZGUV8cptTcvV5g2X7idT2RmMGv7g4YTYy5IGF4pEjYTY
	 pgK5pM4YBndCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE851383BF75;
	Tue,  2 Sep 2025 09:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/smc: fix one NULL pointer dereference in
 smc_ib_is_sg_need_sync()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175680480651.206615.13443256148780571715.git-patchwork-notify@kernel.org>
Date: Tue, 02 Sep 2025 09:20:06 +0000
References: <20250828124117.2622624-1-liujian56@huawei.com>
In-Reply-To: <20250828124117.2622624-1-liujian56@huawei.com>
To: Liu Jian <liujian56@huawei.com>
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
 sidraya@linux.ibm.com, wenjia@linux.ibm.com, mjambigi@linux.ibm.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 guangguan.wang@linux.alibaba.com, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 28 Aug 2025 20:41:17 +0800 you wrote:
> BUG: kernel NULL pointer dereference, address: 00000000000002ec
> PGD 0 P4D 0
> Oops: Oops: 0000 [#1] SMP PTI
> CPU: 28 UID: 0 PID: 343 Comm: kworker/28:1 Kdump: loaded Tainted: G        OE       6.17.0-rc2+ #9 NONE
> Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
> Workqueue: smc_hs_wq smc_listen_work [smc]
> RIP: 0010:smc_ib_is_sg_need_sync+0x9e/0xd0 [smc]
> ...
> Call Trace:
>  <TASK>
>  smcr_buf_map_link+0x211/0x2a0 [smc]
>  __smc_buf_create+0x522/0x970 [smc]
>  smc_buf_create+0x3a/0x110 [smc]
>  smc_find_rdma_v2_device_serv+0x18f/0x240 [smc]
>  ? smc_vlan_by_tcpsk+0x7e/0xe0 [smc]
>  smc_listen_find_device+0x1dd/0x2b0 [smc]
>  smc_listen_work+0x30f/0x580 [smc]
>  process_one_work+0x18c/0x340
>  worker_thread+0x242/0x360
>  kthread+0xe7/0x220
>  ret_from_fork+0x13a/0x160
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> 
> [...]

Here is the summary with links:
  - [net,v2] net/smc: fix one NULL pointer dereference in smc_ib_is_sg_need_sync()
    https://git.kernel.org/netdev/net/c/ba1e9421cf1a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



