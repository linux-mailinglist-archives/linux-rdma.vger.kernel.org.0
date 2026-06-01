Return-Path: <linux-rdma+bounces-21577-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDseFgNlHWrLaAkAu9opvQ
	(envelope-from <linux-rdma+bounces-21577-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 12:54:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FCA61DF14
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 12:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E94BB300ED85
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2026 10:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE79E39D3FD;
	Mon,  1 Jun 2026 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMtAkGfh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235533988FB
	for <linux-rdma@vger.kernel.org>; Mon,  1 Jun 2026 10:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780311254; cv=none; b=OKvDA2KnGN/vZOHKohnMNiyUMD1VYJYFz+OirnIm2wbOfeGv54VH4a3ZzipnHz2g4IG+FCg8YUsgnpNStoxCDqU0kNpUUgFAujADtdTq4rHUXPFWCm9rqcaOL1FIgqAMbB+VIxQTdH4xzjQ5uKxdf100EDNzcsTx5MwUAvsSSWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780311254; c=relaxed/simple;
	bh=aBqwRcjjrirAEQcYUzGrlCWqcSI+0qm6EGsqltY6yx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yb5nci8loa2L/pEbglAqjQJXbo/dUosBDbRdUF59QWCaxXb1Zc9aH+cWKIHE3Qr/q+GoY/Ac3tvjjP6FCNZDCiKwi1yBaz21obZUkAxMH09ePGad3irIwGZIIewVUAoLHNrtalIERKl7IKpym30uWmZw5Ojo2zZq7GfzJWvrlGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMtAkGfh; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39677c434efso14224171fa.3
        for <linux-rdma@vger.kernel.org>; Mon, 01 Jun 2026 03:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780311251; x=1780916051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lFXg3u3Hl1xsWJNPPj6ianatRb4V7SHTMso00cbxCeY=;
        b=YMtAkGfhBSUTJtXvRvAmSFQtqkI4LW5g2KiGEicDsLCdw5BQ6QWD9cLLapBuxjPP0+
         xHTECCMQ2d8Tc2cuY3/qGoHJt90mHvpkbsft3Gh5pGNn87zQPD2JgfSaZBXWbcSlukBS
         MLIhWYNy/GaZqbjMJ8Dx8ye5XmoJTABWe1yPdofQhw/7PXKOO3iqxUDoI1K/XVwNe5PW
         kk0jLSQpq5LEfWvYZuCxSa54mM8FZgUERQP96Y94yM3MfcqbOP5NQrF4yaJH8Fc6gMdU
         AvgEXpWj7GCsX1krCIcg4dOf3p33qMqPaHc1g4y4g5JxvfSt+IOtVDwuUrnXviIXn79+
         3HAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780311251; x=1780916051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFXg3u3Hl1xsWJNPPj6ianatRb4V7SHTMso00cbxCeY=;
        b=QoB6aSK33eNIhjMoebyp7N5g8l46djYhCUUH0jU81rl3O9wdik7ker0phajHSZO6Ae
         mi8hmEu1JazRZXY8Lg8GVyas05DetOKSR2k1UubIEOI8uOB0J9JAK3sS43OTG5957e0o
         uVoHwzZ4Fbm7hgtcl8WAqV+UfF4PVgrAFhmmVxqBrb3hETONgHqqcRBBsvRwW58svndr
         l4imB55WKeWJ+q6CN9pFU917B6aoH5YPMcLxculVJXxR8tbSwn5wj75LA6HovMrG0pXx
         P1XQviAGLo1mNlAyriOKanpQ+MCv7k48HeO8oqr2TKdpUR2kKSS5rRSEQJfrYGKanIA4
         sKFw==
X-Forwarded-Encrypted: i=1; AFNElJ8K7f1a+DfQnH4sWcMPKQmdIunL5vt9naqzHqNtfrHtLgTBqzRMUBn7WTOXxVANaH0T+zXbPJtCQ3YA@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8RLHwQJNrPtkxAoY3kzDwc+0KwLF0u97qywAZB02hZU10ZBQL
	y0RekE0qPU5qOeUYYFc1Ad2zck+kv1kN1c3++ZW+DiidP4KkQjzH3CP2
X-Gm-Gg: Acq92OH0Avd61us0U5Y+hJGqLi81t5FquZuDlAgOrLeGXNfm5OWBOo5ZX366w+Tyvkx
	FjljINOQ24C+I5pimmzicL8u+aZ+NNA4D9CVaWI4VunxN2eq6Ri4NQ0uZEOQK/t+6LHan8xrHIa
	TSgCnSMy6qo247kIV6rZeWzAws7k2tqHOq7afLv3JyUwVLHeIV3qGS9FZMXOjwm1Dc0vWVPtCbz
	7WzgTl6T6KfjWne/DC7wHAX77PP1Khp9KjaJjHe69m9GExG5P/7veGVdEMnLHPnNVDvC3YW9Zdr
	rG2DvSLErPLDgjO37P5wJfS2ItZD7EK1FZOPFohxo5tNiy/NzFlWP79UnJw/6FxIz3mmLl1JutS
	FG7TSko9QwVRHgyriM7y3OUAdMLYGk6rHf+pv5flSMVNnHO14Bzunicq9B7lxgNuH8jC/ACP5wi
	DsZZPP17DdAdrvXl+t6U8C6xZnyhq6q0YYwvjSaQgfg6WtDDgrtckdIhbgtSLDxW1Lae6gUd4Sf
	4+BszI=
X-Received: by 2002:a05:651c:4419:10b0:395:fded:ee35 with SMTP id 38308e7fff4ca-39664e39419mr20850381fa.3.1780311251119;
        Mon, 01 Jun 2026 03:54:11 -0700 (PDT)
Received: from c0624c666cc5.devsec.astralinux.ru ([93.188.205.42])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3967a2e7abcsm10381351fa.8.2026.06.01.03.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:54:10 -0700 (PDT)
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
Subject: [PATCH 5.10/5.15] RDMA/rxe: Fix the error "trying to register non-static key in rxe_cleanup_task"
Date: Mon,  1 Jun 2026 13:52:32 +0300
Message-ID: <20260601105336.3023-1-vlad102nikolaev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,ziepe.ca,mellanox.com,kernel.org,vger.kernel.org,nvidia.com,linuxtesting.org,syzkaller.appspotmail.com,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-21577-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vlad102nikolaev@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma,cfcc1a3c85be15a40cba];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Queue-Id: 13FCA61DF14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Signed-off-by: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
---
Backport fix for CVE-2023-54028
 drivers/infiniband/sw/rxe/rxe_qp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 13b237d93a61..687d4419388f 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -785,8 +785,11 @@ void rxe_qp_destroy(struct rxe_qp *qp)
 		del_timer_sync(&qp->rnr_nak_timer);
 	}
 
-	rxe_cleanup_task(&qp->req.task);
-	rxe_cleanup_task(&qp->comp.task);
+	if (qp->req.task.func)
+		rxe_cleanup_task(&qp->req.task);
+
+	if (qp->comp.task.func)
+		rxe_cleanup_task(&qp->comp.task);
 
 	/* flush out any receive wr's or pending requests */
 	if (qp->req.task.func)
-- 
2.47.3

