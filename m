Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2CC1F712
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 17:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfEOPDM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 May 2019 11:03:12 -0400
Received: from mail-eopbgr60053.outbound.protection.outlook.com ([40.107.6.53]:48947
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725939AbfEOPDL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 May 2019 11:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+dfteZQe88DSkwHwMNs09j40yG+kVY9Zd2GmIJGiuA=;
 b=XR98DmQkZuLG0+VSe2yCMZ/rp1vTXG4pW9z/T4CVBDEV/YhRORGb6kuQB+ZMUVrXjs5c54M911Mw/xgiknMyGKGmqNBMk/H6YoKOX0dopAob+XGJWMBC9T3F7zklG3Xh/E352EJAqH+q+tsuO26dizXvsRmqjffYU++HcrO/YQc=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5261.eurprd05.prod.outlook.com (20.178.8.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Wed, 15 May 2019 15:03:07 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1900.010; Wed, 15 May 2019
 15:03:07 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [RFC PATCH rdma-next v1] RDMA/srp: Rename SRP sysfs name after IB
 device rename trigger
Thread-Topic: [RFC PATCH rdma-next v1] RDMA/srp: Rename SRP sysfs name after
 IB device rename trigger
Thread-Index: AQHVCyD7tJKWIpzEbUWUvMvlthApuqZsSFKA
Date:   Wed, 15 May 2019 15:03:07 +0000
Message-ID: <20190515150301.GG30771@mellanox.com>
References: <20190515132026.18768-1-leon@kernel.org>
In-Reply-To: <20190515132026.18768-1-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::14) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 788493a5-bdc7-4710-3f2d-08d6d9467045
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5261;
x-ms-traffictypediagnostic: VI1PR05MB5261:
x-microsoft-antispam-prvs: <VI1PR05MB52610C5E52D9F71BBFBAF84BCF090@VI1PR05MB5261.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(366004)(346002)(199004)(189003)(76176011)(446003)(3846002)(6116002)(6512007)(8676002)(5660300002)(2906002)(486006)(25786009)(8936002)(71190400001)(6506007)(386003)(1076003)(71200400001)(36756003)(99286004)(256004)(86362001)(476003)(52116002)(6916009)(2616005)(54906003)(11346002)(66066001)(4326008)(186003)(508600001)(6246003)(68736007)(102836004)(73956011)(26005)(64756008)(66556008)(66476007)(33656002)(66946007)(305945005)(66446008)(7736002)(53936002)(14454004)(81166006)(81156014)(316002)(6436002)(6486002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5261;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TlzJQkzuvy/f2RWKu/Ak1YDseLZuHDDHcijyTcvkysxDi9FrejXWT7I58bnMeoSlrnAxHHBLQq3LA/jkvwOVYJAlUo9NFSnDTWWS05cNUQEdiNRaqyQ2gi5fb5zOVJ1Gd9YrAGUW3FGdu40PRxR3SPln8FFbK16T/ED0t99kGe1ffaRLkWtjm2iQXYCLIgspnpFLrfwZDof0WivTyN5vMfcoAIs8UtTyiF5am6iajQE6ZZ/RX5jKJJ8Lg9Kiz5P0SMUrVc6joaQx1Noz9ttmNJVPZnk951OcJq8oM6bNXPKLOIVcxWVCoGmBgq8QjpAb04pWFYTJuI6BkhKPztUV3zD0Ec1EdTZyA6Mu99ZBanyyx+U/dNnWxuuF2uN0X5tJo6iN9n9UFbDm9A/ckMX1OnldUL8c5zGfF+f1T7OlidQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B265702CE3ED1D4DB999F19E615243AB@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 788493a5-bdc7-4710-3f2d-08d6d9467045
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 15:03:07.6996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5261
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 15, 2019 at 04:20:26PM +0300, Leon Romanovsky wrote:
>=20
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/d=
evice.c
> index a67aaf0e1f76..64f777e757f6 100644
> +++ b/drivers/infiniband/core/device.c
> @@ -410,6 +410,9 @@ static int rename_compat_devs(struct ib_device *devic=
e)
>=20
>  int ib_device_rename(struct ib_device *ibdev, const char *name)
>  {
> +	struct ib_client *client;
> +	unsigned long index;
> +	void *client_data;
>  	int ret;
>=20
>  	down_write(&devices_rwsem);
> @@ -428,6 +431,19 @@ int ib_device_rename(struct ib_device *ibdev, const =
char *name)
>  		goto out;
>  	strlcpy(ibdev->name, name, IB_DEVICE_NAME_MAX);
>  	ret =3D rename_compat_devs(ibdev);
> +
> +	downgrade_write(&devices_rwsem);
> +	down_read(&clients_rwsem);
> +	xa_for_each_marked (&clients, index, client, CLIENT_REGISTERED) {
> +		if (client->rename) {

This isn't the right iteration for clients.. It has to iterate the
same way ib_get_net_dev_by_params() does it, otherwise there are races
if the client is concurrently unregistering.

Jason
