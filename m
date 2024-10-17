Return-Path: <linux-rdma+bounces-5443-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A681A9A2341
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Oct 2024 15:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D79F81C289EB
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Oct 2024 13:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF33E1DE4E9;
	Thu, 17 Oct 2024 13:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f9E1BCSU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6411DDC3C;
	Thu, 17 Oct 2024 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729170779; cv=none; b=s5a3kRGQiwsFktgWG+p+EG3NV1zT0wdQVg8LcLtMqhu2aM6CqQto3r7RyOI8xlIrIXazw7SDSqFFeRgFarJWNTaYHz4457DFatzyZdTLviKMQRwpHMGv1w5ryB1E0g5WgyGBFtyQ9gGAhuSE23avjYWfy5+bwcwb2incno7Rnq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729170779; c=relaxed/simple;
	bh=YmPKHblmykCYSpTXM4GbHkuG2YVDdbnNCpiO2NiFhRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plKf46HW3m6pWRIyAGxnDKq6fZG2AGYzojcwBZCQuPOAoX9P82JDJElHZ5MlJBfrazks/S0hNQ21dgD8WcdOjFaQPSDqVMc5SP++XfbYqIGuUwuyCfxF4Ufjwe/ESUZZAzD9AFBNBxr2O/OH7kZ/r62itqfxr6wtRe8/XC3mGyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f9E1BCSU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YmPKHblmykCYSpTXM4GbHkuG2YVDdbnNCpiO2NiFhRY=; b=f9E1BCSULnSugS1EghEBwHw0l6
	zQ3Gk6pTRx0UFUwvhS7/QVjlX0Hf2PrR3WtDAuc0WJtV5BrIMKHFQ6poJj068iXE5HPhablrFUo67
	MGkkhQ8qf0FJ6PLrTdLSBf5j2R3pEgurLlaVeDox3ljUsYGxbDYygYPWcLv+25D+sELMvGtdjquA0
	bZd/APhOUz3Pby05vHrYJODgTtxhpASNztVy/ApfHKosY+NMBHrlC6cx7rXcM7lZToV3hgRBrTs+I
	TZ95IZLqPyXabFZg1Oq+H1xdllas7yBhvJ92uhWJBHxdyeUyBYfn1Q69UDb+LevK1JuB1EX6oSp9t
	Mzge6k3Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1QJD-0000000EtT8-3yia;
	Thu, 17 Oct 2024 13:12:55 +0000
Date: Thu, 17 Oct 2024 06:12:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@infradead.org>,
	Yonatan Maman <ymaman@nvidia.com>, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-mm@kvack.org, herbst@redhat.com, lyude@redhat.com,
	dakr@redhat.com, airlied@gmail.com, simona@ffwll.ch,
	leon@kernel.org, jglisse@redhat.com, akpm@linux-foundation.org,
	dri-devel@lists.freedesktop.org, apopple@nvidia.com,
	bskeggs@nvidia.com, Gal Shalom <GalShalom@nvidia.com>
Subject: Re: [PATCH v1 1/4] mm/hmm: HMM API for P2P DMA to device zone pages
Message-ID: <ZxENV_EppCYIXfOW@infradead.org>
References: <20241015152348.3055360-1-ymaman@nvidia.com>
 <20241015152348.3055360-2-ymaman@nvidia.com>
 <Zw9F2uiq6-znYmTk@infradead.org>
 <20241016154428.GD4020792@ziepe.ca>
 <Zw_sn_DdZRUw5oxq@infradead.org>
 <20241016174445.GF4020792@ziepe.ca>
 <ZxD71D66qLI0qHpW@infradead.org>
 <20241017130539.GA897978@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017130539.GA897978@ziepe.ca>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 17, 2024 at 10:05:39AM -0300, Jason Gunthorpe wrote:
> Broadly I think whatever flow NVMe uses for P2P will apply to ODP as
> well.

ODP is a lot simpler than NVMe for P2P actually :(


