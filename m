Return-Path: <linux-rdma+bounces-9413-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EB7A8881D
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 18:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706A3162E1F
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 16:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7324728A1E9;
	Mon, 14 Apr 2025 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dBrWaBKO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tPTXMfDd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A484C288C8E;
	Mon, 14 Apr 2025 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744646900; cv=none; b=ErcP3Tlt4CtiRPesenVO89O0B01veSmRksXw2DnWgHNrzcrJW7g4PFq12YdUvcXc5wmAVUCNY6zVa8UzOz2mfkqtTcT+TFxRG+/CyIfSVvtHsXni7zpOB2HtxrIUUJmxYOyXt8DHpSeC7uBIZ1oqCAsukax2oSM08aZ7qCRX378=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744646900; c=relaxed/simple;
	bh=i0VNjcCRvdovrY3iCi7sMqjj1HF76Yz/3D8yI+89hSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNin57iSs0Wkd/sSGc1Ajm+/jKqeCNEFIvVO1ExldPBYZiH53o/kfxnEdPCNLYkMBntFy7V4bMFmSvNapXxbj3S6kLVo0HJx58eqlNUOjUaftzh/3SpsinQ/uS4YqRsJR4W6hgRlw3w+wEnzT7CjjapBqqshxegY3xoufPyEydo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dBrWaBKO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tPTXMfDd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744646895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nmddc0pDztofvgEdvZvBBZR6kgIdxTlNYioqcelkIOA=;
	b=dBrWaBKOvIfDOKydkAX1TjXnLLAXGfZKl4h601pm66oyAaU2ezBPCNTNu4NPyNU+xOMA6J
	D91mFnuA53jzRr+ja1xZBLXQ4fzWAAodLVnq2J5ZmiUGHXpEbXp2wYd4m4cKQgCn2q40ZS
	VW0us5jMkX5hZrk4kLFbMBcsslKOWMYe+X5cvzhLfyw2mMfZ6KFRxTOxBnX7ZXI8IO0Y6T
	1hXDH2FX7P1EwjZnyAf39x8e8650Uxhd8RCmOHRaUMwUFZp0lrXPzTe3IbyziICAhhraoZ
	IcABUe+PMIBzpmCfJA4UEQ2gNe4PHe7VLAkOhYFhu0OoIJASwX9W96LsQnuRrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744646895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nmddc0pDztofvgEdvZvBBZR6kgIdxTlNYioqcelkIOA=;
	b=tPTXMfDd3yTeGRXen6UR0X3vF4P4U0KQXBg7CWwG6FnA4+V/rL8bYdb4Qx94jitZW5xxFY
	k/mEK8GfKnx0NoBg==
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
Subject: [PATCH net-next v2 17/18] rds: Acquire per-CPU pointer within BH disabled section
Date: Mon, 14 Apr 2025 18:07:53 +0200
Message-ID: <20250414160754.503321-18-bigeasy@linutronix.de>
In-Reply-To: <20250414160754.503321-1-bigeasy@linutronix.de>
References: <20250414160754.503321-1-bigeasy@linutronix.de>
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


