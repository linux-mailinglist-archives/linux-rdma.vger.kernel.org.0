Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DE653527D
	for <lists+linux-rdma@lfdr.de>; Thu, 26 May 2022 19:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348281AbiEZRVp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 May 2022 13:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348273AbiEZRVi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 May 2022 13:21:38 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2078.outbound.protection.outlook.com [40.107.101.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA4623BE0
        for <linux-rdma@vger.kernel.org>; Thu, 26 May 2022 10:21:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iU7xdYstcdFxpOkY0pb7P95RozI3p0yOIy3Y0Yozds74LwiAovRs/9br/jsWJACTHCAXSWw1K1/rlItRznEmQU5/FqNSifM972EeOFSlErNzp4UG13i1ua8mXxpW/8Kc1LLtArqCHufNmi9xW5uNNewnwY1PQYDHtxCdNZILbEWLcYvhn5AxCP65gcQEHP5uumHELd8BvWzAa4P1FESig3+rR28/0TDII4Cbl18HLSnfDweNQDDmlVdjDy+2o4Jd34/CQdtrB5EPief9W0Rnf2crv0xHO1EA6uz3MlkYJKUgIMJCJL17x3uRMjJURhdpkQsruiTpO8q6NP0+XZBvnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+QC1flPCxlAzptxbJHoY3Qh87xrEVJW+ABhNzf/um4=;
 b=GYRp4gyD++kyzWJVj2eAYveEawivJftlkdXccf48fWuYuPx8PIEsdUEGRMcOw9Ju7la5y62qIGL5hiGkxYDAdc2Y7liB7mdTj+AW99wUenOC0jtnM9+7s1PFJ/XNMg1bSZ1ivjuxUugbGUGOaQhXTtSmkgNGVpPPWy/biJy5s0NfVk4+ZWN/BuDEQ+GihITBoNL+UnqRCdzRFEbQMLeerzFPSD9ohGNFSYBQzwlqyjPSqhvNXhc9SijkHbV6eTrZzWRxmabQqcz2OexgvuHUh235yxBu4fw9iBwLWUsUYwgqW8JuhjY0hPDKLxJHKulkmoPC1TsgHTgi+GuE8aItww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+QC1flPCxlAzptxbJHoY3Qh87xrEVJW+ABhNzf/um4=;
 b=lz6mQ1Bt+qKTwsZk060nnJKaz62vFDx2n5/SGeU7bG89AKjMKFmf7ftM6s+MVQdb+pGI7c3a5jZ+pX3a1GqxiXS8g3aD8TW5N9zalbHcv3gyW8IAFakA2D792242o1vSL9yEDwMCXs2vB0IMtOMBISFNnox6mQTMdI20NCRM+C5kc+CnwLctf2xJvqB5fgGicU/6Hkgt/AT2r3ygMeWCmkhN+NjeGSr5ldBMyIh1I2khb7UaF5QeveMaqnmmvoQUAr0KX/Qex7Y5Tty9tTHBwXxMPrOWcvi+x1e6c9QRPn4ZPGR1BMx8TJkQJwLDzMBY/f4gQXnb9hBCW1Rp3KWaKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB3403.namprd12.prod.outlook.com (2603:10b6:5:11d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 17:21:34 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%7]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 17:21:33 +0000
Date:   Thu, 26 May 2022 14:21:32 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Add a umr recovery flow
Message-ID: <20220526172132.GL1343366@nvidia.com>
References: <6cc24816cca049bd8541317f5e41d3ac659445d3.1652588303.git.leonro@nvidia.com>
 <20220526143212.GA3078527@nvidia.com>
 <Yo+q4KQ2JU92XZlh@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo+q4KQ2JU92XZlh@unreal>
X-ClientProxiedBy: BL1PR13CA0143.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::28) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbe0633f-709c-4b2f-d1c5-08da3f3c2e83
X-MS-TrafficTypeDiagnostic: DM6PR12MB3403:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3403C4A6CC79145BE6E52333C2D99@DM6PR12MB3403.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 15zRsCPqoDBUMYsdGOzB0jp1WKxjTSdp3PXIko9OTnMqgbruIKBfMTeUI6Upcgm0nXO5zbZ9yHFbsBf97A6Ey7OqIGNRbmHgars8eAo3e74mJ/mo+jdJ2MhFZ1uksvRVlYph46xsx6JpRvz0HMDrUkQjyBngXY18gkrbo+TOcsj2LpzNVK4US7baY9zbM+zU+ULyzzjnidOg9/r4VnJW7qjxANwa+dmNyJNZ4PZuZ8HdiPWblV17WY4XyJYSpUfmtR+ZGpB2XRxaCPXCfvTFewbxaM+qCbqkfNclLS9//mPXc5jp/q0MFbNaVMiOO4n/iv6CJjGjXwQl0siSOf/6WeGBOkJABwDJ0Mt/FOtpanCDSr19mOxMqmxUnI44NtRvDONWsWpNmZSfjd5lWg3xU5XKix1nsP5FsHsFDOtJy4JZ36Rkpsi3/q3wNKdhxNWojbqW7vY1Hh/85qm8SlcGo7+0O93cNbcz+a0NpNXxxTRFStf2zBKMbDmi1HS3xyp/W1GWFzeaGoNm+euLCBV9HWSlSlIjfEzkvshQ8R+9th9A252SC2R4dxqhKpbJ9jhr5dwwZdB96gVKJ9/Nl0G193nrsvvNVXEAWMwFOOlvU//tBPO17JF95q/k5/IL8RfLYiWI5HE7+NntvwmL6H5yHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(107886003)(2906002)(1076003)(54906003)(316002)(4326008)(8676002)(36756003)(508600001)(83380400001)(186003)(5660300002)(33656002)(4744005)(6512007)(6506007)(26005)(2616005)(8936002)(6486002)(66556008)(38100700002)(66476007)(66946007)(86362001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hFWyU5Q3/DuaZLERdyVfF6FXYQtfG7oWFKbYkWTgOP7EjwOxrB0d6MuRLWpq?=
 =?us-ascii?Q?UEdj4ac2z2cS7yCvjwFkzCKUXpQZkGbidy9nfBaWfmrfEa6pE9mX7UDI4Nu2?=
 =?us-ascii?Q?e096wcs7Pj+ALnUN4vVweiuhUub0x470vxYwDCotdhQmLSeH+orjyQi2xQ9j?=
 =?us-ascii?Q?Ibxpw8vjv0GDYTzfLCqbkGclKYr6vcwlk1dUcmhuPTOUV35UCdvq0BvHH7kv?=
 =?us-ascii?Q?UjOealVOnJjakfdBRJV/513FHYz2+rRYIi186ON5CYdK82t3ezTT2YNFm5f9?=
 =?us-ascii?Q?2TvnbCLPoCJP2W93Gd+0d6MXb/dTyfdy+ZFqHvH68heKaWvu94ruc687cbjg?=
 =?us-ascii?Q?RDTa2hfBlkiIqnfj8AMYu0WR25py9atHQ3hlms5QD8xfA2uR8at0bP/Fb92Q?=
 =?us-ascii?Q?JgMYkeUGTrOQRU1gSUBMUtS4W6tikqLK/eP+6wBrbtL+fLoevU/KdRQm5+bQ?=
 =?us-ascii?Q?E2QhEr7JiWnW4CBPxhDJzdnDqWrPoUaicCzPo8H0cRHRhV8FaYC7ZQSkhzHU?=
 =?us-ascii?Q?CVRrG+7VjBbu49H6p7BjrHnKejR2eWtOzMjjfYNDn99rYevHAS58c+N3+LDt?=
 =?us-ascii?Q?1dfoBrP6izMyzRAMXqp/zhoRarzId6+L71Oys550KA2QnffTmnfdLZHZd5xm?=
 =?us-ascii?Q?twaMv4QkjRUIwnwigXsl4qN5jOT8dfwaGwiIWxlgo0faCSk120NaVkBOfPsM?=
 =?us-ascii?Q?JWkxocBt1UTLhWGdL7Fgy+FePAEINWSMG0Hs7QV++bpV4+VVIA+7J/sMXCpx?=
 =?us-ascii?Q?dgyfsY6rUx/T2WctkFOJOmurtYdDUFKVdTnFitX2+PXRwzgufHPFzsbFo6dN?=
 =?us-ascii?Q?B5qFItLkPqhs7h0Oyc8ReLqdDrYEXxSh/kMa2h5PlhInanho5yXknc/7QC0D?=
 =?us-ascii?Q?mQ/P8B2unCNKM8QEgrsHMsc3ymhTGtzFq0i2fXeKdeDT/UZSokvdsWHL2e1U?=
 =?us-ascii?Q?4tfnqa18Z+GRFJzQMKuWY4eyn0hLQB0nQ5i022QN9QCVyx96tnXzvUOuylgP?=
 =?us-ascii?Q?D8mUr25utfYPfvt3aUqPqJA0V2DZXFHCHtvPAN/1jd/V5yqY4yOZaSZOHzqm?=
 =?us-ascii?Q?cgwmObeEDvX6Y+XzPueNPmTAXvpzaew8KsK8gv0nf1zn4tgfiEI1VwH9jwu1?=
 =?us-ascii?Q?BP0SF1aOcg95dBXloHFROh5CylD3Kk24BmSvGGpdZ9nCvDbzWjwbKoXztcvf?=
 =?us-ascii?Q?cdXFJFqAt6Y7YcpskQf3gY4lxy4owxYHA8cSGrm+H5doON2dctv4xWCrTNlc?=
 =?us-ascii?Q?FHSnhpebAFAJ7E4678aIqR9dhYou3x2PXaj/brbL1HbYRFIWHAn2LZqsxqoj?=
 =?us-ascii?Q?tx2B0YMqMplHDkkNz8JHoycBEmybImcBfqvOHqTSwVkMvY2BOy4h0NfvXHdU?=
 =?us-ascii?Q?ZTT/wILxDXTrPuFG2d1XjlNqteN6sjHXXJQmVc769vpOjPP2kEuez9P2kMNQ?=
 =?us-ascii?Q?zKm/gzxFaxJEN0Df3PlzOXzFvTN0fyLFwRfrCsvLlbxHCiJR4t5p/xn6Xu8h?=
 =?us-ascii?Q?NNEXK2Pg+dE5WmMerZKwwfD+bEXyiDMrnShkbpUFXDFf3mwlw039yAoVg6ME?=
 =?us-ascii?Q?IpNIuYKQFBLGsX+LAdkBhx8FK75qoxW/QPWZFv5M/KwRLVPGb8h6MOr59jF+?=
 =?us-ascii?Q?i1R77V3tWuWhTQOg7YarJeQrkyfPB9JCc5h0FGqm2/nVLFA4w9Azc9P3O92Y?=
 =?us-ascii?Q?LcL68+w3OYg0rVIH9CTjJZetVmp+k6E+RC7+2/Yt/SLyJWxgGWblfzeTHFMV?=
 =?us-ascii?Q?CAIn7NJ1wg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe0633f-709c-4b2f-d1c5-08da3f3c2e83
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 17:21:33.8562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPw0dkEA/g+ktuoRgg5jTEFhP+VmOd4Ugv2jwHHLpWjBc9ttib5Jz9MN2lsWmeba
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3403
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 26, 2022 at 07:29:20PM +0300, Leon Romanovsky wrote:

> > > +		err = mlx5r_umr_post_send(umrc->qp, mkey, &umr_context.cqe, wqe,
> > > +					  with_data);
> > > +		mutex_unlock(&umrc->lock);
> > > +		if (err) {
> > > +			mlx5_ib_warn(dev, "UMR post send failed, err %d\n",
> > > +				     err);
> > > +			break;
> > >  		}
> > > +
> > > +		wait_for_completion(&umr_context.done);
> > 
> > Nor is sleeping under a semaphore.
> 
> Not according to the kernel/locking/semaphore.c. Semaphores can sleep
> and the code protected by semaphores can sleep too.
> 
>    53 void down(struct semaphore *sem)
>    54 {
>    55         unsigned long flags;
>    56
>    57         might_sleep();
>    ....
>    64 }
>    65 EXPORT_SYMBOL(down);

Hum, OK, I am confused

> > And, I'm pretty sure, this entire function is called under a spinlock
> > in some cases.
>
> Can you point to such flow?

It seems like not anymore, or at least I couldn't find a case.

Jason
