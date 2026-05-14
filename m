Return-Path: <linux-rdma+bounces-20702-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UO8oBkPuBWpWdgIAu9opvQ
	(envelope-from <linux-rdma+bounces-20702-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 17:46:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CDF5443A1
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 17:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1B923010490
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 15:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E046410D23;
	Thu, 14 May 2026 15:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJDc7HKq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2075E39A058;
	Thu, 14 May 2026 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778773173; cv=none; b=YmW5STxu9YmtHyhC1SS7m3uSFQ5jiid8lLJLSj4VY8c3Cp2VcgeqK5b7QtNluqNZlgJGvPUaj5qBYpczKGS7ZzmM/ITr72Z1AiSEpmk671KhbdiBzwrkneCVuScwiVW/vdA3TT7V1oT9a8VUQTRZOjXF3W+E5A9eeoo90zq7/+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778773173; c=relaxed/simple;
	bh=Q8rrleqv5Sb7oOjGmlWrOSAFzd37m6TjSrDHQmTtJHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hO/NmgubUe+GMeLv+60eiVaO/WDClFOWxDrK7mvFG4aOfKQ//62rneBfpbQY+iuUWhGnnUIkXkzRu6lIB4x/oivqM6ikQRx7uua5NY+aa0O3zdEZwJ5xm8ZezQM7EUX2zjpnOvsbHRLTrlKsGD+Zb86YNGElGM1HjRwhjYRz0m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJDc7HKq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4816AC2BCB3;
	Thu, 14 May 2026 15:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778773172;
	bh=Q8rrleqv5Sb7oOjGmlWrOSAFzd37m6TjSrDHQmTtJHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IJDc7HKqvD7Uji1KR7x/Wn0oiFpYac5rMRVvXsUyvMmNSquLLyiDByDRW3+PgOd9B
	 d3sNW2aXtc3FMnXIedV96uUq7wYCk1J5J81dhyLeUtaCK7TCHOEi4125i/TuiuqKVP
	 y8FE2AiRnklFu3iADjn2kDXqAr6fNmPNzwSfqZbmAQagbFljKasIJSY+eIi9+h044n
	 chZerRupKETjMR6M/6vFlnOBo9gDZ7bDqx4XD+F9Il9krJs02OCqNQa1xxUEkEEudN
	 qOoVVamwFEf8UUrHuQUN5ouxTbFZicVBlFXmwsHd+Vl1phSvWj6E3kxAso5Jn8Vidt
	 0AnciCM7c4xJA==
Date: Thu, 14 May 2026 18:39:27 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Export pci_parent_bus_reset() for drivers to
 use
Message-ID: <20260514153927.GQ15586@unreal>
References: <alpine.DEB.2.21.2605050042390.46195@angie.orcam.me.uk>
 <alpine.DEB.2.21.2605050051390.46195@angie.orcam.me.uk>
 <20260512090006.GQ15586@unreal>
 <alpine.DEB.2.21.2605121104560.46195@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2605121104560.46195@angie.orcam.me.uk>
X-Rspamd-Queue-Id: B7CDF5443A1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20702-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 11:17:29AM +0100, Maciej W. Rozycki wrote:
> On Tue, 12 May 2026, Leon Romanovsky wrote:
> 
> > > Export pci_parent_bus_reset() so that drivers do not duplicate it.  
> > > Document the interface.
> [...]
> > 
> > I wouldn't recommend doing this solely for hfi1. The driver is likely to be
> > removed or significantly changed soon.
> > 
> > https://lore.kernel.org/linux-rdma/177516078937.637585.1447184858924347033.stgit@awdrv-04.cornelisnetworks.com/
> 
>  Thank you for the pointer.  FWIW as per the cover letter I have no own 
> interest in the driver and offered this cleanup as a general code quality 
> improvement.
> 
>  Dennis, please clarify your position, and if you'd rather this change 
> wasn't made, then I'll drop the patches from my local verification setup 
> and won't offer them again.

Let me put on my RDMA maintainer hat.

Since hfi1 is the only user of this newly exported symbol,
and it resides within RDMA, please drop this patch.

Thanks

> 
>   Maciej

