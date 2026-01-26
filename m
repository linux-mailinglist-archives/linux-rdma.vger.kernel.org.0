Return-Path: <linux-rdma+bounces-16037-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGnrClLUd2mFlwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16037-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 21:53:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D298D55D
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 21:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21DB430378AC
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 20:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3624F2D8777;
	Mon, 26 Jan 2026 20:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Gnbh9Loe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B91283FC5;
	Mon, 26 Jan 2026 20:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769460650; cv=none; b=FSTnL0p0IqU4WZ1VD7ciolA1SJh7xgjWQawKMbFxy14euw2PHbbPK59aN66/eEyqBqowMwdrB52cZm9uTrC6oRh5jK2T8GPpHMupV7EzU0Fj1dYe+FoVqVrRdTHIwGpUSOs0ksIUX5WRj3lRC2x4c93MSWvQuRVlSv138/5G5lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769460650; c=relaxed/simple;
	bh=yndic95Dd8m5l7C1UqbBVJQY3dB2qyl3JPw2oSTE5TQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Y7vgKw8a2nXORWlUEQDEWA+lELdWwbe5Hh3DccTgzfnu6+nQH6o0Mwk3YymL135lgN4EmRXsm+ScdrDKote5KhnlvEgPZGw91sycHLM/7D4Fqtzr2EQLINc3lIiByNgUf0yYO1CsioJAOJo9PCP3dH4IeBxJdVlieJrvRkBxq10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Gnbh9Loe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC155C116C6;
	Mon, 26 Jan 2026 20:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769460649;
	bh=yndic95Dd8m5l7C1UqbBVJQY3dB2qyl3JPw2oSTE5TQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gnbh9LoeYg4uZkvQPBCJHv7TazOmO+eqozhbasI0b8pDuDPJ/LE4GearjPOnG04NB
	 /t1tDK4uOP4xN4ZsPWegJH7KYRjDifFFGDt4laaZ+PpC0Uf05a9w2tV709Z6OH1Ogt
	 GvJ4OwYOaLmX6a2pJF4xDjbXynMUAml/PDzkSr5U=
Date: Mon, 26 Jan 2026 12:50:48 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Boris Brezillon
 <boris.brezillon@collabora.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, Leon
 Romanovsky <leon@kernel.org>, Steven Price <steven.price@arm.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v2 7/7] netclassid: use thread_group_leader(p) in
 update_classid_task()
Message-Id: <20260126125048.323a281527fb2554c96f40bf@linux-foundation.org>
In-Reply-To: <aXY_4NSP094-Cf-2@redhat.com>
References: <aXY_h8i78n6yD9JY@redhat.com>
	<aXY_4NSP094-Cf-2@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16037-lists,linux-rdma=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:mid,linux-foundation.org:dkim]
X-Rspamd-Queue-Id: 74D298D55D
X-Rspamd-Action: no action

On Sun, 25 Jan 2026 17:08:00 +0100 Oleg Nesterov <oleg@redhat.com> wrote:

> Cleanup and preparation to simplify the next changes.
> 

"next changes".  This is the final patch?

> --- a/net/core/netclassid_cgroup.c
> +++ b/net/core/netclassid_cgroup.c
> @@ -93,7 +93,7 @@ static void update_classid_task(struct task_struct *p, u32 classid)
>  	/* Only update the leader task, when many threads in this task,
>  	 * so it can avoid the useless traversal.
>  	 */
> -	if (p != p->group_leader)
> +	if (!thread_group_leader(p))
>  		return;
>  
>  	do {
> -- 
> 2.52.0

