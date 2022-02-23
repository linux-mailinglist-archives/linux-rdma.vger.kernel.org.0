Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B464C1B4F
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Feb 2022 20:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244043AbiBWTCh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 14:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbiBWTCg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 14:02:36 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031FF1D0CC;
        Wed, 23 Feb 2022 11:02:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbA270U/XTCDmI8BWjxybiNB2f6XiDBQOHSWPGFIwkV394vzsbd7hsim0WJYJ2YNGSUmzK1aWNpCoqfGrr7vZ5CAMt6rY0IBAFf8QW3lrztug8paVx0ElZSWmwShGzxyfBsfJFdNfi+1eJwslIbitleQswxvaH9PrSZlZ3wuoOjLV74p7kY7fUQ4OZlCog4Qs9G8HpjLK9VPjCvndjlTNhBagRlARNdJEcA6abm/GqPc/91Gv4CD0yw5UBpCuk5z+4fT+GrW1asmnnkTesyDNb2blJLAPKSL8wpdz71FzawAc+MhD6BDS3zpKwwXTLKRVg+qJ01mV8CuWLeUoiGojA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7GBBhIXYfd4z4kaALl1PbeU7N3KuqhHDOS1N8Wfzew=;
 b=PT90dPCoqWQBdlqUGZO40jT0EwJZmWDvv5aBdobj4/mEtnRmZLUWIQe7HbeC09gZxu05x5tf25c5/H+PpOR1Pio6rn+ZUFj8T/jpoTocEmq8B/Ft2OCw2FAZaOLR/f7SCLLr98ITl3vmAlPNMkzRcLxnN+k2wEC26I+OsnEP5dqBZH8mQ699PXsa0YCslWRSLn1pdBWYeeidAQVJ8rClQBwIHvqNq/RZ8LO2nMgD2VgYGdor6bV6pUv4vilkfk+hOA9A2gskHD/M9PxltjuCnWfNwV0XltssHNrAaSfKqu5KWApbIaJJjzeINriWTx9yJ2btsT/gosNPUOS3/BZ6hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7GBBhIXYfd4z4kaALl1PbeU7N3KuqhHDOS1N8Wfzew=;
 b=YELN0VtlGUoLT8Z17DJQlAZw9OOqChbzmc9HHqCW6dMFTGx+3IuANu8I3E8ffk8J6GcbSvL2NKFNY0kgcLxtSZgwJE1uFjQ9QEARAKTWK/P3Lu6rEMspMvujtW8KXP2wTp9ARtsblw1twmwspi4AN5NI1Eh5/iq07sqLOgu2VQU1Z1Zy32VKnSi6fsZ/FTHP9vFTsKk93YMQ0Dsgj5is+IJy/PqD3qJXCAEV2P0y3+yO1PeYF5h0Ho7UpM87ezwtGbfTMyEdEZiAo7BWasjWksPdxo03fqiSx97kmlpITj9P/O2i0uGslTh9fvT79Ao5hIhaHvux89aHlc7PJzSVZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN8PR12MB2945.namprd12.prod.outlook.com (2603:10b6:408:96::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 23 Feb
 2022 19:02:05 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.5017.022; Wed, 23 Feb 2022
 19:02:05 +0000
Date:   Wed, 23 Feb 2022 15:02:04 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v2 0/5] MR cache enhancements
Message-ID: <20220223190204.GA399839@nvidia.com>
References: <cover.1644947594.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1644947594.git.leonro@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0239.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::34) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19d65edc-406d-4752-2711-08d9f6fefb7c
X-MS-TrafficTypeDiagnostic: BN8PR12MB2945:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB2945BF51F8FAB69F07D8C905C23C9@BN8PR12MB2945.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YIRAdh3ypOFBR91z9zPDZQGusZfMx7PlZH8onr+l9MbGBgDhR5oU67x/j8/Sa8LXs9KrS6S9WSymRlJqhfAnmQR8NeBVFmC1k1W2Zo+0+j4la5JI3iFLZRuF1iDbVtji0hTnYS9mtDGT2ma9aNelgJdp8crSh71Hppy5H4gDvvo/ujLSCa7w7oVr4SzDPnSUegr75XnLn1L6XnPwnTbylqG6a9amQY+z1aHTGCIrgOxTXMjg8EjLC3SxlyoOL4F6iUC2M6I+bxHwjmErdCoESmrjILAJXGSatV8G+oerubEN+5Red9nDxiXj5mzwQ/6ZacNZ3pUP5nrRCCwvFGR/hgeYfsMgY4LM3o27NMTaJb+RlRsaOfNz+zcE/z+kthaAaYEv9fZsyQFa8talWX1Sdm3KMdPtZp7M8+T0f74yYuXZVyXcDkL4BqwqiALzIomshvhzTVT/QpuHiArjGtUFY/xhz6nhWdZqxmS5Dp+hBqJ46sGDOgMjEut3+lqibV6Xs8ncg0aKHwMc+OCbQ5x+V2hyJFPdRTEPPofh6lzeqt+Vfp2WW0eZyJQ0AKBDdqEtcUj1sj/sdDBo2Uem8507yVttnkW5euFh8kS2Y7T0BqIJ6pSQqYoAxFeoHRp29DV6SUbZ4BitZAlTZ4dwhHUsyR1INtJaIZ/laZj+Eb9sXkrTpYSz+PX+C7pfdoLRaTeQlCD12W1gIgOTTVkGd+Yffcw+9PbDiW3Z31Qc+nODr1ypC1HlaZIkvwnKGPiXWvbOA13Yo5Hs9Y5tA7PuKxcvRhOOjaSRPfssnsIbVkJ3v0cgduQIsKHdN3bvpz1BMV2gjjgl0cSvvqLoWcjai4Ey9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(6506007)(54906003)(38100700002)(4744005)(316002)(36756003)(86362001)(6916009)(8936002)(83380400001)(186003)(26005)(33656002)(508600001)(1076003)(966005)(6486002)(66476007)(66556008)(66946007)(2616005)(4326008)(8676002)(5660300002)(2906002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n6PhD4MS/QubmGfxZOpyeQOl8wcdyVltq0JyXc4xTbmfX1snsKbMLG3dle3D?=
 =?us-ascii?Q?/Q2agLPTvgCi4jT4tY1owJ2crLCtet474TuVlnqTVHtGYO8+n9pt7O8bNPjs?=
 =?us-ascii?Q?R4DGdgsPjujL/BnOiUPPYP/3HZW8I67IOXax76tbut0L7Zjr/iJ3NyicoZuM?=
 =?us-ascii?Q?x/nohlAcmKbc9tYsX05N3ZwGnEQ8OjpdrkCOahpsYoJprtYyxJG1RZEgZkXC?=
 =?us-ascii?Q?zfyfla2G7nkxvQEIJ/0z7v+PNpUlEaI8qJnAPsTj6XVDSV4wnEQE/aphlbIb?=
 =?us-ascii?Q?TN+RwboFqzC9xR3BDesR3LbUc/65xl5bWMHBPaBvXCFSQUrYPX6za3bpSAd9?=
 =?us-ascii?Q?GYJw+U3qpZJ7QaoqcEQFGbjjZ+ZYZiUex7EdvC4wYgz0vp7J9yMl3K6DGRpU?=
 =?us-ascii?Q?h6SoujDndU3xumUgdsamxXQPcAaWp1o4qdadxWsq/DZU52s2bQ8HGaatzSzE?=
 =?us-ascii?Q?8sApDk6lARPhGYY2lj403jH2IRWJ5GF8NefZSlW3/3HnC++3OoAFsinRQ/si?=
 =?us-ascii?Q?90quKe4WLac14FEdksSXJviTCUvejxdGZrgv8JSYW9Tx91Mk/Y9Mcenwn8j8?=
 =?us-ascii?Q?OB2LAmq46VZaFwjHZnlyiJcMdXVsnfVYUrnjQfB26cnFlu0hzvAv6n9DpwaC?=
 =?us-ascii?Q?7D/57wI11AHCv2co1nr+UTdlKoZZequDOPR6S/YkW2wvzG7vtNnXHSmT4qDo?=
 =?us-ascii?Q?BO1Ea1tPIqRDRHdN9r3IBoSyNrG8+tF6CNrcxTVcxjWyhHaHLRrZVyfdEXJl?=
 =?us-ascii?Q?QdKc5RH7/Sr/bbsPbPvtpyZFsSK6NIMPEFGm1T/5h0pAPG3xy7xUgDYzN/Lg?=
 =?us-ascii?Q?k457K7pNJb+BrRg9i11EWFYqV3xnqsRd4u2KK+TrfF4tNAYZIPThSwXJEgCv?=
 =?us-ascii?Q?d2eCGlTwoCym1OXvScBUyFrOgbih8pQ0fP/tHlf7xXoaFC8rinenGQqdJf52?=
 =?us-ascii?Q?aZbgqYi/iooiC8/+k9ZlDwnrV9nFXJIStEvIOLA+dRo+HGLQzhKEy+vmz7bi?=
 =?us-ascii?Q?1szKhgQc6Ry2aN6S8ojOy5cgeHkgpAlRZlJNEzfbQ6AZVAb8HFy2lIgWkX/x?=
 =?us-ascii?Q?0A6WbXoqTHIrgpydwFHJq2WqHzKgo+9PEeZwLqOkxjoSWs9H2NLDJQwWUgsN?=
 =?us-ascii?Q?RU2MOnSpp8zRQwh27Xj2+mpJ3hCxbWjL+IK3B6P5XacMWFu9vxsokOS2wAR2?=
 =?us-ascii?Q?cOKCOOYagdYweln2+eb+nDe6tRKWP62jISev0Erg0ZZqBSyJlAIsjh5YryaQ?=
 =?us-ascii?Q?m0N1ktFCYQLRlWjN5il7jtzAxnc4W8ebBoqqgFlg2FRPnmXPAX5fREYpwhPj?=
 =?us-ascii?Q?rVYyKhwN5Zma5qZOjqIFi3oGx8BP/c23eC3EXsYiNXMfVxCSL++dl0LWRMrH?=
 =?us-ascii?Q?wHxohIA59kWeC6zAnAYIgrTQ0lwJ0hqKauA0WnrsAvcBxw6NGNprpr+CuLkj?=
 =?us-ascii?Q?3v7bAAK4ZlqkVo2gld49Qmnd0PE8kLqzirFMFK8+7wzSWOy9Q8aGwErsQENZ?=
 =?us-ascii?Q?EIaPBI9h0fJO4X56TADSLkN67JOYOnnATCyV2jfjTXycz55u7Hj+sbxllG6f?=
 =?us-ascii?Q?aXKwPKcQ14Tgtv+GUm4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d65edc-406d-4752-2711-08d9f6fefb7c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 19:02:05.6772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chKR9bVdzQi5ikrJ3AS3KDKMyaGpuFa+4sZR56J7ZieFKodkBECwMwnlFffjIfdL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2945
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 15, 2022 at 07:55:28PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Changelog:
> v2:
>  * Susbset of previously sent patches
> v1: https://lore.kernel.org/all/cover.1640862842.git.leonro@nvidia.com
>  * Based on DM revert https://lore.kernel.org/all/20211222101312.1358616-1-maorg@nvidia.com
> v0: https://lore.kernel.org/all/cover.1638781506.git.leonro@nvidia.com
> 
> ---------------------------------------------------------
> Hi,
> 
> This series from Aharon cleans a little bit MR logic.
> 
> Thanks
> 
> Aharon Landau (5):
>   RDMA/mlx5: Remove redundant work in struct mlx5_cache_ent
>   RDMA/mlx5: Fix the flow of a miss in the allocation of a cache ODP MR
>   RDMA/mlx5: Merge similar flows of allocating MR from the cache
>   RDMA/mlx5: Store ndescs instead of the translation table size
>   RDMA/mlx5: Reorder calls to pcie_relaxed_ordering_enabled()

Applied to for-next, thanks

Jason
