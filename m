Return-Path: <linux-rdma+bounces-16540-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDEJNbyIg2niowMAu9opvQ
	(envelope-from <linux-rdma+bounces-16540-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 18:58:20 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B006EB48B
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 18:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A81E3023527
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 17:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24FE3AE703;
	Wed,  4 Feb 2026 17:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEwmVcOk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6697F3491D6
	for <linux-rdma@vger.kernel.org>; Wed,  4 Feb 2026 17:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770227656; cv=none; b=b4R6LNvfs95RbSTuLkexrho0g+OaDHDyY43q/aMadYCyw1756NuU3tzuMcOj8MyOSSzh7rcLZb8I7owPusS+wdn2jCYjG2Vj84kYekywHJJoiqYgN+FfvIEfHnJq5PyFRcarOZsTRKIVUH8K3xAGRl/MKuwdV+ugu4Pf8RplzEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770227656; c=relaxed/simple;
	bh=5PW2Wj2jfSao4QDvyprje98Gq9xhzWTMwORxWQPxCHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3oFwU5lUUIHxAj3T7EHnIinryk3B0y7XorHSwJneE8xwGlvzxFjEYNitLGqK2jAk2fCySVKhKiPlzfxxWxw6MurPRsYYKgf2G+kjDF4FsKFJCfLQ6xqrWT76rIsNR8pAq8SMDYn7lNbdTXmHpwyqZ303H5WhHxyuKhDm9MNNBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEwmVcOk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48AC1C19423;
	Wed,  4 Feb 2026 17:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770227655;
	bh=5PW2Wj2jfSao4QDvyprje98Gq9xhzWTMwORxWQPxCHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NEwmVcOkCvAegWRTkQRadb/LKDA5euoYWah1CdvzORLEe+qDzF0DlXPxBuWOA6Ys8
	 yNF2EU3pog6P7XHaMMbWFN0T48BlKxHG541XG8m9p3Xl94RHKS3yD3FosR5OJcfOOj
	 zq4OuYWQLHLoyZcNuQvnDzMntkejaKG8qdaaHLOkKU6WMT1dt1Y3fXJqm2FMF97eGr
	 bmfrBXoac74KGvcZMT5c9fq8hO0cDvazo9kH71TvTaXlWxmcV4Aj3KjqFY/ScvHjsf
	 BBcu9SbBf58WEfknAf78ddhM2NDL4KYH/T5afVFZz7k/YSfkETgbIbZbgK7FgHPmmy
	 gOgsISO1JYT6w==
Date: Wed, 4 Feb 2026 19:54:11 +0200
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
Subject: Re: [PATCH rdma-next 01/10] RDMA/umem: Add reference counting to
 ib_umem
Message-ID: <20260204175411.GB12824@unreal>
References: <20260203085003.71184-1-jiri@resnulli.us>
 <20260203085003.71184-2-jiri@resnulli.us>
 <20260203145138.GQ2328995@ziepe.ca>
 <424kifntiluu2rrsqea6k3aatduoqemjccmsun5z6rvx67xo43@6q4t3r44ql3e>
 <20260203165938.GS2328995@ziepe.ca>
 <q4cc35lcpl2xrziu7c7hkebib6mc4bnapztckk3duzv5uzyjv7@f4nqhsi57wi7>
 <20260204174615.GI2328995@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204174615.GI2328995@ziepe.ca>
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-16540-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B006EB48B
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 01:46:15PM -0400, Jason Gunthorpe wrote:
> On Wed, Feb 04, 2026 at 04:38:22PM +0100, Jiri Pirko wrote:
> 
> > >Generally I would not assign to the driver's umem storage until the
> > >creation is completed to avoid this. ie it stays null until committed.
> > >
> > >But looking at mlx5 that looks like quite a maze there.. Yikes..
> > >
> > >So maybe mlx5 adds some NULL assignments on its error paths and less
> > >convoluted drivers can use a simpler option?
> > 
> > How about we have:
> > 	int (*create_cq_umem)(struct ib_cq *cq,
> > 			      const struct ib_cq_init_attr *attr,
> > 			      struct ib_umem **umem,
> >                                              ^^
> > 
> > 			      struct uverbs_attr_bundle *attrs);
> > 
> > And instead of taking ref in the callee we just do *umem = NULL? :S
> > 
> > This would help to cover the error path vs destroy path differences,
> > Tt could also be used to make sure the op consumed all umems; all
> > should be NULLed on success.
> > 
> > Makes sense?
> 
> I'm ok with that, though never seen the pattern before. If the core
> code fails on !NULL it would be pretty hard to use it wrong.

I'm less excited to see unique coding patterns. We should rather invest
time in effort to layer everything correctly.

Thanks

> 
> Jason
> 

