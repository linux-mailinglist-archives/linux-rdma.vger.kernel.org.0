Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7B255A243
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jun 2022 22:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiFXT6G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jun 2022 15:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiFXT6D (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jun 2022 15:58:03 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027566573;
        Fri, 24 Jun 2022 12:58:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETf6qYkXG+QDVqEmPo/tvoWKv/FLlb4Ge1cwI3F5V7T2lFuZyeUVr38qan6fUJrOjecnVlcH2JKad85QsVz4fduOnx9ozbrGXkJD5OYO2j88j2ePD04u6PmwCh7PcFpbcgDow9mMYErhhW8rgb3lvhC/RAzGPYLfw6a27HLv5O2xZ0r6FZ3Mwp5T02pbV7iY334l9l6nuzC+Lx6gh1YdSpXaf8VBUjPY46xP/Qplvc8Hsa3cFczSz7P14v21zqB7MbqD5naM+Bp2u2WhU0nf0RU4MoZgmecKCxo1pqHUlzRNDPshdaU0so7fwGzXxBSCcihcv6pLjwsxgZaPB1DKKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPHSF5NnU2gVRJ7Q2K62dMXe+cly8A7xCd01/sgtog4=;
 b=essqN8U3/aSUZk370yLbOwDll9R9xQkBM9R+UcCJybHxQ6IUVmTy8nlaTwXZ6bFCRoe28TrVdTjbXpLID8ufv75ee2Eaq2KcmMZ/MyNUPaU2KoOYAxifczPUV3PqVqDz4hwIq3QZPe4MSeP9GndZ87dBcnr9Cvsgny+xMFCRCvn844DH6NazWdxQiZawRHU0/8pnjbsqUFRir4+HJvd03rnxjH6rN7DFIwtpHNOVCEBu6h1K2DPXgvA0iuFryH2ZbsjvpVPqIJidmKt3UeHWPNu1T1PXK+LggZpZ3X7UcOKv5W1F8VHN3FUFzd3AC1Vngky9ZM2zzjSmQEb3YEO7mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPHSF5NnU2gVRJ7Q2K62dMXe+cly8A7xCd01/sgtog4=;
 b=W2sit0J4M0qg91r5w9dou93NqE5dz7abrxgbqJyABic3DbQrQCbfwfZIZf2377uDRUq1j2TG2quqecrFVrLbrKNG20EyYY1OJnygCIx73oAov8oxuMLR0ej5Sk76PmFtXGjE1/Z1KkE1bOFBilUFkdCiKlts+kgzHVXjZuPBy9cRqgsW2yM63OTvb8bmvkS2tpKH8JKWF2p5glNvS36z3yYC11D3eSeNdWxXpxpwbSH4Sg0OL6fgjQRUjycUte3rNva1G+og/DEE0PmfrjgNEL7b55JbZ0SAAKVd2v9beb/HjTaG/vgfMflJycGpn/r1LXoL3qvWj3PuYndzMTP5LA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BY5PR12MB4003.namprd12.prod.outlook.com (2603:10b6:a03:196::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Fri, 24 Jun
 2022 19:58:01 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5373.016; Fri, 24 Jun 2022
 19:58:01 +0000
Date:   Fri, 24 Jun 2022 16:58:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/core: Correct typos in comments
Message-ID: <20220624195800.GA283233@nvidia.com>
References: <20220622170853.3644-1-jiangjian@cdjrlc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622170853.3644-1-jiangjian@cdjrlc.com>
X-ClientProxiedBy: BL1PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:208:256::15) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 253ebd3a-f32f-417d-8aa4-08da561bd7db
X-MS-TrafficTypeDiagnostic: BY5PR12MB4003:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A/kzYnxgDmmHjY/e2XiB2dyeaROF7oEcWCu2OvpS+UfYH8ucyl/LNCDHDuOablJDrEivmcq9TL24/7lmG+NFTCiGt6Lno1GKgETWw24ZE6YoLKV8ubIaP884V3uH9OINgeriLHxG5zP01vfklYDMc87Qm1CidRz7VlRJJmrGBINfTdrM2G+h0FLgHFbDL03w5GJyGd3/rioNrcfI+83RQlSihjVkMXtKYA/4aW6+WbtHptRtEdXPSl7d0vyWlxh3uLzpDZDPjcBT8KrqhZxKUPgq5Zwhx7YxwTflYZJgUeWXoAZ5rzIw3qb7RzVwkIYaCMXSMhpPix5vwLtF/4G9t8DRbrnLa0f0pDEdlg3nbrVC7RTxL4wwANhi34YZauBrtWuDkPQki/WOCZSYyNh371URIP3A0htWMABs+C9T/Tk6U9sF++shXiEnUoNAJPXxzET6VBobbtPEPaHt5XOJ+CK6mLd8KgoBIsTIis1o4fcSKHrEvDu2IpoaZIfXpIXdQNdQkSQzPI8KWOO7TsqMmWJ0iowDqQkuX7hcNnFE5lULJWCmcxCn7f7R25X120zIAZeBQYV7R8CS2ZNVUnaD1Q4O19s9glb9JbzI7fPjpTzKV27hIg6xxdYuTqHxDU3MUda4fEkuKSuU7GA5jM6f7scUkOSfPWn1KRA4M4cpYVWa48xhHTatIkW55bVMgArbM17SX2dHo+O1phG584nboNuxvgXnfochRE1p6/QDuRuCkve9MQ/vYXDdM3lbRUSoRTVafkCoLmP9nlF3Q6dt7qv8DikLWfymRlMbZMgRUUQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(4326008)(66476007)(186003)(8676002)(66556008)(2906002)(316002)(66946007)(36756003)(478600001)(33656002)(6916009)(26005)(2616005)(6506007)(4744005)(5660300002)(41300700001)(6512007)(38100700002)(8936002)(83380400001)(1076003)(86362001)(6486002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dlks7sDPk0or6/uiC5up17xoQfu1y9gglzQW6FFCbmbqR+efsaJP+tUQqIwr?=
 =?us-ascii?Q?xjy+0t8XQoEzSLd54tFVT+rvl7OTLp039U+YWlToCLrng+mEMBkW5DLIlvRT?=
 =?us-ascii?Q?FGk/Oa0kd0Rn7McZ5OCJVWVa7ooO9+moWVcs90rWq07Zb78HleR7EbuBXEFy?=
 =?us-ascii?Q?U10HZeKomAeAZ90EVU4e3Wu0CwxAPYFkqYsj4fbOXCVMdpYZZ/8yP2Y+Imo3?=
 =?us-ascii?Q?rUQm12Bj4XEJfhtecOEndhbeDa6f6WLvNC2sroAnIZmvsmTjVaJ4dWggYHUF?=
 =?us-ascii?Q?KaWahjY2md9NwjgJaDqa0dN5ZqP8bGPtZ+CffUIFuAzZip0fmMhjGs/Xea6Y?=
 =?us-ascii?Q?3KyEYPKFrwdWAejGgic1GnVXkuyb2qv/d6E3CY66fSIurvwFsG+H6p6jckjG?=
 =?us-ascii?Q?r1cnVzogRd34sg90VesHUz3NSFBPCM5GMCiPyo67AAMp6+kzT48yR5Cqfs+U?=
 =?us-ascii?Q?ybJPy982iYK+gUbJf9JDkSVBt9FkKBGNeVrtNV2EWnOkHc2LrZ0GP1N879S2?=
 =?us-ascii?Q?6nCIwYpqEFPEUNS5+JSLeDc9dOkgqMordeaTSl2NMAZSWDnHgarEIJpxwawK?=
 =?us-ascii?Q?87/AvmoQInimrQ/mu1dSdnwIPfB6BFD3Z/U23ccQ9MK7eueL/RDiXwY3UNSI?=
 =?us-ascii?Q?02Ha843nOnbKZdZnSCC9lx36dLxxYxT/Xst9tiIVGYdqRYSor/ik6fBzsq7D?=
 =?us-ascii?Q?NR5SPX4Wylxe0tTbD5P+pu59MA/hIx5RX8yuS5PHDQweZvzR6snAK+MwxL5e?=
 =?us-ascii?Q?vHPtVBnMfc4xW0TOtJz55mZfu3bJRPt++EyCWG677ZpBG1xcygxYqujmylXL?=
 =?us-ascii?Q?qYf4Wlz35LXOcZ2pfg+3jH2paxNtH8q59/fxkSKm74qB7QDDxvyGwoqZeBtX?=
 =?us-ascii?Q?L3VG1JA+ul5no/i1w96EVQ0ZKHqwtpbAD6LS3JYlscLICd7QgXGIetvo/Vl2?=
 =?us-ascii?Q?proGYZGMTZ5o9702ulWO1bFuGd6roycD3GGFHSDP4wKA9Ec1UhlTSrPvuxHy?=
 =?us-ascii?Q?Kyh8YpnR4rhQ38T7sx43gqUT8e+3tsMxTKazcHJLEX8VdSL5BPcCMeXTfwcH?=
 =?us-ascii?Q?pvcnQPUji/8vSS6t1Hy87Jtf4CpTqGqeNbpkKXztsGjNUcElm8nJ7u5R2ZZj?=
 =?us-ascii?Q?hT5xhrVw05+xJ7KllnApMxs9cQhsjPXiOumXnINGsLg5V84LYpbL8rUu9+IZ?=
 =?us-ascii?Q?KRSk7CJL73pVgihwnU76vTX3hA0oi/isTlwqPWlbNH0Ev9UX/l2ElY+ryNTA?=
 =?us-ascii?Q?8kNbF2Dgq6Ghcnnh84EejLyY0oazq5uyF+lAcOV2Se4nX1dbb0STYRVD+/Uo?=
 =?us-ascii?Q?6/3C2xXIlQOn8r2JpW2ZTSxzVq16vlGh+1HGaYtLQTrW2FWudfj5lCF+RVJz?=
 =?us-ascii?Q?SZnDNcnUAmI6GD8vSTisS6dB2xN4vxU8bRzVCTJ+PlB+dgixjbY2wp650j2D?=
 =?us-ascii?Q?agR5Tgnh4frotoYZnh+6y8VvUs9UVnRPeapj1O8L5683gLZL8sn6E7h9hb9T?=
 =?us-ascii?Q?sqV47MvY1Xy9lxGKrGFyOG6s1Cxx0y0re1FzzX7hWRQkMmUiwPtPZgMIHfZj?=
 =?us-ascii?Q?mESuFjYewuTKGfVxWYVl7XzsbbxDjcajugBUX40Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253ebd3a-f32f-417d-8aa4-08da561bd7db
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 19:58:01.3484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tqfn9A9AlEzF4quVHaqhMxDEcG01gnr+CqRQwW3OYuvB5ZlReZlBzmzBcdxm4PPo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4003
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 23, 2022 at 01:08:53AM +0800, Jiang Jian wrote:
> there is an unexpected word 'is' in the comments that need to be dropped
> 
> file - drivers/infiniband/core/rdma_core.c
> line - 71
> 
> /* work and stuff was only created when the device is is hot-state */
> 
> changed t0:
> 
> /* work and stuff was only created when the device is hot-state */
> 
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>  drivers/infiniband/core/rdma_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I squashed this patch and the next one about 'for' into one patch and
applied to for-next

Thanks,
Jason
