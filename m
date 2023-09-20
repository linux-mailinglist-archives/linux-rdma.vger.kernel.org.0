Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C8F7A899D
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 18:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbjITQgv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 12:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbjITQgu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 12:36:50 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E269F
        for <linux-rdma@vger.kernel.org>; Wed, 20 Sep 2023 09:36:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5EoZdomPCA5K8R9YSaJE1hoCrHbm6sq7SuK7r7WLyI/TCT5UnajmFOPtS47lvPVQQ0NvR992OhTnrGIWVAp49Lwrdsk94hPVvQ5KA7N0hV0GHTrPsWa7rSQa3jWeYEYgx2nH+22MlbHihiZdBokFx9AQyKHhTgZH+A274WA9zpMvLNuJAERYZvni8JCMfrTHh1jeUdzPZytCbqGKSnklB4wStBjcp576dt0Ar1jMjGa6hlrzLXqDy339Ro1O8H/WT8dX1hhvTPmog4obaChqels0HY7nf98bvroPuYC4j3AxMVc/e8ipjAvPq17ErQszuQpS6nYquXjPiOEYllr4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFAolHrgDdLv92m/WNjYZQistTq9m/RSoI5ZNW0A8bY=;
 b=CBjrx01fF+hSgNVp9ATucqy92pIbHldrLqxmPP2exVMzWeEwI90GyQun37aGwy/Q2n9uthI59cAAZ61aEl3Wzc+QPLgV5vV3GcjaO2Pea4RdvaNoFo/p2cAw0OFq2ygYZJ1fLcEKqHnAXSzB60qFDSB07sxRg8SOnQBaSZw3Y1YfVy9HbBUx5Se02Oszp/IaxF9EetxC5aw/KzufO6ByT3lyRUpcBOkPfXq1hM6U8lBTnd7zC0SSUoN+9IJH1YODzryteKifGqV+rNINnPg9Lybrzx5laQ5J6HwtyS9LAB9VlVdtHyEqIZGPyh3fNufaLQNspBny9lCYh84/Gez4cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFAolHrgDdLv92m/WNjYZQistTq9m/RSoI5ZNW0A8bY=;
 b=Rq4pb0I9L5kBFgnAlC5jam7RbrbQ6UnLABKhDTT3JACwGZ31GoCI1UlrcND2MI86BPO7NOvotVE/2zgPUYDqKdoGW2P2IPtzsqz+mtpAadh3zZnOTZGWhVDknq0ZLxP+MAVwPduIQkpUIJam8rP/EB8+yTQ4pX1ChyUsqitagB2O8WY0EFoSs/HeALcHR8Jv2LvCshyXc/OluyPwQiz746ZE0uT41SB66FbrbDkp9pme2tmB2bWwJOuN8c4glHrWqrxqTzLGSPG8cVhXkfFBeRvAPxkBfbkhcCPbSjQs5fI61+v+EqaNoqG6J/kU6GCF/wQxYI+qUcnFyOJORJycOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7434.namprd12.prod.outlook.com (2603:10b6:930:52::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Wed, 20 Sep
 2023 16:36:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 16:36:42 +0000
Date:   Wed, 20 Sep 2023 13:36:37 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Shay Drory <shayd@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Implement mkeys management via LIFO
 queue
Message-ID: <20230920163637.GE13733@nvidia.com>
References: <96049c4bd3346a98240483ed2d22c5b1c7155c8a.1695203535.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96049c4bd3346a98240483ed2d22c5b1c7155c8a.1695203535.git.leon@kernel.org>
X-ClientProxiedBy: SJ0PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: d6f8958a-2911-424d-d32f-08dbb9f7c560
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RCoRhdCL90f9+o0K5xPBwm8zQKgAmYyuKzoSIWIVEwjGiHq2L2fon6/F5KYrhaG3CCeNaF+8j9Y2DDYNuLSUUBDYPn24GySVyfeBKG2gl+eYNmJdi2lK24DmWeeDgT0YCZIOynj1y9HYfo1voKmtp9OTYr0sSVEkgh8sM89i9sBaxV5a0MeVQHUYxIQrttuFFBfX67rp2likT9FsCN+tssjTU08MrjJ5fOhTOJ5Y58JQvETvagCd32T+tJLRC9wghCezwCe1//1YOjeDJ76mqbpAQ46/iyaAt9kcJiDbNfdiMgluFNFszuBJEGtRkfdef4RNXAsw/xbxC+sgWK8wkBOJotjX28stiiHO9fVzAYo3PFE+/haGMnkpQlA6hXPMZLzNm5JJlNkquOklqxFoiLskChUM2UoCokFdt+YjJV2m6MECPogGECZmMLOmfzTV0IHp5Bh+aItmZ76RvEw93YduNpaueVsPTF89UHUVjbg9Gm0iwEe/Pq0KDvFW7EHBojAXHt8wmOCmjEWydfEYQh8EPEMQLYNWrA/JvvRzy8V2dNHp8rkwLnlRctwWufZk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(366004)(39860400002)(1800799009)(186009)(451199024)(2906002)(38100700002)(36756003)(86362001)(33656002)(41300700001)(316002)(6512007)(6666004)(66556008)(6916009)(6506007)(6486002)(4326008)(1076003)(66476007)(478600001)(8936002)(83380400001)(26005)(66946007)(2616005)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1ekSOqPDVvRBh5nWr2vAbdXZTyCDlR82TQbrHOLTGqB8ZAK8Yts/85qk7sft?=
 =?us-ascii?Q?31pPH95BqAXZujiwE8S/UCr8BtIP1ZybPQHSjT1NeFDwD1G6Sx/c/KSk5nBu?=
 =?us-ascii?Q?65DtEp98iAp3XS891wWHJZROtuw7RDddFCsU0IyZ/9nCMXnzjbeo5zwIHFz0?=
 =?us-ascii?Q?TNiz2FRbq3zQqEzIuO+YjzzC8V0AFucdKjBXjCnyoLLNs4w/ouFUDAULKcdV?=
 =?us-ascii?Q?Ff+KiSC6vHSjJKDnvahAfdMRYXH6cK8AS7jUBYFVBkqvsGUHbIMJVgq3Y2Ww?=
 =?us-ascii?Q?o0Kr/XvkQcWf6AnbHYWu3f8nGQS7n6bi8+BrTjCfIU5u3uxFtJql55gtNzDs?=
 =?us-ascii?Q?5NwiHqWvT5IvL6FKET7EBpwCLtE7u6VLfqMFoRoLS2nQfZuwVzzDHJJfyiq6?=
 =?us-ascii?Q?slfajc3nYB0jM9GRpwKLMe8+Qz5G9EuFAdCV/bT66JX2QjbBTJm4zby4wYtR?=
 =?us-ascii?Q?dQOweQAUesHwfPuGtnyyJgJ8T8K3g4AHtuxG86y0HChcv4dsEFF1+7XeXrdm?=
 =?us-ascii?Q?iLumkb9UmTRwfW4nyx4gvr+xk8cJEl+XxuFW55jA7+71TO8g45kC+0OHUc8S?=
 =?us-ascii?Q?tbmXah9l2TwIYC/sCTAg+T1JFf0XcBVoChlRxehm7miqtdexSsVwvL438kAn?=
 =?us-ascii?Q?C9j5RvXq0NKDAC8JDJaSbgSsxQqizcAfKaWGlzm//VLatK1KgRWStW6ZWJTz?=
 =?us-ascii?Q?egcdf40Z8MhKD8FnQexk7AcCAw+VW/nVoIhW1prCnDFAH+DDtN/j10VLSME4?=
 =?us-ascii?Q?kX4Ulmm6OdicU4o3Wb82s7sdtCl80QQw6z6HpF4Kz9BGpboiTnCb0hcJx1R4?=
 =?us-ascii?Q?1TS5tb7g2RNaixM47GNy9r6CR1cgFPlIMCF/YMX/LG/YmyXUwnVVBNRrGVvh?=
 =?us-ascii?Q?9HEn+mAD44jR8U/fdIveMzcI3a01FCcfGkWsQ9nt2vood1RJVkFGPy60YHa6?=
 =?us-ascii?Q?w8F0NZ0K9DuG9pOzjBVbTdiomNVqF9vcKxvKWFpt09N2wcpfsbJZ4grL6kfp?=
 =?us-ascii?Q?ZlDGMGaEsvl/ia8hEkHm2uqMlR/GD6DpiFiP3UOwEimoc6oZGsQeKSTuCxjH?=
 =?us-ascii?Q?8+Z8kLeJUR/8NgKymFtBn3xx1fOEPW8F1FzI399aMV0zN0vBWcLXvlblBwzR?=
 =?us-ascii?Q?Zf/fgJEJ6SQMD8e/BKbeoq9IQWneMZ1MSejQMmg+LHuv1lAH0YFPTpZCya0g?=
 =?us-ascii?Q?spLbq7NYxy8IC7u9ppNwJnzwWykHVqcP3bH6wMXaIn+iKiv6DbnUMS28mp7X?=
 =?us-ascii?Q?7sZTJ1HW2pL1TUl2/8eJ1bljUfeFCcMYEcK6PW+aS1SNjjln55nN0hkZXMUj?=
 =?us-ascii?Q?8XEa2qughlM5avHezuIZkHaBFwSXUkmIsrLgnQYDZUxmnXJGzG4i6SyC7mN4?=
 =?us-ascii?Q?yot0jBfaXr+zjKF/zLlyte3HOilePBn6EasK6na9DgzlBDDXZLAjtYa5wQ1w?=
 =?us-ascii?Q?V1a/9QvjrUj2LXZ9baiohH2TCiafo6HtTBDJySAt3ued9rlVGAlVlNDYgJmt?=
 =?us-ascii?Q?NO14wbH1YcPtubCxxYiGvU9Lf5/a4DgfvJNUCBeVNDQR5SU+feEINcHeYuW1?=
 =?us-ascii?Q?mbPc2QIZ0Q5v5eWu+evlHlDVb3Ta/JlEMrYoGbZr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f8958a-2911-424d-d32f-08dbb9f7c560
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 16:36:42.3878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JD7lL89QbC/x5w+Jbc5HmTKDmCGQ8d73Xcs08BhdFJogqBjQo46T05yrWSKe1bz3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7434
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 20, 2023 at 12:54:56PM +0300, Leon Romanovsky wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> Currently, mkeys are managed via xarray. This implementation leads to
> a degradation in cases many MRs are unregistered in parallel, due to xarray
> internal implementation, for example: deregistration 1M MRs via 64 threads
> is taking ~15% more time[1].
> 
> Hence, implement mkeys management via LIFO queue, which solved the
> degradation.
> 
> [1]
> 2.8us in kernel v5.19 compare to 3.2us in kernel v6.4
> 
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |  19 +-
>  drivers/infiniband/hw/mlx5/mr.c      | 324 ++++++++++++---------------
>  drivers/infiniband/hw/mlx5/umr.c     |   4 +-
>  3 files changed, 167 insertions(+), 180 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> index 16713baf0d06..261c86fe6433 100644
> --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> @@ -753,10 +753,23 @@ struct umr_common {
>  	unsigned int state;
>  };
>  
> +#define NUM_MKEYS_PER_PAGE (PAGE_SIZE / sizeof(u32))
> +
> +struct mlx5_mkeys_page {
> +	u32 mkeys[NUM_MKEYS_PER_PAGE];
> +	struct list_head list;
> +};

Er, isn't the point of this to be PAGE_SIZE big?

Add an

static_assert(sizeof(struct mlx5_mkeys_page) == PAGE_SIZE)

And fix it so it is true..

Jason
