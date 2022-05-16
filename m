Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56935286AD
	for <lists+linux-rdma@lfdr.de>; Mon, 16 May 2022 16:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiEPONF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 May 2022 10:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiEPONF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 May 2022 10:13:05 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DF532066
        for <linux-rdma@vger.kernel.org>; Mon, 16 May 2022 07:13:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNb7Y60G9uEnVS9fEjBCSp1CF4KMXEqJuhsaLtp6PIiW1hXW71TEtbls86hdrtSugqAYITtFKJLyEjw4ldhy2KtgAza6sx2RzjCVDddrq3BrYDwBvm4kkc/6ugN4Pr5a+VnoFOmHSUb7RYRwQBiw+RGdUTwup++WLUlQaOwfR2w131RA5BjZeEa36XQcTuTAWPLqHbiUBTf2u6UfTniczTf57UIwhrOFY5OHga70lvy0HInkU1mWzGuj578l9QcmYvGO+Aq5UvMX8Q1r0Io+NBn1UyjsVWS+ZohC737BQPmgnBw5U2VTYDxsoibPFEES6CUTdgoogYNR2jFvN4R/+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TJstTC1j2HvEZQdT+H+CKDR43G/pkW3PFM8sq+7wcE=;
 b=WIagrWRaRJaXrPSzscVXbPyM9TFH3aFOQKPlpbVrYqzvJ4BhMeMQj44Et7i3A1D56IbhPWaris4tkfIsGSEqnkND8WFXNIfSIkQdQYkwFcrW7XkJq5bqbspGebCmYFSwg9/leZ42FsK+W6r3ezXQ/jljXVWvQWzZMctwC9CMc6SavkqB9EmmfDSDADNmyxtWwWu/qj+XTs8zjflyXY1gdgyMMkSk1+k/tr5qpuejRS7LGAkMp/bX98akOV9HhTffuczBjmadaUkPrsqyliXvxrD3FV2kNBTl1CEtRYgqjXqXRrqfu00zK6CDF3C4ZZSCzuV5JFOQvlVBiw4WuJ6z5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TJstTC1j2HvEZQdT+H+CKDR43G/pkW3PFM8sq+7wcE=;
 b=QvWrMV6FKaa59psVcRcughcYMQxUMw0rIDg61C+PH/sd/s9HQBfLf4eKG8mItKOVHTdF4uO6lILhI+3ReXYlFfsen5Qm/M2VHh4KitI+U6R0BjA0uvpW6NPSv6lrW2y5u/l9CiwHkwVD3Lzd4xW5abRTqlkn6I/wYvggETS9eRiZLPe7H491UPbuHFEQ6d97lHbSHuFfGjMndKpeKFa859R5DLwkxdR3ucyWaKfzwBzPGhCkMnzg9nIAj0BYPJALe/5PNbG9SQccOGpl3HIcErbOKNDiRLmQ2Tss+hmxPqZfwc0QN3OeoIuJ20aAcX2ghS12L2GJctdfNGG1SQ7gfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Mon, 16 May
 2022 14:13:03 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 14:13:03 +0000
Date:   Mon, 16 May 2022 11:13:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com
Subject: Re: [PATCH for-next v7 12/12] RDMA/erdma: Add driver to kernel build
 environment
Message-ID: <20220516141302.GX1343366@nvidia.com>
References: <20220421071747.1892-1-chengyou@linux.alibaba.com>
 <20220421071747.1892-13-chengyou@linux.alibaba.com>
 <20220510131841.GB1093822@nvidia.com>
 <cb86ec72-5878-6bba-1f4f-e0c2f25e45c9@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb86ec72-5878-6bba-1f4f-e0c2f25e45c9@linux.alibaba.com>
X-ClientProxiedBy: MN2PR14CA0027.namprd14.prod.outlook.com
 (2603:10b6:208:23e::32) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72b27b51-6951-4ab0-d915-08da37463095
X-MS-TrafficTypeDiagnostic: DM6PR12MB4186:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4186413D4737AB3ABF1E01E6C2CF9@DM6PR12MB4186.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PomUUUVqblYNvo3yhCcQWz/1w3LE2Qfe/LChvEYSC5MvEwNu/0eD5DQYd4rtvDIYWp6gG1eXMgTL/AkAYBIiTlhUjT2CQgV/it+d/xBmMX0YDZEocKh4zOWSDu5U5l75vv2Apjj1VlfqWpl5aZT9mtU4EdU7RZF7bCou2FznAK8GH9dQ8oEnybyoGs5qAcI+kck3510b7pnV0EY7JNTX1NFZBoOl6oKiE+fp0ort7sJtOrwKU7wHsD+OPuL5fjL9AzxoFvzolrSRce/zVD6gIN7OW1rKxOx7acPQ8M6idtmVTf2pPjUros+UPwauSkpoktP+d6iecgQ61F15U/lBySI2UovwsupY/KuQrEImPCVhy5zoCiHbnVzPDUVV/VIw6GgHiW0tDLRSQZ2nJ6IL1JZqBYpJZlITzAqMuG3xsIKBwJevckfIu4WN4XhtOWgSVUUIvPSYcbouyY/TN28H1arfU9OCJuI4vuZdWp9fb8GZPz9HwvYWN7LqnwEV5q9xVdUq1rSDDL+IS3JY2cTepu6oFiIYah6ocpRanVtBmEUWAoV+DJMbIGOYl1JYEBFge49wQIrsEocm8gN6xRHnrfehymg2OFz+knCl816cUJpeItgGldrwUnJaPruInGUwU0DwVfI+oRYnePvwpYdX8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(316002)(2616005)(6512007)(6506007)(2906002)(6916009)(6486002)(8936002)(508600001)(66556008)(66476007)(86362001)(66946007)(26005)(8676002)(4326008)(1076003)(186003)(38100700002)(33656002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?clDviFg7CVby4egZYSbC5HWALS2wDXPUiLaKNPpxHP2UyWCFmVHFd7QOBew2?=
 =?us-ascii?Q?nJct/qlw7BDKr1slaElQpoN646pjcGpbOsxt0Ej3FSsa3Frp7GrHHqkpk8/U?=
 =?us-ascii?Q?S+wJacoKVnWanTTPuY750SDnpkJOhNoV55KGC0u2RQ/wX1kFbi/hNHgRSDui?=
 =?us-ascii?Q?Nq+XT+egnIZGCs1UbQeNPIocqryFpIcrlCy1IL95Kw91ZmXiO+Z4HGSOeuTm?=
 =?us-ascii?Q?50jhNV5OpfIMTTHSUwQLLWhkLdz28U1mTyzFlQk1EfZQoCe731X0xghabqS2?=
 =?us-ascii?Q?1MFaWu4VJ2tmBQ9LU+kD5L+4C5s/VAlnozJb+lA4K/hn944cq67KECbOVKBR?=
 =?us-ascii?Q?SLzVvINAGhOofDe/bAnu8GLwyxK5iT1A6O/qjQ+cfyzLTmc7W0KfMjdSdj2X?=
 =?us-ascii?Q?mVB/SHLvil5fz/xn/BjWGKYY2Mv1UmAzzIXsLG3bhOXo4stiPeyRWb8evr4K?=
 =?us-ascii?Q?pp3k63dl0SfGEofIQndEg0CqoFC9qUWnYvEjKxjvYNwlBSYRju/wu+SSmwld?=
 =?us-ascii?Q?KCLdN4b8uUVzbed3U67+brRaYbG4IsZDnPWGf6SLc8hV/6A2PY1JJbM0vAKd?=
 =?us-ascii?Q?Esk+MPQb9hOPnODZfa2WhKw73+2u9v1xHonjK0wXIRh7E+huhfT9Ke0hOT49?=
 =?us-ascii?Q?reRLeVushA+YrVGc0XaBbW0j3TJ7d4KgKphYckqP463oDFR6gV/f9LAex9l4?=
 =?us-ascii?Q?GozDSrrQDsraKefU2UjRcN45Cn7WEQGsSoKwiy8E+NGHTmmGe+kojOCROIs8?=
 =?us-ascii?Q?kkmaLSBuTPo/Fy2bSnBjF/DnqvEgIrPclikZRxrPnvrSIasKajFUuPEw/Ada?=
 =?us-ascii?Q?PSSfuw7E1Jc6zO8LYGoy90z9FdSWv8Gnog7Np5TnWMxBKTcag8d+egMRnh1G?=
 =?us-ascii?Q?iWIc+qHv0jfbCr/7B4J1pARdSUTiXG/Ui2Vk7BxqOn4Q9URaojOkX3+t2okH?=
 =?us-ascii?Q?SuHIpdODL9xqjUkJJ62UJ5uEhjMvY5tv12HBFgaCD7jAX1I4k9APW0KUnxoh?=
 =?us-ascii?Q?82Eig9KO5kIZN+fqgAErQ4QVKqlvkUfz96vcMgSE4ynTMvsF+xFEeQQmj+FN?=
 =?us-ascii?Q?g++T4gzDT0u/nUs51ofBM+15XS8TEH1UZ8AbxfDNZ3QeWzrSrEy3tvH/9Pfc?=
 =?us-ascii?Q?AlWj4vnIggyIJE1FdNCAdg5jPyWcDkFt7h2UjdLSP5GYzsMG/wCihrBqxUwz?=
 =?us-ascii?Q?vthnz9qQp7ZGegq1UfEXLuifAlXOxbLR/aTUydj9kanb+s5A5D8VJoN8TTg6?=
 =?us-ascii?Q?EO1VYa2QV3Hh9iXdsk5rnAwcVxRZc7zF/UHv8j1XmlZIr3rfr4u8TVy730Pb?=
 =?us-ascii?Q?3m3KaOgDb/ziPlzW+6RxIKjFlAMrVJbQSaE6XSbQ97Fv4zbn2cQBjac2Zhi2?=
 =?us-ascii?Q?/HjldANq4p2dnqHfAETAOqr/lOgyrmLTjJhBG9hpTXOQU7H4Nj0BpEJseEqw?=
 =?us-ascii?Q?i7l07bs5Avpe6D2VCZu3xD19ETizH1t3xwswCNUJebJa/BZeWUiNfPlQoN41?=
 =?us-ascii?Q?GoAj9F06whp8kcRrxfX0RxHEB/zVUJ1gEyFAJOnFkS8+CKbB03dkzHyieOOw?=
 =?us-ascii?Q?JGJAb9hIAL7sOM1YO51qe8SS/APwQ0N3o4WnU+8B8r+Zu2WwgUPD4RpCr6pE?=
 =?us-ascii?Q?DI9fIlwZkhg6mrnxfQwgtvhvzl6VaXuaFWEchiApe0qH/H99nGfRGGw55UQL?=
 =?us-ascii?Q?2LX99hLcVO28OXwC200J/Y51M6Vk9Rv9FEEUbnOIiT+G6C9PRiVy3zN2Jd8p?=
 =?us-ascii?Q?/KyWTkcKNA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b27b51-6951-4ab0-d915-08da37463095
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 14:13:03.0117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqugn3M3xqf6KZbd3bZTb+Ca07U5EW+6fekEQB4ndL57hN715h5pFw+snprlK/R0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4186
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 16, 2022 at 11:40:46AM +0800, Cheng Xu wrote:

> > > diff --git a/drivers/infiniband/hw/Makefile b/drivers/infiniband/hw/Makefile
> > > index fba0b3be903e..6b3a88046125 100644
> > > +++ b/drivers/infiniband/hw/Makefile
> > > @@ -13,3 +13,4 @@ obj-$(CONFIG_INFINIBAND_HFI1)		+= hfi1/
> > >   obj-$(CONFIG_INFINIBAND_HNS)		+= hns/
> > >   obj-$(CONFIG_INFINIBAND_QEDR)		+= qedr/
> > >   obj-$(CONFIG_INFINIBAND_BNXT_RE)	+= bnxt_re/
> > > +obj-$(CONFIG_INFINIBAND_ERDMA)		+= erdma/
> > > diff --git a/drivers/infiniband/hw/erdma/Kconfig b/drivers/infiniband/hw/erdma/Kconfig
> > > new file mode 100644
> > > index 000000000000..c90f2be1ea63
> > > +++ b/drivers/infiniband/hw/erdma/Kconfig
> > > @@ -0,0 +1,12 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +config INFINIBAND_ERDMA
> > > +	tristate "Alibaba Elastic RDMA Adapter (ERDMA) support"
> > > +	depends on PCI_MSI && 64BIT && !CPU_BIG_ENDIAN
> > 
> > Why !CPU_BIG_ENDIAN? That is usually not OK.
> 
> we want use !CPU_BIG_ENDIAN to disable the erdma compilation on big
> endian machine

Do not copy this

> because we only have little endian machines, and don't support big
> endian machines. I have no idea why it is usually not OK, could you
> explain it any more?

It is considered bad coding practice in the kernel. Write the required endian
swaps.

Jason
