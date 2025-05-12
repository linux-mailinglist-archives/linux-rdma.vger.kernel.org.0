Return-Path: <linux-rdma+bounces-10294-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339D9AB3397
	for <lists+linux-rdma@lfdr.de>; Mon, 12 May 2025 11:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48B287ADF14
	for <lists+linux-rdma@lfdr.de>; Mon, 12 May 2025 09:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026D7267B96;
	Mon, 12 May 2025 09:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gdl/QhHT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BZYGo/78"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA35267B84;
	Mon, 12 May 2025 09:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042072; cv=none; b=USd9pzj0hZo/rAM3+uO5aAo3gputup/m5uDWKQU2qoGvm1KtBu60abuwHxww4pj7tj+U6ZXmvkXlVkjTZvTVYGnGsGH+pIxT4TKd0B2KhwEI+qNGq5H7fA3wc8IxrDRicsVsjO5h4YYWPawfJ+EU+h7LKpiJmaLzcqvTTbjbFOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042072; c=relaxed/simple;
	bh=znTzkElG+15BqXoaBmnxoK9Wf2NNmf8iaeTKQhTwaWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3b3sKjhIq6efYqKUUerhzcIjTUyeVoQneFA3WeET8gL1B8pT7Z1R8ahfb5hhXzEy5N19kv5ancubYTRw/5rGz1Qf8vAIxhNU+RaVSU1+rQum9Pl0EJQgT/kkETWsBvH6MvYaUj88Rt9DMIwXYmX/2MkZSB62SvnkRfC0hMI6gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gdl/QhHT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BZYGo/78; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747042068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aD3CNIqIdKGjQEvqGC7xw6ktmCbjt3ZQtV6T8srOrPY=;
	b=gdl/QhHTJ116fRgVaya+11ZdesCHmCazYp9ePDFUR3HhCpDlFk/aEk5oxD4+mCAcx9KV35
	LoDfZxqVqLoWd9AakSNMvZ0u/SI4CFrQXf7O2gM9OYv0ydrPj0ju3hPyVa9nGY4f+e41/g
	z+1F7lYJ4hWyIoUJnuKPE8bYBi7HAL+2XfvMOrmxsWvZp0zlMJI4iiESHUkBiMlY409lf5
	Yn40J7vmhRS059USurjNPq4kC83PfEnFTPGTY87QstP0kWvchaKdgP1Y3bzAKV92PRf6xj
	zat3no9wDTVUJGagfPBKW9UkiS2h3wvcSy9nsBJpfkl0X1ErIOy0oxDRBTMPJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747042068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aD3CNIqIdKGjQEvqGC7xw6ktmCbjt3ZQtV6T8srOrPY=;
	b=BZYGo/78s5EbQQTsYv3HMCxVaTtcYU3ykCJY5Q8XBDhkH7uA7u3vmNmF+OuidQmSn5kuos
	TJoSRSAEkGWaNdAQ==
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
Subject: [PATCH net-next v4 15/15] rds: Use nested-BH locking for rds_page_remainder
Date: Mon, 12 May 2025 11:27:36 +0200
Message-ID: <20250512092736.229935-16-bigeasy@linutronix.de>
In-Reply-To: <20250512092736.229935-1-bigeasy@linutronix.de>
References: <20250512092736.229935-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

rds_page_remainder is a per-CPU variable and relies on disabled BH for its
locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
this data structure requires explicit locking.

Add a local_lock_t to the data structure and use
local_lock_nested_bh() for locking. This change adds only lockdep
coverage and does not alter the functional behaviour for !PREEMPT_RT.

Cc: Allison Henderson <allison.henderson@oracle.com>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/rds/page.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/rds/page.c b/net/rds/page.c
index 58a8548a915a9..afb151eac271c 100644
--- a/net/rds/page.c
+++ b/net/rds/page.c
@@ -40,10 +40,12 @@
 struct rds_page_remainder {
 	struct page	*r_page;
 	unsigned long	r_offset;
+	local_lock_t	bh_lock;
 };
=20
-static
-DEFINE_PER_CPU_SHARED_ALIGNED(struct rds_page_remainder, rds_page_remainde=
rs);
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct rds_page_remainder, rds_page_r=
emainders) =3D {
+	.bh_lock =3D INIT_LOCAL_LOCK(bh_lock),
+};
=20
 /**
  * rds_page_remainder_alloc - build up regions of a message.
@@ -87,6 +89,7 @@ int rds_page_remainder_alloc(struct scatterlist *scat, un=
signed long bytes,
 	}
=20
 	local_bh_disable();
+	local_lock_nested_bh(&rds_page_remainders.bh_lock);
 	rem =3D this_cpu_ptr(&rds_page_remainders);
=20
 	while (1) {
@@ -115,11 +118,13 @@ int rds_page_remainder_alloc(struct scatterlist *scat=
, unsigned long bytes,
 		}
=20
 		/* alloc if there is nothing for us to use */
+		local_unlock_nested_bh(&rds_page_remainders.bh_lock);
 		local_bh_enable();
=20
 		page =3D alloc_page(gfp);
=20
 		local_bh_disable();
+		local_lock_nested_bh(&rds_page_remainders.bh_lock);
 		rem =3D this_cpu_ptr(&rds_page_remainders);
=20
 		if (!page) {
@@ -138,6 +143,7 @@ int rds_page_remainder_alloc(struct scatterlist *scat, =
unsigned long bytes,
 		rem->r_offset =3D 0;
 	}
=20
+	local_unlock_nested_bh(&rds_page_remainders.bh_lock);
 	local_bh_enable();
 out:
 	rdsdebug("bytes %lu ret %d %p %u %u\n", bytes, ret,
--=20
2.49.0


