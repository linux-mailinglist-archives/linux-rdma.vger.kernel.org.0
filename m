Return-Path: <linux-rdma+bounces-16943-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YC8tFmgdlGkpAAIAu9opvQ
	(envelope-from <linux-rdma+bounces-16943-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 08:48:56 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D66149507
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 08:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 411A630158AF
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 07:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FC22D5C91;
	Tue, 17 Feb 2026 07:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgGwVs4B"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5945418C02E;
	Tue, 17 Feb 2026 07:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771314518; cv=none; b=H9K2raskTk1P8ZDZOumY8bH4jZZ4mhczFBbM5I6nG5XE46LCsfK5jzhBcDQ8EMefa2QbTgSstuX7MP4SohoFiqmfOR1Lb9deA1vjBz3mQQLTEsuUIp4NUvQbSiWtpfFQbihOq96eEZnFoEyhHLpJ49TD7xZRhqLD+eBJ6ohAkbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771314518; c=relaxed/simple;
	bh=mJLwzjpt2bfEgYp4baQkU9mJK9eW9sZ+pX73oE5VKg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwwMYz2ZxiqKq5XJd5Htli9DPDAXEeagDl+jy+Y9drQAaxhZjEMYywRcIpcxZq7l7/wDeGt0mGq0OmlelUvyrTRs77NSNukEJCu+JfaDbqUvim31FJ2rXQK+oFQrfeyDv2dhi8qK2t2fULjdQuFGlujne44thLX5VYBHPd1OYr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgGwVs4B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CBBC4CEF7;
	Tue, 17 Feb 2026 07:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771314518;
	bh=mJLwzjpt2bfEgYp4baQkU9mJK9eW9sZ+pX73oE5VKg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dgGwVs4B5LLGiS7X1zS5obWx/mor8BygeVT48WTb5O81v04Ok6750noC+zYZatpc5
	 W2bGGWt8kkDKoVYU3nsIUEz1ZJhmTxMvPiVTMIXP06VpwXqNDxyH8wtIW9bPTaXHsY
	 QRfxbzjTCJHVOK47EK07HOhaxkVraJJEX7i8mzgh4bz+Ivycq9wi/dIm1JOSGGaNYb
	 Un3QTr7OBABuXr5BrmlZnmbXMk9biJFrpnqQj8aMPeg2vWy/44MWrhdltHpeDYbsV7
	 GtgK7u/lF4XdpX9xwRBP9AUIly9iQewVGcPHHMzWFjnHxYBwG2btH+V18syZD2Os7F
	 A6BkjRmc3cPEw==
Date: Tue, 17 Feb 2026 09:48:33 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH 03/10] RDMA: Add ib_respond_udata()
Message-ID: <20260217074833.GH12989@unreal>
References: <0-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
 <3-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
 <20260213101053.GJ12887@unreal>
 <20260213124359.GD1218606@nvidia.com>
 <20260213153739.GR12887@unreal>
 <20260213154813.GG1218606@nvidia.com>
 <20260216231424.GA3804671@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216231424.GA3804671@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16943-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4D66149507
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 07:14:24PM -0400, Jason Gunthorpe wrote:
> On Fri, Feb 13, 2026 at 11:48:13AM -0400, Jason Gunthorpe wrote:
> > On Fri, Feb 13, 2026 at 05:37:39PM +0200, Leon Romanovsky wrote:
> > > On Fri, Feb 13, 2026 at 08:43:59AM -0400, Jason Gunthorpe wrote:
> > > > On Fri, Feb 13, 2026 at 12:10:53PM +0200, Leon Romanovsky wrote:
> > > > > > @@ -3177,6 +3177,38 @@ static inline int _ib_copy_validate_udata_in(struct ib_udata *udata, void *req,
> > > > > >  		ret;                                                          \
> > > > > >  	})
> > > > > >  
> > > > > > +static inline int _ib_respond_udata(struct ib_udata *udata, const void *src,
> > > > > > +				   size_t len)
> > > > > > +{
> > > > > > +	size_t copy_len;
> > > > > > +
> > > > > > +	copy_len = min(len, udata->outlen);
> > > > > 
> > > > > Don't you need to check that udata->outlen is larger than zero?
> > > > 
> > > > As far as I can tell 0 works fine with copy_to_user()
> > > 
> > > My main concern that it is not clear what return value will be in that
> > > case.
> > > 
> > > +       copy_len = min(len, udata->outlen);
> > > +       if (copy_to_user(udata->outbuf, src, copy_len))
> > > +               return -EFAULT; <--- this?
> > > +       if (copy_len < udata->outlen) {
> > > ...
> > > +       }
> > > +       return 0; <- or this?
> > 
> > Oh, yeah, that's a really good point.
> 
> So it still returns 0, copy_to_user() returns the number of bytes left
> to copy. See Documentation/kernel-hacking/hacking.rst
> 
>     Unlike :c:func:`put_user()` and :c:func:`get_user()`, they
>     return the amount of uncopied data (ie. 0 still means success).
> 
> Number of bytes left to copy for a 0 length copy is still 0, not
> EFAULT.
> 
> I'm just going to add a comment.

It should work as well.

Thanks

> 
> Jason
> 

