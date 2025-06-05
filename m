Return-Path: <linux-rdma+bounces-11011-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D908EACE9C7
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Jun 2025 08:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3953116A7E0
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Jun 2025 06:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4915F1E8348;
	Thu,  5 Jun 2025 06:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yhNiMwGK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t+p8jzgb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7151E1FC8;
	Thu,  5 Jun 2025 06:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749103664; cv=none; b=HXzqH/Rz9J+Is0X02mcQmeCXxb5j5tK0+wh/+gSAzdWBjkUtoUL250TjNdmdBNdGxG/m3rovaPOiwqFbZvFwAs6r+9wGcFYnV/2xp8Mq/b/mnZoMZA8WH7MCFk2P+ei+qtai7NEXK6/aJEJw2pbLvYGZaLBkrVFdAxssZe/xdls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749103664; c=relaxed/simple;
	bh=+uBO42iXZqtDYIQMA9gA6/zv4IsrwRUl3RAt4NSUZlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pI/D2d8kU9yO5HTicS5xYTTMuMx6h2BlgDyAmrTZaWgd4QwbYqxFj3ac3lVOgxJMPeaxNUtzt8i9OzWbC0bL17w6lS6Y+VhetD2SjkO3va2q0uC8T+MHO2rU9TR+aUj3NLT8cg8JXY/EJHH/qM2opR78GDhOakT68+JNGHBNBhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yhNiMwGK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t+p8jzgb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 5 Jun 2025 08:07:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749103660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8HZ71isqmSlxdQ2pUqhCUqFJFnnu4E61MVtczgwOP6Q=;
	b=yhNiMwGKmUXfkBKAQLXO/d3mTwEE3QnYl4xV5r+GwmyOgacZhEdCH7UCbTWj+WIOfYhk7o
	gMraDmikgcjndOHfvnKxjxPOaTbfnnyN2P8T2/SaoLlq8pKh8Hp5+BDOBXkPnVhAPxsxH0
	sxK6rmYkHRbOPKejL8DCcCzBE8tHNjquvrFCIxCrVTdpX7lp/zVRECytzKf7oGfji/aeYW
	e5lNKkifBjnHRKlop2T3odJ7zO5va2eIdPb5hny7XhhWUatVJi2kKA/Ix4305mWU9nODAw
	kVD6s8qRcaMxsSAs387s0Xr3jdXVnt/Vb18P9nt/OtaIzh0FFxajK8AFrdfWPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749103660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8HZ71isqmSlxdQ2pUqhCUqFJFnnu4E61MVtczgwOP6Q=;
	b=t+p8jzgbDKKet5/oPbEz5/zhqjCZj2Q3KQu7QZtaWafXE22DK5hbl4cjUZPD8GgwU2y4rb
	fgWZI2jQ5RTsTmBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-modules@vger.kernel.org
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Allison Henderson <allison.henderson@oracle.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com, Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2] module: Make sure relocations are applied to the per-CPU
 section
Message-ID: <20250605060738.SzA3UESe@linutronix.de>
References: <202506041623.e45e4f7d-lkp@intel.com>
 <20250604152707.CieD9tN0@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250604152707.CieD9tN0@linutronix.de>

The per-CPU data section is handled differently than the other sections.
The memory allocations requires a special __percpu pointer and then the
section is copied into the view of each CPU. Therefore the SHF_ALLOC
flag is removed to ensure move_module() skips it.

Later, relocations are applied and apply_relocations() skips sections
without SHF_ALLOC because they have not been copied. This also skips the
per-CPU data section.
The missing relocations result in a NULL pointer on x86-64 and very
small values on x86-32. This results in a crash because it is not
skipped like NULL pointer would and can't be dereferenced.

Such an assignment happens during static per-CPU lock initialisation
with lockdep enabled.

Add the SHF_ALLOC flag back for the per-CPU section (if found) after
move_module().

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202506041623.e45e4f7d-lkp@intel.com
Fixes: 8d8022e8aba85 ("module: do percpu allocation after uniqueness check.=
  No, really!")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1=E2=80=A6v2: https://lore.kernel.org/all/20250604152707.CieD9tN0@linutron=
ix.de/
  - Add the flag back only on SMP if the per-CPU section was found.

 kernel/module/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 5c6ab20240a6d..4f6554dedf8ea 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2816,6 +2816,10 @@ static struct module *layout_and_allocate(struct loa=
d_info *info, int flags)
 	if (err)
 		return ERR_PTR(err);
=20
+	/* Add SHF_ALLOC back so that relocations are applied. */
+	if (IS_ENABLED(CONFIG_SMP) && info->index.pcpu)
+		info->sechdrs[info->index.pcpu].sh_flags |=3D SHF_ALLOC;
+
 	/* Module has been copied to its final place now: return it. */
 	mod =3D (void *)info->sechdrs[info->index.mod].sh_addr;
 	kmemleak_load_module(mod, info);
--=20
2.49.0


