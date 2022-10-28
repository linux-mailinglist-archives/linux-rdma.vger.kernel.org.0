Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5775D611952
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Oct 2022 19:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiJ1RdI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 13:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiJ1Rc6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 13:32:58 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D09969EE9
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 10:32:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/JfdyeHtOZWw015ZOiH2aX18keXcof4dItOSsIbAGI1X/hML0Gy3yqWc6alS6Vy2HGxsO5Ch8oKif5iKHXKHtzRfhZKHP3Hn770p2wCMPyEZcfvdYj6f1bS9b5AIJyBT2KA5ZUD6UykQdoPAiT9CPVXIsrlVvXvlCuEZLeFHslk0FuGPanQKWkd+yyYDTpv222i038XQvKN0P+xPyDkicPNL+VuTFwNDu5ve0UP65pYc0O8SeuMNedMa29ROmYlLbqtpaAIeaxRNY7lmJ4agkx6DLliAZmDr/NDvjvgt22C49t1P0nFwF3329UHJFxXzD3IdhYwN/pgM3FPzFbXWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qO+iJFiLq1EyoUAlxIVm+BLsAakTePZ17tvGjsjTmwU=;
 b=N10ZH8IikRYY8XsswcJIfV1TqXb0z51bcquuriVpa+4HBnlIgNvoESbGYa2igC7odtO0sIxYnSSE/EOIri/aRCzOV9kPKdgewRAzH2w5qeHprl18VUp77X6DKQPT6oyHdlbVHHTVCaHVDpsn8pIlxr1V4fePOgEpMHYeX0yZnCCP7vhx7Fmb5+h2ChBtvPXkKWF8Qi+7Q8sYFpbiEhG4IhLJ3tnqZmzg/W4lwFEK+iqe5tsJkVua1pjB6Jo6dcdFmVcDURpTFrmhxe4SpZ5Cvtxn7YVh6C2SHXhKBP9MuKp/cYQikslh8Tu48BMy5b4q4F35bjXyq0JBZLCInvhQNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qO+iJFiLq1EyoUAlxIVm+BLsAakTePZ17tvGjsjTmwU=;
 b=nW4cfhOBtnzkiKWt+p9i8351qprsK+cwXtacyBMwNGz5eFOlrMldGfWB3zuyryXZZRF3B9kyomi1gXfXM+xUrFA75lhv+7Pm3IaG8VVYMbmoR8rwLqKfwSbbL4OOhffMZm+MGTr09+/W46SO9q7NVa7HSVc0zAZ3dE5qBlEv/jDYgRYEb1YSkOANM0KBLJfc1E6JrfZl/M6QQ0hj0LrWLiXnowIwmZ49aySZn1L5JjM7Mb8b9gySXl6EyzVZlsQuB76ybte08stisojnf1SHfXO8/Z+I3E19phSYODyy3K1FL1+tj3tqsdX8OS01bs/jB2l2YqQHU7PjnOSc823iww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB5408.namprd12.prod.outlook.com (2603:10b6:a03:305::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 17:32:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 17:32:56 +0000
Date:   Fri, 28 Oct 2022 14:32:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/rxe: Convert spin_lock_irqsave to spin_lock
Message-ID: <Y1wSRyFc809rFohX@nvidia.com>
References: <20221006170454.89903-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006170454.89903-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL0PR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:207:3c::41) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB5408:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e9a85e1-1fb4-4d47-c7f0-08dab90a7338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8CKBVq4GiNTJ5j7kqAyIMBSLvwE5KBfW4jiD9x6MzhwRfUj0kaWjtwAfW0R6ADdyc9gqy78EzI8ywl7ORjD5G7La1MDePVvyX8jibBmNrFeeVLpramLuDAxPajCZMa28C+DqUHgONO1yeY4jVw1XF7Rq1fAv14chVIXGeaJBaDudLds5rjEdigTtolgjrrw/zQXyo/4VKOXRXkZc/f8CTAetOMJpHqQhQBER2PoScbMIsbfhkxkcvNjG6PO5jth8HHzsiRUigO7H4eoCbCRu2xr/ShDM++HwU2IpBw5XSTdIRr0XrnjijpAmRrhKaZl3qsXhuyF5kihTeB4rbp0X+tcu4azkJs+BKskzYylPjLh27tQRZrG7KsTZpYfuAYKWvOvyJSKfjtB1eTw2V/CMalGa7cH0xSg715l+b7NW9dC3zzSIDzx8EVzTK5Eii0LWKm2yOXsfeHbz41eO7mm/DjMkEcB+JfE/mfclJTLPfbWrKaDHCDXzuF3HBxlmNexKWxLCbwJ1ejiZi99gkFH4VQhP0Ajgx/LcKIyXL2CcKwS/EPRAv/+7BnaFaierq3czsLY06pv5v0Y+5d1gVPHOv+7s482EbWWS4jrYdeTcbVDCjxr/b9Mgco4i9GOXdsfTuZ7w2Vqnskr1at+Fk9Nm5tSsOmPWg13cb6JTVuy0hMNFb4NAMAXDjUF7yklOae6OCvffwf0Zs38dplVkiwc2AQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199015)(86362001)(38100700002)(5660300002)(4744005)(2906002)(6512007)(66946007)(4326008)(66556008)(66476007)(8676002)(41300700001)(6506007)(8936002)(26005)(2616005)(186003)(316002)(6916009)(6486002)(478600001)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wjMjbioCZ6f/AS7gj9ieEtMarFF+RYLNGGDeM7vxFovctf7O79zBhkNQ+y15?=
 =?us-ascii?Q?n+nJ8zqt4yFcnjaPYdkmvT+U8pJOB/aIt67tetC+VOKZNM+AchJ3vhKeSvMw?=
 =?us-ascii?Q?5sLiaw2SL5QhNY46Zm74KPNnoCNrg+85E+2Ksh0yf6CM6VOF1faTE15lOFP9?=
 =?us-ascii?Q?xSmF0tpScUySE66blXVwZrJesgAupIjvktmXtJY70/5fVxm3ofjzLHZ0svsy?=
 =?us-ascii?Q?zSDJuxVrCHMPl4FEoqYjLuWKREUwYiYrf9gFS+KsQ+2Jqr8/QSIGOAPh3NLn?=
 =?us-ascii?Q?tkZnBaYfwptY+CUmmEdIieqdH0u+qI1TOOFRQ+nZNedwMhIvQMhgPFaeUiJA?=
 =?us-ascii?Q?UuEEeTT4JGbZeyRUlRQWBv8N4kNrMpJe2l7Mc9YpOFPi9k1rS7KYY9XD+1an?=
 =?us-ascii?Q?zml8lzeRNYFcjLB6ua6f0oM29b29cd2DsaRIRCC2HIpOrIaifp97F9geilIQ?=
 =?us-ascii?Q?fuhsui2GhgorrbwSD8yYKBtAVditJS/tk9OOVNtfK1Um8uCHoH2SqM4J6jHz?=
 =?us-ascii?Q?6rRc+0wY2/vt3cqLxSbao4vtAGsc+JuFyXXlkYzYtJdfaR5D4sjXLymnjAhD?=
 =?us-ascii?Q?i+mwutYYFNwdvCOUXk8PhehwQSK3PZFkHT/KuJbLjNJP9frZJ6MM+YjsL1fc?=
 =?us-ascii?Q?bE4NvHdi4gBiGhef8ipyCpCC9nvhGlVNpggOCJqR12NCt4pNc1mOAKXcFJ4O?=
 =?us-ascii?Q?wCdFKAUWavcFegj+75wngtcfA08EPTSIYz9ztAvLGG9BbNCobzn+lOgtJgxn?=
 =?us-ascii?Q?satin+C4IYMa+WTjYNiUjf3K2m2DfcIdA+rVYygOUwCDpxjioAnzuKSl9lsC?=
 =?us-ascii?Q?AJDWEhXs9bPrct4eSBHckXrwePAsOrsq57b7D/5y07+/PhgDUqaBoNNhhngM?=
 =?us-ascii?Q?rNR7QSli1JwsLghGc+Kgiu/2LeaLYqj7ChB1v1tlFbTnGXoKXd1nCX7CHLu4?=
 =?us-ascii?Q?Gni1tvRd5l3K19DPIpeioLtqZd4GjhP8QLkJzxOt1BPGDvo3OPR4T289OjCS?=
 =?us-ascii?Q?Vql7ziO8BC3D/8MvU0Cso7fkIi/JJ0ETUKBw6HNS1/jenfVJE2lDQ56zJ09T?=
 =?us-ascii?Q?CfeBp/wkwELjHpB7Af1Sc0X0Tvjw4/g7HtY4DlZko2ZLRslkE2axvnwhXiWa?=
 =?us-ascii?Q?NLx+jHY428ptlfhfxvfqq1oY2TuMEmNXxh94cHjdBE6tynrsYgxjMKOPJNOB?=
 =?us-ascii?Q?eVRHOJeBSWiBzpUvDHjvvlVA80YbUxBC6IdHe7w2olFjJpG1HS71A3uR37e5?=
 =?us-ascii?Q?8kQMBMCoKziTzNd9XK4a3xrT/SKkGbxPSTH8jssM3W/6Y6qgK6MYNHPmcEeG?=
 =?us-ascii?Q?Tp9Y0tHoaBZo5nmMyHTvYO5rOBLT5LNwPeafTcl+Ca8sffsBW6HbVLiR7Df7?=
 =?us-ascii?Q?26NOOu2StnvMTygnkPiuK6vihP4ggFPflB4ZXgHRmtRsw1Q43bGFyQPl0plo?=
 =?us-ascii?Q?uPQVYqZ5TUAKDISC9S7JDNAWD2ZOr4baq4UtyDzTNBra8cbPwJgJbYeBoGt3?=
 =?us-ascii?Q?sFQ27L+Pvu1jY4hrxnd4iLem/Qp14rEFmjKO6rwRvkHl/n1FIx0F5+Xq0Mmy?=
 =?us-ascii?Q?DF1ZB4XriErLbA6wQPQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9a85e1-1fb4-4d47-c7f0-08dab90a7338
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 17:32:56.1665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ApgdSCt+pFanZbvKlawj83RfF5iRZqnTTVDUjQjYWezVMUsMYCyLibkTlsUe6zP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5408
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 06, 2022 at 12:04:55PM -0500, Bob Pearson wrote:
> Currently the rxe driver uses a spin_lock_irqsave call to protect
> the producer end of a completion queue from multiple QPs which may
> be sharing the cq. Since all accesses to the cq are from tasklets
> this is overkill and a simple spin_lock will be sufficient.

A tasklet is a softirq, which means it needs to use the BH suffix for
all acquires that are in a process context if it the spinlock is
obtained from a tasklet

There is a nice table in Documentation/kernel-hacking/locking.rst that
explains this.

Jason
