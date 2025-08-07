Return-Path: <linux-rdma+bounces-12626-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 695D9B1DCF8
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Aug 2025 20:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 530A1188426B
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Aug 2025 18:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5836D26A1AC;
	Thu,  7 Aug 2025 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyRSg+3/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103FB2222B6;
	Thu,  7 Aug 2025 18:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754590781; cv=none; b=BrJC7//n/aOuHSt0uAyRVNRxxQkiXtcMvqxZDTyFCAtbRvgv5KvayGmu4lTBE87Mnb5zGIsX6Sa+i+J6nkw61yZ2L155q9fpqVgTKJ1QZ12MzvBtEdvso2RnocdPY/INutHu+NsZEos/v3JhXuFl8ptUUKVa5bvXl7N9E3QSmuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754590781; c=relaxed/simple;
	bh=IRN0oHalVFeznJOegXzd94G2U4td7tUuq9QBsHcMA1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRA1yFFg2XzjLp0X2BF3dwt28qq4ig1pWGJcr7QfWZx3Rnqm0MnwIXO2CBACLZrAAzZliArlWVuFVjMt0rRBFjaUIYLR/KS9busRqZX5qLgRlQ4u6isOSW3PHv1kOxQLNETmcG0bQk7WpP7QnbPtEjLA/a07Jv80nq0zv/X+K+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyRSg+3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCB0C4CEEB;
	Thu,  7 Aug 2025 18:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754590780;
	bh=IRN0oHalVFeznJOegXzd94G2U4td7tUuq9QBsHcMA1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EyRSg+3/mlB7Zfib7iXk1F/FyYA2jXU25M925e4J6OCKAEcW0SUZEqKs9wvhJgi/L
	 u1T3bXBYTTTjWy9d4Td7ETSRjBGyNUoQ63ACUAHjfY8Oz78ttVUqx7m7s+1quxhLjN
	 3ixsUv5Ip9u+QZ4d1CUu4HbrKjg4aEnmk78ytnHza/6QQKptMP2KW0IU4X2Ht3gO0w
	 fohzVpW4OVsE8kmppGgSIJQOj9TIhbBa61YtdAGLQLSrT8xgul2mbPV3M9ckZiNH99
	 zH2JVr7ud0XRc4YhBCRHrvZsmwhxF2KDC4o10XLSA5DL/qmsHUwEuVoU4rpg1htlHA
	 GGiREQx0mhkqg==
Date: Thu, 7 Aug 2025 19:19:34 +0100
From: Simon Horman <horms@kernel.org>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, Halil Pasic <pasic@linux.ibm.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [RFC net-next 08/17] net/dibs: Register ism as dibs device
Message-ID: <20250807181934.GM61519@horms.kernel.org>
References: <20250806154122.3413330-1-wintera@linux.ibm.com>
 <20250806154122.3413330-9-wintera@linux.ibm.com>
 <20250807163700.GL61519@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807163700.GL61519@horms.kernel.org>

On Thu, Aug 07, 2025 at 05:37:00PM +0100, Simon Horman wrote:
> On Wed, Aug 06, 2025 at 05:41:13PM +0200, Alexandra Winter wrote:
> > Register ism devices with the dibs layer. Follow-on patches will move
> > functionality to the dibs layer.
> > 
> > As DIBS is only a shim layer without any dependencies, we can depend ISM
> > on DIBS without adding indirect dependencies. A follow-on patch will
> > remove implication of SMC by ISM.
> > 
> > Define struct dibs_dev. Follow-on patches will move more content into
> > dibs_dev.  The goal of follow-on patches is that ism_dev will only
> > contain fields that are special for this device driver. The same concept
> > will apply to other dibs device drivers.
> > 
> > Define dibs_dev_alloc(), dibs_dev_add() and dibs_dev_del() to be called
> > by dibs device drivers and call them from ism_drv.c
> > Use ism_dev.dibs for a pointer to dibs_dev.
> > 
> > Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> 
> ...
> 
> > diff --git a/net/dibs/dibs_main.c b/net/dibs/dibs_main.c
> 
> ...
> 
> > @@ -56,6 +65,33 @@ int dibs_unregister_client(struct dibs_client *client)
> >  }
> >  EXPORT_SYMBOL_GPL(dibs_unregister_client);
> >  
> > +struct dibs_dev *dibs_dev_alloc(void)
> > +{
> > +	struct dibs_dev *dibs;
> > +
> > +	dibs = kzalloc(sizeof(*dibs), GFP_KERNEL);
> 
> Hi Alexandra,
> 
> It is not the case for x86_64, arm64, or s390 (at least).
> But for x86_32 and arm (at least) it seems that linux/slab.h should
> be included in order for kzalloc to be available for compilation.

Similarly for dibs_loopback.c in the following patch.

