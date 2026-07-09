Return-Path: <linux-rdma+bounces-22958-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5RZYJOhyT2rbgwIAu9opvQ
	(envelope-from <linux-rdma+bounces-22958-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 12:07:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECE072F604
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 12:07:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=F3SlPWTW;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=P0+UTFwj;
	dmarc=pass (policy=none) header.from=linutronix.de;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22958-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22958-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD3B730F4C9E
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 10:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0777404BDE;
	Thu,  9 Jul 2026 09:59:25 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D6638C40C;
	Thu,  9 Jul 2026 09:59:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591165; cv=none; b=n0J6JBmE5XZ2ZJgyEoO/aRkGGO7QROkz1FPitaRVifaJXCjY2i0sP4Pe5L4IUuHsBWh9haWkwvpp3eCP8cdjjqL2gcir17JFmtWiOG49MwkqQiCMNZk99ROjvwPo5Cxrv9MvC+kO3zZy1iZ+7zKXDz8LJaW21QJMnuXH3V4ACno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591165; c=relaxed/simple;
	bh=Go/Ow9NdN4PxV6mme3Xg9lA9cu5K+Q3RBgUKPoj+SIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gS96vV8MMX0FZh8PQj5R2sZnRpKrsT4rZ4PHYzfVDbsBGWUUJzI3gnUYxRa9ZpXNKS2q7aCtS3Jdge6GDHP1cl3gti79pbxB/wqqvT500caO9LMMvExEry+yDrAiLZBZ7u88XyYWuWmZlAk7/Inl6+79XS+Fv2K4LaOUv7YG1ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F3SlPWTW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P0+UTFwj; arc=none smtp.client-ip=193.142.43.55
Date: Thu, 9 Jul 2026 11:59:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783591163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ywjx3VH5KvFJhxza1vG/IcMhtQddFPg3UYMEOPLrG3U=;
	b=F3SlPWTW5AkbYZPzElQen87HvE9BoRyfVJBGP9gyEZP+abTGTo2HkSTPLqIJDc/HPuY5AH
	11cbIzAOlr5kBLeLtkbiifmF6zd0OaGj+N40Yclph83rcs1IKDK3ZaqOwFYGNRMpGY/7eq
	tBRd1DMo6+wlucTl5DKhCh/L2qlOqHwZxwsLXY+mpAiYqq3uB+8zXRGDfFBy+XgMMo43bI
	k4gEIyhh0p+c5lbYeHlKJAvJHTqYlIeYW1XxStOcqb1/DbYYsdy9F6r9VVBj1gts2mlNnv
	K6ItXjNzRM7QkrzCRNYDsfPVcv+KWWfC0h6LG69w8ilXwz9VAQuL3piy6VW/ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783591163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ywjx3VH5KvFJhxza1vG/IcMhtQddFPg3UYMEOPLrG3U=;
	b=P0+UTFwjC2haWr3Et2irrK7UzdcwQadTGFP3nu3I5wFUXeggsXNuJ8kHgbeUDGO5O1++sl
	Lc/w8P4M2e4PMvAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Petr Pavlu <petr.pavlu@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH rdma-rc 0/3] RDMA: Prevent RCU callbacks from outliving
 modules
Message-ID: <20260709095921.5g994Mie@linutronix.de>
References: <20260709-unload-rcu-v1-0-fccd27211e5a@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260709-unload-rcu-v1-0-fccd27211e5a@nvidia.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:petr.pavlu@suse.com,m:paulmck@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[bigeasy@linutronix.de,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22958-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linutronix.de:from_mime,linutronix.de:email,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2ECE072F604

On 2026-07-09 12:06:46 [+0300], Leon Romanovsky wrote:
> ib_core, mlx5_ib, and ib_ipoib use call_rcu() with callbacks implemented by
> their modules. Stopping callback producers does not drain callbacks already
> queued. If module unload completes first, RCU can later invoke code that has
> been unloaded. synchronize_rcu() and SRCU waits do not wait for queued
> callbacks.
> 
> IPoIB reclamation completions are signaled from inside the callbacks, so
> they can wake teardown before a callback returns. Initialization unwind
> also needs protection because registration can attach existing devices and
> undo their setup on failure.
> 
> Wait for queued callbacks after all producers have stopped.
> 
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Closes: https://lore.kernel.org/linux-rdma/20260708092316.Qb39F_B0@linutronix.de/
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thank you. This makes sense. drivers/infiniband/hw/hfi1 might need the
same.

However, we do have a little conversation thinking about moving
rcu_barrier() into the module core code but nothing has been decided so
far. I'm trying to figure out how many might be affected by this.

Sebastian

