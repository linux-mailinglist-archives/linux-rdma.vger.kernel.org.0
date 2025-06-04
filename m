Return-Path: <linux-rdma+bounces-10982-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FB6ACE170
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 17:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247A4163C8C
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 15:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83541C84AB;
	Wed,  4 Jun 2025 15:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="34Q7dwG4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YpY9q+Q6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E0B1953BB;
	Wed,  4 Jun 2025 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749050832; cv=none; b=SebTGB7sr6PxRXkHA/zQHSgh/ugnXr7vRkNCOyurENmM4Rs6TYADH1VMYoZP/eHCb3EmXgJ9pq/JaWC0LVcyC99TD91/brdvguAhyYf+hsRcOZ2dOkKit7xmeSQ0hMAHsR3THhDQ6ZYtqBnwq/NDgynM4lfW/OyXsnxuXIBBgRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749050832; c=relaxed/simple;
	bh=ECBw3mcegDKUHOLSOkINmT0psmeYZUxNdiRS0riunZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZ6EEJFWBPx2X9BpSN5a7ji1mMKlswjB6SsrMTegP0slKcxp/z/av5raWAkucQybjnpS2BFzUAPZItWpB3P3Vs78z+f8Ou3B49M7LocJsv+y9MbxKqdGa8fXr8KuSMNvSlJnEYTQ+Kd9HCVQRTZLvN2Mf1Ruqkq4cK+v3hV9iDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=34Q7dwG4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YpY9q+Q6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 4 Jun 2025 17:27:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749050829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KeczW7bWlrnXwwKkhxyWJXZmEyyc0PgR7tMYRMUOC6I=;
	b=34Q7dwG4LxD4q21PPvVoIzD3+E69BsgoN/OBVM3uCHFuMo6TtTovefwoogy9xK7FXCyyY3
	NO9stWBO8jpUM3OhReD5Jq8Dfr8E05aGAdrzx2JKgF5FjXsAt7z8GuNVZqpphi9pofgmsm
	voihIm2NFF3iFuq3EQcJ+2JgT8WGKb/ThSJiVut4k/dqR7foSWF5acrrkw7vlii4k+Boe/
	aqe/5/Eh9BRrbxA+Q9ODz/YFnGeBydNi9MuZsMNNhAOG5Vd0J6jOE7P6d1DHui5PLCaEMP
	W20IXFmeUiAQIthDnr88Z7Wr2L5ZuJe6TzcjSXocJjah8GN0O+V+sc7IUd0Vgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749050829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KeczW7bWlrnXwwKkhxyWJXZmEyyc0PgR7tMYRMUOC6I=;
	b=YpY9q+Q6UGXz9kl8L+b9cC1SlKw7LULJmhHnZ4iD8pQxAMJ4TPc1zScPQ3/9UTTHoCuEQE
	IKZGrmrYMtn8LRBA==
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
Subject: [PATCH] module: Make sure relocations are applied to the per-CPU
 section
Message-ID: <20250604152707.CieD9tN0@linutronix.de>
References: <202506041623.e45e4f7d-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202506041623.e45e4f7d-lkp@intel.com>

The per-CPU data section is handled differently than the other sections.
The memory allocations requires a special __percpu pointer and then the
section is copied into the view of each CPU. Therefore the SHF_ALLOC
flag is removed to ensure move_module() skips it.

Later, relocations are applied and apply_relocations() skips sections
without SHF_ALLOC because they have not been copied. This also skips the
per-CPU data section.

The missing relocations result in a NULL pointer on x86-64 and very
small values on x86-32. This results in a crash because it is not
skipped like NULL pointer would and it can't be dereferenced.

Such an assignment happens during compile time per-CPU lock
initialisation with lockdep enabled.

Add the SHF_ALLOC flag back for the per-CPU section after move_module().

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202506041623.e45e4f7d-lkp@intel.com
Fixes: 8d8022e8aba85 ("module: do percpu allocation after uniqueness check.  No, really!")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/module/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 5c6ab20240a6d..35abb5f13d7dc 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2816,6 +2816,9 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
 	if (err)
 		return ERR_PTR(err);
 
+	/* Add SHF_ALLOC back so that relocations are applied. */
+	info->sechdrs[info->index.pcpu].sh_flags |= SHF_ALLOC;
+
 	/* Module has been copied to its final place now: return it. */
 	mod = (void *)info->sechdrs[info->index.mod].sh_addr;
 	kmemleak_load_module(mod, info);
-- 
2.49.0


