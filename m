Return-Path: <linux-rdma+bounces-21663-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2gqWHOuKH2oOnAAAu9opvQ
	(envelope-from <linux-rdma+bounces-21663-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 04:01:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC9F63392B
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 04:01:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=l+5sfnW9;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21663-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21663-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 668F23024CB8
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 01:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720A5395AD8;
	Wed,  3 Jun 2026 01:58:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF42391E5B;
	Wed,  3 Jun 2026 01:58:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780451935; cv=none; b=eXTY1y/kVurb77qaCVrztjZtdVsz1BHsZ6qJ+78lO71I3nwENNt3Y0u8OuZV5wQu5TIgrXLk3bjJPnlDVcrhYOcyykygVstKYlvD0meHxG+4VozrHB6vxkXgozaqo3s4U1lN0hLgGUQNvI50tSVrb3zoXUb8xYyxBzgswQdAAtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780451935; c=relaxed/simple;
	bh=4UAkSHyts2wKV6GLVSbcpPizHATKVgcPbqwRbKwlcws=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Rs+La6GiZX1/XTkesT57wQ/lu1AxmnruV/Z0EYCji9efvyyOv6+BXjUdNWW+KCbqvFtST9t4TRdRhijABI1yPi9pablvW/R9IruQF7i95VM9nywL6AvUH4NlLbWQPpXnLaK8zNPRpdHmw50suD5jd9elgvy9xblKS2EfilRy1PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+5sfnW9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B351D1F00893;
	Wed,  3 Jun 2026 01:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780451930;
	bh=4B3KvEc1dwO0ujpKZjsPorwmzZfs0UtyayL3dg0Jit0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=l+5sfnW9I+psIYVAHnfBUxg6AzMOz+5FBRafH/qS+Lm0TfTM3dsjbmAo3imnzJlYQ
	 nGvZz5lzqIWg41OHihB6R8SxevOXlYuoiwHavowZ+huQQaYQLBZ7cDNIINsTHiCTgt
	 kKafzuz5rY/triV+BUJBm1RwmA1zctPsIuhKn0M1NE/FDtl8GiSvGiFfAnEBvNRjEO
	 XKJ+iXSnfqnd/VCD4aUa3rTxarj8t65Bh3ZuWqn0hYJ5vcUk10HCSUqDZ8PcIO0pN0
	 NALjlnTyDZGdcvFcqg0Ptj4vlIBCPfhb7jkdVb5KK42fbd6r+LKn7qlGeHhCgaISbg
	 YvekgMjDUq2sA==
Date: Wed, 3 Jun 2026 10:58:42 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Andrew Morton
 <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, Nathan
 Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Dennis
 Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Arend van Spriel
 <arend.vanspriel@broadcom.com>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Vlastimil Babka
 <vbabka@kernel.org>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 1/2] tracing: work around -Wmissing-format-attribute
 warning
Message-Id: <20260603105842.1e0ef8cb4a55cb776d6a4971@kernel.org>
In-Reply-To: <20260602150904.2258624-1-arnd@kernel.org>
References: <20260602150904.2258624-1-arnd@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21663-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mhiramat@kernel.org,linux-rdma@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_RECIPIENTS(0.00)[m:arnd@kernel.org,m:rostedt@goodmis.org,m:akpm@linux-foundation.org,m:pmladek@suse.com,m:nathan@kernel.org,m:arnd@arndb.de,m:dennis.dalessandro@cornelisnetworks.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:arend.vanspriel@broadcom.com,m:miriam.rachel.korenblit@intel.com,m:mathieu.desnoyers@efficios.com,m:andriy.shevchenko@linux.intel.com,m:linux@rasmusvillemoes.dk,m:senozhatsky@chromium.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:vbabka@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-trace-kernel@vger.kernel.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[goodmis.org,linux-foundation.org,suse.com,kernel.org,arndb.de,cornelisnetworks.com,ziepe.ca,broadcom.com,intel.com,efficios.com,linux.intel.com,rasmusvillemoes.dk,chromium.org,gmail.com,google.com,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhiramat@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,lkml];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BFC9F63392B

On Tue,  2 Jun 2026 17:07:05 +0200
Arnd Bergmann <arnd@kernel.org> wrote:

> diff --git a/include/linux/sprintf.h b/include/linux/sprintf.h
> index f06f7b785091..036a247b7c1e 100644
> --- a/include/linux/sprintf.h
> +++ b/include/linux/sprintf.h
> @@ -12,6 +12,7 @@ __printf(2, 3) int sprintf(char *buf, const char * fmt, ...);
>  __printf(2, 0) int vsprintf(char *buf, const char *, va_list);
>  __printf(3, 4) int snprintf(char *buf, size_t size, const char *fmt, ...);
>  __printf(3, 0) int vsnprintf(char *buf, size_t size, const char *fmt, va_list args);
> +int __vsnprintf(char *buf, size_t size, const char *fmt, va_list args);
>  __printf(3, 4) int scnprintf(char *buf, size_t size, const char *fmt, ...);
>  __printf(3, 0) int vscnprintf(char *buf, size_t size, const char *fmt, va_list args);
>  __printf(2, 3) __malloc char *kasprintf(gfp_t gfp, const char *fmt, ...);
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index d49338c44014..4715330c7b6b 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -962,7 +962,7 @@ perf_trace_buf_submit(void *raw_data, int size, int rctx, u16 type,
>  	int __ret;					\
>  							\
>  	va_copy(__ap, *(va));				\
> -	__ret = vsnprintf(NULL, 0, fmt, __ap) + 1;	\
> +	__ret = __vsnprintf(NULL, 0, fmt, __ap) + 1;	\
>  	va_end(__ap);					\
>  							\
>  	min(__ret, TRACE_EVENT_STR_MAX);		\

I think this is a slightly confusing name. What about vsnprintf_nocheck()?

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

