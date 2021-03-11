Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFCEC337B01
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Mar 2021 18:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhCKRhk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Mar 2021 12:37:40 -0500
Received: from mail-bn7nam10on2040.outbound.protection.outlook.com ([40.107.92.40]:9057
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229663AbhCKRh0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Mar 2021 12:37:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQMXLv3Jp5XuZ+o2vEmTp+R/ugJgXOgEj7naVP26tsDdPZ99MyPLDuqZsdC6nkOM9nIcOnjua1tQ19HZSuQ1j7SIbEtQE6QWHeJsY09T+qSqCbHkqZMqE8W2ZPuoSCO6PRTkC2Bqk7nBGfnIiIDk8N3ET6LJNc4KesWDlwj2vxBsCYVcYKVgdJQHohviF1H144zMsLLH/hnGzw2P/O/7yyXzvcEZ2fhFYZ5CRwVXJfmUPmvdPkVJ5O6erhYQijG6258ybCq4c1e0LwUCaitmMj1ew/aOtBB85vY3SZBEfRw/UpXQcU3JlD80IsHN/Q6bz5dOcndsFdS5+JjIdoJJEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nN141gRtvJNxyEGOxbPbyr4Q9XfzirjHdKrRmYZ+fys=;
 b=EGcRt5PcIvakvNBws1xJQH1OPnVotRjSVlB2/+JyzB+Gre0yE9kf0P6l7Q6Q24epEqGsyYO5DMXW5s67vixjT/o2y+k8DqjbL9/W0FPg7pIHWOO9+MHIgu+zma0ALI6ZqSlFFsj0IPvhRvoNSZ624qZjTlQvzFKEW+dvTp6XuvJfF7BaIshiJfvbRiQ1yuUDut6qgJ+0ZzE0Aqofecpk7/Mxn0kqtVvnWmviid9PZK303oyM+LYkL+VprK/FC2Vrh4r4wKFhLoxYP9SGmEZMBtcbBWyoIOi8uoCcFtEOwu1tcGSmvjGq6IZoDYCMBoeL+rm7SgOOfsadHilU1hFBog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nN141gRtvJNxyEGOxbPbyr4Q9XfzirjHdKrRmYZ+fys=;
 b=mwsIXU2DUC2f8w2iJhIR4FYu79w7r+SEIO9GUpYSJLNBcnFQ7GOUWYkjGHyCT0Vo/99IbPHTTD5p14M1T/rLhpXlIHgUfWBKNcRUyj8qcUnuHIrdSa/IC5lwWkex9llau7JJfJpHglktCRSIwrxaDzSLxbIfdUUkogFTZTl9nBjgeb+ANB64pRrT1VUm1lFaR8hHDgJ1EZcKuGHjBz/RYUjCGfljKE9XT+2j7WmsDLCVjZvr+LPg40J9uJDz7c45jcC8MH5zu713ZeliePRSBcgsLbs87iM0qbBAYjdhw6iyFxICe5FJ6jdAAfwXrANJgeetyriG8Unp/jkhtf4zfQ==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1659.namprd12.prod.outlook.com (2603:10b6:4:11::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 11 Mar
 2021 17:37:24 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3933.031; Thu, 11 Mar 2021
 17:37:24 +0000
Date:   Thu, 11 Mar 2021 13:37:23 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Mark Zhang <markzhang@nvidia.com>,
        Ido Kalir <idok@mellanox.com>, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix typo when prepare destroy_mkey
 inbox
Message-ID: <20210311173723.GA2714107@nvidia.com>
References: <20210311142024.1282004-1-leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311142024.1282004-1-leon@kernel.org>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:208:23a::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR03CA0015.namprd03.prod.outlook.com (2603:10b6:208:23a::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Thu, 11 Mar 2021 17:37:24 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lKPFT-00BO59-9z; Thu, 11 Mar 2021 13:37:23 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9a8bd51-1cd4-49c5-7907-08d8e4b45500
X-MS-TrafficTypeDiagnostic: DM5PR12MB1659:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1659AA37800FC0E5D2667B06C2909@DM5PR12MB1659.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Ei6grqmGbhztihlsDNRHlzNQoXkPBwisBduKt3W5pXB5D/WgZS1qdvyQ4YDEjJTmUUHuVlLa02qyvfDoJ3BChPFxQTv7sohBROpd9QJhBG56LkXu7fSrUleHpwIltqCGUSNmyG7cEjZavLkTmBgBKvsOI8JSBFf+qgb3ZAki2N/mIIxrlG59Aaz/MTYe5rDqX8W/Xbca2lhB3WQMoJkXJcgE3thEaNNXkZfnu/CCOktU5l9nelH7oKto/YqfNGyQ5YpYKGfXIvM3abKJkae5GlNlRI8teWi7pr5++lYIH7RgY4oXEVtQt93bOyF59Phh6EsCzabqk/Ksou6smW71mmWedSlc2C4P+6LFTjmDhLOhxL0fxul3Tl6iVOqmh91V5M9iqiDHT09bAg+ROcliofdlQHIzzT1uHLz+ai6joej3ccb6e45Zda25hSXykU/EjlyuyQD2cIwQn5GsdkkIemqIP8cMd9jzwfAJJtxRfnYZ9B2GeBoTDxOQWy02mRAI6qfHjsG+/HclsZ9I0RREQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(4326008)(478600001)(107886003)(86362001)(33656002)(1076003)(4744005)(54906003)(26005)(8676002)(426003)(316002)(5660300002)(2906002)(8936002)(6916009)(2616005)(186003)(9786002)(9746002)(36756003)(66946007)(66476007)(83380400001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XguvNmbJeqqSVVdVu5rrCflJf3f2vVeqfKSyhkd7w4+8NxiVlwMN7LemCIW6?=
 =?us-ascii?Q?D365kAtIL6ymrbuW5hcbCd5aV+K/ZPRGnM+lO6XMIkp3Uy4zL9jVCF7EU64Q?=
 =?us-ascii?Q?lUchRoBIPlCTlokoadPnfD9D/a2KaFL3wE12g0OkEGke3ZHGCUFd9rLQ8qpr?=
 =?us-ascii?Q?pytgy2M3tHeQ9NK8+54wZkmXqGrIBVWzVnFaO3DuKy5u1o+wciLLJgYfDF11?=
 =?us-ascii?Q?PCXiADkmVcfNdgBnJRcWnPTvVEzjJwSSMC+narp/Uuc49COy+m1VtxYKCZhu?=
 =?us-ascii?Q?M4jMS+qnc1tQOdD2HHAnsrzqbMQAmTHjLiud6utLfQUxXrQuG0QkthB76PSW?=
 =?us-ascii?Q?RAb5Vhb0393wgWNlIWWQD1QVJxD5bZqymBCqHIPR/KWQcfmvLYxi9Ko478Ni?=
 =?us-ascii?Q?kDH9y3L+Fwa4IgDFeXRbVbeFPBPjWECSgpw0Y/HZ53EVKtYrZmMPxMzeXEul?=
 =?us-ascii?Q?C+bO0mAW1V7E1fvLmSIE2inbaTwaNaJ3Fx0pmHFNpjwvIE+eqRs+q/graKmr?=
 =?us-ascii?Q?mOkQDg2lqNxdQhyJT5LoGOtGcXieC4HIfUJvjHLEjuou1D6IrRyVi8UwN1X/?=
 =?us-ascii?Q?wmJQcFfkGuKiuomA5lgKLVo9AiZJFlkOO47Ut+Gq40JsSFtdMqQpKjj4CHhW?=
 =?us-ascii?Q?Q6dPKiS2Pq+H9oieHAvsa0/BOSsu5cgRLMwCAkJUd3T3bpwORf7N9dyrE26g?=
 =?us-ascii?Q?NDfHEunSqvnzbViaRKJeVU+k9Rcw0LW5cUVUeE2nDUOt4C1zUCQ4Ohz8zN5I?=
 =?us-ascii?Q?HCiEX6EWRspypfIj8UOPONAAZ32GhSm6DGbtc314J1eaz/ZEOxvy9bVV0mB3?=
 =?us-ascii?Q?h0tyGKTcWw0Gku50t+vKgzyC7bJtCgBzGXlpgutsHoJHuX8iUmuvld+XlJo2?=
 =?us-ascii?Q?N/BO8ewaOluxrdjuLvPPkSQSNB9pWRxqdFv+E9tK1NObbSZ5pDrduuWMdw2D?=
 =?us-ascii?Q?RVKoD8/I5wOcqIFdeHtj4LDxI9ZZnRm8T+FaQXRX7tAfHULsLbl/WMEbs7Pt?=
 =?us-ascii?Q?lUPxsdjPjm1kDMH7KggwnGyHCWFtkHFyCOtIWEB3iOx7roMTPRhlyTN0nd0K?=
 =?us-ascii?Q?1qPnCswnh9JpcKv3RTCbh45yR0J85k7S+v88wo5lFMWf1/Y26jesEGpFs9XG?=
 =?us-ascii?Q?7vk2xa07gyYuxelasfvZStzH5PwuWM5W/xtPdGAvleTd53neQwDZmovyyMPP?=
 =?us-ascii?Q?SmkdKmF46YykAhNXP7NL1Cu+iEHUdttm65ZyHBSOy2DHpAKWLdPyRziVnM6V?=
 =?us-ascii?Q?D8NTFagTFcfQBfUZ8Tj109ckUFufB7z7oP3BO6jOMkR+HHlFCAh0HkSckNck?=
 =?us-ascii?Q?HJo7LWCDzMOh9YIScvtEx67oGJli4J+2fs2cI9sn9bne9Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a8bd51-1cd4-49c5-7907-08d8e4b45500
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 17:37:24.7254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IvKpfzGB2CcYLmhJQeRFau6uLxiF5GDyRHNFh7sOZyACmdCyfkG++WoCIRkj84t0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1659
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 11, 2021 at 04:20:24PM +0200, Leon Romanovsky wrote:
> From: Mark Zhang <markzhang@nvidia.com>
> 
> Set mkey_index to correct place when prepare destroy_mkey inbox,
> this will fix the following syndrome/
> 
>  mlx5_core 0000:08:00.0: mlx5_cmd_check:782:(pid 980716): DEALLOC_PD(0x801)
>  op_mod(0x0) failed, status bad resource state(0x9), syndrome (0x31b635)
> 
> Cc: stable@vger.kernel.org
> Fixes: 1368ead04c36 ("RDMA/mlx5: Use strict get/set operations for obj_id")
> Reviewed-by: Ido Kalir <idok@mellanox.com>
> Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
> Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/devx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc thanks

Jason
