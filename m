Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951463F993D
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Aug 2021 14:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbhH0MyP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Aug 2021 08:54:15 -0400
Received: from mail-dm6nam11on2057.outbound.protection.outlook.com ([40.107.223.57]:59831
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245163AbhH0MyO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 27 Aug 2021 08:54:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpswH4uC7xm4fZTbReiK7Rolnaz9vo+peukctn2yxSnmFMsefRI3cEsIGY/VrixPTdQ/CXCllp8eUXAdi8e+8vAKerWAIsN03qVzxeIdXsvTb+EDeqkTHos3qrPWjZJN+WgSoktrBjZ3JyaFpSS10XrTKVMtTS5WRWzevnlwwKz68AZ4qKeyYD0wnIn50UgJrm4t5SHtOmOS04uK8HkFbNQdq7IM/FkD8Ni8boIboDxDoCbCkMsqhLWXv7rf9ki1Nqe1fpi5AbY4McvyZdN2Xbwux1TQ+Xsy+HHqrNgHx7oV8BcytCQlskTyorjJapCxvtCpcV3AJv/HQR0p+GNgMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xd5bElWldBNf1h7VFSO22NscpqxJlhpKC/WI9emlS7s=;
 b=mcawkisqiTqfKbvTjxARWrUkCA9ia5aeZWcqUJvC2ILTz5kjQy2QUIIBYHedzNT2h71QOS3V0iiQuVjL2MNpkwOI7449xPH3uLUjvSHxNlyHSgNAnL/ypItBZ74l1QpkQrCHTPLjfe4ndSP2I4L3SVm3leDAHfqw0jf0/qDRbKTl1BZqXJyJmbxa86Q4TEe6XyS4I8eYQK5oHxbpzph2uBNthE/W4n2/uSrZSjdAILtkmbC7mCM2RJPg+TjynwVXh9NaQDQSBRguGVk/+DnBop/RjbYw2U4PfHtVNJ4q03QOjVVf3rLrrSP/rFYCCLUq6QH0/akL3ogjWHvB7Iqu/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xd5bElWldBNf1h7VFSO22NscpqxJlhpKC/WI9emlS7s=;
 b=iz9cpiJ73s/C4x2CYU9+cUrb4cIBb732KMsR9OjnG0BeTvccJSej/b78Xf0uxovOW9GMBpH+sGAb5s5IgUaB/S1bjfLVMlA0k6GoripakvjRu34NohPUyxfzQZqrV2rZ/nvt6FggzIgAAfbeeVEiN0TluE+ax3F67WzmKMU3CBABpxAi6zHcUfiGqg9KKV0kxNPjXXXmoDAP96Va1qZrcc/9bz4+NR26aRzpolW18SxZ9LbfC5+2dWMoEDtoIx0att6tZmYMWOBFnfL5eKBXzqvgSXCY6e8duosANlCxQsNH8GFz9AeUx+cUS+VMWKMuCtSu3niyg6LJ6YUx6fw08A==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.20; Fri, 27 Aug 2021 12:53:24 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::81bc:3e01:d9e0:6c52]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::81bc:3e01:d9e0:6c52%9]) with mapi id 15.20.4436.024; Fri, 27 Aug 2021
 12:53:24 +0000
Date:   Fri, 27 Aug 2021 09:53:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v3 5/6] RDMA/rxe: Lookup kernel AH from ah index in UD
 WQEs
Message-ID: <20210827125323.GA1353944@nvidia.com>
References: <20210722212244.412157-1-rpearsonhpe@gmail.com>
 <20210722212244.412157-6-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722212244.412157-6-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL0PR02CA0135.namprd02.prod.outlook.com
 (2603:10b6:208:35::40) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR02CA0135.namprd02.prod.outlook.com (2603:10b6:208:35::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 12:53:24 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mJbMJ-005gEo-Kn; Fri, 27 Aug 2021 09:53:23 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aec2fd66-9ee2-4762-c7d1-08d96959a84d
X-MS-TrafficTypeDiagnostic: DM8PR12MB5399:
X-Microsoft-Antispam-PRVS: <DM8PR12MB53990836A7EE4917EA47BDE5C2C89@DM8PR12MB5399.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vKXrGRQPsG72+ENXmkMgoOQJ/YOVMjhs3Hwx/488DYTTHYzrA35A0zAXIPYSjQ9kwCijBXL6wGZsgwLyR0n3o0u//d9X/nO+5zE7Sl5p8NCXVPeMz2bqokySUS/iD6s2Sj1uGeeWooMgfWHCf/5H1UafSjArCu0hRHxDQTpFyhRzfPOJekSHb7t6IhAF8HKtbNJAH2og+G/2iMT9vhTCYYhdf3FpiLJzpRA7x2hGO4FbRF4tHYSc1Q0qCw7Qi03SvdeN64YJW2hU3R7+t4YqMLN/weQujFj8VniBKtt93PvXiPB3nnqNVDJ+JXQsa+bD/4HNeC2t7ql5eb1OP7kbopebsOLsXFOkdzj8o5sPggNeOH88GWffkiZ+ppG70LrIcLytywgNlpRMHattcW1ix1b3Zrdr4lQPQsBSTwblnDtCYPjdUMggrbWBzwJFUktO3Izg9DUCXv4JyVjtFevX2bTMoijkk4ONms073lJkiu1wxfHcpLlMd5OC+tMorZXgaucYMM+83QN6QDP3XTn8jKV+Ci7cuRRweUbaCLB4JwjN1D0sbjyU2V3cXMhIrmOcOBatxbIG5bGT2TEnMUWLsSmNpK5t2SlS6kW+a+GvSnnwi6iRkOW9qmyD2shBPKfPKB7YCKJR4qQbwGu1e1uNBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5520.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(186003)(33656002)(66946007)(4326008)(6916009)(9746002)(9786002)(66556008)(66476007)(83380400001)(2616005)(426003)(86362001)(1076003)(5660300002)(8936002)(26005)(38100700002)(316002)(36756003)(508600001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?61H/VJz0amdZlNo671WMJD9rKAnSnVHY0A0wHcyqYccmRIP2nOMNbgA2BIOU?=
 =?us-ascii?Q?+4sjLKb4SIAxf7UQDh6vPscFYLz07dLt3cQ3cAnEASuxZkuQNlKj7fMKozTQ?=
 =?us-ascii?Q?RZdRJBgxBmojGZ+oSddx7wxbLkRZkAZ2N7ZPB3em4lRH32YCpMjDM0HPWUax?=
 =?us-ascii?Q?xSk7xk2X8BGoR2acQ7xAQfemn0ccp+Fq5ZsZ2GkKNGW3IzAmOwzc5lAJtZA9?=
 =?us-ascii?Q?elHja9EdKj2vzHgES3qkjp9QeoGFM2v9Nv96WMb9/C4MqoBv+Oe95d5kJxDA?=
 =?us-ascii?Q?t/gmREvjl0OCndRqs2gDyNXan2BhXvJ/TEIv0mLKyJIZ2Cv1hZ3P6u501Fr+?=
 =?us-ascii?Q?5g6Y+b6kNm5aGe8oGcLoNJeKEVFD3W9OiDFuzFIZjfGpwYyPQTPouJjHfXy+?=
 =?us-ascii?Q?i6x3jUUwcs9+jWzIAGY37NBb8YsckmOvakJ1Ei7XKL45krPMxr61Ah6vO5I9?=
 =?us-ascii?Q?WhbdkDsXz7xf+Pawl5z7DB9rRul6O3yH/qFuIJmwD4dlhvZi1Yok4U0+qJGa?=
 =?us-ascii?Q?TybbKdAZfQemW5tpD6/A721UZyAYDv7Fyd9ibuooq/qgWuT9NQodCGn/wX6G?=
 =?us-ascii?Q?E5rM3/Pt9WBweOgmg3KFa7To+MJXJx+PRky0lqgkP8KQlHhvh8USk8DJtVnL?=
 =?us-ascii?Q?xN5eS0Eg5M0fRWSZHDXsds9kVGdgGdopzebPR7x/HDGKYILnVke68bYQkBDv?=
 =?us-ascii?Q?bCc0+8Ykh+BPRC+qLHz9DyqQwGcyXOq3WTyIRfYPIXNWm50NGaBLNHWsSQ2C?=
 =?us-ascii?Q?KIRMcjm12BAeMtzoLzKIPggsQIm+plzSPMvT1uQxxAfvQM9mKEZKzI1UoDFx?=
 =?us-ascii?Q?UpSYbnpJFOrbotQVVzdzCI1TPdgwF1bkx6rvHVzH888TjKGiaWC66gTWSZK9?=
 =?us-ascii?Q?/BxZVUk5jdj9hw6iHFinMmyxm2up4203UbRZv2onQ5Y3I1NEEx1B6FhCRUF8?=
 =?us-ascii?Q?59BkkrZCMcOqnnx7begKuuZDmmpKhaTMmtVD49ycFULlh51ntBmwEi9ef+r6?=
 =?us-ascii?Q?7DTS9ey+hD4+KGhsEUKKjuVJud1plA3sGb5lLGGyNsk2g/OKsgmbdgxVN2Uw?=
 =?us-ascii?Q?9ZFFBcfINfStFnFQArfphftW4UZXiPtXCKwXIJecFgjUrOqrnuiYH6uOIDYB?=
 =?us-ascii?Q?yl+n33DvB9qOv5OSZhFCE9aj1gqAyWwNR1UTXsJ9wrNQuU6Y55EL9agOhn45?=
 =?us-ascii?Q?HrKAJEW4Cfy7O4mBKKNghToBGm0lLWAHH0K8dndcAMTo0NIIy0V1U0yI+N9Y?=
 =?us-ascii?Q?uge4A6IeQ5E3D0YfiCoSnS7kyctKAVUmt8Yod/RahsDocZ2fPaZ+o9oxTfFU?=
 =?us-ascii?Q?2JGpCUgs7X/B/KHPpSOo2MC/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec2fd66-9ee2-4762-c7d1-08d96959a84d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 12:53:24.8382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+iWc2/wUJvLTrwUfD3cT3gjfWDDB3X2JqLsBZXi1M+pEt1JmE1uvQEwF2PsRHNd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5399
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 22, 2021 at 04:22:44PM -0500, Bob Pearson wrote:
> Add code to rxe_get_av in rxe_av.c to use the AH index in UD send WQEs
> to lookup the kernel AH. For old user providers continue to use the AV
> passed in WQEs. Move setting pkt->rxe to before the call to rxe_get_av()
> to get access to the AH pool.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>  drivers/infiniband/sw/rxe/rxe_av.c  | 20 +++++++++++++++++++-
>  drivers/infiniband/sw/rxe/rxe_req.c |  8 +++++---
>  2 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_av.c b/drivers/infiniband/sw/rxe/rxe_av.c
> index 85580ea5eed0..38c7b6fb39d7 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_av.c
> @@ -101,11 +101,29 @@ void rxe_av_fill_ip_info(struct rxe_av *av, struct rdma_ah_attr *attr)
>  
>  struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt)
>  {
> +	struct rxe_ah *ah;
> +	u32 ah_num;
> +
>  	if (!pkt || !pkt->qp)
>  		return NULL;
>  
>  	if (qp_type(pkt->qp) == IB_QPT_RC || qp_type(pkt->qp) == IB_QPT_UC)
>  		return &pkt->qp->pri_av;
>  
> -	return (pkt->wqe) ? &pkt->wqe->wr.wr.ud.av : NULL;
> +	if (!pkt->wqe)
> +		return NULL;
> +
> +	ah_num = pkt->wqe->wr.wr.ud.ah_num;
> +	if (ah_num) {
> +		/* only new user provider or kernel client */
> +		ah = rxe_pool_get_index(&pkt->rxe->ah_pool, ah_num);

rxe_pool_get_index() incr's a kref, but I don't see any put of that
kref in this code?

Jason
