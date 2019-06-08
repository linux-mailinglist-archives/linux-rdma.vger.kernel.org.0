Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7486739D91
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jun 2019 13:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbfFHLlp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 8 Jun 2019 07:41:45 -0400
Received: from mail-eopbgr30056.outbound.protection.outlook.com ([40.107.3.56]:35031
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728233AbfFHLlo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 8 Jun 2019 07:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dm5t7RwyC8mbdoq110urMkfCMJmGmRbbuzagndSbNrE=;
 b=kAuQwdJx1jmLjEj4PWsyTzdyj3xbNHpqiYq8uVn1CwPaInYlsDlDgcvLGEwEZRbNZwmu41CzRD1PfVE4QNeUN0S0O27Bu8ChRWZpGt8rl1V+NGmb0cyGRSx4+c31pooCcjxJRQMWiK49ruQDQvmDxu/8pp7KGU05D5gPyiUwaMk=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5007.eurprd05.prod.outlook.com (20.177.52.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Sat, 8 Jun 2019 11:41:39 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1965.017; Sat, 8 Jun 2019
 11:41:39 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Ralph Campbell <rcampbell@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [RFC] mm/hmm: pass mmu_notifier_range to
 sync_cpu_device_pagetables
Thread-Topic: [RFC] mm/hmm: pass mmu_notifier_range to
 sync_cpu_device_pagetables
Thread-Index: AQHVHY87cnj6rYaF00uB6DOqwK5J5aaReNEAgAAqToA=
Date:   Sat, 8 Jun 2019 11:41:39 +0000
Message-ID: <20190608114133.GA14873@mellanox.com>
References: <20190608001452.7922-1-rcampbell@nvidia.com>
 <20190608091008.GC32185@infradead.org>
In-Reply-To: <20190608091008.GC32185@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::38) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d05033d-46b3-43bb-b701-08d6ec064493
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5007;
x-ms-traffictypediagnostic: VI1PR05MB5007:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR05MB5007B0248BAF930F089C6908CF110@VI1PR05MB5007.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0062BDD52C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39850400004)(396003)(376002)(366004)(136003)(189003)(199004)(53936002)(66946007)(316002)(66476007)(66556008)(26005)(64756008)(73956011)(6246003)(4326008)(186003)(2906002)(81166006)(25786009)(66066001)(8676002)(66446008)(81156014)(54906003)(86362001)(229853002)(8936002)(14454004)(1076003)(478600001)(966005)(6116002)(7416002)(3846002)(102836004)(6916009)(476003)(76176011)(6512007)(99286004)(14444005)(5660300002)(6486002)(68736007)(256004)(6306002)(52116002)(386003)(6506007)(71200400001)(71190400001)(33656002)(486006)(7736002)(305945005)(446003)(6436002)(2616005)(36756003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5007;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oo6gBf4xnKbnuLgjj+3gOZyAmqrCSoudzh6QQhuIXOxJwXWerg0BwM3MLb/FmZYDen+hzwRsqXde1gz4fbbE9MW5380nn2C8DdViZojxawz4Qs8tSrHS3VW+PGvkJTVaEEONDTOpuFk9g0mo1L7bQkFeDoIeHRQAn3UZ0q2MbKGOGdKF5SvsSGkUZMCav8dOCInP11RZ4x8vitV8NHglioRn4obmW+sy8Ld2EkNHVSLf1VafoSEUdnLfF5l5b5FVg3eZkXFZnKQNd/b5923jHl8DsAqp9fCZPu7Tg5TyoJcFlxiGH/efr/HKr1BEgoRVQHXcT5c3FpSTL7g2whImTeICvXhibJ8ErhDkV/XFDIkXGhaj9GGr7onZNYFuvp5E4DG7d5BKOL2DdiC/FFJ67XyHKWENSAjyCXKKNHQboiA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EECCBA142F666248ACACC3016329ACD8@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d05033d-46b3-43bb-b701-08d6ec064493
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2019 11:41:39.2878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5007
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jun 08, 2019 at 02:10:08AM -0700, Christoph Hellwig wrote:
> On Fri, Jun 07, 2019 at 05:14:52PM -0700, Ralph Campbell wrote:
> > HMM defines its own struct hmm_update which is passed to the
> > sync_cpu_device_pagetables() callback function. This is
> > sufficient when the only action is to invalidate. However,
> > a device may want to know the reason for the invalidation and
> > be able to see the new permissions on a range, update device access
> > rights or range statistics. Since sync_cpu_device_pagetables()
> > can be called from try_to_unmap(), the mmap_sem may not be held
> > and find_vma() is not safe to be called.
> > Pass the struct mmu_notifier_range to sync_cpu_device_pagetables()
> > to allow the full invalidation information to be used.
> >=20
> > Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> >=20
> > I'm sending this out now since we are updating many of the HMM APIs
> > and I think it will be useful.
>=20
> This is the right thing to do.  But the really right thing is to just
> kill the hmm_mirror API entirely and move to mmu_notifiers.  At least
> for noveau this already is way simpler, although right now it defeats
> Jasons patch to avoid allocating the struct hmm in the fault path.
> But as said before that can be avoided by just killing struct hmm,
> which for many reasons is the right thing to do anyway.
>=20
> I've got a series here, which is a bit broken (epecially the last
> patch can't work as-is), but should explain where I'm trying to head:
>=20
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/hmm-mirro=
r-simplification

At least the current hmm approach does rely on the collision retry
locking scheme in struct hmm/struct hmm_range for the pagefault side
to work right.

So, before we can apply patch one in this series we need to fix
hmm_vma_fault() and all its varients. Otherwise the driver will be
broken.

I'm hoping to first define what this locking should be (see other
emails to Ralph) then, ideally, see if we can extend mmu notifiers to
get it directly withouth hmm stuff.

Then we apply your patch one and the hmm ops wrapper dies.

Jason
