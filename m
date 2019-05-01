Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9270610850
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2019 15:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfEAN27 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 May 2019 09:28:59 -0400
Received: from mail-eopbgr80075.outbound.protection.outlook.com ([40.107.8.75]:65415
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726010AbfEAN26 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 1 May 2019 09:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVpRpbjxXcscNzRxLkw2o5XcEHXPqHqKp4OuXDooeOs=;
 b=XC0B2zjuKTprK6ERMUslxhp+PSlhvzMai81yPoNCkA9AZaARq6FRhIe+Yn75mCItmevC3hFqXwCVBPbA1L+2VjkBpMFSRhzSgWuCpC2jNtFBCkoefqzAetho/zys1WzjhxDd92wrqaiIwhRpKbT0CjswYBAVxWktWtrSXFZ88Rc=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB3198.eurprd05.prod.outlook.com (10.170.237.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.14; Wed, 1 May 2019 13:28:55 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1835.018; Wed, 1 May 2019
 13:28:55 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/device: Don't fire uevent before device is
 fully initialized
Thread-Topic: [PATCH rdma-next] RDMA/device: Don't fire uevent before device
 is fully initialized
Thread-Index: AQHU/+E4Vr9Vk2z/C0iohsSgWNwU86ZWKHqA
Date:   Wed, 1 May 2019 13:28:55 +0000
Message-ID: <20190501115049.GA10407@mellanox.com>
References: <20190501054619.14838-1-leon@kernel.org>
In-Reply-To: <20190501054619.14838-1-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR01CA0002.prod.exchangelabs.com (2603:10b6:208:10c::15)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [173.228.226.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9de2fa44-6e98-45c3-4a8b-08d6ce38f57a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB3198;
x-ms-traffictypediagnostic: VI1PR05MB3198:
x-microsoft-antispam-prvs: <VI1PR05MB3198C825662D70B915007970CF3B0@VI1PR05MB3198.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 00246AB517
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(39860400002)(376002)(136003)(199004)(189003)(478600001)(102836004)(66946007)(6512007)(8676002)(476003)(2616005)(6506007)(486006)(36756003)(52116002)(11346002)(81156014)(81166006)(33656002)(256004)(68736007)(8936002)(76176011)(2906002)(26005)(446003)(86362001)(99286004)(5660300002)(25786009)(1076003)(54906003)(14454004)(186003)(53936002)(66066001)(316002)(6486002)(229853002)(386003)(7736002)(4326008)(6246003)(3846002)(6116002)(6916009)(6436002)(66446008)(64756008)(66476007)(305945005)(66556008)(73956011)(71200400001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3198;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wVQkZHe4zI0UHrGCAm2utp1oWjkh8TDhZa9pJqr1fhRczMVd1yKdB8T69rlQ72zejSfzczB6u1PFqP4MHsJJpFFQ35/M3RgzawYBe9Mc4zr3/FOx7DlexBLKvldpww9eiWQGhC0IGnfbi7pUpVsbtEHJKP5IXfpUHsG7Czfb2repJvKvzd2Ms01nrqWdasJruAGM+p3Xvc534RribNB2OYAya97EwrsJhvkZI3j2ROHAWEKuv/iRWWdFvQIxCbKXbHS+9NoizxrGYPzIToBMQp9Suj002AvI3LqWItoBkDJwHBV5IIkfFB5ILeO2J+lji68ZwavsDxcbQBxYQXy461E8rY3WmE/BOvU3Nz7riVXwpTRgsNSgkOo5yCk+zMGvYYomumkY1paCxDyEE0Tam27A5r7JeZWT85y9LQ3qG8A=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F36EAFF853F8064587A03D72F0966E18@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de2fa44-6e98-45c3-4a8b-08d6ce38f57a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2019 13:28:55.3818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3198
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 01, 2019 at 08:46:19AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>=20
> When the refcount is 0 the device is invisible to netlink. However
> in the patch below the refcount =3D 1 was moved to after the device_add()=
.
> This creates a race where userspace can issue a netlink query after the
> device_add() event and not see the device as visible.
>=20
> Ensure that no uevent is fired before device is fully registered.
>=20
> Fixes: d79af7242bb2 ("RDMA/device: Expose ib_device_try_get(()")
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/core/device.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/d=
evice.c
> index 8ae4906a60e7..4cdc8588df7f 100644
> +++ b/drivers/infiniband/core/device.c
> @@ -808,6 +808,7 @@ static int add_one_compat_dev(struct ib_device *devic=
e,
>  	cdev->dev.release =3D compatdev_release;
>  	dev_set_name(&cdev->dev, "%s", dev_name(&device->dev));
>=20
> +	dev_set_uevent_suppress(&device->dev, true);
>  	ret =3D device_add(&cdev->dev);
>  	if (ret)
>  		goto add_err;

compat devices definitely should not be doing this..

Jason
