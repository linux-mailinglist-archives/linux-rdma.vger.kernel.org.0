Return-Path: <linux-rdma+bounces-7820-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6332A3B395
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 09:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9781896545
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 08:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0328D1BD9C7;
	Wed, 19 Feb 2025 08:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+lW5BTM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE15E42A93;
	Wed, 19 Feb 2025 08:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953450; cv=none; b=qbKmClz2zwH0zUCr1OJHabzYjr18yJ4SYvPXWbfUcTEVzUTZvR0a4h8UAncBZg8OljvIf3QoGpLyeasMk0AuKrpzsRujIcMud1B2doDCpGESPbr9/nh7UfgGsKh9zftgTmFWv7uLJInHk3BKZHCj5WG2EJE3UYckh0AXundCvL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953450; c=relaxed/simple;
	bh=95w7EDKsRDoPuqJHls8uz2vABQ/9pubYzApPmVZyK9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbkghH3FwUfVjBo297+eXtYnKJ10Ob+djzM7YL8cKDmmRKU9V0k5Q7otm+64b/VEtZRG+ox/ZvvSX1jxs5SfiVTLnQQvxMDSSXA+lP7r4aRBtAwjN7zD6bAP8wpfDPCHrf5iuofV2rHCqMw+LoKjChlLHP36t9csUEqniiwOU/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+lW5BTM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85824C4CED1;
	Wed, 19 Feb 2025 08:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739953450;
	bh=95w7EDKsRDoPuqJHls8uz2vABQ/9pubYzApPmVZyK9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S+lW5BTMOsXNLjh6MhoTEk1UwpgvNBdB+52zr5MEKW5pVwVOVlJsCU9zEHuYGfnas
	 KewSBy+Dmk/b0UcSa6ixr/u/MoB7tbbNk4lY+HdKIALro9wuHcbLVnqvYOAIfj1syz
	 SIWdNJCeVxw+7iRNFz16F4Cjoy927VyfOoOFfBtwqTy1iwyS/UbrAZPowhBkbuWxTC
	 IXWcxWL/t4EzeJSTaykBK4mLOHm3+QaeFG0qhxoSg2YNnjlM1+/QqOgDkovGiyKcnt
	 5ESXiU1hAPlfMQGvbDNQGnk27Dmy54KHuhljlAU34ATb51wbcUTktustIFMMoOb2je
	 RR1VJ3KRM/0NA==
Date: Wed, 19 Feb 2025 10:24:05 +0200
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
Message-ID: <20250219082405.GC53094@unreal>
References: <20250211234854.52277-1-shannon.nelson@amd.com>
 <20250211234854.52277-3-shannon.nelson@amd.com>
 <20250218192822.GA53094@unreal>
 <604b058d-88e8-436d-abf7-229a624d9386@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <604b058d-88e8-436d-abf7-229a624d9386@amd.com>

On Tue, Feb 18, 2025 at 12:00:52PM -0800, Nelson, Shannon wrote:
> On 2/18/2025 11:28 AM, Leon Romanovsky wrote:
> > 
> > On Tue, Feb 11, 2025 at 03:48:51PM -0800, Shannon Nelson wrote:
> > > Add support for a new fwctl-based auxiliary_device for creating a
> > > channel for fwctl support into the AMD/Pensando DSC.
> > > 
> > > Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> > > ---
> > >   drivers/net/ethernet/amd/pds_core/auxbus.c |  3 +--
> > >   drivers/net/ethernet/amd/pds_core/core.c   |  7 +++++++
> > >   drivers/net/ethernet/amd/pds_core/core.h   |  1 +
> > >   drivers/net/ethernet/amd/pds_core/main.c   | 10 ++++++++++
> > >   include/linux/pds/pds_common.h             |  2 ++
> > >   5 files changed, 21 insertions(+), 2 deletions(-)
> > 
> > <...>
> > 
> > My comment is only slightly related to the patch itself, but worth to
> > write it anyway.
> > 
> > > diff --git a/include/linux/pds/pds_common.h b/include/linux/pds/pds_common.h
> > > index 5802e1deef24..b193adbe7cc3 100644
> > > --- a/include/linux/pds/pds_common.h
> > > +++ b/include/linux/pds/pds_common.h
> > > @@ -29,6 +29,7 @@ enum pds_core_vif_types {
> > >        PDS_DEV_TYPE_ETH        = 3,
> > >        PDS_DEV_TYPE_RDMA       = 4,
> > >        PDS_DEV_TYPE_LM         = 5,
> > > +     PDS_DEV_TYPE_FWCTL      = 6,
> > 
> > This enum and defines below should be cleaned from unsupported types.
> > I don't see any code for RDMA, LM and ETH.
> > 
> > Thanks
> 
> I've looked at those a few times over the life of this code, but I continue
> to leave them there because they are part of the firmware interface
> definition, whether we use them or not.

How? You are passing some number which FW is not aware of it. You can
pass any number you want there. Even it is not true, you can
PDS_DEV_TYPE_FWCTL = 6 here, but remove rest of enums and *_STR defines.

> 
> You're right, there is no ETH or RDMA type code, they exist as historical
> artifacts of the early interface design.

This make me wonder why netdev merged this code which has nothing to do
with netdev subsystem at all.

Thanks

