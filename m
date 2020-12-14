Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFF82D9B25
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Dec 2020 16:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407457AbgLNPfG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Dec 2020 10:35:06 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:41631 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729466AbgLNPfB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 14 Dec 2020 10:35:01 -0500
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd785f80001>; Mon, 14 Dec 2020 23:34:16 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Dec
 2020 15:34:16 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 14 Dec 2020 15:34:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcxUmPXdM3I6ovC/Yo6L7U9ZslCZL3kt4l5FXms9pargXpebzeMSAFwX+kZBaxF2N+DBhPK2VwFgsryMqz5g1Qe5thjLDUdTXepZJOpJGtGb2C8gSVFB2EM97EuYyfShhQSu0KvyJLn08S/zmRlvUFpzOwOzaHKUQt48+XcUQ4Ia8t4DB8VNg7GkTf1Y0tYJjPTMV4/XhZfwG+VEKYs6znbPk8MAPSPYsrD9ye0CJfU5mUUqneJbAlHAaJIYz+P2u4008nK9Nz4v94EzPk+vbjhStSkrrB/OHk0YYnwuHcYExJaZMYKWPQzS7eLQM5N0mYtwDX84/aFwqVaYvKPN/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/R38Z5rHucu380osq+yeo2o117iQdWynQehSKHzAgM=;
 b=GJk+pVYPbr6Ag5Es545b2mgrTWdbb4a3CQ9eiFCxGZuUWpx/Xi6Ull7mri2GGsMzzGIvjKTDAuYV4LL37OCe77c3xwGOKTaiyb2jw7z3JG7BGjQbfMc1ToMbejqswTP7wpQHVta8sKdzdsvpYIz3RJUfTQlkA8vETNvu+xNoiBEWWONMvHRaEqY1XiatdkBIK+ub18SgH9dLrJo3HvuryWrf1P3cZGJWWPPlN9L8fe2Xisk1XaMFDNXqTCBcYQgCLIRWAhyiJkCRAzK/pnxiVqq20jJdNf5GRp+PH7sVJD9WFxeU4FZ8vgGHoMH0+1bBvjBlv7bDTtcJEDmoehYsJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4973.namprd12.prod.outlook.com (2603:10b6:5:1b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Mon, 14 Dec
 2020 15:34:14 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3654.025; Mon, 14 Dec 2020
 15:34:14 +0000
Date:   Mon, 14 Dec 2020 11:34:11 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-rc 5/5] RDMA/ucma: Fix memory leak of connection
 request
Message-ID: <20201214153411.GT552508@nvidia.com>
References: <20201213132940.345554-1-leon@kernel.org>
 <20201213132940.345554-6-leon@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201213132940.345554-6-leon@kernel.org>
X-ClientProxiedBy: MN2PR10CA0012.namprd10.prod.outlook.com
 (2603:10b6:208:120::25) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR10CA0012.namprd10.prod.outlook.com (2603:10b6:208:120::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Mon, 14 Dec 2020 15:34:12 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1koprX-00AKlL-3j; Mon, 14 Dec 2020 11:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607960056; bh=ulDgyDaplpKYFvychtFvha0IiDUIddZrKF/AcP+zuXc=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=JaRrwYeFwWl0NSlhf9ri77gAq4iNXgg5U5R3EEton9dtT5MDBwR7H22wmhVHNtVfK
         SZNhNk/dEHHy5QtsYkjFT4mfcbhDudANyaw1JJmZIYVpQ2rnM/XPjqqBkspOMyo07V
         +OA4D2ko1+PlJ/8mB4hntDk8LvJ+AWdGN8kqQU5kFQDzBi4ZpLD/1XjehqREGAl+fW
         qbXVjGwVpLkFv6L1dDb1gqLsguqK7nB9bZy0nqgIBH1q0OVCeukZGfej61KoLsKw2T
         sIB5FqB9Em8d6+RcFrOCur+nPqA7slgID7q/+yZJbUvEWqm/Z9Auy8efRopQU/3d2m
         xL8V2VJQ+pTGA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Dec 13, 2020 at 03:29:40PM +0200, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@nvidia.com>
>=20
> Add missing call to xa_erase when destroy connection request.
> It fixes the below memory leak.
>=20
> unreferenced object 0xffff88812a340490 (size 576):
> comm =E2=80=9Ckworker/5:0=E2=80=9D, pid 96291, jiffies 4296565270 (age 18=
35.596s)
> hex dump (first 32 bytes):
> 00 20 03 00 00 00 00 00 00 00 00 00 00 00 00 00 . =E2=80=A6=E2=80=A6=E2=
=80=A6=E2=80=A6..
> a0 d3 1a a0 ff ff ff ff a8 04 34 2a 81 88 ff ff =E2=80=A6=E2=80=A6=E2=80=
=A6.4*=E2=80=A6.
> backtrace:
> [<0000000059399d4c>] xas_alloc+0x94/0xb0
> [<00000000d855673c>] xas_create+0x1f4/0=C3=974c0
> [<00000000336166d1>] xas_store+0x52/0=C3=975e0
> [<000000006b811da0>] __xa_alloc+0xab/0=C3=97140
> [<00000000cf0e9936>] ucma_alloc_ctx+0x197/0=C3=971f0 [rdma_ucm]
> [<000000008f99b6bb>] ucma_event_handler+0x17b/0=C3=972e0 [rdma_ucm]
> [<000000000a07fc34>] cma_cm_event_handler+0x6f/0=C3=97390 [rdma_cm]
> [<00000000fe05d574>] cma_ib_req_handler+0x1163/0=C3=972370 [rdma_cm]
> [<000000004516baf4>] cm_work_handler+0xeda/0=C3=972340 [ib_cm]
> [<000000008a83945b>] process_one_work+0x27c/0=C3=97610
> [<00000000b71b71e2>] worker_thread+0x2d/0=C3=973c0
> [<00000000caab54ff>] kthread+0x125/0=C3=97140
> [<000000004303d699>] ret_from_fork+0x1f/0=C3=9730
>=20
> Fixes: a1d33b70dbbc ("RDMA/ucma: Rework how new connections are passed th=
rough event delivery")
> Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>  drivers/infiniband/core/ucma.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucm=
a.c
> index 7dab9a27a145..b0b9ea90a27d 100644
> +++ b/drivers/infiniband/core/ucma.c
> @@ -549,8 +549,10 @@ static int ucma_free_ctx(struct ucma_context *ctx)
>  	list_for_each_entry_safe(uevent, tmp, &list, list) {
>  		list_del(&uevent->list);
>  		if (uevent->resp.event =3D=3D RDMA_CM_EVENT_CONNECT_REQUEST &&
> -		    uevent->conn_req_ctx !=3D ctx)
> +		    uevent->conn_req_ctx !=3D ctx) {
> +			xa_erase(&ctx_table, uevent->conn_req_ctx->id);
>  			__destroy_id(uevent->conn_req_ctx);

Oooh, yes this is wrong, but this fix isn't right.

At this point ucma_finish_ctx() has been called so this must be
careful to avoid racing with parallel access from the FD side.

Actually all this destroy stuff still looks subtly wrong, sigh. Let me
try again.

Jason
