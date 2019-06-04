Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D19283479B
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2019 15:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfFDNGw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jun 2019 09:06:52 -0400
Received: from mail-eopbgr60066.outbound.protection.outlook.com ([40.107.6.66]:51845
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727033AbfFDNGw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Jun 2019 09:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WanoFGC/h4LOh7h5rBr8BbyJ6EfIYawm3UhUB1H5QM=;
 b=qdOY+i/Ucav2g7TfMvlWJsT8WZCX+ycDnX93Kzph6QM4doFjgEc+FVu9qHqr2HHpHnbV/emW3fFiB0+0HuWq5jB0oDcBEyS63rTiOBupH0A0bO/48bByAG0b5bntvsIF6FqbZ5ZbzJDJWTTSR3aOUosePqZKfiovyZjOMP97zmk=
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com (52.134.107.143) by
 DB7PR05MB5324.eurprd05.prod.outlook.com (20.178.42.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.18; Tue, 4 Jun 2019 13:06:47 +0000
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::599c:3c72:e7d9:e688]) by DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::599c:3c72:e7d9:e688%7]) with mapi id 15.20.1943.018; Tue, 4 Jun 2019
 13:06:47 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>,
        Gal Pressman <galpress@amazon.com>,
        Kamal Heib <kamalheib1@gmail.com>,
        Denis Drozdov <denisd@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Erez Alfasi <ereza@mellanox.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH for-next v2 4/4] IB/{core,hw}: ib_pd should not have
 ib_uobject pointer
Thread-Topic: [PATCH for-next v2 4/4] IB/{core,hw}: ib_pd should not have
 ib_uobject pointer
Thread-Index: AQHVDuF1DOqAXpFGBkqC6rsta48O16Z2SyeAgBOe1ICAAaT4gA==
Date:   Tue, 4 Jun 2019 13:06:47 +0000
Message-ID: <20190604130643.GD15534@mellanox.com>
References: <20190520075333.6002-1-shamir.rabinovitch@oracle.com>
 <20190520075333.6002-5-shamir.rabinovitch@oracle.com>
 <20190522002237.GB30833@mellanox.com>
 <20190603120000.GA31289@srabinov-laptop>
In-Reply-To: <20190603120000.GA31289@srabinov-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::30) To DB7PR05MB4138.eurprd05.prod.outlook.com
 (2603:10a6:5:18::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15eab781-59b9-4183-14f0-08d6e8ed802f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR05MB5324;
x-ms-traffictypediagnostic: DB7PR05MB5324:
x-ld-processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
x-microsoft-antispam-prvs: <DB7PR05MB5324A2A73DED7F621A676ABECF150@DB7PR05MB5324.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:923;
x-forefront-prvs: 0058ABBBC7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(396003)(39860400002)(376002)(189003)(199004)(305945005)(446003)(11346002)(386003)(6506007)(86362001)(102836004)(36756003)(99286004)(7736002)(6512007)(66066001)(486006)(2616005)(476003)(1076003)(508600001)(229853002)(54906003)(76176011)(5660300002)(316002)(3846002)(73956011)(81166006)(81156014)(66446008)(64756008)(66556008)(66476007)(52116002)(66946007)(6116002)(53936002)(8676002)(8936002)(7416002)(4326008)(2906002)(71190400001)(186003)(6436002)(26005)(14454004)(71200400001)(6486002)(256004)(33656002)(25786009)(6916009)(6246003)(68736007)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB5324;H:DB7PR05MB4138.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jFywdQ7STO0KRLUo0HyejRZNcjiIbNLQXF7pBw/b9MP4YRA+ri3sf24N/x4h819E1D8hWTQ1mXJf2MaAxl6cpc591pZV8Yms3N1hCYuwooqEGs3eFI1SJFU2XP6z0KToYnody8PCAI7q7loSiV3gh+4efZo8Y26ZSgBhiecIF9+JD17JRHtuOj00DDfnsSZZSHpVpJOwB8Fm703YexubAKU0FFyFpe4EADYCrJ1wyngcq6ZOrhGj2NfAlkD3/JGy3QEAKQkDjofoXWyouj3i0vZy2X0ataJemttaWqo4y/EuL7qoRCFJaQOeNIysEEfQsWCI3yTLirh64s3vWHr1jZla2jscwKOfZDc4zSFbBpxp+qtL+RTzqOXAUtwx8KmK850vdl5tkLwRf55d1SxAZErpDmOn5K8SDYfJE/72AVA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <82990D7B5724544CA4ECC7FB623EF686@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15eab781-59b9-4183-14f0-08d6e8ed802f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2019 13:06:47.7934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB5324
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 03, 2019 at 03:00:01PM +0300, Shamir Rabinovitch wrote:
> On Wed, May 22, 2019 at 12:22:42AM +0000, Jason Gunthorpe wrote:
> > On Mon, May 20, 2019 at 10:53:21AM +0300, Shamir Rabinovitch wrote:
> > > future patches will add the ability to share ib_pd across multiple
> > > ib_ucontext. given that, ib_pd will be pointed by 1 or more ib_uobjec=
t.
> > > thus, having ib_uobject pointer in ib_pd is incorrect.
> > >=20
> > > Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> > >  drivers/infiniband/core/uverbs_cmd.c       | 1 -
> > >  drivers/infiniband/core/verbs.c            | 1 -
> > >  drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 1 -
> > >  drivers/infiniband/hw/mlx5/main.c          | 1 -
> > >  drivers/infiniband/hw/mthca/mthca_qp.c     | 3 ++-
> > >  include/rdma/ib_verbs.h                    | 1 -
> > >  6 files changed, 2 insertions(+), 6 deletions(-)
> >=20
> > Please remove the uobject from the mr as well, those are the two
> > objects I want to see be sharable to start.
> >=20
> > Jason
>=20
> Jason would it be OK to progress with PD first and later come back to
> MR?

Ok

Jason
