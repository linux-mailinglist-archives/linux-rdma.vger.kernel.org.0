Return-Path: <linux-rdma+bounces-22394-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wI+FFZ3pN2pTVgcAu9opvQ
	(envelope-from <linux-rdma+bounces-22394-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jun 2026 15:39:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A95DF6AAF42
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jun 2026 15:39:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=WjSFBVc+;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22394-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22394-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E723E3016CAA
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jun 2026 13:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D4C368264;
	Sun, 21 Jun 2026 13:39:20 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E1E366049
	for <linux-rdma@vger.kernel.org>; Sun, 21 Jun 2026 13:39:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782049160; cv=none; b=qcwweP9ttc8hEZsrLns8yudn7WCaaUqqauZ/U/DgWD+K2r28WPZ6jPqMdZ/REih6pKtvRUuVOumBGzItfRD2VL2yMdVLTz/iRo7NYBXvHttF+E+0foIu1732EClst4CsS3VB5TmXDShrMVyVb0m+1EhE/caOXd2cFK4LZz5kqGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782049160; c=relaxed/simple;
	bh=PcEURl2W5mmzOY49oIrDgC4sXuUKEmnXJC+EqHFqIx8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXHrCq0mz4ZITMSrlXZt0c4+eRF04D1tAYnQcMALL3EugwlN+g5WpwLhfns6HFE9/WHnIfcgaACiGEGMXO3Wst+WRBEf+IcbY0kxSudCVDHdx1J8ckxiFTObBYE89EKTwW/Vbh7ZCjVAKtJcG1OMFA2grVroTSEX0vSgUe6ZM7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjSFBVc+; arc=none smtp.client-ip=209.85.128.172
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7dfceeaf168so43955017b3.0
        for <linux-rdma@vger.kernel.org>; Sun, 21 Jun 2026 06:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782049158; x=1782653958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YUsaj7vv5ecLJDUQ0RmLhOH3YlF5lnncSJLJl2FpGbU=;
        b=WjSFBVc+x5PQ4eaJ0Sgq53AeKSuFVqLUXt1bdNxYWDgfM9Gd+cbZm9xNx6j0EHdJPE
         HTww0TPxeWims2viP3NLoABiuxw4YJbyhjsaFbiCmT9CUzuiOMJBall4Ny5+a8n3JoxL
         RAbWijGhJB9Y959HS7qnPSGQSXUMVj4DJPBFAQ54uygppFKbaRn/JaF2eVX9T+oKy55s
         5UuvzBs3n9atksSgvIo+LnDIY6WzFlP9VIiHQn/cekRGZeQ/fCZya9JTR/7Go5adjR4K
         RgwOPTOQfje4Iq1ypeW2heg3nQ4ZNXcxpe/8Sn+A/ACOrH9r4nxxn0LtXIlC4IPvBREK
         JbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782049158; x=1782653958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUsaj7vv5ecLJDUQ0RmLhOH3YlF5lnncSJLJl2FpGbU=;
        b=rGX7pZQJ/UPgHyqplfR2uZbZRLwwXACB3Y2epHgwM/7egmFoyOpkPr5GGicGky9xk3
         MviZtbxyqFmPPDCEBjGuxoXANM0psYuDpRhbXbjqIPSmt1Qyx8rAx5VdBUHKEK1zMlXZ
         NNoBSiGjolSuP9agg+/6V73T/dePdIZxl/aBvtd8TtRuwFauCNLTpkk6TH2XiYVSzjFd
         L7K910pNE6wSTObx5C1y+XeSPl3GzemIjOFEyuY8YJZrEegcI7wo0IwHOr6BGxrjCKzb
         7UzuPglA2vPgIrGP+0NhcXvOGfxUPX1nPqNCibK5YP7Mg4b2fVCmi5N+xuso/U/Wb9zc
         p0Jg==
X-Forwarded-Encrypted: i=1; AHgh+Ro8BH41XQkOtA1ipD7I5Y5XhebTAFaX6qctCkEfRRlY/iK23ngrFyn2Smqh7L3cjg6oZ+W1lCmwy0yG@vger.kernel.org
X-Gm-Message-State: AOJu0YwxSYAR1YRlZh3P5o+8kMCIRHocKwEjlG+DD1jSsbWjTnuqZkQh
	Jg39PXAbOkzpO6wDr6lW7TC2eE65/d5a4rThFR8KJKPz9J0qLqpVL2ZdzMzrdg==
X-Gm-Gg: AfdE7ckq8QrtQa37B1VCtOxvnCMOCFTKdLnG22Cr6mpK1/c7pvi0O96hyaVn7dX4xWW
	WyHsXUk8a7OsLanXO2nMwpCB9Hk69pXkfnynfGFAXnbQdWeUbfxsGVoXr4De4S1uKb1uKkrWl2F
	ooPsJZ72So9SKbw9HE1Ax6Fj9kyMxloxWxsf52ctT0OVZJ0g/Ri15wJCtRZe7C3ug+lTaWp48tV
	sCZMEgvYJC3gJNQXXGk90PER0SCnVu+O5wyDIo8FQ+EGvKn5RFgRovnRKQnLrlljDuOIag+KVg/
	7um4WINOy5SOZ5T4yN+584Kzo3Wsg8Ro6x7e6c2REnpT4sKHmjdrp0qmQGerED9FrDGJR3S/wiu
	+kONSTGZtJWw3X4LJqqm3RMb4KeWNT72XGwgwr6L3ju6FkaMWxr7PVIZm4l3PJ+MZqMeEpT8L43
	EYlX8xZF6UcrLnoKKR2MC9qA1eRL/r8UD8OZo=
X-Received: by 2002:a05:690c:e347:b0:7db:ccda:a409 with SMTP id 00721157ae682-801759e5070mr88778787b3.9.1782049157948;
        Sun, 21 Jun 2026 06:39:17 -0700 (PDT)
Received: from localhost (user-24-214-85-55.knology.net. [24.214.85.55])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025f8dde30sm20893067b3.27.2026.06.21.06.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 06:39:17 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
Date: Sun, 21 Jun 2026 09:39:17 -0400
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Julia Lawall <julia.lawall@inria.fr>,
	Yury Norov <yury.norov@gmail.com>, linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
	intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/2] tracing: Add CONFIG_TRACE_PRINTK_DEBUGGING to clean
 up kernel.h
Message-ID: <ajfphe4Z8BrfYoUX@yury>
References: <20260621093430.264983361@kernel.org>
 <20260621093811.168514984@kernel.org>
 <20260621054721.7cde38f0@fedora>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621054721.7cde38f0@fedora>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22394-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rostedt@goodmis.org,m:linux-kernel@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:mhiramat@kernel.org,m:mark.rutland@arm.com,m:mathieu.desnoyers@efficios.com,m:akpm@linux-foundation.org,m:torvalds@linux-foundation.org,m:bigeasy@linutronix.de,m:john.ogness@linutronix.de,m:tglx@kernel.org,m:peterz@infradead.org,m:julia.lawall@inria.fr,m:yury.norov@gmail.com,m:linux-doc@vger.kernel.org,m:linux-kbuild@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:dri-devel@lists.freedesktop.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-rdma@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-ext4@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:kvm@vger.kernel.org,m:intel-gfx@lists.freedesktop.org,m:yurynorov@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yurynorov@gmail.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,arm.com,efficios.com,linux-foundation.org,linutronix.de,infradead.org,inria.fr,gmail.com,lists.ozlabs.org,lists.freedesktop.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yurynorov@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A95DF6AAF42

On Sun, Jun 21, 2026 at 05:47:21AM -0400, Steven Rostedt wrote:
> On Sun, 21 Jun 2026 05:34:32 -0400
> Steven Rostedt <rostedt@kernel.org> wrote:
> 
> > Instead of having trace_printk.h included in kernel.h, create a config
> > TRACE_PRINTK_DEBUGGING that when set will update the CFLAGS in the
> > Makefile to allow developers to add trace_printk() without the need to add
> > the include for it. Having it included in the Makefile keeps it from being
> > in the dependency chain and it will not waste extra CPU cycles for those
> > building the kernel without using trace_printk.
> 
> Bah, I only tested with the config option enabled, and missed some
> dependencies with it disabled.

Yes you did.
 
> For instance, rcu.h also uses ftrace_dump() so that too needs to go
> into kernel.h.

No, it shouldn't.

> I also need to add a few more includes to trace_printk.h.

> OK, I need to run this through all my tests to find where else I missed
> adding the includes. But the idea should hopefully satisfy everyone.

If you include it under config in kernel.h, to make the kernel buildable,
you need to include trace_printk.h explicitly where it's actually used.
IOW, apply my patch v4-7.

Then, developers who use trace_printk() on their development machine,
will be really frustrated when their debugging code will break client
build just because CONFIG_TRACE_PRINTK_DEBUGGING is disabled there.
They will spend a day, at best, communicating with remote managers,
and end up with adding #include <linux/trace_printk.h> in the files
they touch. Is that your plan?

If I was one of those developers, the solution would be simple for me:
don't use trace_printk() at all.

Thanks,
Yury

