Return-Path: <linux-rdma+bounces-19257-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNp8Gqix22lkFAkAu9opvQ
	(envelope-from <linux-rdma+bounces-19257-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 16:52:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 643B53E4638
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 16:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7F53C3002F61
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 14:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9272375AAB;
	Sun, 12 Apr 2026 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uctA/RbY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEE6125A9;
	Sun, 12 Apr 2026 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776005536; cv=none; b=VLFIbUrIcqHBK+z1UHe4bYj5coZ71cjLSuIhVFTwhhZ5ZFqxVJ36zXO07L7vGGJ0CNyQxh7THZw9vaWu0e9QK9TvOv0Z50ekLxu71ljWXIARmE5PCejjtAa08KJyvIaVTHO3C7W/Ty/jBetAUQB4KtCWrHQEwzRUIpklzD3GoiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776005536; c=relaxed/simple;
	bh=9m1OPLncfn29O6rzvkC43n0KxhQdSV1Gi/0mQAATyCA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u0yeEM0IPHwoFiS7f0+Itw9mW+hHsycM5DA3GozOlpvl2VKgbPICc+GwjCQD0hD/o+1uvJKuaSVaDBpOK2d9kN4aEnQ2fsiw6H1qGRQSuMa9M36Lh0BH2m9kyyZYl17/+F8/QhX9tGQHiHQPdBXDNrEF0jFkW7Ab0lnbCGraRYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uctA/RbY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3467C19424;
	Sun, 12 Apr 2026 14:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776005536;
	bh=9m1OPLncfn29O6rzvkC43n0KxhQdSV1Gi/0mQAATyCA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uctA/RbY5QPDddBTqYEBenaPzrCCVEDEzPU2fxZVji9bGIWtV7VzWBDAaKXn07TzQ
	 nER9SjRjgTfsmh1mXpDLrvvHnQUhGB4Ajr56Ihf94az3LKpud8EAT8wa7f+HJjB9xS
	 deN8F9N4HwiFC//nMeMh3E9e4sb/ZmzmMAInpyq7LFJE8M/4LyKkI1XJwHUAgBSG7d
	 deOH/Y+34rOvM6QdDXs9it4YGagNUCHOBl5IyQR9Tht5JSAyX/uhSITqBhQE4Mw4/Q
	 YUq75PifVlbPmx0dcIX2Lx9TPJ+HZwteG93pE/2OEi2UM6PHARUbcn78Mmj/Y5lJgo
	 AOQCf/Nzjd6OQ==
Date: Sun, 12 Apr 2026 07:52:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Allen Hubbe <allen.hubbe@amd.com>
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>, jgg@ziepe.ca,
 leon@kernel.org, brett.creeley@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] net: ionic: Add PHC state page for user space
 access
Message-ID: <20260412075214.3e87ace0@kernel.org>
In-Reply-To: <69c189b7-9896-41cf-b28f-5ed4c7b80d6a@amd.com>
References: <20260401102501.3395305-1-abhijit.gangurde@amd.com>
	<20260401102501.3395305-3-abhijit.gangurde@amd.com>
	<20260401170600.312a23d1@kernel.org>
	<52cee89f-50e2-4569-a622-b03e711ab26b@amd.com>
	<20260410134311.785683cd@kernel.org>
	<69c189b7-9896-41cf-b28f-5ed4c7b80d6a@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19257-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 643B53E4638
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 19:44:18 -0400 Allen Hubbe wrote:
> On 4/10/2026 4:43 PM, Jakub Kicinski wrote:
> > On Fri, 10 Apr 2026 09:10:09 -0400 Allen Hubbe wrote:  
> >> The simple answer is just following the same approach as an existing
> >> implementation.  See struct mlx5_ib_clock_info and
> >> mlx5_update_clock_info_page().
> >>
> >> Making this common might risk presuming that other implementations will
> >> be a similar design.  Compare these to the sfc driver.  The clock is
> >> quite different from ionic and mlx5, not using timecounter, because
> >> instead of a free-running cycle counter the hardware itself provides an
> >> adjustable clock for timestamping.  
> > 
> > So your augment is basically that drivers which don't use sw timecounter
> > exist so we shouldn't bother creating common definitions for drivers
> > that do? Why do we have common implementation of timecounter in the
> > kernel at all then?
> > 
> > These are rhetorical questions.  
> 
> There is no suggestion to get rid of timecounter in the kernel.
> 
> Maybe I've been overthinking this and misunderstood your first reply. 
> Did you mean, just, why not move this to ib_user_verbs.h, struct 
> ib_uverbs_phc_state, and use it from the vendor driver?

I think so, just drop the ionic from the names and pop it into a header
that won't be awkward to reuse by other vendors.

