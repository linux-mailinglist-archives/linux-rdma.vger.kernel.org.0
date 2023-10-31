Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544727DCF27
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Oct 2023 15:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbjJaOHA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Oct 2023 10:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbjJaOGt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 Oct 2023 10:06:49 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EA6D48
        for <linux-rdma@vger.kernel.org>; Tue, 31 Oct 2023 07:06:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsPDN0Pb16w/VKsHyCCooIOWJlB4ZRWEl5Oppv22bjkZmQL11ufZ9Ogf1v+P97rv3p/26f2IDB+nVyJd89EmaEVKTVwCGSztdT1uWrra4JFNpkDwO6R7yN1zcNZz57iX6g5vkm9PimIWVHFfpyrttDaTO3ngKR64Xv/D/Ht18TZPLdf5eoCw/DAAyrgnHLQ234GNS8fRbP3s2aIUeJa6tQN3LA96G8O6t6zBh3XRg5Iu0EyWp7Dkc2T49nLZlRSaRvHbEyhzN91Er1BOV7wFeK1FKE2wMwJlfiwfs39SOF7BuhziPIcoWjN/WAcojtppnnv2pLAhuiJP3RRXA7HzSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6noDZrjBgEkgnuDpMCiqchX2QMKMJUAblnIZvPCAclo=;
 b=URelVEaHCA/4LFrPddBXRHAQbDV7WX5d2h6y4LSffSiCmc+Q0hfmyvqBe7MjIC9aAkTC288eZfC5fiAcu8zQhUkAnjd6MJ9YtRmswuLNCvLS4p34Y2hhDlcxR+cBiXsCJM1NWBHqXUnacIrQtKuTB45oX8uZbgAgddXU4KExwraKQEkEgfycfxgdi+DC5vghFJyAYN+rm2GEaRcHVjVUzbE6ltWhW5rffd2/FMi/5F15O9AGTlumJ2czWxiPLxWVa02Gm8yfBPmCL5bLbi8gDLn68Npl7deyeiUGa0XI+YAGjMlyaZztDzNoR5zQOHR6JTjRcigO1+1pidM+xSjJpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6noDZrjBgEkgnuDpMCiqchX2QMKMJUAblnIZvPCAclo=;
 b=p9tYMhDD7TTHpZHHTjUgZKmjpojeabRS0GgSnan6N3VQ1e2K4Uo3ePYGQcB+2rRHOosjFns8BcJkY5iMgok5R2OF87dx1hwJQtPZEY9EHmutC47Rw6N1A0y8+kcTu8V4uKboCS5T1zuZQg2yf4beMAINppWf5hbwUL9gwYPD40GwaIScQr68XdO0npu6uJ6eOhUyXadAqHTG9gBG+7ljUfMSf9WBq5IEOUe6M7WeWSbr7lEZO80EHc1lWKnF0dNxNC6AH7PykAtFP+/4WK7CrEj75OX4kbXTvvNLA2dkrQuif3ejSjTU6tmU0rux8cg+Zb2ugzfqlm0Vd0I0qvO8Ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB7931.namprd12.prod.outlook.com (2603:10b6:510:289::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Tue, 31 Oct
 2023 14:06:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Tue, 31 Oct 2023
 14:06:13 +0000
Date:   Tue, 31 Oct 2023 11:06:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Moshe Shemesh <moshe@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>,
        Shay Drory <shayd@nvidia.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix mkey cache WQ flush
Message-ID: <20231031140612.GA1846982@nvidia.com>
References: <b8722f14e7ed81452f791764a26d2ed4cfa11478.1698256179.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8722f14e7ed81452f791764a26d2ed4cfa11478.1698256179.git.leon@kernel.org>
X-ClientProxiedBy: BLAPR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:208:335::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB7931:EE_
X-MS-Office365-Filtering-Correlation-Id: 802eadc0-92a1-4cf5-1c3f-08dbda1a8ae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uqzj+TBUiGlnxGLzXTB+F1nFwe7SgG1mS72cF6kkrr/5ayEDvXhmhSaN/PHh22nc8L5bwRP1/jURNcg7Af8tJietgCbeTRfDxJvCXX8M1n4V5yR/8S78CCpQywu5MqwTojAp32EiaVIaJQqA7HEGcewAsFZ2m6IsHcQNb6sBa0Tej0I5yZmc27pmGb5SEP5zIkorXgZXNkHNMSNeXN9kZyH3EN6N6V3X3zScIALG1XvKeWW21yQiJ9t4/KOUGf2fmBoEOKkiMJQudFTL5d1HJAQ2AwsbQ0YH3KJaZr66/yOJa8wARqjE7KlNbL2Z+urXD0pKcduxLsMjkob04OeBDswGd5n+R33Oz195dKNDPXbhLo0QQkKPwdJ8jYqCUtHIUZK4DCQ5vDemT4lI/VUofjf2EPra2ebOwOioHwXzsNkr7yqQ4BBm7lRHZGbwWnoDr4CL/t/ogMg7Bkfi5z0oOHDcXNWcGHr9WkA7d+9OWBcpLrT6uIq1X4FWKgIOLF0aDUQ4GBG3z8HPZrb/mKVnLfeWV3A10Awgk6f9EqG7/S2BaVBh8fUqN5zy8Rnqx4vd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(376002)(396003)(366004)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(26005)(6512007)(33656002)(36756003)(86362001)(38100700002)(54906003)(4744005)(41300700001)(2906002)(83380400001)(5660300002)(6506007)(107886003)(478600001)(8676002)(2616005)(8936002)(6486002)(66556008)(66476007)(316002)(6916009)(4326008)(1076003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PXSENbJTiI/lLGccAUHE9HC8VAjUdh6KSWkBcwI52xsEDKs+iTWQai0BSgbV?=
 =?us-ascii?Q?pd5LiXHgaoa/Oj3nTeYSEMS4U3GSlc55bcu63AjwcppiY0XqrgCqHl4HokFD?=
 =?us-ascii?Q?pa3PjO5FU2TVZlIUmQ4yXiM1k1qoJHgnP1rjRHupyHSLxBJDFzpsG7Rorjwg?=
 =?us-ascii?Q?h4cl+osZfRViECLJbgE2dTiPswkk+uBv3g7TTtov5SgXx8IjNgJrGVDaHDGr?=
 =?us-ascii?Q?GFbuMjr0wBAOT/hUL8xoOtSm7kjlaqOSIFFJr6jZ1Wk85kWxc4GQ1XYoxY/H?=
 =?us-ascii?Q?Xlm4FOt1ihDX0/Wn2MWcXItWIxNCqyNtAMjY60+WNJpqeYjvvz76BzSPmvcM?=
 =?us-ascii?Q?alW+nkNSllHatZHlITbLTuW9y+CxTE6jqZViqOk/wi65FChLFeRFvQ7XqPw2?=
 =?us-ascii?Q?Kr8Yoswhht4q2NTGU9oRjgCJ3X6pp9Zc+HQMK4d/1eijAB6XgGrfDDOaUUUI?=
 =?us-ascii?Q?UibV1ymhh8LHJq/Q735T/x+u40Fs1KLfMBjHlJnb5/IeDyh7nvOjO6nK9q0k?=
 =?us-ascii?Q?ShSpDPTd73i8KViAAoi6895e6WzvklHoQMC8LT4qo1xiymRipruXJeA58gTs?=
 =?us-ascii?Q?7CGIGoCtDcQj1Mif9RaAs7zY7QCYQ64Yq4OYUqhceQcRFocuuqnaSjwiwgLK?=
 =?us-ascii?Q?QWg2Yv5H5jprYPESbAAdqyCrGuarjpUZDS2Z/diFnrhKjbzBTPf5FWqsyCmo?=
 =?us-ascii?Q?dgOX7nea/NGUVHs7Sac7o2j9nbdbcU0H+O8vq7Rxy9WqPFl7H6c5PhxEYkb9?=
 =?us-ascii?Q?Z/bO7J52zmMhXqldRTn4Mnlx2eC6R/iWgneGvYcpZNH9N1FLJ5XyIYQS6315?=
 =?us-ascii?Q?ODGrGYZc+dKzbjHkpDvEdBGzuA0hM8yUK1wJ4Rhfu4w/Y94llfXj6+ch1ZWh?=
 =?us-ascii?Q?VQQ5LXqBGHgeGkCwCUCqAjB6y0IGbM2+tqFVYvFXUywvc0HQOMtDCViX2z0F?=
 =?us-ascii?Q?BoLK5MdHrQ3/jIY63Jqts72RXuTfCs7kYvdbjgJkhY8cER5V68SlOFS/QSnt?=
 =?us-ascii?Q?N7YeVhTawaAUz8rhmNdqbYjn6Dy4xQYf83CreCY1+pw1IRZSu9d9SXk3v12h?=
 =?us-ascii?Q?izzUvTIC4U+eeqyWqSEnKsvfBdB5o+uo6bDqpXtIzQywOWDx9yQr4/wPSwKR?=
 =?us-ascii?Q?YL2BBToSI2Js6Wb0H8l+ppWcJcVuZaoJ9/BNcfwCr5ZGMVLpVVCqpTUNbnzH?=
 =?us-ascii?Q?DFWv3bScA580LgUkijWzcy4lSe30wxNt0RnZzN+QllYqkrTu7WEIlwOvSfAl?=
 =?us-ascii?Q?u27RNer9bUDBxQfusbI/T1EmzFJlUiv/gzEgkEb70p0iHoOVtcpPeFSO1HEd?=
 =?us-ascii?Q?NMksazNFioA1PpmlEt0+p+CWwgVFh/N1M5nIwi86u8Syn9NaSTa1X9HV26k2?=
 =?us-ascii?Q?0/k/c7u+EMSpsOkknS1KB4x3BS76+xvzAjU/FB25PncYP39lsBAYuRjonXxZ?=
 =?us-ascii?Q?Q2/La26MHdD88TG/jLXYGbBnfK+rtm0yi0Ik2KNf+2P223n4BKiZzq8/zR+9?=
 =?us-ascii?Q?9zTb06uZn0j+RaWsneHZX4zQ6og9lbbPykqiZSbt1ZsHH8ahcjx0Jbkue26Q?=
 =?us-ascii?Q?K9Nbko85AEq3LeBIwg0H9J7rWk6OgqmjFXaR5Ydd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 802eadc0-92a1-4cf5-1c3f-08dbda1a8ae2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 14:06:13.8737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1LHxUhWC/u0O99YvvCy2NJ2pPO91x1JfXjgoPFjkxK15x7z1vfZ7Y2rnJvHxvR4q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7931
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 25, 2023 at 08:49:59PM +0300, Leon Romanovsky wrote:
> From: Moshe Shemesh <moshe@nvidia.com>
> 
> The cited patch tries to ensure no pending works on the mkey cache
> workqueue by disabling adding new works and call flush_workqueue().
> But this workqueue also has delayed works which might still be pending
> the delay time to be queued.
> 
> Add cancel_delayed_work() for the delayed works which waits to be queued
> and then the flush_workqueue() will flush all works which are already
> queued and running.
> 
> Fixes: 374012b00457 ("RDMA/mlx5: Fix mkey cache possible deadlock on cleanup")
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/mr.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to for-next, thanks

Jason
