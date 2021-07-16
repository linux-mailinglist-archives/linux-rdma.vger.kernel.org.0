Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892953CBB57
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jul 2021 19:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhGPRrK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Jul 2021 13:47:10 -0400
Received: from mail-dm3nam07on2050.outbound.protection.outlook.com ([40.107.95.50]:18913
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229534AbhGPRrJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 16 Jul 2021 13:47:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTlWSVgmCw2TvjfaAhFYqagPpVSGza23JzdeOqMRXo5Wl+OxhjxIZT+eGP8OvhJFa6Nf1+aMiqlQuahnE742TcmQOX8SJahFIp9Pqy8EFf+uXbUjoO4KEz4APZ6Zuur4c2j+AeuV8wA1rf7Ey9DN8U517pI1HgxD9+8YZxp6DDiOYe/qZ8VgFNr6cMKWJ8c40kzk+fGrwj/qYtEfv97O0HR5tU0v5irUuA170TncrNP8sOmRlBj1fpx5oiromv1ZL/MfE37IoiorsMN73CGeMK9mtoxIxf60k+n4DFPK7jE7WK09LoQm6o8XOs33wDZ2ufbhQ8QBu9DSHtXhKMI8JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cM3J3Qr3SexF+sqoczd5ss+qn/1VmcnXJEEIOc0nA3Q=;
 b=WaSZ1veoSnBeg3yR3BMtIfgJS71dDvd0AYKCAfEIDgRwTtkMyOvfsogVdVqlMzKecIpoMfoFUFHcYY2N1A4xc66qxx9BlOqOe3poverKaoEQfgoqVUJ69FGic8fs24DYOr6gRwWpKetdqDpclhCvLLt20h75xutsuSZL3IPaNcZek6HGJt4gjW93PrC19ICse3YhMULXz9nndDHJkwwvc5Ele0GxBfPnPcrcnvF21u//fiyERYDtP7mSpgS2HG5MPfy4GTkim87Y2D1DYswnZjiu+vCwHQsPFBn7ROENgtQHHRbxZ0hSM77UhDNh1UHkABIBoTmHfgDqYeSQXDuYiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cM3J3Qr3SexF+sqoczd5ss+qn/1VmcnXJEEIOc0nA3Q=;
 b=J+hcqNH0FB5w5fjjx0FfHiToHbA84e1gcrXLJXEpHil0I4zqw0JqObUoSU2NNN1EVA76pE8RhBpRul0mLlwhBW4+Sm9kTIUJa4t4J7Plw6c4GdcNxdh2HNBnWdUsk7xvZzwPYzO5tGLLtgK/94bcdzYNsfXTuinthQqwQjVcq5KkBDQhwLrbrjRez5iz7B9JiFG/5nzb+WHfefvCRXKlcFBCVWtb7ktJm2+E4IpjNRkEE193nN9W4sd+53qzbwKNgkbYrsr//+b4ve6JACz9kTji3LywdInIxz6vTnBnPam2irqSXSJ8ZNf2ztAAdAAsBeoM1fgSniT7UNsReBOt9A==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5333.namprd12.prod.outlook.com (2603:10b6:208:31f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Fri, 16 Jul
 2021 17:44:13 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4331.026; Fri, 16 Jul 2021
 17:44:13 +0000
Date:   Fri, 16 Jul 2021 14:44:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/5] RDMA/rxe: Change user/kernel API to allow indexing AH
Message-ID: <20210716174412.GA768036@nvidia.com>
References: <20210628220043.9851-1-rpearsonhpe@gmail.com>
 <20210628220043.9851-2-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628220043.9851-2-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:208:fc::29) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR02CA0016.namprd02.prod.outlook.com (2603:10b6:208:fc::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 17:44:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m4Rsi-003DpQ-LY; Fri, 16 Jul 2021 14:44:12 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f63d37cf-889c-44ef-806d-08d94881535c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5333:
X-Microsoft-Antispam-PRVS: <BL1PR12MB533342AA6139AA5360FBC56FC2119@BL1PR12MB5333.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8v/DNPKPFpg01uK/N2QNYX4pa+dPLtfTfjXWWAXM6ec2610yohXKzMoBvVtBsDeW0p4CuntD3lfJtYzlSKa6OVcZKVdsgnQSc1zGB0+2iN2HVXt5W+x1SVBqFvt6Qd/8HBbxuVsCx6kPlO6riifzikF6MBZc9SWrIBhBt0gc+YfOO01C28YSD3d2QT36L5BrbaTdyqknAe2AbESyKV1hq7IaxmgVbVQUZH1+ABFHa+0vYyAYWA2OoAlQx45pLiIY0fEeWU0NpPruUFwoqpcm5NLaJrxYaKlBfdje8G7AFXjxBzfS7dDukm72KzrTOZpwZlAGqaXAgs1X+vxAQD8MeRSZSp6kCYEN8Y1HQD2wH+KQCO26QZXycdSjrbMP+Ry68dMSuTnxyO6MxsutKIZGV767csDGkfOFFm4xl9slv5BU0slPykm35KL5QrwMuxKGa3mLxszmFLRLen9C9HKpM9iRcGZRcvWz9LP6xW2RnXy9SC/6LkFjTm+OI7T2wyYElvgJH82jt2wo1GXWOeYvaCqPgAAoQLVtK36zIBNaqw/7ejBt6JQMei1LwOQOjR2wbl52PDozh884Wz5E/SWmayOFmq9NaXBCtTgcjMqqj5WSFP/f5FP0ZY4QT3ZbDSb6U+Z2BaljL1Io+xjVbv0+snPOuU2lvfey3Uty0CTtzguhEIReVmLTdPLKEjzSEfXGPFt/T6v99nXIatyi8iQHdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(8676002)(9746002)(36756003)(83380400001)(316002)(9786002)(1076003)(66946007)(2906002)(8936002)(2616005)(86362001)(66556008)(66476007)(33656002)(6916009)(26005)(4326008)(426003)(38100700002)(186003)(478600001)(5660300002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XRkjiAbwhS+We1ZMw06Kc+d1YEM51FT5zU7wNkFpMHSZHb46fvnwL9C+zaQT?=
 =?us-ascii?Q?Cpji9xY8feag5Kcp8z2YrEyXR+lbaElVcPptAykQ7JfK9h9r0AKYj4tw/bXJ?=
 =?us-ascii?Q?zAIcuujfYOyXwNTPtgH34ZDB+lPRVOXRAJwqeWln6EJwOpJJPlsTX1K4eTwI?=
 =?us-ascii?Q?uVriqowaijyAP+NBZownnpKhAWTXQA8DIaH25S6qUszZ2DdwdS4B1ZgKSZbf?=
 =?us-ascii?Q?hES/8CrhLT0Uayv6crD9/Br8NjSRF8H1r6z23hXQjO0r1N70w4XX2iNai79I?=
 =?us-ascii?Q?A8dgGnBPUFgLBexWladfHVAEc4w3X0Bea47Q7U8KT/Uuaq1WI9DVSz2Xp3kL?=
 =?us-ascii?Q?frWYaPh1Q4uRrZmRyxL1BAXRRpMwN/VjJQ7VXxDHZ8nlJo2EehZP7HqKWiwM?=
 =?us-ascii?Q?b87GLgKDtegj5bDiL4XnD+pAoqEjh7D96Uzd5lR/39/bBJ3VGjdOqKyN8adu?=
 =?us-ascii?Q?1fDqkpLsKJMffZZAiXBAiVMsLfrZ/7K4QZk8PJX1HNRYRML1LmusQqQ8lD1b?=
 =?us-ascii?Q?bciPsoinxONRyxBKA37ftW/ANYmdAw8y9QSAod/u7OOoZdRzdwlqEjx7A0WL?=
 =?us-ascii?Q?5fLHmSyXK+0SGyHMLqm7DxhVbMI4W2pfuu7k6QPPKyS9Zp4rJ8GTooKc/zfU?=
 =?us-ascii?Q?em/Z2YwefTXp1IJupUgRc0CuXDcGaJJILTUsRioU7GNR46SWNvMuWB61JIhP?=
 =?us-ascii?Q?JLjY07oG5QAG1s7U87cvgXAtT6qmEkIaYs30/jBPtrF3aIAzic0q5iDgrRvM?=
 =?us-ascii?Q?uz+DddO7SwFe92vi7MbUgVADqBmLpBolvswYh4Hct/XTB934W8Ua10Hn169N?=
 =?us-ascii?Q?sTXKEEjuhkB1jBc5FkcVE8GlIoqhLX5uUa5l2Sz9lSEtiCpMDgrk75eRiJzk?=
 =?us-ascii?Q?ISp+p6Hqo087cvjq+DXD6VCLkqIeqM2CTeyNmBpLD9dfPYBqFqtyTJIQlMqe?=
 =?us-ascii?Q?CH9gCxpL6a6uGmwrqLpATrXAmRKB1YveKs/KIxAuCWH+Uwsu5GUidJQpTUxn?=
 =?us-ascii?Q?HDpnMZTkgJm/ljxOAtsE8mRFyuDKupNpFv+QZGvbSlpBMaGt0nL+MzaP+aCc?=
 =?us-ascii?Q?owrIAEfSCpsHj+bm5vvJ49awFIvIRJSzrb64M9uFNyjlnssXodOIg6Ac06Ci?=
 =?us-ascii?Q?M5X7qo05Yxhjxu9TpwBKucenTggF3spHif/Tq7k8aUsFitiaRa8zNchd8/2e?=
 =?us-ascii?Q?RfmXVZY/2cv/9kUGdKOivFAESRb8r75dWnlOO+93PbDtLMqF3qPxpHuWfLGA?=
 =?us-ascii?Q?qv7VPJ2JD2cvbP/ZwWFlz0FMJOMziHqQQWPv7xM+uX1ipWv0QocME1FuEcpC?=
 =?us-ascii?Q?+o0W1Di2O9NSII0F3xPll92R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f63d37cf-889c-44ef-806d-08d94881535c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 17:44:13.7432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jr+Z6ahi1NL/fEKGdjbtH94XiAzrIPp4Zgb3YRC1QM4b7l3X4fMCqANeWWY/sBK0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5333
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 28, 2021 at 05:00:40PM -0500, Bob Pearson wrote:
> Make changes to rdma_user_rxe.h to allow indexing AH objects, passing
> the index in UD send WRs to the driver and returning the index to the rxe
> provider. This change will allow removing handling of the AV in the user
> space provider. This change is backwards compatible with the current API
> so new or old providers and drivers can work together.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>  include/uapi/rdma/rdma_user_rxe.h | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
> index e283c2220aba..e544832ed073 100644
> +++ b/include/uapi/rdma/rdma_user_rxe.h
> @@ -98,6 +98,8 @@ struct rxe_send_wr {
>  			__u32	remote_qpn;
>  			__u32	remote_qkey;
>  			__u16	pkey_index;
> +			__u16	reserved;
> +			__u32	ah_num;
>  		} ud;
>  		struct {
>  			__aligned_u64	addr;
> @@ -148,7 +150,12 @@ struct rxe_dma_info {
>  
>  struct rxe_send_wqe {
>  	struct rxe_send_wr	wr;
> -	struct rxe_av		av;
> +	union {
> +		struct rxe_av av;
> +		struct {
> +			__u32		reserved[0];
> +		} ex;
> +	};

What is this for? I didn't notice a usage?

Jason
