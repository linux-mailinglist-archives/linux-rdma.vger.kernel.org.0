Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D8371E9E8
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Jun 2023 18:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbjFAQJ4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jun 2023 12:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbjFAQJz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Jun 2023 12:09:55 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F7013E;
        Thu,  1 Jun 2023 09:09:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7kAyrrQ9mS/G7CzAd/kMv1vDmjapeHE8zWojfyeqxcTt7RFqWmGNSTu95xpSy98j7/cFwVC3buEe7JukHlHSMnAh1Lpz981HuyDTdHUNv/uAWDq8DXaDibZ+i+OXE7pQQuiJkXMVYMwW1AAX7wVZCBHGGqOvYzev2gred7ncO4PMSRg+eVQ6ZXdyKJnh847GM6exB27IVABDdiseai9v7ISdfAUlWzZ0eJ7dZw6Z0Z8q7Wb/6061wIhwYJMTYLGXX37n+fwQLGVAy/srtCJTIaZ8m8R683HZNGJGcagkimRT5R4mwh+4YMmKFNp1HrV2RArN6Ih2mYLcQ8CjDLkgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSkXLqg9Fj03i+0P7Ipn4hXC/1ezroKA81yxUktkQ3U=;
 b=cPtqFHQHfuZiITI+hXIQHc+B1JYWVJ7aUw7Ls8RTgHLBpnTgxeiUw1G2aQsmas7ofGeFYMlX9AaoRShqk8NFpPzoB6E2zeevBYy+srRAA1A0JHWrn/fKgv6fKhUePhtF4PS1hzE2Y7aBMGjiSdq+qVqs6kU+OU5kOeJZVx3c3RXt57X38NvuBXApgZbqL/o6JLFBYejgfNqSYOYC74utksa6XJLZm+Afa4SszX/p6n3FhVbcoKxAKnYUX5ycDSnUf864w7UtH0vU1DjhyDQrmvZJYWf3kDSWnNHLZ06q5fu3lmOE2QLJIGZiLoIPinGeuTynQ8IwM5dGW6sKceh9Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSkXLqg9Fj03i+0P7Ipn4hXC/1ezroKA81yxUktkQ3U=;
 b=bsRSHMOBD1c8yJ7HMkbzsgP/Ml3QK+kmUUGGfTcDIpiG9u9Z81t83/RQYs7qfLaeXdVBIBEhVnV2mLqKgf324GTmv5dy+uCXFMavyw0Ue6Q2Y6XCOPfYihKz/yEWxp6JTrggbxSWHfVg+tfcJw9a+MeJcE7bk7tx5GjvQ40Znqb5D/qBfgpUEFQWjYaXlEZENhIr2JSidEFz+WmT7epCsF1xC/T67mkNIf5DZbCZLzEdO2pL2nes/As8Ke/J/bZ5UaSwu6ORjX8VVRA9oy/vXS8J6snJAWAKWhqg+rFlj9V23mqShSvzAPRJFn+zZcZ5wR6UZu3UACNXSISGUxp/JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB4542.namprd12.prod.outlook.com (2603:10b6:806:73::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Thu, 1 Jun
 2023 16:09:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 16:09:51 +0000
Date:   Thu, 1 Jun 2023 13:09:48 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sindhu-Devale <sindhu.devale@intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/irdma: avoid fortify-string warning in
 irdma_clr_wqes
Message-ID: <ZHjCzHfNPubWUXcL@nvidia.com>
References: <20230523111859.2197825-1-arnd@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523111859.2197825-1-arnd@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0364.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB4542:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d62477-f241-4471-995d-08db62baa10d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cx4iqf9HpvP4rBaoAG5IF/tS8ii73eaVfQ51iS53ZbEy3xo8qC+uiTC4jNwVEkmaixcUZv7OFhySOSHd6k2Vv3fgcnbe/H2AUpKQSchZQPUNEf26Gmioijp8XTVfximjwqKcpTvCU04wpWDtuDu7NIu+Xf862zEZ3SFlkIqGmbaaKa+78LaIIP6LPojlA5ZAXEcYb6WZMPWod5YS/Evo7OpcE0SQLauIFrjVRUcDN2VYmeWm6zRWRKgRiGxwXbSkpXU0ptpAurslr8tTE2jA15us07+tuD6QpGmSmdneYdajrE34zv0wjsPzN1T7C9pDj+hw8jRC1mqZ1a2h/j5oA3rhBXUAessOVFm7GmnXRl5hEPHYoN44z5xazFnuGEqgtaCueyAIOhlWzb0uiu55kNKByTA/8alBPL3m7lyDaxD3V3r92veFHhAbLPENY/bjB6VZjDxSy3DonguMVTAmmEz/mB6f/QQomCtq/HQTdYtjgiaAUjln3aiO9sWnC9j8kFxzXb1Sm+bSN9nL8/HoAs/X7fAzsMzQNYQiFcTmo4Mt9MiBWSXhEWuj9p72HChN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199021)(26005)(41300700001)(38100700002)(6486002)(6666004)(186003)(6512007)(83380400001)(6506007)(2616005)(478600001)(54906003)(66946007)(6916009)(66476007)(4326008)(66556008)(86362001)(316002)(5660300002)(8936002)(36756003)(2906002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QdNwZZaZXdT9pgSeopOFMjup0fOgmTszBBg56XTlCtT233c9k4rqzhGP7kbk?=
 =?us-ascii?Q?PRndRqWKkayjkLDpoNYjl0o/4WEB5wmhxY/sBMlPjWGwpeSTX5cu7xAGmfN3?=
 =?us-ascii?Q?u1xRSL7fchCWNnyAjgp2GNgFkAVOqEmXNt/RamhbOBf7LA98wD/BZidpLgd1?=
 =?us-ascii?Q?OCcP+aLxd1G1EkqF7/9tU54xyYFT6mRwUsEjXmSJOgeaRIvWgE/UGt7Jm+gd?=
 =?us-ascii?Q?svRTCxIp6TIz5JMK4X7Xym0nddE7qAsu9yHXit2KlMAzlj/eEs2rLVktkUvY?=
 =?us-ascii?Q?2FMLuoPL+SQC+yNhPPNaNsW8pMQxX4DZrf8KbxzbgQAcPiVrfIFY6ixLMcuh?=
 =?us-ascii?Q?BU19VQk4RMsF8C9jzi/QKT9aXCOKssdkLDQ+rM0qDWKY4czPf9L+Ol2sSln4?=
 =?us-ascii?Q?3oP84++HXI54gokhrpHFDwkehI7B5LVWrrU4XPnjre8KXk/VwRaj1Og5UBMh?=
 =?us-ascii?Q?fDwsQoTjJf5ZmXwTdzKmPYYUtdY8BbUhRz9j8TgJvq19RfGej55I/753zcb1?=
 =?us-ascii?Q?0MpT4mvegnZWKOhe7Qb7zf2QcxFlqT5W7f4EnWS4avIAvSuLbhS6JxTqFJ4H?=
 =?us-ascii?Q?pbFoYF6BISp6E26OGFGotrLRkhSuA99i2JL9kNNVIBXET/yJ/cI3j3zgM7Xx?=
 =?us-ascii?Q?EkBHjE3IZRNnqXGOw+eaJ6MftvXKA9U+OPhXbttiIJYhgzx/+Zsv1fALGOSN?=
 =?us-ascii?Q?8VXvVbQPnH3/rtjvBgX1L+zZ78BX89LQn2f5/P92KpcKs5M2Sm9vgKU2Qalf?=
 =?us-ascii?Q?i2dnBcPP8RRU4ZwKRLDU/JKLwPVrOh4VEOYaiqwfVnkHvvGUYyTqufDFpZDT?=
 =?us-ascii?Q?a4vwG1zALi6u6UJLSco52LdKdTayCQAmuj71OHIxnBfQ5HOaX3pjC8wdjRCt?=
 =?us-ascii?Q?qdK4py6Wx9PVR5f0Lc1qIZWKckT3SZyRLN0rMAfklHn5TdrIbRsxfUwYsNHz?=
 =?us-ascii?Q?o7n9C8QVpPAlCzoxcVuyQx5r3rL5aUl2xtLTXDkGVfC4v+e2tHd99mL5JWIJ?=
 =?us-ascii?Q?RHTN8S28AdW06pg1rqFTjwUZMFpE0kI1ETbX37Ao/rQyGGSPzw10AsIIXypV?=
 =?us-ascii?Q?lHCHdY6qsrjQBSJYollOwyueF0V35YohAR/5eim8m8Fv5CYH/rhJLs1AEQ1C?=
 =?us-ascii?Q?oEgMcKCV94fGNG03LYM8ExvHj8wiwi5QvijMffdL0JLL9kNNcajCljOFxGRm?=
 =?us-ascii?Q?qEtDT7BvYtHs5OJ5ujgZvQ4LYLVoVbjfoq8l9WbCYl3OFowknPlzbWbzLz3X?=
 =?us-ascii?Q?fAm0AMz2Uzg/pbum19VwGQAqytVQAwt0x8Us4K0DNoyajb716O/Kdvd+BehQ?=
 =?us-ascii?Q?AptN/xiGKtMGleo8gQbxRQTTwsJZ66dnjyUHsOgJFTd2cCYtx+C2hYl9MvrG?=
 =?us-ascii?Q?8KqDIpVBZsdoA4a9JceyU+yCFP5oBVcU8qLV7mVYDE9lM1ME/LfCxfrDOxcw?=
 =?us-ascii?Q?7+nWnay+JCVVSdBWZCO9k7IPElmtj72PPcFaan+C9cXnCP1Y6qFEqgCZ/eat?=
 =?us-ascii?Q?Di2aFXUogMRjzKLQPjXshmScB4j6kxBiaYUDIKJK/rpRLFVyiSuI9jHeOqZ4?=
 =?us-ascii?Q?e9rqj0r1jBVMlmQAHNjis0md+VfHYNRINM+CdAjm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d62477-f241-4471-995d-08db62baa10d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 16:09:50.9950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0yPXSFUQ8ntMmBd4mJlKqfTIMsNZtFWY7wH03WmhnHSSIQj7iprPYHwxkb52hzYU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4542
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 23, 2023 at 01:18:45PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Commit df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3") triggers
> a warning for fortified memset():
> 
> In function 'fortify_memset_chk',
>     inlined from 'irdma_clr_wqes' at drivers/infiniband/hw/irdma/uk.c:103:4:
> include/linux/fortify-string.h:493:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>   493 |                         __write_overflow_field(p_size_field, size);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The problem here isthat the inner array only has four 8-byte elements,
> so clearing 4096 bytes overflows that. As this structure is part of an
> outer array, change the code to pass a pointer to the irdma_qp_quanta
> instead, and change the size argument for readability, matching the
> comment above it.
> 
> Fixes: 551c46edc769 ("RDMA/irdma: Add user/kernel shared libraries")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/uk.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Applied to for-next, thanks

Jason
