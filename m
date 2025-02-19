Return-Path: <linux-rdma+bounces-7821-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FCDA3B39A
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 09:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54B1171F1C
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 08:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491F01C5D5C;
	Wed, 19 Feb 2025 08:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bs0EYBRl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41EF42A93;
	Wed, 19 Feb 2025 08:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953561; cv=none; b=lZwMpjq+R+L+Ku9M3be1FgDK5NuX3CF8sS3ncwLYzW3kXwFJyQq4hncVYcZ/Xr86LFu9wKWBenPe3EvNz3MgmKGpDC6CY4WInQYlX8uFWkK8FH+aY9eRlmI4EYsgNM2QJK7zd4u/8GbntGI/Tq7x1hK4uKOgOnmb5lp++WTsqZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953561; c=relaxed/simple;
	bh=nnBzE3Weq+c/v+u6OHmBCFpKpwYxvH1Rb9cxp3X2mq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGJ+L+gArVFSythl38mpo0i3iennbUfUZir5HWi47oYlTSa59w5GZl6LF4XHwGY1tZSKhFu5yL2YApguqVeJ5uwq8+lORR9oVTeBg5Jxlecs9zZt3WSYR3jMxxVQawBQ4T3z/iHJccrgZT3n2/JrRGJrKuLr89stDj5OiVjYQ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bs0EYBRl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F2FC4CED1;
	Wed, 19 Feb 2025 08:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739953560;
	bh=nnBzE3Weq+c/v+u6OHmBCFpKpwYxvH1Rb9cxp3X2mq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bs0EYBRluf9LJwujtUi+3c3gNsvyaAColAlGDddSdJKzuRYNiVV7OjFqD6GFBEfwy
	 gamovavrCdy1AaFiMZTspNknIgSLADcvqQAkIE0LAiRUw6jscehlMrqwNxmGNnCfMr
	 fzctmx1zDeUqj7sOeg6x+3jIHQKvAdQLvfur8Q4pqYJN+//8eVrH6rYhA+jMiS74jZ
	 48+Ku6dH9v9ivqVs014keAoq9p4tYf3y3r10MJwpUHd9LkEGvpr0yvggHdJjwrgkyI
	 XtFijhl1sKDFtLZe08iAW3+md3JfEb0bflibDyp8uMATGKjWfO6u3wbQsifgNhNYD0
	 k/fRiVgWcehPg==
Date: Wed, 19 Feb 2025 10:25:54 +0200
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
Message-ID: <20250219082554.GD53094@unreal>
References: <20250211234854.52277-1-shannon.nelson@amd.com>
 <20250211234854.52277-4-shannon.nelson@amd.com>
 <20250218195132.GB53094@unreal>
 <39ec35d0-56a2-4473-a67d-9a6727c61693@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39ec35d0-56a2-4473-a67d-9a6727c61693@amd.com>

On Tue, Feb 18, 2025 at 02:19:03PM -0800, Nelson, Shannon wrote:
> On 2/18/2025 11:51 AM, Leon Romanovsky wrote:
> > 
> > On Tue, Feb 11, 2025 at 03:48:52PM -0800, Shannon Nelson wrote:
> > > Initial files for adding a new fwctl driver for the AMD/Pensando PDS
> > > devices.  This sets up a simple auxiliary_bus driver that registers
> > > with fwctl subsystem.  It expects that a pds_core device has set up
> > > the auxiliary_device pds_core.fwctl
> > > 
> > > Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> > > ---
> > >   MAINTAINERS                    |   7 ++
> > >   drivers/fwctl/Kconfig          |  10 ++
> > >   drivers/fwctl/Makefile         |   1 +
> > >   drivers/fwctl/pds/Makefile     |   4 +
> > >   drivers/fwctl/pds/main.c       | 195 +++++++++++++++++++++++++++++++++
> > >   include/linux/pds/pds_adminq.h |  77 +++++++++++++
> > >   include/uapi/fwctl/fwctl.h     |   1 +
> > >   include/uapi/fwctl/pds.h       |  27 +++++
> > >   8 files changed, 322 insertions(+)
> > >   create mode 100644 drivers/fwctl/pds/Makefile
> > >   create mode 100644 drivers/fwctl/pds/main.c
> > >   create mode 100644 include/uapi/fwctl/pds.h
> > 
> > <...>

<...>

> > > +             return err;
> > > +     }
> > > +
> > > +     cmd.fwctl_ident.opcode = PDS_FWCTL_CMD_IDENT;
> > > +     cmd.fwctl_ident.version = 0;
> > 
> > How will you manage this version field?
> 
> Since there is only version 0 at this point, there is not much to manage.  I
> wanted to explicitly show the setting to version 0, but maybe that can be
> assumed by the basic struct init.

But the question is slightly different "How will you manage this version field?"

Thanks

