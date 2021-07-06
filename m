Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8923BDC5B
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jul 2021 19:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhGFReJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jul 2021 13:34:09 -0400
Received: from mail-bn7nam10on2057.outbound.protection.outlook.com ([40.107.92.57]:44608
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229949AbhGFReJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Jul 2021 13:34:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KK8pvNRdQJYYpn97y+TI11FjxvE09A2kgyAC2ux4T0SCrRbuoVXIMXGpFg03SvOuL3op6s+2ks55xDMJiAsbj1VP52VAnUGPl0YybCqbT0NO55jNo4ml6sMEVx24u617Ap4jqlptqdK+OetAGPV8NmpCESlSsieSEXpxonoMmCZWjAE5lcLznlHe2HOE6Fe/tmwkit5WiBvaUTHWLF1cRUk2xLKJEY4vQ7UVSMLTF7u5ufjlgWJlEa77YM8VT95kY0oJ1UEJn4hM4UkEh+2SDKwoYKo7dPWGkCB8fud3aMJLTI6rJP7DmhtyyMUFUg5AYrrptlPdb25CZx4FLqvRkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUoxQV6ZcTWC0aGbhHHskn2bFL9s+iQnSi4H2usKNkc=;
 b=KMZg9kK5RDquj4KuDwzjLWNn7GxrBER9x6yCu0d2UIM7AGgu9qij7VnillQuXEd9UCzX4QE9J5EYh/IvtyGYjI0IL6GGzm6tmbeD5rd8e+u6oumiDFj9AvHC15PI2564NWj6eiRzaPopISLxuX4JjNOJ8qRO2jBoGi5m62RdMkFuSdpcbKE5DqTkISqcFZv2aznXWvpvO+HbbeNAawzQ4EDF5KCw1hmlvADdwUw+U/32vZfozDP7Q1Fh0u8jPXsIM+8mwHxfrhZljmluPfguFhypUOOYny0DIOOr2FgmGi1iiw1ICHRs5yWGtvvt6UZsOcbIObHEsceFoXArkvu7zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUoxQV6ZcTWC0aGbhHHskn2bFL9s+iQnSi4H2usKNkc=;
 b=RORIpcJWY9QaDlcPTca5mj7kIlbudqg5+Rn9ZKyI0bu7dxmr2iVMbWdz/SFem6fad/vzIaaBDfD/cVSQetshrAhrmXupfd/CGWIduRc1edyNdupde5ozhDLLQA8vWWejgBCD7S2fjHQoqsE9tgnWfRQYxUhEcP97dF/tQ4eVVDLjs4Wk+Yl3cdi5w4WRk+vfaSj2jTgY+KVqz0KA02F4vuIlMP+923vOI1wGTFnNoaJqzGXioCuI3MIZiwl/K83AOCcIpmPSr5fNpPj8ULPtyGri/ln6P+Xay9j8Xk54eamUdZdHrIo33uc0RbiJbMX/VNqDI7iCS8ErhEnN+0kEeQ==
Authentication-Results: 163.com; dkim=none (message not signed)
 header.d=none;163.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5030.namprd12.prod.outlook.com (2603:10b6:208:313::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Tue, 6 Jul
 2021 17:31:28 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%4]) with mapi id 15.20.4308.020; Tue, 6 Jul 2021
 17:31:28 +0000
Date:   Tue, 6 Jul 2021 14:31:26 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Xiao Yang <ice_yangxiao@163.com>
Cc:     rpearsonhpe@gmail.com, haakon.bugge@oracle.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: Question about ibv_reg_mr() and ibv_reg_mr_iova()
Message-ID: <20210706173126.GY4459@nvidia.com>
References: <56061c0b-89bc-4ca1-599b-c47ce9a5e5f7@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56061c0b-89bc-4ca1-599b-c47ce9a5e5f7@163.com>
X-ClientProxiedBy: CH2PR18CA0042.namprd18.prod.outlook.com
 (2603:10b6:610:55::22) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR18CA0042.namprd18.prod.outlook.com (2603:10b6:610:55::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Tue, 6 Jul 2021 17:31:28 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m0ous-004VAr-Sd; Tue, 06 Jul 2021 14:31:26 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 936a8e8e-e19f-478f-4c5c-08d940a3e2f6
X-MS-TrafficTypeDiagnostic: BL1PR12MB5030:
X-Microsoft-Antispam-PRVS: <BL1PR12MB50307BD159A50951D1745B12C21B9@BL1PR12MB5030.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7upQI/e/xcvwZW4bFMbVS0pHdHufo8RX9hBGcQYRQmkLzWNqBu6yKnls2Y42DrOruYVy31sHavAwefcD4O/8ZxwLDNitQoNNL2t52JQW36+7pNF8h6yv7AtNp/h7In3iI4O/00v+8oifT2fTfE8DdTxEyFkzLzRFt9pEBNAYzMEQEC9GU5KdqI134aKoCxXFy8N4bAgbKxBiDF3q+2EqyhZaQz6WrwCjO5pQgl1638F0F0hUsffzfVSWPVLUTFFL2QLOpiNZ01VDRg3nMRyG7VxMlez2d2UEV7Xxe4dxeakHQtxbfupZFm/vh8ybogHWoG72OTEfcTPlqUd+YyFfj7nMHfJj5bVsX4bBGMx/z/sksk0dh6BhNT3dKwh1YSt/aCYDhPGzba2zwmbbbo+E51Fxw9HHfG0cWOrSUIyfBMyEFZ1NERkhxuthBPv9PJcm5IJBbFCpQOdEl+Tc268hVzEnUUpMGT7Qb2H+b3JhrB7/oIHFIWm2viT3LA6AjrRje7GyPzuTul54hcdlwEXn0TvsU+OINhjsJVb1YRZBuMlvSFytS2F+X2cHSSAgoY+aAHoIPBwNSxAWDvxB0c+xEvhUWMGGcc3Un9XyBnK0bELovDIU3zWcvQg+QEVFaRtIDdbGcDiFZTVX67Ojl6hzlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(33656002)(6916009)(8936002)(4326008)(36756003)(38100700002)(8676002)(86362001)(9746002)(9786002)(478600001)(66476007)(5660300002)(186003)(4744005)(26005)(2906002)(1076003)(2616005)(66946007)(426003)(66556008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v8YiyqMb4GP+I6Eb43VsEWp49v8ikW1bza9xi42EjK0A6R6AQ7XMXK5bYm7i?=
 =?us-ascii?Q?9MPX7hAZDNHxfL1ShpSwy4BK8Uv4MvyaU+y+cIl7CAKeg7C4WdGMEIIbPirX?=
 =?us-ascii?Q?wkiknNwSUnrxEXVM15eXF+xcLxcf+fYcpYtkaMLlILDaUf2Ich/ftS6mJB7j?=
 =?us-ascii?Q?eEcok4CrvOM6wKLPwszrjdmZHmFmThYvpecHSMFnQCldvqfo4DC0G+lyv7r3?=
 =?us-ascii?Q?tULKMl3Db/VKHBja7pQ0PXpaoayDN+/UVKG3mXZdlfGgnB7tNtHqJEPzGUbD?=
 =?us-ascii?Q?d+ZKRJ4qDJl/FczcHWPY9221VBohasiqCTrQDb2QzwH7/QFxdFfFyDIyrPT0?=
 =?us-ascii?Q?RCucE9SLp9JcBVMpfmTbvLeg4v0Bsb/HICnNA520HhwhN5LBt6UQpCmsAs34?=
 =?us-ascii?Q?2I5CUNZBdTZdwM6dW0u+EJP24R0vQN44LUM4TkwGrtLxpvpJwtfPgbov0yJ8?=
 =?us-ascii?Q?JX8WuUyLvyLVjN7JilTBTZOpkaYvUqeq0xOUN+gXBXd9P+9KpJW7VvvJ7/2S?=
 =?us-ascii?Q?Lek2Gl8/CETAQfn21Hg71Ym+fCW7IxqFw2mBPiqbYNpC6LbkOIr7h2kDfbmP?=
 =?us-ascii?Q?ch7xPRaz5BT/DLP1OLZe8gozWGlDJ5UydSZX3CckdXZsnge7gZr6PF01s/iO?=
 =?us-ascii?Q?jaguJi+AuP7r5mzWgidPHlO1x72fYuV4lNhBghj18+KikBH3u5Mv5Mt101d7?=
 =?us-ascii?Q?2870CjRNYpwp/ZqrH36KhmA0F+F0GOTv2LuMj5dqO9COe8jl9Ryy4zMUNnIg?=
 =?us-ascii?Q?pHB+JDWqO8yT0bM4IqWkELOtiaOR55sMJh72fPdS//kPe6EQFFqG7yC7ky7u?=
 =?us-ascii?Q?BOlYbxccrUcsbltSqISeMrppU+tKlSN/TsLTpFEhClpQ1uEizIoVwXhVoK4b?=
 =?us-ascii?Q?u+oJeD4lsSRweUbN3arP/Ht1/GvPW3a0/i8rF9JHsqEGW5Gwn6VQtr1lSXzi?=
 =?us-ascii?Q?AwraYU3GWX1ok3pEwvuIwNezQDmSsY1xJqrmqGZzgk6rsscDQ1nnQx3VuJF0?=
 =?us-ascii?Q?HilnEhAYwqW6UQWeVWnQS0B/1RN4pgs42/EmIfY1wB/Se8eIu4oi9MbUXXot?=
 =?us-ascii?Q?NBhmN5FjXzRpqIV1UfU2XJcW+CXSHwfnf4USTV4XcHKleLMTGGg6hwiBj2Ae?=
 =?us-ascii?Q?RbZYugmaCStXUQY76NO6Zo5PhhWh+JbbDcb9kuGAS0fMQHQCBXMBQqSbXSGw?=
 =?us-ascii?Q?GzGkgH1zHJF94xFA9gpFuUL/m+3ljhNBOwLnScHTRKXstr3QRUSHJ6rsZqrh?=
 =?us-ascii?Q?VDw3OkLiGRGx0A4XG/FxRacFBeU8VekWq8W5q/zFImqAsURGiYCTf6gtVrl2?=
 =?us-ascii?Q?TarRPqiJrXGKZmQPaq6Z3DHM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 936a8e8e-e19f-478f-4c5c-08d940a3e2f6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2021 17:31:28.3415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrFPGV9ECEwOnX6iObssOK9j/ozkVr0Yawtb00DyYlOukU/sPuCaQUdMgqmLmMW4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5030
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 06, 2021 at 10:25:00PM +0800, Xiao Yang wrote:
> Hi all,
> 
> After reading the implementation of ibv_reg_mr() and ibv_reg_mr_iova(), I am
> confused about three variables(i.e. addr, iova, hca_va).

Addr is the 'void *'

iova/hca_va reflect the address placed in the RDMA packets

There is a translation between the CPU virtual address and the RDMA
MR's address space.

Jason
