Return-Path: <linux-rdma+bounces-22902-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L13fGp9XTmrMKwIAu9opvQ
	(envelope-from <linux-rdma+bounces-22902-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 15:58:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D53E8727021
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 15:58:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QD3FWQWd;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22902-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22902-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 047FB3009B2E
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2026 13:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAB739B4BF;
	Wed,  8 Jul 2026 13:58:51 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCE0380FF4
	for <linux-rdma@vger.kernel.org>; Wed,  8 Jul 2026 13:58:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519131; cv=none; b=hDlrM9OhH/+CydfRz1j7p+gx9k76I5jWAKkBEt4t7HYKD5wtHDrBJvMC9mvGE4fLOCWzt7ZKp/lF4v4cMUStVKO1x9KXhqvyb5coMo1hrrKESPTK2sAVYQOC36TuTJT/HQqTOZ0jaECKxCCfYjhU6wvzNGDYT7/rWbtekKfbcmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519131; c=relaxed/simple;
	bh=daVzIBbukoWLoBCsRNnHFcyvFTsgKx7Z+34RsPaTKUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfF+xbuQYzUROzKL0gi7PD05lHmdCy9xdgqZJl+jj3T81kOzmdHXmYx/uzqzMqDPtmoh4QXjPZNOuNVVFkq6zbGAP/PWXr43Hckqda/Juajl9MZhc7creh1x3veeUUn8T276Ag6xybCVu60k5V/PaBgA+Yv9vmPNeeMR6vNy3UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QD3FWQWd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8681F000E9;
	Wed,  8 Jul 2026 13:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783519129;
	bh=DCc7WuoFYjY2qxNpWvM9hG0Ya1pVxG11XBXwq0PONNI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=QD3FWQWdE1kec9MBslfG9SaoDSltC1cyT2ed3CQ1zQHbEXF2jFv6xlrX3yaSvlU04
	 eXB5xfOupcY9PV1SuJBN0FX8tRJHze7zV54lZYtfB+QPVY875b7tWrIA+W7YD23Uif
	 HCa6zSakfs/xZkbp7DRmyXL7zTZ92L0qMnky9OXz0A78lhmkT5jWtRTO5Io7ZRYBHs
	 4YtCO8ozzu1it51FGW/+c5zwpplrEtwgYBTVY234IKSwF1R/2VnyNaKnLBbF9J8n9n
	 jtU08feRHY0cX+TPP25e75nzr+fRgHC7o1P+lnPqnC8DaD3DZMiIh9/upehv8DKXkR
	 I9qDYz83hVtYQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4BB79CE04B1; Wed,  8 Jul 2026 06:58:49 -0700 (PDT)
Date: Wed, 8 Jul 2026 06:58:49 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: Re: [Q] RCU usage in infiniband
Message-ID: <95768d78-3316-4971-9fbf-141136a0a9bb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260708092316.Qb39F_B0@linutronix.de>
 <20260708131727.GB674038@nvidia.com>
 <20260708132105.5c0kDr8S@linutronix.de>
 <20260708132849.GC674038@nvidia.com>
 <20260708133410.VZR0-V_p@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708133410.VZR0-V_p@linutronix.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22902-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[paulmck@kernel.org,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bigeasy@linutronix.de,m:jgg@nvidia.com,m:linux-rdma@vger.kernel.org,m:leonro@nvidia.com,m:petr.pavlu@suse.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulmck@kernel.org,linux-rdma@vger.kernel.org];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[paulmck@kernel.org]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D53E8727021

On Wed, Jul 08, 2026 at 03:34:10PM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-07-08 10:28:49 [-0300], Jason Gunthorpe wrote:
> > > Where? Within the module core or somewhere within infiniband?
> > 
> > Eg the uverbs path has a srcu synchronize IIRC before allowing the FDs
> > to close which holds the module as well. But it probably isn't wise to
> > rely on this
> 
> But this is srcu. So this takes long enough so that we have a RCU grace
> period, too? But there is also RCU_LAZY which could stretch this a bit
> ;)

Just to emphasize Sebastian's point here...

If a module uses call_rcu(), there needs to either be an rcu_barrier()
or some explicit synchronization with the callbacks themselves before
module-unload time.  Any explicit synchronization must also include
a wait for existing softirq handlers to complete, so rcu_barrier()
is simpler and more maintainable.

Please note the rcu_barrier().  And that synchronize_rcu() is not a
legitimate substitute for that rcu_barrier().

Similarly, if that module uses call_srcu(), there needs to either be an
srcu_barrier() or explicit synchronization with the callbacks as mentioned
above.  Please note that neither rcu_barrier(), synchronize_rcu(),
nor synchronize_srcu() are legitimate substitutes for that srcu_barrier().

The difference is that while rcu_barrier() waits for the completion of the
callbacks queued by prior invocations of call_rcu(), synchronize_rcu()
instead waits only for prior RCU readers to complete.  So rcu_barrier()
does not care about RCU readers and synchronize_rcu() does not care
about RCU callbacks.  And the same holds for SRCU.

Also, RCU does not wait for SRCU and vice versa.

Does that help?

							Thanx, Paul

