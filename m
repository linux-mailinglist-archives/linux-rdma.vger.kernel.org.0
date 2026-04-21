Return-Path: <linux-rdma+bounces-19456-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDZOHQWW52mp+AEAu9opvQ
	(envelope-from <linux-rdma+bounces-19456-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 17:21:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7312543CAF8
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 17:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1E310300EB5C
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 15:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E7F3D75C5;
	Tue, 21 Apr 2026 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0hw8asq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33651288C08;
	Tue, 21 Apr 2026 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776784193; cv=none; b=ijsqgYN8fqKovgm9xw9IKwRzJW3y4b7lPqMnBB1FuILICxgXULrAm6xytyFDxx9OMtR20/5NP816EGfuBREI2sY6ymeEIrzVl2/JjTy41cgWbVHd1y03em6BHqXUv9RH/X7PctSMIPefe8h1JNDrRAOkdLQvf8kmYDArk4bezJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776784193; c=relaxed/simple;
	bh=g6Heiu8xEGCQd+0wqaphxrKWOZZfiwM84rnJaHKjKmE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lGzpv78utztPhbjb6xnKogbmy30KZkKKvp2Uu/fmbfVuNipJFXAJ1uHcmadd23RNp6A5Gw2+w5eDL7N5mEYX+RffXExoaB/Mn0i3T83Wxcq8fT6KBFN1ib0WDWORTsuA5DkmY0qS+71qNpxHYD2E76XFjX1CfiiNLiCk7PCocU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0hw8asq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28AFEC2BCB0;
	Tue, 21 Apr 2026 15:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776784193;
	bh=g6Heiu8xEGCQd+0wqaphxrKWOZZfiwM84rnJaHKjKmE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o0hw8asqH/xJSN58p5KF/M4eqL64X8U3RN6BA9d2cTSoCfu3da35vXXZABvInJES1
	 MxrJnv/Jf6+34HWsbFyz2dYj4d7pzDWhM02060806XTM3u/lsTsAuWGqqNcvTPPic1
	 L4pfrwLS3oEjEDui6Rj3EflghIudd4logt2ctGGSXw9BgHb4azEWDCrtw/JGJeHSwH
	 5emhdg/Sl8J7Tj6rQpwIWVC8dPCw7WjEpDCf6iLouONu6+57Tz5AtrxdGmZlPPRnpb
	 jCOFz+LJ1yS7sI/vVZpVk4Wd4NEfhiGYMStLscbn1P0joIR8S9gbWOr4a4esg24q9a
	 5hFUFwJy+CZFw==
Date: Tue, 21 Apr 2026 08:09:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: Boris Pismenny <borisp@nvidia.com>, "willemdebruijn.kernel@gmail.com"
 <willemdebruijn.kernel@gmail.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "daniel.zahka@gmail.com" <daniel.zahka@gmail.com>,
 "davem@davemloft.net" <davem@davemloft.net>, "leon@kernel.org"
 <leon@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "edumazet@google.com"
 <edumazet@google.com>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Raed Salem <raeds@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 "kees@kernel.org" <kees@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net 1/2] net/mlx5e: psp: Fix invalid access on PSP dev
 registration fail
Message-ID: <20260421080951.570e6e49@kernel.org>
In-Reply-To: <3ca1bee450608d37cd0f9199ebc44c52c084cb08.camel@nvidia.com>
References: <20260417050201.192070-2-tariqt@nvidia.com>
	<20260418190848.204170-1-kuba@kernel.org>
	<d7e2d46769e120a16ce12d345c51a47349733828.camel@nvidia.com>
	<20260420100917.1e4be22a@kernel.org>
	<f327ce67e69c27ed971f4ed38f46381cd2f97ec7.camel@nvidia.com>
	<20260421072609.4b15e7b9@kernel.org>
	<3ca1bee450608d37cd0f9199ebc44c52c084cb08.camel@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,lunn.ch,davemloft.net,kernel.org,vger.kernel.org,google.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-19456-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7312543CAF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 21 Apr 2026 14:33:51 +0000 Cosmin Ratiu wrote:
> > > priv->psp and steering at the time of mlx5e_psp_register() is inert
> > > without the PSP device. Cleaning it on psp_dev_create() failure
> > > would
> > > be weird, it's cleaned up anyway on netdev teardown. The fact that
> > > only
> > > memory allocations can fail inside psp_dev_create() is irrelevant
> > > here.
> > > psp_dev_create() failing shouldn't bring down the whole netdevice,
> > > so
> > > logging a message and continuing is ok (which is what is also done
> > > for
> > > macsec and ktls).  
> > 
> > This is a misguided cargo cult. Or something motivated by OOT
> > compatibility. Alex D sometimes tries to do the same thing with Meta
> > drivers. I don't get it. Of course we want the device to be
> > operational
> > if some *device* init fails. The compatibility matrix with all device
> > generations and fw versions could justify that. But continuing init
> > when a single-page kmalloc failed is pure silliness.  
> 
> I am not sure about the wider context, but from the POV of the driver,
> it's calling $thing from the kernel which can fail and it needs to do
> something about it, either fail the entire netdev bringup or accept
> that $thing won't be functional and continue without it. The driver
> shouldn't need to know what $thing does inside and how it can fail,
> which can change over time. Today it's a kmalloc(), tomorrow it may be
> something else.

Like what?

> It doesn't and shouldn't matter for the local decision
> to continue or not without $thing working.
> 
> Isn't this reasonable?

No, the normal thing to do is to propagate errors.
If you want to diverge from that _you_ should have a reason,
a better reason than a vague "kernel can fail".
I'd prefer for the driver to fail in an obvious way.
Which will be immediately spotted by the operator, not 2 weeks
later when 10% of the fleet is upgraded already.
The only exception I'd make is to keep devlink registered in
case the fix is to flash a different FW.

