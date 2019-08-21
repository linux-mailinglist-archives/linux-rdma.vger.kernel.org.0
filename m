Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55A0E97DB0
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 16:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfHUOxh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 10:53:37 -0400
Received: from mail-eopbgr00088.outbound.protection.outlook.com ([40.107.0.88]:31373
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727099AbfHUOxg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 10:53:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHfROSHe8B5ICfqS/+WnRMGuIBeoAfzbB79EnS9hWmYz6Jf0BJJYu64f9583XRXDuFnPYydx+lTMnegbDXPiKwsHJdd8WYB9DTq6owbnk1Or5KTvFHjKqgdTQqXvGHC7C0VHkp9DLduohB8iZG64H7/QHk1EivscOAiLB/Yj7sovq+Qit49MMFcfef6pKBRcI2m2Zqv00EyE8CUmp4HGAxmbsl7JWgccS8zHL8snERoLsl1OeH8rNMuV6ceY0mkehRgaWXWYZ8RxsVaMXeh/7iEN3WSMD7qR9PdbJmmd61B2P41iLpQ/9jWXzv6rlcmg/BA206nSxUUjLTkoSNatfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jou9QTdiaCH4yIWHGYv7bBLDQWpCaO+scI8/gpLtvE=;
 b=aHz7Ms1gq1fAbVo9cKRDULbzmRYVfBZTiTlMD4szc1JbsLVxTL0bl8EjfxF2V/vcdWfSHvZpw+7nJ231Cfxldhnq30hL4GLPV/FZ1LFs3GCfTKSgEVMMMDKDX4Y5IH9+n/5cGywB/lC6GNIPVAthQWy7HdcthfB5N2JV0UtSJQlA9rhzFVxkuc5VLtAu9o2DreKQLDOTp3+SJrhMtdtpBeNoUMmzak6bbOq9x3HAwA2lTUabuNekTf9/PuLX7Uxjp5y0/81VKz8u6wVH98QIOyk0NNfMBxwO1WCGdRON2Ajv9hdqXyZaHOaRi2q3mM0YhmrM815bHatvd0nMUaXqMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jou9QTdiaCH4yIWHGYv7bBLDQWpCaO+scI8/gpLtvE=;
 b=X1aDVlracEG+27KxaYEaw3Uh6QqlObuvwMtZq/gihoIjBrzqT0ewR2n3GvJWw613M6URKfNGQS7Px2worAtlrrPsYMGNfN+RwzMPcADvdbF9tM2ccxu5rvYBW/SkUlMJWQbdwSr51RyfcZClTtjq2IUJ/UYZPdqSNIokbZQWRLo=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6030.eurprd05.prod.outlook.com (20.178.127.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Wed, 21 Aug 2019 14:53:30 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7%6]) with mapi id 15.20.2178.018; Wed, 21 Aug 2019
 14:53:30 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Yuval Shaia <yuval.shaia@oracle.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        "kamalheib1@gmail.com" <kamalheib1@gmail.com>,
        Mark Zhang <markz@mellanox.com>,
        "swise@opengridcomputing.com" <swise@opengridcomputing.com>,
        "shamir.rabinovitch@oracle.com" <shamir.rabinovitch@oracle.com>,
        "johannes.berg@intel.com" <johannes.berg@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        Michael Guralnik <michaelgur@mellanox.com>,
        Mark Bloch <markb@mellanox.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Israel Rukshin <israelr@mellanox.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        Denis Drozdov <denisd@mellanox.com>,
        Yuval Avnery <yuvalav@mellanox.com>,
        "dennis.dalessandro@intel.com" <dennis.dalessandro@intel.com>,
        "will@kernel.org" <will@kernel.org>,
        Erez Alfasi <ereza@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Shamir Rabinovitch <srabinov7@gmail.com>
Subject: Re: [PATCH v1 05/24] IB/core: ib_uobject need HW object reference
 count
Thread-Topic: [PATCH v1 05/24] IB/core: ib_uobject need HW object reference
 count
Thread-Index: AQHVWCvdmPY5rYH3jkihM3498i9koqcFsAUA
Date:   Wed, 21 Aug 2019 14:53:29 +0000
Message-ID: <20190821145324.GB8667@mellanox.com>
References: <20190821142125.5706-1-yuval.shaia@oracle.com>
 <20190821142125.5706-6-yuval.shaia@oracle.com>
In-Reply-To: <20190821142125.5706-6-yuval.shaia@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR0101CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::49) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9ea433f-72a3-4afa-1e49-08d72647547d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR05MB6030;
x-ms-traffictypediagnostic: VI1PR05MB6030:
x-ld-processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB6030EB109FAB3C94E11B0D93CFAA0@VI1PR05MB6030.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(199004)(189003)(66446008)(64756008)(66476007)(66946007)(6512007)(6486002)(229853002)(6436002)(33656002)(6246003)(53936002)(66556008)(6916009)(7736002)(5660300002)(305945005)(4326008)(1076003)(3846002)(36756003)(7416002)(25786009)(478600001)(186003)(2906002)(446003)(11346002)(26005)(66066001)(256004)(81156014)(8676002)(99286004)(81166006)(54906003)(14444005)(316002)(386003)(8936002)(76176011)(6506007)(102836004)(71200400001)(71190400001)(52116002)(86362001)(486006)(14454004)(2616005)(476003)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6030;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lZ6LXjmvvuj/fcsvYDVqjwb0uP0c/TgQlYzFZMib3hMAV9v/XjykdjZsp3EsOCVtw1dBezINahaHDoyO0iIH3e5G213xprbth+T1IoX2Qdg1EwqiXENQDT0Y/GXLRFstqyE/0vj+1W6Mk3N0Fi3EA0JXg9Exxk4ai+h0yO9JkmfOvEbOOy8dKjZcZ3B83d2fO+LAYVEIB/CKNxOUVJwGWchw0x3WdRAPsXejiIzeMUZ+uhgBUas+eswnd9FD03sMLFWTWa9koSKjUl6O1djx/lsGXElnpMHq2C5wxQeRSLVtBHnnxDU5TiO6fuavRD/EfY9A4lo+bXW8t7TAa78r1ut1PZXdDbwXYRSFM7Vdbdqw/SFKNYNjMkXHH+VahOrNwQjsuqWN9RwxyQbSSnO6CvzCHFjtpcrWvEn5Fds8VaM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19A378E61038074A9CFEFC5FEF8E990D@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ea433f-72a3-4afa-1e49-08d72647547d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 14:53:29.9533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: be1BQfqdJU2XeMIG6sx1p3HLL+3NVk9pIsb+K6v6br0tOVOZdFUtDblPlRVcYyzAGa6vjFzKYo7Qt1Gxd/yK8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6030
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 21, 2019 at 05:21:06PM +0300, Yuval Shaia wrote:
> From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
>=20
> This new refcnt will points to the refcnt member of the HW object and wil=
l
> behaves as expected by refcnt, i.e. will be increased and decreased as a
> result of usage changes and will destroy the object when reaches to zero.
> For a non-shared object refcnt will remain NULL.
>=20
> Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
>  drivers/infiniband/core/rdma_core.c | 23 +++++++++++++++++++++--
>  include/rdma/ib_verbs.h             |  7 +++++++
>  2 files changed, 28 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/cor=
e/rdma_core.c
> index ccf4d069c25c..651625f632d7 100644
> +++ b/drivers/infiniband/core/rdma_core.c
> @@ -516,7 +516,26 @@ static int __must_check destroy_hw_idr_uobject(struc=
t ib_uobject *uobj,
>  	const struct uverbs_obj_idr_type *idr_type =3D
>  		container_of(uobj->uapi_object->type_attrs,
>  			     struct uverbs_obj_idr_type, type);
> -	int ret =3D idr_type->destroy_object(uobj, why, attrs);
> +	static DEFINE_MUTEX(lock);
> +	int ret, count;
> +
> +	mutex_lock(&lock);
> +
> +	if (uobj->refcnt) {
> +		count =3D atomic_dec_return(uobj->refcnt);
> +		WARN_ON(count < 0); /* use after free! */

Use a proper refcount_t

> +		if (count) {
> +			mutex_unlock(&lock);
> +			goto skip;
> +		}
> +	}
> +
> +	ret =3D idr_type->destroy_object(uobj, why, attrs);
> +
> +	if (ret)
> +		atomic_inc(uobj->refcnt);
> +
> +	mutex_unlock(&lock);
> =20
>  	/*
>  	 * We can only fail gracefully if the user requested to destroy the
> @@ -525,7 +544,7 @@ static int __must_check destroy_hw_idr_uobject(struct=
 ib_uobject *uobj,
>  	 */
>  	if (ib_is_destroy_retryable(ret, why, uobj))
>  		return ret;
> -
> +skip:

This doesn't seem to properly define who owns the rdmacg count - it
should belong to the HW object not to the uobject.

> +
> +	/*
> +	 * ib_X HW object sharing support
> +	 * - NULL for HW objects that are not shareable
> +	 * - Pointer to ib_X reference counter for shareable HW objects
> +	 */
> +	atomic_t	       *refcnt;		/* ib_X object ref count */

Gross, shouldn't this actually be in the hw object?

Jason
