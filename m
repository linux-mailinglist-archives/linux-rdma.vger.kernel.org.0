Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDE929C01D
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Oct 2020 18:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1816979AbgJ0RL1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Oct 2020 13:11:27 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4535 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1816978AbgJ0RL0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Oct 2020 13:11:26 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9854c40001>; Tue, 27 Oct 2020 10:11:32 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Oct
 2020 17:11:25 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 27 Oct 2020 17:11:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5WofiCWBnpmtSSwPwto+e3180wLu5MKvcruQbwi7EHBrKlyhl2ZceLtnmf3xu4pG1wgqqTlPCCFFPzEr4x0AdB6H/I65hkMDnuvAbDYy2dHm5Lc49I5j+99qQqnKlmYHBbXAHNmfVcgC2fZLb3tFbg3WWK5HABIK5qWXsXEVwj+0oKQcQF9apvCBnTgO2B0YcmhzHAYTk1UkCsWkZK0rdYsuXcv5vF0qKJlxXui/zRcnn3m0iajZAXH6BMn1Ru72a7PxKJn3ZmhVaLliykUP8LKDlIJBvLrbRiNOKSZ28izFkULFt613GQz9RKINBjSryJrUSmEKA6lRDUXY8X+iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOADcN9HQ2XlXcvNuEv3kI8JkYlZo5CcU9qzP0WXGSU=;
 b=YdNAslsYaz4/kxs8ro5ajlR8uwXIxezOQxRhgwG255g6olD+By8jgR6IxyuT037iC5UeXLxSG37wRrobT4D0u3vfn1sUjFfUM22aG2ey4fHleLp1oeTNXetytZi5qTYJQgBVE9sJFWtSP7PxCTqro7bApUAp5SLvsZ0Dn44ow4z+vP4Ku1OTLm0i6YXuTSb5L8D45xYvYR6+BYET0IngDo9fBmwwLwiLHOP2h2c2D5EaBTXnnLzfybKUytw8favcYomsKDgXTX1cfBoB0T8QF7oMJLvDgj2DievJ/rF3SnU1eD4NCmC+pquiWyoZaOM1RB6Aog/Eo6Z5XyTIgaCM7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3593.namprd12.prod.outlook.com (2603:10b6:5:11c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 17:11:24 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 17:11:24 +0000
Date:   Tue, 27 Oct 2020 14:11:22 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-rc 1/3] RDMA/core: Postpone uobject cleanup on
 failure till FD close
Message-ID: <20201027171122.GP1523783@nvidia.com>
References: <20201012045600.418271-1-leon@kernel.org>
 <20201012045600.418271-2-leon@kernel.org>
 <20201027165508.GA2267703@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201027165508.GA2267703@nvidia.com>
X-ClientProxiedBy: MN2PR19CA0070.namprd19.prod.outlook.com
 (2603:10b6:208:19b::47) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR19CA0070.namprd19.prod.outlook.com (2603:10b6:208:19b::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Tue, 27 Oct 2020 17:11:24 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kXSVG-009bZk-SL; Tue, 27 Oct 2020 14:11:22 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603818692; bh=NOADcN9HQ2XlXcvNuEv3kI8JkYlZo5CcU9qzP0WXGSU=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=SXynfMR+4vZXR+t7l1fqv83rVsiOM/cs845BJaw7STPU3OekN4+lcNk86gEr5QOZ5
         0Vwzjk/oF8uLreyqpqhyryuU3ctKh+7cR9apisGKJRNNLgZMZoge4orkjdMamJNdxa
         8aZ65TVc4x9lRKOyU/UxgUleQhaIUHxg/tfcoDW55J7DjLGpNzrV7xqUdtjFVvVI89
         BLr+k6RU7sTqaFqJaTRahq1XFkjlhPSXVt7AOdUabz27tuXpcax2XEBDN8gm1CA5rP
         r/AyCtsQRXIDsVT3Bb8Go/aZRUphwfshfyXW8X8g/H01UqQIsuaUFnfBorjhC2v5e1
         MWUHJPJRr86JA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 27, 2020 at 01:55:08PM -0300, Jason Gunthorpe wrote:

> diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
> index 3d366cb79cef42..3ae878f3d173d3 100644
> +++ b/drivers/infiniband/core/rdma_core.c
> @@ -540,6 +540,9 @@ static int __must_check destroy_hw_idr_uobject(struct ib_uobject *uobj,
>  	if (ret)
>  		return ret;
>  
> +	if (why == RDMA_REMOVE_ABORT)
> +		return 0;
> +
>  	ib_rdmacg_uncharge(&uobj->cg_obj, uobj->context->device,
>  			   RDMACG_RESOURCE_HCA_OBJECT);
>  
> @@ -727,10 +730,8 @@ void release_ufile_idr_uobject(struct ib_uverbs_file *ufile)
>  	 *
>  	 * This is an optimized equivalent to remove_handle_idr_uobject
>  	 */
> -	xa_for_each(&ufile->idr, id, entry) {
> -		WARN_ON(entry->object);
> +	xa_for_each(&ufile->idr, id, entry)
>  		uverbs_uobject_put(entry);
> -	}

Actually this is not a good idea

This one is better:

diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index 3d366cb79cef42..fd012be700ccc2 100644
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
 
@@ -845,11 +848,17 @@ static int __uverbs_cleanup_ufile(struct ib_uverbs_file *ufile,
 		 * racing with a lookup_get.
 		 */
 		WARN_ON(uverbs_try_lock_object(obj, UVERBS_LOOKUP_WRITE));
+		if (reason == RDMA_REMOVE_DRIVER_FAILURE)
+			obj->object = NULL;
 		if (!uverbs_destroy_uobject(obj, reason, &attrs))
 			ret = 0;
 		else
 			atomic_set(&obj->usecnt, 0);
 	}
+	if (reason == RDMA_REMOVE_DRIVER_FAILURE) {
+		WARN_ON(!list_empty(&ufile->uobjects));
+		return 0;
+	}
 	return ret;
 }
 
@@ -862,9 +871,6 @@ static int __uverbs_cleanup_ufile(struct ib_uverbs_file *ufile,
 void uverbs_destroy_ufile_hw(struct ib_uverbs_file *ufile,
 			     enum rdma_remove_reason reason)
 {
-	struct ib_uobject *obj, *next_obj;
-	unsigned long flags;
-
 	down_write(&ufile->hw_destroy_rwsem);
 
 	/*
@@ -875,25 +881,10 @@ void uverbs_destroy_ufile_hw(struct ib_uverbs_file *ufile,
 		goto done;
 
 	while (!list_empty(&ufile->uobjects))
-		if (__uverbs_cleanup_ufile(ufile, reason)) {
-			/*
-			 * No entry was cleaned-up successfully during this
-			 * iteration. It is a driver bug to fail destruction.
-			 */
-			WARN_ON(!list_empty(&ufile->uobjects));
+		if (__uverbs_cleanup_ufile(ufile, reason))
 			break;
-		}
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
-	}
+	if (WARN_ON(!list_empty(&ufile->uobjects)))
+		__uverbs_cleanup_ufile(ufile, RDMA_REMOVE_DRIVER_FAILURE);
 	ufile_destroy_ucontext(ufile, reason);
 
 done:
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index edfc1d7d3766ca..7e330f4a6d33ff 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1471,6 +1471,8 @@ enum rdma_remove_reason {
 	RDMA_REMOVE_DRIVER_REMOVE,
 	/* uobj is being cleaned-up before being committed */
 	RDMA_REMOVE_ABORT,
+	/* The driver failed to destroy the uobject and is being disconnected */
+	RDMA_REMOVE_DRIVER_FAILURE,
 };
 
 struct ib_rdmacg_object {
