Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2006D4F9B88
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Apr 2022 19:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbiDHRYP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Apr 2022 13:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbiDHRYN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Apr 2022 13:24:13 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4543B15FC6;
        Fri,  8 Apr 2022 10:22:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QihuWeY1VdQyXAgBY25TIDA1Y7NpsZF7VHLRSkNhk5lLw9LH9CggboEI+rfNqhEG/Y3J8k37oKHT5ltKhHkdjo+ugR2ZGLKqKLYIZZffFewXJRuvaA/WQ6PK98Sm/LjGlcbhniNwUdgtKBr4D0X4h+/xNfegyRYDmH4qmao71jVQ51gPejL7ztmNoUc5o9qTJjx5d9McAPLZjamCLLLJlFKF+23KC+hx/7hSHZeeS9yFF0ZAkEKZD+nM0QWVlnqZvaVNnnhzYHvTBy/mKYC0lmxoZLWepdoFjeFCV78NSTRxyWSzFvx5cx5YY0RIlRBNzwBMWbk+MzCsZo3tYS3mKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xw/a/ummHEaWM0F4smmi+yvtM9OQJlQmqewlMXe2hBg=;
 b=Qi6dajl/mdXFZ1iyCBrgnQJHqfq15Mmc03u2X5xK52+WZ4GD8lg3/yzoRYovOkeZ7T3tPTADi9tqLw1TFEcTMqK95fihnlU7oEOuXZvBCav9EncrLasIMnE4UEp7IWQXvQRkKNzW1g7qSrLGk6Zg8QnJMQ9AfaA5PDi16geivCCIz7yth+W0EzhjpZs6nohLFfcOswrKU3qlxghiuDSo/npbq6QQo2paHUPa66219wBzpjyF57tu+VvLnc+V/TY5S24Ukmo/pbTUqlkkBY9ENFRGiWuAvLuDcII2pKe6qleegKvMDukMryUgnu5itzaovz2AIgNzjA2shrPxzvEJOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xw/a/ummHEaWM0F4smmi+yvtM9OQJlQmqewlMXe2hBg=;
 b=sNccsY5AL9XkPJjhmZnJH/e+9Sn/b9JKPuxkVRw6/mBhaxjXb4JuwueeYYIMlmsNQX71HGJOmNper3mD6qUZCn2ht9zo7xMAu7XT+zFNdnTlVEY7NV4dzwR9UCCUuuePAvLb8S2fXoLMoaM3xt0FIRNXW/9m+Mq+ElgG4vBlGFG/TW6E+6m0aYt2m5dSI5VJGyuwoQFA75IMl/M4CJNlIXCCtxxCMvXUzG4c44Cl9QJ1sOk0+9scNUv8apu+9NmcPvIDzrjvDq2i2A1TF0q2EqMB1e2w970LzGpz3EkdbHKpCkasSkyDf7nh0W8hC4zOsVZZ61G7PWcCcFDj2C1gPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BYAPR12MB2952.namprd12.prod.outlook.com (2603:10b6:a03:13b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.23; Fri, 8 Apr
 2022 17:22:05 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%6]) with mapi id 15.20.5144.026; Fri, 8 Apr 2022
 17:22:05 +0000
Date:   Fri, 8 Apr 2022 14:22:03 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
        Mark Zhang <markzhang@nvidia.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH v3] IB/SA: replace usage of found with dedicated list
 iterator variable
Message-ID: <20220408172203.GA3637956@nvidia.com>
References: <20220331091634.644840-1-jakobkoschel@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331091634.644840-1-jakobkoschel@gmail.com>
X-ClientProxiedBy: BL1PR13CA0437.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::22) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c2f8829-8ea9-417f-6f80-08da19844d37
X-MS-TrafficTypeDiagnostic: BYAPR12MB2952:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2952352875A4DB68B9F52D5EC2E99@BYAPR12MB2952.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I/MZZKMhtMRlInc9Lsf7l2JdFhWKeUIKiOfkUM1RrYmHSpbaytegmCiAhpDxjEsbjTAU62k5tWn/uLG3J9pcNL8M0vkMaFmKnG1aRPwcHof4mRgsjDpyqvXDv7UnszU0C6gvrcOrYEJAUoGpru0rz0aKDmxXKEApHMcajeLZFog8wm9gnNiPTn07EesKqchV691ixdK0oQi2bFS23DlY1msx3K1qb9gTiTyQ+rldIPUbPezwuu2qPOtxoTFusSKSg7qW/YGsZqxjGa/7dVpG7if0JpbyI5Aifv4TgplqXpI5/cbENOLAlncsdYvjtPkt7pkkTc3QpVOJ85Ph+ov39czEJ/9SNC08BiE3Xb/WF4t4yOdvNFtJ7nfkYAcQgpSkxuVvOIDjLmNQd6JJK+bNTo0yGpQEi0N3g9f+Yuxu0pWmVuVlywqoRVV6x5x3pcoowNtjyRi42ZvUktqp0mvfSS1T3fIxVgFrUTKCisGCBaH+LW82nVtFpUwnryV1rYJpZo7WOaNuWNyyxFNwjaXZV2lHrO2hmpzVvCBiNeCmOCqXTRrZuHELxnskdmE2L1rSklRYV8iWtBbzMO/jORaxviM4obqkCJv1Ug1Wki0RN2giZs+aesXelvmAxGx8hlfqKcwXB4YYhh+a9NgxNfTCif6zHHwwpacEIxwf21gDxBt6c6IhDLMESw2qL05RW7qIQpZg9x1+InzOndTkCrFSe0UoKZXnOHiA+3NGzeUT+Ys=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(6486002)(2616005)(36756003)(26005)(4326008)(6512007)(2906002)(83380400001)(966005)(508600001)(8936002)(8676002)(38100700002)(86362001)(66476007)(66946007)(316002)(66556008)(54906003)(6506007)(33656002)(107886003)(1076003)(186003)(6916009)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5krphoEBqrgods1169VE/37ARS8pl8vp2c5GAEXEMzBPPIqox7K4T8/XPfKt?=
 =?us-ascii?Q?OiVqTdd+lYSZITXC1gvy52zaSGpPv867K+5V/LoZl3bR7I5P1+0fKjExx9m/?=
 =?us-ascii?Q?GDQ43O/Lt40YeqsgJCJJPIW6joLbz3vtlmKS04hKW5+7CwV+g6xqELZXpJPK?=
 =?us-ascii?Q?f8K55/04dPBArsiK6Q7hlUAxczijtxBIDNbm9lmtmpVrf9L/rjS/X3JJl1v0?=
 =?us-ascii?Q?9gx09D7cFybeHT088fV2qcow/hapt1CVHAnpkFtAkrJkSRx61xqm5j4+BqBM?=
 =?us-ascii?Q?R27zjbHTN87PEubENMHb+apYc+KwLN/z/++/1bvprYmMphYEma33GmlIN48a?=
 =?us-ascii?Q?mIUgqzRVHUSp+4Ktdzb6zEzYGSzhriPuvNDFh4pNDz2+POFKejMSgRrGuHRu?=
 =?us-ascii?Q?6BqeVW9dISOI4Yej8qSSmKzp05geDwpZ3V88A/xjH8YiiBv5VgzzBAJ/ueeB?=
 =?us-ascii?Q?5lk4rPfpdM90eB2+t/V/New6fKHWDnYv/aCxgQkI1vPqqCxjfzfCyG+Si3mO?=
 =?us-ascii?Q?OmblsXTmJjRabQB+MsSpPjqY6mh8V0vyYmPZJr7gqtiITn6z0zFhyTe1tsP9?=
 =?us-ascii?Q?RFw41aWQ+zb/MXR9tG4ytdaBOW+qRRy4Pb+HgkRPzNcKkLKXs/3gU8+wM/jD?=
 =?us-ascii?Q?IZIr0Wclm5gNYeqRbx7i/L2QkL6QxVUZKWYS5yZ8/ZTEDG90FUEz/MtlXN1e?=
 =?us-ascii?Q?Ka8dDQEC2vzpIDk8ectiYEQXC+NXm5OPqoHO1ouxC+B1pXKfWrLf/tPgJ3HW?=
 =?us-ascii?Q?NyL6UE7ngZO1f8vE5qhnYUq9S9XouZ9I+3KPbWVIbAb+uu2BBVS9vK0+yOOX?=
 =?us-ascii?Q?5DqDaAQDe0lqmxf5/BkXjho+UKg3NmblqzgFtDX8ZLvRu/sO4S8Q8CX/vQPg?=
 =?us-ascii?Q?WGAFxIzYmE4K5hKfMcQtd0PS0EV4tp+kvvGQ43TyXItx0Ozc2+auxpLyuheu?=
 =?us-ascii?Q?3fKsxbFnUTt8Jx7y+pk314XBy/uX6kWBTRaPkhLklPf4qLhPmEP7L+TNpNfv?=
 =?us-ascii?Q?SsVPaLnJli2iygPY2+Si+1YrJUqGfQgtWlolMjZdg7I41W7PNT/2Oh9ULVFw?=
 =?us-ascii?Q?BFHo7WYxvpHTnP23+YYXn++RbuXqAb2JyRjlk+F59YSN9OIs7dWv4eeQH+06?=
 =?us-ascii?Q?jztz0LYvD3tD4myvzpL7Xugth5vfq6StiYVB/uC+tMdXPtHJTZ0K1b/tlLvq?=
 =?us-ascii?Q?zOoqK+ZxVgUDgfiyCYrneVftyUmFd9IFDdgvmnPqlZHX2Sa/5WzURRiXTkxe?=
 =?us-ascii?Q?nNWDEtsaf48sLn2Up+HpTT8ppDgWrHfrM3e+bcd7hVLY7u7DefaU8vnNukwm?=
 =?us-ascii?Q?PFqh3OsiTq5N3nu49hZ5Xu1m266KUGAo03Rsr3fCnH3lAUPg8E5jQtMEcLsY?=
 =?us-ascii?Q?yw0pZlq8XBRq3N4jgKfYuEErB9KUiK7DHMqSGTrCNonepZlLe1Wh0IXwi7Kp?=
 =?us-ascii?Q?G7S2mXHi80oUglN5dGWTjJuBLJWiYhTD6bYO07W0apKpKx28gyXfYvA9wHGI?=
 =?us-ascii?Q?1xDGyebvIm6/fwq4jryEUD2AUJtTQwu8s5mez99P9sRLbeE7bxN2xqNGXS8A?=
 =?us-ascii?Q?4C9EECORNw2vNvgL01gCKPaE6FmTQyJWARb9t0Pj6VoA4lcr17LuYBM8yhmJ?=
 =?us-ascii?Q?hpU1CHH5vYRcpn5zIACI5SVnphIy/gWxrSh8yxMLQjqseLT7b7aD/Xpf1H6Y?=
 =?us-ascii?Q?gQ4C5KKxJc+2tt0lH+g53Z2QX31/T/lXnIh4Asaqupmc50jXv1nTibKNFBDt?=
 =?us-ascii?Q?zkaJX0WSfA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2f8829-8ea9-417f-6f80-08da19844d37
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 17:22:05.1338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /jnZl2lH0Xo0TqLE8Bh/8Gr8Ksvyn1ugb/Wfs/Sy75sBhTa1OSDi3Ei6MHXOikNO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2952
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

On Thu, Mar 31, 2022 at 11:16:34AM +0200, Jakob Koschel wrote:
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
> 
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable instead of a
> found boolean.
> 
> This removes the need to use a found variable and simply checking if
> the variable was set, can determine if the break/goto was hit.
> 
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> 
> v1->v2:
> - set query correctly (Mark Zhang)
> 
> v2->v3:
> - remove changelog and link from git commit message (Leon Romanovsky)
> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
> 
>  drivers/infiniband/core/sa_query.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Applied to for-next, thanks

Jason
