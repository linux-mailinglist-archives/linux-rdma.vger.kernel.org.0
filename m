Return-Path: <linux-rdma+bounces-22539-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C7DqFle+QGrshgkAu9opvQ
	(envelope-from <linux-rdma+bounces-22539-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2026 08:25:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB5E6D3476
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2026 08:25:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=l7ftEBAr;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22539-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22539-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=mailbox.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E4613014BEF
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2026 06:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD19A36492A;
	Sun, 28 Jun 2026 06:25:24 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F4619539F
	for <linux-rdma@vger.kernel.org>; Sun, 28 Jun 2026 06:25:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782627924; cv=none; b=WMwTtFmAIUtGPKW340wB5uE+wIX4ys2DCXyqCZMMeSNtHStx241GzGvhfLDvwHun6HV7arPKMfq4XoWlWkZJvRjkwMsBSchr222DzlY2Wy0m4+Q3oViNF/gIlddxwZB+n4cjrdvhl/HbVmGm+12dF49vsQpXLwOkOTkxh/z4byQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782627924; c=relaxed/simple;
	bh=wx+Ihvw2j97Zi2vd35K0siuXw9YsYfc9TFRBPWgYmKw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qC50NSDU861uKIHxVJRD3OyFyxHBTBoRGgMrQMW/ccn4FDm28g+mkCs3rFzl8OzZmj7u0A9Xy8l7TyP5KwI+rpdK3MWHT3+sSgGbDXqH8ITggsXfqbJrRsqiKKZY06ikPrXS6u+Mdot+Ba2pEv7fCCVdUM4wDR+7Kwaf6ZPq6+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=l7ftEBAr; arc=none smtp.client-ip=80.241.56.152
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gnzt63zRqz9v1S;
	Sun, 28 Jun 2026 08:25:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782627918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wx+Ihvw2j97Zi2vd35K0siuXw9YsYfc9TFRBPWgYmKw=;
	b=l7ftEBArXQ+eTSkkUG2ukXb2/YRX+dIAGv6+A71hhQDxZQDh6k/7hNesbeCsNJZv+/leBT
	99lwd4yNBe3Z97c/L8cOw8EMmOPCdtHEXXHr3dlydYPjE06wmS5FoO8V++KYGhOCsnyGeo
	vGxB5jnUtM9YV6p0PEO0YFGWAQLnx3K/KXZ1yHY6ZyjK05ooZplaj8j6/jokYQwon6kwSE
	/0cF9q5UKbgFQT91l7dMQGBhNzMP1kpL9DproUv9QJXumSNbcz6/W5E9Ou5M45r6fsK8hj
	VoaB3q3iuwPU2/ZzsI9FlASJxk1tRl6OSI9DvHIrh16OpzZM3t06ZGmEv49+BQ==
Message-ID: <2ee49f1c24d886cec6a24a0242cf44fe529b9e28.camel@mailbox.org>
Subject: Re: [PATCH] ABI: sysfs-class-infiniband: minor cleanup
From: Manuel Ebner <manuelebner@mailbox.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org, 
 Jonathan Cameron
	 <jic23@kernel.org>
Date: Sun, 28 Jun 2026 08:25:15 +0200
In-Reply-To: <20260612142109.GA1879774@nvidia.com>
References: <20260612122611.183127-2-manuelebner@mailbox.org>
	 <20260612142109.GA1879774@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 65075e91ab526149924
X-MBO-RS-META: u9d17r6qyedrwt4cwq94yhwnrynpq6j8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22539-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:leonro@nvidia.com,m:linux-rdma@vger.kernel.org,m:jic23@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[manuelebner@mailbox.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manuelebner@mailbox.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mailbox.org:dkim,mailbox.org:email,mailbox.org:mid,mailbox.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FB5E6D3476

The get_maintainer script didn't return your e-mail-address for this file:
Documentation/ABI/stable/sysfs-class-infiniband
Please consider adding path(s) to file(s) or directories to your subsystem
to MAINTAINERS.
As suggested by Jonathan Cameron.

Thanks
 Manuel
=20
On Fri, 2026-06-12 at 11:21 -0300, Jason Gunthorpe wrote:
> On Fri, Jun 12, 2026 at 02:26:12PM +0200, Manuel Ebner wrote:
> > Close parenthesis with ')'.
> > Add '-': 64-bit counter.
> >=20
> > Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
> > ---
> > =C2=A0Documentation/ABI/stable/sysfs-class-infiniband | 8 ++++----
> > =C2=A01 file changed, 4 insertions(+), 4 deletions(-)
>=20
> Applied
>=20
> Thanks,
> Jason


