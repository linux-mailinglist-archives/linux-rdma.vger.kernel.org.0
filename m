Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815FB52EE60
	for <lists+linux-rdma@lfdr.de>; Fri, 20 May 2022 16:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237156AbiETOpS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 May 2022 10:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237092AbiETOpQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 May 2022 10:45:16 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E84F170F22;
        Fri, 20 May 2022 07:45:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnuhCraQ/yTA4pX8VtvoNph7DjzDHECkkd5EOwvvN/zCCnGmWIRI4UcQjIU76YGfDxBeEDhfI5xOnlq02yAidWfLrbwwn+8JYwK1DzIFDoABxypVXYwp3M6RD5Hq0CACJi3eJl1SlGN8bw2sgHrhnLJkUcrDoIcmmFdwUFk1Y1265WubcK0z5Zv4LcBbgVNMemOyIUboM1pcPvNSxjArYEY1oy0Nq7jkja4Adx6hfWeNR0kRDwU8x0R10Y+Qb9xEoGZjaQaZ7K7yZ43/rKY9HiwuJOKjqzMuudwCSzohbfFpvei9uZP5J8JMKRV5QeMzj5DMGP4Yxp6BYWei+r5E1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9o8czfjRm88/ROisOKix6uiVn4Jg6Sr0YAoQYW5o+9k=;
 b=PDQgBoOJZDWVICdUvjQLW0ul5Nw28/FIQ2m9Sa7g7oeCH1WCYi37QDQpmj7YJw/6Xk6QrGimjRBa+en/+Br7wIJ0HjgGv4ZAbh0idUIWYxd63q7B/ZCR2m14Rdy8dsndRPy7EnNCHytg5ok4FClsE/3XKBWqTMAGZdkJ8y7/4/yLQGdPNDu/HHjIFMtKkLuQqR/E67FQnX/oFy2O3qK8/2nhJYPQ0KSFIBpsQRCx4bDU1k4hGNNvwbpOHkk6mYKinwrdHoSVOaVopNiq7AjcL45JQ1AcNfKlvv1qTVjPkDxtgzVei7XzI12gVO3WDgPKpmiRwMoLalwsa7vePOBURg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o8czfjRm88/ROisOKix6uiVn4Jg6Sr0YAoQYW5o+9k=;
 b=kQtj7QuDlO+8SkS3DJFXfQVYpiMxb0Y+6It/WQDlpRQ3md1PQWBGN8RH/JLZNNdkhIyYESlJvJ+ptyKRxwNeF6f20QHKoIFO3H6tS6MB2LmP435ibY5Rnm1qEyeDoGIyvLUxeQ7tUiFz6MMh1XBqjlJQoBrxUrjkCYJKszb3rqlccKOwOyYcKsem7FTpWnUlnAPIFuDSSm59k3Z8UvX0KFFGyKC5/a6D+yXj/dO8wt0bRDaOqdPZgEM4lOv6Lksy2XzVtnKt3U78StdSuqgUNle94XNEeGNgFnLwCXsFxiE746Fu3EZZonZRg64XJUFZupklHjOeCExEjg2gYaH8iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Fri, 20 May
 2022 14:45:13 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%7]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 14:45:13 +0000
Date:   Fri, 20 May 2022 11:45:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearsonhpe@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: Use kzalloc() to alloc map_set
Message-ID: <20220520144511.GA2302907@nvidia.com>
References: <20220518043725.771549-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518043725.771549-1-lizhijian@fujitsu.com>
X-ClientProxiedBy: MN2PR08CA0006.namprd08.prod.outlook.com
 (2603:10b6:208:239::11) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b53422ea-b3c4-4173-23f4-08da3a6f5908
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB580530C9D6B00A1306F76A37C2D39@PH7PR12MB5805.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y3lh7EI6kxkvnV07D+cSJbiPUKs3e4mPqpORi1cnAIv2ijgWsnEhMKQfuWbAZsFDwPs12nm7HPsl/EFG6IeJ7bA6NW1ps5NoTsuH1XVbH8LiLEXAOW0IWntjwwwgWRVHi7X6ir0X0PJ0zYLWd4slw33t2SjyDhFv6YP82Bsl0o1/qLJdNhzoxZqaFuHgjPDaIVsXMf3bpbjUAm2n+GTdbGpp2Jtb6JftzShxjkita28unMCod7G1w/w0tgO7FEJKhb79j938yWIHHcGsrox/YjNvdQcPQnyyz+7SxB2gODLQ63NdnyLq9VwUxnzUaWZkBE6NkU0j8nCa6wBRJUvwXQz0wJoN75+hmDPOfuWxr22i3UyiF728RzxuFKFo2edXZQm8NiYpiUymQfZ2vlM4v2AzAD3XY2Xd5AsKHyZ5WaSEgAepneMrLBwG2ARAa1JIF+YZtzHyja1L//VsLhbCI8g5SnUc4mOMaNhFFGEBlrFL0rkWuBzmcLTWf77T3/B+fP/wWNSM0KatJaea4M+8TQlJ3pqShVKGvySWyty74JR+3evsPW4vKxtCSJoH7q2UOzDSPQpZNQ9LvWWnH1fjkROdQ9XYgPnoQZV2vITHgjl4M/+UWT+SmJ6xnvYa9zaJgq2TJGsTWgV3VAytfiO07g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(2906002)(54906003)(6916009)(316002)(33656002)(86362001)(38100700002)(6512007)(6506007)(26005)(508600001)(2616005)(1076003)(186003)(36756003)(4326008)(66476007)(66946007)(66556008)(4744005)(8936002)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZCeOck/v0iv6WBRd0COScLJtt6EpU4PCS+g6Ra3IEED447S8ZGUpu/AM139r?=
 =?us-ascii?Q?mOifMl3HerEyGJqgNcPzIr5LLXY4VnWXjdQA3XE8oVjpSimpIh9wW/2XQziz?=
 =?us-ascii?Q?X5zXACSXI+TQ3Vvrch4PdTv8qV94KrLMDfToKu7e8meC+e+SdHlKuYDMtEnt?=
 =?us-ascii?Q?yuUbKrCgfi6L3I0gO9t49vUlcu+NyZgdGAc99s9LdJjjTT/nGz0//mFKr52P?=
 =?us-ascii?Q?tqEYr4rnk+NekslmuUa9/GAxTK+X48CvdPHNkXkGSTsXtCXPhTLDonlAY7Bw?=
 =?us-ascii?Q?c7sx5/j/AdXJndFh0OgtqyUC286bI+kyqnl0rbjS8Y1ZvKp0hu4XElAAtzuY?=
 =?us-ascii?Q?M6CuJwzj0OQmleQKF1dc4b0c+lh2sA6EpJoJGSOHSXu/gQheIO0nvt/soPSL?=
 =?us-ascii?Q?INOVB2mQYEgKhOAaKURpJR53P5Lb1ER1dtG6KaB5vRkT8iZ8f0rss8DBhBlq?=
 =?us-ascii?Q?wE8rK1m1p97gmmO6noHJizhGunQ275q0So7qzyq5ua81pANH/qiJT8s/MfBY?=
 =?us-ascii?Q?ktlailkBLTA5wIfU/QfVONBXUL4RP8xbVBB+Fy3dFj7MDumk8fdJC7Y1TSP9?=
 =?us-ascii?Q?sku3/b1xEaRWv5P7RRlA7fkLNeG3NTv24hXqQPn6OFsolK+UGbSpjUFBK2XK?=
 =?us-ascii?Q?qvc2CQqpdRJQawovLsatnTh0qrB63zCErPlPGt+EgUpt6N6asYabIiD4wHhP?=
 =?us-ascii?Q?dCCm/4NuZa0e9m7il9XTC0U8jFjoZk55OlxVLkh65mKcYEFvUPyWoj8B59L0?=
 =?us-ascii?Q?vFv98N7peNONn+AuvNfOg5qfNRSFgMPTWE5GkCPo4CGs02AYX5FXudUZwVDC?=
 =?us-ascii?Q?mnXdmyzRZOasCBYMiQmRF2T/NhPYjCxaBcusZAZDuNH1jH6eTcY2p64x99sN?=
 =?us-ascii?Q?VW5z1NlpQ+I+rFv0viTKrH/m84B0O9/Ao4pc29HrJvsvqhHZRcqd00BgO5JX?=
 =?us-ascii?Q?8jgz7Pq0W5Lp5lzzeAazBnEMzMOjAnMLJXrgvStM2PRT4u/Gmt+SPgXMPCj+?=
 =?us-ascii?Q?zroGU4ITQL7B1b6T25/vuMzusw/gAr7J+T08YJz26Lw8kRgL+r/7OayHK3a4?=
 =?us-ascii?Q?UPU1bbs3k49QKvI+ATOTywc41/TLgD+kmVyRD1CUKmiasYiyqqIwLH9U3KOl?=
 =?us-ascii?Q?Ozk03BtjNss0FVuaUNjkZhul3AeoyqNqfUDUDtAKPnVmYzawbQGKHi6x+kQP?=
 =?us-ascii?Q?dO2nvq4s7iGbkQErP/mQb1XeP4NR0jwKruRjtMFzbE7ie27INEw9JPW7VGcE?=
 =?us-ascii?Q?2lTqM+JPMY3tdIG9P4QQsU/Cw+MeDTHwHA9ajXoKEtljHp/He0KAAS2lj/c0?=
 =?us-ascii?Q?eZ8J7KWjdc/l6G80MjURDe70Y5rB1cqsTYxtbt668Jtml/dlxA3KYGV1/Ylm?=
 =?us-ascii?Q?ouqMbJ6tSx1xoaf5wTFnSFq4uV2mJZ1kb3fsfxBI1NCXtxrt1rNLNze1gjuf?=
 =?us-ascii?Q?Ng4QuHoWTAN2dqWts61hxQLnhFLDQF2ZFLNkDwx9fHDUKG2hkfWnekt+A8DC?=
 =?us-ascii?Q?ATKSQ2utjW+F8mIeWqkLrnaTvD00beGTJrXvI4RfUl+TNny2kD/ew4a31/sB?=
 =?us-ascii?Q?4VIAuHkkQWVal/AHRREZswLutEacFWbmdvXKQ2CKu3Y9yornn0YU0N9RpIut?=
 =?us-ascii?Q?LvFuKZWvNKqhaU4E1IQmQu198A97o4+IczwiKgClyFYpWZzsgZvBuf1APy2d?=
 =?us-ascii?Q?cBJaqVl83MZzhweRCkKwUuRYWN7g9JHHasS8KiaXPqmEzV7f6y5ETh4oJJoa?=
 =?us-ascii?Q?TmrKOjn5Uw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b53422ea-b3c4-4173-23f4-08da3a6f5908
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 14:45:13.8176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNqR325knmxI+AkxQv0PtLBauXE3cqw9eEDu+oboqWMxYWgHSLbK8R5dQdkaw9fC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5805
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 18, 2022 at 12:37:25PM +0800, Li Zhijian wrote:
> Below call chains will alloc map_set without fully initializing map_set.
> rxe_mr_init_fast()
>  -> rxe_mr_alloc()
>     -> rxe_mr_alloc_map_set()
> 
> Uninitialized values inside struct rxe_map_set are possible to cause
> kernel panic.

If the value is uninitialized then why is 0 an OK value?

Would be happier to know the exact value that is not initialized

Jason
