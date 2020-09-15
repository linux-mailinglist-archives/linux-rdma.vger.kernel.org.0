Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8028126AE6F
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Sep 2020 22:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgIOUIR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Sep 2020 16:08:17 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:16190 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbgIOUFI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 15 Sep 2020 16:05:08 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f611e650000>; Wed, 16 Sep 2020 04:04:53 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Tue, 15 Sep 2020 13:04:53 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Tue, 15 Sep 2020 13:04:53 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 15 Sep
 2020 20:04:52 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.58) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 15 Sep 2020 20:04:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKkbpQhhtogAC6VuvcHUGzoOaA0vD5mJBrVOmaHzTgERsfhxijCwbYqAUyXd1l+Wpy3EEAeS3+pHomY9SFg+73jBJSNRjZCFo3wS79c4EpnugHIsxCyZM6DJCwbkf+QKeYsnZ1D99rbD4T3gBHev7YA5NEUTvp/R3ztCkr81qc8vS7t+5ieE3qsoMgEhBUSG96vrvzOQ9JlNZlzoxpgxEVVdU6ibtYL7pT7s6PeXwCdbVPG5rKXik7Q46+qBvbZUwLS+qgUDR0Yni/2EgyLBSreoZL9gRbzn1FgMQazXGXQpXBP6l1exGXA3t668MDePeiREVvTXE4BR6n5zP+mHSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2QDla0Lm/dMclSQdZWfo+S3lHmSrKjutEFebQTz9Hk=;
 b=dKAeDq2do3r1AzKXpmZDT6H7KfjrUbug5zFnqoWyn/VT4l6Ft53e2LHC4wzxMGNufXiRiMF8jf2HuDzUA6LoQyAL9IZJ1U21RAjJJboGuCKTy2PNAwbZTIQ4rdTpJqRrEaMRV5jFrAqBkWK9zFDkh/MX7tdlJp1dL0LQ4FN5kyba5H/SHbhyPOaNb+gcdpuN/r+furBwShETnAODYVNDHNkOeUSUVnwevfnC2vc1lb29YfD3KNaSwSME2Ohe2tCYzBSXfs7srLzDZrlEvXhYwVyn/2lLcb74bK+KMpsvkqQZRvaz7OiEieAhkJfouNA80LyLDsjv1SoaE4nHjIosog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0105.namprd12.prod.outlook.com (2603:10b6:4:54::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 20:04:49 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Tue, 15 Sep 2020
 20:04:49 +0000
Date:   Tue, 15 Sep 2020 17:04:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, Alex Vesker <valex@nvidia.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next 2/3] RDMA/mlx5: Allow DM allocation for
 sw_owner_v2 enabled devices
Message-ID: <20200915200447.GA1592810@nvidia.com>
References: <20200903073857.1129166-1-leon@kernel.org>
 <20200903073857.1129166-3-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200903073857.1129166-3-leon@kernel.org>
X-ClientProxiedBy: YTXPR0101CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTXPR0101CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Tue, 15 Sep 2020 20:04:49 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kIHC3-006gQj-Eo; Tue, 15 Sep 2020 17:04:47 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d78d5fa9-1762-4921-215b-08d859b299bc
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0105:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0105DFBB43A4623283ED8C3CC2200@DM5PR1201MB0105.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +t45H0B8ByjqMbA+aayF7c6TIQHjgcg+IMpL3VJy/LwN40W/GbXZPxt7bPWznMUp4xhpJreeUQTI3esQ+/tVX4qTr0uHOfyCNmXM80TTzPYuzL4JWOuZFps1RN3qKqwP6VdUnDHP7G4MwRumUWPZkUoCzFW5r7tCP6A7PWBAkLouLiUDNFtfu1D+ZfGLwZmrlOSZEHqBH+nlzLqSbR5MAVBC/E28sw9bMJIUYvapd/SFq4spnk2P/++hz9LcGEeNex99VANBrL/A1eoCCiJ0A/6IKsoP3zdW9Nq/RdHuxHURrgafK1M7NEPgaL+O82p8iBczMhdtVQVipVd//oQBSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(478600001)(1076003)(6916009)(186003)(36756003)(4326008)(426003)(26005)(9746002)(8936002)(8676002)(2906002)(83380400001)(66556008)(9786002)(66476007)(66946007)(2616005)(5660300002)(33656002)(54906003)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: aYoB/rFvfJ1KLQjWzxgIg7oOPXRfr/FwNGUnLQJERKgA+t8EGkt12ZUa6zsby3VqUzkj3riWxVUmB4WaJ3tNJLcWyzPgc56V7eGhOHJQuCPiWMUM/0fIa1rHngWLuJ7P+nh467D4EoDOegGrG+wedUAeMuaMIqLCUy7JzVnggY4ier2zMRAnDJXK2/mVpPEgyjyJk7qb6XfP3+1FhRFZcI7ofV48VKRVAMIl/v+4DqZlxi2E5DiCHzbS250joXOqL4Z0YI0tPcakTPS0/pjAZMnqNq1urHp7A3ugVjohq0gmAw/5qHPTezwfoWYWMdCpvWluz86ZEXd54eyIuKWoJo8wGCK1Qu15AhIwILOjy7f6h6hf2MhFmnF7DlXEVxmk7GaERc7AMtCLq/pwesVNrIRLNoHjHDZwz5DEcbIE8eHeuacLWboB5EgYC5YVXFlKnb7joS1sEB2dJ0cfJLakcEbO1S89mql2eGYRKT9+rlasmQUnHyNyuk8E8H0JIacF9+YLvuTHaAOAd1HflY3zUvSW2ONCGO5Klre/Igtx9LjuZXhtGTGtTtK/zUBvKhYWKgTNUiSIQ6v0pfvSIrQejihTYrNpsnJW82VclCahkCSH36GspDZ4n74eVX4qImuyfuHxxJea85INlzP30UL4bQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d78d5fa9-1762-4921-215b-08d859b299bc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 20:04:49.3687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FtYYA1sJNAMH6hmB4nsxSdvBLve6QxjgACZRtMt97JIJjoTEtnvVa184Z3qy1sGX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0105
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600200293; bh=s2QDla0Lm/dMclSQdZWfo+S3lHmSrKjutEFebQTz9Hk=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
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
        b=gUCBkSWk8f1LK+04l+Bk26c/smetWIaJwPkeqAm6YRqIqKV4SQ7J25TKKhSx3mljI
         fXsGH2ZaQAjp9oOZCsOcTSeA6R6hBIxv8OqtusXa1Lh6FzzmpIUvgG0nSmXzeyzlqt
         QKZjoAcJQUvihgi6LSeqUBh+WTnRO42GP985QX9vdn7ARqHx6/JmeUwyROwhxFOXF+
         urfrrQxmEPS7WrA2BOufujRNCvjZ/El84hUAkN0d6xTYuJZyt3DJsA6bTXOVEoBFKe
         law/FoW3BeO4r2Ae5nvEC5+UAvAHGpWtfHWbpijcvtjKWsplqcQvlwv4umZ4XjU5Ep
         R4sK4j/gZqxOA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 03, 2020 at 10:38:56AM +0300, Leon Romanovsky wrote:
> From: Alex Vesker <valex@nvidia.com>
> 
> sw_owner_v2 will replace sw_owner for future devices, this means
> that if sw_owner_v2 is set sw_owner should be ignored and DM
> allocation is required for sw_owner_v2 devices to function.
> 
> Signed-off-by: Alex Vesker <valex@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>  drivers/infiniband/hw/mlx5/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index 99dbef0bccbc..8963b806ad19 100644
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -2343,7 +2343,9 @@ static inline int check_dm_type_support(struct mlx5_ib_dev *dev,
>  			return -EPERM;
>  
>  		if (!(MLX5_CAP_FLOWTABLE_NIC_RX(dev->mdev, sw_owner) ||
> -		      MLX5_CAP_FLOWTABLE_NIC_TX(dev->mdev, sw_owner)))
> +		      MLX5_CAP_FLOWTABLE_NIC_TX(dev->mdev, sw_owner) ||
> +		      MLX5_CAP_FLOWTABLE_NIC_RX(dev->mdev, sw_owner_v2) ||
> +		      MLX5_CAP_FLOWTABLE_NIC_TX(dev->mdev, sw_owner_v2)))
>  			return -EOPNOTSUPP;

Shouldn't user space ask for MLX5_IB_UAPI_DM_TYPE_STEERING_SW_V2_ICM
types too?

What happens if old user space runs on a new device?

Jason
