Return-Path: <linux-rdma+bounces-16238-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPP9Bd+PfGkQNwIAu9opvQ
	(envelope-from <linux-rdma+bounces-16238-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 12:02:55 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67697B9B54
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 12:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA11930484C2
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 11:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB17378820;
	Fri, 30 Jan 2026 11:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tq2Xh5eU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B18367F2C
	for <linux-rdma@vger.kernel.org>; Fri, 30 Jan 2026 11:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769770844; cv=pass; b=dtg+uDJ9htBLyQVxLq7GSBHIH9JPqcKHCJ73JSPFRjbo/plToV074fjlEhL/u+q8RbWvtmlMHJggjRAD9o2ORou/TCrvBI6lx+DK4OxE/HxXc9J0FSjimu+u27Y5x1mkSVxHlAugvF979ZxVlGgpcaOFYjjUOaV5CgqnRDj4MMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769770844; c=relaxed/simple;
	bh=EJMvSfSaKnBUl6AvBAYoI05afWcq1mwYS/36SF16DkA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Q6yq3MciFYFBp1Z+a9vKir4pWJZCeqHm74L0lvBXID6K8iGiqT74bj345PzQ/mWQCG2ZQfoDBv3CDFuL1hsanfWAYYtDvg4IUwEHGKVSHgYjWfAaJZ7r0Zkw54FRwL5wGwKd0XoYpyo3xv/ivIuEoz4Tm3HquAoR07g2ngKuLeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tq2Xh5eU; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34c93e0269cso1885109a91.1
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jan 2026 03:00:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769770842; cv=none;
        d=google.com; s=arc-20240605;
        b=VUZmplImYeOQiXHUMUODNm2un1FObCJPTUKBNmmtpgAi9+QjM0Q+soqzTGHAqBCIIx
         EWXFQtxjQP2xWgsmWjp+te3JDYFnHANDVPS++wyUCxMfmpGtGD3+7q2yWLsOclJCahbI
         LmC1z3ItgE1h0k4mDtj1DWO3GZTfQNdb+B4D3UPrQSpPhNnLVcQEMmg/HuwUEal5d/bu
         Vf8Kr4YLeO5Nu3pPYPlcYtTjxWstj05G4m16r19D40QZg6AqYqNbhG3w1Z42hbQkRXIi
         aUxX4ek/+RcNn4aZ5qzVmW0rfFOzccVF9ye4twDJnmQUPrdXYrwZjlhwcBQv+bv2sdhk
         D1tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Iv1Txqafilv4zc+TX4o1Nyh3k8p0mNPInsRSHjhSWyQ=;
        fh=/CgHMz/XuCFl1VfknS3kluMqAigxtSWTEPBitq8dsyY=;
        b=Xx5x9mP/C24cyYDL+WrvczLWdOs/ySr75C+cx4BZUYKLyb/5oZ+VayVcJ5Nqz2fm7R
         mDjVU4g9ekf4BVJmjOeu9w0g+C5iCSMxy8Yd0p717mgkW/eRc+qpfFogoBnH0XsurD22
         GPQdULBmCmQIX7WhRJFB8p2b27617seUqvC8YKlH01tQ58q+JCl17PxTVprXnncZjesw
         wfGXYXUkTFQmlS28zVl+M1fnrWTSUE50cj9cy3IXbTTe1kDVHuwOQwbtcOyVTIihdQbt
         6c4qHlR1A49cNwfrb2C++u/vk1NnGSVs4TvCQ48GmI++CvUpU8WO2MMpr0Ihd+GNmsuV
         64mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769770842; x=1770375642; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Iv1Txqafilv4zc+TX4o1Nyh3k8p0mNPInsRSHjhSWyQ=;
        b=Tq2Xh5eUpG1qM+58aAp0bEOtRgng2sGwBMBkFkrvUqTDq6Lgss+QzcVskgKx0+r6lB
         gayMzePOcHlgBxoBBu5uTmTbtbBBPl1Vu0AYJwxeKOPcGbLB0whqV0ZkpDInCJ9E8zDt
         tWGFdQykIUshFI070zm+s5EL4YumwrZ4ov+/+sw44nrkhZ5g1uww8GO6dYijDdlQ3eVt
         iGP+HoR9RXkyttlURx0cYnaos3EbDXw42Y/2Giskba5C/htq/KINTO3IyJ+FCjJu6Ggx
         sML3un2qgpk47li90M4MlpcxdoqK6Qt09+ZFxnVi/wRLYbjulBeGpx0vGt1HthwFZKkb
         wlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769770842; x=1770375642;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iv1Txqafilv4zc+TX4o1Nyh3k8p0mNPInsRSHjhSWyQ=;
        b=T2BXKxh6Z/Y0JbZ1ubqgCo3g/tmyzqWi+Yrc2/5KUPkxt6qS8nZ8n/ZmH15jAOqlK1
         /NhaxsUGEVKSW942r/q8xFjXTlYRp4RjH9mGsXLq8LNYVByleEHLR+9zWvC7L+rsorYO
         uVbj5BsP2DXTs2CB5N4fUre93mMEKov/jG+GaYWh61befws3XOwZRsf40BH0epKQ6m/8
         0n53u1h/ffvYJzl/76DQTk0DeaZ5X/Je1sBp27mzAkPuBIc5sSZkCdNA+e1X+smOUEQX
         WzftHjipX0FKrZQsMZAzWpYGRvQHaNHERSqCJ7V4HvtiUUBu+yAtCsOc22bPk0bnOlxm
         NeyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmsx0xTCE0wjlmvFFUoby+lS3166kIKafrK2MRbJbP7jvYytl81lOw+p3lFX7X4Vmq83S8FDCZr/6y@vger.kernel.org
X-Gm-Message-State: AOJu0YzTufJG6nU6tlffV9pMP89WnM0tjAvPUPgM9Y39hPFGdLGoV4sT
	LZeWJm2IC/HyHJd9SpFN5wPLiIJ1TDkokpdhWvACgYRkzw2QBwju+8aaV5D7bk+B5dRiJi66KjC
	EdBV7K/5wpJECjh1xhkNEVbkFa+8s256srq8cwb/pNg==
X-Gm-Gg: AZuq6aJiCEzfcpy03fa4YGc8Prt0kWVT23wfFz9fPKBosbLMnxE69mSXiXb5x1YmMVo
	e0fcuZURDeuP057JLyXRPIu3OMawnvDemKwiRgx2GpVL8Nz3yk3Q2uwJ/iW24XqMl2oGLDdOU6D
	BugbLMiILIM7tBsMOWsyiXUbxnlNb9ZMbgZo8BCeYpGKxYGqCgscL3UrALVznOQGVfGGNKamx7v
	GzovdrkEa3csrGctL9jqUqh//Bn6VHRhkaMBKe+6N9Wb/hCZ4wESuUEElL+JeXWvoOH1SJXDQ==
X-Received: by 2002:a17:90b:4a82:b0:34f:6312:f225 with SMTP id
 98e67ed59e1d1-35429b0007emr5284240a91.14.1769770842444; Fri, 30 Jan 2026
 03:00:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: yunje shin <yjshin0438@gmail.com>
Date: Fri, 30 Jan 2026 20:00:30 +0900
X-Gm-Features: AZwV_QhiAerOaYRrmkGFqJXjUik9Gg3rl3izblnVbCbEgBsLutGpsOYa1Y5l_Rk
Message-ID: <CAMX6_QHrodOD1KD6qtK2A=tHOocrpSWJh7VTSYR+fMiHRgsktQ@mail.gmail.com>
Subject: [Bug] KASAN: null-ptr-deref in range in ib-comp-unb-wq ib_cq_poll_work
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: YunJe Shin <ioerts@kookmin.ac.kr>, linux-rdma@vger.kernel.org, 
	Joonkyoo Jeong <joonkyoj@yonsei.ac.kr>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16238-lists,linux-rdma=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yjshin0438@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 67697B9B54
X-Rspamd-Action: no action

in drivers/infiniband/core/user_mad.c



[ 1621.970286] Oops: general protection fault, probably for
non-canonical address 0xdffffc0000000000: I
[ 1621.971167] KASAN: null-ptr-deref in range
[0x0000000000000000-0x0000000000000007]
[ 1621.971925] CPU: 0 UID: 0 PID: 43 Comm: kworker/u9:0 Not tainted
6.19.0-rc7-g8dfce8991b95-dirty #4
[ 1621.972373] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX,
1996), BIOS 1.16.3-debian-1.16.3-2 4
[ 1621.972850] Workqueue: ib-comp-unb-wq ib_cq_poll_work
[ 1621.973486] RIP: 0010:ib_free_send_mad+0xf3/0x270
[ 1621.973718] Code: 85 22 01 00 00 49 8d 7e 08 48 8b 4b 08 48 89 fe
48 c1 ee 03 42 80 3c 3e 00 0f 85 2
[ 1621.974316] RSP: 0018:ffff888008487a30 EFLAGS: 00000246
[ 1621.974522] RAX: dffffc0000000000 RBX: ffff888007c8c600 RCX: 0000000000000000
[ 1621.974721] RDX: 1ffff11000f918c0 RSI: 0000000000000000 RDI: ffff88800be6c168
[ 1621.974919] RBP: ffff88800be6c160 R08: ffffffff8198dcf3 R09: ffffffff81990d3b
[ 1621.975227] R10: ffffffff8198da24 R11: ffffffff8198d9a3 R12: dead000000000122
[ 1621.975571] R13: dead000000000100 R14: ffff88800be6c160 R15: dffffc0000000000
[ 1621.975934] FS:  0000000000000000(0000) GS:ffff8880e6191000(0000)
knlGS:0000000000000000
[ 1621.976269] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1621.976491] CR2: dffffc0000000000 CR3: 000000000a7eb000 CR4: 00000000000006f0
[ 1621.976833] Call Trace:
[ 1621.977113]  <TASK>
[ 1621.977292]  ? rdma_destroy_ah_user+0xf1/0x170
[ 1621.977520]  send_handler+0x1b0/0x330
[ 1621.977748]  ib_mad_complete_send_wr+0x1de/0x920
[ 1621.977902]  ib_mad_send_done+0x706/0x1200
[ 1621.978063]  ? __pfx_ib_mad_send_done+0x10/0x10
[ 1621.978258]  ? __pfx_ib_mad_send_done+0x10/0x10
[ 1621.978545]  __ib_process_cq+0xe1/0x330
[ 1621.978676]  ib_cq_poll_work+0x46/0x150
[ 1621.978853]  process_one_work+0x5e7/0xf30
[ 1621.979012]  worker_thread+0x763/0x12b0
[ 1621.979128]  ? __pfx_worker_thread+0x10/0x10
[ 1621.979246]  kthread+0x30d/0x630
[ 1621.979346]  ? __pfx_kthread+0x10/0x10
[ 1621.979447]  ? __pfx__raw_spin_lock_irq+0x10/0x10
[ 1621.979592]  ? __pfx_kthread+0x10/0x10
[ 1621.979696]  ret_from_fork+0x308/0x3f0
[ 1621.979808]  ? __pfx_ret_from_fork+0x10/0x10
[ 1621.979934]  ? __switch_to+0xaec/0xe60
[ 1621.980046]  ? __switch_to_asm+0x39/0x70
[ 1621.980163]  ? __switch_to_asm+0x33/0x70
[ 1621.980281]  ? __pfx_kthread+0x10/0x10
[ 1621.980385]  ret_from_fork_asm+0x1a/0x30
[ 1621.980537]  </TASK>
[ 1621.980659] Modules linked in:
[ 1621.982033] ---[ end trace 0000000000000000 ]---
[ 1621.982642] RIP: 0010:ib_free_send_mad+0xf3/0x270
[ 1621.982890] Code: 85 22 01 00 00 49 8d 7e 08 48 8b 4b 08 48 89 fe
48 c1 ee 03 42 80 3c 3e 00 0f 85 2
[ 1621.983468] RSP: 0018:ffff888008487a30 EFLAGS: 00000246
[ 1621.983748] RAX: dffffc0000000000 RBX: ffff888007c8c600 RCX: 0000000000000000
[ 1621.983953] RDX: 1ffff11000f918c0 RSI: 0000000000000000 RDI: ffff88800be6c168
[ 1621.984135] RBP: ffff88800be6c160 R08: ffffffff8198dcf3 R09: ffffffff81990d3b
[ 1621.984305] R10: ffffffff8198da24 R11: ffffffff8198d9a3 R12: dead000000000122
[ 1621.984470] R13: dead000000000100 R14: ffff88800be6c160 R15: dffffc0000000000
[ 1621.985284] FS:  0000000000000000(0000) GS:ffff8880e6191000(0000)
knlGS:0000000000000000
[ 1621.985656] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1621.986069] CR2: dffffc0000000000 CR3: 000000000a7eb000 CR4: 00000000000006f0
[ 1621.986500] Kernel panic - not syncing: Fatal exception
[ 1621.988088] Kernel Offset: disabled
[ 1621.988350] Rebooting in 1 seconds..

