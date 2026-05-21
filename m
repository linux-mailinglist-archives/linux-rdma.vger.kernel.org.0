Return-Path: <linux-rdma+bounces-21142-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEsaMp+ND2pdNQYAu9opvQ
	(envelope-from <linux-rdma+bounces-21142-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 00:56:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D30B85AC7CB
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 00:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B20B4300B8D3
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 22:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA85836997A;
	Thu, 21 May 2026 22:56:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com [209.85.160.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD72036683B
	for <linux-rdma@vger.kernel.org>; Thu, 21 May 2026 22:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779404183; cv=none; b=tl3f7qMDevGH3TIDYKeLmunnLIr5d/56fA2Prc+3p+jh8AxoUAosd+35EieQTMpQniBXQZ70f3S8KlecQys8evaoM6IHtmltcelFjby5Li0XluUGcR1fGr2CUCPblB2B2jHCcbvi/aPOu0fLdyfpzjuq1+Jz6qITvqeL9JBd4CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779404183; c=relaxed/simple;
	bh=woFJNG+AkIhIjdrUa3L5vqm1iAVDH/ulwz2H+d6Dlac=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EFsCk9fy3Xe1Q/RHBWHNDVF3uHZTMsaU/Wu3i9H09FZiHSL3Ts4k1sasJslqIzbin0qr2LufTBW6Sen+n8LYW4NRqYyP2wvy9odBFXe9P6HWh9Fb1dm3eRHBFyGStuMycQWfJ5LKKLc1gRY2ADLHp5lgA5hHYtYzY/5+uSFNY9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-4346755f7dcso12229599fac.3
        for <linux-rdma@vger.kernel.org>; Thu, 21 May 2026 15:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779404181; x=1780008981;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wKcggRR9OaSzW53BRXT7XgtoSulSO0zV7NnoewwOLLk=;
        b=lSwD0+J20EeDj/MFzhnQP5m37Jum21iv93gIJL2yW7Ui6n9sDmLioRGAcGrfJzsJqi
         L2KHNVjDSWDqyU76UHT23NLQ+L1aE3OUl8OVyUNicg6QxRmPycTjNdpK74YA6G45Kh/T
         5eAJ4uLTNEI/Hw/JSPsP0yh5K/nIggetrL3ll5WOmPivy1/inqrARZSWojtNs5rvu7qZ
         Bu3VthA8NJSwnebGH6CR3VStShMAbVgnDRi/ZBeKyAvJJcvf5TYSaDtkOMgJYaq8pNFj
         JlyjsNsNcXe/kkBk2ijj78XfwR1kevVFIPfAVt1t5KWrKYRiLM+VjoCYY99QE6p3XrSe
         pv3w==
X-Forwarded-Encrypted: i=1; AFNElJ+AC6UeoJIBaWalpsFgtMqCQHtywYMo2wuinlVWIMbkeI7oHXTd2cUYNXRMrgFIKL68+VgvvRpx5OVA@vger.kernel.org
X-Gm-Message-State: AOJu0YzFEYsqFdtKMpSbEH0r8iCAuDTiElDr4GBjHRy4kk7P5wgSL9nR
	qkzjBpionaUvonY7y6JL5fRDV7+SV0BUXiBdwGcxjiGDI+/24DU6qpQw6qHGlS0HzUGUIUjbOQc
	1o/OlFCcWlDQ9EPO0ouiHeLWTMg2YTM/7RTjufzhVFP7UnEZDHlPX+ymKWNs=
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:998:b0:69d:7dbc:19b1 with SMTP id
 006d021491bc7-69d7ed29503mr687622eaf.55.1779404180791; Thu, 21 May 2026
 15:56:20 -0700 (PDT)
Date: Thu, 21 May 2026 15:56:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a0f8d94.050a0220.6b33c.0000.GAE@google.com>
Subject: [syzbot] [rds?] KCSAN: data-race in rds_poll / rds_sendmsg
From: syzbot <syzbot+fbf3648ae7f5bdb05c59@syzkaller.appspotmail.com>
To: achender@kernel.org, allison.henderson@oracle.com, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, rds-devel@oss.oracle.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=2e40c0f41e01837e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21142-lists,linux-rdma=lfdr.de,fbf3648ae7f5bdb05c59];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,appspotmail.com:email,storage.googleapis.com:url]
X-Rspamd-Queue-Id: D30B85AC7CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    e5d505e3664b Merge tag 'trace-v7.1-rc3' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144d37ba580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2e40c0f41e01837e
dashboard link: https://syzkaller.appspot.com/bug?extid=fbf3648ae7f5bdb05c59
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d01e24b29d85/disk-e5d505e3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/763a9ed109de/vmlinux-e5d505e3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aa1f01135fd4/bzImage-e5d505e3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fbf3648ae7f5bdb05c59@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in rds_poll / rds_sendmsg

write to 0xffff8881054183a4 of 4 bytes by task 9010 on cpu 0:
 rds_sendmsg+0x1001/0x15b0 net/rds/send.c:1391
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 ____sys_sendmsg+0x563/0x5b0 net/socket.c:2698
 ___sys_sendmsg+0x195/0x1e0 net/socket.c:2752
 __sys_sendmsg net/socket.c:2784 [inline]
 __do_sys_sendmsg net/socket.c:2789 [inline]
 __se_sys_sendmsg net/socket.c:2787 [inline]
 __x64_sys_sendmsg+0xd4/0x160 net/socket.c:2787
 x64_sys_call+0x194c/0x3020 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x12c/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff8881054183a4 of 4 bytes by task 9013 on cpu 1:
 rds_poll+0x9b/0x310 net/rds/af_rds.c:222
 sock_poll+0x21c/0x240 net/socket.c:1502
 vfs_poll include/linux/poll.h:82 [inline]
 __io_arm_poll_handler+0x1ef/0xbf0 io_uring/poll.c:590
 io_arm_apoll+0x2eb/0x400 io_uring/poll.c:698
 io_arm_poll_handler+0x12f/0x160 io_uring/poll.c:727
 io_queue_async+0x25d/0x320 io_uring/io_uring.c:1634
 io_queue_sqe io_uring/io_uring.c:1660 [inline]
 io_req_task_submit+0x9b/0xa0 io_uring/io_uring.c:1062
 io_handle_tw_list+0x1f5/0x230 io_uring/tw.c:72
 tctx_task_work_run+0x42/0x140 io_uring/tw.c:132
 tctx_task_work+0x3f/0x80 io_uring/tw.c:150
 task_work_run+0x130/0x1a0 kernel/task_work.c:233
 get_signal+0xdea/0xf20 kernel/signal.c:2809
 arch_do_signal_or_restart+0x96/0x480 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
 exit_to_user_mode_loop+0x6f/0x820 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x232/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00000000 -> 0x00000001

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 9013 Comm: syz.7.10555 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

