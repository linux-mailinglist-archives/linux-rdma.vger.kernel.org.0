Return-Path: <linux-rdma+bounces-16472-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGvNMZYqgmnFPwMAu9opvQ
	(envelope-from <linux-rdma+bounces-16472-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 18:04:22 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC173DC74C
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 18:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE723304343A
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 16:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D373D3317;
	Tue,  3 Feb 2026 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WF6giYGR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428503D3497;
	Tue,  3 Feb 2026 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770137928; cv=none; b=tEWYq/HvYqlTAwECB4KfvfOYpMLHwZx+hN4CHEaweLMg5RkGmYmAtHYr/XZgbXmo+xA2dSyqZurjrFwR9yVUeGOOiXUAHIMsq6P0IpguDnVuF6TKZtOS6PUX1fZPxRwgjJpR9pnPvnCf5QbW5pLyki5qo5Oy9J0m3Sb4z0qCLKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770137928; c=relaxed/simple;
	bh=8tglhI2GFK6F1EuLtfYkrNoDUgtU2tDYJakyaYOi0Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExQDMjCKG9wYcoTI/nKfmUWVblLm0aja/Q73NXR9bcH2Vp5v9ivWs4Tnp7gUkmn+RPzRrT2Emmw2JWHnxPk/+0tzCq/Y35B18MW4DH7UU0Lvalv53DNWGWlvb/JeaW/y+Uhj7bVrdbShdzvChlU7yUCyJJWZkBgBCR3ENrOE7SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WF6giYGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB2EC116D0;
	Tue,  3 Feb 2026 16:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770137927;
	bh=8tglhI2GFK6F1EuLtfYkrNoDUgtU2tDYJakyaYOi0Ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WF6giYGRmDH1mF7FDcQqs/LJxXCax8EcYS7IcQtPELuwYsdyGCUXnCjkLrnUuysHT
	 l9flN2JyJHwZrQiGMwYDU07FmeqWhkoktaA19Z1KaAQlV9cJQP0QcNBoX6qM4jHOkR
	 OOPaHjGs70oZo9llplKyRPJWrCHSAoze4tzD0XfLwDuz6pixRDLc7rMYGgdAjOAqzy
	 ts0xWFFSZoTjqzvQGHBEoWG6lr0aEC3XzAGuiEkDayLtRLwdnH01f0IN0f15vJXd8D
	 drPG8FIXiMCJEN0NPzZh54H1z/WYLQL/oKiMYtXXPt5ryr6Kvp5k3c0D0ach8JdAGY
	 s55Whlbbt7HXw==
Date: Tue, 3 Feb 2026 18:58:44 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Stefan Metzmacher <metze@samba.org>
Cc: linux-rdma@vger.kernel.org, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, Jason Gunthorpe <jgg@ziepe.ca>,
	Steve French <smfrench@gmail.com>, Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [RFC PATCH 0/3] RDMA/smbdirect: introduce and use
 rdma_restrict_node_type()
Message-ID: <20260203165844.GX34749@unreal>
References: <cover.1769025321.git.metze@samba.org>
 <20260128141123.GG40916@unreal>
 <1f77a9a6-9020-4d65-a6b9-fe68d4f6e46f@samba.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f77a9a6-9020-4d65-a6b9-fe68d4f6e46f@samba.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.samba.org,ziepe.ca,gmail.com,talpey.com,microsoft.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-16472-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC173DC74C
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 04:25:35PM +0100, Stefan Metzmacher wrote:
> Am 28.01.26 um 15:11 schrieb Leon Romanovsky:
> > On Wed, Jan 21, 2026 at 09:07:10PM +0100, Stefan Metzmacher wrote:
> > > Hi,
> > > 
> > > for smbdirect it required to use different ports depending
> > > on the RDMA protocol. E.g. for iWarp 5445 is needed
> > > (as tcp port 445 already used by the raw tcp transport for SMB),
> > > while InfiniBand, RoCEv1 and RoCEv2 use port 445, as they
> > > use an independent port range (even for RoCEv2, which uses udp
> > > port 4791 itself).
> > > 
> > > Currently ksmbd is not able to function correctly at
> > > all if the system has iWarp (RDMA_NODE_RNIC) interface(s)
> > > and any InfiniBand, RoCEv1 and/or RoCEv2 interface(s)
> > > at the same time.
> > > 
> > > And cifs.ko uses 5445 with a fallback to 445, which
> > > means depending on the available interfaces, it tries
> > > 5445 in the RoCE range or may tries iWarp with 445
> > > as a fallback. This leads to strange error messages
> > > and strange network captures.
> > > 
> > > To avoid these problems they will be able to
> > > use rdma_restrict_node_type(RDMA_NODE_RNIC) before
> > > trying port 5445 and rdma_restrict_node_type(RDMA_NODE_IB_CA)
> > > before trying port 445. It means we'll get early
> > > -ENODEV early from rdma_resolve_addr() without any
> > > network traffic and timeouts.
> > > 
> > > This is marked as RFC as I want to get feedback
> > > if the rdma_restrict_node_type() function is acceptable
> > > for the RDMA layer. And because the current form of
> > > the smb patches are not tested, I only tested the
> > > rdma part with my branch the prepares IPPROTO_SMBDIRECT
> > > sockets.
> > > 
> > > I'm not sure if this would be acceptable for 6.19
> > > in order to avoid the smb layer problems, if the
> > > RDMA layer change is only acceptable for 7.0 that's
> > > also fine.
> > > 
> > > This is based on the following fix applied:
> > > smb: server: reset smb_direct_port = SMB_DIRECT_PORT_INFINIBAND on init
> > > https://lore.kernel.org/linux-cifs/20251208154919.934760-1-metze@samba.org/
> > > It's not yet in Linus' tree, so if this gets ready
> > > before it's merged we can squash it.
> > > 
> > > Stefan Metzmacher (3):
> > >    RDMA/core: introduce rdma_restrict_node_type()
> > >    smb: client: make use of rdma_restrict_node_type()
> > >    smb: server: make use of rdma_restrict_node_type()
> > 
> > The approach looks reasonable.
> 
> Thanks!
> 
> > Do you want me to take it through RDMA
> > tree?
> 
> As I also have other smb patches on top changing/using
> it I guess it would be easier if Steve would take them.
> 
> Steve, Leon what do you think?

I'm ok with that, let's me add my Acked-by on first patch.

Thanks

> 
> Thanks!
> metze

