Return-Path: <linux-rdma+bounces-21668-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YCt7B5TVH2rIqgAAu9opvQ
	(envelope-from <linux-rdma+bounces-21668-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 09:19:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE6663521A
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 09:19:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rasmusvillemoes.dk header.s=protonmail header.b=PQbU687e;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21668-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21668-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=rasmusvillemoes.dk;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE798309C8C3
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 07:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6451A39B4BF;
	Wed,  3 Jun 2026 07:15:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A545396B76;
	Wed,  3 Jun 2026 07:15:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470937; cv=none; b=mc2Y0uJvbPZQ5eaDT8gBfBiE9rLMWcXjUdQaLJ8EAfHxefLpwxqwzKdP0eONCfuMQSiULpOgNnk8MfY80uZshH42nni2hmSdhrtoTpI6RoXd2oTafH67ibFuvf+XV8l/jrciJyXwx9zG2C16To8ADLmcVqSWeP61Px1IXW61Btk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470937; c=relaxed/simple;
	bh=M1qhC0UFXz8MVPH15I4zPG/B8TW75biCWf4twzWwS/M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QJ7ozG3LY1gdTWhF/fmvgY8R74XNgmwVKW9syqVwnLzMItWPx6TrbmPLk7RG1TWf38axBs8VGhh+n9EtlnxgKZt2jyIo3cMyiF4tNkkQnY1pZ+KaG6UuSYwaIXCVNRaADmU9EYLMsVZb34Y1wks8A0XHkuiFq0PP9dTL9nt/XPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (2048-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=PQbU687e; arc=none smtp.client-ip=79.135.106.112
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
	s=protonmail; t=1780470921; x=1780730121;
	bh=LmZEeSZAd+OZ1Gn48j9QvYPymSsKNATaHgUOGJMb/zs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=PQbU687emmJLIgwcPqMgFazSSKX0n0cdzFemS41SLCaXBkfiNvkSXGFWGo/n0UiqD
	 oc3+1sUKRdBrTkJ0u6DrQtBYqE/67eBNluaDN9SbjNwZL6mJQtY7CIFAVv2Oq+/ZIt
	 jvFfcGMHkPqudRC0yuZqRg6nksQi7sGyEP6TbUdYj1lg/9M4/oRdbj4wYXflpAwtlG
	 zYVA7vUcVJ5Z6/+X5XKinW8nlbv948aAcHGuMzDAUQ+ns8HvapWodahfQOKD/6n9oV
	 AhDAIn+6TmVBlnnICNTlwVoFnIvCwOVO65mMr+Sc5eZBYOU1Nzibau0b5NDda6Au50
	 sZ/qvAPNDmkFA==
X-Pm-Submission-Id: 4gVf9D52zyz2SccQ
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,  "Arnd Bergmann"
 <arnd@kernel.org>,  "Steven Rostedt" <rostedt@goodmis.org>,  "Masami
 Hiramatsu" <mhiramat@kernel.org>,  "Andrew Morton"
 <akpm@linux-foundation.org>,  "Petr Mladek" <pmladek@suse.com>,  "Nathan
 Chancellor" <nathan@kernel.org>,  "Dennis Dalessandro"
 <dennis.dalessandro@cornelisnetworks.com>,  "Jason Gunthorpe"
 <jgg@ziepe.ca>,  "Leon Romanovsky" <leon@kernel.org>,  "Arend van Spriel"
 <arend.vanspriel@broadcom.com>,  "Miri Korenblit"
 <miriam.rachel.korenblit@intel.com>,  "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>,  "Sergey Senozhatsky"
 <senozhatsky@chromium.org>,  "Nick Desaulniers"
 <nick.desaulniers+lkml@gmail.com>,  "Bill Wendling" <morbo@google.com>,
  "Justin Stitt" <justinstitt@google.com>,  "Vlastimil Babka (SUSE)"
 <vbabka@kernel.org>,  <linux-rdma@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-wireless@vger.kernel.org>,
  <brcm80211@lists.linux.dev>,  <brcm80211-dev-list.pdl@broadcom.com>,
  <linux-trace-kernel@vger.kernel.org>,  <llvm@lists.linux.dev>
Subject: Re: [PATCH 1/2] tracing: work around -Wmissing-format-attribute
 warning
In-Reply-To: <35c1ba62-e74d-4abc-aa73-ccd35968ff89@app.fastmail.com> (Arnd
	Bergmann's message of "Tue, 02 Jun 2026 22:32:04 +0200")
References: <20260602150904.2258624-1-arnd@kernel.org>
	<ah8n-Nk305S5hRwN@ashevche-desk.local>
	<WPQQfPHOiGJbSxrXRdFDy9jURhS7JMpNu9sD54Vfe5wB-JOjyGY6xPQyACz3MSGg0xGp79eOYCyZ2Hi2CsPeUg==@protonmail.internalid>
	<35c1ba62-e74d-4abc-aa73-ccd35968ff89@app.fastmail.com>
Date: Wed, 03 Jun 2026 09:15:11 +0200
Message-ID: <875x40hz7k.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rasmusvillemoes.dk,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[rasmusvillemoes.dk:s=protonmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21668-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:arnd@arndb.de,m:andriy.shevchenko@linux.intel.com,m:arnd@kernel.org,m:rostedt@goodmis.org,m:mhiramat@kernel.org,m:akpm@linux-foundation.org,m:pmladek@suse.com,m:nathan@kernel.org,m:dennis.dalessandro@cornelisnetworks.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:arend.vanspriel@broadcom.com,m:miriam.rachel.korenblit@intel.com,m:mathieu.desnoyers@efficios.com,m:senozhatsky@chromium.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:vbabka@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-trace-kernel@vger.kernel.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[linux@rasmusvillemoes.dk,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rasmusvillemoes.dk:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@rasmusvillemoes.dk,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,goodmis.org,linux-foundation.org,suse.com,cornelisnetworks.com,ziepe.ca,broadcom.com,intel.com,efficios.com,chromium.org,gmail.com,google.com,vger.kernel.org,lists.linux.dev];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,lkml];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,rasmusvillemoes.dk:from_mime,rasmusvillemoes.dk:dkim,prevas.dk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9EE6663521A

On Tue, Jun 02 2026, "Arnd Bergmann" <arnd@arndb.de> wrote:

> On Tue, Jun 2, 2026, at 20:59, Andy Shevchenko wrote:
>> On Tue, Jun 02, 2026 at 05:07:05PM +0200, Arnd Bergmann wrote:
>>>
>>> A number of tracing headers turn off -Wsuggest-attribute=format for
>>> gcc, but they don't turn it off for clang, so the same warning still
>>> happens on new versions of clang that support the format attribute.
>>>
>>> To avoid duplicating the same thing in each tracing header, as well
>>> as changing all of them to also turn it off for clang, add a new
>>> __vsnprintf() helper that is not annotated this way in linux/sprintf.h
>>> but is defined to work the same way as the regular vsprintf.
>>
>> vsprintf()
>
> Fixed now
>
>> Why the __printf() annotation is in the C file and not here?
>> Is this all about headers as the second paragraph in the commit message
>> explains?
>> I would add a comment to explain it here, otherwise we might see false
>> patches to "make things consistent" in a wrong way.
>
> I've tried to come up with a kerneldoc comment now, similar to
> the one for the vsnprintf() function, and added a separate prototype
> in the header. Does this address your concern?
>
>       Arnd
>
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 3caf0796f54d..7c696aea2ed3 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -2975,7 +2975,23 @@ int vsnprintf(char *buf, size_t size, const char *fmt_str, va_list args)
>  }
>  EXPORT_SYMBOL(vsnprintf);
>
> -int __printf(3, 0) __vsnprintf(char *buf, size_t size, const char *fmt_str, va_list args)
> +/**
> + * __vsnprintf - vsnprintf() wrapper without __printf() attribute
> + * @buf: The buffer to place the result into
> + * @size: The size of the buffer, including the trailing null space
> + * @fmt_str: The format string to use
> + * @args: Arguments for the format string
> + *
> + * This has the exact same behavior as vsnprintf() but can be used in call
> + * sites that are missing a __printf() annotation, e.g. because they
> + * get a 'va_format' argument instead of format and varargs.
> + *
> + * For this to work, the attribute is added to the declaration here but
> + * not in the header.
> + */
> +int __printf(3, 0) __vsnprintf(char *buf, size_t size, const char *fmt_str, va_list args);
> +
> +int __vsnprintf(char *buf, size_t size, const char *fmt_str, va_list args)
>  {
>  	return vsnprintf(buf, size, fmt_str, args);
>  }

May I suggest a different approach, that avoids having that extra
function emitted (which presumably compiles to a single jump
instruction, but still, with retpoline and CFI and all that it all adds
up): Keep the declaration of __vsnprintf() in the header without the
__print() attribute, but then do

int __vsnprintf(char *buf, size_t size, const char *fmt_str, va_list args) 
   __alias(vsnprintf);

in vsprintf.c. Aside from reusing the same entry point, I could well
imagine a compiler some day complaining about seeing the printf
attribute applied in a local extra declaration but not having it in the
header file.

Presumably it will need its own EXPORT_SYMBOL if any of the intended
users are modular, and it certainly still needs a comment.

Rasmus

