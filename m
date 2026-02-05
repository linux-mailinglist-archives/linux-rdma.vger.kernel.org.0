Return-Path: <linux-rdma+bounces-16555-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFNNEIT7g2kXwgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16555-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 03:08:04 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDB3EDDC8
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 03:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEF2830209C0
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 02:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDB225A2DD;
	Thu,  5 Feb 2026 02:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCssFMyN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB0124677F;
	Thu,  5 Feb 2026 02:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770257198; cv=none; b=HMde1tJnmaJNIids8LxIbyKTIsAQGUrdkFkeI2hlwa1Qpkit7EaooMbROIvctz8lgwAQld3y1A3bH5t78eMiWZe3awx+bXWtCOVlP6lcFXz95ZH8yISQMevNM3aButDPIi40T7oU0CYN2N0pIrCEqZZPAMArGI3emJ1f1fKPuRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770257198; c=relaxed/simple;
	bh=o5GScY0IkA5GPyQXBW8RFTDzDffTJNoOPmkAuFmcNts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M2jyR6KVFMCUpJDPWxUWkmJgMAwUEscQxp9xrAMCQPfsMRxO4Ytycq8jW+og5VNWqbR1MQI0NnSbab6LFOw74gUkIhO3gmH0VFqD31RkPVhXLwwfeaXA2H/fyo9BOl9SKr2Bi7G4ioy5YdNZlCdsLQ8IQuCqaqLHHOmfeH6BFqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCssFMyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3836CC4CEF7;
	Thu,  5 Feb 2026 02:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770257198;
	bh=o5GScY0IkA5GPyQXBW8RFTDzDffTJNoOPmkAuFmcNts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vCssFMyN/MYJ3pp6mRt9gbYbxLArpvEIqwxsJ6i0uEg3acxlxvUzLRo9a+35Ank6m
	 2IIVTHz+jdHtmaGVSxvYqlrwnLRDLddo6Xg1TYeJLeoCjg4w9+PPkzVQgH/EZKM0gu
	 gGVgT2kHHIm9b1kioqALCaLeTaf2UlFtV+UOCAcYApGSrzPcgVdDGvrA+aszVwBGH5
	 7IFGaICnk22UIc0Z8J1ppxLU4ZqD89EfJOavzdPXaqX5cj5LwmIqaNDvR8tbHvuTyg
	 NdmUkgWRWmbb31oqz9GBN2SMrHLX7p04OdA9j9ogl32MQQ2un16OVCRLtxP1beBXhp
	 RU8qn5JytWVhg==
Date: Wed, 4 Feb 2026 18:06:36 -0800
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
Subject: Re: [PATCH net-next V7 02/14] devlink: introduce shared devlink
 instance for PFs on same chip
Message-ID: <20260204180636.7ae26cb6@kernel.org>
In-Reply-To: <y2q4usbmebqm6vpu32is6m3ga3f3xs5xe3jbk2g5n7l7fmt2eu@4m3guiuc3uuz>
References: <20260128112544.1661250-1-tariqt@nvidia.com>
	<20260128112544.1661250-3-tariqt@nvidia.com>
	<20260202194946.64555356@kernel.org>
	<wdkd7yelgosii7bklmahxf5t6xnn2vydnwiiruiwqpyue722dj@yjnkcdctzeav>
	<20260203184200.216bb426@kernel.org>
	<y2q4usbmebqm6vpu32is6m3ga3f3xs5xe3jbk2g5n7l7fmt2eu@4m3guiuc3uuz>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16555-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DFDB3EDDC8
X-Rspamd-Action: no action

On Wed, 4 Feb 2026 08:15:21 +0100 Jiri Pirko wrote:
> >> String gives drivers flexibility to use anything. Perhaps I'm missing
> >> your point. Are you againts free-form or just string and buf+buf_len
> >> would be fine?  
> >
> >I was thinking binary buf+len is fine, and we shouldn't really expose
> >this to user space in any shape or form (hence no concern about free
> >form).  
> 
> How you imagine to name faux device then? I'm sensing that you want to
> get rid of busname/devname handle for things like this and rely on some
> randomly generated index. But the whole ecosystem is bases on
> busname/devname handle. Any idea how to overcome that?

Quoting myself form the other sub-thread:

  FWIW using devlink day to day, the bus/device is not at all useful as
  an identifier. Most of code touching devlink at Meta either matches
  on devlink dev info or assumes there's one instance on the system.

IOW I think you over-estimate the value of the bus/dev in real life
systems. And that's for instances that have a real bus/dev. Having
a faux bus/dev is completely pointless, right? The only question is
whether some code will straight up crash when seeing a device without
bus/dev.

