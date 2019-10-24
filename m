Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87AC3E3AF6
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 20:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504015AbfJXS2k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 14:28:40 -0400
Received: from mail-eopbgr50041.outbound.protection.outlook.com ([40.107.5.41]:1328
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726155AbfJXS2k (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Oct 2019 14:28:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mr4U++XGPQ9lYrnBz+sBOmvnfB7n7/JnvGw+ToX0Df+oeS0m1yPbCkh2H/9hdFkZ6n2pEVzA1AFUe3uMKzn7WZlcl9YFurTq3tKbORw2BsBmkJ4mkk/CeRomj6+1NBmNNb/1lE3Zywrm2GmIRwWq35M0b/oPoDta7cmZMHd+DV2x0tBQVrcpbP2n87E90SlGr/erao0hN985NaMPctVody3yomzra4AIr0S/195J2z/LBqYj4nR0htM0+fel8AvyMXgz+APtK/KQ2vvAWX+1J1myWelxjtM7cL0TkjHlfsBglZEOUGDIx/POzWwlTVZlmhY40qnJETvDPPWNN69oRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nvrGCZrNNn+7+SQrVZwA1eefrjIirVgo/s521PfLsQ=;
 b=f07PoaSvdvDIWj94dQqDZ6Wa5VbXzWLleYfqCeZ9JU7obXj9ZZbtvJQ1bsPxiaXBS6INWCARnyKXUVLaTkEMZSvAbNL0TNBmWzu0QOStbaXHLm7cnMpfEDVcJ2wCZiJVwv7GhiBSJgslCGXl16KbCu28DpflaXWCGBRNLaj2yN2srsc3Z5o520s/fi2f+opOvD0gKntpVkW+epiwv4JXWf9zYOVooIrR54zSnUlGEMc3aLUlwfJnbVzJUDB+4hi5RY0qTuj5hXKRYTY7o+t4EZkHI1pxCKJ5PagdBiTRB2ey7NghopE8da7DFsuv9j6jWqCZ1a7urD5IE6W3L0kxsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nvrGCZrNNn+7+SQrVZwA1eefrjIirVgo/s521PfLsQ=;
 b=HdsnvfUY2Tyh2AiThw2G5C8T1YKQ30iRTzymQucEKBPpLc4cfLGQ44AyGFBj+KTUqGFnPuHHAgwbVVGPD65dO132y2dGA8feBDa/Gxlxihmq2XCPXABQK1ZH66wuoj5k70K0vPoxgvDIaa2IeeLl3SwPgIbIh4smau1Cjebikus=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB5154.eurprd05.prod.outlook.com (20.178.16.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Thu, 24 Oct 2019 18:28:35 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::64b2:6eb4:f000:3432]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::64b2:6eb4:f000:3432%7]) with mapi id 15.20.2387.019; Thu, 24 Oct 2019
 18:28:35 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH rdma-next] IB/core: Avoid deadlock during netlink message
 handling
Thread-Topic: [PATCH rdma-next] IB/core: Avoid deadlock during netlink message
 handling
Thread-Index: AQHVgy+dqbhYCwPdVkCqZeGqtQCivqdp1HaAgAACWYCAAAbBgIAAJQsAgAABewCAAAFggIAAJH1A
Date:   Thu, 24 Oct 2019 18:28:35 +0000
Message-ID: <AM0PR05MB4866029667184FC06C427E3BD16A0@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <20191015080733.18625-1-leon@kernel.org>
 <20191024131743.GA24174@ziepe.ca> <20191024132607.GR4853@unreal>
 <20191024135017.GT23952@ziepe.ca> <20191024160252.GS4853@unreal>
 <20191024160810.GV23952@ziepe.ca> <20191024161305.GU4853@unreal>
In-Reply-To: <20191024161305.GU4853@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 26e9e431-bda1-4a23-39e1-08d758affb34
x-ms-traffictypediagnostic: AM0PR05MB5154:
x-microsoft-antispam-prvs: <AM0PR05MB515401954D12F528D6EF1B95D16A0@AM0PR05MB5154.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(13464003)(189003)(199004)(76116006)(74316002)(55016002)(476003)(11346002)(229853002)(7696005)(8936002)(186003)(66066001)(446003)(2906002)(81156014)(76176011)(15650500001)(486006)(9686003)(7736002)(71200400001)(71190400001)(6116002)(26005)(3846002)(478600001)(66556008)(81166006)(25786009)(316002)(6436002)(64756008)(256004)(14444005)(33656002)(66946007)(110136005)(99286004)(86362001)(66446008)(53546011)(66476007)(6506007)(52536014)(54906003)(6246003)(5660300002)(14454004)(4326008)(8676002)(102836004)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB5154;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SDZSn8lpEeoqWwXfirNO1Iq+QvOquNw+ileYLrOME7aj1LaYlH7G0LLP0p85ADaIxa1BzYPXZa+YNLHg5qdRkil6gWv1Kx93/Y2iAIrfGpcCSXIy50XkXvi1XZuZyq9u2QMxR6HhrZZCspJkX0XeQFWgoO1lYjmREIXgFdGIGLp6gDDjhB9DRn2bJJBWknfiqucEl5ud5iJcnr+rLxGb1ZlhBWcRmgZBUYnE9uM5FIWprdHFrN+smK1H0UYreYgRYby059Tvly6yIzqnSgtpUbuPbn211RbOlAb2VButwbpOtItSMH2FyLRqRB3nGCL8VX0PIpy+JoKAoI8SArGq3+IddJDSFhUzaPG07W1wIYDiQj/A/CQ5GJm57Zl7QtM28rZ/VoXXBIZd00QR93EJn/U9tGYdodieN2qOoTgmu4JKURIiq9mHWe4CCgAxseJt
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e9e431-bda1-4a23-39e1-08d758affb34
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 18:28:35.2020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jcahyUXAwywsghtI2b33GOrYalfCMQSwEoNWuYX1nW8932HWvQosPH3d7LTY/87KvYUMkOmNm6S3RdyD8ByVRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5154
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Thursday, October 24, 2019 11:13 AM
> To: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Doug Ledford <dledford@redhat.com>; Parav Pandit
> <parav@mellanox.com>; RDMA mailing list <linux-rdma@vger.kernel.org>
> Subject: Re: [PATCH rdma-next] IB/core: Avoid deadlock during netlink mes=
sage
> handling
>=20
> On Thu, Oct 24, 2019 at 01:08:10PM -0300, Jason Gunthorpe wrote:
> > On Thu, Oct 24, 2019 at 07:02:52PM +0300, Leon Romanovsky wrote:
> > > On Thu, Oct 24, 2019 at 10:50:17AM -0300, Jason Gunthorpe wrote:
> > > > On Thu, Oct 24, 2019 at 04:26:07PM +0300, Leon Romanovsky wrote:
> > > > > On Thu, Oct 24, 2019 at 10:17:43AM -0300, Jason Gunthorpe wrote:
> > > > > > On Tue, Oct 15, 2019 at 11:07:33AM +0300, Leon Romanovsky wrote=
:
> > > > > >
> > > > > > > diff --git a/drivers/infiniband/core/netlink.c
> > > > > > > b/drivers/infiniband/core/netlink.c
> > > > > > > index 81dbd5f41bed..a3507b8be569 100644
> > > > > > > +++ b/drivers/infiniband/core/netlink.c
> > > > > > > @@ -42,9 +42,12 @@
> > > > > > >  #include <linux/module.h>
> > > > > > >  #include "core_priv.h"
> > > > > > >
> > > > > > > -static DEFINE_MUTEX(rdma_nl_mutex);  static struct {
> > > > > > > -	const struct rdma_nl_cbs   *cb_table;
> > > > > > > +	const struct rdma_nl_cbs __rcu *cb_table;
> > > > > > > +	/* Synchronizes between ongoing netlink commands and
> netlink client
> > > > > > > +	 * unregistration.
> > > > > > > +	 */
> > > > > > > +	struct srcu_struct unreg_srcu;
> > > > > >
> > > > > > A srcu in every index is serious overkill for this. Lets just
> > > > > > us a
> > > > > > rwsem:
> > > > >
> > > > > I liked previous variant more than rwsem, but it is Parav's patch=
.
> > > >
> > > > Why? srcu is a huge data structure and slow on unregister
> > >
> > > The unregister time is not so important for those IB/core modules.
> > > I liked SRCU because it doesn't have *_ONCE() macros and smb_* calls.
> >
> > It does, they are just hidden under other macros..
> >
Its better that they are hidden. So that we don't need open code them.
Also with srcu, we don't need lock annotations in get_cb_table() which rele=
ases and acquires semaphore.
Additionally lock nesting makes overall more complex.
Given that there are only 3 indices, out of which only 2 are outside of the=
 ib_core module and unlikely to be unloaded, I also prefer srcu version.


> > > Maybe wrong here, but the extra advantage of SRCU is that we are
> > > already using that mechanism in uverbs and my assumption that SRCU
> > > will greatly enjoy shared grace period.
> >
> > Hm, I'm not sure it works like that, the grace periods would be
> > consecutive
>=20
> Whatever, the most important part of Parav's patch that we removed global
> lock from RDMA netlink interface.
>=20
> Thanks
>=20
> >
> > Jason
