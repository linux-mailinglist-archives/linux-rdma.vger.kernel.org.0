Return-Path: <linux-rdma+bounces-4318-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5874694E6D8
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 08:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A67228328A
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 06:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A77C153810;
	Mon, 12 Aug 2024 06:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oOq7bptY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072DB14F9DB;
	Mon, 12 Aug 2024 06:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723444722; cv=none; b=eSzDE4Dmybof3jn0bZcLWDxmvv1nWVpePl7EkOZ6valo3ywzbqbPbXfNW+5a2TX2v+BK8roE/Qz+wg1AtHQn77NqXBKotvI/6V9eGCUCxJWstpGqGcqg/MAic0Q1XevrsPmos0qMDtcjuWDVsCD7I0vK8oyROjLg0xrzxxLmtP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723444722; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clzICbhXvlOhzqUGGlM2ZnAJ6y0KxRCKRD8R34ZILpvLC5S73A7W9Li9tQTl+ojPDDZgbcF+ogpEQbTTwzh9PNQp1yU2E06PSBFZZQWotLOXgDpw7tHKNhkxPAnqiQBIwbwQ+uzVDsQu30XOO0XDU6AzgGVk8BiG0C6bZSRkuWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oOq7bptY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=oOq7bptYuSILwOzaxArpzFjr2K
	+uKWU9hsetJakH8nTrqyXOf50LRyN1whe9u1s8IcddihzD+eFYFMze/CswwScW7eYeDCp7MCCDH+/
	ar8KEUrfs95aFnc7SSvtskgeCxed9JqGyAD1cKYrZFUIqj7EVAg2PJQkVVvDJVT+dnILGoqbzJzBH
	nVMf0g6QgJ2YZeZWrdZFecgghs2AlmWN4JBQ5OpTCYMSY5qNGi8Mma4VdyOeO8IkKzOIAeTMRIMGS
	v0GKTS4vWrCNIajtkD1G3Jr+38y2JkrE1x9HGwnuqBmL+NNQEg/yWgYYVThh45XaalPg/eJc8k8Gu
	a8aWHMgw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdOhU-0000000H2z5-0hlu;
	Mon, 12 Aug 2024 06:38:40 +0000
Date: Sun, 11 Aug 2024 23:38:40 -0700
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
Subject: Re: [PATCH v5 2/4] kernfs: remove page_mkwrite() from
 vm_operations_struct
Message-ID: <Zrmt8MuXqZjnp6dY@infradead.org>
References: <20240808183340.483468-1-martin.oliveira@eideticom.com>
 <20240808183340.483468-3-martin.oliveira@eideticom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808183340.483468-3-martin.oliveira@eideticom.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


