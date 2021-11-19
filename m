Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCCB45760F
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Nov 2021 18:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbhKSRsq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Nov 2021 12:48:46 -0500
Received: from mail-bn1nam07on2072.outbound.protection.outlook.com ([40.107.212.72]:61700
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237488AbhKSRsm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Nov 2021 12:48:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R35vK1kX6WRUqtejOASNclWShCYzSzwRnHRYlGr9UWm5w8r0tYVkpofDdG34mO6Qg+lcecYlF8yS3siqK5Ra8R2mqH/P6ssIyTO23jC1B/nbTrWabhm8jVVVkSS+VSff2enj+gY6PxR7CMv9YSDHclQ0dF+TctZyc1klgY3cz74fWhHkHKSuZFXr5JZpwHzq0pvxAypnmaYkFKJVLr92JrHp32S/W08RJ0WHIfE7WZK1aaRvu+Vp+gEckS8h7h9w9EICEz+obK34WY5kmU+O3BtNBv/3Oto1vi4rhLXw6vrk8c+/p6LWmDzU1qxQaFH1mbI1Swz5Okkn2vMWR49pLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/A87QXXxDut10POY9XSqfLwK5JvORziYDw4WLUe+bzw=;
 b=TRqHfyEbBHhPG8NDgQj65Rm57pPUtlmG1cJryOGb4cx5oY5QPcTmEy/6QuubUNiaTgPCG9a/vfFr03a/GLhnmCGBrjyMliDXTdfIs7HQghcCX9EG7KQVul3g+JNcIneXPXv30y6UlJoy0yvg33CfxQcuVM78KM4c/4kRxS+b09INMiCSZltJ1mTan8m58vIQPjzaSqlUwKBk4sI9bv/+URuTtlLEajPenEOP/hCd2VYN6pL7Pu53F1ukShpZPCJwXNRotrQNrWR+35GrYIRo9jOl78rIvpdR1we67C81vdjtq4zq/nDNxUMO1wteYWtAqB/mWL3n0Mc3SY3iTXP+nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/A87QXXxDut10POY9XSqfLwK5JvORziYDw4WLUe+bzw=;
 b=OLdcvP14th8YrM1EYlXPcMbLdZQPjeMRC6fvtpNprlLD0u5XFx9POI7Bndwa3KzHUwUTIYFw0x+rEjPzg7fUdVbK0/h/a5je3ipBarGPwqS2+vpXp4a8H+BSLQZWawIVb/A3pBhcCIh0LqT7gzfbKWnpvtxW1Nk4yeGJawW3wBKvpNM7W1nYIVRAs+Ib2mUDrGxdrpGTa7bG/p2H4njY/vnixXImkVl1aXRRrlZBHPJuMa1sC6jn15OfNaW7qq9jUqA67h5MXERArPXozPFcTdkkfOfj/7AxZFflycoK3dpsHlolnb9W97B7If/o192ZngtHdUdzgwKC/1HRSkYAmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5222.namprd12.prod.outlook.com (2603:10b6:208:31e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 17:45:38 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 17:45:38 +0000
Date:   Fri, 19 Nov 2021 13:45:37 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v4 10/13] RDMA/rxe: Prevent taking references to
 dead objects
Message-ID: <20211119174537.GC2988708@nvidia.com>
References: <20211103050241.61293-1-rpearsonhpe@gmail.com>
 <20211103050241.61293-11-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103050241.61293-11-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL0PR02CA0095.namprd02.prod.outlook.com
 (2603:10b6:208:51::36) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR02CA0095.namprd02.prod.outlook.com (2603:10b6:208:51::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend Transport; Fri, 19 Nov 2021 17:45:38 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mo7xB-00CXkK-Ra; Fri, 19 Nov 2021 13:45:37 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eefdecf7-7d2f-4922-2253-08d9ab84661c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5222:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5222EF97A4D5E84757D06697C29C9@BL1PR12MB5222.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pJIq/wuHf8UEsiAYsSiB/Pgq29e2UWLPGtzJoGfnO8ThgdX3eLuUm5VkObc5jDbSwE6XGgUnA3g6pL6QU15umg8/zHxwKvU7lKaetgtL4ALt/A83matWixcbNk0ejr5hhqxk6dIbfC6BezlGGmx4TmP9oXklbLzHhoS01n6YpmRr8sCY3Cfs/s0yOgUF76urRpEC1Kj2KavbkTp1heOTuHKfAF3g0If1l2Y28SsqJZkyoe2ZQf7GcmjtPCEKvb7oTKuSoQ+FDZzD6I4v8Pp4umUZwik3AQTpa/bO9dQhOXSoVjCO6Y2cY1p5rQBeJNSKbYu5kAbFgiGGY1dD51LLaKQ3gJI6I52yxUZEf2J5lW8vahLlbgo9mYSCNXHChE/iu8gDUfon6EGqygplRzB5Dcm8UiJupXig2hC9y9HwMcywZTgVSmRHApJBRlNbmetkxSdWlkfumCf+0TcjBUac9G8i6PTSypRgNPIjgAXuTaQv/wA7yDwWqRu0ht7oVXaMv+th3R+SM2pcsnySLqsKjPRZH9/42gtDmUcu1lOJ8bpFKdehGvAM3rw/53C7edUQIuhT3j/ghFr8FRBg4OzYeeNlYipbSedCrQWVdeaKH8tN2eCP55jyqtrmrc5XyLy4JkTyi6SxoGwlor+pEjGsJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(26005)(2616005)(2906002)(83380400001)(9746002)(1076003)(33656002)(66476007)(5660300002)(8936002)(316002)(36756003)(508600001)(9786002)(6916009)(66946007)(4326008)(66556008)(426003)(186003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vZLpP1cCv3991o51Mp10K0FSlxCpMDpqwsGRx2SaIbBg/wZKViPR9N+lr/Ul?=
 =?us-ascii?Q?70EyBWVZfBtX9g8Yp9JVE31h0H9vqiJP1MJ8iXJfnk/bnIki6tQojWEM78V2?=
 =?us-ascii?Q?suEA3hSV2BsILprmWWePQNo1q4QTUuTy3IJh+1wuLjBB183oo+Y1Dpl944R+?=
 =?us-ascii?Q?I9lTpBXgN+IH95zDlolSad7U82c+lG7N08El35K0e71P2ZNayaElIkFNTeIR?=
 =?us-ascii?Q?UlSuMSHDrVjbkWrCU3xjAPB2iFsQrq0eTRrs2UW5GBbkuiWpXcn5XqmeDvRf?=
 =?us-ascii?Q?i92qzGUz2oJh0vr48EapDEFbLOya6hQ85Yi6ffNgV+mZau6k3jzoQ/bzP1o/?=
 =?us-ascii?Q?oFwfYRTVkYmohVTH01j54FrHQHYZ/8ilS+gbn5v3qkMzh1V+BgJF9on9RxPa?=
 =?us-ascii?Q?Km40YIXYAsMCYosK7wo0fYYL9/f0sRLIncWQWs2BWiCh1qLdLafwbwc9NAnS?=
 =?us-ascii?Q?jqpxaetNl/AploMbL/H7gHaJDgeP0JikA1wL6zsIpI0rbb/XaB02ws0QP/6t?=
 =?us-ascii?Q?KgDHdxS/WjZtojSQUlFB93me+7JwDk/WF0EYJDgT6pvr9Wx+QQoEVzHNwkAq?=
 =?us-ascii?Q?rzLPLvtGEt6260XiluCEAdm6dqrsQLZT4GKceuKfvuBBXfuEkWsFRwDtrsDT?=
 =?us-ascii?Q?j+8ssFd6srtjq1+aO3CzodmEU012xgBNIa3HDhVRAS9qTxYMRMvW3swt+USt?=
 =?us-ascii?Q?yoIrqVBGVIdBcGLRvPNXnN6gwbCZl+/EAAv+9lWnVg50C7+StVgxd7BdV0Fn?=
 =?us-ascii?Q?a/rsPSG8HR+cgip6ZQDl862LSvo0sXAZU4JUhbsbT1vOJ/sbnX9LpT8D2dkR?=
 =?us-ascii?Q?X6CWmoipnrftWCMUzOdH0DxamHUvTK01+o6u0Yl1/j9K39eMasq25uFt45oa?=
 =?us-ascii?Q?/qPtYgg076X/txnfVJfVVCGwnhS3sMMkZKOAcKqvGGw7CD+Acng60F6NrOPu?=
 =?us-ascii?Q?B/Vzy6Y+2cWRovvPZl+5TI9cw/yiuN/y9Ua5sUeQTK54X6udEA7NFwQC0m0G?=
 =?us-ascii?Q?pSKpHWPx8jetnDGq/2gRKJOy960W7H55D3n4LlZEd4QB77O30Aqj38WLoj9D?=
 =?us-ascii?Q?htoGANMJD8vU3p7eS1FIJnKglbEOPT4Suh3WQnxrUqjZy4sBy/3yko9jr4n5?=
 =?us-ascii?Q?diRuj7zw+591T9d2RnVobUbrlIgFqNiTJBSlm54+Y7Yznvz2jKdaHEI0M3GB?=
 =?us-ascii?Q?q11vLCtm+EUmr+DR9vGZBIywby4JChK3IGfCZaIp98OkQ2WOsbSzMqA5I+aG?=
 =?us-ascii?Q?qONqrDXXzaWnoJkVWo0XMNDjkNOhIAeJ/MMuVTC0oHEqMDIOTZd8oyYsXatp?=
 =?us-ascii?Q?3jRHDPv6jU+U0eLSTagQsfwadYTSc3s85ZCjzVVlwgqy+7lf7kOy3/ll1Z/1?=
 =?us-ascii?Q?u6PwW8UMR1ayK8l16rdHjbd+y9gZvRqmkrbtQVGV0tQJEBJiOoU0JY3Oln2z?=
 =?us-ascii?Q?pYX+Hmw2JYORIu68grwr/2SZZ9lr3Y3QMWZ+7GEBfttmspYKHbpuYGJSz83I?=
 =?us-ascii?Q?nTrPo7J0ojLjFKIadn6ek6I5X8dN+TBX3mp5FapBsjpkfYej6R8uzsfAQrIg?=
 =?us-ascii?Q?7gDAriw5OmsNIUm9UnY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eefdecf7-7d2f-4922-2253-08d9ab84661c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 17:45:38.8879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5paAae6SUi46p8mjVwq55Rxt4cz1C6YkuuR4B3Vnbdwn65rpW1Wv1mUJLWgwViE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5222
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 03, 2021 at 12:02:39AM -0500, Bob Pearson wrote:
> Currently rxe_add_ref() calls kref_get() which increments the
> reference count even if the object has already been released.
> Change this to refcount_inc_not_zero() which will only succeed
> if the current ref count is larger than zero. This change exposes
> some reference counting errors which will be fixed in the following
> patches.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>  drivers/infiniband/sw/rxe/rxe_pool.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
> index 6cd2366d5407..46f2abc359f3 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.h
> @@ -7,6 +7,8 @@
>  #ifndef RXE_POOL_H
>  #define RXE_POOL_H
>  
> +#include <linux/refcount.h>
> +
>  enum rxe_pool_flags {
>  	RXE_POOL_AUTO_INDEX	= BIT(1),
>  	RXE_POOL_EXT_INDEX	= BIT(2),
> @@ -70,9 +72,15 @@ int __rxe_pool_add(struct rxe_pool *pool, struct rxe_pool_elem *elem);
>  
>  void *rxe_pool_get_index(struct rxe_pool *pool, unsigned long index);
>  
> -#define rxe_add_ref(obj) kref_get(&(obj)->elem.ref_cnt)
> +static inline int __rxe_add_ref(struct rxe_pool_elem *elem)
> +{
> +	return refcount_inc_not_zero(&elem->ref_cnt.refcount);
> +}

Don't reach inside a kref to touch the
refcount. kref_get_unless_zero() is the api for krefs

I'm not sure how any of this works, ie rxe_create_qp() stuffs a core
allocated object into the pool, and various places do refcounting on
it

But then rxe_destroy_qp doesn't seem to do anything with the
refcounts, it just blindly lets things go to kfree in the core.

Seems really confused..

Jason
