Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824E4705C0B
	for <lists+linux-rdma@lfdr.de>; Wed, 17 May 2023 02:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjEQAja (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 May 2023 20:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjEQAjX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 May 2023 20:39:23 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7453C9E
        for <linux-rdma@vger.kernel.org>; Tue, 16 May 2023 17:39:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmAd4jR2B+iTrZ0HKGxdvOEkCt5cnSX23+U9IjmqkbbSjt2j3HzQGl3e58dZRGczZWeLHngeaIn5JWwGak/T+uzi0EphkU23xmKRHgRip+iaGj6rSRGFl/zRvze0DiArdNQlZZAPNv05UTvPiL8m/1l+Lqa5bjlFC4ShFd+D3NiCf4wMWArcG558Nn2FeYMBjyNjtWw51T3/GDUgJsBRFU3ACsQgx7jIx2KBibmAeXVFR4njBRmHACay4GYTDm3WXMeOo0uNY2+KCkaTkpdl/VlawN591lYeF637RfdxsbamPGzeAM/dqMJUNTOU9GvMH9Y/9Vr9TwSYJhYRMlSG5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHoA71QWxZZXtBaqJrYtlYIlMqU0IYaVPZ1RfL33Jes=;
 b=G9/aFE1dYfRMVY8O/TTrREhxEzghRIJhxnN4czQ6TDtVJsyQuJpePlDk2jGINNZzq48Ki/gMI5pv+z5bvW/a62o2iBVLNujM/L6hvvuXFxjKRa55XcgN/XKwd8z7dAWjk9kpm9eACjYAvOjmDtvOo8gNAcmQIBgv0MlgyE6TFgUBjx36dkRnK16IkYTBn6SW9hWdAARQGTgJEE4kJ1gaeh8pGDdq20XBy5fsLBjvj1ZnBvHs1kywOK8j2OiEW3+brRWQQCwg1mGnHUOl32/nYs6CP8jBnRbew6kvYjLlDG7NgHA7aHuei6NLg2NEEF/hoi2bFzmXcosDUQrEUWNScQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHoA71QWxZZXtBaqJrYtlYIlMqU0IYaVPZ1RfL33Jes=;
 b=UvUQ/GaRRivba1nrId1QSi1HynqQCoeFGMKNhsJKJ67DVp/h/uRWEj9MlFSRIgKZXxFGWFpexkeDMktnY4dArkqi9IEYmFKfARO/cfv5w5C29OM4xSu2WCinEaS4WGY861RXgcSAId0YEUjZtaWk1d84Epqh5zdpZCjKc0VaDLt8sEtKCvXMQawXsK3qIWJeqeyYTmbptoc/sNMpLyQFM4tOt5uUQ0zrEKrFth64n1SPvAl85mNtbH1Fk0yS0dJ48Iiqgro1sF06BoFa3TqGGP7DXxPM009RhveZ/L9OmnZi1ei7ZOkkpTkJKSepIN7pNIHxbCAUgVbS9wBWWH3ghQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5859.namprd12.prod.outlook.com (2603:10b6:208:37a::17)
 by PH0PR12MB7469.namprd12.prod.outlook.com (2603:10b6:510:1e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 00:39:16 +0000
Received: from MN0PR12MB5859.namprd12.prod.outlook.com
 ([fe80::94b9:a372:438d:94a2]) by MN0PR12MB5859.namprd12.prod.outlook.com
 ([fe80::94b9:a372:438d:94a2%7]) with mapi id 15.20.6387.030; Wed, 17 May 2023
 00:39:16 +0000
Date:   Tue, 16 May 2023 21:39:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>, zyjzyj2000@gmail.com,
        leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: Convert spin_{lock_bh,unlock_bh} to
 spin_{lock_irqsave,unlock_irqrestore}
Message-ID: <ZGQiMsBAWhyACuxK@nvidia.com>
References: <20230510035056.881196-1-guoqing.jiang@linux.dev>
 <ZGQbwBeIqk6YMKuf@nvidia.com>
 <5d1aa20f-2cd0-5400-69e9-057ede404ae4@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d1aa20f-2cd0-5400-69e9-057ede404ae4@gmail.com>
X-ClientProxiedBy: MN2PR22CA0019.namprd22.prod.outlook.com
 (2603:10b6:208:238::24) To MN0PR12MB5859.namprd12.prod.outlook.com
 (2603:10b6:208:37a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5859:EE_|PH0PR12MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d6a9959-7b75-406e-1479-08db566f24ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vQmud4NRXvt4nUD8NUTe/Nz1svhGUVN/2BBWUgVQcucmUPYmv0+5uGeRfuhdwSsf1nAAqtBsfkrzAss5u8oMNPdeP7dRVxn5KeBrowAPcF7NPK3HK/34wwDTBwcKxB4NJkgsxxaNVJ+orwodAqZCJWZZRmQ6wudYVBMgmHd2qdZGlJHkpfcqzDit68CyZ9a/vSq6xJF2Y/y2hrZWx50mMV/zB0O1t9pXpnbTH9g1kOasboK1IQYx2fyeRsSZwQ+gPuZViwYMhrn3dVvPCXq/gTYDakTdRyY/sNC9wKImhIgInpmbV7GD3JJaCWVHdsDtoZV3XUCW2+0hGeLbV/KtBs1iLn8JQu5/wTaGl6iW8h0yzixOUx+Aibw3E94m/U/1vwjvavBISrdMD07Gyd8lSrNNbh/Ie0guZyh9cwJXSCj3thLIM4LoUb/NICIcZKpMfIDbB6DKjq+XXTHdBWqHidNejUkqWca6fEPgJ/TDEPjxrzcjRssveA+Y7Fmsaw8XcE/pSumvckFAyfwEVHcl1qjuaEzNUy82EBlOXwmHBTjqj809rk329Sh5fWUykcYV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5859.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199021)(36756003)(6916009)(2906002)(4326008)(5660300002)(8936002)(86362001)(8676002)(41300700001)(66476007)(316002)(66556008)(66946007)(478600001)(6486002)(53546011)(186003)(26005)(6506007)(2616005)(83380400001)(6512007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TlrTnlJBVa/ZDE15NbH9U1ohGbAZRmNowYfeHauSNdUosAyuYJKxl54NoFQP?=
 =?us-ascii?Q?6+1lyzYhFN87nPkToFw6yNYZfgM9uvaZh/z6zdwEJSBRtFOv20C3qWH2VeyK?=
 =?us-ascii?Q?Qn5lMLnrbKcFXsqFkUaIZSSx8XOSEh+DpRXFvrr6GZXDrDikjQLsp/eeulrG?=
 =?us-ascii?Q?rrr8BWfoqMwPVx4IuHmosu/HCkIZ8IdYmmmBCXB7uUqzFFd5BMPHy+AF9wtM?=
 =?us-ascii?Q?LXX2Fuz1XwJAvLR2YBas/FbwQE+x55nwSE5X+Y706qao4TUAe0mFnvwxV8Z7?=
 =?us-ascii?Q?jPM3ilu893WxvEpiabUoFHxYPLD3AvR4jWlXRFZk362/xGVwgTmiLnOZajwq?=
 =?us-ascii?Q?NEdAZs60TZq9lndIG98cb3A6VMnGNbcNn5MtI/EYYvqC1NP4vjVHarMrBGog?=
 =?us-ascii?Q?mZje9ZecYJKJyoKTJl4Km8F2qMR0xKmPtTqo6AKwaHMCPRPjkuTJ3bC73qsq?=
 =?us-ascii?Q?Pj8oky41smOQUkqD8LQuNkj63UN1zHtTRUW0BcNZaXA1cYw2dadw1Zgv1WgX?=
 =?us-ascii?Q?6V4rzw9HKWlNbAZ+BNxycUNxsrKl/7+ztN1mMfeRZ0CjLqAbb58rSnha2Fts?=
 =?us-ascii?Q?yZuFVrFkuCAXYRcFPewgaAz1Zk+Om/FrMeCD2OncFAWK59SehfIFtJ+7x9m6?=
 =?us-ascii?Q?wTK+uLKqGwmQX4Lguxxa8FQXisfHccIu7OtJMe6jSmmjTE1Dve4oESGUUscg?=
 =?us-ascii?Q?yvVs9ZUTLFeVpj7+pMaZ+KSOQ+s7f3sk4dsZgoBuMBXrFQScRp4EkJ7YhUoj?=
 =?us-ascii?Q?+bNG50jWeHQFuEh/HoLInRWlgGYngoastwiJHi3WENn7AYXdx3UPQXFHmiYb?=
 =?us-ascii?Q?zzvtJEMB3qE/Ds794wZ+42HpkRM+NwLE8goVvp/1CynhFUTgSAA8GrjiRVTa?=
 =?us-ascii?Q?+mju1Rnu7WiAsVEO8QJflNa8i2OWQ6NCJYiAPOWnsUta9ZEsUIhQIf2Lej4M?=
 =?us-ascii?Q?UjcQbgztN+yYB/GCtkplQ2OlmhbnJYLoiTGfnUY+gQInEf8YYYudR7f+qyvV?=
 =?us-ascii?Q?COQO4A62SbmbY14jdpSVygrXDQuIM8JZmNwoyYTh05cwYs9Tk/dEBr64O5mY?=
 =?us-ascii?Q?pf9lp2czEltBTWwORWSBpeu7yMFt9dVOlWFB5QgE07yYvVb1TV3E8g6LV5hC?=
 =?us-ascii?Q?o7/TJNWSpNbHSQc8zd1ke4VIVucg+MC1a3urwpPSi1OYp58JxixgtLRKcQNm?=
 =?us-ascii?Q?qhIGDn2gawMt15MPdaZn9Z/KphRgRIpPsCtYCrIgj/Fwv2QrScj1ROmmWvGd?=
 =?us-ascii?Q?JEDMXXYTbPzQ24dSNTOAmCXANjWZ9k7PKvpbLkrVYo8i3LyytdAg+XoztJYR?=
 =?us-ascii?Q?z538OeJT0Ogr7P31Skq3KEsU67OzlH9gNanPyNU/moK3lc3yxFEczAR+7tfS?=
 =?us-ascii?Q?2X60QWKZnbwBmce6AIoQpFRl0xdRBzOi8hpEOmNk99WAPUbtLFmVOA+t1q0y?=
 =?us-ascii?Q?srQ4qaufSRvX14DYuNtw/js53q3SxqrXsEyTtZ7z2wW90FGSSvY6Qn7TC/cM?=
 =?us-ascii?Q?lTuutee/aLX0+LnQIF6wAQGRBavkU57SDx4NG7y+VVfR0nIUGsPqsbXx3ZIb?=
 =?us-ascii?Q?IIuctNbXzUxozhWpcFPC7Pb0VLQQRZjZLm3fMcRT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6a9959-7b75-406e-1479-08db566f24ba
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5859.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 00:39:16.2405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ePkhLI+fnz4Ld+mXe3sIcpPCQH+zkNEEB//q3jkMgvI5HJluQaRzlkiO/bsW5S1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7469
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

On Tue, May 16, 2023 at 07:32:35PM -0500, Bob Pearson wrote:
> On 5/16/23 19:11, Jason Gunthorpe wrote:
> > On Wed, May 10, 2023 at 11:50:56AM +0800, Guoqing Jiang wrote:
> >> We need to call spin_lock_irqsave/spin_unlock_irqrestore for state_lock
> >> in rxe, otherwsie the callchain
> >>
> >> ib_post_send_mad
> >> 	-> spin_lock_irqsave
> >> 	-> ib_post_send -> rxe_post_send
> >> 				-> spin_lock_bh
> >> 				-> spin_unlock_bh
> >> 	-> spin_unlock_irqrestore
> >>
> >> caused below traces during run block nvmeof-mp/001 test.
> > ..
> >  
> >> Fixes: f605f26ea196 ("RDMA/rxe: Protect QP state with qp->state_lock")
> >> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> >> Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
> >> ---
> >>  drivers/infiniband/sw/rxe/rxe_comp.c  | 26 +++++++++++--------
> >>  drivers/infiniband/sw/rxe/rxe_net.c   |  7 +++---
> >>  drivers/infiniband/sw/rxe/rxe_qp.c    | 36 +++++++++++++++++----------
> >>  drivers/infiniband/sw/rxe/rxe_recv.c  |  9 ++++---
> >>  drivers/infiniband/sw/rxe/rxe_req.c   | 30 ++++++++++++----------
> >>  drivers/infiniband/sw/rxe/rxe_resp.c  | 14 ++++++-----
> >>  drivers/infiniband/sw/rxe/rxe_verbs.c | 25 ++++++++++---------
> >>  7 files changed, 86 insertions(+), 61 deletions(-)
> > 
> > Applied to for-rc, thanks
> > 
> > Jason
> 
> You didn't mention it but this shouldn't have applied/compiled without
> fixing the overlap of these two patches. ??

oh, I fixed it, it is trivial

Jason
