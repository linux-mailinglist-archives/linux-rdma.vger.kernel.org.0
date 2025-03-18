Return-Path: <linux-rdma+bounces-8785-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 226E4A674DC
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 14:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECF2A7A6724
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 13:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082C720D4E6;
	Tue, 18 Mar 2025 13:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="scgWkin2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B222838DD1;
	Tue, 18 Mar 2025 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742304123; cv=none; b=pkyxp0eNQbAMqwVEUo0N2VwGKcG64DICmfh0k3nLlBI/I6FXgVXghQqxxuvu9lOT6KcRiRf1LSIqwyuH/Dv+LfPGk6iQIqMr+u+dJN5UcfyMvE1IlLc5sS0mT/H8MoE4g3Cmp1lgrCDVYe5ac5BEtWYgRBPtip1F2U/1C7rt9fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742304123; c=relaxed/simple;
	bh=fOS7iDxZOHk1sgoULcRxPlweKfANq7xiKpKVn+nE5RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9QL4FpkH56qNfu63xI8mmOckSdrKvnNJVoX86zuh5A1CmMB8XVz3t0t4NuAe9HFKyVv+95wjgcmpx2d3xc7/PMHuyAv5YAMP4I9fFBjJS5TuseVahPwsRxNf58UVcFDbNtylHz0i80C/Yu/2dbkFMNclbrPvlMyqiD6vmC182s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=scgWkin2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FAD2C4CEF1;
	Tue, 18 Mar 2025 13:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742304123;
	bh=fOS7iDxZOHk1sgoULcRxPlweKfANq7xiKpKVn+nE5RA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=scgWkin2QlN9YrIo/cNjwSpPCn64Yan7wPU1EUHcqKeawbmYYsriNBR1As2q2l4iq
	 Ei+n3uuhmBsIWq0CYZzneTba8QRk2UXPlzn0G3aqp533p3NqnONvrbQmxV6kBUiKuy
	 aoElyPGmmzp3RdQOlUeQq7g8zH9SC0/NQ0gFW4FA=
Date: Tue, 18 Mar 2025 14:20:45 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
Cc: David Ahern <dsahern@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>,
	Leon Romanovsky <leon@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	"Jiang, Dave" <dave.jiang@intel.com>,
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
Message-ID: <2025031840-phrasing-rink-c7bb@gregkh>
References: <mxw4ngjokr3vumdy5fp2wzxpocjkitputelmpaqo7ungxnhnxp@j4yn5tdz3ief>
 <bcafcf60-47a8-4faf-bea3-19cf0cbc4e08@kernel.org>
 <20250305182853.GO1955273@unreal>
 <dc72c6fe-4998-4dba-9442-73ded86470f5@kernel.org>
 <20250313124847.GM1322339@unreal>
 <54781c0c-a1e7-4e97-acf1-1fc5a2ee548c@amd.com>
 <d0e95c47-c812-4aa8-812f-f5d7f6abbbb1@intel.com>
 <20250317123333.GB9311@nvidia.com>
 <1eae139c-f678-4b28-a466-5c47967b5d13@kernel.org>
 <CO1PR11MB5089AB36220DFEACBF7A5D1CD6DF2@CO1PR11MB5089.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB5089AB36220DFEACBF7A5D1CD6DF2@CO1PR11MB5089.namprd11.prod.outlook.com>

On Mon, Mar 17, 2025 at 08:33:04PM +0000, Keller, Jacob E wrote:
> 
> 
> > -----Original Message-----
> > From: David Ahern <dsahern@kernel.org>
> > Sent: Monday, March 17, 2025 12:01 PM
> > To: Jason Gunthorpe <jgg@nvidia.com>; Keller, Jacob E
> > <jacob.e.keller@intel.com>
> > Cc: Nelson, Shannon <shannon.nelson@amd.com>; Leon Romanovsky
> > <leon@kernel.org>; Jiri Pirko <jiri@resnulli.us>; Jakub Kicinski
> > <kuba@kernel.org>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Andy
> > Gospodarek <andrew.gospodarek@broadcom.com>; Aron Silverton
> > <aron.silverton@oracle.com>; Williams, Dan J <dan.j.williams@intel.com>; Daniel
> > Vetter <daniel.vetter@ffwll.ch>; Jiang, Dave <dave.jiang@intel.com>; Christoph
> > Hellwig <hch@infradead.org>; Itay Avraham <itayavr@nvidia.com>; Jiri Pirko
> > <jiri@nvidia.com>; Jonathan Cameron <Jonathan.Cameron@huawei.com>;
> > Leonid Bloch <lbloch@nvidia.com>; linux-cxl@vger.kernel.org; linux-
> > rdma@vger.kernel.org; netdev@vger.kernel.org; Saeed Mahameed
> > <saeedm@nvidia.com>; Sinyuk, Konstantin <konstantin.sinyuk@intel.com>
> > Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
> > 
> > On 3/17/25 1:33 PM, Jason Gunthorpe wrote:
> > > On Fri, Mar 14, 2025 at 11:09:47AM -0700, Jacob Keller wrote:
> > >
> > >> I'd throw my hat in for drivers/core as well, I think it makes the most
> > >> sense and is the most subsystem neutral name. Hopefully any issue with
> > >> tooling can be solved relatively easily.
> > >
> > > Given Greg's point about core dump files sometimes being in .gitignore
> > > maybe "shared_core", or something along that path is a better name?
> > >
> > 
> > Not seeing the conflict on drivers/core:
> > 
> > $ find . -name .gitignore | xargs grep core
> > ./tools/testing/selftests/powerpc/ptrace/.gitignore:core-pkey
> > ./tools/testing/selftests/cgroup/.gitignore:test_core
> > ./tools/testing/selftests/mincore/.gitignore:mincore_selftest
> > ./arch/mips/crypto/.gitignore:poly1305-core.S
> > ./arch/arm/crypto/.gitignore:aesbs-core.S
> > ./arch/arm/crypto/.gitignore:sha256-core.S
> > ./arch/arm/crypto/.gitignore:sha512-core.S
> > ./arch/arm/crypto/.gitignore:poly1305-core.S
> > ./arch/arm64/crypto/.gitignore:sha256-core.S
> > ./arch/arm64/crypto/.gitignore:sha512-core.S
> > ./arch/arm64/crypto/.gitignore:poly1305-core.S
> 
> I would guess its people putting core in their own ignore lists, not necessarily what we commit to the kernel tree.

Yes, note, the issue came up in the 2.5.x kernel days, _WAY_ before we
had git, so this wasn't a git issue.  I'm all for "drivers/core/" but
note, that really looks like "the driver core" area of the kernel, so
maybe pick a different name?

Maybe drivers/lib/ as this is common stuff for a variety of different
drivers?  I don't know, naming is hard, sorry.  I've been defaulting to
just using dutch words for projects these days as they don't seem to be
used much.  Hey, that might work here, drivers/kern/ perhaps?  Nah...

thanks,

greg k-h

