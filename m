Return-Path: <linux-rdma+bounces-16538-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHwyHXqGg2niowMAu9opvQ
	(envelope-from <linux-rdma+bounces-16538-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 18:48:42 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E41EB272
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 18:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D10D3301650C
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 17:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146A83B8D5F;
	Wed,  4 Feb 2026 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzkRWBw5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2B13AEF34;
	Wed,  4 Feb 2026 17:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770227206; cv=none; b=FXIlXl90BZp6aVdxsUeindl2YNjAjs2BD4qQRIB57Juc+6jSHbiy1ZWxQmejJC//utbyOrjyB7QeAdURU+6mjSAyZREJZh5O35K4xRfK67fLpOqkP0hdPo2LYc27Dfh3jdqu4kCizEOOu37tSDdFJBCUfZddOh8sYSOf0FdP4hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770227206; c=relaxed/simple;
	bh=FMpw7MCRAxpI19L4sGevw2nu0PxGdX+AeHvLnk4cicI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6ycxXMZOep0IPWv6PtUtd5h9h+xPI4gtL2H/6EtGGL7h3XAO1WaXE6MPvx4FY0Ke3cgaUODty98p/uABDaXz+qumEOVcULjtcHJJxdbNh7BmRsIGlDjTD6LY/Z/V2OC+7e2jSP8wOzLAOC1neemg5PL6oWCBVm3SRjDADCRDJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzkRWBw5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB82C4CEF7;
	Wed,  4 Feb 2026 17:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770227206;
	bh=FMpw7MCRAxpI19L4sGevw2nu0PxGdX+AeHvLnk4cicI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jzkRWBw5SRTHOnH2WrKCixE194N9KteMRjsWqxVBh77I2GYd4fIfzp+bCnNG85nxP
	 mIoPqkXKBv5WrAzFq3HjkaL19vBm2oeao367b+NzYTxEk1UEBtWpEy8ivuTxRo0SG+
	 mVLItx4FeEsI6cqoFa+VzasG5xvYzOuJ4Ng2W8MiXmL0VTajKTXPgN83SjcIKEwtvW
	 8GbMjn0zlR1Jm2eD9vrYSVuo3us4qQPR8BLpNY9O8OxMBKccja2gjnJk+RR0j0wobv
	 hpq+UhtMsbl39u80kZN0BiUNZq8hrOKqle/SvXeJL08Cs1jIZHcyzv6V8oJlxlykSZ
	 kXPoQuHcRuO2g==
Date: Wed, 4 Feb 2026 19:46:43 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Konstantin Taranov <kotaranov@linux.microsoft.com>,
	kotaranov@microsoft.com, shirazsaleem@microsoft.com,
	longli@microsoft.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: return PD number to the user
Message-ID: <20260204174643.GA12824@unreal>
References: <20260204135813.870538-1-kotaranov@linux.microsoft.com>
 <20260204142827.GF2328995@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204142827.GF2328995@ziepe.ca>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16538-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8E41EB272
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 10:28:27AM -0400, Jason Gunthorpe wrote:
> On Wed, Feb 04, 2026 at 05:58:13AM -0800, Konstantin Taranov wrote:
> > From: Konstantin Taranov <kotaranov@microsoft.com>
> > 
> > Implement returning to userspace applications PDNs of created PDs.
> > Allow users to request short PDNs which are 16 bits.
> 
> Why does userspace ever need to see a PDN? Please justify that in the
> commit message

Probably for the debug and we have restrack for it.

Thanks

> 
> Jason

