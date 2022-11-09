Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8D162332D
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Nov 2022 20:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbiKITIi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Nov 2022 14:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiKITIh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Nov 2022 14:08:37 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287D2AC
        for <linux-rdma@vger.kernel.org>; Wed,  9 Nov 2022 11:08:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhQF64avE1ez1YZgIzSIiLMY2WMqzAdbkP5anu8KkzQOCY488KCbB/gFOUNIMxHTvLNLvXcnVmNmm0NzTL6BYgSHZANdjzhGC/tR31nfte2kRTFJO4Tfk/JL2HzILUSkDAAOvt61VoUOnJQkpZoxJYVLPAj7WPpGS8B9P+A8tRLe6zDAIIZm7yHakgYiImMoukuN6j/fRcL+pUnJ26v95pMVJbnnMyuDjD4xCA6vtbcPCcvnN32TSnJeYnVyT+Tw9cKSCK6P0rn4/5YpS0rgsJ4RG48WR/vDPCfZ7NO9g/qj5cethQr0EaRKjQleesB3fELqFZVkRKypmzh5kudPHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QNvJ0Nc+nxJofXP2PBTu5bgpZKyeGMBY3W3a8ScOEw=;
 b=Cw+bthbDyMye4QBIl9xRns40MHD0UYq4n73JYddcwHfLWjrkN04vV2Agri5q98fbUE0HYtR2Vwh5qIigKGhL6CD+D/lQSUTx+/zGSNZICx8obndmeSnSablABuH139fRng0dNP6rff2LCJRinKMDabxbkwv7wUBCu9usMRDcbef1cBU/djl/6Xtcu+EVlnrwL0JCdgIt9FiWnX61uza78f/5nsZWAos/dV4cgqmqpfFhc9gcCTMkY4rhPqdza/si8+50INbKo8G2ON7UH5OI0fZk8kTcCm177w2DM2ebEmt2fhAPQY3rLiu8UzBkIG+6GXwkGbd9yZj7Gl0twsnq3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QNvJ0Nc+nxJofXP2PBTu5bgpZKyeGMBY3W3a8ScOEw=;
 b=RUOtRn8vCTzHTP+od+EujaIuTmzU2/4filYmmJsMW6+VIbrgp/HOZIMjINsU6XH+g5RA5poKCCuSnnMq3YNIrlm8bPmy75SQ1KHRuV9wgThkPCZ+ByKkabyhsULGwR02P7ijL4Lv6cR0ZOFbhNmldwLlZ5EZLxzBHqGlzEL+RT/FphoPqASxkDR31gbVF2tahB8qoIdBJWxki6ur/wY6JrksmWpHkiFoH7Hl8+i/w07xEcl7gWg9hAqZ6xbe/nOh8ALEdbuikAZdhi7xEI9vIVFhU7m7LEfhO6kWaopKNKKiE3HFELq3ICKX2VE4VI+MkG/7BO/WXvNvi5j/9+dIpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6763.namprd12.prod.outlook.com (2603:10b6:510:1ad::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 19:08:34 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%7]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 19:08:34 +0000
Date:   Wed, 9 Nov 2022 15:08:33 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>,
        Or Har-Toov <ohartoov@nvidia.com>
Subject: Re: [PATCH rdma-next 2/4] RDMA/restrack: Release MR restrack when
 delete
Message-ID: <Y2v6sTD8docw5bjK@nvidia.com>
References: <cover.1667810736.git.leonro@nvidia.com>
 <703db18e8d4ef628691fb93980a709be673e62e3.1667810736.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <703db18e8d4ef628691fb93980a709be673e62e3.1667810736.git.leonro@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0130.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d030875-d2ab-4349-2913-08dac285cc62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ICI+WJi91HhK3OzCjKH43rUgX4Uzz5uAsaxRVuNfN98be3f31Bl+6Geti5OAaF9l1pWWL1WbLdg9RjgALQyUhfbBuW7jC7rAFhnRZED6nxtKaZagGeJDYgGFRgCpqNzLca2rMsPHqXYGIAXqmw6MwPRniLEoIhbCjYzDOKwHDWq1J+keD5LqtAgyi5wrvB7+AQJ3qdYi/n3s2EsKPLz79PvPCWRpt8wrOswLRhS37GMKzHON2PBFikqBAwKttpvpjEOLvV8DFcT1ds6o6P02d3yEl+wNAfisZ/CmLXqv4BnY+TNcWh5SxuMSRQM4kniBeWebuzJj01cnyeja8Kh/2gKM14U+YKyn82+DXkQLCXVyc89dCf0ZX8zafkgE79EKOXtEmmAvfCACXfApqyAVd6E0rKnhVrpjiPMJQ7ZJOErklM3GJ5QbM1fHDKUHWXJEp6W6hEFkvrxSKqKvfZ94E8EBdFNfGTt8TBg+J/VbRqNuCVV2LN2qx0gLGhnEHj+QBIVMrvcVzoX5mMbzI8YM1SiMeokPpCst+uUp9fNM4Qb0QOc3m+hWQ+XTLaOAoZc0IWmPc/UnVfe/85nnfeWZcI2RqJfXKIulQSM9E3x4sRl9hx2zOlS8LE81eZlKEJ+ql5JYtwYFCwu4+zHickbd89Dqe55v/VPtrZkMSV9xvo09Jb9HH4vzJYecss3RqIaLo6ep5IAXQtH3bWbQxrEgSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199015)(6486002)(107886003)(6916009)(54906003)(316002)(478600001)(66946007)(66476007)(4326008)(6506007)(6512007)(66556008)(8676002)(26005)(8936002)(186003)(2616005)(41300700001)(5660300002)(36756003)(83380400001)(2906002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CCiHmG+F+Jm4fJq7jg2ZtNDiMM3d+wq4c4McTIpO7wUw4SDKsO2CgeFQ9nhV?=
 =?us-ascii?Q?0YCXgHm46AGuL1IO3wuxZzck/RIgheKaQcuPZ10l5iEpx+WyxM3qAFDcJ1BW?=
 =?us-ascii?Q?opoFBjqU6+GzmMBXOPP/RK0/5zrosugyBWR/0gTXdlcfv3BSIFv0tYAdOYCT?=
 =?us-ascii?Q?g7dZz+QLju34Oyy49TNNolzBa3U4Ft3V0LFmRkZpkSMO1yAkSUzV68xpeb4s?=
 =?us-ascii?Q?mpf5L/fApJdOnS2O6Pv30/txt2kgFnD6HiCJbr8NwZ+D04a1YQVxBWFlUsW5?=
 =?us-ascii?Q?0Px290UzV2gP3u4VgC/WsPP/aE9F9eYBBP13WwuLrb6txIja/632bBiGRpNR?=
 =?us-ascii?Q?9DCyjnUQ1Xy+Xjns9GgQR9j42leMIDy3z+bJmGuOc2ma0xuVQUM9PwobKPcJ?=
 =?us-ascii?Q?E7OZ5aimKsARc1zlkb3vYl14e3ErOqY+A3Eo8hxXyRcHxrmQqlkt02Zlbuqu?=
 =?us-ascii?Q?ios3EY48Q3/7hhNLSGfZMmzE5ua0VbMYJs4UJbHwvxpgCWjO/NXvZEW946TB?=
 =?us-ascii?Q?AUrcdQ+q0oRZtuApRTr8cAWBRV6YGcknKrVU4QewQSP5c9uM3snwk2/LQP4E?=
 =?us-ascii?Q?hh2JktqM9k8XgjIsxBfHWEjK7WnoVFt2SeN77/n9FBjJr4KTkI2zrr9On4+D?=
 =?us-ascii?Q?THMCuHQ5geT2nTa6ZfUKxMTMQznK5FB4VIr/Q8/nDgcfpKSTXCa7iKr6SV7a?=
 =?us-ascii?Q?gXfDoFasz+Gniz40q9iOElLcG6mGk6nXd4g2V6pBl0UWaFuC0Xv+2nV0b3lk?=
 =?us-ascii?Q?4tORadab2sRpBv+h0CCuVkRilb57/CWNhuOVOl0wmrkNfHBG7+UDi6//uEAQ?=
 =?us-ascii?Q?U9CPhMQAw71d3jXP9+BkpWZMO9pJ1MPeNNifiQ7R1ekOhNp3DzqgRmkx48v7?=
 =?us-ascii?Q?yqgppfJZNOp5QwX3tq9bRiCwDrXF1y9IsvP1ewtioF/fXzmEQ42Q8stDcPFq?=
 =?us-ascii?Q?AO7QBzleFGwWkLQx6iDKLcJxi5TB5k781olbnylIgJHr6L7E06cgZFveTJbn?=
 =?us-ascii?Q?yKETXDA1uON56CZzCSVYsvLINHROSEkAxqQISVCtiVzX0OKKaLnt3xD5fkEr?=
 =?us-ascii?Q?b44vnuUC0AxE+VU7oLemaU46caRwsyG2uD5O21bhN5IRP+m0oOjNyEmu3zq5?=
 =?us-ascii?Q?vHkYdS0fSONZ6L7wVm/rNPPeCo53AFa8IiPfxe9TVaUFmfoCq2Rvv+zQ00Cj?=
 =?us-ascii?Q?7HHR6L9urA+wSCavmZL6rVS5kGTC14QFQRgyVHfmM2v2eFU5I+et1dpaYBcn?=
 =?us-ascii?Q?dYE1Uu+IC4OTTUimwFpiN82NmIm7/G3T/ZI7Ibzu5ZYfkU8ESHjQosrEaD4M?=
 =?us-ascii?Q?+rP/k7YyF+er7OxvxPx/xsHiXzC50KJQNk/n/i4nclklvKVFWWfoL9TIgDIg?=
 =?us-ascii?Q?dm2aFok5zGBhrrMAAk/aKUUCJ/AtU+5ExWvU1hid2pc0r4mSEqW3Hu1LZ7Rn?=
 =?us-ascii?Q?OFSfQNtg20CJe/HJ7/glb/6ehilcoB/43QQnMkwj4JGxqg6BGv7pnUTNJ2xe?=
 =?us-ascii?Q?TlG5IWlpHivNcspKP+F24u20/LziNGrgkck1Yno4nTnza0i3qnzdrjV7RoHK?=
 =?us-ascii?Q?mNuSZS88l5n3833l7ec=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d030875-d2ab-4349-2913-08dac285cc62
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 19:08:34.3801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97u7b4piZphDQFvrgoWrkdnUFLHfR4Ssv16rQx3bNz/ONhBquRd3WY8NKbHjp3Iu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6763
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 07, 2022 at 10:51:34AM +0200, Leon Romanovsky wrote:
> From: Mark Zhang <markzhang@nvidia.com>
> 
> The MR restrack also needs to be released when delete it, otherwise it
> cause memory leak as the task struct won't be released.
> 
> Fixes: 13ef5539def7 ("RDMA/restrack: Count references to the verbs objects")
> Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/restrack.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
> index 1f935d9f6178..01a499a8b88d 100644
> --- a/drivers/infiniband/core/restrack.c
> +++ b/drivers/infiniband/core/restrack.c
> @@ -343,8 +343,6 @@ void rdma_restrack_del(struct rdma_restrack_entry *res)
>  	rt = &dev->res[res->type];
>  
>  	old = xa_erase(&rt->xa, res->id);
> -	if (res->type == RDMA_RESTRACK_MR)
> -		return;

This needs more explanation, there was some good reason we needed to
avoid the wait_for_completion() for the driver allocated objects, but I
can't remember it anymore.

You added this code in the v2 of the original series, maybe it had
something to do with mlx4?

Jason
