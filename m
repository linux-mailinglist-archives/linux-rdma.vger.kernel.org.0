Return-Path: <linux-rdma+bounces-9322-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6478A83E63
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 11:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750501B860BC
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 09:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7D92147E6;
	Thu, 10 Apr 2025 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KFt5vlzJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D0E214213
	for <linux-rdma@vger.kernel.org>; Thu, 10 Apr 2025 09:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744276504; cv=none; b=tLpo5LKapCEuXjfzKw/Zcmed81zt5Z9XkcHNrqJPx+sHu9bnrX7XXOBnfh7FpC7e58Rr+ibAuGNRKvW3FIO6MX1lJrR/5WdtOagQVnbfb68Bhx2BGSg7L6vqkalsRITLHMonMMP8Ha0BhxzazebCRI/CNIaqdKSJNE5atgM5leM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744276504; c=relaxed/simple;
	bh=9Mc038kgrjnC4AGLtLjiWvMwLfAxrZ94U/ZvLdU8GiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KCK0HEuCs1rLqLDidWWNYGOXgPxM+dOe3rzd66aERhJfVoSgPwuxR9ZuUnx8Qo2Z+v6pqQAYf2KMKzzHEM3zmtddQz/eUA250ZEK4FXVhqAl1eWR5BeSmRGztZCCgUrVXPfibM9+/+B3toYDoGGryfczUzbMejoIC+CPI6W4B98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KFt5vlzJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744276501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ha8G/R6Z1nWekWpyrgNmSOP2tcQD41MQSkiD5umDxHo=;
	b=KFt5vlzJgdl45GOym3D29eQiAqBSA9yPk46VeEmnStYaNHKFQGqsCjwiSni4hgV0JLlVQM
	mV2LZDcBF2eGpD9bx95BRpyYTe3KHEzG4twyb5GKFEI3Ib5iEWNchnMo2UHlu8NFQuuk3d
	KyEOdu7S6mwISdMY/DUwp6QNCM3gRYA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-NX4EdsgbNgGSafhvrq2v7w-1; Thu, 10 Apr 2025 05:15:00 -0400
X-MC-Unique: NX4EdsgbNgGSafhvrq2v7w-1
X-Mimecast-MFC-AGG-ID: NX4EdsgbNgGSafhvrq2v7w_1744276499
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d22c304adso7497055e9.0
        for <linux-rdma@vger.kernel.org>; Thu, 10 Apr 2025 02:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744276499; x=1744881299;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ha8G/R6Z1nWekWpyrgNmSOP2tcQD41MQSkiD5umDxHo=;
        b=VVZ2xx6Hwg2VpmS/5X/QbOMxTGDu6+VdFcrbOXQ15iHyJPyo20rDKJeI+dm+DI+X2k
         /NUcvdgdGegk94/nokoRevB0MqhWCRhTPtrp3+x83v+63JrH4nlEayyI9SQOvm72C3IE
         VORkJ1yhx4dNYb2rF7TfG24k9TBM/aEOGsQIKAzndiZs0gWqcZIIhFT8K7q/wgwY2hZh
         nkSiXNqUKVqKFP/qMuGxqCrDOdAMDbbXMZ42dRbgob3UYs06CH+l7SfB2FS1CmebtBtb
         83tVZh25se3Ek+GQWkqIjEfDolEa+ss3wGYTTDexR4lTyyYxosym0lybi7dNT1DzUumm
         pzQw==
X-Forwarded-Encrypted: i=1; AJvYcCVW5vZGXSTZexb09MTlwuxRcJ+UgsOGPoqIAzJ0wbk/pmaD46bFcONIJn33QGyPyHdv6SiIyojTHag8@vger.kernel.org
X-Gm-Message-State: AOJu0Ywagl6SRBVtJd9iIcU0ruZeSsL7/CBDMpSOVshKHdwev/ERJEZ/
	LMrgop299yIqjNBztZxpxixU97o9o1BOR/b3EERZW9GMLWt+Jtt05DGOzPZ5s+twZHIPAsJ9J5k
	WzgDzrRAexLHI+jaA0j/mAvrQglGUeADlhLD0EwUAVAjLlod9kteR1vhWEUQ=
X-Gm-Gg: ASbGncuWqE+9AV7ix1sWuHwxdyhiCpM/PNAGh7JgG90PDfnlGCQcYdgHrCvbYYbWNY9
	MICrQtoceuw5tNExcLayzRwY+7ilqFdeEt71SSLSgHfR4gALZGX4DIX/z7x+PjU6PwzMmynq97N
	jaO7qOL1Pu67H5AH1TTW9U277NLxZichTkDFO3kqDyqjXlZUTLkutU8W93TAfxEVnLomvzmdkOw
	rQjl5gt5taMRYNsnRMFAS7zMRhYcTdWYfdYWvZerPPVMMNNfgDdBm2NTsE7aaGn1bQ7J9pZu7TU
	R855nGhuW2vkBCQQPfGWDWMO26BFvZ99eQr0Ekk=
X-Received: by 2002:a05:6000:430c:b0:38d:ba8e:7327 with SMTP id ffacd0b85a97d-39d8f5ea8a8mr1690768f8f.8.1744276498887;
        Thu, 10 Apr 2025 02:14:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVWWc7PS2YU/zohgZw5YNyHZwovcip8Ni6SgZ4G0iu/U6c+1LKCYwd5UcKQ77SyrufZNS7Lw==
X-Received: by 2002:a05:6000:430c:b0:38d:ba8e:7327 with SMTP id ffacd0b85a97d-39d8f5ea8a8mr1690733f8f.8.1744276498463;
        Thu, 10 Apr 2025 02:14:58 -0700 (PDT)
Received: from [192.168.88.253] (146-241-84-24.dyn.eolo.it. [146.241.84.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d89361191sm4249911f8f.10.2025.04.10.02.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 02:14:58 -0700 (PDT)
Message-ID: <9f7449e9-764b-4544-ac72-c5061dc518b6@redhat.com>
Date: Thu, 10 Apr 2025 11:14:56 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net] smc: Fix lockdep false-positive for IPPROTO_SMC.
To: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>,
 Wen Gu <guwen@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org,
 syzbot+be6f4b383534d88989f7@syzkaller.appspotmail.com,
 Kuniyuki Iwashima <kuniyu@amazon.com>
References: <20250407170332.26959-1-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250407170332.26959-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/7/25 7:03 PM, Kuniyuki Iwashima wrote:
> SMC consists of two sockets: smc_sock and kernel TCP socket.
> 
> Currently, there are two ways of creating the sockets, and syzbot reported
> a lockdep splat [0] for the newer way introduced by commit d25a92ccae6b
> ("net/smc: Introduce IPPROTO_SMC").
> 
>   socket(AF_SMC             , SOCK_STREAM, SMCPROTO_SMC or SMCPROTO_SMC6)
>   socket(AF_INET or AF_INET6, SOCK_STREAM, IPPROTO_SMC)
> 
> When a socket is allocated, sock_lock_init() sets a lockdep lock class to
> sk->sk_lock.slock based on its protocol family.  In the IPPROTO_SMC case,
> AF_INET or AF_INET6 lock class is assigned to smc_sock.
> 
> The repro sets IPV6_JOIN_ANYCAST for IPv6 UDP and SMC socket and exercises
> smc_switch_to_fallback() for IPPROTO_SMC.
> 
>   1. smc_switch_to_fallback() is called under lock_sock() and holds
>      smc->clcsock_release_lock.
> 
>       sk_lock-AF_INET6 -> &smc->clcsock_release_lock
>       (sk_lock-AF_SMC)
> 
>   2. Setting IPV6_JOIN_ANYCAST to SMC holds smc->clcsock_release_lock
>      and calls setsockopt() for the kernel TCP socket, which holds RTNL
>      and the kernel socket's lock_sock().
> 
>       &smc->clcsock_release_lock -> rtnl_mutex (-> k-sk_lock-AF_INET6)
> 
>   3. Setting IPV6_JOIN_ANYCAST to UDP holds RTNL and lock_sock().
> 
>       rtnl_mutex -> sk_lock-AF_INET6
> 
> Then, lockdep detects a false-positive circular locking,
> 
>   .-> sk_lock-AF_INET6 -> &smc->clcsock_release_lock -> rtnl_mutex -.
>   `-----------------------------------------------------------------'
> 
> but IPPROTO_SMC should have the same locking rule as AF_SMC.
> 
>       sk_lock-AF_SMC   -> &smc->clcsock_release_lock -> rtnl_mutex -> k-sk_lock-AF_INET6
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
>  -> #2 (&smc->clcsock_release_lock){+.+.}-{4:4}:
>        __mutex_lock_common kernel/locking/mutex.c:585 [inline]
>        __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
>        smc_switch_to_fallback+0x2d/0xa00 net/smc/af_smc.c:903
>        smc_sendmsg+0x13d/0x520 net/smc/af_smc.c:2781
>        sock_sendmsg_nosec net/socket.c:718 [inline]
>        __sock_sendmsg net/socket.c:733 [inline]
>        ____sys_sendmsg+0xaaf/0xc90 net/socket.c:2573
>        ___sys_sendmsg+0x135/0x1e0 net/socket.c:2627
>        __sys_sendmsg+0x16e/0x220 net/socket.c:2659
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
>  -> #1 (sk_lock-AF_INET6){+.+.}-{0:0}:
>        lock_sock_nested+0x3a/0xf0 net/core/sock.c:3645
>        lock_sock include/net/sock.h:1624 [inline]
>        sockopt_lock_sock net/core/sock.c:1133 [inline]
>        sockopt_lock_sock+0x54/0x70 net/core/sock.c:1124
>        do_ipv6_setsockopt+0x2160/0x4520 net/ipv6/ipv6_sockglue.c:567
>        ipv6_setsockopt+0xcb/0x170 net/ipv6/ipv6_sockglue.c:993
>        udpv6_setsockopt+0x7d/0xd0 net/ipv6/udp.c:1850
>        do_sock_setsockopt+0x222/0x480 net/socket.c:2303
>        __sys_setsockopt+0x1a0/0x230 net/socket.c:2328
>        __do_sys_setsockopt net/socket.c:2334 [inline]
>        __se_sys_setsockopt net/socket.c:2331 [inline]
>        __x64_sys_setsockopt+0xbd/0x160 net/socket.c:2331
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
>  -> #0 (rtnl_mutex){+.+.}-{4:4}:
>        check_prev_add kernel/locking/lockdep.c:3163 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3282 [inline]
>        validate_chain kernel/locking/lockdep.c:3906 [inline]
>        __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5228
>        lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5851
>        __mutex_lock_common kernel/locking/mutex.c:585 [inline]
>        __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
>        ipv6_sock_ac_close+0xd9/0x110 net/ipv6/anycast.c:220
>        inet6_release+0x47/0x70 net/ipv6/af_inet6.c:485
>        __sock_release net/socket.c:647 [inline]
>        sock_release+0x8e/0x1d0 net/socket.c:675
>        smc_clcsock_release+0xb7/0xe0 net/smc/smc_close.c:34
>        __smc_release+0x5c2/0x880 net/smc/af_smc.c:301
>        smc_release+0x1fc/0x5f0 net/smc/af_smc.c:344
>        __sock_release+0xb0/0x270 net/socket.c:647
>        sock_close+0x1c/0x30 net/socket.c:1398
>        __fput+0x3ff/0xb70 fs/file_table.c:464
>        task_work_run+0x14e/0x250 kernel/task_work.c:227
>        resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>        exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>        exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
>        __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>        syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
>        do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   rtnl_mutex --> sk_lock-AF_INET6 --> &smc->clcsock_release_lock
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&smc->clcsock_release_lock);
>                                lock(sk_lock-AF_INET6);
>                                lock(&smc->clcsock_release_lock);
>   lock(rtnl_mutex);
> 
>  *** DEADLOCK ***
> 
> 2 locks held by syz.4.1528/11571:
>  #0: ffff888077e88208 (&sb->s_type->i_mutex_key#10){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:877 [inline]
>  #0: ffff888077e88208 (&sb->s_type->i_mutex_key#10){+.+.}-{4:4}, at: __sock_release+0x86/0x270 net/socket.c:646
>  #1: ffff888027f596a8 (&smc->clcsock_release_lock){+.+.}-{4:4}, at: smc_clcsock_release+0x75/0xe0 net/smc/smc_close.c:30
> 
> stack backtrace:
> CPU: 0 UID: 0 PID: 11571 Comm: syz.4.1528 Not tainted 6.14.0-rc3-syzkaller-00267-gff202c5028a1 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>  print_circular_bug+0x490/0x760 kernel/locking/lockdep.c:2076
>  check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2208
>  check_prev_add kernel/locking/lockdep.c:3163 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3282 [inline]
>  validate_chain kernel/locking/lockdep.c:3906 [inline]
>  __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5228
>  lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5851
>  __mutex_lock_common kernel/locking/mutex.c:585 [inline]
>  __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
>  ipv6_sock_ac_close+0xd9/0x110 net/ipv6/anycast.c:220
>  inet6_release+0x47/0x70 net/ipv6/af_inet6.c:485
>  __sock_release net/socket.c:647 [inline]
>  sock_release+0x8e/0x1d0 net/socket.c:675
>  smc_clcsock_release+0xb7/0xe0 net/smc/smc_close.c:34
>  __smc_release+0x5c2/0x880 net/smc/af_smc.c:301
>  smc_release+0x1fc/0x5f0 net/smc/af_smc.c:344
>  __sock_release+0xb0/0x270 net/socket.c:647
>  sock_close+0x1c/0x30 net/socket.c:1398
>  __fput+0x3ff/0xb70 fs/file_table.c:464
>  task_work_run+0x14e/0x250 kernel/task_work.c:227
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
>  do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f8b4b38d169
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe4efd22d8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
> RAX: 0000000000000000 RBX: 00000000000b14a3 RCX: 00007f8b4b38d169
> RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
> RBP: 00007f8b4b5a7ba0 R08: 0000000000000001 R09: 000000114efd25cf
> R10: 00007f8b4b200000 R11: 0000000000000246 R12: 00007f8b4b5a5fac
> R13: 00007f8b4b5a5fa0 R14: ffffffffffffffff R15: 00007ffe4efd23f0
>  </TASK>
> 
> Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> Reported-by: syzbot+be6f4b383534d88989f7@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=be6f4b383534d88989f7
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Makes sense to me, waiting a little more to allow feedback from @Wenjia
and the SMC crew.

Thanks,

Paolo


