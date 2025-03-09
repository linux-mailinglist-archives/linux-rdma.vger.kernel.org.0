Return-Path: <linux-rdma+bounces-8510-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2E0A58510
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Mar 2025 15:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA1EB7A6643
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Mar 2025 14:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F301F0981;
	Sun,  9 Mar 2025 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NKeRG1C6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FxQ5VLEa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2D11EB5C4;
	Sun,  9 Mar 2025 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741531637; cv=none; b=VDDPKA5jxp0xc4E7IfMddojnaAbaWuSaXqEKL5JTCNN6W+0dAMnoUM/5clu80fTRLTWAThWcHwyOfoKDjunNVK5v6p8NJ0L6unfUsdvbBg30Q99vo8zr8F9mPvtQXRkQE8IdQuP96dsSxug3Xxv02OL7g1Vec1Q+2MrDOdFgU80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741531637; c=relaxed/simple;
	bh=KqoKUZEweth4eUnuFS1Nm52k3bfMfq298SudnyUOZxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9ic4Nd0HraR7Qgmh0lhQU0PoLQd4E5I28oqIvfvRk1VOvgXQjzyTfjDFWeeumAdbrLRUPke2/DVBnOUVKly/SCz9gieqY77/ref41dFjucMLDgdNj5pkuD16IhUxk6FR3oW8OunK2c4GdnYeT4dCKFgWMtYNGW8JfH7ZkewIJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NKeRG1C6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FxQ5VLEa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741531632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dgbrz2OEZ6aEoJpoB0C+hoamsafL5vBdsLc143vGtMY=;
	b=NKeRG1C6VaKiSwGdYsB5nzBCZxDLcaIyoabVuvOgX6ppaGrmV6/c7vJyx+f5ZBsVkbdDTv
	pTDhBJLKk1aIg0AWIx6lNditWebWlNEkTJXkufmBYC3K9ERHNx3Zrx4UwsppzvQpifT4af
	jxOa7GBQWr2f2J6MCKJVooa9Wru3KZNWJRd4y7jMX9Em8QXli3LS7yGAzAWNW3e9Pi/edV
	wp+b7GZREpY6Xdl++aKEVQ9CHtvd0hyKEaHntsWjn+83p575Yig1zf5HNUHbFVZsH+TN07
	iDHNzdyOz0pa8X4jt0NO6KQrX3CyNJaJw7iM6sPsmy4fM2dfFDJXksqiQpaqbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741531632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dgbrz2OEZ6aEoJpoB0C+hoamsafL5vBdsLc143vGtMY=;
	b=FxQ5VLEaXR+FXN5bDRPqXF90SWUM1FxiatgPy6CNtcS+PZ/ixp3NCM2LlH1T+YxpqbSzOs
	EOEEE1Oh4oWM1kBQ==
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
Subject: [PATCH net-next 16/18] rds: Disable only bottom halves in rds_page_remainder_alloc().
Date: Sun,  9 Mar 2025 15:46:51 +0100
Message-ID: <20250309144653.825351-17-bigeasy@linutronix.de>
In-Reply-To: <20250309144653.825351-1-bigeasy@linutronix.de>
References: <20250309144653.825351-1-bigeasy@linutronix.de>
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
2.47.2


