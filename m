Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC6268F5BB
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Aug 2019 22:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731963AbfHOU0Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Aug 2019 16:26:24 -0400
Received: from mail-eopbgr40056.outbound.protection.outlook.com ([40.107.4.56]:50049
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731850AbfHOU0X (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Aug 2019 16:26:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUpJ+UlwqNgRqGHELoHIeW/U4VAlGy7J4s1KxewDpqBAfMoOQzWpYBEYjMGSyK185V9JIwfLwF0C6o5tmdDwFf5wR0vusjJbGE+SuYqTqAYNnlyKzeF1WjLYjOUyfKR9wR3kORigmFZ47Mqvkc9v6uIAcdmt2RDpqBTZNll053njXNrn0XlO6B+zWMSYKIxxyQEcCCcomt8bk8oj4GyWiyvam74z9+T0XvhSDlgpB+RDpLiKquL5LbLmZhuc76+sYlZxPLiWSzJbD4rMleb4b/HkiVC9FahmDWGUYIlcev2UyVwHnYt0ZjfwWzRwp+XUNbNT8sd1mSP+X/6doHQgPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Lmwq4ctt1OvxMmYpzSxlvmO5aifUEaILaNRW32iR40=;
 b=G7n5NN7gyLkwoDEPXOMiEA+f/MAaXv1HFsekXnzDdBut5yhbxnI584vS1fO8rQvlzOQ2ZNiGQGaBoEfbhIGFoA/TbYk/6Ynz6gLZwPp+bR+TJ7811RYTdJkeFABNRPSfKxF+ngdWQ7JRMRbfC7gX1SwhNYCMm4vURW9uq50gKsivYi6eF118wU1OXMt8zDyuQ1oPH3DSEz+SZSvbh1Jl5bjwYB+NvtSC+QdH4tEFw7Z2oeQd+WqLumZc/CFBy16fz3ICkdQiBDITmCHa8nyx2Bzkhso3yRQqNxMQrRCwhye/EajCyb76URDH3V4TwZott0DCtnaB9150Ut4Eo7oB8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Lmwq4ctt1OvxMmYpzSxlvmO5aifUEaILaNRW32iR40=;
 b=CfeqTpEesuGLwQlE1vKAM6yMt/e8waGeVF5gFV3Psnlbh3hQF0yvkgPiEtKNmO4s2zDm467ouH55c1dLLj7wdEk0lhnZfcHxOCvdPl59iIlhWt2mhkl/ekHrvW+lhlk1M6BUOnxtEO6pXdkuVimBrkHHZ7E24p8I4KBHbg9+RgU=
Received: from AM0PR05MB5331.eurprd05.prod.outlook.com (20.178.16.25) by
 AM0PR05MB6529.eurprd05.prod.outlook.com (20.179.35.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Thu, 15 Aug 2019 20:26:19 +0000
Received: from AM0PR05MB5331.eurprd05.prod.outlook.com
 ([fe80::1d05:2252:6ace:70fd]) by AM0PR05MB5331.eurprd05.prod.outlook.com
 ([fe80::1d05:2252:6ace:70fd%6]) with mapi id 15.20.2178.016; Thu, 15 Aug 2019
 20:26:19 +0000
From:   "Guy Levi(SW)" <guyle@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Moni Shoua <monis@mellanox.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Ido Kalir <idok@mellanox.com>,
        Majd Dibbiny <majd@mellanox.com>,
        Mark Zhang <markz@mellanox.com>
Subject: RE: [PATCH rdma-rc 0/8] Fixes for v5.3
Thread-Topic: [PATCH rdma-rc 0/8] Fixes for v5.3
Thread-Index: AQHVU0TY5bq7GiGYXE2a5M1bGzk0Iqb8mQyAgAAOFHA=
Date:   Thu, 15 Aug 2019 20:26:19 +0000
Message-ID: <AM0PR05MB53310C7255ABD0333FA3387AC7AC0@AM0PR05MB5331.eurprd05.prod.outlook.com>
References: <20190815083834.9245-1-leon@kernel.org>
 <20190815192940.GS21596@ziepe.ca>
In-Reply-To: <20190815192940.GS21596@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=guyle@mellanox.com; 
x-originating-ip: [2a00:a040:19a:e326:4cf0:180f:5ece:fd05]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3fab805d-945f-4ee7-8f9b-08d721bed509
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR05MB6529;
x-ms-traffictypediagnostic: AM0PR05MB6529:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB6529A393237330FF720B4638C7AC0@AM0PR05MB6529.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 01304918F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(199004)(189003)(13464003)(110136005)(486006)(476003)(66556008)(6436002)(14444005)(229853002)(256004)(6636002)(14454004)(8936002)(5660300002)(71190400001)(54906003)(66476007)(66446008)(11346002)(64756008)(478600001)(71200400001)(316002)(446003)(81156014)(2906002)(6246003)(76176011)(7696005)(7736002)(81166006)(53936002)(6506007)(76116006)(107886003)(99286004)(33656002)(8676002)(86362001)(46003)(66946007)(53546011)(74316002)(102836004)(9686003)(52536014)(4326008)(186003)(305945005)(25786009)(6116002)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB6529;H:AM0PR05MB5331.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: D2ODWG3OFgMOA3q/kor/uCCqsppxZHAjl5zLlOa4C6FeJu/TlvZ7hy/mbRrCp8qAKaC3Zu5NjVHXbvIr/xWpypShITNdCbceLA7Dtv++oDTtojHwDQ+LNx4OB117BDWQw4qufGYytEHozD0m7rmHgtzNoe3nOHl/JwDu+/YsoCQB/UE5eMTMQnvrhX7hXaFXi25BldL6KIxykMpKBcDOrHQZ7La+rsD8nITiauy4zOaTqIJdnRi5emyEnJsB17A39boDFJGAlrPCfgS5DYkUY9jsHep33qgg8Uu17HhDO6LoSIS0w5wZZ1lxoqHPzvniNujnBRjV4gDNeniOT6qLNzYnZeccAucM6y/wv336vlx9JNmHagWv10vqi1O+hvc+IEV8pXo0ymSht83Bds8Vd5nlNEY7YiEW+WhDGI/30Xk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fab805d-945f-4ee7-8f9b-08d721bed509
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2019 20:26:19.6191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /1NnWXMJwJSQRBt15aMEbtmJOIRnUlQMYNyD8ryJ5JtRyzB+bL+1+acMup2tOR+xMBqg42hMGf0v5ggsCn/nqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6529
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe <jgg@mellanox.com>
> Sent: Thursday, August 15, 2019 10:30 PM
> To: Leon Romanovsky <leon@kernel.org>; Moni Shoua
> <monis@mellanox.com>
> Cc: Doug Ledford <dledford@redhat.com>; Leon Romanovsky
> <leonro@mellanox.com>; RDMA mailing list <linux-rdma@vger.kernel.org>;
> Guy Levi(SW) <guyle@mellanox.com>; Ido Kalir <idok@mellanox.com>; Majd
> Dibbiny <majd@mellanox.com>; Mark Zhang <markz@mellanox.com>
> Subject: Re: [PATCH rdma-rc 0/8] Fixes for v5.3
>=20
> On Thu, Aug 15, 2019 at 11:38:26AM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Hi,
> >
> > This is a collection of new fixes for v5.3, everything here is fixing
> > kernel crash or visible bug with one exception: patch #5 "IB/mlx5:
> > Consolidate use_umr checks into single function". That patch is nice
> > to have improvement to implement rest of the series.
> >
> > Thanks
> >
> > Ido Kalir (1):
> >   IB/core: Fix NULL pointer dereference when bind QP to counter
> >
> > Jason Gunthorpe (1):
> >   RDMA/mlx5: Fix MR npages calculation for IB_ACCESS_HUGETLB
> >
> > Leon Romanovsky (2):
> >   RDMA/counters: Properly implement PID checks
> >   RDMA/restrack: Rewrite PID namespace check to be reliable
> >
> > Moni Shoua (4):
> >   IB/mlx5: Consolidate use_umr checks into single function
> >   IB/mlx5: Report and handle ODP support properly
> >   IB/mlx5: Fix MR re-registration flow to use UMR properly
> >   IB/mlx5: Block MR WR if UMR is not possible
>=20
> I'm a little murky on what thes are fixing? Moni?

See original fixed patch.
Sometime the HW device disables some UMR abilities and hence driver should =
avoid UMR usage in some cases. This HW behavior can be seen today in Linux@=
windows environment with "untrusted VF".

>=20
> Jason
