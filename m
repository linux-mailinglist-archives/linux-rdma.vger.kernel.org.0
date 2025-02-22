Return-Path: <linux-rdma+bounces-8010-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D166DA40AF4
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2025 19:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0B11774B5
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2025 18:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774A820B1FA;
	Sat, 22 Feb 2025 18:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nc3fpnuV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFF618C0C;
	Sat, 22 Feb 2025 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740248944; cv=none; b=JH/IwZQBFFNekofaTgiarorPQYdbFfmYdjjxLBXyAGDknV37U9PA6qTWB+vjmsy4t5n161xdnVZ7RbmtZ7UE83mJ3GFkMRSktA/FffxD4GEBgPdSbJReWPFufnSzHW75iBC/xiiILRaXbo97yOveiamhBrc42dzZaefobRc0NQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740248944; c=relaxed/simple;
	bh=2ihQX9u9K3sL0h1y3ZuxOKbm7qAky/Nw4YGKusOjRos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCJHery+bUhiGk6lld0FGLR7M19Ft2VNNYhdVcM7J2r91dA7EbbLgB2t/ShjBIxyW8m94MOhalhp4oKHb8apZP42s2guAnvoUbW/O4V+zPSnyAjsBMGrkLcOyLw2OgFPuXxRhbsSNjqHe5t0aTAlZdJO9mqahKUQ/TumQR/2vz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nc3fpnuV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3FEC4CED1;
	Sat, 22 Feb 2025 18:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740248943;
	bh=2ihQX9u9K3sL0h1y3ZuxOKbm7qAky/Nw4YGKusOjRos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nc3fpnuViIVxv5g5qSVEO0+QoHzF+Vc0eo9P4Kw+jXhtQFIKNAGsGfV8HYdtJrvH/
	 h9Cv0skM+N5iT0LA2XeYupWmP7s7H9l4rbG1YEjjJ2Abviju53lrs/1hFILW7JeFym
	 8GU+r7i35+15XNx56MY76tfKRafkIHv+oZ4VuMvqz7YCNNVjLEk8luknVdU/Yj1MGC
	 byKZtShKWYiK5hJjoD1z/krswnW+wGElMSN6MII1K2nDKQ6ze4N4O9AAFJadsSi00J
	 Ju5iyisL07EVGpZ2twSqWkPOh7Cd/NqRM6f1M5kxY4Ie4Pjrdok6OP4iarfQTKpXgY
	 ng+PGdjmZlXpg==
Date: Sat, 22 Feb 2025 20:29:00 +0200
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
Subject: Re: [RFC PATCH fwctl 3/5] pds_fwctl: initial driver framework
Message-ID: <20250222182900.GU53094@unreal>
References: <20250211234854.52277-1-shannon.nelson@amd.com>
 <20250211234854.52277-4-shannon.nelson@amd.com>
 <20250218195132.GB53094@unreal>
 <39ec35d0-56a2-4473-a67d-9a6727c61693@amd.com>
 <20250219082554.GD53094@unreal>
 <6e023017-27ac-4182-8a87-313d2b34f5e4@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e023017-27ac-4182-8a87-313d2b34f5e4@amd.com>

On Thu, Feb 20, 2025 at 03:27:37PM -0800, Nelson, Shannon wrote:
> On 2/19/2025 12:25 AM, Leon Romanovsky wrote:
> > 
> > On Tue, Feb 18, 2025 at 02:19:03PM -0800, Nelson, Shannon wrote:
> > > On 2/18/2025 11:51 AM, Leon Romanovsky wrote:
> > > > 
> > > > On Tue, Feb 11, 2025 at 03:48:52PM -0800, Shannon Nelson wrote:
> > > > > Initial files for adding a new fwctl driver for the AMD/Pensando PDS
> > > > > devices.  This sets up a simple auxiliary_bus driver that registers
> > > > > with fwctl subsystem.  It expects that a pds_core device has set up
> > > > > the auxiliary_device pds_core.fwctl
> > > > > 
> > > > > Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> > > > > ---
> > > > >    MAINTAINERS                    |   7 ++
> > > > >    drivers/fwctl/Kconfig          |  10 ++
> > > > >    drivers/fwctl/Makefile         |   1 +
> > > > >    drivers/fwctl/pds/Makefile     |   4 +
> > > > >    drivers/fwctl/pds/main.c       | 195 +++++++++++++++++++++++++++++++++
> > > > >    include/linux/pds/pds_adminq.h |  77 +++++++++++++
> > > > >    include/uapi/fwctl/fwctl.h     |   1 +
> > > > >    include/uapi/fwctl/pds.h       |  27 +++++
> > > > >    8 files changed, 322 insertions(+)
> > > > >    create mode 100644 drivers/fwctl/pds/Makefile
> > > > >    create mode 100644 drivers/fwctl/pds/main.c
> > > > >    create mode 100644 include/uapi/fwctl/pds.h
> > > > 
> > > > <...>
> > 
> > <...>
> > 
> > > > > +             return err;
> > > > > +     }
> > > > > +
> > > > > +     cmd.fwctl_ident.opcode = PDS_FWCTL_CMD_IDENT;
> > > > > +     cmd.fwctl_ident.version = 0;
> > > > 
> > > > How will you manage this version field?
> > > 
> > > Since there is only version 0 at this point, there is not much to manage.  I
> > > wanted to explicitly show the setting to version 0, but maybe that can be
> > > assumed by the basic struct init.
> > 
> > But the question is slightly different "How will you manage this version field?"
> 
> If we find we have to change the interface in a non-backward-compatable way,
> we'll increment the version number that we support, and watch for the
> version number supported by the firmware as reported in the ident struct
> data and interpret the data appropriately.  Similarly, if the firmware sees
> that the host driver is at a lower version number, it will handle data in
> the older format.

Thanks.

> 
> sln
> 
> 
> 

