Return-Path: <linux-rdma+bounces-21934-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gSqeNXEeJmoESgIAu9opvQ
	(envelope-from <linux-rdma+bounces-21934-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 03:44:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3119E65221E
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 03:44:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=TfWiL3IK;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21934-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21934-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 826C7300AB31
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 01:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5668A3064A9;
	Mon,  8 Jun 2026 01:44:13 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0297024293C
	for <linux-rdma@vger.kernel.org>; Mon,  8 Jun 2026 01:44:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780883053; cv=pass; b=Sh1UsAqkatBiA8LLF+vfkAPjcC+t4tiOEXYx/5I74i0nBjopHzZpRIswgAMjZuSNqVT7S6kKTG7zyGyS0X/JkBVYmJCjE9XiyRiOYsC6rFRoLZFf/feIpQAwOfAlCgpSw8FW8dngnV9wonnLnS7iQ9Ap4M2H00/opwpoY0hDIJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780883053; c=relaxed/simple;
	bh=m69/45OncC8Dt3QO1Dj3pWSaWTIMAInHIkhndU4GmrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WLaEMSIFJlUOdkmHhUFlzyGqFaS25pZ4Mc8mqgup8rye9bUdIx0c3jgx2o2fLpks8GwFGeGRknrUzwh2MN02lroww0VbuK515vktOntkG/MCCKTupGNpOUqje6R5yiwux/Mb4/2GZH6JKeIiMydpybx5CWBXWmgNxO2aK99Fs1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TfWiL3IK; arc=pass smtp.client-ip=209.85.167.174
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4864a5c83f1so2462364b6e.0
        for <linux-rdma@vger.kernel.org>; Sun, 07 Jun 2026 18:44:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780883051; cv=none;
        d=google.com; s=arc-20240605;
        b=ZztOz9KfcKX4uXhR74Oix9PJQhlTCa7WDZBSx1U5IcyxpEhr3mrOub2cAycKDJG5YO
         tL1Y8/O3s8hS540TxunqiSvX5Pn2nHrcEt2QXrcV/k0IFLbTBPr+Vyj9BuXtXhYHKE/T
         UOMbPWiljhcOsAoOJ2OL07r9mT6aNIGDOcOl83EqGDU4nSJ3GZunZ8KjhHbVoGuIxlm7
         3zz4OnoziIA/5spKlEhk/OLHdR2HA1AHD2hHG2IVDLdsvOVTn7U3E1P/7iR/R2o1qms7
         6WFsNeydToWVeIryr5L/g6iCszCxev1/OF+/CuxfLMi5c/JVcG15VOAMTF70IB5QJm1r
         U//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=m69/45OncC8Dt3QO1Dj3pWSaWTIMAInHIkhndU4GmrI=;
        fh=6AHw2SHuBOchcD/sYnennnTPebt84bRLXTZ907sre4U=;
        b=IL/YS2FNiHJqoOxTmW5u5s0T+YNNf+er4pVADAnGDS4M8ZO++RUAzu5pSExHsmqs3p
         tbDINf+9UyOjm701EbDk9Vp0uwBZU36B/KvcCNi1IywbNeG5LjvJtysrBdSaHfRjRZl/
         KXReYicFbXd/rhLHcMF+sfYidWimMyjCPhUkG8fGA6wc8/KLaBxK6yA1H0AKw1Y9APUY
         V92a217CKfbnh0SRaFM91ftnv6I78rTcOponiSvpPo1GZJPcXOP1NUpZURtS47Bz/4AS
         6Hwf7OMMc8wPPJSBc8fRBZDdkMW2th44fkBCZMy5FDMKRERx1/Grj7oXbUStfiehyx7m
         Dz/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780883051; x=1781487851; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m69/45OncC8Dt3QO1Dj3pWSaWTIMAInHIkhndU4GmrI=;
        b=TfWiL3IKZlDeLZKMRv1VGuH67P9OdIL3rYWKuugCYuzkjLvnYowZtrEbvvY3OncrNb
         C4ZQ3uFYbbc0AdxQkK5nkm8v61UDw+t5oE1s3gp0xWRRd8m9A9SuYgK3Gf7Zo1/8JSA2
         TZhHwtTRp5Vtm7GpNfFETaqijbrhrhf43cpgq7HS8pD3K6g8vmmtXHy9aS4rfZGswB/s
         814QuJlTlB10WI/jTc39v4jZMT25ei3bBBv57wjgXGpmWHzwH2KOCeL7otV9kGcahpDm
         FOiPOWYKhTJ4A6Qi5sqT1ALAfR5Ymy1AtfIrevgMR0FeZ/lJCFB/TunQ/vdcxoJsw/si
         kV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780883051; x=1781487851;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m69/45OncC8Dt3QO1Dj3pWSaWTIMAInHIkhndU4GmrI=;
        b=MFyCtFgjknf3zk8TrzZm19OxDCt7W83x7qrByJ4hmnA/D0d5JOkpG8oTFSJonvuqu3
         EQOFA6RTvZRHDawfUZBq4xdWQ1ugTI1a5J4fLUaeQUi4fYCUS3+fmzOZ9hmWVgYJb8Sg
         JHoprAIjw6KykTcZb9zDvkYRAqUqIhX4aOiIDVdFkGsgbynw4zeEJL6kBDUXOGW60Qe0
         Ev6xn9HlnYPHSSEKmSCh+vQMFJmgV94M1Mg/ZcEzw30k8mVf47rFihMG9JrjLuI1ofLS
         JghbinH8Qyq+ZTmA0rYWMmBAyegCtj+Rui/lpFPTp4x9B1SqiEKQntyfs13b3rm8WVSX
         OD4g==
X-Forwarded-Encrypted: i=1; AFNElJ9kgM6nydjsCp2DH2RovgY4oL2JppkmtURutbPlS9vLqnPAc3tWyr6P3PEOoQz7zpY/FAqz9819tg5C@vger.kernel.org
X-Gm-Message-State: AOJu0Yx80yhHvB/ULBjN3uW3m1MFXSQaTo6Fu2QKgTvwWRzSPoyQhzDP
	D6vutiqnN0j0WGI8P1AG5KRU4n36BVGGYS29xLbc4M/Pxf6xm1kDeziA1I9e8kTIFmjED5+5Szw
	oPMFWCHQmyqCaacFtUgRHag6NKCLucpYmUvEj4+hq
X-Gm-Gg: Acq92OEuAQ/gUxwstKB0URBcxWg/qBCKJG9N+8kKCy+XWr6EaTVeyMRDi7qzHLd2snH
	HsnEA3BNpolKKSEqfbrHQIq7FmhcbZS8GPucaPSL+EDfmgc4aVhzfuUz7O+y1uN6/g8sC8wvaEh
	TF3Y8gxQVSx7hQ4x9Fw58v1ZgquzX1sbc/JRk1ZgV/J/xQPHhkzmK/L83mYSfmG4rl9YnsdOmpU
	qdCepckgmM8zMhFOuyKh7/nDhbLnUkd10+3YudcRaEuKGBAYLxBW3T2+uSl4YREziIeDb4Ea03/
	Zhv9O4wAAKY/lh4A4XQ=
X-Received: by 2002:a05:6808:1b09:b0:479:fc87:27ee with SMTP id
 5614622812f47-4868dc00f20mr7660451b6e.1.1780883050289; Sun, 07 Jun 2026
 18:44:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602214423.1315105-1-jmoroni@google.com> <20260605171137.GA2771195@nvidia.com>
In-Reply-To: <20260605171137.GA2771195@nvidia.com>
From: Jacob Moroni <jmoroni@google.com>
Date: Sun, 7 Jun 2026 21:43:59 -0400
X-Gm-Features: AVVi8Ce9wVEKxbPWvyrhNGdNDi8Y8kDBrR7r1t5LLxWGt-pXQ5rRbYFhsVaC5nU
Message-ID: <CAHYDg1R0ahtKWLuvv3P_RGP0oij1BW8B1Ebsh4bVn7ypz-=z+A@mail.gmail.com>
Subject: Re: [PATCH rdma-next 1/2] RDMA/irdma: Remove redundant legacy_mode checks
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: tatyana.e.nikolova@intel.com, leon@kernel.org, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21934-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:tatyana.e.nikolova@intel.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3119E65221E

Thanks!

> There are more sashiko existing issues:

Yep, Sashiko is keeping me busy. I will take a look at them as well
as the findings on the rereg_mr patch.

Thanks,
- Jake

