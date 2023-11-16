Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564357EE5B5
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Nov 2023 18:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjKPRMr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Nov 2023 12:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKPRMq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Nov 2023 12:12:46 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71F2B7
        for <linux-rdma@vger.kernel.org>; Thu, 16 Nov 2023 09:12:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqfGPSiMbRv/CcNpwV/+oxuHbqW+bNdkK6qdcMqkg+rkWP14K4Dcw76Hl8UjQUiO8lSo9fwnFqjsWDaIiSI9lQ+hLVbbV1wpj9x2DiCZmU+TJD72XapkhE/YpoYA5s4KAIFjxsIwnEXLF0IorTHR8OpPmEx3sxvXbw0wJoA+6TEbOOubdYFT4ziwJQcE07rsTbBpgAKYpEZ5dby1ue2QyyYe5W73tXS9Vn5CMyUXMc+TDeHMfYvo48VTVbbJ2VjS1OduaRU0f/IL5QnyNcJKO/fq/Oa8/Fhww1E98iPHauYb1cXQmy1/HJFhYqL3ffztDfEeNDplcNqHdqw0LK5jGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWcO92LVB5lvaW2t65RZj+ZusZjVNKp1A2VZrUySzkA=;
 b=FYHGvsw73b3qI67yduW6BqtwdxZ4md6Uv0LWm9heIm8JqUcjOc3+P2hV5n83bpOENm9Tjd3n9rBDzVwjxV3Sftu0R83/f1/nFbXE21VkIeghcbzfWGeVBtw9e03qGkwG0+SwHUIC3XfM7ExWtwktBVdokF5FFOoxouhNoDUHr3Qm+TDkgBQuWEYQ15rsnNnLHe0p946cuArWFHm6Ui5Jvq9Jh5IMiPOrUmFAhpEYzEs6HRIpHhCdAs+vu6XMZn1pN3sVFfO1OXSclZICCtS9XpHS3YfCndaF+XF/4LGOHxaeZblqC4eWgcT+pUgcy6TgJu+LAjDAeL1+TgmKkH8ciw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWcO92LVB5lvaW2t65RZj+ZusZjVNKp1A2VZrUySzkA=;
 b=ZdZ3VToBCTEFXZCjcNsrpX/J02FwB1/n30KESq+CIt96Kph6DBTF5Qm6r6AekCWaoPd1sv4TwxlLlrrGGXXCcfI2m4U5PHhnesvc0a9SQ2F8lWw8YF2KbnNIm7zT1EXdGSW72p2nwc2Q5nLifwl4HDtHnEAK1Hkh8QMLE+VaDgJJ1MX7XsRvPwOpzBiF6P9MCUVrU99GnM4A6NabTDYqVnBPCtC6kSOrYvvwXnqFit9lODaM0kU3QbkX8YcZ+Z61buVjUd/WMoBQrt+D4KmdcPnIvDkfGE7uzMcWXf/q7eKoKuN7SATUvJsWoxX6zU3d6FXfCGkG/DYNPOm326Ev6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB5453.namprd12.prod.outlook.com (2603:10b6:a03:37f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Thu, 16 Nov
 2023 17:12:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 17:12:39 +0000
Date:   Thu, 16 Nov 2023 13:12:38 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>
Subject: Re: [PATCH for-rc 1/3] RDMA/core: Fix umem iterator when PAGE_SIZE
 is greater then HCA pgsz
Message-ID: <ZVZNhpx6oTBS+PIP@nvidia.com>
References: <20231115191752.266-1-shiraz.saleem@intel.com>
 <20231115191752.266-2-shiraz.saleem@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115191752.266-2-shiraz.saleem@intel.com>
X-ClientProxiedBy: BL1P223CA0026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB5453:EE_
X-MS-Office365-Filtering-Correlation-Id: 3880e4e3-33f2-4591-d5b3-08dbe6c73ca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dSphZpCmkCORlYHInnDkqYl8b0YDVs3VE+mP0ym+GWFGLvmjQkSl1zviC7BhuJvPEFJueYf79Hp1JFxlf0XwCsUyJF7HMcn2bCCE5uLYL+GLPK2k8p7zsElCURap35+oNPEFV+CdD/WQrE282MtnoXTkrfPrnqitrhI8RPTl0szTz2wr0Y7UhBLzr0B196AoL2cafonVxoTMMVc5gVWVvM2AXcj4+lTUTR+O3c8bzRzVqokmll+Lm1M8j+7DncDBaVvZrtpbggvKp2SbCLclYgRmbEpmxjaXB8taabMRQKczjzxNHcR8VicRC5BCgRii7LfWJHo5v1LhAmRIWcDY6knRrTSz9jY2BnHyXbjkyOCLMV7W3pOaMwQ8Z2+PSrmjTR/McHKBpgj7FbAJAR+nAT/0cEnF84zPz9UyQUG0nGLtLMDy4+9+dFOpRndYrhBYlpWFG623PCE4GccOCnM+sRB0O3tQEEfPQ8tNHXtvohKi8MInj5LE/sEQu8uBvzqXIKY5CZQSFNCOVQHFES+3bdNpBQlfj2Ay7hhLdB9k1LOVXP9cs9f5ar+5cwyZk+Vc5mbd55+KCeqsvPB/V9zVl9sbr3aRpxGSSs9dj5cphdM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(366004)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(316002)(66476007)(66946007)(66556008)(36756003)(6916009)(86362001)(4326008)(8936002)(8676002)(83380400001)(2906002)(26005)(41300700001)(55236004)(6512007)(2616005)(5660300002)(6506007)(478600001)(6486002)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KmwVzUaSTpCms1BZwRZTP3uwVW8+RZtII5QxNb8+rvPd8CpTfWQLjRcaVZGL?=
 =?us-ascii?Q?v5YN/5VLP/YRXq0euTeGf4hP1U46c00JFYVt5qwmVLueD/3hOnj7m04s15B6?=
 =?us-ascii?Q?uLCvw1t/QK0J4ZbL75sjuhwnvjDPNVVbmcX989pWDFU0Nx7iWP4OS2fCuIRy?=
 =?us-ascii?Q?9f+kQEAnTTH/vwKWeed96xqM6/67x0vnXJads0ZSFI3W6WbQ5MWizIGyNZWj?=
 =?us-ascii?Q?JwlitAddNp/ZYkIy1F6/EsOFuzwv+4aQhYfH7iwtEJvbxYHD34l6uvi44hi9?=
 =?us-ascii?Q?9/YULTTRa+ix2Z7EPM4Wmg/belZCfNw4B0/De8XZna8U9f3WThc5lxJvJY52?=
 =?us-ascii?Q?McwNVYvUD2LuitUjdVnMh6ioYiknYUJJHwEfl+Y6/9HQBz5dFNVGpObz+7xf?=
 =?us-ascii?Q?K3jmJVCEvY+Vxye0U4DW4+K+whnaAbo4pPBFeK+cVTsW7FcyCD49iHy410GI?=
 =?us-ascii?Q?ZG0XXcVKD07p4Ir44IpnwMhXTMqgogywSOGeiETx7ljHY1DkcWvZ7JkM7ufh?=
 =?us-ascii?Q?SAprKW1iH7PouO4PBa5sVD02yi8pPmPjn0e3BCHrnoFoVeY3wkiBau6LldaW?=
 =?us-ascii?Q?w8jJ9nstQg5a514yagz26C1kFkDdJbBk5Ic9Ljc1rhayh6eujKuAOA9p/fFA?=
 =?us-ascii?Q?5e+j0wH1fZko08GygEl1+mQxvvE+0k6UhjTNFSqjjrQmAttN3ur8X0t8MgII?=
 =?us-ascii?Q?FzId16s/4y7Z7/EU86FnQjWvkudqnQDc9yrQwGFcHu0/bKUHBKWZYscX0mNe?=
 =?us-ascii?Q?5z7fXeLSx+6Ca48cId/ddZOf4qgGQI36R0zTQISJNLXSPVN8jJr+DS7oLRsj?=
 =?us-ascii?Q?bDOJgyGHlEOu8QKcS7g1H6+iEijypYTPlZIlxtJF0nFfxu5ljs14+0kKm7EY?=
 =?us-ascii?Q?yEgcDexSGXDgW3xzL1iQslTKGgcHNjgFvpvYQEtXyqhoU5XKY7SWqEKzPPpI?=
 =?us-ascii?Q?xx5nfLk75agZuifGxhCBWVCO3swvid46bO9mcq2+KDQEpt11/KXhhdxhBY32?=
 =?us-ascii?Q?IqwBrlmI3jsUZrI2AmSRf3Yzw9Urv/6FRytyj5P2H/zU5BL4E1uDXeqb/gIr?=
 =?us-ascii?Q?Sp5jC/4xOe2i+hWIBQH2agevIacq1VQxlC2bMqXERIm5ii2zFoZnl3tJgb6w?=
 =?us-ascii?Q?ih2EmiFyiqlQxsymE8ycZotu14KG+ON4xaGlY24TCuJRplPjztPB49GnUpMo?=
 =?us-ascii?Q?nQRezLNfu92KyMtg/5JC5/Y5jnOah3ZYBhte/58ytrMsmtoKATG4VU6BFIWn?=
 =?us-ascii?Q?80euPz98z/Ab5MLhqbECoiLJpYuum1PK3qeBUubq6hCKN+A7QykpfahHwHAB?=
 =?us-ascii?Q?PLsRpYXSr0hto/6778ZOehCmcX/8GsaAKDN/XwHcQ15hk9h/V44LX3CpUwu1?=
 =?us-ascii?Q?8iYtwex0vwxypeIhBAlugr6Na+BZeJtNnJ8Q8ylUxNS2jTUjwWg6pBTUVD0v?=
 =?us-ascii?Q?ZgddsJpVX6RDENqAGKe3MyiPMtXuRlMYRargma+rSVq+XnwQxkMJz7A/D+OI?=
 =?us-ascii?Q?RRGX1lKuSdpi0VgNuSBGcHiXlihT7FzHUqn2uEBFv2dYGln2K/xWiSHdnCg7?=
 =?us-ascii?Q?TKfaTYtEJDVORiQFc686oraQuJ8frAvPM1jJDXNP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3880e4e3-33f2-4591-d5b3-08dbe6c73ca8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 17:12:39.4708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSxiNlc+LTDT0DcEmT2dZbGa/oA681vG18UQAtBeJuQs5G3s34kWxWMFhjBsd3a2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5453
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 15, 2023 at 01:17:50PM -0600, Shiraz Saleem wrote:
> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> index f9ab671c8eda..07c571c7b699 100644
> --- a/drivers/infiniband/core/umem.c
> +++ b/drivers/infiniband/core/umem.c
> @@ -96,12 +96,6 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
>  		return page_size;
>  	}
>  
> -	/* rdma_for_each_block() has a bug if the page size is smaller than the
> -	 * page size used to build the umem. For now prevent smaller page sizes
> -	 * from being returned.
> -	 */
> -	pgsz_bitmap &= GENMASK(BITS_PER_LONG - 1, PAGE_SHIFT);
> -
>  	/* The best result is the smallest page size that results in the minimum
>  	 * number of required pages. Compute the largest page size that could
>  	 * work based on VA address bits that don't change.
> diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
> index 95896472a82b..e775d1b4910c 100644
> --- a/include/rdma/ib_umem.h
> +++ b/include/rdma/ib_umem.h
> @@ -77,6 +77,8 @@ static inline void __rdma_umem_block_iter_start(struct ib_block_iter *biter,
>  {
>  	__rdma_block_iter_start(biter, umem->sgt_append.sgt.sgl,
>  				umem->sgt_append.sgt.nents, pgsz);
> +	biter->__sg_advance = ib_umem_offset(umem) & ~(pgsz - 1);
> +	biter->__sg_numblocks = ib_umem_num_dma_blocks(umem, pgsz);
>  }
>  
>  /**
> @@ -92,7 +94,7 @@ static inline void __rdma_umem_block_iter_start(struct ib_block_iter *biter,
>   */
>  #define rdma_umem_for_each_dma_block(umem, biter, pgsz)                        \
>  	for (__rdma_umem_block_iter_start(biter, umem, pgsz);                  \
> -	     __rdma_block_iter_next(biter);)
> +	     __rdma_block_iter_next(biter) && (biter)->__sg_numblocks--;)

This sg_numblocks should be in the __rdma_block_iter_next() ?

It makes sense to me

Leon, we should be sure to check this on mlx5 also

Thanks,
Jason  
