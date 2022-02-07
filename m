Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094044AC9BE
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Feb 2022 20:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbiBGTlJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Feb 2022 14:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240492AbiBGTij (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Feb 2022 14:38:39 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B26C0401DA
        for <linux-rdma@vger.kernel.org>; Mon,  7 Feb 2022 11:38:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIz9zS1qMov21VchxdGuBNDVWhQOmodvUKVPPEZKsTdjpWh5wAd8M2k5okfYI3v+Cdw1lCwbZwpKqu06Mqj07MiWE4BFgYmojJerS87EKJqX5gOSGkk6E88c6xNOayS95DCYuBjZ5+i7N0WhbgzEcVTZY6BfY2v4r4v/wndhxOB2J1ustSl96e//ISXl6IFlM5EbBqELu7L00juuhGTXaqFSEm1FjRoLrUmkLDMyZ+pze6i3aZKONJLR2Wh7LuAN0V4o86TnYUKG7AdsmjdDCnqS3kyhqIGlGLfsJozSVLw4A7XkMizzDIxWEyPYXPeceurMUpR+SQbfflLm3bjpMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2YhXxlqSPQudyErpgx2Zl+j6mPMKJeH/dT8gIltdD0=;
 b=REoJQaz+tHVB3Tp7nJr+/KoxkXmRjGN71+Wth8YZ3N3QTIliPKq9nPbLnkj0xi2KoYje5khMZPgWg7Y4gsBYmMeoGbIzzY1Wcmj8IkZ7OwBS76mgS/7Kz6fRDD56PVXZBOSnlwJAfV86ojwjkgJA6ewnRzLK0o2NHHcqx9xOjG2mXFctqfCVd2RRdwS/iDLh0b5WgjM2iWL2bn4nt6cC1Y9yycwFKASAdyTMTjKDtdxQwoUZa1hyBSlaigXJwUwF83pxnE/pPfZgjMC74RN7iPVHeVig+Yb5OzRPq+PfyluiiXONRwqgtjvjP1zhJZaB2zyBOSG/kk+Ar9spaai9cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2YhXxlqSPQudyErpgx2Zl+j6mPMKJeH/dT8gIltdD0=;
 b=PV/lvyzufu5Nj1K1iAXwFx3910oDpX+H+94ghGD2Y9N9sAvV/mHIdUo5jcbHyFPnvM8GmpG/JnA5GK/JPiWBioVw0oCqGGDJZd28fv98TxOvPOVq8Ht6cilXCyGPLd5cRhMPYYo71mFjHNrW0vAo4e839X2NcakCZxtwXkG3hCPtzsXNuVWf836E4JTTIlPJbMV5XeQ7is/4EqozYwbSaEla1SN06OpgQvypJmiHE7/7yklblrNFW2B0XPKK54Y5lMJBtDyUI3jFQkrl+9p/2nkCCgHQwmUNvvDEjWuW5KK04bJL0OcvGr8B1moIibf4yhNoYdpkqocRKtKglzt0DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB3231.namprd12.prod.outlook.com (2603:10b6:208:104::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 19:38:36 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 19:38:36 +0000
Date:   Mon, 7 Feb 2022 15:38:35 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH v9 00/26]
Message-ID: <20220207193835.GC4160@nvidia.com>
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
 <20220128184200.GH1786498@nvidia.com>
 <9080f698-3b72-36a7-0051-be12f4ce6e28@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9080f698-3b72-36a7-0051-be12f4ce6e28@gmail.com>
X-ClientProxiedBy: MN2PR17CA0008.namprd17.prod.outlook.com
 (2603:10b6:208:15e::21) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a5301fe-2d9a-4383-5b92-08d9ea716ed7
X-MS-TrafficTypeDiagnostic: MN2PR12MB3231:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3231F4CC4654C833267C03D9C22C9@MN2PR12MB3231.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fp9EgyeyrtTiowqDyGif+peY6dvIstDKCfMk+HK/QCXJROMV7n7igwkdKkTm21iMVDRfd4Q5kmvtD5dbqf5H8RwTi0sU9iTPd4QmI1QZmeNXRH3huDcVJrc/WKickZiq/JnflQ0q3u9XSHGZTduy983ds4dMysqbLkG9r/1VQxFI1kg+UCwsxHDEIk+BB/hibNh1ijuycRhz0u2JE6X3f6WZalpRb4mHp8e3XljBkP2b9fXCh5mdlgsVv/c5ixfHdK6Cf4nB08UCefnCT+5FdNApB4tJFo7YokGvRAN9ts8h2JC67V1NwOZhlqojlYGbfP0WqDDH3Hhu+QnPdxaQucCGKFZvq2K7XacwgQVgCVzxXknYByPVDw2ppfdeqUCwtA7HJw0qK8jW8FMt+iLRQ1ueXHLV5d3VJOiAkKVwTIjcfic/0b9+O3k5VIAu7RsJWxLTFEenEGQU36U0G/Oj7HdpnjqqHhPIm5xcoFtq2maOGWMwD8ajW+IUqg0X6MCuc1aConKrrqdjopZvlO5RVbIjjxjo4+51gRwEDGx0b0/WulOZPFSaK5nJQEJPHxSLVkrKztZzDnjppLF7GnAvVXlzhYGMurZcul4NRHksbHR3ppKRVyYz4uu//oTjjUkhBjCzL3Ki/f71/cIhPW6diA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(33656002)(508600001)(2906002)(186003)(26005)(1076003)(86362001)(6506007)(316002)(6512007)(53546011)(2616005)(66946007)(36756003)(66476007)(83380400001)(38100700002)(4326008)(5660300002)(6916009)(8676002)(8936002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VA/lI1rodbr03wKwNnfxuqRZVRBeEIfKiuc6U9fnP+WqD6xHFy4g1jTLnRoz?=
 =?us-ascii?Q?LIrvjnZXNaP1H7oG1y6yRuNOq5PlTyemukSoaCm2hVZzcLW1MeHWlVjiwky7?=
 =?us-ascii?Q?S3G67sAXorD66gS4uLMsvSGqY7zjIvKpN8lj4myQpZXf+9v4necyORSydtH8?=
 =?us-ascii?Q?gz3F34bMEROUsHqYO5vN/M295Wbs3NbcdZn5vJrq/GEwl75wKMVS+EU2vIX/?=
 =?us-ascii?Q?GyFFvsmWdV8X9nh06+Ez6q55SQf9UDdHrXvIWlf07UYvs3UEowIBoyGaOT+9?=
 =?us-ascii?Q?7qLJ86AkxDB4l/bt60KG3rZmAsxx3C9j0Ns0dGorT0f19DRbjRirWdVDk86h?=
 =?us-ascii?Q?jubaLDwHdDssUo/l8jTm6p1TYnrGIzigughTjdHKhzVYrDydEnLYzGEBs8KA?=
 =?us-ascii?Q?lXmFld/C5zmzfPne1v40DG/eM6HG7C1hylUcBtox9NX66Fhc1niyMwPGjTD0?=
 =?us-ascii?Q?U4Wrk0ikVq94S5TXTdNelwzx5NjSUTxUW374R1asEEM81v7eV2AyehlzKrXL?=
 =?us-ascii?Q?lWWH2mehRm2ExCAA3LaiGTADCq+7uK7jK/F3qTh7TM6mnBkc+EyOtsmG8ZNV?=
 =?us-ascii?Q?09Mna1xKA4Yg+UmgsRaMIsmKBQQ2QBBoK+oJfFlI4BUQlF+/9UTI0CRuOv20?=
 =?us-ascii?Q?EEwgWCGKngbIjp5PXisCTZ+oQtFixw2tQHoYn2F2UZ4vIu2l7RycW/spkyP0?=
 =?us-ascii?Q?Hp7L+ZRb46RohqU+PqTt6EoosGcZRhosph+1a1IhVWxD9KsSi6LUND2PdcYk?=
 =?us-ascii?Q?Ap3pyNW+eI5NX/odsphQt19rinU4Fs3ct7ViU03tcV5nDGbg9B/u/ZmylH4P?=
 =?us-ascii?Q?f0N7Bgp85EiN+dxWrNbKQ+UwNJtN+r89q9ueuJQg35b25EZghXbQKGCCguj/?=
 =?us-ascii?Q?AKVjystPplXHAMLO82bNXHze0QhIvudPSb7OIlF7V1ua9nnq4eQYvJIkzN14?=
 =?us-ascii?Q?EsX3LMmGuPsar0Zt1Zj4V/BlEef8GJ9OgVmc4hLXTZcct+VdZzSv6lbAgUs+?=
 =?us-ascii?Q?S4MaOBeYl3EKT8PYBqQ4FfkG/oMtEm0ID2uUrql+eydDyNfuiT4DzQ+Y0H6H?=
 =?us-ascii?Q?GuOjfde0u05pXF/Dzc65rJFmLGzkvBP9Vl9r6LIjMzDOqcOZquT/QLbaPPAs?=
 =?us-ascii?Q?XU2Y8I7uJySblE4SFgI0wJ9B6foBk5XG18ZVPtt+jgLXzbtTnSCdsg/PYKOS?=
 =?us-ascii?Q?9e1zjLFkYvnQtnI+cZeY+gny+XXlOZ8yUo13QB4C7ZC4XHCnOQh+Qz5zSrl2?=
 =?us-ascii?Q?FWxIeFP+3W8TevrCzrp4mM44cbee+a4CNAE2VL2udi0GdYxQ7/pTFKDOEKyO?=
 =?us-ascii?Q?lQFE8JGKs6Xw4hS47Sp6sXyQV+rZrMz8QP5blPs8TCX0h7W+hJOVYqyowADL?=
 =?us-ascii?Q?T020jWvmZVXeaMF+USgP15yV3Dn8o0gZNsEpCtfjsEus1wyJ+vTHMZHyT1ZU?=
 =?us-ascii?Q?nbXOOh4MgUoND1h0+gBJlr2dbktAb+G4IXUuLuTUkQ6LeFpLFRkssgdORkiI?=
 =?us-ascii?Q?DEjJTETltyAd6+i6UAlRrlkI7bUDxJwHU8e7EzLOYWZDB0RtPC6TGlJlw2PH?=
 =?us-ascii?Q?nhAJjbAqEIDZNwjAEpM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5301fe-2d9a-4383-5b92-08d9ea716ed7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 19:38:36.3478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGcsm0nBor1Q7X1zbHqS2evQMNkrdm3la4W8ye4tAad4C5Ip0qt0Y9cHSbs0X3z2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3231
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 07, 2022 at 01:20:32PM -0600, Bob Pearson wrote:
> On 1/28/22 12:42, Jason Gunthorpe wrote:
> > On Thu, Jan 27, 2022 at 03:37:29PM -0600, Bob Pearson wrote:
> >> There are several race conditions discovered in the current rdma_rxe
> >>
> >> Bob Pearson (26):
> >>   RDMA/rxe: Move rxe_mcast_add/delete to rxe_mcast.c
> >>   RDMA/rxe: Move rxe_mcast_attach/detach to rxe_mcast.c
> >>   RDMA/rxe: Rename rxe_mc_grp and rxe_mc_elem
> >>   RDMA/rxe: Enforce IBA o10-2.2.3
> >>   RDMA/rxe: Remove rxe_drop_all_macst_groups
> >>   RDMA/rxe: Remove qp->grp_lock and qp->grp_list
> > 
> > I took these patches to for-next
> > 
> >>   RDMA/rxe: Use kzmalloc/kfree for mca
> >>   RDMA/rxe: Rename grp to mcg and mce to mca
> >>   RDMA/rxe: Introduce RXECB(skb)
> >>   RDMA/rxe: Split rxe_rcv_mcast_pkt into two phases
> >>   RDMA/rxe: Replace locks by rxe->mcg_lock
> >>   RDMA/rxe: Replace pool key by rxe->mcg_tree
> >>   RDMA/rxe: Remove key'ed object support
> >>   RDMA/rxe: Remove mcg from rxe pools
> >>   RDMA/rxe: Add code to cleanup mcast memory
> >>   RDMA/rxe: Add comments to rxe_mcast.c
> >>   RDMA/rxe: Separate code into subroutines
> > 
> > I think you should try to get up to here done in one series and
> > merged, it looked OK
> 
> Jason,
> 
> I have these ready again. It is a little restructured but gets to the same place.
> Last time I sent things in you had a complaint but it got mangled somehow so I
> couldn't read it. Is there anything else I should be looking at before posting these
> again?

I think I said you shouldn't re-send patches I've already applied?

Jason
