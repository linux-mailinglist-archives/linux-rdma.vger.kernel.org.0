Return-Path: <linux-rdma+bounces-19567-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPH6Cu8Y7mm/qgAAu9opvQ
	(envelope-from <linux-rdma+bounces-19567-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 15:53:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C718546A2A2
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 15:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D21E300231F
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 13:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B68363089;
	Sun, 26 Apr 2026 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zsl2UJ3P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA6A310620
	for <linux-rdma@vger.kernel.org>; Sun, 26 Apr 2026 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777211626; cv=none; b=TQGck5BKYTpBR3BdpHFlUOlqBuRBfsw+ZMkwxS5UBRytCGB2TZbW9mKTiI4ZfO2ebJ/xPUJO2/5ZemAghNWJW1VmQmAC/Cf4VvxkzU3CQ/pubhW0j+GKgrR+fIHXLTzx2zxiScxbyLpcY27zzZ6r5ygyPYw5gTOUY8DIsEMV4bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777211626; c=relaxed/simple;
	bh=3rJNtN/lx+V0j7xttEISYsjhwKjkbHo5XMTdXUFKaMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msO5KhvL9ueAZ43g79DDHrvJjD2pt76EeAw5x3X87PAcy/rY9oBVpIREA4Kww5lNaleTdY6JBzoNw1OGTQgrzNP/Uj77U+3WRqD+HqOvCt3byn8yJph4YCQBbQxrRkfvgSPzVppDu51Tl0vi635ExWtQVS6ntZ4yB1aNNC8pIYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zsl2UJ3P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EE4C2BCB3;
	Sun, 26 Apr 2026 13:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777211626;
	bh=3rJNtN/lx+V0j7xttEISYsjhwKjkbHo5XMTdXUFKaMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zsl2UJ3PeDYxHxhk1f5FJxl9v2cgIjzy/JA1jGr9uymutAOQg6KKiqvlPQtS/kK6R
	 zVqc1D0NpQ5Cra5u1aP/6eUtreq0q2Ej0sWB0XuytaodIKsrc4a2G3Em+DoLY2YbXw
	 +XAx5FG4vwb0LfxNiot5XX/ZRgqDVGAtPtmQV3nHYRy1cB5V5wuJpB60zdT2O1dTVn
	 cFMdkJscUUXatUugTqU1JW4Pp+/Ub0fhCdMXDochN+nGnDU00UHwocSH8tQI6sm1ZI
	 /wv0i4z3IXhnIEOc6HaxXDNoR2p9FhtMQ316YBLJ1a/TPkO3OK6ghLDc3NsA7ulG0s
	 vjVeMGf5d915Q==
Date: Sun, 26 Apr 2026 16:53:40 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jiri Pirko <jiri@resnulli.us>, linux-rdma@vger.kernel.org,
	mrgolin@amazon.com, gal.pressman@linux.dev, sleybo@amazon.com,
	parav@nvidia.com, mbloch@nvidia.com, yanjun.zhu@linux.dev,
	marco.crivellari@suse.com, roman.gushchin@linux.dev,
	phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com,
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com,
	ohartoov@nvidia.com, michaelgur@nvidia.com, shayd@nvidia.com,
	edwards@nvidia.com, sriharsha.basavapatna@broadcom.com,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v2 01/15] RDMA/core: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <20260426135340.GH440345@unreal>
References: <20260411144915.114571-1-jiri@resnulli.us>
 <20260411144915.114571-2-jiri@resnulli.us>
 <20260421134635.GG3611611@ziepe.ca>
 <pun4bxcclwqmurxzxuqlkv5qdpiqcxqjpbhrz7vtsjf2paallz@6f3w32ww4gl7>
 <sdmwjrxzgbg4iz5cspcdkvvdb7rjgdggkw4njct3pkdsvhsq24@qstis6jnplap>
 <20260422165101.GO3611611@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422165101.GO3611611@ziepe.ca>
X-Rspamd-Queue-Id: C718546A2A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19567-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Wed, Apr 22, 2026 at 01:51:01PM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 22, 2026 at 04:06:03PM +0200, Jiri Pirko wrote:
> > >>Just brain storming, but if we let the driver pass in its uhw
> > >>information inot a getter:
> > >>
> > >>  struct ib_umem *uverbs_attr_get_umem(struct
> > >>      uverbs_attr_bundle *attrs, u16 idx,
> > >>      u64 uhw_umem_base, u64 umem_len);
> > >>
> > >>  dbr_umem = uverbs_attr_get_umem(attrs,
> > >>                     MLX5_IB_ATTR_QP_DBR, uhw->base, uhw->len);
> > >>
> > >>Then if the new attribute is provided the uhw is ignored, otherwise a
> > >>ib_uverbs_buffer_desc is created from the udata parameters instead.
> > >>
> > >>Drivers use the normal attr indexes to define their many umems for
> > >>something complicated lik QP.
> > >
> > >Won't this go backwards? I mean, I was under impression that we want to
> > >move the umem creation to core. What you suggest is the driver initiates
> > >the umem creation. I personally think that it is nicer the way you
> > >suggest, since the core is the owner and responsible for cleanup and
> > >umems are created upon need.
> 
> Well, brainstorming idea. I'd like to hear from Leon too
> 
> But if we set the general goals as:
> 
> 1) All umem creations should have a struct ib_uverbs_buffer_desc at
>    the UAPI boundary
> 2) ib_uverbs_buffer_desc should pass directly to umem code without any
>    driver touching it. ib_uverbs_buffer_desc should be the only way to
>    create a umem from a driver.
> 3) Existing UWH umem descriptions must continue to work if the desc is
>    not provided, by reforming them into a desc
> 3) Cleanup and lifecycle should be centralized

I have mixed feelings about this. My CQ conversion showed that even a simple
task like creating a CQ umem (numb_of_entries * size_of_entries) ends up full
of creative hacks in various drivers. Because of that, I see real value in
pushing as much logic as possible into the core code instead of duplicating it
across drivers. However, my later attempt to change the QP path made it clear
that creating umems in the core is not a viable goal in the general case.

Another outcome of that work was realizing that CQ resize (and probably MR
rereg as well) becomes messy when we keep the "old" umem around. Splitting
creation and cleanup into different layers probably will going to hurt us
at some point of time.

To summarize:
1. The most practical fix is likely to provide a driver callback to create
   the umem when needed, as you suggested.
2. We should reduce the use of UWH as much as possible in favor of a
   well-defined schema. In the long run, we want to add more umem types,
   and many drivers should work out of the box under that model.
3. Explicit behavior is preferable. If a driver creates something, the
   driver should also clean it up.

I'm not saying no to your proposal, just expressing my thoughts.

Thanks

