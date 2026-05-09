Return-Path: <linux-rdma+bounces-20278-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DhaJkaF/mmBsQAAu9opvQ
	(envelope-from <linux-rdma+bounces-20278-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 09 May 2026 02:52:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B1A4FD1F9
	for <lists+linux-rdma@lfdr.de>; Sat, 09 May 2026 02:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF6133025F72
	for <lists+linux-rdma@lfdr.de>; Sat,  9 May 2026 00:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6155923BCF7;
	Sat,  9 May 2026 00:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxbmyloE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2064F22CBE6;
	Sat,  9 May 2026 00:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778287935; cv=none; b=dydOLh6etGrTl9eiVPSBF8tN9riTFUuCdhkAWJUj5gXkO+EW5kW/gCPmYE8NkF+pBuWKxFhyfYefV1KrkstBnoIs5Wl9VR6gSSeJkWhWqpBnYNdGFlLcg3MDOOZKWgQF9PHx7dRoZBkpwOgP55RW891258l5jo+JI342OZWx3Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778287935; c=relaxed/simple;
	bh=tzx7ZwgL4qb9E7LiEim00qbYgEtsXeRU7mCgbW19k6M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GjwB6afowpjeE+1vdgOiBgbig4/hkWTQkUuNMvr8EChzDinzFw2I5b3Y2iYcVGt29Qm0IID5ey0AYZ7STZf/iJNVi0CyErGJIPwfDAj6z4sPLbCnhYLNfyLAgwAYSemc5ku4tFc4u1FcTMYbQvrp65BP9Eci19ApURsbSj8hjlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxbmyloE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BC3C2BCB0;
	Sat,  9 May 2026 00:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778287935;
	bh=tzx7ZwgL4qb9E7LiEim00qbYgEtsXeRU7mCgbW19k6M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cxbmyloEO08k8n6A91Ub0EQs8QPp9FXDJCaF269871JqsS/tTFWF1ZAR1/IYmJmQJ
	 WIAcvX75OsoH9C668Vyuga0z2wnL5ebyJudy2owBLJva0WrfsHvKCQYqUMs71671Mp
	 /BcjaxY1Dy6fyLgVtvD3MdaVhxspItLv5A0IcbGmOhKd+JIHyfrKa1tJiI3uDn6TaM
	 KtABzmVKJ6QaWVGn9nBQW+1M+zEfcPXyAFcOCablaxW+1/PneBfzyop5SRANApwTS0
	 u3PubW9+JuPHP5rtT6Z1zVkFQPtfIjmj4VmNuizxrb3f/JBBSWsUv2g06+90KB9MRV
	 i4fA4+V1ZaRgA==
Date: Fri, 8 May 2026 17:52:13 -0700
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
Message-ID: <20260508175213.1952097f@kernel.org>
In-Reply-To: <af4lBIJdCuN5VKq_@FV6GYCPJ69>
References: <20260506123739.1959770-1-mbloch@nvidia.com>
	<aftaW-irGmkfA7FS@FV6GYCPJ69>
	<3f9215c4-7c84-46d9-ba74-30dabe24db09@nvidia.com>
	<afxvzOjqw-vxUAED@FV6GYCPJ69>
	<b6a9b568-dd09-4414-be57-6b9cd282a43c@nvidia.com>
	<af4lBIJdCuN5VKq_@FV6GYCPJ69>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 17B1A4FD1F9
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20278-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, 8 May 2026 20:07:44 +0200 Jiri Pirko wrote:
> >I don't think switchdev by default should mean CX4+ in general. If we get
> >there, I would expect it to be limited to the DPU/BlueField/ECPF case, where
> >the host PF probe path can depend on the ECPF reaching switchdev. Changing the
> >default for regular host NIC deployments feels like a much larger compatibility
> >change.  
> 
> We can't travel throught time, but if from CX5 onwards the default would
> be switchdev, nobody would feel broken in terms of compatibility. That
> is my point. Having "legacy" as default is simply wrong for never NIC
> generations. That is why it is called "legacy" and it should have been
> rotten through and out since CX4 times.

legacy vs switchdev only describes the eswitch configuration.
As a non-SR-IOV user I really don't want to see the extra representors
hanging around my systems, confusing all daemons. IIRC mlx5 had some
limitations around the uplink representor. Maybe that's the disconnect.
But for a real, fully featured switchdev eswitches having the
PHY and PF representors on boot, always, will not make sense.

IOW it's not a question of the generation of the card but of
the deployment type / use case.

> >For the ASIC/NV bit: maybe technically possible, but it feels like the wrong
> >layer. This is boot/deployment policy, not a persistent hardware property, and
> >storing it in NV memory would make the state persist across kernels/hosts in a
> >surprising way.  
> 
> Well, as any other nv config, it persists across kernels/hosts. Think
> about it as "unbreak-my-not-legacy-device" bit.

For most devices the switchdev mode does not change anything
substantial about the device. It's purely a kernel / driver config. 
It changes what objects and default rules kernel / driver installs. 
So I don't get why it would make sense to flash into the device
nvmem a Linux SW stack specific config.

> >I do agree the RFC probably went too far by making a generic devlink cmdline
> >configuration language. Maybe the smaller thing to discuss is only:
> >
> >devlink=[pci/...]:esw:mode:{legacy|switchdev|switchdev_inactive}
> >
> >No runtime params, no ordering between different operations, just early eswitch
> >mode for explicitly selected handles.  

Yes, let's cut this down, AI went too far :) As I said we should just
document how we envision the format growing but for now we can literally
implement just the global "esw mode".

One note on the formatting, you mentioned:

  devlink=[pci/0000:08:00.0,pci/0000:08:00.1]:param:flow_steering_mode:hmfs,[pci/0000:08:00.0,pci/0000:08:00.1]:esw:mode:switchdev

TBH when I used the square brackets I meant that the field is optional.
But I guess you used them like we use them for IPv6 addresses to
separate the : signs, makes sense.

Since AFAIU we only care about global default should we focus on
supporting:

 devlink=*:esw:mode:switchdev

meaning all devices default to switchdev?

> FWIW, I'm still against this.

One more option, tho IDK if it actually is good enough for Mark,
would be to let user space "pause" devlink probing. So that the
systemd daemon can configure the device before it populates all
the netdev stuff. Basically make the devices probe into the reload_down
state, until user space configures them. IDK how much of the time
is spent building and tearing down the legacy mode on mlx5 but
the thinking is that we'd at least stave that wasted effort.

