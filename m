Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A080CA03A9
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2019 15:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfH1Nsg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Aug 2019 09:48:36 -0400
Received: from mail-eopbgr130059.outbound.protection.outlook.com ([40.107.13.59]:50318
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726407AbfH1Nsg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Aug 2019 09:48:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLP7LHXRGJO9sJMMgaKEBPG7hSOm7qWlgvJ3IyOINXLL8WPccAH9qkpJEiQexHC1bQD7rRcu4QJFFros7Y4mW0nZo5Riuh92+RMb3snZUShArDCrmXYDQacOh0rqQYcslZedJJ8NS4QkK4zD7oVMQcHAuUduzg9gENt+zQRIxfPwjDD4/5jZRy4ChQmqk1BXAbtIyqQ713UKwtuV0Vn1SRM6TOtYUWEuZly2m0kLbwX9QeBpC8oMlRNPpdd6eRN33/gdjBrOKRtAqHs3Y36eBwe71puwZsgzw9Z1hJzKxPJtmL6h1JOPtg8nIelEp2Nu9YGlAwi4/X3mmm13JXekUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vGJDNZv8MsE7urt8kTwKSfsD0OQedtkckdMwSSimTI=;
 b=ToyW0xQ4nkyjuoZ5iOl6/gnnatv4d/jmuYyBm0w8UxmT1pq3yL8AD51xzcbU6UhOowxEEKlLZo9IwAWUAmO85beHdRekPuKqrHDl2lUdInyruVBbsEYVNMC+phV0+lpjI3PhOrTenws+6YGjTA2//jfv4hXvj3VLgGreQZOyNI07H13m1eDQsGCHf1jzEcWVjWmtdtxUpzxjWICwvK1/+48whTNJg9lqFPMnZuS24s1ohUJb16BaezLjgSRreikzjxARucuae+UlWAAtCB+SUgrY7bCmkxdaZc26rbMeks5E4eO4DBBLLCHT/xfOFwKR++/7RZUfh5HVkS+xCkr5ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vGJDNZv8MsE7urt8kTwKSfsD0OQedtkckdMwSSimTI=;
 b=prpYkV0iTfCVvlTNISs8hyVoRqgSbsi6raB24UvFP+yDmoUm/UpuR5ZqXxfgTgih3g21abocLviyfHTSZ0bTcdlCYoTT9B6iPoO3bLVDF+1VvQKsdfg6lCBEqvO9pcnHOkh8Kf5PD+1Aqkv41VaOgObiOdB4C0rauZXGmsdQQzQ=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4190.eurprd05.prod.outlook.com (10.171.183.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Wed, 28 Aug 2019 13:48:23 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7%6]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 13:48:23 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Yuval Shaia <yuval.shaia@oracle.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "oulijun@huawei.com" <oulijun@huawei.com>,
        "xavier.huwei@huawei.com" <xavier.huwei@huawei.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        "swise@opengridcomputing.com" <swise@opengridcomputing.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        Israel Rukshin <israelr@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        "kamalheib1@gmail.com" <kamalheib1@gmail.com>,
        Denis Drozdov <denisd@mellanox.com>,
        Yuval Avnery <yuvalav@mellanox.com>,
        "dennis.dalessandro@intel.com" <dennis.dalessandro@intel.com>,
        Erez Alfasi <ereza@mellanox.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "srabinov7@gmail.com" <srabinov7@gmail.com>,
        "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH v1 4/5] IB/core: ib_mr should not have ib_uobject pointer
Thread-Topic: [PATCH v1 4/5] IB/core: ib_mr should not have ib_uobject pointer
Thread-Index: AQHVXYFCn5THWXrmTkW4xFnRRwvM96cQk3qA
Date:   Wed, 28 Aug 2019 13:48:23 +0000
Message-ID: <20190828134817.GG914@mellanox.com>
References: <20190828091533.3129-1-yuval.shaia@oracle.com>
 <20190828091533.3129-5-yuval.shaia@oracle.com>
In-Reply-To: <20190828091533.3129-5-yuval.shaia@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::23) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.167.216.168]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be701bd1-9119-425a-931b-08d72bbe64cf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4190;
x-ms-traffictypediagnostic: VI1PR05MB4190:
x-ld-processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB41909A7E7FA665848BFAC981CFA30@VI1PR05MB4190.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:289;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(199004)(189003)(66946007)(229853002)(54906003)(316002)(81166006)(256004)(446003)(81156014)(36756003)(64756008)(1076003)(33656002)(305945005)(478600001)(186003)(26005)(66556008)(66446008)(8676002)(86362001)(7736002)(71190400001)(8936002)(386003)(6506007)(14444005)(71200400001)(102836004)(11346002)(4326008)(6116002)(25786009)(6246003)(2906002)(66476007)(6512007)(99286004)(53936002)(14454004)(476003)(66066001)(52116002)(486006)(7416002)(6486002)(6436002)(6916009)(2616005)(3846002)(5660300002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4190;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: I+ufocYL4krwCqykZWBgqUnpkjm1Kfm2UAW0WEcRgWbb91ieyGaoySbXzgA6PBKpG+9qPujmuHAVCk1lZdjszt4i8DknNSHlA2vHbF3POYnn+e3rxMlmztucMpwlGei3xNnkGVbxk6HEZaSbOqHzPeuB4HtyYNXb+N0jZZwE9qoXLO4l5adcm6Za01lwuvT57GH1v3PMvlLzcgl/46JsKPsazz6bG8TiZtqVJvZKUgNoN3KzfGSWxDLOTXrrs/5OJR3Xq6JF+dCJi+CUB63b4mcj1IMpJQQJx8eglmhDoDuUXsZLdEBPEK+IpBW0z2YI8iymobZRxWdRz6KY/uBTZdzfiEr+NJzaK3nZg/VL2BxMsZ4BLZFQ7IlAZJEYnYAQz2lZgzq4GD8zyLm0Q2bQxy3sAgA1NSPy/quBHi0xA9k=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E44908765E3FDA4C96983D857A5A245B@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be701bd1-9119-425a-931b-08d72bbe64cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 13:48:23.6167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a38N0W3Npx+UakXCM7PMu3rmMi+0XtcLqnRjMtHudmg7IVmi9ktp61gN2ilQ2N6vwqb5aOU+PPbNuzt6gRcbzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4190
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 28, 2019 at 12:15:32PM +0300, Yuval Shaia wrote:
> As a preparation step to shared MR, where ib_mr object will be pointed
> by one or more ib_uobjects, remove ib_uobject pointer from ib_mr struct.
>=20
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
>  drivers/infiniband/core/uverbs_cmd.c          | 1 -
>  drivers/infiniband/core/uverbs_std_types_mr.c | 1 -
>  drivers/infiniband/core/verbs.c               | 3 ---
>  include/rdma/ib_verbs.h                       | 1 -
>  4 files changed, 6 deletions(-)
>=20
> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/co=
re/uverbs_cmd.c
> index d1f0c04f0ae8..54326ee25eaa 100644
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@ -761,7 +761,6 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle=
 *attrs)
>  	mr->type    =3D IB_MR_TYPE_USER;
>  	mr->dm	    =3D NULL;
>  	mr->sig_attrs =3D NULL;
> -	mr->uobject =3D uobj;
>  	atomic_inc(&pd->usecnt);
>  	mr->res.type =3D RDMA_RESTRACK_MR;
>  	rdma_restrack_uadd(&mr->res);
> diff --git a/drivers/infiniband/core/uverbs_std_types_mr.c b/drivers/infi=
niband/core/uverbs_std_types_mr.c
> index c1286a52dc84..5219af8960a3 100644
> +++ b/drivers/infiniband/core/uverbs_std_types_mr.c
> @@ -130,7 +130,6 @@ static int UVERBS_HANDLER(UVERBS_METHOD_DM_MR_REG)(
>  	mr->pd      =3D pd;
>  	mr->type    =3D IB_MR_TYPE_DM;
>  	mr->dm      =3D dm;
> -	mr->uobject =3D uobj;
>  	atomic_inc(&pd->usecnt);
>  	atomic_inc(&dm->usecnt);
> =20
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/ve=
rbs.c
> index 1d0215c1a504..a7722d54869e 100644
> +++ b/drivers/infiniband/core/verbs.c
> @@ -299,7 +299,6 @@ struct ib_pd *__ib_alloc_pd(struct ib_device *device,=
 unsigned int flags,
>  		mr->device	=3D pd->device;
>  		mr->pd		=3D pd;
>  		mr->type        =3D IB_MR_TYPE_DMA;
> -		mr->uobject	=3D NULL;
>  		mr->need_inval	=3D false;
> =20
>  		pd->__internal_mr =3D mr;
> @@ -2035,7 +2034,6 @@ struct ib_mr *ib_alloc_mr_user(struct ib_pd *pd, en=
um ib_mr_type mr_type,
>  		mr->device  =3D pd->device;
>  		mr->pd      =3D pd;
>  		mr->dm      =3D NULL;
> -		mr->uobject =3D NULL;
>  		atomic_inc(&pd->usecnt);
>  		mr->need_inval =3D false;
>  		mr->res.type =3D RDMA_RESTRACK_MR;
> @@ -2088,7 +2086,6 @@ struct ib_mr *ib_alloc_mr_integrity(struct ib_pd *p=
d,
>  	mr->device =3D pd->device;
>  	mr->pd =3D pd;
>  	mr->dm =3D NULL;
> -	mr->uobject =3D NULL;
>  	atomic_inc(&pd->usecnt);
>  	mr->need_inval =3D false;
>  	mr->res.type =3D RDMA_RESTRACK_MR;
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 7b429b2e7cf6..fc4b1a0d3bf2 100644
> +++ b/include/rdma/ib_verbs.h
> @@ -1775,7 +1775,6 @@ struct ib_mr {
>  	enum ib_mr_type	   type;
>  	bool		   need_inval;
>  	union {
> -		struct ib_uobject	*uobject;	/* user */
>  		struct list_head	qp_entry;	/* FR */
>  	};

Delete the union too

Jason
