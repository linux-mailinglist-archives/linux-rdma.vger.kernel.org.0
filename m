Return-Path: <linux-rdma+bounces-5368-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85030998D78
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 18:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39027B2635E
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 16:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AAD1CDA30;
	Thu, 10 Oct 2024 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFFvSx5B"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B35E1CC15B;
	Thu, 10 Oct 2024 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728576630; cv=none; b=jzWI5ueDqpRvc1drF51B6FWOWrwacOjeBJtIdTw37jPKYP7fFMSBdtSpxq/Hx9VYiuB8fGYBKb+lFBiOJN15lYEJWF/ht/Gkq3xT759IWxdTT19IDIApF8cEJ0G7JqQKb8LsGoEsjXcu729TSTzHJO4m2XSKV0u9Y0WG3M702aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728576630; c=relaxed/simple;
	bh=rlF1oA0bq8FwlMfxzBRflJpjdnVEJmqoV2so6rXk3HY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Etj7teUSrdhvTX33qDuqVJMzLOASaetl6oTgiJvgyzunc71xoZtNXh2uoDgncfcJuIt5YqmjJpgatXd9mmedF8tD/atik3R3aLfqZCtKbZWdBn0VPRMLo7j1ssIn06BWCoyRKAhEyWPMQ/pPkPCFee7B1uLKRqwsoCEvnS8cf3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFFvSx5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1524AC4CEC5;
	Thu, 10 Oct 2024 16:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728576630;
	bh=rlF1oA0bq8FwlMfxzBRflJpjdnVEJmqoV2so6rXk3HY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hFFvSx5BY4KcxW1FB6+Pyb6QtaCfhQCtmiXRIMCwsfxcgqUWdmBmMr9KqU6kb1M1+
	 6s1Fflstt9WCjpZmxIrIvVH3ZwT5lgDnVzi4nHbfJA/H1gJV+HsKOgHPndErTsdb36
	 7CualFXNfb9YN4/F3iyShNPJXZRZvzHLKB1L9un3Ek/VXOr24VfqzU8O0z0zGYMAQ3
	 7M88MVjUQpJnMEjth1balBwXdsXL4Xhtpr6R0oxxEff+iK1lm4kBY/KLzBVRj4ujBo
	 HEHss/tOVO1wyGHsWpodqds2jY2Oh8D/D+dRRgluLCS4uJ04DO3IZ2C+yPfke+klLd
	 bdqiGSg5+aSTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0273803263;
	Thu, 10 Oct 2024 16:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/smc: fix lacks of icsk_syn_mss with IPPROTO_SMC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172857663448.2081951.14132205441929515766.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 16:10:34 +0000
References: <1728456916-67035-1-git-send-email-alibuda@linux.alibaba.com>
In-Reply-To: <1728456916-67035-1-git-send-email-alibuda@linux.alibaba.com>
To: D. Wythe <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 wintera@linux.ibm.com, guwen@linux.alibaba.com, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, tonylu@linux.alibaba.com, pabeni@redhat.com,
 edumazet@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Oct 2024 14:55:16 +0800 you wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> Eric report a panic on IPPROTO_SMC, and give the facts
> that when INET_PROTOSW_ICSK was set, icsk->icsk_sync_mss must be set too.
> 
> Bug: Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000000
> Mem abort info:
> ESR = 0x0000000086000005
> EC = 0x21: IABT (current EL), IL = 32 bits
> SET = 0, FnV = 0
> EA = 0, S1PTW = 0
> FSC = 0x05: level 1 translation fault
> user pgtable: 4k pages, 48-bit VAs, pgdp=00000001195d1000
> [0000000000000000] pgd=0800000109c46003, p4d=0800000109c46003,
> pud=0000000000000000
> Internal error: Oops: 0000000086000005 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 1 UID: 0 PID: 8037 Comm: syz.3.265 Not tainted
> 6.11.0-rc7-syzkaller-g5f5673607153 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 08/06/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : 0x0
> lr : cipso_v4_sock_setattr+0x2a8/0x3c0 net/ipv4/cipso_ipv4.c:1910
> sp : ffff80009b887a90
> x29: ffff80009b887aa0 x28: ffff80008db94050 x27: 0000000000000000
> x26: 1fffe0001aa6f5b3 x25: dfff800000000000 x24: ffff0000db75da00
> x23: 0000000000000000 x22: ffff0000d8b78518 x21: 0000000000000000
> x20: ffff0000d537ad80 x19: ffff0000d8b78000 x18: 1fffe000366d79ee
> x17: ffff8000800614a8 x16: ffff800080569b84 x15: 0000000000000001
> x14: 000000008b336894 x13: 00000000cd96feaa x12: 0000000000000003
> x11: 0000000000040000 x10: 00000000000020a3 x9 : 1fffe0001b16f0f1
> x8 : 0000000000000000 x7 : 0000000000000000 x6 : 000000000000003f
> x5 : 0000000000000040 x4 : 0000000000000001 x3 : 0000000000000000
> x2 : 0000000000000002 x1 : 0000000000000000 x0 : ffff0000d8b78000
> Call trace:
> 0x0
> netlbl_sock_setattr+0x2e4/0x338 net/netlabel/netlabel_kapi.c:1000
> smack_netlbl_add+0xa4/0x154 security/smack/smack_lsm.c:2593
> smack_socket_post_create+0xa8/0x14c security/smack/smack_lsm.c:2973
> security_socket_post_create+0x94/0xd4 security/security.c:4425
> __sock_create+0x4c8/0x884 net/socket.c:1587
> sock_create net/socket.c:1622 [inline]
> __sys_socket_create net/socket.c:1659 [inline]
> __sys_socket+0x134/0x340 net/socket.c:1706
> __do_sys_socket net/socket.c:1720 [inline]
> __se_sys_socket net/socket.c:1718 [inline]
> __arm64_sys_socket+0x7c/0x94 net/socket.c:1718
> __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
> invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
> el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
> do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
> el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
> el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
> el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
> Code: ???????? ???????? ???????? ???????? (????????)
> 
> [...]

Here is the summary with links:
  - [net] net/smc: fix lacks of icsk_syn_mss with IPPROTO_SMC
    https://git.kernel.org/netdev/net/c/6fd27ea183c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



