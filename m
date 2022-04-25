Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B526D50E449
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Apr 2022 17:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiDYPZ5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Apr 2022 11:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239819AbiDYPZ5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Apr 2022 11:25:57 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2052.outbound.protection.outlook.com [40.107.100.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0409FE124A
        for <linux-rdma@vger.kernel.org>; Mon, 25 Apr 2022 08:22:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eg/wb/jjBJ0X/FNVzcG/lLBI9HDTAxsLs5jm+5JJpdrqv47FS6RuUsArKOECf3aFhVWMUPxiH7dqI/nNW5r0+KIsrpWRwIQG63d9NUQ4hpNj7t9bcIDe7j/Gbi9YvPoEIQ2x3Pnncns72LdrvDS5RuvPKMwXIUmShkxFwgknUggRN1UXS2uY6azyIUBUe78bckFNLAJkwlfP9lK/aCgh4ysu2BRIPiNNrlPIDCFYPicsaZHRBGv5xmZ3dd5fVumgKTKEaVwDuqkfcghIuK1mLBRkC4DWp29K/lRX8BUeNAIhbO6lrM9lGPJUcRFdRqqdK+hmeEnLKQH0JqZMyTMozw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZZK81TBUdgP363xxSvaBUzaUdcVnX1edAR2HYWO+7Y=;
 b=CtKEyjygiefWx0z1NV2HABrxOTpN4n4qFbol1F6Ysd1DyqKOex8p1ux/j9djIMn1Nt4Ozkr93igS27d9d6H2VB+xUFrZRsnnxs+8bnOP6E/BhImMrYldgh9vHgfrEm31jhzX9UcUKSoSjmi1MTAm4ab2moym3LTNoUMz2pSqCgjIUS1k5rR01oubKzU13N/AbmX1JbvtjBpS5FNhcyPKlV2VSe8R3FP0rSwAw5U3Nn5ge4bVCzOt4J9gI7Qxd/NDs07MPZcG96dDJKFeRWrPaTLAGpFOB5ZC6Vgf+gF3uxK4Iy76KK8Jg9I9vChibHP9LhNdBEke6SWSBiSZF+PQ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZZK81TBUdgP363xxSvaBUzaUdcVnX1edAR2HYWO+7Y=;
 b=Nrs1pBO+60kzpWcabs7tRZ6blr1mL3PenLem/gozBsLVdkEfpvGu8YtTciiMgma3NzSpmHYrgbX6HuKfajtDmvT9sMFmYACJxdJ2reNaFQ3UsajF0LGjva0ZCgBHm8XSVBEKqzOroFI54nv2UbX5E6yqG1egNb5LYMbBHIaGhb5jrwqj+sZ/l4UOum2OQYqnguZxN3EPV2084cVqTGDm4ymPrYxrdWU9VOS0wc9boa3ujQZKU3PpT0YM9LqGmbTpcm3B0eyWkCVHG4bG3Kx30qgxjIzjHYWGy1iUtXIhhqkd32KdG4m7l1d6g94M5MqZguGC9exIOFElGzzKMoXQ1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN9PR12MB5384.namprd12.prod.outlook.com (2603:10b6:408:105::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 25 Apr
 2022 15:22:50 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 15:22:50 +0000
Date:   Mon, 25 Apr 2022 12:22:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: Re: [PATCH rdma-next 03/12] RDMA/mlx5: Move mkey ctrl segment logic
 to umr.c
Message-ID: <20220425152249.GA2225197@nvidia.com>
References: <cover.1649747695.git.leonro@nvidia.com>
 <5a7fac8ae8543521d19d174663245ae84b910310.1649747695.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a7fac8ae8543521d19d174663245ae84b910310.1649747695.git.leonro@nvidia.com>
X-ClientProxiedBy: BL0PR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:207:3c::42) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 951197ea-f6f2-494a-009f-08da26cf7605
X-MS-TrafficTypeDiagnostic: BN9PR12MB5384:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5384991E4A45C51F52C56C3DC2F89@BN9PR12MB5384.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wz1xSSnW+Isi9dA/IrNq9fwB3VcgVTp6u81drPkh/ANrMNt6xibq3C3Xch6GqlGpxOcofFUkBXriQYo6b7p5BjsRYAt7/KnbzCZ2HZPTMluYVj5BNGmtCyuklawGS37n/Q+ZhAR3MP0wJh6WqrJycbVu4kpeZEnKkaBVIw2WWWJNgYGkas5qP4DUQExxIGNQxETlYC/Jbl/7eJ5RN8sqThFOo9D+pZGgV9Se9/htouzyo2sN1f8wHUrPgcw8GflT6okGhP7bVopE1i+8IyKGJodWW/0B99EhUCPYVScBaXbhcnpcxKKSII5orRvRYq7cIOa5wr7wfg6bShcYPX0k7451tGf/kx79NxA5qF7tTelvpJG4XRVroT3EqhHQGSg5UtOZa4IzE9FgDKgBx9yt3TcHBMdYc/qfrhgrM8+vWR9BB8VFgFfFTrWnvi+hU6m7741F1PVXqUaj8ucnsU08qmfB0CI6x3rUzHnPVg1J8iBsFajYrQw6ThB6xeQXPg4Jm0yTEktqpEUsEa6uXU6SsNpTadiYVG9ZGdYKGD1QPoy7AhDpG/Yxsp4sBDUDTT3IN1OJgwIFlaCLb7S5bJPBdhcoA99jeqWYHw53ROaL7nfIUMkJ98iU8sAtP6UbcAfAu6EyY2k2yowvP0ww76NBcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(8676002)(33656002)(83380400001)(107886003)(54906003)(6916009)(36756003)(2616005)(6486002)(316002)(2906002)(26005)(38100700002)(86362001)(508600001)(8936002)(6512007)(186003)(1076003)(66476007)(5660300002)(6506007)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nv9hSEoOS2BgBhob5kQ/mvXfQP8ibVSDAk/CXA9wNH/X1kqGAkrHFT+gdtiT?=
 =?us-ascii?Q?/KEfpTlUrhYB3TZBIUtxSiLWaSH6hffrHg7I6TpDm9T8ZHoa/iG9NYgEelrM?=
 =?us-ascii?Q?BxmuVy51rehijhgflwxEKJwSIENI4rtsrxeLJP/cpDFY7gShQHVmNXELJzP2?=
 =?us-ascii?Q?/VbgLsrduAgvruxthpw/rFkalbAKynPV9jEUf7DMiV4yglwccsK3MxZ5GTX7?=
 =?us-ascii?Q?HAN1EtWx9cUGn8GNi9VQtI0c697YDF8lXSfdUa3JuRFcbRIXYXl7qToTWZI+?=
 =?us-ascii?Q?Ql5qxNsE5ticL4VwNYqkUInn0MBYqze4ErQpUgOxdUQ1fySKECkKcKfdova9?=
 =?us-ascii?Q?qNC/roIqUDsDnlL3kYyQ9aLiALqFOhRDxCO+J2zPCz73vfsIYa4UV/cdA9nZ?=
 =?us-ascii?Q?+IkEMWGs8nXa9iyLVFIDXl0fD3hp0Q8jtWB6RVwbe8F1JK147ELfDFw93ZZC?=
 =?us-ascii?Q?PNfT+QgsvjPkgDeVZqmglvfgdAnqGUoIytPnv5gmcmHfVGF/9pz9WTV6Yb5e?=
 =?us-ascii?Q?X/LyO37qirtmszgJr8Ot/Prn6CfXMtQDW5lT2W1OS6kIpIZ5tErJRveKOdwk?=
 =?us-ascii?Q?0rwXEpXyUlqXCoCe+xqUqZzS461f0AYzuX8r0p0zWLwaYjaK79CLZ61IjV0b?=
 =?us-ascii?Q?/uI2dehpHwjAFXtGTY5kLCyHSwsAxgkMR+4UpNTGRypS/pFwBf/eloMGo+LU?=
 =?us-ascii?Q?FJyJ0JAOzSlKETrd5JKu0Uw6Rr3803qOGPnFd9zlVd9E5mBvu2qXm6xPOgm3?=
 =?us-ascii?Q?gCW3lNF+UqL3ZV0I6ZEcSbyxbch977PuaRgZtJDzmh5/0/XmZlqI5C7zTlH6?=
 =?us-ascii?Q?jBCheWjLnJzpcTSuePqJ/n7SQByQJ49Q9uCDqs3xZoJDMwukMlmSXFq71Gvz?=
 =?us-ascii?Q?NJa+5u/OwlF0c/rdv36YElR/4v32VEPB7MLqGuVOYS5SyrmdaWPiQpel/V3R?=
 =?us-ascii?Q?KBa3e1TUBWDYckrUxbQcUKy5RRK+ioEwppfwFPHJrvEX3nXjwd9HDmXUdpoQ?=
 =?us-ascii?Q?ncQji7b6q3H36Q14xf5YN6XWvTDcYtYe2xXuoJUJbiS0S0elGY7XPBbgMmY0?=
 =?us-ascii?Q?93k4WW6rGCP7k8k2WFMmZm8dHRtiSz6rkgPpaQfIpLgD+faa5a8H73SkNcBz?=
 =?us-ascii?Q?Zez2rcRG48bmd2nSkz/Otu9MJ20GWcX8H9Ierd02dgXxVYCkf+PkiAIm9Rv+?=
 =?us-ascii?Q?D8GEARJZtqWDw02En05oiLc1yuTu++8O5YVZgazCqM60SqYJrNLpwGRXiZuL?=
 =?us-ascii?Q?K1ICMSLLIe3HnAipWis6inGhePgFDtPnOAR9uzXySLowyqRGpRzlS3XvL9pu?=
 =?us-ascii?Q?dDgmxT6oCag6a7Vpi/WjjWnJyacY/A/F5dRZrkWORyppUZBq8yWFxZAoiL0y?=
 =?us-ascii?Q?6APA5V2/qjlpVQLlQ+9vKGWgjZ2qpSYSGWUItrYkzMjDO8e/awckPrLrxozv?=
 =?us-ascii?Q?buUlhXSuP1KVZrdk4bVBCXlZyh57MQuIs0+k5exntd76qbDQwLONXo9Rcm+K?=
 =?us-ascii?Q?lKeGjxExP7fEbGsLEB77ENiT9dfTX/d8jT9Ka6pmT41yLC8/igpwCSf8nN+n?=
 =?us-ascii?Q?tELKL1P4q7AnmHdjRoQF/LcyHgLbON65ECL7HOb/bqEX+hYFH/rpySdpqrlc?=
 =?us-ascii?Q?4kT3OmFWCQ4PAfvg01GVets29uQzQTrMiSVmOQjHNgelTdh6EHyHhohRGf20?=
 =?us-ascii?Q?jy0hCcUY0jJfC0uMawD1sA2kX/imrVoKFHmUYeIteQg0LFAtvkXp/ReVCre1?=
 =?us-ascii?Q?1uOnzFn2Fg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 951197ea-f6f2-494a-009f-08da26cf7605
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 15:22:50.7721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cYgsTs+qUkj0eeDJMf6m910LWg3vNf0wY1pAHI6tKYxIrbasaokC5QHnRsFFw7sf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5384
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 12, 2022 at 10:23:58AM +0300, Leon Romanovsky wrote:
> From: Aharon Landau <aharonl@nvidia.com>
> 
> Move set_reg_umr_segment() and its helpers to umr.c.
> 
> Signed-off-by: Aharon Landau <aharonl@nvidia.com>
> Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |   3 -
>  drivers/infiniband/hw/mlx5/qp.c      |   1 +
>  drivers/infiniband/hw/mlx5/umr.c     | 129 ++++++++++++++++++++++++
>  drivers/infiniband/hw/mlx5/umr.h     |  13 +++
>  drivers/infiniband/hw/mlx5/wr.c      | 142 +--------------------------
>  5 files changed, 147 insertions(+), 141 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> index 18ba11e4e2e6..d77a27503488 100644
> +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> @@ -311,9 +311,6 @@ struct mlx5_ib_flow_db {
>  #define MLX5_IB_QPT_DCT		IB_QPT_RESERVED4
>  #define MLX5_IB_WR_UMR		IB_WR_RESERVED1
>  
> -#define MLX5_IB_UMR_OCTOWORD	       16
> -#define MLX5_IB_UMR_XLT_ALIGNMENT      64
> -
>  #define MLX5_IB_UPD_XLT_ZAP	      BIT(0)
>  #define MLX5_IB_UPD_XLT_ENABLE	      BIT(1)
>  #define MLX5_IB_UPD_XLT_ATOMIC	      BIT(2)
> diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
> index 3f467557d34e..d2f243d3c4e2 100644
> +++ b/drivers/infiniband/hw/mlx5/qp.c
> @@ -40,6 +40,7 @@
>  #include "ib_rep.h"
>  #include "counters.h"
>  #include "cmd.h"
> +#include "umr.h"
>  #include "qp.h"
>  #include "wr.h"
>  
> diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
> index 46eaf919eb49..d3626a9dc8ab 100644
> +++ b/drivers/infiniband/hw/mlx5/umr.c
> @@ -4,6 +4,135 @@
>  #include "mlx5_ib.h"
>  #include "umr.h"
>  
> +static __be64 get_umr_enable_mr_mask(void)
> +{
> +	u64 result;
> +
> +	result = MLX5_MKEY_MASK_KEY |
> +		 MLX5_MKEY_MASK_FREE;
> +
> +	return cpu_to_be64(result);
> +}
> +
> +static __be64 get_umr_disable_mr_mask(void)
> +{
> +	u64 result;
> +
> +	result = MLX5_MKEY_MASK_FREE;
> +
> +	return cpu_to_be64(result);
> +}
> +
> +static __be64 get_umr_update_translation_mask(void)
> +{
> +	u64 result;
> +
> +	result = MLX5_MKEY_MASK_LEN |
> +		 MLX5_MKEY_MASK_PAGE_SIZE |
> +		 MLX5_MKEY_MASK_START_ADDR;
> +
> +	return cpu_to_be64(result);
> +}

This is pretty ugly, it is fine to copy it, but an add-on patch to
remove these function wrappers would be nice

#define UMR_MR_MASK_DISABLE cpu_to_be64(MLX5_MKEY_MASK_FREE)

At worst (and arguably it can just be open coded)

Jason
