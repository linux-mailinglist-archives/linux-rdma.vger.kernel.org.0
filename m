Return-Path: <linux-rdma+bounces-8742-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A516A64D79
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 12:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D223A8A5B
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 11:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0CE2376E7;
	Mon, 17 Mar 2025 11:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpSmw1RY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AF827701;
	Mon, 17 Mar 2025 11:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742212652; cv=none; b=mw1wggROqjSDCW4L1WVtzAjRUmH9hbOihTmfpChx7ApjHeyblN1qLGnhJvqwKFbn8yu7bYFOaNZGRLFCVmEx1/FAB8fDUdk8l9QpXFy/rWtppw9DiCSGl01ccyxwjn61wqT8TxUxJgB7AlagKTwc/JvdriQOSm6mJ2YDjCYEI0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742212652; c=relaxed/simple;
	bh=qx4d5VhU7979chbNqkl7b3SaFYWEFssXIF7fOZYmzIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbMG1GiaxvlB+V8apF8U5m8hkjW5XRXMFoNA24vifotExfgelNdFe3EwWwuUht8vbRY6PgDANjXzSfsDV2sAYZxH/O8njrLymZq51qqW0GnqH2pfwYzyM03KlOF7dNqLge9Af2pWYd4NGrymLL+hc4ZY9zCx77E0Qtj69DqBiSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpSmw1RY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C81C4CEE3;
	Mon, 17 Mar 2025 11:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742212651;
	bh=qx4d5VhU7979chbNqkl7b3SaFYWEFssXIF7fOZYmzIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RpSmw1RYqV5+JbUwYKGySg2Juxbpy462CJXAl/VNVe27SelEUl3DgeJBJ1fWqAY2K
	 +1/Xag0U+xhoXBkHag3fMFHKdio9trBLn29qq+By2FxSqwjocZMEATysSlBCR8fdkZ
	 KxrupN8Dlk64XCWzawU1FDseNOgK2LA81RU6Zgc5UovN+fcP/IIP+sjC5UA+i8so/i
	 uiEsP5S+jbo4ueng/k0WcW8skC2GRZ1090rpzS2x6Gls/GNceUOPPavB/EfquA3K00
	 9u7s2/UGjTuh5zT4cvgWyl6+XClz4Ywhwa4l39sAGclDbyqdT6s4w3q8XNnyf90HCo
	 7v7HK6uI6AIIg==
Date: Mon, 17 Mar 2025 13:57:28 +0200
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
Message-ID: <20250317115728.GT1322339@unreal>
References: <20250225050428.2166-1-tatyana.e.nikolova@intel.com>
 <20250225050428.2166-2-tatyana.e.nikolova@intel.com>
 <20250225075530.GD53094@unreal>
 <IA1PR11MB61944C74491DECA111E84021DDC22@IA1PR11MB6194.namprd11.prod.outlook.com>
 <20250226185022.GM53094@unreal>
 <IA1PR11MB6194C8F265D13FE65EA006C2DDC22@IA1PR11MB6194.namprd11.prod.outlook.com>
 <20250302082623.GN53094@unreal>
 <07e75573-9fd0-4de1-ac44-1f6a5461a6b8@intel.com>
 <20250314181230.GP1322339@unreal>
 <8b4868dd-f615-4049-a885-f2f95a3e7a54@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b4868dd-f615-4049-a885-f2f95a3e7a54@intel.com>

On Fri, Mar 14, 2025 at 06:18:00PM -0700, Samudrala, Sridhar wrote:
> 
> 
> On 3/14/2025 11:12 AM, Leon Romanovsky wrote:
> > On Thu, Mar 13, 2025 at 04:38:39PM -0700, Samudrala, Sridhar wrote:
> > > 
> > > 
> > > On 3/2/2025 12:26 AM, Leon Romanovsky wrote:
> > > > On Wed, Feb 26, 2025 at 11:01:52PM +0000, Ertman, David M wrote:
> > > > > 
> > > > > 
> > > > > > -----Original Message-----
> > > > > > From: Leon Romanovsky <leon@kernel.org>
> > > > > > Sent: Wednesday, February 26, 2025 10:50 AM
> > > > > > To: Ertman, David M <david.m.ertman@intel.com>
> > > > > > Cc: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>; jgg@nvidia.com;
> > > > > > intel-wired-lan@lists.osuosl.org; linux-rdma@vger.kernel.org;
> > > > > > netdev@vger.kernel.org
> > > > > > Subject: Re: [iwl-next v4 1/1] iidc/ice/irdma: Update IDC to support multiple
> > > > > > consumers
> > > > > > 
> > > > > > On Wed, Feb 26, 2025 at 05:36:44PM +0000, Ertman, David M wrote:
> > > > > > > > -----Original Message-----
> > > > > > > > From: Leon Romanovsky <leon@kernel.org>
> > > > > > > > Sent: Monday, February 24, 2025 11:56 PM
> > > > > > > > To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
> > > > > > > > Cc: jgg@nvidia.com; intel-wired-lan@lists.osuosl.org; linux-
> > > > > > > > rdma@vger.kernel.org; netdev@vger.kernel.org; Ertman, David M
> > > > > > > > <david.m.ertman@intel.com>
> > > > > > > > Subject: Re: [iwl-next v4 1/1] iidc/ice/irdma: Update IDC to support
> > > > > > multiple
> > > > > > > > consumers
> > > > > > > > 
> > > > > > > > On Mon, Feb 24, 2025 at 11:04:28PM -0600, Tatyana Nikolova wrote:
> > > > > > > > > From: Dave Ertman <david.m.ertman@intel.com>
> > > > > > > > > 
> > > > > > > > > To support RDMA for E2000 product, the idpf driver will use the IDC
> > > > > > > > > interface with the irdma auxiliary driver, thus becoming a second
> > > > > > > > > consumer of it. This requires the IDC be updated to support multiple
> > > > > > > > > consumers. The use of exported symbols no longer makes sense
> > > > > > because it
> > > > > > > > > will require all core drivers (ice/idpf) that can interface with irdma
> > > > > > > > > auxiliary driver to be loaded even if hardware is not present for those
> > > > > > > > > drivers.
> > > > > > > > 
> > > > > > > > In auxiliary bus world, the code drivers (ice/idpf) need to created
> > > > > > > > auxiliary devices only if specific device present. That auxiliary device
> > > > > > > > will trigger the load of specific module (irdma in our case).
> > > > > > > > 
> > > > > > > > EXPORT_SYMBOL won't trigger load of irdma driver, but the opposite is
> > > > > > > > true, load of irdma will trigger load of ice/idpf drivers (depends on
> > > > > > > > their exported symbol).
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > To address this, implement an ops struct that will be universal set of
> > > > > > > > > naked function pointers that will be populated by each core driver for
> > > > > > > > > the irdma auxiliary driver to call.
> > > > > > > > 
> > > > > > > > No, we worked very hard to make proper HW discovery and driver
> > > > > > autoload,
> > > > > > > > let's not return back. For now, it is no-go.
> > > > > > > 
> > > > > > > Hi Leon,
> > > > > > > 
> > > > > > > I am a little confused about what the problem here is.  The main issue I pull
> > > > > > > from your response is: Removing exported symbols will stop ice/idpf from
> > > > > > > autoloading when irdma loads.  Is this correct or did I miss your point?
> > > > > > 
> > > > > > It is one of the main points.
> > > > > > 
> > > > > > > 
> > > > > > > But, if there is an ice or idpf supported device present in the system, the
> > > > > > > appropriate driver will have already been loaded anyway (and gone
> > > > > > through its
> > > > > > > probe flow to create auxiliary devices).  If it is not loaded, then the system
> > > > > > owner
> > > > > > > has either unloaded it manually or blacklisted it.  This would not cause an
> > > > > > issue
> > > > > > > anyway, since irdma and ice/idpf can load in any order.
> > > > > > 
> > > > > > There are two assumptions above, which both not true.
> > > > > > 1. Users never issue "modprobe irdma" command alone and always will call
> > > > > > to whole chain "modprobe ice ..." before.
> > > > > > 2. You open-code module subsystem properly with reference counters,
> > > > > > ownership and locks to protect from function pointers to be set/clear
> > > > > > dynamically.
> > > > > 
> > > > > Ah, I see your reasoning now.  Our goal was to make the two modules independent,
> > > > > with no prescribed load order mandated, and utilize the auxiliary bus and device subsystem
> > > > > to handle load order and unload of one or the other module.  The auxiliary device only has
> > > > > the lifespan of the core PCI driver, so if the core driver unloads, then the auxiliary device gets
> > > > > destroyed, and the associated link based off it will be gone.  We wanted to be able to unload
> > > > > and reload either of the modules (core or irdma) and have the interaction be able to restart with a
> > > > > new probe.  All our inter-driver function calls are protected by device lock on the auxiliary
> > > > > device for the duration of the call.
> > > > 
> > > > Yes, you are trying to return to pre-aux era.
> > > 
> > > 
> > > The main motivation to go with callbacks to the parent driver instead of
> > > using exported symbols is to allow loading only the parent driver required
> > > for a particular deployment. irdma is a common rdma auxilary driver that
> > > supports multiple parent pci drivers(ice, idpf, i40e, iavf). If we use
> > > exported symbols, all these modules will get loaded even on a system with
> > > only idpf device.
> > 
> > It is not how kernel works. IRDMA doesn't call to all exported symbols
> > of all these modules. It will call to only one exported symbol and that
> > module will be loaded.
> 
> If we are using plain exported symbols from all the parent pci drivers and
> make direct calls from irdma, i would expect that all the drivers need to
> load based on module dependencies.

Are you doing it already?

Thanks

