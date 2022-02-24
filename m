Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1B14C20AA
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 01:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiBXAda (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 19:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiBXAd3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 19:33:29 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2042.outbound.protection.outlook.com [40.107.102.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BCD7A9B4
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 16:32:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPuRPoywPfw8R08SZL4FdLDhIiz45V7/RWdUo232JQ62iqTGWssYCuVQZZMsKWuIGvBq5K9YW+RqmSkt5ONNlJTUzC61euJ6ZoSZcJSya+TaFGwg/t3Maoeh3Xzit4Mda0m6bawKEYVTRc0jt+HUijHdrf8uo4zut/UUjKth/sIFC87ntzR/W0UWaMDFeSTIWmdtTLWmvLgbEAuyibU/vgmOVkTC6668WTy06PtUS8Qin2CQI5dScSkMwqCYQm62G26Xc+zVQG8bNS87tyk8kTy0geoP4qWzN55dbV6ULynVp905Co/tPa5ZxXzi7jx3AwFnXSLioNjT4iwHB+ZP8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sH6+ev//Mmpf1DRKmmGRQz/QCXQHujnp36Rmw0BeJr0=;
 b=Cs8NttDSMXML96aXd3gGb/MgNmCWY590P2pnkc/Rbhb7GpqdIuj8Gj9PcMM2fCA7v/a32MLrttzxZiTeb2OYLVv7k7oBE5WTdOKnITQgYjITNaUOwhWNtdqyYrFyTxGgw8VOWOcD8SCZPXYVX7UM6fx1pBPl50hk1HG8Ng9gRi6z9s60UXmOjMbQBzxGfChtFwXVFxIAkswh7eOZMQbkldd6SRKMbX80ERWbxTHsJ1NUzJ+9ACsA6qmXi39+E/wUOceWeoU/C4fltD4xsPbK0UXvXxRq0XRO68gR4GESY9QohQjBsohLTnIaIPIMGm5gNIQzvtWc2yCG553Pt6OOfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sH6+ev//Mmpf1DRKmmGRQz/QCXQHujnp36Rmw0BeJr0=;
 b=KkE2TchM1huhzSHjF9ba8NYxlK5jJnzySTBVsl8Ii1zvXDvDINrKDnhjtuenBy32gbC6A4W3cpG4lAeUDXkpyUhyCjQjI0GL/TbkCGZ2gJXkOlD/Oy5prEAADo471Jl9IeUOsnby9f9RGe/D2bLat4DXuGB7zGpUw0cq7qOzBVcZHNkKGtTFZlFClsY5c8PglvigqAS/d6BHYx0cmYVLSdcxG/7mQ3vfJiREhqFRCMBrlA5kkKUiK64GL2Hutnsb9AsWIf0gujhRWdz5skhW3IjyM8TwTLERDmy1+QdjP6xw3oT6QBUz0JR7GcA15xuKeXlhrnibfL1o9Y0WzENyiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BYAPR12MB3542.namprd12.prod.outlook.com (2603:10b6:a03:135::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 24 Feb
 2022 00:32:57 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.5017.022; Thu, 24 Feb 2022
 00:32:57 +0000
Date:   Wed, 23 Feb 2022 20:32:56 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v13 0/6] Move two object pools to rxe_mcast.c
Message-ID: <20220224003256.GA447494@nvidia.com>
References: <20220223230706.50332-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223230706.50332-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL0PR0102CA0013.prod.exchangelabs.com
 (2603:10b6:207:18::26) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f87aae4b-a663-4266-26d9-08d9f72d3443
X-MS-TrafficTypeDiagnostic: BYAPR12MB3542:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB354268AD5366D658EF9FA9CEC23D9@BYAPR12MB3542.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Z9Tj7mBF9+CCkwNOddTrkg8Nbhv+XPkDedM8DR99kWWpJxnNN6fzQQH5DUuIc1QQVftK95RF6kaOF7II8NpYYB+bj0S1rnq9eyRIoBgAHtINZuP66sRrTqN9Fv9ByqbsLZgHsB7DnoWntU/zX5V50/S8fhQIGNrHEz+ZqtLx7vVzXKKGfNsGva+7g7Y4ePAkOLqW5aR9hTdjRNnNU0PoQD3w+W9Lwjn59vj9JG3Xn8h158IPxwtkPeJqkV1sU+KHvxoDB05dR5ZbFJFGlWRJCkff5LkPTgWhnJMvyYmW/aQtpdgxH/mSxzUZWF3iX5hlvzzYFOnSZSNK6MI68f3BtXOVQtR9LXYpLElnx3umIc7lpbPdG2bqgWXhuv9fS2UYzIrIbJDdEmicC/zjvy8UD6k95WNME3r8qM6ZjE0eRWjZLUc4jgsnQWgpkP/wUypSZLX3OhGvAMXd79OE4DDjJIaAnn4f44Pz25k7cVyzboXsEO48y9temQ2/ceoAbkjWbLRxdlSmSHDgx4GcG5yAoSAKT1Q5AstRL7sL+cM735f6nc/KegXU4N40sZVoptAms1CU2P0THspiucrNwYL83B+mGnjWd4XURpM8Eyku4p3DKG4ZFoZxm+NyUh/JRQcDxG6Jiiabxs7e+gXf/F/343OjddwYeeO/kHR2H1laZr27T7LuHaXYjgTNdqc9+Yfpa59cpcVweOsoVqLTDqzOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(36756003)(558084003)(6506007)(2906002)(66476007)(4326008)(8676002)(66556008)(6916009)(38100700002)(2616005)(186003)(26005)(8936002)(1076003)(316002)(5660300002)(33656002)(6512007)(86362001)(508600001)(6486002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1LUNTIf3a6CMYMOB+hJDZ6kFNei9IPfKCxT4rdkoUB4VJI42PVlD3rhN/cGw?=
 =?us-ascii?Q?/cLeq6GsyXyEtxWgNWHmvBuDzg6xRre8crj7tsvgnPOgHJZgJhihxqEEp2M7?=
 =?us-ascii?Q?DZRNPJu+JzaAfQXrDyZs0MZdbs9iddY/gomeb5hh2jX00ZbpDUz2duxPyjPQ?=
 =?us-ascii?Q?81ED6s452GLHkIwCl5wc7c8BB7oKFAw7For8eoPvSsCsLHOcj5J7scqDlqp4?=
 =?us-ascii?Q?vi1Yf1jqXPBHZtHQvaWqmLaD2O/T3t3WowVyRRbHvFmSQZucw638nu9kYzGZ?=
 =?us-ascii?Q?8Xb6s7mIuK5Tc4aM2HlOvR9IXKFJx77uQe1dFyOlTChF+OYpVZRxXOLFCSM+?=
 =?us-ascii?Q?mnCs1euvj4iHDanTqIyVqF8pC5nARK0FmZaCLFCjbUGjapvqZRU3U/P54cUt?=
 =?us-ascii?Q?0OQpsdf1ZumA+zK5n79szD01cShYOwGMdGJiX0wI3mLlZvh6wO8aCDYy5Aqf?=
 =?us-ascii?Q?i/b2vcqre2xu6dAde5qu5/2/qsw5RTb+AoANV9P0Wpf928Kk9xpygnqNP2zp?=
 =?us-ascii?Q?KGedjeVYxs6EGsv+VK0EZlgicqSVnk0SQT8BCM6x8ZekxjyopMetY8q26uT4?=
 =?us-ascii?Q?S36KM5pKnkLG4h8Af9x1Go8IqHPc8l9QAehTSGnUrvqRNwbfTInfuqESVO2s?=
 =?us-ascii?Q?eepv/VtYPizRGvBO4e70oos0ydag6Ra5L0F9znUUrX4shySjR41ROlKZCBxS?=
 =?us-ascii?Q?qvhNtNn6D7h8NNx1ov0Agizq/DZrtd8sBk+MemEWMe1wrZ+UiF3w4o3g7WQh?=
 =?us-ascii?Q?XqSLo/fMJE45VRPXkHA13U8jCI/dV49FFwxJbGpmPGIs+GdE60lXt8uQvw8V?=
 =?us-ascii?Q?soC1RaWB5pg3soWtqDsC/KQo0Zewje0rXSkNSfv4DpjJHrP/xw8E732Rf7KU?=
 =?us-ascii?Q?thtQ/F7ugGvlQ0mi8ondfoM80XkRtsnko8l3axUBTAT3SzXqfC9CsLP7uKZj?=
 =?us-ascii?Q?XXEoyIS2tterb5jVWjvFutjH+MmzywP6/iCfmWYHo7+yO/DCqMrQyZAf1iJC?=
 =?us-ascii?Q?+yjKwoDw8z8BQbZpFez/WMQD6aaejzs3GMndPRIbIwsQV7E2KzH9vzfLl9UA?=
 =?us-ascii?Q?75A324n08t078kUNm/FoegaxVcRCv2zcpF+l2ARQ7OaGzyDQI5yLypC6o5yH?=
 =?us-ascii?Q?/YoQ2+DruayFi718RpGLkosi06NoY75Ov2NGcNLMpgqvBW3ztHUtTRvw7f6s?=
 =?us-ascii?Q?wUW2vCHr4QncArbrRTFqGmIbV6tszTjEY1qn5Hi/GpWyLZKDsFnnSi7F5WEg?=
 =?us-ascii?Q?RyWhyS2P0bh2Q6jaM4Z3pHGrVBT/A+DFT3j8L+HgPelhfHKvUrMCQJcF942f?=
 =?us-ascii?Q?snN/QgU8yW+HcT25HWPJxRX1/n++HVVwBANsfK8VNu/x0FkqPYmB62ObYsXM?=
 =?us-ascii?Q?j/ZP3zhL44GPWJK/Tw6v2KR/vwLSqDtQ4P/gCKZACxlNOQo9wooPOPrla5DZ?=
 =?us-ascii?Q?hdPVkw/RgXuDNbPGYyVTKTbYpcni/KVu4q9ZPej+FSi3UwSMZifPmiP3HTfB?=
 =?us-ascii?Q?FHR/HPI+rjw/XYRFNatCETfyob2iW3FQHjT1q1lzEP4RpFre6eY8mfv2Ih9Z?=
 =?us-ascii?Q?EfKCwV7qBUzz+J/bLQc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f87aae4b-a663-4266-26d9-08d9f72d3443
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 00:32:57.2978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svcifu8njZFsfjniR2y4ATZVwSL7yNHkv1R5YgXvCC5BEoBpmgqh6+fpz8gp2vxA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3542
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 23, 2022 at 05:07:01PM -0600, Bob Pearson wrote:

> Bob Pearson (6):
>   RDMA/rxe: Warn if mcast memory is not freed
>   RDMA/rxe: Collect mca init code in a subroutine
>   RDMA/rxe: Collect cleanup mca code in a subroutine
>   RDMA/rxe: Cleanup rxe_mcast.c

I took these to for-next

Thanks,
Jason
