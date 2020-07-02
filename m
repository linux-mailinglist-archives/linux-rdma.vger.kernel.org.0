Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B8F212C54
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2020 20:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgGBS1m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jul 2020 14:27:42 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8616 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgGBS1l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jul 2020 14:27:41 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efe270e0000>; Thu, 02 Jul 2020 11:27:26 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 02 Jul 2020 11:27:39 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 02 Jul 2020 11:27:39 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 2 Jul
 2020 18:27:30 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 2 Jul 2020 18:27:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXNvQnTQpC6pDxe21mD309Oua4PX/VHl8ob+IOobmx9RtHtISjKMfCWoufzvXtTDf40ftwyfBl4G/1cVJcLlCv67uZxQugKtOxgscAat9XIsxlThIdVKUtAdf6sL4UjOKKMQwIZ4UpTUjoL67Px9p3Xgx3ZT3xo01ZBWDO0sBBlH8vTjtROKiG1+83XWL8zB+yUMDw6HeUeOx+mNim00iqEDoL+m4Lt0rfnp3doXmTxMNQdQFNMYRO7erZtOWVR7Tw+P5Ro/MI6rVaoaAzC74fUrsKPigXW1hny7Km6IFLf0DXMeeYeyYCj+to0QCQ0yMh6OU5hpjvO4sPVkCXRcKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RB/eXtA0P+c49pCkPhmTDeGCPBLUlk8f1Wz49eBhhcg=;
 b=ZYlNV9rmOQEBzMy0LkGh1SmlymWFjy+2zz0wieiTrCWxviwQpFQUWnFh86ZqQXHvNy6IDtH5J4a80Bed35j12vib5cGKXn5LAj6o3SX5s9PNE2/HRE57XZAlVAPXXRPcAiENnSQe2pd2RJo2ZM8LFvlyBwCL8U8wFthxe63DJm446RYQLONZWxRiRBvVKaq2B69IHvQ7mSF5xZvC7Rb1Fe+K2X7s+jeJiz+il0IoWpe3fWuoRSUGiTlV8JWGwPyKp5X1JgqPrZouv/ZzX+HPg42rHaxoLmE6lKnJjYs4yIS6aaHqN435ao15NDJAgQ+rAaxWnrZh6bpamR7bcW+PIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1148.namprd12.prod.outlook.com (2603:10b6:3:74::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Thu, 2 Jul
 2020 18:27:29 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3153.027; Thu, 2 Jul 2020
 18:27:29 +0000
Date:   Thu, 2 Jul 2020 15:27:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1 1/2] RDMA: Clean ib_alloc_xrcd() and reuse
 it to allocate XRC domain
Message-ID: <20200702182724.GA744415@nvidia.com>
References: <20200623111531.1227013-1-leon@kernel.org>
 <20200623111531.1227013-2-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200623111531.1227013-2-leon@kernel.org>
X-ClientProxiedBy: BL0PR01CA0019.prod.exchangelabs.com (2603:10b6:208:71::32)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (193.47.165.251) by BL0PR01CA0019.prod.exchangelabs.com (2603:10b6:208:71::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend Transport; Thu, 2 Jul 2020 18:27:28 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jr3vg-0037he-1t; Thu, 02 Jul 2020 15:27:24 -0300
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a5186b1-a5d8-4c75-e9d3-08d81eb593bc
X-MS-TrafficTypeDiagnostic: DM5PR12MB1148:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1148ACFD322D6AC5577E12C2C26D0@DM5PR12MB1148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pcVLAjLx83iDxPYzH2JWKtVSp0d7oIg+Su0lSTK48w+QCgrm+yBJss4c+83aRHRpCK/Ja7cEqlr6tfpGIP3yYdo/Tczz6tJrvG80i+nX215CCGBYqw0A2kz0Jk73UFsdJ+mgeySdmKY7unsj9ErLZlujsSYztb5HGgMsTI++l38tY7ZrGdYIYh3UajOct3iRfKWDfgrH8+oQoH79avIeHqaXu8y/2r3Apwm1zDCystOPZTaoUSOmrlRGVwuUyRYspbUZSIlOXeyHf3fW8hB6aEevKxIs0an466ucEMq65QR7n8sK7EoEoa5dYIKPR9SgLTEf3HbVRs+3tbRy99GnV1TlQP42LgQuigb5T14mS+LiUiWNGnhorlNuJeGp+FvK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(426003)(54906003)(8676002)(4326008)(66476007)(66946007)(8936002)(9786002)(2616005)(9746002)(86362001)(1076003)(83380400001)(66556008)(5660300002)(6916009)(478600001)(26005)(186003)(36756003)(33656002)(316002)(2906002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Yjel50jfFdBvAQ7FrR+TgRRlgfgFoa4uJDIbMTTQ6toSeAx6XXtAh7Iqos5Emy953mYiA0jPWNGVHRf9RN/vIGy9XhoslB8kYRW3XmxstcGi2QNYsEzM+L0tLNu+whhwsBKcDgvy3AaTVFxERRQ3pg4pn2wMQewEZI7Iajyd//eny1/93VUPwcKpCMrkDbZ1mjBtpCji6of+K9zaf/CIFxzG9EUfyhng+1A9KwHehU8jnTrQ3D9C4UioTzcFGX9YYV0MAXkSppGqMNCLKvkdsJXNRaLckDTmGLuYG4TGeJhMGDCc4SWzOpUIfFqAqriEltDE9HnYmSdifddaWST0Ks6lmYQfrPaBZP093ngh7x35Jb0UFpb8E9qqg7bFaL1amDVENXrJlWNIhgvrtc/uLdbe35EykKPEJ79Ylm4Kd8JyJrMFUFCspVxf1C0ZlhGJqZpuuwjYdD1WnHKF1lX6clAKKxD5V3OpHC6BXJK8hLTpbudguHESaQvsPzoHABr9
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5186b1-a5d8-4c75-e9d3-08d81eb593bc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 18:27:29.0979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BAEkn0SEMu4m6dawJD4Ye8ScHVIvI75gJqhY4E7BCqSS/a+y9bI5mjoIUufE/q77
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1148
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593714446; bh=RB/eXtA0P+c49pCkPhmTDeGCPBLUlk8f1Wz49eBhhcg=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-Forefront-PRVS:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=cxcxp+vAlYmiusv1JDZ4CvwREWUIfKeuP0Nq4EjCfV3s/TXlpA7J1QBPf9QCcm+b2
         rx92mLmqisAOY34uZVnqLL/L/x6O6NwMUv2zACLNc+SNKBdi+S6UPbWalEQBhr8OEa
         k1nfxuAcB3KHj4KkX5u1rDEGqSPnH+IXOBDfOC+H+LVc0H0MR/2Pgdio2cn0C51Eru
         k+8yg6nlH5c0nWkq7CJAl3ATfg6yXT/giI4wibopB/z2nOx6osnsRwmCGGpiPcvkuI
         s1wKCgyGo2YansuXxSEFvsoqgJXchqD8HSXg0ZJN9LLeUvv9YpLnnJAsIGxZ7dEjsB
         oui0aQBqaTz/A==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 23, 2020 at 02:15:30PM +0300, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@mellanox.com>
> 
> ib_alloc_xrcd already does the required initialization, so move
> the mlx5 driver and uverbs to call it and save some code duplication,
> while cleaning the function argument lists of that function.
> 
> Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/core/uverbs_cmd.c | 12 +++---------
>  drivers/infiniband/core/verbs.c      | 19 +++++++++++++------
>  drivers/infiniband/hw/mlx5/main.c    | 24 ++++++++----------------
>  include/rdma/ib_verbs.h              | 22 ++++++++++++----------
>  4 files changed, 36 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> index 557644dcc923..68c9a0210220 100644
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@ -614,17 +614,11 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)
>  	}
>  
>  	if (!xrcd) {
> -		xrcd = ib_dev->ops.alloc_xrcd(ib_dev, &attrs->driver_udata);
> +		xrcd = ib_alloc_xrcd_user(ib_dev, inode, &attrs->driver_udata);
>  		if (IS_ERR(xrcd)) {
>  			ret = PTR_ERR(xrcd);
>  			goto err;
>  		}
> -
> -		xrcd->inode   = inode;
> -		xrcd->device  = ib_dev;
> -		atomic_set(&xrcd->usecnt, 0);
> -		mutex_init(&xrcd->tgt_qp_mutex);
> -		INIT_LIST_HEAD(&xrcd->tgt_qp_list);
>  		new_xrcd = 1;
>  	}
>  
> @@ -663,7 +657,7 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)
>  	}
>  
>  err_dealloc_xrcd:
> -	ib_dealloc_xrcd(xrcd, uverbs_get_cleared_udata(attrs));
> +	ib_dealloc_xrcd_user(xrcd, uverbs_get_cleared_udata(attrs));
>  
>  err:
>  	uobj_alloc_abort(&obj->uobject, attrs);
> @@ -701,7 +695,7 @@ int ib_uverbs_dealloc_xrcd(struct ib_uobject *uobject, struct ib_xrcd *xrcd,
>  	if (inode && !atomic_dec_and_test(&xrcd->usecnt))
>  		return 0;
>  
> -	ret = ib_dealloc_xrcd(xrcd, &attrs->driver_udata);
> +	ret = ib_dealloc_xrcd_user(xrcd, &attrs->driver_udata);
>  
>  	if (ib_is_destroy_retryable(ret, why, uobject)) {
>  		atomic_inc(&xrcd->usecnt);
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index d70771caf534..d66a0ad62077 100644
> +++ b/drivers/infiniband/core/verbs.c
> @@ -2289,17 +2289,24 @@ int ib_detach_mcast(struct ib_qp *qp, union ib_gid *gid, u16 lid)
>  }
>  EXPORT_SYMBOL(ib_detach_mcast);
>  
> -struct ib_xrcd *__ib_alloc_xrcd(struct ib_device *device, const char *caller)
> +/**
> + * ib_alloc_xrcd_user - Allocates an XRC domain.
> + * @device: The device on which to allocate the XRC domain.
> + * @inode: inode to connect XRCD
> + * @udata: Valid user data or NULL for kernel object
> + */
> +struct ib_xrcd *ib_alloc_xrcd_user(struct ib_device *device,
> +				   struct inode *inode, struct ib_udata *udata)
>  {
>  	struct ib_xrcd *xrcd;
>  
>  	if (!device->ops.alloc_xrcd)
>  		return ERR_PTR(-EOPNOTSUPP);
>  
> -	xrcd = device->ops.alloc_xrcd(device, NULL);
> +	xrcd = device->ops.alloc_xrcd(device, udata);
>  	if (!IS_ERR(xrcd)) {
>  		xrcd->device = device;
> -		xrcd->inode = NULL;
> +		xrcd->inode = inode;
>  		atomic_set(&xrcd->usecnt, 0);
>  		mutex_init(&xrcd->tgt_qp_mutex);
>  		INIT_LIST_HEAD(&xrcd->tgt_qp_list);
> @@ -2307,9 +2314,9 @@ struct ib_xrcd *__ib_alloc_xrcd(struct ib_device *device, const char *caller)
>  
>  	return xrcd;
>  }
> -EXPORT_SYMBOL(__ib_alloc_xrcd);
> +EXPORT_SYMBOL(ib_alloc_xrcd_user);
>  
> -int ib_dealloc_xrcd(struct ib_xrcd *xrcd, struct ib_udata *udata)
> +int ib_dealloc_xrcd_user(struct ib_xrcd *xrcd, struct ib_udata *udata)
>  {
>  	struct ib_qp *qp;
>  	int ret;
> @@ -2327,7 +2334,7 @@ int ib_dealloc_xrcd(struct ib_xrcd *xrcd, struct ib_udata *udata)
>  
>  	return xrcd->device->ops.dealloc_xrcd(xrcd, udata);
>  }
> -EXPORT_SYMBOL(ib_dealloc_xrcd);
> +EXPORT_SYMBOL(ib_dealloc_xrcd_user);
>  
>  /**
>   * ib_create_wq - Creates a WQ associated with the specified protection
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index 47a0c091eea5..46c596a855e7 100644
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -5043,27 +5043,17 @@ static int create_dev_resources(struct mlx5_ib_resources *devr)
>  	if (ret)
>  		goto err_create_cq;
>  
> -	devr->x0 = mlx5_ib_alloc_xrcd(&dev->ib_dev, NULL);
> +	devr->x0 = ib_alloc_xrcd(&dev->ib_dev);
>  	if (IS_ERR(devr->x0)) {
>  		ret = PTR_ERR(devr->x0);
>  		goto error2;
>  	}
> -	devr->x0->device = &dev->ib_dev;
> -	devr->x0->inode = NULL;
> -	atomic_set(&devr->x0->usecnt, 0);
> -	mutex_init(&devr->x0->tgt_qp_mutex);
> -	INIT_LIST_HEAD(&devr->x0->tgt_qp_list);
>  
> -	devr->x1 = mlx5_ib_alloc_xrcd(&dev->ib_dev, NULL);
> +	devr->x1 = ib_alloc_xrcd(&dev->ib_dev);
>  	if (IS_ERR(devr->x1)) {
>  		ret = PTR_ERR(devr->x1);
>  		goto error3;
>  	}
> -	devr->x1->device = &dev->ib_dev;
> -	devr->x1->inode = NULL;
> -	atomic_set(&devr->x1->usecnt, 0);
> -	mutex_init(&devr->x1->tgt_qp_mutex);
> -	INIT_LIST_HEAD(&devr->x1->tgt_qp_list);
>  
>  	memset(&attr, 0, sizeof(attr));
>  	attr.attr.max_sge = 1;
> @@ -5125,13 +5115,14 @@ static int create_dev_resources(struct mlx5_ib_resources *devr)
>  error6:
>  	kfree(devr->s1);
>  error5:
> +	atomic_dec(&devr->s0->ext.xrc.xrcd->usecnt);
>  	mlx5_ib_destroy_srq(devr->s0, NULL);
>  err_create:
>  	kfree(devr->s0);
>  error4:
> -	mlx5_ib_dealloc_xrcd(devr->x1, NULL);
> +	ib_dealloc_xrcd(devr->x1);
>  error3:
> -	mlx5_ib_dealloc_xrcd(devr->x0, NULL);
> +	ib_dealloc_xrcd(devr->x0);
>  error2:
>  	mlx5_ib_destroy_cq(devr->c0, NULL);
>  err_create_cq:
> @@ -5149,10 +5140,11 @@ static void destroy_dev_resources(struct mlx5_ib_resources *devr)
>  
>  	mlx5_ib_destroy_srq(devr->s1, NULL);
>  	kfree(devr->s1);
> +	atomic_dec(&devr->s0->ext.xrc.xrcd->usecnt);
>  	mlx5_ib_destroy_srq(devr->s0, NULL);
>  	kfree(devr->s0);
> -	mlx5_ib_dealloc_xrcd(devr->x0, NULL);
> -	mlx5_ib_dealloc_xrcd(devr->x1, NULL);
> +	ib_dealloc_xrcd(devr->x0);
> +	ib_dealloc_xrcd(devr->x1);

Why is this an improvement? Whatever this internal driver thing is, it
is not a visible XRCD..

In fact why use an ib_xrcd here at all when this only needs the
xrcdn? Just call the mlx_cmd_xrcd_* directly.

> +struct ib_xrcd *ib_alloc_xrcd_user(struct ib_device *device,
> +				   struct inode *inode, struct ib_udata *udata);
> +static inline struct ib_xrcd *ib_alloc_xrcd(struct ib_device *device)
> +{
> +	return ib_alloc_xrcd_user(device, NULL, NULL);
> +}

Because other than the above there is no in-kernel user of XRCD and
this can all be deleted, the uverbs_cmd can directly create the xrcd
and call the driver like for other non-kernel objects.

Jason
