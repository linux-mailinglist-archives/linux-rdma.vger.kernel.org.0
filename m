Return-Path: <linux-rdma+bounces-13923-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D8403BE7574
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Oct 2025 11:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 84E2435ABB3
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Oct 2025 09:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70452D24B3;
	Fri, 17 Oct 2025 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JAS79/U2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5175A2D2486;
	Fri, 17 Oct 2025 09:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691814; cv=none; b=uJRpr6SoC5KvKJ5LwRggd/ZxPldHwmg1gaCkOkou31rus/RfXpOutJqJ4KKukOnaiM+5bR5arzj5+B4Hc/87K9U6Gpi6v6ABnKzmqxTS6QqE1VTYNTFG27p7BsVzIHrQyIXXV2/sWkyV9AcAJXJwgtqjoy26BXyms88S5jG5sCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691814; c=relaxed/simple;
	bh=do5Ry9GxCpqqihl7odHQwHmjdHwUtx2yAcyU3jjzBIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+UeiXqon5RPSQDLqBK3k3GVIur4qlANnYI8elkFxRKRi2o/Khzjz+IiUrzPLr3MsJjp4EJiaSqy4Ifdi8NX2JaeflxneA+V6G06DeZZLywd7GumGTSLIbV+lLQh3X4tCZqL1vPzJNFca0X8AkiuYrr0BYF/TeQ8MCHwuuo+DoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JAS79/U2; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760691807; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=xYpkGDYxXhDg5l5WAfcmpffIBgs0vfXw+0gwNwOh1Dw=;
	b=JAS79/U2342T1lTxsHwBckmwNJ8VPy6XEAdwDQyLJv/BeFvPKRht22KISohFIVVbcmgfrRFOxKsk2CijutJDR/pYykdoTrZ7Xnmo5XDn/eN03/yVvWK057sOyrllytnFD4XumV+0pyVX9v7iHgYLkT2l4M+7K4APKS3w5G3+TCU=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WqPMAWk_1760691805 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Oct 2025 17:03:26 +0800
Date: Fri, 17 Oct 2025 17:03:25 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Wang Liang <wangliang74@huawei.com>
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com, wenjia@linux.ibm.com, mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
	zhangchangzhong@huawei.com
Subject: Re: [PATCH net v2] net/smc: fix general protection fault in
 __smc_diag_dump
Message-ID: <20251017090325.GB80913@j66a10360.sqa.eu95>
References: <20251017024827.3137512-1-wangliang74@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017024827.3137512-1-wangliang74@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Oct 17, 2025 at 10:48:27AM +0800, Wang Liang wrote:
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
> The process like this:
> 
>                (CPU1)              |             (CPU2)
>   ---------------------------------|-------------------------------
>   inet_create()                    |
>     // init clcsock to NULL        |
>     sk = sk_alloc()                |
>                                    |
>     // unexpectedly change clcsock |
>     inet_init_csk_locks()          |
>                                    |
>     // add sk to hash table        |
>     smc_inet_init_sock()           |
>       smc_sk_init()                |
>         smc_hash_sk()              |
>                                    | // traverse the hash table
>                                    | smc_diag_dump_proto
>                                    |   __smc_diag_dump()
>                                    |     // visit wrong clcsock
>                                    |     smc_diag_msg_common_fill()
>     // alloc clcsock               |
>     smc_create_clcsk               |
>       sock_create_kern             |
> 
> With CONFIG_DEBUG_LOCK_ALLOC=y, the smc->clcsock is unexpectedly changed
> in inet_init_csk_locks(). The INET_PROTOSW_ICSK flag is no need by smc,
> just remove it.
> 
> After removing the INET_PROTOSW_ICSK flag, this patch alse revert
> commit 6fd27ea183c2 ("net/smc: fix lacks of icsk_syn_mss with IPPROTO_SMC")
> to avoid casting smc_sock to inet_connection_sock.
> 
> Reported-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f775be4458668f7d220e
> Tested-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com
> Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
> v2: remove INET_PROTOSW_ICSK flag instead of init inet_connection_sock.
> v1: https://lore.kernel.org/netdev/20250922121818.654011-1-wangliang74@huawei.com/
> ---

LGTM.

Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>

