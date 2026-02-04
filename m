Return-Path: <linux-rdma+bounces-16497-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFwdO3a2gmnwYgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16497-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 04:01:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A6486E118E
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 04:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90EF830B3B21
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 03:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C812DEA7A;
	Wed,  4 Feb 2026 03:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijxGHV7W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D6D2D6E70;
	Wed,  4 Feb 2026 03:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770174068; cv=none; b=PGXWaJKUX5fq68q06YH39tcaLCi3MPd0MPDYKw1s7h5i95V77ysTaYmVrw4dS4HWo753Tk3O+PWxA+Sn1/XWoKl4FyEfc4hhxbySm9+qgk8DdbqEyQ83Qhh7t+MAqvZtmQccg5TIYvsHbcmGTP2XxBjBPHg1Xbl1wOReDWudDmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770174068; c=relaxed/simple;
	bh=6XAZmg56BsoaiZTScJCBb1Byh+9xOFtrJFKqRLcjVWY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=axcF1SsFwdtWLM32RkbItL5SkhktEjSm9LV/fEOUgoLnHc8hKtw2tMFjoiuo1Ba0qmyChPqmWxjOo65gEb9wC1HN/ltpenzwZ5UGc2Nu7jd/t4riQuoLT7QEUDidp4cTVYxSWgNZ2Iiv3tskPSrJslw26vxdCcGQoqlzCTJ7+D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijxGHV7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4251C116D0;
	Wed,  4 Feb 2026 03:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770174067;
	bh=6XAZmg56BsoaiZTScJCBb1Byh+9xOFtrJFKqRLcjVWY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ijxGHV7WPzw2Jts6F+OtujuBc6tuo7S7NEUeR44LX7nujRTaVgqFjirA4GdyqP364
	 3VvBnLUP4c5eEgZGzjJ6MxlAZQkxCwJ9Z6fiBvfRLivvO/HAZJeBnQQhHqnJDBSzA6
	 xJ1JehE4cI6WmhcwRnu4ZkMtC7hoYZjx1r9D/ap+k72r0BCNUvH2ZmyV+Y/9MDXKjI
	 E1wAjAH7z34FPumg6A19r63+nrgxxmWM3UIjxkvDzDvxQd2TsSAMXMoAppsHFh+JQB
	 OWV0B+kspI24L0114h+toZlTINSZiz6jnn4TEonZuhqa1LA4QWcDEb3ZMRw3EuU4eX
	 hk4oSaMTof6Lw==
Date: Tue, 3 Feb 2026 19:01:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Donald Hunter
 <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, Gal Pressman
 <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Carolina Jubran
 <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Jiri Pirko
 <jiri@nvidia.com>, Randy Dunlap <rdunlap@infradead.org>, Simon Horman
 <horms@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH net-next V7 01/14] documentation: networking: add shared
 devlink documentation
Message-ID: <20260203190105.2cc28e71@kernel.org>
In-Reply-To: <u7uicnxkcirhacpzjimss2pqsuhbngg4ticqrz45iqchkk2ha2@t3eem6w6hhur>
References: <20260128112544.1661250-1-tariqt@nvidia.com>
	<20260128112544.1661250-2-tariqt@nvidia.com>
	<20260202194023.412bb454@kernel.org>
	<u7uicnxkcirhacpzjimss2pqsuhbngg4ticqrz45iqchkk2ha2@t3eem6w6hhur>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16497-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,kernel.org,vger.kernel.org,infradead.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A6486E118E
X-Rspamd-Action: no action

On Tue, 3 Feb 2026 10:18:22 +0100 Jiri Pirko wrote:
> Tue, Feb 03, 2026 at 04:40:23AM +0100, kuba@kernel.org wrote:
> >There needs to be a note here clearly stating the the use of "shared
> >devlink instace" is a hack for legacy drivers, and new drivers should
> >have a single devlink instance for the entire device. The fact that
> >single instance is always preferred, and *more correct* must be made
> >very clear to the reader. Ideally the single instance multiple function
> >implementation would leverage the infra added here for collecting the
> >functions, however.  
> 
> How exactly you can have a single devlink instance for multiple PFs of a
> same device? I don't really understand how that could work, considering
> dynamic binds/unbinds of the PFs within single host and/or multiple VMs
> passing PFs to.

The same way you currently gather up the devlink instances to create
the shared instance.

> >> +The implementation uses:
> >> +
> >> +* **Faux device**: Virtual device backing the shared devlink instance  
> >
> >"backing"? It isn't backing anything, its just another hack because we
> >made the mistake of tying devlink instances to $bus/$device as an id.
> >Now we need a fake device to have an identifier.  
> 
> Okay. I originally wanted to use an id, similar to what we have in
> the dpll. However I was forced by community to tie the instance to
> bus/device. It is how it is, any idea how to relax this bond?

Interesting! I was curious to research how we ended up here, found this:
https://lore.kernel.org/netdev/20160225225803.GA2191@nanopsycho.orion/
My reading is that Hannes was arguing against the _NAME attribute but
both _NAME and _INDEX were deleted? I think there's nothing wrong with
an index.

FWIW using devlink day to day, the bus/device is not at all useful as
an identifier. Most of code touching devlink at Meta either matches
on devlink dev info or assumes there's one instance on the system.

> >> +Similarly to other nested devlink instance relationships, devlink lock of
> >> +the shared instance should be always taken after the devlink lock of PF.  
> >
> >of an instance, not a PF  
> 
> lock of PF devlink instance. I think that is what the text says, no?

Sorry, I was trying to flag that using PF is not necessary great cause
we may support this on other functions in the future.

