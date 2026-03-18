Return-Path: <linux-rdma+bounces-18349-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAcqIyXKumkLcAIAu9opvQ
	(envelope-from <linux-rdma+bounces-18349-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 16:52:05 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C3C2BEA9C
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 16:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 215213062FA6
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 15:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E273BED40;
	Wed, 18 Mar 2026 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5KLqPxJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BDA3E5ED0
	for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773848644; cv=none; b=Kafl37OGywKw1+o/+NJQ2YLuAdijDwCDgvWnL1X/0Wm2hBSfijzKEjYL6pkSqxcB54Ggg0vWjKSI+eTOBjg1MrXlNXm8mRc1LqbsA0ROCm/hvmxH7/rTUcgVP5tlNv505FXmjFSxM60MP617+OmYgdR1pwqd47ChGKOCJHht5KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773848644; c=relaxed/simple;
	bh=VO8tBa3Bp9vuiFXKMMfeoOaFvHk35Zu6Q/z7NztNGn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpFvUdlDlsqgTIrhT+AmBpZqVpp41Ku32mMh+6bdjM88kNVk99jaDkyzoGC4fyTFjmZ1PX1OAbjbDVCWcUs5XuyGYb1m5vnx/Sv48VsGkyNBjCbqHhsMh0ZbyevEZ3lZz7NRJPXlZz4Lh9ePqam2z/9NgFNkl2bJaz2dNzmTmaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5KLqPxJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB5FC19421;
	Wed, 18 Mar 2026 15:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773848644;
	bh=VO8tBa3Bp9vuiFXKMMfeoOaFvHk35Zu6Q/z7NztNGn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i5KLqPxJNpBEucHCxi6D3BaspJ0mux6ez6LmaFnqrhDT8nmiLkk/ZPNXm58r2Lrmw
	 q2mCzYSyJVurXW6wUaW5YmE6BtVUuqRjzGoSxNZ7mukn8M00aLys520Y+KwZo0wkj6
	 l5iiWbRkyoQdxXsGVROfbGqfeCKgrwWRD9CTlPSbY3KBw4rm9vUjxg7i1KdHgWplC+
	 lO1xdMZF7ipKpyKM0kgvKl4Ppyncc7olvJvDpDYM8QzlzKIi7uakP8oInqY1Q8Qhzn
	 3sYmSy1YIIYNq4GyXQ/NEjC36Gw69UAWqfV4tapfdJ8LD19TZEIO0tP1+UK34Njc9s
	 yKsxdYCI+b7Eg==
Date: Wed, 18 Mar 2026 17:44:00 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: jgg@ziepe.ca, Dean Luick <dean.luick@cornelisnetworks.com>,
	Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2] RDMA/hfi2: Consolidate ABI files and setup
 uverbs access
Message-ID: <20260318154400.GG352386@unreal>
References: <177384649619.507973.16055266883386579175.stgit@awdrv-04.cornelisnetworks.com>
 <20260318153558.GE352386@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318153558.GE352386@unreal>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18349-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,cornelisnetworks.com:email]
X-Rspamd-Queue-Id: 35C3C2BEA9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 05:35:58PM +0200, Leon Romanovsky wrote:
> On Wed, Mar 18, 2026 at 11:08:16AM -0400, Dennis Dalessandro wrote:
> > hfi1 driver is being replaced eventually with an hfi2 driver. Until that
> > happens rather than have all the duplicated code in header files, make hfi1
> > use hfi2 variants where it can. When compatibility breaks we'll keep a
> > separate hfi1 version.
> > 
> > This is the case for the <dev>_status struture. The hfi1 varaint is single
> > port and uses a freezemsg char array while the new hfi2 chip provides
> > multiple ports and thus needs and array of ports.
> > 
> > Likewise the tid info struct is expanded for hfi2 so we include both an
> > hfi1 and hfi2 vaiant.
> > 
> > There is a naming conflict with the trace_hfi1_ctxt_info() call. It has been
> > renamed to remove the 1 from the function name to keep the code readable
> > but allow it to compile due to the #define in hfi1_ioctl.h.
> > 
> > The big departure from hfi1 is that we are no longer supporting access from
> > users through a private character device. Instead we define two custom
> > verbs ojects. dv0/1, which proivdes methods for what in hfi1 are individual
> > IOCTLs. We have added an additional method to get stats related to page
> > pinning done by the driver.
> > 
> > The hfi1_user.h is no longer needed and is removed from the uapi directory.
> > There is a private compat header in hfi1 that will be deleted when hfi1 is.
> > This removes driver specific content from generic RDMA UAPI headers.
> > 
> > Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
> > Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
> > Co-developed-by: Bendan Cunningham <brendan.cunningham@cornelisnetworks.com>
> > Signed-off-by: Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>
> > Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> > 
> > ---

<...>

> > +#endif /* _LINIUX_HFI2_USER_H */
> > diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
> > index 89e6a3f13191..c7573131c862 100644
> > --- a/include/uapi/rdma/ib_user_ioctl_verbs.h
> > +++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
> > @@ -256,6 +256,7 @@ enum rdma_driver_id {
> >  	RDMA_DRIVER_ERDMA,
> >  	RDMA_DRIVER_MANA,
> >  	RDMA_DRIVER_IONIC,
> > +	RDMA_DRIVER_HFI2,
> 
> This hunk should be separated and submitted as part of hfi2 addition.

BTW, you can also try something similar to RDMA_DRIVER_IRDMA where Intel
used same ID for irdma and I40IW.

Thanks

