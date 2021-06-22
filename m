Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115ED3B0D19
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 20:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhFVSml (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 14:42:41 -0400
Received: from mail-bn7nam10on2068.outbound.protection.outlook.com ([40.107.92.68]:32334
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230146AbhFVSml (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 14:42:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDyqH9kVvSzZWnLuSvqRuRmO4+miGXXnMuv9cn/uReeRs2uveCokBO5VVjkZQmg0NMY1ij+D4vm+3z+sDsav3YjrWtCDf1ycsJNt448+ZUz3PUw5odCCKijnmsZ5i8Gk3QboGkeoSoHOlA+CDKsHIUb/g9EPy5gz7xu+wEO6ZxkC+eg07s+v3MRZgAfR2wHjLo768yDbZu3z1NL+/jM8PwKz1sZK8LkLobBVCyMpKQZO39WJMNDsIVa8ICPOB9JUkpvHVN9Ux4FI35prvWmKgO43reLkYcf+fJxSAWKl+4zU0XxSAMKOtuvGZ1bqs8I0LaNcYTivmQd0JjlEwlHmvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djKxIeKdWebs4gBQHKj5dWQututXFlKMnH9eVYoAZ/0=;
 b=h+BFi5Zrw57XfvSYbh+EpaxqoA0pCN+RU8vFMiqQyeSck67GGzupFKGyNUbY9kZxCNXRV5Br5G7MAjO18oiDWdhmJzWvm0ssVG7cmY/9FdYQ5G+CkbeBOW7bfdwtmMb0deYSA4eK/oxXwFZhNVTfHV8LTPsy48q4aYjAoqVr9nEjIlJg3sf7g3QjW7qWIPZLTMT2hMUAdiXZUNPTp4ZCtUU4ZdFax87nLqZPkyiGn7j3ZCAtRIE6ePw+x+eSwAbyH0veB5owlfNrrIqh3SpmpTP7JkukHcrv35IF8ZXucw/cF8H6K+qkZM/ygsYxvLKBnSn7vlZGdaPtgDNqTyO/cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djKxIeKdWebs4gBQHKj5dWQututXFlKMnH9eVYoAZ/0=;
 b=jRlZunsa2eLVpsLOFfvK0HhHlRLjyOWbMVER6xoacCsh0ZA+BfEx7Qt7he5J4Zzl9ybCMo0qYxx6DeabBa/LVMxSO56YxZPzwuFjdlLrtgHMMSqbGjTPva2SjzI13x5Gt9GqDCLccXBTA6+SVRcc/mV9SYEOmNBqEKFQoxl4MleQHNONE7lkmiuXUdB3qEfENyA1XUZ0VdiQf7wTgg3MuZe9PBpLKyXrugsoR3fsO5T1n0LiecQHarzYmim7MCsd04EOjnB1Sc9BCvKA66SUTfOblPyatRAfbbvSlb2Q9rtR0ZIPAt/ZUUzaQ427hOWutbjgvve6SqLEmOoZHLVSOQ==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5378.namprd12.prod.outlook.com (2603:10b6:208:31d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.23; Tue, 22 Jun
 2021 18:40:24 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.018; Tue, 22 Jun 2021
 18:40:24 +0000
Date:   Tue, 22 Jun 2021 15:40:22 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/6] Fix extra/redundant copies
Message-ID: <20210622184022.GA2595597@nvidia.com>
References: <20210618045742.204195-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618045742.204195-1-rpearsonhpe@gmail.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR12CA0004.namprd12.prod.outlook.com
 (2603:10b6:208:a8::17) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR12CA0004.namprd12.prod.outlook.com (2603:10b6:208:a8::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Tue, 22 Jun 2021 18:40:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lvlJv-00AtFa-08; Tue, 22 Jun 2021 15:40:23 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a408a953-6386-46a5-0ed1-08d935ad3251
X-MS-TrafficTypeDiagnostic: BL1PR12MB5378:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5378A781289534EC8DC871BEC2099@BL1PR12MB5378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FnVBGAsihw3YKw9LpqYvEfP/AY6Ce3ogEbTr60nbsbZj6MdxIl8De3y0GcqS0eZp6MTpBg59AgcsoYm6whZ9qB13u+Y9onq6u9aoz48jPtUiogGAO0xmDHdJ0P/7Zv6ndee5D05Ql5IFEYZNAd50kEZ7wtXlAVVwkMFX5rxIY9JL3W+CppjDxQPFGJbIle0S+HLHBYjEsOfXqmYKNIJl6eLO+R8F8WspOuZdhtesVakR3pRL8yUWBh5BopGLGmK2OmUllryVGXY1Sp6lgdIsXfG31JW7c3aDD+H+Cklk8CznHL8AZIRaSZeXIk0nSOJvypJ4OmOBzOgL0Ap5tMwqNUdGP+X5QOtcB3OZDaKchc7/dnhLk7sJcRuqY7wQVr9hoELiQn9Ma5nhNo17fUpNxOLo4sMM1Uq1kF6zHZD7y3lkGaNoWN9R5mn0CNGnvGSllfaYIs2xeRoW3+8C6qw+0cgz4Ic9JlUI1wnxhigEu7+8C0xrX4LNCqT93TltwzCKe1+I3poc1Nq9iOdy4TF9y6lZCxEaqphbpNwCMj5qLL47EhsLtVYLQpGI8yX8weEgsCMV4Z4z3nvs1fIjGa/V2g4/ua4xqNFZLKD+lPbnZzU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(316002)(426003)(36756003)(66946007)(8676002)(2616005)(9786002)(9746002)(66476007)(66556008)(8936002)(6916009)(1076003)(86362001)(478600001)(38100700002)(4326008)(5660300002)(26005)(186003)(4744005)(2906002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6xUnQGmRZ6PO0dIl2kwSrsxivD0Z+UwAI5uZTro44x5M6LmvEeeZMwlJZCyn?=
 =?us-ascii?Q?+G9wVjKqUzu0JewwdKERxL3B0ePMWRQbARrQ2MiIXzHjlTV747D5TeIKCoWW?=
 =?us-ascii?Q?RVIsxzUBALdWak0YDBnYiqSRvz4XU8Y6dXgO63FUuklrgpWcjl/gWMiom6Uc?=
 =?us-ascii?Q?+zoGBAiy0TRR/bi6wvrTjer0nfkL16+D8R5dSVt9BCy0Nc6ZQIA19IY62TcZ?=
 =?us-ascii?Q?XYm9YQNTf2ANtUvEtX2Bq+XDlAJbSNE1b90lWMJezxE+3YgjvJht1Pmeh1X/?=
 =?us-ascii?Q?Pxr+xTlEOXKq3n6l+kjZ41ujhwdfJmddbIYplKy3MgFKDpAxBdq7nKPO9OgN?=
 =?us-ascii?Q?syo+AkYh6nm+FyTTTkUH4xEx4o3kCy1mTfKC4ZqTljGKdQ9NzyusrGKJBqF2?=
 =?us-ascii?Q?7sEJcRWeAhxrQdrlGhFp+2JfxSRCAtUmrO2WApus+wDI1jz0OoABhGFSHrPJ?=
 =?us-ascii?Q?8f/T9RzCYf/zAro7mt3BukVio0+dZ2qIu+Ll25f8ljJpVdFX6Jl+d1LIjq3w?=
 =?us-ascii?Q?YL5oe2vjj9fx0Oj9pXE6sgqHb0OpbHJ5XYNdo/ngnHfHgiHm8fasVRGcZePT?=
 =?us-ascii?Q?Y8N+aWH3ydhA0YbV+t/BkezaDESUHJT+G51OkKSJewqLwCrtsmEFQeF7xF+7?=
 =?us-ascii?Q?0sIdHD5b/xTziRi64xyKI/eYyFvv17zJI02/rWntoQ2WXBLcm1hX70CYbgQF?=
 =?us-ascii?Q?R5PdhWBkuXduaRFBGFDRzcQP9o8z8Af24jDPEsmkYD++Jfw5NUHB4buzthcE?=
 =?us-ascii?Q?0zKguzy01apal+xhNRs9iMQvFIJ1m0zZf+dtRIHSrgEUo64GIMdv0+LVs3/Q?=
 =?us-ascii?Q?WOC52Ej5HKgHeThQ6uKuSAl2BQ5xaWrUptBaAi45EfQasmNZXNA+YSoA7xmF?=
 =?us-ascii?Q?9A477ES6XOgDG0+XEVXK82nhpaZfDIkB2SBUXR8XAyl2I0UbR+llHX3sPJFj?=
 =?us-ascii?Q?+4PcpzcPCzeNno4btoKMJyfTQKAcw9rsYL6KSqQdN88w3hZVAPicDaLir0E1?=
 =?us-ascii?Q?IvnkARYuDVEudORSopgC9xM19agdmA2/yHW6pMX56CtDb7OSAnoaKudzNZWR?=
 =?us-ascii?Q?+omCsoRaw/2NwGlCRfP3N4h0zXfuZyDvQOzcwaLHIh3e8qFc0HUZHuhwy7cd?=
 =?us-ascii?Q?zlXCbDSmGaZpKRlDFmmw0/GHkPuVaz9cJUouc4oQ2dg2yjmcn9dXNY/tGZnE?=
 =?us-ascii?Q?yhnY9yDYjqsbhZzN3YCdXhM0DNsV2xU5A19X5oz0FtyXkZ3yeFqxxfzMbqW8?=
 =?us-ascii?Q?QPV7a4SSgAAaO0+Tp2DaO1sgPT3SxS0CJBbm3gbt8W/9+GYuzdnFNhvuBtQ4?=
 =?us-ascii?Q?7j/0X4LhAfIluNEu1F8JzSRJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a408a953-6386-46a5-0ed1-08d935ad3251
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 18:40:24.0607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+2AwoKF4MVN99KS571VsZ6ECxn/js4HCFTOssWZQujnD8huqfNe+ak0b+inoY35
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5378
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 17, 2021 at 11:57:37PM -0500, Bob Pearson wrote:
> This series of patches removes or shortens several unneeded passes over
> packet data.
> 
> Applies cleanly to for-next after the memory windows commits.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> 
> Bob Pearson (6):
>   RDMA/rxe: Fix useless copy in send_atomic_ack
>   RDMA/rxe: Fix redundant call to ip_send_check
>   RDMA/rxe: Fix extra copies in build_rdma_network_hdr
>   RDMA/rxe: Fix over copying in get_srq_wqe
>   RDMA/rxe: Fix extra copy in prepare_ack_packet
>   RDMA/rxe: Fix redundant skb_put_zero

I'm inclined to agree with Bob that the network fast path should not
rely on pre-zeroing but each written header should zero or write valid
data as it goes, for performance

So applied to for-next, thanks

Jason
