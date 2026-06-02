Return-Path: <linux-rdma+bounces-21634-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +srEMkopH2oriQAAu9opvQ
	(envelope-from <linux-rdma+bounces-21634-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 21:04:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 303C463147B
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 21:04:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Yo582DSO;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21634-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21634-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B1C43068FF9
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 18:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A9939BFE7;
	Tue,  2 Jun 2026 18:59:15 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19282F39B9;
	Tue,  2 Jun 2026 18:59:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780426755; cv=none; b=ReAvA/Lb2NUtzfKTVD0QQJYAsDY2OAAydWNDJruFhbiw4CLofid0O7v4/HRfOcKM2XlSseQNYyv7b/EYzOCOZ+8Ek8d/mU/ekThs0oUMwS13YdqijMAFzJnkEA30HwIuvEulM8VtWJNcXtwX6xMu4eaLjcCKLWBCMXR1h46yQt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780426755; c=relaxed/simple;
	bh=GvyU1VHG9G0bx3iqtGiPUhz+SeLDv9qe2ZeDnh9OQ+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubTyGfYNVV6TO4A6gd/Qan1h6jGQhOAWn6RkerhOUlNh3Gw99zdQno8XLjj3hG5iWC7+kJjfTML93q6S28APOhcieMKZOyOZDWjw7J4aY9J948IYok8gE6gYq17+eL/9fr+Rz/8Rc9ZlebUegsCvL+aA6pKZ3Vjur9Br3RN5q0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yo582DSO; arc=none smtp.client-ip=198.175.65.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780426753; x=1811962753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GvyU1VHG9G0bx3iqtGiPUhz+SeLDv9qe2ZeDnh9OQ+E=;
  b=Yo582DSOXev/Cy49uul4q2uaLqOBtHFQOJOy7ptHQwkR11paBf8Hk4hg
   aBn6/9iZH0SKBgTta7LDHTMb4rnCYLSPaQyNxLIYsqCQ4CQEDZvSKgIz+
   6FOPrFiAJNUEIPDdSpik59y5OK1Ieu8f4n8mj4WVkMsLwfmncHPksJXx3
   vqfFGgB4MRG/KD1HakJlQj3qv29CBVuOfHLfcsWu39VyAESZnOPyZhiJY
   44h4HzLm5RZZQ6sLCbYEjG/2VWs9C58LrupWJVo+NgyRAN80O7abnltah
   RhbWJniKCm1VCBV1kmwJU8v7BtHumVLnb+0etEGAM1ulHADnu/2/z9+/s
   w==;
X-CSE-ConnectionGUID: 7pyuHn8LSE+T4+g/vrALeA==
X-CSE-MsgGUID: TT1U3Vx6TWaKxMnXDvnPCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="91533739"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="91533739"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 11:59:13 -0700
X-CSE-ConnectionGUID: RQzM3udfSO6EFJ+AdhTWXg==
X-CSE-MsgGUID: NLFQCh7FSO6e1Hvs+jok5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="239543956"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 11:59:07 -0700
Date: Tue, 2 Jun 2026 21:59:04 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
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
Message-ID: <ah8n-Nk305S5hRwN@ashevche-desk.local>
References: <20260602150904.2258624-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602150904.2258624-1-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21634-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:arnd@kernel.org,m:rostedt@goodmis.org,m:mhiramat@kernel.org,m:akpm@linux-foundation.org,m:pmladek@suse.com,m:nathan@kernel.org,m:arnd@arndb.de,m:dennis.dalessandro@cornelisnetworks.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:arend.vanspriel@broadcom.com,m:miriam.rachel.korenblit@intel.com,m:mathieu.desnoyers@efficios.com,m:linux@rasmusvillemoes.dk,m:senozhatsky@chromium.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:vbabka@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-trace-kernel@vger.kernel.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andriy.shevchenko@linux.intel.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[goodmis.org,kernel.org,linux-foundation.org,suse.com,arndb.de,cornelisnetworks.com,ziepe.ca,broadcom.com,intel.com,efficios.com,rasmusvillemoes.dk,chromium.org,gmail.com,google.com,vger.kernel.org,lists.linux.dev];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ashevche-desk.local:mid,intel.com:dkim,linux.intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 303C463147B

On Tue, Jun 02, 2026 at 05:07:05PM +0200, Arnd Bergmann wrote:
> 
> A number of tracing headers turn off -Wsuggest-attribute=format for
> gcc, but they don't turn it off for clang, so the same warning still
> happens on new versions of clang that support the format attribute.
> 
> To avoid duplicating the same thing in each tracing header, as well
> as changing all of them to also turn it off for clang, add a new
> __vsnprintf() helper that is not annotated this way in linux/sprintf.h
> but is defined to work the same way as the regular vsprintf.

vsprintf()

> Aside from tracing, the same thing can be used in va_format(),
> which is part of lib/vsprintf.c itself.

...

> --- a/include/linux/sprintf.h
> +++ b/include/linux/sprintf.h
> @@ -12,6 +12,7 @@ __printf(2, 3) int sprintf(char *buf, const char * fmt, ...);
>  __printf(2, 0) int vsprintf(char *buf, const char *, va_list);
>  __printf(3, 4) int snprintf(char *buf, size_t size, const char *fmt, ...);
>  __printf(3, 0) int vsnprintf(char *buf, size_t size, const char *fmt, va_list args);
> +int __vsnprintf(char *buf, size_t size, const char *fmt, va_list args);

Why the __printf() annotation is in the C file and not here?
Is this all about headers as the second paragraph in the commit message explains?
I would add a comment to explain it here, otherwise we might see false patches to
"make things consistent" in a wrong way.

>  __printf(3, 4) int scnprintf(char *buf, size_t size, const char *fmt, ...);
>  __printf(3, 0) int vscnprintf(char *buf, size_t size, const char *fmt, va_list args);
>  __printf(2, 3) __malloc char *kasprintf(gfp_t gfp, const char *fmt, ...);

-- 
With Best Regards,
Andy Shevchenko



