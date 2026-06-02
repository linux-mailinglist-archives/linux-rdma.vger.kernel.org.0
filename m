Return-Path: <linux-rdma+bounces-21646-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wnzhMBhAH2qkjAAAu9opvQ
	(envelope-from <linux-rdma+bounces-21646-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 22:42:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21237631D39
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 22:42:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arndb.de header.s=fm3 header.b=EaAWwa7i;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="h PaaIjz";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21646-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21646-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arndb.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B48E30B2981
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 20:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9938F377560;
	Tue,  2 Jun 2026 20:32:49 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D397F34F46D;
	Tue,  2 Jun 2026 20:32:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780432369; cv=none; b=prqi5L0R36504WW9Xe1E88A8tTkQlLHUkG0tJ87vyZ6qi5Tk3Kvruc+/3ST4Zpn4GP/GgedsyNFhISAWhSCHxO0r7o2/hHzVOi+LC0Ana89XUjnibBu9LKoj8zf6KXo4ThxeGW+BwXKob91oD3DTNmZRQozp1+/5p9YI0jyEEoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780432369; c=relaxed/simple;
	bh=P0QnsQoLM1byQG+q9EIQ+vv+d1oecWA4HDzYJ87Pet0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hDeJHOkuAuomB4GFd8eWyCK2nl/HeiA9DykmFM+l9nKIGnVNGCHSNYa8nWAxK2JsN8AJEFUXlNXuUJ5BkGKJHOrJ6O39IbcZEfR3QTq+jJzdO5PT0hU2NFtPNCwExMD7OTFuKHVVBlm0X+DQ+vLpKabTDG4I9tgeaUXXNXhf60M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=EaAWwa7i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hPaaIjzP; arc=none smtp.client-ip=202.12.124.159
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 483087A00D5;
	Tue,  2 Jun 2026 16:32:46 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Tue, 02 Jun 2026 16:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780432365;
	 x=1780518765; bh=4UlQlg6gKVDMsOvjIMppFn4eB9CwfNHEg4isd2yLNAo=; b=
	EaAWwa7ik8uVsjTW/TPS/vlliARiqvx4v70djSPDhd1pOVysfvVt75qSUIjkQEOK
	t+MmYz1LHITxN+nR1Ca0fpgBvB/C3tgXWrymoaURNTIATf83c1aKCYpJFopU8i83
	v7ev7sWWcLExMaXKqHB0bkL+FpzmKVBdI8u7lWnk7krvrbDhwvMHUVhcT4i+xN8Y
	E2SWiu8KqBgAv15jv9e6g8cgGk7xLe8eEqnk0aoDKx2MTL5yPxnFvCzJgAIK7nEd
	hIDPL6eNervpJOQ7TJQEbeYdA+dsLpeK+sV96EfRXTrFn7uCFWrTP/wwB19jhU+s
	sSQV72TCubcYO1nK2cyv8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780432365; x=
	1780518765; bh=4UlQlg6gKVDMsOvjIMppFn4eB9CwfNHEg4isd2yLNAo=; b=h
	PaaIjzPPdHVd0NY7qH8fLxubQaFQkdTETi1kZaHcZ0eFZr0SBcePswvIK5n90Uwn
	mTYICs8JbXY+g02+fRUbueJcrZPPdpoj1D3QjRbd8t1LOyYbtBDIkbCyXrXeQtm0
	dtW4OaZuUGozPP66DU5tQFZ8Gmc+dOEi2qKbTGYwHeKS1ofsr45xqAsQRGWdCRJE
	FppRNYjoVw2FxfXsOlTKVwFk2Y70B5E2/CaS+HIRmgWCDua/gGveOjZ5OhJNzgV5
	5qpY5gp0uawZ7K6kJgUNqsN5HK5bCEakfbQNVcP9Hl4kgWOsJozE0p5xQ/RMBZz3
	7KQaBT5yOv2F2IWne+lMw==
X-ME-Sender: <xms:7T0fal4Ck-gzdJepFviNmCp6eVKCsXpV4UwZfGPB9xEg5r14gyBOGg>
    <xme:7T0fattJ76hXySIouALPEh009cTXGCQgm-fyzI1bi3Lf_RyMVhgFNlWaxesi2kddn
    QZoykqmEpa3y8b3Z3fD1AdqdDmCWkMyzvmzg3gzlQdyz5MNcJVOXqI>
X-ME-Proxy-Cause: dmFkZTEbT3rTfYi+vpP8FbosnWdIu2cFkNGLW2kCrAoj5RsFDYzRvapGzBAAtzUtEeWzH5
    tDnth4/5ICTMBFAHra5UAfRhotP9Up7aq5ScKIJ7fBJQbZxnaISDNoyfNhBlNzmBP9sPB9
    QBCyGolarJftIvzLOJRpMOA6EtNZea1sW+oRk/SL91YaR+HymtQVF03gR3G8HDQbEZL8kC
    tC8Tu8KmFlQ5gUp96MgTrr4qJM9ZgGj6RMOtqEnVzT2eVWIgA0G7XrNQcrtOvxHGErBP9G
    ZcRR3DRvFASweZ7QZOOzC2HNoV1M1vSzizXIZzipkkNYazVBwdsznkuV5jCcKgZ0xxzFtD
    HGphW3yWYQsbWkpsmJ/B86ET1kxPnGRd0lWsg+sWN0UcbgQbCMehvKEKlqUzWcKfmxFHh6
    lAwRV+cnGWaCofv0ZBBV6MNzknF9fjZPXLON/feonEDSgvYDWEnDPxWE/EvEBqRSZ9OS49
    5P8D4MLeKIVE6SynT9aiQsigIuj3zskfKzHscNxr0a9wW0pvXixV+cgRru6HNX6JDxpae+
    EidVXUorJxtN/mM/Dkbo+rd3eQ++H1iptdIkYPp/V+hGqwtc7xZN4Inxn9lwmwXlxNKinZ
    WGEYmWN8N4BnzNWQSpW+qJDQdJ5CUDKfAQlnu+rn1WQ99AAQ5x1I1WnptWOg
X-ME-Proxy: <xmx:7T0faj46jJFMwWOa3-4Au_q_h-Njz8nb1YuWcnGAdIjy6k1jm_woqg>
    <xmx:7T0faiOyjlv1U9IfNf8iroN6ZkQvmRMXYFRg5ffxIYSMsN8InQwTnQ>
    <xmx:7T0faie04gvwpej-HGtnSoQOAWLYYH20taUetybn_YO3ihbx5fYBtQ>
    <xmx:7T0fat0dZefDvcQ6ZTLTXvGyaFKutgkpExbk0OIfM_FaDKAlvmgsVA>
    <xmx:7T0fakbW6oUHo1pfD5PmAlm66E44ZL14F13V1WJ0FIXETP6lSNl-cg_O>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2542F182007E; Tue,  2 Jun 2026 16:32:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AAuCPBQLA6as
Date: Tue, 02 Jun 2026 22:32:04 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Petr Mladek" <pmladek@suse.com>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Dennis Dalessandro" <dennis.dalessandro@cornelisnetworks.com>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Leon Romanovsky" <leon@kernel.org>,
 "Arend van Spriel" <arend.vanspriel@broadcom.com>,
 "Miri Korenblit" <miriam.rachel.korenblit@intel.com>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>,
 "Justin Stitt" <justinstitt@google.com>,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev
Message-Id: <35c1ba62-e74d-4abc-aa73-ccd35968ff89@app.fastmail.com>
In-Reply-To: <ah8n-Nk305S5hRwN@ashevche-desk.local>
References: <20260602150904.2258624-1-arnd@kernel.org>
 <ah8n-Nk305S5hRwN@ashevche-desk.local>
Subject: Re: [PATCH 1/2] tracing: work around -Wmissing-format-attribute warning
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21646-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:andriy.shevchenko@linux.intel.com,m:arnd@kernel.org,m:rostedt@goodmis.org,m:mhiramat@kernel.org,m:akpm@linux-foundation.org,m:pmladek@suse.com,m:nathan@kernel.org,m:dennis.dalessandro@cornelisnetworks.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:arend.vanspriel@broadcom.com,m:miriam.rachel.korenblit@intel.com,m:mathieu.desnoyers@efficios.com,m:linux@rasmusvillemoes.dk,m:senozhatsky@chromium.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:vbabka@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-trace-kernel@vger.kernel.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[arnd@arndb.de,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[goodmis.org,kernel.org,linux-foundation.org,suse.com,cornelisnetworks.com,ziepe.ca,broadcom.com,intel.com,efficios.com,rasmusvillemoes.dk,chromium.org,gmail.com,google.com,vger.kernel.org,lists.linux.dev];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,lkml];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,messagingengine.com:dkim,arndb.de:from_mime,arndb.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21237631D39

On Tue, Jun 2, 2026, at 20:59, Andy Shevchenko wrote:
> On Tue, Jun 02, 2026 at 05:07:05PM +0200, Arnd Bergmann wrote:
>> 
>> A number of tracing headers turn off -Wsuggest-attribute=format for
>> gcc, but they don't turn it off for clang, so the same warning still
>> happens on new versions of clang that support the format attribute.
>> 
>> To avoid duplicating the same thing in each tracing header, as well
>> as changing all of them to also turn it off for clang, add a new
>> __vsnprintf() helper that is not annotated this way in linux/sprintf.h
>> but is defined to work the same way as the regular vsprintf.
>
> vsprintf()

Fixed now

> Why the __printf() annotation is in the C file and not here?
> Is this all about headers as the second paragraph in the commit message 
> explains?
> I would add a comment to explain it here, otherwise we might see false 
> patches to "make things consistent" in a wrong way.

I've tried to come up with a kerneldoc comment now, similar to
the one for the vsnprintf() function, and added a separate prototype
in the header. Does this address your concern?

      Arnd

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3caf0796f54d..7c696aea2ed3 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2975,7 +2975,23 @@ int vsnprintf(char *buf, size_t size, const char *fmt_str, va_list args)
 }
 EXPORT_SYMBOL(vsnprintf);
 
-int __printf(3, 0) __vsnprintf(char *buf, size_t size, const char *fmt_str, va_list args)
+/**
+ * __vsnprintf - vsnprintf() wrapper without __printf() attribute
+ * @buf: The buffer to place the result into
+ * @size: The size of the buffer, including the trailing null space
+ * @fmt_str: The format string to use
+ * @args: Arguments for the format string
+ *
+ * This has the exact same behavior as vsnprintf() but can be used in call
+ * sites that are missing a __printf() annotation, e.g. because they
+ * get a 'va_format' argument instead of format and varargs.
+ *
+ * For this to work, the attribute is added to the declaration here but
+ * not in the header.
+ */
+int __printf(3, 0) __vsnprintf(char *buf, size_t size, const char *fmt_str, va_list args);
+
+int __vsnprintf(char *buf, size_t size, const char *fmt_str, va_list args)
 {
 	return vsnprintf(buf, size, fmt_str, args);
 }

