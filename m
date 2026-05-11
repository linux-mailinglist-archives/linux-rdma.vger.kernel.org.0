Return-Path: <linux-rdma+bounces-20421-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEvHKjJpAmoxsgEAu9opvQ
	(envelope-from <linux-rdma+bounces-20421-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 01:41:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 509AC5175B6
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 01:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 20C11301B531
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 23:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEC436A340;
	Mon, 11 May 2026 23:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmg0L6Rj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1648356749;
	Mon, 11 May 2026 23:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778542895; cv=none; b=HVAHP+J1lX+pzsU9AQP/D3VCDEHvPB5HPgNAFIlUvFLQgZiNcMuOvIbtfEUis44oWpYNxDnrfF3ivEp/OvsUtme5r+jFyxMDToZfPklUlcJPv1+SxtxGk7T+ePUcihUneqLZPVgfx/qskK/BvR7Z/FBlel2JQjkwqTn+7VwSEt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778542895; c=relaxed/simple;
	bh=WrJh3A6nMW7Eo9Tv/TgbN3zD/5GN9ddIFq650lK9aO0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZSKaZt4nOnb/urC7nt0o7pkm/n66SIhN7CbFaHvQ2+G935O26WtCQA7RLbfYyhBuHa7ynvZ/4Q1Id8Bw89H6vLv7W3nBHT2EILHU8kSKonW7IcnIkQGYuGoKtuEWxL3f3jEx8EoSH4o5+31o+3C+jlmocZVPI10TqDEnKnPS5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmg0L6Rj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3438BC2BCB0;
	Mon, 11 May 2026 23:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778542894;
	bh=WrJh3A6nMW7Eo9Tv/TgbN3zD/5GN9ddIFq650lK9aO0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cmg0L6RjLFqv1Z55LdiBNDaX61Hjg+ltAUGAuHvGQkZy0/MwCL27EG20/UNjJDxiI
	 9fGZCzsj4s3Vlg+3nYjw4kvDs7biPNjpytqqf0PXp+lS9fSlaPFF8PFGr4oN12K9oI
	 sbpLxuxVCPBGDY6K0wSHIOgGgoxX1xZPXDEcZWCb/MKJ2vczwd615bHpYdWfvClfVi
	 L3llAxRxt3p/bGExisnnZmZthHhZLHaobLbiks1VJ80ocJXq1QD+r2fIbSqYOT+9S5
	 jL+v2zZ6CTssDd1ep5Gh8i1WnlEScfnn3Wl+KrgVY/CwzKC7NOVTBfnb8v6Ei4wN3o
	 2Zh7RUPsh13Bg==
Date: Mon, 11 May 2026 16:41:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Mark Bloch <mbloch@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Morton
 <akpm@linux-foundation.org>, "Borislav Petkov (AMD)" <bp@alien8.de>, Randy
 Dunlap <rdunlap@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Christian Brauner <brauner@kernel.org>, Petr Mladek <pmladek@suse.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Thomas Gleixner
 <tglx@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Dapeng
 Mi <dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>, Marco Elver
 <elver@google.com>, Eric Biggers <ebiggers@kernel.org>, Li RongQing
 <lirongqing@baidu.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [RFC net-next 0/4] devlink: Add boot-time defaults
Message-ID: <20260511164132.2df9c5a1@kernel.org>
In-Reply-To: <agGOeqeNwJGJ_-2A@FV6GYCPJ69>
References: <20260506123739.1959770-1-mbloch@nvidia.com>
	<aftaW-irGmkfA7FS@FV6GYCPJ69>
	<3f9215c4-7c84-46d9-ba74-30dabe24db09@nvidia.com>
	<afxvzOjqw-vxUAED@FV6GYCPJ69>
	<b6a9b568-dd09-4414-be57-6b9cd282a43c@nvidia.com>
	<af4lBIJdCuN5VKq_@FV6GYCPJ69>
	<20260508175213.1952097f@kernel.org>
	<af7Y4AYv-XDCbK_8@FV6GYCPJ69>
	<20260510093732.6ba47e54@kernel.org>
	<agGOeqeNwJGJ_-2A@FV6GYCPJ69>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 509AC5175B6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20421-lists,linux-rdma=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[31];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, 11 May 2026 10:42:56 +0200 Jiri Pirko wrote:
> Sun, May 10, 2026 at 06:37:32PM +0200, kuba@kernel.org wrote:
> >On Sat, 9 May 2026 09:01:23 +0200 Jiri Pirko wrote:  
> >> Sat, May 09, 2026 at 02:52:13AM +0200, kuba@kernel.org wrote:  
> >> As "a non-SR-IOV user", what extra representors you talk about? When you
> >> have pfs only, you don't have anything extra. Just 1 netdev per-pf, one
> >> devlink port per-pf. What's extra about it? When you don't have VFs/SFs.
> >> Everyhing is the same:  
> >
> >Some devices have separate uplink ports and PF representors.
> >As I said, what you're proposing isn't going to work for all drivers.  
> 
> Well, the point is, mlx5 appears to the the one needing this, not other
> drivers. What I'm trying to point at, mlx5 should not need this.
> It makes things compicated, adding a ugly knob for no good reason.
> Legacy/switchdev mode, in both, the non-sriov/eswitch user should not
> see different behaviour. The mode is an eswitch attribute.
> 
>    devlink dev eswitch set - sets devlink device eswitch attributes
>        mode { legacy | switchdev }
>               Set eswitch mode
> 
>               legacy - Legacy SRIOV
> 
>               switchdev - SRIOV switchdev offloads
> 
> 
> Briefly looking over other drivers, looks like ice, bnxt, octeon, sfc,
> there is no new entity created in case of switching to switchdev mode.
> The only driver that creates separate pf entities seems to be nfp,
> but the mode seems to be determined by the app being run (loaded
> firmware).
> 
> Am I missing something?

Hm. Okay, I wasn't aware that mlx5 was the only driver that did
heavy-duty reinit for switching modes.

> >> I look at it from the perspective that from some CX generation,
> >> switchdev mode should be default. So that is a device-based decision.
> >> I believe as such it can optionally be permanenty configured (nv config)
> >> on older device. Why not?  
> >
> >Feels a bit arbitrary and won't cover all cases. The question should be  
> 
> What cases it does not cover? I don't follow.

Other FW and HW versions. People are still using EOL devices (CX4/CX5),
IIUC the nvmem config path would require FW upgrade.

> >why you are nacking a more reasonable solution. Keeping Linux config in
> >Linux params.  
> 
> What's reasonable about adding basically a module option (kernel cmdline
> is pretty much the same) for no reason?

The initial patch as posted added this to a mlx5-specific module param.
If we need a module param IMO generic one is much better.
Doesn't matter if other drivers take no time to reinit into switchdev
mode, having to switch mlx5 with a module param and all the rest in
runtime is not the best user experience?

