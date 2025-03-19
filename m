Return-Path: <linux-rdma+bounces-8809-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D96CAA68680
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 09:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC1137A4094
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 08:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E7924E01E;
	Wed, 19 Mar 2025 08:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTWQbU7l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0913242A93;
	Wed, 19 Mar 2025 08:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372230; cv=none; b=Ck0rDGBwnHIMgKlwIE1nV7whF8NKkbvNSFK2TdlLuKj5EYsI2cUUkkhvASl1J/U9raw/sSNJLr+n6zF/2burA76n2A2rr21YvnIYiNyfrGSTC+5eIn8Kwuli2Mzoo0y83DS58XFF/TeahoKD8B2jDDQEqTRkTg4TeIIxoIS0SG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372230; c=relaxed/simple;
	bh=CNBPnFg8+WJfXuiHTuQ9PmtoNYVlC/qxt+ljvKbbvu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9b/ygpbRjC86Ue9Xpr1I2G2oN5p5HTI4yutS2JuWy3vo/QYu5dunrso6pTd4pPVqfmHq4d7Tmu10qFzeMvArRgtGw5kDrmgGmzmESm+9CkC2A7ZNjh7Ktnv6DKuyvZK4L475T0ueB5yOIEXJWX929ZdyIY8KCNNA2rkfpLDHCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTWQbU7l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E23C4CEF2;
	Wed, 19 Mar 2025 08:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742372229;
	bh=CNBPnFg8+WJfXuiHTuQ9PmtoNYVlC/qxt+ljvKbbvu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YTWQbU7lf68nAKkCHaqwEkr8uZMhORPYZ3GslyMaXNBBhOxLfkYM7DDPiDtvFE1LA
	 bgZST/cL7XZRfDUr2i+SF3yXDBkEhCidC6okKsFW3wzZ2cB+gz2F3L6kyXMF/45vWy
	 2WoNbIDvWq2BGjYEgQMyYFBUu7CLRLOZ+S67ao8n/WY7G7L+hylp2d0zJ6pz/X2cqv
	 Lmfr2pHPpPkllXxPMxjA9WzhtQomS5zPlr7vRDz+DmQP605E2Tvbv9VZPCBeM93d8M
	 +d2doCfLAO4ChIedP/v1bH6IidN2ehQe6Cp3mvWSmqOWMSqmuiTAt6y80klQMXzDHD
	 tS3+tKjS8wDNg==
Date: Wed, 19 Mar 2025 10:17:04 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dave Jiang <dave.jiang@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
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
Message-ID: <20250319081704.GF1322339@unreal>
References: <20250313124847.GM1322339@unreal>
 <54781c0c-a1e7-4e97-acf1-1fc5a2ee548c@amd.com>
 <d0e95c47-c812-4aa8-812f-f5d7f6abbbb1@intel.com>
 <20250317123333.GB9311@nvidia.com>
 <1eae139c-f678-4b28-a466-5c47967b5d13@kernel.org>
 <CO1PR11MB5089AB36220DFEACBF7A5D1CD6DF2@CO1PR11MB5089.namprd11.prod.outlook.com>
 <2025031840-phrasing-rink-c7bb@gregkh>
 <20250318132528.GR9311@nvidia.com>
 <9e3019af-7817-49db-a293-3242e2962c22@intel.com>
 <2025031836-monastery-imaginary-7f5e@gregkh>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025031836-monastery-imaginary-7f5e@gregkh>

On Tue, Mar 18, 2025 at 05:06:17PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Mar 18, 2025 at 08:39:50AM -0700, Dave Jiang wrote:
> > 
> > 
> > On 3/18/25 6:25 AM, Jason Gunthorpe wrote:
> > > On Tue, Mar 18, 2025 at 02:20:45PM +0100, Greg Kroah-Hartman wrote:
> > > 
> > >> Yes, note, the issue came up in the 2.5.x kernel days, _WAY_ before we
> > >> had git, so this wasn't a git issue.  I'm all for "drivers/core/" but
> > >> note, that really looks like "the driver core" area of the kernel, so
> > >> maybe pick a different name?
> > > 
> > > Yeah, +1. We have lots of places calling what is in drivers/base 'core'.
> > 
> > just throwing in my 2c
> > 
> > drivers/main
> 
> Implies the "driver core"
> 
> > drivers/common
> 
> lib/ maybe?
> 
> > drivers/primary
> 
> It's not going to be the primary drivers for my laptop :)
> 
> Naming is hard.  Let's see some code first...

Yes, let's do name contest later when code will come. There are multiple
companies already started to work on it and my hope that it will be ready
for next merge cycle.

Thanks

> 
> greg k-h

