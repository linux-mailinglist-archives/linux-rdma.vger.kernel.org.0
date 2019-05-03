Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA2D5135DC
	for <lists+linux-rdma@lfdr.de>; Sat,  4 May 2019 00:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbfECWtu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 May 2019 18:49:50 -0400
Received: from mail-eopbgr130078.outbound.protection.outlook.com ([40.107.13.78]:54334
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726509AbfECWtu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 3 May 2019 18:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fehmT1d3+g4vjFSYiRvjOvbmjLeLYbJvvNN8zh4mxek=;
 b=UpM8s97zICM/rhrlTMQWtPHWtWyKdJCJE7h6FqTLCGxYIxAHeLCnQkVaBz4X4+EZ8XXQPYF/N8Qeux6l2bUGrdxh+6zswwv1fVaoxfahUsU9ZYwTtA5TNM8jG12WYkqKOXoXb3vTFwIhZ8b9rjWtzpz/PtmK1ZeHO61FmF9IzSU=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5213.eurprd05.prod.outlook.com (20.178.12.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.15; Fri, 3 May 2019 22:49:46 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1856.008; Fri, 3 May 2019
 22:49:46 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH for-next v1 1/4] RDMA/uverbs: initialize
 uverbs_attr_bundle ucontext in ib_uverbs_get_context
Thread-Topic: [PATCH for-next v1 1/4] RDMA/uverbs: initialize
 uverbs_attr_bundle ucontext in ib_uverbs_get_context
Thread-Index: AQHVAgKBCE7HtjCa8UCiWemCif6ekw==
Date:   Fri, 3 May 2019 22:49:46 +0000
Message-ID: <20190503131329.GA18325@mellanox.com>
References: <20190430142333.31063-1-shamir.rabinovitch@oracle.com>
 <20190430142333.31063-2-shamir.rabinovitch@oracle.com>
In-Reply-To: <20190430142333.31063-2-shamir.rabinovitch@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:2d::40) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [65.119.211.164]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ca280cf-00aa-4804-4242-08d6d019a3bc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5213;
x-ms-traffictypediagnostic: VI1PR05MB5213:
x-microsoft-antispam-prvs: <VI1PR05MB5213D621092C7C0C0964754ECF350@VI1PR05MB5213.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0026334A56
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(396003)(136003)(376002)(199004)(189003)(256004)(6116002)(3846002)(99286004)(33656002)(66066001)(68736007)(305945005)(6916009)(53936002)(6512007)(66446008)(64756008)(66556008)(66476007)(73956011)(1076003)(4326008)(6246003)(107886003)(14454004)(25786009)(66946007)(26005)(7736002)(81156014)(8676002)(71200400001)(81166006)(71190400001)(86362001)(6436002)(76176011)(186003)(2906002)(476003)(102836004)(486006)(2616005)(11346002)(52116002)(446003)(8936002)(54906003)(316002)(4744005)(229853002)(6506007)(386003)(478600001)(6486002)(5660300002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5213;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p3JAZMs+Z8CpYNjlAj+XDC8xn38E0YHS30W0Ftm50Yz9lKIb0cjzZ1589LmPqm1hHfZNyXrNbge0319DzoC3NJ7qSVOWfIpBlnRxxq7vR7GiZFEkc2dwuRxM3d0xQJterVLC4yslhNyVOlT8wxcA8a55U9x+hs+OoWMOODGNpAg208wO/6fxuzAzrC0q93KkORFvKIlDZQMJtbQBo4tXvqdZ1i9p1k6L8VB4X4PeK5Ux5fa/QN6K16MCezjJ8g6a2bECsdMC4XQfD8yjQaBhMuWFdNr0vNQJ8WlVWcfHvAxtbFJZNmHiPcMx/6OWJttYuZFGHJvvWu/RLYiHyt6U9lhnFHM2i7gfok5vZuEk4LqwxnlccXPfBkgBzMJRKxUB04BvtFQWMnkQVapuzy+RU1y9ymXuv8ko47mK6gfL6Bs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1D9F0F7091CF254198EAC9C2696215CC@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca280cf-00aa-4804-4242-08d6d019a3bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2019 22:49:46.8944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5213
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 30, 2019 at 05:23:21PM +0300, Shamir Rabinovitch wrote:
> ib_uverbs_get_context does not have uobject so it does not call the
> rdma_lookup_get_uobject which is used to set up the uverbs_attr_bundle
> ucontext. for ib_uverbs_get_context we need to set up this manually
> before we send the uverbs_attr_bundle down to the driver layer.
>=20
> this complete the change that was done in
> ("70f06b26f07e IB: ucontext should be set properly for all cmd & ioctl pa=
ths")
>=20
> Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> ---
>  drivers/infiniband/core/uverbs_cmd.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to for-next

Thanks,
Jason
