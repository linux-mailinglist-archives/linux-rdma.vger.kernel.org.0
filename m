Return-Path: <linux-rdma+bounces-9940-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2E6AA4BD5
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Apr 2025 14:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34EC24E840D
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Apr 2025 12:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB8025D90F;
	Wed, 30 Apr 2025 12:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1R9eqsxL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MzhCubqh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFB525E44B;
	Wed, 30 Apr 2025 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017301; cv=none; b=ALXscrMG8pULH/g9eMJ3dB7jfH8sv8JLgmJoF/sgt7FFdAp5hVOW0XDrEEZphPC5Yihij2pWRqdGNpI6yassCDi2Iov9BQ1O04PiF815yqMQUppvm/yEjlorr7wKyXpJC1JFwQCrbbnlf5hHXrNr9xMdSbS5Flsy/dTHzMg7C/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017301; c=relaxed/simple;
	bh=jOJA68RRCsFupoKbIXpdPkdpTgYXhITPGS5zLjDwJlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7qW746zPtip4Gl2zpAzgPlP2RL9mV0z6cZ8U1XAA8tj3vy/bhc3RzXZ8ACvpxFYI91KQ4eQa80aEhJjGidUkG96bMm7HfM0QlrNwCTejK/wTQrBDQ/I7UY+zBNOMVqOd4NLfP6hHOW9mB0/WfKxdAguoYi3RbuvYTBaSkp6p6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1R9eqsxL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MzhCubqh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746017296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QW4ASRASgx99S0FnlTl8xeHoYCpECC/wdaoXtQZvpSA=;
	b=1R9eqsxLKqG+mPm6QaVBZ+nK1TjVvTT1oabZcThxWfZLyv5BSUo4PAamzmxhaJ6VIqNw/r
	jA1bu84EU1iPg5gVedIF9fl+n6HtEEcZHHXTOid77DBst8yuJMuUv3WsXAbJ0XRq0oqlAF
	txEUNSKaeBttwE7MR6GLGdJoRgJe+VklnK4YXsA3lybtkTYotfDuvuciZX8DGd1qmSQMCI
	j+FaOxQgvHH3zt2yt0q9prI9juCCyXEc2gdSDl/VV/uT59xg/vfdr85SMUC79f7ejnfaQY
	hCz6E17GNrwGn8Tf8YpdtQM5SBaDwPVmEJn10/bdarZtTIepcTYQFNyy7ObqoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746017296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QW4ASRASgx99S0FnlTl8xeHoYCpECC/wdaoXtQZvpSA=;
	b=MzhCubqh4AbrJOIeP2/9SC8zOFapRWq3Q/YgjvL7nAPT1hqf9ssQa0/7USe0hKb2cWHClg
	ht3gmgtz5Dz08CBg==
To: netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Allison Henderson <allison.henderson@oracle.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v3 16/18] rds: Disable only bottom halves in rds_page_remainder_alloc()
Date: Wed, 30 Apr 2025 14:47:56 +0200
Message-ID: <20250430124758.1159480-17-bigeasy@linutronix.de>
In-Reply-To: <20250430124758.1159480-1-bigeasy@linutronix.de>
References: <20250430124758.1159480-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

rds_page_remainder_alloc() is invoked from a preemptible context or a
tasklet. There is no need to disable interrupts for locking.

Use local_bh_disable() instead of local_irq_save() for locking.

Cc: Allison Henderson <allison.henderson@oracle.com>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/rds/page.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/rds/page.c b/net/rds/page.c
index 7cc57e098ddb9..e0dd4f62ea47a 100644
--- a/net/rds/page.c
+++ b/net/rds/page.c
@@ -69,7 +69,6 @@ int rds_page_remainder_alloc(struct scatterlist *scat, un=
signed long bytes,
 			     gfp_t gfp)
 {
 	struct rds_page_remainder *rem;
-	unsigned long flags;
 	struct page *page;
 	int ret;
=20
@@ -88,7 +87,7 @@ int rds_page_remainder_alloc(struct scatterlist *scat, un=
signed long bytes,
 	}
=20
 	rem =3D &per_cpu(rds_page_remainders, get_cpu());
-	local_irq_save(flags);
+	local_bh_disable();
=20
 	while (1) {
 		/* avoid a tiny region getting stuck by tossing it */
@@ -116,13 +115,13 @@ int rds_page_remainder_alloc(struct scatterlist *scat=
, unsigned long bytes,
 		}
=20
 		/* alloc if there is nothing for us to use */
-		local_irq_restore(flags);
+		local_bh_enable();
 		put_cpu();
=20
 		page =3D alloc_page(gfp);
=20
 		rem =3D &per_cpu(rds_page_remainders, get_cpu());
-		local_irq_save(flags);
+		local_bh_disable();
=20
 		if (!page) {
 			ret =3D -ENOMEM;
@@ -140,7 +139,7 @@ int rds_page_remainder_alloc(struct scatterlist *scat, =
unsigned long bytes,
 		rem->r_offset =3D 0;
 	}
=20
-	local_irq_restore(flags);
+	local_bh_enable();
 	put_cpu();
 out:
 	rdsdebug("bytes %lu ret %d %p %u %u\n", bytes, ret,
--=20
2.49.0


