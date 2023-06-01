Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62EB71F657
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Jun 2023 01:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjFAXCv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jun 2023 19:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjFAXCs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Jun 2023 19:02:48 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861E41A1
        for <linux-rdma@vger.kernel.org>; Thu,  1 Jun 2023 16:02:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHjy1oUzBUog7f1n0xxXQEzgE4DZGGX9mW09RluBm2t3ji2XcxbKlLMbZVMPPqm5G9p8cjigVQN1CXPjMolAuIt50tOIxrcsPLkr4/9YGF25PokdKFBUsIBkhVE8FSmo8qzaHowjZ1Df/tILCjDQfDg5uvIKGsEspF6jZXHJc+nsOY1er/IhnM9zryfOgO28vW1stBChm0yRyItPiHO1vNHH26M2X4lVS5Qy2geS/DGALIxkVOfaRdI5G6tepSgnfdvdNAgpazxhKybGOW1Y87jtvTqHbBYv5Arl1dmFGXw7Qw/9cYyuDqreqsACNPpeFmDGiGHs3AiGSUMhr1ohKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12/u/gszcn4+WodBiMOm7W9Yv6a7GjEHs00E+MhcADk=;
 b=P+YNvvvmgy3okgqVaYhbJho8RR4/FvM+0XLJguJ5t8VaWRflYoLRbEcFLBshIDaVFtXtz1FC9+OIF2nq2C+G79Zx2M53IPv7ApCs75CE83b0pr5kTVaiiMz9jJWvHxOCylsAVoLCnYwCab8YxMASOqTkzMAO17N35z37HKV//VG5+utkuE71yH4aij5SfoX5+Wqtfn9nr5kr1VkbJCQYC3p+LWG+n3yU7UjFqx2LKVCY3gafiBYMqH2olOZhMx900z5XgYCTQtYMTjG6B9PAFlNFcR77mBXpt2oKfA63HZKgQxLaJ71iCcj7WUuDGDOGOzGk5nHFJdVauq1payYsiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12/u/gszcn4+WodBiMOm7W9Yv6a7GjEHs00E+MhcADk=;
 b=o8rP7XUwBjC7ZW+rk2NMmqNR9HHWkvFi7m+00VKLM+g1l3Q0Jy1Ktea8CJMnoa91RXNKyCP/TfBPJvetcaP3K1VRZ1OzJjJ+YS8hf1bGLfFA9iO1ARRXHDSYZ7NuV6FLJkIhwvtW03LSGjU7wVTUJiloLZaHLOo+dmXTQYLFhj1J0hvXJ5ZY2JIsZnUjMR5X/6GCMJ6bPEbXdmn/05l6bmMJE+KFDMvABHzBWnhN6SYxls6+fxd692/FOZaxBiU9XLQIGF73impdPJLhT6eDsROOHBq2btj2pPWGJ6wMcMrQiVhazdcakRMP3agGDJFBmFRRdlRE8f6oUh4XCkzqSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB6053.namprd12.prod.outlook.com (2603:10b6:208:3cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Thu, 1 Jun
 2023 23:02:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 23:02:45 +0000
Date:   Thu, 1 Jun 2023 20:02:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kheib@redhat.com>
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH for-rc] RDMA/bnxt_re: Fix reporting active_{speed,width}
 attributes
Message-ID: <ZHkjkpommwXAXo6x@nvidia.com>
References: <20230529153525.87254-1-kheib@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529153525.87254-1-kheib@redhat.com>
X-ClientProxiedBy: BYAPR06CA0046.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB6053:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e59d04-33a2-4a54-b6c2-08db62f44f92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rULOMAz4AoIY2rFNvI0WIXBXMaPv0sy5d/HtTdVuHIRlJ5ySDXc4zwkbcN6qShMrNgxkV3bht100JoQPp78JWvkM4xm5hGb4Wju3YR4p3Kx6hfPo8dveqHUDfC63UfPCZ9JE4PCI3cjhtnNMc68Sto8sfaZzmoiP+lzVcJrXwuUJYTFtNgJWejTD9NLSeUxLrO+yAUXtNh+47Vj4TqQB0Wh/5ojES+bFt5Ke6IMhUEgrnd3Avc4SH8f8aJ/Zb+8T4NNLZfx2NjQQQC00XS/Zh/p7ZHNrAcLiQQCWCC+6ihz4GYOSMuJH9NMSuQv6+EIkeLeFHRAtaQxd+TDxJoo/0qGufyNiXzETk2O9WGWyUJfNAysld/23Z7GkaDcbxfLyCr2XXig2pv3WQoXqZ52IGYTY68hmceCVs9gOMSzDP8p7EvLTjwFETXeRNVaSk8UlNO/qocpNhaHt2Z2gqerZVLcMWy84QmWzHkBXQEnKXpmv+iT4AjtpZjO056GEq7h7tNwFNUonevQQ7B9NC37QrR+BKq9TAFqmMek+f7PYMvBYnJkt9Tr/4HCvbpOOEkFK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199021)(83380400001)(66946007)(4326008)(36756003)(41300700001)(316002)(38100700002)(6666004)(6506007)(26005)(6512007)(6916009)(6486002)(66476007)(66556008)(4744005)(2906002)(8676002)(8936002)(5660300002)(2616005)(54906003)(478600001)(86362001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yQp+qrWqAwLDPY2EjC8ai7SdE3oAkqvO5EcaT+HxM4+BGQEnYa3qJswOxJLo?=
 =?us-ascii?Q?LSl1ddTAnK5dl8TLMOiVjtgag14slbnODzEXkylbO/Zk7PRuz1nC/xwT2j0x?=
 =?us-ascii?Q?09R2DydF7ioRR44/otZ/Oge5rvRpGXoiUoOIOoGJjM+OoxlUn8Fxne5E8KZS?=
 =?us-ascii?Q?PUURnRxGt1OOmuhZC2tLqR7ciL04X9xKGOH8Dv2o6piGtp6xhWXYk32qQjxK?=
 =?us-ascii?Q?8tCB0+yiF05HkbsysASrPh4p8Nf3zQxK1sbEW7XyCWkcBPhon+7ToLKk96kX?=
 =?us-ascii?Q?tfYegwYi0Gwf4SvhLgENOV7wy9TTxFiWvZgl8oV+4sjVli6Q+Bm30WdvJBvR?=
 =?us-ascii?Q?+jAdqzTefmdz8yD8/pL5PmTWX09BA6CTSImz9GtnCVq1kcif8GeQhA6PXTXo?=
 =?us-ascii?Q?hX2vXCUDeoPOvBTkj9i6tUtqNV4f42uXzETtff2UV0rHfmyeeEgWYboaMtzQ?=
 =?us-ascii?Q?2HUqSs0croyGVFMKzs7fF21amMc0gge0165YXzzkTiancdFIp9BRP/dM1Sp7?=
 =?us-ascii?Q?3Twg6ADegDxk1dn81tpFCOvS2vmn2v0z30Teb+Tw0hlaaQsrY5aVTxH2xJCT?=
 =?us-ascii?Q?mmTy93u5wAenCRewE/GkfWvSGdq7vo58n3qJoDbFXyQcf9Y7BkckAjpq4ZIQ?=
 =?us-ascii?Q?D6IskjaVtIbcT6r+Druvm68yBeTPMRJWvq/KzDGlrIj06jDvUc5gYr1MwTZ9?=
 =?us-ascii?Q?bD8rv9Q2OZdSOPP3QcGDYAdJVG8btYOSv6RkEqPh6QVnROX1j+HTmmZbzyLf?=
 =?us-ascii?Q?04MHeGrqSBh4xfEwXTAFetdo0NKPsddIbMN5Gh6uKF2iqkZ1CENSDq07vIT3?=
 =?us-ascii?Q?0k01i9I7AJL/pvhjnYHl1Srymw/DJUxH5ZpYTJIygkwszpJWYkibCenVNNx0?=
 =?us-ascii?Q?k5MoGhAstdwclQgiGMIb5wAr3vvHyqNC1W697rTedU2SPyOkrCSC8tkaOVQO?=
 =?us-ascii?Q?NPB5uQ1X7Nd++/pD9SB1D8NXKbjUUwPUtHdh76sfave0UcWg7p4wvZX/StuO?=
 =?us-ascii?Q?B/tUCjGCqKJBHsUT8g2j18O5yqw61vo/75fTcTOS9YNSWNHEVvEekagUn/SK?=
 =?us-ascii?Q?BK3qZDTaKxurkKUPXQUxt6tEVIUNnP+mty8khweeB3SdhGVVvDVkKrbmR+7L?=
 =?us-ascii?Q?YL4SBdKPCpfNJ2OUXtVx72pxX81pR730e1u9KvIEHjieFohgCfLPnZSxJd3r?=
 =?us-ascii?Q?ykV4uYdm+Ct4y5QOn+jU883R53xDtYG0KEj43Ko4SlZWXIVzsL9AyOcb56Ui?=
 =?us-ascii?Q?qlLnyYRqRGM8Pq5mcwvB+2pfIzvB1ksmKSq2xhbM+IofbG3nt6JI2qw7ww4J?=
 =?us-ascii?Q?wdJghcVJEtR09J9eV9ic1tBezwpcOww7899UkEx96otP3YrHy9Dtz0vZ/VM+?=
 =?us-ascii?Q?2axgpsg2zKnByk7h0mBna6X3qeCdTKBiupwjtCO3O8IrAMKF8Q217Glg4jcG?=
 =?us-ascii?Q?r8toQjBZYwUgtLm4ICwkjM/9zw2DrR+3D8Tpop90nkl4aUg9cekSDQ4FqJdc?=
 =?us-ascii?Q?sodParbQPptT9mFAhGhO6MiclA6n02PP3Gaen33i/cA/Mx5dTigMNYz0uf+n?=
 =?us-ascii?Q?6vZIE76unDmouea3l6pgdVYVb+EO+7h6QZqeuKaX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e59d04-33a2-4a54-b6c2-08db62f44f92
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 23:02:45.2591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLkA0VjTElr090yObwSHwEByG/HVI31oAcIQerx41QZ4wJGuJ0bQETsjnPJW8HMp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6053
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 29, 2023 at 11:35:26AM -0400, Kamal Heib wrote:
> After commit 6d758147c7b8 ("RDMA/bnxt_re: Use auxiliary driver interface")
> the active_{speed, width} attributes are reported incorrectly, This is
> happening because ib_get_eth_speed() is called only once from
> bnxt_re_ib_init() - Fix this issue by calling ib_get_eth_speed() from
> bnxt_re_query_port().
> 
> Fixes: 6d758147c7b8 ("RDMA/bnxt_re: Use auxiliary driver interface")
> Signed-off-by: Kamal Heib <kheib@redhat.com>
> Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/bnxt_re.h  | 2 --
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 7 ++++---
>  drivers/infiniband/hw/bnxt_re/main.c     | 2 --
>  3 files changed, 4 insertions(+), 7 deletions(-)

Applied to for-next, thanks

Jason
