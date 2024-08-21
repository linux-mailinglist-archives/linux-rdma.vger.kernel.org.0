Return-Path: <linux-rdma+bounces-4475-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7EE95A85D
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2024 01:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A16F1C20E7F
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 23:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F46E17D358;
	Wed, 21 Aug 2024 23:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ELN4COzv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E3717D354;
	Wed, 21 Aug 2024 23:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724283323; cv=none; b=f/2Zwm+iiWmDenljWbomDiIkK4FES2IKWD69CyjWZir4srXOsjLr6JEszUxxHFdpk6hNuIH87F91gNGX8ONOELAdYGWCzPNEE1N7CVdl18eaCAJu0Bep5AdVTDNsaO8WRRB6D/henFNIm0im8MeSEM0FFGEzCeFSql2VDMBGum0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724283323; c=relaxed/simple;
	bh=3xWr65f/8UFK4AztTZVns9baOkOUll4BHku8VlE4qSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeQutswhUL0pkUCl63lBNZquQEjOmWqeaNHZ+Fp/6A9f1mK4Yv+IdhypS1nz1kpP1Col+FFUl2MQstf+S9zqCfuGBlTYgEO1MUJ4uF4JP7BdO+b9diDkWelRzNEtPidjmUxw25KGFZkMuxvZaRG67FvtoRkyOzXoahMSAB4EjNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ELN4COzv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5818C32781;
	Wed, 21 Aug 2024 23:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724283323;
	bh=3xWr65f/8UFK4AztTZVns9baOkOUll4BHku8VlE4qSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ELN4COzvQx0wZlikCG0QUDKvBebwEA5SHeYMd6HXEbf4d6QoJMLx03QR8oIaMR1+p
	 o7yVCPI08r9yqdHjvK7pkBLRPD36sgJr68Vf+4dQIevSbI5ipTuuCik0lJU4htPL66
	 YgAWiQT8hus03sdYgrQC+jZWFSYPUHHESt22hfK0=
Date: Thu, 22 Aug 2024 07:35:20 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH v3 04/10] taint: Add TAINT_FWCTL
Message-ID: <2024082226-unbent-clarify-564c@gregkh>
References: <0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
 <4-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>

On Wed, Aug 21, 2024 at 03:10:56PM -0300, Jason Gunthorpe wrote:
> Requesting a fwctl scope of access that includes mutating device debug
> data will cause the kernel to be tainted. Changing the device operation
> through things in the debug scope may cause the device to malfunction in
> undefined ways. This should be reflected in the TAINT flags to help any
> debuggers understand that something has been done.

I know naming is hard, but the word "fwctl" is rough, don't you think?
It's become much more than just a random driver in the kernel tree, it's
now a taint flag and is exposed to userspace.  So I think you need to
rename it to something that is at least pronouncable when talking about
it (i.e. something with vowels...)

There's no need to keep it in 8 or less characters, this isn't the
1970's anymore, we have enough room for everyone to spell things out
now. :)

thanks,

greg k-h

