Return-Path: <linux-rdma+bounces-13951-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2167BF42F0
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Oct 2025 02:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B883AC495
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Oct 2025 00:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678241FC0EA;
	Tue, 21 Oct 2025 00:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPv7SLjv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7331E7C19;
	Tue, 21 Oct 2025 00:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761007828; cv=none; b=nRxgTxg3J/IaL/gFwZrzUMeOk4k2Y13+Np5rlemfTvFPTjIAFlIqWyMqKVzcT8uj82XKLm7r5nvGi4HFUfQCsKltVDqHJbFe/2Y6aAbOahL9h2cN6d0MhBTRZyZsYBVdiYT4cKfazh6wMhBmTm5rNaVlalquY/4pY5MFQAHXK5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761007828; c=relaxed/simple;
	bh=oMlYshkcc5RvJ9NUcckvVdcCEGPA36gUCVeoMsopJGA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F5ga9dKoQuTmB6Ar9uSi8mXD8rpalYnZS7pSwW/YYoXK6AxMxfiy2nB1uV1wq7hP2icYNG5UdlbirCYu/UDFnwkCo9qq1x0t0/Wb959989VN+ocH5zEOMRHsS7ASNhLog2I8d0Zq1LTvvfLHmPlDiXWKvI2CkBGGeF6ldKlqVgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPv7SLjv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E51C113D0;
	Tue, 21 Oct 2025 00:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761007827;
	bh=oMlYshkcc5RvJ9NUcckvVdcCEGPA36gUCVeoMsopJGA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mPv7SLjvpy8cYOFjoXpon0RIFeTwfAPLGEldBhOJfikRorQxmZo3h304ruAyy9E6a
	 PY2whK3LjxepK8Chiq7zx5UvJtkAEW18HSiS7gYBckljdnj44EfgZUBNulJ/j+Xo9l
	 +1/VFaUiIcqPHoyQiI1220a3Lungf7ixG5rlIAnNiwmPGQD9N1LY3hkqM5jPQqo1aC
	 ov5UCon9YX6HbV341G+H2n41TFTBm3nqjb2v2Xtm171PMxgS6Luns9fC3GezAFWars
	 UvECPmLB4Q1hHnSqMgkN3GnxGzGWFPXLmbS7RcVi9spFm64wxfmlROORM8J8+KYKX+
	 WNmL947DncnAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE503A4102D;
	Tue, 21 Oct 2025 00:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/smc: fix general protection fault in
 __smc_diag_dump
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176100780950.473459.10068795081815761640.git-patchwork-notify@kernel.org>
Date: Tue, 21 Oct 2025 00:50:09 +0000
References: <20251017024827.3137512-1-wangliang74@huawei.com>
In-Reply-To: <20251017024827.3137512-1-wangliang74@huawei.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
 sidraya@linux.ibm.com, wenjia@linux.ibm.com, mjambigi@linux.ibm.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 Oct 2025 10:48:27 +0800 you wrote:
> The syzbot report a crash:
> 
>   Oops: general protection fault, probably for non-canonical address 0xfbd5a5d5a0000003: 0000 [#1] SMP KASAN NOPTI
>   KASAN: maybe wild-memory-access in range [0xdead4ead00000018-0xdead4ead0000001f]
>   CPU: 1 UID: 0 PID: 6949 Comm: syz.0.335 Not tainted syzkaller #0 PREEMPT(full)
>   Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
>   RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:44 [inline]
>   RIP: 0010:__smc_diag_dump.constprop.0+0x3ca/0x2550 net/smc/smc_diag.c:89
>   Call Trace:
>    <TASK>
>    smc_diag_dump_proto+0x26d/0x420 net/smc/smc_diag.c:217
>    smc_diag_dump+0x27/0x90 net/smc/smc_diag.c:234
>    netlink_dump+0x539/0xd30 net/netlink/af_netlink.c:2327
>    __netlink_dump_start+0x6d6/0x990 net/netlink/af_netlink.c:2442
>    netlink_dump_start include/linux/netlink.h:341 [inline]
>    smc_diag_handler_dump+0x1f9/0x240 net/smc/smc_diag.c:251
>    __sock_diag_cmd net/core/sock_diag.c:249 [inline]
>    sock_diag_rcv_msg+0x438/0x790 net/core/sock_diag.c:285
>    netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
>    netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
>    netlink_unicast+0x5a7/0x870 net/netlink/af_netlink.c:1346
>    netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1896
>    sock_sendmsg_nosec net/socket.c:714 [inline]
>    __sock_sendmsg net/socket.c:729 [inline]
>    ____sys_sendmsg+0xa95/0xc70 net/socket.c:2614
>    ___sys_sendmsg+0x134/0x1d0 net/socket.c:2668
>    __sys_sendmsg+0x16d/0x220 net/socket.c:2700
>    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>    do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    </TASK>
> 
> [...]

Here is the summary with links:
  - [net,v2] net/smc: fix general protection fault in __smc_diag_dump
    https://git.kernel.org/netdev/net/c/f584239a9ed2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



