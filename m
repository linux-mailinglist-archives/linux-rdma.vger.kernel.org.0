Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1CE699842
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Feb 2023 16:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjBPPD1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Feb 2023 10:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjBPPD1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Feb 2023 10:03:27 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30C52F7B2
        for <linux-rdma@vger.kernel.org>; Thu, 16 Feb 2023 07:03:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbQze/JLuVL3j08bIUfZMNeYUQ/3Qm3TfTyX+GKzAZ60huV59qnWsUO1GIvp6mFWqaHIn94CsCMIAbnLU1+SvHY/QYq1FLjTkDQDZkc+daYiiP+3tg4vvrwb+sHereXeJgZjCn6XJbuWfRlYlOOJQ7Yc1oXVBpIJkynuCh7+qw+KlPh5rZNwmeg9cAfXXU1BtvkbyvgCyTa9YoEkztbOCsuuTDtFgdm4Q5iOYKHNzlIUAi2DWyF67SmNKK9pHZ/xT95+IvfpvLMbaFOdyA2vdtO5E9W5p415QSIhhewhuWbwcz/rqyNs1H710A2PIvlaHzTXx77E/R1pbWiV1nVdIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IngYMVFOFRUjBLaFiY4d4JhcmSI8qb+NXfg2cGKSOak=;
 b=R0S7XbzqZ5YfSnSZxpCym5zknPLR8S/GiKxpsQpuR+iJjEhvA2kBVNIOmnksSIQMlGwRjX8V/+y439s9seOLhsrWPsai2PGIpc+XlkRPzAIiokGQk4xdagvRVzCTKQNuEKmCUs/Ed7x8FAKgrKBumfzrg6dYbQy4k8jOqxL69DNb3hQ23Gqytxtxj3hc4R+QINw4pP+9oIKM8wed6xPfaqifEKFpTppBcEuiEYidhPq8bK8t6bENiG7hY8Z8gwcYRcxiSSUZs8gH8OVOn8ZMvbNqWr9YWCpImcgkcn8RaMVQseZH2Ti5CWFev5IKcRGt9d68NWhBqEbLj1s0vHzzIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IngYMVFOFRUjBLaFiY4d4JhcmSI8qb+NXfg2cGKSOak=;
 b=LJOMsmfN8WdJRP0ETGRshDMyA9XGdKmVzYV2migeYilEYLDWY8xMxG1jP5Txef5nJhEgBr0dntBgxIT8vhRROtAfEMApj+BlRuQbmuJW2+Xmxw8sP5LmJqthAPeyltiC1m2iA5U/wwLEzNFMW+SfJ/BSJ7+iTR0TMH3w+zcZ5U7nf85/ykzy/BKMhZ/c3sCZqWehIe6sjVpW1PhxokmPVVp3rs6izDGDN19+GXS7l7eB5ZOQiiUiUEdK6LSqGyhkD/Qn45DWtH5bq4fA3lw4LkBrlVbMYakoc9galT2lhPj7m/eE7vRC1L0QdOtTmedkJfe+TijPcyN4aIjtaubJVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7508.namprd12.prod.outlook.com (2603:10b6:208:440::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 15:03:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.013; Thu, 16 Feb 2023
 15:03:24 +0000
Date:   Thu, 16 Feb 2023 11:03:21 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, leon@kernel.org,
        linux-rdma@vger.kernel.org, Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCHv3 for-next 1/1] RDMA/irdma: Add support for dmabuf pin
 memory regions
Message-ID: <Y+5FuSxVrtmCawC8@nvidia.com>
References: <20230201032115.631656-1-yanjun.zhu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201032115.631656-1-yanjun.zhu@intel.com>
X-ClientProxiedBy: MN2PR19CA0042.namprd19.prod.outlook.com
 (2603:10b6:208:19b::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b330f4b-fbb1-44b2-faf7-08db102ef30f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dnqS97mvdviocUrkIczG/TEdGz5xmgJyJzrIyjaLJkurxdittzamSzQ6+93u52aLXA6yAmMlrh4vVltUVZJOijj9DZWJ2N+HaMcOi/3FqbfOEytup/m+juIVsYTSlV8oBrcYwVacalFEmCiCooAeM6dSuKkH6wuXsq5oV5ZMHAlZbVB0yTYpFqzyFEEUKZLOhUoEbpUygcm4bB+iNfCx1+eFPxSS96hKg/+Wk86Lkhm6rYn2yTtN5FqIuaVcYOf5IZKb/XtXEbJILFem6rZX1R/dsuu4qPfKU90TEDRTdVBkpxoRxxovfUaM/a7XIECePA3fI060+ItwFdrv8XLf7oaS8hwXcUeIJdOqBHTDqW4oYSu/cp276gqIiFZhI4G76pMHKQgDldBAnrbnBpOoNTTD4YWM2drxObv577lo5r/ESjzf8AtBYzMEnOs3GUHCjhVeG97ftdpYV0cMKZtW4OI/VH0v32E+q7KMKLjTKiXbK8GSbcwj4eR6vz1F14PFXwRhrn48fm0wWH9yfK+hpvvP+Otpu6MhaNUGIomKYCxI+SlK5jsULNTzWIfbi/rmaZqq9HPf9CcWAdGSirQzq1iv7+qrV4EYOo7PtJ4GBJZ7DXwG+X31CKvK68uMEr//ApCrs5C5CqE5jzXTPAszr5myQOqXkdVlYtrusc4ORl/G8MjdU+Y2OqL5LjrPQxpOpIqgBDDdjPW/WRBAidvEXv0esvjKx3cObJzLjnfQtXY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(451199018)(36756003)(2906002)(5660300002)(8936002)(66946007)(66476007)(316002)(66556008)(6916009)(4326008)(41300700001)(478600001)(8676002)(6486002)(86362001)(6512007)(186003)(26005)(6506007)(6666004)(2616005)(83380400001)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CXX8X9ZAtRVsTFQ4MxS+rTo26unJIxrKwSVGqySZHrih+vsr4pe1h1sZ5sKg?=
 =?us-ascii?Q?fIzDHrU0JCNs2Lehxbv/MZcII5NsrTcU2Km9zVfbkDEVny7esR8ZWRhkZ6HE?=
 =?us-ascii?Q?TM1Egq/cX7KBrI0zONv0eZ5qkZtR+vvDJ87P7P4wkgPMkqy8DrNQ0gRACpI2?=
 =?us-ascii?Q?6EU7VYzZatGA1rtTL6ZdP3txh48dJ29oaHoHFuqPJbTQSDIhEnoM8TGVTcUR?=
 =?us-ascii?Q?P1bVHfueoYcCf6Tumdcm8S6s6fVDLjyQdtghWeHw6+P9O3cDEykcHlXtvMmU?=
 =?us-ascii?Q?u85Ah8RAVIjuW8Mg5dHhSOIAtmej0ILk8+6Us0XS8gi3mYGJff/nXPD7YDZx?=
 =?us-ascii?Q?Re5IWiXdud3M6lWsLUu+VFXvxzJuE4E9U0ksjL44CLxFeCItzMZ2kBXjuSDC?=
 =?us-ascii?Q?VFmgQsBiQF4Ms21ME6pbLJvukeVVeE/f+3eS6OvAX5/zOYnc8oF/TeDRuJi/?=
 =?us-ascii?Q?cU/Jrl5D+RDq9/dwpwYTWZTWlKj/auTCk0HvjlENEjrKZTkJCcXhoRXi0Es1?=
 =?us-ascii?Q?YVBtzdFeUbhLR4SPxPRPrwQ4X6XHMq4pfMdWHFPf3LwKnLR9NWnt4+1ZP3TB?=
 =?us-ascii?Q?8BUi255LRtFi5yAVNnJP6xRj0HEc0dMyAYYQP4zCDahloPEDdmc1hoAf8F8Y?=
 =?us-ascii?Q?X713LoOWO/A34M1axIleN5cvmLVtdpnqsBdhAz1DtL9VuNNaRkWXxOZcHqGb?=
 =?us-ascii?Q?E32or2r5L64EEcYxLTTyUuJKYXv1gsTDtE4u4v6V+JfjsqYlUEZm7fffYwcM?=
 =?us-ascii?Q?4nIrezFGdy88F2KFjGVRv/0fFfLi1gYM0bPiKNMJ/obO06JGArmmlhio0Agx?=
 =?us-ascii?Q?xM8Dhn/Gtf6wSvyD+QcGA17iMcCBW/v3imSJbSK4qLl3/APDP+MPgG6Tn3QG?=
 =?us-ascii?Q?9Wv5glpsv2hcf+Ak01brQwgLRJruBr6z36UO9P0R7Z+3pVEGxlr+0i4Cs3gR?=
 =?us-ascii?Q?beOHfzNxoeJFi1Dwi6kbwXamAZd0Kp21RFwv9wi7aqLB3EnF6gQrjwS2c2zh?=
 =?us-ascii?Q?bi7L8H2LyOTOGKiuR7p4euZCcgweC+Fy6W0ixbLT/iNQJjIwc/ZqCxt7Xmfn?=
 =?us-ascii?Q?J8S9EegVW1Q/Y5zlzNPAlCFKSuGw2ax1uwSopcBcOmoFIuZlZ6NFNICkWyu3?=
 =?us-ascii?Q?a80Ro37G5v7ee6pMt9qU8CaAIu1F3q+jvsFIGb2Jl0NLOg3RQcmsCM537qy3?=
 =?us-ascii?Q?8sakF5Zg/pSApxMVe3wMgtoWd1w6kPi/+xem0rPOJSkx5AdcXeY8niZyM90m?=
 =?us-ascii?Q?7hfAnJxmyuHbneh3MB1SuGNb6RXu1wfevN5eScMTg2oBiiCXzL0zk5r117kX?=
 =?us-ascii?Q?qp42mzYIqMzbarpB2Na049trxFV1uyql+bTt0EpThC4NTzZroLNQC+7moi9z?=
 =?us-ascii?Q?b9Q3v6UHprnHOK1CWxv/zHtvJ3IBKgcSstZLwd89sEDNfBCyAAwf5O+982BV?=
 =?us-ascii?Q?oTDqYh6z4ioVLlBMNhIX0SL/VM48RFLJstW7ylHKNh4YO+z0t5YNBpwUCpVg?=
 =?us-ascii?Q?UnrfkG3agNm2gSBPXTtzak7teH9uMhcaBET9cxrQNZ4EdbT4xiCM9VgQopkx?=
 =?us-ascii?Q?+h6GAmCks7/yeWI5rByPuA8qYC3t0oYbPkgtzzhD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b330f4b-fbb1-44b2-faf7-08db102ef30f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 15:03:24.0341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hPT0YPOZLZwUcR5Eif+leSIKEv8+aYCz+R829k7uyfcPxx0+UDRsSf85pS6u+I/e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7508
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 01, 2023 at 11:21:15AM +0800, Zhu Yanjun wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> This is a followup to the EFA dmabuf[1]. Irdma driver currently does
> not support on-demand-paging(ODP). So it uses habanalabs as the
> dmabuf exporter, and irdma as the importer to allow for peer2peer
> access through libibverbs.
> 
> In this commit, the function ib_umem_dmabuf_get_pinned() is used.
> This function is introduced in EFA dmabuf[1] which allows the driver
> to get a dmabuf umem which is pinned and does not require move_notify
> callback implementation. The returned umem is pinned and DMA mapped
> like standard cpu umems, and is released through ib_umem_release().
> 
> [1]https://lore.kernel.org/lkml/20211007114018.GD2688930@ziepe.ca/t/
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
> V2->V3: Remove unnecessary variable initialization;
>         Use error handler;
> V1->V2: Thanks Shiraz Saleem, he gave me a lot of good suggestions.
>         This commit is based on the shared functions from refactored
>         irdma_reg_user_mr.
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 45 +++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
> index 6982f38596c8..7525f4cdf6fb 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -2977,6 +2977,50 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
>  	return ERR_PTR(err);
>  }
>  
> +static struct ib_mr *irdma_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
> +					      u64 len, u64 virt,
> +					      int fd, int access,
> +					      struct ib_udata *udata)
> +{
> +	struct irdma_device *iwdev = to_iwdev(pd->device);
> +	struct ib_umem_dmabuf *umem_dmabuf;
> +	struct irdma_mr *iwmr;
> +	int err;
> +
> +	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (udata->inlen < IRDMA_MEM_REG_MIN_REQ_LEN)
> +		return ERR_PTR(-EINVAL);

Shiraz is correct, I'm wondering how this even works. This is a new
style uAPI without UVERBS_ATTR_UHW so inlen should always be 0.

How did you manage to test this??

Jason
