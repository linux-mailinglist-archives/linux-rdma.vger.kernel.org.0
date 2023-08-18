Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A833F78106E
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Aug 2023 18:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358025AbjHRQdx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Aug 2023 12:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378676AbjHRQdl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Aug 2023 12:33:41 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E34D3C04;
        Fri, 18 Aug 2023 09:33:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvUQJIH085QGl5R8lU6hEUI+46fshNLxPSAeHsRsdwwCFKP44Df5lhcgo7R33rfunY66zWzM/24Uu9/wSdrTO0qoFz3B4xSU+3/h0BMI3gvA+4TZkJ08xXXBCEnOt9ar2bKrobRQZ+6RIPe5JgqyTslK2YUwJbksXf1txGIvFYutbpeo8o3fPo3Cs2oRgY8BPpulm/9xiErmK1+39hr3Ql7BEgW3Jqnd8apRIvIAyfiUGIpgrIcFxgY91GxiJ1uuu4CBoN5vDgonT0wAFo+GO/WHCTNt7GMuL1wFXF4gItu5KD/cxhIIWP0doCisMpa02+I9V76N398xa2KTRLxE1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9TRpPA7y/JGcvF1MHCwNZ64+Ii0s3yHwruHT2kDBTw=;
 b=DljW8hCqK1lfVvrj7m0TpDlWkdXYBTntZPDIfGyhzFVE/JVFnpD+i9+1fzeYgPp8Nd0Y3rhm1jXl1dGS3l+MQWb3bLlhxhxJTYUH4zb9b18pRVNKBR0O4vX5EYgf3hjcj81kaFXQtibHXz4AQFmhFfB9WDw9APlPnDBLnlLoKdnBF/zMfAxhGtIa/UaCGlLY/GJ5KqryPUbzCDCPEM97IO5fCOU9Co3W6ayi8sfHoy8oZIcZrF8YYHOXidu+ZKj/HwpHl0VFL4U0qpKsIFC8Mb1O/OCTa6eEfsHO+ZdZ0DQVMpxSpBsYEeNwysA1K1IkXwMjn/TXQbUDSv1owh/6fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9TRpPA7y/JGcvF1MHCwNZ64+Ii0s3yHwruHT2kDBTw=;
 b=Y9KP2HV89X0ns5L+ZUDDtmRH+cP90UbjW3A23zlI7zKLqkVAzJbn8a08gGai64m3+ImGM40/x7JoQrN3AsfK24FvQi69p+NnfjBEJE7qvar5c98YW/LlEFQO7NAcPWQj+kAPmWE65CzSalWnDBJIzU0/OljdEuiX2j7El3B/VztrnPRDWY/o3cLnGBVSudW15DyVQwQbMUbiJl7KXo6GawLCnXQTik0T6NZAhQojMQUlA/pI5AExT92Z9k0SLhoYZrgcch1N2dwcVyC3O1OlaSEI+qATU/p3iIFV5VvP6YaEWn3T+5113Z0y98eauvbCt67uAEOGeNsKq1LGWx2N6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 16:33:36 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 16:33:36 +0000
Date:   Fri, 18 Aug 2023 13:33:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Mark Bloch <mbloch@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH rdma-next 1/2] RDMA/mlx5: Get upper device only if device
 is lagged
Message-ID: <ZN+dX1hkUbEIHid4@nvidia.com>
References: <cover.1692168533.git.leon@kernel.org>
 <117b591f5e6e130aeccc871888084fb92fb43b5a.1692168533.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <117b591f5e6e130aeccc871888084fb92fb43b5a.1692168533.git.leon@kernel.org>
X-ClientProxiedBy: MN2PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:208:a8::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: 487cde28-d6a5-405f-0188-08dba008df24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SoASKH0FxfdBmw2mg53ZUbcBrJijid/zOfsAZSF/A19jsOWX8xAtKQHkBDAls1ZwOWemsazm1WU1ON6BBwOjPdM2cKyzcx/vMfkNKwATi8Z4PhjmzpFCLaewwKvbZ3R3VuX+AinpKuw3ByDSnU2CDi/q7dZ3Q+e2EXiwkdZcM3WQog1xRZPF4WIcQVUvaJKxupWp/SNYmFIz0Yaf5BzR6IPgaNUzjUoMS6+UUH6H64mj5MgNYLMDBUP/R9EZaAyIjoeG8Uy264tIttBON3ox8bFV3VcmJdxMotAKZOrHUQ3kn2iwge6EkTWniU9uaXwMl/7Z2asnfy/j9PQiFYe4qTNa3LHYxV6q4TpP1ItRKcqjmrOJrsHxMv+6oJhx9fmJRspNGNYZL+yTYBcGTcaZB5KMJPaFBk+XK9eKci6BrIgb1LjgK+o48qoecNYiBZXEBGR/Tfy5+QU9yhpUvSZffpGjS5Xu05B++1yVNmIzbV666TL53pAqlSqwoUyAeACQbMt42NSWxMXVE5r5KVSR0Cwy6b9w+0ehLKvbYkXsDWfFDxqjs6FlBvCznTciXgHXR8i/1zghoILwo0YU+1l953dKDQ5cdh2JvXcEgX/dok0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199024)(186009)(1800799009)(107886003)(2616005)(26005)(6512007)(6486002)(6506007)(83380400001)(5660300002)(8936002)(4326008)(8676002)(2906002)(478600001)(41300700001)(54906003)(66476007)(66556008)(6916009)(316002)(66946007)(38100700002)(86362001)(36756003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M8f5sENmB70Hm6+WOTEjL5xsQ39PJEzVDB8fdR290ZVivEOCfpBzicTnFXRE?=
 =?us-ascii?Q?OYa8cRME9mgdjuE3kF6kjvJU4RNT70C9FG/KDhp/dVPYBg0vqyBn66z/IpOr?=
 =?us-ascii?Q?jmDYJqgI7r0Y8zFLyG6vp3oMpkjLbMVYjKXqBg0TVPEPOgu8YNtqvAk43Xra?=
 =?us-ascii?Q?E8xnuV+SrEGGSUyCubHfsVBdZfNcb/bDR9Ofc5vj01tUishlZfcSuExUMp3M?=
 =?us-ascii?Q?IfdNcJuKoSOb3uNX4Gx/sCnvHjkHO8QQmzZhQ7qQJ1Ds/in+o1s7JGma+Z7K?=
 =?us-ascii?Q?f+rgg1S3YrTPVG6487guzRRH6eRCutw++6rf7SAOe9f73KTMpJ4rRqaCPMkk?=
 =?us-ascii?Q?JPH8Q8v9y+RpTLliBx8GrvfccWM98xOiK0ulYMrC0ZmVUzwnLB/JODJn2kKn?=
 =?us-ascii?Q?SvCYcwMV2qKjnprBE4y2hNdCGqSZUCL867+bpVr9bZcKAdHR90CbRUea/VVh?=
 =?us-ascii?Q?6GHZdWkeAO5sI+DwsgXNQMLrenrG1JBhmuACVMe5mEHu4HFqU68pEzUIfJSa?=
 =?us-ascii?Q?rLMS/uufIsjvkWv4ZtDy6N5OFvnd9MuHRzZI51YJPa8RB+cYxBh+KxFTF7jT?=
 =?us-ascii?Q?JVNyFcefh0Hq9vI1uTNvBEWkbk3CXb2E8AFHn9tRfmRVzVFI+esKSauSxOAM?=
 =?us-ascii?Q?k8uxhCauZG3rO8C7ajTsiXVsoC+KKw6oqCnfe8Lib9jS6/fhYoDi7rvsksnO?=
 =?us-ascii?Q?Xu04o7IsUrimDUO3V//AkHNf3D2Ecb1ReWY4X4r8U5PS/eXxJyw0Czhk2FA7?=
 =?us-ascii?Q?lPYg9f1M9jRJfl3ffb8pchTipNzO42ekCv0qBjefZdEnwF9SeI2LG+gRpiGC?=
 =?us-ascii?Q?2muLHwDm3nG6ZneqQjFD8uyeiw1vA1X6JDkjxYKGSzfa41giBJzCJT0Xi5JE?=
 =?us-ascii?Q?Cp0p//Kxkz4e7pNj9dWBb3aK+/T5aRjRzbPpCLPyezwnzZAvFt8xKaBfO3cZ?=
 =?us-ascii?Q?63+kS/XujVea4hvjHR+kjRqPla+uEPwQbMsOdQpinRpbi9/0Nmuxy/YgzTFT?=
 =?us-ascii?Q?6RWB4gSTQLd6GgcR1iLo2GWbYlC/C5Tj7Y7bGxb3DC1ZYVfb7M0axiH7I71U?=
 =?us-ascii?Q?rIZfmgo49Jgzvbhz4EwFasqTpnV6395x7VGQ/k1DAVNpyKgXJ3p2H2cf8ZnF?=
 =?us-ascii?Q?y8rjX97ZmyXvD44P8s96SIosr5eeK2kByC7b9HREmk14AeFLVNmoKqsQCh7G?=
 =?us-ascii?Q?HFj+4ilrAJz2D3hJlwKgL9rgpzoKM96+7PA2h1nfP7CGjx6JIlo9l3aOK3A0?=
 =?us-ascii?Q?Y70bR9uEgkXBUG+1JXlvdetgwXwmj1FlSaFRYpsWwQocs/f5w83Q/tUCSQnE?=
 =?us-ascii?Q?dAt1mxM6sYjMcKIYcT5bMeg0NjCBl5pk9tu3Gd3HZeAjvfgSQGkRXFPw5zam?=
 =?us-ascii?Q?5oBTKlKEFeXgpjBqCaOxgyCTYoc7VyL3fZZFdDMfZeVsfYnOEW/+BfqadOLl?=
 =?us-ascii?Q?UCle2c14q5HGgTaDSZ6CzbMwi6qGn4nwS5TQSJ0vnkDI3+efrowGsbGbRk1H?=
 =?us-ascii?Q?Z15Lo0a5MT6uvfd8s4h1rMKvIdqLCwYdM1Joh1j21r3t0+XjRT5jssTaqYUc?=
 =?us-ascii?Q?oL+VvEXJmTbJsGBWvvTBHiI/B1oR3z7mc37SH+lc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 487cde28-d6a5-405f-0188-08dba008df24
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 16:33:36.8304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0JBL2Sw/mU4ZxHa7U+lcJeNquIB7rly3ispQU79AqDvC0FawsyPGzExEG7IUbU/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 16, 2023 at 09:52:23AM +0300, Leon Romanovsky wrote:
> From: Mark Bloch <mbloch@nvidia.com>
> 
> If the RDMA device isn't in LAG mode there is no need
> to try to get the upper device.
> 
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index f0b394ed7452..215d7b0add8f 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -195,12 +195,18 @@ static int mlx5_netdev_event(struct notifier_block *this,
>  	case NETDEV_CHANGE:
>  	case NETDEV_UP:
>  	case NETDEV_DOWN: {
> -		struct net_device *lag_ndev = mlx5_lag_get_roce_netdev(mdev);
>  		struct net_device *upper = NULL;
>  
> -		if (lag_ndev) {
> -			upper = netdev_master_upper_dev_get(lag_ndev);
> -			dev_put(lag_ndev);
> +		if (ibdev->lag_active) {

Needs locking to read lag_active

Jason
