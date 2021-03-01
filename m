Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340613288D9
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Mar 2021 18:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbhCARqD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Mar 2021 12:46:03 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17885 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238617AbhCARnM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Mar 2021 12:43:12 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603d25f00002>; Mon, 01 Mar 2021 09:35:44 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Mar
 2021 17:35:44 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 1 Mar 2021 17:35:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qru+AAqpiMjUP9qElSOF3UC9SpX8LsKZxs9a8tGlDPUAj9MwFwqw21/wZK7ChHgzEBtlfSTky/5dZEsz2CgrJVcwgcYaWrS6L35xMwT+f8c6JmXfKj+UEWxTJJcZodWE3piH4onn6s883Sl/Y5jwl0pTtP1W/qomZNgC+dIOufemgfIZDF7eqxTqpO4uRqEno8MDtAzUzoaR7NbKAACUjs0EesfZQoAPN8OIU6aJU7rN6WxeKPfrrUYUnapvV5qOQhngV8oOVpNsivIgJ3ybrbnoAfTdr8Ku0UVQm8BO4vhl0jG+VNySUq9EpcGNLoXVZc3JIf3Wl1bzVHTNq+/khw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8DhnkGv1pdn/zKfkb4yhnXue7UH6nm8CUZsJb6/3ys=;
 b=TIlROjSOExBKjnGEbF9PHllTRastUXkkrbJxN9RZpO1I6S3cCodDVcNvf6hIpHfIH+FRPyI0zLUj0z7zOlto+YoUbRXhO1nhxkR/SeRcPjZLvEMQCsIl1Tzl43SAfC0Qf2fDNsLVjyKqfGr0dzlL23nQFZTBcDgey56W/zof/Yh+CJsGm1jUKP+O4XwAtBtDeON/DfBAMW2xe/SUjowAnugzvSzTtMVsrIMlllin+7h1g6dZoDTcFXcogPaF5TYEz0XCH+6lsOnpwziL+McGtvl/xeK3lUfW4RcsKU/pVtxLQlIp/L0CDfP5RlyPuzMYAdTW8wr1c5/lE601M4amhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3210.namprd12.prod.outlook.com (2603:10b6:5:185::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Mon, 1 Mar
 2021 17:35:42 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3890.026; Mon, 1 Mar 2021
 17:35:42 +0000
Date:   Mon, 1 Mar 2021 13:35:40 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     Leon Romanovsky <leon@kernel.org>, <zyjzyj2000@gmail.com>,
        <linux-rdma@vger.kernel.org>, Frank Zago <frank.zago@hpe.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix ib_device reference counting
 (again)
Message-ID: <20210301173540.GN4247@nvidia.com>
References: <20210214222630.3901-1-rpearson@hpe.com>
 <48dcbdc5-35a3-2fe3-3e3d-bff37c2d8053@gmail.com>
 <20210226233301.GA4247@nvidia.com>
 <3165add7-518d-9485-fa12-6d7822ed9165@gmail.com> <YDoGJIcB6SB/7LPj@unreal>
 <db406802-25a8-bda8-6add-4b75057eec96@gmail.com> <YDyWqLuRw33mU63D@unreal>
 <b1fec0dc-6b4a-8364-2b90-a4ef5cd839c6@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b1fec0dc-6b4a-8364-2b90-a4ef5cd839c6@gmail.com>
X-ClientProxiedBy: MN2PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:208:c0::35) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR05CA0022.namprd05.prod.outlook.com (2603:10b6:208:c0::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9 via Frontend Transport; Mon, 1 Mar 2021 17:35:42 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lGmSK-0033bM-9o; Mon, 01 Mar 2021 13:35:40 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614620144; bh=S8DhnkGv1pdn/zKfkb4yhnXue7UH6nm8CUZsJb6/3ys=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=iRaZpJo16vTFvJZMPjv8omd8EFke0W8egReRjr77T9YfrY2I5I4Tuy32ubZ8Ug/RW
         SocIzUx+Ye5/O4/AEsONOWl1Fq5kCow1L4wDX6Jd9UzzM9dTLp67lnScMWVndZuQQq
         +dbwknqbcKKHGwCyY8FYmNG3XAL1zYs15lCnDiBRcnnO59jD6gQBy9WmPYFGu1Sitt
         X6RnX3ubQaRJ7fMAibM8+FRVXeygOmBixb9IRrQogNDylxNoRKvIpx+Tyuiw1ogEMJ
         y26lrRaQyBd0xLocvCBuWdq6KqNhwsCdgXxHfyhd9P683Eny+rbJIwaQJ1sDGb99Nt
         w9IaicsC/4t3g==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 01, 2021 at 10:54:21AM -0600, Bob Pearson wrote:

> I agree that ib_device_get/put is attempting to solve a problem that it not
> really very critical since ib_device is very unlikely to be shut down in the
> middle of a data transfer. The driver never worried about this for years.
> But now that it's been put on the table it should be done right. A data packet
> arriving is completely independent of the verbs API which *could* delete all the
> QPs and shut down the HCA while it was wondering around the universe or worse
> yet while the packet is being processed.

If driver shutdown can guarentee that all pointers involved in
multicast are revoked before shutdown can finish then you don't need
this refcounting.

It was only brought up because the API that returns the ib_device from
the netdev requires the refcounts as it is general purpose

Jason
