Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8099E9359
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2019 00:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbfJ2XNF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 19:13:05 -0400
Received: from mail-eopbgr00044.outbound.protection.outlook.com ([40.107.0.44]:37014
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725830AbfJ2XNF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 19:13:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYLyxVDer07yot6FTR6Xi12XSPV3TnamPzHEbcCPVYNwj0ZVt937LZCZrDKIWvhNzX9t9RT5TSIpANbpzEVyQWrDB4SCWWcP9TKlIwhNykojbcsnAWUcYKyu55pIp8vrrnVzXUHCQt2V/tCJjeF48LW+wShcguOJ6pdnIh772UoEAYuMT4WpHZu4HzjRBR3nJGK7XGsaDt6SCPREfek84VFKJh4Rkst6Vq9a0REOVASBt2FbXemNZCvAZBkBd3nyOsS25/XgKZyvRNGLQux75ENGYLEERgLIPlbhLvdL8xZjXohcga58XkBYn0CuvJAhv4laVQuT3NpO3Ojp0zD8eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lb/NTsMePdh/dTAMcAAvYHy81Y3M9ibceRr11XqormU=;
 b=QWQJKz+5BlvPn60eL8SNaKiytCThlTETdGYcloEozO8TUBLUnYyf+7hlKIA3YGukizrt3/ye+XFP/esSwvfrnbUVCiot9DopDTSgdlh0EzhxWRB5tnCbLEmaMz7cy+j39f55AOoKWhiGb3t5f+tXpujR+pSzMTxfD15GVKOIjOWY6nWIPp79YOccQwsPp621+HxKJtG+F+WIfHc/NjTC1dRjRRJhjJi5439lNps77OlLEkNXnvEYZolvJiQPLxdp57aLUX4twAeotpQj9wCNgd4rnX0h6YVGj+8AgU7xw+MNgUZI8tMvA158FaTu02dPoLTy07pzEA7JFoa7Z9T88w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lb/NTsMePdh/dTAMcAAvYHy81Y3M9ibceRr11XqormU=;
 b=CRtsWYz/nrcUV1Palwc4SnpMVfwKW0ROkRu/xY9m7nUOLV4JEOiiRm0iVrtLGMF9nVtbj3sMlMkNnvlxuhiLt4r0xh49Ys0LBcI/lH6llHrFfNzFG8z/5mxmW77v994pxe//+knJjGpDIopg517kKFotU5m+LuZ5pMGLiSD8NDU=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB3486.eurprd05.prod.outlook.com (10.170.237.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 23:13:00 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2387.027; Tue, 29 Oct 2019
 23:13:00 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] mm/hmm/test: add self tests for HMM
Thread-Topic: [PATCH v3 3/3] mm/hmm/test: add self tests for HMM
Thread-Index: AQHVidvRl0DiLfVRckS4hHS5dqmJyadx8UKAgAA3LICAACCkgA==
Date:   Tue, 29 Oct 2019 23:12:59 +0000
Message-ID: <20191029231255.GX22766@mellanox.com>
References: <20191023195515.13168-1-rcampbell@nvidia.com>
 <20191023195515.13168-4-rcampbell@nvidia.com>
 <20191029175837.GS22766@mellanox.com>
 <3ffecdc6-625f-ebea-8fb4-984fe6ca90f3@nvidia.com>
In-Reply-To: <3ffecdc6-625f-ebea-8fb4-984fe6ca90f3@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR1501CA0025.namprd15.prod.outlook.com
 (2603:10b6:207:17::38) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 11a69733-7ad4-42d2-d687-08d75cc58a14
x-ms-traffictypediagnostic: VI1PR05MB3486:
x-microsoft-antispam-prvs: <VI1PR05MB34866EBB7B0A2B17117DCD08CF610@VI1PR05MB3486.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(199004)(189003)(386003)(3846002)(6116002)(52116002)(6436002)(66556008)(64756008)(66446008)(66946007)(478600001)(76176011)(6506007)(446003)(11346002)(476003)(229853002)(6486002)(14454004)(71200400001)(102836004)(2616005)(25786009)(6246003)(186003)(66476007)(14444005)(4326008)(26005)(86362001)(256004)(6512007)(71190400001)(54906003)(316002)(5660300002)(36756003)(305945005)(7736002)(6916009)(66066001)(8676002)(1076003)(8936002)(33656002)(99286004)(81166006)(486006)(2906002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3486;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WbBIsqYUPLDFXp1jlGg02w5X8fDbKoWRmW8RSJCweJcocxIcx04fvGZVWL/JHUNc2sX5iwALhcj2I9k+jLhoeMG7GUzZ5BNfNzyqnpUgVTjtbyP2kCRPTOn5QZC3TXsp+Bl7CkxrNOQNH1vLzw4Zwtq7X+PVmx176ewx6Lorxthf8Qqlea/GPxG/Du7FqM5mZTyvPQrpuDMHfKedM+18nES9Ug9mazrued3GzvNCrMBolabrGvJtifjhG70vCGvVwT+AWMZzUYdzrv3VYy0vzBqMUKtvuQGze0HhLwEOQy0GCmLdQ0mTdeDp2V4A6dM+ZtZWDPdqrnq/mjR15kkIS6xIx0lXCbnNDbsqxxN+FP8MpocZeVZOS9H6TYQhuHOHFN0vccfSA5omLtjgtzzOOrvW5gIAKzYaw9Yf1r49n3YYIkpmdXwS0Ro+Tx7/2kgM
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DF0B346546CBC74587B861126B28465A@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a69733-7ad4-42d2-d687-08d75cc58a14
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 23:12:59.2128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PMaHJJ00b3Uffot6NjdWrUeXiKMUJoTWrco4kzT4bR+rGkykXkm1qcdcDZv/2i7RQMssfEHn70R7NQI7bUlNnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3486
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 29, 2019 at 02:16:05PM -0700, Ralph Campbell wrote:

> > Frankly, I'm not super excited about the idea of a 'test driver', it
> > seems more logical for testing to have some way for a test harness to
> > call hmm_range_fault() under various conditions and check the results?
>=20
> test_vmalloc.sh at least uses a test module(s).

Well, that is good, is it also under drivers/char? It kind feels like
it should not be there...
=20
> > It seems especially over-complicated to use a full page table layout
> > for this, wouldn't something simple like an xarray be good enough for
> > test purposes?
>=20
> Possibly. A page table is really just a lookup table from virtual address
> to pfn/page. Part of the rationale was to mimic what a real device
> might do.

Well, but the details of the page table layout don't see really
important to this testing, IMHO.

> > > +	for (addr =3D start; addr < end; ) {
> > > +		long count;
> > > +
> > > +		next =3D min(addr + (ARRAY_SIZE(pfns) << PAGE_SHIFT), end);
> > > +		range.start =3D addr;
> > > +		range.end =3D next;
> > > +
> > > +		down_read(&mm->mmap_sem);

Also, did we get a mmget() before doing this down_read?

> > > +
> > > +		ret =3D hmm_range_register(&range, &dmirror->mirror);
> > > +		if (ret) {
> > > +			up_read(&mm->mmap_sem);
> > > +			break;
> > > +		}
> > > +
> > > +		if (!hmm_range_wait_until_valid(&range,
> > > +						DMIRROR_RANGE_FAULT_TIMEOUT)) {
> > > +			hmm_range_unregister(&range);
> > > +			up_read(&mm->mmap_sem);
> > > +			continue;
> > > +		}
> > > +
> > > +		count =3D hmm_range_fault(&range, 0);
> > > +		if (count < 0) {
> > > +			ret =3D count;
> > > +			hmm_range_unregister(&range);
> > > +			up_read(&mm->mmap_sem);
> > > +			break;
> > > +		}
> > > +
> > > +		if (!hmm_range_valid(&range)) {
> >=20
> > There is no 'driver lock' being held here, how does this work?
> > Shouldn't it hold dmirror->mutex for this sequence?
>=20
> I have a modified version of this driver that's based on your series
> removing hmm_mirror_register() which uses a mutex.
> Otherwise, it looks similar to the changes in nouveau.

Well, that locking pattern is required even for original hmm calls..


> > > +static int dmirror_read(struct dmirror *dmirror,
> > > +			struct hmm_dmirror_cmd *cmd)
> > > +{
> >=20
> > Why not just use pread()/pwrite() for this instead of an ioctl?
>=20
> pread()/pwrite() could certainly be implemented.
> I think the idea was that the read/write is actually the "device"
> doing read/write and making that clearly different from a program
> reading/writing the device. Also, the ioctl() allows information
> about what faults or events happened during the operation. I only
> have number of pages and number of page faults returned at the moment,
> but one of Jerome's version of this driver had other counters being
> returned.

Makes sense I guess

> > > +static struct platform_driver dmirror_device_driver =3D {
> > > +	.probe		=3D dmirror_probe,
> > > +	.remove		=3D dmirror_remove,
> > > +	.driver		=3D {
> > > +		.name	=3D "HMM_DMIRROR",
> > > +	},
> > > +};
> >=20
> > This presence of a platform_driver and device is very confusing. I'm
> > sure Greg KH would object to this as a misuse of platform drivers.
> >=20
> > A platform device isn't needed to create a char dev, so what is this fo=
r?
>=20
> The devm_request_free_mem_region() and devm_memremap_pages() calls for
> creating the ZONE_DEVICE private pages tie into the devm* clean up framew=
ork.
> I thought a platform_driver was the simplest way to also be able to call
> devm_add_action_or_reset() to clean up on module unload and be compatible
> with the private page clean up.

IIRC Christoph recently fixed things so there was a non devm version
of these functions. Certainly we should not be making fake
platform_devices just to call devm.

There is also a struct device inside the cdev, maybe that could be
arrange to be devm compatible if it was *really* needed.

> > > diff --git a/include/Kbuild b/include/Kbuild
> > > index ffba79483cc5..6ffb44a45957 100644
> > > +++ b/include/Kbuild
> > > @@ -1063,6 +1063,7 @@ header-test-			+=3D uapi/linux/coda_psdev.h
> > >   header-test-			+=3D uapi/linux/errqueue.h
> > >   header-test-			+=3D uapi/linux/eventpoll.h
> > >   header-test-			+=3D uapi/linux/hdlc/ioctl.h
> > > +header-test-			+=3D uapi/linux/hmm_dmirror.h
> >=20
> > Why? This list should only be updated if the header is broken in some
> > way.
>=20
> Should this be in include/linux/ instead?
> I wasn't sure where the "right" place was to put the header.

No, it is right, it just shouldn't be in this makefile.

Jason
