Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419CC42A942
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Oct 2021 18:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhJLQWV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Oct 2021 12:22:21 -0400
Received: from mail-dm6nam12on2049.outbound.protection.outlook.com ([40.107.243.49]:62912
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229496AbhJLQWV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 Oct 2021 12:22:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bC+L/z1K3MmOAUBTZUjyvVHd4o1ghiVpQziJWUtmdIPUqgAQircxURJmhjlXdgRLNGbH+IYnUaWeer/6cmMmV1VaV+UOmYw4uoYQUj9vGzCibZ0UeI8Z7NMnIYrrznN7lle98GclL2PFIkojhFC4ZXtUjSO04Z7f5ozfd8YwtQhrh2SzSXQ9XAuIDI8PyVBn5uz1UI9DtNj3bgx9LJnykpVt49sY0SSJxQnsMA/sWVkjaadl6LJkLjls2eYnIr9uhCxWoGU6TqFllrPU5JmdItfXL8lyyBpJ5dHfTtFSUZw+MynqAq9Js6CzKTJkFKQMUkk49HikAX+++8Jd/o6BEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmONpB/Nl927eedI+KGAXBKUDQtqKN+V1v8vTJdcopA=;
 b=XG9+y2gsDMnaRKVS6b+Eu6miDtm0VQ7QDQPyv73+vTQAcUX3hjCuXZDctQ59G+MkKIdwK7eZzx4bsdQdWiy7XyDPBrNGvCpNtsOskLF4u6NzdvhGdOdUU5uMWB4wqt354K/KKspirraVjHDzlu6NpOVEfimSrccxWZZwGLGnMwoG/IzDwElEo4AtXjBTw6GXMMoweN31SEhMGtOSmswq+0gs5SAM/FgBVXcyRe6pEUIgwVFj3tsn2V+bd4WmDANrNhAguIygOQ9RCl2uOP32PcO+u202fUH2OC/lM502rbyCGvURgg7m04xHBsU407yMaOSP+4n8GMqm5rVjwkNEBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmONpB/Nl927eedI+KGAXBKUDQtqKN+V1v8vTJdcopA=;
 b=dN662wuAdvAbNF2GoUOpib1/s4yQQDX7RIS1VdZsuj6lV75vIsjYl4M6BLDh1FCBjxH87o7Spx8H62bu7OYR1iDwqY7rJQNHHHRzvYqDgKX3OS6HFJ+wuNJQVZ7X9n4uiSYsapTetT3aIxUr2XCIWpk4mQGatUEU2TnJlTFZTDmqkEr+4YUgvPC49xIwyf70ajj99YBuoyxtk2b+H2Tz9D97SdY/JTX/wKTohI0A2pomLLj3lK/jQUEVbRW1GKZmjPR403Dju5xnau4lfauhSDQ8EQF3FUsDWdwHUhNYyFqUSBL7RdDF8zpLTUUsZflI5NVh4PyAQUmqy7O9RWRYRA==
Authentication-Results: wanadoo.fr; dkim=none (message not signed)
 header.d=none;wanadoo.fr; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5318.namprd12.prod.outlook.com (2603:10b6:208:31d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Tue, 12 Oct
 2021 16:20:18 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%6]) with mapi id 15.20.4608.014; Tue, 12 Oct 2021
 16:20:18 +0000
Date:   Tue, 12 Oct 2021 13:20:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dledford@redhat.com, bharat@chelsio.com, yishaih@nvidia.com,
        bmt@zurich.ibm.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA: Remove redundant 'flush_workqueue()' calls
Message-ID: <20211012162016.GA3381697@nvidia.com>
References: <ca7bac6e6c9c5cc8d04eec3944edb13de0e381a3.1633874776.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca7bac6e6c9c5cc8d04eec3944edb13de0e381a3.1633874776.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: BL0PR02CA0059.namprd02.prod.outlook.com
 (2603:10b6:207:3d::36) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR02CA0059.namprd02.prod.outlook.com (2603:10b6:207:3d::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend Transport; Tue, 12 Oct 2021 16:20:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1maKVk-00EBkE-TF; Tue, 12 Oct 2021 13:20:16 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56bd9783-8054-4b83-8b66-08d98d9c2e26
X-MS-TrafficTypeDiagnostic: BL1PR12MB5318:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB53181CD27B1AB2EBB6BC1977C2B69@BL1PR12MB5318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tArQ5CU2NdkIdSIBawibK/pygL0wlyu9hfDjZH5UlsfL48DSMb9toc61UNehN6K4Rw4uqRuzEn1J5hGQL2zAsPf7YRQBS0fs7Tw6VLsBe6bXWueNBQRfWoc77QM+B2FZtjJRdL5TP5BXPb8bCg2qxlL++eHGgfZ1QbVYrKAIgIINvy8U/gOlGF1Vzhjh7CDXRb2X4RjxYAtk1dUEjYPrEoX2J+lgYtxNWA3lkJLuyiJjfJUNniGsSnfFptse31aEj822Sqir+pMfaPw/9tV0cIaireNyqBq4XmaUOutTOMB39pNdVnx5OL707a8npD3VT6RLvKAMha758w323OVER1Q83yoTgOHKKQp3+NgpiKuCPKPAs8B4tdNvAcX9bJmWKQZLDX8QIuibBJi+WkWHS3nWraYPxgv8qsOumuT0Tq/3MKXGH7d/10pK8MPXLDvAXaiUzAIpf66ris2XiUj/M2NUSZTSAidbPl4+6wExlk06Ko2aOkzjiVQGjzkQVCrtDhZKCMrNu51vku/dpxeGNJZfjbtie7Fb2kNVJEZh7FmU82xVhKexwXSH8/WkvxJ2dFKHvAGdt6qc1wGTaT4p1HDWQpa3+VT2jr60I2uk7uPEYjo2bNTP2R+Fxedv/cjR8L4dY59EPOg6t7PTPkWP1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(9786002)(1076003)(9746002)(8676002)(316002)(4744005)(508600001)(4326008)(2906002)(426003)(2616005)(33656002)(26005)(6916009)(38100700002)(83380400001)(36756003)(186003)(66946007)(86362001)(5660300002)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xw/B8/4KowRZokXPtrrxjUlV/3anNHv+wzSEnunOPIqCHJFgD2JyyiRjm+6M?=
 =?us-ascii?Q?BxXHvzmG7DiQmYZwXIHNPf2GM77wnBRHJP1k9wyou0ihGKzUB1XxKONHaBaj?=
 =?us-ascii?Q?R3SB5XlSeEL5Z+vU9DiIEzcby7xj/uVG36/R2eHqM7ZwXTD8Yip32sCJPgwd?=
 =?us-ascii?Q?fTQRTtTwcNr/2wIvu5z6hu0MILWH08Bnb/TFwACw3XL4QlA+nvLS+PE4AdYC?=
 =?us-ascii?Q?kg05qNy8hh4pkQaPTfOpllQ48HupIztq+YCcnndfZAkfy62TtDutFe9OXonZ?=
 =?us-ascii?Q?bKcsGhVXfui8PiArVzRrSANVHUxMK716h+tA6NGiG1fTdGdvigy5qedbHrV9?=
 =?us-ascii?Q?u4mMYDaOX6KH2VclnBzd36A4b15DF6HnPa2sm9iSYgxk8dypsQdHGogkxH46?=
 =?us-ascii?Q?Np3SrpkWLco3jEMFoF0Oot2/MpXiWDZt7EcQ/Aye/iaR+dz5csbnOAu7VFTm?=
 =?us-ascii?Q?VIeuitk8lHPvoznrG+HGXhvJYZR8/Aa1Hnm/Z31gEUqhNr7n1B0gvKMxyoqP?=
 =?us-ascii?Q?e6DfIP2wCQzs6duiOWlmX8xx3i/7PHOWozfsYS2Py7XBvPgIrSjOTkznU+Zn?=
 =?us-ascii?Q?YWuFmRjU+MmBnD+iIsHp5R046A2DK8SyzbdknOcehevyu48IHr7+DZGxCQl1?=
 =?us-ascii?Q?w73H8r7sC8ZNSbTJKKglPSvOu9DtytOp8LxLxdj+mvMyrQTScWQbgAum0pBj?=
 =?us-ascii?Q?QcsNhGVUmauT/W+eQc9fU9Y/diDVqNdEHz22OyTCLUfMd4W2eMsexOp9Pr/U?=
 =?us-ascii?Q?dY+lQqcoUoUicL1HKA/cdiP6Q0iqX2GAjE2CCikipWXEBoohbgF3YxFTJ7+/?=
 =?us-ascii?Q?7lrNmZZAZSBLWKJQ+L+d0t6Rj3VhD8m4Lrc5Gz+EU2eQeDc0mGhC4aucX7bJ?=
 =?us-ascii?Q?ElMDXEazODclch68uNpsLBkWuWBKIsxlmXLpngqDeWcQU6t6vCjg69XN2Kit?=
 =?us-ascii?Q?T/YfrAb8y7F2i1txfksGTppiGfKF8sD959zVALHPNqEZ2+Drf7OrquzeereC?=
 =?us-ascii?Q?F6tzaJiXu5D2C+5JNOX5ESNIhJzYR1MXZmIuoJ+sdfSnalOXxy2nR2/F5sM9?=
 =?us-ascii?Q?kquPMevss7nFCxd1jo1XD6rWm/kO3DYohQ3Es1bv3e4g/hLWxHQtF9uGudz/?=
 =?us-ascii?Q?Y7QxQcHId9fLre6TU2wPphiZZuj9W3+KIeWMOih0K+7fFMeRxFyxelwbANXa?=
 =?us-ascii?Q?0eC5mxvV4u1e+poFjS4ibUy9wyIX8c3eUGWzv9wwZxslBP3umQEdYyNB0YJn?=
 =?us-ascii?Q?l1mAVBnujMmVy4ruYCkrF0JLdd974c7pTsfN74yC+AwCT/y+wsT/6RspAxt+?=
 =?us-ascii?Q?wS9AkFdzSHfCE5KMoejDdHz/zrQi3RnccyYVC75ArJwDpQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56bd9783-8054-4b83-8b66-08d98d9c2e26
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 16:20:17.9762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZgWZOgoJOQeeG6MAzfIxXPesoBeam+DSRJMi//WljJXQL7S/UgoCNW4lAzDt4uD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5318
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 10, 2021 at 04:08:10PM +0200, Christophe JAILLET wrote:
> 'destroy_workqueue()' already drains the queue before destroying it, so
> there is no need to flush it explicitly.
> 
> Remove the redundant 'flush_workqueue()' calls.
> 
> This was generated with coccinelle:
> 
> @@
> expression E;
> @@
> - 	flush_workqueue(E);
> 	destroy_workqueue(E);
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/sa_query.c        | 1 -
>  drivers/infiniband/hw/cxgb4/cm.c          | 1 -
>  drivers/infiniband/hw/cxgb4/device.c      | 1 -
>  drivers/infiniband/hw/mlx4/alias_GUID.c   | 4 +---
>  drivers/infiniband/sw/siw/siw_cm.c        | 4 +---
>  drivers/infiniband/ulp/ipoib/ipoib_main.c | 1 -
>  6 files changed, 2 insertions(+), 10 deletions(-)

Applied to for-next, thanks

Jason
