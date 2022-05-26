Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6305350B1
	for <lists+linux-rdma@lfdr.de>; Thu, 26 May 2022 16:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbiEZOcW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 May 2022 10:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347659AbiEZOcS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 May 2022 10:32:18 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7D3C8BDC
        for <linux-rdma@vger.kernel.org>; Thu, 26 May 2022 07:32:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9Q8cdIfBeayv1k+sNpLRMNeiBpjjBFqO0FsjaATXRcjWZUP8ArBmq+f2w+c2ZvxHj5F6Oela1I93mp3/zKpf+kTMcLn8/NsxHOy7BVUZHeFTt2JAlzjtEIK7fkNB4y/2Q/Vl0uuOZUPM2iMvdE/OnC13HC+zP9S1+jjJft29F4kHQNOQmlruZtSebhIGP08f9qZZ+4pXeRNYj51hIjq8DnQMqeHGiAp5ogu3dUj7WwDm7/J5igkKQh+UEWIPnXQndrbQQ8BEYiQskR7p3WBo4LkSXs5JU12U5TyfRSEXXT1WPyqvLUjC0fLet7CGGO9kMA/TXnk/Av3mOpBeGjokA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=to/dS1KkACq0j2G/9UA16aGhO7eSQe5Vf9BviJl9I4A=;
 b=G7gn09DJluxAAkxyj6HjRxoweBrLfqrw48Uz0Vn8N3kqnEcv1ZFBnxTiZOb5xeFJlFu6rXUnH9h1RybWIGqaHVedlHJadc6m2zIuSGvggY4hfyadFOHx/MWFW7pH/aivD5vWfKU1K2m60asK/uZ5Ni/K5CMJDHEhTa3ynIzH2d8eSi1eGgkIZUpbgNQW+MJYy/CVLaJP8wxDWHfezPGY/H+HSq5kQgYdeEDtYsvFYfUM849wwTfZLDxCUGNVStMTHA0z213LVH4E0xQAFlOENsJglfVev4T+sRjk+SeF+pXV6Ir55S07l5SLaLb8xTaSauyONqXdV+TaAC/ZQNVicg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=to/dS1KkACq0j2G/9UA16aGhO7eSQe5Vf9BviJl9I4A=;
 b=sm1MZWSciKK3Ke0TJFpnK6PPMpIjWQ7MrN9btVx5FOpmDlbzCFav4Gvf+Px2KqLJUqNX4kGiZHtBP+oK6w6GW6O5xRAxx3V8QicA9NLA6zN5fIai/l08fosgaQmjWdhIHjakjvkFpCqX08IToC3KJB6gyrAiH6P2cqI5PtVd6dr6VNY3mhr2Icd4dn1ctMQOSHffaCcI2oj9h1J/CNmKuMDGyzdX8Hl0KGtdFTqcyy1v9qreqpDQsgIW/wDYVFNGI86tp8Kzeziidc/ybubg6IeSMx6MpyEt1APHxh4zJ+OUrZWXCJppREI+5Zdx/3kAgPGfp7zJ0yqG3fgTAPocXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4026.namprd12.prod.outlook.com (2603:10b6:5:1cc::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Thu, 26 May
 2022 14:32:15 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%7]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 14:32:14 +0000
Date:   Thu, 26 May 2022 11:32:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Add a umr recovery flow
Message-ID: <20220526143212.GA3078527@nvidia.com>
References: <6cc24816cca049bd8541317f5e41d3ac659445d3.1652588303.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cc24816cca049bd8541317f5e41d3ac659445d3.1652588303.git.leonro@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:208:329::24) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ad9bd5f-6168-4d65-504b-08da3f24873f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4026:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4026BB62613B676355E65FF1C2D99@DM6PR12MB4026.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +lpMEEW6x/ct/vsow7To1xQ55bZmUJ8B6/P7MhLHS5EPeikU/AGBjVdEE5IrVgdhdDd58FhkArV6UnT8bobLkIxOXh17dfaf/SW5lrOQTogvc5ZuJHmeLlHrpg0vberPVbAxNwIKJC5v51etFAIZAYlTqpAcP9a40xLlbI2Go/sJcYWaBa9fbsFQ3H2gH8h9qiLux04093D6du5Tf3W5tPC/mf3hn4dqyIlU2MBS1NDNXn7NRMxUuaAX75Ah+FtBrlwu6rLqV9Z152kptvd16lUb3IYz+Cbx8gjMoIzVEtLyiHpVzrHoKmi1H9FcwsU+yTmjSPKn9xZkGoRIW3gl3CRY1PIWzygs+GGboOq+Ic/bcFtFF/0iSLKBctTBxPYTdPdpVt47KmyM38jQs2BVE7JALnl4NivUNmT5l6OQExFxd2ygTTgvQcx1GAcyPtn+dZU1M8wR7TxZEJomeb8XEdyHEHsEgc7ObVxs6tXWqwG2KWEwtYvqdObmh1fetUDnyp8/005AA17B0Ke4lrnot+OHnaOSvSQgNTwDaNdXyjIAJPjiETZli/7EyT5NGIWNHI7r1HQ2OmX8xVcEIYHJebGjrR3vIR9ZBTgwiuBC19Fa51GRSU0uMBQeahvTapwPkC9vpGXH64tuvhCKEalgDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(66946007)(2906002)(4326008)(66556008)(66476007)(6486002)(38100700002)(8936002)(6506007)(33656002)(5660300002)(4744005)(508600001)(54906003)(83380400001)(316002)(1076003)(6916009)(107886003)(2616005)(36756003)(186003)(6512007)(86362001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TwKnf8ddS/lSTVhaKQRXyj6Qb+0NXAIludkVAeARYIad5exkswQ3qIu3V5HA?=
 =?us-ascii?Q?iktwFZpRdyDQjHdW9WnGBwI5E55gMbufcx+0hwbwnFz1Sop6cTKvLqeTAF67?=
 =?us-ascii?Q?xSfkHOd/6D+A8exXG0iCPjc89gSqRsnlcZhAesD4TvMRjYETk6o9I7RGXqb+?=
 =?us-ascii?Q?/Vii3bplCLKbOTPDGm14QMkRTDsdjHJeh9wzcRajQVEqCrrsDSMCmukoOHVO?=
 =?us-ascii?Q?mTwRahPweU84SgUKfPGfoM6qvL7vPWfmfWPSXildlSci+X/5M7qFasMcYIHB?=
 =?us-ascii?Q?BO/pPioIWiix3u5alwD9CSHAEUsaQqQtiUlOfDU/ECdTh4fEGEMtrqQE1d+q?=
 =?us-ascii?Q?6mrYJA+cYhR8bJGJn6P4eWxZ4Aq5P62NembYy8dW2E6t1hkhLAYHGjRMagBL?=
 =?us-ascii?Q?SDBskAZx8fMA55z8gIetnejyM5VRl4zQ2+9gV0WNa9p0JW+cfEPXqUHOU/Ql?=
 =?us-ascii?Q?npdjAjn7mnF1le4BtPXeqlzkOaxJlb0oWVbTR3ZhMN2tCUld9c/BUKvvYoXS?=
 =?us-ascii?Q?VbwIfcIRqjQ8szUNt89tXR4oVGqyx0HqVjX9GQHIDp957/YAUp1c5v+T3UVs?=
 =?us-ascii?Q?D8dDjsoJKx4AbYwM+3fjtRkRtq2Jicc0vI0VkVBMkCgdj2toY8guHnI6cMz5?=
 =?us-ascii?Q?Inw6IERp7rhjJl0YHYo1i/O+k9gxWWe0gBMnBFEUtHTFREk0fauKIBAMn2cK?=
 =?us-ascii?Q?t5rxHbt5Nva4PigRIM4kza6CqOs9H9ocUkRxzYmy8AJPAuaEjrZK6c8rA8cU?=
 =?us-ascii?Q?MDlGldZJytSRZHM4SmhE+SEQ9isyeYUil2NQrf/6PwhLREnvBn7ycdXd0dpR?=
 =?us-ascii?Q?YgXs6pfiIxfnUNOGKO52PbcoBRyAq1tf4FOZdecHZ3lrCFMHJyJaUqpZVmfW?=
 =?us-ascii?Q?4sGqNNV8tK4vUeqLrS9Gq6SfjeDhf2JiVhKbjziWpruxY2x103LA/3t+tygq?=
 =?us-ascii?Q?678GONrqxU2YBMH1N0m+OP1eDxiy4ZHtXqAY444nIJb7It0JwsJV+JQxr2GD?=
 =?us-ascii?Q?Fnj/3YOkDr/Rl2nReAImuWeuOOAko3TBnqcNyIblhgC7q0yQrmzAz3QKbhRN?=
 =?us-ascii?Q?dSaHy+aVpUQSx1vquxbe8H+U57dUoLkDfY47S5QD8cYPcN2bwvdSecf77283?=
 =?us-ascii?Q?MqYYqWgmtPFTEOgtwHfd6PPOB+R/JNCa/qIFz55p5OLuehTvc5KrFheChjDI?=
 =?us-ascii?Q?mWKbV2Z99ftDOiwB3971H1tCqbWOLV/jgBcXbiQMvqOHNLKuKcXdVaAS0r5+?=
 =?us-ascii?Q?Nx60kPCr2M2Durq9n6qXnw+t/PfnT5XdEsUdg7wXjLVgF30h89Jny1M70gVT?=
 =?us-ascii?Q?83BrV6kfI1nVf9KMxomnW0htRQ1Idwo+XUNL4XDTLXhPH5JPPHHHVJt32FEg?=
 =?us-ascii?Q?XUnPFnuVZcUIgm4XJwxqk2ZCHeKdj/eGOVbhGIDaEY8ccpA27GcPU1afvnZq?=
 =?us-ascii?Q?4Si2E5VBehtlt8epZCamHKy3JwahnLtofXIIL6Nnxudcsw06N+qaZaKyChI8?=
 =?us-ascii?Q?lTJluS1gqMzEVYATbfoyXA8KJMWtwEI0KR0z9JnGyMkDJPzyxNEOIYs7YRZ9?=
 =?us-ascii?Q?nCfcFr7zwrbJpTpEzI+2BDY3qMsb6TDcI4A5eYqvCin7hWxRJ5JTP2RQxLbJ?=
 =?us-ascii?Q?dl3VGpgNJSXYY/FjG5UJ/uN5peSqe+lUkM90D/QPd/394yjrumxCiMAm0aeW?=
 =?us-ascii?Q?2yzydToZYr9JQ5XHf3przoPyFS8UG6x1CSGCqgyEMJakLVkIlqktGtnzVVur?=
 =?us-ascii?Q?nZYmARXTbQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad9bd5f-6168-4d65-504b-08da3f24873f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 14:32:14.8991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLre+FEUVgQt+RjWW5t2eWRxOKJzlxzlswQ2O6XChm2f8lp84kVT32TuDHhLbaRR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4026
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 15, 2022 at 07:19:53AM +0300, Leon Romanovsky wrote:
> @@ -270,17 +296,49 @@ static int mlx5r_umr_post_send_wait(struct mlx5_ib_dev *dev, u32 mkey,
>  	mlx5r_umr_init_context(&umr_context);
>  
>  	down(&umrc->sem);
> +	while (true) {
> +		mutex_lock(&umrc->lock);

You need to test this with lockdep, nesing a mutex under a semaphor is
not allowed, AFAIK.

> +		err = mlx5r_umr_post_send(umrc->qp, mkey, &umr_context.cqe, wqe,
> +					  with_data);
> +		mutex_unlock(&umrc->lock);
> +		if (err) {
> +			mlx5_ib_warn(dev, "UMR post send failed, err %d\n",
> +				     err);
> +			break;
>  		}
> +
> +		wait_for_completion(&umr_context.done);

Nor is sleeping under a semaphore.

And, I'm pretty sure, this entire function is called under a spinlock
in some cases.

Jason
