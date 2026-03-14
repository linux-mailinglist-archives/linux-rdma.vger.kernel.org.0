Return-Path: <linux-rdma+bounces-18163-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UN4yK2GhtWk02wAAu9opvQ
	(envelope-from <linux-rdma+bounces-18163-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Mar 2026 18:56:49 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EF528E4BC
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Mar 2026 18:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 23D663050034
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Mar 2026 17:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE2D2DEA62;
	Sat, 14 Mar 2026 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLFlyPES"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805892E11B0;
	Sat, 14 Mar 2026 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773510868; cv=none; b=O82JKMOjxEX04JaV0JBvmBmBfgRmSIacQOPuDCkbFY9torT9qk4SefbCidukiaTnJGxg1mBJl0xUMTO1Eyhus5e72KoX5hbp8ccnVIVPhLQlDh3vnAJaXTrCrl8bUii0XbDloinoxGGAsoqwCtsVq6U8BqnE7FRuMmqahy5gWGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773510868; c=relaxed/simple;
	bh=qKw3eIwgpxDMpDQ9HWLk0v6mGLeCdoZuhJ7h/0EWDyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dS4hhyzMJJcD+9Gm0GRNfuED4WU3SFFmJTUzyA3GwRzeRYPkFlXwF2MWDJv8tgyp9eigcigYyvk1oNJYww1VESIDvGi2VGddGjjnfzmQKZNM/xe45NUqriIpI0CWh5N4nIfDB9d8rAr479n0lOItANPvFwsSc79VFEoD1QrPqMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLFlyPES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5886FC116C6;
	Sat, 14 Mar 2026 17:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773510868;
	bh=qKw3eIwgpxDMpDQ9HWLk0v6mGLeCdoZuhJ7h/0EWDyQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sLFlyPESRMMPREle/UUhRuvd2TvhBQH7TnOwKEDUITamc0AzJPpI1+gSydNYsBiya
	 olBKkVVI7GIsHMOVZ6QHxk59nu+/eHulP0mucJVLsfEGjIyjz8iVmvUjGCEESTclg1
	 IrBWp83xIRM2uzU/bTpaFokizO+bD8eVtC0G0Q6XWoihzETbrUJC6JUmlDe39tSVlr
	 Ft/oe/6BG35Il3CGb5XZ/gBaEh3105bHaPVTJpUCqRkyxu29ihSswcZa8ymmhmnwnc
	 5x8EZH07zJRo19BJG+/Y2R0i3rpaOX2jqtuDTaaqr96y8Y9rht8XS/ZnMYyzaNytRM
	 W9V3fIOxOXzLA==
Date: Sat, 14 Mar 2026 10:54:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: lirongqing <lirongqing@baidu.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Paul
 E . McKenney" <paulmck@kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, <netdev@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, liyongkang <liyongkang01@baidu.com>
Subject: Re: [PATCH][net-next] net/mlx5: Expedite notifier unregistration
 during device teardown
Message-ID: <20260314105426.36ae4cba@kernel.org>
In-Reply-To: <20260312094804.2744-1-lirongqing@baidu.com>
References: <20260312094804.2744-1-lirongqing@baidu.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-18163-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 90EF528E4BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026 05:48:04 -0400 lirongqing wrote:
> During device hot-unplug, the mlx5 driver expects quickly unregister
> notification chains. The standard atomic_notifier_chain_unregister()
> calls synchronize_rcu(), which introduces significant latency and
> can become a bottleneck during mass resource cleanup.
> 
> Introduce atomic_notifier_chain_unregister_expedited() to leverage
> synchronize_rcu_expedited(), and use it significantly reducing wait
> times in the following paths:
>  - Event Queue (EQ) notifier chain
>  - Firmware event notifier chain
>  - IRQ notifier chain
> 
> This acceleration ensures faster teardown during hot-unplug events.

Some detailed example and how long the whole operation takes would be
great in the commit msg.

>  /**
> + *	atomic_notifier_chain_unregister_expedited - Remove notifier from an atomic notifier chain
> + *	@nh: Pointer to head of the atomic notifier chain
> + *	@n: Entry to remove from notifier chain
> + *
> + *	Removes a notifier from an atomic notifier chain and forcefully
> + *	accelerates the RCU grace period.
> + *
> + *	Returns zero on success or %-ENOENT on failure.

Warning: kernel/notifier.c:211 No description found for return value of 'atomic_notifier_chain_unregister_expedited'

kdoc wants you to use Return: or Returns: the colon is how it knows this
is the doc for return value not just a random mention of the word
Returns
-- 
pw-bot: cr

