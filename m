Return-Path: <linux-rdma+bounces-8368-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07233A5035A
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 16:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4221889ED7
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 15:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862502505C3;
	Wed,  5 Mar 2025 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxeMFU4x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6642505A7;
	Wed,  5 Mar 2025 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741188171; cv=none; b=NSdSlryfri260iO/XyJhQ/n4yv9G1UuzkTZ83DmdBRfrYOIq7lA6+yIjzSaNL5Arw6E30VNgufd+Takb6ONVgb+JoOhAILsBkbwzXhP5y/alQAiAN3hrY2gqmgmxNVM/AhVRsPs8868hGfHatrJ4wTVQqEZDk7vaqTF54mk/3YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741188171; c=relaxed/simple;
	bh=7ARoV0mOCny+qdLm8BP8VvPVb1WxjpYf0oKN/uahM7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+yHdA8UWHlBVRRGfy8yu65Cv1ct7mnxjYNPf7CWycY8e2wjAA+wOuxATLKG+66CT44TpQCyRNnEj5ftNQ4ibgKjb8+mbKldVGQgL/hnc+JPePND7SWeSygEon0PejzEI6nqsPmNa+RFcXyFm4ruzn58LI86sW20hV7LB9fUu54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxeMFU4x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE6CC4CEE0;
	Wed,  5 Mar 2025 15:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741188171;
	bh=7ARoV0mOCny+qdLm8BP8VvPVb1WxjpYf0oKN/uahM7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bxeMFU4xFAOlzjrDRB/Xevvr9QvieQ2JV6G3raREZIa1LHwkgPqxyqHJTEKtd7UOA
	 rDDwRzyxVCmtcsZwbvLca1BtTPz/54mLxfRJ1bnLS30ASy+CsKeDgkrVOPickaaTat
	 lRqL/9nyJR4VoAI13CBcgADARnNnxf4IKWL1v8bNQBiabzhHEq3IoMcdB0NXZ9QIGJ
	 LU2Rs4R0VpIKVAtZstN7MP7BDhSazSCh80orIwtExq5vKkVPACPPgDrQSTB9aaKMuM
	 DQcmur7tekh2kXncfJOjSz4f8y7vo+Y6cmjZWOxPJ+O9Jc4TJd7twd5SHfwtxUZujJ
	 pKPcVipxmCkqg==
Date: Wed, 5 Mar 2025 17:22:46 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Leonid Bloch <lbloch@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
Message-ID: <20250305152246.GM1955273@unreal>
References: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
 <20250303175358.4e9e0f78@kernel.org>
 <20250304140036.GK133783@nvidia.com>
 <20250304164203.38418211@kernel.org>
 <20250305133254.GV133783@nvidia.com>
 <mxw4ngjokr3vumdy5fp2wzxpocjkitputelmpaqo7ungxnhnxp@j4yn5tdz3ief>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mxw4ngjokr3vumdy5fp2wzxpocjkitputelmpaqo7ungxnhnxp@j4yn5tdz3ief>

On Wed, Mar 05, 2025 at 04:08:19PM +0100, Jiri Pirko wrote:
> Wed, Mar 05, 2025 at 02:32:54PM +0100, jgg@nvidia.com wrote:
> >On Tue, Mar 04, 2025 at 04:42:03PM -0800, Jakub Kicinski wrote:
> >> On Tue, 4 Mar 2025 10:00:36 -0400 Jason Gunthorpe wrote:
> >> > I never agreed to that formulation. I suggested that perhaps runtime
> >> > configurations where netdev is the only driver using the HW could be
> >> > disabled (ie a netdev exclusion, not a rdma inclusion).
> >> 
> >> I thought you were arguing that me opposing the addition was
> >> "maintainer overreach". As in me telling other parts of the kernel
> >> what is and isn't allowed. Do I not get a say what gets merged under
> >> drivers/net/ now?
> >
> >The PCI core drivers are a shared resource jointly maintained by all
> >the subsytems that use them. They are maintained by their respective
> >maintainers. Saeed/etc in this case.
> >
> >It would be inappropriate for your preferences to supersede Saeed's
> >when he is a maintainer of the mlx5_core driver and fwctl. Please try
> >and get Saeed on board with your plan.
> >
> >If the placement under drivers/net makes this confusing then we can
> >certainly change the directory names.
> 
> According to how mlx5 driver is structured, and the rest of the advanced
> drivers in the same area are becoming as well, it would make sense to me
> to have mlx5 core in separate core directory, maintained directly by driver
> maintainer:
> drivers/core/mlx5/
> then each of the protocol auxiliary device lands in appropriate
> subsystem directory.

In my vision, the write access to that drivers/core/ will be given to all
relevant subsystem maintainers, so it will operate like shared branch, but
foe everyone.

It means that series for netdev that changes mlx5_core and netdev code
will be sent to netdev and applied by netdev maintainers. In similar
way, series which targets RDMA will be handled by RDMA crew.

It will allow us to make sure that every piece of code in shared
repository is actually used.

Thanks

