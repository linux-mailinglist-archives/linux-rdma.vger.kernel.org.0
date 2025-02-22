Return-Path: <linux-rdma+bounces-8009-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C9AA40AF1
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2025 19:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0D0019C18B0
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2025 18:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45F220B1E1;
	Sat, 22 Feb 2025 18:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVHJzVTG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E4C433A8;
	Sat, 22 Feb 2025 18:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740248778; cv=none; b=KzitAIKwJmMy8f0iZhb5aO6wCIGS/h5UWG7S1j10z8Co/0XCmzksKKtTcyC15+ph+VSVrappLoY+R7Vp4K3sY2WU0wouTW1R3P6FpI8upt7CZc4DoRCVn5HvahriZibwCgtXfKnGjtsj2ihKCw+uFEV8XsLvWISHJLz4wJIhzFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740248778; c=relaxed/simple;
	bh=qYJfd141m8+GrAfi283GiZ92nyulY8bsm7dQ5ckPxUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXONLCBiULG8uWtIKrSmxTy9ItJaU/wDY6OK351so0aVSiWzEkRU3KUIvzZiKWrlHdesTSkRCcmVyUtT9VV4aloWAgYwG9tNhxrzuTY5qjHN/pl7DHkVxCyeLn2if1zA6KIVc1o2W040IR+SVm/muNse0/vGYlM7XUZBFmwTqew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVHJzVTG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E90C4CED1;
	Sat, 22 Feb 2025 18:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740248778;
	bh=qYJfd141m8+GrAfi283GiZ92nyulY8bsm7dQ5ckPxUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RVHJzVTG/qXYzNFwdyjpxT64w+V9rbrlDZxTcn8yKDy2ECpSR/SQStCF4uopJaL5K
	 goSjP/DdQZUV37ncJ+Z2AbMCOUhewyGcxJ5h8cQoqkLdnn97ukStlNxkKCE2+AMYR+
	 1DReToJhw+sAVg1CO1AKiot5pRCkMqRl8xTwUH3MiBt9jMH4+FuEMWbQxyprYH3m/H
	 xstBHhuv+/uFU0szsoSthg3Zw8PnLbMAvTLfiX85LJ+tVHZsGblj3/CCxZOlfAbN3O
	 FsdGSv7/B1Bo/H5KJrWMNs6ZIMKJoJm6hn2idFCF8EwenoRkoehZx7x6h6bcOFZgFc
	 Qs4ZIhhaU58BQ==
Date: Sat, 22 Feb 2025 20:26:14 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "Nelson, Shannon" <shannon.nelson@amd.com>
Cc: jgg@nvidia.com, andrew.gospodarek@broadcom.com,
	aron.silverton@oracle.com, dan.j.williams@intel.com,
	daniel.vetter@ffwll.ch, dave.jiang@intel.com, dsahern@kernel.org,
	gospo@broadcom.com, hch@infradead.org, itayavr@nvidia.com,
	jiri@nvidia.com, Jonathan.Cameron@huawei.com, kuba@kernel.org,
	lbloch@nvidia.com, saeedm@nvidia.com, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	brett.creeley@amd.com
Subject: Re: [RFC PATCH fwctl 2/5] pds_core: add new fwctl auxilary_device
Message-ID: <20250222182614.GT53094@unreal>
References: <20250211234854.52277-1-shannon.nelson@amd.com>
 <20250211234854.52277-3-shannon.nelson@amd.com>
 <20250218192822.GA53094@unreal>
 <604b058d-88e8-436d-abf7-229a624d9386@amd.com>
 <20250219082405.GC53094@unreal>
 <6fc8dae5-9bfb-4b74-b741-b85159a0daef@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fc8dae5-9bfb-4b74-b741-b85159a0daef@amd.com>

On Thu, Feb 20, 2025 at 03:20:14PM -0800, Nelson, Shannon wrote:
> On 2/19/2025 12:24 AM, Leon Romanovsky wrote:
> > 
> > On Tue, Feb 18, 2025 at 12:00:52PM -0800, Nelson, Shannon wrote:
> > > On 2/18/2025 11:28 AM, Leon Romanovsky wrote:
> > > > 
> > > > On Tue, Feb 11, 2025 at 03:48:51PM -0800, Shannon Nelson wrote:
> > > > > Add support for a new fwctl-based auxiliary_device for creating a
> > > > > channel for fwctl support into the AMD/Pensando DSC.
> > > > > 
> > > > > Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> > > > > ---
> > > > >    drivers/net/ethernet/amd/pds_core/auxbus.c |  3 +--
> > > > >    drivers/net/ethernet/amd/pds_core/core.c   |  7 +++++++
> > > > >    drivers/net/ethernet/amd/pds_core/core.h   |  1 +
> > > > >    drivers/net/ethernet/amd/pds_core/main.c   | 10 ++++++++++
> > > > >    include/linux/pds/pds_common.h             |  2 ++
> > > > >    5 files changed, 21 insertions(+), 2 deletions(-)
> > > > 
> > > > <...>
> > > > 
> > > > My comment is only slightly related to the patch itself, but worth to
> > > > write it anyway.
> > > > 
> > > > > diff --git a/include/linux/pds/pds_common.h b/include/linux/pds/pds_common.h
> > > > > index 5802e1deef24..b193adbe7cc3 100644
> > > > > --- a/include/linux/pds/pds_common.h
> > > > > +++ b/include/linux/pds/pds_common.h
> > > > > @@ -29,6 +29,7 @@ enum pds_core_vif_types {
> > > > >         PDS_DEV_TYPE_ETH        = 3,
> > > > >         PDS_DEV_TYPE_RDMA       = 4,
> > > > >         PDS_DEV_TYPE_LM         = 5,
> > > > > +     PDS_DEV_TYPE_FWCTL      = 6,
> > > > 
> > > > This enum and defines below should be cleaned from unsupported types.
> > > > I don't see any code for RDMA, LM and ETH.
> > > > 
> > > > Thanks
> > > 
> > > I've looked at those a few times over the life of this code, but I continue
> > > to leave them there because they are part of the firmware interface
> > > definition, whether we use them or not.
> > 
> > How? You are passing some number which FW is not aware of it. You can
> > pass any number you want there. Even it is not true, you can
> > PDS_DEV_TYPE_FWCTL = 6 here, but remove rest of enums and *_STR defines.
> 
> When pds_core starts up it gets ident/config information from the firmware
> in a struct pds_core_dev_identity, which includes the vif_types[] array
> which tells us how many of each PDS_DEV_TYPE_xx are supported in the FW.
> This is indexed by enum pds_core_vif_types.

So just leave in the kernel, the PDS_DEV_TYPE_XXX which you support.

> 
> > 
> > > 
> > > You're right, there is no ETH or RDMA type code, they exist as historical
> > > artifacts of the early interface design.
> > 
> > This make me wonder why netdev merged this code which has nothing to do
> > with netdev subsystem at all.
> 
> The pds_core was originally brought in for supporting pds_vdpa and
> pds_vfio_pci.  At the time, it was essentially following the example of the
> mlx core module; at the time there wasn't any push back or suggestions of a
> different place to land.  Maybe further fwctl and "core" related discussions
> will suggest another approach.

The understanding of that "core" drivers don't belong to netdev was
always there.

Thanks

> 
> sln
> 
> > 
> > Thanks
> 
> 

