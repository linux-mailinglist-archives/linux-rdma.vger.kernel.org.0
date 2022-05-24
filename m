Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DD9533064
	for <lists+linux-rdma@lfdr.de>; Tue, 24 May 2022 20:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240319AbiEXS0Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 May 2022 14:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240216AbiEXS0W (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 May 2022 14:26:22 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F32D1D338
        for <linux-rdma@vger.kernel.org>; Tue, 24 May 2022 11:26:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMEgrdOteoxx0JEviZN+QiJtzx42L9nK0oIcx/12HcRLZk0A2Ni/iQIxbmkcJf4Gqj46MgMjatErcsjoNQzwis0cNZnByxZ7vfmgMM0JZ5lr+kzAm0MF6RQu75oYCo9k0BFUrHlh/LRSyGB3K4V4/unZKyzAz8XaZe8YkVzawqXQlIlCDZz5hAhdLRAay+61yT11+DmX7liH4qwMPbLFnvuRpF1LkpdmAthi6ZvdznW27U7WLoSrYc5ZTgjKuH7YDw1tDmpXan9/o9triZ9waa1OFJ7kiLlNV7okS+8kjsrVWjJyPdG6GH3lbplg67s+yVQTnrY2RwwQWXpMVNaE0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUkchF6KS8FKOU1P9oFaXn4aJkTMdwdw/l9QH6JDNTU=;
 b=YZ+ORYKUVhb1CE/59PP98+3vlAj/iOjAcAkES7GpVTQC5D0giz1Ywo3DolZARbssK7HNoLwIV27LM4ChiRyho/V54m8bekAynZIZieZ3F4lndYKRDUOVSMqDqoPzn5JiHpmiOTxCSVDd2dLa+b4EBuUj3ePqblpAKFaMsIlMcw/F2E5JPOGDe/PItKlz02OyGTnme0XL8+zWVEbWJl3WtHwg/sgaLemKaw4bCFE1mH30lfZPYq2qlEmFkTtXWBcnx4aWAAbIG3JCoszUbsAStlryGfHFLJSkxuMdsriDohXzUVQ14Lc0Ry3+ZvmU+9A3VyIg//lHRS8yVI8A+0AfVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUkchF6KS8FKOU1P9oFaXn4aJkTMdwdw/l9QH6JDNTU=;
 b=MVtav5X2aa6OyS2sVNLJFbSd2VvlvUoZ95XVUOINxL5BBchJYsqSjoyQDzEW6+ZbbXJJIPABJPD7poYs/NzuEdUEGk56IbhcVvQrrxp3gieOvutGqRVhbCLHiNirs0w26O9komzkgXR5nx67YAZnk1rrOkoYvCQWLuc/hb8sXFfozNAY3f0Rnqx1iGdPILLRwAB0IJZqHR07+EVKbM9BJvohhDSXxL2BtCAn/v+fBI+ZNwOu1r0HETdCxOcVSkoadFMevmoVtPOdK2K4IzVy/XDt0Kb1U4AHccav2vCO79Bz5YJK1qbAhiGd1KkiMbCIaUFHErvFLfWq8ItF4TDk4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BY5PR12MB4065.namprd12.prod.outlook.com (2603:10b6:a03:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 24 May
 2022 18:26:17 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%7]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 18:26:17 +0000
Date:   Tue, 24 May 2022 15:26:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v14 00/10] Fix race conditions in rxe_pool
Message-ID: <20220524182615.GZ1343366@nvidia.com>
References: <20220421014042.26985-1-rpearsonhpe@gmail.com>
 <20220509182353.GA927104@nvidia.com>
 <6012bc26-a2f6-c05f-a056-36aac02797e8@fujitsu.com>
 <20220524115753.GO1343366@nvidia.com>
 <ec2369b3-4dad-30bf-35c0-d45ee0a7ce92@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec2369b3-4dad-30bf-35c0-d45ee0a7ce92@gmail.com>
X-ClientProxiedBy: BL1P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::26) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa65afc7-26d2-4a61-ee81-08da3db2e430
X-MS-TrafficTypeDiagnostic: BY5PR12MB4065:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB40652601D10B9842515B527EC2D79@BY5PR12MB4065.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VGYn/LRDe7S2LvNjphfmDBnAfywL3Sz6RXB2oMRVeITwcpa1ZWwhaknwwkQJ8ccN6D6sZQnT89It6XFN39CiSezGkAUTVAi9owteXE/lDdMN3bwTr7QeKYbTxQzag8Xas7UrokHXOyDSfkaDV/SCCamcSRaWrJDe/LbHgmEgWwXVdnjeSKY2LuNzWxDaEfQvrdQ1kJNNMLfFqujADQNZgnJK45MIorkXHYcbyUcu37t4M2T1SGepTQ+v9xR6DLUJWBeALeiYXT57OeDP9qXxmFtOTTj07pe1Bey15MYNMyycoBNubyAEE33d34z+9b5qotLrXgoisoeqoZhw0ytqFzFsIiuvv2dnrFE8l6ToQTKw8uQP58IEY0mNFvQZLfj+1FJlrHiIcTtPE4DLt//3qR104cNFUMCCVFoudqGxb8zCWO12NjcLG460Xk1s4SbTjRbm54iWW8wZKOgvTAG67wafR1+kKdh/fJczBPnnE/xvZHcR+ts6LtCGXD8DHbc4SF8sv33GTyPzN9JgvpQa/oH97Te9qcxD4ONIR32RhiuuPG5U0BkOjr0FBL4Vlra2EIcv9eiqbxhVAA9+80/aLr2g+h2pybkFeq3BeX2myWa9gzo9TsjYZQ2L/AySFDuompr4weAMH4qRrf6+IGizCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(5660300002)(4326008)(8676002)(6512007)(2906002)(2616005)(33656002)(38100700002)(54906003)(86362001)(26005)(316002)(6916009)(66476007)(66556008)(36756003)(508600001)(83380400001)(6486002)(186003)(53546011)(8936002)(1076003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hp+RPpF1J62T+fqe813C+Q+dppURufTKSFUAnsq7DOFa9kA12kA6/Whk5swM?=
 =?us-ascii?Q?g3yUR187J6sDOjMDnN4q2dp50hgdXfwHMubADwgX2V04cnyaIDZO+PCpekg0?=
 =?us-ascii?Q?/NoOwY3pg0pJUAwtQFwnRon+CVbEetJy13XXcdrP/WDJQw39+9Q4pTBWazuc?=
 =?us-ascii?Q?+waAb7f2wCAAjeaPy3q/ZeIymiy5FK8v/SeV60YpOT8nigTh+wQHTXUTpEJK?=
 =?us-ascii?Q?5cDIL6umPdPUFEOHEXZb55gxnPVuyEF7RZmKP67D2cgk8SkPZ7sxR4hh4jK4?=
 =?us-ascii?Q?Fzci6yWrhx9wGdE0zEidIt2SPvAVok9c/5qcSm1NOLc5lAPTHjEZdNAI6Fak?=
 =?us-ascii?Q?MUNCi6wUpyVQLPm1DULOMxVijbB7qGbOkUnb6n40h3Ul30jnlMaD9wrupmgA?=
 =?us-ascii?Q?Q/G3xUBo4/OGHCwuGv6EWwf5KZmcu1/oT2u3sxy1llcxiadUMNfr01Iyg8Gw?=
 =?us-ascii?Q?gA5gFbU3BOjAd6aPwgC6Hy39WUdVpT2cH7+mmvULZSGUZpxjK7DnBA3CTRPy?=
 =?us-ascii?Q?2yuG8qV6BSuYZPWfvF16SmVJrmFybm2UWBtdYoJg+3aULaiK1qOV3sXOE2PJ?=
 =?us-ascii?Q?O9BeO/99g6gz3BBGNvFBtVv02s+46C10IZ1VI5E4eSXjpbZwvVn+5MgjexaD?=
 =?us-ascii?Q?iKJTsP0oYW3op+WUNm5m7XIxOavx+gbtNx/3r8/FDVcsOJbbU2wjPETh2Bi/?=
 =?us-ascii?Q?8tZ6+0SguEnpnGaqGas7AFY71Nhw2WCS1zYO3dQOI8uUJ4b+/y4ZFd4tchSN?=
 =?us-ascii?Q?1Qmo+lHHlcKQhkV1Q1FjU5k6RHSpmzscuVkAX8ADBKRzYpyaqJ97DOMZCeIX?=
 =?us-ascii?Q?DahKuyM59JOVuDxQp+yucBfuVo8bjC5o5IJDe1i7NUfR5yIcyCX+x74D5wp2?=
 =?us-ascii?Q?vcyg8xqHPmNUPO0ePq6gmhIeh8sHrBB69SYwt7in+KSBvlYeyP7Dzl80N+8X?=
 =?us-ascii?Q?MwL3Me1K67M1xqPBrd8E1QpqM78Enp41ZYKr5SrDf9N+FQ3dG6/31c7SD9fv?=
 =?us-ascii?Q?dV/NjikEqHnpTKlylv9F6rWRHL5ETbPtuPcTXVvH9we1MeLRUhS7piGVoLDB?=
 =?us-ascii?Q?SvZvJILXphnabu4TH7i5Djy6MYH/yPMtONh66EgEwXqLRM/A65frWJRQnFxD?=
 =?us-ascii?Q?Dm2GYboaQNsq4TENZ+cC+ebfPXw3+2Swf+Mu0nWWycAh4kd/hK4MqYVTfO4s?=
 =?us-ascii?Q?EC0znfM4OVfmxN72P/h2stMvHjD1eP+WZGeZLGyrmOTdNfH3llLDiaSN5j9V?=
 =?us-ascii?Q?A1kffyDpo2+IvutZT1cLsYEhNiP4mdsVZxlVvDO3sTvgsnKVLytEMybjGYg8?=
 =?us-ascii?Q?HZ1K8/D9O+9lHRz9NrfMb1jA6UHMFuo4HmBeDToxFRtl6mQ5l6i1qei6aR1X?=
 =?us-ascii?Q?E26N9IJA8bGWIrj1nMVP5BPal5qRrRp3Wr2m6qA8hUrtvZq1UvGT+4D8PfTo?=
 =?us-ascii?Q?llM2tKrq2uIE1i//saw7om7HbTnrwHGSI584q0YK7Q0+ahhB8WnhBM6paEQs?=
 =?us-ascii?Q?zO4tUnSQlabuuhW/B/2yypX1HITFhCLr3Brsf8+asuomzghL5PeVxFlgJovg?=
 =?us-ascii?Q?1m2gnEvagXCdQhr1uQ7EZGVVMZa3vkWhKApF9Z7Ro7Z104doqjPJspfbD3b1?=
 =?us-ascii?Q?K8flyzvxIF0l4A4NwxmV2Q84pv7Ljo3FTpwUbw+VoHizWktq1SUxrQzk7ScY?=
 =?us-ascii?Q?QiL2Z2qG773iOryfMxDQsGYiZt4W2KcnnWPne1xYGrJue/xKeS+vnqkMv0pf?=
 =?us-ascii?Q?79Z+AFx3HQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa65afc7-26d2-4a61-ee81-08da3db2e430
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 18:26:16.9325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+iMXGNgHPGnRfWwhOrwJQU0DBCVGZAQXd/irdfpAljIKxX8+bWjIHxrmIl+vrCP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4065
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 24, 2022 at 01:22:07PM -0500, Bob Pearson wrote:
> On 5/24/22 06:57, Jason Gunthorpe wrote:
> > On Tue, May 24, 2022 at 03:53:30AM +0000, yangx.jy@fujitsu.com wrote:
> >> On 2022/5/10 2:23, Jason Gunthorpe wrote:
> >>> On Wed, Apr 20, 2022 at 08:40:33PM -0500, Bob Pearson wrote:
> >>>
> >>>> Bob Pearson (10):
> >>>>    RDMA/rxe: Remove IB_SRQ_INIT_MASK
> >>>>    RDMA/rxe: Add rxe_srq_cleanup()
> >>>>    RDMA/rxe: Check rxe_get() return value
> >>>>    RDMA/rxe: Move qp cleanup code to rxe_qp_do_cleanup()
> >>>>    RDMA/rxe: Move mr cleanup code to rxe_mr_cleanup()
> >>>>    RDMA/rxe: Move mw cleanup code to rxe_mw_cleanup()
> >>>>    RDMA/rxe: Enforce IBA C11-17
> >>>
> >>> I took these patches with the small edits I noted
> >>>
> >>>>    RDMA/rxe: Stop lookup of partially built objects
> >>>>    RDMA/rxe: Convert read side locking to rcu
> >>>>    RDMA/rxe: Cleanup rxe_pool.c
> >>>
> >>> It seems OK, but we need to fix the AH problem at least in the destroy
> >>> path first - lets try to fix it in alloc as well?
> >> Hi Jason, Bob
> >>
> >> Could you tell me what the AH problem is? Thanks a lot.
> > 
> > rxe doesn't implement RDMA_CREATE_AH_SLEEPABLE /
> > RDMA_DESTROY_AH_SLEEPABLE
> > 
> > Jason
> 
> First I have heard of those. Should we implement them?

Yes, it is the source of all these AH lockdep bugs.

Jason
