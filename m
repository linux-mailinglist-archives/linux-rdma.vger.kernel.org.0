Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC783132DC
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Feb 2021 14:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhBHM7x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Feb 2021 07:59:53 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2110 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhBHM7t (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Feb 2021 07:59:49 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B602135970000>; Mon, 08 Feb 2021 04:59:03 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 8 Feb
 2021 12:59:03 +0000
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 8 Feb 2021 12:59:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmO8pAW/bhScjH8OV+wdbzGFJ4q/qfMgmhv6L6oEsLxzxxEieh/r5qBwSWi2sms6OsiMQMd0hldj7UK3mbMNxPfmZizxglaaAphK6mjQDl06xrBRgfUrYgXo1bbb3SvohW+poiAVf2uRi9srNak5pnodnvcDad+tVP0FWn3Fhwmu21Uel5UrVNwEi8/LvW8AUP4J2uGEdLucuZq0NTuRSriAhD9bMjz+M9g5i2eErQevzMlOtcl79C6d1lVbR+2z/wAfsEDIXNMPGTG/NC0XdA3VRk+jNNrx3j/shu4Y5Sl7UA0yuRWrKIE1fTdUw9LW92HCOdZKoCOMeK0MVjWoVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5mluze5Tu7Iw6szgb2J8n4B7eQkElAKZmGtV2jNADA=;
 b=FRpZNSulFTxALMdlZHzm5KDkC8G21wbYAfkN1zkFlVhFP09J2lA2dNU2ZQYy/tetpWvOq6RwZG5K3TgGU42XCcIFfq47Yeawm2jOtxiGpPFsXnCyWthYIA8as7VlpplKgszSLHr55CN6H4a6vvKz2TK4+s2FX6PDbmnXvxrCrV6PV27xBO26zQbBhRiDXotZw1s4q+rxszSlte9ntnNwbHu25dQpcTeLGWhHA2JyUhakN/+mtCKGSeulhgLgNgEfr93iEoe6GhrPdIdOtRNU5NMGV9GP7rIUGPvMDK6nhdPXgsCJ1Z8BgcBNO1QNKlRwrb7250Dshc4XmM9a2THvbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2809.namprd12.prod.outlook.com (2603:10b6:5:4a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Mon, 8 Feb
 2021 12:59:02 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 12:59:02 +0000
Date:   Mon, 8 Feb 2021 08:59:00 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Honggang Li <honli@redhat.com>, Itay Aveksis <itayav@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Alaa Hleihel <alaa@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: rdma-core spec weird behavior on Fedora
Message-ID: <20210208125900.GX4247@nvidia.com>
References: <20210207080649.GB4656@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210207080649.GB4656@unreal>
X-ClientProxiedBy: BL0PR01CA0036.prod.exchangelabs.com (2603:10b6:208:71::49)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR01CA0036.prod.exchangelabs.com (2603:10b6:208:71::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Mon, 8 Feb 2021 12:59:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l9684-004we0-PU; Mon, 08 Feb 2021 08:59:00 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612789143; bh=D5mluze5Tu7Iw6szgb2J8n4B7eQkElAKZmGtV2jNADA=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=O7ORt6Xwe+S5SggEb80c/eKglH9SM0fKSIi9ExbtKfFtWYW9+k+FfdHGTeh6cau0c
         3g0VJdAx6HmvXECL5X2vkbTqpunlN0MrYGhQjv9DzmsHsfrNnFCajJldQPMDtprcbv
         O/yvI4LpIcYmvdD86yF60ZvVXEP4jfmiaoPXXzvmmZc2SIzd0pUOw95gXrrJGmJm/9
         go2VrLdL8lFW9UpTeEVGc+AZ9xm9a5kSWaQK0rZKm7D6HlyuVDHWEiFlyCbmSeAWAa
         10l+ak1XHVdZzPT4cKKFPlQi54nest6+z2s2WdzDl7BGSp4vm38qX85YSrSZpYoHXx
         gMUUWglGgulgA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Feb 07, 2021 at 10:06:49AM +0200, Leon Romanovsky wrote:
> Hi Honggang,
> 
> Your commit b02de521022a ("redhat: Remove base package dependency from all sub-packages")
> removes protection from rdma-core when user performs "dnf autoremove".
> 
> Before your patch, systemd was dependent on libibverbs and latter
> required rdma-core. After your patch, the last link is lost and
> rdma-core marked as orphaned package.
> 
> Any attempt to install rdma-core as standalone package will have the
> following errors, due to the library dependency of udevadm.
> [leonro@c rdma-core]$ ldd /sbin/udevadm | grep verbs
> 	libibverbs.so.1 => not found

well that makes no sense, since when is udevadm connected to
libibverbs?

$ ldd `which udevadm`
	linux-vdso.so.1 (0x00007ffcc09ef000)
	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f394bec3000)
	libkmod.so.2 => /lib/x86_64-linux-gnu/libkmod.so.2 (0x00007f394bea8000)
	libacl.so.1 => /lib/x86_64-linux-gnu/libacl.so.1 (0x00007f394be9d000)
	libblkid.so.1 => /lib/x86_64-linux-gnu/libblkid.so.1 (0x00007f394be46000)
	libselinux.so.1 => /lib/x86_64-linux-gnu/libselinux.so.1 (0x00007f394be1b000)
	libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f394bdf8000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f394c1b6000)
	liblzma.so.5 => /lib/x86_64-linux-gnu/liblzma.so.5 (0x00007f394bdcd000)
	libcrypto.so.1.1 => /lib/x86_64-linux-gnu/libcrypto.so.1.1 (0x00007f394baf7000)
	libpcre2-8.so.0 => /lib/x86_64-linux-gnu/libpcre2-8.so.0 (0x00007f394ba67000)
	libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f394ba61000)

Jason
