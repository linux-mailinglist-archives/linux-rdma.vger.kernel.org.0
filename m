Return-Path: <linux-rdma+bounces-22975-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E+cFOHj2T2q7rAIAu9opvQ
	(envelope-from <linux-rdma+bounces-22975-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 21:28:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B6F734F55
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 21:28:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=shazbot.org header.s=fm1 header.b=fxrIC1xq;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="f o0u8uw";
	dmarc=pass (policy=none) header.from=shazbot.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22975-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22975-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 367E1304B692
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 19:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395C53B895F;
	Thu,  9 Jul 2026 19:26:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD1E3B4EB7;
	Thu,  9 Jul 2026 19:26:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783625168; cv=none; b=tcrajhyvZ9qGFf3xzmG8wU0P5Ij+cR8uXMort9rJwNsMmv2vgu98Op8YN/kkUj7fdCglr50g2vJnAdi8sbwb5QRhCjXz18uZ9QZsnEsXhg5eaeLzNyYFbcQyyqZHj8xhF4TpM0lCzBSxg9wEiFIf26fRO/NaKfKlBz+Ho1MyMZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783625168; c=relaxed/simple;
	bh=Q7AjLGS/SFId1GInaNXeQDct9+gLnAZDYsTKp+4y6HE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xc/Jmffa/IMRY9UQXB40qWVPQgIVh/sOkheD8MDoIADXPevU562PQwd4cixRhhg6HihUOdW3QX0ku/2kt/wX5SxtDK5Rd2xfjdJQcBYeIhI7fhB3UTgRN8JsrBjQGXlpAccbfyTReUzqGKTuCNGOphuStmwifMm5SMXyqB1TQC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=fxrIC1xq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fo0u8uwX; arc=none smtp.client-ip=103.168.172.158
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4E7D214001BD;
	Thu,  9 Jul 2026 15:26:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 09 Jul 2026 15:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783625165;
	 x=1783711565; bh=I9rPXmDJECuT3ucAFK0IBkM4yWwM7Zo/Km35xBzf+0U=; b=
	fxrIC1xqtyoqjQZDTd9Tvy7V9IjaUA3Xj3LBIx4hkYVL2ZHeh4xhyHIqYiczRFuJ
	j4xcsYH+Q8Lx6Stb67/TmdChuNrQ/OWcsQkExF0cZBdmgJOcu7oMEj6tC9tBy8E7
	qpt3nQ3vTJCSRm913JjRVQmxz4ifR5WzwL1uytC6lbWLcB/WYtR9D32djqZw4JiS
	T3tp8bft46I4H12B3J25wziEoQNj9ooESOe0bfWwqLQR5/wCBEmOytaRXIg3xk/m
	4BwrYzMNHEixkfz8U7vZFMZGucq3OrcEMjDcikjFqmUJ1x+xLaHjUvgMJaW9Jo12
	5sd/Hq1Uep7eEaLbqeEQOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783625165; x=
	1783711565; bh=I9rPXmDJECuT3ucAFK0IBkM4yWwM7Zo/Km35xBzf+0U=; b=f
	o0u8uwXilBzSH8cZeu1sQST+IBGKX/jiQYeEjHSyub1h1VvjTk5y2pruyB3ddQd/
	axac1nCW71UuDKAGIssjDAmqVqbea/SMEksnII3za5aNBu89nlLjjy6AZD15kMzu
	rzaCCbhfzT2GOVz32/LWR9JQv1cj4HX2zVlZmm+dCt/xuHdSjv11T+pWqo0Qf+Hx
	ydRsaYCZpYvRx8eu0BYQnncTye8shfqZJXOAe8wckIRgUTO0MAAwspefOhV/OnuY
	9WcGUgYPLEs2Y1AZh6Wn5IBW/aSoI/1nFvjhFKh6JoBFnba1KLbhpP7m7BmAXxkl
	Vyx/Z60MyoIkPkOTXCytw==
X-ME-Sender: <xms:zPVPajHsvUEJWbQcU7Px2gDFeA8qoiNVrSC--6MWMiLavEWnKheo6w>
    <xme:zPVPamsVqC3Yaj7KjCST76hUp6LhY2sy-4MeeDK_qV97q3L16IMdHwMbvaQiqn7hq
    clRs_zlBgBTpSvL2VeGiYLSnhxK2s8o9uyg9ssWy2y0Dfv7fFJoEQ>
X-ME-Received: <xmr:zPVPahZiY3mVU-PO-Zhn6L5tWelN7ciU5txUULlAABCnC8WsYNZVDWJwa78>
X-ME-Proxy-Cause: dmFkZTE3N/VYUlCu+B/e+pNSYGOlK/ujHCY3wsoqBKl+7XqYvD9oq198P9rrmOx5R7DDOd
    MgfX89m2DFOBXWuKmWTBm51sfp+Y+PFQ/mgKGd1L0i00oT86alC24ZEaKhq2LthuUBqatM
    uV+xJpjA1vnjr1qImP77lzYxbXx7DZG1Iyv5GuLD/D3NC507byJOFzvPzhwIi7zKeiho6P
    MHpelfRZi7iUgve4883YfxghCAzl8ZPE4tix0xLYOUAavbvS5sB/MMt3lPaD//cakO5/j0
    eOm92iJ5bfCbrOsCHmBT9CYbBKXn6lXeTmDElUr4zSqsapmcIY+Se3wEGScsRix437e/F4
    ZlLwDvpNpriuCsFQCmhPdxWxG1RHqRbC59VtrZL3RqsHPCPT+o0MGOlyA/oNlzovMIfgX/
    IcpJHDhynCMsY+Nu4TaUd4Fza3x8fU3aCom3SvzPVfd7RjK+T2Ktn7BU5RNK9FaXSrV6Fj
    k3cBjHU+fplJRuigW6sZukwT1NLNQuAdK4fFKvePDdv2AREMK5ATyuvpI2+oNftfcLkO+9
    Os9pXgslQAE3aQIhX4YVsmigzqFA9ZVIAjGyjddJdefixSm5+MHhqKHKwwhbL+71w6Zooe
    TjQMLezuDg3shi71YmxzF/ghMtiQ3C64q9viTnZPAvtgwf4ZSTzK/R1tAqwA
X-ME-Proxy: <xmx:zPVPau4mJt-jTh9C8PZz0cuiBF3cfqfgnrxfGwcZ4sXuLLPnh9-Ilw>
    <xmx:zPVPah9yiipmrsKK4l1ISLPwbdEx62F5SQKifJ48k2n9cQt5Yu4AHw>
    <xmx:zPVPaia9uKMSkJLB8VGKOEAv0vPqxY5qYB_VQZ5PIK7CAGpu93hYrg>
    <xmx:zPVPai6QjnzqZ5vs4UWhz3qcs3gUUIHSYQa-AGL0C6pC2Qjo0RYpHQ>
    <xmx:zfVPanhbtxmh4S49JyjeFa_9ks2Wiq7dwwHJ5fpmmQEhY3vSOf_6s0bk>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 15:26:03 -0400 (EDT)
Date: Thu, 9 Jul 2026 13:26:02 -0600
From: Alex Williamson <alex@shazbot.org>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Michael Guralnik <michaelgur@nvidia.com>, Sumit Semwal
 <sumit.semwal@linaro.org>, Christian Konig <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, <kvm@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, alex@shazbot.org
Subject: Re: [PATCH v11 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
Message-ID: <20260709132602.6a3fb084@shazbot.org>
In-Reply-To: <20260702181025.2694961-1-zhipingz@meta.com>
References: <20260702181025.2694961-1-zhipingz@meta.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[shazbot.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22975-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zhipingz@meta.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:michaelgur@nvidia.com,m:sumit.semwal@linaro.org,m:christian.koenig@amd.com,m:bhelgaas@google.com,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:alex@shazbot.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[alex@shazbot.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@shazbot.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shazbot.org:from_mime,shazbot.org:dkim,shazbot.org:mid,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,messagingengine.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38B6F734F55

On Thu, 2 Jul 2026 11:10:13 -0700
Zhiping Zhang <zhipingz@meta.com> wrote:
=20
> Changes since v10:
>   Patch 2 (dma-buf): Per Christian K=C3=B6nig, document that the ST/PH
>   returned by dma_buf_get_pci_tph() is only valid until the exporter
>   invalidates the current mapping and must be re-queried afterwards;
>   note added to the wrapper kernel-doc and referenced from the callback
>   kernel-doc. Also add dma_buf_get_pci_tph() and dma_buf_ops.get_pci_tph()
>   to the central dma-buf locking convention.
>=20
>   Patch 3 (vfio/pci): Per Alex Williamson, update the vfio_pci_dma_buf
>   comment to note that @revoked is additionally protected by memory_lock,
>   and describe the READ_ONCE() rationale in the commit log. No behavior
>   change.

Sashiko has valid comments[1] across most of the series.

 - Passing through 0b10 seems mis-categorized as High in patch 1, but
   is valid hardening if tph_req_type can ever hold an invalid value.

 - The documentation error in patch 2 is real.

 - Patch 4 ironically fails to re-validate according to the lifecycle
   requirements that patch 2 specifies.  This is a significant gap in
   the implementation proof for a real requester.

 - The broadened scope of the existing memory leak in patch 4 is
   already addressed in [2], ok.  Maybe should be folded into this
   series if mlx5 isn't going to pick it up separately.

Thanks,
Alex

[1]https://sashiko.dev/#/patchset/20260702181025.2694961-1-zhipingz@meta.com
[2]https://lore.kernel.org/linux-rdma/20260612170406.3339093-1-zhipingz@met=
a.com

