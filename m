Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA7671F64E
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Jun 2023 01:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjFAXAw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jun 2023 19:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjFAXAv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Jun 2023 19:00:51 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768A1193;
        Thu,  1 Jun 2023 16:00:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdUz7UvVrJvGt2FhUbCxRPLgWxIA6uxvlxaKu9MqyaKCa4naUzpEp6cxnpDYFLL3f5TOt4tNUIJ5VeA6TAEMEy8zs80BfM6aRoUq/gi8uqqhO9ELM7GDHm+i0ungUrHgeykgmVR2FXxCIOqSfBkqtOAVpJba72wRAuo7PPFXxXa3JVQwTW2M80ocYe6sTidrc7wfUjT4StoW0jQR3lngK8ZVG2Y0U2TbaCcjzd6Rf49pmcdKUXojLTcBS2zIgUN/GhYs4m9hhGX1l9XRVyc6fvAgEIgWtLgbW0yyCAl8T62qdKQpd7TPIZFXuUwM2RKvI2VkfQ6W/u7B3LJQewvHEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0PQGBrOsomxrz5d6IVzHUYRZXzOge0EzVH20SIiEa0=;
 b=AWobaOeNmgLQpnaK2MC+uCWWVMPFShv4ivLYusx/no4CocxJD0UUwEOZ0Tr/Jo0Bk6FmElYbUJIT6oh5COUIK9tzbU3IsoyPsV8rSw3uqtNMWQbr0ngj0nu1I/M6JTWxC59y3FqFFSWtGfOSRtBRXFRtOrJCHKfLDJMjYYkC/c+YjBr1SGWCaftMjt3Lx+x48KjjtjlYoaTaJr1yDYesolXrAKDn7P1QQZWXmJqag763wEGjzbNPEvG85cIA5j5F8eoCf6ctr0G0BRgHIfUbkdBTyAtb4NsWT6hB/RsOTY6nS/e/fjp3bJVkDyrmeA/kmABfW6kUC1WQ785eSw80cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0PQGBrOsomxrz5d6IVzHUYRZXzOge0EzVH20SIiEa0=;
 b=qqMeKgzg53dAKE2EQIhx5mqTIuo3msarcSEkvn19PZNQdeVh54d3FCCoZw4YKpZ7DzpMGoSHq9cbCQNtWdJFq+HzZrVHkVHNbbpeaZCNSLaMPfSMTPjrM2z5Hk01WRx6lqbR6wYWMEy9Up7yLp9CHef/V2e/2tdF//gftfHbxGhPl8xbEvBkDzkaUbAu6DfN7zQdQNy1CDDQl0aOXGlluDzBdsPcmdcrpW9/3AyfMjMuoatkivghrb4f0cpOKOooE+6qDjZBxV/5cR5os0oreDahjf6ZyzXuN14ir7y894en2Acnv/i6xPpPX+jmVGpW4pcfyz3LSUpCZgKp1ydIRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB6053.namprd12.prod.outlook.com (2603:10b6:208:3cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Thu, 1 Jun
 2023 23:00:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 23:00:48 +0000
Date:   Thu, 1 Jun 2023 20:00:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-rc 0/3] RDMA/hns: Bugfix and improvements
Message-ID: <ZHkjHl1H02sr8pnq@nvidia.com>
References: <20230523121641.3132102-1-huangjunxian6@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523121641.3132102-1-huangjunxian6@hisilicon.com>
X-ClientProxiedBy: BYAPR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:a03:74::38) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB6053:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ee93b9d-35f7-45a0-42a5-08db62f40a04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F4GvUhWQ8h3yy55nVA3WiTiw3lZJOszOT5tx9Ta4nwmh8fy06akFQPU5a3OUAFM+gS1Tn6XKOGfCjjNHXNynSobrCUAwo29oHKLtnWQ8EjviDR8MiNjs+PtVr4/tM8upUddqCcaKiua+0H34HB9fKjcWfTKqSn5ruy9raqeIBKFPzSpYIytjz2oqz2OZvghhNc7UquBh+IxmeNK7wnQPeuCEDnpvsx07nWxuZu5VRxMHqAefsZOfK6qBqYCC+fUzIXm3EhUCclb2QMpLu+uUncmDxMqxNAVhJ+f4aKMssoDPTC4dKeQqkbYkVv/9v1ZFxw1xi7whPO5evosBH1DShz3XKznr+4tc8vdgQ+0HkKbZ2JLV3HCkTcY0sd5iKd1y6p9ZCS/1inqAD2bUhIuTWke8UuYMYMgwvnWXpjcj+YsU918umxgmR6wpvzsYChUnc3+JSKFgYlSUIPUX81pYo8n0Rftt73JxM0CMY5Z+uhpTCNeGCDAmu/obecg2ETPxqO89taQSSEy/6pvrkDeuZ4ZgAVmQGV6J7ddYJxoZKEoQqtd3G47+iaSdy15r3r9z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199021)(83380400001)(66946007)(4326008)(36756003)(41300700001)(316002)(38100700002)(6506007)(26005)(6512007)(6916009)(6486002)(66476007)(66556008)(4744005)(2906002)(8676002)(8936002)(5660300002)(2616005)(478600001)(86362001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ILif5hhl46JF4yTRpxtE7X9v9M64ZVMc0YUwoPGKkj/VdSQnYhyASI5CVmmN?=
 =?us-ascii?Q?j3qoX3K3q59j9X/te3o6HPKeWd3tgqdpHmZhb9LH9+b1Gb9/E8MyKgcc2R67?=
 =?us-ascii?Q?M/lJnY8oXBYzf/GOjzO4Zkcuuz/S9/VWyLUcQqSBNQbYg7Ci6nw8TB1Oj6Yg?=
 =?us-ascii?Q?Us2P+ltGseOBON3znrr/MidlDg2OBo1Lcs65+alsJ58Hh/++/ogGVtsbctQG?=
 =?us-ascii?Q?PnlA+yqbZLovGJ0wclNcrTF5oiS+ZYa4+MKWpckAIPM+u2RHSsdduhxpUoHi?=
 =?us-ascii?Q?rCGMVgh7Q3MZr/ZetU6ef/vg0u7uee9dWvJuv6tz8Ty8ChTiTX2JIoI5vA/U?=
 =?us-ascii?Q?0VY2t2Jfzd0bBjDbzF+tf/HlM0P4V0Vt6DJwyBw7RzzhOHgGyD8BvbsV1YEZ?=
 =?us-ascii?Q?FS1NS6TE+TOWj4Xy7LdzkQUOmmse5HhXDcCNoTnJnaM/20pBxV9Sb9jxdFu/?=
 =?us-ascii?Q?fSrUhIbJaL+ovO7sYwYO8NlwKrHiKUmiZ6lwC7zCpc0doRbOVICPKM/0RZhV?=
 =?us-ascii?Q?H8T7LxQIy9loeHivoySlaB6VQH3N2+xVYmgDYX5/GUTuF/EQGZJXScViD9oF?=
 =?us-ascii?Q?rjrX2GFYUIWrAq8Nbglu1tUkmgeDXLHrvs0XtIHMmTroIENCUzh0qVpZKPir?=
 =?us-ascii?Q?LB+hTsxVuGfy+DrYl+5ksj1o1cZTsPrRAreWBJmTH7F13KO684HkEl65UDp6?=
 =?us-ascii?Q?23sZXSHfOmBQ1iavrBdNijgnHAPUta79yPDnjex5DnlAm+l0U/V9dzA8lJli?=
 =?us-ascii?Q?2L0Q11pnZPQUgVRWW/1w0gjVVf62yhFxWC8sGHAsWVzpBJhn9sluUSqdOZOC?=
 =?us-ascii?Q?AHYeonoVxkHaOwxmWKMUzomQdRt9W4saA6+XC5nm9Yeq4JDZigEWOyiTWetp?=
 =?us-ascii?Q?Ru50ZwufIfGkS3OL8QDUEdT9Zw9gnLKqehysvEI6EheeKAlFL4JdriFnr/sB?=
 =?us-ascii?Q?/4FFNMHrIHsG+K0fE7GCWNAGtovVC5sYfmxdGqigblXHO3g9jkORHVXteqCk?=
 =?us-ascii?Q?8z1iYxZjB+VMo05DEdbNzSeC1xHBvIxZXtS6tTldw5V7oydJZDM09kBzILlD?=
 =?us-ascii?Q?GWMalzXl8/4c/tfqMuWeFlCuKaPyyC23tEtS4Se+7HROt/BHBrEZvQRc1GyF?=
 =?us-ascii?Q?9M1M7FaZX91cOX5OSGCFSmzIobB2tx41d1U5zMwCZ+dRZgha797qFBjnFazT?=
 =?us-ascii?Q?kIzj7xGQKd35pm+P5FgqkzLjAevLyrZvox8E09uuizHgk/edSnAfElMb7ob/?=
 =?us-ascii?Q?zXv4A3m85zGGE24U6U8y/DO0a6h0t+ucjiKZf86tc8Gt5S6LaMGQwpvvWNmP?=
 =?us-ascii?Q?mZz2EG+9U9UmBA3sF7fgG1ylazhKBsHRv/fG3vqtq6U9P5n085szjMRmXQyj?=
 =?us-ascii?Q?t42xJJ1Oachz6De8M0M/r89tJd4QrU1S6jE37nfACq4qbYpnGXKjSJek3+uG?=
 =?us-ascii?Q?SA5clnafwma43xUDNDfv2oux8+7Q9arp9gzmRaY5gcrAGnXEjBEMhFvgjgSm?=
 =?us-ascii?Q?1FNiBZHvB/taEhpvzwoyvdIiGwJ25f4bp5ANA4vAKqQf73o4tO5J1Kn7HMSd?=
 =?us-ascii?Q?7UXBJQ/MmM9Wm/gnmF7wvLo1MJBBfWLp6ouOqCcq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee93b9d-35f7-45a0-42a5-08db62f40a04
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 23:00:48.3871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TfLhvN4Ixeqn0zz20j0rgUS4PqCpCtWfD5jl6gU98KX7NXtKHgBZ3b+brH5x5hT5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6053
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 23, 2023 at 08:16:38PM +0800, Junxian Huang wrote:
> 1. #1-#2: The first two patches improves diagnostic information to
>    the driver.
> 
> 2. #3: The third patch removes unnecessary QP type checks.
> 
> 
> Chengchang Tang (2):
>   RDMA/hns: Fix hns_roce_table_get return value
>   RDMA/hns: Add clear_hem return value to log
> 
> Junxian Huang (1):
>   RDMA/hns: Remove unnecessary QP type checks

These are not -rc patches, they don't fix user facing things, so I put
them in for-next

Also there was a compile warning I fixed

../drivers/infiniband/hw/hns/hns_roce_hw_v2.c:767:20: warning: unused variable 'ibdev' [-Wunused-variable]
        struct ib_device *ibdev = &hr_dev->ib_dev;

Although it could probably use more fixing.

Jason
