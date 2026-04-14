Return-Path: <linux-rdma+bounces-19348-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Qa/UEe1j3mmcDgAAu9opvQ
	(envelope-from <linux-rdma+bounces-19348-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 17:57:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD903FC3A4
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 17:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB2F93026C1D
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 15:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F853EAC68;
	Tue, 14 Apr 2026 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="uBb01W7w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767A83B2FD1
	for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 15:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776182247; cv=none; b=YWz0DYNjmLdeXi/fy94xOLyUWwlWzpNTXmJ9p0axNtNxSKuMStdd0aRvVaDQp48zGdIIO4ZN1BKyLISEmqL0MIE4ipDd7saJbelbYjB5ty4UJyMezE+dxYTJuyNIjZJs6JlPRlDMbkfPgopW469BRe+cpaLWXoeqR9+DTH/iVTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776182247; c=relaxed/simple;
	bh=wGgw+qgo747DRb+gygDuh4GWuFQBDTB9e5MDpiBFEjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nf6T5jzpTbSpH2avWD0tXjzi5G7BFKduBkiNLhbyK94MxKb+4wnBG+fAuiXouKVXLxCNy/CUSCSuw2cGxy6G3dRddR0c1hbX9sjC2F6cQVbQKfbySZ2xMDL9phBZEaGlrNNSFZW5grnCwI2V1Hj1sM4bBFrL+f79uPGp/WQXPuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=uBb01W7w; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488ba840146so56762165e9.1
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 08:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1776182243; x=1776787043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T4PXTdofcGZmYLyTTFyqEDRAXNhc6S7ITH1t3RuKHrg=;
        b=uBb01W7wpg/AhNnPPQzjv6c0kn1POiTcToG8QnZ/ZYNIRMRnHtHFRcUJKTdvfiAMk5
         Gccdt7B6MpRt0h4RLwNfN+tedSeMlgo4zyRljlhZOv1NsTdpiSRF0Si4UMLJU2x80ibQ
         ZmySugzcCo/Cizn34tjwdbuuRK0G7DNzulLgWyjTDjEjha7fYq79mkDlEjVVm+Jk6HNN
         dZ+25k9BjgAAXA603P6IO0W0vWbgC++fUkIIjyHARxjDvoUYiem2nXDNxGSIV3zqNbfj
         pV/ter4Yg2ffcWxv5BACYcTBt0q5js7gkYeMUJcnMBJZRPJ7Wqqz0nJp8cKj2Rs2d5J/
         uIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776182243; x=1776787043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4PXTdofcGZmYLyTTFyqEDRAXNhc6S7ITH1t3RuKHrg=;
        b=A0E5EYwqCMr4fqGMuN0EUZdvkMf0baEEzqOOBlUsjhAM4K4dqq3VfQLUtk0CpMGGSa
         38fHZ3njBGIFUbB+9pI3/HFxEF9s6AaAjHxV0gniyO564cG65u+ES7abIf+yuLMF/szt
         UmZ/UgHuibTkd3noc5endHTPJ/SewNdBUmoSFCJykBsaX5h4fSixvEiXeL79Swsu7ywv
         Z/UZMuzu2KqazGVnuPamsZidOswHYZlFGJrqD41TjDTTWnY2TY/nNu4QEsmUKy6rU1Mj
         VMWJOMPNPfMWMyz9QvVPBqcem81diIVxJ4+JRFuQl4hhtderKohleiqIS1JN59/J41hY
         Dfww==
X-Forwarded-Encrypted: i=1; AFNElJ+gPR2uh+jox2KSAgoJVfC6p9ArsAmnp2KRmfT2NCxmP9MOQfrcRqiS+7ILEnAx2dcqdfA6Ouz+cO+T@vger.kernel.org
X-Gm-Message-State: AOJu0YyiIdcRdVUkqRdDJ589UIoagACOjQ9vzCZy8/oDFhKh99K1qEqO
	xN1M3+3NmP5m+5ylBLhz2pH66/VDz4P8XgHGZGVT8eUzyJNVqOUuwS45cM/P5W/FCXE=
X-Gm-Gg: AeBDieu4B/G3pAK2SPfeeeb0A3cGCKUdqgg10EhdPF7zW1tb1ErKrvMyrL1PfCo7n26
	+nOyMaZqVC+UVoDYElxk1a8ZJbT3RQ3hoxPDgil7MZ9PwIdhDi8xWI30u1XfXnxUn7mDa2BW7uc
	Sm3jsEkR5YtKu9+RJGblvmM/82x+Vf9ZcjTiQOJbnuo7CsHVGY4itxwVWBLmes4UYvpc19WanFk
	Cr98c9AG4THESfHgPXxXT22XSgr3bfi7imoNCKL90gWIJTTBLbpQaOqjUw68ZoTMNbT2HKJh9P7
	fHL04Pabo40qQ17t8oGfTHonT8A39MsyEfQe0tWucM9hBcxfje5AsIQ0jx04kIl52/3qVaCETmO
	vzqQ4luvJBCjw5u0CI6vQDGfgaeOnaEHspQ35QC9PL1CkIDjvphqV6TCg9Z1z+W6MDi5dHcXmOT
	56AWvAcHkRl9rPn6Eja39T7t6skJs+WkT5F/GWDS/XEzU=
X-Received: by 2002:a05:600c:3b0e:b0:487:20ee:bef6 with SMTP id 5b1f17b1804b1-488d67e65fdmr249803205e9.11.1776182242164;
        Tue, 14 Apr 2026 08:57:22 -0700 (PDT)
Received: from FV6GYCPJ69 ([2001:1ae9:6084:ab00:21a7:c498:d7ab:e1e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm43780121f8f.33.2026.04.14.08.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 08:57:21 -0700 (PDT)
Date: Tue, 14 Apr 2026 17:57:19 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Leon Romanovsky <leon@kernel.org>
Cc: syzbot <syzbot+03393ff6c35fd2cc43de@syzkaller.appspotmail.com>, 
	jgg@ziepe.ca, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [syzbot] [rdma?] WARNING in ib_dealloc_device
Message-ID: <tinnwpbb7kwhfp33lfltl6ryaymuamtimac7xenbqhsbbofiw2@xgfvtcs5yjwk>
References: <69dc3310.a00a0220.475f0.0018.GAE@google.com>
 <20260413154353.GK21470@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413154353.GK21470@unreal>
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=45cb3c58fd963c27];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19348-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,storage.googleapis.com:url,syzkaller.appspot.com:url,googlegroups.com:email,appspotmail.com:email,msgid.link:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,03393ff6c35fd2cc43de];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 7DD903FC3A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Mon, Apr 13, 2026 at 05:43:53PM +0200, leon@kernel.org wrote:
>On Sun, Apr 12, 2026 at 05:04:32PM -0700, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    7f87a5ea75f0 Merge tag 'hid-for-linus-2026040801' of git:/..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=11778eba580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=45cb3c58fd963c27
>> dashboard link: https://syzkaller.appspot.com/bug?extid=03393ff6c35fd2cc43de
>> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
>> 
>> Unfortunately, I don't have any reproducer for this issue yet.
>> 
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/0f5deca1373e/disk-7f87a5ea.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/6aea6c1c6b6e/vmlinux-7f87a5ea.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/61444b289e96/bzImage-7f87a5ea.xz
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+03393ff6c35fd2cc43de@syzkaller.appspotmail.com
>> 
>> ------------[ cut here ]------------
>> !xa_empty(&device->compat_devs)
>> WARNING: drivers/infiniband/core/device.c:682 at ib_dealloc_device+0x187/0x200 drivers/infiniband/core/device.c:682, CPU#0: kworker/u8:37/4856
>
>I think that we have only one patch in this area https://patch.msgid.link/20260127093839.126291-1-jiri@resnulli.us

Unable to find a link to this patch. But I don't see a scenario on which
this WARN can happen either. Very odd.


>
>Thanks
>
>
>> Modules linked in:
>> CPU: 0 UID: 0 PID: 4856 Comm: kworker/u8:37 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
>> Tainted: [L]=SOFTLOCKUP
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
>> Workqueue: ib-unreg-wq ib_unregister_work
>> RIP: 0010:ib_dealloc_device+0x187/0x200 drivers/infiniband/core/device.c:682
>> Code: e8 de ec ad f9 48 89 df e8 56 59 07 00 48 81 c3 30 08 00 00 48 89 df 5b 41 5c 41 5e 41 5f 5d e9 0f 09 60 fd e8 ba ec ad f9 90 <0f> 0b 90 e9 72 ff ff ff e8 ac ec ad f9 90 0f 0b 90 eb 8f e8 a1 ec
>> RSP: 0018:ffffc9000f49fa18 EFLAGS: 00010293
>> RAX: ffffffff88169536 RBX: ffff888039d40000 RCX: ffff88806a691e80
>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>> RBP: ffff888039d41308 R08: 0000000000000000 R09: 0000000000000000
>> R10: dffffc0000000000 R11: fffffbfff1ed4eb7 R12: 1ffff110073a81fd
>> R13: dffffc0000000000 R14: ffff888039d41268 R15: dffffc0000000000
>> FS:  0000000000000000(0000) GS:ffff888126332000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007ff6d2897e9c CR3: 0000000022382000 CR4: 00000000003526f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000f1ffffdf
>> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
>> Call Trace:
>>  <TASK>
>>  __ib_unregister_device+0x393/0x3f0 drivers/infiniband/core/device.c:1545
>>  ib_unregister_work+0x19/0x30 drivers/infiniband/core/device.c:1639
>>  process_one_work kernel/workqueue.c:3276 [inline]
>>  process_scheduled_works+0xb6e/0x18c0 kernel/workqueue.c:3359
>>  worker_thread+0xa53/0xfc0 kernel/workqueue.c:3440
>>  kthread+0x388/0x470 kernel/kthread.c:436
>>  ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
>>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>>  </TASK>
>> 
>> 
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>> 
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>> 
>> If the report is already addressed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>> 
>> If you want to overwrite report's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>> 
>> If the report is a duplicate of another one, reply with:
>> #syz dup: exact-subject-of-another-report
>> 
>> If you want to undo deduplication, reply with:
>> #syz undup
>

