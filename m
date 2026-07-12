Return-Path: <linux-rdma+bounces-23064-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DDh1LidRU2ofZwMAu9opvQ
	(envelope-from <linux-rdma+bounces-23064-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 10:32:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 188E87442A2
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 10:32:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nUNaIwfD;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23064-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23064-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEA35300EF47
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 08:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAE5308F2A;
	Sun, 12 Jul 2026 08:32:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B03266581
	for <linux-rdma@vger.kernel.org>; Sun, 12 Jul 2026 08:32:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783845157; cv=none; b=ZTJBIOAwNpsLJo1M10FWKEz3sMQ7LRgVG44c/ZhjJmg5qXtvSrfp1616Qu7M8AT58lQN3KVO5qYKdQ5errGyXCkO9znGuCt2K9igVOO9asZk8CLbxa1PZcV3tanHbUTh0A6sUjZiBBjxgT8LN8BOcMD0xgR9CedFkIUMJoTogFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783845157; c=relaxed/simple;
	bh=TngsQJbHEmgnaEVQVI2KKyb2DJcdE29dzBZVVPFwVbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+/qUcin75e1wu5uDxV8I5apxeQv2g6NiIEX+Co/peWyXZYROOq3aMpov3yzgrEDg/h1Of7mmL8zRnNjC6YlSnLbfl2Nx/sgRSmaajv8TOVzr865ghGWXexbXhFu5twYVj9zAqBZlj1ZqsvcD7bcMY2UeEvL92j2nr7TqgUwbpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUNaIwfD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410231F000E9;
	Sun, 12 Jul 2026 08:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783845155;
	bh=g/gbwKBTNKP7GsnKso3fNTKrEVTAeaxIsvNuRteZWXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nUNaIwfDYIv92FCSv6nv9G4dNIiK/8d0lAFYE/2Cz8IPJuCzJIUWIAr/7uO76NVNZ
	 V6JWUow8XKGqPXLm90+FZoDxQOvUNPzBWDiptNdpOq8kO6B/O0u2HjYMh+XfweY4AV
	 zpO4ipzR4trCEXVqS1aK6Z1JPHG3aVMecFtD3R0xrY3fmne1c/1i9IHXHrVJm4VAUS
	 +Z9S27Sv73nGOX5RE3lhl+dpqf4uWhTLPSL9b1siLi5XH3fBUNWnL19acfkz5LEyQQ
	 nMIkyhLZaMFrh508ZR1J5BMMJd2Yn0RbX3rN86bKAcmx0LXODlvznOnahjb5h8zS4I
	 xEdVHqwuudRDQ==
Date: Sun, 12 Jul 2026 11:32:29 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jacob Moroni <jmoroni@google.com>
Cc: tatyana.e.nikolova@intel.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v3 0/7] RDMA/irdma: Adopt robust udata
Message-ID: <20260712083229.GB33197@unreal>
References: <20260702170652.4159201-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702170652.4159201-1-jmoroni@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23064-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jmoroni@google.com,m:tatyana.e.nikolova@intel.com,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[unreal:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 188E87442A2

On Thu, Jul 02, 2026 at 05:06:45PM +0000, Jacob Moroni wrote:
> This series brings irdma up to uverbs_robust_udata compliance.
> 
> The driver has been audited to confirm that:
> 
>   1. Methods which do not accept udata input perform an explicit
>      check for no (or zero value) input.
> 
>   2. Methods which do accept input perform the correct validation
>      to ensure that additional udata beyond the kernel's current
>      ABI definition is zero, and to enforce the required minimum
>      length.
> 
>   3. Methods which do not return udata responses use the proper
>      helper.
> 
> The irdma driver is backwards compatible with the legacy i40iw
> provider, so special care was taken to avoid breaking any legacy
> binaries, as there were some small differences in the ABI/semantics.
> 
> This has passed the rdma-unit-test suite using the normal irdma
> provider from upstream rdma-core.
> 
> NOTE: This series is based on a few irdma bug fix patches
>       which have not yet been merged:
> 
> - RDMA/irdma: Prevent user-triggered null deref on QP create
>   https://patchwork.kernel.org/project/linux-rdma/list/?series=1113053
>      
> - RDMA/irdma: Prevent premature deregistration of user ring MRs
>   https://patchwork.kernel.org/project/linux-rdma/list/?series=1113648
> 
> Changes in v3:
> * Add ib_no_udata_io helper to more easily handle the
>   common case of no input/no output ops.
> * Fixed regression in create_qp failure path caught by sashiko.
> * Rebased on top of previous posted irdma fixes.
> * Fixed an additional latent legacy compat bug in create_qp.
> * Added missing response buffer clearing for reg/rereg_user_mr.
> Changes in v2:
> * Fixed Sashiko findings:
>   - Moved ib_respond_empty_udata to beginning of most
>     methods to close gaps where it could previously
>     return 0 without calling ib_respond_empty_udata. This
>     also fixes issues where the ib_respond_empty_udata
>     call itself could fail, which may leave resources
>     in an inconsistent state (kernel believes object
>     is alive, but driver resources have been cleaned up).
>   - Moved input validation to beginning of modify_qp
>     methods to close gaps where the op could be invoked
>     with udata but without input checking.
>   - Fixed a QPN leak that could occur during QP create
>     by moving input validation earlier.
> 
> v2: https://lore.kernel.org/linux-rdma/20260629232532.2057423-1-jmoroni@google.com/
> v1: https://lore.kernel.org/linux-rdma/20260627025642.4064973-1-jmoroni@google.com/T/#t
> 
> Jacob Moroni (7):
>   RDMA/core: Add ib_no_udata_io() helper

I applied only first patch, rest needs to be resent.

Thanks

>   RDMA/irdma: Add checks for no udata
>   RDMA/irdma: Clear udata response buffers where necessary
>   RDMA/irdma: Use robust input copy helpers
>   RDMA/irdma: Use robust udata helper for QP creation
>   RDMA/irdma: Fix legacy i40iw compat check in create_qp
>   RDMA/irdma: Enable uverbs_robust_udata compliance flag
> 
>  drivers/infiniband/hw/irdma/verbs.c | 216 +++++++++++++++++++---------
>  include/rdma/uverbs_ioctl.h         |  20 +++
>  include/uapi/rdma/irdma-abi.h       |   1 +
>  3 files changed, 167 insertions(+), 70 deletions(-)
> 
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
> 

