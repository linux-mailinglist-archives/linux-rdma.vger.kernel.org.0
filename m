Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE88025B15
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2019 02:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfEVAOW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 May 2019 20:14:22 -0400
Received: from mail-eopbgr70040.outbound.protection.outlook.com ([40.107.7.40]:8198
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725797AbfEVAOW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 May 2019 20:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBTxmRQbOrRmRWdaHgzYgHZcbpi6PX5sLV52ad7WI6E=;
 b=hHHQ4UW2Qc6WNlLhQoRipIXRbOJOIpuy6KmX59FPzUzk06vhWEZwAOuE1Bu2bI7D1elXdaZa7kgY+VxGJfbZezZ26GB8h4ykju8mI/ZjZjgGs6fluqOoisOShJrAmMqsjmLHtCwLv6lyg9jA79O0ehNGcz6J/DQTzcfFy2dQMzU=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4365.eurprd05.prod.outlook.com (52.133.12.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Wed, 22 May 2019 00:14:17 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1922.013; Wed, 22 May 2019
 00:14:17 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Glenn Streiff <gstreiff@neteffect.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: Re: [PATCH rdma-next 04/15] RDMA/efa: Remove check that prevents
 destroy of resources in error flows
Thread-Topic: [PATCH rdma-next 04/15] RDMA/efa: Remove check that prevents
 destroy of resources in error flows
Thread-Index: AQHVDtjuQBBHO2HSKkGy9VmU4u8onqZz9GwAgAAIigCAABTggIABx5AAgAAZSQCAAFYvAA==
Date:   Wed, 22 May 2019 00:14:17 +0000
Message-ID: <20190522001412.GA30833@mellanox.com>
References: <20190520065433.8734-1-leon@kernel.org>
 <20190520065433.8734-5-leon@kernel.org>
 <a3358e40-9be4-0a7c-dab5-96573b646ded@amazon.com>
 <20190520131000.GJ4573@mtr-leonro.mtl.com>
 <161ad83d-cb50-d02a-8511-938b2b3b7156@amazon.com>
 <20190521173514.GH2907@mellanox.com>
 <3e957c76-5959-2b6a-f29e-09a4e2436258@amazon.com>
In-Reply-To: <3e957c76-5959-2b6a-f29e-09a4e2436258@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR12CA0007.namprd12.prod.outlook.com
 (2603:10b6:208:a8::20) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 627a3503-a724-4f88-9ccb-08d6de4a6d96
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4365;
x-ms-traffictypediagnostic: VI1PR05MB4365:
x-microsoft-antispam-prvs: <VI1PR05MB43654D1E1C79B05FA0FA9A0FCF000@VI1PR05MB4365.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(366004)(39860400002)(136003)(189003)(199004)(6486002)(102836004)(229853002)(4326008)(11346002)(1076003)(186003)(446003)(66556008)(64756008)(66446008)(66476007)(66946007)(73956011)(25786009)(14454004)(71200400001)(476003)(6246003)(36756003)(478600001)(6436002)(2616005)(6512007)(71190400001)(68736007)(6916009)(33656002)(6116002)(486006)(53936002)(2906002)(5660300002)(316002)(3846002)(53546011)(256004)(54906003)(14444005)(305945005)(7736002)(52116002)(76176011)(86362001)(99286004)(8936002)(66066001)(8676002)(26005)(6506007)(386003)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4365;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HSK1Bnd48zu1BZ9NK2WoeATGgdycG+uTbf7Q/gtRZB5WA8fV7BaQfqWGY1X1ACHZbeFYAJyX+4rc5Y4n7GUwkbVUIgQl7ntoUNi29+9zgud6/02jf9EMm7WbgmDkgYIlReVN/DtI4bK0u2qDMS4YrxQfmCkKW1khr6WqnzzWZGaDbzQyDYhYthwrJkfK9H+4ZKz7GogA9G0wgdd9zQiPXkf2Udmt6UWuI4mCB9cJ0hwK6DfJccOpMmNhyziR0GOf/uQYmWEBu8ZlzPRREK6l02HXsQuuYS4j/mnqJ6zG79KsH6cLJxyKpH6JbPHdFudmNoLF+6FmoNvFFvZG6AwPE6x2TH9ul87BsuRNz6OZzsvk6Nge/pJ0HH+JQUQNby+pwkFI9fZoCHnoZxl6OjlENMlLEgJ1HENgVCMEnPFEacA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7BF5B287CC4F6247B8D10B846083931E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 627a3503-a724-4f88-9ccb-08d6de4a6d96
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 00:14:17.0605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4365
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 21, 2019 at 10:05:44PM +0300, Gal Pressman wrote:
> On 21/05/2019 20:35, Jason Gunthorpe wrote:
> > On Mon, May 20, 2019 at 05:24:43PM +0300, Gal Pressman wrote:
> >=20
> >>>>> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >>>>>  drivers/infiniband/hw/efa/efa_verbs.c | 24 -----------------------=
-
> >>>>>  1 file changed, 24 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infini=
band/hw/efa/efa_verbs.c
> >>>>> index 6d6886c9009f..4999a74cee24 100644
> >>>>> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> >>>>> @@ -436,12 +436,6 @@ void efa_dealloc_pd(struct ib_pd *ibpd, struct=
 ib_udata *udata)
> >>>>>  	struct efa_dev *dev =3D to_edev(ibpd->device);
> >>>>>  	struct efa_pd *pd =3D to_epd(ibpd);
> >>>>>
> >>>>> -	if (udata->inlen &&
> >>>>> -	    !ib_is_udata_cleared(udata, 0, udata->inlen)) {
> >>>>> -		ibdev_dbg(&dev->ibdev, "Incompatible ABI params\n");
> >>>>> -		return;
> >>>>> -	}
> >=20
> > Regardless of the issue of udata validity, these checks still cannot
> > be here.
> >=20
> > We are moving the whole core to not return error codes from driver
> > object destroy - because destroy is not allowed to fail in many flows.
>=20
> What is the reason for that?

Because very little was ever doing anything with the return codes. In
nearly all cases it just caused a memory leak.

So I want to say not being able to destroy is a catastrophic error
and the driver must cope with it, however it deems fit. WARN_ON & leak
or fatal error the device, or whatever it wants.

But the ULPs will not be exposed to this, and don't contain any code
to handle it.

> > So, drivers do not have the option to validate the udata and fail
> > destroy at this point. If it ever comes up, then we will need to split
> > validation into another step on the uapi path that is done before
> > invoking the actual destroy function.
>=20
> Is it really necessary? The udata in these flows is new, so there's no re=
ason
> any driver won't be able to work with a cleared udata and fail the valida=
tions,
> even if it expands it in the future.

It isn't necessary now, and probably never will be as everyone should
use the ioctl flow which already has this split validation approach.

Jason
