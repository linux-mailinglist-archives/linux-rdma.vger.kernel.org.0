Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68C33E3C87
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 21:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390861AbfJXTyB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 15:54:01 -0400
Received: from mail-eopbgr60072.outbound.protection.outlook.com ([40.107.6.72]:8934
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390431AbfJXTyB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Oct 2019 15:54:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJW+ygt+/ikcI+Na4oEQDjMBfxnKWKG84yFcIKLyts55Bs02Y9zBQ4LUT/TGoievlNu4Kgt4sELWhEpcsJv0Jb9E+ZE4V7o0u+VW81o1AX2oQC/Fbdqp4kDZei1z1t77KEljUj3/lTlwGBFNenmEuueV5JT+cI6HuKFB3PJL3kelavbM34S0icLu4sYb8vrlTgm+3564+qghnXigZPpkJ2Ans20IFIMFmhCYxEINcZ8Dr/w4ubM8PibvcjcskvMVS/UZTbF1xQ8Sx42lDGNzjz0FHAFk1xpZdsxpA0h6vke0jaQoJNsmUnIqI9MhEzANToTkynO1DbuZ3cgZI4FDfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMhAVs9fqwmIsufoG4TeTo3Fw2MzqJ1AICnT/hPj73U=;
 b=VqPT6VnlpwUKSZ+M98xdnr5LxYRWfeMMZ10bVMbeTySym74wKKe2wNI/meK0zSJVUws8tqMLj62m7FxRW0v9yCEjz2LIvAgF9LaPqpSv1Yux3s+lTTBXBMZXWJmRzRvXJFW7vbbji4aRtFqXEWQKJjdUcZv5XRV4oVdQ7EvQpiL30lLdAhrCHWg6OSi6NF4/Y+n5tiuSNLH+vNdk6CxkJLGy+lsjmiFVTWTuJFHy9N3gi8HtwdwqlbVUQF9lp8lj5duLmdoUCGx4R8INEtmzgFERRUCAJJelALKzCtDL95e2r8Y9ZW3tM4NKM3m0gDClD50wBj4OVz7RbYFTDG1iBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMhAVs9fqwmIsufoG4TeTo3Fw2MzqJ1AICnT/hPj73U=;
 b=IXDwrRP1qEdEQa74KGqn4Suk8Ev5ojQBtN3ALze3F7ehj/eWLUnw0pRa3hG6gssCJ5quN3Hz+iGTcuRBe9hub58pQerr3wgkupJZ9oelZrM7fv2CIJGQSnDZQjj2PvZzdhZt1mzjjD9EXXAWPqyovoqTuCIYL8wHm31jNYuMGwg=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB6115.eurprd05.prod.outlook.com (20.178.202.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Thu, 24 Oct 2019 19:53:56 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::64b2:6eb4:f000:3432]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::64b2:6eb4:f000:3432%7]) with mapi id 15.20.2387.019; Thu, 24 Oct 2019
 19:53:56 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH rdma-next] IB/core: Avoid deadlock during netlink message
 handling
Thread-Topic: [PATCH rdma-next] IB/core: Avoid deadlock during netlink message
 handling
Thread-Index: AQHVgy+dqbhYCwPdVkCqZeGqtQCivqdp1HaAgAACWYCAAAbBgIAAJQsAgAABewCAAAFggIAAJH1AgAADn4CAAAwNgIAABcYQ
Date:   Thu, 24 Oct 2019 19:53:56 +0000
Message-ID: <AM0PR05MB4866CA70E3711F8BE19F294ED16A0@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <20191015080733.18625-1-leon@kernel.org>
 <20191024131743.GA24174@ziepe.ca> <20191024132607.GR4853@unreal>
 <20191024135017.GT23952@ziepe.ca> <20191024160252.GS4853@unreal>
 <20191024160810.GV23952@ziepe.ca> <20191024161305.GU4853@unreal>
 <AM0PR05MB4866029667184FC06C427E3BD16A0@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <20191024183639.GA23952@ziepe.ca> <20191024191947.GV4853@unreal>
In-Reply-To: <20191024191947.GV4853@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d5553283-3a0a-4cab-d9b8-08d758bbe7b6
x-ms-traffictypediagnostic: AM0PR05MB6115:
x-microsoft-antispam-prvs: <AM0PR05MB611512F6320419CB11B165D2D16A0@AM0PR05MB6115.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(13464003)(189003)(199004)(2906002)(8936002)(486006)(99286004)(476003)(52536014)(11346002)(446003)(8676002)(9686003)(66476007)(64756008)(66556008)(55016002)(86362001)(71190400001)(71200400001)(6246003)(33656002)(66946007)(25786009)(76116006)(66446008)(15650500001)(81156014)(81166006)(76176011)(6436002)(6506007)(14454004)(53546011)(3846002)(7736002)(305945005)(316002)(54906003)(229853002)(66066001)(7696005)(5660300002)(6116002)(110136005)(74316002)(14444005)(478600001)(186003)(256004)(4326008)(26005)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB6115;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: obtk5U6ai1C7qVYGR26lPWeheHIVcRMXw0roV7iAmBKExpweZQbmxueaZ1htpC8JTPQskWRoBqFyqZ7YfIGfQOQTIvX7T3X3WnoqWHkTTRAcPem0GxfW0MMKp4IVHLqnFK67szgAP1KKZ2qlLzHwf1qE3Nw12Fhgc/vWosPrqIHGqPpez+aB0t9jCSmK9K4zPi1jNdW/5mBI3aQpoC6SUumxSnssL97p1wmJpDwlmlwIpiAAid7PW79Q3GMZLbqCMpibTS/i8QkHzjOMvzthg9ee+sH0KQ9+y1kK83U1uyJk6+yBjxxxRdnXhJ0/xyMD8/f4K6io1p4DdMKoVXiaXAKz+2MkE7uPT+udYPCa1fBQWQlQqB6fAHwktZ4q9VirZCBzhkieujuskBrbHwARM4obNrXbnjIUjcwJ9Iy7qpgyYHW/0QN7s53rtf2v0RhY
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5553283-3a0a-4cab-d9b8-08d758bbe7b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 19:53:56.5273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O6hszQMTJ4dlRQERhIJBJn5D6VjD7xJfTRN4TEczUjeC6UzPxEnJEYVvkGFU6EI37+Ww3cpz9MkMGRZIcyskwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6115
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Thursday, October 24, 2019 2:20 PM
> To: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Parav Pandit <parav@mellanox.com>; Doug Ledford
> <dledford@redhat.com>; RDMA mailing list <linux-rdma@vger.kernel.org>
> Subject: Re: [PATCH rdma-next] IB/core: Avoid deadlock during netlink mes=
sage
> handling
>=20
> On Thu, Oct 24, 2019 at 03:36:39PM -0300, Jason Gunthorpe wrote:
> > On Thu, Oct 24, 2019 at 06:28:35PM +0000, Parav Pandit wrote:
> > >
> > >
> > > > From: Leon Romanovsky <leon@kernel.org>
> > > > Sent: Thursday, October 24, 2019 11:13 AM
> > > > To: Jason Gunthorpe <jgg@ziepe.ca>
> > > > Cc: Doug Ledford <dledford@redhat.com>; Parav Pandit
> > > > <parav@mellanox.com>; RDMA mailing list
> > > > <linux-rdma@vger.kernel.org>
> > > > Subject: Re: [PATCH rdma-next] IB/core: Avoid deadlock during
> > > > netlink message handling
> > > >
> > > > On Thu, Oct 24, 2019 at 01:08:10PM -0300, Jason Gunthorpe wrote:
> > > > > On Thu, Oct 24, 2019 at 07:02:52PM +0300, Leon Romanovsky wrote:
> > > > > > On Thu, Oct 24, 2019 at 10:50:17AM -0300, Jason Gunthorpe wrote=
:
> > > > > > > On Thu, Oct 24, 2019 at 04:26:07PM +0300, Leon Romanovsky
> wrote:
> > > > > > > > On Thu, Oct 24, 2019 at 10:17:43AM -0300, Jason Gunthorpe
> wrote:
> > > > > > > > > On Tue, Oct 15, 2019 at 11:07:33AM +0300, Leon Romanovsky
> wrote:
> > > > > > > > >
> > > > > > > > > > diff --git a/drivers/infiniband/core/netlink.c
> > > > > > > > > > b/drivers/infiniband/core/netlink.c
> > > > > > > > > > index 81dbd5f41bed..a3507b8be569 100644
> > > > > > > > > > +++ b/drivers/infiniband/core/netlink.c
> > > > > > > > > > @@ -42,9 +42,12 @@
> > > > > > > > > >  #include <linux/module.h>  #include "core_priv.h"
> > > > > > > > > >
> > > > > > > > > > -static DEFINE_MUTEX(rdma_nl_mutex);  static struct {
> > > > > > > > > > -	const struct rdma_nl_cbs   *cb_table;
> > > > > > > > > > +	const struct rdma_nl_cbs __rcu *cb_table;
> > > > > > > > > > +	/* Synchronizes between ongoing netlink commands
> and
> > > > netlink client
> > > > > > > > > > +	 * unregistration.
> > > > > > > > > > +	 */
> > > > > > > > > > +	struct srcu_struct unreg_srcu;
> > > > > > > > >
> > > > > > > > > A srcu in every index is serious overkill for this. Lets
> > > > > > > > > just us a
> > > > > > > > > rwsem:
> > > > > > > >
> > > > > > > > I liked previous variant more than rwsem, but it is Parav's=
 patch.
> > > > > > >
> > > > > > > Why? srcu is a huge data structure and slow on unregister
> > > > > >
> > > > > > The unregister time is not so important for those IB/core modul=
es.
> > > > > > I liked SRCU because it doesn't have *_ONCE() macros and smb_*
> calls.
> > > > >
> > > > > It does, they are just hidden under other macros..
> >
> > > Its better that they are hidden. So that we don't need open code
> > > them.
> >
> > I wouldn't call swapping one function call for another 'open coding'
> >
> > > Also with srcu, we don't need lock annotations in get_cb_table()
> > > which releases and acquires semaphore.
> >
> > You don't need lock annoations for that.
> >
> > > Additionally lock nesting makes overall more complex.
> >
> > SRCU nesting is just as complicated! Don't think SRCU magically hides
> > that issue, it is still proposing to nest SRCU read side sections.
> >
> > > Given that there are only 3 indices, out of which only 2 are outside
> > > of the ib_core module and unlikely to be unloaded, I also prefer
> > > srcu version.
> >
> > Why? It isn't faster, it uses more memory, it still has the same
> > complex concurrency arrangement..
>=20
> Jason,
>=20
> It doesn't worth arguing, both Parav and I prefer SRCU variant, you prefe=
r
> rwsem, so go for it, take rwsem, it is not important.
>=20
Jason's memory size point made be curious about the srcu_struct size.
On my x86 5.x kernel I see srcu_struct costs 70+Kbytes! Likely due to some =
debug info in my kernel.
Which is probably a good reason in this case to shift to rwsem. (rwsem is 8=
0 bytes).

One small comment correction needed is,

-	rdma_nl_types[index].cb_table =3D cb_table;
-	mutex_unlock(&rdma_nl_mutex);
+	/* Pairs with the READ_ONCE in is_nl_valid() */
+	smp_store_release(&rdma_nl_types[index].cb_table, cb_table);

It should be "Pairs with the READ_ONE in get_cb_table() */

> Thanks
>=20
> >
> > Jason
