Return-Path: <linux-rdma+bounces-12827-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C735B2D263
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 05:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01BC1C43607
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 03:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1527B2BE65C;
	Wed, 20 Aug 2025 03:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHisFwvW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF1726F2BC;
	Wed, 20 Aug 2025 03:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755659476; cv=none; b=B2tL7xMyVfOYeZqgAAC6d4/9h+dXTPb9Ar7zCHOsCqRveTZGVCTpwiYk0Bm8kOHJQ3dh4OH4BUSjYwn7qtGqYfXgH8BeYcPO+B0eJJr4ZPvJZhNN01xIvCKG9sBgB3i0u8oMhPhFc1o8XD/1eEU62W3i5M2MW3TAHfSgj7h128g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755659476; c=relaxed/simple;
	bh=ml1Y35fvP1QMdZJuztTyhRtOjp4HuX0A5UgIfOSaGDE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eFO7aPp3n64tPuziTSN8iFqw/reY6f4EkmXfyQj3HL2DymIXAyS/Jg7VMUYQiD/Vy8rk4HSkiKtq3s/3m3S4Axjz7Xb/4ciobOgsGYHzycLH0P7BEq/JY2/YJSZexbT0JW3JPs7h3qg8xS3AaTT82GZVKsPihSJfc98PeM34r3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHisFwvW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4664DC116D0;
	Wed, 20 Aug 2025 03:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755659476;
	bh=ml1Y35fvP1QMdZJuztTyhRtOjp4HuX0A5UgIfOSaGDE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PHisFwvWWniHiSbKc+trGaujFsjiUyL8guSgrRbmXX7niPPUW9cwHAkp2RwnEuFMa
	 7cWTjL3l3qznoQfJ/B7ZuagUXWaE70ckI1kVVQIFdzdp0/EMbD4CdkFYxSRxxv6B+7
	 onNB2DItSTvfpPAwQN6NVRuDtRZg+lpee+jLRNGvOvl0+64aD821gyvl5TpFe+ghbY
	 iQBxjgF5YoWvQM/37ICNIYS+6QP3/e60LAodqZu6Be6+lN4amJKZJMbsxMnSLL1yX1
	 Kp4uweVOxAhZYzEpWM5z9vsmK13zoAGEnB1yoMB9MG/Xxw2QxyLNxXwxYnAv+ZJIcV
	 5u0097qYHrX7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BC0383BF58;
	Wed, 20 Aug 2025 03:11:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/smc: fix UAF on smcsk after smc_listen_out()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175565948574.3753798.15328877682080975423.git-patchwork-notify@kernel.org>
Date: Wed, 20 Aug 2025 03:11:25 +0000
References: <20250818054618.41615-1-alibuda@linux.alibaba.com>
In-Reply-To: <20250818054618.41615-1-alibuda@linux.alibaba.com>
To: D. Wythe <alibuda@linux.alibaba.com>
Cc: Mahanta.Jambigi@ibm.com, Sidraya.Jayagond@ibm.com, wenjia@linux.ibm.com,
 wintera@linux.ibm.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, kuba@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 jaka@linux.ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 18 Aug 2025 13:46:18 +0800 you wrote:
> BPF CI testing report a UAF issue:
> 
>   [   16.446633] BUG: kernel NULL pointer dereference, address: 000000000000003  0
>   [   16.447134] #PF: supervisor read access in kernel mod  e
>   [   16.447516] #PF: error_code(0x0000) - not-present pag  e
>   [   16.447878] PGD 0 P4D   0
>   [   16.448063] Oops: Oops: 0000 [#1] PREEMPT SMP NOPT  I
>   [   16.448409] CPU: 0 UID: 0 PID: 9 Comm: kworker/0:1 Tainted: G           OE      6.13.0-rc3-g89e8a75fda73-dirty #4  2
>   [   16.449124] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODUL  E
>   [   16.449502] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/201  4
>   [   16.450201] Workqueue: smc_hs_wq smc_listen_wor  k
>   [   16.450531] RIP: 0010:smc_listen_work+0xc02/0x159  0
>   [   16.452158] RSP: 0018:ffffb5ab40053d98 EFLAGS: 0001024  6
>   [   16.452526] RAX: 0000000000000001 RBX: 0000000000000002 RCX: 000000000000030  0
>   [   16.452994] RDX: 0000000000000280 RSI: 00003513840053f0 RDI: 000000000000000  0
>   [   16.453492] RBP: ffffa097808e3800 R08: ffffa09782dba1e0 R09: 000000000000000  5
>   [   16.453987] R10: 0000000000000000 R11: 0000000000000000 R12: ffffa0978274640  0
>   [   16.454497] R13: 0000000000000000 R14: 0000000000000000 R15: ffffa09782d4092  0
>   [   16.454996] FS:  0000000000000000(0000) GS:ffffa097bbc00000(0000) knlGS:000000000000000  0
>   [   16.455557] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003  3
>   [   16.455961] CR2: 0000000000000030 CR3: 0000000102788004 CR4: 0000000000770ef  0
>   [   16.456459] PKRU: 5555555  4
>   [   16.456654] Call Trace  :
>   [   16.456832]  <TASK  >
>   [   16.456989]  ? __die+0x23/0x7  0
>   [   16.457215]  ? page_fault_oops+0x180/0x4c  0
>   [   16.457508]  ? __lock_acquire+0x3e6/0x249  0
>   [   16.457801]  ? exc_page_fault+0x68/0x20  0
>   [   16.458080]  ? asm_exc_page_fault+0x26/0x3  0
>   [   16.458389]  ? smc_listen_work+0xc02/0x159  0
>   [   16.458689]  ? smc_listen_work+0xc02/0x159  0
>   [   16.458987]  ? lock_is_held_type+0x8f/0x10  0
>   [   16.459284]  process_one_work+0x1ea/0x6d  0
>   [   16.459570]  worker_thread+0x1c3/0x38  0
>   [   16.459839]  ? __pfx_worker_thread+0x10/0x1  0
>   [   16.460144]  kthread+0xe0/0x11  0
>   [   16.460372]  ? __pfx_kthread+0x10/0x1  0
>   [   16.460640]  ret_from_fork+0x31/0x5  0
>   [   16.460896]  ? __pfx_kthread+0x10/0x1  0
>   [   16.461166]  ret_from_fork_asm+0x1a/0x3  0
>   [   16.461453]  </TASK  >
>   [   16.461616] Modules linked in: bpf_testmod(OE) [last unloaded: bpf_testmod(OE)  ]
>   [   16.462134] CR2: 000000000000003  0
>   [   16.462380] ---[ end trace 0000000000000000 ]---
>   [   16.462710] RIP: 0010:smc_listen_work+0xc02/0x1590
> 
> [...]

Here is the summary with links:
  - [net] net/smc: fix UAF on smcsk after smc_listen_out()
    https://git.kernel.org/netdev/net/c/d9cef55ed491

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



