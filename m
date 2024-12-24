Return-Path: <linux-rdma+bounces-6732-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3BB9FC1A7
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 20:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D4E7165A95
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 19:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E93188587;
	Tue, 24 Dec 2024 19:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBfq+2U2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500408C1F;
	Tue, 24 Dec 2024 19:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735068382; cv=none; b=IUtVfNGbSp/liLj+qDnkY+UYNy2+uFbTQRLTxFejPRZZriWYX/49+7fhDUThmBOSkMiwUl5G+h52Noj0yWpTVvk8emN+4poVmXBMru8rV+RP1b8ApAlrRoe2wObqiqXK1AxWYvKJi0VuSsLX4u2R78smeYSOR36ZUiUMcGVuHAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735068382; c=relaxed/simple;
	bh=0fStXC2Be9umDwsXNJjpPIk8i2XTUm+Pupv8qwKYIxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZiawv5THKyMd7bg536G+VK3FaV3XGx9Qa+mR20XxrQDMkkL7oztuu7QFwJmWR0H788cf2Jk4+xF9jbx/ANZ//POrgF9OwfVBbYvr7O5WGPYforoUVOtQukulWqPCHWh7lH0lLL6xmA76uO6m126qxUlnvu6gDstx4UHKkQ3KK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBfq+2U2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B4BC4CED0;
	Tue, 24 Dec 2024 19:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735068381;
	bh=0fStXC2Be9umDwsXNJjpPIk8i2XTUm+Pupv8qwKYIxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pBfq+2U27XXkJONBK1Pqu4ZCIHGcklC3XEbjQlJ4BVnu9QsvEYSGUPm9eg1aRR2K+
	 DrAgeMB9gL8D4k7rm540f6qD11bgGDbTy8rCos36fiPQ/UljROXcdg/wz8Dd93CoKG
	 BRFlKhXjovJCghf+Af6Db+PIOOoa0gJZNBE4ERb8CQhiogsRgd7y4Lm6FDzoy+1HPE
	 wqhvdRbHWAs5vdGRrVqMw7Fs8h6bvo74iitRdMMb/MVsbQU3k5+c/x5o/0wMumjw0/
	 HsVkN82AdWdsR2J7Zcaxw0vlStUpJNdGmj8ncXpMmup5fQBTjO2hL3BXDW9cUsAEcR
	 1SZgpRdYeEsKg==
Date: Tue, 24 Dec 2024 21:26:16 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: jgg@ziepe.ca, cmeiohas@nvidia.com, michaelgur@nvidia.com,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [bug report] RDMA/iwpm: reentrant iwpm hello message
Message-ID: <20241224192616.GI171473@unreal>
References: <661ee85f.a4a2.193e4b2f91b.Coremail.linma@zju.edu.cn>
 <20241224092938.GC171473@unreal>
 <103c061b.e87e.193f84b0840.Coremail.linma@zju.edu.cn>
 <20241224141127.GH171473@unreal>
 <48307bf.eecb.193f974dadf.Coremail.linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48307bf.eecb.193f974dadf.Coremail.linma@zju.edu.cn>

On Wed, Dec 25, 2024 at 12:16:45AM +0800, Lin Ma wrote:
> Hello Leon,
> 
> > > Please let me know if I understand this correctly or incorrectly?
> > 
> > The thing is that down_write() is called when we unregistering module
> > which sent netlink messages. It shouldn't happen.
> > 
> 
> I acknowledge that this is a low-probability event. However, the race
> condition still exists; otherwise, these read and write semaphores
> would not be necessary. Why not just remove all of them?

netlink input and module removal are different paths and they can be in
parallel, and from this race, the semaphore is protecting.

Do you have reproducer for that?

> 
> Moreover, I find that even without the deadlock, this reentrant message
> would hang the kernel and cannot be killed, with logs like below:
> (after disabling locking sanitizer, tested in latest ubuntu)
> 
> [2187983.899998] INFO: task poc.elf:1717021 blocked for more than 122 seconds.
> [2187983.900049]       Not tainted 6.8.0-49-generic #49~22.04.1-Ubuntu
> [2187983.900057] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [2187983.900063] task:poc.elf       state:D stack:0     pid:1717021 tgid:1717021 ppid:1716834 flags:0x00004006
> [2187983.900087] Call Trace:
> [2187983.900094]  <TASK>
> [2187983.900355]  __schedule+0x27c/0x6a0
> [2187983.900430]  schedule+0x33/0x110
> [2187983.900442]  schedule_preempt_disabled+0x15/0x30
> [2187983.900454]  __mutex_lock.constprop.0+0x3f8/0x7a0
> [2187983.900476]  __mutex_lock_slowpath+0x13/0x20
> [2187983.900486]  mutex_lock+0x3c/0x50
> [2187983.900493]  __netlink_dump_start+0x76/0x2a0
> [2187983.900552]  rdma_nl_rcv_msg+0x24c/0x310 [ib_core]
> [2187983.900673]  ? __pfx_iwpm_hello_cb+0x10/0x10 [iw_cm]
> [2187983.900699]  rdma_nl_rcv_skb.constprop.0.isra.0+0xbb/0x120 [ib_core]
> [2187983.900802]  rdma_nl_rcv+0xe/0x20 [ib_core]
> [2187983.900898]  netlink_unicast+0x1b0/0x2a0
> [2187983.900911]  rdma_nl_unicast+0x49/0x70 [ib_core]
> [2187983.901005]  iwpm_send_hello+0xfd/0x150 [iw_cm]
> [2187983.901030]  iwpm_hello_cb+0xb9/0x130 [iw_cm]
> [2187983.901052]  netlink_dump+0x1c0/0x340
> [2187983.901065]  __netlink_dump_start+0x1ef/0x2a0
> [2187983.901077]  rdma_nl_rcv_msg+0x24c/0x310 [ib_core]
> [2187983.901219]  ? __pfx_iwpm_hello_cb+0x10/0x10 [iw_cm]
> [2187983.901245]  rdma_nl_rcv_skb.constprop.0.isra.0+0xbb/0x120 [ib_core]
> [2187983.901344]  rdma_nl_rcv+0xe/0x20 [ib_core]
> [2187983.901437]  netlink_unicast+0x1b0/0x2a0
> [2187983.901449]  rdma_nl_unicast+0x49/0x70 [ib_core]
> [2187983.901544]  iwpm_send_hello+0xfd/0x150 [iw_cm]
> [2187983.901567]  iwpm_hello_cb+0xb9/0x130 [iw_cm]
> [2187983.901589]  netlink_dump+0x1c0/0x340
> [2187983.901602]  __netlink_dump_start+0x1ef/0x2a0
> [2187983.901613]  rdma_nl_rcv_msg+0x24c/0x310 [ib_core]
> [2187983.901707]  ? __pfx_iwpm_hello_cb+0x10/0x10 [iw_cm]
> [2187983.901731]  rdma_nl_rcv_skb.constprop.0.isra.0+0xbb/0x120 [ib_core]
> [2187983.901830]  rdma_nl_rcv+0xe/0x20 [ib_core]
> [2187983.901922]  netlink_unicast+0x1b0/0x2a0
> [2187983.901933]  netlink_sendmsg+0x214/0x470
> [2187983.901946]  __sys_sendto+0x21b/0x230
> [2187983.901992]  __x64_sys_sendto+0x24/0x40
> [2187983.902002]  x64_sys_call+0x1fc0/0x24b0
> [2187983.902023]  do_syscall_64+0x81/0x170
> [2187983.902059]  ? security_file_alloc+0x5f/0xf0
> [2187983.902079]  ? alloc_empty_file+0x85/0x130
> [2187983.902140]  ? alloc_file+0x9b/0x170
> [2187983.902150]  ? alloc_file_pseudo+0x9e/0x100
> [2187983.902163]  ? restore_fpregs_from_fpstate+0x3d/0xd0
> [2187983.902197]  ? switch_fpu_return+0x55/0xf0
> [2187983.902208]  ? syscall_exit_to_user_mode+0x83/0x260
> [2187983.902229]  ? do_syscall_64+0x8d/0x170
> [2187983.902240]  ? irqentry_exit+0x43/0x50
> [2187983.902249]  ? clear_bhb_loop+0x15/0x70
> [2187983.902293]  ? clear_bhb_loop+0x15/0x70
> [2187983.902302]  ? clear_bhb_loop+0x15/0x70
> [2187983.902311]  entry_SYSCALL_64_after_hwframe+0x78/0x80
> [2187983.902319] RIP: 0033:0x440624
> [2187983.902582] RSP: 002b:00007ffcfa4b29f8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
> [2187983.902592] RAX: ffffffffffffffda RBX: 0000000000400400 RCX: 0000000000440624
> [2187983.902598] RDX: 0000000000000018 RSI: 00007ffcfa4b2a30 RDI: 0000000000000003
> [2187983.902604] RBP: 00007ffcfa4b3a40 R08: 000000000047df08 R09: 000000000000000c
> [2187983.902609] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000403990
> [2187983.902614] R13: 0000000000000000 R14: 00000000006a6018 R15: 0000000000000000
> 
> That's why I'm quite sure this is a bug and requires fixing.
> 
> Thanks
> Lin

