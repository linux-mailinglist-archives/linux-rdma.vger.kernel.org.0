Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31973134A4
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Feb 2021 15:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhBHOLg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Feb 2021 09:11:36 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15354 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbhBHOJT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Feb 2021 09:09:19 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B602145db0000>; Mon, 08 Feb 2021 06:08:27 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 8 Feb
 2021 14:08:27 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 8 Feb 2021 14:08:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gaNO+Mqehob9NSJo05GY9VIOGNiT20nf7cTDpUZJ+A/eIFEzhEhv+hDa62MN7m7UwI2exFXStxFJv6NRCQh5ZFZ+KGc0lXHy3c5O9AbdmmNi1nl3YvOY06/90b6sxOrAvTOLpdGusoJJ952GNxWNY6k9ErqTeIZ2sHjy7QOeku/qGOdyCMxfXvkPJgJMjSXFX6bH31sSO1qwe3YNZhdIrFMU7GP903c7FlO2Ko14BFsSunI3YDSB6bHalyGQEJ2P7V4ONtu3i6p6aDKwDyrF1nR5MvnE57MNKX6GgqzIQw9F4kmy4+cucVnlmey08Qtmd9+OiJSgwm1VY9E82fRKMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVdR3hrYxThilVnNvYv9WWc/sgO7dt49vkK/EZWetdQ=;
 b=YugjnwZldl2hbl5zkf1ABmgmunToFWDR3m6umjRjpDwJs54YhXV2oHlr3glJcDFSmmifVCQJCkbl2bzGsILIJBBSWCSkQXLX1MBabazTP2OOI+U2oRYm8f4R3dlqYbxoouRbvgYVwZd9KNoCbMzgVDQIuUlfTitzsftdq2xSB/U1EetzX9eRstxg/aePT4FDofDXPX0vkVY8GzA5aVlaVCH+W2aNsBw9ITm7/KkfO7n5+jv1nZfKgOIDcN6bwm6CVwhwwkwkFp3hqqhzxsBvBoCeXrp4n+RgB+hR/hrckwRgFRTCMZ5oBIUF+R7wY/756bfi0uAUaBstwGmwzqgjpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4778.namprd12.prod.outlook.com (2603:10b6:5:167::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Mon, 8 Feb
 2021 14:08:26 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 14:08:26 +0000
Date:   Mon, 8 Feb 2021 10:08:24 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Honggang Li <honli@redhat.com>, Itay Aveksis <itayav@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Alaa Hleihel <alaa@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: rdma-core spec weird behavior on Fedora
Message-ID: <20210208140824.GC4247@nvidia.com>
References: <20210207080649.GB4656@unreal> <20210208125900.GX4247@nvidia.com>
 <20210208131053.GC20265@unreal> <20210208132115.GY4247@nvidia.com>
 <20210208133137.GE20265@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210208133137.GE20265@unreal>
X-ClientProxiedBy: BL0PR0102CA0027.prod.exchangelabs.com
 (2603:10b6:207:18::40) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR0102CA0027.prod.exchangelabs.com (2603:10b6:207:18::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.21 via Frontend Transport; Mon, 8 Feb 2021 14:08:25 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l97DE-004y6b-5T; Mon, 08 Feb 2021 10:08:24 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612793307; bh=RVdR3hrYxThilVnNvYv9WWc/sgO7dt49vkK/EZWetdQ=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=ZHummvCTUUwe8KWP8y2TAocxVXJdiq9BQFw+o684gnlMgOt3ct0TARfCB0whYawD/
         fbqJymavFAD0EM8FWkRA/jLZEAaqqVAtuEkz6cRrG3NXAZP27fZEUey8UeDgC6fXU9
         syTJItxtR1fCllW99aT2YHI9feQzG/K8DGCjilE3LvK/+QxVZ8ed8bhCHDdM+uUm8D
         lxbEmifDMB3eSwx/jdBFHQgiFHiHFQRLezCnfVQ4iWgouMPs41u5NarXf22UYXHyqF
         vLTKrVNr5eGUfAsQ0gIHZ1O6hlaP5/9Kt44kQqOUifHoAOWWq6XvhVJ1Mr6MSL0VFa
         AAHuiKaleqwXA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 08, 2021 at 03:31:37PM +0200, Leon Romanovsky wrote:
> On Mon, Feb 08, 2021 at 09:21:15AM -0400, Jason Gunthorpe wrote:
> > On Mon, Feb 08, 2021 at 03:10:53PM +0200, Leon Romanovsky wrote:
> > > On Mon, Feb 08, 2021 at 08:59:00AM -0400, Jason Gunthorpe wrote:
> > > > On Sun, Feb 07, 2021 at 10:06:49AM +0200, Leon Romanovsky wrote:
> > > > > Hi Honggang,
> > > > >
> > > > > Your commit b02de521022a ("redhat: Remove base package dependency from all sub-packages")
> > > > > removes protection from rdma-core when user performs "dnf autoremove".
> > > > >
> > > > > Before your patch, systemd was dependent on libibverbs and latter
> > > > > required rdma-core. After your patch, the last link is lost and
> > > > > rdma-core marked as orphaned package.
> > > > >
> > > > > Any attempt to install rdma-core as standalone package will have the
> > > > > following errors, due to the library dependency of udevadm.
> > > > > [leonro@c rdma-core]$ ldd /sbin/udevadm | grep verbs
> > > > > 	libibverbs.so.1 => not found
> > > >
> > > > well that makes no sense, since when is udevadm connected to
> > > > libibverbs?
> > > >
> > > > $ ldd `which udevadm`
> > > > 	linux-vdso.so.1 (0x00007ffcc09ef000)
> > > > 	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f394bec3000)
> > > > 	libkmod.so.2 => /lib/x86_64-linux-gnu/libkmod.so.2 (0x00007f394bea8000)
> > > > 	libacl.so.1 => /lib/x86_64-linux-gnu/libacl.so.1 (0x00007f394be9d000)
> > > > 	libblkid.so.1 => /lib/x86_64-linux-gnu/libblkid.so.1 (0x00007f394be46000)
> > > > 	libselinux.so.1 => /lib/x86_64-linux-gnu/libselinux.so.1 (0x00007f394be1b000)
> > > > 	libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f394bdf8000)
> > > > 	/lib64/ld-linux-x86-64.so.2 (0x00007f394c1b6000)
> > > > 	liblzma.so.5 => /lib/x86_64-linux-gnu/liblzma.so.5 (0x00007f394bdcd000)
> > > > 	libcrypto.so.1.1 => /lib/x86_64-linux-gnu/libcrypto.so.1.1 (0x00007f394baf7000)
> > > > 	libpcre2-8.so.0 => /lib/x86_64-linux-gnu/libpcre2-8.so.0 (0x00007f394ba67000)
> > > > 	libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f394ba61000)
> > >
> > > This is from my laptop and it is connected:
> >
> > Well, that is crazy, udevadm uses libpcap on Fedora which is linked to verbs
> >
> > But it still doesn't make sense, how did you get a in a situation
> > where this is no libibverbs installed even though there should be
> > dependencies from udevadm preventing that?
> 
> It was part of my experiments and it is not the issue which we need to solve.
> 
> Our two problems are that "dnf autoremove" removes rdma-core and you can't
> install it separately after Honggang's patch.

why not? libibverbs should not be removed by autoremoved?

Jason
