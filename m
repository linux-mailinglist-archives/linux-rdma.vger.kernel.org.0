Return-Path: <linux-rdma+bounces-16767-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNvKLAm1jGm5sQAAu9opvQ
	(envelope-from <linux-rdma+bounces-16767-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 17:57:45 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC8A1265C8
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 17:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57D9B3012CD3
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 16:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75113451AA;
	Wed, 11 Feb 2026 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RafUlj7f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C8DA932;
	Wed, 11 Feb 2026 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770829060; cv=none; b=gTPkAWHDihMyNn+SVzsM5qpadYJ1LAFeDu2cw28/BKWrCUCdftE5bFhZdcySkkiErhN+rw9+1IkYQqv0s+A2cAE/T+7nFveVQOHFL1XzAxv8ClKTl/+Nozz2z8qrXseeqFIOrqMb0s1oKDRhfab8BqWCZ89ToocDClteYUjJAiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770829060; c=relaxed/simple;
	bh=KQ4Q7NEGmrbV9vFDTxlRhervK4AoaXw9wNXWEHz1NT4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IBrE726QJjzAtGIkxQXbCmtxrotqeo0RZbAkOJVuLIYDS0R83vq36+6tRpvrrY6+/0+p9LwYzx4YzMX4U0+5CAs0cvdXl2+PC9DYpGZHKt4Lxv3+kjSabkkZfWqa4/6on1X7RV2R+FICDadC4G1PoMnfmP5UsjKInV0C8bctb2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RafUlj7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E6EC4CEF7;
	Wed, 11 Feb 2026 16:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770829060;
	bh=KQ4Q7NEGmrbV9vFDTxlRhervK4AoaXw9wNXWEHz1NT4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RafUlj7fupiB60MaQKL6RsyB7JpUxfrw0gxBfL/3yZXrYhJKHlhUelXkGO4lKKlzk
	 r7rISTu3/sz6fPmtGCS+FIe/yqLhmAkt52VnSLzjVwWrteAM54c0WKqqUZO7J26P4I
	 TXCdCQYwfZ2/qyzxZhUgfW0JcKsBoDwrKEf/L++PZWzKKwq32s3PZWg6Vo2+h6Z2k2
	 8F7d6y0aNQGqgjKmERgVE58sWHR1sauwlFxZYkF8qEM8o+tcwa56pTKCopM3Ikgntq
	 I3pEGTKSUzTbcisUPIZ7of7x6MeD3VtEwKEzhmzgOt8gUPjjniW0P41JiRl9ehnRSj
	 rTV8oXD1NPe3w==
Date: Wed, 11 Feb 2026 08:57:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "donald.hunter@gmail.com"
 <donald.hunter@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "leon@kernel.org" <leon@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "edumazet@google.com"
 <edumazet@google.com>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, "jiri@resnulli.us" <jiri@resnulli.us>,
 "pabeni@redhat.com" <pabeni@redhat.com>, Jiri Pirko <jiri@nvidia.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Carolina Jubran
 <cjubran@nvidia.com>, "horms@kernel.org" <horms@kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>, Saeed
 Mahameed <saeedm@nvidia.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
 <moshe@nvidia.com>, "krzk@kernel.org" <krzk@kernel.org>
Subject: Re: [PATCH net-next V7 07/14] devlink: Add parent dev to devlink
 API
Message-ID: <20260211085738.5835f812@kernel.org>
In-Reply-To: <9d3d4e49cec85473619eb5166f01168a6ae3fd85.camel@nvidia.com>
References: <20260128112544.1661250-1-tariqt@nvidia.com>
	<20260128112544.1661250-8-tariqt@nvidia.com>
	<20260202200035.742f9500@kernel.org>
	<9d3d4e49cec85473619eb5166f01168a6ae3fd85.camel@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-16767-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,lwn.net,lunn.ch,gmail.com,davemloft.net,kernel.org,vger.kernel.org,google.com,resnulli.us,redhat.com,infradead.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2EC8A1265C8
X-Rspamd-Action: no action

On Wed, 11 Feb 2026 16:28:14 +0000 Cosmin Ratiu wrote:
> > > +		/* Drop the parent devlink lock but don't release
> > > the reference.
> > > +		 * This will keep it alive until the end of the
> > > request.
> > > +		 */  
> > 
> > To be clear -- devlink instances do not behave like netdev instances.
> > netdev instances prevent unregistration of the netdev.
> > devlink refs are normal refs, they just keep the memory around.
> > If memory serves me..  
> 
> If no reference is held, a concurrent user op could release the parent
> devlink instance altogether, and free its memory, that's the reason for
> keeping a ref alive for the duration of this request.

I suppose my comment was more about using the word "alive" 
in networking context. I associate "alive" with registered. 
See dev_isalive(). Here you're just keeping the object
from being freed.

