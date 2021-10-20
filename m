Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32279435643
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 01:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhJTXFv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Oct 2021 19:05:51 -0400
Received: from mail-mw2nam12on2068.outbound.protection.outlook.com ([40.107.244.68]:64353
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230361AbhJTXFv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 Oct 2021 19:05:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpPsdx7mmsGWcPLKGpgbQqDn1L61Cj5WxbAM46BLHABS3yKfL8m8ZV7ebmkLcUTUkxvcoFZSvovHpk7p7Vq9ZCcbXSbveTxN9BEk7049nk3Jzpb8b5hGJ14zPM38g4PiInTwxxn/7cwuYA8yeMPDE1DpDpsxFuSaAY6lO21Dg3Lxm7uuhGH5/lZ4WPq7qeZcqIwcyXrIoczt+QER2bc0//mmBHjm04KbNU6WkWYQMBoDzlEpQTtFXM/xwLCV1K9GWnpo7IMyxtBv2QZiffD/pY9t45/eFBiVWiOs1bbFGbuqZmVJi6uDKqoD4W85S5XlQbOdDSR26BjRF5N87MWvKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxQkm3ZxQmep4SC6uu3KJbldlEFDntfTjBN3BvbJZyo=;
 b=oVeq+197s9QFYzoBECzuccc8i4DLstJhO3nteq7V7mCiYmXFJ508qdLheRfzymXjq65+eTu/BfMii0B8vsAOqswbZeEPadjEs53E9MOuEHjRLb81tmNfGdy0sthz+wUhKh8Hb+1X42tKpKcKufA1jNslod4WnQBHiTYepxR6IYiOi3Y+fr6VjaX6U2beb2C+wYUugEIJDx99fLn7NHktJkwhv/zO3f3UBGVyz06CwKikrpUnTsr88BRJy/LOlcL1TukgsEBONVX/wegYF5ThQBJG4GxaoDyzJO60dn8cluJuYUnSWcC6QNgmxhyUP7drQ76fSBUI2kqhG5GcKu0eXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxQkm3ZxQmep4SC6uu3KJbldlEFDntfTjBN3BvbJZyo=;
 b=J8y5PrF0cKlxxXUKSb6VRrmXqJbi3AJreaujTynL2R4fZY3fHbPIGFvfluRXW89C7J468uiPFMUOS2Pq4M9IW/C3FamVFwmw91l/6+KmaG5w3uvZnJdFvmRvYnnRLugq2CYaopldieo240YB97eINaYkfJnDb2bPzYbRtRpyRWO5oB0dqiLTPv4hBj8/OelHAEQpPIhPupsDhugWedApZfy1QdRtfeCaNTT5yUazNKQu3lsfM/fZXnB5df3ifkycfK/VnzgPN35UzmUmOtH90lhiCp5SZOGSOoFeNdzflT8K41YlHR6pmD9UG2WFlUNpr/rCRpNmnLq6ECLUieqKpg==
Authentication-Results: linux.dev; dkim=none (message not signed)
 header.d=none;linux.dev; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5363.namprd12.prod.outlook.com (2603:10b6:208:317::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 20 Oct
 2021 23:03:35 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 23:03:35 +0000
Date:   Wed, 20 Oct 2021 20:03:34 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     yanjun.zhu@linux.dev
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        dledford@redhat.com, linux-rdma@vger.kernel.org, leon@kernel.org
Subject: Re: [PATCH 1/1] RDMA/irdma: remove the check to the returned value
 of irdma_uk_cq_init
Message-ID: <20211020230334.GB27337@nvidia.com>
References: <20211019153717.3836-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019153717.3836-1-yanjun.zhu@linux.dev>
X-ClientProxiedBy: BL1PR13CA0414.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::29) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0414.namprd13.prod.outlook.com (2603:10b6:208:2c2::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.10 via Frontend Transport; Wed, 20 Oct 2021 23:03:35 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mdKcQ-000790-8C; Wed, 20 Oct 2021 20:03:34 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6eb546ac-7209-4251-0a94-08d9941dd82f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5363:
X-Microsoft-Antispam-PRVS: <BL1PR12MB53639D3C3F89ECE109A0D04DC2BE9@BL1PR12MB5363.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FPh8znK3pBUfw7L/6GhbRwJLA7l/bQixDYFDzSglg2jGedTt4KJXxNvY74aDBzPBvhMKneb2DR5RjEPAcpRIQ8Owgc13Z24AyqmzDvYbJoo7gxZrh4HTrDPSxQR5Phu7DMwQN8IEK3SUykoo4fQsmWRnP/c7P+eEf04VRgf7omt4GbMvP+BZe6NNfabBl4MekPD5bcpRlWersVQVEEG7E/m8IKNQJzbXZPRiYfAmbhmfERy6p83NmBSVxgFCNsBlf4bYLHVQ70azyuWP4IPqS3N3oDNfEjfSfOKCj81hGBl/p4fm8KS+JYnLtn73a3A2swWQ1x/hPGLzV19UZQybj9YVW51p9nqiGBitLmHAwpYmd3TnvpGA1YmQNADRIRP/MLDfAHJsPHsFuu9SirBMlJ797Iy5qsj1HelNQqOnXIHIEdiXx6UxxgPkEuTQoxcGPah0fQ/Sj9O0Hpq0yc6VZNYcI+H6ONZmr1NwY6X7WIA6MrobKGEHG+J8jhaTZFt/V5wWRGPvPgnN7G0CPksaZvS4vN12Rv6dxs/BX4GdfRLzZNJoYMSgYl6UEANyjkJAPiiq+GziPwp2EUNdkJ+NjLUl6qc0nPhLg4QEJxIer2uRWG8p+FjBjRLvAv4YG9PpkoeIOGdJjR4L61xvq8ca4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(83380400001)(38100700002)(2906002)(2616005)(1076003)(86362001)(426003)(316002)(8936002)(4744005)(36756003)(186003)(26005)(508600001)(33656002)(66476007)(4326008)(66946007)(5660300002)(6916009)(9786002)(9746002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F7sbdb4uji4wh1VLigILhh+m8uDMQHDRbhbWHA7OByqCNZGMSGlAB9yUMVkg?=
 =?us-ascii?Q?D4fRV5WJ3LhqCfFnpSB1ZKs0QNaYMebf35cZYDbDHNY5dsuYZgJMHPAfT7x+?=
 =?us-ascii?Q?8jb00pr2wIoLVndMWcaGo+2kZlIMN+vlYAt80YGYDBqLh5FYFOJnc51aGB/z?=
 =?us-ascii?Q?VO+XgirCDPXj+dwcApxXRl+A54aEPdj4PM9MrWDSIojGmHEtKAVKeUl+Mqmv?=
 =?us-ascii?Q?Fdb3wxc2QmSoYO+vVSN+Mb8o/AucyH1gUc6ZXWuBgBmXZIcLOde6XWnXtIE8?=
 =?us-ascii?Q?00Cll9nTpy9ZvR8oE48RocPQ9AXLSe8K6n39zGTVhnolYiuGxdY1J3Y/GXJ2?=
 =?us-ascii?Q?ez6igS67MLCWDsOy2cjdpJK5D3HmaI/oZzOrzGjPq780uzkLXfsvH74mLA0y?=
 =?us-ascii?Q?zpnGtWaFBULWPbLShYvZZ24qI+p0FzWpi7HsHh6XUEg6gVj7mxp/o/rxDTma?=
 =?us-ascii?Q?VobPm+zv4e+Ma3XVfx2NEsG7LkV7yAyAHDJjXNxTtw5/JRrseRtvbJ/73ZTV?=
 =?us-ascii?Q?pt3/MtxPIgvlahzESsSmiXEWMJVQDiYXc8BwgeneKF7sQjZ6wzeXlBTT+EqV?=
 =?us-ascii?Q?FddQfwFIGEsqlE1MYAwclNd36qtBdNOR95LCRYGGW4Pb2+lmkTkTTR00MDW/?=
 =?us-ascii?Q?NdKHX4trnzPYYFx5KvedAsJtlBlI8jn+vgXT+ZZgY8PvkYNCiZcldiyfCxoU?=
 =?us-ascii?Q?0XJvGUPHOHwCqpCmIGhq5RafXAzvzhI2+V98n8iApPprKkMtymtBJPKFlgEA?=
 =?us-ascii?Q?B5UkOf7EKt9Tbh3il3aWFzuVnm43dbe9LDD1el64jx/dl4CpfT1IZ/UW0HYN?=
 =?us-ascii?Q?Bu0Wy5M9rtKZFR0+/2sy4/i5b38ns7g3skp33iG5MkdEGsa6d2cceBLx7VgC?=
 =?us-ascii?Q?hrJkUcTxtFjXmosjB+lZC4g1FSXYN7qjAfO5vPBLrtqFJ6MI2FFiYMiMo3aT?=
 =?us-ascii?Q?XQZ1mEqMMhoTXG1U3uq0FixmPtXorKCyWyiBsDAGxDG5oX7uaYwhOMLEwBhn?=
 =?us-ascii?Q?Nq8vT/ahbuPq7kZs/Q5AwN7JcHd0uwY3EP+dWCq+NmXFJnv22IqHKVIWEN+c?=
 =?us-ascii?Q?9UMfcHzcQVH7jChpcDAxpFbpdr1/8xj39ptjiK2orUYrjA+692pX0NnCr0vv?=
 =?us-ascii?Q?1VNYl8bSW309ztDggGiyzH+yjS5jTWZLZHkrk1ljUbIT+CfVnvepivegyy1i?=
 =?us-ascii?Q?Pb8VCHRJ5WfEIY+NaFLCRnzVg5F/TvUpFDRyRaaoVSi039n/KOwVvP2UZOXG?=
 =?us-ascii?Q?f0/550+bdtwn1o1/tQKqibmiReliBZEWXw1h22zWF+mcThZdkmyjZ6Zcl3P3?=
 =?us-ascii?Q?gHCOHUKsj3UGUmkLo5o76FJMMbsWA9xbc2ft9b1VdlBgJI+H4gHPhG9aw6dZ?=
 =?us-ascii?Q?wsLGl8ozGgNkyl1096mmaKmRfbbmshS60Zo2oYoa07BN4qoeq6An/47C1nN5?=
 =?us-ascii?Q?YNZSDsJSY0o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb546ac-7209-4251-0a94-08d9941dd82f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 23:03:35.2874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgg@nvidia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5363
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 19, 2021 at 11:37:17AM -0400, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Since the function irdma_uk_cq_init always returns 0, so remove the check
> to the returned value of the function irdma_uk_cq_init.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/ctrl.c | 5 +----
>  drivers/infiniband/hw/irdma/uk.c   | 6 ++----
>  drivers/infiniband/hw/irdma/user.h | 4 ++--
>  3 files changed, 5 insertions(+), 10 deletions(-)

Applied to for-next, thanks

Jason
