Return-Path: <linux-rdma+bounces-16554-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFRsMVv6g2nwwQMAu9opvQ
	(envelope-from <linux-rdma+bounces-16554-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 03:03:07 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81842EDD3F
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 03:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29F6A3015D1A
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 02:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED2923B61B;
	Thu,  5 Feb 2026 02:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlhrAdo5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F32A29CEB;
	Thu,  5 Feb 2026 02:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770256978; cv=none; b=YipBEWRGh1DXhAMXTYfzKp8PXgY9mVAhQKNMTnXPkioTjaiLuf2F2jYOtll96qhfmngGmJju4FRqv9Xf/FDi/ZnCX5ZOJGD0yPA+4qmn8FsABch0ZmQteODnd1sAQ3nNUOI7H157exSUkVlfPL0F0TxrsOrvmLkFFj7D9/mzVdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770256978; c=relaxed/simple;
	bh=nHi2UCGiCbJ0UnCuBebGdrB9aUOyKoFBhFgFqNuLD50=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VboPA/T3BQKzR1srwmaFgpqEqnSx1/3gLxaF0700P+XsPQs+UU9GKr4ixRIUsdyNWO5MjipAv99RNdl9tguSFrdLWCHA+31Od3pqgNyFVGFRwMuTZdQPUx93dR4hK+6+2cuxKWyocUTuKSCXIUN5/RT+d5I2MzmBE0TQJBB/Ke4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlhrAdo5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED13C4CEF7;
	Thu,  5 Feb 2026 02:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770256978;
	bh=nHi2UCGiCbJ0UnCuBebGdrB9aUOyKoFBhFgFqNuLD50=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AlhrAdo5TIKMad6/U4CLXKjjKTzvKlYie2xwNvIbUEGMnniorxSiPH8e2PO+Att1S
	 j3hdtqxYgIsZUtIosEhkpjyVTl80hMP038625drLIt5tajRVjnwM2OpRlkLw1sl1EK
	 91i87nRcGsbxkisfsKY791B/7NP6TPxSqZH1LxPPTsC+9tTRtUEavXdvD0UhxnJH5H
	 X+5RzqrnxW3PYZEcWT2KI4XhBlEhr/znQG9x76YUvGcEo6UTaTKzkGQ3qWXiO3B6O9
	 DQ6ODbhuKVYxyOGmLytrAIK+IsucwMmKStLNtsjEZCMQyCVGF6ZI+udB/MJFtW1cs2
	 c9aTAT+tRnpBw==
Date: Wed, 4 Feb 2026 18:02:56 -0800
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
Message-ID: <20260204180256.1476f537@kernel.org>
In-Reply-To: <3edheaanzxgutuyryorfzlfjvizlorpj4y3ard5js7mp44hfii@4a36de6wazfd>
References: <20260128112544.1661250-1-tariqt@nvidia.com>
	<20260128112544.1661250-2-tariqt@nvidia.com>
	<20260202194023.412bb454@kernel.org>
	<u7uicnxkcirhacpzjimss2pqsuhbngg4ticqrz45iqchkk2ha2@t3eem6w6hhur>
	<20260203190105.2cc28e71@kernel.org>
	<3edheaanzxgutuyryorfzlfjvizlorpj4y3ard5js7mp44hfii@4a36de6wazfd>
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
	TAGGED_FROM(0.00)[bounces-16554-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 81842EDD3F
X-Rspamd-Action: no action

On Wed, 4 Feb 2026 08:12:00 +0100 Jiri Pirko wrote:
> Wed, Feb 04, 2026 at 04:01:05AM +0100, kuba@kernel.org wrote:
> >On Tue, 3 Feb 2026 10:18:22 +0100 Jiri Pirko wrote:  
> >> How exactly you can have a single devlink instance for multiple PFs of a
> >> same device? I don't really understand how that could work, considering
> >> dynamic binds/unbinds of the PFs within single host and/or multiple VMs
> >> passing PFs to.  
> >
> >The same way you currently gather up the devlink instances to create
> >the shared instance.  
> 
> What's the backing device / handle (busname/devname)? Best would be to
> draw a picture, as always :)

Either the bus/dev that shows up first or we go back to index.
(My main point being that the single instance is strictly better
than shared, ie. no problem exists in single instance multi func
which does not exist in multi instance + extra instance multi func.
But some problems do exist in multi instance which do not in single
like the locking)

> >> Okay. I originally wanted to use an id, similar to what we have in
> >> the dpll. However I was forced by community to tie the instance to
> >> bus/device. It is how it is, any idea how to relax this bond?  
> >
> >Interesting! I was curious to research how we ended up here, found this:
> >https://lore.kernel.org/netdev/20160225225803.GA2191@nanopsycho.orion/
> >My reading is that Hannes was arguing against the _NAME attribute but
> >both _NAME and _INDEX were deleted? I think there's nothing wrong with
> >an index.  
> 
> He argues for "stable topology indentifiers", which randomly assigned
> index is not.

Agreed, I love me a stable identifier myself! :) That does not mean 
we can't have ID _as well_ as the identifiers. Which lets us add
more stable identifiers and/or making some optional.

I think I was trying to sell you on "more stable identifiers" 
as a alternative to ALT_NAMEs for netdevs at some point ;)
Maybe I'm projecting that conversation onto what Hannes said.

> >FWIW using devlink day to day, the bus/device is not at all useful as
> >an identifier. Most of code touching devlink at Meta either matches
> >on devlink dev info or assumes there's one instance on the system.  
> 
> Okay, what's your suggestion going foreward then?

Add the ID back, make bus/dev optional, forgo the faux dev?
Would that work? Would exiting CLI become very unhappy? :S

