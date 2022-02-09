Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F74B4AF173
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Feb 2022 13:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiBIMZL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Feb 2022 07:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiBIMZK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Feb 2022 07:25:10 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9780C05CB86
        for <linux-rdma@vger.kernel.org>; Wed,  9 Feb 2022 04:25:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/5QpN706ooSpyV5lTRGVgT196ZmYVKmo1RlbdQCaOKuPtscljoI23Rg3hJUBrNhN9dV3fB+x7fcAbnccNWV/pDZW5oAjkLKcb66eay/fgg9MOL0t+PONAUNaS0s8FBTGJ1y50xAam+hNTUT/F+QA4CAegg4GwopO8+m3knzuf9qfCv51UHWndzuMbvwBEsK16IJUIL4RUcJuAbOnORGz1fXo0M7mcjVX+5vZsbFf0kuoO3PoUEZg27guBtn2V9HXy4Joh/CoeP3Mybiw3JriJdkVoicUomcmoKScmyZTcov/EQS5trS2ytdDcBmfRMVlcwLtvodwIqCse+BL/g3DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZZLIIA70LS5JqfMPKQInUF1AlGYGcz+sDbEf8EN/d0=;
 b=VXSRWE8Vxh/khe5UrSQqWKFu0eSvJ0IYT//AvPFbawIVvbFGwt9Jx4krigE5D+tUrXDY94cMF6H9n5249FtXD4bgyIfzqJ4ZzsKiguyi53o1URNSk1hzNBcZEn9TvLaWICnuJEQcAEoliJg6pM/PC9JSCnCr6/lanefc5FdMQq0bBnhNmdBbQNWSBCBEhEc3pn/6Hs33/SoqtfieVQKWKyz8wf5VnJ9vNkFqCfkrgMcNB5ERjKRYoQ7HH/2kUC5tqB9k8Ar6gRvQpnnjJeIF2elqax4CgwudJdKSayvT4kxwjakF8KXbfhWIxOwXqg7PjGy/YZM2feZ8PamFxjLL4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZZLIIA70LS5JqfMPKQInUF1AlGYGcz+sDbEf8EN/d0=;
 b=lvB0ifh3ZtTPIgJfgAa9qasuJ57Ve7ONrODa9ERRaN3GYWJ9Q9LCn3e4/D6jqIGeCi5JqLANfC1H2KaZIuo2AMPOa0hznVP48WZPiGy1D7Hj12a6Aac9WISkxGXVGAydup+ynnmVCjZPJR9dTwg6JRG1Kn1Q3BAxbcsBenS6isdtzRurs+J20IIsJ033JJ4E+aJLVyhj3yEpr6P0WAjwsCZvo3Fe5rmzm/YMjnntlrCxJcNFxKhfYTmnYM4nOEGHEjPLipWNHPDrEAnWHU2iMjHr4B0v6u22ud8bmuw7dCQDocYG/iYrvZtitU5Q8tpfgLTIxmtaOT5PD7GmD54INg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL1PR12MB5945.namprd12.prod.outlook.com (2603:10b6:208:398::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 12:25:11 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 12:25:11 +0000
Date:   Wed, 9 Feb 2022 08:25:10 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Haris Iqbal <haris.iqbal@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        jinpu.wang@ionos.com
Subject: Re: [PATCH v3 1/2] RDMA/rtrs-clt: Fix possible double free in error
 case
Message-ID: <20220209122510.GQ4160@nvidia.com>
References: <20220202150855.445973-1-haris.iqbal@ionos.com>
 <20220208164835.GA180654@nvidia.com>
 <CAJpMwyiU_yxgQXugRMF+ifGz3mH=GNherqKDCMVXax6jUp6hdA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJpMwyiU_yxgQXugRMF+ifGz3mH=GNherqKDCMVXax6jUp6hdA@mail.gmail.com>
X-ClientProxiedBy: BL1P221CA0027.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::8) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ab541b2-df4e-45ba-f2a7-08d9ebc7375b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5945:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB59451C3710613FAA0C3F979EC22E9@BL1PR12MB5945.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4zCXRkNgIq1I0q9zabKa1jSF5sv1CePRYWMKtOcbfcYOWEouTn1H5VSsIRHwB93hyBOcUwytjVg/j+f5fNYxxMFKVJQU82jjVhva2SGxPTcGjwf5Z64jrZ3cCeJDrRvwdk8WhqXQhjJbQMUicNQURI/N7y3zq2YRuzpVJdqQwT2EW2lD+obuVtaivt4slZSF3fFute27dUsqTo9PqbVEWIcZYJJ3ThNVIAgqvM5mhEjCMUULm9ZTZ7xsmUVWqMmRax4QWppxkrxzmabCFOpu4jNOlfC+2SzFxwd+8OurInHXC00JDf6IStUzj2I4qAmete4nwNI1bhsSnz2lPZeqAqPmu6B5pbL2fGIoe+P8NoKzYCT2RE19QeFZgeWJ/lAP4+rhNDfNIoTmxFadujGukcuUZZfNkvJOQ6pYfUKpma820j8HasBXq4mzNPDAgAnqC/Idfixks5zdN2fDiBXco+uF0gFvY651bbvkC1YxVaHztZnXvbe1v8THRr5P4sklTzbBtQQSLfiwbT4qjUhwJNPqB4ppjHCpkP+T4/ziTNHFz8TvyJmDIMagvxxASO1Brwu80Owl9Osq7TcF01zOi6sS6oIfR9wPYr6xnfcC45RtmxedyxAeoKpAZ/P4u+fhUL75qoJz1jRWaGpiiQwaXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(53546011)(6506007)(6512007)(5660300002)(2906002)(316002)(38100700002)(66476007)(33656002)(66556008)(6486002)(86362001)(66946007)(36756003)(83380400001)(6916009)(186003)(8936002)(8676002)(1076003)(2616005)(26005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MY/Cpk9H6DYuu3CdI/0VZ9yNQzCEsRD+oyVgvK/trDh+WBbmStpp1s+BKu5l?=
 =?us-ascii?Q?TDKsdeFXDENVUPGBPItccNvl1s9P02wZtChpvlBFk7uAZihO2XGzhHUiTkU8?=
 =?us-ascii?Q?GlRu/f3j7jeXxRfB3HKtktFY/uQZDUxWrovkopdw+xACxxXRM0XXj6wxt2Zd?=
 =?us-ascii?Q?1wVYtLaDsr97i4ynOoq6P1ubQUrXhx7+ZlqY+1SOMPJuOM2WrOCnjqM3spQi?=
 =?us-ascii?Q?24W3MemPIHOAlMGWrKXGrQuBn6KK7K8Cu8yVsKez/vfrPdXClV2axA9xW0iu?=
 =?us-ascii?Q?phgjGpch5orelBJi2je8oV7sfyRK7PceEgQ0pBzDoHDQejIVw26xf6Lr/L3C?=
 =?us-ascii?Q?MS04gF88z2WMxGo7ZpMFajhSCXGWDgrEM0FvvHPh1qAYt25pUb6RrMc/Qr8u?=
 =?us-ascii?Q?orz5Le2lMXraIIqeCzAjo22F7vMaDyfPWplNaeowZ0oeu+PtWMFsaqs51Vu9?=
 =?us-ascii?Q?MtxEYt55Zn7PYme7SjZmAzDuVbJviXy3vrMmLTLmvj4ybLqBU6gGmWNfdM48?=
 =?us-ascii?Q?4RAL/Qi+8SMfrsaPmRwxOc98QirwKluA9CBMYIgF+hfGNqhP4jTtv8IskVDW?=
 =?us-ascii?Q?ZrcUjfm9miCF9YU8QTHo9MNvx5O9LQH1ewAVsOBmpTfTXrKN9aZ8SyuFFgIv?=
 =?us-ascii?Q?nxiJXfA4T/z5vukbcmGp3qgBwlHaoYOWz5jyrfVexdBOXefmfiOxCfkICy5w?=
 =?us-ascii?Q?2X4yUslrK3+7+kGBR5yKi9gHGn7TnEiZyn53/sZ5dXxQ0Us+oRSoFnwVUqwo?=
 =?us-ascii?Q?h5fMevTTXKRH2fsW8uqzOyrOy+6m/rjL21qDpvuBWDgmk+Q/lXEteU3N5wlu?=
 =?us-ascii?Q?8zaV+/MY8APP3RCBVa4t9I/8Ia8qRKH4q/jnMGNwInrCoG1kkxIfvMBvZoVG?=
 =?us-ascii?Q?vg72lz0uYBA/dE6K7BTqLFexDDXxORCHzX42ZQHVwLD2slykbBC7EzVj+1z3?=
 =?us-ascii?Q?v6v4LUX9f5a2Z8BCyktaGwxqAL8tDh+6GX/QtV3Gr/ynb3/BewSrbW80ssfv?=
 =?us-ascii?Q?kQek7NruKkT7Cw2hncN5AtFVpd44aDSXq8uQDkz59zOfsjyivvMjjbcjtbof?=
 =?us-ascii?Q?mAVv5VsIXiPQhWoydaeQY6LEQYTGyC+5lMe5/mDY2Szg3RixmmqAddSq5dmr?=
 =?us-ascii?Q?xjmTOD1FNSKZqAvW5VMapiBUmHFR+p4/SB/k1S+lcJTy8zgzirq1I8ETh2Is?=
 =?us-ascii?Q?CuKk9NMxyX5sXjEfhNmyAlYU1N/JYxCQ5rMDD+Fp+XyEZGNlEJAtZ79Ex8cK?=
 =?us-ascii?Q?riQ9HaPskycQDHlmqHa0v3n6NwGDrL7zAWgpIz0pG0cZiPVVli5I8MdKqRsR?=
 =?us-ascii?Q?+w79SAc4Vp8nSdDSoNPZyT1Lk1wAa35LR86O48IixTZSdkFK56oIqYadcqV5?=
 =?us-ascii?Q?tMjYRKSKujGqoMNr494fGducpl+7x32dmFarzzKKjilJKUDvyIlL0Y81YjsE?=
 =?us-ascii?Q?hMNE8+vJCezIP6eJApMC6p9RN6qwvuNf1q16WTZYBSV3x8RT7FaBLSsv1aYf?=
 =?us-ascii?Q?An9b+qfha14YB1J4m8fjiqZSvmXFUg4LBHdE2X8y8C4VLgkIsaJL1o6PTx3t?=
 =?us-ascii?Q?mOfW19CZfyG9aEMZKFE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab541b2-df4e-45ba-f2a7-08d9ebc7375b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 12:25:11.0521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjqIBTUdJYSeHuYqUBexDL239zbulidEiIXTjbbd7Ct6JwLq8NYZU61vg29zNv5w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5945
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 09, 2022 at 01:00:32PM +0100, Haris Iqbal wrote:
> On Tue, Feb 8, 2022 at 5:48 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Wed, Feb 02, 2022 at 04:08:54PM +0100, Md Haris Iqbal wrote:
> > > Callback function rtrs_clt_dev_release() for put_device() calls kfree(clt)
> > > to free memory. We shouldn't call kfree(clt) again, and we can't use the
> > > clt after kfree too.
> > >
> > > Replace device_register with device_initialize and device_add so that
> > > dev_set_name can be used appropriately.
> > >
> > > Move mutex_destroy to release function so it can be called in alloc_clt err
> > > path.
> > >
> > > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > > Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
> > >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 37 ++++++++++++++------------
> > >  1 file changed, 20 insertions(+), 17 deletions(-)
> >
> > These patches don't apply, please resend them
> 
> Hi Jason,
> 
> I tried these 2 patches over wip/jgg-for-next (commit
> 2f1b2820b546c1eef07d15ed73db4177c0cf6d46) and it applies. Can you
> check once more if there is some other issue? Thanks.

It applied for you because you have the right 3 way information, I
don't. You need to generate and send patches against clean trees

Jason
