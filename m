Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE7142C631
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Oct 2021 18:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhJMQW3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Oct 2021 12:22:29 -0400
Received: from mail-dm6nam10on2058.outbound.protection.outlook.com ([40.107.93.58]:17825
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230212AbhJMQWY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 Oct 2021 12:22:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gd0EGN194tSHgvOiqF7hViKq9a1FhMB81aldN2FRQ1s/0Ecw1jDIJq3Lj8p1e1fQ66xSTgBY0ryva1eMElZ1kFsBR1cQ77bvqAUy3bA+NDbrDaPA5l0sNbhvDuKNJIp1gt6hXPmsn7h/suHCi/m87fTkho8YcFaG4XqS3Mm+Zc9qCzXhC4t/381lE90FSAfWhQDYYNLfWqFSwrQEAVL28wSUcbD2lPRLQx5aPLWSIuy8Ew1/1rO0akwi5OloYfUgTXc2IAcq2xyiQcQGT8Q+jGSKZJV6V+Mye9VR3VMhW5jb4dfUnusUop5Hc0uSDMeK+4ScSsaDtF8oE5FcVMxQZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHCuxDpxuvskpek7oTNmQ5Tb/914WRFdidyAFzuM0wI=;
 b=aOw8LJ7+ZkYOOIxm00Id3c+3IkvJcwh50l9lER13x/Qw0RHzFvEFMMyzwpbHFnKkOsMrMH6HZRatsRc6T/iLTulJJelV+6Js6hmQk0ehBbCnZzN/bJxRBCR44QnXMMJpoMbq3fyiXmglV4HjwxDsM/Izz8jA4FnMDhuGQToNbjd1YxqxpP6zfbiUNxPiRnKc27Gd9/tyzdNs+asMD7f49GqsnTEI/sJNTWEqHNAwVeMN88SnKmrG7hrlp3kj59LgUD2kTc+BxYkFyfzhWMe/AQTz9Z/kBRIaOITudh4rnquFXv/82d5NUqCQGaB0PC669PfEqFWMrt3ASRF2PrKiZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHCuxDpxuvskpek7oTNmQ5Tb/914WRFdidyAFzuM0wI=;
 b=eEWGCcMO4tDcQZGMj6czW0uIvPfhsUtXNP4zlJwUOqq7ThirTkXuIaC2/mKGNzN7yw/Vn704JGdM/+DkdKmnY3Lo2OQRI8Zx54S3MKPYHVH90x1U1Hi/Ck1xMR109rKWpOyGcShJjsCet+Kx/jTI9lcmvDsYpJiTM/QkVaHTYM0LxwfHUujfmSTM3eIi1J+Hw7xzHDuY5niFMxAhEXjhqo9x850n5fzaP2aZZbxP8EP10EVWL6cEiunFK95OXBf+N5atdA4c6nstDY2xKUbSxpneoMLOOCF5XPD9UEWhNeJFQ+MKk5jtUDykZlMojRi7BrNquV37Fps7gy+OORDQZA==
Authentication-Results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5158.namprd12.prod.outlook.com (2603:10b6:208:31c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Wed, 13 Oct
 2021 16:20:19 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%6]) with mapi id 15.20.4608.016; Wed, 13 Oct 2021
 16:20:19 +0000
Date:   Wed, 13 Oct 2021 13:20:18 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: Kernel warning at drivers/infiniband/core/rw.c:349
Message-ID: <20211013162018.GI2744544@nvidia.com>
References: <996fa723-18ef-d35b-c565-c9cb9dc2d5e1@acm.org>
 <2b07fbf9-36b4-37ea-b203-7d0a2fc6589a@deltatee.com>
 <a9d05dea-860f-fe77-fc41-19208d76d9c1@acm.org>
 <6ff6b13c-d5c8-eec1-6949-5aabf28a5e68@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ff6b13c-d5c8-eec1-6949-5aabf28a5e68@deltatee.com>
X-ClientProxiedBy: BL1PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:208:256::33) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0028.namprd13.prod.outlook.com (2603:10b6:208:256::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.7 via Frontend Transport; Wed, 13 Oct 2021 16:20:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1magzK-00EX2D-J7; Wed, 13 Oct 2021 13:20:18 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72e2ee6e-e318-413c-e044-08d98e65597a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5158:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5158138398F62F175F2F4FF4C2B79@BL1PR12MB5158.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uGemDSAJJwm10wYMDqGQKCZEeEBj0d5ijMUXbt5mDIlLL3SUO1eX8uPBrqaRxKfbdE6AVhLLVmdr3tQy7aBOfJMUrmM939XDI15VD5YaU68gIsYPfFERD/SJmjwWw1VE6at/2aZzvMMFtDpTsSmftk/jLQnHatGkAC6VExj+M2dqqSf6HRny4aqlfS1W92kwTnPJz/pVFV21ztB+YBm1tHMDBLN0pUEaUvr/s5M4bUsytAMkTlvwoeW+kiyKy0ZeZCne+H9k37Kr5MEwMDR1BkuDOLwehbA2FDCM9e8uwJLPgkDo2uWqUHBH6ydGIastQaK8DX+mFdk7wXj2xatTIv/0TKfO3t1mspqx/6yDJuVZoEKNxS4N8iwnUh6Zhu7dJ1H4IFlctXcZXKc9Lw9/As1yNj1kbNa20qzBY82yfrHg5VBi4jmrQEvAavS6vAIrf7tLSOruvH7XuTzW9+yJf0KFmC8cw7IbRi/gW9x6Ov6U95/LyCzyBYNeaTU2NqLbPI7vsTGCY/4wUfwgXyctbNCQSlEtrJPSu94wOe4Galb4he4hgkdG6Q4wvwsX7Md1pIzUXWH0iLw1QXuCCK7sRKQjYL4E6bTDjN+wIuDH7apkGufnIH4iCAMw3Cs+a5J7e2gWWey9qN+l4AVpRylwvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(36756003)(66476007)(66946007)(2616005)(508600001)(54906003)(1076003)(316002)(6916009)(26005)(426003)(8936002)(33656002)(5660300002)(8676002)(9786002)(186003)(38100700002)(4326008)(86362001)(9746002)(4744005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mFtGGPpdPuWic3sCvD/ZHHtCtj+TX0t1bhyyGqt8IJvjk9Yt0XOnCs1ku7Qe?=
 =?us-ascii?Q?YG2q8eB+2rA/t6hkNJXLwD9e2+/kg2G/7SVa3J5yeGPDLg+XeGWGvYKqCVSc?=
 =?us-ascii?Q?lSVhhJLn7FKDq2errmZQHEisR/TEz8sULlg7xkiYbJbx1ZoF360ppPX8NJkw?=
 =?us-ascii?Q?IybQPRcFY76+JzQddtusSQ+BfWjx/ZngusAuwtZE6IJF8Lzp6tfB6eqqzwe0?=
 =?us-ascii?Q?tRRT59MT8kunvHeO71XjFhOZSmQhkMDDpqhmttsasnWQZd4P058qxfZ4ciGc?=
 =?us-ascii?Q?6JS4cxFGGp+UEZK12rwnjznWCcFjDiPe4Wesq02vPJ7nqmbian/7CFI6JyAY?=
 =?us-ascii?Q?l1rDQbnBXr6KDLzcEsMp7P+9s3WzaNejeG7Jxb240WAA5dqT6Dh0F5LWBjWn?=
 =?us-ascii?Q?Fr5lTYGaPcFImGrCpQagqSi+T01/lgI51gsNZH4h3dskW1fIWFTbH8PnX1Sh?=
 =?us-ascii?Q?pbxOWkppccwH4sSGTjVwCwEcPudt2XCH03iA+aziENPU36Nuz6+pZHVf0kcc?=
 =?us-ascii?Q?edrdz/6wEZMWofR76WT1vxyT9WCUNV+3/nPqNpckGOp2ArTc9DBDbcilYex/?=
 =?us-ascii?Q?oalJq/Ynv5RJItkXPjimoJTYHyZkwdpVovq28n8HO2QVBnbl+ZkG8w4bIhG8?=
 =?us-ascii?Q?tK/Gq6uJUXN4TOS0//h6XLjGwlsPFkDaHVnaZfYGFm9U+XXnAdDJYdD97kZl?=
 =?us-ascii?Q?Wx3VVyjErJdUKPrWnSjOoNFyRLiUsI6jkMFQzMvqpXJKiIAXkAoSMsZTpwJB?=
 =?us-ascii?Q?UFLIiE3c2usK4LUEZ89CPMX2NB7xO4IUIX4vCLpRcY1hsYFszxlIbj8+FBqq?=
 =?us-ascii?Q?6+TKy0XY0+PacDONQBJDAK7PL78lZsQkJOuJLHg+p+vd2F++1qCcBwJ7KFki?=
 =?us-ascii?Q?Ul3CZFi2f1JnXeLbbpz9Wh0KE6e20hvJiWgl6CmVWfyWStkdhVDkXcmNovre?=
 =?us-ascii?Q?OVZnaf7JOPlGVYdZXzjyrHoFVB/rYiz9WOQhugKHSYN/JceytS3a0GNHLGjo?=
 =?us-ascii?Q?Sm5+0BaXAtDfzWShcJLqUZfjkwITTSbT8BgKgO1upgeTw4J9VMQiJzMB7BUz?=
 =?us-ascii?Q?M+aKlt++XpF8d7TBmYlBJ533TirI6BS7ORpJlfSuK49M1zPV5WwAcY9fqpzD?=
 =?us-ascii?Q?yPhITisPsrgUm1pkeCxDp/UdPXl0C+UFTEkS+rT1xhuCN4N7f/8M0rB3h17x?=
 =?us-ascii?Q?Gyw1ks/2JIpBLF5/LwacHwx08bV7sV/msSwPDDWRG+ikQrRbZeyLFQ51LPop?=
 =?us-ascii?Q?df+Oq/HuoMG4ImzyL+6qkFWkGF6i1/CfvKEPeKche4r5Qd1Ltbmut+hkyRX2?=
 =?us-ascii?Q?TV/DVvbRoHmhPwzdr4UDqh36oUFYOkJSYpl/aopmnOb6ig=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e2ee6e-e318-413c-e044-08d98e65597a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 16:20:19.4777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WL0QlL2EnTZ2PmAJ9zRmklLKezS3F8HYfCNYwUWPmmUfarqSHeU7Nf5OSqwKCylZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5158
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 13, 2021 at 10:15:59AM -0600, Logan Gunthorpe wrote:
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 4b50d9a3018a..4ba642fc8a19 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -4097,8 +4097,13 @@ static inline int ib_dma_map_sgtable_attrs(struct ib_dev>
>                                            enum dma_data_direction direction,
>                                            unsigned long dma_attrs)
>  {
> +       int nents;
> +
>         if (ib_uses_virt_dma(dev)) {
> -               ib_dma_virt_map_sg(dev, sgt->sgl, sgt->orig_nents);
> +               nents = ib_dma_virt_map_sg(dev, sgt->sgl, sgt->orig_nents);
> +               if (!nents)
> +                       return -EIO;
> +               sgt->nents = nents;
>                 return 0;
>         }

Oh yes, that definitely looks needed.

Jason
