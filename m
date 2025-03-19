Return-Path: <linux-rdma+bounces-8820-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF6DA68B85
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 12:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 339D1188431A
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 11:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B240A25525D;
	Wed, 19 Mar 2025 11:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdU0PMCg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B185254B0B;
	Wed, 19 Mar 2025 11:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383357; cv=none; b=GV+fAYU6IAVyGgnljxyBR4ZiJyMgiMj555KzygW6y6vH93TYhRPD80CbRFGJ+FITr/PvRwQJgAV42B8kIKQyxj6Ma4zVoCUPb8sT9SdZHNhsvplkFmrjspoFUmQStIXnGRxw2V/xLtAPAfdNQAOooFUBatJixb6KnK9BY8gTH60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383357; c=relaxed/simple;
	bh=cujdxR9tJsCSokcNg/S3qzmyatuAJjZjTxgqBQEZgyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCbzOyIF5FHMfEj2d83jdrxbTQ09iLnreulijWVsGlB+tet5SdigdCPPrDYSJ7dqd0/ZsQ7oUv9+gK/iezPcCH9pLQO6Yj/JInkESaTa1GLyhzI0dT9WH9vJmTZKnDuX2iBKRf+0+XFiuTXWc/w5LgrOrhV6TQG2QmcnlYEDdGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdU0PMCg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59677C4CEE9;
	Wed, 19 Mar 2025 11:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742383356;
	bh=cujdxR9tJsCSokcNg/S3qzmyatuAJjZjTxgqBQEZgyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jdU0PMCgpKLfQYoamDe5ixeQMmUrEWrK9eWydFxaOWC8v4dghVVk3h1vfaP/f6Ow0
	 dB3IrvWCx1pCL7G0GA7VUVTfyODi3qhnkHJ/X73mMTe9bXCoYcRBH9KmcPSJx3ycJX
	 Yig1nCJ1ubVxRf4CgI9M7JS5eaUnqg4noQsd1qykbvciGNhwnl1T967UCk0nHbglzd
	 3lTraga9J1SkO1dZ7w1SOKa4xYB82RgJ17pDEe+WkK7EQgmt2/K3LJKpd0vpNPyQVE
	 h6CwNtqKrMakGN7Qv/xFBzEafXqOIG2jG7fwhWanQIJQjFtvlH6e9XycW9cfpr4bjL
	 J6Oyzgva0YijQ==
Date: Wed, 19 Mar 2025 13:22:32 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Dave Jiang <dave.jiang@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>,
	David Ahern <dsahern@kernel.org>,
	"Nelson, Shannon" <shannon.nelson@amd.com>,
	Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>,
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
Message-ID: <20250319112232.GJ1322339@unreal>
References: <20250317123333.GB9311@nvidia.com>
 <1eae139c-f678-4b28-a466-5c47967b5d13@kernel.org>
 <CO1PR11MB5089AB36220DFEACBF7A5D1CD6DF2@CO1PR11MB5089.namprd11.prod.outlook.com>
 <2025031840-phrasing-rink-c7bb@gregkh>
 <20250318132528.GR9311@nvidia.com>
 <9e3019af-7817-49db-a293-3242e2962c22@intel.com>
 <2025031836-monastery-imaginary-7f5e@gregkh>
 <95da9782-7c46-4ddc-8d7e-ffb3db31ebc3@intel.com>
 <20250319081416.GE1322339@unreal>
 <81005d10-15ae-4d85-bf67-9362a2169151@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81005d10-15ae-4d85-bf67-9362a2169151@intel.com>

On Wed, Mar 19, 2025 at 11:46:15AM +0100, Przemek Kitszel wrote:
> 
> > We are discussing where to move XXX_core drivers which historically were
> > located in drivers/net/ethernet/XXX/, see this idea https://lore.kernel.org/all/20250211075553.GF17863@unreal/
> 
> yes, I know
> 
> > FWCTL is unrelated to this discussion and
> 
> it is related,
> I see the move as a workaround for "netdev maintainer complains more
> than I would like", sorry :P

No, it is not. There is no technical reason to keep non-netdev code in
netdev subsystem. If you have an explanation why PCI-to-AUX, VDPA, VFIO
and RDMA logic MUST be under netdev subsystem, please speak it now.

Otherwise please keep brigading out of this discussion.

Thanks

