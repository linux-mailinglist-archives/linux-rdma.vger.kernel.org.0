Return-Path: <linux-rdma+bounces-18515-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFYjOLMdwWlaQwQAu9opvQ
	(envelope-from <linux-rdma+bounces-18515-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 12:02:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 835CA2F0BD7
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 12:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3BAC4301060A
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 11:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B22D392C28;
	Mon, 23 Mar 2026 11:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IX4tHpFV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09BE392802;
	Mon, 23 Mar 2026 11:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774263714; cv=none; b=BNv1yuHDnNFRro3QvpsDZO0plNgQcxjfrzVNWGKanLKNuEuBTVHsxKlEjx7WT8M8M/s2AeqlWsaZGJ8gi/FmyfASrYmdBCxOVn8qP9uSXjlgLpGpvX/kL2c8kgRxaBS9ssal0hYNDEMewf5LImxv0CJ5xLm+LrvUt/WEjR8IxZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774263714; c=relaxed/simple;
	bh=imVv5EG3DZvwMibJMQPIQgAXd8NxzOALu6vmEfSTsPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNwrc+Bqo6epyT0GVNPLxTGztTras/oHU8/yYMYFATL+AL5b8qgTLr1ZfWaSL1jlTfY3/RFvcoC/8prjzB1o3ZbHhEiijT/2iIJmFJaI0ud66xX+89kOqKkpIqwSvBqNaiDz5Kq8t2vZFloTBVqKMNcKTmd04AXN38s+AjIEMqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IX4tHpFV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3458C4CEF7;
	Mon, 23 Mar 2026 11:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774263713;
	bh=imVv5EG3DZvwMibJMQPIQgAXd8NxzOALu6vmEfSTsPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IX4tHpFVUpZsw6fAFSiGydpzX2vEz/VPYS7T8ep/6DT7rAdreGWGyfgMGYmINZVCy
	 fGCRtVmQYbPpdAsGHP9loA7NwYi+nDE/ZOahYRZM9XeFvArnX0izGFoxwk4OMuNrRf
	 fYzW1aODzleSVsDnkh0AsUFMbpQUGb6eQVkDbnA5uYGafi/MpfywmIQikdnmZMbTPL
	 HWB8iJdXajwXnKZbn26UAU1uhu3YFzSGU5bx741L7DsafprV7DO+2sCDBnfICJ5G5f
	 U3g1Fj3xRlAP5+ermCR9BO+87cjmOt6SZ0nSaSr8jUOSy0SwsQY2QXh175kSmFw8bn
	 qS9+pZrA+Iecg==
Date: Mon, 23 Mar 2026 13:01:44 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
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
Message-ID: <20260323110144.GG814676@unreal>
References: <20260320151511.3420818-1-arnd@kernel.org>
 <20260320151511.3420818-2-arnd@kernel.org>
 <6b56c476-86fd-4d43-8dee-c7f89d346941@app.fastmail.com>
 <20260323080848.GF814676@unreal>
 <5d5f25fc-e522-4131-ae4b-22db57b92d6e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d5f25fc-e522-4131-ae4b-22db57b92d6e@app.fastmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18515-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,cornelisnetworks.com,ziepe.ca,intel.com,redhat.com,gmail.com,google.com,suse.com,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,lkml];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 835CA2F0BD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 09:48:59AM +0100, Arnd Bergmann wrote:
> On Mon, Mar 23, 2026, at 09:08, Leon Romanovsky wrote:
> > On Fri, Mar 20, 2026 at 04:53:04PM +0100, Arnd Bergmann wrote:
> >> On Fri, Mar 20, 2026, at 16:12, Arnd Bergmann wrote:
> >> 
> >> > +	 */
> >> > +	ibdev = &dd->verbs_dev.rdi.ibdev;
> >> > +	dev_set_name(&ibdev->dev, "%s_%d", class_name(), dd->unit);
> >> > +	strscpy(&ibdev->name, dev_name(&ibdev->dev), IB_DEVICE_NAME_MAX);
> >> > +
> >> 
> >> I messed this up during a rebase, that should have been 
> >> 
> >>        strscpy(ibdev->name, dev_name(&ibdev->dev), IB_DEVICE_NAME_MAX);
> >> 
> >> (without the extra &). I'll wait for comments before resending.
> >
> > The hfi1 driver is scheduled for removal. Dennis has already posted the
> > hfi2 driver, which serves as its replacement.
> 
> Ok, that does sound like a sensible decision, and I'll just drop
> patches 1 and 3 then, which are just cleanups.
> 
> The cover letter at [1] suggests that the two drivers will still
> coexist for a bit though, so I think we'd still want patch 2/3
> in order to get a clean 'allmodconfig' build when the 
> -Wmissing-format-attribute is enabled by defaultt. I have a couple
> of patches in flight.

Sure, builds need to be fixed.

> 
> I took a quick look at the hfi2 driver, and noticed a few things
> that that may be worth addressing before it gets merged, mostly
> stuff copied from hfi1:
> 
> - A few global functions with questionable namespacing:
>   user_event_ack, ctxt_reset, iowait_init, register_pinning_interface,
>   sc_{alloc,free,enable,disable}, pio_copy, acquire_hw_mutex,
>   load_firmware, cap_mask.
>   It would make sense to prefix all global identifiers with 'hfi2_',
>   both out of principle, and to allow building hfi1 and hfi2 into
>   an allyesconfig kernel without link failures.
> 
> - The use of INFINIBAND_RDMAVT seems unnecessary: right now
>   this is only used by hfi1, now shared with hfi2 but later to
>   be exclusive to the latter. Since it is unlikely to ever
>   be used by another driver again, this may be a good time
>   to drop the abstraction again and integrate it all into
>   hfi2, with the old version getting dropped along with hfi1.

The best approach is to drop rdmavt as well, since hfi2 is expected to
align with the other drivers in drivers/infiniband/hw.

Dennis, is this feasible?

Thanks

