Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5823E53309A
	for <lists+linux-rdma@lfdr.de>; Tue, 24 May 2022 20:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240398AbiEXSlt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 May 2022 14:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240422AbiEXSlr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 May 2022 14:41:47 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2062.outbound.protection.outlook.com [40.107.101.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF4F1208A
        for <linux-rdma@vger.kernel.org>; Tue, 24 May 2022 11:41:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOjrTr8Px3hvWCoDss966qbr/D6WP1099PTML0HqjQgtn4G+o2nMYbekWJZlSl+sJgMWe9f22AmusHTNo25dFERDblBRD0qpBt4UgePUmbGpvyEvXw/EFagwQCuP5NCWzudEM2MpyZOUo1G6MPOGGebYcpA4j8AjQxnO7OHL+zBPS9zuD75qV0/pKZWdMYJaXlWIAMuBsZbxdN4WaJ9f3otN+7AegnEf0WJhG6hBL3fw5KOAh3+/ZgI5uslN1uUCAmFRJOzB9dwqHUR7nva4lURuEcw87C1EfsO0U8WlT8uSk+xKywYS9mfMVRdRbogVlAu5yOx68ue4F/0PPKuJ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRTdHEnGCtcY7yHZRN4a9HfGNTVXEZLQLvjTn5McKtw=;
 b=eIemTtU7v2nwUVN8xIoW/uuxtvMplAEARZaVKr/6ek+BrfOYn3EVF+adLYo3uRjJw0pwHx7prGEB/aaJKDqNhxkHBNSdw5yrUn8JctDEvTaMLE452WQ3a1PvKxKlU0Egx0uj3ov2GOQ/v/VBCdRtWqHQhJ/8VUZ1jEL9nQuRf3YKSwtKpVjH5x/4kPCzfsBdkIT3J0dVY2AnTnmA03htxOHntHn7tPhNDJnAzo4CZgAkqxTeu2l9/JwI9UKZY8nOGDmVL9IydcO8Ol+ORA+hS6VFal/rEBU3hoIvdV8vxD61g+bAe8Yl7nQ8rsdMer9BhbbXTz7qmGJd1x2efDjhZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRTdHEnGCtcY7yHZRN4a9HfGNTVXEZLQLvjTn5McKtw=;
 b=cSVFxtv0FO7ACT/GjBtB3s0y92JlCjahc7HHNiMU3MN6GwSlQgtURvNTXcRUhy6/dXeIWUSgT2XzmQMkxRqzETy8ryqBQNTCAKdv8zybawNutdKnpjcKv95b2G9JgtYPOLOPjvlqtO0UAOLLAH5arQV+ixigku3ieagtSATr2poy3jCRBsopDIxp3em5Zpk5xQmsP8OFoDihT34nrOKiCPa9XkUiorVH9GsQnyfBcA94HKLdDW7jgvxMbWsZ+gzh10ciMIRLG6qlkKcXS6JX3v+pEThjgylIdTZDR6SIiZkR7aiWI7JD+8OvhaOQnUOYd0r4KPWPg/Lj9Mm46GiUfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 18:41:35 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%7]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 18:41:35 +0000
Date:   Tue, 24 May 2022 15:41:34 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v14 00/10] Fix race conditions in rxe_pool
Message-ID: <20220524184134.GA1343366@nvidia.com>
References: <20220421014042.26985-1-rpearsonhpe@gmail.com>
 <20220509182353.GA927104@nvidia.com>
 <6012bc26-a2f6-c05f-a056-36aac02797e8@fujitsu.com>
 <20220524115753.GO1343366@nvidia.com>
 <ec2369b3-4dad-30bf-35c0-d45ee0a7ce92@gmail.com>
 <20220524182615.GZ1343366@nvidia.com>
 <dfe216f3-43c1-fc6c-d956-9454d7ab5056@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfe216f3-43c1-fc6c-d956-9454d7ab5056@gmail.com>
X-ClientProxiedBy: BLAPR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:208:329::9) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dd0d47c-4d92-4807-cda9-08da3db507c4
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3587B06BDF31FE8854AB8262C2D79@BN8PR12MB3587.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ig0lBPts1XmfvarGD1RlrvGzyYgj2bU7ziTjwD14lWfflCFwWIaTKKIm9brGx2rXB9YvKinfqp+R/xWXB7PQEkEeGIZ2uvjs/8y2GeqBNkBJmB39+EiJ7qVAzDhpolYipym955W/qcKqmsowR5grb6kRWbpW4jgta4wgxxARyGyi0bYxULo0U9lHSdlqe+E8RiQPWyPHISicMeKBiCaBUaX956fdWh4KsTz8zYl80umY2DVubTKmPnbqVnaxAz9Y9Qaf+0QFW9440aT05ScSJK4Zlo0yRqndf4eCrQxro6EiawxGOJBEcacXAtfLndRsnl5oPk1oxJw7oQlQ2KwbnvAbxqJ0Ielc50u9OAM8mGvdz14I+gxdjRni9g9aU+zfH9BeLCvweL/2vcmgQuAYr/gz8ag2JKovRWt1rtsoT7WwHi5fuyHF7uwDvN2sqguGnVKgBOWDGrA6EUmBrP6ncJ87iazQoBuV6LFzsWESazq5fgdICSrv+PCWO8dKqMBvbJYMU1ZVFrQOI8BsTJwm08XinsLgcDx3vhxLRtIVCUisyT7SlJMWwavtao36VIF2wsGB4YSYGKgbYY7aWiBdaCPsleXnRp4jn51pgewcgnWhVEgMmM174zLvDGHpEgukckWY+58pMpV5CeTBA+r5bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(6512007)(33656002)(2906002)(2616005)(38100700002)(86362001)(66556008)(66476007)(66946007)(8676002)(36756003)(5660300002)(8936002)(316002)(83380400001)(4326008)(6486002)(508600001)(6506007)(53546011)(54906003)(1076003)(6916009)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UP5sSMFkkwE0vP7dAlX4GSV7VuPXXVaLYEg2O0h9Z3sJNtPXT5nbo1G7NWsS?=
 =?us-ascii?Q?VSeAqikj1HxsCITZMKUIYlQh42epsav3y2zpxF1+oIhGYjlgChnhOOSYHPV0?=
 =?us-ascii?Q?r05oPg0It+ULXavD14YRtI8J4qOa+x+dVZ6XxU5s+FtsOHmQFMgbtaQV8fzt?=
 =?us-ascii?Q?t2dn7Ttr5mXi1FRv3WNjc0cd5+1KZcoPWgVCrrY+Eqi6JQyRZj2kGhtPKc2d?=
 =?us-ascii?Q?Nl8jOZQ1/ivIBSk6Oj2+mOAQTxV0/xe44YT3J0Oa8Wa82b+tv6CYsNPT80U2?=
 =?us-ascii?Q?yLG2H/l1ME/2Wf/k3NNOAxMdtB6u5L9DcGfPb3FGdgZ3YQTo5xFvvlhQ3k1w?=
 =?us-ascii?Q?RlVSnhWSF4ahzWDhTMHOy+rXaGL1G9dE29tmCzc/RtW/52IZMQN267GI2UAh?=
 =?us-ascii?Q?VzNInL4/jJdDur9zxO9cv+djjPYYxQ+5tZoWIEV4UOkR/n/5evhCirDlkqKo?=
 =?us-ascii?Q?V4lzhDB0lV1N6tZylhsh/L1rc3JqrTpGKMgcxA3ToXtVV0SPw+/ENZA/+vqw?=
 =?us-ascii?Q?49J/fXsYp+CxzFt64j2Ux9XrkWv/LoV7FqpamYZsV+gQAMd9FBmS8TKXrHEO?=
 =?us-ascii?Q?hx+4Cq5SJ3eoiMYz14Dy022KQ/72RCf7PeF+pg/DKtrUP8/YEqQY6uNo2rhX?=
 =?us-ascii?Q?gIedBq7Z7o24HDUS0NUwJZmY3PCrjvjOXlrEiNQPhvL6O+TFEdqobKHA1AXp?=
 =?us-ascii?Q?JDTFTc+PDzA1c3ZmON8iJgu1nJG97s53MmHzT3pGpyoecT2jeyMgxwUCf66H?=
 =?us-ascii?Q?lSeA8rE+ubeEs7Sghs4f3A3BauIzqqPiacGMg3Q1HA6OoMpE7QQzTEsxQGOt?=
 =?us-ascii?Q?6UR5XF1M7+/5HhGgd9btNvGog9paAap5y3iPn8dHbaBxI7mS/lC/49+/BUHP?=
 =?us-ascii?Q?OyaaUUKJjxzJtfifZD7FyGRTCXTOj6cE0fZKMVyCskWAYXVK2UZ7JIsj6TLb?=
 =?us-ascii?Q?hzra4JApcC8MDlewu0Oo+9u0j5lzs685Zq7OlWaEV2DmjF2S0Pk6h3Gu8CUc?=
 =?us-ascii?Q?T4VCldAcjg3B55asyg2/Isgc13mW2SJy+V1/lYcepvRGv6BW8h4J1oIkjI57?=
 =?us-ascii?Q?5FPrmlozHhivgb7T3ya7YCA6kAEhuXlbe9j+h2pRzr/CE29cz3Gctg0X8QVC?=
 =?us-ascii?Q?ud9zpbCjHvZ+R5FxuBtKzk4twg8lGToz9Ydj2oDNE95kE878EPzWVDelleOn?=
 =?us-ascii?Q?cfFDu4XcAJlDZySRl2Nb2h29zMDKkl22x5rh8ulj92cH4GLlbNNSL8zuMLYL?=
 =?us-ascii?Q?lJYGCTLlcm6xJSUstzZvuwtOrbzYKYFK4gBAWH1BBVTnt0ClXU1oqHNIBeeE?=
 =?us-ascii?Q?dJQeZs3pyskdWs2lXPU3ouD2g3J/TSY2asYcJqjGHgVnvdmkxFJ/3QgP3G6l?=
 =?us-ascii?Q?op1+jEjKjOV9DAij19YMrEBVJd3ftpuD0ZP4dQODQBTLOuRunCDKINN1Etv4?=
 =?us-ascii?Q?VCxu0+iSeC4pUTrC55IWMjGnaN07HQNecblKxu5s6i9nRPiOgEhigbS0F3/8?=
 =?us-ascii?Q?el2Mpi2DQ0CnCWCbHNAMCXtETWU5GoR2/iWQaVkYT+Iye5QjoBoKDUgAzxJS?=
 =?us-ascii?Q?Ns1J1+SOgmmuFX7VTNtgGaQcoKlA+y0yOC4Afk6It+YqelodxRBdPs8IpTB9?=
 =?us-ascii?Q?NuxRkPC9RWlY+KfwLKkrWR6WA0AZKmkZU0Imnc+Ztw2twTMTn7vcbGebqmvQ?=
 =?us-ascii?Q?cqRg0cFysUVeTh2D2l72yLGsP5Rn5lKea+WC6doHskGNBQv8JFsH/FAlMdI8?=
 =?us-ascii?Q?dfNfvrLV3Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd0d47c-4d92-4807-cda9-08da3db507c4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 18:41:35.5996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ma7NxcyVU9zBCQ37Ra81WedD1fJtkkMYmnqzYobakaUT/atdTYq/Q4WWUdHs37rd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3587
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 24, 2022 at 01:27:49PM -0500, Bob Pearson wrote:
> On 5/24/22 13:26, Jason Gunthorpe wrote:
> > On Tue, May 24, 2022 at 01:22:07PM -0500, Bob Pearson wrote:
> >> On 5/24/22 06:57, Jason Gunthorpe wrote:
> >>> On Tue, May 24, 2022 at 03:53:30AM +0000, yangx.jy@fujitsu.com wrote:
> >>>> On 2022/5/10 2:23, Jason Gunthorpe wrote:
> >>>>> On Wed, Apr 20, 2022 at 08:40:33PM -0500, Bob Pearson wrote:
> >>>>>
> >>>>>> Bob Pearson (10):
> >>>>>>    RDMA/rxe: Remove IB_SRQ_INIT_MASK
> >>>>>>    RDMA/rxe: Add rxe_srq_cleanup()
> >>>>>>    RDMA/rxe: Check rxe_get() return value
> >>>>>>    RDMA/rxe: Move qp cleanup code to rxe_qp_do_cleanup()
> >>>>>>    RDMA/rxe: Move mr cleanup code to rxe_mr_cleanup()
> >>>>>>    RDMA/rxe: Move mw cleanup code to rxe_mw_cleanup()
> >>>>>>    RDMA/rxe: Enforce IBA C11-17
> >>>>>
> >>>>> I took these patches with the small edits I noted
> >>>>>
> >>>>>>    RDMA/rxe: Stop lookup of partially built objects
> >>>>>>    RDMA/rxe: Convert read side locking to rcu
> >>>>>>    RDMA/rxe: Cleanup rxe_pool.c
> >>>>>
> >>>>> It seems OK, but we need to fix the AH problem at least in the destroy
> >>>>> path first - lets try to fix it in alloc as well?
> >>>> Hi Jason, Bob
> >>>>
> >>>> Could you tell me what the AH problem is? Thanks a lot.
> >>>
> >>> rxe doesn't implement RDMA_CREATE_AH_SLEEPABLE /
> >>> RDMA_DESTROY_AH_SLEEPABLE
> >>>
> >>> Jason
> >>
> >> First I have heard of those. Should we implement them?
> > 
> > Yes, it is the source of all these AH lockdep bugs.
> > 
> > 
> 
> OK but what is RDMA_CREATE_AH_SLEEPABLE? 

If it is not set then create_ah is not allowed to sleep.

Same for destroy.

Not allowed to sleep means you can't use GFP_KERNEL/etc.

Jason 
