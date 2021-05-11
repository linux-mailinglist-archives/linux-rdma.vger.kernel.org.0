Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752D137AF71
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 21:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhEKTiz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 15:38:55 -0400
Received: from mail-co1nam11on2047.outbound.protection.outlook.com ([40.107.220.47]:25108
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232215AbhEKTiz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 15:38:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RO15RDJhDqQEMhnY8yJ8XtvZsxkyonxVwbuFrCXsC1n1PwPTxDkqhIEPOtIFFGjymwIC5OGYD219e/9bqRWhyoUT5ZUJVrTM4uHbHv4jmIrz1p9ds6IMCFDXX211nOHpmwKWWRDnaAccz7cwgojAw7qYe0Ku4crPQQbqoNf3vWSuO1lcloKZh8Z/33uTaU4KL1Cwx/sCK2oGFCzI/MJBxB1ogA6nD5x2y48WLlWgDP/LWdeRdE+ZaBOzj4ZqbnwzJTUhpoqQ4wzJrYqEW3tV6ae3ll7PV0vDF27HBjI9gVxaBnI4aXv/co2iinoM38wPOcNMTgpZKweCjGA4x4nouQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lag8/Dbtz+iczl2pjPIqjnkF2kocn/ZaOaQ7QlFEASM=;
 b=SWM40F+6LIdjDttPsUJJiHUlCF4kDaKPFIR4TBe7DPjS0+A6wWsuSLxrahCIrhz4dcAvPWpfiH76N7IE0sk38W6WNk9xG6cyqUWMzf8qZQi+wzF+qlCxEOWOExKh8a1Am0WpzUFAVkoUrzgq/dd5Kxoeslu5abaMEgYMwhbxVuaqm3bUPYVE/69NNWued8y1FXOr3Ya36Cr2TU2P/Kg83Zrgtk8C3IrmWdpZXLt8DjnbbfxPFEi8QOs8O23HPz1t7vfSqRt8rtCJKQwuo6bo4q3Op3Z18NHSsGrgo7skwoZLhT7n+Vq7aeRdmQE2SXtnUJPxOJnD2jKzfihThMeoow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lag8/Dbtz+iczl2pjPIqjnkF2kocn/ZaOaQ7QlFEASM=;
 b=AOfng/DYT+obWVERQtLGTyB3FnVWSQFD+y8o6Lqkk1HwZlmQbw1PK/H0v1gvm2wH71f5v4xXB+lAeJ55Pft/pIJdbDGufI8bL99QVbJM7HcNO90Yod2/0j1j3cgcnwFxx+vwimGXDPEZETIlDGRtqJkDPvAXz9Xs6AjewvYGyVHVpqApZKLLtxzc151vSMh5XvjbzO5r2yhkfDMHwclhxmeKgnJLhCR2N9hwNrKlo7vQBfaCvOn6MDfeRd4OfcL96zNKcS1oPhZH3L0QRmUaIrvUFS9Pgr5So3v6omP7yFCMc6iPka6xMBFVdlMdi1H5qRHRAPjaYBdLGaN5xzvJMw==
Authentication-Results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Tue, 11 May
 2021 19:37:45 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 19:37:45 +0000
Date:   Tue, 11 May 2021 16:37:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     bvanassche@acm.org, dledford@redhat.com, nathan@kernel.org,
        ndesaulniers@google.com, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] ib_srpt: Remove redundant assignment to ret
Message-ID: <20210511193744.GD1316147@nvidia.com>
References: <1620296105-121964-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620296105-121964-1-git-send-email-yang.lee@linux.alibaba.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR02CA0114.namprd02.prod.outlook.com
 (2603:10b6:208:35::19) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR02CA0114.namprd02.prod.outlook.com (2603:10b6:208:35::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend Transport; Tue, 11 May 2021 19:37:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lgYCO-005WQe-16; Tue, 11 May 2021 16:37:44 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb470983-be6b-46c6-1ac7-08d914b44025
X-MS-TrafficTypeDiagnostic: DM6PR12MB3212:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3212F4A8249C30E9B45F375BC2539@DM6PR12MB3212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nzOhH06/EQHgfkvx9MzV2T7ac08LN6ml92TE81h7CNWT1NG2ALV8bw8OsugtULD1INGfIEhxcBeJNaDE/sLo/vScp1HHSFfbt/oU15ZGgaaW1usctJL6HELWAIEJgTIGfLZ85J+M+gAau7RYb28p0wiCcXusZeQdol5RunQMxR9/gnEMJgDHWRENi0INcEowFZeZj/GOq4V0tmxATkNE40LFe3pYYNKk29jCI0kzIbBf4vGQlKhZGxDBsAujGkCK+gMVVjGemxbOJBMbvHi/VIGagq36gFe47J67sPxik77iWQkXqt9KXDaug3myAv7tbC6HyRi9XxpwsQO0TL1L9xTTkI+HpDg/evXwsBF4zEFoj8eSlKVE61MMqwn8djq7wzXsMDdtJD8Y5f1cipCednzZ2FnuEpf7p44qlalpqtkrDLgHKpLadKWalzlKBksOG3HZxGl+MMaMcZX+iJa0O4y8n9380NyJ9cB5Y/m/44d7x0hDCA0m8Wo5Wg1WtD93NsNrs2uTGZBOdg32TLGy7c54K7GelaZqtXVVyXb++L5+O/f5ovfXG6scNMJrxOXTJoEH3ntc1HoGNB6zHE7hmezL37d+C2rnienua+AomDc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(33656002)(83380400001)(2906002)(8936002)(4326008)(478600001)(316002)(2616005)(426003)(186003)(66476007)(5660300002)(9786002)(8676002)(66946007)(4744005)(66556008)(86362001)(38100700002)(26005)(6916009)(36756003)(1076003)(9746002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UvF5u6g9P39B86T52rEodDZBO0xCvl1eFX/qdJNfUIijgfPAxhPJLy8GGhKs?=
 =?us-ascii?Q?dVuU55ovUrdIRKZPgw1tZp6Tm5pBah4XlPXu7wv3we3/Mr8rb2UigChIKCtJ?=
 =?us-ascii?Q?mdiHQP8ZvbElMbtohcurJPRKJLg9/2p/xoWczhyYASuRKXC9Iw/Zek0M4mvH?=
 =?us-ascii?Q?wxduTXptEHcYG5OBcsDZCqh0VX8z2ZIDNBU8aZaJAv7RUpjzXBmjCbVYUIAb?=
 =?us-ascii?Q?w7KWm/y+KhSuOhjnnU3QRNJxb3IEn9T33sh2nEvIfH9GUexBFDoTSfRAH7J8?=
 =?us-ascii?Q?M+ZXzMqEODkEREIstVa+MN76gcL5L7WdcM+57cUU50gef2Aeo5OVJA/ZF4Z5?=
 =?us-ascii?Q?aWFgaF3UXVCqHDZdq0daB8wUEbqx/0pnkq4vRHmInTONyXqPSR+kH93IiX6I?=
 =?us-ascii?Q?6nsP13cLCO4Jdzk+0qsehHyeNhPvr+BH0UTlHHQYNnFpU4QmPHIKdpMiyP4u?=
 =?us-ascii?Q?/hlyZ4Xmu4siZtJAoAbx95aMsqwYGCPJbtD5kprl0Ins2VysrVYCK28j4F6Q?=
 =?us-ascii?Q?QnFERwIltKmykrcywmm1xX3bA/ma+FYD50yuDyeHJKzlH05Jna+V+H984hKU?=
 =?us-ascii?Q?kFggMNtJQKWyu+eJFRGD4j2vp55dEVIeI+BFK4dwtUzvpvRD5vKeSJj6dtdB?=
 =?us-ascii?Q?SJJdiijcYQLRHid3AwvCfJAfjMgFuN6vUr38a89oUuEygFUUTkfUVOBIgQhm?=
 =?us-ascii?Q?KZ3HE60dXkbmOvusgXd1Vc/f4eHk0ZaKXX3RbpuBK5+uUSPfXe1RnXua6Dum?=
 =?us-ascii?Q?s+APZ2ukcLKXUKBuUy6L8k2l7jOA5nzYLKKwPaxA0weAKmzFCO8YxoPI3fwO?=
 =?us-ascii?Q?iTsMkfw4UPmSkx2BIgi3+7iFAGpgx2/oMmQO5N8Mz8UqTk3rq+W0nXZhT4CU?=
 =?us-ascii?Q?5dbLJ/zEQTiU9RubygZXzM0w4NiW3tBQQvdnTSWpazI+pGJGEYCqpmIghzci?=
 =?us-ascii?Q?JJ6yGQa6UUNRXrBm7gKK9lyuLPQKbTVKGgpFLb0foY1oFdjnT1GWRWfAA5nX?=
 =?us-ascii?Q?z8AePGvWq1xNUuzv8RRnyK4WMwG6oag/xYNIIThEabfS541tuII/bckVEUCj?=
 =?us-ascii?Q?2Od3B4XxQ1rxcYZ/+SEw+BirFksHeT/UFmxhP24IjoPN8oI2NzeqDxZXi6Xn?=
 =?us-ascii?Q?SbCszCKga4L+zoNBvOMYwtqWN1CWbU8sNGLAAQEBfqmbNYNWF+1DmV5DJY50?=
 =?us-ascii?Q?cGUD9sO3v5Uusu8t4WqWFS53BSKz3Y0TbfWWRvrS/a3KM4Sm00vN2KHxE74m?=
 =?us-ascii?Q?eTy0NTJDyu7gTf8OQ7yFtdBxsX5T314rcizYaoRNPMzB1zWFpuEbEgiYcyVG?=
 =?us-ascii?Q?Yk/QEYjs0blq6na0nX44BrcL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb470983-be6b-46c6-1ac7-08d914b44025
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 19:37:45.4187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZrEcojDKFYMUPuRDK3oVSTWl6HAGZu8eloi26SdcWcWBeejqr+yscDRK47M1ZDGc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3212
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 06, 2021 at 06:15:05PM +0800, Yang Li wrote:
> Variable 'ret' is set to -ENOMEM but this value is never read as it is
> overwritten with a new value later on, hence it is a redundant
> assignment and can be removed
> 
> In 'commit b79fafac70fc ("target: make queue_tm_rsp() return void")'
> srpt_queue_response() has been changed to return void, so after "goto
> out", there is no need to return ret.
> 
> Clean up the following clang-analyzer warning:
> 
> drivers/infiniband/ulp/srpt/ib_srpt.c:2860:3: warning: Value stored to
> 'ret' is never read [clang-analyzer-deadcode.DeadStores]
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 1 -
>  1 file changed, 1 deletion(-)

Applied to for-next

Thanks,
Jason
