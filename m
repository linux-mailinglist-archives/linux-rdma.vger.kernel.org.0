Return-Path: <linux-rdma+bounces-16877-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOrsBwFKj2moPQEAu9opvQ
	(envelope-from <linux-rdma+bounces-16877-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 16:57:53 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72125137BE5
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 16:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E52AE304997E
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 15:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB693570C9;
	Fri, 13 Feb 2026 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hh1C8s5r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DF326AC3;
	Fri, 13 Feb 2026 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770998270; cv=none; b=Lj+jxzuAO3nVZdoT26ymUfFYDdAVMVkUvTKDq5mKoJbjXEYoBusX4f1JJSXSeA2ZJioDLEYSJKBAXvRKAtBGhPirc6iW5Q6to2rn0u6GhjfTfAbloEbFDW+7t483YQkxJ2N4YG2vj5DgdOilynH2eDg3cEpEJpnUFO/bYamm6tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770998270; c=relaxed/simple;
	bh=HvQGvbAd3NJbRP0dl8wfJtSlFFQwKsB8qcfxscFtbdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdFtTAIzpvarW6hutI5BC2iAAW1P5drTrNIFY2WBaLrR3sMMIe7kllV352OKixWYmlo7XcgJGREXpyGj8oP5r8+e3wBS8eRac5IkkCL45NB+6ERU8+hC9tcSIuewAvZtkK3i1qox6guDEgUfKebrjfhRg0Lulu71D8D9EiIgnOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hh1C8s5r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6A3C116C6;
	Fri, 13 Feb 2026 15:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770998269;
	bh=HvQGvbAd3NJbRP0dl8wfJtSlFFQwKsB8qcfxscFtbdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hh1C8s5rJiU38LVvZcurQ3B3+JlGd+a2YrirMLX10eOZ17SXeXHibI+wV6PlWEKIw
	 ORtpqXgjNA4e6kimDUX0bhD62ODIRtHPCS5fuM0PiMqMa4vrRbUNcI0qBG1Da+IXBi
	 3JKSlFu3nGbiIkk5v/L76cTjkeqcIrFzOVTiLL/1uOSukhCLlIv9b+HCD3471yrWf5
	 rM/FNH5bproPGqR0G+jC9XYb+pOC5ON6v7ZPs6spKDikQmr1iQie7F12qH8vmZNqD8
	 /kBcR5jqRH8KWCdm74p+uASx5Ttb+F6SFK0DDxLswrSoamw0VQs6piAmjHGsMMIvBr
	 vPWQkSJFkxzUw==
Date: Fri, 13 Feb 2026 17:57:31 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH 05/10] RDMA: Provide documentation about the uABI
 compatibility rules
Message-ID: <20260213155731.GT12887@unreal>
References: <0-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
 <5-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
 <20260213102347.GL12887@unreal>
 <20260213125658.GF1218606@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213125658.GF1218606@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16877-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 72125137BE5
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 08:56:58AM -0400, Jason Gunthorpe wrote:
> On Fri, Feb 13, 2026 at 12:23:47PM +0200, Leon Romanovsky wrote:
> > On Thu, Feb 05, 2026 at 09:45:39PM -0400, Jason Gunthorpe wrote:
> > > Write down how all of this is supposed to work using the new helpers.
> > > 
> > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > > ---
> > >  include/rdma/ib_verbs.h | 81 +++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 81 insertions(+)
> > 
> > Can we add these rules to Chris's review-prompts?
> 
> Yes, I was thinking about the same thing, not sure how to do that

As a start, you can put it into Documentation folder.
Here https://lore.kernel.org/all/20260212124208.187e53ae@kernel.org,
Jakub says that Chris is changing prompts to consult with Documentation/*.

Thanks

> 
> Jason
> 

