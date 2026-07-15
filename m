Return-Path: <linux-rdma+bounces-23239-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pyfuHffwVmofDQEAu9opvQ
	(envelope-from <linux-rdma+bounces-23239-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 04:31:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C859375A108
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 04:31:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=AqEx7fEl;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23239-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23239-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8860A308836A
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 02:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D627E3A783B;
	Wed, 15 Jul 2026 02:30:45 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67FB19F137;
	Wed, 15 Jul 2026 02:30:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784082645; cv=none; b=nLehHbdvE2xVyLiKbfMVk+uIaKQWGeh96dOYDkME5ic3jBy8qNGnoetqBpA1pEHcZCmqbzXXOj5upuPQGH4lCQRa3EHGI3hpm0WgZaVKn4Z1V/ggsYeOotZa/rRugcxNzpY0+gYrwtxgE7MhOAmlfCCAZ3toa3d/UkZBObsq+aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784082645; c=relaxed/simple;
	bh=j2mrNv1C/JWkbTczEQfx78x9V0OtWFlFCo+ubJB8Vlo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IFU8c1Zu6qtIEd/UJGFgAJjIi+y5JfC0Xd8ROHDxu9Z6TU+OihMHfHWX7cDgJLZWwPIVWOKTgLL+q48eXh1Me2YbPNImrXx5cibn1vqdnlwbITKb+4pjLhZ96RbojupZ6u2JfjtPbCkP+QmfiqtfkPC3xKAVDTN4QjCx19wwcZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AqEx7fEl; arc=none smtp.client-ip=220.197.31.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=77
	H6uJKkG6iYW7g9AkN53A/6FyfqZ+quA14rVSz7XU4=; b=AqEx7fElOy/stYAWFQ
	U61n4GAWIshy7BotppTBsXBHual53Xx+JeAGxStJkNJeVBNc/JXvO99u49J+5Nlw
	v7zi4TACHXgfgdobRHeCGIwDT0NzNajRGVHYWFchY4B0wYgRfORhNb5wvQVyi4IH
	K9RnK17m5R9La80aaiNe/hE3s=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wC3IJO58FZq5FUMIw--.64680S2;
	Wed, 15 Jul 2026 10:30:18 +0800 (CST)
From: kensanya@163.com
To: bvanassche@acm.org,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	TanZheng <tanzheng@kylinos.cn>
Subject: [PATCH] RDMA/srpt: Fix srpt_alloc_rw_ctxs() unwind counters
Date: Wed, 15 Jul 2026 10:30:16 +0800
Message-Id: <20260715023016.56767-1-kensanya@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3IJO58FZq5FUMIw--.64680S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw4kXw17ur4DtFWUCw4kZwb_yoWkKrX_C3
	srKF97Z34kCa18uw1qkFnxuFyFkFy7Cr4Iqa9Iq3s3C3s0v3Z8A3s7Wr1rZw45J3yUKF98
	G343K3yxGr1rKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1LvK5UUUUU==
X-CM-SenderInfo: 5nhq2txq1dqiywtou0bp/xtbC6RqadmpW8LoHDQAA3j
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23239-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bvanassche@acm.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:target-devel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tanzheng@kylinos.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[kensanya@163.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kensanya@163.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C859375A108

From: TanZheng <tanzheng@kylinos.cn>

When srpt_alloc_rw_ctxs() fails partway through a multi-buffer indirect
descriptor, the unwind path destroys RDMA contexts but leaves stale
n_rw_ctx and n_rdma values (and a dangling rw_ctxs pointer). Later
sq_wr_avail accounting in srpt_queue_response() or srpt_write_pending()
can then subtract the wrong number of send queue credits.

Reset the counters and rw_ctxs pointer before returning an error.

Fixes: b99f8e4d7bcd ("IB/srpt: convert to the generic RDMA READ/WRITE API")
Signed-off-by: TanZheng <tanzheng@kylinos.cn>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index f66cfd70c263..4644429fae14 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -1016,6 +1016,9 @@ static int srpt_alloc_rw_ctxs(struct srpt_send_ioctx *ioctx,
 	}
 	if (ioctx->rw_ctxs != &ioctx->s_rw_ctx)
 		kfree(ioctx->rw_ctxs);
+	ioctx->rw_ctxs = &ioctx->s_rw_ctx;
+	ioctx->n_rw_ctx = 0;
+	ioctx->n_rdma = 0;
 	return ret;
 }
 
-- 
2.25.1


