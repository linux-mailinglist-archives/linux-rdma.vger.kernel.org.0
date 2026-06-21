Return-Path: <linux-rdma+bounces-22391-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6zQmDVjfN2rlUwcAu9opvQ
	(envelope-from <linux-rdma+bounces-22391-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jun 2026 14:55:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 812776AAC54
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jun 2026 14:55:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HEPnlA7i;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22391-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22391-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD2003012C43
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jun 2026 12:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A9C342510;
	Sun, 21 Jun 2026 12:55:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6733659EE
	for <linux-rdma@vger.kernel.org>; Sun, 21 Jun 2026 12:55:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782046537; cv=none; b=Hic/Tb5yfYM4nmXY81yNuAssUb/Fw4EKjYcluHrNXvShNoXM0f4Hdph03bY30qFXxsMmCqsofLDfWVIjZArHbN6MMJVK7i0rzInx1qVhyoTYnd+k4+bkRWC2W1KNUbvOyvnhhBfXOb37F7Xxail5t8+RJ41CRGzkqh2bVFbM22o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782046537; c=relaxed/simple;
	bh=FrBpf/gkssNS0FzrmeyqCp0e1iIN10xNwwkHFwdCrQE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UzzBQMfA9qo+Di7ZRTIOHn+FbQp85i0admouad8QiXXijnVSWPNK1oo3a9snUKtWLTVkFrIsYaCqgY8JTPswXA/2Lz1RhT+0cTLHaY8YhrGmgnioQqesG4AikAr7ClMahD7Np+k1R4GtFwrwQebjpKuNNgrTlvdA4zU8eJscghc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEPnlA7i; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49241a577d8so14568255e9.3
        for <linux-rdma@vger.kernel.org>; Sun, 21 Jun 2026 05:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782046534; x=1782651334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WU+6TPSMrQeQnOmPDKoUDmLIYSzXbxEWNqGQFFhaaZU=;
        b=HEPnlA7ilq5cBLXmRCRdE+fi/N7aST+SdfMD+MJXNx44EBemiG9rjXiFv70GGeXSoz
         OL+YA0wO4DZ+Vojg0dtpiA/+jHjShkgs9abDLGW3cDtqvdjyeSWyTCBZv9ntyUJ8YgkF
         2LlW/c9NPd35YBu9qUTAvTzk/cctdfAz/26y+X+lPsuttpW4Px8uT6A7LWPw6p25qqh3
         LN5ymox0l7svelgtmlOUVvfqkISw+y7pTMmkNCOhS+m102IwN1RYhV1E2cNi38XRGRkb
         7yoF60g0aJidx7f0xIQvNERu2I7c6x6JhnU0pe9CGHXzsLJzdkQSpMm4duLjoPK4meQd
         64yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782046534; x=1782651334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WU+6TPSMrQeQnOmPDKoUDmLIYSzXbxEWNqGQFFhaaZU=;
        b=riFAH34jGbArc20RSM2cw4ZYjleYxFkwy5JDHEHM1RDBHQuCBNcdw+P+q02qEJPBhC
         7tHAgBBBOOOKdSKaDpEh76305uwacaGnrDZE7g0/G/ddWoycErEf9/3YAQjKW3int2nj
         umS8nJUC5ugzU6yjXFm5BW1cVujSJdhECFcSakTMU/FeBXr6VGK3vCus2hNbLVSgenDu
         egphyQPsOCa2UFrBUo24i57elXGk9FbTZBFzOy2zU4dh/pXwjVnm76dhessNCe+RJ8xC
         MklMfpuh0lg0VaNOLxuo8ngmYH3JNpYC3OW+62HdNerLsATAy5zvcs5hr80n4lmcBf3T
         nCkw==
X-Forwarded-Encrypted: i=1; AFNElJ+Nf9NUZvFSNQVbeSM2rlgUMFeTo+XhY0UGT6kNq/dFZc1koZFFpgZ1Wtfmdc1lMgwV1vFuyoj0O1rY@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3H5b9BSjNetEhGAyriEaKLKDQ8LqFJLowjLy+0eW0XOlVc9bR
	mqcJ7iC0CU0BakSclMek3e5ONLsJJ9PXMcRdZe9mJIplsOx6Yl13T1mY
X-Gm-Gg: AfdE7cmKUy62gXbRL2BV+64EVPUbjXFTBGpHuXwUCCGszFHnAtUjDW7LzCscTj27pSY
	7m2qNR8CpNjZ45t4xrb/qQ9d2ZiaL3MCPbaZM3XLp8HtLTjndWn3SmYfpdRilQUdzYPbKHYh+h8
	rEdrDLLs6tZJwqbkF39fp7K5/AaF4MJTQWzwuq6MpHh5Qz50Km+IZvXDA7tzzOeAX5wZ7dm18sh
	/2RxqEFH/UUD0buxMAZlYGFoOpkiWIWgHwyMpdL3uhRQiuJ9pbvHDIzz8ZO7PVBhQozssWOiIXJ
	OAam1rlFgN37nX+wMwu1qA8hRVQ1wVla869x8VJ7qLgaOz4K2aPJRV6v/rXOiMXzZ41Uvii35Ec
	Q0MCICz/wo+kgkkXm7rlncYtmRI992K58IltLsfnseR2AFTdvrWRNLYv3C3nYfYqg6BtVbw70a9
	ZSTBlJBeSwWq+5DyRdB2qQZOM29FQkLo3kMpDccissKzeTelmtAg==
X-Received: by 2002:a05:600c:e547:20b0:48f:d5b8:5b07 with SMTP id 5b1f17b1804b1-49240e81b22mr113459545e9.20.1782046534244;
        Sun, 21 Jun 2026 05:55:34 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49249238900sm129230375e9.4.2026.06.21.05.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 05:55:33 -0700 (PDT)
Date: Sun, 21 Jun 2026 13:55:31 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>, Julia Lawall <julia.lawall@inria.fr>, Yury
 Norov <yury.norov@gmail.com>, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/2] tracing: Add CONFIG_TRACE_PRINTK_DEBUGGING to clean
 up kernel.h
Message-ID: <20260621135531.243375d9@pumpkin>
In-Reply-To: <87ik7cmcb7.ffs@fw13>
References: <20260621093430.264983361@kernel.org>
	<20260621093811.168514984@kernel.org>
	<87ik7cmcb7.ffs@fw13>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22391-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:tglx@kernel.org,m:rostedt@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:mhiramat@kernel.org,m:mark.rutland@arm.com,m:mathieu.desnoyers@efficios.com,m:akpm@linux-foundation.org,m:torvalds@linux-foundation.org,m:bigeasy@linutronix.de,m:john.ogness@linutronix.de,m:peterz@infradead.org,m:julia.lawall@inria.fr,m:yury.norov@gmail.com,m:linux-doc@vger.kernel.org,m:linux-kbuild@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:dri-devel@lists.freedesktop.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-rdma@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-ext4@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:kvm@vger.kernel.org,m:intel-gfx@lists.freedesktop.org,m:yurynorov@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,arm.com,efficios.com,linux-foundation.org,linutronix.de,infradead.org,inria.fr,gmail.com,lists.ozlabs.org,lists.freedesktop.org,st-md-mailman.stormreply.com,lists.infradead.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pumpkin:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 812776AAC54

On Sun, 21 Jun 2026 12:13:00 +0200
Thomas Gleixner <tglx@kernel.org> wrote:

> On Sun, Jun 21 2026 at 05:34, Steven Rostedt wrote:
> > Instead of having trace_printk.h included in kernel.h, create a config
> > TRACE_PRINTK_DEBUGGING that when set will update the CFLAGS in the
> > Makefile to allow developers to add trace_printk() without the need to add
> > the include for it. Having it included in the Makefile keeps it from being
> > in the dependency chain and it will not waste extra CPU cycles for those
> > building the kernel without using trace_printk.  
> 
> IOW, you make it worse just because.
> 
> With the header being separate I add the three trace_printk()s and the
> include to the source file I'm investigating. The recompile will build
> exactly this source file.
> 
> Having to enable the config knob will result in a full kernel rebuild
> for no value.

Indeed...
Isn't trace_printk() just an extern?
Having it defined somewhere isn't going to make any difference to build times.

	David
 

> 
> Seriously?
> 
> Thanks,
> 
>         tglx
> 
> 
> 


