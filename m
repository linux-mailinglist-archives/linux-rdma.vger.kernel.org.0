Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17110E21AF
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 19:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbfJWRYu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 13:24:50 -0400
Received: from mail-eopbgr30078.outbound.protection.outlook.com ([40.107.3.78]:10417
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728583AbfJWRYt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 23 Oct 2019 13:24:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSoIh2Re3QHAc2joYgOWb+Me3GXRpED+0zTPRYajXTdY0KeHwJy0YY96BZBFJmjfWeHyLeHSvCU7wrAKRd4IxReFstNBeizO3WxMV+vEuW0+mfusMveKh8LFvcd1ZLGW3LohNbsukRBHXO27I7YBbpz1UJ52HTswwziJpNDepnhhKo2cvsNFHtKGem7cbiwfyIGly+YvkLSv4d6dzV/J4l8i+lbLDn5PPPeBc1/QEMUGjn4kYmCpYZMkehxSN+bxj5yGy86LLoWfwRtIOuhsrBQcLw4/xnndGAiJ/6LfPq8A14P7Ja9FBzqlELpIK1yLuKZ1BAIaLP01tCQZFJcK0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e27RJwgohDjB5rPJYMfqo9M5TDj75Snml902/edeD64=;
 b=RBadsEmZujOi/G3z+o/KoCPUFGoZqmqMHI8gNv4TNayYClzMJJpqU7Jq50I49BCWkzu6EWqv3MRD7bPXMk5vqAvlmb9+QqjtPdYIEO4tzGip2bBtLfd4JSGMo+ta7LIPEWVZ1lDRM/zT5EilUfJ3LMAWXD6gr7cns5QmrX/00czhfq+bketAl/QTuziRhdcNHe8lhavizZelSmxYJtxwwyWwMErLCOK/MreyG+zQwoydwCOXjOyAZh6ZzYO3F275mtd4a3HGpq6kzzYVokbETBCbq7tXdooZJxy8B6AkCDa80B/Yygn6T0Qy0ie4xcFU2KmukRnrXUFrFJ9VwJywMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e27RJwgohDjB5rPJYMfqo9M5TDj75Snml902/edeD64=;
 b=p5PJZX8QiqkvZDVkoXS+MksknfUpTBD+uWoELKAEeh4p4/HGbAm+rADHP/zSyQgek/c+GVOdib4vaNsZeu5Mx1gzD0/1scToH0aMD1PMT6ITits7izXr7FqcxMDB7hitHfxyvtjHz94W9jLGU43zioNZMMvWowa3RW69N1HawLI=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4239.eurprd05.prod.outlook.com (52.134.123.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.22; Wed, 23 Oct 2019 17:24:45 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0%7]) with mapi id 15.20.2367.025; Wed, 23 Oct 2019
 17:24:45 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Jerome Glisse <jglisse@redhat.com>
CC:     "christian.koenig@amd.com" <christian.koenig@amd.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Yang, Philip" <Philip.Yang@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH hmm 00/15] Consolidate the mmu notifier interval_tree and
 locking
Thread-Topic: [PATCH hmm 00/15] Consolidate the mmu notifier interval_tree and
 locking
Thread-Index: AQHVg4Sqa7CCxCToXEeTrrYAqVQVhqdc+JgAgAB3OACAARovgIAAficAgAAF3YCAAdJKAIACvAUAgAGLqgCAAAilAIAADDUAgAEY24CAAHZYgIABL+8AgAAGggCAAHr4gIAACQcA
Date:   Wed, 23 Oct 2019 17:24:45 +0000
Message-ID: <20191023172442.GX22766@mellanox.com>
References: <20191018203608.GA5670@mellanox.com>
 <f7e34d8f-f3b0-b86d-7388-1f791674a4a9@amd.com>
 <20191021135744.GA25164@mellanox.com>
 <e07092c3-8ccd-9814-835c-6c462017aff8@amd.com>
 <20191021151221.GC25164@mellanox.com>
 <20191022075735.GV11828@phenom.ffwll.local>
 <20191022150109.GF22766@mellanox.com>
 <20191023090858.GV11828@phenom.ffwll.local>
 <13edf841-421e-3522-fcec-ef919c2013ef@gmail.com>
 <20191023165223.GA4163@redhat.com>
In-Reply-To: <20191023165223.GA4163@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR02CA0137.namprd02.prod.outlook.com
 (2603:10b6:208:35::42) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f6b4a1d-3abc-4baf-6e57-08d757dde5f7
x-ms-traffictypediagnostic: VI1PR05MB4239:
x-microsoft-antispam-prvs: <VI1PR05MB42391529A72E1D681D6E323FCF6B0@VI1PR05MB4239.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(189003)(199004)(71190400001)(36756003)(6246003)(6436002)(86362001)(4326008)(6116002)(1076003)(3846002)(6916009)(6486002)(33656002)(2906002)(71200400001)(478600001)(7416002)(5660300002)(26005)(66446008)(76176011)(11346002)(486006)(64756008)(476003)(256004)(52116002)(66476007)(386003)(6506007)(66556008)(66946007)(186003)(305945005)(7736002)(446003)(66066001)(99286004)(6512007)(81166006)(81156014)(25786009)(8936002)(8676002)(14444005)(229853002)(2616005)(316002)(102836004)(14454004)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4239;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /eDCrbN2DZ7jIHyX3sGWvx8DgQk9MjRGIiKuxS3Lsl935gUs7E+g91bhJwfIHxLFxgdAE+/hPJWFdMIxN7sxANaES+49qJESfLhmxuoSLrdS8viRM6yy+6JRLGRZHDyj4+8PoUMT8ArRtrhgxDmwN0k1N3FRh/ebqplcDfxPclckH6mVCR2Gset6aFwB0YBUOaexLD4aNg6Pjnn9MWpKdRws+jl3XnLsHiLWOLzA+wIuMeCui4VJAVcJDjtwhgmzcoORQ3RwN5P7u0v/3ll3qq62pQx7BU36gSQG4aNHJgdgWbtabVcYwLtLcLri9DDSEMKP2LkjKMAL8b9dOHQYAMNzwDHmCXONbJ+hz3xYWArNOJWFTznOIf7bQz459TRux6R9gKna115MLyXE+G3wFO0/pmDgwGkNyz7Ntz2ATS4SzCkKzKu4hBcq0S3mYb8E
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ECB58748CAB4784EBC55A1889CAC7D2B@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6b4a1d-3abc-4baf-6e57-08d757dde5f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 17:24:45.5170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jd8rcyB6pWt4/zZXZYHvAYuYU/mqvHSucyjl1/KDFNaq8LOiiu5qcuSve8X4a9z++8cRiHm9oN56WcEN+qWeww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4239
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 23, 2019 at 12:52:23PM -0400, Jerome Glisse wrote:
> > Going another step further.... what hinders us to put the lock into the=
 mmu
> > range notifier itself and have _lock()/_unlock() helpers?
> >=20
> > I mean having the lock in the driver only makes sense when the driver w=
ould
> > be using the same lock for multiple things, e.g. multiple MMU range
> > notifiers under the same lock. But I really don't see that use case her=
e.
>=20
> I actualy do, nouveau use one lock to protect the page table and that's t=
he
> lock that matter. You can have multiple range for a single page table, id=
ea
> being only a sub-set of the process address space is ever accessed by the
> GPU and those it is better to focus on this sub-set and track invalidatio=
n in
> a finer grain.

mlx5 is similar, but not currently coded quite right, there is one
lock that protects the command queue for submitting invalidations to
the HW and it doesn't make a lot of sense to have additional fine
grained locking beyond that.

So I suppose the intent here that most drivers would have a single
'page table lock' that protects the HW's page table update, and this
lock is the one that should be held while upating and checking the
sequence number.

dma_fence based drivers are possibly a little different, I think they
can just use a spinlock, their pattern should probably be something
like

fault:
 hmm_range_fault()

 spin_lock()
 if (mmu_range_read_retry()))
     goto again
 dma_fence_init(mrn->fence)
 spin_unlock()

invalidate:
 spin_lock()
 is_inited =3D 'dma fence init has been called'
 spin_unlock()
 if (is_inited)
    dma_fence_wait(fence)


I'm not sure, never used dma_fence before. The key thing is that the
dma_fence_wait() cannot block until after the mmu_range_read_retry() &
unlock completes. Otherwise it can deadlock with hmm_range_fault().

It would be nice to figure this out and add it to the hmm.rst as we do
have two drivers using the dma_fence scheme.

Also, the use of a spinlock here probably says we should keep the lock
external.

But, it sounds like the mmu_range_notifier_update_seq() is a good
idea, so let me add that in v2.

Jason
