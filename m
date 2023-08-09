Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B137767F5
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Aug 2023 21:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjHITKJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Aug 2023 15:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHITKI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Aug 2023 15:10:08 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CA610DA
        for <linux-rdma@vger.kernel.org>; Wed,  9 Aug 2023 12:10:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6gCwVAqU3c6TPR5RLqzVo5qZ1v7xypKDt5tzg54i79k+vAAV//lHkmgsg0gfbO75nbA+GUHNN07xiDmT4fNAHZQ1dupB267zjlol1AXHUG3Clgab2k1UlF6lADUIj948wMJzW03S5ECtbtDpthmvtYl5N2v4LZWk9H+u+ydaNWdjl8jxosZB/NZssouz13vu4YC/73vKWjCB2bbZ74rM5F2EtL2B8arXErbeAl8tI+bW4R9KCOucWUnvCmGAzKFwKRmarNsNeSvqZR4BMJCUdNOocWXHIUJUelZ8l59e1PxuD131H74GeYP0GgdAdJ5MlaVE/nyt/W2ub06Mq4/4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxk2pn6AQi7De+gP5Mm+xRk3EkcaIY3ezbIxT+/8w7k=;
 b=Re+nCH2TLuY0bvbJ0DfQgFzT+iQzGvnM9W8O8uwI4z108Abq4iJsldb928GjR+Umymk7dmwjGUwp8B1dKO46YG4ruk67noRNRaLFq2nvpHCB7/wtAF1vGp66w5NfWLc1fPcc95voKHJVw1GX2gOqH2u2cFI5PdLyLeKx6Kd+zJgfH2+b1qClTLfvtWutl6n5Fc+Fv+YPE+w5fteGtN9lHOjPIwPRq+91iQ4RPO6iThSUl7KkOrRvbRG7oikALrmh72+cZHIGCiYSdWyBxRFnixiebwRCpNP+L+gaeiVnxywNSJLxi9IUNSK8+RYPul8AxfGWQdVh+Ca0cSKYV6z7Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxk2pn6AQi7De+gP5Mm+xRk3EkcaIY3ezbIxT+/8w7k=;
 b=lzLtjnf+ZSPri0WmpmOaipLoqXSZrPzxxm57i2ZLg8WrcoQsE4zlmEmyaoJ1W9oIxWdag3809e/LfPNDAaALedROesshdCxuGHp3Klp3NqJtGpmgmJ5WWcLb55BEPHxqReOL4Dcnzax6IL9ihv+gWH6SahCOxy8QmmpCBD5zMr6lozYeQ96y+BsGZb9Zwlbcym8OwlOFaFt6gwiO2FOoLatu+FOFeTdEZBvJYcmk1vK2OXVxUtuV6LSCq3TLJAjhVLPPOdfZ6l3thoFMTNMgyhR8GFgfmtuIJQTT86aenmV6xuLUKAgfDdQVos8SKKdLSsqw1OuMu3mA8FY7/RXTfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB6055.namprd12.prod.outlook.com (2603:10b6:208:3cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 19:10:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 19:10:05 +0000
Date:   Wed, 9 Aug 2023 16:10:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        jhack@hpe.com
Subject: Re: [PATCH for-next 1/2] RDMA/core: Support drivers use of rcu
 locking
Message-ID: <ZNPkik5qUPRzZXAW@nvidia.com>
References: <20230718175943.16734-1-rpearsonhpe@gmail.com>
 <20230718175943.16734-2-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718175943.16734-2-rpearsonhpe@gmail.com>
X-ClientProxiedBy: SJ0PR13CA0214.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB6055:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f69ccbf-d0e7-4aba-3dbf-08db990c3d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d9iyxarESvc3m0/L735APgQPUNCrHlr99dhLvZFNGFEELZNkMOHcRz85xf3zoFZcy01wEkbPQtsPA2DlXDDfxDAH7TlNBuHczRKZqkEIYfXvQzHXgaZURJocsBnutm8JX8AeJZnOqAkf3OzNa4VFL3knOAjO3N4Q8JKLBe3HpktcVt25BualXY06yrPHNIZ0LdgBLaG5GLzrwgO9FoQwRCtb4OEO61rovk0mAA98eCe9reLtd2GVIcKr6mIMVD2gK7/sjcrd/RkA47qZpldc2MEVHIrt4eWkRoPXt4uvXnz5XTfFORY/i2+T4HGY1yY1C9atCiijmjiy8n9SkB6PGENjcXwNB3/084tR2ShP+CNchgipLwFY4JhVr75DxHH78VccRBUJsRjWCGLwRZNvJ7zvtUEygSTs4iyBhuJ5jb0lh9sk7sss2pW33ZxmFYhVbPKMzhcSBGZcd9/MtHfbPNrN/qkf1lbpr9Q2azRuHCSZxw7E2Hi3zSbgwQRXMOdRS8z3qOfGzNDQgLRLalBOb5/jycx4JTaOjQsdpDSnu80Rx6uwzPdR8IDlr+1JUDXM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199021)(186006)(1800799006)(66899021)(6666004)(6512007)(6506007)(26005)(6486002)(66556008)(8936002)(8676002)(66476007)(316002)(41300700001)(36756003)(83380400001)(38100700002)(86362001)(5660300002)(2906002)(4326008)(6916009)(66946007)(478600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qkQc66xDEUopQhNLphCvI26yzjfHRKCu/wOtPBFwoZHZcbyIWbLSnMdiH8Oe?=
 =?us-ascii?Q?kHOuFFk/zLi5m9A5LfSo4zkZOEE3YREAqW0+fl2V8EXxaZlOIylz+u2DfsnO?=
 =?us-ascii?Q?vUk2qWEKWx4SlCM7kcmKVYXXABqD6khUrY65x/yc0rNDvdM5dAlZGQfYPxs4?=
 =?us-ascii?Q?rW/Qa1soqfS8CQvFmzsNPnlZplTH2q0nkJEW8vPQEyPNO5ccbeqyKopLu7Jq?=
 =?us-ascii?Q?MdcB/eXdTK5+dwTr1e0GRbcyw7mct39I5NMyIhmTdsagbredFB56tVEI1Uxe?=
 =?us-ascii?Q?/qaj781KLPkhltX+CWfiGNsQDYtPb37h9ioti4fLYUSzasCHR1EKLLoPr38t?=
 =?us-ascii?Q?kKI9GxFrbnMbR9gRf9LM3+u0C9zBPZL+Cdia7Ato0yU1Z4L4L5+LRwI810+X?=
 =?us-ascii?Q?lvcaBgtpNacY5M3r6/HGsQWcwtqoVYMj6hat6vg2/RHa7VEZhrkzuOSLJbT1?=
 =?us-ascii?Q?acVCuQNY/mnUrtF37EFznxKXPph+UcSptuG3dKfrpJKrVJw7Txvx3BqSWB1K?=
 =?us-ascii?Q?ysOtDoj9g3jTb7jogz36mWLlqO4K3fxljRlBcI/LKXI9CoWNwM7Dn5qP2vA4?=
 =?us-ascii?Q?Tmgb+KzLyeB7hMw5MyAnpw6/JE+ls+4ZUeU6rANg612i4siM5DydTrZq0qnG?=
 =?us-ascii?Q?/X94p2/WBt+n2Pd+op4EH+0qgnUnsOEzG768xhPnjyCeIOHNak91yWEB9tTe?=
 =?us-ascii?Q?6y37IePAnFgCg/kFV3T+MIr+3UcXvjPtBTeii6UpiI8jbi7GWSNveLMdrMSl?=
 =?us-ascii?Q?Y1UNzXR+lnsPhUckP8Ycl2+jkGMTIo1djvV5jK7UY4x1WxyQ/cGM1y924KfY?=
 =?us-ascii?Q?2WhYOLQmT5wnkfMYgFKlDVkWJN+CsMdim0ebNORPvKqptbvEoDYKFEkO/AJ+?=
 =?us-ascii?Q?pxbLl3pMyOdXr2xUM/QLJe6MZ0gH6E3EFSpXZCOnptHPWZO6ekJNPvN0Qwln?=
 =?us-ascii?Q?oQY90JPQ5uhKiA7wdytA6wWxOasZHiaFxl07BZxKMO+Y/3/ArISyts9OzT5v?=
 =?us-ascii?Q?VjyPQSb6YXXOGVpXeuON/pM6pSukzbyCoB4mwAJSw7XD8jeTmiG/Oa/b9cEr?=
 =?us-ascii?Q?b3D49u/un7mWhafXOVGZC8HCDIhxRWCAgf12kLAk7wWrrNsfS8Cep/xXsqLg?=
 =?us-ascii?Q?oOTLGlTYOAuGvFUclLO4WKT5U0KKBRkGhFUskNyYIr81EYdVUEJQI5WO8kKY?=
 =?us-ascii?Q?NOsiUNMHTgiLGktYiiqKES8jG5rNj0OUWRkx1kLVo+1W4S3PiiT+NXpQ9Oto?=
 =?us-ascii?Q?qPbNkNcPAKxkFIWrALTTO2vZ+y4NiebhqlkA7/QZvXvmLM/SwuA23gVhn1ke?=
 =?us-ascii?Q?kVg7YlKDjo2QIe294UsNBV4Be4DufpjcC6f0O7oJVkJYq2tE6+/Gku2r3ULq?=
 =?us-ascii?Q?f9s6rsHn/KDlw9yx5L0pslTMje4A7F5s6nCgNby9lzvgT7IxcyVVGnk6NsGC?=
 =?us-ascii?Q?87ynL5Mje7s3GJ5ZcgsZiPjg74B7N2ghohPIMMvtaGeMbsmhNPuG8B+AKZp9?=
 =?us-ascii?Q?td6M1sQQHiQuvgU/Hh9vGH3ORHpdzIkzpKmlvcwu2y23QfQmSMw9lWUtywCw?=
 =?us-ascii?Q?IDI5xwtBnPDFGspwxNBPJw8KPox5rA5vWDNJTe88?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f69ccbf-d0e7-4aba-3dbf-08db990c3d51
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 19:10:05.2834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wpWauhvJiPe5wArbUBuHhxa9mxG36wddnHqy/nPG03DI36HvkcY/SMIcffQiazE8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6055
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 18, 2023 at 12:59:43PM -0500, Bob Pearson wrote:
> This patch allows drivers to optionally include struct rcu_head
> in their private object data structs and have rdma-core use kfree_rcu
> to free the objects.
> 
> The offsets of the rcu_heads are stored in fields in struct
> ib_device_ops and a macro RDMA_KFREE_RCU is introduced which calls
> (an open coded) kfree_rcu instead of kfree if the value is non-
> zero. Currently the supported object types are AH, QP and MW.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/core/uverbs_main.c |  2 +-
>  drivers/infiniband/core/verbs.c       |  6 +++---
>  include/rdma/ib_verbs.h               | 24 ++++++++++++++++++++++++
>  3 files changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
> index 7c9c79c13941..50497e550f18 100644
> --- a/drivers/infiniband/core/uverbs_main.c
> +++ b/drivers/infiniband/core/uverbs_main.c
> @@ -112,7 +112,7 @@ int uverbs_dealloc_mw(struct ib_mw *mw)
>  		return ret;
>  
>  	atomic_dec(&pd->usecnt);
> -	kfree(mw);
> +	RDMA_KFREE_RCU(mw);
>  	return ret;
>  }
>  
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index b99b3cc283b6..a49ae8c52c66 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -982,7 +982,7 @@ int rdma_destroy_ah_user(struct ib_ah *ah, u32 flags, struct ib_udata *udata)
>  	if (sgid_attr)
>  		rdma_put_gid_attr(sgid_attr);
>  
> -	kfree(ah);
> +	RDMA_KFREE_RCU(ah);
>  	return ret;
>  }
>  EXPORT_SYMBOL(rdma_destroy_ah_user);
> @@ -1970,7 +1970,7 @@ int ib_close_qp(struct ib_qp *qp)
>  	atomic_dec(&real_qp->usecnt);
>  	if (qp->qp_sec)
>  		ib_close_shared_qp_security(qp->qp_sec);
> -	kfree(qp);
> +	RDMA_KFREE_RCU(qp);
>  
>  	return 0;
>  }
> @@ -2041,7 +2041,7 @@ int ib_destroy_qp_user(struct ib_qp *qp, struct ib_udata *udata)
>  		ib_destroy_qp_security_end(sec);
>  
>  	rdma_restrack_del(&qp->res);
> -	kfree(qp);
> +	RDMA_KFREE_RCU(qp);
>  	return ret;
>  }
>  EXPORT_SYMBOL(ib_destroy_qp_user);
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 1e7774ac808f..616e9e54a733 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -2684,8 +2684,32 @@ struct ib_device_ops {
>  	DECLARE_RDMA_OBJ_SIZE(ib_srq);
>  	DECLARE_RDMA_OBJ_SIZE(ib_ucontext);
>  	DECLARE_RDMA_OBJ_SIZE(ib_xrcd);
> +
> +	/* if non-zero holds offset of rcu_head in object */
> +	ssize_t rcu_offset_ah;
> +	ssize_t rcu_offset_qp;
> +	ssize_t rcu_offset_mw;

Just size_t, this isn't negative

> +static inline void __rdma_kfree_rcu(void *obj, ssize_t rcu_offset)

Here too

Jason
