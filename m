Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5BC43A04F8
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 22:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbhFHUMM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 16:12:12 -0400
Received: from mail-bn7nam10on2065.outbound.protection.outlook.com ([40.107.92.65]:34144
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232764AbhFHUMM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Jun 2021 16:12:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P708VbeL9F4LIQ9ZhN5y7OaJCxqhi6OjhfPsE3RnFCnZaWDFZ8M3XJ71An2uSboWTubb4/6IrHkfYFyaoIaodkHzNA4I0ypolthA5VjehY3OaOdybMPbYFKTobhiX9RlxUWOZpkjT3fV5hErqBhz1sBPlmV82oKsYm6Fqq8u0JMVd1fUouvN7+H27K2o9BqEb/3Wv7RXQW76Xk8JwTu65C0bzI8lCQtfDcEhFBaVWPAFOe4DAYqBiIcEvRmSNuPxUYp8hemrvzi3T9+ZeBVEfVMm7WjIk0zhSUiA2qwolKmxAzVuALHFhn18Yc88SSjCkdtpv49nD4vedE2wTMu+oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vm1EgulWJmBpZqP+jAMCOLTl7nD4hpJyNHWRCRbPxPk=;
 b=UeanpJ+kxap9tOJQEg0hPkSqhtQdnTKpAEu11M+FQ9bxw8Y/mO12FbZdKoC9N6ECPjM2BhEd4mpJQp5jORItFNq2UDB2/HMQ/vCJE9ThoIv4qB68xlaUhmcafYZhWDOyUva7s0X0UDHgZ7xujFUbUjUFzhRXCi+y3GN4Wq0qSMogFApxD9f1eu+K6j2N9EgdaLH0ZLRSfIV6wfJk5PXElo8dHHfdcd/QJOyTKg16kQPmh5zCI5cqmAVRKiPdxiTcZwQXa/Y8qor0WV9R+xpRzfRGRDo5BnI0lisvamStigfbOM9+W12DyGxx0IzrK4tIyZsXVqXy17+4ym95LCFJtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vm1EgulWJmBpZqP+jAMCOLTl7nD4hpJyNHWRCRbPxPk=;
 b=IO0k7E+B9wD0XNgdXv4eQsj99q8/nTcm1RI9v+SlduiJTeWcf+OC3JELfotNyFNmJq44EBa0yTSGKRnP8dCDHXbfTZakGxFwGVIq18+tXtYfR0Qu1ZTd096JjuCf6Ip7gTZqN/R+yxoXzgHWRpreX0LTD1oNtlZ6B6t96qqnzaJXpQD67/730cU8nR9m9HD/wNNXHXkEYeQs64EAHpsSkmK/OC0TUmpEF4m2LrVx03QlQdY+FP2xZqBOz0lqS6zg/RCjckLiVnxQbRJa7iIzOqeWUsH4k4aNLDhNSdyMkD38PGAqPI8tvG2GEOrJ7SBq3jXfy2lUqXCo/WmxkxP42Q==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5031.namprd12.prod.outlook.com (2603:10b6:208:31a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 20:10:18 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4219.021; Tue, 8 Jun 2021
 20:10:17 +0000
Date:   Tue, 8 Jun 2021 17:10:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, Mark Bloch <mbloch@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>,
        Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Block FDB rules when not in switchdev
 mode
Message-ID: <20210608201016.GA992876@nvidia.com>
References: <e928ae7c58d07f104716a2a8d730963d1bd01204.1623052923.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e928ae7c58d07f104716a2a8d730963d1bd01204.1623052923.git.leonro@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR01CA0060.prod.exchangelabs.com (2603:10b6:208:23f::29)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR01CA0060.prod.exchangelabs.com (2603:10b6:208:23f::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 20:10:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lqi3E-004AJ3-SJ; Tue, 08 Jun 2021 17:10:16 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3418ff55-9b04-4986-2244-08d92ab96f81
X-MS-TrafficTypeDiagnostic: BL1PR12MB5031:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5031BB912FA0CC5CC4C176AAC2379@BL1PR12MB5031.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: npWYd4VOVwIScDV1nYhuN2znKKYAVj82HV+jJcfCiYCLzYPdaBlKVzV3iADEcPXQuJE4Uct4XR0JgEDJw8aJeI9iv2Zk9BjVIT8rgxFGLpkiVPfPvwYDQiQpV/120hCXgdbcATMYvGpBduNMX11lAh52AkGoQQqQ0jFnUh6tPKjzs3l0285PbF6XWP3oomtF6uA5jbdovMpij5UUcirf/D6ByWy4Cvxw4p0xJ5UsPIsDQZ6gEvz8d689YquuoxYSm0u7QsAiVsDiulYljyTEuEwzCt4B3+QgRtskj2NVdnsqtP0f+xxqcAFIac29GJnDZ7ZpoCpisbexx7aQP6hveUEOOhpC+CXOR1g6uI760K1s2zJJZ0RLIB/ORPY5qgUbfx9gwlfC2jZqXNC8vb5zdrj6MOqi/YkAd80VPk7LBZMsi0Xs7sCmuFtRTOTbQCYDc1HhshfqOGTOR466dnZXv7KIVkmOufVnYj1V9ajyfFMdVxTFD0o7I+wSN+HQN9qvTpwymgeoD70K1j050nP5bOHYAVtIK6GIc5gHkd0Xazi7FmWH9rKCAqZuESLYDphNiolSKwkDxcR+hnUYrqyOnc9Z+r6cyYmxOP+m8VpxMx12lVO5vyFveT5BtrJSMbSyQq6NQ2cCCL3yB6a6TuoxdhUiXXyD7vs4gGmOHS5q8gE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(426003)(478600001)(5660300002)(86362001)(66556008)(4744005)(66946007)(66476007)(2616005)(8676002)(38100700002)(107886003)(36756003)(6916009)(2906002)(9746002)(8936002)(4326008)(316002)(54906003)(9786002)(26005)(186003)(1076003)(33656002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/DO0jaGFofxj5gD9z6EbNjRlzkPSZZev2dkjHjUp0m6SpRU4p2ZEoID6R8C2?=
 =?us-ascii?Q?xm23fct5bpd5GL/sXgS5/dPxQ0AavfDb+v4wipfMZxURDpkl1znStN61+8wl?=
 =?us-ascii?Q?Nsuo7MJGEwgn8JJ/NzBjvIEvttCwO++jTitpASRkYKEssmSoTp7ihZllMaiS?=
 =?us-ascii?Q?JLzPq3u87+iL3FXV1ZXdl4PTZfDsPpruXHlGnkLe9geHIYiRv5PXzMhEF+Oq?=
 =?us-ascii?Q?9jat/u763F+naMUUN7hhm700J8cggJvgXuy7hMnD28FQbekG6NZ1jYqgnBos?=
 =?us-ascii?Q?ePp6LTYrGN5C/y/q0EpwR5Wr9X4LPeZ88hKiolAr2WIioJHsO2OIBwcdMGMK?=
 =?us-ascii?Q?Ze3M8czqLDNg8Oj29w9ZOCT/TBzeY8Hr7hhTULBM1BfohfV9xEFYulaPqLSB?=
 =?us-ascii?Q?tNZIK+bcYhPHAx5Hinos2Zm2COUN5kNhwtYausSqHkD0JzYqLyf+uqZ+Mg5h?=
 =?us-ascii?Q?NJGVMLVacbZgcAW5S4s9dht9tdNHoTfiqRd6xV7KeSE/wvVT/QNFRsyIHodY?=
 =?us-ascii?Q?Jjf1v+aEBb+l6MqGHy6A1Aa+Xiz1ssSWNZgRVdorFOgWimdcXD9hOFYIqMfU?=
 =?us-ascii?Q?i7UoTmVSXiVAMLs7LYwHbjtclSI+BHUErhnyN7Fialji0IYQXbwnWGxioUH8?=
 =?us-ascii?Q?4jtH6wr7QqiyJILTKZe3rAICIaYsZbsDqJbleOC+ZJFaK6tf8zftZ/tGceqd?=
 =?us-ascii?Q?wE1edgCP1xEMKHEy/mmIQdkBtZoV5e8+14eNXKUZU3oaOVcM9R72TuL9KULS?=
 =?us-ascii?Q?Jci18tIqgfgI3r1zo9YuVBGoEIk+qigpxmsX1kvbSlezxo6Hedy7QA46O0Yw?=
 =?us-ascii?Q?/93RRgaVmlMtI9hs9BPAMmAY/0MVAGjmLbX54jsylXVJ8dqMkRnYk8e6gMe+?=
 =?us-ascii?Q?LOXby4IOxx5wADmQ1IU9O63/dAnitlzCbDnXqDVazBVgrOmJEHqCp2T+cRbF?=
 =?us-ascii?Q?66xOvOxNmAgqHW//Tfhkc4O5YLF/7hRazY0NKN80HM9RY8nBC+75DdcOwzap?=
 =?us-ascii?Q?LH8F8hZhXP8T8JSAE7sjCLdp1uOqwZdXK4v44oNSBXJL/kOAqWnz1j1UxgV3?=
 =?us-ascii?Q?8QczfW5osK+Nf5zwTtlV4kFitBHu8P7/eoBzQgCLU+3oI4nfoU0yATN35SfJ?=
 =?us-ascii?Q?di30HIKdtpMf05tq1cYwZ8j/Pm+e3dbRsLotZuSDn8wPhvrnnUg1AmYuNIj4?=
 =?us-ascii?Q?TfBlRG0uenPQO65sk4dpuGq27z4SLKlL0CFKTe+oQ7jbkXmBdaeaDqbOEKQq?=
 =?us-ascii?Q?ASp9+7apetHfEtLMTN8ZaIt8FiuPrP9CC7sq2pxn4kGLh+RtyD/S0AQigJmj?=
 =?us-ascii?Q?ZYk06M3n6c1eCoEVG7baRDTp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3418ff55-9b04-4986-2244-08d92ab96f81
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 20:10:17.8621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z2icBcyb/30rheYivF58WJ4GfdDBWaIoveC45NE76ml0F8Q5T6iMg8SXo4ll3FWu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5031
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 07, 2021 at 11:03:12AM +0300, Leon Romanovsky wrote:
> From: Mark Bloch <mbloch@nvidia.com>
> 
> Allow creating FDB steering rules only when in switchdev mode.
> 
> The only software model where a userspace application can manipulate
> FDB entries is when it manages the eswitch. This is only possible in
> switchdev mode where we expose a single RDMA device with representors
> for all the vports that are connected to the eswitch.
> 
> Fixes: 52438be44112 ("RDMA/mlx5: Allow inserting a steering rule to the FDB")
> Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/fs.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Applied to for-rc, thanks

Jason
