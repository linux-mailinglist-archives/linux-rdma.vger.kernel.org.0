Return-Path: <linux-rdma+bounces-2961-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A62D8FF61A
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 22:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D805C1F26C90
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 20:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746B312BE9F;
	Thu,  6 Jun 2024 20:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A6kyP1N4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E7B6F06E;
	Thu,  6 Jun 2024 20:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717707249; cv=none; b=muizLf7rpNZoT3jwdVC0lzFlPt3LwwUVp2FTpfVP977F5SeXWFxaKACp1RKPZZtNIMX529oIdCLgiLcJBYnhuKGR86glxA3ERrhj93McoN9w7Il7aYuZNb8LjJRcXza/0A276kRMwqPFodLG1w2K3aDFznqs2s/6lCcABl/Fg2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717707249; c=relaxed/simple;
	bh=UqeI96+MM5X3pqwCptXH2eQJ3yuc1OFxEnYiSX/y3zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OThTK7TeDfB4FDEef+Pq4zdCh0CoNe++cWG0bzYJFMCdbGf9WkY6LS3fljVegBAXcHL8Js1ICIr6HxFd+Mz1WfeqkGidY/73hTKHODIJcFD0A4B8/th/MpLyE8P43+RWSM36gRr/XI1cTzqL4ILyKwEP6GY1ad2SUtC3PsBY/mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A6kyP1N4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59061C2BD10;
	Thu,  6 Jun 2024 20:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717707248;
	bh=UqeI96+MM5X3pqwCptXH2eQJ3yuc1OFxEnYiSX/y3zc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A6kyP1N4dXj3GzUHpLannf6y6D/DZdpilO3+TVH+Fi8roM8Aj39obTruHOHQheVuo
	 UJwXzYsvbA9zFqU5zAV9iT651Za7HI5PQpS0joWloWlz6gfYZXd5/Xg1juzOG9Jn4T
	 4c7WbLPv3KG8D/bcooMr+zVEgBpvvB94WvCxd0eE=
Date: Thu, 6 Jun 2024 22:54:06 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Martin Oliveira <martin.oliveira@eideticom.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Message-ID: <2024060658-ember-unblessed-4c74@gregkh>
References: <20240605192934.742369-1-martin.oliveira@eideticom.com>
 <20240605192934.742369-2-martin.oliveira@eideticom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605192934.742369-2-martin.oliveira@eideticom.com>

On Wed, Jun 05, 2024 at 01:29:29PM -0600, Martin Oliveira wrote:
> The standard kernfs vm_ops installs a page_mkwrite() operator which
> modifies the file update time on write.
> 
> This not always required (or makes sense), such as in the P2PDMA, which
> uses the sysfs file as an allocator from userspace.

That's not a good idea, please don't do that.  sysfs binary files are
"pass through", why would you want to use this as an allocator?

> Furthermore, having the page_mkwrite() operator causes
> writable_file_mapping_allowed() to fail due to
> vma_needs_dirty_tracking() on the gup flow, which is a pre-requisite for
> enabling P2PDMA over RDMA.
> 
> Fix this by adding a new boolean on kernfs_ops to differentiate between
> the different behaviours.

This isn't going to work well.

What exactly are you wanting to do in sysfs that you feel this is
required?

thanks,

greg k-h

