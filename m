Return-Path: <linux-rdma+bounces-7798-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 231F6A38BD9
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2025 20:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6CF416A3FB
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2025 19:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEC0233D8E;
	Mon, 17 Feb 2025 19:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X78Ycrin"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E24188587;
	Mon, 17 Feb 2025 19:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739818948; cv=none; b=QdalkCyxSwZjLH16r0NWQ/vS22bCEQce2koGXGj12RTY9q+ZCVAXuHtkgPHD9KEcUR9uwHL6JcbkUVuqtV8Byouq2Yp1j1M8rQwtIty92KDsW25WSJ9gxk8ft7stcQNEWX+oDx7jELgd2tgG4ea3JuqpR3mrK7bBk8sJ55Ha7rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739818948; c=relaxed/simple;
	bh=8feeCX8F0dISVge9lCOCz2KhWK3uuoj5HsZP7Hxh9tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MU/q4ChJ04w4zs43vv7U1/NMRbVlVNCWMBCYTf2Bx7fcRw9DrNHrja25DJtyXQJCrxm5gMaatvWJ54M7cJbjR2LxFnEouAe2xtMwl4kNwUurI+hyiLU9lJVvgWaTurZe7DDBGzUmwCbNcvM29KhE4NMKGntW9E6BwBjM3LDL7G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X78Ycrin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84ED4C4CED1;
	Mon, 17 Feb 2025 19:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739818948;
	bh=8feeCX8F0dISVge9lCOCz2KhWK3uuoj5HsZP7Hxh9tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X78Ycrin00wpwK6zeqygmhbVj4Y0FHS8OvkZWG895TG2oGHQRDIFXODCm0Ar5L8TW
	 eJWQYeZc4ynwf8R2frTjPckYuX7tk6Bm6kmVY+7onFJ/FsQaqlasbk58BBSjuz/sab
	 0wa4vcYFQ4VvgxqtnRr/mvBkdrXAuIei26BOUPWxBnkpVWmhT4aNMBWO4slfzraijv
	 0Eo/F7b0wGooW8uEJ7li5L0c0zq3GIhTy1cR28Q5oi9vUGz80h6goo8FyWx02XhQBA
	 ywcwo3D7bXD1yXgmSMi0DKp2slKCifxBORsE9Bt912eA5Qm7JsRoCocd5HAvlglCqL
	 33Olkm9ckSBdg==
Date: Mon, 17 Feb 2025 21:02:22 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Saeed Mahameed <saeed@kernel.org>,
	"Nelson, Shannon" <shannon.nelson@amd.com>,
	Jakub Kicinski <kuba@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Leonid Bloch <lbloch@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>
Subject: Re: [PATCH v4 10/10] bnxt: Create an auxiliary device for fwctl_bnxt
Message-ID: <20250217190222.GB69863@unreal>
References: <20250207073648.1f0bad47@kernel.org>
 <Z6ZsOMLq7tt3ijX_@x130>
 <20250207135111.6e4e10b9@kernel.org>
 <20250208011647.GH3660748@nvidia.com>
 <20250210170423.62a2f746@kernel.org>
 <20250211075553.GF17863@unreal>
 <b0395452-dc56-414d-950c-9d0c68cf0f4a@amd.com>
 <20250212132229.GG17863@unreal>
 <Z66WfMwNpVBeWLLq@x130>
 <ccdz4sq2dzclxhevnj4ecfbehgtbiiw4pxtwctvknjzlvp72fl@lvfpjzfekm6z>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccdz4sq2dzclxhevnj4ecfbehgtbiiw4pxtwctvknjzlvp72fl@lvfpjzfekm6z>

On Mon, Feb 17, 2025 at 01:49:12PM +0100, Jiri Pirko wrote:
> Fri, Feb 14, 2025 at 02:03:56AM +0100, saeed@kernel.org wrote:
> >On 12 Feb 15:22, Leon Romanovsky wrote:
> >> On Tue, Feb 11, 2025 at 10:36:37AM -0800, Nelson, Shannon wrote:
> >> > On 2/10/2025 11:55 PM, Leon Romanovsky wrote:
> >> > >
> >> > > On Mon, Feb 10, 2025 at 05:04:23PM -0800, Jakub Kicinski wrote:
> >> > > > On Fri, 7 Feb 2025 21:16:47 -0400 Jason Gunthorpe wrote:
> >> > > > > On Fri, Feb 07, 2025 at 01:51:11PM -0800, Jakub Kicinski wrote:
> >> > > > >
> >> > > > > > But if you agree the netdev doesn't need it seems like a fairly
> >> > > > > > straightforward way to unblock your progress.
> >> > > > >
> >> > > > > I'm trying to understand what you are suggesting here.
> >> > > > >
> >> > > > > We have many scenarios where mlx5_core spawns all kinds of different
> >> > > > > devices, including recovery cases where there is no networking at all
> >> > > > > and only fwctl. So we can't just discard the aux dev or mlx5_core
> >> > > > > triggered setup without breaking scenarios.
> >> > > > >
> >> > > > > However, you seem to be suggesting that netdev-only configurations (ie
> >> > > > > netdev loaded but no rdma loaded) should disable fwctl. Is that the
> >> > > > > case? All else would remain the same. It is very ugly but I could see
> >> > > > > a technical path to do it, and would consider it if that brings peace.
> >> > > >
> >> > > > Yes, when RDMA driver is not loaded there should be no access to fwctl.
> >> > >
> >> > > There are users mentioned in cover letter, which need FWCTL without RDMA.
> >> > > https://lore.kernel.org/all/0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com/
> >> > >
> >> > > I want to suggest something different. What about to move all XXX_core
> >> > > logic (mlx5_core, bnxt_core, e.t.c.) from netdev to some other dedicated
> >> > > place?
> >> > >
> >> > > There is no technical need to have PCI/FW logic inside networking stack.
> >> > >
> >> > > Thanks
> >> > 
> >> > Our pds_core device fits this description as well: it is not an ethernet PCI
> >> > device, but helps manage the FW/HW for Eth and other things that are
> >> > separate PCI functions.  We ended up in the netdev arena because we first
> >> > went in as a support for vDPA VFs.
> >> > 
> >> > Should these 'core' devices live in linux-pci land?  Is it possible that
> >> > some 'core' things might be platform devices rather than PCI?
> >> 
> >> IMHO, linux-pci was right place before FWCTL and auxbus arrived, but now
> >> these core drivers can be placed in drivers/fwctl instead. It will be natural
> >+1
> >
> >Fwctl subsystem is perfect for shared modules that need to initialize the
> >pci device to a minimal state where fwctl uAPIs are enabled for debug and
> >bare metal device configs while aux sunsystem can carry out the
> >spawning of other subsystems.
> 
> Wouldn't it be better to call it drivers/core/ and have corectl or
> corefwctl ?

Before names, let's first agree that this is the right thing to do.
I'm fine with any proposed name.

Thanks

> 
> >
> >> place for them as they will be located near the UAPI which provides an access
> >> to them.
> >> 
> >> All other components will be auxbus devices in their respective
> >> subsystems (eth, RDMA ...).
> >> 
> >> Thanks
> >> 
> >> > 
> >> > sln
> >> > 
> >> > 
> >> 
> >
> 

