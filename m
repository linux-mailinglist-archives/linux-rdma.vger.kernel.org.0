Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063647414E2
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jun 2023 17:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjF1PZR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Jun 2023 11:25:17 -0400
Received: from mail-bn8nam11on2100.outbound.protection.outlook.com ([40.107.236.100]:31392
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232213AbjF1PY5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Jun 2023 11:24:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6T7yqjNp8/VwkS3r+djx1f6wJSVQ2xrUsM1QtDpfzsBQGfZT+MwaMmqbg4heHhsU0WmGWhYeKoWYntDRUL0Bjpt4Hj67O7Dm6R48Eya/Cml42XdythU7whTWjHHDstmvKzHHYvCTvPRR8xGplexvs4gdDlcqw+0qWO8vq0B9deeU1bizlNsPwAa06p6yesx1LjFtLqI7RcKpcFZZ9dfPIAv7rxlrzgrRiBUJLEbXy3akMVTMQYgg9TykkQFhON2zzI5Zsmu4NK7Ak+J26XYX91CZwO77wmNwxiylwWj7DDDze3VJGRmLQ++3zMPenHoSmmqA75FW46qsF4rI1D9tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lj93QyC8z4s1I7VxrOH/kuBGZudukU54muW/mIx1etI=;
 b=g+xhEirbYkwbi3PSK9lNF8zdjN4aIzM/JsWGMV7/fkyoL0IC7LiRGuWPQBl5zZrHRWcEzxZMBw65QlZkz/tCq4S2hpAXKpJBVH6WuWq/f5rhq1HNdaqh43BNLu8r1c4JDG9WSFaiCvbzJzk7vacM6090JabP/nSuDrwoNS3lEaqyrkDXATM6p+HuzeSdZggf9J8Yt+2vViOP+ieq7SpWobs7chFfvKruy0Uc4/gJSmE0zZWuuPQhKNOhTek4MJHGBiPTjSZKhnrtivtkFYTAjXAynTSOJ8nbAp3emjgVqbVMOkUNEVHyFipazNFwuPoMnHaeb3K6TByNspYtUQ5lGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lj93QyC8z4s1I7VxrOH/kuBGZudukU54muW/mIx1etI=;
 b=ENvcK1AmHGQXbjdMTTJM8/vszXSqmL0BET9UGi7KAvfyiZdLtkNM3OZ0mNwVxYXkySCDT3CsG2VbOr0OfpVydQNQspb25f/gUHZIjltQBEkxoE9Mxf96zzb4D/9BIdd79FvZ1Ez31mOjhdq0HaUhMLrpkc2rqvB+juCKapMcDxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA1PR13MB4829.namprd13.prod.outlook.com (2603:10b6:806:1a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 15:24:54 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Wed, 28 Jun 2023
 15:24:53 +0000
Date:   Wed, 28 Jun 2023 17:24:45 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, borisp@nvidia.com, saeedm@nvidia.com,
        leon@kernel.org, tariqt@nvidia.com, lkayal@nvidia.com,
        yuehaibing@huawei.com
Subject: Re: [PATCH net] net/mlx5e: fix double free in
 mlx5e_destroy_flow_table
Message-ID: <ZJxQvYh/k/5yEDAi@corigine.com>
References: <20230628005934.1524909-1-shaozhengchao@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628005934.1524909-1-shaozhengchao@huawei.com>
X-ClientProxiedBy: AM9P195CA0001.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::6) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA1PR13MB4829:EE_
X-MS-Office365-Filtering-Correlation-Id: ae3f99dc-dbba-451e-c66a-08db77ebd289
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CPE3IAk/wk6kBJxprTGyMPAO+eYLkHdP2gjhyAiZ+2qq3gR332PCwoOpKU5Dg6Ni5pFV15IfeiTReoAj6Ls12IXfcHNx6dFLUuvqArMYGMbfHTppgICryUTKdtnmp6Qo32pGWuWbklNp7p8ZLsR1Iits6Vx55AuBWSENAS2dM1eID2Q4NbkSeOgAUt6y0Eqwa9LdppuGb+cBPW5yfu/7V558h769QtfKx4IYheWM/9gRJ6Kskn2cfDhvXAoeNekKljQn8tLjtDtjXXXBDkq/iGVXMv8r2nOmHk7/IRX8DqK3G5CKSBgXmSQ+cnQOtR6NywcBuCXZ5/JDMCIvvkcmwRUcPOpR5qjDTtU/34XCx0RjW0c8TJFx7qc6+L85OSs/lzmD9CUGmUXW0k7vHbcFrom2F9w8CDK2w3wihqXTFvUjV89CrPxtMYf+BeHYKpWLBmLQMDDzuPkSwTqR0rJczcYTt+7PifWiUjA7RAfUOK2fWSpGTbvm1A+0xzlmTIs0F+E1EaE4VNCG4qVtKhtv7vWr1iA6NqiYrdrYEWhqL+p2RY9MpuaQT3hNzhFWEM6j2f0gxQ4Or4gdUg0+y/5Ynos5EhdfCpwg+YBW3aXRzQ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39830400003)(346002)(136003)(376002)(451199021)(4744005)(2906002)(6666004)(6486002)(2616005)(38100700002)(6506007)(186003)(86362001)(41300700001)(478600001)(66556008)(316002)(6916009)(66476007)(4326008)(36756003)(8936002)(66946007)(6512007)(7416002)(44832011)(8676002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pcc2Z9jrlkLTfzRIBdJfSW3/Xdenlh3HUyoYskMkuY+eU/cP01nSJoG5FA1U?=
 =?us-ascii?Q?Yan4ofapcfHJrfNGMVY/1TaxOPxQVmt6va/EaHnompJGZ5C6ffn+BKq1KUcX?=
 =?us-ascii?Q?rtnctOWI2e8rhHuPdfw46M4lp0ZG1OsHwuU//fwC5zqmnpdwNb4xjx1QkcEn?=
 =?us-ascii?Q?GrK8m5HYIuCEBCouWKXfQK8RD0sWdZASXfKwzA0X4qS++6VE/jI95Qnh76mm?=
 =?us-ascii?Q?X9ZxcFbnH+8eDVA+A90O52Gb6mV3rqYjb3lFNBNIiYuJSkpyi7J3UGEDJpUk?=
 =?us-ascii?Q?2S7N8AoH1gQKEIRDrhAD2x9C9v9AwRMjsMZU5v92epWPLFdGeV0XaQ5tvyO/?=
 =?us-ascii?Q?dJcj/VElRZTtxZpqxgXo+oC7zhYusksLOVY0xo9qwYkIiuj3OOMB2OyRHG+D?=
 =?us-ascii?Q?l4HptxoxZo+b4vNy61w3Fj7qZTNFZLJfD8BdZe79LqgvaK/JZYLz86hdQV0Y?=
 =?us-ascii?Q?yvLjxq2Wo/OXQj/qgEsMHEFo3npSzJ1kWNUPtk8n8D+LJGnb3oX3m6vWDOMV?=
 =?us-ascii?Q?46hbA1jn3L9oA54VvX2k3ZozRsN5uAW8dZrWf9y8rOSTI3vFCQfDsOGxcVn3?=
 =?us-ascii?Q?ix3i+KddPqJc/icCbqvIOJNHc99pJm/LRgp+V1MCz/lVAkbT8Wr2JGWyZlYs?=
 =?us-ascii?Q?503lsqouBNqcrX4UKzt6gvDD3wVpg7xLeN0Mz9Xz5hIAtbekVRD6cr1i+xba?=
 =?us-ascii?Q?fg7UQ1WD3xtpLCurlbfvfSrXn3tc5CWBe4Y2tPYdM4Yry9bSUUDEBAKNcosV?=
 =?us-ascii?Q?kt6T1ckU/hMbRIyX1MhvP5LJmnqM9POfCymSutyGK6K3qY62HkQls5IhnncM?=
 =?us-ascii?Q?W9g8KUsqWBHLiHWAGLhqzuOcQU9nba2LCayDPd/q8Hq3MREtirVCzaHY5PeP?=
 =?us-ascii?Q?LuvcikkRWBL0epanPz31jYwsaMOvJl4nvgDcacDgpwZScRWT2mo5EOm1PFOB?=
 =?us-ascii?Q?3OgFngG7N/hPZ7eJmvOHvxAGCDnXak383Jc2c8iMeyZFQYSefkfirRWay4kP?=
 =?us-ascii?Q?MV9bZ4oSLzTyk45HghNiKixp6Wfq+YRHkhowiw2NUfI0Iilj+miY5D+x0av4?=
 =?us-ascii?Q?JMCNum6tjkpEhLeteuISUSWaNYiyHH5rKl7NtXXW6semdUDK7Mh3Wnm4kYJf?=
 =?us-ascii?Q?HHiOh0dZf4FeCILu6ULu6TKsymKejalEpdN0uRbqlczYTLuiTevyX+EgoXl1?=
 =?us-ascii?Q?A3u8q0iLg0XXlkSlOlexJCLMMF/m7XFDFlx0acRGUm0aAcwYvN4sllM2wrVB?=
 =?us-ascii?Q?fm/eqrW3/4ef7dHSG3F2XpveAz4BiHEgcAFuEAzf4K8L2CgExQAECu7pm+1V?=
 =?us-ascii?Q?d003odQB/gL2EaEDMV6oE7Ca04kwG5c0fL3bTH8OwbazUkTEdBf9VkWPdiYz?=
 =?us-ascii?Q?NI8PYRrTaLx6Hud/jFdZusbUZkfQOFfekil3q0ygx3vJkaUi2x/ouTTPhPmM?=
 =?us-ascii?Q?uEcRgAioJUwAKv+HaMI4KrxWakaJQEolKEq7vQf8aFmL2mUHgFHcofjFUgai?=
 =?us-ascii?Q?AIBqtDbGHgOsap4ViIGsI8UZ2+f4yv9RSVB3ucO192kTmM2aovTn5eRfgfce?=
 =?us-ascii?Q?prs5SB4VEfyWocOF3uyVX80mZIvMd9tpGWsYI6W978a/K6muwJisS7XypV/Q?=
 =?us-ascii?Q?gmQsuC5zJIL/IOYyliWBs8gy2kv2HT1hsLNgFaZyfpdLnVO6rVOewIemFIUB?=
 =?us-ascii?Q?o1KuZA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3f99dc-dbba-451e-c66a-08db77ebd289
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 15:24:53.7725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EAdhcsSt9R4EAkhLhBi2FEZW0u1GIQVxkkCe2kATwW3jR4dbrvAL55ctATaYiwRElpZqnZbRRTUJuVtuK/91fVTMzk/iwLPDfgqBcdXI8OM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB4829
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 28, 2023 at 08:59:34AM +0800, Zhengchao Shao wrote:
> In function accel_fs_tcp_create_groups(), when the ft->g memory is
> successfully allocated but the 'in' memory fails to be allocated, the
> memory pointed to by ft->g is released once. And in function
> accel_fs_tcp_create_table, mlx5e_destroy_flow_table is called to release
> the memory pointed to by ft->g again. This will cause double free problem.
> 
> Fixes: c062d52ac24c ("net/mlx5e: Receive flow steering framework for accelerated TCP flows")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>
