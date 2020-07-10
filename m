Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA28821BE08
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2020 21:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgGJTqx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jul 2020 15:46:53 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:5722 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728276AbgGJTqv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 10 Jul 2020 15:46:51 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f08c5a90000>; Sat, 11 Jul 2020 03:46:49 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Fri, 10 Jul 2020 12:46:49 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Fri, 10 Jul 2020 12:46:49 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Jul
 2020 19:46:48 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 10 Jul 2020 19:46:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUPjZeHyd5jJg0M57zRhAHmu7DFIAa5gC4Rw7nrJQtgDZGDAOxO6aibM0LHlIgiL92yEuedKvkLIN7lRq78KZtZNzpyd0PFizrbIDrP7Fr/u+TswQWEHeHlukXgkiTVCIfGH+hs9TFZfQYhQHQSX2xPoUhZBo8B/BuA58TRiwU9hvz5+zIIZfM+862LuKbLbUFtktzg1aCzwVztcjQqjrAMwS24Pi74dskD9XK+Wu673H70HrwwrFbbUUiKcH5GvQh2zL92/Z7aT9VuTm/1aC4/oqsswDAUx4tAK+8lODz3EDSd4HjQuGsy5j3J1rlhPYmE/pegkBpuzUjvApVCGyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCcz/EQXX5GiImacsYN+y+JuHr2mAIlxU5PExUTM+X0=;
 b=DeY2cyrAvWV/eQjJY96VaMc3JYm9XWZISbopp9bs6/N487jmi85qgK2q5TuZSR0zyMsQpPa+or799xlN5VMQ7Ovt8d3rR0xLaKAs2yRKJR9iYoFIG2OLU3ljYxmfmlaEkYQH8uVsMknVJwmd4mXLlCdn+JNfVsBUn3oAZgwskNIz1sntJASgo0+HUAiDJDhx5Y+HOydUBcCanOLv9bX8Dhf+Cacv/stSxpDcNl5+A1MhV3JTej+xhZ6D5QkSk5X7hrljLba34A6eWNwBbHB6uBy1KOQTJtQTubOZSEMNETXyuEvlFTFgo/5Wi0NyF4AuE+7x/U4T6+/oITPBshUuwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3513.namprd12.prod.outlook.com (2603:10b6:5:18a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Fri, 10 Jul
 2020 19:46:45 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 19:46:45 +0000
Date:   Fri, 10 Jul 2020 16:40:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/mlx5: Remove unused to_mibmr function
Message-ID: <20200710194054.GA2129968@nvidia.com>
References: <20200705141143.47303-1-galpress@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200705141143.47303-1-galpress@amazon.com>
X-ClientProxiedBy: MN2PR01CA0050.prod.exchangelabs.com (2603:10b6:208:23f::19)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR01CA0050.prod.exchangelabs.com (2603:10b6:208:23f::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend Transport; Fri, 10 Jul 2020 19:46:45 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jtytC-008w6u-Ez; Fri, 10 Jul 2020 16:40:54 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1e45dde-2ba8-4a3b-7a39-08d82509fa31
X-MS-TrafficTypeDiagnostic: DM6PR12MB3513:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3513A166C390D30BEF96F742C2650@DM6PR12MB3513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 046060344D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z0Jr+cgCFYrorTYZ/dglAmMx+M4G9OnP+5jnsu45wiX/Yh/PhJWG8gIIUWRA1BHCoZF66mK2GaHDTp8CFr342e5ZmtLeeZxR0C3s6Ab59I5pk1nIHQFJylqREoGFmM/459Ejys2U0TZyTC6tzaBJMVfBDs65XP3EMfs3NNKfg7gDg9a8wNCJsyz8BgQCB/bgBid/XS46X9S0FPPJ+GjAnk+jPqHcjdyDvChWIk84e5FXgdemAj+g5z8nf36i/jrcrFdIqXsswBPGhJ9VmVUWWrGgHm5nZOE/vvGGqHfVGXa6SDIw+UmFPfSOO6Q1/I6y9tPRrbBKZUmk3R1LwVEJqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(83380400001)(2906002)(4326008)(1076003)(33656002)(316002)(66556008)(66476007)(54906003)(66946007)(5660300002)(186003)(6916009)(26005)(9786002)(9746002)(478600001)(4744005)(8936002)(8676002)(36756003)(2616005)(426003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: quvCkwkPti9YOTq1mjucpSM47DJmEzRnkfGq4qS4bm3tHSrCf+vKvy7JRU7rwkwSsA1HcJKSJxQfPwt+h7iJz81su3RhgNSaPzzs+mCRQvGR7xTUNXHAetd81eItFp2VHX8W50pu0evTIgASfeEGLpZCgIe7CdAr/q1oZ5C7TnKJpkdLAMoAltO2oaRX6144grB/FcjG+i5L28kJwTs/sccW/DOUutMobfJHRTSGu6jyH8Ui9D7LbndPB2uqwiNCw6fhIyqDmW7uuVZOu89ykGAyzEskfrr59d2VsT3fls2/8bUiIadcqc8NIEyd16Sui7xxKKVXDDyxSA/AGc1rF51AIyd7602lWpkr9T4nKL/pULaLusL9yXQaArXPB3mOlmlHfi7GcIOHuQIdaKaSOrJh0LnNby0cUbRNcyubkdnkeaGkfNed8qIttwbMcNSuGq6szYEiC8mtxbxHUDrVjyPnZchRg6mDedrvWm+yqmI=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e45dde-2ba8-4a3b-7a39-08d82509fa31
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 19:46:45.7893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1yFYnZRohXNBYC2c2qNcvVV95XUAIOPmgm+WihEiorkb6rk7tU8HZ2G/rjwnk6W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3513
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594410409; bh=NCcz/EQXX5GiImacsYN+y+JuHr2mAIlxU5PExUTM+X0=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-Forefront-PRVS:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=N0WesMwDrIbMFzbyZXVbZIgmiryTSu9hYqcSqFh27yIY7Y9b31FxuIuFQEvjKthVh
         U4/7nUWpSzAwoSrYIBUC8lJpyKabaYITyIlm32lcvG72xTIC3coEhi2AkiGv9gAqt0
         FX6UpvYYQoLi4JrWJ8Ta8phYRjkkKRk9G6LGlFrXsg2L/dYHsWcoFZLrXXSWWLEfBr
         7xu8xP6WKq50A+nS0qtlY0h06IR/Ip9bhSm3+osq0mBFj7M3VHu4764AGKZaAsQSFL
         VZE4gbnBbU+GRJ3nank17Iibg9xWDIl/WOBNz2zXDhyk5mJZw9kpoxemtt1E8iC09m
         zZ/wm8FBy3O8Q==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 05, 2020 at 05:11:43PM +0300, Gal Pressman wrote:
> The to_mibmr function is unused, remove it.
> 
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> Acked-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/mlx5_ib.h | 5 -----
>  1 file changed, 5 deletions(-)

Applied to for-next, thanks

Jason
