Return-Path: <linux-rdma+bounces-9378-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB02A85EB4
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 15:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2FA1B8417B
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 13:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD75165F1F;
	Fri, 11 Apr 2025 13:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="htierM6R"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B1354723;
	Fri, 11 Apr 2025 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744377538; cv=none; b=PkFalF/bpRLwNRXZo+9jQc1h9MQton3BcayJgc4YFtk6eOid61qnwCQtVIOBRGfvJv6qW+qxWjlrWWzetPKNXmxjc6xFtjLPneZVrfJJoMDZkcHxUkPjmDfU5Aj9Q3ZDPUJ0AQmtXbcYgxOISV5f2b9o2TDdVFiv4/VArt45Wfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744377538; c=relaxed/simple;
	bh=qf3SKcAWsyKEM1wYMBif4F/P7XVL+R9j00DYlVRZhz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S6Rdwrll7zW+bhjS2K5FSnfiNW0kdHzXKcY/mkxcM38CPwVmUNmLFrFtJmLq2nIAWlV9IX8+5kVHKMXz8QDAyn+EqaxzAK8hN/ZLUlZntWg5T9j1Rdiu0AKUjFy50tVcdXa/n74nbtDc/ZQvHrfMWB+oC2eQ9HlnJWntzsCgU1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=htierM6R; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B7pRrf011852;
	Fri, 11 Apr 2025 13:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6KbhY0
	gy4TOmrKpr6FGpj34FWxfHf6zvFq4T2DNioyY=; b=htierM6RxoggW8KIhQ1O1u
	02rnvGWWzxHObEO3luQozFndXHVO2kHimp5uRUUBW3JbgXQZa0J/P8FaagvrD8Z7
	mhUUD/h89eYrVtD/rCpTPMvFDbGJZ6dEH91uj/YztGJggY7WGFw24BqFcQii5fNu
	8pEg6r324VjXv+kBN7rEpb4V1ZZMP7rrYqQz3WbGUzB7sTr5PIJhr7loe/NvUD6b
	J/3rTAdDQgFnD6y/Ux4fs2DHXsl7aHlRlbaCoDYfkA/3W6yIwVZjWPr1O6X44xZr
	Cd3ny+/9p8X0BvUPpbXnsp9CrrE+Pab/pMC30/s5JnTF+HI72asEsFWfiBhwZzfw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45xn71bnrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 13:18:47 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53BDDSNM020173;
	Fri, 11 Apr 2025 13:18:47 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45xn71bnrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 13:18:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53BAfxvm018432;
	Fri, 11 Apr 2025 13:18:46 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45uh2m2xb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 13:18:46 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53BDIgeZ64749846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 13:18:42 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92BCC5804B;
	Fri, 11 Apr 2025 13:18:44 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 638165805B;
	Fri, 11 Apr 2025 13:18:41 +0000 (GMT)
Received: from [9.171.61.225] (unknown [9.171.61.225])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Apr 2025 13:18:41 +0000 (GMT)
Message-ID: <db7f87c7-9550-4772-875b-09a143d61d41@linux.ibm.com>
Date: Fri, 11 Apr 2025 15:18:40 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net] smc: Fix lockdep false-positive for IPPROTO_SMC.
To: Kuniyuki Iwashima <kuniyu@amazon.com>, Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org,
        syzbot+be6f4b383534d88989f7@syzkaller.appspotmail.com
References: <20250407170332.26959-1-kuniyu@amazon.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20250407170332.26959-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _P0VxpprV4gBkLwj-Y5G7gOhxSnoiBFn
X-Proofpoint-GUID: -4zZLWN6zjUXZvR15V9FUrzSCGGjY59v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504110083



On 07.04.25 19:03, Kuniyuki Iwashima wrote:
> SMC consists of two sockets: smc_sock and kernel TCP socket.
> 
> Currently, there are two ways of creating the sockets, and syzbot reported
> a lockdep splat [0] for the newer way introduced by commit d25a92ccae6b
> ("net/smc: Introduce IPPROTO_SMC").
> 
>    socket(AF_SMC             , SOCK_STREAM, SMCPROTO_SMC or SMCPROTO_SMC6)
>    socket(AF_INET or AF_INET6, SOCK_STREAM, IPPROTO_SMC)
> 
> When a socket is allocated, sock_lock_init() sets a lockdep lock class to
> sk->sk_lock.slock based on its protocol family.  In the IPPROTO_SMC case,
> AF_INET or AF_INET6 lock class is assigned to smc_sock.
> 
> The repro sets IPV6_JOIN_ANYCAST for IPv6 UDP and SMC socket and exercises
> smc_switch_to_fallback() for IPPROTO_SMC.
> 
>    1. smc_switch_to_fallback() is called under lock_sock() and holds
>       smc->clcsock_release_lock.
> 
>        sk_lock-AF_INET6 -> &smc->clcsock_release_lock
>        (sk_lock-AF_SMC)
> 
>    2. Setting IPV6_JOIN_ANYCAST to SMC holds smc->clcsock_release_lock
>       and calls setsockopt() for the kernel TCP socket, which holds RTNL
>       and the kernel socket's lock_sock().
> 
>        &smc->clcsock_release_lock -> rtnl_mutex (-> k-sk_lock-AF_INET6)
> 
>    3. Setting IPV6_JOIN_ANYCAST to UDP holds RTNL and lock_sock().
> 
>        rtnl_mutex -> sk_lock-AF_INET6
> 
> Then, lockdep detects a false-positive circular locking,
> 
>    .-> sk_lock-AF_INET6 -> &smc->clcsock_release_lock -> rtnl_mutex -.
>    `-----------------------------------------------------------------'
> 
> but IPPROTO_SMC should have the same locking rule as AF_SMC.
> 
>        sk_lock-AF_SMC   -> &smc->clcsock_release_lock -> rtnl_mutex -> k-sk_lock-AF_INET6
> 
> Let's set the same lock class for smc_sock.
> 
> Given AF_SMC uses the same lock class for SMCPROTO_SMC and SMCPROTO_SMC6,
> we do not need to separate the class for AF_INET and AF_INET6.
> 
> [0]:
> WARNING: possible circular locking dependency detected
> 6.14.0-rc3-syzkaller-00267-gff202c5028a1 #0 Not tainted
> 
> syz.4.1528/11571 is trying to acquire lock:
> ffffffff8fef8de8 (rtnl_mutex){+.+.}-{4:4}, at: ipv6_sock_ac_close+0xd9/0x110 net/ipv6/anycast.c:220
> 
> but task is already holding lock:
> ffff888027f596a8 (&smc->clcsock_release_lock){+.+.}-{4:4}, at: smc_clcsock_release+0x75/0xe0 net/smc/smc_close.c:30
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
>   -> #2 (&smc->clcsock_release_lock){+.+.}-{4:4}:
>         __mutex_lock_common kernel/locking/mutex.c:585 [inline]
>         __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
>         smc_switch_to_fallback+0x2d/0xa00 net/smc/af_smc.c:903
>         smc_sendmsg+0x13d/0x520 net/smc/af_smc.c:2781
>         sock_sendmsg_nosec net/socket.c:718 [inline]
>         __sock_sendmsg net/socket.c:733 [inline]
>         ____sys_sendmsg+0xaaf/0xc90 net/socket.c:2573
>         ___sys_sendmsg+0x135/0x1e0 net/socket.c:2627
>         __sys_sendmsg+0x16e/0x220 net/socket.c:2659
>         do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>         do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>         entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
>   -> #1 (sk_lock-AF_INET6){+.+.}-{0:0}:
>         lock_sock_nested+0x3a/0xf0 net/core/sock.c:3645
>         lock_sock include/net/sock.h:1624 [inline]
>         sockopt_lock_sock net/core/sock.c:1133 [inline]
>         sockopt_lock_sock+0x54/0x70 net/core/sock.c:1124
>         do_ipv6_setsockopt+0x2160/0x4520 net/ipv6/ipv6_sockglue.c:567
>         ipv6_setsockopt+0xcb/0x170 net/ipv6/ipv6_sockglue.c:993
>         udpv6_setsockopt+0x7d/0xd0 net/ipv6/udp.c:1850
>         do_sock_setsockopt+0x222/0x480 net/socket.c:2303
>         __sys_setsockopt+0x1a0/0x230 net/socket.c:2328
>         __do_sys_setsockopt net/socket.c:2334 [inline]
>         __se_sys_setsockopt net/socket.c:2331 [inline]
>         __x64_sys_setsockopt+0xbd/0x160 net/socket.c:2331
>         do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>         do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>         entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
>   -> #0 (rtnl_mutex){+.+.}-{4:4}:
>         check_prev_add kernel/locking/lockdep.c:3163 [inline]
>         check_prevs_add kernel/locking/lockdep.c:3282 [inline]
>         validate_chain kernel/locking/lockdep.c:3906 [inline]
>         __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5228
>         lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5851
>         __mutex_lock_common kernel/locking/mutex.c:585 [inline]
>         __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
>         ipv6_sock_ac_close+0xd9/0x110 net/ipv6/anycast.c:220
>         inet6_release+0x47/0x70 net/ipv6/af_inet6.c:485
>         __sock_release net/socket.c:647 [inline]
>         sock_release+0x8e/0x1d0 net/socket.c:675
>         smc_clcsock_release+0xb7/0xe0 net/smc/smc_close.c:34
>         __smc_release+0x5c2/0x880 net/smc/af_smc.c:301
>         smc_release+0x1fc/0x5f0 net/smc/af_smc.c:344
>         __sock_release+0xb0/0x270 net/socket.c:647
>         sock_close+0x1c/0x30 net/socket.c:1398
>         __fput+0x3ff/0xb70 fs/file_table.c:464
>         task_work_run+0x14e/0x250 kernel/task_work.c:227
>         resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>         exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>         exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
>         __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>         syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
>         do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
>         entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> other info that might help us debug this:
> 
> Chain exists of:
>    rtnl_mutex --> sk_lock-AF_INET6 --> &smc->clcsock_release_lock
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(&smc->clcsock_release_lock);
>                                 lock(sk_lock-AF_INET6);
>                                 lock(&smc->clcsock_release_lock);
>    lock(rtnl_mutex);
> 
>   *** DEADLOCK ***
> 
> 2 locks held by syz.4.1528/11571:
>   #0: ffff888077e88208 (&sb->s_type->i_mutex_key#10){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:877 [inline]
>   #0: ffff888077e88208 (&sb->s_type->i_mutex_key#10){+.+.}-{4:4}, at: __sock_release+0x86/0x270 net/socket.c:646
>   #1: ffff888027f596a8 (&smc->clcsock_release_lock){+.+.}-{4:4}, at: smc_clcsock_release+0x75/0xe0 net/smc/smc_close.c:30
> 
> stack backtrace:
> CPU: 0 UID: 0 PID: 11571 Comm: syz.4.1528 Not tainted 6.14.0-rc3-syzkaller-00267-gff202c5028a1 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>   print_circular_bug+0x490/0x760 kernel/locking/lockdep.c:2076
>   check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2208
>   check_prev_add kernel/locking/lockdep.c:3163 [inline]
>   check_prevs_add kernel/locking/lockdep.c:3282 [inline]
>   validate_chain kernel/locking/lockdep.c:3906 [inline]
>   __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5228
>   lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5851
>   __mutex_lock_common kernel/locking/mutex.c:585 [inline]
>   __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
>   ipv6_sock_ac_close+0xd9/0x110 net/ipv6/anycast.c:220
>   inet6_release+0x47/0x70 net/ipv6/af_inet6.c:485
>   __sock_release net/socket.c:647 [inline]
>   sock_release+0x8e/0x1d0 net/socket.c:675
>   smc_clcsock_release+0xb7/0xe0 net/smc/smc_close.c:34
>   __smc_release+0x5c2/0x880 net/smc/af_smc.c:301
>   smc_release+0x1fc/0x5f0 net/smc/af_smc.c:344
>   __sock_release+0xb0/0x270 net/socket.c:647
>   sock_close+0x1c/0x30 net/socket.c:1398
>   __fput+0x3ff/0xb70 fs/file_table.c:464
>   task_work_run+0x14e/0x250 kernel/task_work.c:227
>   resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>   exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>   exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
>   __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>   syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
>   do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f8b4b38d169
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe4efd22d8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
> RAX: 0000000000000000 RBX: 00000000000b14a3 RCX: 00007f8b4b38d169
> RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
> RBP: 00007f8b4b5a7ba0 R08: 0000000000000001 R09: 000000114efd25cf
> R10: 00007f8b4b200000 R11: 0000000000000246 R12: 00007f8b4b5a5fac
> R13: 00007f8b4b5a5fa0 R14: ffffffffffffffff R15: 00007ffe4efd23f0
>   </TASK>
> 
> Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> Reported-by: syzbot+be6f4b383534d88989f7@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=be6f4b383534d88989f7
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thank you for fixing it! It looks reasonable to me! Good description!

Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>

