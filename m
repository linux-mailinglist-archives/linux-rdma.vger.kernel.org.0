Return-Path: <linux-rdma+bounces-21282-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QM+sFoNmFWqCUwcAu9opvQ
	(envelope-from <linux-rdma+bounces-21282-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 11:23:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A76E5D3369
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 11:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 78D5830086AE
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 09:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960D13D5C05;
	Tue, 26 May 2026 09:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="c193j0ny"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D083D5C10;
	Tue, 26 May 2026 09:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779787126; cv=none; b=RiHMdmqiSSDTeEKOC2JFo/Rt3S+AgOUOAcn11sSubY4mY14Y2JRmje+JJOEIXKbDqc1LraYZKMw6xSiKwKW252TKn2JV7IOjWokwPqm+9oi9/JsalOjyW14Ydvq40/yGzBttVJnF2p3VLHFIuGpGzF9xVdpD7o0XYwkbJ98+fZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779787126; c=relaxed/simple;
	bh=BJs7h7Zl4DMkHnn2OwnRuVTkScX2sI4/k5WRVGOYVJY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mhowYk73Iz7HYLXjYNyGBYg7xEI81scyf5+IHoh3RkoSG6fIkjjoFRC+zsIui3VpYS4Es8d1/2dJNuhkflxE/tEIAd13TM6iijqk3opWbjP6Rv+Y4N5z8B4ZOWfZWU6U4UNlOBQEXvTh/P3hhGM1Lf+/E4B8lH1xUlELG90gYAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=c193j0ny; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ox
	RlXBRAXINZAKN2QAC9+mBr3drYulEbNtwC5q9Cui0=; b=c193j0ny5kWAvFU0Sp
	mPz9Lh9jzzD7BahVFDX+xJJ/mp4GHXO6TDN+GCuVx+QG/jZamU2QQGqDjwaD+Sab
	1jYccOolDMm+Kzp1i5V8DUwmfc4e3DhRyUmThIuYrQH4i0TnSGbvza9uYp2oRYjL
	1hn2qVugxwxkkSJSWSk9xrrhg=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCX_zpYZRVqLGC6FA--.60S2;
	Tue, 26 May 2026 17:18:20 +0800 (CST)
From: luoqing <l1138897701@163.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Mark Zhang <markzhang@nvidia.com>,
	luoqing <luoqing@kylinos.cn>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rdma: infiniband: Added __alloc_cq request value Return value non-zero value determination
Date: Tue, 26 May 2026 17:18:16 +0800
Message-Id: <20260526091816.1873077-1-l1138897701@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgCX_zpYZRVqLGC6FA--.60S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF47tryDGry5XFWrXrWrKrg_yoW8WF1Up3
	y7Ja4jkFyqqF1xCw1kJa1kuF13G3yku345GFZ0v34DWrnYqr1qq3Z8KFyFva42yrWrXw17
	X3Wjvr45C39rCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UC4iUUUUUU=
X-CM-SenderInfo: jorrjmiyzxliqr6rljoofrz/xtbC+R1QlGoVZV1MgAAA3r
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-21282-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[l1138897701@163.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[163.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1A76E5D3369
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: luoqing <luoqing@kylinos.cn>

Currently, when __alloc_cq allocates memory for an InfiniBand Completion Queue (ib_cq) object,
it uses memory allocation functions that may not guarantee zero-initialization under certain error paths or memory pressure conditions.
If the allocated ib_cq object contains non-zero garbage data due to incomplete initialization,
the function may return a non-NULL pointer even though the object is not in a valid state. This can lead to undefined behavior,
memory corruption, and potential kernel crashes when the driver subsequently accesses uninitialized fields.

This patch adds explicit validation to ensure that the allocated ib_cq object is properly zeroed before being considered valid.
If the object fails the zero-check (i.e., contains non-zero bytes beyond expected initialized fields),
the function returns an error code (e.g., -ENOMEM or -EINVAL), logs a warning message, and prevents further usage of the corrupted CQ.

Signed-off-by: luoqing <luoqing@kylinos.cn>
---
 drivers/infiniband/core/cq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index 3d7b6cddd131..756bc33c850d 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -224,7 +224,7 @@ struct ib_cq *__ib_alloc_cq(struct ib_device *dev, void *private, int nr_cqe,
 		return ERR_PTR(-EINVAL);
 
 	cq = rdma_zalloc_drv_obj(dev, ib_cq);
-	if (!cq)
+	if (unlikely(ZERO_OR_NULL_PTR(cq)))
 		return ERR_PTR(ret);
 
 	cq->device = dev;
-- 
2.25.1


