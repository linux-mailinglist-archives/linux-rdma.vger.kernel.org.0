Return-Path: <linux-rdma+bounces-22419-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /YaiJj42OWqAogcAu9opvQ
	(envelope-from <linux-rdma+bounces-22419-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 15:18:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 378926AFC01
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 15:18:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="k/i5uTze";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22419-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22419-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA4C03056AB7
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 13:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630E33B14B5;
	Mon, 22 Jun 2026 13:11:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FAC378D98
	for <linux-rdma@vger.kernel.org>; Mon, 22 Jun 2026 13:11:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782133913; cv=none; b=i8lFmVhbHdEI4RT8EQ77QH1vF8qRPvzFKMij6aXkHKMF+pkU1ZicM/Qr5xek6HkRlJ1PJsHkIdq1+Nvd4ox0ZvSEb4E5zK0Ll3aCQrheIK/xfikM716IYFv4QyDJbi4mdAhqlVgOsgIWIoyUnitZMSoDihDkNaDE/Lm/j5xmiPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782133913; c=relaxed/simple;
	bh=HQz5Bgb9Ix6CxIn/K74tfrlANhIDMynRIFpNpd4eCGE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9/iltRR7zu/SavVswJ2ioc14sON18PqPCBkSAR8oSKuo1uBx8DIioJGeSx+ZRMaPhLs7nxj3IqgXLxYnPVbHewYoC6joUxDaBgvEYbijDDSLXKGzuQdCJqX4SlE5vNhAadVchBP99Pa/Jsljj9iSTHYf8U10L5/tpMbAj6sWG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/i5uTze; arc=none smtp.client-ip=74.125.224.50
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-662bb8b1f93so4130291d50.1
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jun 2026 06:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782133911; x=1782738711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XkaEWxUJkCuHp/17+ud4oWXJ3qqAKnltzqopfMTtFIs=;
        b=k/i5uTzeJQR4+7Wet36cQgSo4sxL7JHnWkI80+xtkrP/9oBTFyHZ8X3t1Q2CnMTDp6
         Psigzn+fygxUIibpKJV8vugNaeMafjx2dbtYSsLvity3z1Woqbw59/7qieJHFyH4Adan
         iIRyDi8CMOCz/az4EFMKhiAYGCpfEhizDTOzb65ymOvZsLNvI1F9BvcwvMSLbbcXXmc6
         lyPBLK7m1zPmKDIwdT1nVVOesfeemXdJZa83ea/kP7geAEZB8UZ24UFkA43weVCRdqNX
         kqhXI7Jym8KGVdZHNk1qUH7mqWCLBnaTI9Bl96kF6LQYh6lfzYB59dUz5+jAHbpHTf5O
         SP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782133911; x=1782738711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XkaEWxUJkCuHp/17+ud4oWXJ3qqAKnltzqopfMTtFIs=;
        b=E5vXcojgBf2GpEpFzcCqF11sGM6+w9kJ6jARLSNLdpE7nqqNjSxpYGR29/5+IxMp0Z
         oC5z6xxdFQ2NVyw+WLlCr71k9wKhwopWUtf7OG+egB2rDjNLAtaHX/jXvJ40y5UI/Tia
         6ndyT8u6yWTUqDPoo8o6OO+IJh2OjvPprfWizzQ3g/6A6WL8P0V/qfH2UhfScgndHXJZ
         yxQHuFOMKzAAOLDy+t0jJ3HcI5bNW0C1x7tOLt6rh+6hq2RRXzI5Ne2uWIVBS/Lz5daU
         d+6tciLBTVUMpsxsornl14oS5wGHmT+vXNc8JIX+OA1iu0qkPI86U1yXbixzC7M6qnye
         NkYQ==
X-Forwarded-Encrypted: i=1; AHgh+RoSJ6Kslkgna0EslN1meiunYE5IEBtwytjU1UkCF5a3qYMje6urZov3SV59qeisRoVgJrCU2AtSXtEk@vger.kernel.org
X-Gm-Message-State: AOJu0Yy97GAiF04KH8HzsSFjaZlIn/F8FIoIcM+xaFryA5PchXngfT+R
	ceuhBp2BJb5a75k2KWgJ0vnZsgauo+FTlhXH1KHmkpEb67zA9RWQwIdO
X-Gm-Gg: AfdE7cl5xN/XYx8rIGtOhjRang0PVlTeYRPmK5oGk8Ov1CAXpak/JXlrmzOutAwuHoE
	Wmqv5oxMeEVuUavSxXjsj1frn5H/iJUoZewq65TPscgnmoTQ8zvqR0SEN6zsYkJvAZwy6hKezhz
	NjCEgCH/erqWwo5YI2HY8EqJblzydZRAhINSrEyNkbvzReMnZDOuc2YLHhASkVdn7VNcyrOk8+o
	jbjGpJkIfMd4DVz5es1dty2KHhJH+/10miPSgRxvNwhjgK9t1qqbF1aNQ6zknq1FmE9GfOizlxN
	ufW99YPWSf4owWkyHGdmYYUr76LB30IIiLDKdSG67dOQ66CnUdwmwSuaigv7nXqX3QUX6GN3FSi
	mvVu/UHCfLb7dXUeyqsKTxkiPHsnkc6u/ST0xXoDksCh00XxYgg1QrImEoap6hon4I07SEtEDCS
	dK9goyQMg=
X-Received: by 2002:a05:690e:120c:b0:660:54e4:5dd1 with SMTP id 956f58d0204a3-6630333ac1bmr11505521d50.44.1782133910591;
        Mon, 22 Jun 2026 06:11:50 -0700 (PDT)
Received: from localhost ([38.101.158.131])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66314ac3f96sm3600882d50.1.2026.06.22.06.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 06:11:50 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
Date: Mon, 22 Jun 2026 09:11:49 -0400
To: Steven Rostedt <rostedt@kernel.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
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
Subject: Re: [PATCH 0/2] tracing: Move trace_printk.h out of kernel.h
Message-ID: <ajk0lT9P0SeuD94j@yury>
References: <20260621093430.264983361@kernel.org>
 <dbb5915e-6587-4de9-87f3-76bea5024da8@kernel.org>
 <20260622090826.20efadb3@fedora>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622090826.20efadb3@fedora>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22419-lists,linux-rdma=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[yurynorov@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:rostedt@kernel.org,m:chleroy@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:mhiramat@kernel.org,m:mark.rutland@arm.com,m:mathieu.desnoyers@efficios.com,m:akpm@linux-foundation.org,m:torvalds@linux-foundation.org,m:bigeasy@linutronix.de,m:john.ogness@linutronix.de,m:tglx@kernel.org,m:peterz@infradead.org,m:julia.lawall@inria.fr,m:yury.norov@gmail.com,m:linux-doc@vger.kernel.org,m:linux-kbuild@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:dri-devel@lists.freedesktop.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-rdma@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-ext4@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:kvm@vger.kernel.org,m:intel-gfx@lists.freedesktop.org,m:yurynorov@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yurynorov@gmail.com,linux-rdma@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,arm.com,efficios.com,linux-foundation.org,linutronix.de,infradead.org,inria.fr,gmail.com,lists.ozlabs.org,lists.freedesktop.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yury:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 378926AFC01

On Mon, Jun 22, 2026 at 09:08:26AM -0400, Steven Rostedt wrote:
> On Mon, 22 Jun 2026 10:05:13 +0200
> "Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:
> 
> > > There's been complaints about trace_printk() being defined in kernel.h as it
> > > can increase the compilation time. As it is only used by some developers for
> > > debugging purposes, it should not be in kernel.h causing lots of wasted CPU
> > > cycles for those that do not ever care about it.  
> > 
> > Do we have a measurement of the increased compilation time ?
> 
> I believe Yury does.

I re-run compilation is a more strict environment, and the difference
is negligible.

