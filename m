Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFD87767D6
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Aug 2023 21:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjHITEl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Aug 2023 15:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjHITEl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Aug 2023 15:04:41 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40ECE71
        for <linux-rdma@vger.kernel.org>; Wed,  9 Aug 2023 12:04:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdN0AScPmfjfAg5Hvb2zU0HaGnLj7EkEujU4SI+pD9VfsokyG7dx+odFSUVVf+Ul1uS9+qWRzfcXWuNBpbkj/5/Nfc3EVvwQwUQqcswI6bj9gyRUBPzSQMbtjCdcMdzywAfMKXLoN6DadvvmF+EWPwM+Uo00HO9Sc6iAphsnwU3eEvyU5rlVb94F+dod+RKOl0I5W4gLzu9mlABcxIIHfZO+pKBm+kVpgKI6DwwbkhCFEXleXgivYbklKHH8b5zQA8Tlwwn4F/U85ck+Nkl1AV1lqgkIlaEQHGAkEgo6+rkirgEfJhrtxEZyUCcDVqQNrXQGUkSJBFd/5Sgj5LItfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7OKtteOGhGI68E7zwwWMKo4ZfAOhAFwdb+XMHMhtzE=;
 b=CkxqURj/nA/7EDgrmq6YrN0W5XMZIE79eOZm4FRehdBosB/Jvg7S/0y4VA/yYXy1gsHTvp8FR2i65YqN0AqBSuh8czwhEShrqNecSq6OdnPIjcVEYvhsdft7ObnsnQB+Qr++Wl1/R697MLGK1FWdMwB/j/6AqUg143nujqWH7TJ33qu+4Mc/61TEgN73HhT5Cea6Eo35YJgiX2MVQE2GVs5Kj5RaaOi5Plyx450vN6VXd/vPKMnuFXMyswJwC5MLkWIa83hNIcivWSWRsuiaeoNPn0xaLaojzdvnK5APqTxkPN0aj2+tpWRUYehWdpifS/HjsVQsGn2mp+GVY5djVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7OKtteOGhGI68E7zwwWMKo4ZfAOhAFwdb+XMHMhtzE=;
 b=dR8JA7tihqzIfXJCJWywgqrRgo98Ks6BkxSjVvK+R7utdBUjOlG0srUvdij43+5cYPedxr6bPQZkqMYslpo8Pzc7AZBMfkjR3X237NV0Mg1v7irkPkz2dAEMTFPdXvSajVHDv65vVigKlMkMn4/MYl7zDQHP9gMH7WiNFfuRfTtFRgbm/6P2FZBVgblUnfaaAi0E0KEElT+7XPzOeky70KLJOcBKdanFzAsYtkX2pCqWne6DZsAsSAaJLwV9HPYLAY/U2nmD443fEJYp9EyM7F4O3jJYa/fuLr6zyEs1MfgW6TDgoxvLB5XeqoX3UfSwYrsyFo6JO30MmtLqVUXAWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 19:04:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 19:04:38 +0000
Date:   Wed, 9 Aug 2023 16:04:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     bmt@zurich.ibm.com, leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 0/5] Fix potential issues for siw
Message-ID: <ZNPjQ0mknxtO6Fwa@nvidia.com>
References: <20230727140349.25369-1-guoqing.jiang@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727140349.25369-1-guoqing.jiang@linux.dev>
X-ClientProxiedBy: SJ0PR03CA0295.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4376:EE_
X-MS-Office365-Filtering-Correlation-Id: 68e7b207-a193-4a12-1ef1-08db990b7a39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xB2xkwo825K4lFOSEYjX4rR2zkl+rpC1Z+lfAUR8ku6lhfq8DrjCSjgteWWeaVwEkEnN5WuAsuNu1fSGgSqDB9W7kcCO7MaiiZFgqDa4p/vaz0pWyd8JbZ5kDyZjG82JMtO4sF/pddhVqKuTNOJbdcxEF1J1YnrarHosmLG6fLmDb1F4jxINtnFvwWP8gCGY9kHkjh3t4iHiARDPA5vum/toRSJpmmhoRmqJ1/OoXGu92k8Mf0ZZ2LNJkBn5zDFfowrQrqxi3Yl0pCRo5966po4PmG7w3sK9vqHppXJ7CNiAuQf/Pu/aduymU8rKOl5C1WmPLa6kcVT5h/OLeES/4LKTlhBYWETCoIi2ZjxZ908Ya4LIc1HdL+ffqm4x+9t44QlbloMbfkdJRbtACPgTs9lMfCwr0iPC2hMq0+jLxkLqpmwo+KmI/ahKdQNejVCa56XupsYcgcc6zhsffArqGCuWaqFRbS5W8gakPaX70dGoeoikvGVBUln7Fbq4Q3lfLGe7ivCinDTfLboI2Co/Tl8WLnGdFxFbBhRHiQ1RcaTbLL9bLvqm86X4SQEsPNiG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199021)(186006)(1800799006)(36756003)(6486002)(6512007)(478600001)(6506007)(6666004)(2906002)(316002)(4326008)(66946007)(6916009)(41300700001)(66556008)(66476007)(8676002)(8936002)(5660300002)(38100700002)(86362001)(2616005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AmKLKAQhymhDCJl10vJyrH0Ms8AgBGr68nRiz/PNy2OGoF+6xqMTSQPpChey?=
 =?us-ascii?Q?1+1KTg5gcehi9s1bt3GQyHUGR9rZzVEehNnaOLQlOhGqrFkJ14GgUtG+AIby?=
 =?us-ascii?Q?O46so51o/Qjp2Bwk7dFDTN4pidBLRBeV8MRwFeNAscYmlG3/OGZP/xrbIBIB?=
 =?us-ascii?Q?Gp1+ho511OOJibyRvdDtWj9ue2DbY7j65SlpnB8IAkWQvdw8cL+hjV3Mowgf?=
 =?us-ascii?Q?SY/0VW5PYsK1PVMxDepU20IxjL2PD/GZekBLYJhMWpUFFmiPKwiFjzrQcMcW?=
 =?us-ascii?Q?eB7OFacfv97/OOT/r78c5PICQ5jQw4SU2a45yM0FNYLykG7+vK6betFCm4f5?=
 =?us-ascii?Q?S5MtdzHVgR8rJVCWBwsCLDaLsW7rSsXniNIKEX2ACQJDe9sl1ZscgJeU8HuU?=
 =?us-ascii?Q?Cipm/YKgDZYQqSB7pvkQBuyXiO6c+yRfhc2xbL4zrxgEEUgByqPe7yNMZDHj?=
 =?us-ascii?Q?BZY/KzOkz9U9//T5XrSVfP7WR3KAj3i8pB0ljzZ8WdHi/5Xia6c1zB7MdUwn?=
 =?us-ascii?Q?hvQA8mXixOX0vsx1jTqJHQX39cx0EwbJp63mBW6IThTdXTnhVF0hkvB1gYRu?=
 =?us-ascii?Q?aA+qnOOLc45ZWtdjLJL5cUhy967FTPKlELTuZTwAIOZ7DZbQaz+Ls2MowG5Y?=
 =?us-ascii?Q?dJ3JTR2Dbks6p8rqdoN9fNIjHEvrKBog1/SX8W+i2vL2bnThwUKQit4MRvyx?=
 =?us-ascii?Q?GgkW2MqHcehqZXxsQzlGuZ9Nf0RdRDUI8EhgFnXqzrYhMiTibmvpfbmmVxXC?=
 =?us-ascii?Q?aEwQMO6a/pSDx2RY60PwAWdn4yKkOazKlBxazjVe2Dn94ZIX3UUJrwUIxPjr?=
 =?us-ascii?Q?n8pNblFQCD5+knQvVIiJJEdfPfVOVt+DdN2Tf0E+vn908mit01aeBNoNfInW?=
 =?us-ascii?Q?MbaJTxJ1j9KhlDGPKZwMBqJh0S8c6Oz9LpnHxGQcadKd9GCU0j1TFEkpA771?=
 =?us-ascii?Q?R6YUUPja2+MZYvyaNFYoW6LSUX1VJ6lRu8+I2zTBW2pDwcwnkFo364rji9ov?=
 =?us-ascii?Q?SpdNp+0NFWnKnyghMoapuIOwfvdvW2AiVkhQt1gljKEeejfF10x/Ukyq9Atz?=
 =?us-ascii?Q?S96Nmez5BMEbU8VJsOLgYog2kpusEP/Xp0UqJg4BRMb9ev8XT11RWfK2ox3T?=
 =?us-ascii?Q?OOTJug/jf/hrwOuHViBdavOpcRle4ms0JixiBQXC5LomnlAF7cMdS2Qk13lm?=
 =?us-ascii?Q?5WR6HGo3pfzVYdj1pkQ8bmYytVf/N7873G2kVaTOWUbYsma+PTxr/0OjC2cm?=
 =?us-ascii?Q?efroIdQYMvdOki/8fgCuDpoTfHeM6AHITmiRkPBIxkq2OJOA0cR0FPGxPhnh?=
 =?us-ascii?Q?zYm8i/tWL3GdYHD5mDVNM+ap4Qh6yVu3lJa5NGFeSytUQx4G4n2WMHje129n?=
 =?us-ascii?Q?dXLO/fjQnY9uQlnofjtJ6jdUVfdiB2QYbG7lPTujjaSx5VV/CZ9h3/wfo4R4?=
 =?us-ascii?Q?A7/R2soF0IhqwRxpUs2rBMRyJ9NJEZpcDwvRjrXNYUQ6iXmPhZ4f6+NIJeZM?=
 =?us-ascii?Q?bWy91EdWCOhuDYd0OgtY5AzGqkTeTzLvTC39qenpWKuc6JkPkTU2qmHpKVEx?=
 =?us-ascii?Q?s1iEAqMbKVfh5NGdiznR7Rj3gOhYnREzkhjPU6Qj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e7b207-a193-4a12-1ef1-08db990b7a39
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 19:04:38.1944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bc9Hu2bmkJ7siu4v1+V8K89A3ou6Rok2DOrJM+SstIXUR3oWMqTViubBXO1hrr5N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 27, 2023 at 10:03:44PM +0800, Guoqing Jiang wrote:
> Hi,
> 
> Several issues appeared if we rmmod siw module after failed to insert
> the module (with manual change like below).
> 
> --- a/drivers/infiniband/sw/siw/siw_main.c
> +++ b/drivers/infiniband/sw/siw/siw_main.c
> @@ -577,6 +577,7 @@ static __init int siw_init_module(void)
>         if (rv)
>                 goto out_error;
> 
> +       goto out_error;
>         rdma_link_register(&siw_link_ops);
> 
> Basically, these issues are double free, use before initalization or
> null pointer dereference. For more details, pls review the individual
> patch.
> 
> Thanks,
> Guoqing    
> 
> Guoqing Jiang (5):
>   RDMA/siw: Set siw_cm_wq to NULL after it is destroyed
>   RDMA/siw: Ensure siw_destroy_cpulist can be called more than once
>   RDMA/siw: Initialize siw_link_ops.list
>   RDMA/siw: Set siw_crypto_shash to NULL after it is freed
>   RDMA/siw: Don't call wake_up unconditionally in siw_stop_tx_thread

What is the status of this series? Bernards fix for some of this was
already merged and this doesn't apply, so regardless it needs
resending.

Jason
