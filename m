Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8235792571
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 15:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfHSNqU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 09:46:20 -0400
Received: from mail-eopbgr10079.outbound.protection.outlook.com ([40.107.1.79]:51268
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727308AbfHSNqU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Aug 2019 09:46:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnTR/GXqj1wwZJTu+7EDdbDaVt1IvVnQaQkYkq1Lmc/GKVFlDYPokoD8DAeY4fgTqu2WtZKGlNGzDD51ZbWHgTyynKQclnJey67KIC91znPPRDCPU6vQ2l5jzlIGAX8ea850ZyBEyn/Bm5ePF3HLwsN8d06uwlrHYNLjBOyq9eVIya7vPEoTF7kfYVUlEbGqdLHx8sKIAoIOuBtMeDsvJrtiucS+61aeSrj97fJYJAPX9pXUsDrYMrrdLj0c0hXAAwk1kbLPhgckEQuTOHtIk0uMXsPvhzzQ6H3g8A5pRU4Mq/pgMycB6eRMZyWtn0IJxPTpYTiuKJerkhIbQeNaEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usucbA9Uk+hsI6BTxvCL6xSCG5eteLB6cnONDe2Hzik=;
 b=YP0jYPXub1lD3HtIV5lb+N+5mzZ9Q+VESOohbf9JC0/ga2EM0MCZfeXq15JMahv+BUpH4m4+aFLXCmkGjHzJY72CyeCJ3D+isM5ir5Uc6623tbW2KD1xoDYnHLUnrCb8LT0vqWz3SjsPo3gSponGeBfm0HmEatDUPhR4IYKiLaXfAc9M+5SC90yvXrOITFyd2438iixwmxQrGWdCnO8xU/YguX3iB/+qjPv6j8iOVfb+mu6QVv9m9S4pw/4xrwJ1PsN68g6O4zR1XfC9F1W6LUdLW0FMgWnlwrnys9ei06nwQqxjcXzELlG7oXEtiOBywq/mdFE9kw3HnkT7n/ShXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usucbA9Uk+hsI6BTxvCL6xSCG5eteLB6cnONDe2Hzik=;
 b=psbeilAjuf8NVfnaBp0nN8LL/H7CgMns8u1A+nN+a3oktHjI4DQIce+wO3Gv+/mISBbSYXMHacHA1ldOr4bIu3KvyVr3pA3C07yHiWT4/gors9STGWgnaavLpj25jsaKvY4HPB8MLqAGgLQsoMUfgsljXW+BT2sdqY0KmXToayw=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6336.eurprd05.prod.outlook.com (20.179.25.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.14; Mon, 19 Aug 2019 13:46:14 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7%6]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 13:46:14 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Hal Rosenstock <hal@dev.mellanox.co.il>
CC:     Bart Van Assche <bvanassche@acm.org>,
        Hal Rosenstock <hal@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        oulijun <oulijun@huawei.com>
Subject: Re: [PATCH] RDMA/srpt: Filter out AGN bits
Thread-Topic: [PATCH] RDMA/srpt: Filter out AGN bits
Thread-Index: AQHVVoiim0GU9wq9dk64C5+GB9JNzqcCejwAgAABmgA=
Date:   Mon, 19 Aug 2019 13:46:14 +0000
Message-ID: <20190819134608.GE5080@mellanox.com>
References: <20190814151507.140572-1-bvanassche@acm.org>
 <20190819122126.GA6509@ziepe.ca>
 <c8bf9c9e-6f4b-b3f3-2c12-72fab52f6a05@dev.mellanox.co.il>
In-Reply-To: <c8bf9c9e-6f4b-b3f3-2c12-72fab52f6a05@dev.mellanox.co.il>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YT1PR01CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::28)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f19a897d-015b-451c-291b-08d724ab9a10
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6336;
x-ms-traffictypediagnostic: VI1PR05MB6336:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB6336F5D6FC53F44E758C88AFCFA80@VI1PR05MB6336.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(199004)(189003)(7736002)(305945005)(8676002)(446003)(11346002)(14454004)(4326008)(256004)(33656002)(186003)(478600001)(229853002)(81156014)(102836004)(99286004)(66446008)(6506007)(2616005)(486006)(66946007)(25786009)(66066001)(14444005)(1076003)(6116002)(3846002)(76176011)(52116002)(6862004)(5660300002)(53936002)(26005)(71190400001)(71200400001)(476003)(6486002)(386003)(8936002)(316002)(6512007)(66476007)(6436002)(86362001)(36756003)(66556008)(53546011)(2906002)(6246003)(64756008)(81166006)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6336;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TBXtG8mBfaTnekumG2+4PIF294+5oExcNkkrLuybBwWH9gW0aIBpV2Xh3yTluysahL83CQ5EpT6pvOt07M9U5capUbHH/Vvw07gaBBLg6TixyYuXQKnjcS25DnrmLai4dDEfxqKk3oEM14s83m3VZ+mYEQGoufoHXD0b/+QKCP2FVDKHYqdMlzFnrisq7NgULcP1uJFDwh/bSxwOmP2IywibzoqZLt1M5/GLoEGOPhNi+6GSmWNJeHavLA4g/ETjjIWYuNs/x94PQtsx+hgeIMOIvh8PRg6WTC/eeT4cbxQDTLlDVq5nwzRELgLlYHBMDBhtcbV8uvtxKbnY8dYx1v8U/LqSlwugO6eIJ/ceYuAQ+fEddK6DU9VljtyvqJ9mL7tI9BCPyWnJYz81sqSkdepF5dinrQJOPpUVF/+yQ6I=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13FEFE1B99498344BA3497B76C22E5CE@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f19a897d-015b-451c-291b-08d724ab9a10
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 13:46:14.1011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vJ6TQ4f8zK3VCWVSccsJ3FzXYS94bl4lCxHcWpjzBVcmbrk9OTgx3Rs42te8VyLhwZCFHf7V28NFjsRd4IzqLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6336
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 19, 2019 at 09:40:24AM -0400, Hal Rosenstock wrote:
> On 8/19/2019 8:21 AM, Jason Gunthorpe wrote:
> > On Wed, Aug 14, 2019 at 08:15:07AM -0700, Bart Van Assche wrote:
> >> The ib_srpt driver derives its default service GUID from the node GUID
> >> of the first encountered HCA. Since that service GUID is passed to
> >> ib_cm_listen(), the AGN bits must not be set. Since the AGN bits can
> >> be set in the node GUID of RoCE HCAs, filter these bits out. This
> >> patch avoids that loading the ib_srpt driver fails as follows for the
> >> hns driver:

What is the actual problem anyhow? Is some roce GUID using the local
bits and overlapping with the IB_CM_ASSIGN_SERVICE_ID?=20

Ie generated VF MAC or something?

> >>   ib_srpt srpt_add_one(hns_0) failed.
> >>
> >> Cc: oulijun <oulijun@huawei.com>
> >> Reported-by: oulijun <oulijun@huawei.com>
> >> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> >>  drivers/infiniband/ulp/srpt/ib_srpt.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniban=
d/ulp/srpt/ib_srpt.c
> >> index e25c70a56be6..114bf8d6c82b 100644
> >> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> >> @@ -3109,7 +3109,8 @@ static void srpt_add_one(struct ib_device *devic=
e)
> >>  	srpt_use_srq(sdev, sdev->port[0].port_attrib.use_srq);
> >> =20
> >>  	if (!srpt_service_guid)
> >> -		srpt_service_guid =3D be64_to_cpu(device->node_guid);
> >> +		srpt_service_guid =3D be64_to_cpu(device->node_guid) &
> >> +			~IB_SERVICE_ID_AGN_MASK;
> >=20
> > This seems kind of sketchy, masking bits in the GUID is going to make
> > it non-unique.. Should we do this only for roce or something?
> >=20
> > Hal, do you have any insight?
>=20
> include/rdma/ib_cm.h:#define IB_SERVICE_ID_AGN_MASK
> cpu_to_be64(0xFF00000000000000ULL)
>=20
> IB_SERVICE_ID_AGN_MASK masks entire first byte of OUI which seems like
> too much to me as it contains company related bits.
>=20
> Would it work just masking the first 2 bits (local/global and X bits) ?

Maybe if we see a local GUID it should generate a random global GUID
instead.

Jason
