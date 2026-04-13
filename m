Return-Path: <linux-rdma+bounces-19294-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFguA9EQ3WkOZQkAu9opvQ
	(envelope-from <linux-rdma+bounces-19294-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 17:50:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FA23EE2F1
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 17:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12747301AF77
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 15:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D483BF68E;
	Mon, 13 Apr 2026 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZY+rwfh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA237262F;
	Mon, 13 Apr 2026 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776095039; cv=none; b=N8/WOMKG8bDU13oc2Hv+lhF6VbLnY2OWB6exDOS7zUAooLdDFFgjoF0nXw+FPunYrgDyMTQd+QBYsevQEjc6ZSSJzuJBBuuhsfB+OC69rNnzaBdIUf+mEgFHjxYAxbkgyLdapNQbxFcsr+FFuq1qOnW8C1+UVvNIi37+n7mm/jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776095039; c=relaxed/simple;
	bh=7h0XxI+w9IS8gzg0n1Zgs6B7YWeMT+op97h0d1y8m2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xx2kuE1tYAxiB20VRJSVUKuQ/ntzXnATLqFKbTpwREVmgF+HFADaESyu8KBbalqFcsbDNE8axH7R+6sv3rCDZlxoTymmu0ufveqe+2/Z29HDjmBUa/F1y2Jo/t6aBGzjLOKG2sJcy/GvY+EVFwLtMBFJ/2CQeQFpJG0eIcSPfa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZY+rwfh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB8FC2BCAF;
	Mon, 13 Apr 2026 15:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776095039;
	bh=7h0XxI+w9IS8gzg0n1Zgs6B7YWeMT+op97h0d1y8m2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FZY+rwfhOCRPgZmJfpDnURVfnagsJGLfSqVB6qh0FzP0vpwCAEIt0L3fyvl2iLi+w
	 VTfuPnuLXrOP2UGrDaBH+2XuUuGLtujyzIZPzAYchWKdjElzd/IupZc8TzgOkfDhUs
	 +SISzRa4NKRmYbCLOxjgRlY/KY3SQZwFUpxcxow53TUtCevxkyo+f38jAKhsyzrgPL
	 Dme/ILUQ2Z33aE1xL7XY5LMAbIzAYHENxqAcuDlhymW8DQYiT7JFqeyH5pDLCBipbi
	 O+R9ii2PpCck/tP1fbO9Eo7KQFLt1LiL26FqxAjOV5yM1upyyvqIDCaLDxDaW2dAUW
	 p7vfPUnbwIAmg==
Date: Mon, 13 Apr 2026 18:43:53 +0300
From: Leon Romanovsky <leon@kernel.org>
To: syzbot <syzbot+03393ff6c35fd2cc43de@syzkaller.appspotmail.com>
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [syzbot] [rdma?] WARNING in ib_dealloc_device
Message-ID: <20260413154353.GK21470@unreal>
References: <69dc3310.a00a0220.475f0.0018.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69dc3310.a00a0220.475f0.0018.GAE@google.com>
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=45cb3c58fd963c27];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-19294-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,googlegroups.com:email,syzkaller.appspot.com:url,storage.googleapis.com:url,msgid.link:url];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,03393ff6c35fd2cc43de];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 57FA23EE2F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 12, 2026 at 05:04:32PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7f87a5ea75f0 Merge tag 'hid-for-linus-2026040801' of git:/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11778eba580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=45cb3c58fd963c27
> dashboard link: https://syzkaller.appspot.com/bug?extid=03393ff6c35fd2cc43de
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0f5deca1373e/disk-7f87a5ea.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/6aea6c1c6b6e/vmlinux-7f87a5ea.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/61444b289e96/bzImage-7f87a5ea.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+03393ff6c35fd2cc43de@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> !xa_empty(&device->compat_devs)
> WARNING: drivers/infiniband/core/device.c:682 at ib_dealloc_device+0x187/0x200 drivers/infiniband/core/device.c:682, CPU#0: kworker/u8:37/4856

I think that we have only one patch in this area https://patch.msgid.link/20260127093839.126291-1-jiri@resnulli.us

Thanks


> Modules linked in:
> CPU: 0 UID: 0 PID: 4856 Comm: kworker/u8:37 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
> Tainted: [L]=SOFTLOCKUP
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
> Workqueue: ib-unreg-wq ib_unregister_work
> RIP: 0010:ib_dealloc_device+0x187/0x200 drivers/infiniband/core/device.c:682
> Code: e8 de ec ad f9 48 89 df e8 56 59 07 00 48 81 c3 30 08 00 00 48 89 df 5b 41 5c 41 5e 41 5f 5d e9 0f 09 60 fd e8 ba ec ad f9 90 <0f> 0b 90 e9 72 ff ff ff e8 ac ec ad f9 90 0f 0b 90 eb 8f e8 a1 ec
> RSP: 0018:ffffc9000f49fa18 EFLAGS: 00010293
> RAX: ffffffff88169536 RBX: ffff888039d40000 RCX: ffff88806a691e80
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffff888039d41308 R08: 0000000000000000 R09: 0000000000000000
> R10: dffffc0000000000 R11: fffffbfff1ed4eb7 R12: 1ffff110073a81fd
> R13: dffffc0000000000 R14: ffff888039d41268 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff888126332000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ff6d2897e9c CR3: 0000000022382000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000f1ffffdf
> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __ib_unregister_device+0x393/0x3f0 drivers/infiniband/core/device.c:1545
>  ib_unregister_work+0x19/0x30 drivers/infiniband/core/device.c:1639
>  process_one_work kernel/workqueue.c:3276 [inline]
>  process_scheduled_works+0xb6e/0x18c0 kernel/workqueue.c:3359
>  worker_thread+0xa53/0xfc0 kernel/workqueue.c:3440
>  kthread+0x388/0x470 kernel/kthread.c:436
>  ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

