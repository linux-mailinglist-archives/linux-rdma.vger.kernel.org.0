Return-Path: <linux-rdma+bounces-8511-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1BDA58508
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Mar 2025 15:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A18D18806DB
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Mar 2025 14:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CD81F0998;
	Sun,  9 Mar 2025 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b4k0GYge";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qZ4Amo/H"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729CD1E521D;
	Sun,  9 Mar 2025 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741531638; cv=none; b=efwWDVqoySPw24NoqXJxXUXF1ifeVuQupXWwTMSCZGr77CAurkucz4NzFAdPhFfwOK4sVPAFTuzZWZV5qnfeDoBN5StwQlnLghLhf4oQCl/ZY4ioWACiay6LezvzveVuLTBZNS0xdEW3RAGMDSAD7tMlpiBvumXhp0JlOqsxM0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741531638; c=relaxed/simple;
	bh=alvzr3rmRIJs8SYMbjK6X1RfWDp0ICwIjcxZCSinOLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQ2BPaTYEfgHAzCTVAyiUCxFdFRBAD2n7tC2dgglSIsBNd1qzX8i1Fx9T3rixPlSj6CafkYVuZN60rKZUYYHHHZ+Yk8f7Tx+f4LcIrtasuctaYz09EDQmYH5LvfC/ilgFyf6ohSs/dZ3vyZVHjut6HuVdqRQN/vo9A94ypU28D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b4k0GYge; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qZ4Amo/H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741531632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QvIeJeOhBJ2MlknP0xO1PybUxd0Jemlt2VLER5LrqDY=;
	b=b4k0GYgefgxyxAJjh4MU39+73tYHC9owGD7B5c6QytvgXG6giRVS/Z/Fz7KWxk6ZxoAfLj
	7f5ZtqXMTCR2IK88afKn2KpAwcgC9YVLnOV28o+1vg61bMoYUdW4SDB++JelXdhIopFODk
	1NcB1d4gym92K5RqoautjBGKW/CLR49uPsMXLTuCOEzx1nctWBUekIT9bzQohAd7Ja2vft
	+hi7xbgm26H/0eypIFG6vPlNYavAJLMi3JCURbAX5N3ETx6fGCUKFmd30UnCYf4V8OQKzh
	Q/J+HNwB8fDZTvBpIBjLBxwxTVqLSXAdiQAYrJB0AfKgHoIb9nRIBj0Lxl/mIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741531632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QvIeJeOhBJ2MlknP0xO1PybUxd0Jemlt2VLER5LrqDY=;
	b=qZ4Amo/Hf+Eg2+oaw+s1iSO+6i/Qt5b/dWs8SxfvTyDeLmhT/P17iKwUiB3tC27H1kY4hZ
	XHSQdjCFeFQTI+AQ==
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
Subject: [PATCH net-next 17/18] rds: Acquire per-CPU pointer within BH disabled section.
Date: Sun,  9 Mar 2025 15:46:52 +0100
Message-ID: <20250309144653.825351-18-bigeasy@linutronix.de>
In-Reply-To: <20250309144653.825351-1-bigeasy@linutronix.de>
References: <20250309144653.825351-1-bigeasy@linutronix.de>
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
2.47.2


