Return-Path: <linux-rdma+bounces-8512-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D347A58511
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Mar 2025 15:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0033C7A697D
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Mar 2025 14:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05341DE3DC;
	Sun,  9 Mar 2025 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OACsY6l9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ix7/O3Cy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0DA1E98F8;
	Sun,  9 Mar 2025 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741531638; cv=none; b=FH69F8/E7KTHTPA954BuvzCc2dI/svc8rEnshOrVsWSaruYclU207towOKKdptgmz/SNJ63bFGiCNnTJTtYZCPu3MYSzfxkQEkruWiGjDwi3xzwwcYW/YR3iw2ejVaGC4HxPzmFlG64iE6ZiaomRqnrVFeGauZmK8Qd1Mln2lvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741531638; c=relaxed/simple;
	bh=EM/uznQ2YZTtHd2PJqyOgtHEa7X0gpcWflzaAAZAoes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1Cl7A+HpEhSzisCR40nwovk3YxWIPMQHWHznhhDCW7aIVEwZ+TxB3TSqWhVmIZjnkBQH7CUVxtBoahIhFxu47FBdQxjMwUtUvKZOkSkoUaoDwjLW0nwq4tIqde1nWqB17M4P0XeskMN8SuC61+Bv6X3+Ze4x+1sUBTIvcP2CGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OACsY6l9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ix7/O3Cy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741531633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ILRU884p1OAoaunx4VDmaSDgJgpHGl18bni0vDofXnE=;
	b=OACsY6l9XCBNmnz8p2IxMspoNEZ+22tc4fkJIUoq8KCksZe+eu5ShFI6kD2CPfOjZ8z6Z7
	zi0gr988bG9nd1r8vjnAjEfSpkPsFdWH2k8aDtQUocAZrlky7tdsY1Y0Kbur2GF63PPbay
	lyXXgBa4tsQ2tQ9kz4XJhT5Uoximfli4JMRLi7fVt4iyoe/9WRiveVwhECk9Qlj01btE24
	gXxBhcMeWZ0fMOnbhKnsGFyrym1qP/5xqFMiZHNgFMwffLNZ/kR4+Wd63z6m5Wa693J9se
	B6DDduKN+lZX/ejgIyHrgnrGTCvFM9esUPWzMQceX34PKp/efy66b3KFHhUYpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741531633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ILRU884p1OAoaunx4VDmaSDgJgpHGl18bni0vDofXnE=;
	b=Ix7/O3CyoYpZV7DwZk0ANGxA/wE9TXlnVQP3wfC3y5a0xK+i8ISaBE5PoyXK/0tIVlumix
	e9lpnZtl2Yx2ZXBQ==
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
Subject: [PATCH net-next 18/18] rds: Use nested-BH locking for rds_page_remainder.
Date: Sun,  9 Mar 2025 15:46:53 +0100
Message-ID: <20250309144653.825351-19-bigeasy@linutronix.de>
In-Reply-To: <20250309144653.825351-1-bigeasy@linutronix.de>
References: <20250309144653.825351-1-bigeasy@linutronix.de>
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
2.47.2


