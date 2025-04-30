Return-Path: <linux-rdma+bounces-9938-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B11DFAA4BA3
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Apr 2025 14:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F2B99A4174
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Apr 2025 12:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8232609D1;
	Wed, 30 Apr 2025 12:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xXD+e1ZO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/jAWWDvf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EED25B1E2;
	Wed, 30 Apr 2025 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017300; cv=none; b=K9nJmslhZB4N1PacBg2abNBwNBjdFo+Ydrp/cyYlv3dmDE+SdkVO//n4KnM2VN5gl63+DO0mcWJYHQUAEdwzGLIM0nUx/WllGBjDicEa/X5hYfXlgPVhfn0WhJyomrM6w9ThiBHLvr1ILPuF3C6eoH4m6/WX+u5h0EXvwi4pF9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017300; c=relaxed/simple;
	bh=i0VNjcCRvdovrY3iCi7sMqjj1HF76Yz/3D8yI+89hSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWFsli2CdJ2njo2YpOX1liidgDUwpcYk7yXFeyvt3EtR6jQaZkS5hahayjH3KUzj8fe3RWZcUa0Os5nEUxel6M8SGuhx295je4AIZy7MApViM4EEl+DZVRqmHEWWf+CdYPjfNvoe5eAGqBNETheuWbITUW//azGNuEizAXcTh4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xXD+e1ZO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/jAWWDvf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746017296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nmddc0pDztofvgEdvZvBBZR6kgIdxTlNYioqcelkIOA=;
	b=xXD+e1ZOC2ZljqUk6n4xMV3n9nyFj9MqXQdzH0biIwUUY0W9mj1QQ8sH1gDdXMNZgkxwes
	XSeJ/PBruU656gH0FjrYiRmWquvIXbxpWOsY/3yIAoVD1VZ01zXGGMiVPPpWG3W8uBfIHF
	3i5Rc3QgK6YAW4CcJWOdiMmy2rWwm2NBXaVCRRqK93EZzy4ZaH7EirwHaERWxl3sP3kblW
	SN+GHAVSPevopiXQj3NgBeAE4d38T1vhTcGDSmo7u2G8fHFrQeKePw/R0/Vq+94Db2OX1K
	BF9wAmYENDPESYO2ut7vSv7dNnsvZa+a9Fq2xbRA0Ktz8rb57DhlcChnlg21ZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746017296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nmddc0pDztofvgEdvZvBBZR6kgIdxTlNYioqcelkIOA=;
	b=/jAWWDvfKQJ/loCK45ofJNBVgnj3HpNbCMuSu6hioeeTkFMk0ZXlud94yhYXnyOzkO5abj
	9fnD85W6+iiz1ECQ==
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
Subject: [PATCH net-next v3 17/18] rds: Acquire per-CPU pointer within BH disabled section
Date: Wed, 30 Apr 2025 14:47:57 +0200
Message-ID: <20250430124758.1159480-18-bigeasy@linutronix.de>
In-Reply-To: <20250430124758.1159480-1-bigeasy@linutronix.de>
References: <20250430124758.1159480-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

rds_page_remainder_alloc() obtains the current CPU with get_cpu() while
disabling preemption. Then the CPU number is used to access the per-CPU
data structure via per_cpu().

This can be optimized by relying on local_bh_disable() to provide a
stable CPU number/ avoid migration and then using this_cpu_ptr() to
retrieve the data structure.

Cc: Allison Henderson <allison.henderson@oracle.com>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/rds/page.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/rds/page.c b/net/rds/page.c
index e0dd4f62ea47a..58a8548a915a9 100644
--- a/net/rds/page.c
+++ b/net/rds/page.c
@@ -86,8 +86,8 @@ int rds_page_remainder_alloc(struct scatterlist *scat, un=
signed long bytes,
 		goto out;
 	}
=20
-	rem =3D &per_cpu(rds_page_remainders, get_cpu());
 	local_bh_disable();
+	rem =3D this_cpu_ptr(&rds_page_remainders);
=20
 	while (1) {
 		/* avoid a tiny region getting stuck by tossing it */
@@ -116,12 +116,11 @@ int rds_page_remainder_alloc(struct scatterlist *scat=
, unsigned long bytes,
=20
 		/* alloc if there is nothing for us to use */
 		local_bh_enable();
-		put_cpu();
=20
 		page =3D alloc_page(gfp);
=20
-		rem =3D &per_cpu(rds_page_remainders, get_cpu());
 		local_bh_disable();
+		rem =3D this_cpu_ptr(&rds_page_remainders);
=20
 		if (!page) {
 			ret =3D -ENOMEM;
@@ -140,7 +139,6 @@ int rds_page_remainder_alloc(struct scatterlist *scat, =
unsigned long bytes,
 	}
=20
 	local_bh_enable();
-	put_cpu();
 out:
 	rdsdebug("bytes %lu ret %d %p %u %u\n", bytes, ret,
 		 ret ? NULL : sg_page(scat), ret ? 0 : scat->offset,
--=20
2.49.0


