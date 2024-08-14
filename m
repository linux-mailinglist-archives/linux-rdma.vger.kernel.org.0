Return-Path: <linux-rdma+bounces-4357-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1F695137C
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2024 06:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C6E2B21D05
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2024 04:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD6E4D131;
	Wed, 14 Aug 2024 04:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uh2JpD5Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3B03F9D2;
	Wed, 14 Aug 2024 04:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723609618; cv=none; b=GLzgb+l16R42tBWNgWo3+YkQIVg9d8YDZvK1idHdPlmcKJyCoQFeYZ8j6PEMjYrp/ajUAAoq7920eqQwmx1UWKq+T1LJ2MAk5oOlTxUKmzD+J+b1vgkpqr2JFpRz3vvjwK4XVEdMrAdOgwv6cPHJGspAKCg5etheGJHpnY84/NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723609618; c=relaxed/simple;
	bh=PLb67pVSsndcRI1y+KjrOGjJp6540cHeBGACcgBee8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fu6jS5yAk9kun9+PKbTMAc0SZ2AMA+o8K1SD2Oy1XTw7nO8WQvWfuxQKU9LkAKcfNT0saZQkI8Vncw9SYc7eQRq2TFQ/j+L5K5h3vMO314u9gcvDq+NVRBii0twNCIIuxTwdZIXn9tiTAwju+OaMmYUZyi5NsF55UyEiOtNuTx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uh2JpD5Q; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LLpJw7phUcutr01b12qv/qpETaOvy+zBcX+/75hkvbs=; b=uh2JpD5QvJXwqoGwxpzEwHpoFa
	CGMYHrX7qJBCL2dDDtAlj0zdNDORRfH8/0OoO+ounA//ihfJ1GQewiXVrDZk1yQxBEPkw23ad+yOj
	18+AKDzpJB/MGHbOq/LBuDgp0BRYM1+td2BrXODCaY2BYF17M+hdHArGCs2+KRxS63AhuKPrG1md0
	8VkG46a5ftMHdpYXkyLQ+4p0swHOD81TJfaPne1dGD2DKhG9OpqX/psWhwQVKS4LtrLIxEB5gKgU7
	DlL9e/q8XqXsyZDaSVwVF2Zy/TdA/bJtzQQuQE4oOiU8bAYUEy/xT2KFvoTBf4f2hW+OdGUF0leo2
	ISRtmz9A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1se5b5-00000005gyt-2c07;
	Wed, 14 Aug 2024 04:26:55 +0000
Date: Tue, 13 Aug 2024 21:26:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@infradead.org>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Artemy Kovalyov <artemyko@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leon@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>, Tejun Heo <tj@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Sloan <david.sloan@eideticom.com>
Subject: Re: [PATCH v5 3/4] mm/gup: allow FOLL_LONGTERM & FOLL_PCI_P2PDMA
Message-ID: <ZrwyD10ejPxowETN@infradead.org>
References: <20240808183340.483468-1-martin.oliveira@eideticom.com>
 <20240808183340.483468-4-martin.oliveira@eideticom.com>
 <ZrmuGrDaJTZFrKrc@infradead.org>
 <20240812231249.GG1985367@ziepe.ca>
 <ZrryAFGBCG1cyfOA@infradead.org>
 <20240813160502.GH1985367@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813160502.GH1985367@ziepe.ca>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Aug 13, 2024 at 01:05:02PM -0300, Jason Gunthorpe wrote:
> > Where do we block driver unbind with an open resource?  
> 
> I keep seeing it in different subsystems, safe driver unbind is really
> hard. :\ eg I think VFIO has some waits in it

Well, waits for what?  Usuaully an unbind has to wait for something,
but waiting for unbound references is always a bug.  And I can't
think of any sensible subsystem doing this.

