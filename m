Return-Path: <linux-rdma+bounces-17040-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WElLDl7OmGlDMwMAu9opvQ
	(envelope-from <linux-rdma+bounces-17040-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Feb 2026 22:13:02 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6161816AEEF
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Feb 2026 22:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D031D3003BEE
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Feb 2026 21:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A0630C602;
	Fri, 20 Feb 2026 21:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tj7FiZud"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136E08632B;
	Fri, 20 Feb 2026 21:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771621977; cv=none; b=Qs5QCC9Y/WUqs9uoAiCc7zhxq1I+MrWq7TIHFU8Hf8BTPaD2gwZ7Oj9JSjjURSTO1mVvj5Jru0o1t/oN1sdNIItv/bWrld1YcvnxPT2Rv7d/OzRb501bTosAJEXOg9g7hPXbPc5X491JPUk3chpFZZruPRrqDtBmENB0T1QJJ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771621977; c=relaxed/simple;
	bh=rWl6dMxeYGvOMYwtSU//ooK1I0F1z6Cua66E68lf2Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M8YWyKRBSLBGvh7exo++lblKDgvWI9Q9DDbP2xW86Acd6DkQTwsXNCfOangfj+5X1vZLDuJCFvYmoUqKQjE1mcEaQ9HRn046+TzYfAoU5agAbapoN18VhQ3N3mdxzmRQeQJBgu4icH4+UEL6WRM7v74RPpK0UlvqU8+fAVFgraQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tj7FiZud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3826C116C6;
	Fri, 20 Feb 2026 21:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771621976;
	bh=rWl6dMxeYGvOMYwtSU//ooK1I0F1z6Cua66E68lf2Tk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tj7FiZudoNl05G9q5nEn7pGIJvO7AJV8Bh1AhMlr5O1InCzsN1ZmH1yk8QKwpE2y2
	 9GXfE+oGkjVX54YYCng+IC07iWGSnQi6Uk/MqmVsEPYiPMfoXLF0YJZbVAzGB1jYrb
	 wmrPn67armgNBkql77xUt1N8BMI5wp7IAY1qsLuul5JljHbGpDIJZyfW3q7mCAgWHM
	 B4ed/KRnK6yUOKw+J1Ba7JzblsZxONnuL0QmfptrEr2d5vqos+dSm6na1E8MKFjV2M
	 n5KW7ChJyeozPQzIfHPef5PM7iJ0qitJwSmg6EKeRloMz7cDz17kElcrWD5tKTycIm
	 5ETZ5iMw0C1bg==
Date: Fri, 20 Feb 2026 13:12:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Saeed Mahameed
 <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Michael Chan <michael.chan@broadcom.com>,
 Hariprasad Kelam <hkelam@marvell.com>, Ido Schimmel <idosch@nvidia.com>,
 Danielle Ratson <danieller@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
Subject: Re: [RFC net-next 0/4] ethtool: CMIS module diagnostic loopback
 support
Message-ID: <20260220131254.03874c4c@kernel.org>
In-Reply-To: <3b0949fa-0b05-4bce-86c0-2a7a058865a5@lunn.ch>
References: <20260219130050.2390226-1-bjorn@kernel.org>
	<415c4922-cc8d-4e35-bbac-3a532f44d238@lunn.ch>
	<20260219160519.323041bf@kernel.org>
	<3b0949fa-0b05-4bce-86c0-2a7a058865a5@lunn.ch>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17040-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com,nvidia.com,lunn.ch,bootlin.com,broadcom.com,marvell.com];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6161816AEEF
X-Rspamd-Action: no action

On Fri, 20 Feb 2026 15:18:40 +0100 Andrew Lunn wrote:
> > Something like:
> > 
> >   struct {
> >      enum type;   // MAC, PHY, SFP
> >      int type_id; // if type=PHY - phy id
> >      int depth;   // counting from CPU, first loopback opportunity is 1
> >                   // second is 2, etc.
> >      bool direction; // towards CPU/host vs towards network
> >      char name[16];  // "pcs", "far", "near", "post-fec", whatever
> >   }  
> 
> Lets see what comes from the drawing board, but i was more thinking
> about expanding the bitmap this proposal already has, extending it to
> other layers.

IIUC the bitmap this proposal has is basically a product of
direction x depth: [host, network] x [nearest, furthest]
plus its scoped to SFP.

> As use cases are implemented, we define the bits needed
> in the map. 

Sure, but if we are creating a dedicated API we should decompose 
the information from the start. Direction, and entity (MAC, PHY, SFP)
don't have to be part of the bitmap?

> The ethtool kAPI has the needed infrastructure to map bits
> to names, it is used for link modes etc, and that can be used here. So
> the ethtool(1) part should be reasonably generic.

Dunno if link modes are the right point of reference. Link mode is 
a combination of various parameters which must match on both sides
exactly. For the loopback the config is very simple, the expressiveness
is needed to explain where the configuration is applied.

IOW for link modes it's important to have an ID for the combination of
all params to easily check if the whole thing is as expected.
For loopback it's easier to think of it as traversing attribute by
attribute: MAC / PHY / SFP -> which one -> which depth -> which dir.
Single id has no benefit and would be cumbersome to define.

Or at least that's my intuition, I haven't use loopback much myself.

