Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42A0C121E1
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2019 20:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfEBSa6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 May 2019 14:30:58 -0400
Received: from mail-eopbgr80077.outbound.protection.outlook.com ([40.107.8.77]:42499
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725962AbfEBSa6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 May 2019 14:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sA8xitavzV/lHmpyahknobVohb4b+Nemc5nQZMhDvT4=;
 b=hHh5hXHU8WiEMGOsJO9KK7Qh/0cymDaW2bEO5EidJzFNcVynkW/5QACVYCut0jBf3B1QDykJDfw4uy8LMjPxQ1M3/5Lm3eIE4in9Aws+9PCVYZqXWcuC+ZKFeVKF47sh6AESHJ6BsNIfuM4OghpXasQTPkILGeNAVT36uQKNgb8=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.134.149) by
 VI1PR0501MB2733.eurprd05.prod.outlook.com (10.172.15.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Thu, 2 May 2019 18:30:54 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::8810:9799:ab77:9494]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::8810:9799:ab77:9494%2]) with mapi id 15.20.1856.008; Thu, 2 May 2019
 18:30:54 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: RE: [PATCH rdma-next v1] RDMA/device: Don't fire uevent before device
 is fully initialized
Thread-Topic: [PATCH rdma-next v1] RDMA/device: Don't fire uevent before
 device is fully initialized
Thread-Index: AQHVAL7PhQAMxrKzgkymANG7P633+6ZYKEfA
Date:   Thu, 2 May 2019 18:30:54 +0000
Message-ID: <VI1PR0501MB22716ADE6FE7EDBC0000F1D7D1340@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <20190502081229.18372-1-leon@kernel.org>
In-Reply-To: <20190502081229.18372-1-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb30d554-e9a9-4629-b77d-08d6cf2c5019
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0501MB2733;
x-ms-traffictypediagnostic: VI1PR0501MB2733:
x-microsoft-antispam-prvs: <VI1PR0501MB2733EC239DB9BF83BF43EA0FD1340@VI1PR0501MB2733.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(39860400002)(346002)(396003)(199004)(189003)(54534003)(13464003)(5660300002)(99286004)(6116002)(52536014)(66556008)(66476007)(8936002)(8676002)(478600001)(229853002)(73956011)(64756008)(66446008)(81156014)(81166006)(9686003)(6436002)(55016002)(76176011)(86362001)(66946007)(7696005)(316002)(6636002)(76116006)(3846002)(54906003)(7736002)(110136005)(6506007)(53546011)(102836004)(33656002)(53936002)(4326008)(68736007)(74316002)(25786009)(305945005)(6246003)(476003)(26005)(71190400001)(71200400001)(14454004)(66066001)(256004)(11346002)(2906002)(486006)(446003)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2733;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kwFTndg3lhZGJ3cjUlCcaQaNLpaSwHaG56RwxI6UI47eaTvV34DCuhqQcZx3jwtksLkosdPxVS+cWe3WytqRxYvAYy6ZpjLXv1U8KAP+p5XQI5s2D9pb7jTr47UE5dJ5AGV/cxqbb+AQgyZvnXJlozoHI79YzOnEA4d6ls5ggvAmWZDu6WFBYdBSslCcFsKjvJ1srlx8EjV0cZ983Hn0Z16fr7i9LlueJNyAzPRYYZyfe2/lBSr24+qWDjdN8F6LCZvoiw/f9lDDHmtBPXsetU5h1/SO2VxOBgnePiqNxrHT9NceCo4WWGoHY9WL1N4Cm0kPtY1WO+CNuZH+56iyPqP2F7BzL1WkoSLCn+pBz7WLznbqvVI8FWKW5QVPzhx5AUzlxqBsoAVmEem9eRB9OuCP9nKTW4x/+Iikzx0vRMQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb30d554-e9a9-4629-b77d-08d6cf2c5019
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 18:30:54.7516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2733
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Leon Romanovsky
> Sent: Thursday, May 2, 2019 3:12 AM
> To: Doug Ledford <dledford@redhat.com>; Jason Gunthorpe
> <jgg@mellanox.com>
> Cc: Leon Romanovsky <leonro@mellanox.com>; RDMA mailing list <linux-
> rdma@vger.kernel.org>; Jason Gunthorpe <jgg@ziepe.ca>
> Subject: [PATCH rdma-next v1] RDMA/device: Don't fire uevent before devic=
e
> is fully initialized
>=20
> From: Leon Romanovsky <leonro@mellanox.com>
>=20
> When the refcount is 0 the device is invisible to netlink. However in the
> patch below the refcount =3D 1 was moved to after the device_add().
> This creates a race where userspace can issue a netlink query after the
> device_add() event and not see the device as visible.
>=20
> Ensure that no uevent is fired before device is fully registered.
>=20
> Fixes: d79af7242bb2 ("RDMA/device: Expose ib_device_try_get(()")
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  Changelog v0->v1:
>  * Dropped uevent suppress in compat devices.
> ---
>  drivers/infiniband/core/device.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/infiniband/core/device.c
> b/drivers/infiniband/core/device.c
> index 8ae4906a60e7..7c51406e34e2 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -1244,6 +1244,11 @@ int ib_register_device(struct ib_device *device,
> const char *name)
>=20
>  	ib_device_register_rdmacg(device);
>=20
> +	/*
> +	 * Ensure that ADD uevent is not fired because it
> +	 * too early amd device is not initialized yet.
> +	 */
You probably sent older version?
Minor nit comment correction.
s/it too early amd/it is too early and
