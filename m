Return-Path: <linux-rdma+bounces-18516-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CG4wE8QjwWmTQwQAu9opvQ
	(envelope-from <linux-rdma+bounces-18516-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 12:28:04 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A79222F1336
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 12:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D26913033AB6
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 11:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AA2391E7C;
	Mon, 23 Mar 2026 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0cyVVGr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E1238D6BA;
	Mon, 23 Mar 2026 11:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774264449; cv=none; b=u6MUUide1Du/MqfbCJINvFhJ+FnXh+ICJ8VRengHYOViZDzzJRzENWqUUda8VEjomh88mMgC4Ot3jPtqVb8qFkvc9tE19geyOmrHXDFdBsR/pdXzT2JdUlpfmDQ7EkDarhysY7AGjCHbUmKyXtKCBEEhO9jiW4y+UWAVVo0WAHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774264449; c=relaxed/simple;
	bh=blTgKdsB6hMF8lUQQCxUPVNXYwUxtNk252kTVVYCDPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QybifKouOtJLuRk7X3jBYfbOWuIjX6PTA8XMykQlh22K8Kb8a0opze0qaRRdOWpkgfbRZEkn/RvwZVcYxcNRcCgKo7CimDcFedja90nLqyM4Wi+o9swqhmDL3DIJfvV7lGtH/rXEL1NNwFsyzb82RUdPEaXj5GqvgqcFQVfNoKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0cyVVGr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1269BC4CEF7;
	Mon, 23 Mar 2026 11:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774264449;
	bh=blTgKdsB6hMF8lUQQCxUPVNXYwUxtNk252kTVVYCDPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e0cyVVGrRHeRcHpLHamnbE5lGsropL3mExESMYquGE23C8dOZvT58CheZicVx/xse
	 P9Gsq9dsTwXlttfHfqnzW6xLW06+ZqzpsBpnfouP2s4TYkhfvF19EXf2H8Lw8xSlpJ
	 jNuX9JylstAVPx5TA3pNegD5skJ6Bt2rD6obfa6ONjnUru2DpYNDqkFjNUlENqgy3v
	 prb/GAy5hfKop8nBn5CHFISldPG2bAOCPAgSF2QZ4wWMgLVw8B8ns+Qva0sbrubtmO
	 3JxrQ8tbWF/9SOLDVkzbwq8mMeSzIo1wJFrN6ulNA9Q/e0Uyk/z/ipk8nov9Fvwg7E
	 NxDbVst2ke8XA==
Date: Mon, 23 Mar 2026 13:14:01 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next 1/4] RDMA/bnxt_re: Simplify
 bnxt_re_init_depth() callers and implementation
Message-ID: <20260323111401.GH814676@unreal>
References: <20260318-bnxt_re-cq-v1-0-381cb1b5e625@nvidia.com>
 <20260318-bnxt_re-cq-v1-1-381cb1b5e625@nvidia.com>
 <CA+sbYW0vhjp49vngMs21DXErN=tMRN3M8uxqSSjOHL+H0uAbvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+sbYW0vhjp49vngMs21DXErN=tMRN3M8uxqSSjOHL+H0uAbvw@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18516-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A79222F1336
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 11:46:43AM +0530, Selvin Xavier wrote:
> On Wed, Mar 18, 2026 at 3:39 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > From: Leon Romanovsky <leonro@nvidia.com>
> >
> > All callers of bnxt_re_init_depth() compute the minimum between its return
> > value and another internal variable, often mixing variable types in the
> > process. Clean this up by making the logic simpler and more readable.
> >
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 81 ++++++++++++++------------------
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.h |  9 ++--
> >  2 files changed, 42 insertions(+), 48 deletions(-)

<...>

> > -static inline u32 bnxt_re_init_depth(u32 ent, struct bnxt_re_ucontext *uctx)
> > +static inline u32 bnxt_re_init_depth(u32 ent, u32 max,
> > +                                    struct bnxt_re_ucontext *uctx)
> >  {
> > -       return uctx ? (uctx->cmask & BNXT_RE_UCNTX_CAP_POW2_DISABLED) ?
> > -               ent : roundup_pow_of_two(ent) : ent;
> > +       if (uctx && !(uctx->cmask & BNXT_RE_UCNTX_CAP_POW2_DISABLED))
> > +               return min(roundup_pow_of_two(ent), max);
> Looks like the min setting is missing in the else case. shouldn't we add that?

I did not add it because all callers of bnxt_re_init_depth() already check  
that ent is less than max. However, roundup_pow_of_two() requires a  
min() guard because it can overflow the prior range check.

Thanks

> 
> > +
> > +       return ent;
> >  }
> >
> >  static inline bool bnxt_re_is_var_size_supported(struct bnxt_re_dev *rdev,
> >
> > --
> > 2.53.0
> >



