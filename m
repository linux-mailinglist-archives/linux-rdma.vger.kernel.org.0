Return-Path: <linux-rdma+bounces-21683-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z6+7BNQpIGovyAAAu9opvQ
	(envelope-from <linux-rdma+bounces-21683-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 15:19:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA01637F93
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 15:19:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arndb.de header.s=fm3 header.b=F3KciT6N;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="M ff/BpC";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21683-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21683-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arndb.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDD0530F343C
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 13:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6149D480DD3;
	Wed,  3 Jun 2026 13:10:33 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9551B480DD5;
	Wed,  3 Jun 2026 13:10:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780492233; cv=none; b=lr5Eb/KIgIbsf+23BqAaA4087GSSU+wJeGKF7boqsw398Ny41KigfBi28gwsFDAjLBQazDnIopQqr5VbCTunPJue26BLVZ1db4bX1ZykgCV/XsNEPE2reNPZqLmCYtC/TBcF5VgqvknjCPx4D79B+lf77bV93PHQElP1+vvDB0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780492233; c=relaxed/simple;
	bh=lP5QJJuOKglyx6J1a/8UfKNOxuYG5diuFX02YWZfKq8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pep3LK9pL7WFoSZhteO8TifYGwlgR6eP9YHiAgX8hAIFZIja4V5Lb1C+Jzon21KnCeRIQI/vOczuTQYj3/QZBv3wnLaXLS4C543n2HzuoRNrHogvbN00mZGR5sc5o4h3AIUZsyMVwowgbxfvitSiiSZ9IXZMxPuGR4IAVNWPs0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=F3KciT6N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mff/BpCg; arc=none smtp.client-ip=202.12.124.150
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id B60D11D00128;
	Wed,  3 Jun 2026 09:10:29 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Wed, 03 Jun 2026 09:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780492229;
	 x=1780578629; bh=hpoZBeoqCBQo7mAwIGX+VUpxekz9pKp5gQJBK1lkg8o=; b=
	F3KciT6NrD+ji5UyE7NaDKKwT6UK82bXiTiXFjsndeUfsTMobOfKq0l1D67QYNEy
	2NPwnO6ciwqBwpqBqY4sqvtO1TVKpj9IZAma2lSLtoAH5E8XOtRVBf8KlrEZ1yEE
	8lN6LUELviBRHnePhmpfSlGrke84iY+j7L72TNdZOFHFWNpvz2O7tfZIe0p6kua5
	bUTmc/Q7QGm/HqKD11lifrFEj/jxx7gB8gixe2aVY3Hl5FECFSn1Z+ikr+mYJo5C
	BlThVfY71bZuTJEW4SuiIUXZH2xC+CpwYDRDBk0fokg28HaHNgtJcwY4AojMXHb5
	F3V9KKEM0KgcZBoiwAITog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780492229; x=
	1780578629; bh=hpoZBeoqCBQo7mAwIGX+VUpxekz9pKp5gQJBK1lkg8o=; b=M
	ff/BpCgKMM1gIOV5TbDg9K7LrT87oRexzi3PLrMsfd9iz8SGLH1RMPwvrq4NT3Og
	QuCKsFMz/Jmpqs2lQVLV/i8mk2r0wJH0UuzwIKX38HvNsdaxVipXEWrSqlgUgWec
	gL0oALRMOxHyNU+C9MW4InRC7cPTy7CeVH9nWYFSN9MBBT2BY9EfayXvdHzL0ew+
	zk3rJ/pze6Qy0ocjYn0YbJIwGaGJwQZ1EckdJf8t64hr0+6dslMNrroqfhgr+fXG
	T69DBZ8oppJ/lWbZDuoOtnxlU78NnycizjpngtlOwN0eM4Pti7Xt654mo31A+fEv
	AevPWXBZgU3nNz9Hsut9w==
X-ME-Sender: <xms:xCcgancbYdIJxA2kLOi-Yrv5wSyUnpVlkJVhzh0-wuwY0IIBFGKZAw>
    <xme:xCcgaoBvSDGwrpu8DShO4mxcB7GnrrZKV3idLJiL1LQAyktqGo_Q8F5V9rWw74zQu
    rQcHj5y32C2wqnc4it-pSvBdLTuCvLYiS70xQftoySFkvs4vwoGdTlm>
X-ME-Proxy-Cause: dmFkZTF4ka3SKL2vrKeBSM9FPU0Ph/VV7ezdSdxFeAlzlFV55Klqpm6ZoGacaFoc7M82f5
    jSMoYK02niDMu41PFS5tOBUIRTq8DGsnl+kYTBT2+HORgCtExVQYwu6wxu5po7XVBukCRQ
    29SLEbyCLD7Hu6ISZm3wJZZy4cOz5x7g3Q/2kqaa78yfzUfxtoww6NB2GTfHC7Q10Qau10
    dSwQsfCYLl5UHZlsoLdQ5h/Xv94PQuBm6uA/QUqE00uDiogCSatz/eLdXghfD6/F9/oZYl
    GToWb6Z0tyi7XTWeCDC+wFr1Fxkv0vfv2GrwVkBBiz0U6wbA4So+dbmM/nRArlaseBfIDi
    DKJIrfdWCXHJFTM0xrU6jArXzIt6T46ho3j9kWvWjFBaDeyAWeKGQ91Oy87Hlk1KEoXxss
    7Blw89fUCkrSwnnsJvB91K7KyWhkQKhVygB2i6gzzLKEF5W5c/4LBYzjJjEdKHUt/SxAUM
    FfjGrEyG3qvangKeiHcn0tlQC6cyDgZOyfhQE6vLLN6GMF4k+9NbexQmKCQ9G15UMxEUoa
    tRSBC2RtXNtvY5/axdoL7HdGDhAzcaUX3CQ5up0V0Y8ysxsTDjKh7FwPNcZSkd+h2BBnN3
    f7+LJpeUQl2PmrAFvnnM7eaEQ3+kGVyxx56n0aGDc9IZ1HKmdA+WzQ+1IoJQ
X-ME-Proxy: <xmx:xCcgaofSDyLnnnmE-mie8dWjmd7X3SW7l-VdL6N64NbAy6nN5N1tsw>
    <xmx:xCcgajgftM9BAeD_-K_XBFKzszaDTuxHSkcVeT-Wjw1fTqbv2wohRA>
    <xmx:xCcgahgEL-VGOfzztO1j90UsaTncaJPjG_x2_BlxN0WNabSurUomNQ>
    <xmx:xCcganqt4ax3RT6HA5JGuPcDkpukiqvIJWYln3HLDMLo_r_foGzuyQ>
    <xmx:xScgaiKUnLEa6xEnE_yCG4oimQnaJDbN-amSkJ1LFukCkv6LBj4_BwLp>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 55D041820082; Wed,  3 Jun 2026 09:10:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AAuCPBQLA6as
Date: Wed, 03 Jun 2026 15:10:08 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Rasmus Villemoes" <ravi@prevas.dk>
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
Message-Id: <e2445810-20ae-4384-a485-259651143f05@app.fastmail.com>
In-Reply-To: <87zf1bhjqp.fsf@prevas.dk>
References: <20260602150904.2258624-1-arnd@kernel.org>
 <ah8n-Nk305S5hRwN@ashevche-desk.local>
 <WPQQfPHOiGJbSxrXRdFDy9jURhS7JMpNu9sD54Vfe5wB-JOjyGY6xPQyACz3MSGg0xGp79eOYCyZ2Hi2CsPeUg==@protonmail.internalid>
 <35c1ba62-e74d-4abc-aa73-ccd35968ff89@app.fastmail.com>
 <875x40hz7k.fsf@prevas.dk>
 <cODLVx6ZlerCiOgdpsG7OSsC2YRA6pXmq2jBdTjRB2UQoTIY4hI-yhV1lrumRNBH1hTT2aJRS-MgtlbhNWUTEw==@protonmail.internalid>
 <aafe201a-64a6-438f-89a3-d1cd10a357a7@app.fastmail.com>
 <87zf1bhjqp.fsf@prevas.dk>
Subject: Re: [PATCH 1/2] tracing: work around -Wmissing-format-attribute warning
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21683-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ravi@prevas.dk,m:andriy.shevchenko@linux.intel.com,m:arnd@kernel.org,m:rostedt@goodmis.org,m:mhiramat@kernel.org,m:akpm@linux-foundation.org,m:pmladek@suse.com,m:nathan@kernel.org,m:dennis.dalessandro@cornelisnetworks.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:arend.vanspriel@broadcom.com,m:miriam.rachel.korenblit@intel.com,m:mathieu.desnoyers@efficios.com,m:senozhatsky@chromium.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:vbabka@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-trace-kernel@vger.kernel.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:dkim,arndb.de:from_mime,arndb.de:email,vger.kernel.org:from_smtp,app.fastmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6DA01637F93

On Wed, Jun 3, 2026, at 14:49, Rasmus Villemoes wrote:
> On Wed, Jun 03 2026, "Arnd Bergmann" <arnd@arndb.de> wrote:
>> On Wed, Jun 3, 2026, at 09:15, Rasmus Villemoes wrote:

> I don't remember what minimum gcc we currently require, but gcc 9
> introduced another attribute that is apperently meant for cases like
> this: 'copy'.

The minimum version is gcc-8.

> This seems to build:
>...
> +int __vsnprintf(char *buf, size_t size, const char *fmt_str, va_list args)
> +       __alias(vsnprintf) __attribute__((__copy__(vsnprintf)));
> +
>
> That at least should handle any future "gcc knows this-or-that about the
> vsnprintf function". But I don't know if clang supports that copy
> mechanism or if the minimum supported gcc is too old.

clang-22 and gcc-8 don't like the attribute, but also don't complain
about the other mismatched attributes, so simply using the __copy()
macro we already have will work on all currently supported
compilers and likely all future ones as well.

      Arnd

