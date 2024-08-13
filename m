Return-Path: <linux-rdma+bounces-4343-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CF894FD5A
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Aug 2024 07:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B175B22835
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Aug 2024 05:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC002364A4;
	Tue, 13 Aug 2024 05:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oXL+ggOr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302292C19E;
	Tue, 13 Aug 2024 05:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723527685; cv=none; b=a/ZzaLvyDtvAOUi38302hP3MbFIMH8n11b+TGcVzLfA7F0J6GwulKTcMKfzd1y8zcMNQpuM/7za1QhmhN3zlSUPHg9wlwe/Gv2iFljObWWyo+hXXRDrFVWS10oG93EoCJbdihSoLeC9BDqmECcPtsRWkjjfueAgBuo2tpqRN97c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723527685; c=relaxed/simple;
	bh=i49iooVK0nCmN7mBhxTyADBk+5BtpXEZY4WJwPZbSME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjcSv23LAz/CbwOzdsMJy62n6YZFm3h8PxeUTndNBrebMZJTk2zB4qwKIxSurqTiHahgGfOnB2Gxf++g4HswQVyFFK6yzB4BUxRSEh9vU2UL//HnPQivGPgXo6a6qtEqg4xhr0bdT/xBLX+oB8KzxrA4o+BI/3Bb5uamO0JWM6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oXL+ggOr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HbO1EYl5czIqfwARjxEt22LiBn82E4H9bfJsvtc+EjY=; b=oXL+ggOrdCjoKtMhmVfXLcx9Ur
	/Vq6hSt/096cHs0MblkRe7e99WnyXtYK7Kc0kemMw/6+IMIDKFFaIME/N4hZ3IDAYu0UvQ1pI1ny+
	YjyBdStcBBBKJrRO9evMX1hIwyEX7nbM0r3rHzH6wBzJCkqzMz+JVpiWVDM5gSqefo0CMhsZ8ebMj
	jWrk3JyxdmBQYyZcawkrlvAZMrMC3cFc7P8y6WXor2f/HVftliBDfsFKqQD5pCLQ9YHW4WzKYkWbX
	WDkSbaFbszEzLTgdvkhvXIXVKNAHwSnqMFE1qjLNKHGdbFZNTebWBrVBIV2Nn8LSuaWvEcnA/gKFt
	wBiMbFjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdkHY-00000002TJW-3iEA;
	Tue, 13 Aug 2024 05:41:20 +0000
Date: Mon, 12 Aug 2024 22:41:20 -0700
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
Message-ID: <ZrryAFGBCG1cyfOA@infradead.org>
References: <20240808183340.483468-1-martin.oliveira@eideticom.com>
 <20240808183340.483468-4-martin.oliveira@eideticom.com>
 <ZrmuGrDaJTZFrKrc@infradead.org>
 <20240812231249.GG1985367@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812231249.GG1985367@ziepe.ca>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 12, 2024 at 08:12:49PM -0300, Jason Gunthorpe wrote:
> > This is unfortunately not really minor unless we have a well documented
> > way to force this :(
> 
> It is not that different from blocking driver unbind while FDs are
> open which a lot of places do in various ways?

Where do we block driver unbind with an open resource?  The whole
concept is that open resources will pin the in-memory object (and
modulo for a modular driver), but never an unbind or hardware
unplug, of which unbind really just is a simulation.

