Return-Path: <linux-rdma+bounces-23072-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ynCEAMFaU2pUaAMAu9opvQ
	(envelope-from <linux-rdma+bounces-23072-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 11:13:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EA27443BE
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 11:13:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gKs551H1;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23072-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23072-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BEC3300E24E
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 09:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3051D372695;
	Sun, 12 Jul 2026 09:13:33 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D17C36BCC3
	for <linux-rdma@vger.kernel.org>; Sun, 12 Jul 2026 09:13:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783847613; cv=none; b=rgaw/fB3WXYfZa1B6KUEGhOQDnuMmFmwcSzgpaVkJw4tAN7Iaf4b8Z2Hm0FP5aEVqdm/Uhl7xshvtRirQH3+T84GwnPG9SIB2Rm/pZIQj3IX756y8F/rHsr3Q1s5hiYr/hab0cOjImkEFqj6a/F6ZNT59ROU5KoyaI7R223IZoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783847613; c=relaxed/simple;
	bh=tgzAKMNW8ZfPs1Ko4jHTWkUQw1aZcHGNA8q3uTnh/as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JR5kgT+Wg3bitF+WQfcgpoQJReIaxaAx3E9Df9jK/4bAHyB5Yhq1TaybOVntY24w9o0N7xND48WVBWZNkBrvD7Hi6LR9nbUMdRCyZcW8saP0ql6CAPIe8S4gUhEtEhhQV521UMsOIox6jewKBduypFLK4fNwtvQ/yyRudMRFtxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKs551H1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FF01F000E9;
	Sun, 12 Jul 2026 09:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783847611;
	bh=7UuFVh2BQTPAK8HwjImBHNQZEQaRUbsDBQp419h+dY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gKs551H1kIphArJR+kbDoqm4fFstiqXLaqvtbJm7+ztkstlvL6zQS+6xYBLXlS4GO
	 hC7mrYl6v3njs3vve1FbNQ8OHxU8HJoMZ/m2pi5Fh3P4ZAPSOExhEGrf2sCUapv3mx
	 mDkAiSyPScv3jnydgVZRIn+cCFyamM/dE6cyWZ3gnvhrY2rz0+7TO17mOCyINBPLqx
	 xKDtUzNu9RMZE5axTvH1VlLJoOZ4rUL7NmMhfXPHUSbC7m04sL/ZRVUunXd3HOQ0Ns
	 tbXSRCjBWPTjKsW226550k4Ctau0AGZL7SzFvplgx5RFt48V9r/4EuwPBDf+zvU6Tn
	 zSGf8p4FjHF3w==
Date: Sun, 12 Jul 2026 12:13:26 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Kamal Heib <kheib@redhat.com>
Cc: linux-rdma@vger.kernel.org, Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH rdma-rc 0/2] RDMA/ionic: Fix NULL pointer dereferences
Message-ID: <20260712091326.GG33197@unreal>
References: <20260709220353.729951-1-kheib@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709220353.729951-1-kheib@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kheib@redhat.com,m:linux-rdma@vger.kernel.org,m:abhijit.gangurde@amd.com,m:allen.hubbe@amd.com,m:jgg@ziepe.ca,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23072-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,unreal:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 53EA27443BE

On Thu, Jul 09, 2026 at 06:03:51PM -0400, Kamal Heib wrote:
> Fix two potential NULL pointer dereferences in the ionic driver by
> adding the missing NULL checks before dereferencing netdev pointers.

How is it possible to have ionic IB driver without netdev?

Thanks

> 
> Kamal Heib (2):
>   RDMA/ionic: Fix potential NULL pointer dereference in
>     ionic_query_device
>   RDMA/ionic: Fix potential NULL pointer dereference in
>     ionic_create_ibdev
> 
>  drivers/infiniband/hw/ionic/ionic_ibdev.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> -- 
> 2.55.0
> 
> 

