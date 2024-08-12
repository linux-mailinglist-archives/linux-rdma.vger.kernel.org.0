Return-Path: <linux-rdma+bounces-4317-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C611494E6D4
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 08:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00758B23444
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 06:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323EB15098D;
	Mon, 12 Aug 2024 06:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IrlmR/oG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5F314EC64;
	Mon, 12 Aug 2024 06:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723444704; cv=none; b=CJR7OJuoFF8Txe5ddPvjIJ36VQBrlQflTY3WRhKyAe727vudEtuYtO0NMsmLYA8Vd/thk6jtfIXictSnq42RVDOgrhKsbrJRP3BRD68/59rgGj61M+vKNJYEjsMRNQunrZGhKIR/XHUgNsiXkjWf87waIH1m2+CHYeT5ubhmUU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723444704; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Abal0tzhBTaI+WeWWYeokwGb48qkikJBUwH2zWdFUs7cQDdMeUKofaJmuboVqpSAfyYctdpz5EZiaGCm6OMLTz3zuhMoyLMZ0sHST5dcSHka5MX7xPQK7mmFkc4ZP2uCtwYowtUxCTbwIKtK/xJmzNdwPLwp0CIn8tBMUFbh9MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IrlmR/oG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=IrlmR/oG73MgBSRIOrICho25mF
	wEYIaDlWHh4yghmHe53kbHWjYyADKGEw+Gnd1I5l5yk73b6kVdP3iK9k1SAyeV78ykusvWoBrHVFn
	oqIRMrd8amTSp6HaVJNywMhl8wyJJs0Gzxpa/J+V1fWonhWhxsc2JL35CtNehy/wSSYe8WI9KWA89
	vzQ6mfd9SrBUAPj9TtanGBtjrxwth0RpE5Q6Tc4aBktH/t1oJ3BdyCz+XevknpplbdbOqCX5xt66e
	NILkr/HNgiEfUaVp+vYnFMZckLt14BjOKNg2ECPjSquao6e4cSHbxsDkXcu+cIezxF26L8i/6AZs5
	rRaHQaMw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdOhC-0000000H2ub-0Wnj;
	Mon, 12 Aug 2024 06:38:22 +0000
Date: Sun, 11 Aug 2024 23:38:22 -0700
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
Subject: Re: [PATCH v5 1/4] kernfs: add a WARN_ON_ONCE if ->close is set
Message-ID: <Zrmt3pkGaOil_ayk@infradead.org>
References: <20240808183340.483468-1-martin.oliveira@eideticom.com>
 <20240808183340.483468-2-martin.oliveira@eideticom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808183340.483468-2-martin.oliveira@eideticom.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


