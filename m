Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C13313357
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Feb 2021 14:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhBHNcZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Feb 2021 08:32:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:57998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230315AbhBHNcV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 8 Feb 2021 08:32:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56EFF64DD5;
        Mon,  8 Feb 2021 13:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612791101;
        bh=lVY3/ZAAyTvAuKESMlWnkX8E1z4UdmKelleKTBcTQwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hUk/iCxDF0qFVnx6LyIImqEVKKy9K/WoEwpjPGTenAvzaEoyd2FsKoMt/GDjJ6xDa
         bkOmKXxFX0edkwmmVVBPC4rGYzdrlyuIddiDwHGPAMOFt46qut4YggPqJrfbGBv0Zj
         +9lM6QPROcgyUGc/XVNe2ZsC25f/aYOX10vYZgyz+pC4IPGKQ0onfq9mzkAwX/aH59
         GMjI3MCIGSeCjYAdjXbB+ZAPtoMRzng3i43shLo5RPfBcFxwlol1pLd68tgR2zMRSf
         GSyA/etABJYwyIBkDRZbv8MUGkKaQkh6LnVQxlaxgnwmDaq+8cZI3YQ3Q5m6DHzTVx
         9yf8UzJJR+Yhg==
Date:   Mon, 8 Feb 2021 15:31:37 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Honggang Li <honli@redhat.com>, Itay Aveksis <itayav@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Alaa Hleihel <alaa@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: rdma-core spec weird behavior on Fedora
Message-ID: <20210208133137.GE20265@unreal>
References: <20210207080649.GB4656@unreal>
 <20210208125900.GX4247@nvidia.com>
 <20210208131053.GC20265@unreal>
 <20210208132115.GY4247@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208132115.GY4247@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 08, 2021 at 09:21:15AM -0400, Jason Gunthorpe wrote:
> On Mon, Feb 08, 2021 at 03:10:53PM +0200, Leon Romanovsky wrote:
> > On Mon, Feb 08, 2021 at 08:59:00AM -0400, Jason Gunthorpe wrote:
> > > On Sun, Feb 07, 2021 at 10:06:49AM +0200, Leon Romanovsky wrote:
> > > > Hi Honggang,
> > > >
> > > > Your commit b02de521022a ("redhat: Remove base package dependency from all sub-packages")
> > > > removes protection from rdma-core when user performs "dnf autoremove".
> > > >
> > > > Before your patch, systemd was dependent on libibverbs and latter
> > > > required rdma-core. After your patch, the last link is lost and
> > > > rdma-core marked as orphaned package.
> > > >
> > > > Any attempt to install rdma-core as standalone package will have the
> > > > following errors, due to the library dependency of udevadm.
> > > > [leonro@c rdma-core]$ ldd /sbin/udevadm | grep verbs
> > > > 	libibverbs.so.1 => not found
> > >
> > > well that makes no sense, since when is udevadm connected to
> > > libibverbs?
> > >
> > > $ ldd `which udevadm`
> > > 	linux-vdso.so.1 (0x00007ffcc09ef000)
> > > 	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f394bec3000)
> > > 	libkmod.so.2 => /lib/x86_64-linux-gnu/libkmod.so.2 (0x00007f394bea8000)
> > > 	libacl.so.1 => /lib/x86_64-linux-gnu/libacl.so.1 (0x00007f394be9d000)
> > > 	libblkid.so.1 => /lib/x86_64-linux-gnu/libblkid.so.1 (0x00007f394be46000)
> > > 	libselinux.so.1 => /lib/x86_64-linux-gnu/libselinux.so.1 (0x00007f394be1b000)
> > > 	libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f394bdf8000)
> > > 	/lib64/ld-linux-x86-64.so.2 (0x00007f394c1b6000)
> > > 	liblzma.so.5 => /lib/x86_64-linux-gnu/liblzma.so.5 (0x00007f394bdcd000)
> > > 	libcrypto.so.1.1 => /lib/x86_64-linux-gnu/libcrypto.so.1.1 (0x00007f394baf7000)
> > > 	libpcre2-8.so.0 => /lib/x86_64-linux-gnu/libpcre2-8.so.0 (0x00007f394ba67000)
> > > 	libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f394ba61000)
> >
> > This is from my laptop and it is connected:
>
> Well, that is crazy, udevadm uses libpcap on Fedora which is linked to verbs
>
> But it still doesn't make sense, how did you get a in a situation
> where this is no libibverbs installed even though there should be
> dependencies from udevadm preventing that?

It was part of my experiments and it is not the issue which we need to solve.

Our two problems are that "dnf autoremove" removes rdma-core and you can't
install it separately after Honggang's patch.


Thanks

>
> Jason
