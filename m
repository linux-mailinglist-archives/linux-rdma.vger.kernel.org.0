Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD15D66DF3D
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jan 2023 14:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjAQNsV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Jan 2023 08:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjAQNrs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Jan 2023 08:47:48 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C689F3B672
        for <linux-rdma@vger.kernel.org>; Tue, 17 Jan 2023 05:47:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUH0cE6uamCMQIYVrSSLbYlBSSyopqu4HDtI9wLPGzona8EaeOEk9eJq8z5rswtLCrL4QHwbY/gMEmIzjb255Ur3jB/vpnFaF8vuyB907v6Flv7H1J8MG0lDa2DrjqInxbyS7KkICMx3jx6eywOUJzNdLRcL8Rxu/uGZ+E1bhB6xXZMnzOxFCQX/EJHLTT6aY1HcfMBBRgpln1i6Dpq8OkAkkxpN91UiaOod6juCBPU9L10HUa38tYGnn/VHUJkzb16gMgdCutLMbGx+1zqq3DqMvyF82jzzEfV7WStGhcJ46eth6J6wqeTYwpY6XaN0tZ908ZtdUKS4kZfucKHuFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3iwXhmms9dLrlLUViUTHOHQJ59lH6S1INmX2/CUmhs=;
 b=Hjf8oxIlifP0/eoDPT/87noMHTvDy3MFPB3P3ndKqg8zipzfeCrGMyKhKwOp9tBgkds0yV4ijomf3oFNiVR7O+hxeWRfw3NuTkwMfRTAeWgHNafEpSNnaiwNRD2JERrra6WWjdjM6sMeGduXpCKqJ38XUBMPjeQSpr8F0rL5Y/TwRfHDUFNslGfO8aeldYboZetntVeEpW8nHUhTwvaIgZlLk+xDUflcrD44Zu44Sw/hkcL6S/J8TvUFkM1UOZb0lN5fs5fuipjPRtsxP+6SwuAYBBnIAik9jrE4ZdKvzsf5If0h+sgoMd+EYGNywTyblUGJyvVqIY48c1bCD7cpsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3iwXhmms9dLrlLUViUTHOHQJ59lH6S1INmX2/CUmhs=;
 b=HaZQcFFZTKcBmPbs1TiDloNmoyxjwoTnCg+GCJRc2Lp0FHb6YND0neYRpxHuRG9zIzst8X6yQfOAZLNUkc2O/fFb2lb19pLwrX1Ah5m/v9K7SagWcR4K9Ssq5xq/ha6WBfg2L5LCAINPWC6Z4rk7dbJapYouFeFBA0VPDTo4Ivjtq61WKs3MXTbItzdLr04K8IsUE9gAJJlQWrGAWWiILEUmgXdGzo3UM39+0pO0jy7syKIo0Qo4IgiNjbm36ulhTPgZhJtqCs4gC+WPk7OZHqjuW7Xg8ZdM05+23XvlaH+ZBUM5or7L8sb7jYztmMMtBFo5FceV6+T9SNeK02F8KQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 13:47:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 13:47:44 +0000
Date:   Tue, 17 Jan 2023 09:47:43 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>, leonro@nvidia.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v3 4/6] RDMA-rxe: Isolate mr code from
 atomic_write_reply()
Message-ID: <Y8am/zTHUWDIhBos@nvidia.com>
References: <20230113232704.20072-1-rpearsonhpe@gmail.com>
 <20230113232704.20072-5-rpearsonhpe@gmail.com>
 <CAD=hENc4W7ZXCa73oOnKbspf9TeVdZ096AYwHGp-HEtoT+m86g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENc4W7ZXCa73oOnKbspf9TeVdZ096AYwHGp-HEtoT+m86g@mail.gmail.com>
X-ClientProxiedBy: MN2PR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:208:fc::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c351c4a-22e6-483c-9f7c-08daf891694d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cs/HHC2TN4x2OAyGz7IkozX38yXKI42x5X6d1DptcU+72RSRMY6cu6e/SPAs++wH/wvOGG7O+l4CBv7WSlkotrVDmHIymMc9CHFclKSPEEbSOFEb/gfrfWVjU8bM7RM2AKakMKVkpW+eGTDo//rHm6Z+5TcJ3saiQ1tJWd9XbBHdrp6+Z2bg+CyS37/JGD7SbpIp9n/gZ7VS+XVAMitzXlpVE1RXog8ZxnAMXi5QdMD5xVr8/yATw4ZXfXSimA+rZJ84r1pJvP8gngP/vRfQzxg4yzRrnpC9X5fqIQwGBcipnejskbXs3avlt4x8qbhveW1JB0prKH5IM/Ftgd6lTizI3tjepdJ+ZQq4Vow2X0ZnNlu8hQpRk4qYR88zpi0N9DBoQDcbMWkPUs9JBuXkb7Z4cTfr7WenJbvIeG4TOKCU99z+BGshdhO+aeukAUY9TGWIzvRi4tmyDzTMsb8QR7zrFmCz8cV6FjxZZzYk7FIZBCUYzo7LAZo+Yk7fIwGaDpGUVxM1wr8DWok026O4+RKXwL2WZcELZthFnVKevJY0C2AUeyJGS6dKz5eM2/RHCSmutfHPpXngP3EREZuxQTCo0jIaWOlridIsElafgIUBd3JvtcbrkuAoJdsHcXdguykVPhKroS/AW477hnTKKfzXGGQSS8kE7pw9liCAmNEsTGiDiAVFEL5LjvPei5heL7wUKdNRgBhQVT268Isk5jIraXJ1tySIkMPrzjcm1AQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199015)(83380400001)(38100700002)(86362001)(2906002)(5660300002)(8936002)(8676002)(6916009)(4326008)(66476007)(66946007)(66556008)(478600001)(41300700001)(26005)(6512007)(6506007)(186003)(53546011)(2616005)(316002)(6486002)(966005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HaGZYzvpEWAlRTC+FNPISNxVW+QMrpKi2llnHBG6+e+3/LDvOlyW1T7TLbnX?=
 =?us-ascii?Q?4eQSvw+NyhlvottacyncU91rDD8JgvXx5qTkJs8L32g9nyhhKQhWh4VqFE5F?=
 =?us-ascii?Q?lIBj5sUd4k/wMF59Baapv+o99qGGU2zsps+jwB/dx1ouC1/VA+IVT8Pxa1gA?=
 =?us-ascii?Q?vtD+6L40R0e0EtW9VdeyvydEEjVQQ9VDz3w9T59cMJ+6s8WYfGrm/eJsNoDw?=
 =?us-ascii?Q?p+soUO5oV3yYU1W4ZYKP0i4rU0aNU42//2bfQM8CpU6FEP2+Aet4mgKiZsSr?=
 =?us-ascii?Q?W/zD7HQK2eBY3U7mSZWNL/1MT5wS/+6zzu6HLWyxjYOhRIfWDAPkg9b+mBOu?=
 =?us-ascii?Q?ilQm/HIgvHe4cAVZocXUuSbHazbm9p9RZshiVvuQ64xXOZwgf/PUSAcetXIK?=
 =?us-ascii?Q?1ohKsqP66gyZ5C+NM46JxUlODHRH1ljHtnS3v+26wRrmEwj6MKtjXb5LP7Db?=
 =?us-ascii?Q?K7tLLLumFsrIalcK95Vmot+AYJbb9Z6cnmrI+BcBiKQQf6HUIhw8+sr4aO85?=
 =?us-ascii?Q?mhDyqbaH6KK7/lVPloDRPzeMGMjoWBSQYY9NmiQEJ8AAk2VOxqMDX1qyfFaA?=
 =?us-ascii?Q?ex4RAoQbZdOgxl5ZARvfCVm73nyTYJ934/x2icZ0eTetty8ESzl00tfpFgaa?=
 =?us-ascii?Q?FIy1DvqccCozkyQPMwins/6LB6gENsV5UqaZti14yswyLIrDJEent228u80P?=
 =?us-ascii?Q?IhKifwju84x0DiZNpc3G8wj/+SJdoZaqhags0KNGY9LEwKCoD6b4G8TO32PW?=
 =?us-ascii?Q?jV9NUD/07H8Siyz3CVHy7EOPjbR7RFcz0MWsWsthAGSozXrvzlbJTHHFGHyz?=
 =?us-ascii?Q?yIcqY5z1rlaG6R71TB4KFLbq2qCjmVYcsdqdsmPWrASt+LE5bPOz01IDN25F?=
 =?us-ascii?Q?sZ9REx6QGII3vFdt9hhpYXqHtj2LzrK+1mzGMKSQhev2jT4ojcCbgpwleLL1?=
 =?us-ascii?Q?SGMJ6TCkiwvu41unir8aPBBMv19L1BKwHfB5vkCvJCA+EgSczKSBOpi8t348?=
 =?us-ascii?Q?2pwOMFVz0zSbLscG4A5DYfqMbve2Vre7x+SHKDfkAvLSjm79eiHC1Npwqt89?=
 =?us-ascii?Q?0Sw438N8NRT58iycq2uhG9Subl4FzcWnv6CMQeU/Sp+PxW/znZ48KOuf04Mu?=
 =?us-ascii?Q?d0KE69imt49yIm5hLTzWF5ifPkfsiciG5uqaiUhSjVoGlE4u5UrNjEHmEjwG?=
 =?us-ascii?Q?gP4D7//8mmY3Xe3KG2AFEVuCZ2ru8Bsvn2Lj6lWQ8NGOLUC74ei7KsngCOdf?=
 =?us-ascii?Q?JIsWDSVBE607XpFbVYOD9NtnKTAMXmASWhWcPBfbSCzFRwNzpesghfV0O4r6?=
 =?us-ascii?Q?QNs4sOM+p2uaBEdrHfEwkuALpc7jF8ashC1hvC9kOPM4mLtTQCuhwHIW2qGP?=
 =?us-ascii?Q?Z5HaPKAyyKyX7hl73TQZMXmsZCyishjlEXBljoItL2BwF3HZqRVpF+sQp3iJ?=
 =?us-ascii?Q?Rkr/0WJ15Ynnv9BXuaSKDMjn7U5i4CD9F3y3oyK3u1F845qxUJCoJQlwkw0I?=
 =?us-ascii?Q?BfR5j+sTrOeIEAPTn5StWL6eS5C+zb2ZR7TNIhk5G2i0l2gUtcmzRlztplt5?=
 =?us-ascii?Q?FQYrVJdUe4CeIitcSu3B6eYZeNPDcQzhuHVvj4yx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c351c4a-22e6-483c-9f7c-08daf891694d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 13:47:44.8393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+0cFV3kUCOLxP3aGschhhywV4L610yFrp0fLfh+CFAdh4oeIjjPfc2WLDmsYXqm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5730
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 17, 2023 at 09:36:02AM +0800, Zhu Yanjun wrote:
> On Sat, Jan 14, 2023 at 7:28 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
> >
> > Isolate mr specific code from atomic_write_reply() in rxe_resp.c into
> > a subroutine rxe_mr_do_atomic_write() in rxe_mr.c.
> > Check length for atomic write operation.
> > Make iova_to_vaddr() static.
> >
> > Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> > ---
> > v3:
> >   Fixed bug reported by kernel test robot. Ifdef'ed out atomic 8 byte
> >   write if CONFIG_64BIT is not defined as orignally intended by the
> >   developers of the atomic write implementation.
> > link: https://lore.kernel.org/linux-rdma/202301131143.CmoyVcul-lkp@intel.com/
> >
> >  drivers/infiniband/sw/rxe/rxe_loc.h  |  1 +
> >  drivers/infiniband/sw/rxe/rxe_mr.c   | 50 ++++++++++++++++++++++++
> >  drivers/infiniband/sw/rxe/rxe_resp.c | 58 +++++++++++-----------------
> >  3 files changed, 73 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> > index bcb1bbcf50df..fd70c71a9e4e 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> > +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> > @@ -74,6 +74,7 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
> >  void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
> >  int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
> >                         u64 compare, u64 swap_add, u64 *orig_val);
> > +int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, void *addr);
> >  struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
> >                          enum rxe_mr_lookup_type type);
> >  int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
> > diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> > index 791731be6067..1e74f5e8e10b 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> > @@ -568,6 +568,56 @@ int rxe_mr_do_atomic_op(struct rxe_mr *mr, u64 iova, int opcode,
> >         return 0;
> >  }
> >
> > +/**
> > + * rxe_mr_do_atomic_write() - write 64bit value to iova from addr
> > + * @mr: memory region
> > + * @iova: iova in mr
> > + * @addr: source of data to write
> > + *
> > + * Returns:
> > + *      0 on success
> > + *     -1 for misaligned address
> > + *     -2 for access errors
> > + *     -3 for cpu without native 64 bit support
> > + */
> > +int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, void *addr)
> > +{
> > +#if defined CONFIG_64BIT
> 
> IS_ENABLED is better?

is_enabled won't work here because the code doesn't compile.

Jason
