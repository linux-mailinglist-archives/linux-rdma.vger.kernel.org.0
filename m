Return-Path: <linux-rdma+bounces-8401-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D442A543B2
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 08:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7A213AFF1F
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 07:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720DD1DDC18;
	Thu,  6 Mar 2025 07:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZF1LCtK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2894F1DC98B;
	Thu,  6 Mar 2025 07:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741246160; cv=none; b=HnYntg1vocZ0XwWnvP/7hJr6onrt3z8cspZVRWxl0dzFoz9v6KtCPnYxma425CeiTMDCkErvSr24LGRMeCJ2Xh6AWamiigDwt7hjX6SFDGKGpUGX6+ItFZvA+YqYms5xfQy8xEa2ICPlXrt+Px5WYzHKkf7pl5CFtB9KsGL7Jqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741246160; c=relaxed/simple;
	bh=ZNaVEPVAXCzdL9St42uwm7LoXpS2rX6afC6PTXfNAK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtUOYd2zcsNgWdU++8Ct7fiAPU7pGrWkxZlQM3uj3LktgeWQAt0j3Hr3HmQfQ0iiuaWpJ4P+xQboN+NhadzNtoKTqodfRXXELeB+Jxit69D2PFomu5ibXLkm/p8tZb22c4PSoTnvfyTKeRxUgheKYWI6d9lREDUTJZN2srpRSJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZF1LCtK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14202C4CEE0;
	Thu,  6 Mar 2025 07:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741246160;
	bh=ZNaVEPVAXCzdL9St42uwm7LoXpS2rX6afC6PTXfNAK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TZF1LCtKBFC9ylRr9B71V4vKBBglWxRMWez0za7qNmcMKiuAEKv/VUP08VrhxdLEI
	 SVkrpND+ODsVlh6oRfVzk1BewPHa4LdERkwhReCVDlQodjqVHs84GkWF7o1bYrkYjK
	 qETAhSIyM4Z9SmJjCbEp8qXXrMNt9s9HmYTHGeZQNAmy1k6+aLTiq24TmsOMHEa2Gk
	 aOsqbe9YFy614aR2KLScLPuI/SDDnybS0pw4I8yZXl4vb0u0PWZkGI+8pvL4+UBauU
	 r7U60zuyPZt2JYgW8Mbn5br2O9jbnBKCahp7DoD3b+gPcbTe3PukA6deUqq8/Jynqq
	 MoeA/fTtBGQvw==
Date: Thu, 6 Mar 2025 09:29:16 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Saeed Mahameed <saeed@kernel.org>, David Ahern <dsahern@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Leonid Bloch <lbloch@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
Message-ID: <20250306072916.GQ1955273@unreal>
References: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
 <20250303175358.4e9e0f78@kernel.org>
 <20250304140036.GK133783@nvidia.com>
 <20250304164203.38418211@kernel.org>
 <20250305133254.GV133783@nvidia.com>
 <mxw4ngjokr3vumdy5fp2wzxpocjkitputelmpaqo7ungxnhnxp@j4yn5tdz3ief>
 <bcafcf60-47a8-4faf-bea3-19cf0cbc4e08@kernel.org>
 <20250305182853.GO1955273@unreal>
 <Z8i2_9G86z14KbpB@x130>
 <20250305232154.GB354511@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305232154.GB354511@nvidia.com>

On Wed, Mar 05, 2025 at 07:21:54PM -0400, Jason Gunthorpe wrote:
> On Wed, Mar 05, 2025 at 12:41:35PM -0800, Saeed Mahameed wrote:
> 
> > How do you imagine this driver/core structure should look like? Who
> > will be the top dir maintainer?
> 
> I would set something like this up more like DRM. Every driver
> maintainer gets commit rights, some rules about no uAPIs, or at least
> other acks before merging uAPI. Use the tree for staging shared
> branches.
> 
> Driver maintainers with the most commits per cycle does the PR or
> something like that.
> 
> There is no subsystem or cross-driver entanglement so there is no real
> need for gatekeeping.

Yes, it can be structured like you proposed too or/and combined with my
idea https://lore.kernel.org/netdev/20250303150015.GA1926949@unreal/

The most important part is that it needs to be group of maintainers.

> 
> It would be a good opportunity to help more people engage with the
> kernel process and learn the full maintainer flow.
> 
> > It should be something that is tightly coupled with aux, currently
> > aux is under drivers/base/auxiliary.c I think it should move to
> > drivers/aux/auxiliary.c and device drivers should implement their
> > own aux buses, WH access APIs and probing/init logic under that
> > directory e.g: drivers/aux/mlx5/..
> 
> That makes sense to me. I would expect everything in this collection
> to be PCI drivers spawing aux devices.
> 
> drivers/aux_core/ or something like that, perhaps?

I like Saeed's proposal "drivers/aux/", it is more short and catchy.

Thanks

> 
> Jason
> 

