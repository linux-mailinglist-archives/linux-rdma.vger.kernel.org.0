Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301DE74DD2C
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jul 2023 20:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjGJSP1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jul 2023 14:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbjGJSPZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Jul 2023 14:15:25 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03E818C
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jul 2023 11:15:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFFLbcwY8+vSkkVJI/uTBnP39sNpKuV88rfy+UzykAuBpAmgGzCM/c4W87o4LJ6pWZr00QYDnga8OtHrT/Qh6mJTGelCYznjdj4dOfAY2Xmt2mfkX1O2mWrNjvhqjJQ6EddDRXTczisrStdblbemga76gTSc1ukzqO1QOUcpxXvYBIV40xTZ+EkD3/uwGm8SNAr40mxEv4BfNcTwtiLCWbzWX4P2TWk3yiywmdWKWaqMX0R0KQCZD8guB75K0NN3qOp1u9Qf/oU6u9bOLeNTnVVTRDCMuN7ocLHYqiJ6xroz03bYmFX2kK7ss+5shV0Ni75nLZUuoFZTThs9JtXyqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r71a1SigA/Df7kw4Qvzp3XuR0L2JIEBDZ0PU9N/fm/o=;
 b=ZZM83a3XoIP8zuhMvuiXzYb6oiEiWpd/kkLH5A0ExLmADgLse47ygROaUyH2uBCcLiy+ZyJmrjIsngx3orZLUH5YdK36CB0xk5OO5goiEDPy7Eo2OAA/nao82f5+wCMjE57f6XSDR6A0H6bYib8IbQ7oKtdoycOVZonvRUZpKUjN53Aq8BMLOqCzx7DJckTPkwlBdefdNuewwLYM6cu+FQXKm9IH5ZCOCnLQol2lFoP+5rJlqZFktmGuW/OgqZIaG38/a23MRm0FZL50ct346LYu3MCpyoay0Xpd16W6Gr6hbkTOP8GBiObbk0e99drGN3CEIesu6UaYsg/tw7s6vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r71a1SigA/Df7kw4Qvzp3XuR0L2JIEBDZ0PU9N/fm/o=;
 b=kajebUx+gNThKmDyd5VO1Oso1M16CSfLuIC1jj/2qQ0ZMIw1RM+mMzzqyz1XDFPLD+As2RsFDyhMwIdUUMM7qXs48/ftV0MiWMnNOsTyHfmKvYWm4Mlqcsn5AhVQKHCoye21z/WKIponf6Me7ctgtktbWbsg44n0qFWA9AAm0geNo9zpEZtXxgFWcdtpjzO45knpb6HefcJaUkWKGE2564swOrRwj8DPs6lKHGSdwayUCnFrSG2cuYA/zqjIaZNxjdtEkeDXDYaWevmjGaSY92ctmgwkU6YJ/KTMErNtKlC6dZqHSu8ieCkxirkUpAc4OiQEM+IGHcWM5++T33qlJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB8493.namprd12.prod.outlook.com (2603:10b6:208:447::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Mon, 10 Jul
 2023 18:15:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::98a5:ba0f:4167:8d53]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::98a5:ba0f:4167:8d53%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 18:15:22 +0000
Date:   Mon, 10 Jul 2023 15:15:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, frank.zago@hpe.com, ian.ziemba@hpe.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/rxe: Fix potential race in
 rxe_pool_get_index
Message-ID: <ZKxKuaTRk9a2hM/+@nvidia.com>
References: <20230629223023.84008-1-rpearsonhpe@gmail.com>
 <ZJ4RXctDIYEhjnQ9@nvidia.com>
 <f48d9b89-d80a-c191-9618-102957868429@gmail.com>
 <ZKw2NbcUhCo5F2+g@nvidia.com>
 <8a34d5b4-1bd9-c2e6-aca2-ab34f4ca1e2e@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a34d5b4-1bd9-c2e6-aca2-ab34f4ca1e2e@gmail.com>
X-ClientProxiedBy: BL1PR13CA0229.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB8493:EE_
X-MS-Office365-Filtering-Correlation-Id: 063bb596-7cbf-4304-b8e1-08db81719ff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eSXbqfOEa6eJ5QJuGQM8Jv8WSrTS8C2Ukvy2fmlBogvw/v6VYglIlNxg0ic46/uM8cG800txMLUOFyDCFobW11fNyHSOu5s4Z4bR4IHtwBTuFSTog+VOlBRsd6IRfKROMudGfintUvdx8ZtuUx+2/h1yZs5pvL5KQ0TGtSj5RKSBvFNi0hA/UUeE5iEQ27s4dNRhePSn3qSzWDiOthZENjmLGGNSi+1cyKKCrvCeSDnAMeHatJYUGVjkRfpOrqzbPP0rgXExff6WEspfOTdM1WnuqT2lRIvAL9nd7YMlms2+RmCZKiJf164O76zc8NkuZEpmnYedqSzkRJkNxKpm6F4cs6X0+V4x4WUHGPB50ZM4lGKaOus6FVG+TMR/O9t0n/C+1V4ND3/1PXv4tE0yvN74I9Aco+BbLOvO4rQmpfHRBTsMrUmJqOAXS5mEdSCMT+WSx0Vy29swv7J67BJUSzHDGoOMR62AfhLWkZzICRA3gALnEntE2ZVbCwwylMNFQN2VrwuWSi7DZJaQ0FU19FbKE6QBLA4Nx7A8dQx2QPMGYvcIMaPOOygYvDpoOef1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(451199021)(41300700001)(5660300002)(6486002)(4744005)(2906002)(316002)(8936002)(8676002)(66556008)(4326008)(66476007)(6916009)(66946007)(6512007)(36756003)(478600001)(86362001)(38100700002)(2616005)(186003)(83380400001)(26005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7bplkeRAclqZGUxK8KBDY95H53kiMFnnsDD32gdtm1GaTQ25A6mpinJ7Saaw?=
 =?us-ascii?Q?ZCW5fhnluye5GT9T6fWcpt1g2daS9CpWgEB2gOVJz3LEQB5x4K8ZvrOPRoZA?=
 =?us-ascii?Q?3S71U9mc2bG6bkwF2HCyi4+NmnU8FZJtnB0Mgyovx+wgfA5SUQmQH+bC/wBG?=
 =?us-ascii?Q?3GOryVLIY6ycwhu4hm4Jgvxu8ZlN0/gvkqtvPctLf4Tndqmv7JRz/3put4wt?=
 =?us-ascii?Q?nXzbINzov55HErBayoBlmEhNFuayjid/tS8KEwhKL4/WtT4nNL9eWssO731L?=
 =?us-ascii?Q?1DV6X3wC5lbhfn/eHdbOOYhFvCVAg8xoEeOsK19oRNHCVb7wg6yA7DSKyLMd?=
 =?us-ascii?Q?/VVGkOSHCsl8y1MDGgAQhpWumB4tfTlDGZouxrVrPR3uXOhp7tFs5eXCzbig?=
 =?us-ascii?Q?W/OrtKUaK5pKYGpKd1rjn7xy+Tj9vPaS6M8b4neDpRbD2j9O4+3CjDnr5SZB?=
 =?us-ascii?Q?APTZxl0fEr9AmHfcYd2GCScIzwy7aaMLdatp+mipA/3IUnthBrrQaz6tsOKj?=
 =?us-ascii?Q?WLj7isrIIoP/opusw5aqltFcGoA/Vnn9dRvPRkFkgbWok3BcKluLIEbV9LS4?=
 =?us-ascii?Q?sXTLvI48ZuoHNtK09+jcBmq1O7LOy9xDLGNkBZUWCiAX0MVKKBV4/7pBW+8x?=
 =?us-ascii?Q?GceRbxiWdPUgCmUlWJitMk9FGYt42WQZrQTNcOVWYLR5nm/+vyCrw1vBg3mE?=
 =?us-ascii?Q?LH6JyKxjPJ+ejO96E2LAuTrokflbPv8Cr6HNM5Z/T0/ttyX45JZooVsjPh8w?=
 =?us-ascii?Q?vMfd5HMQBTxUj+Jk7v7XhPk8GpGXxXzdPi9709tZwKfMtMDUuBYy98TstsyI?=
 =?us-ascii?Q?kkEoxf+Cm39qcCZuLojrpZBdzOy9RNxGMwBMqbYBUmu0IlkstLOuSgiEkZ66?=
 =?us-ascii?Q?0m+ZyV3JMbotL71KbCkGYlnB73bNwjaxWu/Z7m455D5SuSMRccWwKAtf40SF?=
 =?us-ascii?Q?z5RcYg6psSRuBKIuRm5ia47rb253KdshyUNH+z9cu8yPD8Xcl5tnrGHmKtR6?=
 =?us-ascii?Q?rqAcUy+WrQEV9k0a7liHP676kMbdGvwuWcKHrnEMNzMyMkZd1wzjItY2HmSB?=
 =?us-ascii?Q?8XcxLbnxUNBMHhtrSwhzk0iel3B4LtdzCrsCvLtWNeSSNaD+7xtwjSLc6wv9?=
 =?us-ascii?Q?mptkyh0M8KELm9enlYDakWwOjhmjEsl63PcX6e+OGz1pwzzFHhDkinrIV0e6?=
 =?us-ascii?Q?wJEWp4XxWN4uUZJ+Ftd200XX66vmuCu2q9Lh0yuyLUtKE01tP5kASQWp3Cf/?=
 =?us-ascii?Q?pouf9OLZ32tPEQoNZCgCqcVFQ0qo7If0e+NygPUuGEL9wyzq6utPXUU9/NG/?=
 =?us-ascii?Q?YOJm2ysPbjuQXdU48as4v/AUSXb81g/4Rn9bTmled9WOHsK7exm+FbG+s7Ae?=
 =?us-ascii?Q?KMl3gNTpkrQOI6oQdu5OVnuTnwRP1PUeVXoU8Wiro5va20BbLAJWsXetNcLq?=
 =?us-ascii?Q?h42G9JjgvMOnwhvz73FXywTpuTSXQAoeIRggW/U9EFEUiqwzkDzvOAlKMxkr?=
 =?us-ascii?Q?JX+fUxC+upClX0wjx5XjW2xGI0mkO4VPuSzNCM6EcsnaP6amBc2xutqgVvKh?=
 =?us-ascii?Q?ZKxptukOu6+bZJV+er97CMXQdt10J4dUY5k70SVi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 063bb596-7cbf-4304-b8e1-08db81719ff5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 18:15:22.0854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y3DVTHbyQyt1PO4wQK+C40y3ZjZAvv7yzMeKJFb++cIFoVE8IbbvUmbbvYejUYOo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8493
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 10, 2023 at 01:11:28PM -0500, Bob Pearson wrote:

> New news on this. After some testing it turns out that replacing
> rcu_read_lock() by xa_lock_irqsave() in rxe_pool_get_index() with a
> large number of QPs has very bad performance. ib_send_bw -q 32
> spends about 40% of its time trying to get the spinlock on a 24
> thread CPU with local loopback. With rcu_read_lock performance is
> what I expect. So, since we don't actually see this race we are
> reverting that change.  Without it the irqsave locks aren't required
> either. So for now please ignore this patch.

Well, no, you need to fix this now that you found it - you need to
make the core code RCU free things that rxe thinks are rcu protected.

And maybe we should just have the core code do it always, we've wanted
RCU objects for other reasons anyhow.

Jason
