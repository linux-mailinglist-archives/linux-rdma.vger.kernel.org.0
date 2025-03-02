Return-Path: <linux-rdma+bounces-8228-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F82A4B0AC
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Mar 2025 09:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148641893C04
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Mar 2025 08:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5051D79A3;
	Sun,  2 Mar 2025 08:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICadftRa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC691D61A7;
	Sun,  2 Mar 2025 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740903989; cv=none; b=G5yP59k+5tiqDBSIeJAYaExYlLbK3VGqy0DZc6IooFVSmZ95s+zsoT7ZVPCCV8c6IVVgGNceYEY/UEvEPCeYMHT3ImubhQljd0nYVhI+QwvvuGj9k+yd0Erm2XVQ/h7pNc8WxmfApy5hYE6mgZhZA8ICsJOwj6N+ygqBuDxJcoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740903989; c=relaxed/simple;
	bh=XhRpM2FkyuXCXxwWh2C7t7UNTigQOSYTWF3EtRz1gNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOXIjx5eRs2A8lbC2dzjHZCNmpPKujJtdphhx3lXpDhlcFWUnnucFmRwbrRmle0Cdk4+8h2W7CPP9QBT0LIzTL/rgBEUSF1Qxr8BXkFZNj/taejbb/ZXv5Y4LXjkCUqT5NtDPD2Cwod2kcNQmv1JZXS9e1oDScUvxY9dOR6puGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICadftRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61BD0C4CEE8;
	Sun,  2 Mar 2025 08:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740903989;
	bh=XhRpM2FkyuXCXxwWh2C7t7UNTigQOSYTWF3EtRz1gNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ICadftRaJOs1n752jH6kEMi0o2O+PcPBAl1/jGmtiQTVGrlZkcoXC9Dh/Q9qsiYHj
	 vbKEW1ZVzHTpcZXHRbLvndfUuWUf1kEBX2Dx8SG3X/OSFiJS2hrahZRgU7BPinh9EF
	 1ohvEVcgbv5IMTRHKa190lmvZQ4Q8xTYh5JWfV+MbmoXagO7xGMRpFJLGM68ITdnzN
	 4mFlV5ygbzK5LFrXTO6Uf+LZkCweqTgcoHu0YjHSdtO/zQhF7yp3zD8oGaqNg4RRfm
	 TxFRcxHIPC96mkqNnPy33ZlkIPBsw9BzkOzI5yK242qsqFuvECD6Gqbh7zuGcpsZO1
	 SLoYfYipCjqTw==
Date: Sun, 2 Mar 2025 10:26:23 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "Ertman, David M" <david.m.ertman@intel.com>
Cc: "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [iwl-next v4 1/1] iidc/ice/irdma: Update IDC to support multiple
 consumers
Message-ID: <20250302082623.GN53094@unreal>
References: <20250225050428.2166-1-tatyana.e.nikolova@intel.com>
 <20250225050428.2166-2-tatyana.e.nikolova@intel.com>
 <20250225075530.GD53094@unreal>
 <IA1PR11MB61944C74491DECA111E84021DDC22@IA1PR11MB6194.namprd11.prod.outlook.com>
 <20250226185022.GM53094@unreal>
 <IA1PR11MB6194C8F265D13FE65EA006C2DDC22@IA1PR11MB6194.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <IA1PR11MB6194C8F265D13FE65EA006C2DDC22@IA1PR11MB6194.namprd11.prod.outlook.com>

On Wed, Feb 26, 2025 at 11:01:52PM +0000, Ertman, David M wrote:
> 
> 
> > -----Original Message-----
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: Wednesday, February 26, 2025 10:50 AM
> > To: Ertman, David M <david.m.ertman@intel.com>
> > Cc: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>; jgg@nvidia.com;
> > intel-wired-lan@lists.osuosl.org; linux-rdma@vger.kernel.org;
> > netdev@vger.kernel.org
> > Subject: Re: [iwl-next v4 1/1] iidc/ice/irdma: Update IDC to support multiple
> > consumers
> > 
> > On Wed, Feb 26, 2025 at 05:36:44PM +0000, Ertman, David M wrote:
> > > > -----Original Message-----
> > > > From: Leon Romanovsky <leon@kernel.org>
> > > > Sent: Monday, February 24, 2025 11:56 PM
> > > > To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
> > > > Cc: jgg@nvidia.com; intel-wired-lan@lists.osuosl.org; linux-
> > > > rdma@vger.kernel.org; netdev@vger.kernel.org; Ertman, David M
> > > > <david.m.ertman@intel.com>
> > > > Subject: Re: [iwl-next v4 1/1] iidc/ice/irdma: Update IDC to support
> > multiple
> > > > consumers
> > > >
> > > > On Mon, Feb 24, 2025 at 11:04:28PM -0600, Tatyana Nikolova wrote:
> > > > > From: Dave Ertman <david.m.ertman@intel.com>
> > > > >
> > > > > To support RDMA for E2000 product, the idpf driver will use the IDC
> > > > > interface with the irdma auxiliary driver, thus becoming a second
> > > > > consumer of it. This requires the IDC be updated to support multiple
> > > > > consumers. The use of exported symbols no longer makes sense
> > because it
> > > > > will require all core drivers (ice/idpf) that can interface with irdma
> > > > > auxiliary driver to be loaded even if hardware is not present for those
> > > > > drivers.
> > > >
> > > > In auxiliary bus world, the code drivers (ice/idpf) need to created
> > > > auxiliary devices only if specific device present. That auxiliary device
> > > > will trigger the load of specific module (irdma in our case).
> > > >
> > > > EXPORT_SYMBOL won't trigger load of irdma driver, but the opposite is
> > > > true, load of irdma will trigger load of ice/idpf drivers (depends on
> > > > their exported symbol).
> > > >
> > > > >
> > > > > To address this, implement an ops struct that will be universal set of
> > > > > naked function pointers that will be populated by each core driver for
> > > > > the irdma auxiliary driver to call.
> > > >
> > > > No, we worked very hard to make proper HW discovery and driver
> > autoload,
> > > > let's not return back. For now, it is no-go.
> > >
> > > Hi Leon,
> > >
> > > I am a little confused about what the problem here is.  The main issue I pull
> > > from your response is: Removing exported symbols will stop ice/idpf from
> > > autoloading when irdma loads.  Is this correct or did I miss your point?
> > 
> > It is one of the main points.
> > 
> > >
> > > But, if there is an ice or idpf supported device present in the system, the
> > > appropriate driver will have already been loaded anyway (and gone
> > through its
> > > probe flow to create auxiliary devices).  If it is not loaded, then the system
> > owner
> > > has either unloaded it manually or blacklisted it.  This would not cause an
> > issue
> > > anyway, since irdma and ice/idpf can load in any order.
> > 
> > There are two assumptions above, which both not true.
> > 1. Users never issue "modprobe irdma" command alone and always will call
> > to whole chain "modprobe ice ..." before.
> > 2. You open-code module subsystem properly with reference counters,
> > ownership and locks to protect from function pointers to be set/clear
> > dynamically.
> 
> Ah, I see your reasoning now.  Our goal was to make the two modules independent, 
> with no prescribed load order mandated, and utilize the auxiliary bus and device subsystem
> to handle load order and unload of one or the other module.  The auxiliary device only has
> the lifespan of the core PCI driver, so if the core driver unloads, then the auxiliary device gets
> destroyed, and the associated link based off it will be gone.  We wanted to be able to unload
> and reload either of the modules (core or irdma) and have the interaction be able to restart with a
> new probe.  All our inter-driver function calls are protected by device lock on the auxiliary
> device for the duration of the call.

Yes, you are trying to return to pre-aux era. 

> 

<...>

> > > > Core driver can call to callbacks in irdma, like you already have for
> > > > irdma_iidc_event_handler(), but all calls from irdma to core driver must
> > > > be through exported symbols. It gives us race-free world in whole driver
> > > > except one very specific place (irdma_iidc_event_handler).
> > >
> > > I am confused here as well.  Calling a function through an exported symbol,
> > > or calling the same function from a function pointer should not affect the
> > > generation of a race condition, as the same function is being called.
> > > What is inherently better about an exported symbol versus a function
> > > pointer when considering race conditions?
> > 
> > Exported symbol guarantees that function exists in core module. Module
> > subsystem will ensure that core module is impossible to unload until all
> > users are gone. Function pointer has no such guarantees.
> > 
> 
> I also see your reasoning here 😊 We used the auxiliary bus and device subsystem
> with device_lock to achieve this functionality.

It is not enough. You need to protect from the start till the end of
function callback. It means that you will need to hold device_lock for
long time and/or introduce reference counters. In addition, you will
need to be very careful with holding right device_lock (aux and PCI
can disappear).

Thanks

> 
> > >
> > > Also, why is calling a function pointer from the irdma module ok, but calling
> > > one from the core module not?
> > 
> > Because we need to make sure that core module doesn't disappear while
> > irdma executes its flow. The opposite is not true because core module
> > controls irdma devices and aware than irdma module is loaded/unloaded.
> > 
> > Thanks
> > 
> > >
> > > Again - Thank you for the review, and if I completely missed your points,
> > please let me know!
> > >
> > > Thanks
> > > DaveE
> > >
> > > >
> > > > Thanks
> > >
> > >

