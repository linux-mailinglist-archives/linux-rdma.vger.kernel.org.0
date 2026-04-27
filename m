Return-Path: <linux-rdma+bounces-19600-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /dSEMP6w72nTDwEAu9opvQ
	(envelope-from <linux-rdma+bounces-19600-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 20:54:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46290478E41
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 20:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72A4D302C5E6
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 18:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034333E8C59;
	Mon, 27 Apr 2026 18:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URAFIiRu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4AD255E43
	for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2026 18:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777316090; cv=none; b=dM3zBSIcE3Iqo4RbhVq4uOObvPiGC+WN+MQWGxwRZqlf5WfaSK5DYpIV8oz9Q3V1uag8lMx+v6XZeZqngpqp5TdHd7OpGUnlXPXsTCsUcoUU7nyFzEqqPl0ktmnpgRWtbsbj6GTkYBZGNo40yQHHWG03SS+5hq2NP3dDpNpyybI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777316090; c=relaxed/simple;
	bh=NqIS6cFgKEUmMK7y/5lG3ifjv3PAbbffYvozGr+NSiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ds25lmJ8YTrH05E7+/GfGkWqnVlj3kC5KKZX5idXFtYZlkTsjhYW5/hHenWCpfV6K1KOIXliluhco7/j5w2VBMnPIi3uD5cN2uKwkogFKAodNX5hUvzjKNicFZi+SLCVTQGyj4rNfEXiUZIAk+9LznzsVAfA5nJB2eNUMbpRy4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URAFIiRu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7DA5C19425;
	Mon, 27 Apr 2026 18:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777316090;
	bh=NqIS6cFgKEUmMK7y/5lG3ifjv3PAbbffYvozGr+NSiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=URAFIiRuEsuwKN5Src2tRSpbigj2vAupZugA9XMMubXP/GUch5/EZX2pGDqZxSshW
	 jNKcC6Va420wrmwEorYFsU2lSa8szPrZecVZC/BqLsjG74uKkWLaWzDST26MY+ByTU
	 pW0WiHZNxxSMn1+tiuFsa7eGEkavHycUS9NRXTHDKO94R6yenQ1Oi0Yu5Bg7R+uek1
	 u0H2Sr7A642ZMuZ5piikNy+W3OWZKkjMKjkIHN/o+IDFZ50BHm8kT5xUB+IJXzaKWH
	 yKK8Z8tPapb5DfEtbSvbzsFlygSqWRehheVZXkWQ1wMdsp3cieJtbs01MvyH2dG2NW
	 MK5mTohrrjDzg==
Date: Mon, 27 Apr 2026 21:54:45 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
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
Message-ID: <20260427185445.GL440345@unreal>
References: <20260411144915.114571-1-jiri@resnulli.us>
 <20260411144915.114571-2-jiri@resnulli.us>
 <20260421134635.GG3611611@ziepe.ca>
 <pun4bxcclwqmurxzxuqlkv5qdpiqcxqjpbhrz7vtsjf2paallz@6f3w32ww4gl7>
 <sdmwjrxzgbg4iz5cspcdkvvdb7rjgdggkw4njct3pkdsvhsq24@qstis6jnplap>
 <20260422165101.GO3611611@ziepe.ca>
 <20260426135340.GH440345@unreal>
 <20260426225034.GA3540346@ziepe.ca>
 <jpobfdsuuj4wmrqkxzpjmfjxgz6vn2m6a6wy666yfapv6hzytj@6g5qrelixuwe>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jpobfdsuuj4wmrqkxzpjmfjxgz6vn2m6a6wy666yfapv6hzytj@6g5qrelixuwe>
X-Rspamd-Queue-Id: 46290478E41
X-Rspamd-Action: no action
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
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19600-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 12:48:46PM +0200, Jiri Pirko wrote:
> Mon, Apr 27, 2026 at 12:50:34AM +0200, jgg@ziepe.ca wrote:
> >On Sun, Apr 26, 2026 at 04:53:40PM +0300, Leon Romanovsky wrote:
> >> > Well, brainstorming idea. I'd like to hear from Leon too
> >> > 
> >> > But if we set the general goals as:
> >> > 
> >> > 1) All umem creations should have a struct ib_uverbs_buffer_desc at
> >> >    the UAPI boundary
> >> > 2) ib_uverbs_buffer_desc should pass directly to umem code without any
> >> >    driver touching it. ib_uverbs_buffer_desc should be the only way to
> >> >    create a umem from a driver.
> >> > 3) Existing UWH umem descriptions must continue to work if the desc is
> >> >    not provided, by reforming them into a desc
> >> > 3) Cleanup and lifecycle should be centralized
> >> 
> >> I have mixed feelings about this. My CQ conversion showed that even a simple
> >> task like creating a CQ umem (numb_of_entries * size_of_entries) ends up full
> >> of creative hacks in various drivers. Because of that, I see real value in
> >> pushing as much logic as possible into the core code instead of duplicating it
> >> across drivers. However, my later attempt to change the QP path made it clear
> >> that creating umems in the core is not a viable goal in the general case.
> >> 
> >> Another outcome of that work was realizing that CQ resize (and probably MR
> >> rereg as well) becomes messy when we keep the "old" umem around. Splitting
> >> creation and cleanup into different layers probably will going to hurt us
> >> at some point of time.
> >> 
> >> To summarize:
> >> 1. The most practical fix is likely to provide a driver callback to create
> >>    the umem when needed, as you suggested.
> >> 2. We should reduce the use of UWH as much as possible in favor of a
> >>    well-defined schema. In the long run, we want to add more umem types,
> >>    and many drivers should work out of the box under that model.
> >> 3. Explicit behavior is preferable. If a driver creates something, the
> >>    driver should also clean it up.
> >> 
> >> I'm not saying no to your proposal, just expressing my thoughts.
> >
> >So, I think making small steps that upgrade all drivers will be
> >helpful here.
> >
> >If we can get all drivers calling the same attrs function and giving
> >their uhw parameters that is a good step closer to being able to put
> >that in a function if that is how things need to go down the road.
> >
> >And it does #2..
> >
> >Not sure about #3, we already moved toward core destroying umems it
> >may not be a good idea to try to undo that now.. But maybe we just
> >keep that for CQ and leave QP as driver managed?
> 
> I think that the uniform approach is better in order not to confuse
> people. Perhaps one day we will manage to untangle the create QP flow
> and separate user/kernel paths too. But:
> 
> After lots for thinking and back and forth motions, I tend to agree
> with Leon, the init/fini alloc/free should be symmetric
> in drivers. Now, that the core will never create umem and the driver is
> always responsible to create it, the driver should be the one to
> do release. Drivers still store the umem pointer locally.
> Then there is not need for ib_umem_list, makes things much easier
> and more neat. Another pro is, the code does not care if called on
> user or kernel part.

I will try to make this a bit more complicated. One of the reasons the
core code releases the umem is that umem has a special meaning: it is
memory pinned with DMA mapped to it  and exposed to user space,
and both HW and SW may read from or write to it. A driver that forgets
to release a umem can potentially cause serious problems to whole system.

So core at least needs to be aware of all exposed umems and be ready to
cleanup them if driver is removed.

I afraid that we will never find "correct" design here. We just need to
decide which approach has less drawbacks.

Thanks

> 
> 

