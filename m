Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB65972084E
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Jun 2023 19:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236654AbjFBRXv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Jun 2023 13:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbjFBRXu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Jun 2023 13:23:50 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25461B1
        for <linux-rdma@vger.kernel.org>; Fri,  2 Jun 2023 10:23:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKPbH6nTUy1+/gKbn9YBfFSG4hbYylebRIKh062oMnPWb35uO720qt6DQBK+lmfMTDsmn3s8oDPTBhq59nzNQp44xgQcbtGQSW9TlUXi/fVpfq0/gxLfaQZAZ6RV0U8MWLcbrfXDsDVFW2anLItx45XfQTuF0AjSeNWdL5CP1ABwpIyf0wveGW6emQreESItJB5eXZQ+3ZncIgzsuQqCa6W54FOjBZqU16zt+0QzqraXuYnF92WMxo8+gzXezmH+cUzVbjiwrvH3w9WJidAqiR4wcCOVpw8zYW5uGYWZ3wH5MxDwZgvsoQeyKFT1ZotdRUvBa0RfN2XJUDqdVrv4sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZErqA1a815iGjEStSzEc/6CL4ukf0d32ev1GvPUDCaQ=;
 b=jpGlsrcNNUv3e4pwwU0ymN94vTX6pxJ0YLhMw4p+bouAGApReMN0w2mi/HYQmYgow0m6+hGfrsDOGptRJVLsLxRXDqsxwAUYUStuIB0OvaIXrOBQTYQppqzpPuCKgs+R3hMyrH9qRaM8FHcaCWejzWXb4yU1il0OZ15sNXuuSdAdSqkDpt8rl1zIa2HTaBs0ooag5DlFftpv2u2Wvd7PC69A4ShkzmQXc9s4eA0SuW5SrchDiQfJ+DesH1tplYi7xLPSaU3orkf7Yr67poXh5u++o63/Ji7XUy+hbIqi61Qyf+T0mJ2b71qY0Gll3jUOTghmWRfTpswPNz87F9jfKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZErqA1a815iGjEStSzEc/6CL4ukf0d32ev1GvPUDCaQ=;
 b=L32MMH/HedOI2nY/pzrEZiQF6AoxqeS/vfDmm0Dn1rNEl4wLm47Bd/JK9XoyUtb44KdYgehIWCxwdCnoPLFwitDUOIUHWfnMRnQon7x1zdABpk7jqCoAHxp5vKrccQdi/D8SwvTWxJuoZ5KOutpAOC4G4tr8dt8LH+7VeKZ9yhFVtbqeen4Q2nPXITkLVaNA2IgsV2boDbOiunqHl5AmRrff/pNLXVCel48kRC+z1En1qhSaj9jm+9FNmfEebhHTb2zkK+Hx5b3cRJbP4UNJlfdopmvl7DYTCZhfZe5g11uF/suBKwta/FdCsmSe0HtuatsbCYk1xUoJ9Iru0vDl7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB7846.namprd12.prod.outlook.com (2603:10b6:a03:4c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Fri, 2 Jun
 2023 17:23:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.024; Fri, 2 Jun 2023
 17:23:46 +0000
Date:   Fri, 2 Jun 2023 14:23:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     leonro@nvidia.com, Dean Luick <dean.luick@cornelisnetworks.com>,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/3] Updates for 6.5
Message-ID: <ZHoln/2UL7avEou8@nvidia.com>
References: <168451505181.3702129.3429054159823295146.stgit@awfm-02.cornelisnetworks.com>
 <ZHkhjTvi8vNAmmEC@nvidia.com>
 <d5f1df96-b06d-8708-8732-7c034f5bbd81@cornelisnetworks.com>
 <ZHnx2xu/AmkKFni4@nvidia.com>
 <97b685a9-cd0b-023b-75f1-48c8df06a2ad@cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97b685a9-cd0b-023b-75f1-48c8df06a2ad@cornelisnetworks.com>
X-ClientProxiedBy: BY5PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:a03:180::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB7846:EE_
X-MS-Office365-Filtering-Correlation-Id: 087fa3ff-e035-48f3-99a1-08db638e1ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QYWwgho9vkInco8JCLBlppLElOxk8goxPLnFPjE3SZ+py4tJDgJNeQ05aEg9FZgahsZO0phmefyJAh2agN0y0B+dTyyMhC8lj1PBFdpQCJ9RWyZrzDaKXkoeOmhVFfrQzZpN7H5F6OgZjOPESLyXbqNNbZ4GL0u5om6NQ3JlNqTFXg5LuETlF2CFdv4XWZTWJPcUcSefXf/xCSvespIf27eBZUL3mzmm2t9HYDW2I8pIADYmajTasvm2YlFsk/iGsSUnijTgDshQP82/bK9YfDgywmNNaTqFb2JY//AH/V5LEE2A8aOZz3NJF2WSMFRSaaPbqY9a+fjZH3N9PrX1RLWn3+L1QDHvPjJbGPJl3mQAvhJRc8QL8VjtmPPlHXPp4OJXP2VZ/rGW9tANp7GNEuaV3w1To+vZbnVguZz+EUs/2usa5Ky3g2YSRl7PPJ8YMPi+uN2KGjl3hB/V7Pmmaj0YmxoVorAoIAK6pfcuYwt5ihHef8MhnQ9YcBZyFZyunfN7kBmQ8S4wSQGLgwUHU9CiZrFCVDbfD9n9PmbOtrp3LmxlU96T6ydBVnoWRtAJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199021)(86362001)(38100700002)(36756003)(66556008)(4326008)(66946007)(66476007)(6916009)(478600001)(54906003)(6486002)(6666004)(26005)(6512007)(186003)(6506007)(5660300002)(316002)(2906002)(8936002)(8676002)(2616005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IsgRr2r9NHYIQPKnR0icT6nxbPweI4O39KVGE5Mq9+/yr7CjqEKmwv2bFADi?=
 =?us-ascii?Q?Lmz47lfdHZeZncSFSg3yqeEYhOTIP/qwW8Zo1Yn9jEjjBci9t1OsHkpuMS3M?=
 =?us-ascii?Q?vy/MugkGNyC0d9DPL5ENHJko/WEIN9qFqdMLsGsy30Pvhq92EtLAoQ0xNnqY?=
 =?us-ascii?Q?JdD6ZclaSNuL7g4zxA2DL0BIAUu9w6jlpmNiSqZMNVz/Pw/Y+X7cRfUOnLDJ?=
 =?us-ascii?Q?hBuGk50/n1ZVFNjx/BU0EOTr3bsoMRxLSxrRJjayhu63qccWLKy2TCgreC9K?=
 =?us-ascii?Q?WUmRcpUjWbJgysLL1tZYLZPrC7Qkn+7U1DNZRwFAASZbNKVZn6FjtPK7ORwF?=
 =?us-ascii?Q?SHrg16VoR7LF9TwsDjNFpOSF2rPANT9CVa55F6m6EESbqbGNlgBit37UYiio?=
 =?us-ascii?Q?BxcitR8I56ozThbhnuj7SqYXno+KfuX5PShKL6pYUacUO0H2PlXb9ELwvy3s?=
 =?us-ascii?Q?2bz8wS7rGxWQDIVNpy+lvVRPgDYatHrDo0t/M+FxpdkwMkr+7pVD6iUw8WGa?=
 =?us-ascii?Q?6Uw7X/GQc4ygDQjUHKL54QwgvVXn2SVRl2EeuPcGcIjjdan/qGz62DdapApZ?=
 =?us-ascii?Q?TQbv2/KX9CT7X3cN1r1C+FRxUnNvd7HJhP1unavPUnWSw6ENW2NhuSxkRy4V?=
 =?us-ascii?Q?zS0ZEg/NwpYswTzXbEBEYr+TQTg4EFrP38e4bur3IKWyGFd+1UkJbiQLDMDj?=
 =?us-ascii?Q?xBrS+jKOX2W4YZURL3v0EiDrky9n3GybWaSLD4S7lp2Ts+bY4UmC3f2tya5b?=
 =?us-ascii?Q?AqbzO+hP8WHOsy0LUPgQKeZEvPut51ZF2HJ3xshCtpyEK0I6FZHzbts6Z3Ir?=
 =?us-ascii?Q?2tIQJget06Wvkl8ZduGPowOlTs0HI7gv1q/mV4X3J2drmF+t/8WDoCIMPeLH?=
 =?us-ascii?Q?sTbgzCeYSdxYh+ycbEqaj1ZTO6u1Kz55XJbg2jPrWScohNKwL/bfYJsGcb95?=
 =?us-ascii?Q?HqYLDDXdLCouEzwUWEbUs9167FdgG9tIjbAOIZfkGBuSiywF5L9xTCx1XPtH?=
 =?us-ascii?Q?yxGUnDjJLzaG8JCGc+mFNBXdYaoXQsT7ui9ObvUNsojaF0hiYsXg8uagUP28?=
 =?us-ascii?Q?cCbiJy9kRbMxLP/SuwL0TkyrWNJQWAbGcoiXyzz9tSHLXg/HEvq9wyLnhAVg?=
 =?us-ascii?Q?JnNRsS5tnHy5iYMpVRIO9br0AyQpzxBbnEu3KCk15SblBJbvcDnPp5p07HEw?=
 =?us-ascii?Q?/d5VNBod5rFeOUHQ5v/CH5xgFrAOfFMTvz5A+mxhrpr7iQ6w8leV8r0DlkaK?=
 =?us-ascii?Q?bganTZUwQ/E1hApF6Gn8aU/tinKxQXftNA8eu11t0nmNipneK5VEIA2Z0/j8?=
 =?us-ascii?Q?3RYg80blG9k4MsGPi0yYgobsiUw58SVvnfOi20yuxoGKdo3aIChpYIKPC1Cg?=
 =?us-ascii?Q?XqcYpXpCAosiGO5hCuGLAUnyKRCXSqHVKFi3CxsjODMKggHzpSpwW4YH2TPh?=
 =?us-ascii?Q?DdE2sF8CxkWGMfMHAJk/LK4RlH+4vFppCCD+DOOs112VsROucaVxeMFLJBWi?=
 =?us-ascii?Q?oj0WKi98XxZ/qFfrD5ireT4nenxgbkTk4McMgAOBEBThIchlSsIjFjgghvv6?=
 =?us-ascii?Q?VRZPXrI7tXz27fwZE4+hwSFhJgcBCatSmZkRIFy6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 087fa3ff-e035-48f3-99a1-08db638e1ee8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 17:23:45.9739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fj1tar7DEU5wiR2jkJg20Y5BQSHkcmb+ZEGcF8MifojAaNX/fpIgJ6afsqHsMl8H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7846
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 02, 2023 at 01:15:47PM -0400, Dennis Dalessandro wrote:
> > So you will have to think carefully about is needed. It is part of why
> > I don't want to take uAPI changed for incomplete features. I'm
> > wondering how you will fit dmabuf into hfi1 when I won't be happy if
> > this is done by adding dmabuf support to the cdev.
> 
> I think at one point you said it was ok to have the fast datapath go through the
> cdev. We want the core to own the configuration/etc. This is the fast datapath.

Maybe, but dmabuf binding and page extraction really can't be fast
datapath, it just isn't fast to start with.

You should be crystalizing the dmabuf into a MR and caching the DMA
addrs like everything else and referring the MR on your fast path.

> The high level idea in my mind is that we do basically what is done with our
> control IOCTLs through the core, setting up contexts, etc. However, still create
> a cdev for sending in the lists of pages to pin down since that is hot path. I
> assume that cdev could be created by the core and owned rather than done by the
> driver directly.

I never really liked that HFI has effectively its own weird
implementation of MRs and ODP hidden in the cdev.

Jason
