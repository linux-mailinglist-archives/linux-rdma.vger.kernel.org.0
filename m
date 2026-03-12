Return-Path: <linux-rdma+bounces-18116-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEBoH8HQsmnrPwAAu9opvQ
	(envelope-from <linux-rdma+bounces-18116-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 15:42:09 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6DB2738BB
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 15:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39D1E30CF209
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 14:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF272D97B7;
	Thu, 12 Mar 2026 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOnWULja"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C519328243;
	Thu, 12 Mar 2026 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773326203; cv=none; b=KbrEYSWK28+//rOJF9NXx/8qlEt3e3v/009ZZceUTrBSOFme2ku6FelFPYDjbsAAhv+QD2kkdZmYFkaDRB6uxw8qVcyfOodsuMcVxDpn/aYbICF86iZNqZz2RdKAhIGaf1fzdr2UKV7XYV1NJn1ikNBYO8CMPfxNZxvMkeof6BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773326203; c=relaxed/simple;
	bh=uIol7kReUwc484w6eaVeHC9JSYYQ/xkuA7eqjzZdjWY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDPawfswkXfikqxhzcYO2LxWi1DpWmMp1ztChR6+SWmP5/9KXpp/nhs/cPA/nzB000PaWAEwrLT6kEvf7oXVVL9cRIBafGU8klmwKS2m9fjl4/Nb76/W9JO8UtLGji3MV1Q6o8lS5WEIVV9HCXuD58vA6smkNVsgTxD3xhXvI0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOnWULja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAC3C4CEF7;
	Thu, 12 Mar 2026 14:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773326202;
	bh=uIol7kReUwc484w6eaVeHC9JSYYQ/xkuA7eqjzZdjWY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fOnWULjaWfSeAL+ujb69MF5efDFV+BdDdjL+KJ6LPn1/sq6yWSyEvG19ajrOKCXTB
	 B9C22iW21TAf4Kfv+kkOoWZUbUncIdI6cHV4KkNu1MbG/FKsk0kXSLq4E20/l5bsy8
	 ltDEl8Zzvs1GWdKYysz6bIX0RXPX4cyvhFPd6xDeB8sCYpyYIt28Ml0ODdbKkxaM6I
	 fmm3xAfvl4FBFjGgoDqXGq4Hp+FOCn0Kq4CeL5iE3cOl3VR5towpDhpuV6pKZpfS6k
	 AX+qozqXUO1sXP2+3opJNOITzdgH1ApO40Xl07WPh9VEzDpIFVqRdWJvKssD5p1e6a
	 baA2jFgDxmXmg==
Date: Thu, 12 Mar 2026 07:36:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Or Har-Toov <ohartoov@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Mark
 Bloch <mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>, Shay Drory <shayd@nvidia.com>, Jiri Pirko
 <jiri@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net-next V3 00/10] devlink: add per-port resource
 support
Message-ID: <20260312073641.027d86e7@kernel.org>
In-Reply-To: <fw6blzybx7hmvxvqoiy7civmzbf4yuhn2xzdna4apypkuwvck7@xh7iwjt27vi6>
References: <np44uzfn6jea56uht4yq4te5clapgj7pk6ygyvkl22wxumwnvt@nrpvzjqzxenq>
	<20260305063729.7e40775d@kernel.org>
	<ni23r4jiwgc6zjjsubtl4ujjgxzwpxrylumofdwxgozfnieynm@zirlbneaz6p2>
	<20260306120301.0ebe1ab2@kernel.org>
	<74dcd7c5-8a2b-49a7-a23c-174d17a61955@nvidia.com>
	<20260309133341.7e08b35d@kernel.org>
	<5de5103e-e2e4-4b72-9c3c-22847728fbb8@nvidia.com>
	<20260311145126.7dcca532@kernel.org>
	<go5wr5qa7wxe7i4kkcbmecomshpkesr26alq4qmlbpjr72hxgt@mpwq6eufylpn>
	<20260312071916.6b759c3f@kernel.org>
	<fw6blzybx7hmvxvqoiy7civmzbf4yuhn2xzdna4apypkuwvck7@xh7iwjt27vi6>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18116-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,kernel.org,vger.kernel.org];
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
X-Rspamd-Queue-Id: 3E6DB2738BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026 15:29:53 +0100 Jiri Pirko wrote:
> >> I don't see the benefit of exposing the scope to the user to be honest.
> >> I mean, dump would show all, dump with "dev" handle would be used as a
> >> selector to dump only things related to "dev". What is the use case of
> >> this "scope" granularity?  
> >
> >If we follow the logic that dump should show the user relevant
> >resources, no matter which sub-object they are attached to -
> >having a dev specified should only filter the objects to match
> >the dev, including resources which are on ports of that dev.
> >
> >IDK if there's a strong use case for allowing the user to set
> >scope on CLI but also - I don't see why not?  
> 
> At least some small sense of consistency with other dumps? Health
> reporter and region does not have scope and output mixture of dev-based
> and port-based objects. Why to confuse user?

That's a judgment call - either we confuse users but two commands
behaving differently, or we confuse users with devlink $thing not
dumping all instances of the $thing.

Especially that drivers often retroactively move $things from device
scope to port scope :(

