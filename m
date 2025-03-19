Return-Path: <linux-rdma+bounces-8808-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E864A68675
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 09:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0983C178BC0
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 08:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B022505CE;
	Wed, 19 Mar 2025 08:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHfI3kGz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A71720C46B;
	Wed, 19 Mar 2025 08:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372061; cv=none; b=kLE6RmgStHIjh+tUalrnxB9lXTkUsVL8oPK0OdZVcorg2/wbuuDLx280dpVpoo0CdlB1OpXq/W+ny73K2UhhzTTE6iEpxiw9Pnc6pEiXhVfV4BEQ0npl4KEdJnYEoIkGRWHvZM0rzIl+XUizbuA0fOR82oKwBkr1wtEpr+ukIR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372061; c=relaxed/simple;
	bh=ViOjQcPrdThusEfVI9+zUSE7Ys40h43nRiiim9Jk2SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtE2V4Ns5PR+Pkkf7ueV/zYh954UL25vr5UjtA7yb+GkIBka7cA1SbP8tLEHuooQVu7wbkAEN6kgkKoYUVSel8pKno3l+GwDdQClTmDFB5xArTFVxWK/TSTiRvD5qyj+QUEuvbo5KiFtaUUTJnbC7bfPX6fOBNaeIl4AjatTj5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHfI3kGz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546D2C4CEE9;
	Wed, 19 Mar 2025 08:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742372061;
	bh=ViOjQcPrdThusEfVI9+zUSE7Ys40h43nRiiim9Jk2SE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JHfI3kGzcFamkD+KUuXJP1L9EcCzuaz6b951lGEjbzlrMD7fEvT6WoKXUe9HCD1+p
	 YvknrSjlySYsF72xxuGP2/CQLKCRIJD+XwV6FLr3cui/pjcgK/S8Poifg+kPbmmz5S
	 Weqk6ThfLyskhUjlVF8ANMQLVS/0KfuLsH5OxjtIcUVke3Pq+CQKgYH/jctFC0z2jr
	 VDtHtFiGr3tF3Tt91G9BhHl6CsKRig41NbQQK1duaMaKfI88gMuNG+O1mKbgnL8P6m
	 wWVTFRxzcsR+pMamj9BCsSHW0VWRRXG+SzA9wvylN2xgoJ90VVb0gFwmNs3h9Q883Y
	 009bj84Rd8Jkw==
Date: Wed, 19 Mar 2025 10:14:16 +0200
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
Message-ID: <20250319081416.GE1322339@unreal>
References: <54781c0c-a1e7-4e97-acf1-1fc5a2ee548c@amd.com>
 <d0e95c47-c812-4aa8-812f-f5d7f6abbbb1@intel.com>
 <20250317123333.GB9311@nvidia.com>
 <1eae139c-f678-4b28-a466-5c47967b5d13@kernel.org>
 <CO1PR11MB5089AB36220DFEACBF7A5D1CD6DF2@CO1PR11MB5089.namprd11.prod.outlook.com>
 <2025031840-phrasing-rink-c7bb@gregkh>
 <20250318132528.GR9311@nvidia.com>
 <9e3019af-7817-49db-a293-3242e2962c22@intel.com>
 <2025031836-monastery-imaginary-7f5e@gregkh>
 <95da9782-7c46-4ddc-8d7e-ffb3db31ebc3@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95da9782-7c46-4ddc-8d7e-ffb3db31ebc3@intel.com>

On Wed, Mar 19, 2025 at 06:48:48AM +0100, Przemek Kitszel wrote:
> On 3/18/25 17:06, Greg Kroah-Hartman wrote:
> > On Tue, Mar 18, 2025 at 08:39:50AM -0700, Dave Jiang wrote:
> > > 
> > > 
> > > On 3/18/25 6:25 AM, Jason Gunthorpe wrote:
> > > > On Tue, Mar 18, 2025 at 02:20:45PM +0100, Greg Kroah-Hartman wrote:
> > > > 
> > > > > Yes, note, the issue came up in the 2.5.x kernel days, _WAY_ before we
> > > > > had git, so this wasn't a git issue.  I'm all for "drivers/core/" but
> > > > > note, that really looks like "the driver core" area of the kernel, so
> > > > > maybe pick a different name?
> > > > 
> > > > Yeah, +1. We have lots of places calling what is in drivers/base 'core'.
> > > 
> > > just throwing in my 2c
> > > 
> > > drivers/main
> > 
> > Implies the "driver core"
> > 
> > > drivers/common
> > 
> > lib/ maybe?
> > 
> > > drivers/primary
> > 
> > It's not going to be the primary drivers for my laptop :)
> > 
> > Naming is hard.  Let's see some code first...
> > 
> > greg k-h
> > 
> 
> "platfrom" would also suggest a wider thing, so:
> "complex"?
> 
> anyway, I don't like fwctl, so maybe "fwctl" to at least reveal the real
> reason :P

We are discussing where to move XXX_core drivers which historically were
located in drivers/net/ethernet/XXX/, see this idea https://lore.kernel.org/all/20250211075553.GF17863@unreal/
FWCTL is unrelated to this discussion and you are not forced to use it
if you don't like it.

Thanks


