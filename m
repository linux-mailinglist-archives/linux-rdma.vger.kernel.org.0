Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260404B2609
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Feb 2022 13:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbiBKMlp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Feb 2022 07:41:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbiBKMlo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Feb 2022 07:41:44 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5198CE62
        for <linux-rdma@vger.kernel.org>; Fri, 11 Feb 2022 04:41:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwKEpXxnIzXuldRA48Hui/r70Fi/M3PNIA+sHrJhXEL5soYcEtinaNwg/iSGdRwF3Twrms/HEmCB5RnC5oR2TTHuBJFUwmYRoInIYuglay7MiPnGSNRN3t6n3ks9wl3WCHOhhwe5P+essyghRjaWqe/Bu5wF9spEH9E1+8Zb4F/JfnfLm8z+RRtk7heMexuwfWf9c68HCunMJcgljOCQelf0UcSUwg394gzFKp+nmrhSE/G5vlZvZvjIXepIg3EprMBvW+36cVyJOE8/AQ+S2i8AP6ravKgxTgXIkhgaGVHANy4w67uHRJz+Dcx3qLvD14eCKuZ5kD9WoNCvIOt29g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCtSWsv53qIAy54DCnZw1I/1moTdRuYfi+m/gFnJuUM=;
 b=EwhwU0eXPG2ehua5QyLfMk5pNx4nv6RGO7ITuFEEjOxpt9NVAwo4RhPV/vV/ozW11LyHkMcCTnDO3kvLbtJFldSGN4xpicJHUzbCYT1rBnFPCgwjRG3FUPHDmR1hAwANzpQ4P1yqlrVwKHNG7Sx3VzJifyLdGG+P6j6uPW1auQ+ca5X2KFhcboegWVI3fulBH1FE4BBUR/6Rh9Ar0QfzKY8Ke7rQU3VKwqI+HIAuhO+OePMlocLHgFx51wJvHKEYsaQ7D82loqZZF8ZDJLUJfWRFgXB64hRJUKuybHKKW3PKxHr8LxY82oL3fuxDwlwpBlnYjVTE5aTEnMc4/vtecg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCtSWsv53qIAy54DCnZw1I/1moTdRuYfi+m/gFnJuUM=;
 b=B7whl6nXDaGQ44JQP6casgSCCiCzm9d9FPKdiMoP7JKK8K+pH5jiaxTpsAybcHGpFW1n/e/niZ9C85lDfr6LqwPV9VX/whc8mNStDl/DcG2YF9gM5z+q9UshkuN1Q44XB5AuZB+v77TpUpouOc7Jy4Pgjc3SDjomkgrrws9i6qZ97jr71N4xgg0Bn5t88E4KrrkGVYkdurc7IK4lsYkzGRvNnpScqSEbpgle9j058uzL/AkV1xDVe6Ah7AEqYLCwulativqVfdwmclG4nJcHrsv2iS8829gjPkDdV0CSzWjCnseJD8e7Lsk7z55hW62lcDTcjCeH/wFqqocoKwNdsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB4214.namprd12.prod.outlook.com (2603:10b6:610:aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 11 Feb
 2022 12:41:41 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 12:41:41 +0000
Date:   Fri, 11 Feb 2022 08:41:39 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Xiao Yang <yangx.jy@fujitsu.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-core] libibverbs/examples: Add missing device
 attributes
Message-ID: <20220211124139.GL4160@nvidia.com>
References: <20220209025308.20743-1-yangx.jy@fujitsu.com>
 <YgOCXCXWyCTxvva8@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgOCXCXWyCTxvva8@unreal>
X-ClientProxiedBy: MN2PR15CA0027.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::40) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67df9c64-4e79-496c-de3b-08d9ed5bda16
X-MS-TrafficTypeDiagnostic: CH2PR12MB4214:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB421458680697A6021FC00071C2309@CH2PR12MB4214.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VSRmr38uqe+KavJ8mh3jsEMdZKCJhKeLZpsGeF/Qejas8ion37fh57xhiQOZlr0hLh8nRgcXxxoatb5mWYkRZLBvwobh6pqHdUfnTbS5Jv2G8SFM9W+G4hdTyA6w3zwbD2IwuSCriX4JJ0Dy8AgRGhyeGNAge/jVsF+xs+ZFJcSRlEIdXo2VX2iDU30psOeupJtr2hnP6jJekcKgJtEfalkI9pFhVFIy29xV2SehF5jp4/09UZXoq5Bv4T6/dhPRjd5whyG2EhMEefYoC2H3DAT+3JQi5W4aAmoWQvN5+Nh0R1SjFGhgQ+dvuJXHmHhkJzd36iaW04YNV6yaHhpLpJWLhKVSw68czRuHw+twK4YidG1BVgCv2fyvGPg7KYZZ5LgBMbmiAdelBXcmG501I+qA8wY9oGoM1fb6+civ2Gz7DbIbVqO27nwVV53iI03Z5HmPihGC1I/m0ErJqIvIlrUau67x6C2SiokOdpZWXHjt0IfsMCjpBrCkAmE41zfU4exPWPgJJBiZKCD/Zm44Ej00BDQkGKA2UY1jXIdVFCNp7JlrWkAl0O2uSk3x1a3RF9pWJ4jKjD/zM988HBJfHcSrjvH6WLAX5tJy5UQOog1WzwkfgC9WKoQ1u5t23JYgI3DKZh1E/imy9PMHkd9YOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(6512007)(66946007)(5660300002)(33656002)(1076003)(186003)(2616005)(26005)(66556008)(66476007)(36756003)(38100700002)(2906002)(83380400001)(6916009)(316002)(6486002)(86362001)(8676002)(4326008)(8936002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l2668f+aGojmPGXUytIaSJ7GopDijvArc5p6jqglhUspGm+MAdoqWYqUWFME?=
 =?us-ascii?Q?1nstW5D2lHwN9bGHnfRFqeGARvdwHBjH0p9C+dqv599nxafeb5Zso4/t4a1b?=
 =?us-ascii?Q?Dl2K4GZ1dZcc3zNtL7yrxNeNVKLhJRbJqcy20tfmddQ18q9seK4FNMTopr10?=
 =?us-ascii?Q?zn9Y/mME6w8SIaaTMpLu4DC3rmkq866028bUvOjAH5uF3bnwG7qyAVr6K3lY?=
 =?us-ascii?Q?zj/3MQWjsCd8enswIuW9/LxquR6hTLgn4eJo9Rl0dbV4hYyv2F/MaqdA+aYm?=
 =?us-ascii?Q?6Y4mvZRTmkQVFMcR9jswFmLf9cDkZXiI7MSevz2l81oLUoJyHos9z0nckeEb?=
 =?us-ascii?Q?0YwwkCscBAI+r+NHIkO15qSnV1LgnIMBMWoZOm9PA3HfBc73/DjwMZ7f5/Jm?=
 =?us-ascii?Q?ep6xK/AnylWirtwz2NvmW6YQgOAkwV8lvrTr5SSjB0v1JpNQGuBtUUzX5nPg?=
 =?us-ascii?Q?HS9F19QCuyu97Y4XAhCZs0sG5E1QMH1Ueib3zNUq1nDOzc75QOkykjOG6FNB?=
 =?us-ascii?Q?SZ6R7vuLTcTTZuVs/grK2sbg4pgx4RY5xMadMLPyj7T2O9sTLuDTcb13byN9?=
 =?us-ascii?Q?Isn4wFSPrPdKFpw9Od6BVYvaXiu2ckzRJwhdoYW2vC1vuAHZfr7LEQAR9BuK?=
 =?us-ascii?Q?K118ffuL46+ZV2obI/1MNi/mgcL6DYmGRjpl3VUdWcm+IedKMFqtP1f17FHV?=
 =?us-ascii?Q?KWPwdZPAhVFj0MsNfTtMH4q0h7G2fnCNIaahJfI3566i2ZAU2dzOM3s7dRyH?=
 =?us-ascii?Q?tAq/vYO1xFBR+koJVYlzf4ihfNEGGJ0sPR6d6d8ZL6JaAWbDX5wx2Sut6Kdy?=
 =?us-ascii?Q?4QryzkBAdKmDed9eiheyJQ9+h/38Kh8KNmyi2vgdWtxmK6AYZyJC09AFKmxR?=
 =?us-ascii?Q?lAU68CUu+vC936gxABBnV0IuRxrVnvqXwF/Dz7vKjelXEZ8F9XNmkVoacsIW?=
 =?us-ascii?Q?kp/Hj0bsqgZ4mUPfekbsutLJJ8sUNnYuvQ/SRvUDsSaXqLx2plj8cngyWSNl?=
 =?us-ascii?Q?y3xdxKTRZbFgCMzQk8eBMe26rk3jo/i+90QhydpSQ16UISJmGkNcCtSmPTYS?=
 =?us-ascii?Q?DMKjZl2TxE5A0+dbldTtShwkLayQLKScO4Dsf0JrvS9DzVbOJ7pQ7OcbVSx7?=
 =?us-ascii?Q?FF3sHWnCBMKeLBk1IqhA9UEol2BEsczAP1uebFqvC73s8XY4yeGVY6xFJQKB?=
 =?us-ascii?Q?2vij6xN1bjVrnuOCPjubKpJQErRFRo+m0T3IgZhrGygH7yQgI1A4P1iQU5TU?=
 =?us-ascii?Q?Tzhw9Pn1zCznmOI/JE938Riq4zVJeNQqfEA2ThoWqddb5O92a6wgK30LYilH?=
 =?us-ascii?Q?hYAqr3HkdlL97Ie7TR9fC4ASwSQ0qg6esSF4hdN1lGF7BxjX0yJu1Qt0CtX7?=
 =?us-ascii?Q?p/jDRSdVXcXjM4pE3dcL4sbVMfeeKK+8k4k9Fr67XXWv6atS1vKHBBM1Tj3Q?=
 =?us-ascii?Q?KAuHlJcTTY0hx5ig8qbxCtrC3y65+NjJv5aNf9b1pGKYjvMgM2JbuLZquP6c?=
 =?us-ascii?Q?auJpic+IdcKC7T0TZuFpJUUVE+bZ7wnynGWmeEsRqkQz8voNba9Vi9JyuUkh?=
 =?us-ascii?Q?zztpEI+SMuu8tAqM+1A=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67df9c64-4e79-496c-de3b-08d9ed5bda16
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 12:41:40.8873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSE5AqHvVH9Hv/Nv1wRsuig8aGPaZ6i22ttfcGxsyu1UbRB/k0Osc7bXZNNvLjVa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4214
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 09, 2022 at 10:59:08AM +0200, Leon Romanovsky wrote:
> On Wed, Feb 09, 2022 at 10:53:08AM +0800, Xiao Yang wrote:
> > make ibv_devinfo command show more device attributes.
> > 
> > Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> >  libibverbs/examples/devinfo.c | 29 +++++++++++++++++++++++++----
> >  libibverbs/verbs.h            | 13 ++++++++++---
> >  2 files changed, 35 insertions(+), 7 deletions(-)
> 
> I have a feeling that a long time ago, we had a discussion if and how
> expose device capabilities and the decision was that we don't report
> in-kernel specific device caps.

Right, it is kernel bug they leak out in the first place.

> > diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
> > index a9f182ff..68591c7b 100644
> > +++ b/libibverbs/verbs.h
> > @@ -136,7 +136,9 @@ enum ibv_device_cap_flags {
> >  	IBV_DEVICE_MEM_WINDOW_TYPE_2B	= 1 << 24,
> >  	IBV_DEVICE_RC_IP_CSUM		= 1 << 25,
> >  	IBV_DEVICE_RAW_IP_CSUM		= 1 << 26,
> > -	IBV_DEVICE_MANAGED_FLOW_STEERING = 1 << 29
> > +	IBV_DEVICE_CROSS_CHANNEL	= 1 << 27,
> > +	IBV_DEVICE_MANAGED_FLOW_STEERING = 1 << 29,
> > +	IBV_DEVICE_INTEGRITY_HANDOVER	= 1 << 30
> >  };
> >  
> >  enum ibv_fork_status {
> > @@ -149,8 +151,13 @@ enum ibv_fork_status {
> >   * Can't extended above ibv_device_cap_flags enum as in some systems/compilers
> >   * enum range is limited to 4 bytes.
> >   */
> > -#define IBV_DEVICE_RAW_SCATTER_FCS (1ULL << 34)
> > -#define IBV_DEVICE_PCI_WRITE_END_PADDING (1ULL << 36)
> > +#define IBV_DEVICE_ON_DEMAND_PAGING		(1ULL << 31)
> > +#define IBV_DEVICE_SG_GAPS_REG			(1ULL << 32)
> > +#define IBV_DEVICE_VIRTUAL_FUNCTION		(1ULL << 33)
> > +#define IBV_DEVICE_RAW_SCATTER_FCS		(1ULL << 34)
> > +#define IBV_DEVICE_RDMA_NETDEV_OPA		(1ULL << 35)
> > +#define IBV_DEVICE_PCI_WRITE_END_PADDING	(1ULL << 36)
> > +#define IBV_DEVICE_ALLOW_USER_UNREG		(1ULL << 37)

And don't copy ABI into header like this, the kernel parts need to be
moved to the kernel uabi header and cleaned

Jason
