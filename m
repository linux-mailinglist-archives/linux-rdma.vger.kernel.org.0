Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6CFC31332E
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Feb 2021 14:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhBHNYM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Feb 2021 08:24:12 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18946 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbhBHNWH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Feb 2021 08:22:07 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B60213ad30000>; Mon, 08 Feb 2021 05:21:23 -0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 8 Feb
 2021 13:21:22 +0000
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 8 Feb
 2021 13:21:20 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 8 Feb 2021 13:21:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMWbQzlg1C1Bc9TAuymC/ouF+SWDMeYRjjZFCz2gEy5BIoRLoOilBlir2b/lyJ6v/F49KARD3pp2VdkdCGj7MQFX+LbZu3hvWIjTi514ERPhSBtp+S3ILQXkEmjL71JTZNK8mBTVmwYiqh/Vpeh+2oeda4yyMHX971TpnodDINsf1kZy7nHE8vb/Xl8Gr+EsSFY7QXQdeem25sfpoc2OMepJQa1eIxpT4qvtrpFIQJnzsfdJBSbXkj5sbd5Yj8G18gKFJIhNkORc8mE/QCi8UJ6B6xmL9YfahcQOvF9r6f31Tuy6OoPeymWkY2FEYBeuduiCGv7h2PgN945mpGi1Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oduYN2p/iEcfkynEV5JIJZgSb+Ewa643Jh/lB8/txvg=;
 b=bUKVMPSD9OP6ZfTS288oLe6KPMQjVDZmcwk12PlL+bHc071bkJgWIWdY01Z5CG20APEZ9s9lEPljtKh5emE9Zvhwtax24BT9i1/9uN+NF+BSKmeHdM/RjOkH4WPCJM7YFGuHWnz3x3PcVTstKEvSKA5UtJabDvIVGAoVDTaETawCy/mZCAUyr7H2MyztCfAPzeSygN1KUiqerqZ4WtUTCVnSCMk3FpYPEewnYq/JNcHq1pT4TfePFBaJ8dcRjcDQbXrKy+fuq80ywtij4+uDepDKdunEhLtbYfY//VCSlkGWuknc+FXmp/qrMFbKV7EZ+srE+/75OaH5RGhPak0iug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4546.namprd12.prod.outlook.com (2603:10b6:5:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.25; Mon, 8 Feb
 2021 13:21:18 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 13:21:16 +0000
Date:   Mon, 8 Feb 2021 09:21:15 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Honggang Li <honli@redhat.com>, Itay Aveksis <itayav@nvidia.com>,
        "RDMA mailing list" <linux-rdma@vger.kernel.org>,
        Alaa Hleihel <alaa@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: rdma-core spec weird behavior on Fedora
Message-ID: <20210208132115.GY4247@nvidia.com>
References: <20210207080649.GB4656@unreal> <20210208125900.GX4247@nvidia.com>
 <20210208131053.GC20265@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210208131053.GC20265@unreal>
X-ClientProxiedBy: BL1PR13CA0447.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::32) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0447.namprd13.prod.outlook.com (2603:10b6:208:2c3::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.11 via Frontend Transport; Mon, 8 Feb 2021 13:21:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l96Tb-004x5X-0b; Mon, 08 Feb 2021 09:21:15 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612790483; bh=oduYN2p/iEcfkynEV5JIJZgSb+Ewa643Jh/lB8/txvg=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=Pdv1n2NYsban1dhOTOnQea02AfWhosVcQ+o6IoeUKxXbb36sr0bFxA+Dod79H32Dd
         +PbPy1cPyyWwpavEJxwh1312hYAzTbUVfk15QE7956irQ51j3rs5AnZO16ZEqqmooc
         MlPlAUwaPVcpT35hCgptgjOPqqJaAatCH1x+4PkvVgyBdAKPH1wwxYIkAe5Yr2tEle
         BS1YvvLzUdnWGRDCwhI0nQnfNqyHBBLwpFTkR4EQT5bORascx3RMKvrlX1mvrZ11Bc
         +ZIyGW1YuENIG/ARd7irkBtzEutZFCSOPMcEduVHWtlQvKXp/IKKvk1NiNc+CQlSux
         Xw5+qM3d3uPcA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 08, 2021 at 03:10:53PM +0200, Leon Romanovsky wrote:
> On Mon, Feb 08, 2021 at 08:59:00AM -0400, Jason Gunthorpe wrote:
> > On Sun, Feb 07, 2021 at 10:06:49AM +0200, Leon Romanovsky wrote:
> > > Hi Honggang,
> > >
> > > Your commit b02de521022a ("redhat: Remove base package dependency from all sub-packages")
> > > removes protection from rdma-core when user performs "dnf autoremove".
> > >
> > > Before your patch, systemd was dependent on libibverbs and latter
> > > required rdma-core. After your patch, the last link is lost and
> > > rdma-core marked as orphaned package.
> > >
> > > Any attempt to install rdma-core as standalone package will have the
> > > following errors, due to the library dependency of udevadm.
> > > [leonro@c rdma-core]$ ldd /sbin/udevadm | grep verbs
> > > 	libibverbs.so.1 => not found
> >
> > well that makes no sense, since when is udevadm connected to
> > libibverbs?
> >
> > $ ldd `which udevadm`
> > 	linux-vdso.so.1 (0x00007ffcc09ef000)
> > 	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f394bec3000)
> > 	libkmod.so.2 => /lib/x86_64-linux-gnu/libkmod.so.2 (0x00007f394bea8000)
> > 	libacl.so.1 => /lib/x86_64-linux-gnu/libacl.so.1 (0x00007f394be9d000)
> > 	libblkid.so.1 => /lib/x86_64-linux-gnu/libblkid.so.1 (0x00007f394be46000)
> > 	libselinux.so.1 => /lib/x86_64-linux-gnu/libselinux.so.1 (0x00007f394be1b000)
> > 	libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f394bdf8000)
> > 	/lib64/ld-linux-x86-64.so.2 (0x00007f394c1b6000)
> > 	liblzma.so.5 => /lib/x86_64-linux-gnu/liblzma.so.5 (0x00007f394bdcd000)
> > 	libcrypto.so.1.1 => /lib/x86_64-linux-gnu/libcrypto.so.1.1 (0x00007f394baf7000)
> > 	libpcre2-8.so.0 => /lib/x86_64-linux-gnu/libpcre2-8.so.0 (0x00007f394ba67000)
> > 	libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f394ba61000)
> 
> This is from my laptop and it is connected:

Well, that is crazy, udevadm uses libpcap on Fedora which is linked to verbs

But it still doesn't make sense, how did you get a in a situation
where this is no libibverbs installed even though there should be
dependencies from udevadm preventing that?

Jason
