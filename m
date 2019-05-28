Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72E002CD89
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 19:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfE1RXo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 May 2019 13:23:44 -0400
Received: from mail-eopbgr80057.outbound.protection.outlook.com ([40.107.8.57]:52438
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726236AbfE1RXo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 May 2019 13:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4+0J8447I9/munqE7JTFUfXw05Xdkp9I29iK1KWpJU=;
 b=hfX7qSkijBxI+Y4YNFbFME5h6sORaSZ8QE/0PzVHenuTJaWH1aHFFTtV/dtZF4XkwemY9OyL7Slk3BzfY/KaHuyr9gmxN93E0FlWkI7xvA6yit7akiHyfYvjsEI6CSadbF2cXWou+Oo4bSqQh+rMAt46/8t4NE6O/xCOs5CNSas=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5135.eurprd05.prod.outlook.com (20.178.11.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.18; Tue, 28 May 2019 17:23:38 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 17:23:38 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Yuval Shaia <yuval.shaia@oracle.com>
CC:     Yishai Hadas <yishaih@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v1 rdma-core] verbs: Introduce a new reg_mr API for
 virtual address space
Thread-Topic: [PATCH v1 rdma-core] verbs: Introduce a new reg_mr API for
 virtual address space
Thread-Index: AQHVFXlY7MlhB6sNTkiJQQCuGCwHgKaAyTOA
Date:   Tue, 28 May 2019 17:23:38 +0000
Message-ID: <20190528172333.GG31325@mellanox.com>
References: <20190528171439.31499-1-yuval.shaia@oracle.com>
In-Reply-To: <20190528171439.31499-1-yuval.shaia@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::33) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f30fa95c-8a9d-4731-425d-08d6e39138e4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5135;
x-ms-traffictypediagnostic: VI1PR05MB5135:
x-microsoft-antispam-prvs: <VI1PR05MB5135C799FFE49CC8B260CFB2CF1E0@VI1PR05MB5135.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(366004)(136003)(376002)(199004)(189003)(7736002)(476003)(2616005)(99286004)(6916009)(186003)(14454004)(68736007)(25786009)(36756003)(11346002)(446003)(5660300002)(66556008)(66476007)(66946007)(73956011)(33656002)(305945005)(64756008)(66446008)(3846002)(26005)(6116002)(478600001)(81166006)(66066001)(6246003)(4326008)(81156014)(6486002)(14444005)(102836004)(6436002)(86362001)(316002)(53936002)(71200400001)(76176011)(1076003)(71190400001)(52116002)(2906002)(6506007)(386003)(486006)(54906003)(229853002)(8936002)(8676002)(256004)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5135;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HsLBZIOqkft0bg5OPn69Wp7T9LGtCJc+l/KbiiCmo2QYJmK19mGgGkHc+NGPOoC2tZA8xG5D1YlL0eDEYCV8ctx5JJs8ZgSt3sxRjy56CHMlTnAlwhwXDxx5kFY4FSesaDPHARe+NcceKUFCxrTAuzVyrMZIhfVqszUeDwC64nPJM4ydkptcLntfnFhoBVwrByoCWl1DTZBuWjJpnUaeW95yx9jirVkRZwTWKvgIWMrW3+skP6obmBhEoQwlxae5IdIY4z6FqGtxrBR4fod+67qbBduRqz0/2lCjRa3tKjgzguYxdCKaK2lIX4ZttuJsQ4m1WIN95Xd8RzbSyurVKmfkBn1KmaBGZl8V2l+KQ+foPHnrYyVSsmVymiKkqiaibd/KUJJtEVpj8y7jcww5IsUOrtav0pLBiFMSRqdYqgo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21670ED76D71C742A41D541CB22BDDAD@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30fa95c-8a9d-4731-425d-08d6e39138e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 17:23:38.7428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5135
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 28, 2019 at 08:14:39PM +0300, Yuval Shaia wrote:
> The virtual address that is registered is used as a base for any address
> used later in post_recv and post_send operations.
>=20
> On a virtualised environment this is not correct.
>=20
> A guest cannot register its memory so hypervisor maps the guest physical
> address to a host virtual address and register it with the HW. Later on,
> at datapath phase, the guest fills the SGEs with addresses from its
> address space.
>=20
> Since HW cannot access guest virtual address space an extra translation
> is needed to map those addresses to be based on the host virtual address
> that was registered with the HW.
>=20
> To avoid this, a logical separation between the address that is
> registered and the address that is used as a offset at datapath phase is
> needed.
>=20
> This separation is already implemented in the lower layer part
> (ibv_cmd_reg_mr) but blocked at the API level.
>=20
> Fix it by introducing a new API function that accepts a address from
> guest virtual address space as well
>=20
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> v0 -> v1:
> 	* Accept comment from Jason and change reg_mr callback signature
> 	* Add the new API to libibverbs/libibverbs.map.in (please review
> 	  carefully as i really not sure if this is how it should be done)
>  libibverbs/compat-1_0.c           |  2 +-
>  libibverbs/driver.h               |  2 +-
>  libibverbs/dummy_ops.c            |  2 +-
>  libibverbs/libibverbs.map.in      |  1 +
>  libibverbs/verbs.c                | 23 ++++++++++++++++++++++-
>  libibverbs/verbs.h                |  7 +++++++
>  providers/bnxt_re/verbs.c         |  6 +++---
>  providers/bnxt_re/verbs.h         |  2 +-
>  providers/cxgb3/iwch.h            |  4 ++--
>  providers/cxgb3/verbs.c           |  9 +++++----
>  providers/cxgb4/libcxgb4.h        |  4 ++--
>  providers/cxgb4/verbs.c           |  9 +++++----
>  providers/hfi1verbs/hfiverbs.h    |  4 ++--
>  providers/hfi1verbs/verbs.c       |  8 ++++----
>  providers/hns/hns_roce_u.h        |  2 +-
>  providers/hns/hns_roce_u_verbs.c  |  6 +++---
>  providers/i40iw/i40iw_umain.h     |  2 +-
>  providers/i40iw/i40iw_uverbs.c    |  8 ++++----
>  providers/ipathverbs/ipathverbs.h |  4 ++--
>  providers/ipathverbs/verbs.c      |  8 ++++----
>  providers/mlx4/mlx4.h             |  4 ++--
>  providers/mlx4/verbs.c            |  7 +++----
>  providers/mlx5/mlx5.h             |  4 ++--
>  providers/mlx5/verbs.c            |  7 +++----
>  providers/mthca/ah.c              |  3 ++-
>  providers/mthca/mthca.h           |  4 ++--
>  providers/mthca/verbs.c           |  6 +++---
>  providers/nes/nes_umain.h         |  2 +-
>  providers/nes/nes_uverbs.c        |  9 ++++-----
>  providers/ocrdma/ocrdma_main.h    |  2 +-
>  providers/ocrdma/ocrdma_verbs.c   | 10 ++++------
>  providers/qedr/qelr_main.h        |  2 +-
>  providers/qedr/qelr_verbs.c       | 11 ++++-------
>  providers/qedr/qelr_verbs.h       |  4 ++--
>  providers/rxe/rxe.c               |  6 +++---
>  providers/vmw_pvrdma/pvrdma.h     |  4 ++--
>  providers/vmw_pvrdma/verbs.c      |  7 +++----
>  37 files changed, 114 insertions(+), 91 deletions(-)
>=20
> diff --git a/libibverbs/compat-1_0.c b/libibverbs/compat-1_0.c
> index 695f89de..fbcc7514 100644
> +++ b/libibverbs/compat-1_0.c
> @@ -171,7 +171,7 @@ struct ibv_context_ops_1_0 {
>  	struct ibv_pd *		(*alloc_pd)(struct ibv_context *context);
>  	int			(*dealloc_pd)(struct ibv_pd *pd);
>  	struct ibv_mr *		(*reg_mr)(struct ibv_pd *pd, void *addr, size_t length=
,
> -					  int access);
> +					  uint64_t hca_va, int access);
>  	int			(*dereg_mr)(struct ibv_mr *mr);
>  	struct ibv_cq *		(*create_cq)(struct ibv_context *context, int cqe,
>  					     struct ibv_comp_channel *channel,

This one can't change, it is ABI

> diff --git a/libibverbs/driver.h b/libibverbs/driver.h
> index e4d624b2..ef27259a 100644
> +++ b/libibverbs/driver.h
> @@ -338,7 +338,7 @@ struct verbs_context_ops {
>  				    uint64_t dm_offset, size_t length,
>  				    unsigned int access);
>  	struct ibv_mr *(*reg_mr)(struct ibv_pd *pd, void *addr, size_t length,
> -				 int access);
> +				 uint64_t hca_va, int access);
>  	int (*req_notify_cq)(struct ibv_cq *cq, int solicited_only);
>  	int (*rereg_mr)(struct verbs_mr *vmr, int flags, struct ibv_pd *pd,
>  			void *addr, size_t length, int access);
> diff --git a/libibverbs/dummy_ops.c b/libibverbs/dummy_ops.c
> index c861c3a0..61a8fbdf 100644
> +++ b/libibverbs/dummy_ops.c
> @@ -410,7 +410,7 @@ static struct ibv_mr *reg_dm_mr(struct ibv_pd *pd, st=
ruct ibv_dm *dm,
>  }
> =20
>  static struct ibv_mr *reg_mr(struct ibv_pd *pd, void *addr, size_t lengt=
h,
> -			     int access)
> +			     uint64_t hca_va,  int access)
>  {
>  	errno =3D ENOSYS;
>  	return NULL;
> diff --git a/libibverbs/libibverbs.map.in b/libibverbs/libibverbs.map.in
> index 87a1b9fc..523fd424 100644
> +++ b/libibverbs/libibverbs.map.in
> @@ -94,6 +94,7 @@ IBVERBS_1.1 {
>  		ibv_query_srq;
>  		ibv_rate_to_mbps;
>  		ibv_reg_mr;
> +		ibv_reg_mr_virt_as;
>  		ibv_register_driver;
>  		ibv_rereg_mr;
>  		ibv_resize_cq;
> diff --git a/libibverbs/verbs.c b/libibverbs/verbs.c
> index 1766b9f5..3390aef8 100644
> +++ b/libibverbs/verbs.c
> @@ -312,7 +312,28 @@ LATEST_SYMVER_FUNC(ibv_reg_mr, 1_1, "IBVERBS_1.1",
>  	if (ibv_dontfork_range(addr, length))
>  		return NULL;
> =20
> -	mr =3D get_ops(pd->context)->reg_mr(pd, addr, length, access);
> +	mr =3D get_ops(pd->context)->reg_mr(pd, addr, length, (uint64_t) addr,
> +					  access);
> +	if (mr) {
> +		mr->context =3D pd->context;
> +		mr->pd      =3D pd;
> +		mr->addr    =3D addr;
> +		mr->length  =3D length;
> +	} else
> +		ibv_dofork_range(addr, length);
> +
> +	return mr;
> +}
> +
> +struct ibv_mr *ibv_reg_mr_virt_as(struct ibv_pd *pd, void *addr, size_t =
length,
> +				  uint64_t hca_va, int access)
> +{
> +	struct ibv_mr *mr;
> +
> +	if (ibv_dontfork_range(addr, length))
> +		return NULL;
> +
> +	mr =3D get_ops(pd->context)->reg_mr(pd, addr, length, hca_va, access);
>  	if (mr) {
>  		mr->context =3D pd->context;
>  		mr->pd      =3D pd;
> diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
> index cb2d8439..adbf991b 100644
> +++ b/libibverbs/verbs.h
> @@ -2372,6 +2372,13 @@ static inline int ibv_close_xrcd(struct ibv_xrcd *=
xrcd)
>  struct ibv_mr *ibv_reg_mr(struct ibv_pd *pd, void *addr,
>  			  size_t length, int access);
> =20
> +/**
> + * ibv_reg_mr_virt_as - Register a memory region with a virtual offset
> + * address
> + */
> +struct ibv_mr *ibv_reg_mr_virt_as(struct ibv_pd *pd, void *addr, size_t =
length,
> +				  uint64_t hca_va, int access);
> +

Needs a man page update too

Other stuff looks right to me

Jason
