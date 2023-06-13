Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCE872E1D7
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jun 2023 13:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236749AbjFMLmA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Jun 2023 07:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbjFMLl7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Jun 2023 07:41:59 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890A6BA
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jun 2023 04:41:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MeD8FEkZgSV7rhVOiXHezVvk5pBDO8S7z38n+wjiwfSCxRmEPhNILPjEwDiXp0toCKzIADxbhcnSeIxwUu9KCUipVH/c+XY4RkflOp2Hvb11Ul+9jBu36ET7dBoPvEysEElW5cwYs6qVKKigjms+AIlrI1v7rWFIXEYxrZ0PqL/xNwgmeBfwGqO2jzTOD3O9Ynvl1sQYYDJIrHuVAzHh8wiRr/law7azlIdBlEF0aH5m58hXTU1OIe7mXl74gPVKJ7BZjmPR/fEqHzU5lRS4rV76R0+wabQm/5qv0/w+kz9CThVi5GLLnFGfsAyEienQzq51hMVk+gOlSwv8HYMkDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Q3L9rOHZwwrW/kolLvxuMGMNCP2D6zxKDkM5QuWJno=;
 b=C/moZU/H/xsHAoPGGPT1yTRROtZAXuxFKWF1qWsfNuPcflo1+a4CnTQ8lpX73ojn3dUyEzNqDUwcIFcWzI3WXqPCQhSVE6Dn+saNvBPhYfhcA53vPbMHk9TwjAsmX1gvNKa9jsPX7EddtjaJtbVsU5RaPkAr6VpSz4dr9rhnAH+JGgPdcTLvPmKHMDzG+HL+uLmg4AKvBoBYC0ny+jjS0GgqiUBfGO5vVIjDfww/0n0ZbaWY3JthG7lQ5tko9H7VREGBMjHMltDCgfbEpHAZacdKciGWqKDyShnCuN3RRLww/z3dRmt8zRvR4Txs27cnMmuaaUPMigSoL1+kYOZc3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Q3L9rOHZwwrW/kolLvxuMGMNCP2D6zxKDkM5QuWJno=;
 b=eDHib1H4Egtu9yiM6DPBcI4exBMLctmFaikuSCV2baXmk8mAjMcuMNmrEiAL7R0xneMs3Wsi7nIzHUwGKHvlfrWSAS9/zq1vipbazdInfW3peScvGDbo2Jgd5EgO/l4CkCS6NbpW380gKwAHnrDbVmko3ZQ065BJCL2J1n8mVwLMNpMY1e/N2Pwo1FStW+trbf2++KSIt0riVib9WSGgynoSp58zKtYNJ9p0HNOqSPvXdwlhNlU+fIj4Fva7OefmFdyAfIn1yOX7EBBrcR6SmxgCM6kokdctDsk6+8+ft6buftBjSuJDpS6lkbxP5dCTGtk9FEMmsEMd0Fkd4f/2WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB8577.namprd12.prod.outlook.com (2603:10b6:610:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Tue, 13 Jun
 2023 11:41:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 11:41:57 +0000
Date:   Tue, 13 Jun 2023 08:41:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com
Subject: Re: [PATCH v5 for-next 7/7] RDMA/bnxt_re: Enable low latency push
Message-ID: <ZIhWBDqSiZLZDf7L@nvidia.com>
References: <1686563342-15233-1-git-send-email-selvin.xavier@broadcom.com>
 <1686563342-15233-8-git-send-email-selvin.xavier@broadcom.com>
 <ZIdhunLGPLg6h5ID@nvidia.com>
 <CA+sbYW0GD351sTnGaQp5omKj00kmVQPKE0KbWTSuHt6E8M+Jyg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+sbYW0GD351sTnGaQp5omKj00kmVQPKE0KbWTSuHt6E8M+Jyg@mail.gmail.com>
X-ClientProxiedBy: BLAPR05CA0037.namprd05.prod.outlook.com
 (2603:10b6:208:335::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: 347745f5-348c-4137-d1ed-08db6c033125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uaU0UJwdQz6nXY5KJEZ2HT2i2v9LZ1bUt6wMf10KfQMe+88NBOW8K//pTBfxGXupJOPO6rKuOMo/dMxLfc3arm1n/uF1pe7iMhdaDw8mHAOzXrWqg+gu/doKaCifeDR59kfQZq+fRRo2j59z8mLyDATNDxUygai85M0ZM5f3nO8B01hFyEw93PSSOTWRbeoX+1qoorjOIENcva+SmQ4mYTFiB5SPBzNtU03EiikTG8lyYG332/bpAfrfxCbJ2ffzx5z2ng+EJ57B1805wvEWDydyf3Z6tUkmcXhYmWcyay+ZI42PLASTppi+FPPAIGFJ369MH8/IDdfszv8jYOKma5w0yk5JGH96oa0008GP5TSt/oSClYAAX1L9Vb+Q6HqXAGGjzcNxM7pWWmBB64cfkV4zT6+gxWP8+ksIUsmJELsCNqxJKuT0hOAAvNoVKBlHklbVvkfGkgnzdjPPsMF74Q0oGZalJy3YITtxUTGkl+M3e0IoCZen+JdknVE/x2gMLVE4IHH3l4/KEaaqDc8tsG2AHSYMNqdWQvRAuFeKynl/esh9p871aBybm7p0gVIL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(451199021)(6506007)(6512007)(36756003)(558084003)(2616005)(5660300002)(26005)(186003)(41300700001)(478600001)(8676002)(66556008)(8936002)(66946007)(4326008)(6486002)(38100700002)(2906002)(86362001)(6916009)(316002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cpYntPrr4EW6WUVs39vi45F4uzEcIOXQ8MUQ9w+Qiay85a4NNDOnFJrtsVTc?=
 =?us-ascii?Q?xt/y3xUl4nzddr+Tq38x6TgW7kT03HXQRdNJq6O3//16u4qlShWvLmXie/QG?=
 =?us-ascii?Q?Rr7ClIBdWAqhRQ1W7i1x6ZJQt/JhRv+gfkIdfxobZShpZ7Ax9Zfs/HpahxW0?=
 =?us-ascii?Q?FSDeagsf95wkSKtarARUKGj/uO8zECAf/XMR7OcW+ZbkWghZtQpCEtm0tG9/?=
 =?us-ascii?Q?058/b8/bGNw713pLLbHKO/rIJDKgFgAXQhUNwVpsxnxZac2abNjD657n7TlZ?=
 =?us-ascii?Q?cHX97rRyYpouaEzgVeS8ZAVdyYLjdV9XymJyHZ5AJ+Pl7sXaJMmKFbjeSQMh?=
 =?us-ascii?Q?CoE7RoHymk4FKTLc6ZWmfBJRICkJ8NekJJfiOwhXV5gNSQaNp0TVVYyCjNjF?=
 =?us-ascii?Q?30q1zyqs7r48qxRGG5K8mdkLi1tqSnP1ESs1ndC9azXq5a6hxGe6q/qzLM6z?=
 =?us-ascii?Q?B/7IQ7YRTqbPhhM6BTaCY1dt4g9vngo6qFk6vrHX6VeArd9LZ/4diM8/x3Ae?=
 =?us-ascii?Q?TP1naFgVwMGhiy9uaWX9vl6bxMFj64mbP23fw8UOevnEnzbeuC8dqgWOsDqu?=
 =?us-ascii?Q?b5pwoIsgR71Gq8wYuPo+v8+lEtIn86lauIPV7/2SQAEClT7cxWzzDvM/ict8?=
 =?us-ascii?Q?Asng/GxYNzKnojlhCUE2MMwmzgw2ImgGUahbBPcVqPxnipKkaXga3X+TGh90?=
 =?us-ascii?Q?eDSzMq8r39HwiylFDw4U2ZhULqDdpJ0yNoW9HO5wV7aevUfMJ4jsOQyEGBVA?=
 =?us-ascii?Q?crJt6cQnsSEmHlLfg20gBoi4Bd6lvErU0iH6rTxmcwiMZkaZ9TJn2HqVtEHl?=
 =?us-ascii?Q?wNnKrUQj0sR00V0sinVEh2obXH4mixk+oOajAWAhsHwCz3BdVJuv+qFq0ALY?=
 =?us-ascii?Q?fhphh/bUtQaTDSjWXn0Zjmyf6vfZwCPSiSGTwWX5ugoCQQ8YKO+qQluarTFM?=
 =?us-ascii?Q?4I81s4RW08ByL4bYeA5yvtO8xbdIqn6fVfZYjg7fTClEuGVAhT+mqN7O4aUk?=
 =?us-ascii?Q?/e4m9GkomG1pjwfeg4imeyKLoHIAVujzPxHOhQaKv2SuivTl9SQmvDnXSDGP?=
 =?us-ascii?Q?JocHBzYUltQr2lsB+Lz/Hl+00yamEiNLRG2pA4m2fdnIay2e/dDvbBmTgn8r?=
 =?us-ascii?Q?MhzC495Colnm6uYZ/mg2g7S9/yFa4s8moM69ofo/YuzToOQff/NjY7PAGHDT?=
 =?us-ascii?Q?cPqFc4MWEcQi1mzzXyKDO4P6o6rPKWxhyRTMrbmp4jNPSxpBgUUoehd+44WU?=
 =?us-ascii?Q?US6uc/fbkZJXLSzzy6PCDeC6hyT2M1+b+7iE+lkBhzty95DQlW2SmGjJpMIE?=
 =?us-ascii?Q?dq7/Km0sr5ixXZ0G5Yrwk5oG5eJyksDsKeTSS/TaJz8mvHF3s6z0XjP3b+rx?=
 =?us-ascii?Q?9BDEWz0gPz6By6wYy7YhDPSQpyuXiaNN7bf3BB+CSTlNrEglxsXWteLkXDZG?=
 =?us-ascii?Q?vO5Fw5TQSzXmvJFXXaQZDFZz8i94yTJI8M6JROak7i5ut1Y6ymV6LjtdvmPl?=
 =?us-ascii?Q?01lTTkHN2avNseajTyx9jUlwulzPW4WYNbv6m7wx+TpwOT4cPuX6y44A0edF?=
 =?us-ascii?Q?CfCQNCJzh1pdWrACCN9TgpAEdCRv9I7orPzRgrrL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 347745f5-348c-4137-d1ed-08db6c033125
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 11:41:56.9448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MhSvsKoVig3Q0bTm19U8QnBTP2P7X+N4QfuPTMjXG1deUZ/osdbBL96m5xzJSa8o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8577
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 13, 2023 at 10:53:11AM +0530, Selvin Xavier wrote:

> uverbs_finalize_uobj_create is the last step before uverbs_copy_to.
> All the error checking

Oh, you are right, I got this mixed up with a different subsystem

Jason
