Return-Path: <linux-rdma+bounces-22898-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r3vcDspOTmocKgIAu9opvQ
	(envelope-from <linux-rdma+bounces-22898-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 15:21:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8284726BF0
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 15:21:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=UTbjmiSD;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=7mT9xM5G;
	dmarc=pass (policy=none) header.from=linutronix.de;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22898-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22898-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 46A9E3004DF7
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2026 13:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E730314D37;
	Wed,  8 Jul 2026 13:21:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A90B3101BC
	for <linux-rdma@vger.kernel.org>; Wed,  8 Jul 2026 13:21:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783516869; cv=none; b=FTceMtr0AjS6KC8jgpt/eEnO+AYB423p9r1HRCpLIGh1cWVEpDgZ5FAfy7r5r4WqU/DvVOeqFMQlfwI+xQd0veHsyf0xKynl5XN0I8HByVfahQfv3CQ3etNyu2/GQVEktOZPGtLe65M6XlC73ukW2JaOjYToO9PkwJObRHejXgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783516869; c=relaxed/simple;
	bh=kQ3Ff64wTTv0Oaz/zP+Flds9BRxcZ4dVXB+cZWF4Q7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDVYS/rHTMcO1m9why36GDaGx/AhrzYZEiomlMhFrGFf3zQ/E9mC3P9/+hZTQT/8NzshEyqQnOf3OtaU5U+4o/F8pHS3IXJ8dYjUyhKZth/HJ94/NiOwWN4koaRoXGdt5BQbzGz+AdUvrHY6S4duXyHbkwSe4FKruflSuajoPz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UTbjmiSD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7mT9xM5G; arc=none smtp.client-ip=193.142.43.55
Date: Wed, 8 Jul 2026 15:21:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783516866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GMKx3JLi5tOjocRQCFFKP0gP/SbBr3DhsdXQkd4uNiU=;
	b=UTbjmiSD4eYfuyvzattQeOg947zXwp6iyyNgoUwoo8nmoYaG35Zj1PVdn5LdJX9Uc1hCE/
	qGvjjQ48XjtpAwu1S9fX4sBvuA7QyanIkABr0Xg6SYuGCWoXZDpwepokprt9eA41gkDliY
	BqSxy5Kw57ZcGvpzYIZtrQT2G+V5O2E3TtVraZS9Ktktudh78X4w9WaVX0LFtwUtl4YrGN
	xReDIHrbWsTXh7Oze6HUNqBBoBb/PqwF3SSu2BS+oJYa/2PcVHFvM7KdgHYlklTTrZJkB/
	PWFM25yxT/6wN1yqCDHXwmXBV2XtXA1N6yGuQun9M6C0aqjfwlyXkd2dtl1+Kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783516866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GMKx3JLi5tOjocRQCFFKP0gP/SbBr3DhsdXQkd4uNiU=;
	b=7mT9xM5GrTGrYj+bchCi5xcV52vpIdpuDrPvf84ObYXsnIvOyeDgxWj/S0COhAwbaDALbj
	bZmylkJLqUhSchAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-rdma@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [Q] RCU usage in infiniband
Message-ID: <20260708132105.5c0kDr8S@linutronix.de>
References: <20260708092316.Qb39F_B0@linutronix.de>
 <20260708131727.GB674038@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260708131727.GB674038@nvidia.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22898-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[bigeasy@linutronix.de,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:linux-rdma@vger.kernel.org,m:leonro@nvidia.com,m:petr.pavlu@suse.com,m:paulmck@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C8284726BF0

On 2026-07-08 10:17:27 [-0300], Jason Gunthorpe wrote:
> On Wed, Jul 08, 2026 at 11:23:16AM +0200, Sebastian Andrzej Siewior wrote:
> > Hi,
> > 
> > I've been randomly starting at infiniband code and noticed it uses
> > call_rcu() with a callback from its module. 
> > 
> > | drivers/infiniband/hw/mlx5/devx.c:         call_rcu(&event_sub->rcu, devx_free_subscription);
> > | drivers/infiniband/ulp/ipoib/ipoib_main.c: call_rcu(&neigh->rcu, ipoib_neigh_reclaim);
> > 
> > I don't see synchronize_rcu() and rcu_barrier() there so I've been
> > asking myself what ensures that the callback completes before module is
> > gone (via rmmod)? I would expect a rcu_barrier() in
> > ipoib_cleanup_module() for instance.
> > 
> > Is the unload path so "late" that the callbacks run before the module is
> > unmapped or is there something between the APIs that ensures this?
> 
> It wouldn't hurt to have a more explicit unload synchronize call, but
> there are already some existing ones on the path to unload a module
> that would cover anyhow

Where? Within the module core or somewhere within infiniband?

> Jason

Sebastian

