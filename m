Return-Path: <linux-rdma+bounces-9411-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6612AA8880A
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 18:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2DEB7A2EBC
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 16:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C3828A1C6;
	Mon, 14 Apr 2025 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0a49cijR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zCl+R/vs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F94288C90;
	Mon, 14 Apr 2025 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744646899; cv=none; b=Ktv8T5T6q36NjZzAQ6bWswdwiOEY4iNf0KvuIp47JxGWiphYSH3QUY42zu5mi+5ZYD5D0OlY946uqEiyy0Pkt5RiX0J4Robc1JG8X3GOzHzA7u+8Qg82KLkmTGe3z6fgD9vet+WMWj5f/t0C5gyC6fjRIQJNizta9OFjDelbYko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744646899; c=relaxed/simple;
	bh=jOJA68RRCsFupoKbIXpdPkdpTgYXhITPGS5zLjDwJlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2PsH6HbkxadnC5O/rAcHac61Ni04n2v+eKxonI2O4vaux0xHuJZOUe/5UyXQUp8xbWRGOX16HADD3K69B4GiSyYNowGTa8/e/4vw2q1FRvogCH61FyuwQvy2rVFLroOhK3Duerqmhity/Y/raP2ORLn435QDlVHZRq8ROvrDaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0a49cijR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zCl+R/vs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744646894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QW4ASRASgx99S0FnlTl8xeHoYCpECC/wdaoXtQZvpSA=;
	b=0a49cijRWl5eLWk6JoQda21CqwPgmTBuS8G6lw+VKdT7cLuPguL05v0I3TFlsyVck5z27r
	BRw4bUwO9BiP+McfpHBoCd0GNSaExDisOB6Wp3teqw8SXFQn4IQ+C5ms17JERKs8C05CnU
	o0hPE6cexH8F1yb7ahY/wSSKGJqcsWQICwU9LQ6BpJEc9T99vMR56Y5qRnJXqpLiPeMZGq
	oF0sGEN3yCNCb0luwb9PrB4kXI8lV19mCBreEgKHSm241RpvMdlI49BrMPjXXOgGsWzEbe
	XJ/Y2fPmroZSH+JKvVMaQbSzFqFZLo82a4XjXfdDZNdhaRNFlajwkETar7qINQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744646894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QW4ASRASgx99S0FnlTl8xeHoYCpECC/wdaoXtQZvpSA=;
	b=zCl+R/vsl1GZ1kyFbN31QTqwrWfUjazZW+akVYZ9S/VoQ3DYyWQvJrtW/pDO72NNaQhplI
	VB9LU3KHg2tTtBDg==
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
Subject: [PATCH net-next v2 16/18] rds: Disable only bottom halves in rds_page_remainder_alloc()
Date: Mon, 14 Apr 2025 18:07:52 +0200
Message-ID: <20250414160754.503321-17-bigeasy@linutronix.de>
In-Reply-To: <20250414160754.503321-1-bigeasy@linutronix.de>
References: <20250414160754.503321-1-bigeasy@linutronix.de>
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


