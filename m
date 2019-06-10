Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB8103B8D6
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 18:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389928AbfFJQDC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jun 2019 12:03:02 -0400
Received: from mail-eopbgr130074.outbound.protection.outlook.com ([40.107.13.74]:43074
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389356AbfFJQDB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jun 2019 12:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=450d2MXVWodpENJheLwYn0Z7xWvqO7wr3qF4QWDO8sY=;
 b=kctyDxIfUDvoSeIPOePSVT3oHbQ3/3dDtOXCbB4D4/GE+Nai0EpzR0b+7w2Lgude1EulJskY2cIwuXFF5tBkBX5EUAVcsM+IjNX+2gkqkFTUIYjaLSkHD08hPwPRVxDe/K2VxSMq0wfuqMKyZmCVusOGejBp6nJo+eIvS0Izl14=
Received: from AM0PR05MB4130.eurprd05.prod.outlook.com (52.134.90.143) by
 AM0PR05MB4387.eurprd05.prod.outlook.com (52.134.93.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.13; Mon, 10 Jun 2019 16:02:56 +0000
Received: from AM0PR05MB4130.eurprd05.prod.outlook.com
 ([fe80::4825:8958:8055:def7]) by AM0PR05MB4130.eurprd05.prod.outlook.com
 ([fe80::4825:8958:8055:def7%3]) with mapi id 15.20.1965.017; Mon, 10 Jun 2019
 16:02:56 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 hmm 11/11] mm/hmm: Remove confusing comment and logic
 from hmm_release
Thread-Topic: [PATCH v2 hmm 11/11] mm/hmm: Remove confusing comment and logic
 from hmm_release
Thread-Index: AQHVHJft+otwZ8rUPEekfSi3CzR0ZqaQuR+AgARZmwA=
Date:   Mon, 10 Jun 2019 16:02:56 +0000
Message-ID: <20190610160252.GH18446@mellanox.com>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-12-jgg@ziepe.ca>
 <61ea869d-43d2-d1e5-dc00-cf5e3e139169@nvidia.com>
In-Reply-To: <61ea869d-43d2-d1e5-dc00-cf5e3e139169@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::34) To AM0PR05MB4130.eurprd05.prod.outlook.com
 (2603:10a6:208:57::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0456bf9-5aef-4511-cd81-08d6edbd19d8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR05MB4387;
x-ms-traffictypediagnostic: AM0PR05MB4387:
x-microsoft-antispam-prvs: <AM0PR05MB4387F54CE3B8303BBA27A817CF130@AM0PR05MB4387.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(396003)(39860400002)(376002)(189003)(199004)(316002)(25786009)(2616005)(476003)(486006)(99286004)(76176011)(4326008)(66066001)(478600001)(52116002)(36756003)(11346002)(446003)(66946007)(186003)(6512007)(66476007)(26005)(6486002)(229853002)(66446008)(64756008)(386003)(6506007)(66556008)(53936002)(53546011)(102836004)(73956011)(68736007)(54906003)(6916009)(6436002)(305945005)(256004)(81166006)(7736002)(8936002)(2906002)(8676002)(81156014)(6246003)(71190400001)(71200400001)(6116002)(3846002)(86362001)(33656002)(1076003)(5660300002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4387;H:AM0PR05MB4130.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /XoWWl7DXZHkqt6HlSb0h/i3876cDXvgZJD7FRjHmDVQJC4j32FplncqgEl42kFVAZ21UO5yMzo+9aUjSa9MzSgERb4OdeF6NABWEWh/jDwuKvVK5u/M4s5Jh9QycDt00d5E7+4den8XeFui3NEzowflwyR0J7EMuzZlxv5H9SmfVBxXX7y3lRhXvxpQn7DsMvL6VWpVEFYQW/btyyTiGbNTEtZaIh9f7hOdCPkcydvKezjQzAkH6VVR6f4JWrfhZYjFEUE+7O6hLsAscYlbEhtitIzT5oEE9f3RQY3LfF2dRIt1hw5pX2pz7fpHYZQHrCg+AKpe6DI+ZcMrc/SDd497dYSniuK4axUed942M+cEUsmmB90jlgxxYQus0vGmdJULi6YnrC0pX08C3xggWhmm2Ii4hZwucXEF5wcBoPg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8C3BE8F336B51E4C8608A9C4C971BE76@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0456bf9-5aef-4511-cd81-08d6edbd19d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 16:02:56.0642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4387
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 07, 2019 at 02:37:07PM -0700, Ralph Campbell wrote:
>=20
> On 6/6/19 11:44 AM, Jason Gunthorpe wrote:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> >=20
> > hmm_release() is called exactly once per hmm. ops->release() cannot
> > accidentally trigger any action that would recurse back onto
> > hmm->mirrors_sem.
> >=20
> > This fixes a use after-free race of the form:
> >=20
> >         CPU0                                   CPU1
> >                                             hmm_release()
> >                                               up_write(&hmm->mirrors_se=
m);
> >   hmm_mirror_unregister(mirror)
> >    down_write(&hmm->mirrors_sem);
> >    up_write(&hmm->mirrors_sem);
> >    kfree(mirror)
> >                                               mirror->ops->release(mirr=
or)
> >=20
> > The only user we have today for ops->release is an empty function, so t=
his
> > is unambiguously safe.
> >=20
> > As a consequence of plugging this race drivers are not allowed to
> > register/unregister mirrors from within a release op.
> >=20
> > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
>=20
> I agree with the analysis above but I'm not sure that release() will
> always be an empty function. It might be more efficient to write back
> all data migrated to a device "in one pass" instead of relying
> on unmap_vmas() calling hmm_start_range_invalidate() per VMA.

I think we have to focus on the *current* kernel - and we have two
users of release, nouveau_svm.c is empty and amdgpu_mn.c does
schedule_work() - so I believe we should go ahead with this simple
solution to the actual race today that both of those will suffer from.

If we find a need for a more complex version then it can be debated
and justified with proper context...

Ok?

Jason
