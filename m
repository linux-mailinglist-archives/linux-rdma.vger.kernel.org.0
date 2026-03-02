Return-Path: <linux-rdma+bounces-17369-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8K1bH5BtpWlXAgYAu9opvQ
	(envelope-from <linux-rdma+bounces-17369-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 11:59:28 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2731D7132
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 11:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B8323004428
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 10:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BB4330D36;
	Mon,  2 Mar 2026 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iK7Lcmfu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5354E32ED2F;
	Mon,  2 Mar 2026 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772447604; cv=none; b=gIMjdSGeXuSk6gFpMO1rBMmhogTGHgJQEUdaA5iV7lfVHKX2bHjfIP4umGLWfO16tfQ3/RWavxBuIDa0XSazOsOpVnI1yGfYWHpqGLM0aD/1I8vAaZZAB/5w5f7xIAdQvzi5bGr8oy3DE43GJyJ0jXKzviFPR5EuoXcGJmNCYLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772447604; c=relaxed/simple;
	bh=aiFg5+nYCjYR5ACQVI9+TDCz642XlmWqicdCWc1zZ1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHZnvMZxzmG1ztBzPMd5LPvPq6bDO2JF/ancE+e42DxvhyyWbxsgnk6BPb72STVz5TlFrhjpthPD+xA5oG8hCvb3aDer2u7yK+Z7Ji+V7G/g4hD6VQ7K4wEA/rr21edM+XR3BJF604R5MG8V8zP4aU916biw0E+NEwOlBcV8UsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iK7Lcmfu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C264C19423;
	Mon,  2 Mar 2026 10:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772447603;
	bh=aiFg5+nYCjYR5ACQVI9+TDCz642XlmWqicdCWc1zZ1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iK7Lcmfu3aPcnqFJ3YxZg/v1exax41cjUA7kKWENbyw9TiMuxj9H/9izI0L3tvLcC
	 bwQt7Qy0inBkUVxA3TjuVcGff3H8f+hgUpnK3+s4CZhOZmH66lGMSymn3eJclGNJQH
	 EII7FEhogZEaWuaBF9nRFuFHaXIsmEDqLzhUN0qb1d/doK3vc8cmCLuTkWytZ4eOyr
	 H8pGIQRi/me6a3KzyYUhuxUC7lxP0PPk9XXA+lwFdUzAe83McnzlncGMq6nEDpSVqd
	 I/ETUOhQublyN6gg01tKC/3rBs+IZEoDQSTCyHs5E3xqv2NdTBSfUHUM9AuJS/7579
	 U3xnJO0N1KZzA==
Date: Mon, 2 Mar 2026 12:33:19 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Stefan Metzmacher <metze@samba.org>
Cc: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	Steve French <smfrench@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>, Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: Re: [PATCH] RDMA/core: check id_priv->restricted_node_type in
 cma_listen_on_dev()
Message-ID: <20260302103319.GO12611@unreal>
References: <20260224165951.3582093-2-metze@samba.org>
 <20260225125211.GE9541@unreal>
 <a8d20762-e4f7-41fd-b67e-803858655aad@samba.org>
 <20260226100929.GI12611@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226100929.GI12611@unreal>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [7.84 / 15.00];
	URIBL_BLACK(7.50)[talpey.com:email];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17369-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,gmail.com,kernel.org,talpey.com,microsoft.com,lists.samba.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-rdma];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c15:e001:75::/64:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_SPAM(0.00)[0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,samba.org:email]
X-Rspamd-Queue-Id: 7F2731D7132
X-Rspamd-Action: add header
X-Spam: Yes

On Thu, Feb 26, 2026 at 12:09:29PM +0200, Leon Romanovsky wrote:
> On Thu, Feb 26, 2026 at 10:32:27AM +0100, Stefan Metzmacher wrote:
> > Am 25.02.26 um 13:52 schrieb Leon Romanovsky:
> > > On Tue, Feb 24, 2026 at 05:59:52PM +0100, Stefan Metzmacher wrote:
> > > > When listening on wildcard addresses we have a global list for
> > > > the application layer rdma_cm_id and for any existing
> > > > device or any device added in future we try to listen
> > > > on any wildcard listener.
> > > > 
> > > > When the listener has a restricted_node_type we
> > > > should prevent listening on devices with a different
> > > > node type.
> > > > 
> > > > While there fix the documentation comment of
> > > > rdma_restrict_node_type() to include rdma_resolve_addr()
> > > > instead of having rdma_bind_addr() twice.
> > > > 
> > > > Fixes: a760e80e90f5 ("RDMA/core: introduce rdma_restrict_node_type()")
> > > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > > Cc: Leon Romanovsky <leon@kernel.org>
> > > > Cc: Steve French <smfrench@gmail.com>
> > > > Cc: Namjae Jeon <linkinjeon@kernel.org>
> > > > Cc: Tom Talpey <tom@talpey.com>
> > > > Cc: Long Li <longli@microsoft.com>
> > > > Cc: linux-rdma@vger.kernel.org
> > > > Cc: linux-cifs@vger.kernel.org
> > > > Cc: samba-technical@lists.samba.org
> > > > Signed-off-by: Stefan Metzmacher <metze@samba.org>
> > > > ---
> > > >   drivers/infiniband/core/cma.c | 6 +++++-
> > > >   include/rdma/rdma_cm.h        | 2 +-
> > > >   2 files changed, 6 insertions(+), 2 deletions(-)
> > > 
> > > Applied, thanks.
> > 
> > Great!
> > 
> > Will this be scheduled for rc2?
> 
> I hope so, rdma-rc has a compilation fix which I would like to see in
> Linus's master as soon as possible.

It was merged before -rc2:
e3c81bae4f28 ("Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma")
93a4a9b732fb ("RDMA/core: Check id_priv->restricted_node_type in cma_listen_on_dev()")

Thanks

