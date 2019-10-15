Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7EDD7ECC
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2019 20:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbfJOSWG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Oct 2019 14:22:06 -0400
Received: from mail-eopbgr30048.outbound.protection.outlook.com ([40.107.3.48]:43283
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727831AbfJOSWF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 15 Oct 2019 14:22:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gArLE766lq5ksvpsHylZF1vQL2c+ylaCfQ/+7Ygai0k5OKrgmWUI9VzYTTAc02gU0mxNTA01kWEqqfxe4UmrEXBQ8RVr/tfFi90jybH3AcldFL0rsAnoNq8A5p/1qHlY9BKf66RUJAUfspNkskM6H7S525w74SvzNqxhA/1HxuSpE1CxzaU/z8j1LrNtWF/Mt3eW9mAr4GwTN68pdVvXJpcSuiCXH/TmmIdVbTvgEcWilmke9j99LRcDDLgvo9xmyNqvxKvrBj2KDlwd52HgMGwhCtSBxnr2uqGEYvHzZSxYPM8nrceHz4EJAku5LPBXqur4Rsj0f2IK9lVapV6zqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5kY7A/F+MbzghNNnVE5H9C4gl9FY+ImqHpKumK4mI4=;
 b=dldUuZoETK8XLZTyvBcM7iBerwB77Tx9C6YUP25WR4YeXaCCbQA3qZ8WaM4xsq4RsrrNRv/5phJKUxrMzZ65PZx6LpIyJM0yWbUUFbjSHB+exLgWNrzGtL9XDuTjXSN4i9fVBPPZwS3Q2FgQlejPdf1JTPGJExFw4QG2AD7FlmazYwGS4+JbS7DUMTDAz0o41ZxYShF9RGkM2Tp74Xi303ZKn3t+KVOK0CBa6VUcGHlB0y5XvTv/zyu8GdJqhNvhmy7mfYbBuP81MCCx3mm52loX24LTysj5J0HqgZoL2jp0zLnjH3t9oTFb3a6F/Pau1ulTVttm4suyurlLo/rSFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5kY7A/F+MbzghNNnVE5H9C4gl9FY+ImqHpKumK4mI4=;
 b=dfKQue861SFZk/tAb5qWpruK9acunL9SvqJ5EGMnKnZH24eIGwm+3jdUbqkunufxguRVipKcLZM+vhYdi4SlrXKGmQezaR1mn2JSwkldXPO/lJPzQl1eaQPnz6G8QPAxNubnRrEbpnfj9w9lqxc/DKiqDAOuic+PESDdxuMLCRY=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4768.eurprd05.prod.outlook.com (20.176.7.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Tue, 15 Oct 2019 18:22:02 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0%7]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 18:22:02 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-next v1 2/2] RDMA/uapi: Drop the dependency of
 ib_user_ioctl_verbs.h on ib_user_verbs.h
Thread-Topic: [PATCH rdma-next v1 2/2] RDMA/uapi: Drop the dependency of
 ib_user_ioctl_verbs.h on ib_user_verbs.h
Thread-Index: AQHVgy3JMY5LpzR8MkemxU1ZkwOprqdcBHwA
Date:   Tue, 15 Oct 2019 18:22:01 +0000
Message-ID: <20191015182153.GL4121@mellanox.com>
References: <20191015075419.18185-1-leon@kernel.org>
 <20191015075419.18185-3-leon@kernel.org>
In-Reply-To: <20191015075419.18185-3-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::36) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [24.114.26.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3afe473-4042-44cf-3b07-08d7519c92e1
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR05MB4768:|VI1PR05MB4768:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB47680E551D7FE3035F60525BCF930@VI1PR05MB4768.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:345;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(199004)(189003)(6116002)(66556008)(66476007)(2616005)(229853002)(64756008)(6506007)(486006)(476003)(6246003)(478600001)(81166006)(81156014)(71190400001)(71200400001)(33656002)(6436002)(316002)(107886003)(6512007)(54906003)(102836004)(52116002)(26005)(66946007)(186003)(86362001)(386003)(6916009)(66446008)(305945005)(446003)(11346002)(8676002)(3846002)(76176011)(7736002)(2906002)(66066001)(14454004)(4326008)(6486002)(256004)(1076003)(25786009)(8936002)(36756003)(5660300002)(99286004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4768;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5bJdNwATWMrew0W+xuUV0q3SDUgJ+hTmlaJbxeoDIHfFQK5R+3S5vtqpy26jrgjPxR7TsoeKvaqWWfBxnaNpaGGCABllqn/5nfv1eccGjCqqwYY2fStFQ4PQn/b896f0zZDgsbumi4lz9Z5zGultdNAGEPBsi+zXz6r4xrm9LNpVXDYn411kHkbLaHIS4dBnQ3pdAvLBuatuXfKFQ9eLqQMRSXAZ/wqY1TlZV4jdEzzLNOQuiEGZe9j3Yhdpz+VnJphBp3DZ8C1tGntYJziniQGEBJBuTAB8byvJa/rqrEwjSVULLKoocZCeHvIOKZTdXmHB824zjJTiXgvEMtTKwBU1EYRxUBJMlW1u/qlWPZE9eO1FGc5yDzmhCfHgdxysBhlczTh34ljU0xGgibCbQDs8VupchWkIC7e79MttqW8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C0FB0767B67A8D46A3CFC8306D524BD8@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3afe473-4042-44cf-3b07-08d7519c92e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 18:22:01.9405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HcgMgbpI0GpkYQW4WrgCVtVRQFBzQaSwr0u1XWUu5ew5uU2qwf2mxeCJKGZpei8V2XVvfcUlUbHdT2vozh4rgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4768
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 15, 2019 at 10:54:19AM +0300, Leon Romanovsky wrote:
> From: Yishai Hadas <yishaih@mellanox.com>
>=20
> Drop the dependency of ib_user_ioctl_verbs.h on ib_user_verbs.h which
> is not really required.
>=20
> Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  include/uapi/rdma/ib_user_ioctl_verbs.h | 26 ++++++++++++++++++++++++-
>  include/uapi/rdma/ib_user_verbs.h       | 25 ------------------------
>  2 files changed, 25 insertions(+), 26 deletions(-)
>=20
> diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/=
ib_user_ioctl_verbs.h
> index 9019b2d906ea..8bdfdd4ef8b5 100644
> +++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
> @@ -35,7 +35,6 @@
>  #define IB_USER_IOCTL_VERBS_H
> =20
>  #include <linux/types.h>
> -#include <rdma/ib_user_verbs.h>
> =20
>  #ifndef RDMA_UAPI_PTR
>  #define RDMA_UAPI_PTR(_type, _name)	__aligned_u64 _name
> @@ -167,6 +166,31 @@ enum ib_uverbs_advise_mr_flag {
>  	IB_UVERBS_ADVISE_MR_FLAG_FLUSH =3D 1 << 0,
>  };
> =20
> +struct ib_uverbs_query_port_resp {
> +	__u32 port_cap_flags;		/* see ib_uverbs_query_port_cap_flags */
> +	__u32 max_msg_sz;
> +	__u32 bad_pkey_cntr;
> +	__u32 qkey_viol_cntr;
> +	__u32 gid_tbl_len;
> +	__u16 pkey_tbl_len;
> +	__u16 lid;
> +	__u16 sm_lid;
> +	__u8  state;
> +	__u8  max_mtu;
> +	__u8  active_mtu;
> +	__u8  lmc;
> +	__u8  max_vl_num;
> +	__u8  sm_sl;
> +	__u8  subnet_timeout;
> +	__u8  init_type_reply;
> +	__u8  active_width;
> +	__u8  active_speed;
> +	__u8  phys_state;
> +	__u8  link_layer;
> +	__u8  flags;			/* see ib_uverbs_query_port_flags */
> +	__u8  reserved;
> +};

Still don't understand why this is being moved here, not  this one:

>  struct ib_uverbs_query_port_resp_ex {
>  	struct ib_uverbs_query_port_resp legacy_resp;
>  	__u16 port_cap_flags2;

Moved to its proper place

Neither of these belong in this header

Jason
