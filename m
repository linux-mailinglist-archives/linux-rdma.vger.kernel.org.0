Return-Path: <linux-rdma+bounces-8789-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2CEA678BA
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 17:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5601217C05D
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 16:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E6220FABA;
	Tue, 18 Mar 2025 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s3XKkAO+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270B420B1E1;
	Tue, 18 Mar 2025 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314056; cv=none; b=JsoW3eMOnoVfzMTRpHW9EpI+7dpb8tUkrF96Xs9LLA8+oDWfc5uzzNgKoLmRgDlGtFVJTaVo+HtLKcu8KDxtGYtJ7fsw954Z1eET532OxbiSNuClI1RBXaAf/vrBRHpcLkoUs6GkV/7jkwU//yzg2NhGHxfZkL3U+RlC0I2NDvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314056; c=relaxed/simple;
	bh=xzbL2Vk3RuWSOaBf8aMKsNbb3lDjQ0mzGl/IwHJ1YNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfryEsDdhRxBOxqpNxomqcy3UPDiMOptdLTcmao9UDNvv6QWo/xo1IWS4NbewRROV9Ck4hJnWjWo+YV5g6lnWwmUvB7CB3u0afkHlzxcgS/Yk/Do7gvaN0JHRP4kGCQWuNJ/P+pcePnTIifdva1bmyAwVIHRtRGGgGIKNPUCNIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s3XKkAO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF2BC4CEE3;
	Tue, 18 Mar 2025 16:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742314055;
	bh=xzbL2Vk3RuWSOaBf8aMKsNbb3lDjQ0mzGl/IwHJ1YNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s3XKkAO+S1S90H9Doa+MAZ4fbkJZ/t4tCb7a06lWM6MEKeB4rBmJh9q+T5vcLTBzd
	 QxQ4XuP2jmTyBW4Fz1K37XnUdBIxUZzvbv7jo607a1UjHrVdTaNd5XVBVFc+BnngnU
	 7KcFwOe6nfph5Dq1SSEaCB6WElcFL1agmpKHjJpI=
Date: Tue, 18 Mar 2025 17:06:17 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>,
	David Ahern <dsahern@kernel.org>,
	"Nelson, Shannon" <shannon.nelson@amd.com>,
	Leon Romanovsky <leon@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Sinyuk, Konstantin" <konstantin.sinyuk@intel.com>
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
Message-ID: <2025031836-monastery-imaginary-7f5e@gregkh>
References: <dc72c6fe-4998-4dba-9442-73ded86470f5@kernel.org>
 <20250313124847.GM1322339@unreal>
 <54781c0c-a1e7-4e97-acf1-1fc5a2ee548c@amd.com>
 <d0e95c47-c812-4aa8-812f-f5d7f6abbbb1@intel.com>
 <20250317123333.GB9311@nvidia.com>
 <1eae139c-f678-4b28-a466-5c47967b5d13@kernel.org>
 <CO1PR11MB5089AB36220DFEACBF7A5D1CD6DF2@CO1PR11MB5089.namprd11.prod.outlook.com>
 <2025031840-phrasing-rink-c7bb@gregkh>
 <20250318132528.GR9311@nvidia.com>
 <9e3019af-7817-49db-a293-3242e2962c22@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e3019af-7817-49db-a293-3242e2962c22@intel.com>

On Tue, Mar 18, 2025 at 08:39:50AM -0700, Dave Jiang wrote:
> 
> 
> On 3/18/25 6:25 AM, Jason Gunthorpe wrote:
> > On Tue, Mar 18, 2025 at 02:20:45PM +0100, Greg Kroah-Hartman wrote:
> > 
> >> Yes, note, the issue came up in the 2.5.x kernel days, _WAY_ before we
> >> had git, so this wasn't a git issue.  I'm all for "drivers/core/" but
> >> note, that really looks like "the driver core" area of the kernel, so
> >> maybe pick a different name?
> > 
> > Yeah, +1. We have lots of places calling what is in drivers/base 'core'.
> 
> just throwing in my 2c
> 
> drivers/main

Implies the "driver core"

> drivers/common

lib/ maybe?

> drivers/primary

It's not going to be the primary drivers for my laptop :)

Naming is hard.  Let's see some code first...

greg k-h

