Return-Path: <linux-rdma+bounces-21672-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cxXkH2XqH2pusQAAu9opvQ
	(envelope-from <linux-rdma+bounces-21672-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 10:48:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 528CA635DAC
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 10:48:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arndb.de header.s=fm3 header.b=QLTxwh4l;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="R F/jcWn";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21672-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21672-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arndb.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CC58330C37B0
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 08:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F6D426ED3;
	Wed,  3 Jun 2026 08:42:03 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F36C426D1E;
	Wed,  3 Jun 2026 08:42:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780476123; cv=none; b=Ocn3MXHmK7c4Is1B0eOmArRvlAp7u+Ti9yowdD0IOyUUgJfgX7GL58dq7ArpO1wy+xSkwqe6jWu3uuvaRYDlZMNIJ3Dhk9E4vLZleavnfNgHl0A6+fAa+E9PsFcdnWYWrkKMTLRFMBUY5tRKSW3OZUBiX00RXjqPmO/ptFGSxWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780476123; c=relaxed/simple;
	bh=WuDGrJLK9bzLaWzEe07dlHOYpZOb3lGL1ZcgVnTyKmM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=h959XtZkbQFPqPHerElto8K4RhfJpVwrfu/qv6TC8ky/kQM7TaQwheemyMoLlpEhTlI2LHYPL1TWZXRTmKlqtx+3nBGZkkDeIJQd3ZZIIIVFczVy7HJ7TjxaHGF/D3MCMvWMgczzVME8NyoH065fBhqSzsYnrCiaz9n7cQaG12E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=QLTxwh4l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RF/jcWn2; arc=none smtp.client-ip=103.168.172.150
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 413AEEC00B5;
	Wed,  3 Jun 2026 04:42:00 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Wed, 03 Jun 2026 04:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780476120;
	 x=1780562520; bh=vVyiUH+m+c0Pw2AXcQyAOjRt3bx8/ecnoqePaItRyK0=; b=
	QLTxwh4lLgLUduSsXf/btg/XCNzjHPocI9s/J4PwyHqzW2KUi9omEpP8nWXaqkLY
	vfQM4k+YTmxgrspvnxSjLK3gFQ8pJBkni92TeVqX69TTTlwOYweC0AiN1MDCSQtQ
	X5areN9F+ra9iPSljD6T7XNrmehuILm3FYM4VCwTA1iV7fmdTmIGVJIFVgVhzZOE
	KpPd9hBTJtUR/OBoxxm44nfiRUzJixB1SeWaw2oF1CnxrgP6Wk3m/t7QCLw66XaW
	S6KwdZlUpMHgtY7vhAX+t23bDCBPeePXy/3HdG3N27Kr6t6zDbYwIJ1Zn6dPzj8q
	Wp1Kpha1l+B9nT76hdARAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780476120; x=
	1780562520; bh=vVyiUH+m+c0Pw2AXcQyAOjRt3bx8/ecnoqePaItRyK0=; b=R
	F/jcWn2vUy5JrQvGg/OfyMPHyclIcjyTXuOK1YeV4Sq4S3dZ0ICmW9j0IVaAXB9M
	o3j0rxAyFQdstTpvFB68R5RnNdWaacOftKAvUfADmfS+dgWlJRKLhALNzUX/6r5J
	dbcuj0eM1yubwXIxUDA8Pf5FSbf1Jpa7illtcB5IlvYC166MYZBNzKb7FgtvFYwk
	1xdkAgjZg6vxad/2X+GqVTWLHn+tTmkDrZSzMBTcie6eVfnplxW2KLwMLkSkV2yK
	BIY1aI66UoLoRppeXaA6i/IAb8TQPFBIcwvq3U+ShrkOlSLDU0wCAO3iyGsnS5IH
	CoJJ4HNDtnBS3Bi5yez2g==
X-ME-Sender: <xms:1-gfankRdvTVsPuGCOok348e9H0Z2qVwHHYQq64fNhgbp3-EBaubmQ>
    <xme:1-gfalr6Eg9KMqY5FUQHt0mX7BrbirUZhD9sRMVJUnScUJReJdVBAb9-jDyh3Do9j
    Nh77Cc_r_l9s1Ow2q30kwe36c7mvjJediGtAz0-jxTZodkqcL2HbC4>
X-ME-Proxy-Cause: dmFkZTEM3vOKNwb1UkGT2CzPPD9IL8yqTxfRhGM7aT4uWG/NV2TGFckBa4g+hI2eSjLsg9
    JuypidcxrOT/bdo7unzBukQiJ+FcKjj1nhhDLhq3TTIoMwDGiPxanI1gca9AVzflVmUixL
    HNDc4aOO69twBiSHGBLSEt3SLLOCyLKqYSFpL4dh/xOzQevTAvhJI+pY1iF0F5y7W5xnlH
    Ie5jkQEqtRwC/Sjj0yXHm8DTSx+yGGW3nc/BlzEbDRZUrf1nI6YdrsYSEs9kPnViBYdHws
    e1eOTryCPwnfaFPqoW8nqov5jUfMkYRaC4zEnN1os4tvOjv6oD5CaahXTOJg2FWvSYdxoz
    sVCqTcfxYc57QfBVXn+DO08+KFTdqWqivm7UN9yNkgAZPJJBc4ioQk7kzItrjvv16DyJuD
    LrNvsZfZTC1c02liayYtuyBqnwV+4t/DlaJeO8gKBRyYhyTOxhSPK6qbH8wN3mFiDX3jPy
    LHeIYk2fg9r8uhu08H1F3FxgdfkDtlMaeJRdJzCeYbCgZreFFlzU9k6HK0oREI/FygjNf4
    /Xw+3NIz2AlrRR6uqY6TMExyI9vRCwHsdnxV3WRLE+k2IdNtEtBHOl5zeuaN2Q2XcAplsp
    xl2LHgKxc1fIuUR22J0BYMyMGLVXdPzDruOPyGI8Yi/ucbBPKu1+JYJBhFLA
X-ME-Proxy: <xmx:1-gfaunFUYXh-KrFWNiH1oJiG6TzZgXC9qq4KVpU2WmwiAvskPK0Dw>
    <xmx:1-gfavLLyq2DMmAILuCgIawK2NH3jBKJIvD7ETCbQzY4vGx2FNXUWw>
    <xmx:1-gfakqrfVtiu7kuWQ8jRti6mxjHIMAiejmGHYCGr4z2opBG9ldF-A>
    <xmx:1-gfasTJrTRnRdDukRaya1CJ5WWlbVbayPZ0Xhpx6HFqifuZ3QVJWQ>
    <xmx:2OgfatWdJX9U8pqS9Di0HpeaSIT8du7-v9dtgBmhtFYmGmTbZ0TN_Zdc>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 18857182007A; Wed,  3 Jun 2026 04:41:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AAuCPBQLA6as
Date: Wed, 03 Jun 2026 10:41:18 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Rasmus Villemoes" <linux@rasmusvillemoes.dk>
Cc: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Arnd Bergmann" <arnd@kernel.org>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Petr Mladek" <pmladek@suse.com>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Dennis Dalessandro" <dennis.dalessandro@cornelisnetworks.com>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Leon Romanovsky" <leon@kernel.org>,
 "Arend van Spriel" <arend.vanspriel@broadcom.com>,
 "Miri Korenblit" <miriam.rachel.korenblit@intel.com>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>,
 "Justin Stitt" <justinstitt@google.com>,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev
Message-Id: <aafe201a-64a6-438f-89a3-d1cd10a357a7@app.fastmail.com>
In-Reply-To: <875x40hz7k.fsf@prevas.dk>
References: <20260602150904.2258624-1-arnd@kernel.org>
 <ah8n-Nk305S5hRwN@ashevche-desk.local>
 <WPQQfPHOiGJbSxrXRdFDy9jURhS7JMpNu9sD54Vfe5wB-JOjyGY6xPQyACz3MSGg0xGp79eOYCyZ2Hi2CsPeUg==@protonmail.internalid>
 <35c1ba62-e74d-4abc-aa73-ccd35968ff89@app.fastmail.com>
 <875x40hz7k.fsf@prevas.dk>
Subject: Re: [PATCH 1/2] tracing: work around -Wmissing-format-attribute warning
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21672-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux@rasmusvillemoes.dk,m:andriy.shevchenko@linux.intel.com,m:arnd@kernel.org,m:rostedt@goodmis.org,m:mhiramat@kernel.org,m:akpm@linux-foundation.org,m:pmladek@suse.com,m:nathan@kernel.org,m:dennis.dalessandro@cornelisnetworks.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:arend.vanspriel@broadcom.com,m:miriam.rachel.korenblit@intel.com,m:mathieu.desnoyers@efficios.com,m:senozhatsky@chromium.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:vbabka@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-trace-kernel@vger.kernel.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
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
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,goodmis.org,linux-foundation.org,suse.com,cornelisnetworks.com,ziepe.ca,broadcom.com,intel.com,efficios.com,chromium.org,gmail.com,google.com,vger.kernel.org,lists.linux.dev];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,lkml];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vf.va:url,messagingengine.com:dkim,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,app.fastmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 528CA635DAC

On Wed, Jun 3, 2026, at 09:15, Rasmus Villemoes wrote:
> On Tue, Jun 02 2026, "Arnd Bergmann" <arnd@arndb.de> wrote:
>> On Tue, Jun 2, 2026, at 20:59, Andy Shevchenko wrote:
>>> On Tue, Jun 02, 2026 at 05:07:05PM +0200, Arnd Bergmann wrote:
>
> May I suggest a different approach, that avoids having that extra
> function emitted (which presumably compiles to a single jump
> instruction, but still, with retpoline and CFI and all that it all adds
> up): Keep the declaration of __vsnprintf() in the header without the
> __print() attribute, but then do
>
> int __vsnprintf(char *buf, size_t size, const char *fmt_str, va_list args) 
>    __alias(vsnprintf);
>
> in vsprintf.c. Aside from reusing the same entry point, I could well
> imagine a compiler some day complaining about seeing the printf
> attribute applied in a local extra declaration but not having it in the
> header file.
>
> Presumably it will need its own EXPORT_SYMBOL if any of the intended
> users are modular, and it certainly still needs a comment.

I had tried that earlier but given up because the attributes have to
match exactly.

This definition works with all currently supported versions of gcc,
but may have to change when the there is a new version that adds
even more attributes:

int
__printf(3, 0)
__attribute__((nothrow))
__attribute__((nonnull(1)))
__vsnprintf(char *__restrict buf, size_t size,
            const char * __restrict fmt_str, va_list args)
               __alias(vsnprintf);

We'd probably want to also add __nothrow and __nonnull macros
in linux/compiler-attributes.h if we do this.

For reference, see below for the alternative idea I had
that avoids adding the __vsnprintf() alias altogether by
passing down the va_format using "%pV".

I don't think I actually got this one right in the end
since I only build-tested it, but I expect it could be done
if someone is able to test and fix all the corner cases
properly.

       Arnd

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 4715330c7b6b..8e44fc3e60b0 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -956,14 +956,11 @@ perf_trace_buf_submit(void *raw_data, int size, int rctx, u16 type,
  * gcc warns that you can not use a va_list in an inlined
  * function. But lets me make it into a macro :-/
  */
-#define __trace_event_vstr_len(fmt, va)			\
+#define __trace_event_vstr_len(vf)			\
 ({							\
-	va_list __ap;					\
 	int __ret;					\
 							\
-	va_copy(__ap, *(va));				\
-	__ret = __vsnprintf(NULL, 0, fmt, __ap) + 1;	\
-	va_end(__ap);					\
+	__ret = snprintf(NULL, 0, "%pV", vf) + 1;	\
 							\
 	min(__ret, TRACE_EVENT_STR_MAX);		\
 })
diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
index 1a05fc153353..2f3ee3632e77 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -143,20 +143,20 @@
  *         saved string into the "foo" field.
  *
  *   __vstring: This is similar to __string() but instead of taking a
- *         dynamic length, it takes a variable list va_list 'va' variable.
+ *         dynamic length, it takes a variable list va_format 'vaf' variable.
  *         Some event callers already have a message from parameters saved
- *         in a va_list. Passing in the format and the va_list variable
- *         will save just enough on the ring buffer for that string.
- *         Note, the va variable used is a pointer to a va_list, not
- *         to the va_list directly.
+ *         in a va_format. Passing in the va_format variable will save just
+ *	   enough on the ring buffer for that string.
  *
- *           (va_list *va)
+ *           (va_format *vaf)
  *
- *         __vstring(foo, fmt, va)  is similar to:  vsnprintf(foo, fmt, va)
+ *         __vstring(foo, vaf)  is similar to:
+ *
+ *	     vsnprintf(foo, "%pV", vaf)
  *
  *         To assign the string, use the helper macro __assign_vstr().
  *
- *         __assign_vstr(foo, fmt, va);
+ *         __assign_vstr(foo, vaf);
  *
  *         In most cases, the __assign_vstr() macro will take the same
  *         parameters as the __vstring() macro had to declare the string.
@@ -292,9 +292,9 @@ TRACE_EVENT(foo_bar,
 
 	TP_PROTO(const char *foo, int bar, const int *lst,
 		 const char *string, const struct cpumask *mask,
-		 const char *fmt, va_list *va),
+		 struct va_format *vaf),
 
-	TP_ARGS(foo, bar, lst, string, mask, fmt, va),
+	TP_ARGS(foo, bar, lst, string, mask, vaf),
 
 	TP_STRUCT__entry(
 		__array(	char,	foo,    10		)
@@ -303,7 +303,7 @@ TRACE_EVENT(foo_bar,
 		__string(	str,	string			)
 		__bitmask(	cpus,	num_possible_cpus()	)
 		__cpumask(	cpum				)
-		__vstring(	vstr,	fmt,	va		)
+		__vstring(	vstr,	vaf			)
 		__string_len(	lstr,	foo,	bar / 2 < strlen(foo) ? bar / 2 : strlen(foo) )
 	),
 
@@ -314,7 +314,7 @@ TRACE_EVENT(foo_bar,
 		       __length_of(lst) * sizeof(int));
 		__assign_str(str);
 		__assign_str(lstr);
-		__assign_vstr(vstr, fmt, va);
+		__assign_vstr(vstr, vaf);
 		__assign_bitmask(cpus, cpumask_bits(mask), num_possible_cpus());
 		__assign_cpumask(cpum, cpumask_bits(mask));
 	),
diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace/stages/stage6_event_callback.h
index 7d6a6ca6e779..2a4611b20afa 100644
--- a/include/trace/stages/stage6_event_callback.h
+++ b/include/trace/stages/stage6_event_callback.h
@@ -28,7 +28,7 @@
 #define __string_len(item, src, len) __dynamic_array(char, item, -1)
 
 #undef __vstring
-#define __vstring(item, fmt, ap) __dynamic_array(char, item, -1)
+#define __vstring(item, vf) __dynamic_array(char, item, -1)
 
 #undef __assign_str
 #define __assign_str(dst)						\
@@ -41,13 +41,8 @@
 	} while (0)
 
 #undef __assign_vstr
-#define __assign_vstr(dst, fmt, va)					\
-	do {								\
-		va_list __cp_va;					\
-		va_copy(__cp_va, *(va));				\
-		__vsnprintf(__get_str(dst), TRACE_EVENT_STR_MAX, fmt, __cp_va); \
-		va_end(__cp_va);					\
-	} while (0)
+#define __assign_vstr(dst, vf)						\
+	snprintf(__get_str(dst), TRACE_EVENT_STR_MAX, "%pV", vf);
 
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
diff --git a/drivers/infiniband/hw/hfi1/trace_dbg.h b/drivers/infiniband/hw/hfi1/trace_dbg.h
index 05c4f1354269..c96144d516db 100644
--- a/drivers/infiniband/hw/hfi1/trace_dbg.h
+++ b/drivers/infiniband/hw/hfi1/trace_dbg.h
@@ -26,10 +26,10 @@ DECLARE_EVENT_CLASS(hfi1_trace_template,
 		    TP_PROTO(const char *function, struct va_format *vaf),
 		    TP_ARGS(function, vaf),
 		    TP_STRUCT__entry(__string(function, function)
-				     __vstring(msg, vaf->fmt, vaf->va)
+				     __vstring(msg, vaf)
 				     ),
 		    TP_fast_assign(__assign_str(function);
-				   __assign_vstr(msg, vaf->fmt, vaf->va);
+				   __assign_vstr(msg, vaf);
 				   ),
 		    TP_printk("(%s) %s",
 			      __get_str(function),
diff --git a/drivers/net/wireless/ath/ath10k/trace.h b/drivers/net/wireless/ath/ath10k/trace.h
index 68b78ca17eaa..c258ad7de79e 100644
--- a/drivers/net/wireless/ath/ath10k/trace.h
+++ b/drivers/net/wireless/ath/ath10k/trace.h
@@ -52,12 +52,12 @@ DECLARE_EVENT_CLASS(ath10k_log_event,
 	TP_STRUCT__entry(
 		__string(device, dev_name(ar->dev))
 		__string(driver, dev_driver_string(ar->dev))
-		__vstring(msg, vaf->fmt, vaf->va)
+		__vstring(msg, vaf)
 	),
 	TP_fast_assign(
 		__assign_str(device);
 		__assign_str(driver);
-		__assign_vstr(msg, vaf->fmt, vaf->va);
+		__assign_vstr(msg, vaf);
 	),
 	TP_printk(
 		"%s %s %s",
@@ -89,13 +89,13 @@ TRACE_EVENT(ath10k_log_dbg,
 		__string(device, dev_name(ar->dev))
 		__string(driver, dev_driver_string(ar->dev))
 		__field(unsigned int, level)
-		__vstring(msg, vaf->fmt, vaf->va)
+		__vstring(msg, vaf)
 	),
 	TP_fast_assign(
 		__assign_str(device);
 		__assign_str(driver);
 		__entry->level = level;
-		__assign_vstr(msg, vaf->fmt, vaf->va);
+		__assign_vstr(msg, vaf);
 	),
 	TP_printk(
 		"%s %s %s",
diff --git a/drivers/net/wireless/ath/ath11k/trace.h b/drivers/net/wireless/ath/ath11k/trace.h
index 75246b0a82e3..0ac14b72deac 100644
--- a/drivers/net/wireless/ath/ath11k/trace.h
+++ b/drivers/net/wireless/ath/ath11k/trace.h
@@ -127,12 +127,12 @@ DECLARE_EVENT_CLASS(ath11k_log_event,
 	TP_STRUCT__entry(
 		__string(device, dev_name(ab->dev))
 		__string(driver, dev_driver_string(ab->dev))
-		__vstring(msg, vaf->fmt, vaf->va)
+		__vstring(msg, vaf)
 	),
 	TP_fast_assign(
 		__assign_str(device);
 		__assign_str(driver);
-		__assign_vstr(msg, vaf->fmt, vaf->va);
+		__assign_vstr(msg, vaf);
 	),
 	TP_printk(
 		"%s %s %s",
diff --git a/drivers/net/wireless/ath/ath6kl/trace.h b/drivers/net/wireless/ath/ath6kl/trace.h
index 8577aa459c58..d46fe6b675f9 100644
--- a/drivers/net/wireless/ath/ath6kl/trace.h
+++ b/drivers/net/wireless/ath/ath6kl/trace.h
@@ -253,10 +253,10 @@ DECLARE_EVENT_CLASS(ath6kl_log_event,
 	TP_PROTO(struct va_format *vaf),
 	TP_ARGS(vaf),
 	TP_STRUCT__entry(
-		__vstring(msg, vaf->fmt, vaf->va)
+		__vstring(msg, vaf)
 	),
 	TP_fast_assign(
-		__assign_vstr(msg, vaf->fmt, vaf->va);
+		__assign_vstr(msg, vaf);
 	),
 	TP_printk("%s", __get_str(msg))
 );
@@ -281,11 +281,11 @@ TRACE_EVENT(ath6kl_log_dbg,
 	TP_ARGS(level, vaf),
 	TP_STRUCT__entry(
 		__field(unsigned int, level)
-		__vstring(msg, vaf->fmt, vaf->va)
+		__vstring(msg, vaf)
 	),
 	TP_fast_assign(
 		__entry->level = level;
-		__assign_vstr(msg, vaf->fmt, vaf->va);
+		__assign_vstr(msg, vaf);
 	),
 	TP_printk("%s", __get_str(msg))
 );
diff --git a/drivers/net/wireless/ath/trace.h b/drivers/net/wireless/ath/trace.h
index 82aac0a4baff..298a56349ea7 100644
--- a/drivers/net/wireless/ath/trace.h
+++ b/drivers/net/wireless/ath/trace.h
@@ -40,13 +40,13 @@ TRACE_EVENT(ath_log,
 	    TP_STRUCT__entry(
 		    __string(device, wiphy_name(wiphy))
 		    __string(driver, KBUILD_MODNAME)
-		    __vstring(msg, vaf->fmt, vaf->va)
+		    __vstring(msg, vaf)
 	    ),
 
 	    TP_fast_assign(
 		    __assign_str(device);
 		    __assign_str(driver);
-		    __assign_vstr(msg, vaf->fmt, vaf->va);
+		    __assign_vstr(msg, vaf);
 	    ),
 
 	    TP_printk(
diff --git a/drivers/net/wireless/ath/wil6210/trace.h b/drivers/net/wireless/ath/wil6210/trace.h
index 201f44612c31..7eb6ca2b0cb6 100644
--- a/drivers/net/wireless/ath/wil6210/trace.h
+++ b/drivers/net/wireless/ath/wil6210/trace.h
@@ -70,10 +70,10 @@ DECLARE_EVENT_CLASS(wil6210_log_event,
 	TP_PROTO(struct va_format *vaf),
 	TP_ARGS(vaf),
 	TP_STRUCT__entry(
-		__vstring(msg, vaf->fmt, vaf->va)
+		__vstring(msg, vaf)
 	),
 	TP_fast_assign(
-		__assign_vstr(msg, vaf->fmt, vaf->va);
+		__assign_vstr(msg, vaf);
 	),
 	TP_printk("%s", __get_str(msg))
 );
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/tracepoint.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/tracepoint.h
index 6c4e00e9ccd1..66b179adb80c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/tracepoint.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/tracepoint.h
@@ -33,11 +33,11 @@ TRACE_EVENT(brcmf_err,
 	TP_ARGS(func, vaf),
 	TP_STRUCT__entry(
 		__string(func, func)
-		__vstring(msg, vaf->fmt, vaf->va)
+		__vstring(msg, vaf)
 	),
 	TP_fast_assign(
 		__assign_str(func);
-		__assign_vstr(msg, vaf->fmt, vaf->va);
+		__assign_vstr(msg, vaf);
 	),
 	TP_printk("%s: %s", __get_str(func), __get_str(msg))
 );
@@ -48,12 +48,12 @@ TRACE_EVENT(brcmf_dbg,
 	TP_STRUCT__entry(
 		__field(u32, level)
 		__string(func, func)
-		__vstring(msg, vaf->fmt, vaf->va)
+		__vstring(msg, vaf)
 	),
 	TP_fast_assign(
 		__entry->level = level;
 		__assign_str(func);
-		__assign_vstr(msg, vaf->fmt, vaf->va);
+		__assign_vstr(msg, vaf);
 	),
 	TP_printk("%s: %s", __get_str(func), __get_str(msg))
 );
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_brcmsmac_msg.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_brcmsmac_msg.h
index dc296d8bf775..369171af1a30 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_brcmsmac_msg.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/brcms_trace_brcmsmac_msg.h
@@ -28,10 +28,10 @@ DECLARE_EVENT_CLASS(brcms_msg_event,
 	TP_PROTO(struct va_format *vaf),
 	TP_ARGS(vaf),
 	TP_STRUCT__entry(
-		__vstring(msg, vaf->fmt, vaf->va)
+		__vstring(msg, vaf)
 	),
 	TP_fast_assign(
-		__assign_vstr(msg, vaf->fmt, vaf->va);
+		__assign_vstr(msg, vaf);
 	),
 	TP_printk("%s", __get_str(msg))
 );
@@ -62,12 +62,12 @@ TRACE_EVENT(brcms_dbg,
 	TP_STRUCT__entry(
 		__field(u32, level)
 		__string(func, func)
-		__vstring(msg, vaf->fmt, vaf->va)
+		__vstring(msg, vaf)
 	),
 	TP_fast_assign(
 		__entry->level = level;
 		__assign_str(func);
-		__assign_vstr(msg, vaf->fmt, vaf->va);
+		__assign_vstr(msg, vaf);
 	),
 	TP_printk("%s: %s", __get_str(func), __get_str(msg))
 );
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-msg.h b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-msg.h
index 0db1fa5477af..80cfb9fc8ad8 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-msg.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-msg.h
@@ -18,10 +18,10 @@ DECLARE_EVENT_CLASS(iwlwifi_msg_event,
 	TP_PROTO(struct va_format *vaf),
 	TP_ARGS(vaf),
 	TP_STRUCT__entry(
-		__vstring(msg, vaf->fmt, vaf->va)
+		__vstring(msg, vaf)
 	),
 	TP_fast_assign(
-		__assign_vstr(msg, vaf->fmt, vaf->va);
+		__assign_vstr(msg, vaf);
 	),
 	TP_printk("%s", __get_str(msg))
 );
@@ -53,12 +53,12 @@ TRACE_EVENT(iwlwifi_dbg,
 	TP_STRUCT__entry(
 		__field(u32, level)
 		__string(function, function)
-		__vstring(msg, vaf->fmt, vaf->va)
+		__vstring(msg, vaf)
 	),
 	TP_fast_assign(
 		__entry->level = level;
 		__assign_str(function);
-		__assign_vstr(msg, vaf->fmt, vaf->va);
+		__assign_vstr(msg, vaf);
 	),
 	TP_printk("%s", __get_str(msg))
 );
diff --git a/drivers/usb/chipidea/trace.h b/drivers/usb/chipidea/trace.h
index 1875419cd17f..9ec0df074872 100644
--- a/drivers/usb/chipidea/trace.h
+++ b/drivers/usb/chipidea/trace.h
@@ -28,11 +28,11 @@ TRACE_EVENT(ci_log,
 	TP_ARGS(ci, vaf),
 	TP_STRUCT__entry(
 		__string(name, dev_name(ci->dev))
-		__vstring(msg, vaf->fmt, vaf->va)
+		__vstring(msg, vaf)
 	),
 	TP_fast_assign(
 		__assign_str(name);
-		__assign_vstr(msg, vaf->fmt, vaf->va);
+		__assign_vstr(msg, vaf);
 	),
 	TP_printk("%s: %s", __get_str(name), __get_str(msg))
 );
diff --git a/drivers/usb/host/xhci-trace.h b/drivers/usb/host/xhci-trace.h
index 724cba2dbb78..575c02109b4b 100644
--- a/drivers/usb/host/xhci-trace.h
+++ b/drivers/usb/host/xhci-trace.h
@@ -28,9 +28,9 @@
 DECLARE_EVENT_CLASS(xhci_log_msg,
 	TP_PROTO(struct va_format *vaf),
 	TP_ARGS(vaf),
-	TP_STRUCT__entry(__vstring(msg, vaf->fmt, vaf->va)),
+	TP_STRUCT__entry(__vstring(msg, vaf)),
 	TP_fast_assign(
-		__assign_vstr(msg, vaf->fmt, vaf->va);
+		__assign_vstr(msg, vaf);
 	),
 	TP_printk("%s", __get_str(msg))
 );
diff --git a/drivers/usb/mtu3/mtu3_trace.h b/drivers/usb/mtu3/mtu3_trace.h
index 89870175d635..56c9263a99d8 100644
--- a/drivers/usb/mtu3/mtu3_trace.h
+++ b/drivers/usb/mtu3/mtu3_trace.h
@@ -23,11 +23,11 @@ TRACE_EVENT(mtu3_log,
 	TP_ARGS(dev, vaf),
 	TP_STRUCT__entry(
 		__string(name, dev_name(dev))
-		__vstring(msg, vaf->fmt, vaf->va)
+		__vstring(msg, vaf)
 	),
 	TP_fast_assign(
 		__assign_str(name);
-		__assign_vstr(msg, vaf->fmt, vaf->va);
+		__assign_vstr(msg, vaf);
 	),
 	TP_printk("%s: %s", __get_str(name), __get_str(msg))
 );
diff --git a/drivers/usb/musb/musb_trace.h b/drivers/usb/musb/musb_trace.h
index 726e6697d475..7dba44b0496d 100644
--- a/drivers/usb/musb/musb_trace.h
+++ b/drivers/usb/musb/musb_trace.h
@@ -28,11 +28,11 @@ TRACE_EVENT(musb_log,
 	TP_ARGS(musb, vaf),
 	TP_STRUCT__entry(
 		__string(name, dev_name(musb->controller))
-		__vstring(msg, vaf->fmt, vaf->va)
+		__vstring(msg, vaf)
 	),
 	TP_fast_assign(
 		__assign_str(name);
-		__assign_vstr(msg, vaf->fmt, vaf->va);
+		__assign_vstr(msg, vaf);
 	),
 	TP_printk("%s: %s", __get_str(name), __get_str(msg))
 );
diff --git a/include/trace/events/iscsi.h b/include/trace/events/iscsi.h
index 990fd154f586..2e2667658b51 100644
--- a/include/trace/events/iscsi.h
+++ b/include/trace/events/iscsi.h
@@ -26,12 +26,12 @@ DECLARE_EVENT_CLASS(iscsi_log_msg,
 
 	TP_STRUCT__entry(
 		__string(dname, 	dev_name(dev)		)
-		__vstring(msg,		vaf->fmt, vaf->va)
+		__vstring(msg,		vaf)
 	),
 
 	TP_fast_assign(
 		__assign_str(dname);
-		__assign_vstr(msg, vaf->fmt, vaf->va);
+		__assign_vstr(msg, vaf);
 	),
 
 	TP_printk("%s: %s",__get_str(dname),  __get_str(msg)
diff --git a/include/trace/events/qla.h b/include/trace/events/qla.h
index 74a7534b99b6..554ae9a623c6 100644
--- a/include/trace/events/qla.h
+++ b/include/trace/events/qla.h
@@ -17,11 +17,11 @@ DECLARE_EVENT_CLASS(qla_log_event,
 
 	TP_STRUCT__entry(
 		__string(buf, buf)
-		__vstring(msg, vaf->fmt, vaf->va)
+		__vstring(msg, vaf)
 	),
 	TP_fast_assign(
 		__assign_str(buf);
-		__assign_vstr(msg, vaf->fmt, vaf->va);
+		__assign_vstr(msg, vaf);
 	),
 
 	TP_printk("%s %s", __get_str(buf), __get_str(msg))
diff --git a/include/trace/stages/stage1_struct_define.h b/include/trace/stages/stage1_struct_define.h
index 69e0dae453bf..0ae49a935d16 100644
--- a/include/trace/stages/stage1_struct_define.h
+++ b/include/trace/stages/stage1_struct_define.h
@@ -27,7 +27,7 @@
 #define __string_len(item, src, len) __dynamic_array(char, item, -1)
 
 #undef __vstring
-#define __vstring(item, fmt, ap) __dynamic_array(char, item, -1)
+#define __vstring(item, vf) __dynamic_array(char, item, -1)
 
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(char, item, -1)
diff --git a/include/trace/stages/stage2_data_offsets.h b/include/trace/stages/stage2_data_offsets.h
index 8b0cff06d346..5c6dc3092e07 100644
--- a/include/trace/stages/stage2_data_offsets.h
+++ b/include/trace/stages/stage2_data_offsets.h
@@ -33,7 +33,7 @@
 #define __string_len(item, src, len) __dynamic_array(char, item, -1)
 
 #undef __vstring
-#define __vstring(item, fmt, ap) __dynamic_array(char, item, -1)
+#define __vstring(item, vf) __dynamic_array(char, item, -1)
 
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
diff --git a/include/trace/stages/stage4_event_fields.h b/include/trace/stages/stage4_event_fields.h
index b6f679ae21aa..77f74d509760 100644
--- a/include/trace/stages/stage4_event_fields.h
+++ b/include/trace/stages/stage4_event_fields.h
@@ -42,7 +42,7 @@
 #define __string_len(item, src, len) __dynamic_array(char, item, -1)
 
 #undef __vstring
-#define __vstring(item, fmt, ap) __dynamic_array(char, item, -1)
+#define __vstring(item, vf) __dynamic_array(char, item, -1)
 
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
diff --git a/include/trace/stages/stage5_get_offsets.h b/include/trace/stages/stage5_get_offsets.h
index c6a62dfb18ef..1ce5ca15a8ed 100644
--- a/include/trace/stages/stage5_get_offsets.h
+++ b/include/trace/stages/stage5_get_offsets.h
@@ -65,8 +65,8 @@ static inline const char *__string_src(const char *str)
 	__data_offsets->item##_ptr_ = src;
 
 #undef __vstring
-#define __vstring(item, fmt, ap) __dynamic_array(char, item,		\
-		      __trace_event_vstr_len(fmt, ap))
+#define __vstring(item, vf) __dynamic_array(char, item,		\
+		      __trace_event_vstr_len(vf))
 
 #undef __rel_dynamic_array
 #define __rel_dynamic_array(type, item, len)				\
diff --git a/net/batman-adv/trace.h b/net/batman-adv/trace.h
index 7da692ec38e9..ac88789330a3 100644
--- a/net/batman-adv/trace.h
+++ b/net/batman-adv/trace.h
@@ -36,13 +36,13 @@ TRACE_EVENT(batadv_dbg,
 	    TP_STRUCT__entry(
 		    __string(device, bat_priv->mesh_iface->name)
 		    __string(driver, KBUILD_MODNAME)
-		    __vstring(msg, vaf->fmt, vaf->va)
+		    __vstring(msg, vaf)
 	    ),
 
 	    TP_fast_assign(
 		    __assign_str(device);
 		    __assign_str(driver);
-		    __assign_vstr(msg, vaf->fmt, vaf->va);
+		    __assign_vstr(msg, vaf);
 	    ),
 
 	    TP_printk(
diff --git a/net/mac80211/trace_msg.h b/net/mac80211/trace_msg.h
index aea4ce55c5ac..0de50dfa13ed 100644
--- a/net/mac80211/trace_msg.h
+++ b/net/mac80211/trace_msg.h
@@ -22,11 +22,11 @@ DECLARE_EVENT_CLASS(mac80211_msg_event,
 	TP_ARGS(vaf),
 
 	TP_STRUCT__entry(
-		__vstring(msg, vaf->fmt, vaf->va)
+		__vstring(msg, vaf)
 	),
 
 	TP_fast_assign(
-		__assign_vstr(msg, vaf->fmt, vaf->va);
+		__assign_vstr(msg, vaf);
 	),
 
 	TP_printk("%s", __get_str(msg))
diff --git a/samples/trace_events/trace-events-sample.c b/samples/trace_events/trace-events-sample.c
index ecc7db237f2e..07096eadfb7b 100644
--- a/samples/trace_events/trace-events-sample.c
+++ b/samples/trace_events/trace-events-sample.c
@@ -23,6 +23,7 @@ static void do_simple_thread_func(int cnt, const char *fmt, ...)
 {
 	unsigned long bitmask[1] = {0xdeadbeefUL};
 	va_list va;
+	struct va_format vf = { .fmt = fmt };
 	int array[6];
 	int len = cnt % 5;
 	int i;
@@ -35,10 +36,11 @@ static void do_simple_thread_func(int cnt, const char *fmt, ...)
 	array[i] = 0;
 
 	va_start(va, fmt);
+	vf.va = &va;
 
 	/* Silly tracepoints */
 	trace_foo_bar("hello", cnt, array, random_strings[len],
-		      current->cpus_ptr, fmt, &va);
+		      current->cpus_ptr, &vf);
 
 	va_end(va);
 

