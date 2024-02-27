Return-Path: <linux-rdma+bounces-1156-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324D78699A9
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Feb 2024 16:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63F6F1C23FCE
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Feb 2024 15:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2D614A0AA;
	Tue, 27 Feb 2024 14:58:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5711F14A0A8
	for <linux-rdma@vger.kernel.org>; Tue, 27 Feb 2024 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045901; cv=none; b=nf/MffJgQQe338XKmvZSR15yndBFV97CGS1hcJmOiaXvMShTWZjH7eKSTpd2S0hS1zCSUXOiMbi+DnojOH3prQkEZ7rqHq71jugbNerwjjhe6vqu+1VOm03/OCKlEldAWrVNMNlWHlm1FhZZVIQNqHBjS6d44nwlWI+/N+JWZ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045901; c=relaxed/simple;
	bh=v6CtZFIkskFMZP/tfuYcxsRVOqDtKP5Ax0Lc0N+SkrU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LPqod8Fbxsh9xN0DzXfA/wlc2AJxf0WvA+Hsb7+3upDXVx2k3lWOSaQJHDUyJDtdStx85EyhJYMLpAnRQTdDFodYMny6kmBVKvtOtn0i4x1B84LWJOWspd9DpVdfyWJ4NdDB7poNSPmHi4Hqv20Ed4JCZ0xK9T8/6JYsD9ExiaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c7842d0340so474420839f.1
        for <linux-rdma@vger.kernel.org>; Tue, 27 Feb 2024 06:58:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709045899; x=1709650699;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AnxpxdbEEupdGdQ67wxP7la7rz90oqHR6d7BHkK4Pxk=;
        b=Vovxp9rNXaPwTK3XPbZnUIEs0rsnLkXtMT0AEyLgQZPa82L0OcuLMX39YpxTfl+oUB
         K+1R85baCeEswAAh77soswW2rJf6tjhvklC82RUCg8BiJ4PE1sqv17kBRyLd6+PuQMMh
         vhdngLG0NqJ7rj3K0xfihZu/rmi+YAPn/Kt1u0uNvyNchPQANwR7eZewHlAAUHdszpxY
         EiT7+3Hgy2YJ12pteHmOPDY0XgoaESDs8DrFC/haVmfSUhWQj7ldIdsgv8UzE47+Y+x7
         Hh6i+6UIvOGoAVh3cTpp6mlEx3mYdQJfJPf50NsIf+27BPo6msdWwmUTYuTL5VZB3MCB
         fKsA==
X-Forwarded-Encrypted: i=1; AJvYcCVN5BFdM34q83EbnOW8PW9dBcZTxBDdtCThNg1UncYWFmGBVtP9xVPeGwqomNRi4PG8jt/XeqydPAkAaQG07ycoSN5cPkwEcrn5yw==
X-Gm-Message-State: AOJu0Yzrl/7OVYG8HnCkT4X+erkThZs/7Ck8RQGu/RALu4nWEZIQv2N0
	o7totBB/erb/pW4HTnyLJEKTFlQunConM/KO0e4YHJQDoJNJKbVeQ2pRgOeQGbCsny+63KguJPr
	KH7+DoUH7wGWlhoC9Y3Vh27KFpYc0DB0vdeA8jD7s5bbVNHJnGHMaAhc=
X-Google-Smtp-Source: AGHT+IF/Ls8IgqyUvBX1SZoLCecsLftlei40N9hwPdoSs4z3YEAKoVzw/T7dIpahfEU7otPMnmtKHalq3FZUtrb+NXc71nNmIPPr
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3714:b0:474:7eb2:f12 with SMTP id
 k20-20020a056638371400b004747eb20f12mr290417jav.2.1709045899611; Tue, 27 Feb
 2024 06:58:19 -0800 (PST)
Date: Tue, 27 Feb 2024 06:58:19 -0800
In-Reply-To: <00000000000080c6c805f915ade0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c0550506125e4118@google.com>
Subject: Re: [syzbot] [rds?] WARNING in rds_conn_connect_if_down
From: syzbot <syzbot+d4faee732755bba9838e@syzkaller.appspotmail.com>
To: allison.henderson@oracle.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, rds-devel@oss.oracle.com, 
	santosh.shilimkar@oracle.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    25d434257464 Merge branch 'pcs-xpcs-cleanups'
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11f0034a180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57c41f64f37f51c5
dashboard link: https://syzkaller.appspot.com/bug?extid=d4faee732755bba9838e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11cbd722180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10ff934a180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2731aa9fb143/disk-25d43425.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d1daf5663559/vmlinux-25d43425.xz
kernel image: https://storage.googleapis.com/syzbot-assets/798446e4189b/bzImage-25d43425.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d4faee732755bba9838e@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5244 at net/rds/connection.c:931 rds_conn_connect_if_down+0x95/0xb0 net/rds/connection.c:931
Modules linked in:
CPU: 0 PID: 5244 Comm: syz-executor403 Not tainted 6.8.0-rc5-syzkaller-01592-g25d434257464 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:rds_conn_connect_if_down+0x95/0xb0 net/rds/connection.c:931
Code: 00 4c 89 f0 48 c1 e8 03 42 80 3c 38 00 74 08 4c 89 f7 e8 2e c3 42 f7 49 8b 3e 5b 41 5e 41 5f e9 f1 fa ff ff e8 ac 49 e0 f6 90 <0f> 0b 90 eb cb 89 d9 80 e1 07 38 c1 7c a9 48 89 df e8 75 c2 42 f7
RSP: 0018:ffffc900042cf8a0 EFLAGS: 00010293
RAX: ffffffff8ab323c4 RBX: 0000000000000002 RCX: ffff888021100000
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: ffffc900042cfad0 R08: ffffffff8ab3238b R09: ffffffff8ab44361
R10: 0000000000000002 R11: ffff888021100000 R12: ffff8880746ee000
R13: ffff88802e39a6c0 R14: ffff8880260f2000 R15: dffffc0000000000
FS:  00007f8c89bff6c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002069d000 CR3: 000000002989a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rds_sendmsg+0x1409/0x2280 net/rds/send.c:1319
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f8c89c84519
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8c89bff218 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f8c89d0e428 RCX: 00007f8c89c84519
RDX: 0000000000000000 RSI: 0000000020000800 RDI: 0000000000000003
RBP: 00007f8c89d0e420 R08: 00007ffeca3c5797 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f8c89d0e42c
R13: 00007f8c89cdb4f4 R14: 732e79726f6d656d R15: 00007ffeca3c5798
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

