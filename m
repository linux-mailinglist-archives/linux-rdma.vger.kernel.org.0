Return-Path: <linux-rdma+bounces-8171-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B680CA46A29
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 19:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C1BB16C7BC
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 18:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16605233140;
	Wed, 26 Feb 2025 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+4/s9Lh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E9823372B;
	Wed, 26 Feb 2025 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595827; cv=none; b=keBNO0XJmHAZlgJtlUbJV0AVvCfrhpKbqgcc3fI85XSKz2p+KpK0ZuLqoQXXCsxqBIyvbK7IKC8igTuDpsllgjy1uT99jprh0vagtazTd0Razb01y7lPOIwkToI6D25BanGL80dLBE+vFYTS7aWyRwYIKmEQifu9MjGdyR2/jSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595827; c=relaxed/simple;
	bh=GAlBE1MxBLfuNJIdhoKlRlj8/U0KvapKDVttTpAWkto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rus+tEedpumj0GiHDoqPOWRga+GcrY+LX7Mtvgd75EJbMRr7DxnwGrellJbB5y4Gk4wfXO2InV3WXH0upoESYASBXLrOcDdOxGnLECM7z8fsnSKlrVWDFYTpBFBN2EpXZyzsJYhY14GBTIAADvgcyNsdnDRffkpvHMFOaR+cED0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+4/s9Lh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB18C4CED6;
	Wed, 26 Feb 2025 18:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740595827;
	bh=GAlBE1MxBLfuNJIdhoKlRlj8/U0KvapKDVttTpAWkto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O+4/s9LhDb3+Glvl+MPUJGDHbmTaCE5lHu8qIRVou/5uMi4gLs+UsT45p/eEplF13
	 X6+GbdS5V8QvUDsV1RYxM6s86Z7YRDs3bHSwEI9iMzoEAZxGs1F+fO/qoeo+Sy9+7e
	 ah3TfR5ac/wpSWNargdVhkYDiz+jljWsfwnoIe4VcaLJU2MVYTL2UCTlXKvzVuHQCf
	 4+5sX7Kb3qe311nMoFcvPRYbmG/9eypEHJYoCIkEwtbVxPMy6/vXZmltChkJuei9Uu
	 Y1oStQ5jFCVLR4QsvoDvq9vj1QLyvljO07AT5MvdvcV+500o3dnfPEXtQk33vP0UZA
	 lxWmXMOf2I8YA==
Date: Wed, 26 Feb 2025 20:50:22 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "Ertman, David M" <david.m.ertman@intel.com>
Cc: "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [iwl-next v4 1/1] iidc/ice/irdma: Update IDC to support multiple
 consumers
Message-ID: <20250226185022.GM53094@unreal>
References: <20250225050428.2166-1-tatyana.e.nikolova@intel.com>
 <20250225050428.2166-2-tatyana.e.nikolova@intel.com>
 <20250225075530.GD53094@unreal>
 <IA1PR11MB61944C74491DECA111E84021DDC22@IA1PR11MB6194.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR11MB61944C74491DECA111E84021DDC22@IA1PR11MB6194.namprd11.prod.outlook.com>

On Wed, Feb 26, 2025 at 05:36:44PM +0000, Ertman, David M wrote:
> > -----Original Message-----
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: Monday, February 24, 2025 11:56 PM
> > To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
> > Cc: jgg@nvidia.com; intel-wired-lan@lists.osuosl.org; linux-
> > rdma@vger.kernel.org; netdev@vger.kernel.org; Ertman, David M
> > <david.m.ertman@intel.com>
> > Subject: Re: [iwl-next v4 1/1] iidc/ice/irdma: Update IDC to support multiple
> > consumers
> > 
> > On Mon, Feb 24, 2025 at 11:04:28PM -0600, Tatyana Nikolova wrote:
> > > From: Dave Ertman <david.m.ertman@intel.com>
> > >
> > > To support RDMA for E2000 product, the idpf driver will use the IDC
> > > interface with the irdma auxiliary driver, thus becoming a second
> > > consumer of it. This requires the IDC be updated to support multiple
> > > consumers. The use of exported symbols no longer makes sense because it
> > > will require all core drivers (ice/idpf) that can interface with irdma
> > > auxiliary driver to be loaded even if hardware is not present for those
> > > drivers.
> > 
> > In auxiliary bus world, the code drivers (ice/idpf) need to created
> > auxiliary devices only if specific device present. That auxiliary device
> > will trigger the load of specific module (irdma in our case).
> > 
> > EXPORT_SYMBOL won't trigger load of irdma driver, but the opposite is
> > true, load of irdma will trigger load of ice/idpf drivers (depends on
> > their exported symbol).
> > 
> > >
> > > To address this, implement an ops struct that will be universal set of
> > > naked function pointers that will be populated by each core driver for
> > > the irdma auxiliary driver to call.
> > 
> > No, we worked very hard to make proper HW discovery and driver autoload,
> > let's not return back. For now, it is no-go.
> 
> Hi Leon,
> 
> I am a little confused about what the problem here is.  The main issue I pull
> from your response is: Removing exported symbols will stop ice/idpf from
> autoloading when irdma loads.  Is this correct or did I miss your point?

It is one of the main points.

> 
> But, if there is an ice or idpf supported device present in the system, the
> appropriate driver will have already been loaded anyway (and gone through its
> probe flow to create auxiliary devices).  If it is not loaded, then the system owner
> has either unloaded it manually or blacklisted it.  This would not cause an issue
> anyway, since irdma and ice/idpf can load in any order.

There are two assumptions above, which both not true.
1. Users never issue "modprobe irdma" command alone and always will call
to whole chain "modprobe ice ..." before.
2. You open-code module subsystem properly with reference counters,
ownership and locks to protect from function pointers to be set/clear
dynamically.

> 
> > 
> > <...>
> > 
> > > +/* Following APIs are implemented by core PCI driver */
> > > +struct idc_rdma_core_ops {
> > > +	int (*vc_send_sync)(struct idc_rdma_core_dev_info *cdev_info, u8
> > *msg,
> > > +			    u16 len, u8 *recv_msg, u16 *recv_len);
> > > +	int (*vc_queue_vec_map_unmap)(struct idc_rdma_core_dev_info
> > *cdev_info,
> > > +				      struct idc_rdma_qvlist_info *qvl_info,
> > > +				      bool map);
> > > +	/* vport_dev_ctrl is for RDMA CORE driver to indicate it is either
> > ready
> > > +	 * for individual vport aux devices, or it is leaving the state where it
> > > +	 * can support vports and they need to be downed
> > > +	 */
> > > +	int (*vport_dev_ctrl)(struct idc_rdma_core_dev_info *cdev_info,
> > > +			      bool up);
> > > +	int (*request_reset)(struct idc_rdma_core_dev_info *cdev_info,
> > > +			     enum idc_rdma_reset_type reset_type);
> > > +};
> > 
> > Core driver can call to callbacks in irdma, like you already have for
> > irdma_iidc_event_handler(), but all calls from irdma to core driver must
> > be through exported symbols. It gives us race-free world in whole driver
> > except one very specific place (irdma_iidc_event_handler).
> 
> I am confused here as well.  Calling a function through an exported symbol,
> or calling the same function from a function pointer should not affect the
> generation of a race condition, as the same function is being called.
> What is inherently better about an exported symbol versus a function
> pointer when considering race conditions?

Exported symbol guarantees that function exists in core module. Module
subsystem will ensure that core module is impossible to unload until all
users are gone. Function pointer has no such guarantees.

> 
> Also, why is calling a function pointer from the irdma module ok, but calling
> one from the core module not?

Because we need to make sure that core module doesn't disappear while
irdma executes its flow. The opposite is not true because core module
controls irdma devices and aware than irdma module is loaded/unloaded.

Thanks

> 
> Again - Thank you for the review, and if I completely missed your points, please let me know!
> 
> Thanks
> DaveE
> 
> > 
> > Thanks
> 
> 

