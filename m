Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103BA2B0B2E
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Nov 2020 18:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgKLRUP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 12:20:15 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:18647 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgKLRUO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Nov 2020 12:20:14 -0500
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fad6ecd0000>; Fri, 13 Nov 2020 01:20:13 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Nov
 2020 17:20:12 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 12 Nov 2020 17:20:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQCIBs6nsFkcqOyA4TyQnnKNhAoQxPsNDkgt3Tacta5ad6UgnU7udyQuQCLueq9KIAGHayhTnjgvtbUXzuRay/Q40IIqWvtCefYrsxo1vNtlLwmqmFRjHByjqtC/nASEjwQolTJcMjjLAOlLEthZXmJ1q9jlu88g9Dg40kIG6TlfLMU9jNE/ApEcoYR800k7fKFe+W/v/nY4YyjaykeUSUzVv42HsmxPmYZlb0SVaFJyY+RGcB2b7RFb2gZN1tKT/B7Y7Jtm8TEPuQwGlFCb1CCpnB47JpphOPx0D4VKuawB6A2xYmCoByeHcf7bUreSnRd1NN6kztYXt/yuvLvUkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NszQLOkdarnes/OhkUXNEL/ZRSspSme2uHVUqTtH68=;
 b=Yw/17F4mC33GpmixvBI0Wx7Js5F4ZZrczmvvsyiHzsonAyEp0+HZyo3jSXuNaR73YuRLebXmTYOM3WY30HbsGFyr1GF1tGxD+dm0vS3zQ4tyafE8TnJujLJkWX4XY7DH8vkQl+WgN2plSDlnBaP4EhAyneuiXsuJsj3wCA64u8XPWygpfb4IN0nDGcRjP2XbsMmCGWArEuczkKFhpVHNaqJ79BATW8P6Rk7VyYlZ3NHwwtJ4URdJV/K++gRf25vyaQzW5Hr5F1DlSY/7CchA0Lo7fu1GB5e06dUHUi7ZeGn95/F8HzXIHx71RujQ9mguNL0V4avGVPDM1fMdzBjLqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 12 Nov
 2020 17:20:09 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Thu, 12 Nov 2020
 17:20:09 +0000
Date:   Thu, 12 Nov 2020 13:20:08 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     YueHaibing <yuehaibing@huawei.com>
CC:     <bvanassche@acm.org>, <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, <target-devel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IB/srpt: Fix passing zero to 'PTR_ERR'
Message-ID: <20201112172008.GA944848@nvidia.com>
References: <20201112145443.17832-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201112145443.17832-1-yuehaibing@huawei.com>
X-ClientProxiedBy: BL1PR13CA0197.namprd13.prod.outlook.com
 (2603:10b6:208:2be::22) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0197.namprd13.prod.outlook.com (2603:10b6:208:2be::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.13 via Frontend Transport; Thu, 12 Nov 2020 17:20:09 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kdGGW-003xoN-4J; Thu, 12 Nov 2020 13:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605201613; bh=2NszQLOkdarnes/OhkUXNEL/ZRSspSme2uHVUqTtH68=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=LuNN6WDqq4V5EXxqOlzozj0ZaRO6DW/I5JebHsknkQWOhSOdXlCu73wG/lxvKFw5Z
         cUP7fgq/84NxQGACcYTiFvR7vF/LhyGXc7u1C551nC89eEQXZtpE8qqubdmVkYvRRb
         fcyZf0m7FpXLlqzYZOd0FVgFZAC08KMT0bE4ZNNVV9tDDXLsb9Do2x2ORmB/8gjIKp
         HbHSlPFhQWDEt+y6qbdZw3jilwdK7BJZJPQINGyMH16nmsKBidNKe7FahnLRrQUaNZ
         oa83ou4yzwx0/DwmiKvqMuu8nrNGEuOD/R+TEv6S2zK5mhnFW4qGXK9raGcIG2KtE/
         rkaSVgQkXVwMg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 12, 2020 at 10:54:43PM +0800, YueHaibing wrote:
> Fix smatch warning:
> 
> drivers/infiniband/ulp/srpt/ib_srpt.c:2341 srpt_cm_req_recv() warn: passing zero to 'PTR_ERR'
> 
> Use PTR_ERR_OR_ZERO instead of PTR_ERR
> 
> Fixes: 847462de3a0a ("IB/srpt: Fix srpt_cm_req_recv() error path (1/2)")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index 6be60aa5ffe2..3ff24b5048ac 100644
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -2338,7 +2338,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
>  
>  	if (IS_ERR_OR_NULL(ch->sess)) {
>  		WARN_ON_ONCE(ch->sess == NULL);
> -		ret = PTR_ERR(ch->sess);
> +		ret = PTR_ERR_OR_ZERO(ch->sess);
>  		ch->sess = NULL;
>  		pr_info("Rejected login for initiator %s: ret = %d.\n",
>  			ch->sess_name, ret);

I think it should be like this, Bart?

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 6017d525084a0c..80f9673956ced2 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2311,7 +2311,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
 
 	mutex_lock(&sport->port_guid_id.mutex);
 	list_for_each_entry(stpg, &sport->port_guid_id.tpg_list, entry) {
-		if (!IS_ERR_OR_NULL(ch->sess))
+		if (ch->sess)
 			break;
 		ch->sess = target_setup_session(&stpg->tpg, tag_num,
 						tag_size, TARGET_PROT_NORMAL,
@@ -2321,12 +2321,12 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
 
 	mutex_lock(&sport->port_gid_id.mutex);
 	list_for_each_entry(stpg, &sport->port_gid_id.tpg_list, entry) {
-		if (!IS_ERR_OR_NULL(ch->sess))
+		if (ch->sess)
 			break;
 		ch->sess = target_setup_session(&stpg->tpg, tag_num,
 					tag_size, TARGET_PROT_NORMAL, i_port_id,
 					ch, NULL);
-		if (!IS_ERR_OR_NULL(ch->sess))
+		if (ch->sess)
 			break;
 		/* Retry without leading "0x" */
 		ch->sess = target_setup_session(&stpg->tpg, tag_num,
@@ -2335,7 +2335,9 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
 	}
 	mutex_unlock(&sport->port_gid_id.mutex);
 
-	if (IS_ERR_OR_NULL(ch->sess)) {
+	if (!ch->sess)
+		ch->sess = ERR_PTR(-ENOENT);
+	if (IS_ERR(ch->sess)) {
 		WARN_ON_ONCE(ch->sess == NULL);
 		ret = PTR_ERR(ch->sess);
 		ch->sess = NULL;
