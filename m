Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939094DE14D
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Mar 2022 19:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbiCRSsE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Mar 2022 14:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240128AbiCRSsD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Mar 2022 14:48:03 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F4F18B279;
        Fri, 18 Mar 2022 11:46:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MeFv8bgUroNW6J+nefo7dJL8PVY6CJkSgAPXssS3B4AqyDC/xbPQFkjLWW7sxiKABK2XWw5gelGbRle/rFisHcPmdYeko00ncT3kUqFSEtUzi9OZSrM9q0TuX5rFdYQ/uXJBGrKz/UH08hp1l9UaKqLQUSWTQAWEPTHboftTETanrtbQ+Boc7D/ln/vgwZIiaiwosFjPPrE/B9sAc/H0KS2f17872KFlMKJ2sXn1WXwDpRYz179huWz9dnpoGwt3BZPok1FGIBI0EpAQfabdos6nA26ETTzeEVkGsKsppwSd/hVNcBuYY062w0a/rSaRFxMDdcmEa8C1P7zEq2YB2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6q40AxL53/6gw2TT39ztnxZQ8O56cFpNqLWGWT/LvKQ=;
 b=GSqRiKOzP9iyQVksI/AiuIPx/vHEPQH9Pg72+rM3c526TdYFgFWB5uZ6DkutowHNPJHBkt4BuCwAoDG0vIZ/qNHIZg8m9PItQOT3/NzWP0IxQxf8MkaYwOVwIPefmO5WQy6bTSQJ7wKp963GHKEB5/H/SK2VYKR/TWOzMYEKnBDo58QbebFghur5f38sUbNItB9nrP87cpkwYd5/CbwWJySBVlDdT1dF/Mte6FtjFGCI0J7eX6cZCN/wETNzThZYgQeC5XIMhFAPSMTDO/uzLIANuO7waPgjuHsIlYUIPe/Y++x0JFFFD2SVIm98ey1ER0SELJaCxCyriH8XD6r+bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6q40AxL53/6gw2TT39ztnxZQ8O56cFpNqLWGWT/LvKQ=;
 b=cr/WeuNKY6928htzRJRWPQ6YAgliyjxB9EsLGMVZKXva1FSXxB/Zw4P31C1ccy2XWnTLfhTt+z4UvElNPACts7tb8WlBlobsXCB27Zonnv49dDQ3gZCxceoXfPTE/871kgmYFVxRABUdqlYB6d6s9y3U1lzRT93JtKXbjibGmSFqvP0wzfxVCLBE4HJ7DvY+HEVpRO2tHeD1SDiTYxgsFNfewo2WPzQmYqmB9jkxPh6vZGEJ3l0aBCGTqlRvnfyW+sGTxWjgOXHpPqF3FmSUfasTBcW7iU7rUvsNyuTzSw+Sq8Pq62dqHR1lDnbje7sIgrBzD477qkqxzi0dkyvTEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL0PR12MB4708.namprd12.prod.outlook.com (2603:10b6:208:8d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.16; Fri, 18 Mar
 2022 18:46:43 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 18:46:43 +0000
Date:   Fri, 18 Mar 2022 15:46:40 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Aharon Landau <aharonl@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Mark Zhang <markzhang@nvidia.com>,
        Neta Ostrovsky <netao@nvidia.com>,
        Gal Pressman <galpress@amazon.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/nldev: prevent underflow in
 nldev_stat_set_counter_dynamic_doit()
Message-ID: <20220318184640.GA666512@nvidia.com>
References: <20220316083948.GC30941@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316083948.GC30941@kili>
X-ClientProxiedBy: BL0PR02CA0111.namprd02.prod.outlook.com
 (2603:10b6:208:35::16) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fc7f622-18cc-40be-a0f8-08da090fa514
X-MS-TrafficTypeDiagnostic: BL0PR12MB4708:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4708C4C475DDE6CA705BB9AFC2139@BL0PR12MB4708.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IGULLcaWAzYkYzou7YF5A8j2EDOS0qjwjoueppZjVY+RFEXdjq9Z9kHqKt2fi2jtcgNN+L0DW/mzUpN7ILOj+xRBvxRmhjdwHJgBkTVLNkiwaeKIt+MiqYrabuxcJaHFg/eTMWy42XcgXgHsFeO26cCkJm17jyBJ3UtytjUw/JeO4+N0/B78NaoOZYRh7/EpiSdw0GYvjwc3OdDeVebyUBXj1ozKtAt8uqpf6iQOF33ii1y1SL9PAkZ7XO6IKYJcX/qIoQ+VH/9B3hWLqEM90sCinGGmV7kVfpbgWf1/v+T/42iyK9qVdxW/QGhGqv02tgQSQjsfrXAysKzhu2Iaw7KrLrNHrv7yP35x/dyiz3LPQR7f9waO1SMJB/jLht9ua9IeEm/534wGOsA6EeEU9dPhX+Bc7MX2nk8VihLqseEFk2r1TVAzyJHCv8DMz4MnLpd2fnKgPr8gXH9m4TK6+IrbzLi4/IfgSNEwdJlF016QApZDgRt7dY0AheBnZAjnVHnFjrN+tyHdusaS05qPAr99MnCGjn5d4uFS+oI7is8nWD4W4R+kuJuNbYQxlyQezQwVEMqKomrNjuR1rJFdmc1gjDtyEb4B6+OKHLLE4mdXP9y+6nUYoIuS6kQym7U0zFfaMjI2E1dHCBJHutHGGIiZSiQLC1N/WEFTTU/hBpoZJn/ZOo+UTA+HTRX7WX9nigxEIHvTT3ntHHrc1jvGfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(83380400001)(66946007)(1076003)(66556008)(66476007)(2616005)(4326008)(8676002)(186003)(6486002)(54906003)(6916009)(86362001)(33656002)(316002)(6506007)(6512007)(38100700002)(508600001)(8936002)(36756003)(4744005)(2906002)(5660300002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YzVHB+VUfV7pHVU9YyhwXvcY5L0krTSYFWk/pocf7b/wNgYlmQ+9G1NclOFQ?=
 =?us-ascii?Q?Dtq3mW4J3C/XemJK2ZMGIUCz8EULVAk8ZSwUjfM0xrVknOJ5r3TTA7f8Jf5+?=
 =?us-ascii?Q?HepMZ+RGG4K/6GX/b1caR8/Dk66B1c+1/bpqwSHp1ZWkz4VwCwP6yaRw7muh?=
 =?us-ascii?Q?UnxYnwFeDQoW7a9D4oSYM/Q3jnSW60tecJQaJrbGitvJNcFn9gZQuDHuj0tt?=
 =?us-ascii?Q?1sjuYMjZZWq/iaLXsqCmC0pODJtwWinff3sX5iBYOKZDRaFvjNowZM+4nRrU?=
 =?us-ascii?Q?I7+/21Y+v+krQnH1wr58RCBd2zKyMCPnnGqhJdH1knm2omxL6G+B7JGpajp/?=
 =?us-ascii?Q?skrh6juIXYQv+cBq0Fvb6N69DRgnE6rodogfQObcxmprmM7aIn4DqeD4T+V8?=
 =?us-ascii?Q?0L4bU1YKfoN1JnKl7ZJiT92Z7iR/TyIhXqlgK3VGGp0bC3OZvFhFaguHnprl?=
 =?us-ascii?Q?u5wItIvPimyUT9KBS+TQbZl5GT54svT5sKYrOMnBtIEzLGV0HJkijxlfH4Ol?=
 =?us-ascii?Q?EuP3a/eABB7QFzNw4YdjsY9Ce9tAhuEOMXkJenLc6zl6Vzm09FORtG3o8u2I?=
 =?us-ascii?Q?NV5gYXs6cEdr1w9Ja7cNnRX1QjYFogTkzRw2dlBPYzPUYKFkispDW3GajFEh?=
 =?us-ascii?Q?RXp9p03q9L2qBc8aWfLU01iThlY4hZsds9GZBmdNJWp5/r3mT/SbCF8fGfWw?=
 =?us-ascii?Q?SVWm6ByV5Jpl8NdBfc4AGxlUBSNgB0Lt9j8hBK6NTzS9wmMMvNYFb+hzgvFM?=
 =?us-ascii?Q?AWGAhwPf/jtWMA/GRcBv2k2NrgoBWRHKL0rhNA1doaZGJayhzbHFVCwpRQXb?=
 =?us-ascii?Q?T8s9E1smvIKhE9gvZvONXdKBw31mcKY47eCfi3GNo7Gu/dBCQJYiZUMQgK9S?=
 =?us-ascii?Q?dGoZw9Rd4gZauLXUPZcCIx5roVnXS2+9bXbnA1u6I2QbwrVD1vxqegJX3j8l?=
 =?us-ascii?Q?7YFlkXKc1OKUHRHRrmHoen5/3kvbmJfEG83wFtP1owT7cgzMJ30aHx8a9pM7?=
 =?us-ascii?Q?m6iKZj1vqlyF/ChA4ZiyqSu66y3mdDjUK5MYuy0vf/liHYpvvXwbrAS+7+uW?=
 =?us-ascii?Q?mpGfBvSngi2vGIvoP/A1Avi/dTtFEER0aTPJQ0srHp8tREkneRQK7oEalfFN?=
 =?us-ascii?Q?EI7KI85DQHpyjKKQYhcT9TunjCbxYm1olleDV+P+hQzNejzSxf32XUr0KSQI?=
 =?us-ascii?Q?b9vKEvCe/4y21XbhoPCibpVIXKrsekOej9nuEl5erdbFj9xVN6FW7YxLawga?=
 =?us-ascii?Q?kNJ25QXIE5Bo7Gswc9mgXSrrUIsQ2vangknqYMf2FrC19wGH1pLxU1aKFX8k?=
 =?us-ascii?Q?3+MP6RmEW9OvQyyqlWcedNUeVlUW07lobobPvDVtli1fkuOZnJ8RmJdz8ZWP?=
 =?us-ascii?Q?8blAveHjxaRPUOpYJcn0yW25FxfTcUfTzXx1B9681q6j2XyZtpcY3nlpwPPN?=
 =?us-ascii?Q?81DBi/Y2jnV/8dH6cHBxnHeQXxJuMdm1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc7f622-18cc-40be-a0f8-08da090fa514
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 18:46:42.9172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvfqzcnphoTe0m7sXcmDOBgy1H/thtdqpTS4OmalO7eMYGeqeXwexMw4bjxBLxoj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4708
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 16, 2022 at 11:39:48AM +0300, Dan Carpenter wrote:
> This code checks "index" for an upper bound but it does not check for
> negatives.  Change the type to unsigned to prevent underflows.
> 
> Fixes: 3c3c1f141639 ("RDMA/nldev: Allow optional-counter status configuration through RDMA netlink")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Could we not use a nldev_policy[] to tighten the bounds checking even
> more?
> 
>  drivers/infiniband/core/nldev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to for-next, thanks

Jason
