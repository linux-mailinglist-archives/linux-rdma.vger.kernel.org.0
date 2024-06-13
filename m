Return-Path: <linux-rdma+bounces-3091-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24760906394
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 07:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B7051C21774
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 05:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D06A13698E;
	Thu, 13 Jun 2024 05:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XMBP4Gj4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDFE136672;
	Thu, 13 Jun 2024 05:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718257465; cv=none; b=qPX39fkgM4twnI03hJ3Cg63DJoTRxn+NzV06OqO7WmrKpbdGK6dVxOeZFcxZEUHaxV2B1ZE4An8hlbKNOrOLSK+5XNiulFudoHVLfvPS+2M55IiS0iieTWUfVSEJ5Lyzd9GuUFA4OAnNkhO/f/9ru/Gn5EWRY8yOuAEuxN2Uo5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718257465; c=relaxed/simple;
	bh=/tygySxNptF1bNqqC2R+zD32oTKCFsAxOPINPtnaW6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRI0qvtia5MjgIBT59vDB3zAiJuHSqrGtGDK1X1xq72nZWirXRejRr4brz5iA1DaDl6glYF0U0rBHBmZiQVZSBtzUoj/YEqkBec1LL8nikqNYGxHuit/02BX7Pu1Zv2ZrEHv5Wy3It9WQ+0qG/zu+YFWIT4oEJyfpyzPDZCG+8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XMBP4Gj4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mZUyZbGRLoZ61VzFcElkmd0RzIflNIRedkXb41aYIms=; b=XMBP4Gj4alCsQXtnGvwGXhKGJq
	WcL/CT6vNh91rMWL54YOhyIVKEZ/leEAqL33Ichz8d1gGp+JsGDS2PbQPDoQGZr96bGQqisXqcIsJ
	OuEO+i9FYIEzwCXV36lgY4XnjcWtzPmXcjWWaOvp5deZ60g/G7q+sKCNsNgeM21GL+aAIXBewlA9h
	h7mCJ6SESIzFIIHYiPRtM2v1wtHhYFCW9tb+tr/QPY3z0FdPkqJxzfzXUyDeiXOKjmA45C2hTvlD6
	Pu3Xx6w3CK5nY7Zfa/zkDicZU9YyKyX9LdVJ28OmMNCTD+BBduLlz0Ooq2RoJ35KLgLW4xgDRHnQ5
	/vHY+Ewg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHdG1-0000000FCio-48U9;
	Thu, 13 Jun 2024 05:44:21 +0000
Date: Wed, 12 Jun 2024 22:44:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Martin Oliveira <martin.oliveira@eideticom.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Artemy Kovalyov <artemyko@nvidia.com>
Subject: Re: [PATCH v2 1/4] kernfs: remove page_mkwrite() from
 vm_operations_struct
Message-ID: <ZmqHNZn0Pi4HEqTk@infradead.org>
References: <20240611182732.360317-1-martin.oliveira@eideticom.com>
 <20240611182732.360317-2-martin.oliveira@eideticom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611182732.360317-2-martin.oliveira@eideticom.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 11, 2024 at 12:27:29PM -0600, Martin Oliveira wrote:
> +	if (vma->vm_ops->page_mkwrite)
> +		goto out_put;
> +

I'd probably make this a WARN_ON so that driver authors trying to
add a page_mkwrite in the vm_ops passed to kernfs get a big fat
warning instead of spending a couple hours trying to track down
what is going wrong :)


