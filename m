Return-Path: <linux-rdma+bounces-13139-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2B0B47C26
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Sep 2025 18:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946643BCF3B
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Sep 2025 16:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48CE27F183;
	Sun,  7 Sep 2025 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="ndIbsl8i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A6818AFF
	for <linux-rdma@vger.kernel.org>; Sun,  7 Sep 2025 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757260879; cv=none; b=u87s1zdVZc/v8w/Uj3nHEVVOJRAlJv5RzRf6KshVRL+Oo1yZmXgyA98ERoRJ/9QkV1zuV18rwhLP451Z7CEgMYWSmuCKfedyVv66Gc03NUOW7jW1KiaQU8SguN2ePVJngOuQms6AtosrEOIx9cR8Iojrq0cHHNjIF+jAXnwXre8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757260879; c=relaxed/simple;
	bh=2iH/tmlgtIXVcbg5sIxO5juHiTu9/jGxxy+gkH576Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=f5Op5R752ZQHb98SPhrD3WCcve0BKHfz83x1jv4p7PfzegOxpWbEB8YfmHeNUJsCKwwi7+Jd2GaeKx3HeegzFPxTuuk3XXAbcOCu1CC4cSt4X7uIeQN+zuuyo1sDG31Om/PDFD25ESCyhi5DjNe2iv2iO8NhRZqkrDwFGCDgrFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=ndIbsl8i; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45de6ab6ce7so595325e9.1
        for <linux-rdma@vger.kernel.org>; Sun, 07 Sep 2025 09:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757260875; x=1757865675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vg7CHqQNYYzh26+Hh5oDujqwGy19VW95gl4qkCfQ+9o=;
        b=ndIbsl8irgOlKTtqnxvhy5OKtGVZNhDgzmi9bwlj6boHXjsgKCnyV+cdqc5Upkjlhh
         /1sQg/nHV70LH9gC+8Y53jCdQQbTp7ZLlXzHojFyMmUmEnD36Cx8ekwrBTGR0mRPxe+p
         iPH/OEtwW+QdBrYuUfnAERyf582T89yc7k0eN/JqsRElwPGteCFgfq1IeV0tHYBSXg6E
         /Cs8jrn8h89ZoF5ToPMEHSD64AyW7O4xYwFYwgI91wMVL/cDElYUqs75LVzLt/iG9AHH
         JmOMKR/P4SpTz7GzAL2oVZqd2EX8u90m/OmGkrUqK4NxwflSVHNPqthU8BfkXjtDbY0/
         9LgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757260875; x=1757865675;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vg7CHqQNYYzh26+Hh5oDujqwGy19VW95gl4qkCfQ+9o=;
        b=L8tjxzXys0tAXLu21bOIQhhBCyLgD76+1f/tFO2cQZs0OsVhQWGWN38KAH83QV7oJQ
         NZJqHDvhqKy4urEAurzEdbqoK8MWIBKb1fNC9Mjl+DT0UJrCiNsH1RfpVVOpGMoqytlH
         wWKMDuaQpYvX12g3cHyQ/2FJZpcaKDI710Rx+Rf1hrBPau7WKct0PINmnR9z6Ulxl9N8
         hVuKM23QfKhw/QqpMDG76i0Mk9HKTFds7S/BGFJyxRlJUkHYDTLW+9k9EzwEszjkz2SL
         PFiGZBNYnH0xp70n774zpRnF5cNypSPAFNOIOJRAKmexQ6wvM3pkIsshtPFfYsVcCyJo
         4RGg==
X-Gm-Message-State: AOJu0YzmbQWeJ872FFpiHMiM7NYuIthGOZrJmbIeKmLqmZPybkcf9Txg
	nQuMF8OUu+gKcTlv7Ar9eh48h8DuTh6xP1I4XvL/GHnwNs6j7tqWw8q/Je/fRzVVSro=
X-Gm-Gg: ASbGncvJI2CchhLPEJWgcR5CMuaslYY5gp6/tkUdSLza+CYTNnXLMR9ROZBb9pLbQ2h
	/XrgZecsas1KDy2UViBPSslsuiWOkLoiA9FTA5lrD32tGqSP6hoU7eNt3NgTag1qAFyx4nS3tFB
	ngACoS2UqOmtYBN23OcmPKWKJogXvJ/4tABdWBi/kqGIcqTdPXeKzYnA74vZzeGWItSv6JivLJb
	XG2dzSbxT7siUNqzMAFAnnpL0AEvevtQhqCygAoBwg3QDatqP6AQnj7husvPm2SDbW82jHRSaiX
	nNCj8KguPF2N5D6kOgcq/hybr6Rg6Ce0yIesQc8p8k4v8nqTHIdZ7uKyqhJeHeascoNheXQfqKN
	kk0PMOufWlnwcEMlGsAEksqlzI5ZNJXSRGvP0zraZzKXVRHuSzwugTTX2CktaKDQfqibGoYA9w9
	rzV0tuZ3/hXw==
X-Google-Smtp-Source: AGHT+IGn9DppX1oWsqBRvsOrhn+d3X5JdUygKPkoLsD9fVU4imK0p6ui2veZhjeECxYo+CUppl84ZA==
X-Received: by 2002:a05:600c:1386:b0:45c:b5f7:c6e4 with SMTP id 5b1f17b1804b1-45dddedf9bfmr35637975e9.35.1757260874428;
        Sun, 07 Sep 2025 09:01:14 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45de45dce11sm27848815e9.10.2025.09.07.09.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 09:01:14 -0700 (PDT)
Date: Sun, 7 Sep 2025 09:01:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
 sidraya@linux.ibm.com, wenjia@linux.ibm.com, mjambigi@linux.ibm.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com
Cc: linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Fw: [Bug 220544] New: AF_SMC deadlock: held by __sock_release,
 smc_release, and __flush_work
Message-ID: <20250907090107.44a3f68e@hermes.local>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Begin forwarded message:

Date: Sun, 07 Sep 2025 03:42:22 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 220544] New: AF_SMC deadlock: held by __sock_release, smc_release, and __flush_work


https://bugzilla.kernel.org/show_bug.cgi?id=220544

            Bug ID: 220544
           Summary: AF_SMC deadlock: held by __sock_release, smc_release,
                    and __flush_work
           Product: Networking
           Version: 2.5
    Kernel Version: 6.12.x
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: hi@fourdim.xyz
        Regression: No

Created attachment 308627
  --> https://bugzilla.kernel.org/attachment.cgi?id=308627&action=edit  
crash full log and program source code

[ 2499.781797] 
[ 2499.782400] ======================================================
[ 2499.784129] WARNING: possible circular locking dependency detected
[ 2499.785824] 6.12.42 #1 Not tainted
[ 2499.786843] ------------------------------------------------------
[ 2499.788589] 1296/22742 is trying to acquire lock:
[ 2499.789941] ffff88801776ec18
((work_completion)(&new_smc->smc_listen_work)){+.+.}-{0:0}, at:
__flush_work+0x514/0xd50
[ 2499.793080] 
[ 2499.793080] but task is already holding lock:
[ 2499.794731] ffff888017768e98 (sk_lock-AF_SMC/1){+.+.}-{0:0}, at:
smc_release+0x376/0x600
[ 2499.797004] 
[ 2499.797004] which lock already depends on the new lock.
[ 2499.797004] 
[ 2499.799295] 
[ 2499.799295] the existing dependency chain (in reverse order) is:
[ 2499.801365] 
[ 2499.801365] -> #1 (sk_lock-AF_SMC/1){+.+.}-{0:0}:
[ 2499.803149]        lock_sock_nested+0x3a/0x100
[ 2499.804427]        smc_listen_out+0x1ea/0x4c0
[ 2499.805686]        smc_listen_work+0x4d1/0x5520
[ 2499.806987]        process_one_work+0x94a/0x1740
[ 2499.808415]        worker_thread+0x5c4/0xe10
[ 2499.809650]        kthread+0x2ad/0x360
[ 2499.810763]        ret_from_fork+0x4e/0x80
[ 2499.811966]        ret_from_fork_asm+0x1a/0x30
[ 2499.813324] 
[ 2499.813324] -> #0
((work_completion)(&new_smc->smc_listen_work)){+.+.}-{0:0}:
[ 2499.815691]        __lock_acquire+0x2413/0x4310
[ 2499.816983]        lock_acquire.part.0+0xff/0x350
[ 2499.818259]        __flush_work+0x528/0xd50
[ 2499.819376]        __cancel_work_sync+0x105/0x130
[ 2499.820689]        smc_clcsock_release+0x61/0xf0
[ 2499.821958]        __smc_release+0x5c9/0x8a0
[ 2499.823163]        smc_close_non_accepted+0xd7/0x210
[ 2499.824602]        smc_close_active+0x535/0x10e0
[ 2499.825867]        __smc_release+0x643/0x8a0
[ 2499.827067]        smc_release+0x1f0/0x600
[ 2499.828197]        __sock_release+0xac/0x260
[ 2499.829427]        sock_close+0x1c/0x30
[ 2499.830506]        __fput+0x3f6/0xb40
[ 2499.831552]        __fput_sync+0x4a/0x60
[ 2499.832651]        __x64_sys_close+0x86/0x100
[ 2499.833855]        do_syscall_64+0xbb/0x1d0
[ 2499.835043]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 2499.836574] 
[ 2499.836574] other info that might help us debug this:
[ 2499.836574] 
[ 2499.838725]  Possible unsafe locking scenario:
[ 2499.838725] 
[ 2499.840491]        CPU0                    CPU1
[ 2499.841748]        ----                    ----
[ 2499.843036]   lock(sk_lock-AF_SMC/1);
[ 2499.844110]                               
lock((work_completion)(&new_smc->smc_listen_work));
[ 2499.846436]                                lock(sk_lock-AF_SMC/1);
[ 2499.848134]   lock((work_completion)(&new_smc->smc_listen_work));
[ 2499.849780] 
[ 2499.849780]  *** DEADLOCK ***
[ 2499.849780] 
[ 2499.851388] 3 locks held by 1296/22742:
[ 2499.852456]  #0: ffff88801ed58d88 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3},
at: __sock_release+0x81/0x260
[ 2499.855185]  #1: ffff888017768e98 (sk_lock-AF_SMC/1){+.+.}-{0:0}, at:
smc_release+0x376/0x600
[ 2499.857486]  #2: ffffffff86e9dc00 (rcu_read_lock){....}-{1:2}, at:
__flush_work+0xff/0xd50
[ 2499.859710] 
[ 2499.859710] stack backtrace:
[ 2499.860913] CPU: 0 UID: 0 PID: 22742 Comm: 1296 Not tainted 6.12.42 #1
[ 2499.860935] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.15.0-1 04/01/2014
[ 2499.860944] Call Trace:
[ 2499.860951]  <TASK>
[ 2499.860959]  dump_stack_lvl+0xba/0x110
[ 2499.860983]  print_circular_bug.cold+0x1e8/0x27f
[ 2499.861041]  check_noncircular+0x30e/0x3c0
[ 2499.861064]  ? __pfx_check_noncircular+0x10/0x10
[ 2499.861084]  ? register_lock_class+0xb2/0x12e0
[ 2499.861112]  ? lockdep_lock+0xb5/0x1b0
[ 2499.861131]  ? __pfx_lockdep_lock+0x10/0x10
[ 2499.861151]  __lock_acquire+0x2413/0x4310
[ 2499.861177]  ? __pfx___lock_acquire+0x10/0x10
[ 2499.861199]  ? __pfx_mark_lock+0x10/0x10
[ 2499.861221]  ? __flush_work+0x514/0xd50
[ 2499.861240]  lock_acquire.part.0+0xff/0x350
[ 2499.861261]  ? __flush_work+0x514/0xd50
[ 2499.861280]  ? lock_release+0x209/0x7d0
[ 2499.861302]  ? __pfx_lock_acquire.part.0+0x10/0x10
[ 2499.861323]  ? __flush_work+0x514/0xd50
[ 2499.861342]  ? trace_lock_acquire+0x132/0x1c0
[ 2499.861360]  ? __flush_work+0x514/0xd50
[ 2499.861378]  ? lock_acquire+0x31/0xc0
[ 2499.861398]  ? __flush_work+0x514/0xd50
[ 2499.861418]  __flush_work+0x528/0xd50
[ 2499.861436]  ? __flush_work+0x514/0xd50
[ 2499.861456]  ? __pfx___flush_work+0x10/0x10
[ 2499.861475]  ? __pfx_sock_def_readable+0x10/0x10
[ 2499.861497]  ? trace_irq_disable.constprop.0+0xcd/0x110
[ 2499.861519]  ? __pfx_wq_barrier_func+0x10/0x10
[ 2499.861548]  ? __pfx___might_resched+0x10/0x10
[ 2499.861567]  ? __pfx_sock_def_readable+0x10/0x10
[ 2499.861587]  __cancel_work_sync+0x105/0x130
[ 2499.861609]  smc_clcsock_release+0x61/0xf0
[ 2499.861630]  ? __local_bh_enable_ip+0x9b/0x140
[ 2499.861646]  __smc_release+0x5c9/0x8a0
[ 2499.861665]  ? lockdep_hardirqs_on_prepare+0x201/0x400
[ 2499.861688]  ? __pfx_sock_def_readable+0x10/0x10
[ 2499.861708]  smc_close_non_accepted+0xd7/0x210
[ 2499.861730]  smc_close_active+0x535/0x10e0
[ 2499.861753]  __smc_release+0x643/0x8a0
[ 2499.861772]  ? lockdep_hardirqs_on_prepare+0x25c/0x400
[ 2499.861795]  smc_release+0x1f0/0x600
[ 2499.861814]  __sock_release+0xac/0x260
[ 2499.861840]  ? __pfx_sock_close+0x10/0x10
[ 2499.861864]  sock_close+0x1c/0x30
[ 2499.861886]  __fput+0x3f6/0xb40
[ 2499.861912]  __fput_sync+0x4a/0x60
[ 2499.861935]  __x64_sys_close+0x86/0x100
[ 2499.861950]  do_syscall_64+0xbb/0x1d0
[ 2499.861972]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 2499.861992] RIP: 0033:0x7f40854559a0
[ 2499.862033] Code: 0d 00 00 00 eb b2 e8 0f f8 01 00 66 2e 0f 1f 84 00 00 00
00 00 0f 1f 44 00 00 80 3d 41 1c 0e 00 00 74 17 b8 03 00 00 00 0f 05 <48> 3d 00
f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
[ 2499.862049] RSP: 002b:00007ffecd7bbad8 EFLAGS: 00000202 ORIG_RAX:
0000000000000003
[ 2499.862065] RAX: ffffffffffffffda RBX: 0000000000000005 RCX:
00007f40854559a0
[ 2499.862077] RDX: 0000000000000000 RSI: 000055df79c1fe38 RDI:
0000000000000005
[ 2499.862087] RBP: 0000000000000006 R08: 000000000000f800 R09:
0000000000000073
[ 2499.862098] R10: 0000000000000000 R11: 0000000000000202 R12:
00007ffecd7bbb80
[ 2499.862110] R13: 00007ffecd7bbdb8 R14: 000055df79c21dd8 R15:
0000000000000000
[ 2499.862128]  </TASK>


Crashes happened on 6.12.34 and 6.12.42.
Machine info:
QEMU X86_64
Linux version 6.12.42(gcc (GCC) 15.1.1 20250729, GNU ld (GNU Binutils) 2.45.0)
#1 SMP PREEMPT_DYNAMIC Tue Aug 19 21:04:29 EDT 2025
Command line: console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0
nokaslr
infiniband enabled through rxe

Programs and logs that trigger the bug are attached

Usage `cat crash.input | program`

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

