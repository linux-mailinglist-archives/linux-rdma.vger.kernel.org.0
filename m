Return-Path: <linux-rdma+bounces-16881-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MJyDsBPj2nnPgEAu9opvQ
	(envelope-from <linux-rdma+bounces-16881-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 17:22:24 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D45137E8F
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 17:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E8DD300789B
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 16:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BC322126D;
	Fri, 13 Feb 2026 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T22cPCDs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0872154763
	for <linux-rdma@vger.kernel.org>; Fri, 13 Feb 2026 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770999741; cv=none; b=HFBod4lUH71p43z7f98z71EYEhyuMYz1aP81EvJrIAJR5KfIp3y1cfBkYK7PZgfbau1BDXm7EItHKlMyPzXu/szyZkKPS0qJVj0+KPqC/FA794eTQtsu3IbAWdfsREYDi4ClZZbOSajDM4hxYcLz+L+pV46OBsEv8nQJqNRYSP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770999741; c=relaxed/simple;
	bh=IubqBix6/5KEZeGB5iocHiKUaR770iFmmnyMeIX0FMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnVUsBzd4eBaedz+PTRW/EQ3zALm52BhHLtE1tXqe205kVu4T8E/djFyURDbVa7sndhDg7A34VmVbjwzYQd9pkATwB4t/TgtWhvUBrLjaJNZ6yFkIzMCc08UXtJodt2HeB4kIvRNl2p1/sqo6hO5y1PFzVrjUOxTLhA4MkhsPJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T22cPCDs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147CBC116C6;
	Fri, 13 Feb 2026 16:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770999740;
	bh=IubqBix6/5KEZeGB5iocHiKUaR770iFmmnyMeIX0FMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T22cPCDsVPF7zTOorDZCvmE4/lLFAYKG5u39tH7QxUmTA3mHb3oSxnSw3QfDMEo3v
	 YPb9b7b4jvVbTbfFZrdYiACuHOGbBLoM/93FacM7lTSHnyhGGDbIMnfbnkjPDxkx/I
	 OtvBCCjbGDDhXcQ78POUU2lStctC/DT7nYAuy2bhb6wrVxoG6mruWbciDuaZGCZaPT
	 NSWXePztalpVPXV4M9MZ2tK9H1HQDQsDS7v1dKSBTHCoQfjNgAxyi702gPJSxkX+Hp
	 gczY5QWEAANCt084kSUxngSJ+NHK+slzssecaiFVnnnQbumakKEiBRgxjX3Cddha/y
	 dniTzL0wAkEYw==
Date: Fri, 13 Feb 2026 18:22:11 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v12 5/6] RDMA/bnxt_re: Support dmabuf for CQ
 rings
Message-ID: <20260213162211.GX12887@unreal>
References: <20260211124927.57617-1-sriharsha.basavapatna@broadcom.com>
 <20260211124927.57617-6-sriharsha.basavapatna@broadcom.com>
 <20260213111256.GO12887@unreal>
 <20260213145425.GN750753@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213145425.GN750753@ziepe.ca>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16881-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: D4D45137E8F
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 10:54:25AM -0400, Jason Gunthorpe wrote:
> On Fri, Feb 13, 2026 at 01:12:56PM +0200, Leon Romanovsky wrote:
> > > +int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
> > > +		      struct uverbs_attr_bundle *attrs)
> > > +{
> > > +	return bnxt_re_create_cq_umem(ibcq, attr, NULL, attrs);
> > > +}
> > 
> > Please don't mix create_cq and create_cq_umem.
> > https://lore.kernel.org/linux-rdma/20260213-refactor-umem-v1-15-f3be85847922@nvidia.com/T/#u
> 
> Either we drop this one patch and put those 50 ahead of it, or we just
> take this one and rebase the above.. The above has the advantage that
> it enables all drivers to support cq dmabuf in one giant shot.
> 
> However, frankly I'm getting tired of looking at this bnxt_re stuff so
> I'd like to just see it done.

In addition, push them to create 2 separate functions.
One is .create_cq_umem() for uverbs flow and another .create_cq()
variant for kernel flow.

bnxt_re_create_cq()
 { 
  if (udata)
     return bnxt_re_create_cq_umem()

  .... <kernel CQ>
  }

It will allow me to rebase my series more easily.

Thanks

> 
> Jason

