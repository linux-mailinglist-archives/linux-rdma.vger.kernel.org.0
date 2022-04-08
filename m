Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FAB4F9C3D
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Apr 2022 20:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiDHSJI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Apr 2022 14:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiDHSJH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Apr 2022 14:09:07 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C872FFC7
        for <linux-rdma@vger.kernel.org>; Fri,  8 Apr 2022 11:07:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrW2hxaodJ5O9HkmROnQM77NV/02ZDHelzlG+QLd/cu+wHt81X4qg1zQEala315vQjx/Xb+jok8Jag7PIZOfiDpPFeu1sPKM6VZR3HtaqjZLB+qg5SBxBeJPpCERvwHMJYsXzAyTjCnpi78WXVShf/0a3K3FsRJeGR9ZI0FcM379MeEPQJh8KOM06eK6DwBYT+jeUrttqTasDfodwJ6YciHzm5LnHCkKiNWksrkFU17OEVkHpYj8h+luMncBP6U8I/svmNjR8JWhgLBZRhVO8hHzuX/h3d1QIyWofpyYH8/yL+q1xI+BYvDCCbd5Pg+HKekGqS9NLkBu9iP4e8r26Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hk8sBH+pjhrqItttmvPpke9JIM9R7hTWAK1/TTVFkpE=;
 b=nB3B6DaJhkyZ0L23J/y/yxNh/NkDkknBZBK6Z3B6StQb2neLB0uNvwdDj5VjVFKGE/h9e26IvSXpkRf3WkG1sbrfuyOFpzALeWAQKImweCKm+fJyJ9VWXhifyyWBpNrUSU+qhtJZyDlAb76AMEERhq6324YWLxbaDXXcNYFdSPJx5DoVQjcqUYqPJtdEgrpUpAHT1QDKHQ40zxvwEHBcoMlgp0MAk1MgWfd0OBTLW47uT4q6NLW5uM6GH+WKuQQhhDpKsnQz97yMuSagUvbY4ShOL08UzVNGGyIJds5igNFNMKhbz+GMn+dXmQPzY8EI79Dbll2ucnD0DLSwk4mD7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hk8sBH+pjhrqItttmvPpke9JIM9R7hTWAK1/TTVFkpE=;
 b=Lq6Wc1Of9g/Iadr3dxpxSBcImrXpYtmlFR0+4DqGUBSKGlVBKhbP/xSvQFBjHGfo3pBNa7v7IAAKQZ04s5mPAjH3VBkjIrp9hwNQD6H7QY/rBzalAwJouTOzeEh7EPygSNwti50hor7eoAkY7ywgWkuJknsbx5EEf7RXUIiya4rCGwpTQ33fr6DzrbplFGoKL8Lm2Zl5PvlP3wx1IC5rRx9jx8EDFLTHyGOayNkI+6xg9tvKweofAE//vB/XTlwMbVH+LwUchpuBtTn+pAe64MpnV5wY/q2va2EjEfy4GpXFRUHwUdhvyFUXq7Fveg8MX3UH27l9r6erfkeYa/HFPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM4PR12MB5150.namprd12.prod.outlook.com (2603:10b6:5:391::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26; Fri, 8 Apr
 2022 18:07:01 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%6]) with mapi id 15.20.5144.026; Fri, 8 Apr 2022
 18:07:00 +0000
Date:   Fri, 8 Apr 2022 15:06:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v13 00/10] Fix race conditions in rxe_pool
Message-ID: <20220408180659.GA3646477@nvidia.com>
References: <20220404215059.39819-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404215059.39819-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL1PR13CA0320.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::25) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d516bc4-de7d-4553-3b8b-08da198a9414
X-MS-TrafficTypeDiagnostic: DM4PR12MB5150:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5150D5C90961298B11C945BEC2E99@DM4PR12MB5150.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F9OOF0lm/92yed6N0yqQy0VZsGdk0RGXO6Zi1+y66NvVC+pWfrK0+IlYJT8kRvAOC2cxxu2mbVVoVyUCawTdMu/uGayfiXtmKFWbw19BJZEd3OEg6gCZwRrhlUDWSH1Di7Fv8EzfkJhwH9d+ktZTusDisAHBqRsAhhZRNOX3oZcleuyb9tOPSCXsFyz9YvNAN6KE59a8/atZ1bfSDcESJRUyRH5Nauz+EAmDioJiZUcgmRmE5cOhKnv2p/VE9a0Y9RVtac1eq7Bp9fKIUoObAjucq1UB30M14ZZ3IeMOOSpHQE4aTMKxIwpluHDAPssRtfV4N3ytbRIsue2u/pDUER7f3q5Dyoybogj0btmh9DYvqaXGOlw0biwRui3Dj4cnjbAgmQ7OiRa4+i7QTcQw2D1YqkvYO+IfA/SIBDzdjselUehT0jeJjxLL7+g0N7+19yv7TLbyw4EHtf6VK9lI6Z+cCbohBy9PJ0PhTiqYcpzBxcWKLNIgSAE9xpZs5BX5ssEQtkxs6JBjvOyJ67KfGFOGtaT8qJDRrhcHa4tqHgmeklNuQRaUzuNwjQ84i4wVtFZ5KfqqkJ9ikgPV6XUyvRWUH/ltIs0YcvNC1XX2naew37DvuozlkYCIVOG0gBq9cP+/4rG5UELa0JStb3E+Pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(2906002)(86362001)(38100700002)(5660300002)(186003)(26005)(1076003)(4744005)(8936002)(4326008)(6506007)(66476007)(66556008)(316002)(36756003)(8676002)(66946007)(6512007)(6486002)(33656002)(508600001)(83380400001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bT2bOJ0W5nHzpmC0TE3wd6snuAFv5cHLSIkKEhaVEQEAlhw2d6X46sjU8BsL?=
 =?us-ascii?Q?iWM3oVMZz38E4wkh4OtdR4TCh6VxG6vVD1/soHr9qZJk68LdS3gQClDhH930?=
 =?us-ascii?Q?Buh2P0Tqu62yJZVQtIzHMDx70hPl6zEAmEuqBXcaNkl+bgiPKX+yZTXgSMwJ?=
 =?us-ascii?Q?r8vGOzKCUiELlUbJ7fHbE+jCcAKSbvE7CFp4+QfiBujis1ITdD+Ppj9Vg4WV?=
 =?us-ascii?Q?TWdXYJBk+QBe9LFVaWE9gLDZh6mBi83koA0+D2szwdZlF5qFd5RmYfdJmZ/W?=
 =?us-ascii?Q?t2FFalH6oFiFOjaOp36nTHHpgBOeEmZo9lqYCfjx5H0VphKC1BpR+vcW4+th?=
 =?us-ascii?Q?PTs9cRe68Cfpl9XgQHykkenyegXk0VIMdJ3xmojpFYNcYdNH9Ur6eAu2lkq0?=
 =?us-ascii?Q?ZoffoYqYF4exBK+OGBsk90am8bT4osP8o1ropLOPYTVasiI5EJMi/ZxwsPDY?=
 =?us-ascii?Q?ySXyI5+GHrF4YvCtZmqNSUVrlTurp3IU1OLmBdie2idGqaAnX/T9/SIVTpeU?=
 =?us-ascii?Q?SnlvdGfG0TV+APRzO2h6r/CdP/rEbQaYiAkBM4l2ZGqJWVsSM+FF2vnUc6ny?=
 =?us-ascii?Q?+pAr6CSrbnUbA/5gq7XzzpJagfpM9QPd5Mb8ItjdFWC8L/1guvWnJIYoIhvb?=
 =?us-ascii?Q?pyQabHFC9ojq9y143bFIrhAMYJ50F8TzlDuOc0vFMW8wXhJ6ggkkw3EQQbgM?=
 =?us-ascii?Q?o+7fcnDnKiQvD4fceeqAgCAhcndgAdtsyYGYbqouiUZcPkDrmgeuQw0n7uhX?=
 =?us-ascii?Q?sXQTOQXkTvrPzxpqF7BOV8onKGQtdseGJ3CDyooV/v4mUpYx3kF+PYv5/84X?=
 =?us-ascii?Q?sgMXVwAkdj656BPNMDqlBci30i9supP4AJBa4GDqS9lhllfh+LTKlflQU9Xu?=
 =?us-ascii?Q?bTFiwAabkWUEdVHABYt3Rrit5rdrHVR+xjchT1ZxYFguiHmxMSoIO0oOQid6?=
 =?us-ascii?Q?BbPyikR7JMZw5TEUZfczGlecO+3rPpVCO9IG2z3WsKw2+TQSvn7Vcr6ClIkL?=
 =?us-ascii?Q?IrEGMGv4UZkJZLMgzxCqH+DOCzBTvfa3AJPslbrLv5Xn3KEyNGQTilc8ueuL?=
 =?us-ascii?Q?QPeB4OMssr99+MAhosWoSg4eVq44+2xeNqCR70mseBJMo9iI2XVBfn6XTrgp?=
 =?us-ascii?Q?d5F/P40CN/4YQ2gR3zxWhg0qjyJ7LgyigAiqvMdmgRYQWwH2qxAloNZOUZvG?=
 =?us-ascii?Q?HRNK37atPp4nz/Xxk7NIAnFqf1YLPQQHCNEKGSur76w8DSbVhKgdFkC5LzCU?=
 =?us-ascii?Q?K62oHuNCY/+jf/J3jKH1BioRvbh5toae/SOmQGfXoFrG5IFfFOkpDnnuMHrD?=
 =?us-ascii?Q?ORZC2ICD0KBQX3W9xfX7+jRfOOmUWQuU0fLVM7DVN98trY2UT9IPtg0pRafv?=
 =?us-ascii?Q?psZp+gc2PFBI9IYxXXFBvX+ta/0pxMTKoLF3/xVbbMy0WIAz4pO+ZSSvGZwj?=
 =?us-ascii?Q?MCdN+3MzugBNoRbIQ/rLKQ0ZhfCspkxfimoE9NPZ6QguXZ21HOtWKVCxrCXF?=
 =?us-ascii?Q?OsZg0tPQSgHdMkqENZzQuC78sS5MjPeEUVK/+qHq2lZjA4ngIBP9vDcKxVSR?=
 =?us-ascii?Q?ogSJAxRANAcSnfIicQbBO4FPTzDfp/WZyuIxM+Nd+RZJ/JJdRAs0xvkLvQYv?=
 =?us-ascii?Q?j3X8Gbi+yX35O8tlExdhdWaAUIdSnMqc2ey81gv7rZTX7KVMrGk2H0TywEBr?=
 =?us-ascii?Q?rN4gxsXIISG7gaPnkpODXHcEcInLNcsWhDR8ho6XAuMxF4ouGEcLLk4RxZKi?=
 =?us-ascii?Q?s7btVNNm6g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d516bc4-de7d-4553-3b8b-08da198a9414
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 18:07:00.8600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l307QB82IyfS9WjQDeX0zBRGGLdRRmTeW+TtrwoeddhCNlvASWs5Vr87SwY/qTg7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5150
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

On Mon, Apr 04, 2022 at 04:50:50PM -0500, Bob Pearson wrote:
> There are several race conditions discovered in the current rdma_rxe
> driver.  They mostly relate to races between normal operations and
> destroying objects.  This patch series
>  - Makes several minor cleanups in rxe_pool.[ch]
>  - Adds wait for completions to the paths in verbs APIs which destroy
>    objects.
>  - Changes read side locking to rcu.
>  - Moves object cleanup code to after ref count is zero

This all seems fine to me now, except for the question about the
tasklets

Thanks,
Jason
