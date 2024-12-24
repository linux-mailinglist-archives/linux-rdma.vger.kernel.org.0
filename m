Return-Path: <linux-rdma+bounces-6718-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 632029FBB2D
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 10:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63EC1886231
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 09:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34331ABEDF;
	Tue, 24 Dec 2024 09:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqOLffPs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBCB4D5AB;
	Tue, 24 Dec 2024 09:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735032584; cv=none; b=aVxYzWv887lbat89u/XbZrsmKeeC5VKY+pcHhbrQIOgCwnA4pj5Pss914PZiFAU2+mjpX52Dhw87/n09JTPH2L4bcBSvJVxeLEcTjxwKoU+7/nGDb5qvO3VCWogn7IMEsWpGrI16p/ZZMRtWlDMU2IIoB2XQmHFGL0uqhw6q5Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735032584; c=relaxed/simple;
	bh=wEgXsa7WYTd9/uCOG6Y2wMwQK3i+diZEP17y3FttdoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d81ZXCgMtF9xlicw5uKIbX2BxCKXssNZ5J1LK97PKTKmSkEfaQ0og/P8WgReOp641W8XcJTzMnEN5KAW8XJsbLvsUG+FCM937mTT2j0p+7HCjzhpleUcRfhGMHEL1HSIxaId4GnDSWapbvS2UbIs3ggWrbWhNkbMMwtGrTgGfBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqOLffPs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96403C4CED0;
	Tue, 24 Dec 2024 09:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735032584;
	bh=wEgXsa7WYTd9/uCOG6Y2wMwQK3i+diZEP17y3FttdoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VqOLffPsfhfmbJqb2dkfxULlK1nj7OcFS9Rk+AF2M1SPpYqHdjFTOCGdEs79+rft5
	 m2LdGkatZHsCjLT3qbJBbvSzSgE3JCgJHgURURFcnTCY50r2Tja+VJ79MRrV6AYhwl
	 JgwltZd+cWddP5XcP+mQhQe1FXePJtR1gjFIEhRC94FXjbT9Wmo7HRgmsgokCzdbxH
	 EvcLRcYZn/fsP3lopkx+IlBe6ApXalhx1a9+zDmFvRgp8PKl76ux+LrErRxCuXS8zi
	 1WwO6FdTNTpDMNLHKyM0gtjsKROvF5tZqUU2T8mh96IgrrptRz8+UnSus89T13n4BK
	 paRW7QRu0N2/w==
Date: Tue, 24 Dec 2024 11:29:38 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: jgg@ziepe.ca, cmeiohas@nvidia.com, michaelgur@nvidia.com,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [bug report] RDMA/iwpm: reentrant iwpm hello message
Message-ID: <20241224092938.GC171473@unreal>
References: <661ee85f.a4a2.193e4b2f91b.Coremail.linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <661ee85f.a4a2.193e4b2f91b.Coremail.linma@zju.edu.cn>

On Fri, Dec 20, 2024 at 11:32:34PM +0800, Lin Ma wrote:
> Hello maintainers,
> 
> Our fuzzer identified one interesting reentrant bug that could cause hang
> in the kernel. The crash log is like below:
> 
> [   32.616575][ T2983]
> [   32.617000][ T2983] ============================================
> [   32.617879][ T2983] WARNING: possible recursive locking detected
> [   32.618759][ T2983] 6.1.70 #1 Not tainted
> [   32.619362][ T2983] --------------------------------------------
> [   32.620248][ T2983] hello.elf/2983 is trying to acquire lock:
> [   32.621084][ T2983] ffffffff91978ff8 (&rdma_nl_types[idx].sem){.+.+}-{3:3}, at: rdma_nl_rcv+0x30f/0x990
> [   32.624234][ T2983]
> [   32.624234][ T2983] but task is already holding lock:
> [   32.625237][ T2983] ffffffff91978ff8 (&rdma_nl_types[idx].sem){.+.+}-{3:3}, at: rdma_nl_rcv+0x30f/0x990
> [   32.626562][ T2983]
> [   32.626562][ T2983] other info that might help us debug this:
> [   32.627648][ T2983]  Possible unsafe locking scenario:
> [   32.627648][ T2983]
> [   32.633708][ T2983]        CPU0
> [   32.634184][ T2983]        ----
> [   32.634646][ T2983]   lock(&rdma_nl_types[idx].sem);
> [   32.635433][ T2983]   lock(&rdma_nl_types[idx].sem);
> [   32.636155][ T2983]
> [   32.636155][ T2983]  *** DEADLOCK ***
> [   32.636155][ T2983]
> [   32.637236][ T2983]  May be due to missing lock nesting notation
> [   32.637236][ T2983]
> [   32.638408][ T2983] 2 locks held by hello.elf/2983:
> [   32.639135][ T2983]  #0: ffffffff91978ff8 (&rdma_nl_types[idx].sem){.+.+}-{3:3}, at: rdma_nl_rcv+0x30f/0x990
> [   32.640605][ T2983]  #1: ffff888103f8f690 (nlk_cb_mutex-RDMA){+.+.}-{3:3}, at: netlink_dump+0xd3/0xc60
> [   32.641981][ T2983]
> [   32.641981][ T2983] stack backtrace:
> [   32.642833][ T2983] CPU: 0 PID: 2983 Comm: hello.elf Not tainted 6.1.70 #1
> [   32.643830][ T2983] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> [   32.645243][ T2983] Call Trace:
> [   32.645735][ T2983]  <TASK>
> [   32.646197][ T2983]  dump_stack_lvl+0x177/0x231
> [   32.646901][ T2983]  ? nf_tcp_handle_invalid+0x605/0x605
> [   32.647705][ T2983]  ? panic+0x725/0x725
> [   32.648350][ T2983]  validate_chain+0x4dd0/0x6010
> [   32.649080][ T2983]  ? reacquire_held_locks+0x5a0/0x5a0
> [   32.649864][ T2983]  ? mark_lock+0x94/0x320
> [   32.650506][ T2983]  ? lockdep_hardirqs_on_prepare+0x3fd/0x760
> [   32.651376][ T2983]  ? print_irqtrace_events+0x210/0x210
> [   32.652182][ T2983]  ? mark_lock+0x94/0x320
> [   32.652825][ T2983]  __lock_acquire+0x12ad/0x2010
> [   32.653541][ T2983]  lock_acquire+0x1b4/0x490
> [   32.654211][ T2983]  ? rdma_nl_rcv+0x30f/0x990
> [   32.654891][ T2983]  ? __might_sleep+0xd0/0xd0
> [   32.655569][ T2983]  ? __lock_acquire+0x12ad/0x2010
> [   32.656316][ T2983]  ? read_lock_is_recursive+0x10/0x10
> [   32.657109][ T2983]  down_read+0x42/0x2d0
> [   32.657723][ T2983]  ? rdma_nl_rcv+0x30f/0x990
> [   32.658400][ T2983]  rdma_nl_rcv+0x30f/0x990
> [   32.659132][ T2983]  ? rdma_nl_net_init+0x160/0x160
> [   32.659847][ T2983]  ? netlink_lookup+0x30/0x200
> [   32.660519][ T2983]  ? __netlink_lookup+0x2a/0x6d0
> [   32.661214][ T2983]  ? netlink_lookup+0x30/0x200
> [   32.661880][ T2983]  ? netlink_lookup+0x30/0x200
> [   32.662545][ T2983]  netlink_unicast+0x74b/0x8c0
> [   32.663215][ T2983]  rdma_nl_unicast+0x4b/0x60
> [   32.663852][ T2983]  iwpm_send_hello+0x1d8/0x350
> [   32.664525][ T2983]  ? iwpm_mapinfo_available+0x130/0x130
> [   32.665295][ T2983]  ? iwpm_parse_nlmsg+0x124/0x260
> [   32.665995][ T2983]  iwpm_hello_cb+0x1e1/0x2e0
> [   32.666638][ T2983]  ? netlink_dump+0x236/0xc60
> [   32.667294][ T2983]  ? iwpm_mapping_error_cb+0x3e0/0x3e0
> [   32.668064][ T2983]  netlink_dump+0x592/0xc60
> [   32.668706][ T2983]  ? netlink_lookup+0x200/0x200
> [   32.669381][ T2983]  ? __netlink_lookup+0x2a/0x6d0
> [   32.670073][ T2983]  ? netlink_lookup+0x30/0x200
> [   32.670731][ T2983]  ? netlink_lookup+0x30/0x200
> [   32.671411][ T2983]  __netlink_dump_start+0x54e/0x710
> [   32.672220][ T2983]  rdma_nl_rcv+0x753/0x990
> [   32.672846][ T2983]  ? rdma_nl_net_init+0x160/0x160
> [   32.673538][ T2983]  ? iwpm_mapping_error_cb+0x3e0/0x3e0
> [   32.674316][ T2983]  ? netlink_deliver_tap+0x2e/0x1b0
> [   32.675106][ T2983]  ? net_generic+0x1e/0x240
> [   32.675778][ T2983]  ? netlink_deliver_tap+0x2e/0x1b0
> [   32.676553][ T2983]  netlink_unicast+0x74b/0x8c0
> [   32.677262][ T2983]  netlink_sendmsg+0x882/0xb90
> [   32.677969][ T2983]  ? netlink_getsockopt+0x550/0x550
> [   32.678732][ T2983]  ? aa_sock_msg_perm+0x94/0x150
> [   32.679465][ T2983]  ? bpf_lsm_socket_sendmsg+0x5/0x10
> [   32.680243][ T2983]  ? security_socket_sendmsg+0x7c/0xa0
> [   32.681048][ T2983]  __sys_sendto+0x456/0x5b0
> [   32.681724][ T2983]  ? __ia32_sys_getpeername+0x80/0x80
> [   32.682510][ T2983]  ? __lock_acquire+0x2010/0x2010
> [   32.683241][ T2983]  ? lockdep_hardirqs_on_prepare+0x3fd/0x760
> [   32.684134][ T2983]  ? fd_install+0x5c/0x4f0
> [   32.684794][ T2983]  ? print_irqtrace_events+0x210/0x210
> [   32.685608][ T2983]  __x64_sys_sendto+0xda/0xf0
> [   32.686298][ T2983]  do_syscall_64+0x45/0x90
> [   32.686955][ T2983]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [   32.687810][ T2983] RIP: 0033:0x440624
> [   32.691944][ T2983] RSP: 002b:00007ffc82f3ee48 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
> [   32.693136][ T2983] RAX: ffffffffffffffda RBX: 0000000000400400 RCX: 0000000000440624
> [   32.694264][ T2983] RDX: 0000000000000018 RSI: 00007ffc82f3ee80 RDI: 0000000000000003
> [   32.695387][ T2983] RBP: 00007ffc82f3fe90 R08: 000000000047df08 R09: 000000000000000c
> [   32.696621][ T2983] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000403990
> [   32.697693][ T2983] R13: 0000000000000000 R14: 00000000006a6018 R15: 0000000000000000
> [   32.698774][ T2983]  </TASK>
> 
> In a nutshell, the callback function for the command RDMA_NL_IWPM_HELLO, iwpm_hello_cb,
> can further call rdma_nl_unicast, leading to repeated calls that may cause
> a deadlock and potentially harm the kernel.
> 
> I am not familiar with the internal workings of the callback mechanism or how
> IWPMD utilizes it, so I'm uncertain whether this reentrancy is expected behavior.
> If it is, perhaps a reference counter should be used instead of an rw_semaphore.
> If not, a proper check should be implemented.

I'm not fully understand the lockdep here. We use down_read(), which is
reentry safe.

Thanks

> 
> Regards,
> Lin

