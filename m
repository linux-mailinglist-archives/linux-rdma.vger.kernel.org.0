Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58F7DDF5A8
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 21:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfJUTGo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 15:06:44 -0400
Received: from mail-eopbgr80047.outbound.protection.outlook.com ([40.107.8.47]:49793
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727211AbfJUTGo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Oct 2019 15:06:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6hJs01S/6cr1FMXF3VGzvgufocf7zgkuk3a8Cs/X0FRYWou69zoTCEMnkFiG27yhwjs6bCVM2L8B7XSQ3IqaR9MtUmL0nFWnA1xuGU7kdRbFYylYc4lyvZ3ekO8ofzL5SnutjCFjQB+qTDP/FkyprfqJ8+O1cBqk8Vtloz4eR67xAwF8MSJirt5bmGqjtoKBZquHiVCypqHr+0JEqrufJOgpShhS2tsU+45nV8lgdjiDYnz2x+X5/VvOb4dqBhFuXo88SwAtXb65r8KE8Eeaw6qB1620NLl175ZefH9OP2xbEIi0dhovwePdfq0ly7RAk2zt79fFgyeXi5ZuSCjHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKJd2NpinY3P8m2AwGEy7BmBOIvD5pXIr4+oty5xgzM=;
 b=MG4yKM/LzdqTrC8gKZM+GwPOKPWmyMKjlFP36yJSJWRjLnzti0naKZdWOTN7gN6Th9gZ5lOHCUNgnwviUJJ+loLzwcLFJ5PscO9KVvO+u/ejKD6cc5COPIC6NZ8ALf0Ufg93//kscqIGYXUA7G3tTXl3Y7GddQv3oJsFfUkg+bdQjUJ7eddpw+SsVyMoDnR+niGySsoqxdLQdlXiH0ZH2wxoH7nWrU5wAXgwpyH6jQ+WAjul0uZkO+A8Nyr0b16xiaQZEesuRMeFcMNsw2fWQ8Bg3u6V8NPLSQC1cZIta7T8pIVvK7jigDw+J2ZiL7OrYirdo3mFoSVvRbAGDeV34Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKJd2NpinY3P8m2AwGEy7BmBOIvD5pXIr4+oty5xgzM=;
 b=CG4YGrSZGij6J6KVBkGlb9HhJoeTiDjONhgS8039+aME1VgmVwyHfgNeatPc+W5PDHS63brsg5hYASEOzuhfDqWc9QQ4mr4v8ipXPTXp75zZMKCxrrIFfr46WQ04lWj0vi/E/OGEVSnY2KgBpsQQE9E+aSw9ElLyMc0bOrLtadw=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4718.eurprd05.prod.outlook.com (20.176.1.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Mon, 21 Oct 2019 19:06:00 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0%7]) with mapi id 15.20.2347.029; Mon, 21 Oct 2019
 19:06:00 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Jerome Glisse <jglisse@redhat.com>
CC:     Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH hmm 00/15] Consolidate the mmu notifier interval_tree and
 locking
Thread-Topic: [PATCH hmm 00/15] Consolidate the mmu notifier interval_tree and
 locking
Thread-Index: AQHVg4Sqa7CCxCToXEeTrrYAqVQVhqdldwqAgAAHDgA=
Date:   Mon, 21 Oct 2019 19:06:00 +0000
Message-ID: <20191021190556.GI6285@mellanox.com>
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <20191021184041.GF3177@redhat.com>
In-Reply-To: <20191021184041.GF3177@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN8PR04CA0038.namprd04.prod.outlook.com
 (2603:10b6:408:d4::12) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d02704bc-4334-4fc6-067d-08d75659b5e5
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR05MB4718:
x-microsoft-antispam-prvs: <VI1PR05MB4718C871FA1CE457B206E8BDCF690@VI1PR05MB4718.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0197AFBD92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(199004)(189003)(3846002)(86362001)(316002)(66946007)(7416002)(305945005)(7736002)(8676002)(81156014)(14444005)(256004)(66476007)(66556008)(64756008)(66446008)(52116002)(71200400001)(76176011)(54906003)(99286004)(71190400001)(8936002)(81166006)(6116002)(6506007)(33656002)(478600001)(14454004)(386003)(26005)(229853002)(25786009)(4326008)(6436002)(446003)(1076003)(486006)(66066001)(102836004)(6486002)(2906002)(2616005)(36756003)(5660300002)(11346002)(186003)(476003)(6246003)(6916009)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4718;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 848yyiXVONH54Kkcr/4H3YrpXwbjxGarmHogfgIcRQyB9BAQyL7b+LUAsaaea5JJvZPTv0v6cSokHczFqydmW89SFTJ/iloqnLVJxTI44EETpoDxOpU+6OC2xJs/QAjKBFCGhgliz7GPvv1BppF+Dm3WusPMLcrSBGYxi8FHneGfmspxl57uY8ASH6KQKmgWUZPt5xzjPCER2xjRC+yrD/93jx/CIZ5FbrIAk+T8nDefNjD7Sy60MVruS2drvVfFqWraEsOJNtsBFxlrXkqEnxxuqWKISD3+A9YJi0m21Z/4tRvlaf3On1oogNXTExUik2EVINDTMF5mv5BufV9hFLU1slrhuNpbtcSt3gFRj6mt1y6mOC1XOoAnCg0tgu7VetlBfr+guYRuxA+D8e3OKrdaPcOk/T7xC0cCl0yBef72nowZBpL9TbpTMdzSzTUp
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <46700DBA60BB8A43AC732C3FBB27EA05@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d02704bc-4334-4fc6-067d-08d75659b5e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2019 19:06:00.1077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rQFA9nq6A4mLS2977RGY5r/lxIuJD5QCXkx4gDd0HbxIJbyD3HQ9PBGfGhJgZVWmCs427iJB/wWK1+1M3uZ8yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4718
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 21, 2019 at 02:40:41PM -0400, Jerome Glisse wrote:
> On Tue, Oct 15, 2019 at 03:12:27PM -0300, Jason Gunthorpe wrote:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> >=20
> > 8 of the mmu_notifier using drivers (i915_gem, radeon_mn, umem_odp, hfi=
1,
> > scif_dma, vhost, gntdev, hmm) drivers are using a common pattern where
> > they only use invalidate_range_start/end and immediately check the
> > invalidating range against some driver data structure to tell if the
> > driver is interested. Half of them use an interval_tree, the others are
> > simple linear search lists.
> >=20
> > Of the ones I checked they largely seem to have various kinds of races,
> > bugs and poor implementation. This is a result of the complexity in how
> > the notifier interacts with get_user_pages(). It is extremely difficult=
 to
> > use it correctly.
> >=20
> > Consolidate all of this code together into the core mmu_notifier and
> > provide a locking scheme similar to hmm_mirror that allows the user to
> > safely use get_user_pages() and reliably know if the page list still
> > matches the mm.
> >=20
> > This new arrangment plays nicely with the !blockable mode for
> > OOM. Scanning the interval tree is done such that the intersection test
> > will always succeed, and since there is no invalidate_range_end exposed=
 to
> > drivers the scheme safely allows multiple drivers to be subscribed.
> >=20
> > Four places are converted as an example of how the new API is used.
> > Four are left for future patches:
> >  - i915_gem has complex locking around destruction of a registration,
> >    needs more study
> >  - hfi1 (2nd user) needs access to the rbtree
> >  - scif_dma has a complicated logic flow
> >  - vhost's mmu notifiers are already being rewritten
> >=20
> > This is still being tested, but I figured to send it to start getting h=
elp
> > from the xen, amd and hfi drivers which I cannot test here.
>=20
> It might be a good oportunity to also switch those users to
> hmm_range_fault() instead of GUP as GUP is pointless for those
> users. In fact the GUP is an impediment to normal mm operations.

I think vhost can use hmm_range_fault

hfi1 does actually need to have the page pin, it doesn't fence DMA
during invalidate.

i915_gem feels alot like amdgpu, so probably it would benefit

No idea about scif_dma

> I will test on nouveau.

Thanks, hopefully it still works, I think Ralph was able to do some
basic checks. But it is a pretty complicated series, I probably made
some mistakes.

FWIW, I know that nouveau gets a lockdep splat now from Daniel
Vetter's recent changes, it tries to do GFP_KERENEL allocations under
a lock also held by the invalidate_range_start path.

Thanks for looking at it!

Regards,
Jason=20
