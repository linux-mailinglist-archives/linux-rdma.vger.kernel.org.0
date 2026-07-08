Return-Path: <linux-rdma+bounces-22874-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HVMwCN0YTmqjDAIAu9opvQ
	(envelope-from <linux-rdma+bounces-22874-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 11:31:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69561723C13
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 11:31:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=1ohVCYOD;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=lvRHYaZw;
	dmarc=pass (policy=none) header.from=linutronix.de;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22874-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22874-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3C2130D745A
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2026 09:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6092940861D;
	Wed,  8 Jul 2026 09:23:21 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEC140861B
	for <linux-rdma@vger.kernel.org>; Wed,  8 Jul 2026 09:23:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502601; cv=none; b=b3Z0zA+zG6yJhQt5tITVitYoF76kLT6PZFhnZiUAg04c0cRqxFul+nJZ936yjbtMaGgbfJ4tvRxLZToQwwSrvy4m1UNuPvk+A2P963t/YzuKy3fIXeoelRQemtYXpj4Xacadh9xahxyWeDDMd8JEnFC4BkJSMiGOmSaMrcpVDmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502601; c=relaxed/simple;
	bh=KSGO88dgyUe1y4AYUyg7jQ+i0/b7FoOrCed8a0pzrPc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qxSLhexK0jCLsZn/HgyqOJsHXvxUBoLelbEU44Oz+cQrPYjjdRsqRd3ebJBsf8uI7suKY/1kcj+jT4IniIjMobgDcdX59xwUJZioZ7g3C4otfLwPHAy4A9yHs5NiqS3K4VOIDs4qVNMqyH9+rldsS7WoNmQCHZ8YCUEipfbti/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1ohVCYOD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lvRHYaZw; arc=none smtp.client-ip=193.142.43.55
Date: Wed, 8 Jul 2026 11:23:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783502598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=g64nVw3djX+2rwvjxDO9+SIe5HIWvHXM9rmeU1r5lFM=;
	b=1ohVCYODY/DoiA6fMgRF5AjU+fp7lpT1r03rufIAPUo0RBxoYoI+sV8oCUXIi0HbuH9WcP
	W5xER+abrUCs4A4cd1JXrAGOAJwfw6rQyK3TwGDiiFVfQIogJFhqgdoeeAwXi5v3ITZP+y
	1OTbW+gMt15FXQ0+iivCi9BWew/Rq0Lb62NSfc4OVEw0oSJE8a6QQaopwndtTZ4OdEkn3d
	xnl4M6XlbwqLRX2sG/4sGzQP6CJCofXc1VSN8OkAzel8iFz8+C1a4SDTYHu+DY8LHo6YFq
	PLQoIk1edJEAy+LG2SFxfLC1b8eyzJQVNu5rbPoLUXJ0eqAnmSpIAng1Y3VwXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783502598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=g64nVw3djX+2rwvjxDO9+SIe5HIWvHXM9rmeU1r5lFM=;
	b=lvRHYaZwMxKkYIq/RzJiZkwDcN1nkFyExYWkERTPTThwv7u4LdT0Zp2OSIJ0ClkU16CyZK
	YILlXygg2wZ+YrCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rdma@vger.kernel.org
Cc: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [Q] RCU usage in infiniband
Message-ID: <20260708092316.Qb39F_B0@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:jgg@nvidia.com,m:leonro@nvidia.com,m:petr.pavlu@suse.com,m:paulmck@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[bigeasy@linutronix.de,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22874-lists,linux-rdma=lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:from_mime,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 69561723C13

Hi,

I've been randomly starting at infiniband code and noticed it uses
call_rcu() with a callback from its module. 

| drivers/infiniband/hw/mlx5/devx.c:         call_rcu(&event_sub->rcu, devx_free_subscription);
| drivers/infiniband/ulp/ipoib/ipoib_main.c: call_rcu(&neigh->rcu, ipoib_neigh_reclaim);

I don't see synchronize_rcu() and rcu_barrier() there so I've been
asking myself what ensures that the callback completes before module is
gone (via rmmod)? I would expect a rcu_barrier() in
ipoib_cleanup_module() for instance.

Is the unload path so "late" that the callbacks run before the module is
unmapped or is there something between the APIs that ensures this?

Sebastian

