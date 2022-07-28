Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0F4584489
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jul 2022 18:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiG1Q7M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jul 2022 12:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbiG1Q7K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Jul 2022 12:59:10 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E0370E47
        for <linux-rdma@vger.kernel.org>; Thu, 28 Jul 2022 09:59:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLJPRfiIoTBurmFL8ICDVI8NshCq9s/4+AySwiAHPYRkCASirmzhv4wmTwyROmTBiYsosHfNjs2EgTt2pWnlwcc4OAAjdCmOdNdAjX7+zg74qcRHRvxAeaf7sExYnnNfnaFA+EZF0jnaMTWh5GCgj/40/p0bWdZ66noOvlhPl3LvUdqb+wb0hsxPsWjCFP5Yfkam3PYaDOIlg7HenIQ3ztrM90n3fLOJAdmc5Q2JvaeX5/focbxSBJahyrlbqs7H7NpgDQg4L4Ytf+v7sjBjnpSK1VsmyB56JY/Oz/I5IHhiMr7qOfwALSaSxRBZQybGcc8XotDaaxEUgodF/ltvzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6QyCQIoGVSkiVjVHy7oVintFEIczf2yh58P4oTU4Ks=;
 b=AV3NR/wdij1s3S2cWm9pX3maj36rK0EIz39zZ6kRl1XJkBA9KDue2y9eTP3J5Qt9nOXQqaZWy/FwvXSrr7zG8MwJsYZG3P1iwaB3PtwYfnEXPTz5B+6tw1N1z5ZcLObnohBVttOpImhSqqA0UgWd4w6TgFDIAflCr+qOXIlH4sQi2wA+Nusk3eUZFpiu0kXE9dLUFZRhb42DgF58l8jCwQ9myW6Smq+akQtyfNgXcke35JePnuAAS3rq+janxzrBBs/UHpH9JEELi1QYJoTgYKA1ev00o9TJRCvZ+w77RzNjVZ2O8rG5t2YC3Iloz3lnmS061KvHY/KLkwDJUHmGqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6QyCQIoGVSkiVjVHy7oVintFEIczf2yh58P4oTU4Ks=;
 b=greRjuPFJW7Bzd2N1/oyxQP3Cf5Tvp1W8I2UBXdhwfdKmisbJ1vmhYrZ491CSZJsaQ8z0xwJ8Rdpo9187uOKLYjLO2fMH6unecJKcCTaPV15XozVdx5Q/K04r8A6Nek416CrrwVG9tz6QEf6aWKlTGQCk5LxBhq8UDSlTsttbNl7qzY+bxh+G4xIyHMLo5EhuQYUc7EwAMNhBKMmv/v54Qu+fAuU69zVsu55qrbMOa7ttf+roEKxDKoi/wOKJasAyaXelphoprML7meEow0RvXrZom/+iZzBJ+QXAxViu//hHWk1Kt+gyOwepL7DUoK3vugT6ZVjR59W88qm/XcGNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN0PR12MB6271.namprd12.prod.outlook.com (2603:10b6:208:3c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Thu, 28 Jul
 2022 16:59:06 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58%8]) with mapi id 15.20.5482.006; Thu, 28 Jul 2022
 16:59:06 +0000
Date:   Wed, 27 Jul 2022 22:04:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com
Subject: Re: [PATCH v14 0/11] Elastic RDMA Adapter (ERDMA) driver
Message-ID: <YuHgsTJ/tO9Lbodl@nvidia.com>
References: <20220727014927.76564-1-chengyou@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727014927.76564-1-chengyou@linux.alibaba.com>
X-ClientProxiedBy: BL1PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:208:256::17) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3090ff3f-79a1-4e06-7661-08da70ba7b5a
X-MS-TrafficTypeDiagnostic: MN0PR12MB6271:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uj6GG8v/HtpZs0qJmhiR1GUAQTHd7kqZMrnCA0VGoYeWaWzAujSx88cwWiSjywumxiIzInNk20JZV7q+wxvaMkBGqpwqdzqsMoGiTYZSfXQWiRpqrPd1DQZ+KDAyREg6k55t+IFyZLI4AwVafVBQ2eU2wwC5SChj5Zke5Fr/HpRKxRT6Xu31r9al32q4GlQMuH7inFGmEuWRy6Ub1Ihtqahacm9XvE4dYPRVxnk4EFJ4OwxnfNrdOkd9NKji+H64OJFt81f+2wZzd2us2/IczQSZ9t9KSs0P/r70P1yHbwWuBecZktxm4efedgZaTKr/31yy2uUT/ZCi+AEw33+PUHzv2HgbZ7Vq0S2H/xVLAkYjeUynH8Guv5qgUWUm9pxIA5+5GIBNgitVauWcYe5LdloHzKGhYdCFAWcIZTdonlvNN8Lv2+KHdAAoi6TB3n2naZgGAIreC2eEu2qia5H75fGsMJ1QaTgAqAseRp4fCTn59wbHh59NuNs+t/NB7ilbsBgZNmy/TOeOOlcjXPkklloEO74Z671x1xpZRi1mzopStinc/GCHdCx/vGH8jwb/GbgB+q0/HrPjPm4EnnUpcf77bwhnDfKRBqfid/KxwA8R6Z01jfYc+Hbl3U1ufgIw1RRRRfeFuzorZyeyKDOWd2FNvbdsjHq/OgB+RPjR2jNtE/TOzMWJaMuzee4TwOBwb3FK2AtnNPRZYEvHFeuUbUksyE31SwEHvOSTLg1pjhrgAlzpva/yTwKK5U30Eie3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(36756003)(5660300002)(2906002)(8676002)(8936002)(4326008)(66556008)(86362001)(66946007)(316002)(6916009)(66476007)(6666004)(41300700001)(6506007)(26005)(2616005)(38100700002)(6512007)(186003)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?on9eClIEJKd9r8ZKEdkWxg8yrXN5UXiMWiJopKr0qSEJhdKboH3YeQ8tokDi?=
 =?us-ascii?Q?s5P7blQD5GPWtJ0gbQOVR3lGz3jMYd9Ga1/suaJpRvyQUkgoxFaoCGytSts4?=
 =?us-ascii?Q?KMpmftVEzwYMYh80DVPaOABR2Mr4yCjZtReFK76/SzHr8EpJk7c3//tTP1Pp?=
 =?us-ascii?Q?e0LyJv71mEkox+n6uT6i/5KusrL7wtJRYF5svRsGmfOhLjiGrQCC2Tt9wuap?=
 =?us-ascii?Q?6DpT2RJVkQ7re6kbcEelaNXckF1WfjDnC6opzhpGF+3faF6UpQk5urq6zEnE?=
 =?us-ascii?Q?FhsEBB7oUhBnRLIMSXbxsfHy5AFzuSqGY9RTjuZ/I+5IBAh7T9PBe3zalzui?=
 =?us-ascii?Q?bhAv1quh1gGWIMlUmxm3CeR+bfAwfoRj66Hc239apzxW9jQxvpc/GIKipsdx?=
 =?us-ascii?Q?x+UdIz3Q8PJF6X8WDQH2rmtw+KezChb+TIvqfc00mPtL3DZwiqTImPR25hSF?=
 =?us-ascii?Q?8B+qx0Fs5S3ui2k4mZdRAHHWmm2gMHKVQ/hmeQ9/7c/2OPn6yJndhbIywXwA?=
 =?us-ascii?Q?GfYVju151isFyXmXr2OUVu1pnO3D1i496GDs8/oUUwq4tA3564NnySx1gfsR?=
 =?us-ascii?Q?x+Lh5qeDmlW9mWmOEqdTt8EoeI4SAHvKyloxCks6hGwRzug4byd8ID9mPfO1?=
 =?us-ascii?Q?+NU/ZEG3JfOgMqjziQAxiLKEedRL/zXMXJHClq3Xz7KO3BatM3aOll3ImQLM?=
 =?us-ascii?Q?X1nwjr2ranllwzXINigiFuj1jg4O4IFJU3jYVT/UBs1eqCKhNghz15A1ImwQ?=
 =?us-ascii?Q?YX5E1RDdz15Vogw0g9MFaHlAYNOJe2ZFuuRQduk+lf+18aTA0ga/zBgYT+zT?=
 =?us-ascii?Q?MqICBakxHQ6QiYWU2r3PZhcwQFwWIS5/Gdc9odqqJQQXLK6yUR1NtOPp5lzJ?=
 =?us-ascii?Q?nR52WBFNqSRiUsn5VWkp4K1PgpYgxttg98gUrccKhuVw10EdwsZuZ23xl2q6?=
 =?us-ascii?Q?MW7BcS+IOJTp4eIFiX646uQufAYleoZXQiU2WracpcwlbDNa6mjWE8RSbna1?=
 =?us-ascii?Q?xtFXuFYuzOjo8jNHacAyBXejmMZlV7KtdFN9sZVSAFav1bzrpCOvbwO/i+J+?=
 =?us-ascii?Q?5ykZImKW2dMTZMhJcSd2s4KXTna7MFwlQ0Ci5plZeYq7nXk4/60jp1Zen3fY?=
 =?us-ascii?Q?7OFJYYW3ZEEBn1Eh+2Q7nVpVwG4UkRsYbNmtm7p7+spc5ClRoy3iZ2qOuVxu?=
 =?us-ascii?Q?rFbmWjyK5Aj0PAxvxcPG4iu4+b+KnwG818NG2r7RrHrcrefSZgX76zvLXhkb?=
 =?us-ascii?Q?a8mUMaHlCSQznYASI1ceJjQ/Sp05Q00cArJ5LJcZPzpzxtZ+2OIacCwIVx5C?=
 =?us-ascii?Q?lXXPmPCzokycCBVHNJEHxPEKDTD0OgpPpgPdwCTZxYSneThcEqI69pfqfTh2?=
 =?us-ascii?Q?g8cSB2YDRlTxeck0THtpRqgOu/WagGQl5MbZPXvSgvKsuqi1X9EKWSzn6lAS?=
 =?us-ascii?Q?U/31vxQOjQ58uO9nVWMpZIq6qje21EDI+KVzRGgA4UeNyVlBxp8/elif161c?=
 =?us-ascii?Q?y9KsLDE+/pdh9XFxS/T7peZZpZAqY/9lrU6WZcebP4HXAaCdNTn/8qX0u1RE?=
 =?us-ascii?Q?PQiJQzIhgt5m4nmMbtmN78HzeTkpikRIXxwp0kF0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3090ff3f-79a1-4e06-7661-08da70ba7b5a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 16:59:06.3662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UxbwsZaze8aL3c/0nXWmor/w/x0r+Mm+nF4PxEmAgRZy5MG4GhFpD+iMNE8dPxJd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6271
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 27, 2022 at 09:49:16AM +0800, Cheng Xu wrote:
> Hello all,
> 
> This v14 patch set introduces the Elastic RDMA Adapter (ERDMA) driver,
> which released in Apsara Conference 2021 by Alibaba. The PR of ERDMA
> userspace provider has already been created [1].
> 
> ERDMA enables large-scale RDMA acceleration capability in Alibaba ECS
> environment, initially offered in g7re instance. It can improve the
> efficiency of large-scale distributed computing and communication
> significantly and expand dynamically with the cluster scale of Alibaba
> Cloud.
> 
> ERDMA is a RDMA networking adapter based on the Alibaba MOC hardware. It
> works in the VPC network environment (overlay network), and uses iWarp
> transport protocol. ERDMA supports reliable connection (RC). ERDMA also
> supports both kernel space and user space verbs. Now we have already
> supported HPC/AI applications with libfabric, NoF and some other internal
> verbs libraries, such as xrdma, epsl, etc,.
> 
> For the ECS instance with RDMA enabled, our MOC hardware generates two
> kinds of PCI devices: one for ERDMA, and one for the original net device
> (virtio-net). They are separated PCI devices.

Applied to for-next, please sent any further fixes as individual
patches

Thanks,
Jason
