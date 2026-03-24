Return-Path: <linux-rdma+bounces-18561-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOdBCSZIwmnvbAQAu9opvQ
	(envelope-from <linux-rdma+bounces-18561-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 09:15:34 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C13AB3046DA
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 09:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B796311942B
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 07:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5621835A925;
	Tue, 24 Mar 2026 07:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIDsDL4h"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5228835A938;
	Tue, 24 Mar 2026 07:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774338840; cv=none; b=Llzt0bxRMtbbvd/VeP8/DwwrZhJFxBdzji2YmHKVuu0/eVFLBfR7W3R3klT0JtLX+C4cXKtZmo4HSOM++QxQckzf2/hMemP/KjHh6mKnoSpFx9Mawp+lNQumAFP5dSVEmDY5GHE0U5YspbTJqK9lEzTBrSqRQ4AaSLXOHCt3/eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774338840; c=relaxed/simple;
	bh=Ej9RCyIOXuBU2R580hspIcOSN/7Z/230zHmQBCAb5vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDQ0Oym4h2hq58+Kg0K7WxVMwbLqZ30emq+ZPOSE15UfBg6oZxCiOaRY+9mTit3ShldthJAFQLzf1/MkDckHjmqs9sqzjaLOBJs5k5/zuNJwS1Hg7oztn1lZn1nyXWhAlXIyKnBrnXEfEM7i7VG1hc8+rtgXAHHVBW2d89ZwEPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIDsDL4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23AFC19424;
	Tue, 24 Mar 2026 07:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774338839;
	bh=Ej9RCyIOXuBU2R580hspIcOSN/7Z/230zHmQBCAb5vQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FIDsDL4hZPkGOiHWsluE2fT/pM/oiRwKaaBv3L0WXw1xI6ftQzQMfYyQwjLVgzrmV
	 1vixwnTfsJXkPMlApHbPhk0hVP5+lyEyVaLAoF9f86RKtqsN4wJixwruv4TtUrfcG1
	 URnRt2E9vdIJZEdNkNFzrbpRNWTHUdSTJunWOGFKX4zdggi69/KUWCyJlECUzGe9UA
	 YgfJwTcn9tsIZZI1o/VpP2mHtYyzOWypWp1S8/uGn0fEPwF56p0lyTVOSTPlaXgsf0
	 ieKv9ONoIxU59JC/9upazSPUFWDjj5r2GMLPQQsgyeU7ao/2snzNtDwZfpUSzRkXme
	 sQBf29CFd5e7w==
Date: Tue, 24 Mar 2026 09:53:54 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Nathan Chancellor <nathan@kernel.org>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	Doug Ledford <dledford@redhat.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Ingo Molnar <mingo@kernel.org>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 2/3] RDMA/hfi1, rdmavt: open-code rvt_set_ibdev_name()
Message-ID: <20260324075354.GM814676@unreal>
References: <20260320151511.3420818-1-arnd@kernel.org>
 <20260320151511.3420818-2-arnd@kernel.org>
 <6b56c476-86fd-4d43-8dee-c7f89d346941@app.fastmail.com>
 <20260323080848.GF814676@unreal>
 <5d5f25fc-e522-4131-ae4b-22db57b92d6e@app.fastmail.com>
 <20260323110144.GG814676@unreal>
 <8f060e86-5727-4cf6-ac03-7f7174b5a9fd@cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f060e86-5727-4cf6-ac03-7f7174b5a9fd@cornelisnetworks.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18561-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[arndb.de,kernel.org,ziepe.ca,intel.com,redhat.com,gmail.com,google.com,suse.com,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,lkml];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C13AB3046DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 05:47:43PM -0400, Dennis Dalessandro wrote:
> 
> 
> On 3/23/26 7:01 AM, Leon Romanovsky wrote:
> > On Mon, Mar 23, 2026 at 09:48:59AM +0100, Arnd Bergmann wrote:
> > > On Mon, Mar 23, 2026, at 09:08, Leon Romanovsky wrote:
> > > > On Fri, Mar 20, 2026 at 04:53:04PM +0100, Arnd Bergmann wrote:
> > > > > On Fri, Mar 20, 2026, at 16:12, Arnd Bergmann wrote:
> > > > > 
> > > > > > +	 */
> > > > > > +	ibdev = &dd->verbs_dev.rdi.ibdev;
> > > > > > +	dev_set_name(&ibdev->dev, "%s_%d", class_name(), dd->unit);
> > > > > > +	strscpy(&ibdev->name, dev_name(&ibdev->dev), IB_DEVICE_NAME_MAX);
> > > > > > +
> > > > > 
> > > > > I messed this up during a rebase, that should have been
> > > > > 
> > > > >         strscpy(ibdev->name, dev_name(&ibdev->dev), IB_DEVICE_NAME_MAX);
> > > > > 
> > > > > (without the extra &). I'll wait for comments before resending.
> > > > 
> > > > The hfi1 driver is scheduled for removal. Dennis has already posted the
> > > > hfi2 driver, which serves as its replacement.
> > > 
> > > Ok, that does sound like a sensible decision, and I'll just drop
> > > patches 1 and 3 then, which are just cleanups.
> > > 
> > > The cover letter at [1] suggests that the two drivers will still
> > > coexist for a bit though, so I think we'd still want patch 2/3
> > > in order to get a clean 'allmodconfig' build when the
> > > -Wmissing-format-attribute is enabled by defaultt. I have a couple
> > > of patches in flight.
> > 
> > Sure, builds need to be fixed.
> > 
> > > 
> > > I took a quick look at the hfi2 driver, and noticed a few things
> > > that that may be worth addressing before it gets merged, mostly
> > > stuff copied from hfi1:
> > > 
> > > - A few global functions with questionable namespacing:
> > >    user_event_ack, ctxt_reset, iowait_init, register_pinning_interface,
> > >    sc_{alloc,free,enable,disable}, pio_copy, acquire_hw_mutex,
> > >    load_firmware, cap_mask.
> > >    It would make sense to prefix all global identifiers with 'hfi2_',
> > >    both out of principle, and to allow building hfi1 and hfi2 into
> > >    an allyesconfig kernel without link failures.
> > > 
> > > - The use of INFINIBAND_RDMAVT seems unnecessary: right now
> > >    this is only used by hfi1, now shared with hfi2 but later to
> > >    be exclusive to the latter. Since it is unlikely to ever
> > >    be used by another driver again, this may be a good time
> > >    to drop the abstraction again and integrate it all into
> > >    hfi2, with the old version getting dropped along with hfi1.
> > 
> > The best approach is to drop rdmavt as well, since hfi2 is expected to
> > align with the other drivers in drivers/infiniband/hw.
> > 
> > Dennis, is this feasible?
> 
> Feasible yes. I'd like to get hfi2 crossed off the list and in the tree
> first though. Then come back and do that. I'd like to do more than just plop
> rdmavt inside hfi2 and call it a day. There is a lot of code
> cleanup/simplification that we can do.

So let's add a TODO file under drivers/infiniband/hw/hfi2 to track these
future improvements.

Thanks

> 
> -Denny
> 

