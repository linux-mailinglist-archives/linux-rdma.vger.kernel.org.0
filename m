Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3144878A2
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jan 2022 15:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238848AbiAGOCy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jan 2022 09:02:54 -0500
Received: from mail-dm6nam11on2054.outbound.protection.outlook.com ([40.107.223.54]:3968
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238405AbiAGOCy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Jan 2022 09:02:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUwp3xtZzv9dzM4tJOXgoh0WD2mcd59xtn63nwxhq1X9Fr+mohuNuoJX2pP1JKA1f3Z3IJ9yRFYLrBYJsAsyVQDgcAdVw/MO2TOzQ/bejgR27y0J7zrEU3EoMTvIyLxFjdKxrDC1oq9x2a6JO4EtKh16xAyEGkN4dD7uQNal2c6KQwW0kD2lHJ9udkXaJ7SLK/OeLqTXk/IZTKvNDAGL+PbQGq5IyXM64ijEvojlY3msdlmY7h7+WGWim57Vzk6iL8GGnw836vEqsvZyj/NmyfyAzLvAbhQUZXbj23xUPgqqDoXknt1lcc/U3Ainb1XguhWRwx8yiNtEl1Sn/YP5gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9j1mUTYyae6Id55X95q9U1loR+h8LMA1b2Sjhk21RSA=;
 b=cvIiaUKznu5EyW/Am21Lk1e5G6J3KyLLmfsonmoxL5sI3vEzHE8zkeKoD/ttNj8esRP+noXSA8mHa5tvmYdC1wJiwBivGhTBm6JcbmElikA4Y1iC10FFL0gRp8bYzFGJqOJM8aV/6HQo6yzjsxDP8kLsO5g4gypjqCMQ4gpMec009lueM6Al4p8b2Zi4RYt83q/CR56kueUvU1BaBYHpmDgvO6nxIlItOUoXzLyTqM6qZcpsK+ENU8kn4EvcQtz5vRU/E1PPBrFzApNdbxVITin3AZR4ftRrboebG7UzViwdFVhkJTcog4Zj52dwduKtP+0gg+z/VUxx3+4pLmIY/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9j1mUTYyae6Id55X95q9U1loR+h8LMA1b2Sjhk21RSA=;
 b=PSn4r3W3oHpwMTt/jhaK9tsxuvNStGJmqcemc/5yfw3+gmjhnYaJoEEmJx6fq/WblQRku4i8s6lO0KulMM1Ox935BhLN2XqFHb/SvYvcDfpCfVa1ipLVZWHK/fxELf5JzQsl0Tr6sKnKxIFvKLVTIqjHHzrllZAf6SP53G/GYUZ6SrWG9szZT92Zgx0NxuJcExSsw/R9tvtk1w98VN7SiGyUWR8YoYe7UD8Z/PCid4eFZPOLb/TH4sDOuQ04kEYYYKdf2z4wrDB25EET0pPXmQiGGbES8tVfyUAmRfD6JONIYNW5eGBrzvvn7kA6ZbkpqB9Xh03QxFPUx4sLAFoA7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5508.namprd12.prod.outlook.com (2603:10b6:208:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 14:02:52 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 14:02:52 +0000
Date:   Fri, 7 Jan 2022 10:02:51 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next 2/2] RDMA/hns: Modify the hop num of HIP09 EQ to
 1
Message-ID: <20220107140251.GA3074448@nvidia.com>
References: <20211231101341.45759-1-liangwenpeng@huawei.com>
 <20211231101341.45759-3-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211231101341.45759-3-liangwenpeng@huawei.com>
X-ClientProxiedBy: BLAPR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:208:32b::23) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb2a2e4b-0f93-44ef-d30c-08d9d1e66558
X-MS-TrafficTypeDiagnostic: BL0PR12MB5508:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB5508A248C708727066167BF0C24D9@BL0PR12MB5508.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FsiDaXzYzE+oZzly4TglXpW3Qzw/OVSL67sj5ctXaS2FFBHkEfuBZCXX190iEoQfOHNdAATlVZMVnMpGeCQM6XY04lXGVLGAWZJnWUOTEKh1+O9PBDnhkEOoMDGrOnIcgXVmn2cGuUatZNBa2UUQ1SbYUE3G8mpx2czJYLfeXs1yCZ3EaEbwBQ8UBu9ULBvj2lGY3HPXl8xEB1FnqNyoBK99tLDbdXzeJasQq5PtbuFE9Zo4onKBJAnMvdp6N6SKh95aEeE1zcppLDMWKWuyfh0ySEOnVo4qvYk34V22EjF7yX4KNGUksIdHOQkCu23AMZseKGR7/mbTLwks3x+Ta4xqN3r5Oyt+5uePhT0waDT34H4qivE8MTLY5T/1VQRmcHUd/9eSAiQ0mJLWspOjcyKgAECfAm2aUeGN2aXBhJ9YWceiDZb/Q3iNox5rkwk5KjAx/2Kel5KQa5tRzWoQtu+/DV+pz7OCVA7/HMCYVnS886kQq/o/IKP6eijdYcFa+MA+h9QCFahJaWPIptXijQI0GPaHCYE+BwsOhQX/jBMQ79//RP7Os7i3NI6eNJPAqBK83YQCYROc0eVJyjJJLslQCUsjvFplia5rWNffPOFF+JWKvkDO8iKK5xB1f5+STmVpmMKt/GZiIRPMeNsPFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(6506007)(6916009)(66556008)(4744005)(8676002)(36756003)(1076003)(86362001)(83380400001)(2616005)(6512007)(8936002)(66946007)(186003)(4326008)(26005)(38100700002)(2906002)(5660300002)(508600001)(66476007)(6486002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iOT1ZIlNv/1yjlbnrZODhTb4aDvDUiWn9ppbPxjD6VCnnbgcud6HeVIdKXz/?=
 =?us-ascii?Q?YRByVz/YpyBTq6P5FDi7JGvHGZFRhKY5LfnHSNgUgzgA+jO4J7BaXiwZRwQA?=
 =?us-ascii?Q?FAeMr4Khko1Uj/QN5OQkdfrAyYVhoDa3LoARP9MVkMhY4aPdGxD6mDhgB/bj?=
 =?us-ascii?Q?XOz5/zXwUWcZxOwnKMPONpzthjPsjHLwq6zJv/4AJEc8LjC1EzilHJ9Fjneq?=
 =?us-ascii?Q?IPp5OIMj5ihguVpITpyxyg9d65VRtzUQS0AqMaJdCjAvgNtayJ2m6vsafFKZ?=
 =?us-ascii?Q?RiQaB8txp4I74LSm0zMb8AiOh3d3+3e0ZlnFgZxSPbZoH04JYjLQd3pYFssR?=
 =?us-ascii?Q?U/Tv0mmtnHa42FFu7YnKtZE/DZDon+3sSuwSQZSrVqS28NxIPN9d/uDHjkvw?=
 =?us-ascii?Q?80pTcTNY7GF54f4VJwb8547xoIRGSRA2Sg9gk28kyklTEL/zLJOTYbyNu6UO?=
 =?us-ascii?Q?zVPQkTNLIJmJGWYNF/wkN0VWS95x412Jr6vC3AZFcxme1UA0gXoW/wm1x42u?=
 =?us-ascii?Q?lioNl78lRCJxipu19dRFuzV1ntJzQfJw1IzSOFf0kquWZXqfSJCH1RixxdFk?=
 =?us-ascii?Q?ifnqIrSIQqdkELsbiiUQ42MmpIugnmfCmFWPimfa8cIAbgihN3x4o3LTVvt5?=
 =?us-ascii?Q?Kmb3Pq+RStakWsF+/NtGP1RmTH1OetirL4N+PjjYXtpHr9B1TJ6EWTX20SCB?=
 =?us-ascii?Q?I7ECNXj4CxOESXN1g1Aaqa6JW7lOIhPRGlaauP29aS80tpBZyXryEcoCildW?=
 =?us-ascii?Q?4Y2vDtm23t6ni4AlKfQpGTfRGV6rNQsekORpxTW5njSu+AnpjlefrHaGAetT?=
 =?us-ascii?Q?ZAU1Ls3puGzboSqeIJ3BQkJUhFy/EUNruH+J+SpVCHp8zDdhu0H8yEgJOyRT?=
 =?us-ascii?Q?t5SWziiKerkhImDovpyLqb0y8WCqgr0trWRhIiuP+IWHCLVPjU1Sc/PzPCTn?=
 =?us-ascii?Q?CNCtvP7R1PdjNzVMYIiTfY0fwy17IF6EBoHGep+/1gfnYuhrJbY4Gp6B1WL/?=
 =?us-ascii?Q?8jSGrwv9kWGUtltliRBDGariTOWx3Sk69ERpKGlKbD+V1PqIc17EkWe4Y/4D?=
 =?us-ascii?Q?oUKT0D8Y5MN0LH7XelHecsIaer9zZ/mhnTI2yuW3w46jeoOMmoSrTf/dtzLM?=
 =?us-ascii?Q?HOSiJxnD1VJ5O24f9jAypevkquJXZf0kcYLikzaqocjUuED3Ri3kf/gYl6OO?=
 =?us-ascii?Q?8khJ99787cPFFKczpia8OtcEcHEXHqvQLJ4Yawg5olyG4jStwOb1gFL8pUL6?=
 =?us-ascii?Q?br47/d8mik+vQYv2feH8ScmNc3QiC0XB3bjIgZQB/U9fJjee8w+qdf7ffLbA?=
 =?us-ascii?Q?I6mNZCjLwlx+mU/5carYz8tF+kBXtUsfk9mB0/JtRgU3PRVoRVlcRARco0Yn?=
 =?us-ascii?Q?iN3PUaCeqLK9XNGnwwIFcBqpZ/EXTsy1oaXNaYjzTplnk25nQexCwC5PYzj4?=
 =?us-ascii?Q?nqtMiNwTQ0Pu8uHf7pjpENOeD/TS1Yw8HsfNH4++/78ITb5VdylL9jmv2of3?=
 =?us-ascii?Q?HuOoPpzYWudhcvP0dUW/QtVeRIOSddKclwtDD2V9Pjit6mHOcBvyyB7xJrCk?=
 =?us-ascii?Q?1l0n+eoAPBwgCmx5Qak=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2a2e4b-0f93-44ef-d30c-08d9d1e66558
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 14:02:52.4982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5jKtLTHoh6UL+NXtpkaQhNkfEmBy29vL7NXht5kzr1bJHRDe0DPHM++WRuMzMald
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5508
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 31, 2021 at 06:13:41PM +0800, Wenpeng Liang wrote:
> HIP09 EQ does not support level 2 addressing.
> 
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 3 ++-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 4 +++-
>  2 files changed, 5 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
