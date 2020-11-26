Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5735A2C57BF
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Nov 2020 16:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391268AbgKZPB5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Nov 2020 10:01:57 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:14250 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391130AbgKZPB5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Nov 2020 10:01:57 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbfc3640000>; Thu, 26 Nov 2020 07:01:56 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 26 Nov
 2020 15:01:53 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 26 Nov 2020 15:01:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yolgi/PYOy8PH1PuDx6+fxM71qiPiQZWPkj0FpBIUrBfGWxe2uzWv6KhTTMBo4nWmOmX9EhJ0ju4oJxCXKkxusdMRzWv1D9LiLV/RvZPoT8fP+bzcoshtH1mG29QtFeiiOSoyRp0fdjeApFqSreF0YmAr7Wr81R2wXXruuASt0Ivl73hZx86iAuBFQhzQU5htQsY6YVcdFqebWfy404IFErrjaMCtOKN7rK4BNda/cb1Inq+PFU/SV1nSCvrWvxBrs0jb2gABCqyDrGQQpcSK554h6vVmaeQ14P4Pj2+qBAAFhNAnkcErtVF2PJXJcF/OMtWkPHv4WuOeZVs72MOuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6dmvvrlCOuASKYfRk0KT6Nm6WkSQm0e7NUG3L2319k=;
 b=bKaGY1cH2PnDpr/gGAFBZvTKUHjr8f0loSHV7iIrFx0ovOttQgBxw6a3bnWmAeYPv90kPojE9oJ87XCAqkn5MeQc8PpTTbm1YuMFVAHeepTdaDNhBCXQ1bktKq6afZ88jpnb0N+c1RLXYOsZND9jUD9AgYjkLeSNqIgog5rdi5Jt5AgYZTIkGZjDLpkXTTGRcBa4Z/zenLNjyepH+DW1qYCLfYVe/613voiYGzBFJY3e6APM0qoCPITBfQwiKjNmp06ChqJPRdYgzDVBWKVZYsdNfRwYqciBlZo8UUyVxYcsy4t2cVFcp3sF3mU/GZblCGrN1ZdjvYrcDahoXoQbmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3019.namprd12.prod.outlook.com (2603:10b6:5:3d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Thu, 26 Nov
 2020 15:01:52 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3611.024; Thu, 26 Nov 2020
 15:01:52 +0000
Date:   Thu, 26 Nov 2020 11:01:51 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH for-rc] RDMA/hns: Fix wrong field of SRQ number the
 device supports
Message-ID: <20201126150151.GA520564@nvidia.com>
References: <1606382812-23636-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1606382812-23636-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: MN2PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:208:23a::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR03CA0016.namprd03.prod.outlook.com (2603:10b6:208:23a::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Thu, 26 Nov 2020 15:01:52 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kiImN-002BTI-Go; Thu, 26 Nov 2020 11:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606402916; bh=Z6dmvvrlCOuASKYfRk0KT6Nm6WkSQm0e7NUG3L2319k=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=e8TrsBBHEU3w4c8uPKRA5+wYn1TVdWq5NCGIKDD8tseo+w/RHQIkwjIcMa3InJuA2
         0fiquNO06urebOQ2SxILK4vs6dvuVJ+zwGfR6R3onV4ydZ9I7XBh4TlNfW5VzwiFp3
         kuTxhBIT+a3NJpOmH91DbpQEt+R0jon8tP/MESFSMv8jqoWNJIJBIh5yvAYTx35EMg
         2dIedrk2j39sgR2vPGzDhlorUwq6lOJy50BNCCAJByi5eebIXLbTu1/EHtOpcwYING
         F2N+z44OWk8Qev3caJK9KwJ1gp6x2xBLScugocRx55nN7vlSlXHQjbBib6z5l4OFk7
         2FkbNjfuVqbKg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 26, 2020 at 05:26:52PM +0800, Weihang Li wrote:
> From: Wenpeng Liang <liangwenpeng@huawei.com>
> 
> The SRQ capacity is got from the firmware, whose field should be ended at
> bit 19.
> 
> Fixes: ba6bb7e97421 ("RDMA/hns: Add interfaces to get pf capabilities from firmware")
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
