Return-Path: <linux-rdma+bounces-21850-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W5bXEGkEI2r7gQEAu9opvQ
	(envelope-from <linux-rdma+bounces-21850-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 19:16:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4592464A0FA
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 19:16:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gSr5j7DV;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21850-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21850-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F07D230475A5
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 17:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2FB37CD2A;
	Fri,  5 Jun 2026 17:04:35 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00B3340403
	for <linux-rdma@vger.kernel.org>; Fri,  5 Jun 2026 17:04:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679075; cv=none; b=YYAF+YbAC29pqUbqth7Y9WR2vYvmtED58xuFek25TzzwF8OcX0rEtKdoL2eCFPfAN+Pgbnic/P8qXLRrwLH3MkVQaxposiYPt6ZhKK5ueLz4QSUVodZ8JdeK/6+orzzHLdCPSvMqAwZw3vy/mrRJPpRmWrjsw4+hOaGBoH1G3pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679075; c=relaxed/simple;
	bh=D/nO13dQ1LzEazrrsrSdTSHRT/e4G5tqDnpjhZe/h5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0x5H5KcQEsSYQsNHIOia9wVWcdV9G+RK1EWR0mbLbeqZmvOW+KGoOJlrv+7mqVL5C4nD2JHp6Jfh6qvsm3jMBALvzWNd95P3GfEMV8WbK6iXacNVCQzMIJTdBZOM2jyley7KC/IltHbgznxKky5qKg1r8YMFWXzr2NgHs6oYYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSr5j7DV; arc=none smtp.client-ip=209.85.208.172
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-396bed274b9so18842801fa.0
        for <linux-rdma@vger.kernel.org>; Fri, 05 Jun 2026 10:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780679072; x=1781283872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jD9HMBs1n8FhaIiEX38r99JB83FOqKTDd6pKw32kq/Y=;
        b=gSr5j7DVpMIROAQqBlGzLeicC/1TzuYwZMKxbd+3cM8J/UNPqRDWeb/fR4YDOSVJtB
         jibPUMY1kwpHi/KHeJH1fdD+NKg5OyMIen9CVYX8cPHcqltP8eBavubFNAFKUM9hR4ic
         9iiuSMF8Mpu1//c8yhqf8SActmjy0oeEXmXYjFGH1WZhgBuceY4HvGvIfdd7GVxpfeTy
         YHDgidohafn6x5JVWG0227kz25FYRe8CcOGhpHgLB1Jf/Apbj0AphacMClbrbYrvPZZ3
         sgnJnI2FrM2kl0znnJYpLg7B/AuAFsaPGoLBmOSM0s8/4J17kx/88sCUKkuaU9Uxu+Zz
         l9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780679072; x=1781283872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jD9HMBs1n8FhaIiEX38r99JB83FOqKTDd6pKw32kq/Y=;
        b=OxZV5uFLASxREfD/7GeOGi6GkcnW5KDTFPsGnRAYHGrf92loDUddceHiCxAo/vX3EW
         t3SkLDHVixkLjKn0ndoUMXi/ffbxt1bJrVKUD8DIWqHiX4caZQ2Xwlj32NzCYnlvn5vW
         UU1RJ3gsVb4+5Sm5O0bCHczf81+GPSSWB//xsh2Rvu7piQWwGqNBJ2MlM8MyKgOwVbGq
         4JOfTTBZ1DnRlhV5Ae4aZn6rbZxAyqozG8TBBiJrKTq7Odo/18ppBxrl9Ag0vE2ffjZu
         OSvKre6x+ccQImShC7dgUvQ+XYuRSBJfExUN2cbUMx/X2VbEPixn4eKt10E7oLsa4ikz
         ZkbQ==
X-Forwarded-Encrypted: i=1; AFNElJ9pOgyyrAGvnO2d5MAxk91fC9nHfgC+AWn4BwhhatVBAiU5vZ2Q9HbX9rvA3b6GXsj6J2ex6Nsowm7M@vger.kernel.org
X-Gm-Message-State: AOJu0YxBf2lu/TQvnbJh+rxVB0As/hBbIA8sltSg4cZOdfPRT6ukALrw
	6sbrNzmQXKPlUOEXwdouXWrpSwOTmW3yp57m0DTh2sqxi0k1NXSwVeow
X-Gm-Gg: Acq92OFDgkLqq4ffaiGuyjFtRxF9BoHVVd+Ajrf9AC4i+F6mCN05uLvNDtS/cckkqEO
	4O1huNpZwjd6rCMFoz8iKEJZZIBtWn0ok7gevsxq58gxXDx0km5ZAbUR3Of/1QIToBV3v4oj48l
	aZ9EpLR4msjfT3iljPoiK/F8Q5NdqqXphvalNNeLaAOOf/TyyNESSvG/MntDB6/MdLHNKKIfsBD
	frfN0v7fBcCffbziUegENDGFEUEOgahWysUPSoyiO5vy1h8gTnd69FrdU+b0f6GoCE1ybQmCq9a
	TavjA/hl69kJQVdDkS+mEwEPlZJP3/PORM6FLLq6aGIiIVthbEANCel4uACCPnFOq/YNTIrTTre
	KmAMGpBcFgE3XbIiRhxWGdBvn0+WAlJQWwqpia/XRbWzgtm8aYMLi6tCHfFWT5MzcyxOuP/p5UB
	Jif8R8V9ubNhup8/mrpYzUsH9u1S8Hac6oTx6T1ipBfhNSyr7JKvnDGTRfs1tTeoAre6SV/RGYZ
	ghIRS8=
X-Received: by 2002:a2e:bd10:0:b0:396:74ed:a7b1 with SMTP id 38308e7fff4ca-396d08e4001mr13247801fa.15.1780679071635;
        Fri, 05 Jun 2026 10:04:31 -0700 (PDT)
Received: from c0624c666cc5.devsec.astralinux.ru ([93.188.205.42])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396ac07b66asm26931161fa.11.2026.06.05.10.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 10:04:29 -0700 (PDT)
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
	syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH 6.1 2/3] RDMA/rxe: Fix the error "trying to register non-static key in rxe_cleanup_task"
Date: Fri,  5 Jun 2026 20:03:28 +0300
Message-ID: <20260605170349.1524-3-vlad102nikolaev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605170349.1524-1-vlad102nikolaev@gmail.com>
References: <20260605170349.1524-1-vlad102nikolaev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21850-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[vlad102nikolaev@gmail.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,ziepe.ca,mellanox.com,kernel.org,vger.kernel.org,nvidia.com,linuxtesting.org,syzkaller.appspotmail.com,linux.dev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:vlad102nikolaev@gmail.com,m:zyjzyj2000@gmail.com,m:dledford@redhat.com,m:jgg@ziepe.ca,m:haggaie@mellanox.com,m:kamalh@mellanox.com,m:amirv@mellanox.com,m:monis@mellanox.com,m:yonatanc@mellanox.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yanjunz@nvidia.com,m:lvc-project@linuxtesting.org,m:syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com,m:yanjun.zhu@linux.dev,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,cfcc1a3c85be15a40cba];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,linux.dev:email,syzkaller.appspot.com:url,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4592464A0FA

From: Zhu Yanjun <yanjun.zhu@linux.dev>

commit b2b1ddc457458fecd1c6f385baa9fbda5f0c63ad upstream.

In the function rxe_create_qp(), rxe_qp_from_init() is called to
initialize qp, internally things like rxe_init_task are not setup until
rxe_qp_init_req().

If an error occurred before this point then the unwind will call
rxe_cleanup() and eventually to rxe_qp_do_cleanup()/rxe_cleanup_task()
which will oops when trying to access the uninitialized spinlock.

If rxe_init_task is not executed, rxe_cleanup_task will not be called.

Reported-by: syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=fd85757b74b3eb59f904138486f755f71e090df8
Fixes: 8700e3e7c485 ("Soft RoCE driver")
Fixes: 2d4b21e0a291 ("IB/rxe: Prevent from completer to operate on non valid QP")
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Link: https://lore.kernel.org/r/20230413101115.1366068-1-yanjun.zhu@intel.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
[ Vladislav: match upstream cleanup order and add the missing
  resp.task.func check. ]
Signed-off-by: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 05e4a270084f..171c0f4dcbec 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -781,15 +781,20 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 
 	qp->valid = 0;
 	qp->qp_timeout_jiffies = 0;
-	rxe_cleanup_task(&qp->resp.task);
 
 	if (qp_type(qp) == IB_QPT_RC) {
 		del_timer_sync(&qp->retrans_timer);
 		del_timer_sync(&qp->rnr_nak_timer);
 	}
 
-	rxe_cleanup_task(&qp->req.task);
-	rxe_cleanup_task(&qp->comp.task);
+	if (qp->resp.task.func)
+		rxe_cleanup_task(&qp->resp.task);
+
+	if (qp->req.task.func)
+		rxe_cleanup_task(&qp->req.task);
+
+	if (qp->comp.task.func)
+		rxe_cleanup_task(&qp->comp.task);
 
 	/* flush out any receive wr's or pending requests */
 	if (qp->req.task.func)
-- 
2.43.0


