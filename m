Return-Path: <linux-rdma+bounces-23273-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JvkROsNeV2pLKgEAu9opvQ
	(envelope-from <linux-rdma+bounces-23273-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 12:19:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9930475CE66
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 12:19:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=pTDcpbds;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23273-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23273-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81CFE300FFAF
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 10:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B4C43C065;
	Wed, 15 Jul 2026 10:16:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF8F353A93;
	Wed, 15 Jul 2026 10:16:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110588; cv=none; b=lJNy2ves8HxjwXTb+BpyM2ryhqPSTGag0cUtQItTvanJav84Cmze9Uo08SIWjs8lMBwqfbcLyfGfhfotmIt/xO6g6eSV33L/wKR2YDs74bgHm2G1KBgijHStVGrB6xqW1yZzR3HPGgTtY9/YfsjO7iwV5D3b2QeZeRMxr0rpFsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110588; c=relaxed/simple;
	bh=YiS1SZdTwfCtiBbgacK3doelhezdgpunYTTIeMez/JI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DtUYg5na4UOC/jlOz9M52f+iJEAQWipcc6U/O5369qNM+i6H8GPXhwSByNYYgpv0KVugF5liL+SopIst9GmRSlu4NDVCRzuCR3PmgvZr8I2Z5gAX0ER1mPYm0D2ytjN34voqgX6rJCvGUkfbDPFQ+TeN5GJun7BYSKGbfgXMxjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pTDcpbds; arc=none smtp.client-ip=220.197.31.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=PK
	XExNf0diIha/+qNOIbY6dHNL8iPPWfMny+L0Fpiyw=; b=pTDcpbds8WQ+sb+fM6
	woOs7zV/nyRCii5Kp9X5GAKK7NamPyeY1onZ0RHee9KbLNAw68X3yodVNnivD0qA
	gqOvb5HJ22ISsIsaKmbeBAt6zupkm/FmZUG6bMjHU7LpRoQvP70PhKBgIk0Yi2M7
	tzob43YEiiUXnL3PdtBnupM6Y=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wAX9qXWXVdqT9iyJw--.31087S2;
	Wed, 15 Jul 2026 18:15:52 +0800 (CST)
From: kensanya@163.com
To: bvanassche@acm.org,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	TanZheng <tanzheng@kylinos.cn>
Subject: [PATCH v2] RDMA/srpt: Fix srpt_alloc_rw_ctxs() unwind counters
Date: Wed, 15 Jul 2026 18:15:50 +0800
Message-Id: <20260715101550.45345-1-kensanya@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAX9qXWXVdqT9iyJw--.31087S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFWrKry5XF48WrykCF1rZwb_yoW8Gw4rpr
	sYy3yakF98WF4xGFWDta17XFy3uw4fAr48C3s2vwn0vFs0qF9rtF1q9rWDWF1kXrn5Jw4a
	qr4DAa15Cr4UWw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UMq2iUUUUU=
X-CM-SenderInfo: 5nhq2txq1dqiywtou0bp/xtbCwRj92WpXXdjiKwAA3M
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23273-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kylinos.cn:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9930475CE66

From: TanZheng <tanzheng@kylinos.cn>

When srpt_alloc_rw_ctxs() fails partway through a multi-buffer indirect
descriptor, the unwind path destroys RDMA contexts but leaves stale
n_rw_ctx and n_rdma values (and a dangling rw_ctxs pointer). Later
sq_wr_avail accounting in srpt_queue_response() or srpt_write_pending()
can then subtract the wrong number of send queue credits.

Reset the counters and clear rw_ctxs after freeing the heap
allocation before returning an error.

Fixes: b99f8e4d7bcd ("IB/srpt: convert to the generic RDMA READ/WRITE API")
Signed-off-by: TanZheng <tanzheng@kylinos.cn>
---
v2:
- After kfree(), set rw_ctxs to NULL instead of &s_rw_ctx
  (Leon Romanovsky)

 drivers/infiniband/ulp/srpt/ib_srpt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index f66cfd70c263..a9c4995af7a3 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -1014,8 +1014,12 @@ static int srpt_alloc_rw_ctxs(struct srpt_send_ioctx *ioctx,
 				ctx->sg, ctx->nents, dir);
 		target_free_sgl(ctx->sg, ctx->nents);
 	}
-	if (ioctx->rw_ctxs != &ioctx->s_rw_ctx)
+	if (ioctx->rw_ctxs != &ioctx->s_rw_ctx) {
 		kfree(ioctx->rw_ctxs);
+		ioctx->rw_ctxs = NULL;
+	}
+	ioctx->n_rw_ctx = 0;
+	ioctx->n_rdma = 0;
 	return ret;
 }
 
-- 
2.25.1


