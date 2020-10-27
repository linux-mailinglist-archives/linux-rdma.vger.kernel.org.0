Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D466D29BEE3
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Oct 2020 18:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1814489AbgJ0Q4e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Oct 2020 12:56:34 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3941 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1813835AbgJ0QzM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Oct 2020 12:55:12 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9850da0001>; Tue, 27 Oct 2020 09:54:50 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Oct
 2020 16:55:11 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 27 Oct 2020 16:55:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SY0dyTpBkOCgcDnooF/PuHGhjDLpQC4C3UAmxJeW6Ri6cYYlOQwHlUZ1SqnkPB7B16wBAwoHvalWYRpvMqa0IC8JlboaeVpVnBIF357NuSaS3dnfzLagL3HkPQJQhZ9F1qSzONIEjKfNuRAoalulwn0jUQGJHGhDmvvm+49KECxoiKqhZzaNOLE+gyXojAI9koDIiIgx1JlNZ3FrJkppfw4t9i5r0WE3nB1DUA/HSxwtdGmnhTl//4M4s1qezUA/AhVFzATomaoNt5KJ3jvbUtasChFbJHnpX76tknKqCPVKEQQfUnSqkFQqfLLQPXV4cxb2oFFTQ8Lpozh8fgNQeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1eMFpoAU3Zt7o4nm7M62pxmjHeIW38l05OYMJqy1Lk=;
 b=UHNXoFnYvSVDLGYCL9EmMNvDiNpwuFr8+Ctdxkola0yTlo6e+bKk2hChyYPd43f6mqFYng8CVIoGyaDOZEqZd79shGI9E4wIbQOMNLVET3rkLtGU75imI1N98YQ8gcnMKS0aFa5OpiFsy42RXn8LhH8voPSMraPeutP4K6NTflS/BGfLnzk0fFtGYLA+DW+vnyTKXmnCoecAdeHVkFtu0JUYMMw4Gq9csWiemZryooDEOMH/NhbtCfoO4xAc4U6tYp26XKzXWYpQwc+6Gsvu3doj9ecDd9VTThErdnH4YwmIBaDF0xGT/UKx0BUHHm5llOlbu/03cQT5d8nbQsIR6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4500.namprd12.prod.outlook.com (2603:10b6:5:28f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 16:55:10 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 16:55:10 +0000
Date:   Tue, 27 Oct 2020 13:55:08 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-rc 1/3] RDMA/core: Postpone uobject cleanup on
 failure till FD close
Message-ID: <20201027165508.GA2267703@nvidia.com>
References: <20201012045600.418271-1-leon@kernel.org>
 <20201012045600.418271-2-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201012045600.418271-2-leon@kernel.org>
X-ClientProxiedBy: BL1PR13CA0256.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0256.namprd13.prod.outlook.com (2603:10b6:208:2ba::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.4 via Frontend Transport; Tue, 27 Oct 2020 16:55:10 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kXSFY-009Vxu-P3; Tue, 27 Oct 2020 13:55:08 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603817690; bh=z1eMFpoAU3Zt7o4nm7M62pxmjHeIW38l05OYMJqy1Lk=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=Xt4H3PVcc2/T9mSyKYnua+B6rUsRCrTb99/C68D3YBxUUB3t3fj+tKYpFnZAx/JMa
         wGTxLHSWwWNfYMLiMSTulTce5FtbYnN9IdKFQQJjViNnh3e9wDq6hbwhpb1jKhFfOS
         Gh947ROjC2G9lWDlKSE48XJy9OdrUxg1C7wk1Y0GBZ54aiDy/b2xoTElOvnsY6DDYl
         2MB3fYq9e8AN8uCWeFavt2g4kc4RWuyfRENgurg4zOWbdL6ZjNan39bpuqdEsnr8+0
         +/1xRV+kpsZ2r2OScJ2EGYyS5QHuQBo5p6f222R+OlkdL0A7P9yz6ThUwTt5SmP9BX
         f2nEJdLTm7zvA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 12, 2020 at 07:55:58AM +0300, Leon Romanovsky wrote:
> @@ -543,17 +537,9 @@ static int __must_check destroy_hw_idr_uobject(struct ib_uobject *uobj,
>  			     struct uverbs_obj_idr_type, type);
>  	int ret = idr_type->destroy_object(uobj, why, attrs);
> 
> -	/*
> -	 * We can only fail gracefully if the user requested to destroy the
> -	 * object or when a retry may be called upon an error.
> -	 * In the rest of the cases, just remove whatever you can.
> -	 */
> -	if (ib_is_destroy_retryable(ret, why, uobj))
> +	if (ret)
>  		return ret;
> 
> -	if (why == RDMA_REMOVE_ABORT)
> -		return 0;

This shouldn't be deleted..

There are also a few too many WARN_ONs if this path triggers, I came up
with this:

diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index 3d366cb79cef42..3ae878f3d173d3 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -540,6 +540,9 @@ static int __must_check destroy_hw_idr_uobject(struct ib_uobject *uobj,
 	if (ret)
 		return ret;
 
+	if (why == RDMA_REMOVE_ABORT)
+		return 0;
+
 	ib_rdmacg_uncharge(&uobj->cg_obj, uobj->context->device,
 			   RDMACG_RESOURCE_HCA_OBJECT);
 
@@ -727,10 +730,8 @@ void release_ufile_idr_uobject(struct ib_uverbs_file *ufile)
 	 *
 	 * This is an optimized equivalent to remove_handle_idr_uobject
 	 */
-	xa_for_each(&ufile->idr, id, entry) {
-		WARN_ON(entry->object);
+	xa_for_each(&ufile->idr, id, entry)
 		uverbs_uobject_put(entry);
-	}
 
 	xa_destroy(&ufile->idr);
 }
@@ -875,25 +876,31 @@ void uverbs_destroy_ufile_hw(struct ib_uverbs_file *ufile,
 		goto done;
 
 	while (!list_empty(&ufile->uobjects))
-		if (__uverbs_cleanup_ufile(ufile, reason)) {
+		if (__uverbs_cleanup_ufile(ufile, reason))
+			break;
+
+	/*
+	 * In case destruction failed try to free as much memory as we can,
+	 * and leak the HW objects.
+	 */
+	if (!list_empty(&ufile->uobjects)) {
+		WARN(true, "RDMA driver did not destroy all HW objects, leaking memory");
+		list_for_each_entry_safe (obj, next_obj, &ufile->uobjects,
+					  list) {
+			spin_lock_irqsave(&ufile->uobjects_lock, flags);
+			list_del_init(&obj->list);
+			spin_unlock_irqrestore(&ufile->uobjects_lock, flags);
 			/*
-			 * No entry was cleaned-up successfully during this
-			 * iteration. It is a driver bug to fail destruction.
+			 * Pairs with the get in rdma_alloc_commit_uobject(),
+			 * could destroy uobj.
 			 */
-			WARN_ON(!list_empty(&ufile->uobjects));
-			break;
+			uverbs_uobject_put(obj);
 		}
-
-	list_for_each_entry_safe (obj, next_obj, &ufile->uobjects, list) {
-		spin_lock_irqsave(&ufile->uobjects_lock, flags);
-		list_del_init(&obj->list);
-		spin_unlock_irqrestore(&ufile->uobjects_lock, flags);
-		/*
-		 * Pairs with the get in rdma_alloc_commit_uobject(), could
-		 * destroy uobj.
-		 */
-		uverbs_uobject_put(obj);
+		/* release_ufile_idr_uobject() will clean up the IDR */
+	} else {
+		WARN_ON(!xa_empty(&ufile->idr));
 	}
+
 	ufile_destroy_ucontext(ufile, reason);
 
 done:
