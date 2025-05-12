Return-Path: <linux-rdma+bounces-10293-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 958D1AB339E
	for <lists+linux-rdma@lfdr.de>; Mon, 12 May 2025 11:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20F941884EF7
	for <lists+linux-rdma@lfdr.de>; Mon, 12 May 2025 09:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6A7268FCC;
	Mon, 12 May 2025 09:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cr2rXb/J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FTaRom8g"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D6E267AF8;
	Mon, 12 May 2025 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042072; cv=none; b=QV8cNHmS+4V5XrbDRDroP99uSKeDq+XBcxPfVGGqN/3vJMi+is01rxMwNbLWHDaUR8ufSL0dN6RGbFqHbm1ylimUJKL1AmdJMufCFcSY39249zd16TXvtQEylyKwIpOcWjk3jW25G8ItCWUWXu+Ra1wTYbPnUsOqg7YAmL6Y/wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042072; c=relaxed/simple;
	bh=i0VNjcCRvdovrY3iCi7sMqjj1HF76Yz/3D8yI+89hSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpmFV70es4+44Ao6LHdMc+KatlWDYu4HfcRTU3iOXcEUc4g0I0vxTAc8eI8kBnQGEjNr6VZiEBTmJmDtTQJpJxHD/grOCgIwwhOP28Ls9w2HP+GPQs+k/McfVjzs9OoG2hLQZ0Kk1m4F/Z3Y/ZfTLGIob4aDgtg/4uIcUkxDFG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cr2rXb/J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FTaRom8g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747042067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nmddc0pDztofvgEdvZvBBZR6kgIdxTlNYioqcelkIOA=;
	b=Cr2rXb/J1M1vlNcxUcQoDLGi6inoIAi8G4DcutFtVCfH9FEQFWF0WGi6lP0Ol2z1+gU4bB
	+a7MyOVz0AOENDbkmMnLzstZmx6fQQeGwxUYLnXDt2it1VklHqfoPcdoyNqiy+CeAOhhEY
	0mmcQeMdY5Um/mdddQQ1rKHpNQmjJAjy+wD9C9wiqZZfjaku5vE6shpGga6hhUT+WYlVot
	r4r/SJFgiPctn4HWNsk8gi3U8z0aZjzAtQCEMlp4ofF6StsDutw1vJ9LKODKCuzjUXLzxD
	pWPgjb9fiP+IVJ4jU3DrTM8RZGAx53PNTDQguhDlziFyMOG6SI35CebDaa3iIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747042067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nmddc0pDztofvgEdvZvBBZR6kgIdxTlNYioqcelkIOA=;
	b=FTaRom8grHttPaogYXo/YJzsiZ18D/D2VtOVbcd2DvxQbFbVEzRuGZW8ZGR2DBrTgbokzr
	DvVyNUhWj/l1ZhDQ==
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
Subject: [PATCH net-next v4 14/15] rds: Acquire per-CPU pointer within BH disabled section
Date: Mon, 12 May 2025 11:27:35 +0200
Message-ID: <20250512092736.229935-15-bigeasy@linutronix.de>
In-Reply-To: <20250512092736.229935-1-bigeasy@linutronix.de>
References: <20250512092736.229935-1-bigeasy@linutronix.de>
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


