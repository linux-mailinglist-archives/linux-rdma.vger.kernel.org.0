Return-Path: <linux-rdma+bounces-16231-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPNdGwptfGkSMgIAu9opvQ
	(envelope-from <linux-rdma+bounces-16231-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 09:34:18 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB95DB866B
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 09:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87889300FEFC
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 08:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57D231AAA7;
	Fri, 30 Jan 2026 08:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZNdV/H5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8062F8BCA
	for <linux-rdma@vger.kernel.org>; Fri, 30 Jan 2026 08:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769762039; cv=pass; b=Yn+8Dk425GM4aTUbmkKJIJsLEeEbUmcT11C8CT0vYGLXrfhUyFSyvJGPhPwBboE1fyLk7/wcZuAD/H4tUI6SeBnKCoI+96dPh8vTkzAEax6PXBMiF9bVv8Ds0wHY5j5PXi3qUkom6bOYCvL/dFgUWzZh3zs4NSl1WLm1JmHSciM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769762039; c=relaxed/simple;
	bh=8tf1URBwx6eLsuwhSotWuKRJBsyyfuyjrtScjeWrlQo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=o05Gg4JdLSemofzXp8DeDogjl5tgWuRYYKNm8G06xCN3IDl3JlWyBYuUmuuCuG3uw0BawKDVFJip2f1ZDxpqz5TY1F63mUowYy2Czc/joQkkhL3rlSWqxR2JL+aE40WRnIL8Qema36wl5ZIDVAUdlhtvfdpFHnDmyjaKAQi5FM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZNdV/H5; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a0834769f0so12395645ad.2
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jan 2026 00:33:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769762038; cv=none;
        d=google.com; s=arc-20240605;
        b=bLGa5gKiDGn0JNC/pAwTVw48xeKzQH/opgALGlftXzkTbWuiS0dnl2WM3WtAosv272
         1vDQfiqLbU9+w5VQdn+s0C5cGce9Ed+UQ7C8jIQoTg8U3FYuv6xIkSznUTgexL/Qtpba
         8CPIY3IwA2MYVAoel2OiT2aoIFn3oeZAtZMMWlY6BdnjTyYgamLupg77w6hvGswSNBdH
         sj61S7d0gGUGPrrASRpJnfPxNS6fYI64ModZTQlBRH54rmm8mNEEZkYvoiuoX/VTCoRH
         PE1kfwKg90Bv8y+9EEa3/1DqU6434sm/v7A/MhpBxsg14EcM1CbNVmrxVy8JvKaGKBuU
         owWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=vWQ+u7TayfftUmeu2Jh/Gll91sSdUpkw8fM2bQTtlgc=;
        fh=Qop92I+m7/U5F3p7FSy+iLS3BpbTUw93QkNoLucOliw=;
        b=KnJ6LWIqnq0HXC8Owlmm7JiLDWLV5WyoThDsBKMS5oJGqwvZABaw+RYF350D2Ixeo+
         WksSw5esqXE/e5ufGjAP5eQ2Rm7lf52/n1pGVnGMqJ9eEAJVIpOGU+/EZfSntS/Ct60R
         NsyAMfw+rw/6IAaRyoSZA8QQKWn6WMvLnB26+5rsj5MFWakRsg4/kq8HHlwRLENCBqsy
         gTpmdyCjltuyuFHl07dsXouqlMbdXZz6b16QfUbkb6/TFN2yqX+dD/TOjSXpkpSf3BLU
         dnloMafv5Feiggz5eSgxBIpuxj1MCXSF/9WkUbG8C0XIaNfdbEfmd9qErnpGELRD0qvU
         qpmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769762038; x=1770366838; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vWQ+u7TayfftUmeu2Jh/Gll91sSdUpkw8fM2bQTtlgc=;
        b=VZNdV/H5P6mlklJtkSPYNlhF6w1BZf1dCAO178U59Dnx9iBigBA2erlK0Ci1IAxO12
         G7LTVohG0Hf8iJ8u5vxjc0CMHf26imE1bmWvaaRxm+VRosNVsOfOvCwVVFJ3vIpGxHtA
         ZSP6rQRTAP/K9KC1BOnRsaBLKV6jbQXh08fYbHe8RLUGHi1Qd8RNMi2k0IpTv5ZJSX9q
         ltVYoykGp1X92rVAqd7Nuh/saTDFhCX7p4GlMINgHBhCO/8qkUqoqAQG8aCowlRhSG0r
         Nrq1hW7KshMNjDdFcjKtIZV3znWy1fsPVrgCs/5Cn2aR4+OjvNG1vLerTzklmEwjd5aR
         2wvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769762038; x=1770366838;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vWQ+u7TayfftUmeu2Jh/Gll91sSdUpkw8fM2bQTtlgc=;
        b=KqzY2Ru/herQRhLHf948z5ZsFOlRjiWaJOUJ/tY66ULMfPIlvlEChRpyGha0hiYrQe
         W6xudqVMr5iZTg1sPhReNXl5p0WpMd7sXS4FE2j+fDgdn+uXROQc+FzVa7ZSpxbBg2Ua
         INIIXvNBbKRhw60hLyL7+ReDmrLmv7InS26XcZ+8oPXVEB9VCeXVBnAl97RU7wuF6SZT
         W3tId/LDCEIrL2N5PE8HoWDjAXlltSjzLdx0VmYQBDYG7vnm7418d0qAPOFzK++aIK3l
         JR3kVo28yrAPIiEXK99ssJyWTZ+pIuTL0WrQ+AjAGxzIM2DZAp2VdDkCuX0jSeHH2dXG
         EwOQ==
X-Gm-Message-State: AOJu0YyO0A89Tmw7lhV1AfqSQQc78sLgQVYGSuyzOJCEwIMt/WBLjSWL
	gNJmIQiIAjwGKLMs6XKdGQQikai9rsshThS7bqUstNjvyS0mMx93f+ULqo1SPqw8AJ1DY1/Y/mv
	3141UxF/846t7yP43I9MFlzZ/j8Yj4No=
X-Gm-Gg: AZuq6aIyycQ72aMi3ZKgYCG7938lt9dNZHd3ZGmnp4tRr5IwYU0fUVu9ASSWukpgLgX
	l1k/3VLJk/m8a8CFAku8dn9ili0l37+oE15OjdJjPoa8PN7Hp1m6a8DBb/hY3Z2Nq5c7YTOCeGF
	WPXmHdJM6I7vM77R+nSj/WURNmWL4rKNasZLt4B2SYIAR4FknToqOd8MNhTeFVN3Lk4yZWRGamv
	mC8xQhRONaaMKmrztPkHLbSpIhhoKkN1HE5eBT3t1xQRdJS8eCbqqMtqxupraroCuZizMSt2g==
X-Received: by 2002:a17:903:2f8e:b0:2a7:51bf:3b89 with SMTP id
 d9443c01a7336-2a8d96a6dabmr21168115ad.19.1769762037543; Fri, 30 Jan 2026
 00:33:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: yunje shin <yjshin0438@gmail.com>
Date: Fri, 30 Jan 2026 17:33:46 +0900
X-Gm-Features: AZwV_QiXJvCHX3ANP8w91BlGAT4xpSwA52b6P2YvP-_RDPdB7P6dJycS5NRvR6k
Message-ID: <CAMX6_QHfPsyybbO_79u4RpbGY9H28xhpaVPHUD-wu2U+V5W=7w@mail.gmail.com>
Subject: [BUG: KASAN: slab-out-of-bounds in ib_uverbs_post_send+0x0]
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, Joonkyoo Jeong <joonkyoj@yonsei.ac.kr>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16231-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yjshin0438@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB95DB866B
X-Rspamd-Action: no action

i think need check

if (cmd.wqe_size < sizeof(struct ib_uverbs_send_wr))
    return -EINVAL;


Linux lkd-debian-qemu 6.19.0-rc7-g8dfce8991b95 #1 SMP PREEMPT_DYNAMIC
Thu Jan 29 13:39:52 KST 2026 x86_64x

[  962.692908] BUG: KASAN: slab-out-of-bounds in ib_uverbs_post_send+0x0
[  962.693478] Read of size 4 at addr ffff888007df4748 by task repro_hy5
[  962.693677]
[  962.694271] CPU: 1 UID: 0 PID: 435 Comm: repro_hybrid Not tainted 6.
[  962.694340] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 19964
[  962.694529] Call Trace:
[  962.694589]  <TASK>
[  962.694659]  dump_stack_lvl+0x53/0x70
[  962.694734]  print_report+0xd0/0x660
[  962.694764]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[  962.694787]  ? ib_uverbs_post_send+0x106b/0x1600
[  962.694802]  kasan_report+0xce/0x100
[  962.694820]  ? ib_uverbs_post_send+0x106b/0x1600
[  962.694838]  ib_uverbs_post_send+0x106b/0x1600
[  962.694858]  ? __pfx_ib_uverbs_post_send+0x10/0x10
[  962.694878]  ? n_tty_write+0x8da/0x1090
[  962.694900]  ib_uverbs_write+0x87d/0xd10
[  962.694920]  ? __pfx_ib_uverbs_write+0x10/0x10
[  962.694937]  ? __pfx___fsnotify_parent+0x10/0x10
[  962.694959]  ? selinux_file_permission+0x367/0x500
[  962.694980]  vfs_write+0x21e/0xd30
[  962.694998]  ? __pfx___handle_mm_fault+0x10/0x10
[  962.695014]  ? __pfx_vfs_write+0x10/0x10
[  962.695034]  ? fdget_pos+0x53/0x4b0
[  962.695052]  ksys_write+0x17c/0x1c0
[  962.695068]  ? __pfx_ksys_write+0x10/0x10
[  962.695083]  ? do_user_addr_fault+0x43b/0x9c0
[  962.695103]  do_syscall_64+0xa4/0x320
[  962.695121]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  962.695186] RIP: 0033:0x7f250d402513
[  962.695391] Code: 8b 15 81 29 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff8
[  962.695445] RSP: 002b:00007ffe153312b8 EFLAGS: 00000246 ORIG_RAX: 001
[  962.695515] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f23
[  962.695547] RDX: 0000000000000028 RSI: 00007ffe153312d0 RDI: 00000003
[  962.695586] RBP: 00007ffe15331380 R08: 0000000000000037 R09: 00007ff7
[  962.695617] R10: fffffffffffffd8e R11: 0000000000000246 R12: 00005610
[  962.695647] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000
[  962.695690]  </TASK>
[  962.695750]
[  962.697943] Allocated by task 435:
[  962.698093]  kasan_save_stack+0x33/0x60
[  962.698203]  kasan_save_track+0x14/0x30
[  962.698292]  __kasan_kmalloc+0x8f/0xa0
[  962.698362]  __kmalloc_noprof+0x1b7/0x550
[  962.698431]  ib_uverbs_post_send+0x1b8/0x1600
[  962.698503]  ib_uverbs_write+0x87d/0xd10
[  962.698592]  vfs_write+0x21e/0xd30
[  962.698657]  ksys_write+0x17c/0x1c0
[  962.698726]  do_syscall_64+0xa4/0x320
[  962.698806]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  962.698904]
[  962.698981] The buggy address belongs to the object at ffff888007df40
[  962.698981]  which belongs to the cache kmalloc-8 of size 8
[  962.699258] The buggy address is located 0 bytes to the right of
[  962.699258]  allocated 8-byte region [ffff888007df4740, ffff888007df)
[  962.699490]
[  962.699566] The buggy address belongs to the physical page:
[  962.699932] page: refcount:0 mapcount:0 mapping:0000000000000000 ind4
[  962.700210] flags: 0x100000000000000(node=0|zone=1)
[  962.700600] page_type: f5(slab)
[  962.700915] raw: 0100000000000000 ffff888007441500 ffffea00001f6c00 2
[  962.701065] raw: 0000000000000000 0000000080800080 00000000f5000000 0
[  962.701284] page dumped because: kasan: bad access detected
[  962.701407]
[  962.701485] Memory state around the buggy address:
[  962.701885]  ffff888007df4600: fa fc fc fc fa fc fc fc fa fc fc fc fc
[  962.702089]  ffff888007df4680: fa fc fc fc fa fc fc fc fa fc fc fc 0c
[  962.702268] >ffff888007df4700: 00 fc fc fc 00 fc fc fc 00 fc fc fc fc
[  962.702425]                                               ^
[  962.702578]  ffff888007df4780: fa fc fc fc fa fc fc fc fa fc fc fc fc
[  962.702708]  ffff888007df4800: fa fc fc fc fa fc fc fc fa fc fc fc fc
[  962.702849] =========================================================
[  962.704326] Disabling lock debugging due to kernel taint
post_send trigger: Invalid argument
[  962.698362]  __kmalloc_noprof+0x1b7/0x550
[  962.698431]  ib_uverbs_post_send+0x1b8/0x1600
[  962.698503]  ib_uverbs_write+0x87d/0xd10
[  962.698592]  vfs_write+0x21e/0xd30
[  962.698657]  ksys_write+0x17c/0x1c0
[  962.698726]  do_syscall_64+0xa4/0x320
[  962.698806]  entry_SYSCALL_64_after_hwframe+0x77/0x7f

[  962.698981] The buggy address belongs to the object at ffff888007df40
                which belongs to the cache kmalloc-8 of size 8
[  962.699258] The buggy address is located 0 bytes to the right of
                allocated 8-byte region [ffff888007df4740, ffff888007df)

[  962.699566] The buggy address belongs to the physical page:
[  962.699932] page: refcount:0 mapcount:0 mapping:0000000000000000 ind4
[  962.700210] flags: 0x100000000000000(node=0|zone=1)
[  962.700600] page_type: f5(slab)
[  962.700915] raw: 0100000000000000 ffff888007441500 ffffea00001f6c00 2
[  962.701065] raw: 0000000000000000 0000000080800080 00000000f5000000 0
[  962.701284] page dumped because: kasan: bad access detected

[  962.701485] Memory state around the buggy address:
[  962.701885]  ffff888007df4600: fa fc fc fc fa fc fc fc fa fc fc fc fc
[  962.702089]  ffff888007df4680: fa fc fc fc fa fc fc fc fa fc fc fc 0c
[  962.702268] >ffff888007df4700: 00 fc fc fc 00 fc fc fc 00 fc fc fc fc
[  962.702425]                                               ^
[  962.702578]  ffff888007df4780: fa fc fc fc fa fc fc fc fa fc fc fc fc
[  962.702708]  ffff888007df4800: fa fc fc fc fa fc fc fc fa fc fc fc fc
[  962.702849] =========================================================

