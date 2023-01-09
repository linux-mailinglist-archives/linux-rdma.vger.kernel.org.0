Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D7766293F
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Jan 2023 16:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbjAIPDq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Jan 2023 10:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbjAIPDn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Jan 2023 10:03:43 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C851E3C0;
        Mon,  9 Jan 2023 07:03:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5ctPHCPwD8iHslzg+1PUxTEPni9CA0AEd6VZgnYSCX8xgOHagBAAUpw7kPMHx525/4hNSzpsY2iyM7xxQC9kRrrL/bIc2jyQ/Zu4Cnw9T0fT9B1HkHCozlzTk2bx/t5nLlDs3jd8msuG/yatiQRt+O/u9YaU8KbtIkWeqHeTqHC79hdxYKqJk+XOTbi52LHzqDWHYe1DY5cDQTO+PioO6v/jlyVLKbJSjCjW+r/CJFy2DREsQ3cDxBZD1rb9CaDdZ3B+jBNiC52BAR2pwzlMT0CyiNF2J1geZ4O2qrExw44PU9hsjbGuXSKLGobOmuqvToCAO5aAImYHCZAym06WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zFhkoSw9pprmfVUbIye5otklxmtRfQmAgnTdMwHIDI=;
 b=SatW10BOc82eTgA/v690Df5HR0IXBx4RIYbkvekH0z5q+dDglLgqxLu4xb29dPN6I1WVdDC24i8OUXER86GRfNx8edR9lph3EjlGKZok7qS+Zh4pELrG4na0nuDn6XsKVPYOfzda0NponvR2cduu8N6IeP+aO1+D09ljkT/m113aihZXLhh/EQaT0BFLtEsSMp4dbsTQRMjzJTE2Pc2K1VDeBjg4PJBqJEf6BeD65YZLRsEW1cGWRSCt7VojhJvwOlruOtDf3/Ay9NsRQJQ67iuYZ1PfgIH+pH/7F6yOVcyGh+NMUjxIFjeqN+DVVPhhTlFG/eY9FWPZhnB/Hr3keQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zFhkoSw9pprmfVUbIye5otklxmtRfQmAgnTdMwHIDI=;
 b=d9L3QVtRlUByXfGqXX2DVlkSa280pA4ek6Y/3a19dwW7pKmGV+Q+IlDWpEqv3y3xXU84/fdk2lEUe81NpYer3rkqeVtwmYFOjQUiJYyrU4eT/1cx4zoitltD4LXqNAt6MRm5BDVQmw1AjGemwaqc+ms0bCU9BndB/ddRwtFucT4WQ8GnyBKWWO9aO6b0ykwSHqp8QoExUxtkOSIZ7JBCHBwlioy8VyXkR09UPjgNJhHjKaocA1jWDbwrJ163+B/UlfTs2d1HUuTt4zZmSqpy+8jJ2f9x/rDn7SAEed84Rl03j997X9huvuYPJLl8D5s2uJM4YAM02JheIANZIiiBUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6459.namprd12.prod.outlook.com (2603:10b6:208:3a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 15:03:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 15:03:40 +0000
Date:   Mon, 9 Jan 2023 11:03:38 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Haoyue Xu <xuhaoyue1@hisilicon.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next 0/3] Refactor rq inline and add cqe inline
Message-ID: <Y7wsyiAJhvdrCix8@nvidia.com>
References: <20221224102201.3114536-1-xuhaoyue1@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221224102201.3114536-1-xuhaoyue1@hisilicon.com>
X-ClientProxiedBy: MN2PR01CA0011.prod.exchangelabs.com (2603:10b6:208:10c::24)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: 1109b995-f3d2-4fe5-d004-08daf252b12b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v066YJS2F10Rik12eYuTUJa+1j+8rr0H0oo4PwfOIpH32cE7t+MSczLg9K40iMgYMANCCA0z9qxfso9BLfVI5MKb5HshUhm6j84YurB+/HyHbMKiUIxxfbGIYprnveq9TAbbIJqoQwwvFAHO9lDLrcu48xXhzrXsKGjO/XHhDZNALXs9UIRdTLWsBOWh0RGnYzocrtLYwWazYJ8lOG6zfYfJCTh87ScvH/mW91i9OywqQUhzIapX6l+Pbm6+s0vGZ6oCufNgmUkTe7IkHbiDlSqn4A+wPP1E7FkRCItsBJ36jptYKHagxbnWVgZu3RuwmF460cdlVipuVRFj7yHYv9MHJ83PAtcXdD5e+M8+rcw7N5VxAk5tbWvdai2Epim8haazfNo/TfIZdxAKOVyF2fmFTia9L00xvhcmxAJ9+mWw2/6DH7et9izxE50HnAYESAJYkmM9wfg0z40Y5Y7u/KUNZHocLf17Ct8/FKXZ+sWWAZCmJq661RVxFzu0+xVLssEI+2A8Wo451gJOl4cSwgJK5UkaQXSdgdHuXZlRPuEKJMJdyzd3AMBZnPA2bGX6fR/qQdqMjPGMSPvPn1eVnIq3QxUf2GwTsWtQWht/tjdpBaQXh8fJ0UbDxd/yHLMrAtnSxG7fRO8qz2imV1Qjbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199015)(66946007)(41300700001)(8936002)(4744005)(36756003)(5660300002)(2906002)(8676002)(6916009)(66556008)(66476007)(6512007)(316002)(6486002)(478600001)(6506007)(4326008)(186003)(26005)(2616005)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yKMc+AAIW4zwmfFrlohloBRfnczGAWS/6vnPKAmKpgsUDHRj8jR3X6L3F7Qw?=
 =?us-ascii?Q?WxaJk/Ddu5g6Lg6VMQGRxddmfgZvOEFfzcPfSCdNrMATcBKHW/Fy7Dh7YxAm?=
 =?us-ascii?Q?MdDk0WOaUeETTTmQnuT5Tpye+ZrL1LyPwx6anJCbIHc23y+mX71Y3RK4F9iO?=
 =?us-ascii?Q?VOHS6SckcStoopk72ax23RZm1MiDS7pNMa9qVH7qPu2On/7HeqcCcNw2L4Y+?=
 =?us-ascii?Q?kaptIPsBoRA12Goc52vf/xYr6g3GkfCsscOM9B06khwD+GKD16u4V64lkfFK?=
 =?us-ascii?Q?1bwqs3HVr9VsADIJBBX6OXZ2gYFEkAb9KNuGzuxtA8wb7gTfhJQybkWDP8u/?=
 =?us-ascii?Q?GzQC8716dm4Fe3J81kdFo7WwBuP0Zuq/Ix956eiccxqWgTBS2xHNQ8jpZWI6?=
 =?us-ascii?Q?TLLhhIZXFA8oJ+qcLs8yGDX0Fa4qPE49bx61y6T40O2qk67i7R7fkq5WQoIx?=
 =?us-ascii?Q?atHSuHT6h2juVcnPFjxJcOy5JuKBD4SCHEK0mUmefH/blMaIOjU4aRDI1CTn?=
 =?us-ascii?Q?zsx7I7h0XPdT/oPqEVZxE4zYHNzKG6nNbBgDdxwe81fSxypDKX+E7gcI8Q6q?=
 =?us-ascii?Q?gBEjXBOLzUtPlW/dYzqHJhkMUK5g9tGTqB6xbAh0ob8QkTKnhoZDBHmuWr3r?=
 =?us-ascii?Q?2dimM61QsClSAr5TYbn+h08HG3XphjAFWYRyoxmhF3aQaUkpC67RJoBUERIk?=
 =?us-ascii?Q?Kk6l/BU/wGQiawsy6oSHYKDM3Ujy4zawomKBhjO3U506jxZzX2hxedIZUYt/?=
 =?us-ascii?Q?2oQzp76IHHt7YdYwsmVWXlPQID1AqEIR4ukoJypEnNSibDIUFm03P5SLcZA0?=
 =?us-ascii?Q?734wRIRsGUFFDu9cJa9QmdkMF/sO/gw21MyM2oMQIEowIpubpKvmBUROhEGY?=
 =?us-ascii?Q?3g+Qq7Fjvt+CFTeH1ngsJP8GveGY83dZaN/i/WDj9AqpNnseHxnnAmwyGCfd?=
 =?us-ascii?Q?/VfVrKlDTAMHFFEXifu9lL5YgqpS14sP1XuLshL89otqhXj27qkiibBt2Uf5?=
 =?us-ascii?Q?eOvibgxAFWlpJMDRDSJbSclQeYn6b6YyuEu7RAVV9RzhMjnE6yURAYVSEyU/?=
 =?us-ascii?Q?3gGh9Hb0e6IeBiH7qkEpTGGHFpEd2CAuL092hCnfS47fRr8+q3MNqp+iZdD1?=
 =?us-ascii?Q?BuLosrba7Vcqgo48syXMKSo/98TlJieIe1aNUB7TLfFql2I9BG73CPu1bTWr?=
 =?us-ascii?Q?DCb5iu+sRS8Sk8pjReFjphxQQjqG/MONWKmx+riQMC4nw5UG+1Pj3lT1a5y7?=
 =?us-ascii?Q?3Xzyseuc5ZDJzjJZfuc6mJSvleg8oMbCDaJNRU3cU4G3zshIhssy/pRdjJsf?=
 =?us-ascii?Q?AhaeHiO07HyHpJSDVsRGZ3zon1GoinXd/Rl6pxs3OzDkqjxvfzPJUUrfRWBf?=
 =?us-ascii?Q?hDzyORpCjhaszDce17vTTnjjU+/IMfyfPCEgmr2AwEqW07hqGtjwHAKcYEin?=
 =?us-ascii?Q?9Old7hdUAWZIpq5u4LkHuIBpk9PIRU4/ZSkujnL7cGUABiy22uHR3HayRmHb?=
 =?us-ascii?Q?8YQ0TtOKfAn7UXoJJo87pqT+cSOAD2GWeFuncYig6q02bxSJoIP1aOX8ReZT?=
 =?us-ascii?Q?4WWr3Ed2sHwIqgBLDYwhiqiXRbTOHEu8Jcfqk05d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1109b995-f3d2-4fe5-d004-08daf252b12b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 15:03:40.2837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWTMv9y9ZT8M0yt2laPPURrIN9ZHgJgoYdOjqiiJjfYpia95ZPSv69iI/jWdR0V4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6459
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Dec 24, 2022 at 06:21:58PM +0800, Haoyue Xu wrote:
> The patchset mainly removes the kernel space
> rq inline features and supports cqe inline in user space.
> 
> Luoyouming (3):
>   RDMA/hns: Remove rq inline in kernel
>   RDMA/hns: Add compatibility handling for only support userspace rq
>     inline
>   RDMA/hns: Support cqe inline in user space

Applied to for-next, thanks

Jason
