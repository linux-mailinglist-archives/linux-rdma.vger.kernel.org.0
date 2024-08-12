Return-Path: <linux-rdma+bounces-4319-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E6094E6E1
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 08:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92618283709
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 06:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FCD15383E;
	Mon, 12 Aug 2024 06:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="22/7aOa7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702981537D2;
	Mon, 12 Aug 2024 06:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723444764; cv=none; b=X1dJveiLUSrSv67x1NhN3nCMRnr32nddKyrGABZCfHqEaOY4S0mS6XU+0JWYvF9+6DRUYYASVBzIfBrkJ/YSfbc7HVisThc56jfpF2zoB2V20Xtb1yC8BjG0UjZ8erfvHc8vSqQfcTegFfVZWD7akdVOmzG3CAFMHEzfyJl4HD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723444764; c=relaxed/simple;
	bh=t1qB8Z8O9uwrtkXdQUpxH+qyN2Od430SoZbTNpVeoQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMIOj5tL5g+MY+tFwf3halJt271ihCfvaHsQjVaWi4mpfQWQcYnAjWDeAEaxxDiZmFHvPQIrGNW7wgYFJ3UUXVka3+MvSIAj/Y1YDhTz2f30QuEo+dhWRxEae/VAM9YhIJPMDkV5dkhOTACEbn4FFkXrzhAP25ps+XYEdra3gXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=22/7aOa7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6OTqWssiccizAG7tMDe551ZY70fKMpPAPHsb0vYPfZ4=; b=22/7aOa797+qdtRS2hfct6+uw0
	QMVxtGItMeUkhcgqWzJHMDpAUVAL/9PvFcjmFbp6rz44yQKPoUtnx+KURp3j2lQddd66ghy/BV5hw
	tmDmXJ6UIMMQ5fbNVW677cTFXd0hq5oiKK+XaLIW7OwY0zcSyiHm7HdE+nwlTbkati88vi1uRytaV
	+Qp8be1ljua+T8g0TfuJX0/VUGFecv25AC+UtMwiKzMm9BkwsqsNknDqMQjcMJj8DU9w50qKG5Mb0
	2Zf8792xMjpVTly2Ad+xEQUGF8YxNSFFReqnb2FbZRS8XTKJMMiljynXdH5PpBNH9RrZvDhThYmVJ
	77gQLM1w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdOiA-0000000H396-2BLl;
	Mon, 12 Aug 2024 06:39:22 +0000
Date: Sun, 11 Aug 2024 23:39:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Martin Oliveira <martin.oliveira@eideticom.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Artemy Kovalyov <artemyko@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>, Tejun Heo <tj@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Sloan <david.sloan@eideticom.com>
Subject: Re: [PATCH v5 3/4] mm/gup: allow FOLL_LONGTERM & FOLL_PCI_P2PDMA
Message-ID: <ZrmuGrDaJTZFrKrc@infradead.org>
References: <20240808183340.483468-1-martin.oliveira@eideticom.com>
 <20240808183340.483468-4-martin.oliveira@eideticom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808183340.483468-4-martin.oliveira@eideticom.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Aug 08, 2024 at 12:33:39PM -0600, Martin Oliveira wrote:
> This check existed originally due to concerns that P2PDMA needed to copy
> fsdax until pgmap refcounts were fixed (see [1]).
> 
> The P2PDMA infrastructure will only call unmap_mapping_range() when the
> underlying device is unbound, and immediately after unmapping it waits
> for the reference of all ZONE_DEVICE pages to be released before
> continuing. This does not allow for a page to be reused and no user
> access fault is therefore possible. It does not have the same problem as
> fsdax.
> 
> The one minor concern with FOLL_LONGTERM pins is they will block device
> unbind until userspace releases them all.

This is unfortunately not really minor unless we have a well documented
way to force this :(


