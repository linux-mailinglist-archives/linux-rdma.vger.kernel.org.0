Return-Path: <linux-rdma+bounces-21685-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M7TFH2QtIGrjyAAAu9opvQ
	(envelope-from <linux-rdma+bounces-21685-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 15:34:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D01406381C8
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 15:34:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ZknzVmwJ;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21685-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21685-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D6BB3059309
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 13:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644CC2D1916;
	Wed,  3 Jun 2026 13:27:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6762C21F8
	for <linux-rdma@vger.kernel.org>; Wed,  3 Jun 2026 13:27:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780493257; cv=none; b=YnHnbaUHy5Yz/4D30EN6KTm5K0yPqcAagKF8u3ncvETB1NidGlPQWcrC2FHRGnU5sLEUqFCLTcEjpVwu55Jg4RIfhFFDgHGsxXPw61NHTxYR+7pR5PZ+xYq9W4ZtZFr/KEAq8xqSxDHle145Y+z0eD7ZjvYZVpzHGOWaR1UBvrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780493257; c=relaxed/simple;
	bh=ZKmIfYiJUMLvnY0Ua9XlJaLUeAaZxb1MUfLcnPeVDeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qnv2MMkDMp4enJ1RFICaD37pzVW3Faq+qMcLNZ4QZo6ll+Nm+iRGPqdDhbgELpJzqiU+rGT3yWscQjaFAQ7/2ktdQHd5CmBQ5MYN4G49amsw6ANIrwVqzmayzzXbVTeMJDgYvmWnMjP/11Yqw92UGNCD+h5bQUAt5bVQ/iA++6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZknzVmwJ; arc=none smtp.client-ip=209.85.167.49
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aa61503fdaso641680e87.0
        for <linux-rdma@vger.kernel.org>; Wed, 03 Jun 2026 06:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780493254; x=1781098054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2h2vROgMXzHw1sF/4pXkeNWKYSy/sCswN0t0aO0Lclk=;
        b=ZknzVmwJv+xZP/AQeZ6RpppJQ7ghZ24HNJEfOZDOFXyz8HHGAXdeOkIHz3u8LFzLYL
         yxQrbnCJ4EZDPIO1MpejEWMDzNYOYM6R64tQQvM8u/flpi9RHiE23I4MuKf45OeHsXRz
         JHNA2clWC/w/TTbwdsxLhRTwdVePSpr8Ex3E8u4MkpO7rX+EuJ5rT9R5coH4AFmDicfN
         pcBrANNEF94TAEevep+oa2GbYaMQDZNZIAnm1Swh7cNVOi/SsOuZ0pJ40rKCi4/lMH8X
         EuYQ7//n/3TkylgeZ73ACSniNVkQxstZXgovVra7FFDT+7IUVjAQtUNKFBV7zPOHTLBn
         dBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780493254; x=1781098054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2h2vROgMXzHw1sF/4pXkeNWKYSy/sCswN0t0aO0Lclk=;
        b=pkXJ6wEcR7OVD7U3JAPUWeK/K+i3WH5csjh8c3FQa4nXUJdTWpgVFuNRiR+KCkvgPe
         Pdf/g3tQfcZwE5han0YQHqzl/PXwsGLmVt/fwGictI0P1hgJvX19Bfe7LGpDEWxw8Qir
         c/8P07HQl1kiYtuPoFTs40Pz3r3jpCbWQnlrn6OYFeeZzM9tJbOrPNoSG1lQUDEA0CeB
         yZm2Dc4einp4xvY95OsiYpKuwRsW/weeJdKiq25mhaiJujTLjaRCF2/7MJ7rQ2uMdul+
         zt43IdIzjcxc/M1NSEKiw89BJs/HyaQWzT6c89JTqf6ZsfZJRG+V7slp94tutEo2RCHp
         8pwA==
X-Forwarded-Encrypted: i=1; AFNElJ+Q9dvkgdcXgMIgZPmLaq0w6TZ8Xgvu2ko8L19OVErb3L+Hf/yVrA9K8/khValhJPdFG9rxIM+a+vB3@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn/ASgjKtI5flDrlSm6Rg3S9fwFHBDR6ljWFNSbSSVuKiZTFlM
	o0SLfQ2PTEl+ub6hVYbUzOoKlWHEshzUWoMKgHWeIQtOi+bxxu8f9oBC
X-Gm-Gg: Acq92OG1U3L97Sr1Aerr6+KrBsUtfIVRFHeS5eJHgbaGEjcwuTeyGKzduQApuyHTbhn
	cp/zPxQrzvPvmhawqkrFcMNkKSPDTjmiR51z8BL7SYFL1gXotVENTo7pgPmJYKw5C0nHK9hR/Se
	+dztC0g/02Hb4aA747SRA/oTeWryKPZ40aU9GObLz2JjxhcpTB/SOc7oMOFkJPMvBGsfZVoDbi1
	mDxk+e5DdNuFpSYTxsUf9UFCv0c7pfkSKh/mlPyeseNpBpGCEkg7avwZ1MRQOrNuLhqHc3RH6tS
	7gstMTFLY9nD48tmynfcDyjN+IxlNdBk82ZsaaQdNuAcsdEr72xFlaMJ6SGzwqRrqeOScUb0WF8
	fHuJ49VUcOo8LZZZrz/YujYKQWQtH1QqKmr5sMr/EqT5LQYrx3v3w2yBSG25v4FqRI7XwHvKmUf
	kZRlsMDzQtDtwEnLcbYDxWjlzNGbLO37/jcK/5+dd6z1Kzsth+DrcG3SxCwsFfGpJY36R5
X-Received: by 2002:ac2:4bc4:0:b0:5a3:ff48:f7d6 with SMTP id 2adb3069b0e04-5aa7c7921f2mr967973e87.13.1780493253776;
        Wed, 03 Jun 2026 06:27:33 -0700 (PDT)
Received: from c0624c666cc5.devsec.astralinux.ru ([93.188.205.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8ed90csm653167e87.7.2026.06.03.06.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 06:27:33 -0700 (PDT)
From: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Haggai Eran <haggaie@mellanox.com>,
	Kamal Heib <kamalh@mellanox.com>,
	Amir Vadai <amirv@mellanox.com>,
	Moni Shoua <monis@mellanox.com>,
	Yonatan Cohen <yonatanc@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	Zhu Yanjun <yanjunz@nvidia.com>
Cc: Vladislav Nikolaev <vlad102nikolaev@gmail.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1] RDMA/rxe: Complete the rxe_cleanup_task backport
Date: Wed,  3 Jun 2026 16:27:15 +0300
Message-ID: <20260603132729.423-1-vlad102nikolaev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,linuxtesting.org];
	TAGGED_FROM(0.00)[bounces-21685-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:zyjzyj2000@gmail.com,m:dledford@redhat.com,m:jgg@ziepe.ca,m:haggaie@mellanox.com,m:kamalh@mellanox.com,m:amirv@mellanox.com,m:monis@mellanox.com,m:yonatanc@mellanox.com,m:leon@kernel.org,m:yanjunz@nvidia.com,m:vlad102nikolaev@gmail.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,linuxfoundation.org,kernel.org,gmail.com,redhat.com,ziepe.ca,mellanox.com,nvidia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[vlad102nikolaev@gmail.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vlad102nikolaev@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D01406381C8

No upstream commit exists for this patch.

The issue was introduced with backporting upstream commit b2b1ddc45745
("RDMA/rxe: Fix the error "trying to register non-static key in
rxe_cleanup_task"") to the 6.1 stable tree as commit 3236221bb8e4
("RDMA/rxe: Fix the error "trying to register non-static key in
rxe_cleanup_task"").

The 6.1 backport guarded qp->req.task and qp->comp.task before calling
rxe_cleanup_task(), but left qp->resp.task unguarded. It also kept the
responder task cleanup before deleting the RC timers, while upstream had
already moved it after the timer shutdown by commit 960ebe97e523
("RDMA/rxe: Remove __rxe_do_task()").

In the 6.1 tree, rxe_qp_from_init() calls rxe_qp_init_req() before
rxe_qp_init_resp(). Therefore, if rxe_qp_init_req() fails, cleanup can
run before qp->resp.task has been initialized by rxe_init_task(), and the
unconditional rxe_cleanup_task(&qp->resp.task) can still hit the same
uninitialized task lock problem that upstream commit b2b1ddc45745 fixed.

Move responder task cleanup after deleting the RC timers, matching the
upstream cleanup order, and guard it with qp->resp.task.func like the
requester and completer tasks.

Fixes: 3236221bb8e4 ("RDMA/rxe: Fix the error "trying to register non-static key in rxe_cleanup_task"")
Signed-off-by: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 709c63e9773c..171c0f4dcbec 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -781,13 +781,15 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 
 	qp->valid = 0;
 	qp->qp_timeout_jiffies = 0;
-	rxe_cleanup_task(&qp->resp.task);
 
 	if (qp_type(qp) == IB_QPT_RC) {
 		del_timer_sync(&qp->retrans_timer);
 		del_timer_sync(&qp->rnr_nak_timer);
 	}
 
+	if (qp->resp.task.func)
+		rxe_cleanup_task(&qp->resp.task);
+
 	if (qp->req.task.func)
 		rxe_cleanup_task(&qp->req.task);
 
-- 
2.39.5


