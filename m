Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2953F75382
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2019 18:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388766AbfGYQFG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jul 2019 12:05:06 -0400
Received: from mail-eopbgr40061.outbound.protection.outlook.com ([40.107.4.61]:7041
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388481AbfGYQFF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Jul 2019 12:05:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3RRyLg6GO5EekYyxO5nT5Uf2A3XhGl6sgwl7J0U+XLFxcuRrnBxKT/2F4jM08KFHQq3pL/337b4KZGk5WdtVylan7czD3qW4IiexLMqpQY/FM9O76DHt9y5pDx3pDG066vHzDl4pzJ34kjsb6hC4Q3VZ0Yct53ygJDjajPCM/xrTqOwBT7w+wC9/atRU23rhTsMyFL60MFBQBW47nXR14NuTS8x7M2CqlrYa/U67X+VtDkACaFfuBv1/2wggYcaUGlriTaJkVw/aBIFpUgmxB6JWG/yhCUi8nxsRz7DuKe/9LUxJAXMu8slegL8ob2WMqOlUqjsoZviUUQTDUikHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orx/TFEreh+WLgtiUlydslgxHQNXsSzfm4gn0jpXEjc=;
 b=aZdv/jH245PKpI+Yzr4NvcKdjGD8fP9cVrMh2VaOH9zM2NmNq1sjo4fSSr/f7RzrxCc+fJeZxuNVlPOek3rzVkEgt+fDh8ux23J4okWJWDPI2EQ7kOYP9pInOMlOJc5mJDtBitjsG093pZ9sBavWxUwA9ZlI+Mx4vRBtROFRCr2ZSqA6+QZ14x9M10lPYeVp50evamAAy/sGkqCbPnjovC2EKCGGcPHpIvN7igARUQsbzlvLbLq12y6at5kgwqNk+GkvQN5jjklxetsCzF5dg/PofFM/YOsfH1zZaINKuysm/Oi6MfTr4u5zmllkeFGY88ZiFz10k40HK57oOQoxww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orx/TFEreh+WLgtiUlydslgxHQNXsSzfm4gn0jpXEjc=;
 b=brpR6Az0K9GeLh9nt689rVbYGq83nPP7CQSM+kU2WtQqaarmttsUEmqaSbrMEgHnWKM8QevzGyPBCLRVXYiPVDZY8cd9DCAkJYcRTK1XkfG0jS7FnzRALlMknqDrnsZJ998AankXuixYuq3J/5ag9HHPtvMZt+AA1MOnng/E5RQ=
Received: from DB7PR05MB4876.eurprd05.prod.outlook.com (20.176.235.96) by
 DB7PR05MB5146.eurprd05.prod.outlook.com (20.178.41.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Thu, 25 Jul 2019 16:05:00 +0000
Received: from DB7PR05MB4876.eurprd05.prod.outlook.com
 ([fe80::99d2:2fab:65f:c909]) by DB7PR05MB4876.eurprd05.prod.outlook.com
 ([fe80::99d2:2fab:65f:c909%5]) with mapi id 15.20.2094.013; Thu, 25 Jul 2019
 16:05:00 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Alex Vainman <alexv@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Haggai Eran <haggaie@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Sagi Grimberg <sagig@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: RE: [PATCH rdma-rc 00/10] Collection of fixes for 5.3
Thread-Topic: [PATCH rdma-rc 00/10] Collection of fixes for 5.3
Thread-Index: AQHVQSPtRhD6byYB7kytqcfGLH82XKbbdKgAgAAOWHA=
Date:   Thu, 25 Jul 2019 16:05:00 +0000
Message-ID: <DB7PR05MB48769771EF822D5095AA733CD1C10@DB7PR05MB4876.eurprd05.prod.outlook.com>
References: <20190723065733.4899-1-leon@kernel.org>
 <20190725151310.GA24809@ziepe.ca>
In-Reply-To: <20190725151310.GA24809@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [49.207.55.248]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22fad025-5759-4edc-d017-08d71119d8a3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR05MB5146;
x-ms-traffictypediagnostic: DB7PR05MB5146:
x-microsoft-antispam-prvs: <DB7PR05MB51463BB8F92C3087079F2F76D1C10@DB7PR05MB5146.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:595;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(13464003)(189003)(199004)(316002)(26005)(55236004)(9686003)(110136005)(7736002)(99286004)(11346002)(53936002)(53546011)(74316002)(7696005)(305945005)(66066001)(6506007)(102836004)(107886003)(55016002)(68736007)(54906003)(486006)(186003)(446003)(76116006)(6246003)(66946007)(4326008)(66476007)(81156014)(81166006)(66556008)(33656002)(66446008)(8936002)(476003)(14444005)(64756008)(8676002)(76176011)(256004)(3846002)(52536014)(71190400001)(71200400001)(6116002)(5660300002)(229853002)(86362001)(478600001)(14454004)(2906002)(6436002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB5146;H:DB7PR05MB4876.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hmS+xrOuhPxbcWk2UDjYOyEBCRv061wcKbc3/ynJXpeoS9ApdGCZADzPHAWfwBkG/WpU82ctT1kqCWiV10AkFUVUJ3/uX+GiLuMI5Hy/9rThW2pDVb5Mb3AZ629EoxCFw9uasUEwqQgh4CsSgN/FFcKo6gJO6mqPzBdz4mJjl/cAoyav+cEJ+SO/+FWA/Dree3fdMxBWlxJBQgbazAxtOknjamammco80V1YDzpCF/DP5JU0tjPBi665snC0nZmQFriFxLw+gk8qWVQ+rPCT7RSfVbJFhSyCoO0/FtBMXg6bWJvVEi0pWlhH+zuXkaH0pnGTiyrbbTF670EgQXhYILPBg7mQToxdUjmEbRH/RJ1LR3qd5mRshamXGViZ4JNknDXuGF80/rv8R33Al3aBK4+WG/mNbHRdUZb0eivmFAY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22fad025-5759-4edc-d017-08d71119d8a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 16:05:00.0884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: parav@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB5146
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Thursday, July 25, 2019 8:43 PM
> To: Leon Romanovsky <leon@kernel.org>
> Cc: Doug Ledford <dledford@redhat.com>; Leon Romanovsky
> <leonro@mellanox.com>; RDMA mailing list <linux-rdma@vger.kernel.org>;
> Alex Vainman <alexv@mellanox.com>; Artemy Kovalyov
> <artemyko@mellanox.com>; Daniel Jurgens <danielj@mellanox.com>; Eli
> Cohen <eli@mellanox.com>; Haggai Eran <haggaie@mellanox.com>; Mark
> Zhang <markz@mellanox.com>; Moni Shoua <monis@mellanox.com>; Parav
> Pandit <parav@mellanox.com>; Sagi Grimberg <sagig@mellanox.com>; Yishai
> Hadas <yishaih@mellanox.com>
> Subject: Re: [PATCH rdma-rc 00/10] Collection of fixes for 5.3
>=20
> On Tue, Jul 23, 2019 at 09:57:23AM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Hi,
> >
> > This is small patch set of fixes targeted for 5.3 and stable@.
> >
> > Thanks
> >
> > Moni Shoua (1):
> >   IB/mlx5: Prevent concurrent MR updates during invalidation
> >
> > Parav Pandit (4):
> >   IB/core: Fix querying total rdma stats
> >   IB/counters: Initialize port counter and annotate mutex_destroy
> >
> > Yishai Hadas (5):
> >   IB/mlx5: Fix unreg_umr to ignore the mkey state
> >   IB/mlx5: Use direct mkey destroy command upon UMR unreg failure
> >   IB/mlx5: Fix unreg_umr to set a device PD
> >   IB/mlx5: Fix clean_mr() to work in the expected order
> >   IB/mlx5: Fix RSS Toeplitz function to be specification aligned
>=20
> I took the above for for-rc
>=20
> >   IB/mlx5: Avoid unnecessary typecast
> >   RDMA/core: Annotate destroy of mutex to ensure that it is released as
> >     unlocked
>=20
> These are not really -rc patches, I took them to for-next
>=20
Thank you Jason.
