Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF44403917
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Sep 2021 13:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349176AbhIHLqV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Sep 2021 07:46:21 -0400
Received: from mail-dm6nam11on2076.outbound.protection.outlook.com ([40.107.223.76]:39456
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349231AbhIHLqU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 Sep 2021 07:46:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfSlGelXtXudvRgMU8QUqMtHWy617ZcrrVZUl87QuZ6RoulLqHOAKaATS7NqwKUU6OEYP4NiO6i77qEzXrBscPtMiLU0/41A86ZNPY2FwBSpJ+zbFtZY55EBagqaHjJUSr+KO/MV0J5sU2ubLpgHyTaw4UI0YmJ9HU0dmrWKM2x08cz0ZUVCQG5hBURU4q2k0Mx75kIDwU32uE+MRXFirxhmV8kDxwtVQt/r5GHi74vG0VJOVYIUqqqfS3wQAe5PHOi+ocnUTPOLKaW8PuaVBWt2dgUZ1N8xXDOIPrbBvS9bvUw2RVNPildNmb9yCW0HNeo6l/QyWC7yBM5p+BEHmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3PjliwWdRYQSI+H06tQe+anqDul31JtgTzoAa1r+oKc=;
 b=cTOxgE/Sb5dyWvXiLu2ZpM/mcVCPJs75R5TIhR6K+MhQgTshmNjOpbA8AhBdMNTr/TX5NgjbetzDHSXnD6D0GXoQzJe38VBUp2PSRIdU6fEELGV3pnmQJ4U4GNkeF3NOVa0MpmPfHTtfoUeQfybLGU17psBGNDqc9vYFlXNXSKtW9fSgQZ3DIqF0WIrPAG6/xP24ofGQZq18sKrLtKRj/V+p/xunsrqjpQ6p5duCRzy/JJW6eaKqPnd+7WSi3YuqOAR8RTtGylKHZUvcYFQw/84oysdE8GTtPqyGYj5GeBHdbPoUDLL40sjxEmvsOQ/GCqajBlVNaDWQA6c7GOJ33w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PjliwWdRYQSI+H06tQe+anqDul31JtgTzoAa1r+oKc=;
 b=lL2G53Znuhk29WBbh9Jxg5Bq2MQhBwNbRy1ixzgz70d8pQeR7FmdKU7ranerv6cXIsRq5jqK8doOqd1PcFfIPTVEzWp1jKTj5SSp1qwoZCk+HeAbF4J7FK3KWuGuYQyjsQmeRoEcckhcXua9QASYcyZdl3JRnt6KE9iMVWCCPe1bZO8nRHvDd+eCorB44GNJI2WY7QwlEnODIsmxiN90Puy8aMfsf9S3VkWTR4mPHOyNndNd3ISLeiDKmW3Tg8gTqLE1U0FVQA2DnE1gkvJkGLmzyPKiTb3T1c0i+Dgxn8DCcT7QeI0fudEgHMCti/858uLfw0P6w2QsLiWOokWbnQ==
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5158.namprd12.prod.outlook.com (2603:10b6:208:31c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Wed, 8 Sep
 2021 11:45:11 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4500.014; Wed, 8 Sep 2021
 11:45:11 +0000
Date:   Wed, 8 Sep 2021 08:45:10 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 1/2] RDMA/mlx5: Fix number of allocated XLT entries
Message-ID: <20210908114510.GD3190597@nvidia.com>
References: <20210908081849.7948-1-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908081849.7948-1-schnelle@linux.ibm.com>
X-ClientProxiedBy: MN2PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:208:fc::20) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR02CA0007.namprd02.prod.outlook.com (2603:10b6:208:fc::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 11:45:11 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mNw0s-00DO4T-ML; Wed, 08 Sep 2021 08:45:10 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70174c55-cd61-4580-fd8f-08d972be1d88
X-MS-TrafficTypeDiagnostic: BL1PR12MB5158:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5158AA80478771A362CEE016C2D49@BL1PR12MB5158.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I1lVtb5P2Qf0XcvQoBYB2lXvNW4YDBj8RB8w8EXI8SRyHfXPMEpgVqDfwP8Jd5CxdByYF2KK1IfYoeW+Sq3aLVelE7bBs8HKC6R/pq8RXa9K9BNiBK2JdNna0xWrxXHdxSmYr4i+OSnVqA+W0KW7mpp27thbIHDDugyoD40IUMfW+FXDgZ3MY8RKwbZemX+VWzfudFyILpBIaSnSmNdsoMScN7mlhNISXuIZmeQwb6v/0iI4tRjaRBfkYnc47jiVxUZimLhaw8/kQdCtc8ac+HgdY6Cr+jrIPSja4A4y5Zgu95F7h7HglVvrHng70RDXMidFxR007rx9mM6B/60Lwk3DrQsf4iyOy6KIpinjwmHtTgwa1LUHe/HFZlwDSl8tiglHLFUbSHHVeArYKic+S7VyfxUMv+Q/D2NbdwUopTxPSiEG55yXmsJKaowHKMt5mo8cifYnWdFtsvdzkKcUJn1bIOB5xr+Z+os8k09foJdh1xVUnSVqDDzjzbhFODrRBbFIN0OLIGemOyg5yQkSfQiGYnCbzcGOMXy+q0bO34ki/lA89MsKVT9t59V6fikG4iB0qByME4JOhxZfqSLIBQ+kV48ubnoHZy7h/jY2dnXUK7GIjr2SLAPoPEdXPIrTIx9PjtA3S2cPwekqN6iGCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(66476007)(9786002)(26005)(66946007)(54906003)(66556008)(2616005)(8936002)(478600001)(316002)(426003)(5660300002)(2906002)(36756003)(86362001)(33656002)(1076003)(83380400001)(38100700002)(8676002)(9746002)(4326008)(186003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?raH/XRrQwHjRm+od3q650jqcAX2ITY3X4SnPPyinvtfBCZ3ZwqW2dBW8k0cS?=
 =?us-ascii?Q?lbfRsiK1ABraKdAfKUX52lAGaI/pHxD2RMBjZndoOX84+lD2ENe0kV9WeR9M?=
 =?us-ascii?Q?TaCrwccNPHllzS34/xXH3qp1u2owUNkGmsTijuNUvDBXk7sqgGprHt/AWYlv?=
 =?us-ascii?Q?siKdn1YHiRKXBY1dJImQhTpOOb4uKJ7XXRzpDegY66o4XjmFUDgo4FSFrtyh?=
 =?us-ascii?Q?stvkTgeRkzzHp8szsNkZvJ6wiRuAq6tmZYE6Gf58G6zdGxXxJGrtp0N7fvQy?=
 =?us-ascii?Q?b/GZMJx2UnGDz8scG/3loCObuEbosplgGxqSeJ5+/fBgIES/oFs/l56hgCZz?=
 =?us-ascii?Q?MF9fQc+9He4E7U+ToksW+fTKvvKXT3UfUP4UrrI9rSAxsanb7e4LSEtPr40f?=
 =?us-ascii?Q?Sj403JGf6gNKLmSs097Cl2t/hjv3OeSdWqfATjb0n062AFe5jYvIoHquS9lk?=
 =?us-ascii?Q?hvnhK0cw6k9gmCFikg2NaP+ajtkKcazzx7/ikdtUpdGnr55zh1q/TShSrVdP?=
 =?us-ascii?Q?tKp3ISW9DTeMt5F62l9WaMiq/8cMvQDtylro+SEYi7yyhXUxCTq6G0cvTDsv?=
 =?us-ascii?Q?f2VFAtkR8KjqT3L/3X0eSps4zj23vfMVOj1w5FqVMlP+y2D5wJ82rHYwUY5D?=
 =?us-ascii?Q?h1f5o9hJVToQtJyBXC27/hv2PIHqEun0VSTy6WjQW1hCVKM1NM+YWBOrn3Vj?=
 =?us-ascii?Q?tC4sxRiSHeQyFaWlUqwYyOOTAt1JMYCJ1Acm44eZ84/V1UB1IVFc3lbzrbO8?=
 =?us-ascii?Q?qtBCR41jKVqSPOdV1h1vkaiGIhL9LcWyV5IEfvCdEQKn7+nT+LDsNJoa3MJJ?=
 =?us-ascii?Q?JiCTbSbCaFSfplvczr3v0yATjT9jREJYWlsO1cswxWFVA2NIsm7y2dhBt8VP?=
 =?us-ascii?Q?OdBW5HE2cNTFsIT03BICZDaygyj2DgCl2wPSpGfilb17izsCc7jM+AXuhHL/?=
 =?us-ascii?Q?zWztf7tgkhinfU8IubBu7Jcd0amxFOkSsO7BKbzpHEVhD1/XoV5P34myLHHC?=
 =?us-ascii?Q?2Wao91IZLCb2yfu3Lm9ch5K+XVhwFWH1NLrMuNvcBiz78wGpI0/dpH7HnHBi?=
 =?us-ascii?Q?3DheabH9mQbyFcs3FJN5jSuRfn+/a7tqopXi0Tzvdn0i75Ub+DJRvUVrfKEU?=
 =?us-ascii?Q?joiuwN4iCh7ZIyjezXTmw6vr5wZCMtBUqRG0BQPAXOKVN6EBYi8TSpLB8WBS?=
 =?us-ascii?Q?1M43uSlh25zb/A3m1mmgJPb9Qp9BuHtRMd23HPh0ahXkF5atH8IT5njZQ88l?=
 =?us-ascii?Q?66061MsTQfS81FMmgfnZrgMD77hzpNFd8FmZqb3KL0w1rWIvubWt06w/6faC?=
 =?us-ascii?Q?0LI96QFBxS+M5ilgJZZUrtMe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70174c55-cd61-4580-fd8f-08d972be1d88
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 11:45:11.5959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5tyPE5HcPn0vHnA9ZfI8HoZf6rkNHatmaSC2FB5xVKumO61Bw3h0lpWps2PTTg+A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5158
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 08, 2021 at 10:18:48AM +0200, Niklas Schnelle wrote:
> In commit 8010d74b9965b ("RDMA/mlx5: Split the WR setup out of
> mlx5_ib_update_xlt()") the allocation logic was split out of
> mlx5_ib_update_xlt() and the logic was changed to enable better OOM
> handling. Sadly this change introduced a miscalculation of the number of
> entries that were actually allocated when under memory pressure where it
> can actually become 0 which on s390 lets dma_map_single() fail.
> 
> It can also lead to corruption of the free pages list when the wrong
> number of entries is used in the calculation of sg->length which is used
> as argument for free_pages().
> 
> Fix this by using the allocation size instead of misusing
> get_order(size).
> 
> Cc: stable@vger.kernel.org
> Fixes: 8010d74b9965b ("RDMA/mlx5: Split the WR setup out of mlx5_ib_update_xlt()")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/infiniband/hw/mlx5/mr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Both patches applied to for-rc, thanks

Jason
