Return-Path: <linux-rdma+bounces-23108-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gALKMm6tVGoxpQMAu9opvQ
	(envelope-from <linux-rdma+bounces-23108-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 11:18:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5825A74935E
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 11:18:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oM+ize0t;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23108-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23108-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73C583014402
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 09:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3DC3DE441;
	Mon, 13 Jul 2026 09:17:42 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFDA54785
	for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 09:17:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783934262; cv=none; b=U5c7oGajGlyktEuL2czRxBAw3dPLZKENox54ABHH8FpKbDIjIHS9Q3ByRuhhF6LchGJpBfi1T3gi67FsP+eDZM6DNeVK71J+pdULUykdwctueXVgRroIg284SU0y+nCqnc2CjvizDRqnB2KD2TiOsSz56QPzLSVSrY2dI5+34oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783934262; c=relaxed/simple;
	bh=M46DfsLvSukSFTLmQ9i6sgcvOmXZZ8lcqHNV3cQ6zkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPdBKXagkHjb0no3LlMfN6LhfkXhRmdDzl8vJt76OM6iPHFShE1IXH9L6DP2dVaThcheA1fYGphpmAhPKabTuhcVVi8seKbMfgV/mU2k61kI6Vjrf9vFCXcZifH3TO0TtHv2os35CawSyV5YCJvLANLkINfPc2BhVpZJL+FHmYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oM+ize0t; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEA11F000E9;
	Mon, 13 Jul 2026 09:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783934261;
	bh=2+wc1iJe5zQ/YEVkHqiP6X6r7ggjB6KBj5TMXxuM8MU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oM+ize0tjwk+R/hJ9j1cBsdv8T/AtJwnOSIjKaKyVXOfrtK0sNYtd8luuJKMwfcUq
	 uC8YMOEV1CP4zYVKTHxyY11PBATv8c+Xeq3nHXdc6gZq96hhbFo5eaHjjA6bZA7umB
	 KOTIpFzlgJF9hOkLkXEirQOemmeaIb8ju7+hcqJc+sxgmNb2dZiX5KE+/kBMIDKDI2
	 y38WVWZ04K5rMfG7e/BpqC5UYl9HcqLcYZ8lPLTWtmRYf1Kqgb5joZ6r5K5A1m2MfM
	 U2HyaqQK0MOGEysFuCmaLhHeMZTRYBu2eAoSwkPj+WAkuK0PKws4VSMqksX+o/9IHX
	 zpD2CEbJTsb8g==
Date: Mon, 13 Jul 2026 12:17:33 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Kamal Heib <kheib@redhat.com>
Cc: linux-rdma@vger.kernel.org, Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH rdma-rc 0/2] RDMA/ionic: Fix NULL pointer dereferences
Message-ID: <20260713091733.GJ33197@unreal>
References: <20260709220353.729951-1-kheib@redhat.com>
 <20260712091326.GG33197@unreal>
 <alPrQa9ZgDaGuPYo@lima-fedora43>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alPrQa9ZgDaGuPYo@lima-fedora43>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kheib@redhat.com,m:linux-rdma@vger.kernel.org,m:abhijit.gangurde@amd.com,m:allen.hubbe@amd.com,m:jgg@ziepe.ca,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23108-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5825A74935E

On Sun, Jul 12, 2026 at 03:30:09PM -0400, Kamal Heib wrote:
> On Sun, Jul 12, 2026 at 12:13:26PM +0300, Leon Romanovsky wrote:
> > On Thu, Jul 09, 2026 at 06:03:51PM -0400, Kamal Heib wrote:
> > > Fix two potential NULL pointer dereferences in the ionic driver by
> > > adding the missing NULL checks before dereferencing netdev pointers.
> > 
> > How is it possible to have ionic IB driver without netdev?
> > 
> > Thanks
> >
> 
> Thanks for your review, after taking a deeper look:
> 
> For Patch 2 (ionic_create_ibdev): You are right. Since lif is embedded in
> netdev via netdev_priv() and they are allocated/freed together,
> lif->netdev cannot be NULL if lif is valid, Please drop this patch.
> 
> For Patch 1 (ionic_query_device): This one should remain.
> ib_device_get_netdev() is a core RDMA API that explicitly returns NULL in
> multiple code paths:
> 
> - Invalid port: if (!rdma_is_port_valid(ib_dev, port)) return NULL;
> - No port_data: if (!ib_dev->port_data) return NULL;
> - NULL netdev pointer stored in port_data
> 
> Also, the return value from ib_device_get_netdev() is being checked in
> multiple places in both drivers and the RDMA core.
> 
> Let me know what you think?

I think that you shouldn't copy/paste answers from your favorite AI tool.

Thanks

> 
> Thanks,
> Kamal
> 
> > > 
> > > Kamal Heib (2):
> > >   RDMA/ionic: Fix potential NULL pointer dereference in
> > >     ionic_query_device
> > >   RDMA/ionic: Fix potential NULL pointer dereference in
> > >     ionic_create_ibdev
> > > 
> > >  drivers/infiniband/hw/ionic/ionic_ibdev.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > -- 
> > > 2.55.0
> > > 
> > > 
> > 
> 

