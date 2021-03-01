Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634C0328C73
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Mar 2021 19:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240591AbhCASwh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Mar 2021 13:52:37 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12867 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239157AbhCASuR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Mar 2021 13:50:17 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603d37400003>; Mon, 01 Mar 2021 10:49:36 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Mar
 2021 18:49:34 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 1 Mar 2021 18:49:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lche4oZPtH/wmWaOilrwim79pJfeTcpfWZ9sKWP2cj7yrviDR75RKflp8I0yxiV1b787bgVTn0g+FYRIcIcXTF4fH5cLHagPiCHaCvUhEHnHcxaqAsJW0lsyduVk8LY8vmZqQOB3eLX6KSo3/xgfv53YhzNrtJ+yEay4gzRCDU0GjNglIpytfok4THFTOUK1ViRTLf+eITmGCBy9hp3yVhMdDStpDu6wjxpfkSTOz+VTjllEI+KGQySdeLKeBRNsin5juM90Zhq0JWj6wRElkaOIc0CZm+hAeG/acp3ntIgbEI1VoAZXQ86RCK2circ9Sv9r7Qkc98Fd3ImTmtdcFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUZCwuEzN1hS9+MeBQj6LrTYsfAz6Xb4OzWG39IFQU0=;
 b=J7HOZHpQifVZVtcmbQ+LmC78L+mNYGfEFAHkoZCkycDd1/eBUghitl7/E/l+koHQWK0mBgsxmwlwxItIiZ4OssZb+2qEMyCPCqGtn6YnAnUweHjPNHGN9ZEGMmKlZzHDCNDpqJ7Li6Bsr9+HrCJQAqw719JfQWk1CdEN8jXoL+nwzdk1zok/23AP6s8kVoSPx1qczhLMqWJ/cRe+IZpsCHA1LtkLOVpdrPEAhLEXU/ktEySKOPC/CgJaWoDoOKiLOuZYYPM8Cz0F8p3xdDcoDnxmhssxoCnQz4vLbLItXDPpI67HDCqGOZ+Y3SpRMOcPcusP41kGjNqTzWj2hbLixw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1515.namprd12.prod.outlook.com (2603:10b6:4:6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.20; Mon, 1 Mar 2021 18:49:33 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3890.026; Mon, 1 Mar 2021
 18:49:33 +0000
Date:   Mon, 1 Mar 2021 14:49:31 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     YueHaibing <yuehaibing@huawei.com>
CC:     <leon@kernel.org>, <dledford@redhat.com>, <yishaih@nvidia.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 -next] IB/mlx5: Add missing error code
Message-ID: <20210301184931.GA746241@nvidia.com>
References: <20210222082503.22388-1-yuehaibing@huawei.com>
 <20210222122343.19720-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210222122343.19720-1-yuehaibing@huawei.com>
X-ClientProxiedBy: MN2PR01CA0043.prod.exchangelabs.com (2603:10b6:208:23f::12)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR01CA0043.prod.exchangelabs.com (2603:10b6:208:23f::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Mon, 1 Mar 2021 18:49:32 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lGnbn-00388i-E4; Mon, 01 Mar 2021 14:49:31 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614624576; bh=QUZCwuEzN1hS9+MeBQj6LrTYsfAz6Xb4OzWG39IFQU0=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=jP7TAQOkGfVlc8XliiQlJttjV0PR3Azn2r+AIkqzracYvjE2kN0OID5XBYn+MiCGd
         nwgAICWx43eeG3g9xdtBBsgwPbnKKlUeSY6MxjMAryQa0sCtNMI+CEhtuQFapiHNdw
         MoSiPZNlkz6VmFktwYgcBIjZGVanhE2C4QLC88qPSYrcKKW+zLlyTLdkf00SrAkf1f
         DqO3fcKti22HORu6OW4iMXcki0jRiVTqPUtN2E7LvgsyMwbGm9Fe/NCuXKC7XqgtwY
         w6tO8dzqb3Y08E94DhBB+mIjAs/txNeA9irzx1EhYYUCSIFYIHqnvfyMR5cDn13OB3
         epcOOdXceSD4g==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 22, 2021 at 08:23:43PM +0800, YueHaibing wrote:
> Set err to -ENOMEM if kzalloc fails instead of 0.
> 
> Fixes: 759738537142 ("IB/mlx5: Enable subscription for device events over DEVX")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Acked-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/devx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
