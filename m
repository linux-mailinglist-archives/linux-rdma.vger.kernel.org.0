Return-Path: <linux-rdma+bounces-11135-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4469EAD3BCA
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 16:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF81D7AF85F
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 14:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B93227EBF;
	Tue, 10 Jun 2025 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RkpO86n5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nAPd5syc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A01225401;
	Tue, 10 Jun 2025 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749567307; cv=none; b=YiYIDsbHWDMoV+frnScOXRUPgDnZYblxP+auLjD+GQTqr3Mw+m2ISGbFypiYb6BzLTdJlYHgV48y+xoU7yjMD2yPdDBBVOeEQXkDedMKx3Tizam4R5CDGrxotkYgkFwre8GWt0GrbLNMpVVJr8XoEDGbzClHemCG5bObBmw3SJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749567307; c=relaxed/simple;
	bh=TCX0wkhqXCtxiEslMElVI0Emjw27obpJkgDoehIUjjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1D/35hzZItJwG3lAP8xs1AePUsMTxYA6nEbQSisZTD+fK8yyMpjOhow1d9DHWDG7tfQYoyXy5TeFho+rheXVNe0nZsqJ1rRMJaB30K+lHm0vQlU9T2yIL/Rw0rJ+Eenz6Gt4nNe8FoPpRBJveGAw+Me+f5Km8jbyF9ewveplS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RkpO86n5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nAPd5syc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Jun 2025 16:55:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749567303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FnfSL/Q+geUYm0gs5LtGzgbvVp4Bsbwi6KwH+8AqyAQ=;
	b=RkpO86n5QeaUXSi38RzuWeVW0p8PohIPR7ssF2KT74V55AG/Ct3NpKsCGSyiZMTTLgzOzR
	fUTsZpxpdbDBlw7y/epCihkPPN1S8O/JZTv4Y/nCMk49uDNIT2pCMeALgZGxdivuZDGryY
	szLdmYJY2u4vPHK6iXoYd50tBrpZdYWRAA1oKkTaoM0RdjgAJX1myypWy6Q2VO6T6sWti3
	yHrq+bYFSKDtcjQ2oUlekoH84lG1/0KpOzkRzIJraV0+WEKgoHTqNerC3EL8YeE3iX4HaG
	8Dc2gWKeYuFCTF9w+9OZfsp5alNTxzpn0La4LbcYgEAdLVNwA5CGAKLXfb1ifQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749567303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FnfSL/Q+geUYm0gs5LtGzgbvVp4Bsbwi6KwH+8AqyAQ=;
	b=nAPd5syc3qvYrK5iEzIypjkkmgISno/Kclc4XZw21QV2bpgX1BYn29lss3cxOQ4/qzfm5z
	3nRYyEy6H9u0v2Cg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-modules@vger.kernel.org, oe-lkp@lists.linux.dev, lkp@intel.com,
	linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Allison Henderson <allison.henderson@oracle.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com, Luis Chamberlain <mcgrof@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] module: Make sure relocations are applied to the
 per-CPU section
Message-ID: <20250610145502.pA_kA7GU@linutronix.de>
References: <202506041623.e45e4f7d-lkp@intel.com>
 <20250604152707.CieD9tN0@linutronix.de>
 <20250605060738.SzA3UESe@linutronix.de>
 <beb343ec-6349-4f9c-9fea-588b04eb49ee@suse.com>
 <20250605155405.3BiTtQej@linutronix.de>
 <6a770057-2076-4523-9c98-5ff10ac3562f@suse.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6a770057-2076-4523-9c98-5ff10ac3562f@suse.com>

On 2025-06-05 18:50:27 [+0200], Petr Pavlu wrote:
> On 6/5/25 5:54 PM, Sebastian Andrzej Siewior wrote:
> > On 2025-06-05 15:44:23 [+0200], Petr Pavlu wrote:
> >> Isn't this broken earlier by "Don't relocate non-allocated regions in modules."
> >> (pre-Git, [1])?
> > 
> > Looking further back into the history, we have
> > 	21af2f0289dea ("[PATCH] per-cpu support inside modules (minimal)")
> > 
> > which does
> > 
> > +       if (pcpuindex) {
> > +               /* We have a special allocation for this section. */
> > +               mod->percpu = percpu_modalloc(sechdrs[pcpuindex].sh_size,
> > +                                             sechdrs[pcpuindex].sh_addralign);
> > +               if (!mod->percpu) {
> > +                       err = -ENOMEM;
> > +                       goto free_mod;
> > +               }
> > +               sechdrs[pcpuindex].sh_flags &= ~(unsigned long)SHF_ALLOC;
> > +       }
> > 
> > so this looks like the origin.
> 
> This patch added the initial per-cpu support for modules. The relocation
> handling at that point appears correct to me. I think it's the mentioned patch
> "Don't relocate non-allocated regions in modules" that broke it.

Ach, it ignores that bit. Okay then.

> It seems logical to me that the SHF_ALLOC flag is removed for the percpu section
> since it isn't directly allocated by the regular process. This is consistent
> with what the module loader does in other similar cases. I could also understand
> keeping the flag and explicitly skipping the layout and allocate process for the
> section. However, adjusting the flag back and forth to trigger the right code
> paths in between seems fragile to me and harder to maintain if we need to
> shuffle things around in the future.

Okay. Let me add this exception later on instead of adding the bit back.

Sebastian

