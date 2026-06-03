Return-Path: <linux-rdma+bounces-21665-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4E4uL7HAH2q8pQAAu9opvQ
	(envelope-from <linux-rdma+bounces-21665-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 07:50:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C51FB634625
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 07:50:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=UdSzM+U+;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21665-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21665-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E3EE3042FCF
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 05:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FF23D2FFC;
	Wed,  3 Jun 2026 05:47:07 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC52380FEC;
	Wed,  3 Jun 2026 05:47:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780465627; cv=none; b=t1kDmuK0o6EpJUhOL+B3CqXTZhziZAz5UiCRIJNPSDdffqyXSzsGZuHmt9DRjmJ3TFbd+HIDk7wakvltkSJZnnsQH/cGhIhijU85GaUa4N2wiT7m8rlHrx12sUO2mfy6b6CV5xHjwW8AhgqrhobKwJ/CmVQsXQONWqAIJYgO9R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780465627; c=relaxed/simple;
	bh=/FLTeWNgbJxy3Ry7en1bPUx4V4oTJRJksctul9uRdys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2kuMDdc6Px0YOc7f15hwIjbTqZHagNiWGPdsPAykCe0/8wXdQ65YgCIB6Dq++6Mnc5h7CkTtqj/99eL1cYeAUZVdVb1EdcMh8rAZQ3cETo2YhdKZJVYjT9P3wSUo501VV1s4MOL3x1XjXAzxCGZ3f0z3d2t0oT39a39gLz+iYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UdSzM+U+; arc=none smtp.client-ip=192.198.163.13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780465626; x=1812001626;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/FLTeWNgbJxy3Ry7en1bPUx4V4oTJRJksctul9uRdys=;
  b=UdSzM+U+EplFsOf4XNA2qaf1T+vx6hptvRRxtl/KhEWlhBZ/kK8dx3bR
   UrqnTYgYJXYMDxGJiO/dYI1lCu5ffh8v/0NpwSt3rD9nt3fcOXu/i5OTo
   LIuTRUgM941gZ99qNV7T+yn7tIQk3t9it15PWFw+f9uM2UsB73qGVIXH1
   2k15QiSZGbal2ODtdhaf22a1yruuv0GirdhD7DFk9Ps658MWSMDzWRTuV
   D8Swyx0a++xHMz6ELqXgZwN9p/TrujUI2a1Y27W65P4eJdQs9NAiMtiTX
   8/8bkV42Kypb+ExwUmbLiB5f3A0imYBTi8MiTeLRjY+bLLloEE9zSeQ87
   w==;
X-CSE-ConnectionGUID: 2xudbGA8SI+V1JUMrs9lnA==
X-CSE-MsgGUID: mPRSC03bSjCgzO+gCOE2qA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="83842268"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="83842268"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 22:47:05 -0700
X-CSE-ConnectionGUID: FNlwVWqVTf2houfD4TQfCw==
X-CSE-MsgGUID: WZFOE495REOFrIL2m/+VhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="243966295"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 22:46:59 -0700
Date: Wed, 3 Jun 2026 08:46:57 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Vlastimil Babka <vbabka@kernel.org>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
	linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 1/2] tracing: work around -Wmissing-format-attribute
 warning
Message-ID: <ah-_0aAnev7pHU57@ashevche-desk.local>
References: <20260602150904.2258624-1-arnd@kernel.org>
 <20260603105842.1e0ef8cb4a55cb776d6a4971@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603105842.1e0ef8cb4a55cb776d6a4971@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21665-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mhiramat@kernel.org,m:arnd@kernel.org,m:rostedt@goodmis.org,m:akpm@linux-foundation.org,m:pmladek@suse.com,m:nathan@kernel.org,m:arnd@arndb.de,m:dennis.dalessandro@cornelisnetworks.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:arend.vanspriel@broadcom.com,m:miriam.rachel.korenblit@intel.com,m:mathieu.desnoyers@efficios.com,m:linux@rasmusvillemoes.dk,m:senozhatsky@chromium.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:vbabka@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-trace-kernel@vger.kernel.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andriy.shevchenko@linux.intel.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[kernel.org,goodmis.org,linux-foundation.org,suse.com,arndb.de,cornelisnetworks.com,ziepe.ca,broadcom.com,intel.com,efficios.com,rasmusvillemoes.dk,chromium.org,gmail.com,google.com,vger.kernel.org,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,ashevche-desk.local:mid,linux.intel.com:from_mime,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C51FB634625

On Wed, Jun 03, 2026 at 10:58:42AM +0900, Masami Hiramatsu wrote:
> On Tue,  2 Jun 2026 17:07:05 +0200
> Arnd Bergmann <arnd@kernel.org> wrote:

...

> I think this is a slightly confusing name. What about vsnprintf_nocheck()?

What check? If you want to be more precise: vsnprintf_no_printf_attr() or
vsnprintf_no_format_check(). But they also seem to me not the good choices.
(Just slight preference to the latter one no_format_check.)

-- 
With Best Regards,
Andy Shevchenko



