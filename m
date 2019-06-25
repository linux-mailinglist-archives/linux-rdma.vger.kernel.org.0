Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 005EC55031
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2019 15:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfFYNYZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jun 2019 09:24:25 -0400
Received: from mail-eopbgr00088.outbound.protection.outlook.com ([40.107.0.88]:37038
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726707AbfFYNYZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 Jun 2019 09:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIUoRMmT7Q/pGFoH0kkDeucTRlXTCxDbQv1YoIyGNVU=;
 b=dYVaF7mT2ZnWUrzNi5i5uHUxULo9Nd6McPrUgYuX4ulVvlvqfpdQ0yxXs1jc4waihSok9Jd96EGQh2DFXzNMRxLFKb8uoaG1c0OmYXvxlJ0Tkias+y21ZUvR7d6ieBe0SeI6nfAp9eOQ5zjyCHc+H+e4Xo4R/iN39EZFUdwDAtI=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5679.eurprd05.prod.outlook.com (20.178.121.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 13:24:21 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2008.014; Tue, 25 Jun 2019
 13:24:21 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
CC:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v3 13/33] docs: infiniband: convert docs to ReST and
 rename to *.rst
Thread-Topic: [PATCH v3 13/33] docs: infiniband: convert docs to ReST and
 rename to *.rst
Thread-Index: AQHVK1lMQcYJuuAOI0ys5lg+pRy3BA==
Date:   Tue, 25 Jun 2019 13:24:21 +0000
Message-ID: <20190625132418.GA18528@mellanox.com>
References: <cover.1560045490.git.mchehab+samsung@kernel.org>
 <09036fdb89c4bec94cb92d25398c026afdb134e7.1560045490.git.mchehab+samsung@kernel.org>
In-Reply-To: <09036fdb89c4bec94cb92d25398c026afdb134e7.1560045490.git.mchehab+samsung@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR10CA0082.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::23) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.187.232.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af3e7102-177a-46f1-1570-08d6f9706ee0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5679;
x-ms-traffictypediagnostic: VI1PR05MB5679:
x-microsoft-antispam-prvs: <VI1PR05MB5679691D268CE43F5A684265CFE30@VI1PR05MB5679.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(346002)(39860400002)(376002)(199004)(189003)(478600001)(66066001)(14454004)(81156014)(8676002)(81166006)(25786009)(6486002)(5660300002)(6512007)(8936002)(6436002)(229853002)(4326008)(256004)(54906003)(86362001)(1076003)(14444005)(71200400001)(7736002)(71190400001)(305945005)(102836004)(2616005)(11346002)(3846002)(446003)(52116002)(386003)(6506007)(486006)(316002)(6116002)(33656002)(476003)(186003)(36756003)(64756008)(66476007)(66946007)(73956011)(53936002)(68736007)(66556008)(66446008)(6246003)(76176011)(2906002)(26005)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5679;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nQ/LSQlnvbikcg+lluPb95qnljSz9aOrxASYmkcEaittJ6Imkag23r2+RXxgPe0YpR3EsLYvK4yYpWQXDub/1wDFFJ8mbmC1ToAinNqMIzqdCM4aCmfY1g6nHkWN+y3Xjl0ge2drj2S3mipRhn8RDYqQxVHLEA17mZZCH6uXnkZmCRa1urcCW0eRGeKc7JEysRlkZkjOgzGcdTTfOVO1/73+D2U7HieupHHprsQkXM/5u7GsSFQvJOSgkrZxSHlrWHbBctmWBCtsgifP3Gc0XkJ4Rr6/FT6jQUFLlVgBndYLjyKkrT//n2mN57bxWtY/Pw7Y6sxsFEToltbgSKVPaMleuL6Zw3fv9AO/J5soHHUfFy+gVC5EFtc6O68Cxba65ZnxR6uEfT6OdZNHs+vCixVrv8q6R4H/Q9rbDAqu62s=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F7C52F5F4E05CF4E96AB692EE5D43B61@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af3e7102-177a-46f1-1570-08d6f9706ee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 13:24:21.5584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5679
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jun 08, 2019 at 11:27:03PM -0300, Mauro Carvalho Chehab wrote:
> The InfiniBand docs are plain text with no markups.
> So, all we needed to do were to add the title markups and
> some markup sequences in order to properly parse tables,
> lists and literal blocks.
>=20
> At its new index.rst, let's add a :orphan: while this is not linked to
> the main index.rst file, in order to avoid build warnings.
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  .../{core_locking.txt =3D> core_locking.rst}    |  64 ++++++-----
>  Documentation/infiniband/index.rst            |  23 ++++
>  .../infiniband/{ipoib.txt =3D> ipoib.rst}       |  24 ++--
>  .../infiniband/{opa_vnic.txt =3D> opa_vnic.rst} | 108 +++++++++---------
>  .../infiniband/{sysfs.txt =3D> sysfs.rst}       |   4 +-
>  .../{tag_matching.txt =3D> tag_matching.rst}    |   5 +
>  .../infiniband/{user_mad.txt =3D> user_mad.rst} |  33 ++++--
>  .../{user_verbs.txt =3D> user_verbs.rst}        |  12 +-
>  drivers/infiniband/core/user_mad.c            |   2 +-
>  drivers/infiniband/ulp/ipoib/Kconfig          |   2 +-
>  10 files changed, 174 insertions(+), 103 deletions(-)
>  rename Documentation/infiniband/{core_locking.txt =3D> core_locking.rst}=
 (78%)
>  create mode 100644 Documentation/infiniband/index.rst
>  rename Documentation/infiniband/{ipoib.txt =3D> ipoib.rst} (90%)
>  rename Documentation/infiniband/{opa_vnic.txt =3D> opa_vnic.rst} (63%)
>  rename Documentation/infiniband/{sysfs.txt =3D> sysfs.rst} (69%)
>  rename Documentation/infiniband/{tag_matching.txt =3D> tag_matching.rst}=
 (98%)
>  rename Documentation/infiniband/{user_mad.txt =3D> user_mad.rst} (90%)
>  rename Documentation/infiniband/{user_verbs.txt =3D> user_verbs.rst} (93=
%)

Applied to for-next, thanks

Jason
