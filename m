Return-Path: <linux-rdma+bounces-2973-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 078108FFB22
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 07:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAED91C212D1
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 05:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F287B1805A;
	Fri,  7 Jun 2024 05:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3L5H+p8b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43D2D2FE;
	Fri,  7 Jun 2024 05:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717736622; cv=none; b=gZn922jk8o8w0w8wHE/yJxU2qETna5sDJI6HlQTSksS37SsGxcc+OqOWK4gZXe9PeDuuOo1ifOQShSONc2451R/fWP7DYXKV+vvjEUUPHv5Ma8zh8aYbNlhe7oawKtdrgjroDVNXi0Ur4MYq8eYZWXmLlDNllYpwMVu8xwWMTVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717736622; c=relaxed/simple;
	bh=aUYzpSZGY3TaaFu5m3ql2sMizBS7fvFJugEmGfXg2LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1Brzz9ly295CuVBQUNQo6KVTwRSWEmRKlsFjEu+WAXCGuIVNNeGp+OKb0zhFd8m2/y/9sIxzRg+RKX+T7Ru20V1C34280NM8BqiUcUx8ka9N4E3fXda97V5XCaYhbP4cwmefHq9XG3+ANOwfLUxCC6c1fSL1WftK5tTw92I6l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3L5H+p8b; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=t6XUBFY7DDkBX59kO/X1i0VzKzPBvUpCW3krMAMbCqE=; b=3L5H+p8bNwtH1Ds4X1s1esi8GI
	F/XbLP4MsCreTAAhfI1hnYE6tr1kAnKVhAJH3v9xHdRaOTqLAC2AgleKeLdayCk7oiGO1nCSgYh/g
	5LMj+BpUXSTJK2vFAGtGERXfFjDjmAt00JyB82SuOKKAngugkqC9oyPSMhcDPuqdtNvFB8ZWoQE6Y
	KvnYe/NF3uJe77mJ7MbDCc3IYOUpmBc9+h8Bw65NlGCVZXn/Yj5KW4VTwRySfqdoV9NyZvtspuyim
	qT+rLyKuU498q/EkXwr/cm4fsa4t+9nArSeb0c652PWps5lUeS/nO1677S8Rrz6rIgYqO3Od6jmDQ
	9XoXG+0Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFRlF-0000000CRj6-36hl;
	Fri, 07 Jun 2024 05:03:33 +0000
Date: Thu, 6 Jun 2024 22:03:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Martin Oliveira <martin.oliveira@eideticom.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-mm@kvack.org,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, Tejun Heo <tj@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Valentine Sinitsyn <valesini@yandex-team.ru>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 1/6] kernfs: create vm_operations_struct without
 page_mkwrite()
Message-ID: <ZmKUpXQmMLpH8vf5@infradead.org>
References: <20240605192934.742369-1-martin.oliveira@eideticom.com>
 <20240605192934.742369-2-martin.oliveira@eideticom.com>
 <2024060658-ember-unblessed-4c74@gregkh>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024060658-ember-unblessed-4c74@gregkh>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jun 06, 2024 at 10:54:06PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jun 05, 2024 at 01:29:29PM -0600, Martin Oliveira wrote:
> > The standard kernfs vm_ops installs a page_mkwrite() operator which
> > modifies the file update time on write.
> > 
> > This not always required (or makes sense), such as in the P2PDMA, which
> > uses the sysfs file as an allocator from userspace.
> 
> That's not a good idea, please don't do that.  sysfs binary files are
> "pass through", why would you want to use this as an allocator?

I think the real question is why sysfs binary files implement
page_mkwrite by default.  page_mkwrite is needed for file systems that
need to allocate space from a free space pool, which seems odd for
sysfs.

