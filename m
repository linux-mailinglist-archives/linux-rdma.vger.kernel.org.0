Return-Path: <linux-rdma+bounces-21684-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rltcF5gsIGq0yAAAu9opvQ
	(envelope-from <linux-rdma+bounces-21684-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 15:31:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEDE638128
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 15:31:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rasmusvillemoes.dk header.s=protonmail header.b=j9p4Bnka;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21684-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21684-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=rasmusvillemoes.dk;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10ACA3292CD1
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 13:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A20481666;
	Wed,  3 Jun 2026 13:15:01 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C977F48124B;
	Wed,  3 Jun 2026 13:14:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780492500; cv=none; b=LZ1lphu/Fz8fl4kwQB2K1bBAfOA4srG51zw6xFwHdyg/GS5oeGAAD45Q2SlnDt18zJlZ80JZBt+a3sevhZw/k3Rjv71NEH7fvWFr4xgNJQ43T2FgaQD0QJ9jKyG75NZqvkS/zS4FVFDcCjvcayR8eza/AD06Y44qPdfJEsSy3Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780492500; c=relaxed/simple;
	bh=C2GewxLkkgkEYbqR2iNRlLWHQtBSWfBZDO6yBn946kQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RKzklnF/wUBLw4EwrJsPDzLp0S2H1iRS7moVr1qTVm6hp91PYv6JRxtaoK1cobMnZGAwRekwckYru4m28Hbp07F8QHc2gPpzBARrXUV8gDUmUYyyc5Q4UolUUuTAW22DAsYRyn3ZAAnBtLV+BqGy/cRdcF8Y//pMj/+FNFkdSEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (2048-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=j9p4Bnka; arc=none smtp.client-ip=185.70.43.171
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
	s=protonmail; t=1780492488; x=1780751688;
	bh=V2Q66gdvmCtjrbhnA8iFDT8uoIIyOyjUBipERHmuu4c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=j9p4Bnka6PQzW3q8mK/aVo01BjZleEwlhVKxZDjRCXNgW/dEvOKiKLq2eSjhrCSCf
	 QsLmaxdpywC53akTtyxCM3OaE2kVJ9UjvkC329bTW+i45VQht398uA+WkYVcjxGiQG
	 w+KDxUxGKlpLKhznpDa3LTmN41o1v2EJ5K4M+jAD81duudtI3XaBK0EASDtMOP/3DG
	 SJs8KG2B1gJX7R2p2JNWI2pDk+Elhg6Tj0sedgkR3WuQBpBpWOhg3qD4vLkRNE1UTu
	 hVQpzS+MLwZeGUDu8xSAkVpgXpfc3Sm9WLixRtD4BGnb1KiWY4BEp4XZIir2U9RAcj
	 NNwpLVUUCm1/g==
X-Pm-Submission-Id: 4gVp850wFCz2ScNN
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
In-Reply-To: <87zf1bhjqp.fsf@prevas.dk> (Rasmus Villemoes's message of "Wed,
	03 Jun 2026 14:49:18 +0200")
References: <20260602150904.2258624-1-arnd@kernel.org>
	<ah8n-Nk305S5hRwN@ashevche-desk.local>
	<WPQQfPHOiGJbSxrXRdFDy9jURhS7JMpNu9sD54Vfe5wB-JOjyGY6xPQyACz3MSGg0xGp79eOYCyZ2Hi2CsPeUg==@protonmail.internalid>
	<35c1ba62-e74d-4abc-aa73-ccd35968ff89@app.fastmail.com>
	<875x40hz7k.fsf@prevas.dk>
	<cODLVx6ZlerCiOgdpsG7OSsC2YRA6pXmq2jBdTjRB2UQoTIY4hI-yhV1lrumRNBH1hTT2aJRS-MgtlbhNWUTEw==@protonmail.internalid>
	<aafe201a-64a6-438f-89a3-d1cd10a357a7@app.fastmail.com>
	<87zf1bhjqp.fsf@prevas.dk>
Date: Wed, 03 Jun 2026 15:14:44 +0200
Message-ID: <87se73hikb.fsf@prevas.dk>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[rasmusvillemoes.dk:s=protonmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21684-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rasmusvillemoes.dk:from_mime,rasmusvillemoes.dk:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,prevas.dk:mid,prevas.dk:email,arndb.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFEDE638128

On Wed, Jun 03 2026, Rasmus Villemoes <ravi@prevas.dk> wrote:

> On Wed, Jun 03 2026, "Arnd Bergmann" <arnd@arndb.de> wrote:
>
>> On Wed, Jun 3, 2026, at 09:15, Rasmus Villemoes wrote:
>>> On Tue, Jun 02 2026, "Arnd Bergmann" <arnd@arndb.de> wrote:
>>>> On Tue, Jun 2, 2026, at 20:59, Andy Shevchenko wrote:
>>>>> On Tue, Jun 02, 2026 at 05:07:05PM +0200, Arnd Bergmann wrote:
>>>
>>> May I suggest a different approach, that avoids having that extra
>>> function emitted (which presumably compiles to a single jump
>>> instruction, but still, with retpoline and CFI and all that it all adds
>>> up): Keep the declaration of __vsnprintf() in the header without the
>>> __print() attribute, but then do
>>>
>>> int __vsnprintf(char *buf, size_t size, const char *fmt_str, va_list args)
>>>    __alias(vsnprintf);
>>>
>>> in vsprintf.c. Aside from reusing the same entry point, I could well
>>> imagine a compiler some day complaining about seeing the printf
>>> attribute applied in a local extra declaration but not having it in the
>>> header file.
>>>
>>> Presumably it will need its own EXPORT_SYMBOL if any of the intended
>>> users are modular, and it certainly still needs a comment.
>>
>> I had tried that earlier but given up because the attributes have to
>> match exactly.
>>
>> This definition works with all currently supported versions of gcc,
>> but may have to change when the there is a new version that adds
>> even more attributes:
>>
>> int
>> __printf(3, 0)
>> __attribute__((nothrow))
>> __attribute__((nonnull(1)))
>> __vsnprintf(char *__restrict buf, size_t size,
>>             const char * __restrict fmt_str, va_list args)
>>                __alias(vsnprintf);
>>
>
> Ah, I see. The documentation for the alias attribute does say that the
> types have to match, but I didn't know that the nothrow and nonnull
> attributes were considered part of the type identity. Oddly enough, if
> one does
>
>   typeof(vsnprintf) __vsnprintf __alias(vsnprintf);
>
> that still fails, but only complains about nothrow, not nonnull.
>
> I don't remember what minimum gcc we currently require, but gcc 9
> introduced another attribute that is apperently meant for cases like
> this: 'copy'. This seems to build:
>
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 9f359b31c8d1..c1402d375429 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -2988,6 +2988,9 @@ int vsnprintf(char *buf, size_t size, const char *fmt_str, va_list args)
>  }
>  EXPORT_SYMBOL(vsnprintf);
>  
> +int __vsnprintf(char *buf, size_t size, const char *fmt_str, va_list args)
> +       __alias(vsnprintf) __attribute__((__copy__(vsnprintf)));
> +
>  /**
>   * vscnprintf - Format a string and place it in a buffer
>   * @buf: The buffer to place the result into
>
> That at least should handle any future "gcc knows this-or-that about the
> vsnprintf function". But I don't know if clang supports that copy
> mechanism or if the minimum supported gcc is too old.

Ah, so we already have __copy in compiler-attributes.h, stating that
it's not supported by clang. Our current minimum gcc version is 8. But
judging from the commit message for c0d9782f5, perhaps it's not actually
a problem that it just expands to nothing for gcc 8, as the "less
restrictive attribute" warning was also introduced with gcc 9, and the
__copy macro is already used for module init/exit functions. Which also
suggests that it might not be a problem that clang doesn't support it.

Rasmus

