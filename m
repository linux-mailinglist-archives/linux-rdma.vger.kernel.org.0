Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9484E4B2D50
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Feb 2022 20:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbiBKTLT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Feb 2022 14:11:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbiBKTLS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Feb 2022 14:11:18 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11hn2211.outbound.protection.outlook.com [52.100.171.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F8ECE9;
        Fri, 11 Feb 2022 11:11:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UINa92YVPSNLXcmSpEzOvoq820cc/yulJAyTbncipeMnxfWmfwNi48LHPu+2SBh8kO3exalEqEigvJp8PSyNk0j4VvP1W/STkQ9W3GKJMJmfuTE6x8rMKGNfHNgj9+uCF/Q96mSInjVdgMhx6nxPneQl+JyrvEx0BJkFE7QrFGZtgq3VOfxnxM5BXFr3baPnwgwMi0DEIYLdRLOfPb4RQatnm4uhwXXR3nVftt5SAFHzPGsM2JhcXQc36k2gxdkEb8sUt6lxsAi16YI+TB+q0fngNOQuOUGiNf7p/ASlngMjfxY2PWZuvhaVkNykj7NYzIhW1SOJFq79XLnoTLusNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kf/L7FMwPshYSrF0V9DN/WCL6oeSyNLLhQJ9rTFJBRM=;
 b=XqvSn3slwijrddXLtrrW2/YPN8G1f0WV6swDePha0lushvs2fvYHZwpa4hJZva6xZBDdGDG9RnhzZFneskqiUGHOFleEA9Ts2CyJBPgyOdpz+T/cCXKAm+GXDYb4plRdXoNMuwcnE9PgQd8y8GUGNlLJw7zY/BG2VK1gO/1mUQoHYuq9cjUMAHEHznc/+bkDA8KCxA1eqLT5iggwPFBw3P6lgHzrBDdWDBiyBurhhiq3VFnCVgwD27mni7ebPYF7XZvMK+N/2H28K36h0K5wRMVl/TM7L4F/Yl1+RLbc/6XGLGpJpNpuEMSvT74no91LPr6+Rms9zks3+TrsWqQ1fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kf/L7FMwPshYSrF0V9DN/WCL6oeSyNLLhQJ9rTFJBRM=;
 b=VubWmoEL7ssxifygzPGzxh5AYwsJhR5GI/fTrHHCoBQBDjd10TKubTbiAK8aSWzwmqbOvtpdus3Z8mixvqQmEdebhuKiNFyscvPg0986aSIuDiYZhIgDiZgy3iX3iNyh/ym9DxwIhxpZDKPu6d7FT0kosmdrTd7EBdOf06/SNoJBVobhmZ93XEdKvbRcZO6ZqUgzaJ5LfpIuZSNRLAVimCXw0VGVrBe4mF4AHUwNWIjg8cCosOe65kNbK4+9V588ErO3iZJ37xnkqZRv2WuLn4TN6cwdfIow1ingMABUCwAk9xxqm1Jwh40eYSLtcryQnfBzKIW+a9hxkBnJYvoZHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY4PR12MB1320.namprd12.prod.outlook.com (2603:10b6:903:40::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 11 Feb
 2022 19:11:13 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 19:11:13 +0000
Date:   Fri, 11 Feb 2022 15:11:12 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 41/49] RDMA/hfi1: replace cpumask_weight with
 cpumask_weight_{eq, ...} where appropriate
Message-ID: <20220211191112.GA654106@nvidia.com>
References: <20220210224933.379149-1-yury.norov@gmail.com>
 <20220210224933.379149-42-yury.norov@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210224933.379149-42-yury.norov@gmail.com>
X-ClientProxiedBy: MN2PR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::36) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d006e7d2-9307-4692-7ecb-08d9ed924555
X-MS-TrafficTypeDiagnostic: CY4PR12MB1320:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1320C3B0267957FBABD96AB8C2309@CY4PR12MB1320.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CswCXNxvcTO8fiQtkE23fpY3ISAgeZB2jD+DlZlY95BXYQnC6bvfrdwrO6Vv?=
 =?us-ascii?Q?hUo1uEUChYvq1yFA6CldvoQf60OKz3ynqr1+n0C1FJGQaZnSJzVlCk2lLn9/?=
 =?us-ascii?Q?W6bJLZ7b/3zRMpolII2BZ1X2RgHUkrLDXr1r9oqrMF9Gg3KOX561Rq4uSeB/?=
 =?us-ascii?Q?kOA2q//HG9RbnSiCmhMEWd+sF0OWpm5oyF7AtWnZTlNPLxxy+gO3X3mgbONf?=
 =?us-ascii?Q?TCDMX+zWnWPBl1KUBYHuZY5SHfbYqpWn+mH4l3oYLK0yWJxn6ZVpUFBXGzOm?=
 =?us-ascii?Q?DqclSVGXBx6ELg8yb8x6i6JpzQobQeda8UxMWDvX+ReLZ6oNkOlATECYZ3Xp?=
 =?us-ascii?Q?oIuI1XTf/IjAf3tZwlCermTOrFKcsL8Jk9FRduppVbc7htp2V1Tg2UJG2187?=
 =?us-ascii?Q?w66ClB1wlYs5RoxESbwXKylW+NiAVyPM5SWMaSoWg2EdwjV6UKnFeIsRX2IO?=
 =?us-ascii?Q?5EYFT0a4H5cg8r0T8oZNrLY+0ci+l5ulS1GuL99YMJvBZ+NIqUqAvvb7ux1G?=
 =?us-ascii?Q?fXTwS/kYO+Kq77KcZ5pep0pbcsxoWVDILjHTZrJuG+ECmB+vvTeOQlWzRARH?=
 =?us-ascii?Q?QqpYCcWwhXT1XU1j9cCFSkSCmGCI8Nm9UPIFbrYtrtlJ49LLAAIuCla/RahF?=
 =?us-ascii?Q?+eIv+ai5n/IUKK0kjPY6zXRk9ePYgYY7ntBmvDmIakUEJ9E3dH0HzX66M5n0?=
 =?us-ascii?Q?NXmHx6yXNjuCMCKmpfE+J4Y1JCs0JUhEmaxJESaboLrDQuwNqV6Jkk2FmUJS?=
 =?us-ascii?Q?HuwvMCfHT+jGo3M3epZsdY7gmieU55oOEwzy3+7YPezkNEW32RO0tG05NKLD?=
 =?us-ascii?Q?ClkYllDDj9GjsrFAbpXn11dYImxNcKQTKNUDdnK/JJUBGnHs5caRkiirF6d6?=
 =?us-ascii?Q?KhJj1glNg0nZJ6e6EvifgmRMaI7emL6IePiGlO+NV4oBT2lGD+33nxFyrPIS?=
 =?us-ascii?Q?E/gZWG9OAy8heItp7KFOpFf5SLqID+OeVQrpZ72ro1FLU5k32Yktg6zTMrNN?=
 =?us-ascii?Q?QUI4yEY5FNT2KYwq8Nnzpj9JAQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(13230001)(4636009)(366004)(186003)(1076003)(26005)(2616005)(86362001)(508600001)(6486002)(6512007)(2906002)(36756003)(83380400001)(8936002)(7416002)(8676002)(4326008)(4744005)(33656002)(5660300002)(6506007)(54906003)(66556008)(66476007)(66946007)(316002)(6916009)(38100700002)(27376004)(16393002);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vhr2cSm/pVrAJttVU2l5wEv/xYaxUYvZ6JCMZMZZo9pnv+9FZei1DRIrw3hz?=
 =?us-ascii?Q?iW3iiQb0pem7kCxBQyGqqVWoCpXaLJ4VbZI/cjKpWWgmDJMAsJDcb/8PFmVy?=
 =?us-ascii?Q?ycRh3zAw/GsLfeRgLNaNv9Vou23hP9xeHnqP0zX4sqJbcI760o6ZZmnDm/JX?=
 =?us-ascii?Q?3th5lXZ1SCcGP//dhTbCMFAkkjjVBaB7rF8TihRzWgEbA/OivC/efnsRjyrN?=
 =?us-ascii?Q?4ZL6UzATSHYiEBeOg6tofXfu2TOzdX5PmoloUegIrhCkT4XgYIZCI/ODB3Ty?=
 =?us-ascii?Q?UDoRpeMbbojTRrvvifZv7QrP9qArwpQ5ZrGbmj/hVpPgzTYUz2NuTanjV4RH?=
 =?us-ascii?Q?qs7LOZRoO8qVB0xnXhjbU6MgTZIj0TjeUP1CKtkKTR5MFc9Gh62XoXH86/Ub?=
 =?us-ascii?Q?IOc3h+jSEzfVEgbOEWSjeoPHygEn/eaWnxM+6obiW5TyReqVHarfZxh2ptYr?=
 =?us-ascii?Q?UpxoT6ypXK7Thd17AWrVRE+3DjUX96TKVA+qphyGYR+5UbtPlA+LmL6BULvT?=
 =?us-ascii?Q?juzjHOE1KGhB8TahBe2BM7IKUtYk0QHZQ9FOowTGySvAGVTTAgE7QNQutstz?=
 =?us-ascii?Q?5xsHFKgF4IWDsKzh/XV5A0FDojtcHDa9q5ZGaIAjjtnPonGXY5FcLZiEGHtk?=
 =?us-ascii?Q?RGvFgUmv5Fr+UxuS9x+xrRjfJpPQxUsPrPOwmNQKqLZCKLy+PtiiLJnJzrvp?=
 =?us-ascii?Q?I4UwOAQKtnaacxZMwCptg75Yr3cIQIBQyAvFH0FjjtFvmyzPpITeeTxY4bRD?=
 =?us-ascii?Q?mIbgvl4AvcRrZMY/5zpP/fCTnaVyFxUuiZTC7GDpAxg7CBof9bouhsj5UyWH?=
 =?us-ascii?Q?zFKfFHUUq7zNE1oSMY1ijrLJIMi6NXkIZercIN1sUO8aGPp0IyFOBlS5zlLw?=
 =?us-ascii?Q?xghinb4ZVTfPw87EHpI9l8rLT3hE6WSC8KXhHauqH7OYYb3+ysxlTrQVRQff?=
 =?us-ascii?Q?kGHLClR5Lu7CtPLqf6zZIyJTG6qOqec92hU5D9VybSEqfjqdVp9y8hvFirDw?=
 =?us-ascii?Q?yWKKLBmQoLngrkvfkIz+SFwW/8NiRa8Xz87GLSPT0vXFd903qy0m4m96qmnW?=
 =?us-ascii?Q?SXP7vs0yjlR/Bm/RDqeuRAt5aeLlMeA6u2jzrFrQ0gZODmxMpjVFqi72mtxY?=
 =?us-ascii?Q?LGyBuajlutuXSt+32WKZwBfyKkfvYCGfe1utOHQTZet8bKam2Z1LZ+6beOLG?=
 =?us-ascii?Q?L6qExy5On5GAv8jSNuITN7hNP2uA7ucAtJDcB2aQUz96Lo4nt+grrfB5ZzuH?=
 =?us-ascii?Q?0JyRUjDNQYefoUW9fN/LCq+2kvNhDHtBQouLvqlVml17B+40S8ykKZXENHYh?=
 =?us-ascii?Q?FnamI610qSPHCJQxBNfXoqYSnK6IUVp9VMKQNzBO9Q90YoTNlAPpLfmK8gup?=
 =?us-ascii?Q?XrDEwfGwSelbaGj5N5FhoX8OyEaJDzLsDw6q6zwxxJN+8Tcx8m+YZqLhYu8Z?=
 =?us-ascii?Q?TEbqlsYD9EQnr2QFLc50IrOCp0CLOzjUa/rHkaudzhBoy4aUBd/HYxfuHehN?=
 =?us-ascii?Q?kjWSYQmQIViZMu0EBtNcg/3FRKBG3ijDZlESFaWrvQSS17hXp35DwDVAtSa7?=
 =?us-ascii?Q?yu573dnZnLnin9tXgD8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d006e7d2-9307-4692-7ecb-08d9ed924555
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 19:11:13.5593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /KMGfZbB4orGF2MMLJiaewyejlaakwaw7aIdPC5VKyj9bPDGCip03FF5JAmZJYJj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1320
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 10, 2022 at 02:49:25PM -0800, Yury Norov wrote:
> Infiniband code uses cpumask_weight() to compare the weight of cpumask
> with a given number. We can do it more efficiently with
> cpumask_weight_{eq, ...} because conditional cpumask_weight may stop
> traversing the cpumask earlier, as soon as condition is (or can't be) met.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  drivers/infiniband/hw/hfi1/affinity.c    | 9 ++++-----
>  drivers/infiniband/hw/qib/qib_file_ops.c | 2 +-
>  drivers/infiniband/hw/qib/qib_iba7322.c  | 2 +-
>  3 files changed, 6 insertions(+), 7 deletions(-)

I suppose you'll send this with the prior patch adding the functions
in which case

Acked-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
