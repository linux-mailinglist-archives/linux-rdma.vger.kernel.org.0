Return-Path: <linux-rdma+bounces-2920-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 620AD8FD955
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 23:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E67C71F24C2C
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 21:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513F715F3FF;
	Wed,  5 Jun 2024 21:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBmwCejs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078081373;
	Wed,  5 Jun 2024 21:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717623825; cv=none; b=q3+He4rPj7lXgWvC/fnGmCvgigqeRMgI7qExCRQ7iiEs0Ak/BRJbSBE9Kwyd5WP7xPtggBrCCCneRVVvaRxyvaOy1eUOvy1t/IgSjfwLl2Av0S3qmhlCF8k9Wcjwss8FbVC1IKb9aZUP04xCIUQbTNafIJ4JY2wqnxfZr1kNzlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717623825; c=relaxed/simple;
	bh=aFVcd3geGR9oREiYgD4RepVhm5hzoZ0e1xsgwtZ3xEw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mrysDJB+hB8sEpCfru+SNVr2HzAVbP6Y9ypiv2lNpQAAvmy9/ZNROVCMQcLuMzqm5YDs7bRCQUtUIy8in7ONLagJZO9HTmuRKEIn1OpH5w4MjCm1SyUvrSGEiYFibD5Yg1bQz7ue2uzx5drePm4QRKYQpL3aZ2wnM6ty6pQGh6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBmwCejs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904ABC2BD11;
	Wed,  5 Jun 2024 21:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717623824;
	bh=aFVcd3geGR9oREiYgD4RepVhm5hzoZ0e1xsgwtZ3xEw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tBmwCejsGiyfz8GhEMM/IndBJanR8YLNfWrKeFEHMrJUPX9uFGMbTXvKhSM2N9bEj
	 T3RDKX8Z9a4+iQh1pnrALyE/u4xHgywxRjeRSD7kDqcCVl1bvgaT6KxyCQVr2oy0YQ
	 siRX7jpVZ89wLhWSg/dpeEGOlpFtOz708FZuatdJgKnfxiGN6CmsXv6aDHYPVAssV/
	 CE7CJBlnK7kSQzg9ZZgPAkcxbfI6mwlocsnZttS3wQJxY+vkW2eL7E5YTivdvdLS+r
	 +9nDx0YJ75qtco7aoWAi1VO0EmvPlwZy4wYivMmln5BBfsKs+7BOTO2WaD4goThKqw
	 /Rcp3PwNdWIyQ==
Date: Wed, 5 Jun 2024 16:43:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Martin Oliveira <martin.oliveira@eideticom.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-mm@kvack.org,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Valentine Sinitsyn <valesini@yandex-team.ru>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 1/6] kernfs: create vm_operations_struct without
 page_mkwrite()
Message-ID: <20240605214342.GA781723@bhelgaas>
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

s/This/This is/ ?

> uses the sysfs file as an allocator from userspace.
> 
> Furthermore, having the page_mkwrite() operator causes
> writable_file_mapping_allowed() to fail due to
> vma_needs_dirty_tracking() on the gup flow, which is a pre-requisite for
> enabling P2PDMA over RDMA.
> 
> Fix this by adding a new boolean on kernfs_ops to differentiate between
> the different behaviours.

> +	 * Use the file as an allocator from userspace. This disables
> +	 * page_mkwrite() to prevent the file time from being updated on write
> +	 * which enables using GUP with FOLL_LONGTERM with memory that's been
> +	 * mmaped.

"mmaped" does seem more commonly used in Linux than "mmapped", but the
base word "mapped" definitely requires "pp", so "mmaped" looks funny
to me.

