Return-Path: <linux-rdma+bounces-21845-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q54fNP0AI2pZgQEAu9opvQ
	(envelope-from <linux-rdma+bounces-21845-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 19:01:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEE3649FD0
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 19:01:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=GskFwMue;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21845-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21845-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 699393061019
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 16:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B1436D4E4;
	Fri,  5 Jun 2026 16:56:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8442DC764
	for <linux-rdma@vger.kernel.org>; Fri,  5 Jun 2026 16:56:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780678572; cv=none; b=XhSWkFERheWE7C8m7uIQq+CIAGP//O2LbgoDt75WYI22Ng3721SoFTp4gtEvbEjkmZ8+H4T+WwNhcTBS0S+P1VCKzNFeMREmizvm7Ao7+ARwwitXOQ30lykucuZcnOdoW3wGU44D82QGavdv22ZDo1TW7YO7DCiTPZ2COfJpaGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780678572; c=relaxed/simple;
	bh=MRc9L3MHzlchKaFDuer7Ea7EidrnpjxvWHC5t70vnTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eY44MU3corr91fwqgCKe9hnj/oT0mzRPkAgvXRVin9B1+yJvsCdBZQySjzT5PTvCJgQE+WQG1ZuViD9NwDXL+pI6lhGDzX0YnJBxxyNGNg3pbU8Z/8MikkTm1ZvlORNdVvFy5MewH3U2OI3sEFLzZddciiITU+dJF5u9MfqvlQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GskFwMue; arc=none smtp.client-ip=209.85.167.47
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aa61503fdaso2926802e87.0
        for <linux-rdma@vger.kernel.org>; Fri, 05 Jun 2026 09:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780678568; x=1781283368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LcbsUqc+MsiNTTOsX/CXMoiJ4+9c20C5vZh5SOHsMVs=;
        b=GskFwMueDfHh8PRalw+nPzv5TvNtVq9dL8TWVeoLhIwKACSzWohgULG2iUcLYtlKqs
         DXLMiSQkWGgaMtCj8xw6XpsVKuYdrAczbi0wzaKOYsBfCTSE8UXbcLFeSWZRq2YnEj42
         WzOlT2sKHrBcd7hXlmTS9bqif0acm7Dvw8QQyaQxd9kqlaSwVUPe94l34jSTPDRM1Ibb
         3Wde8ojT5wvSo+XSvxeLRZXb4o9DBby6lmtXGRq63CREw57ws+zFOfOCQMK9mGoM5vDV
         0AsOPZMyvr4sG5X6OOnVQgQA71lPGOOyfd0lj9E2/UziF9Q9veVpQ4ezbSFIVFyoXpj2
         oiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780678568; x=1781283368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcbsUqc+MsiNTTOsX/CXMoiJ4+9c20C5vZh5SOHsMVs=;
        b=Cw2UwvEkNm9jwHs74nEZ2UVyhhk6UKggcWHfW0Ir39mW889c3W2XLXv2Tv/1icox5m
         b7bELpwwd/C3KD690kErW+2KMfYJ6NaWIXrixln+72oUiJgGzo3TtFP2dyLuKDCcuS0N
         qb0LUorr229gtVKnsfivZfyFZCIYDxKGv3GXtRgJIBAfyKZZ2fxkfrcmkKEtYxhIQ35m
         +UjgFp5e6jbm7by0C3vZuxhASrI6482cyUAyA+0vl89eOZe+X50tH01mP1DDdgkTFt0c
         Jw0vgo5Mx5hqNz3h08xFA3l52UQahMCVrHGCEGYYMf+96Nn0OXhorqi5c0SBNkXvIRjm
         jA2A==
X-Forwarded-Encrypted: i=1; AFNElJ8cF2wu2fefkRf0sbpLgjVLp5fri5kQONlZ4eongwPWSHyJPxA5jnz/EXmvmKlZZiZ1vi1OwoegDleW@vger.kernel.org
X-Gm-Message-State: AOJu0YxHPaUKMtf1AW1qVjCYVCPn07t97kM4Amd11Ot94Uaiu+/B2dVe
	uUx7L5bq4NkOEqwrXJ5WLjg1xv/axqhBTxDPHnJSURnB3JjVTB4YXTTr
X-Gm-Gg: Acq92OHGb9QROmnCaSD3PD88vQHS4zhMxAydN/9JiejJh057Awg8/LyqM99Lxj+tU2x
	fDwMm/KzvuI0cmY0pmwTpo/Y9IQSFxmcjtn6nNaNFp38mKew0ux6au28MJRI+yt0nMYNA18HTfd
	w6gYFSaNuhy0jWnzrNA2jzOM1uV7a1AdfUV7mgYwbeFSkC2Dg7xFg37aAzUGr6I8YpJ+1F7H5Mj
	OT3F04CmTrKOa6fjLGxpj6MIzo8o+0tSPF2mNWR6ynMryEu/Zhuzfb8Wdf8r2apip+5zf+3WxNl
	OuCdLWaiPNF3F9W75+a0K4hz+bSUcAJqe7m7CdJaWMtiM2a3kyEFDAt1O8u6i1z29KqVwCPU7vM
	cxbBAfvMfhDjT14XUjqseiNYOD0fIGJod76hQtx3nQVaMTJkCECxASCl0yEtwbcpYFy/a0YeCzG
	ebinodiv+a0RiZfgkzLS1dQUsVBJj7bI0m9L6pbp1mlEp/FZmnksr0jXMw1wzY2I/dh4fSyTV4D
	zdBfo4=
X-Received: by 2002:a05:6512:1416:b0:5a8:89d6:93cf with SMTP id 2adb3069b0e04-5aa886c9d81mr901654e87.17.1780678567732;
        Fri, 05 Jun 2026 09:56:07 -0700 (PDT)
Received: from c0624c666cc5.devsec.astralinux.ru ([93.188.205.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b98fdcesm1929946e87.62.2026.06.05.09.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 09:56:06 -0700 (PDT)
From: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vladislav Nikolaev <vlad102nikolaev@gmail.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Haggai Eran <haggaie@mellanox.com>,
	Kamal Heib <kamalh@mellanox.com>,
	Amir Vadai <amirv@mellanox.com>,
	Moni Shoua <monis@mellanox.com>,
	Yonatan Cohen <yonatanc@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Yanjun <yanjunz@nvidia.com>,
	lvc-project@linuxtesting.org,
	syzbot+4edb496c3cad6e953a31@syzkaller.appspotmail.com,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH 6.6] RDMA/rxe: Fix "trying to register non-static key in rxe_qp_do_cleanup" bug
Date: Fri,  5 Jun 2026 19:55:44 +0300
Message-ID: <20260605165556.1082-1-vlad102nikolaev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21845-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[vlad102nikolaev@gmail.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,ziepe.ca,mellanox.com,kernel.org,vger.kernel.org,nvidia.com,linuxtesting.org,syzkaller.appspotmail.com,linux.dev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:vlad102nikolaev@gmail.com,m:zyjzyj2000@gmail.com,m:dledford@redhat.com,m:jgg@ziepe.ca,m:haggaie@mellanox.com,m:kamalh@mellanox.com,m:amirv@mellanox.com,m:monis@mellanox.com,m:yonatanc@mellanox.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yanjunz@nvidia.com,m:lvc-project@linuxtesting.org,m:syzbot+4edb496c3cad6e953a31@syzkaller.appspotmail.com,m:yanjun.zhu@linux.dev,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vlad102nikolaev@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,4edb496c3cad6e953a31];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,msgid.link:url,vger.kernel.org:from_smtp,syzkaller.appspot.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4AEE3649FD0

From: Zhu Yanjun <yanjun.zhu@linux.dev>

commit 1c7eec4d5f3b39cdea2153abaebf1b7229a47072 upstream.

Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 assign_lock_key kernel/locking/lockdep.c:986 [inline]
 register_lock_class+0x4a3/0x4c0 kernel/locking/lockdep.c:1300
 __lock_acquire+0x99/0x1ba0 kernel/locking/lockdep.c:5110
 lock_acquire kernel/locking/lockdep.c:5866 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5823
 __timer_delete_sync+0x152/0x1b0 kernel/time/timer.c:1644
 rxe_qp_do_cleanup+0x5c3/0x7e0 drivers/infiniband/sw/rxe/rxe_qp.c:815
 execute_in_process_context+0x3a/0x160 kernel/workqueue.c:4596
 __rxe_cleanup+0x267/0x3c0 drivers/infiniband/sw/rxe/rxe_pool.c:232
 rxe_create_qp+0x3f7/0x5f0 drivers/infiniband/sw/rxe/rxe_verbs.c:604
 create_qp+0x62d/0xa80 drivers/infiniband/core/verbs.c:1250
 ib_create_qp_kernel+0x9f/0x310 drivers/infiniband/core/verbs.c:1361
 ib_create_qp include/rdma/ib_verbs.h:3803 [inline]
 rdma_create_qp+0x10c/0x340 drivers/infiniband/core/cma.c:1144
 rds_ib_setup_qp+0xc86/0x19a0 net/rds/ib_cm.c:600
 rds_ib_cm_initiate_connect+0x1e8/0x3d0 net/rds/ib_cm.c:944
 rds_rdma_cm_event_handler_cmn+0x61f/0x8c0 net/rds/rdma_transport.c:109
 cma_cm_event_handler+0x94/0x300 drivers/infiniband/core/cma.c:2184
 cma_work_handler+0x15b/0x230 drivers/infiniband/core/cma.c:3042
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

The root cause is as below:

In the function rxe_create_qp, the function rxe_qp_from_init is called
to create qp, if this function rxe_qp_from_init fails, rxe_cleanup will
be called to handle all the allocated resources, including the timers:
retrans_timer and rnr_nak_timer.

The function rxe_qp_from_init calls the function rxe_qp_init_req to
initialize the timers: retrans_timer and rnr_nak_timer.

But these timers are initialized in the end of rxe_qp_init_req.
If some errors occur before the initialization of these timers, this
problem will occur.

The solution is to check whether these timers are initialized or not.
If these timers are not initialized, ignore these timers.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Reported-by: syzbot+4edb496c3cad6e953a31@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4edb496c3cad6e953a31
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Link: https://patch.msgid.link/20250419080741.1515231-1-yanjun.zhu@linux.dev
Signed-off-by: Leon Romanovsky <leon@kernel.org>
[ Vladislav: keep del_timer_sync() because linux-6.6.y has not renamed it
  to timer_delete_sync() yet. The actual fix is unchanged: check the timer
  .function fields before deleting the timers. ]
Signed-off-by: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
---
Backport of upstream commit 1c7eec4d5f3b to linux-6.6.y.
 drivers/infiniband/sw/rxe/rxe_qp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 287fc8b8f5ba..8426c261c263 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -817,7 +817,12 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 	spin_unlock_irqrestore(&qp->state_lock, flags);
 	qp->qp_timeout_jiffies = 0;
 
-	if (qp_type(qp) == IB_QPT_RC) {
+	/* In the function timer_setup, .function is initialized. If .function
+	 * is NULL, it indicates the function timer_setup is not called, the
+	 * timer is not initialized. Or else, the timer is initialized.
+	 */
+	if (qp_type(qp) == IB_QPT_RC && qp->retrans_timer.function &&
+		qp->rnr_nak_timer.function) {
 		del_timer_sync(&qp->retrans_timer);
 		del_timer_sync(&qp->rnr_nak_timer);
 	}
-- 
2.39.5


