Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7411D7252
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2020 09:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgERHyY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 May 2020 03:54:24 -0400
Received: from mail-eopbgr00043.outbound.protection.outlook.com ([40.107.0.43]:21590
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726489AbgERHyX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 18 May 2020 03:54:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNUwkw+T9Cu1G0aaGxKu4Doq9w4uJX+GTviNWe85/FVWw7HuptpSwoe3gjcgLWhvEriocFkVYJ2E0wNSOiUOHX8bBaF+VFoovsLfw97FukGGkKFnZBS409aBFqsSRkQiUn5jMKx7ssS/nyPSrIeDpVFxBrMNzgYFaBxX+FTydogYMo087BKN+alZUbclmBiXEfvqu5gf0mJapyy1KfLxlR5Aj+iKHsIYmeRAdCiQ/mMsHDa9HMJPQ51DSWH1P4unI97DPalvfy8UJyWYPw8ImSIL8W+xWiaXV5GBfJNUCDCckJ/Tb5tPjPEv8qIBASjSlGsZh5ixbkPZMXAIEWhQBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sHdVq3D8ctUmp/CPuJ4Rvqwr4NsZjNISUQq9CpCyag=;
 b=IB5MeVz/4GlAYAMFMfexlhT3lX9ELMI0XHU9sv8hDIhRx/sh8FO4uIyVSBJWocTSchas8FTglK/2fSRe/vOSDB1RSc/aV89s7gK0jImCzN4nWFiXQINKSCP9bSEsYkE+wTkA6Bwwte8sqpXNY+qE27C5m+C2CMX6ec1eBjHWMx6jgJqir3KRBFWobX7dDD4pDQyvrje5CklyT0q2FNGx4+CNcPOvxlMwBusJwcnIMArTk3z7aCKy112H6/uPI7HrSnH/8q6iiqzVB/1ULTUM6VJyWw9Dje1nrL7fqiCEjfi4+2fix7ODFuhPNJ/FWNyg3+21UWRXKHdwot4KzH8qlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sHdVq3D8ctUmp/CPuJ4Rvqwr4NsZjNISUQq9CpCyag=;
 b=F3598uUIQifOD9OjpuzPaXPtHwVg6NkP06WPJHBHzqh2sGSaW6Cmu7C1obx4Svu82Qk7BW4mxwj4WXZQ1NSAtmMWiARP7Dvv4xkqjgLmfQRcBN2rwuK43xwqYU9DefOAg6ko7sKA0VR41lgL+93R3uHeeNUGyrZEkAhSAwuXFM8=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (2603:10a6:20b:b8::23)
 by AM6PR05MB5879.eurprd05.prod.outlook.com (2603:10a6:20b:a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Mon, 18 May
 2020 07:54:19 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::1466:c39b:c016:3301]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::1466:c39b:c016:3301%4]) with mapi id 15.20.3000.033; Mon, 18 May 2020
 07:54:19 +0000
Date:   Mon, 18 May 2020 10:54:16 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Yamin Friedman <yaminf@mellanox.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        Or Gerlitz <ogerlitz@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH V2 1/4] RDMA/core: Add protection for shared CQs used by
 ULPs
Message-ID: <20200518075416.GA185893@unreal>
References: <1589370763-81205-1-git-send-email-yaminf@mellanox.com>
 <1589370763-81205-2-git-send-email-yaminf@mellanox.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589370763-81205-2-git-send-email-yaminf@mellanox.com>
X-ClientProxiedBy: FRYP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::11)
 To AM6PR05MB6408.eurprd05.prod.outlook.com (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2a00:a040:183:2d::a43) by FRYP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24 via Frontend Transport; Mon, 18 May 2020 07:54:18 +0000
X-Originating-IP: [2a00:a040:183:2d::a43]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 70f86801-c474-4ae6-7103-08d7fb00ab65
X-MS-TrafficTypeDiagnostic: AM6PR05MB5879:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB5879D2D40BFAD76FB30EC97CB0B80@AM6PR05MB5879.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 04073E895A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vZ05yFy9ZaWR/fPxQU1DcfYyddfOIqgOJ8uWxPEXMZkprY93GntrYnXqcQVbH/AbGsBN6NRZqxWy6VOyjm62Z4KL2A0JWaNeE8i0PX0HKpq0mtCI2jVsAIQLc93uJjHe0qGv0cK1smIcqt5Ibl634QpJ4SyeiVSkQ6zzHeDrB7DWmreUZuewui2PtYMSmzDeFERFsXYa2Q+e+9hIHoY+iKx1p7BVLmAjmHBrnxX+DvJ+ujWZ/EL5fGj2dDjYlLhM4wGkwJxiFgnNzHHTIUw3YiLYyI/xzsAZIidfQtOfeitpkycSjIU2Q0ehTLmju2mGn0lAhIO051jf+F/W1BmSv1HH3wYJYCee4YqA9q0FcqMYlZMMZaxA26H6F1WAnN+AHsMtKhD1faT8G3YxGkkfh70kg7b+IOJChO9CnSoxLNTKZXsYGYoubMm4r7MGxdjc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6408.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(396003)(39860400002)(346002)(366004)(136003)(376002)(186003)(16526019)(316002)(33716001)(66946007)(86362001)(8936002)(6486002)(54906003)(6636002)(5660300002)(52116002)(66476007)(6496006)(9686003)(66556008)(33656002)(478600001)(8676002)(6862004)(1076003)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: JAEKkv4XsjJUduTHg2u1Ly1yZMmwjFEkQjAVUQD4CpzEzL8qfWwj6Zt7dkMc2VxGpRBo8zEu1bwi0aFcd1Wy4G7M1SdVbXbTZLB3wht2I9r0X662OT845WUzy/AjlKEQnkQ9FT+L2PDN0o1OluJ6r++KC/OF70gds6iR5Uw/bKf1vpXWBpm3BaI1NDuoUbkCx+WAXb21jgKa9jzkndVol2iuiNgtO0GA2EapI2TDHo4YC36hRJUNtgX8Ir3IAqPl0l6Lr4w40qaC6l8fOrDVsgD//T5mhor5Xhf/4lo86xrrfiv9FC/j2m1jW3xBsvi5gik2I3xviO9TFUxuzR7lxlzNobKEJ9TEec5WikA/GrS5OeR+419YlBVJ/rS/K9i7MLmxo9zukkj64lsKSFPNn6pb7mkXBslZ/NhzkiG3bm2rzoqlMgIYAirXXSgIDwlQdS2nCyNhrcSnEKZ7RXZ1FtYVIG0hIsDm8uZ0RnVOplQbMWdgcwVai8TRpZhi7BoSUwVjJgv3tQXgeCvwC17T7A==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f86801-c474-4ae6-7103-08d7fb00ab65
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2020 07:54:19.3406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQY5Aqwu8lwCSWtFvWDXzxjDPxut5R9ejdigeSW4tlh2mQVBTgrQRaO0TSjlDVayiASS2SroeW2qPA4ErS4zWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5879
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 13, 2020 at 02:52:40PM +0300, Yamin Friedman wrote:
> A pre-step for adding shared CQs. Add the infrastructure to prevent
> shared CQ users from altering the CQ configurations. For now all cqs are
> marked as private (non-shared). The core driver should use the new force
> functions to perform resize/destroy/moderation changes that are not
> allowed for users of shared CQs.
>
> Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
> Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
> Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
> ---
>  drivers/infiniband/core/cq.c    | 18 ++++++++++++------
>  drivers/infiniband/core/verbs.c |  9 +++++++++
>  include/rdma/ib_verbs.h         |  8 ++++++++
>  3 files changed, 29 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
> index 4f25b24..04046eb 100644
> --- a/drivers/infiniband/core/cq.c
> +++ b/drivers/infiniband/core/cq.c
> @@ -300,12 +300,7 @@ struct ib_cq *__ib_alloc_cq_any(struct ib_device *dev, void *private,
>  }
>  EXPORT_SYMBOL(__ib_alloc_cq_any);
>
> -/**
> - * ib_free_cq_user - free a completion queue
> - * @cq:		completion queue to free.
> - * @udata:	User data or NULL for kernel object
> - */
> -void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
> +static void _ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
>  {
>  	if (WARN_ON_ONCE(atomic_read(&cq->usecnt)))
>  		return;
> @@ -333,4 +328,15 @@ void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
>  	kfree(cq->wc);
>  	kfree(cq);
>  }
> +
> +/**
> + * ib_free_cq_user - free a completion queue
> + * @cq:		completion queue to free.
> + * @udata:	User data or NULL for kernel object
> + */
> +void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
> +{
> +	if (!cq->shared)
> +		_ib_free_cq_user(cq, udata);
> +}
>  EXPORT_SYMBOL(ib_free_cq_user);

All CQs from the pool will have "shared" boolean set and you don't need
to create an extra wrapper, simply put this "if (cq->shared) return;"
line in original ib_free_cq_user(). Just don't forget to set "shared"
to be false in ib_cq_pool_destroy().

> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index bf0249f..d1bacd7 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -1990,6 +1990,9 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
>
>  int rdma_set_cq_moderation(struct ib_cq *cq, u16 cq_count, u16 cq_period)
>  {
> +	if (cq->shared)
> +		return -EOPNOTSUPP;
> +
>  	return cq->device->ops.modify_cq ?
>  		cq->device->ops.modify_cq(cq, cq_count,
>  					  cq_period) : -EOPNOTSUPP;
> @@ -1998,6 +2001,9 @@ int rdma_set_cq_moderation(struct ib_cq *cq, u16 cq_count, u16 cq_period)
>
>  int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
>  {
> +	if (cq->shared)
> +		return -EOPNOTSUPP;
> +
>  	if (atomic_read(&cq->usecnt))
>  		return -EBUSY;
>
> @@ -2010,6 +2016,9 @@ int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
>
>  int ib_resize_cq(struct ib_cq *cq, int cqe)
>  {
> +	if (cq->shared)
> +		return -EOPNOTSUPP;
> +
>  	return cq->device->ops.resize_cq ?
>  		cq->device->ops.resize_cq(cq, cqe, NULL) : -EOPNOTSUPP;
>  }
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 4c488ca..b79737b 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -1582,6 +1582,7 @@ struct ib_cq {
>  	 * Implementation details of the RDMA core, don't use in drivers:
>  	 */
>  	struct rdma_restrack_entry res;
> +	bool shared;

Lets do "u8 shared:1;" from the beginning.

>  };
>
>  struct ib_srq {
> @@ -3824,6 +3825,8 @@ static inline struct ib_cq *ib_alloc_cq_any(struct ib_device *dev,
>   * ib_free_cq_user - Free kernel/user CQ
>   * @cq: The CQ to free
>   * @udata: Valid user data or NULL for kernel objects
> + *
> + * NOTE: this will fail for shared cqs
>   */
>  void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata);
>
> @@ -3832,6 +3835,7 @@ static inline struct ib_cq *ib_alloc_cq_any(struct ib_device *dev,
>   * @cq: The CQ to free
>   *
>   * NOTE: for user cq use ib_free_cq_user with valid udata!
> + * NOTE: this will fail for shared cqs
>   */
>  static inline void ib_free_cq(struct ib_cq *cq)
>  {
> @@ -3868,6 +3872,7 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
>   * @cqe: The minimum size of the CQ.
>   *
>   * Users can examine the cq structure to determine the actual CQ size.
> + * NOTE: Will fail for shared CQs.
>   */
>  int ib_resize_cq(struct ib_cq *cq, int cqe);
>
> @@ -3877,6 +3882,7 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
>   * @cq_count: number of CQEs that will trigger an event
>   * @cq_period: max period of time in usec before triggering an event
>   *
> + * NOTE: Will fail for shared CQs.
>   */
>  int rdma_set_cq_moderation(struct ib_cq *cq, u16 cq_count, u16 cq_period);
>
> @@ -3884,6 +3890,8 @@ struct ib_cq *__ib_create_cq(struct ib_device *device,
>   * ib_destroy_cq_user - Destroys the specified CQ.
>   * @cq: The CQ to destroy.
>   * @udata: Valid user data or NULL for kernel objects
> + *
> + * NOTE: Will fail for shared CQs.

Let's add WARN_ON_ONCE() to catch mistakes. No one should call to
ib_destroy_cq_user() for the shared CQs.

>   */
>  int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata);
>
> --
> 1.8.3.1
>
