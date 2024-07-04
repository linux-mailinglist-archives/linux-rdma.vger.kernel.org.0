Return-Path: <linux-rdma+bounces-3652-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6796927B72
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2024 18:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CCB81C210BB
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2024 16:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1FF1B372D;
	Thu,  4 Jul 2024 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Iz1Qx73x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25F71B29B3;
	Thu,  4 Jul 2024 16:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720111725; cv=none; b=ExQnzPPRqnVE04ciBM4BZANUiHhqjcTwoUXGgaJ4E/HH8GZx10A3eeZZVEYAnSTXQnpBV+61VI50VNcXTswMv1niFkGoFqTEjk78sB5qgksE0H0Fsl6+oHEx1YW6T1bwRcj37pO924+/7I0uRDSucYJuo51vJk56ONQUl8sfgG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720111725; c=relaxed/simple;
	bh=fws0HiGmamLZEZZjubszO9u8aqlHTHOAwe7LhWHHqWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXsi+1I91mFR3rOXLHMZD+k+EaJYdixylImsHdL/QOe7ZXefk0OxXRVooezx9bZvYfc78U7pR7/dDcXcOCg+z9+KAdRrXAq/rh6bRMUhartbNOKS5/PqFgGtkrrt0whVB0hetMI2v8vLuXYhoazaWQHVZ3N06M0CIGgVMZ+Npqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Iz1Qx73x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9551DC3277B;
	Thu,  4 Jul 2024 16:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720111725;
	bh=fws0HiGmamLZEZZjubszO9u8aqlHTHOAwe7LhWHHqWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iz1Qx73xmcMl1yR+IY4nIYNphQlCVh1WMzcNcBPEqtrbJPSqklaUJJbeIzn0jtSoz
	 zNM3MW1SeY/SzjMB8kSkXkPqFqjv1RVRS/BNEcEY117j89sf69i0IrsJqyeRK+3Fgu
	 DeSdr/iDtOWXvhhcqGHKYee8sHJCz3+2bVorgggo=
Date: Thu, 4 Jul 2024 18:48:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Martin Oliveira <martin.oliveira@eideticom.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-rdma@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Artemy Kovalyov <artemyko@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>, Tejun Heo <tj@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Sloan <david.sloan@eideticom.com>
Subject: Re: [PATCH v3 1/3] kernfs: remove page_mkwrite() from
 vm_operations_struct
Message-ID: <2024070435-powwow-steadier-de07@gregkh>
References: <20240704163724.2462161-1-martin.oliveira@eideticom.com>
 <20240704163724.2462161-2-martin.oliveira@eideticom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704163724.2462161-2-martin.oliveira@eideticom.com>

On Thu, Jul 04, 2024 at 10:37:22AM -0600, Martin Oliveira wrote:
> The .page_mkwrite operator of kernfs just calls file_update_time().
> This is the same behaviour that the fault code does if .page_mkwrite is
> not set.
> 
> Furthermore, having the page_mkwrite() operator causes
> writable_file_mapping_allowed() to fail due to
> vma_needs_dirty_tracking() on the gup flow, which is a pre-requisite for
> enabling P2PDMA over RDMA.
> 
> There are no users of .page_mkwrite and no known valid use cases, so
> just remove the .page_mkwrite from kernfs_ops and WARN_ON() if an mmap()
> implementation sets .page_mkwrite.
> 
> Co-developed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Martin Oliveira <martin.oliveira@eideticom.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

