Return-Path: <linux-rdma+bounces-2216-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F668BA0B6
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2024 20:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53D861C221B6
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2024 18:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8072174EFA;
	Thu,  2 May 2024 18:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bHjgbdAO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD79FBF6;
	Thu,  2 May 2024 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714675513; cv=none; b=i1qseFC/D1FLkU8kQVhOv6CE0KH9ymmDk/LW+LM9gWJLQdrAspPUES+UPx0YeW5Ao62xCGWKHCHc9GgMQs0x5HUpZpST27bjHyKB6xDA12sL6G2hGKe8TxY4Oh4/VhYLVUVDb8EQ3ZLprQtVpMRo4ObtjJuomWwz+dh3yfXGRFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714675513; c=relaxed/simple;
	bh=FWuYteWtRFhnZWyLGHxZuWlcSYRlHBcV1uBe1wn/qeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGV5fk549COC6msk6YSC6Nca90PfK4Y3gOz75QfNOThn/3lB6U6BWS/mFFGmpSjL4zEs/+UbdSqWTj9Wjl33mVsRJRk5wltexkZFiG8n0uZcfl+7+JXhYa4tvbIZGJqKAlWyuwi9vDdo8pog8lXn0xjES4MRKpOekz1L1ndIc3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bHjgbdAO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ChA4JiEO8+pzbEqPjZaxipmruWijlKLZwUNT6NFeTP4=; b=bHjgbdAO2OtVI/QsIEAZ+xE7sA
	piqclsNY80fgYK6rkYvkCmKZ3W0yraJRf1lRVTQq9A/vuaburmAoHPkGeD/72zEo1oxBmIQSxd2pQ
	bLKa9/ENfAW7x2Mfv0zF7UR0yfahZ4B2cEF0yh1+Zc6ZevwLc98DeQMrbKKeYSg0xSh+dzZpvT1Cl
	P6Hjb+YNg8nguEe2VUCajZmwTK6ocR9Zbkl2Kb4pDiHMyJ5eOyJFhdMqLzDw5sKu4B+fVjtSf7AP7
	67itKBXCrbv3RO7mu2GsaUu8rI1xV7wiTwjS+NcwgqBzvqfPvuJHgIppQBjg0UePiR0Fe6SzwQsM4
	6VKgpgWw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2bQQ-00000002Ezr-38HW;
	Thu, 02 May 2024 18:44:58 +0000
Date: Thu, 2 May 2024 19:44:58 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
	linux-mm@kvack.org, Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Artemy Kovalyov <artemyko@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Pak Markthub <pmarkthub@nvidia.com>
Subject: Re: [RFC] RDMA/umem: pin_user_pages*() can temporarily fail due to
 migration glitches
Message-ID: <ZjPfKqMJYU71iCV9@casper.infradead.org>
References: <20240501003117.257735-1-jhubbard@nvidia.com>
 <ZjHO04Rb75TIlmkA@infradead.org>
 <20240501121032.GA941030@nvidia.com>
 <87r0el3tfi.fsf@nvdebian.thelocal>
 <92289167-5655-4c51-8dfc-df7ae53fdb7b@redhat.com>
 <a2032a79-744d-4c00-a286-7d6fed3a1bdb@nvidia.com>
 <20240502183408.GC3341011@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502183408.GC3341011@nvidia.com>

On Thu, May 02, 2024 at 03:34:08PM -0300, Jason Gunthorpe wrote:
> IMHO pin_user_pages() should sleep and spin in an interruptable sleep

killable, not interruptible.  Otherwise SIGWINCH and SIGALRM can
result an early return.

> until we get all the migrations done. Not sure how hard it would be to
> add some kind of proper waiting event sleep?

ummmmm.  We have a "has waiters" bit in the folio.  So on every call to
folio_put(), we could check that bit and wake up any waiters.  I need to
think about that; right now, we only use it for unlock and end_writeback.
Making folio_put() heavier is, well, quite a lot of call-sites.

