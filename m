Return-Path: <linux-rdma+bounces-8188-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D45A485A3
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2025 17:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C3C77A5D84
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2025 16:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48051B394E;
	Thu, 27 Feb 2025 16:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hm4yOuD2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BF91B3943
	for <linux-rdma@vger.kernel.org>; Thu, 27 Feb 2025 16:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674922; cv=none; b=s2I27U6X2Kd5eMQ2oz6dbz6zRF8EoMn1t6kzLbPkSZFTFQcqnIQmk4qmhcdKqP+BQJ9VtC9us6R1WRw9I6MGyQQ1xvvPODoiaWXap0wDfwr0fUjmfkQmxN9/dinwNuUq8dkqfl78L6BdmgGo7I3/YCH1NNcxh7EYvbjb+jPMICc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674922; c=relaxed/simple;
	bh=WeAE/TxeOmGnY4+JQF5xk1qUh5Kf+dfgn0Fy3i422Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yi87iL07uWZXswD27BKRyxU/6GhQOOOiWGgomeGV8nXbp2cNm9+rk3HE5XC8zYA5d13UG4xe5206ISfyl4DguQ42v0zSNmeRjjGNlUxQcxTXZdpRIrkTbYqqePwLdQ65ReFcMZZZSgbQOyD5W5dPkDPrP+aGF2JvQG/ccoX+Eck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hm4yOuD2; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 27 Feb 2025 16:48:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740674908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zYqkwfqBGdERzPpqSrLqEfTuFzAy3l3vuA3S89dJKzI=;
	b=Hm4yOuD2Z6trhtMH/dLnwVtxrs93F6QIonjOPAnYVXPum6sNIsIlUnQ39AVOZPf0RNm+Dq
	PW6tP66dmw+uUfk6i1Nv8BLPd+82mtB1ZfErKAKMLfURNR7J6PycbmJulzavL4cqWtvoYQ
	cDim2l1RgjjtYJwuy1rcm2PgMGKEhns=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Parav Pandit <parav@mellanox.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Maher Sanalla <msanalla@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/core: don't expose hw_counters outside of init net
 namespace
Message-ID: <Z8CXV4c9GSPXvgLN@google.com>
References: <20250226190214.3093336-1-roman.gushchin@linux.dev>
 <CY8PR12MB719566F1EE6987670B7D85F0DCCD2@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB719566F1EE6987670B7D85F0DCCD2@CY8PR12MB7195.namprd12.prod.outlook.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 27, 2025 at 05:22:59AM +0000, Parav Pandit wrote:
> 
> > From: Roman Gushchin <roman.gushchin@linux.dev>
> > Sent: Thursday, February 27, 2025 12:32 AM
> > 
> > Commit 5fd8529350f0 ("RDMA/core: fix a NULL-pointer dereference in
> > hw_stat_device_show()") accidentally almost exposed hw counters to non-init
> > net namespaces. It didn't expose them fully, as an attempt to read any of
> > those counters leads to a crash like this one:
> > 
> It is not the commit 5fd8529350f0.
> You just want to say cited commit accidentally..

Right, it's a typo, it had to be 467f432a521a ("RDMA/core: Split port
and device counter sysfs attributes").

> >  	WARN(true, "struct ib_device->groups is too small"); diff --git
> > a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h index
> > b59bf30de430..a5761038935d 100644
> > --- a/include/rdma/ib_verbs.h
> > +++ b/include/rdma/ib_verbs.h
> > @@ -2767,6 +2767,7 @@ struct ib_device {
> >  	 * It is a NULL terminated array.
> >  	 */
> >  	const struct attribute_group	*groups[4];
> > +	u8				hw_stats_attr_index;
> > 
> >  	u64			     uverbs_cmd_mask;
> > 
> > --
> > 2.48.1.711.g2feabab25a-goog
> 
> With above suggested small commit log correction, 
> Reviewed-by: Parav Pandit <parav@nvidia.com>

Thank you!

