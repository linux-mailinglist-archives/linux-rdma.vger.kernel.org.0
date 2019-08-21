Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B40D897DED
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 17:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbfHUPBF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 11:01:05 -0400
Received: from mail-eopbgr00088.outbound.protection.outlook.com ([40.107.0.88]:19587
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727725AbfHUPBF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 11:01:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FK3jcOxMKEfcxXRSGPgSQXCvKcTEFtGC51i9AMNexfBZZ1DWZ+Pp0367RS6/8UXk9ziQFjWib9AKYN1uvu+a5aSShE8tFUbOoy3dY+fXAgm63Ixa1c0iWEUV29nCzKseaIuAEdOjkTDvGBX5DYl1ao+E+LpzpcQjNPMfxFuANdtMaEl4krmBQRz79tRxO3DwB1MGLcbtRg77a409wqdHutQuGTGfAxNK4/36xDlrE9gY5q19klNIF8EI2OkSChNZR8YKsnrQDawkGNguqOQWaxXdu0gw1E7UrlUtpXUVOle8uL4IMY64st4lK6AQwAZvrXlAodCQD+VNu7PuGe95Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxJMMDUmXRRDNU4gR6beTMacaN+uA9Qtt+DC2fdM1f0=;
 b=XOwbunYK/JDRkVxDuB2tPLnlWrjUFBuy9fcd7km7Zl0S3enR/hih+dgNGdRnIi9PA6aCSqH5k/c4auv5xY3ZEcjMiJz5CF0qxQX3zycotANpJbQqpDQTvQ/9rXfzSzsPciD0K8XPngzOuOxiRG9JVd5MMm02COnTE9rgJO2sNSnqjSpbM6h13H97vcwMDQMH1bWjFP022ltJMShwOi0BfzENaBrZxPhnE6EnOTqVPw3wzldnbzNNw89CU0xSe+hN+glH3RmC8L71mnPYcexJRYX6XrkwwEKbKbCmGy4Ioym8f8GHh4WOHg21m9bMbBCy70oKM9o2OtByGSgwUazodw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxJMMDUmXRRDNU4gR6beTMacaN+uA9Qtt+DC2fdM1f0=;
 b=qffBDt2uAWYA9FJKyiXwtI17Bh4ajwczRm6hlx6ZzbwJh74VKdcIPSRo06E9DzbQiGYx2cvuxK3cSILpH6qzGRujcm4R0jnnsHQDE1LYZT4/jpbb22KQJGjj54JYPI48/n1NrNnjQHek7kh4YzSeSFdAM1FNBVmsRCkgmHBiUBU=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6254.eurprd05.prod.outlook.com (20.178.205.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Wed, 21 Aug 2019 15:00:59 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7%6]) with mapi id 15.20.2178.018; Wed, 21 Aug 2019
 15:00:59 +0000
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
Subject: Re: [PATCH v1 14/24] IB/uverbs: Add PD import verb
Thread-Topic: [PATCH v1 14/24] IB/uverbs: Add PD import verb
Thread-Index: AQHVWCwQ2zDxtd/bakCcS9+ztCJkGacFshyA
Date:   Wed, 21 Aug 2019 15:00:59 +0000
Message-ID: <20190821150053.GF8667@mellanox.com>
References: <20190821142125.5706-1-yuval.shaia@oracle.com>
 <20190821142125.5706-15-yuval.shaia@oracle.com>
In-Reply-To: <20190821142125.5706-15-yuval.shaia@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQBPR0101CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::48) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0348173f-959b-4a41-2d05-08d72648607d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6254;
x-ms-traffictypediagnostic: VI1PR05MB6254:
x-ld-processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB625466D6E168754A7CC2B65DCFAA0@VI1PR05MB6254.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(199004)(189003)(33656002)(2906002)(316002)(7416002)(52116002)(5660300002)(8936002)(66446008)(64756008)(6436002)(66556008)(66476007)(6916009)(486006)(66946007)(6512007)(6246003)(8676002)(4326008)(81156014)(81166006)(66066001)(25786009)(36756003)(53936002)(305945005)(4744005)(7736002)(99286004)(54906003)(1076003)(102836004)(256004)(446003)(386003)(6506007)(2616005)(478600001)(86362001)(76176011)(6486002)(26005)(186003)(3846002)(6116002)(14454004)(11346002)(229853002)(71200400001)(71190400001)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6254;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5zltvfW7O6907dJf70saQPM3x1HJEwNHv/UITg6CXJyqjhdwXaKg0svGvQn8xu6U8IWrylDw1bInar2JO3mmCj7gUo5OgLg45tkWqKoRzTjOhR4/7goTYN9f9cEXOSe96YHZmAXLV5P+XjjMOeEajmOO/Y633rxHEwDsZIfCc5w0D5rO9lvfA9EYZTZN+JYLctcWy9ITOjUJYA7Fmhc0VJFzLvGGIFaBiU3K3IIeVZk8L/nCQnp7DBdcm5CJ4+cd/20F4IDQTbvF4y7Pcz/l8c9V5zDy9E1WKg2AyO78xaa9wsCJIOlD7lGLdOz1T3ncNa0Ozhoi4Emfr49aVc9F/CzU8CZDB/+wokHdcqddjhsb9X3tMePHjroYPy6PGJcpbZKoa55G5eK45iNn2CJJCLCrdp8VSUtolJgeyGgUTeA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <286C6E267CAE3746A22699DB3B0BE033@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0348173f-959b-4a41-2d05-08d72648607d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 15:00:59.6640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WGSModUcfsn/VD1/4imEw33be0Ish6lgdr9P1WQL7KsIijzDj0pNmy/7fGdYUB2CXBVCnfnoImeUkordWQJTMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6254
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 21, 2019 at 05:21:15PM +0300, Yuval Shaia wrote:

>  /*
>   * Describe the input structs for write(). Some write methods have an in=
put
>   * only struct, most have an input and output. If the struct has an outp=
ut then
> @@ -3999,6 +4089,11 @@ const struct uapi_definition uverbs_def_write_intf=
[] =3D {
>  			UAPI_DEF_WRITE_IO(struct ib_uverbs_query_port,
>  					  struct ib_uverbs_query_port_resp),
>  			UAPI_DEF_METHOD_NEEDS_FN(query_port)),
> +		DECLARE_UVERBS_WRITE(
> +			IB_USER_VERBS_CMD_IMPORT_FR_FD,
> +			ib_uverbs_import_fr_fd,
> +			UAPI_DEF_WRITE_IO(struct ib_uverbs_import_fr_fd,
> +					  union  ib_uverbs_import_fr_fd_resp)),

I'm sure I said this already, no new write() verbs. New things must
use ioctl.

Since this looks 100% driver specific it should be a set of driver
specific ioctls.

Jason
