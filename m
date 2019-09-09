Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE1BAD512
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2019 10:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfIIIsO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Sep 2019 04:48:14 -0400
Received: from mail-eopbgr150047.outbound.protection.outlook.com ([40.107.15.47]:1543
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726704AbfIIIsO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 9 Sep 2019 04:48:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/8vpHosKFm4Sn0RkPy2avKWqWOIGFsxDhWrc5NM078Xud2adhyAji8oMkAmhJeH2/2FIN6tut1qbDrfdVzCsj/hLsLACXRIY+sP4iY2TCW8hp7vN0jWnJqK5fJkJ0L/Twr0FdXJP50L0oNFshsWX9cK70AlD7v1cZPm03PzwL1K6MLqDCocFxG97P/OhgOfXkeLZQNgkcRsf0BplW+YcmCRVwtVCIua5pg/hTiSCtEJ6IEUguauRkGHhTiuJ2Vw5AuER0wlifCuwZJ5Cy5qIohoWQmpIzOq5OsX26PvVavxVAX9hJRGc2OZOkI4HDE/7ZOiVdhdjuPXsQY9x4sgXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaK9/HP6kF5dVw1LDvdxMWLajrS9Qmz1Dvuk1PN65L8=;
 b=ZNNFN4UXe7NJOD/uFPSDXF/jwpafzXrH2Zx8Mwy3Q+jXcmU1oMOsUtJR8J6dwE+3BKhCIIu1FPOU/uL7xwYUMqCo8nFkWYDsbZ9gFpWsUOnlsxaMMoQWrNgP/jL3GBxupEgogA/IRiwLd2NApLZlz/AFo0yE9kY1cyanXA8FWnkhPf3dwN0W8C4YQOCTkhdvlh+fJ0Z8LpegR9cx5f7dJEZs+qfxoa1ndP0FD5WpIV3O5v5sMOs+CLXpvMwEl5IXJUCb4aOU0sF58/VA/2osHJc4GNQPmpft1ULe9C9fC3RlTtyO0xKzhAUA6e0YirFQO+HOsUcc+Jb2CgBuv1LKpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaK9/HP6kF5dVw1LDvdxMWLajrS9Qmz1Dvuk1PN65L8=;
 b=gJt59edJtDOra9q5kbCou00AYbSb1acWpqOA0VmRraxORlsGmWhADQCpNIo9uUwse6ajDjIiCXlacDZqzSJBnIor0qktn2fMZ8GiE7zmBiqW02Ap0BhqeBTAcWLDUG/UT1XNwt8GnJYsz7iPVoLgBc8Utl4Nhr+uBIiey5NKQVc=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5374.eurprd05.prod.outlook.com (20.178.8.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Mon, 9 Sep 2019 08:48:09 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f%7]) with mapi id 15.20.2241.018; Mon, 9 Sep 2019
 08:48:09 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: Re: [PATCH rdma-next v1 2/4] RDMA/nldev: Allow different fill
 function per resource
Thread-Topic: [PATCH rdma-next v1 2/4] RDMA/nldev: Allow different fill
 function per resource
Thread-Index: AQHVXws/iJbS0qJvt0+oNIXJuy+U0acjGIOA
Date:   Mon, 9 Sep 2019 08:48:09 +0000
Message-ID: <20190909084807.GC2843@mellanox.com>
References: <20190830081612.2611-1-leon@kernel.org>
 <20190830081612.2611-3-leon@kernel.org>
In-Reply-To: <20190830081612.2611-3-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MRXP264CA0029.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::17) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [148.69.85.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ccd5ea2-b502-4c2f-ec63-08d7350270b4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5374;
x-ms-traffictypediagnostic: VI1PR05MB5374:|VI1PR05MB5374:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB537475BEAE7DCDA5B43FB5C2CFB70@VI1PR05MB5374.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(199004)(189003)(229853002)(386003)(76176011)(8936002)(186003)(26005)(66066001)(25786009)(81156014)(81166006)(6436002)(476003)(4326008)(446003)(2616005)(107886003)(102836004)(486006)(36756003)(6916009)(6486002)(6506007)(6512007)(11346002)(53936002)(6246003)(5660300002)(33656002)(6116002)(66476007)(66556008)(14454004)(3846002)(52116002)(2906002)(99286004)(1076003)(54906003)(66946007)(86362001)(71200400001)(256004)(71190400001)(305945005)(8676002)(478600001)(7736002)(66446008)(64756008)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5374;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Hp93iRngL9xrXwgxfX4oU9l9uummG1kWdzuvqsqvoW3h8UObcCI3MzX7bFgwWJxgVgHionv5hPwmkWeD/6e/uS8lDKnE6g3tSfvmFyn5sngAdaYx+Kqee2wngaD7RnOCZZ4UPxdyNdsX8z3991mKIonsCeHFqf4aS/+JGycAAKz7W9UiDtfHoqs04iQ7ImqZewNvtFwdfgJYdm7InNGVoW5YW/jlRfRR+PbACfFJaF/O+mmtzuhd3cn10MlkP8MxSfOxn3nfpLbCyNwE9r7QIlOx1Bf4h461Z11pjhAvQFJ1f0wIuvRvNWC/TJuJ9m9G7YMRpiH2cU4Ji/fJX+iaJdeQdB3apNG+Dt0Wq1Psbgac51mDRHeOtWvo4SjaXuf9MazJa4Z03VCpmCEoh3KWPxOKVNLaBEcNM+bZEKWtXP0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7DACF98EB6B3DC44A11FF1B28AC129DB@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ccd5ea2-b502-4c2f-ec63-08d7350270b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 08:48:09.4745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tbfw20AxZroBU0JSvozjMNBHz9uNfdGuMB/PhoZTFncuGRZn9xRNho2KGEhPUlmxXMjFHTW7gg8rZUGysiFJAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5374
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 30, 2019 at 11:16:10AM +0300, Leon Romanovsky wrote:
> From: Erez Alfasi <ereza@mellanox.com>
>=20
> So far res_get_common_{dumpit, doit} was using the default
> resource fill function which was defined as part of the
> nldev_fill_res_entry fill_entries.
>=20
> Add a fill function pointer as an argument allows us to use
> different fill function in case we want to dump different
> values then 'rdma resource' flow do, but still use the same
> existing general resources dumping flow.
>=20
> If a NULL value is passed, it will be using the default
> fill function that was defined in 'fill_entries' for a
> given resource type.
>=20
> Signed-off-by: Erez Alfasi <ereza@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/core/nldev.c | 42 +++++++++++++++++++++++----------
>  1 file changed, 29 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nl=
dev.c
> index cc08218f1ef7..47f7fe5432db 100644
> +++ b/drivers/infiniband/core/nldev.c
> @@ -1181,7 +1181,10 @@ static const struct nldev_fill_res_entry fill_entr=
ies[RDMA_RESTRACK_MAX] =3D {
> =20
>  static int res_get_common_doit(struct sk_buff *skb, struct nlmsghdr *nlh=
,
>  			       struct netlink_ext_ack *extack,
> -			       enum rdma_restrack_type res_type)
> +			       enum rdma_restrack_type res_type,
> +			       int (*fill_func)(struct sk_buff*, bool,
> +						struct rdma_restrack_entry*,
> +						uint32_t))

Use a typedef?

>  {
>  	const struct nldev_fill_res_entry *fe =3D &fill_entries[res_type];
>  	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX];
> @@ -1244,7 +1247,12 @@ static int res_get_common_doit(struct sk_buff *skb=
, struct nlmsghdr *nlh,
>  	}
> =20
>  	has_cap_net_admin =3D netlink_capable(skb, CAP_NET_ADMIN);
> -	ret =3D fe->fill_res_func(msg, has_cap_net_admin, res, port);
> +
> +	if (fill_func)
> +		ret =3D fill_func(msg, has_cap_net_admin, res, port);
> +	else
> +		ret =3D fe->fill_res_func(msg, has_cap_net_admin, res, port);

Weird to now be choosing between two function pointers

> -#define RES_GET_FUNCS(name, type)                                       =
       \
> -	static int nldev_res_get_##name##_dumpit(struct sk_buff *skb,          =
\
> +#define RES_GET_FUNCS(name, type)					       \
> +	static int nldev_res_get_##name##_dumpit(struct sk_buff *skb,	       \
>  						 struct netlink_callback *cb)  \
> -	{                                                                      =
\
> -		return res_get_common_dumpit(skb, cb, type);                   \
> -	}                                                                      =
\
> -	static int nldev_res_get_##name##_doit(struct sk_buff *skb,            =
\
> -					       struct nlmsghdr *nlh,           \
> +	{								       \
> +		return res_get_common_dumpit(skb, cb, type, NULL);	       \
> +	}								       \
> +	static int nldev_res_get_##name##_doit(struct sk_buff *skb,	       \
> +					       struct nlmsghdr *nlh,	       \
>  					       struct netlink_ext_ack *extack) \
> -	{                                                                      =
\
> -		return res_get_common_doit(skb, nlh, extack, type);            \
> +	{								       \
> +		return res_get_common_doit(skb, nlh, extack, type, NULL);      \
>  	}

ie the NULL should be fill_entries[type]->fill_res_func?

Jason
