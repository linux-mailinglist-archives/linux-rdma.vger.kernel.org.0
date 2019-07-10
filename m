Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91F5064B0E
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2019 18:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfGJQ6U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jul 2019 12:58:20 -0400
Received: from mail-eopbgr50064.outbound.protection.outlook.com ([40.107.5.64]:44252
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727382AbfGJQ6U (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 10 Jul 2019 12:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0m6yUFOKOqoGyRcM8xOVjgI4hx3oHZIYc5m952pjYE=;
 b=QUOBkhuZ0HxL6SsRmIoQ+NPgwiSFdlZS0buiOwbkuII6blSUbjGqtJyUtR8ppxWZeYpPyUXv1N0aKtmbsKfdizZAcYc8ydomIQm3udJeTde9NIfVdaM46vT1tbwS+eHnsqhYDBiM0MTldJTfAIcxZc5CUySskwZAUVk7N9c56JU=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB3152.eurprd05.prod.outlook.com (10.170.237.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.20; Wed, 10 Jul 2019 16:58:16 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2052.020; Wed, 10 Jul 2019
 16:58:16 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "Arumugam, Kamenee" <kamenee.arumugam@intel.com>,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>,
        Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] [net-next] IB/hfi1: removed shadowed 'err' variable
Thread-Topic: [PATCH] [net-next] IB/hfi1: removed shadowed 'err' variable
Thread-Index: AQHVNyCL8gWLq33pp0CVlUvl0SDSG6bEEgqAgAABBQA=
Date:   Wed, 10 Jul 2019 16:58:16 +0000
Message-ID: <20190710165812.GK2887@mellanox.com>
References: <20190710130802.1878874-1-arnd@arndb.de>
 <32E1700B9017364D9B60AED9960492BC70E0B90C@fmsmsx120.amr.corp.intel.com>
In-Reply-To: <32E1700B9017364D9B60AED9960492BC70E0B90C@fmsmsx120.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR10CA0012.namprd10.prod.outlook.com
 (2603:10b6:208:120::25) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ca153bf-a58c-409c-2793-08d70557cd38
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB3152;
x-ms-traffictypediagnostic: VI1PR05MB3152:
x-microsoft-antispam-prvs: <VI1PR05MB3152D270FB41D93D84415892CFF00@VI1PR05MB3152.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(189003)(199004)(3846002)(478600001)(305945005)(8676002)(6116002)(4744005)(7736002)(71200400001)(36756003)(14454004)(5660300002)(66066001)(1076003)(256004)(71190400001)(6916009)(66556008)(66476007)(66446008)(66946007)(6486002)(52116002)(476003)(6512007)(81156014)(229853002)(2906002)(102836004)(6506007)(386003)(8936002)(81166006)(53936002)(186003)(6246003)(7416002)(4326008)(6436002)(54906003)(316002)(68736007)(25786009)(99286004)(11346002)(446003)(76176011)(33656002)(26005)(2616005)(64756008)(486006)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3152;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: swVU5bi1dgly2kkI6qO1uGM4LQWT2VRc6oklILB9dvZSZiUfkKTvVfdHXuZiGpU9yAYWSA23crMNtrKNWbrT6AmLEtnBiyNQxzr3NT4n25ef88ZlAeKMZSwope7W3ywX2WqrsOHk86qMMcv1mCQ8yWXP8IsumKv0OBlI4W892ZtMGSYBgzUDSSM5TZGBbhTCRcUvNOyNj98SdwGTV8mGhXV/APFYrNBWG8KQulaodZGUI6/3TgLT1EjQWcvGopFO72Yuyw3OpgFYjmxQ/+HELEZmUtgG+wiBRFR6NedKJBAHQD2mR+kS975EhBO2MiuaZQMZBKvVVGVuOf9MDPqNTJ94+r6SZyjLWjCukSkv/E6Ht7go7opM4/4grgw1+8ajAtwG8vMkkUv/KgAL1YjClQcxZ3GxNCKuHpdb2I4+CrE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3D54867C670E644EA7BE2CB5090D2E5E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca153bf-a58c-409c-2793-08d70557cd38
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 16:58:16.0686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3152
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 10, 2019 at 04:54:33PM +0000, Marciniszyn, Mike wrote:
> > Subject: [PATCH] [net-next] IB/hfi1: removed shadowed 'err' variable
> >=20
> > I can't think of any reason for the inner variable declaration, so
> > remove it to avoid the issue.
> >=20
>=20
> I agree!
>=20
> > Fixes: 239b0e52d8aa ("IB/hfi1: Move rvt_cq_wc struct into uapi director=
y")
>=20
> Thanks for catching this!
>=20
> Acked-by: Mike Marciniszyn <mike.marciniszyn@intel.com>

Thanks, I'm going to take Nathan's identical patch though, it arrived
first

Jason
