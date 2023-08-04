Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E69770A0C
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Aug 2023 22:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjHDUuU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Aug 2023 16:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjHDUuT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Aug 2023 16:50:19 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6EE4C2D;
        Fri,  4 Aug 2023 13:50:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEuu/124S1nSQ2ixNZ9rN0enJ3IwwtA+QGLe0ZJIQF/nNiZ8nnRzHulb2+C6s1XtNcBlfBb8vT2gTbhjD0bRmgPkr+HVCNQTregwhmTnchcJrXaq/UVSrW1Mp6MDfGg8hf1aUAFWCgCd7r44stSpTEC7edE3b7cm0w+Y9TbIhwa6imGys+Gzw0P72spiwhrWmsgsKF7ebwQFd7Q8vbwuW2333Z1BsN7Rd6ICdSTE6yv8AhWMB5llVMszAB1znJImCxhiHqjWW9j6EIIyaeGByY70dmEPgfG1OnA/9Dgh7qX6vi3CyQ/NhbtkHR/ThTDChQGGYxNnmi6dleGRsAFreg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLRgDRXSC3HVShwCFxuIXRPiOOsVmdilkbuSN5CDeaI=;
 b=WkILvBVXfcfayVJ0uxlocghCut0x/IEyFWnuB2k3JQnC4l1Rv0IBCwrnJG1SoilWA1NZSgq58oYnKInHErcIb9WCRyECDistygrzRYukJGHjRZPC3STpx6oaitZRa9mI61vTJ0gIkTGmMTSV+UGRL3xlW18flMBvf8scYQl7lZfAAtJHLayVFCSf/vmI8bizxE9x8vZuP2jJMEn5iK4pz+7axbKUa8lK2i/r7Mt8Vol9tieamLhBXnhwF1ZTCU11kne0diewl/YkpFFzJncHtqX0d4eFP33MWDHtwk+MSsGv1Yr98hoy2DrMF7XPrJSsBM0qFY5rePjcUkP0BueFcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLRgDRXSC3HVShwCFxuIXRPiOOsVmdilkbuSN5CDeaI=;
 b=PfhQWmkEdxFuQPhLqVa632LEqBvWtOlGqWCPsgREAEiO0q2gDLnsNFCE4KldmcBMPNbaSy9x82JfvPY7FB8bjPnvDRB0usXc35TdrGVtMT3X+4XwPlLQK/tb+XG2Nw0mP/ZvWyyZrnEvgyQsfbt0bGoL88FHfWHdLcnjBhsUUYpr1Yb60eLwvUyWZZK9/b+dX4NNCu78u4nry9ow67a6bcdxH564/9d9y8rdDI+dJGUQgNxhxUQVPiL3yuoFt+DoP6oB7MbeZ9G5e9WKXLZ8X1osDOfYIK6MEeF6FD3cewT9pqUM/Do+lauzJjDHlzXm4Zz6WUbZbE4flqya+mYDYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by IA1PR12MB7544.namprd12.prod.outlook.com (2603:10b6:208:42c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 20:50:15 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::6a48:3496:dcb4:3ad5]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::6a48:3496:dcb4:3ad5%5]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 20:50:15 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jianbo Liu <jianbol@nvidia.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] net/mlx5e: Fix spelling mistake "Faided" -> "Failed"
In-Reply-To: <20230804182306.843673-1-colin.i.king@gmail.com> (Colin Ian
        King's message of "Fri, 4 Aug 2023 19:23:06 +0100")
References: <20230804182306.843673-1-colin.i.king@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date:   Fri, 04 Aug 2023 13:49:45 -0700
Message-ID: <877cqamt1y.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0036.prod.exchangelabs.com (2603:10b6:a02:80::49)
 To BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|IA1PR12MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: 094a7913-28cd-4677-171c-08db952c6787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G+Mb+4ZhVR4UIK5QwehYWDzvcL6DrK0lFOLDqjzKbg0sLjDPm9GWE8gEtr5FK7gtCi85rIYlWH3YLG7jtsgwpzWWtSJl+pMGt2V/Ttt3Jn24HrWUxcWsOzGEtZkpNyUyBxrOQAd7rG9LGDw887mH0ZtwvLbSUdMi8alumJctW6vcoqiZOpYvgNulGIlh079VJQiJgiJjel070Br/vLISxuzkW0qQuxfcEvtNAH5iurCuvZrxxwxN5UViAMgTq18qyq7/uu/Al8MI1TuRvfKKguAQTO+2Et8jVXppfy3wfxnltlU8/P6eDBzVsbLUVogqB3lZb85hKX9sc8jM57cJdv1DwWfge2vgG4/DPi1CBRrBDDaF8/kVT5kfcWnfTPGYCrDHX18gfHCO1NPaXaZHyychRR+vZZ5MlVfrB7wX16aVokKtPYNlXEPQ3IdLeck5Zuce8A0v4fotlLOB4w2b7W1sQS/atCt49d8Bk2OsuYqnb7fe9RNI8Eb6Qtn9EsEe2IB05A9UmoEeCYjZTBycoTonrXcNhTW0VOrIVHqrcs1RR3ZUs2H9iV6NdpNH3Uju
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(451199021)(186006)(1800799003)(5660300002)(7416002)(6916009)(2906002)(4326008)(66946007)(66476007)(66556008)(316002)(54906003)(8936002)(8676002)(41300700001)(478600001)(86362001)(6666004)(6486002)(6512007)(38100700002)(6506007)(26005)(2616005)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IkGuSQqqMaLD0YjrQdhWzWj8Gvrp2j2M50i6iuHzzjO5fyBN+7ZttHF3rzv5?=
 =?us-ascii?Q?MK74R6ZZtD9jdOWkRytQe+/0GfoG1RjUOHWRXGjii+uu512GB0K0R4sePEP8?=
 =?us-ascii?Q?yjlYi5NwgQKfWk5LSEcJ6xgknQIPsBnCFZ9m/qU63xgzu1/MW4crGJUbPU+W?=
 =?us-ascii?Q?AsScZc7htu06q24Fm03kdD4RqRAum8ZdwUVxrzGmc/ijbqPAIZYn6akZoY4h?=
 =?us-ascii?Q?QlVQkZXQd5xCmJngIHZXXR3ccabLftPULffm8DYzqlL1i2kvh3GGxHX4LSMh?=
 =?us-ascii?Q?D59/DWQgNsVEHNbx6WVQ1LwupdQoILUZqsaMk6+VLyj8Ohs9GD9Uv8IdWqZX?=
 =?us-ascii?Q?q750HV30imtVNZirraf0b67N6IdFPbfSR2BtEaTcirnhTfTQ3ptSIETLwuBL?=
 =?us-ascii?Q?o5ai9LRWu8kfl7k+eTTMWdwlPTci5MgbmhmRAsLMe3sa+3wkkZC7OLzyfZHr?=
 =?us-ascii?Q?IVs82VOgkZGZrah/Z25Tr5e5CRwrchIn4+Pyf806VrbMBfVE8WmFbKys3Qdr?=
 =?us-ascii?Q?tlqgtYr/LuxVTW4VsZANU5gZglTZCBhESSk1RB/kXP8UAFxZ0lHidNWTL62P?=
 =?us-ascii?Q?aUq6kkQvVBYM4sti9/yQNh+llkrsw6xnHGx8jpWlmzSkY2ozFhpu2a732lTE?=
 =?us-ascii?Q?fKbbOyfKN8POlQPl/ETpEtlyGfHQBmDJ7fmTsg/ZjcfXvHvQoYTpcekB52Xx?=
 =?us-ascii?Q?3z9GlTzA9xi6PdVCIOofY1fsRtkuGOALVzAGiRTQZDZ2QFZFvUT6pD7yKCJF?=
 =?us-ascii?Q?cB3f6/WeAkf5ENThfU+X7VPbtl+Qj9YHcBngOPvN6wHlWFmZY8v9QUOUpbgV?=
 =?us-ascii?Q?4FwPA32oETl3O5wIGaWU4gp0cLi5xfPQCeAHqG9Og2ucL4ZI3c5V+cMu4jve?=
 =?us-ascii?Q?a7v5S17pZkSPtTSwlgyO5YdeFXZF9XrmkKGv+CP1a84RKvMH6Jjro1BhHFkC?=
 =?us-ascii?Q?cH+avB+b2KgFq4WmD1URbpDozdnSN07FOFfif5IHpcxz9LfY+XpKAzy3cujk?=
 =?us-ascii?Q?5KSWWtMMWZ/zsSQ4CjpW7rA/QlOMq+DtZHfHV45rrEIsT5E1zx4ChaGkYVUI?=
 =?us-ascii?Q?MxWYHnLDpXRWkiW9rPJkSCQ5igjoQEhkAbWYnoT2+ItxFMwzSswZPbYXpUHS?=
 =?us-ascii?Q?I3FKporeYjE/ftGFxbS3RmRS+Lag4ZkAzo5jx4mUlyZvJKTi3Ut7aWLV0M07?=
 =?us-ascii?Q?F6uRIUy8sqY79Z1E+f2x4wSLpHUXvT9AnUfF1l7qzDqC5FQZR1kU51i+nonU?=
 =?us-ascii?Q?3rRQ3ub4cyL0Pk/4Kn1lggucuTip3PkDSk32gprxvnBFhJnupKXNj2JL8W0M?=
 =?us-ascii?Q?lAoJgy3TZmfJJavTfORwNjkGIdkwVaP7ldZvKEJsd6yybBi2kneOLWBkDrzI?=
 =?us-ascii?Q?FxRYsJsKbSsHItcDAaeOqwm5x9y3qo/5jY5V6D/zWCyp9hcjUemCgh+DOrKA?=
 =?us-ascii?Q?OkxzCB/h/Dw93h1RPTsnx1JGQlCpiOrPN7QHeP6G7egKuBv6DmTh0IrA/Gu3?=
 =?us-ascii?Q?6moHhBvhgSKgkPeIM7W8FMKocxJ1OeVoOUX69dCR1K2rJbHGIdh6auoBgCvP?=
 =?us-ascii?Q?yli0in6p+lRPcfs6VVTxBJk9jMhLIsJYaW+6gPOdA4e/jBBI1sf75LwlFvaW?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 094a7913-28cd-4677-171c-08db952c6787
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 20:50:15.2849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X6GhpXdUZlUqb3mtco8f46Js6/vCZRyc5yit8bXDlbfmfK22h5HVF72OurpDOUt9cSi440UoYDGg9hNZQ8LQ6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7544
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 04 Aug, 2023 19:23:06 +0100 Colin Ian King <colin.i.king@gmail.com> wrote:
> There is a spelling mistake in a warning message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
> index 455746952260..095f31f380fa 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
> @@ -316,7 +316,7 @@ void mlx5_esw_ipsec_restore_dest_uplink(struct mlx5_core_dev *mdev)
>  			err = mlx5_esw_ipsec_modify_flow_dests(esw, flow);
>  			if (err)
>  				mlx5_core_warn_once(mdev,
> -						    "Faided to modify flow dests for IPsec");
> +						    "Failed to modify flow dests for IPsec");
>  		}
>  		rhashtable_walk_stop(&iter);
>  		rhashtable_walk_exit(&iter);

NOTE: This patch should be targeting net-next. There is no 'next' tree
      to integrate into in netdev.

Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
