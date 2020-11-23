Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812E62C16C4
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Nov 2020 21:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgKWUa7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Nov 2020 15:30:59 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:43442 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727461AbgKWUa6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Nov 2020 15:30:58 -0500
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbc1c000000>; Tue, 24 Nov 2020 04:30:56 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Nov
 2020 20:30:52 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 23 Nov 2020 20:30:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHwUvjXZHU3TQJaHZSs/4p6h4YQ3d1VwIUjd/3h+kN9M5Wq7hUySg+jgA0xQdorlRs7avPkxGHvc8BI7F8U7+h9rgu/txSrspiDhFl5l+znIWj+cEf6uNkZkwehX+EvbqFq9+5TGn5LzhYg735HsA8b4ALhXh6eZiUXnrlzBFS2/EY5BQCe5fSfp1tG0z1faFwkhbF80kiXL2SFMbiEV9m8+iyd1ovfcaHlqxPSrJziF/IKxxFh7SjHm5zErCVG5k0uAfbD7eCm+oyFbjxKk0vMAIInMeTco/+4GG2aC+lU62e6vezr3FvOBMVQWppl6djnaalgPtlJlAdPlVKTqwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnUMuVBegwyQnKb0R5E916DXWjswpfVuGY3GYJ4bUPM=;
 b=PASzwS2hOLlCvodDpnMrNE2FIoxe76GoLJQI2HhqbaiM2xWuAes776Q1IJekC5/uHI84iZurakoR4yphdznpJDVn1s5aMB8jQk9Ea3FnyG6HHg8gQMjXIYbsBZuzqarkOs4F1Q/t/SJccLWXPWRwvbw6FCscslZ/rYxmHT2s/RYwvwKH8FwFgJ3vhNsmJilO/EDa7bqbO9/zEccxdAvDe3Xzg6Wwf7cgfWYYmSL+Lvc3VDQuD3peLnsfGQK/oWE2pstoIJQDdIcudn1P4SqyPSmODOGgGlQ8TdyFML39K/VIXU/0cfmkdQBuUXi/7RbAWuMe2kKrmM1931JYRFyKqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4944.namprd12.prod.outlook.com (2603:10b6:5:1ba::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.24; Mon, 23 Nov
 2020 20:30:50 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3589.022; Mon, 23 Nov 2020
 20:30:50 +0000
Date:   Mon, 23 Nov 2020 16:30:48 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
CC:     Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/i40iw: Constify ops structs
Message-ID: <20201123203048.GA85243@nvidia.com>
References: <20201121002529.89148-1-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201121002529.89148-1-rikard.falkeborn@gmail.com>
X-ClientProxiedBy: MN2PR17CA0028.namprd17.prod.outlook.com
 (2603:10b6:208:15e::41) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR17CA0028.namprd17.prod.outlook.com (2603:10b6:208:15e::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Mon, 23 Nov 2020 20:30:49 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1khIU4-000MBQ-JR; Mon, 23 Nov 2020 16:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606163456; bh=cnUMuVBegwyQnKb0R5E916DXWjswpfVuGY3GYJ4bUPM=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=hToL8sqVT7cWKD9Pp0Mj7NdaPgHw8khUevHhtRMLCi8nC9vQXvnmfZ1XgumHL6XN9
         MxOvA086ajl664eqyQJCcl59GfEToULlb//YiW1Ej0aJCNmZoSn+5shdeb4ZdRnbbC
         21UEjiC7wJziugwk5QqkXYypD42sdR2gTmeKmll79P/dmI52ipSWYb5oW/g2X/bNvV
         OXj8xxeXc6msxJ0p+DXTwzB6Nx2Y/kXf5I0Z5uvGiZL0GBaj1K5MT9Wx+CmwdClkcw
         3L5vUlwg6t3Wzw+/TMPtXBl/gu70kbVk5b33aj4D3L3hIFL7cpmESBk1s9reD6DDtN
         ziI3+nrv9a8Tg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Nov 21, 2020 at 01:25:29AM +0100, Rikard Falkeborn wrote:
> The ops structs are never modified. Make them const to allow the
> compiler to put them in read-only memory.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
>  drivers/infiniband/hw/i40iw/i40iw_ctrl.c | 20 ++++++++++----------
>  drivers/infiniband/hw/i40iw/i40iw_type.h | 20 ++++++++++----------
>  2 files changed, 20 insertions(+), 20 deletions(-)

Applied to for-next thanks

Jason
