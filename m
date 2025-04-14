Return-Path: <linux-rdma+bounces-9412-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BC0A8881A
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 18:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DB80162AB6
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 16:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E87328A1DD;
	Mon, 14 Apr 2025 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XeEdGD5Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S1e8lcqC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A941F28468F;
	Mon, 14 Apr 2025 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744646900; cv=none; b=fj/g2K00RsjnaQFOJCUTtH9Lln/cSjORMQqJmbqNNK+r3Ysjv1C9D7Fs7lvnNCsPMrdETU53ix3xnfJ4uSS+0Sc9pY3+HFF2L6gGrD3Tj2pYB2upgYSEBOOhuPWQ1hvMMoS8pvjG+sUDpzBC+dzF8LluoJ7L7IjBtZh1n3M898g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744646900; c=relaxed/simple;
	bh=znTzkElG+15BqXoaBmnxoK9Wf2NNmf8iaeTKQhTwaWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZo1tGhsznYEMHWT88wbr3OcxhmhcJiIifpTutHlWLCAnBXp1R1oqyZkEcUNOwvaS/PCawGGjUz9+AT5vE2LsTMbXpdlAOYvSjTc6uzBWXTTZT0TwhvvQq2/1QaV8LLUgM6CwKOM3a2Laeuz7qyc5j2hUVkF+4lPqpp/xzrJjn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XeEdGD5Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S1e8lcqC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744646895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aD3CNIqIdKGjQEvqGC7xw6ktmCbjt3ZQtV6T8srOrPY=;
	b=XeEdGD5Y/VOxosQ72ZO5iuHDekthUpf/fsaoy6pRjvVi1hx57pTiaVrSh1oBdvzQwugDUK
	awDIKifwsPiEIXcW234DdoHoDuPMf/qEgPf+iN6yMkzar6x1mgd0cawhIEDhgxjg+xyFN8
	so0XjfI+X7JqotccKNvoISCgcvQcM+SBLt3/fyy3puTBMnJ1uq+qjiYnL2qNJa9vcFQgzZ
	WVeK3Enq+UGjM05qgkl7kb1MCrDRCwhhPghETSzoGDBebCTr78mFoQetiGDMxDBqLzm8xS
	Q3lsbnMlkVPxZe2Cgl/v11EMV0SK4BDxz9A9ZUOuWCsbFQW2hda3RDleZ2GwGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744646895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aD3CNIqIdKGjQEvqGC7xw6ktmCbjt3ZQtV6T8srOrPY=;
	b=S1e8lcqC50em4bGFDAptPTuBr6ww+Fca/f/jbFvNvlF8p+bqhcLn/Pi95G9iJCdqW1KKz7
	Nz7IcuAC5p8oSaBA==
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
Subject: [PATCH net-next v2 18/18] rds: Use nested-BH locking for rds_page_remainder
Date: Mon, 14 Apr 2025 18:07:54 +0200
Message-ID: <20250414160754.503321-19-bigeasy@linutronix.de>
In-Reply-To: <20250414160754.503321-1-bigeasy@linutronix.de>
References: <20250414160754.503321-1-bigeasy@linutronix.de>
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


