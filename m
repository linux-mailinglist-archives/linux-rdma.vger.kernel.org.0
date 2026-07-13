Return-Path: <linux-rdma+bounces-23092-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fQ3bJKmdVGogoQMAu9opvQ
	(envelope-from <linux-rdma+bounces-23092-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 10:11:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB3074885B
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 10:11:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GdAfMVNg;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23092-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23092-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D0A1304CA53
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 08:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF8C3A63F2;
	Mon, 13 Jul 2026 08:08:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BB939EF14;
	Mon, 13 Jul 2026 08:08:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783930103; cv=none; b=lnF51uRsSTOLvZ6fAOVP7enAGyw688+5lSPBjSJwKu4zIxtOh/CSKBRfeFrX8i+Wxa8UESdmpDi9PFWGXELaD+g07+14mU7PaXubmHr+pg1VrHIBo1WInirpK0S6gbwg1AHHzMNzaA/5bkUm6+Hf81NiWeK/vXCsZyLjsDpZo1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783930103; c=relaxed/simple;
	bh=uLT7HWzsI84MdeWJhgNF4lDj6foDO+aRXB+64HHmnzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpkSMwYs4BlrzDxdERcVUYLi+SpytyV2zQilEggUpY20TYZvkaWgroXyHVsVGqPgNypsZL2P0Zl0DsbVIdAUrWSwoSew7KUtuLRW6kqcOl+LR8u1NhKfxoqJ+0tRaybE5HYQZMCRdsNRrPvQyd0WGvEgBhnC4rUYL3vfk9y55R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdAfMVNg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300321F00A3F;
	Mon, 13 Jul 2026 08:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783930102;
	bh=pYNE2/vvUsYohUa/Lltav4piWNiMdY9CO+/H9wkxZu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GdAfMVNgR8cuLk8qti7w7tFiS+cVjrHBaRfIfI16N7YleLCkgNNDKTR2IiKInO4c6
	 eW9VJ5OusGVuvE0MMMM9XOpH4pjsk5xCKr6LvMGCz+vk4dvRN61vLAEpk+WaHlEJEI
	 //NNe2+dXOmZlic/YjAAXICikCfFE5GnaDlfO466oe1mo4YQW6dHhRGZpuHwRdGfxA
	 6hQbvqZw0NUq7B/TEs1Xgj3yqpw16mqxbvQ37tN57fFAjVjHNYdMGIZoEBwypS3kzt
	 6jNC3LDIvlOFikYUaPKzfq5rh67MM6n05mLl/Iq9Mf+68Njd1ghRQqrsLAmciNBt0k
	 RewQpcHA4rrAg==
Date: Mon, 13 Jul 2026 11:08:16 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Zhiping Zhang <zhipingz@meta.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Saeed Mahameed Michael <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net/mlx5: free mlx5_st_idx_data on final dealloc
Message-ID: <20260713080816.GA327832@unreal>
References: <20260702222507.1234467-1-zhipingz@meta.com>
 <9e4e455b-c10b-447e-9fe6-80672f26fd8a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4e455b-c10b-447e-9fe6-80672f26fd8a@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:zhipingz@meta.com,m:jgg@ziepe.ca,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:michaelgur@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-23092-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email,unreal:mid,vger.kernel.org:from_smtp,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2AB3074885B

On Fri, Jul 10, 2026 at 01:25:45PM +0200, Paolo Abeni wrote:
> On 7/3/26 12:24 AM, Zhiping Zhang wrote:
> > Workloads that repeatedly allocate and release mkeys carrying TPH
> > steering-tag hints (e.g. churning RDMA MRs) leak one
> > struct mlx5_st_idx_data per cycle; kmemleak flags it as unreferenced
> > and the kmalloc slab grows over time.
> > 
> > When the last reference to an ST table entry is dropped,
> > mlx5_st_dealloc_index() removed the entry from idx_xa but the backing
> > mlx5_st_idx_data allocation was never freed.
> > 
> > Free idx_data after the xa_erase() so the lifetime of the bookkeeping
> > struct matches the lifetime of the ST entry it tracks.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 888a7776f4fb ("net/mlx5: Add support for device steering tag")
> > Reviewed-by: Michael Gur <michaelgur@nvidia.com>
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> @Leon, @Saeed, @Tariq: just in case this fell under the radar, it's
> waiting for your ack.

Tariq and I completed this on Jul 5 and Jul 6.

https://lore.kernel.org/linux-rdma/20260705141920.GI15188@unreal/
https://lore.kernel.org/linux-rdma/0bb37f75-c94a-4a10-b115-186b71daf14f@nvidia.com/

Thanks

> 
> Thanks,
> 
> Paolo
> 

