Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDA0313D1D
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Feb 2021 19:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbhBHSUQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Feb 2021 13:20:16 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14639 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbhBHSTp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Feb 2021 13:19:45 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B602180960000>; Mon, 08 Feb 2021 10:19:02 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 8 Feb
 2021 18:19:02 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 8 Feb 2021 18:19:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJAe9INhhODEpDCaYs0X3vk4aDpihxJa0doKoLZubMM4KY72Oiur+TJsjp/5IIvwgf73Q0M4MzSYI0mE8955MwIsTYlSnO79Q1Ic3Bo9HH0OJQVN2DoJ5fkyaKK8xgcUVojbCQh9XcMchmlnTmsblZ5KeVhjfI3RqbZFbroBXVA1m9qdaF3B3Fy1FUDJ0GinsDlgbGVoWzBdNhR9xzZp3egDkqd8+8f1ipsZE89/u/LHo9GhnRceqPnjhS00vqSBY/JNvmZDM2L2cvKt+kIOCROwbckbb4EDJ8u/SVkHN889FCo85yfrfyOCTK45o5evI6uMbE2LJ5AfNbjn+QFCKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cm68S11lN8Bp66DREOl3jYpDxqh9wbJ3mOgaAI+/3D8=;
 b=A0Gd3hgqzF8R3J4pTpxGfBkxKSOeBga4D+Zjk3mC6CPKXw/K+NrKw6bHe0SCTw98Z6NRjYoG8ReLp8gDIi1pFdH82KWotQ0EFTUEMt5XKy7E8NFYjpKrAzT0GfkSQGYPDUVcaRVFxbMUEVBHcqrt0ZoeLS39F15OpMrOpgNCz7mMWBN57dYhGZt1BXpvic8FbGzMypqpUme297ur7kRAiltylfQFAhRL1EiV7XTeM/OefS2sH1Qd1qgoHuZYEiLO5jz8WK4m9JQOpJkVP3+SPgZppg3DLoSnfZmSFt7t7C/0bcAA333DKlPeATJDuE302m62lm29MNBIwBZ+d1PcJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1340.namprd12.prod.outlook.com (2603:10b6:3:76::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Mon, 8 Feb
 2021 18:19:00 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 18:19:00 +0000
Date:   Mon, 8 Feb 2021 14:18:58 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Honggang Li <honli@redhat.com>, Itay Aveksis <itayav@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Alaa Hleihel <alaa@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: rdma-core spec weird behavior on Fedora
Message-ID: <20210208181858.GI4247@nvidia.com>
References: <20210207080649.GB4656@unreal> <20210208125900.GX4247@nvidia.com>
 <20210208131053.GC20265@unreal> <20210208132115.GY4247@nvidia.com>
 <20210208133137.GE20265@unreal> <20210208140824.GC4247@nvidia.com>
 <20210208143100.GF20265@unreal> <20210208153531.GD4247@nvidia.com>
 <20210208155911.GG20265@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210208155911.GG20265@unreal>
X-ClientProxiedBy: BL0PR0102CA0013.prod.exchangelabs.com
 (2603:10b6:207:18::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR0102CA0013.prod.exchangelabs.com (2603:10b6:207:18::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Mon, 8 Feb 2021 18:18:59 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l9B7i-0051qV-3K; Mon, 08 Feb 2021 14:18:58 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612808342; bh=cm68S11lN8Bp66DREOl3jYpDxqh9wbJ3mOgaAI+/3D8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=YeoiUtW0nGhtOSdvNN91WQSa68emHmfpYpC69tr6JUo5hEptUf0DOeROU8kIgOFup
         rM3RAw5zSEtBgiNWhqHIMsGwSPBatr9f0lhBz5SLiTqNiKBWeSvQ+fdvN0y70kXjGf
         dmbUz03A9P+ltYdnQRrV6jnvbU69Vg2HVycPhbuvu5U7++D662pcz1ERVRsVz/Bsvm
         E1HBKjoH9j73jL4EAprqkPLCTGHmpIKJF0I2uXcXpBLsIntERW0n6XSM+4rey+sy4o
         JvLbl38N6GR9BcL1xNnY4g/OWUrGNElK24GQkhMzZTSCpLUQXcfnvTeijfR5ejqyNp
         4ClARVNGOJ4kA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 08, 2021 at 05:59:11PM +0200, Leon Romanovsky wrote:
> On Mon, Feb 08, 2021 at 11:35:31AM -0400, Jason Gunthorpe wrote:
> > On Mon, Feb 08, 2021 at 04:31:00PM +0200, Leon Romanovsky wrote:
> > > On Mon, Feb 08, 2021 at 10:08:24AM -0400, Jason Gunthorpe wrote:
> > > > On Mon, Feb 08, 2021 at 03:31:37PM +0200, Leon Romanovsky wrote:
> > > > > On Mon, Feb 08, 2021 at 09:21:15AM -0400, Jason Gunthorpe wrote:
> > > > > > On Mon, Feb 08, 2021 at 03:10:53PM +0200, Leon Romanovsky wrote:
> > > > > > > On Mon, Feb 08, 2021 at 08:59:00AM -0400, Jason Gunthorpe wrote:
> > > > > > > > On Sun, Feb 07, 2021 at 10:06:49AM +0200, Leon Romanovsky wrote:
> > > > > > > > > Hi Honggang,
> > > > > > > > >
> > > > > > > > > Your commit b02de521022a ("redhat: Remove base package dependency from all sub-packages")
> > > > > > > > > removes protection from rdma-core when user performs "dnf autoremove".
> > > > > > > > >
> > > > > > > > > Before your patch, systemd was dependent on libibverbs and latter
> > > > > > > > > required rdma-core. After your patch, the last link is lost and
> > > > > > > > > rdma-core marked as orphaned package.
> > > > > > > > >
> > > > > > > > > Any attempt to install rdma-core as standalone package will have the
> > > > > > > > > following errors, due to the library dependency of udevadm.
> > > > > > > > > [leonro@c rdma-core]$ ldd /sbin/udevadm | grep verbs
> > > > > > > > > 	libibverbs.so.1 => not found
> > > > > > > >
> > > > > > > > well that makes no sense, since when is udevadm connected to
> > > > > > > > libibverbs?
> > > > > > > >
> > > > > > > > $ ldd `which udevadm`
> > > > > > > > 	linux-vdso.so.1 (0x00007ffcc09ef000)
> > > > > > > > 	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f394bec3000)
> > > > > > > > 	libkmod.so.2 => /lib/x86_64-linux-gnu/libkmod.so.2 (0x00007f394bea8000)
> > > > > > > > 	libacl.so.1 => /lib/x86_64-linux-gnu/libacl.so.1 (0x00007f394be9d000)
> > > > > > > > 	libblkid.so.1 => /lib/x86_64-linux-gnu/libblkid.so.1 (0x00007f394be46000)
> > > > > > > > 	libselinux.so.1 => /lib/x86_64-linux-gnu/libselinux.so.1 (0x00007f394be1b000)
> > > > > > > > 	libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f394bdf8000)
> > > > > > > > 	/lib64/ld-linux-x86-64.so.2 (0x00007f394c1b6000)
> > > > > > > > 	liblzma.so.5 => /lib/x86_64-linux-gnu/liblzma.so.5 (0x00007f394bdcd000)
> > > > > > > > 	libcrypto.so.1.1 => /lib/x86_64-linux-gnu/libcrypto.so.1.1 (0x00007f394baf7000)
> > > > > > > > 	libpcre2-8.so.0 => /lib/x86_64-linux-gnu/libpcre2-8.so.0 (0x00007f394ba67000)
> > > > > > > > 	libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f394ba61000)
> > > > > > >
> > > > > > > This is from my laptop and it is connected:
> > > > > >
> > > > > > Well, that is crazy, udevadm uses libpcap on Fedora which is linked to verbs
> > > > > >
> > > > > > But it still doesn't make sense, how did you get a in a situation
> > > > > > where this is no libibverbs installed even though there should be
> > > > > > dependencies from udevadm preventing that?
> > > > >
> > > > > It was part of my experiments and it is not the issue which we need to solve.
> > > > >
> > > > > Our two problems are that "dnf autoremove" removes rdma-core and you can't
> > > > > install it separately after Honggang's patch.
> > > >
> > > > why not? libibverbs should not be removed by autoremoved?
> > >
> > > During installation of rdma-core, DNF throws errors if libibverbs
> > > doesn't exist, which was in my case when I wanted to reinstall rdma-core
> > > to something new.
> >
> > dnf shouldn't let you remove libibvebs, so how did it get removed?
> 
> I built rdma-core RPM with latest code, issued "dnf install rdma-core
> ...", which passed with error and left system with "unknown" library.

Hum.

In DEB land if a post install script called some other program, like
udevadm, then it would have to pre-depend on that program so it could
be fully ready to run. Pre-depending would ensure that libibverbs was
swapped out somewhat atomically and the system wouldn't try to
configure rdma-core when libibverbs was not installed during a
transaction to change things around.

Sounds like some dnf expert should take a look at what is going on
here

But also, I don't think Fedora should have libverbs as an mandatory
package in every system for whateve udev is doing with libcap,
something really weird is going on that udev needs pcap

Jason
