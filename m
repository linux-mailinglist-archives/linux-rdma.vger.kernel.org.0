Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F0C313836
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Feb 2021 16:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhBHPiy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Feb 2021 10:38:54 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14825 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbhBHPhw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Feb 2021 10:37:52 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B60215aa60000>; Mon, 08 Feb 2021 07:37:10 -0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 8 Feb
 2021 15:37:09 +0000
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 8 Feb
 2021 15:35:36 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 8 Feb 2021 15:35:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOW8gmyx4BfyrTdMducye54ONEPQckxTI4oCMyMuWaT4LoEBlM0aEnqqjAbJk7ghPXVP4B2HnptPZwiwFpmzjb46ZVVvSE6vQG93/zrx3+SX+iWbpV8spWoAQYoQ36b7hNDdix69Z63Kow0fNC5OX6WaLFdvuOGskSpb9vpkcFjaXuQfeld9N/8XTJaJTxhPWkU/yEi1Pn9eGaIaWBSY8bM67ZE95v/4/9WpNfdIDZX8E259nuDatTuq1jqh0pcldIzegyw43YRWVVfwsInKWV8g8Wf2NPjnu+1Ci1zw4188Wb8jlCtspPEZAe6YBwsNWE86abud+cDCjUnodXPS0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Frc0TeTGXKeAkqBvttWy2nzT4+56lsaDApKZK/HEjD0=;
 b=kv81qziJVXvGdBL5cXZdpjOLAejo61xeb1Zj8dw/hgbsSDAKx4RlJO+wJfoDm/UgbzbP1nShXAAaJ5lFLYvIaEHGwOEtohdT/n7MPdQNo7gSjYE9zuenaAqFlS6vxJpjgCCuTDTJyQs4vtu0mA3vCrGBGv2Iu1zaAXlJLBMvHqWpHrVYGaefSYkwY37TRFmrCVwpNWaDnmf6V/EUd8d/tKYRw9yfg6Lj2SrrrEm8uiqFzLI0Z1//XQC8nXxF0PhJSoHhO2vPH566YQkx8zQDTdWMptRPXvfsUbdUx93SUYvO7nnQ3015SomjO6V9SrijE/GGK3pjw5zUsg9QhQ6H6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.25; Mon, 8 Feb
 2021 15:35:33 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 15:35:33 +0000
Date:   Mon, 8 Feb 2021 11:35:31 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Honggang Li <honli@redhat.com>, Itay Aveksis <itayav@nvidia.com>,
        "RDMA mailing list" <linux-rdma@vger.kernel.org>,
        Alaa Hleihel <alaa@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: rdma-core spec weird behavior on Fedora
Message-ID: <20210208153531.GD4247@nvidia.com>
References: <20210207080649.GB4656@unreal> <20210208125900.GX4247@nvidia.com>
 <20210208131053.GC20265@unreal> <20210208132115.GY4247@nvidia.com>
 <20210208133137.GE20265@unreal> <20210208140824.GC4247@nvidia.com>
 <20210208143100.GF20265@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210208143100.GF20265@unreal>
X-ClientProxiedBy: BL0PR0102CA0024.prod.exchangelabs.com
 (2603:10b6:207:18::37) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR0102CA0024.prod.exchangelabs.com (2603:10b6:207:18::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend Transport; Mon, 8 Feb 2021 15:35:32 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l98ZX-004zEs-Ch; Mon, 08 Feb 2021 11:35:31 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612798630; bh=Frc0TeTGXKeAkqBvttWy2nzT4+56lsaDApKZK/HEjD0=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=bxckH2uNupaCQS7wpUojszS8SMeD4/zoZxETh2ywzUyLWKeMGhJKcpVs5bWSvD4wj
         phEQiGv7is/v2MsMzMJp70W7SejULQD5vBJT6D84qpUw0T7pPkcl+usHK6NfWly1gy
         4WDeqFU1MDbmXeWFEXWtX4i+z71SA4BwftklAqh3wDe/OEjKVGmKtw9Rjj6k/iuHvg
         8gY/MDHkqPYMxYF9jvNK5f94mjzsVY7RtmINyAE1VZ6EEcZ/3RWd7RSqr2lwaY3fub
         p8LejNrF8PFbAojwa53ZoC6QcNlhOVmH+py2MMzYMuAuHDapjVPOlUjCORKVWSaZ66
         oy4ib0whP+2fA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 08, 2021 at 04:31:00PM +0200, Leon Romanovsky wrote:
> On Mon, Feb 08, 2021 at 10:08:24AM -0400, Jason Gunthorpe wrote:
> > On Mon, Feb 08, 2021 at 03:31:37PM +0200, Leon Romanovsky wrote:
> > > On Mon, Feb 08, 2021 at 09:21:15AM -0400, Jason Gunthorpe wrote:
> > > > On Mon, Feb 08, 2021 at 03:10:53PM +0200, Leon Romanovsky wrote:
> > > > > On Mon, Feb 08, 2021 at 08:59:00AM -0400, Jason Gunthorpe wrote:
> > > > > > On Sun, Feb 07, 2021 at 10:06:49AM +0200, Leon Romanovsky wrote:
> > > > > > > Hi Honggang,
> > > > > > >
> > > > > > > Your commit b02de521022a ("redhat: Remove base package dependency from all sub-packages")
> > > > > > > removes protection from rdma-core when user performs "dnf autoremove".
> > > > > > >
> > > > > > > Before your patch, systemd was dependent on libibverbs and latter
> > > > > > > required rdma-core. After your patch, the last link is lost and
> > > > > > > rdma-core marked as orphaned package.
> > > > > > >
> > > > > > > Any attempt to install rdma-core as standalone package will have the
> > > > > > > following errors, due to the library dependency of udevadm.
> > > > > > > [leonro@c rdma-core]$ ldd /sbin/udevadm | grep verbs
> > > > > > > 	libibverbs.so.1 => not found
> > > > > >
> > > > > > well that makes no sense, since when is udevadm connected to
> > > > > > libibverbs?
> > > > > >
> > > > > > $ ldd `which udevadm`
> > > > > > 	linux-vdso.so.1 (0x00007ffcc09ef000)
> > > > > > 	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f394bec3000)
> > > > > > 	libkmod.so.2 => /lib/x86_64-linux-gnu/libkmod.so.2 (0x00007f394bea8000)
> > > > > > 	libacl.so.1 => /lib/x86_64-linux-gnu/libacl.so.1 (0x00007f394be9d000)
> > > > > > 	libblkid.so.1 => /lib/x86_64-linux-gnu/libblkid.so.1 (0x00007f394be46000)
> > > > > > 	libselinux.so.1 => /lib/x86_64-linux-gnu/libselinux.so.1 (0x00007f394be1b000)
> > > > > > 	libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f394bdf8000)
> > > > > > 	/lib64/ld-linux-x86-64.so.2 (0x00007f394c1b6000)
> > > > > > 	liblzma.so.5 => /lib/x86_64-linux-gnu/liblzma.so.5 (0x00007f394bdcd000)
> > > > > > 	libcrypto.so.1.1 => /lib/x86_64-linux-gnu/libcrypto.so.1.1 (0x00007f394baf7000)
> > > > > > 	libpcre2-8.so.0 => /lib/x86_64-linux-gnu/libpcre2-8.so.0 (0x00007f394ba67000)
> > > > > > 	libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f394ba61000)
> > > > >
> > > > > This is from my laptop and it is connected:
> > > >
> > > > Well, that is crazy, udevadm uses libpcap on Fedora which is linked to verbs
> > > >
> > > > But it still doesn't make sense, how did you get a in a situation
> > > > where this is no libibverbs installed even though there should be
> > > > dependencies from udevadm preventing that?
> > >
> > > It was part of my experiments and it is not the issue which we need to solve.
> > >
> > > Our two problems are that "dnf autoremove" removes rdma-core and you can't
> > > install it separately after Honggang's patch.
> >
> > why not? libibverbs should not be removed by autoremoved?
> 
> During installation of rdma-core, DNF throws errors if libibverbs
> doesn't exist, which was in my case when I wanted to reinstall rdma-core
> to something new.

dnf shouldn't let you remove libibvebs, so how did it get removed?

Jason
