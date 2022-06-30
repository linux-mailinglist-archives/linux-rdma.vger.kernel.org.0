Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1142256277A
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Jul 2022 01:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiF3X6A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jun 2022 19:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiF3X57 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Jun 2022 19:57:59 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA105A442
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jun 2022 16:57:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIh05TlEQoTYEevwGHtyEisstWzKgvxPeakL+LqKFPeRF48iUguYEEyUCtR91jvF0rNLM30GbtxgxPRmwOoGbkw+5PWwvsbbm+J7WOaAphPwrND/O3s3KWoZV6wSpSgulFb0Ak/TtBbOgV86eHxIz/KT5kcWa1vL38jax2+mgE7E6yWpoZlVQpBQUnHYEMGp1Di+3Xb+4rfGUIwXiHgM0rrQQ5+p0Q7H2RONezbRfXq5gKwJtX+gAx8fXsKNBkyYHQ1k76Mf8fEq1wr5Gq2pIJaEUyiTu+kNOEetNnv30o1i3pYMr59UefdQFQt3m+IW5YdW2akhOLM2haLkxZ8PWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSIf72HGMFEV0sGnJalBRxEVV9PZB2OOh7Y4ScAUdbM=;
 b=fgDgePtWEcj7C9pMp91R/ruUkKPGZMQ/V6tSy4o6jGujKEeBvO5epfV8RSafT9mXqWRrcITHVVerhHlO2cpvfcSEOtHBs3wbAOeJNO41U1cbm7FRitTdouaOuRGBDYyIZvTzQeQJx5IxmZhEmEf9POQ6/tOl3cuTTpdZ6iwb7/TMKCtz8PpQe7jd6T/P1fQBZCtruFnP6SA+hn1uEkOJosplO6TBv9ygsn7LXKtUT55Yx0oJbP+5/cMKjiWtKWdofmS5ZZn4I3Xz5lycP9aguI8kb/TiyS3i/WiLsMUCEPgg4Xwa2+fH01EU3K+knBQAuQbgdSPPqYGR9DVO5e+RDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSIf72HGMFEV0sGnJalBRxEVV9PZB2OOh7Y4ScAUdbM=;
 b=o0z12p8tMT6bftqaTBKZhVRSc1/v64zvC3S5Ik7D9HNZOTSwuYA/MdMEs8V1XfYNobpZTDttUDWJTBzyGnCRJR8Raaq0iJahqzzBYMhFTSeFlLRuA7BRavDXiEqehFaNiXETCGNRlQoBrpua6AZ6mwb6SMF5XhmLC68/67cIs5YiY6M0ITt761yO8dUq/a/BwHTgLaesKed99Op+02rITRgq0ETVBcdkRNdA0QcXstQaEN6hYmp+4ELUHeShbussPuxb/WsF9TxdPLEpfYUopZwuDni47KwB5RsgaYp+993ahGYYYUgmE5u5W16PR0wJTbidIusuywdIvoQy7Sh1Iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB3758.namprd12.prod.outlook.com (2603:10b6:208:169::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 23:57:53 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 23:57:53 +0000
Date:   Thu, 30 Jun 2022 20:57:52 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, jhack@hpe.com, frank.zago@hpe.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: Fix deadlock in rxe_do_local_ops()
Message-ID: <20220630235752.GA1083417@nvidia.com>
References: <20220523223251.15350-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523223251.15350-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL1P223CA0025.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::30) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40fec8f9-a933-48da-5b84-08da5af458c4
X-MS-TrafficTypeDiagnostic: MN2PR12MB3758:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D61ZUn0iz59M0wz/J/hNSujf1hr9ttjykr4QplmrToYnZC9jUsYCgWMWXkqmJ1ISKcClQy06SB31BI0yPh8ZiatKTDyBGr1QdKawZlFf65UbO0GWPuy8ZNqX7Pc4bY9BJjA04J7plAPJVT0JTVdHpydgg+NP5/fh32XFYm9jALhQ1QcYClVDxYX5b3/CU7vGet9P2PRya6uUch7GyQEF0wZq2WpvmjyoYN+wau1/Vrgo0LflJLwJo3k7l0nLrdnOydeNEYpwpk9ODSrDSU2NdwkkpH4ojqsne9CiBLJLTFLsPznNtHUTI0lU5XLOV6FIFu0RLytswFWkFQVrlJytsr/FzZwBrgcxj+Pyy2ppdpmFP5QAKkY9o2LHmOQXUMvtOt31YhSruU0hX5PZpfjnnz3v0Y6666zn25l2chLbDxunBvuzfuLg4u3HF1+7vbIEwzB5Z0n7lUEYI7LM+9jj/o9yUR+ZizmRFre0Q6JeneJvsPFtaXbwjSehQl3R+p3aJBx6Cxv0LJ0LCD/yAbXCJsdgYJpWFE497I+HeFJLcCwvoXH+YstNevgb6BoDjdo21cJ564x3o8OE7ULCl59FMpCv0Zh/10nJuLH4pwzfmzO+CNCxmeAuKLNtdJAJGWNy/glbBfGDDa9HyowTBuhvkOGq2bWrw0QzAf5cBZmdfKOE3ab80cI7y5Nhe6en1/QMh0cphKKdSMOCl68na6ku+kwUSy7G9myaichM1dXcOf7m8vx416LdfI2b9HYxGgNRt0YF/AyA7O8T7gc3pXYyQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(1076003)(6916009)(2906002)(186003)(2616005)(38100700002)(316002)(6486002)(36756003)(478600001)(6512007)(5660300002)(86362001)(33656002)(8936002)(8676002)(66476007)(83380400001)(66946007)(4326008)(41300700001)(6506007)(66556008)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DXWCy7Li9Q/im6i7Uqz4cV3o+mP2TLz80OQkLOuaIwk6cKdFur1kEMsL7062?=
 =?us-ascii?Q?zMUIlAAIvfsUVoVSOS9ChO2cKpd/VTkzgTfb14oQOEAZCAm+9uftZip5cwee?=
 =?us-ascii?Q?pyyydZ51kWL1ujYYFDb6rDE/KUgEcZI/1giGNJlW1TKNcsyYyc84dWJJy7+I?=
 =?us-ascii?Q?jiuVccy2Kr/jiIDVln84Q79cGec7VK8mBU1qqEk4o4lVdn2nm6Odp1gA+IW7?=
 =?us-ascii?Q?G4iv/KaoDmsCUqDus79C5cLuuB4IkPEIOR5QpFwJA8qQIV4V5mS8VnSNsNy9?=
 =?us-ascii?Q?cc4E/6P91/4IIxeW1GBQ6efEbStwFX87OLiL8yt9dRtThyi+8DG3k63fP9lM?=
 =?us-ascii?Q?M3UGLYLNDO3iuBOZFNGnAa7Yh+CCLeuInZzxgD7/5r6K7sBsGjQcPXbHwXwQ?=
 =?us-ascii?Q?vI0ysWqiH2oI23roPFcghsnesD63ze4ZZSIr4AzXm8woSRyuBYjaV3UOlnFA?=
 =?us-ascii?Q?h8s5YEe0RqiHg5GZ2LsJYBBfzRkQWV7n3efLnUFKonUHxE/US4c/Ln6ScQrx?=
 =?us-ascii?Q?gArGoyrRxQzDgf8IIif0VSX3h3RCsl9JMRAfivVeJgjb5rWeGTmRJofXlJAX?=
 =?us-ascii?Q?YyC+rmlfF6C42lXHeI3mbREK0UM0AOYE8U+6ayVAkv/4EY6LBSVAnPKi0qUg?=
 =?us-ascii?Q?M3WJfzQL2aWh3qy6cpp72c3s4eT7/J0Wb5At14xVEUlC2ZhNIn9wtCfXGWjA?=
 =?us-ascii?Q?iUOZMcPdMb6f2rzzt/seifI2CVobzKPo+YnJ7Q96Epw9nka9iGT9vxqHrTR1?=
 =?us-ascii?Q?t7pDISjG/ms8Mf3oLRVae0anqJm29GpZg7bt7ilBvGwRNuVAu+/7FW22yBeZ?=
 =?us-ascii?Q?iQVUAFkgs1V+UeZWjXu0vSkOVW9XlNUNhyx1xs4c3I3g9NDETbnisGA2/erS?=
 =?us-ascii?Q?0E+HlpEixDJ0rmD/Zv0EOpjLkmjQ3Cuwq++NhNrI1jgrb5YRDrXAUxC/DGYh?=
 =?us-ascii?Q?zIQectQDIPOAh9fGkKfMcD5CRDOm0Wa5/vNRA91S3j389qggxcHO1zsCzq8t?=
 =?us-ascii?Q?GGQPQpNbfcrI+ob4d/EMvVvPRYEzoidY/JYOFIcPtjnqG1MrrT/p6fmob0mA?=
 =?us-ascii?Q?G8p3YtqR1RQsyZqI3PdfqdU25nzDtm5GNKXCINY2AnEA9q4cZEoTfzi9qive?=
 =?us-ascii?Q?nm6EGPvcyB8eHEi/bMDgvaJVWiSL8zw+7uqs97h43/mLdNn45PfIvnYlBpGu?=
 =?us-ascii?Q?7pwlOFZx2b5qXI5+d2G6TzBLwXdcXE6afbP9U9dyZlRRa8VIc1idavIK8xbe?=
 =?us-ascii?Q?IApqUw73e8WKaTitKCXBWHOVZTMj7tXswG4x2Rj97Wx98UwLJsnENgiGgald?=
 =?us-ascii?Q?ASWaeVK9NIlj+Nx99l7WAqJkqFVHcPWAptbbl6o9LLiOTrudgxi1KxcccKBj?=
 =?us-ascii?Q?ooT029JQNk0d/6lEYa2It/t9XWVEiwKx3BMbWcuLeNOU1zAPutGrPGttqk6Q?=
 =?us-ascii?Q?pDav60YJiL+REoCP59ie3eFztnIYyNuIhPsCASUyiv0BbeTNS/byReSh/A3I?=
 =?us-ascii?Q?T3GWoYKicjiggCPc+LxIKrrM94QPfSc8X9bMKH7c+ilTX3Bwte3wsviLLkVQ?=
 =?us-ascii?Q?4zVGsTvQjf40cYjNjSyc9xkV1EWFVtE0pBi4Fe7j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fec8f9-a933-48da-5b84-08da5af458c4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 23:57:53.5704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YavbImuhbEGktUzo3pklPishXqXhUtr5H4l7wkC1CUN3NimOUkh4mzuzCOyA8sFp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3758
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 23, 2022 at 05:32:52PM -0500, Bob Pearson wrote:
> When a local operation (invalidate mr, reg mr, bind mw) is finished
> there will be no ack packet coming from a responder to cause the
> wqe to be completed. This may happen anyway if a subsequent wqe
> performs IO. Currently if the wqe is signalled the completer
> tasklet is scheduled immediately but not otherwise.
> 
> This leads to a deadlock if the next wqe has the fence bit set in
> send flags and the operation is not signalled. This patch removes
> the condition that the wqe must be signalled in order to schedule
> the completer tasklet which is the simplest fix for this deadlock
> and is fairly low cost. This is the analog for local operations of
> always setting the ackreq bit in all last or only request packets
> even if the operation is not signalled.
> 
> Reported-by: Jenny Hack <jhack@hpe.com>
> Fixes: c1a411268a4b1 ("RDMA/rxe: Move local ops to subroutine")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_req.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Applied to for-next, thanks

Jason
