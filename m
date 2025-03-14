Return-Path: <linux-rdma+bounces-8708-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE57A61923
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 19:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6262C3B514E
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 18:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FF72045A2;
	Fri, 14 Mar 2025 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZ7zmc3U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECD01FAC34;
	Fri, 14 Mar 2025 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741975955; cv=none; b=Hfd/yLYOeEQRNGhioIO8g0dq+WYTqDi3hCXr0BhloVyxZBlTLBvnvAc5Jy9AvGoeifO8JvgFViut6FkzxWMvZziIQbhR/ez1jzaNkpe0UYbJG7OuLRk2s7jAX3UyaPPXniZ9n7oMdMyc9qVA0Q+HiB+dGVDaFxRJiNCEPxjRodc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741975955; c=relaxed/simple;
	bh=lhJDeX49+5aiNltJ7ikw4MoRh8myuWlXfEQi8+HVDNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2wmUM4Ya/1zA5yJe/M3kk7ZjybQrFWp8DMzSHVdOkXRoFnEwRYGreoxOc5P+0/Kv7DxduhD/yY5KjNscHjAtMSqrrMilQiwuh5fK3W+lRqdZZFH1fYQ1mPigbaa8W5APqqQWcYvQ+gWE1s/DA4UDBw6ifouZdGp6/p/N8k415Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZ7zmc3U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913F5C4CEE3;
	Fri, 14 Mar 2025 18:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741975955;
	bh=lhJDeX49+5aiNltJ7ikw4MoRh8myuWlXfEQi8+HVDNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZZ7zmc3UuUHq80xn+QmY6UGtc6zc8u26BpKN10Ds35Zu0b1OICd+uIteduEYFPqYq
	 4Pn9fFBa2MT/YyTPBL64M5TVEIm8EJT9+YN3ra5VEGEw65aAVFDNPZBsHTHEqk9LbI
	 yU6KUG8AcgkDhhebFPbgKrO9A45m0jFMcCs2TVD8mCSaYAXGA8V77G/5xIS+tlJRLO
	 GTN7xYkZeQFr4YxHrb4gCgrCwF/lPtqj/upERBNNqzhRngq8gIt8CKj7ecmMsd2gG5
	 Lvw3/XXnjZkZh36GP4JJi7PLSt3huGmE5iZFXwoLiW/ipStaGp06zE3mj+dw5tKkig
	 TvhOX0UW9LBDA==
Date: Fri, 14 Mar 2025 20:12:30 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: "Ertman, David M" <david.m.ertman@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [Intel-wired-lan] [iwl-next v4 1/1] iidc/ice/irdma: Update IDC
 to support multiple consumers
Message-ID: <20250314181230.GP1322339@unreal>
References: <20250225050428.2166-1-tatyana.e.nikolova@intel.com>
 <20250225050428.2166-2-tatyana.e.nikolova@intel.com>
 <20250225075530.GD53094@unreal>
 <IA1PR11MB61944C74491DECA111E84021DDC22@IA1PR11MB6194.namprd11.prod.outlook.com>
 <20250226185022.GM53094@unreal>
 <IA1PR11MB6194C8F265D13FE65EA006C2DDC22@IA1PR11MB6194.namprd11.prod.outlook.com>
 <20250302082623.GN53094@unreal>
 <07e75573-9fd0-4de1-ac44-1f6a5461a6b8@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07e75573-9fd0-4de1-ac44-1f6a5461a6b8@intel.com>

On Thu, Mar 13, 2025 at 04:38:39PM -0700, Samudrala, Sridhar wrote:
> 
> 
> On 3/2/2025 12:26 AM, Leon Romanovsky wrote:
> > On Wed, Feb 26, 2025 at 11:01:52PM +0000, Ertman, David M wrote:
> > > 
> > > 
> > > > -----Original Message-----
> > > > From: Leon Romanovsky <leon@kernel.org>
> > > > Sent: Wednesday, February 26, 2025 10:50 AM
> > > > To: Ertman, David M <david.m.ertman@intel.com>
> > > > Cc: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>; jgg@nvidia.com;
> > > > intel-wired-lan@lists.osuosl.org; linux-rdma@vger.kernel.org;
> > > > netdev@vger.kernel.org
> > > > Subject: Re: [iwl-next v4 1/1] iidc/ice/irdma: Update IDC to support multiple
> > > > consumers
> > > > 
> > > > On Wed, Feb 26, 2025 at 05:36:44PM +0000, Ertman, David M wrote:
> > > > > > -----Original Message-----
> > > > > > From: Leon Romanovsky <leon@kernel.org>
> > > > > > Sent: Monday, February 24, 2025 11:56 PM
> > > > > > To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
> > > > > > Cc: jgg@nvidia.com; intel-wired-lan@lists.osuosl.org; linux-
> > > > > > rdma@vger.kernel.org; netdev@vger.kernel.org; Ertman, David M
> > > > > > <david.m.ertman@intel.com>
> > > > > > Subject: Re: [iwl-next v4 1/1] iidc/ice/irdma: Update IDC to support
> > > > multiple
> > > > > > consumers
> > > > > > 
> > > > > > On Mon, Feb 24, 2025 at 11:04:28PM -0600, Tatyana Nikolova wrote:
> > > > > > > From: Dave Ertman <david.m.ertman@intel.com>
> > > > > > > 
> > > > > > > To support RDMA for E2000 product, the idpf driver will use the IDC
> > > > > > > interface with the irdma auxiliary driver, thus becoming a second
> > > > > > > consumer of it. This requires the IDC be updated to support multiple
> > > > > > > consumers. The use of exported symbols no longer makes sense
> > > > because it
> > > > > > > will require all core drivers (ice/idpf) that can interface with irdma
> > > > > > > auxiliary driver to be loaded even if hardware is not present for those
> > > > > > > drivers.
> > > > > > 
> > > > > > In auxiliary bus world, the code drivers (ice/idpf) need to created
> > > > > > auxiliary devices only if specific device present. That auxiliary device
> > > > > > will trigger the load of specific module (irdma in our case).
> > > > > > 
> > > > > > EXPORT_SYMBOL won't trigger load of irdma driver, but the opposite is
> > > > > > true, load of irdma will trigger load of ice/idpf drivers (depends on
> > > > > > their exported symbol).
> > > > > > 
> > > > > > > 
> > > > > > > To address this, implement an ops struct that will be universal set of
> > > > > > > naked function pointers that will be populated by each core driver for
> > > > > > > the irdma auxiliary driver to call.
> > > > > > 
> > > > > > No, we worked very hard to make proper HW discovery and driver
> > > > autoload,
> > > > > > let's not return back. For now, it is no-go.
> > > > > 
> > > > > Hi Leon,
> > > > > 
> > > > > I am a little confused about what the problem here is.  The main issue I pull
> > > > > from your response is: Removing exported symbols will stop ice/idpf from
> > > > > autoloading when irdma loads.  Is this correct or did I miss your point?
> > > > 
> > > > It is one of the main points.
> > > > 
> > > > > 
> > > > > But, if there is an ice or idpf supported device present in the system, the
> > > > > appropriate driver will have already been loaded anyway (and gone
> > > > through its
> > > > > probe flow to create auxiliary devices).  If it is not loaded, then the system
> > > > owner
> > > > > has either unloaded it manually or blacklisted it.  This would not cause an
> > > > issue
> > > > > anyway, since irdma and ice/idpf can load in any order.
> > > > 
> > > > There are two assumptions above, which both not true.
> > > > 1. Users never issue "modprobe irdma" command alone and always will call
> > > > to whole chain "modprobe ice ..." before.
> > > > 2. You open-code module subsystem properly with reference counters,
> > > > ownership and locks to protect from function pointers to be set/clear
> > > > dynamically.
> > > 
> > > Ah, I see your reasoning now.  Our goal was to make the two modules independent,
> > > with no prescribed load order mandated, and utilize the auxiliary bus and device subsystem
> > > to handle load order and unload of one or the other module.  The auxiliary device only has
> > > the lifespan of the core PCI driver, so if the core driver unloads, then the auxiliary device gets
> > > destroyed, and the associated link based off it will be gone.  We wanted to be able to unload
> > > and reload either of the modules (core or irdma) and have the interaction be able to restart with a
> > > new probe.  All our inter-driver function calls are protected by device lock on the auxiliary
> > > device for the duration of the call.
> > 
> > Yes, you are trying to return to pre-aux era.
> 
> 
> The main motivation to go with callbacks to the parent driver instead of
> using exported symbols is to allow loading only the parent driver required
> for a particular deployment. irdma is a common rdma auxilary driver that
> supports multiple parent pci drivers(ice, idpf, i40e, iavf). If we use
> exported symbols, all these modules will get loaded even on a system with
> only idpf device.

It is not how kernel works. IRDMA doesn't call to all exported symbols
of all these modules. It will call to only one exported symbol and that
module will be loaded.

> 
> The documentation for auxiliary bus
> 	https://docs.kernel.org/driver-api/auxiliary_bus.html
> shows an example on how shared data/callbacks can be used to establish
> connection with the parent.

I'm aware of this documentation, it is incorrect. You can find the
explanation why this documentation exists in habanalabs discussion.

> 
> Auxiliary devices are created and registered by a subsystem-level core
> device that needs to break up its functionality into smaller fragments. One
> way to extend the scope of an auxiliary_device is to encapsulate it within a
> domain-specific structure defined by the parent device. This structure
> contains the auxiliary_device and any associated shared data/callbacks
> needed to establish the connection with the parent.
> 
> An example is:
> 
>  struct foo {
>       struct auxiliary_device auxdev;
>       void (*connect)(struct auxiliary_device *auxdev);
>       void (*disconnect)(struct auxiliary_device *auxdev);
>       void *data;
> };
> 
> This example clearly shows that it is OK to use callbacks from the aux
> driver. The aux driver is dependent on the parent driver and the parent
> driver will guarantee that it will not get unloaded until all the auxiliary
> devices are destroyed.
> 
> Hopefully you will understand our motivation of going with this design and
> not force us to go with a solution that is not optimal.

Feel free to fix documentation.

Thanks

> 
> Thanks
> Sridhar
> 

