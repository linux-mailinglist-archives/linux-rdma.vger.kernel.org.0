Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32A30DD058
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Oct 2019 22:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731569AbfJRUgZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Oct 2019 16:36:25 -0400
Received: from mail-eopbgr130080.outbound.protection.outlook.com ([40.107.13.80]:45334
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727291AbfJRUgY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Oct 2019 16:36:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXS8vb2Jzqod84MSa1ewYRUvPkNE9WagpIfBGh8EST9TAuHU0oWl4dsgUxiiNvRpmzRi0RZ1+nVpS+uKkb/tmFbmLW2oL8u4TyskF/dRq/yBhG7UWEebdOJUbJB4oE4AV9ITzjvPiXE+a/C9TNX+0Oc8YDrJ8HDsx0wcrrrvP3NL8/6QVtTAPUJbNJ0okv36ZpLVn/nBU2DSRybcVOJXpD+b5HLaVXGabVsMJLYa7flTa2YgpRoGimCRRgavkwqDFjFpURwpIvtNXQPaLSBjkz+PMD5RC9DTUibFbORaEmif30fxiGLyeDHntwHbdVhc5+cyCkhStujZVgOvTKmC0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smXqpb9251kp69aNvxZPS9Z8+1UgwbybVdHvLUJQFGY=;
 b=RUEOQJMm5z9iEAFJzsgot+pOk8m2g0pXa8G2s6BJ18y/FzAAGPJgpyO86UXFkSVqmo12zxbJrOiOXBOJMtwlakymxnFq1VhJg9UJ5TTey9ryZEQ5KOkJePEXraSLTYWlBHajvspDzsyNgKFPT5r650JnBxXPyVQS45Ko5MKkaCtkzW/2E/wAjdowrzxwRimT9aZsRjpri3KwLxPydrf0dbLKn7SxDgDKcR0bjt0ofTdAFo5g0pGEvg4kXFYbbgsQfGM/yQbfBXdNOPkEhIUEln/HxWNKlvQlxpo95Ac+u8nNLVffxPnZM1mwI30lTxzS6LpMAoWgH51sqeBqZeujdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smXqpb9251kp69aNvxZPS9Z8+1UgwbybVdHvLUJQFGY=;
 b=r53Jgk999IoxDUKHtfa7EIQ8UnoLc3R0e6RXPbys46Obfs/5j9L5s+yXrWt5Gg46/UeUF2kIUxfWeKlnXYka/+swCuQHxAEMQb/RgnXbksWLe5WjOoKUNsESOEUww8T/oD+0dQO2Z/HQqGJKTODinbGLXXJ9n34+GD3nE+MNVYc=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4973.eurprd05.prod.outlook.com (20.177.52.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 18 Oct 2019 20:36:19 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0%7]) with mapi id 15.20.2347.023; Fri, 18 Oct 2019
 20:36:18 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
CC:     "Yang, Philip" <Philip.Yang@amd.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH hmm 00/15] Consolidate the mmu notifier interval_tree and
 locking
Thread-Topic: [PATCH hmm 00/15] Consolidate the mmu notifier interval_tree and
 locking
Thread-Index: AQHVg4Sqa7CCxCToXEeTrrYAqVQVhqdc+JgAgAB3OACAARovgIAAficAgAAF3YCAAdJKAA==
Date:   Fri, 18 Oct 2019 20:36:18 +0000
Message-ID: <20191018203608.GA5670@mellanox.com>
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <bc954d29-388b-9e29-f960-115ccc6b9fea@gmail.com>
 <20191016160444.GB3430@mellanox.com>
 <2df298e2-ee91-ef40-5da9-2bc1af3a17be@gmail.com>
 <2046e0b4-ba05-0683-5804-e9bbf903658d@amd.com>
 <d6bcbd2a-2519-8945-eaf5-4f4e738c7fa9@amd.com>
In-Reply-To: <d6bcbd2a-2519-8945-eaf5-4f4e738c7fa9@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR20CA0044.namprd20.prod.outlook.com
 (2603:10b6:300:ed::30) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.51.117.131]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69e9ab54-0717-40b2-861b-08d7540ad427
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR05MB4973:
x-microsoft-antispam-prvs: <VI1PR05MB4973E5D04B92642A40EEE0E6CF6C0@VI1PR05MB4973.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(189003)(199004)(186003)(66066001)(305945005)(33656002)(3846002)(7736002)(71190400001)(486006)(4326008)(6116002)(229853002)(86362001)(6436002)(6486002)(7416002)(14444005)(71200400001)(81166006)(2616005)(8676002)(256004)(81156014)(8936002)(6916009)(54906003)(66946007)(476003)(64756008)(66556008)(66476007)(446003)(316002)(6506007)(11346002)(52116002)(6246003)(5660300002)(478600001)(76176011)(36756003)(1076003)(14454004)(102836004)(386003)(99286004)(25786009)(26005)(2906002)(66446008)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4973;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UPF+keoznRhlCBtOJNRn0zkttxRh9aDiR7740wSN6aP5QvRQduueDoET4X5x1pwWC7iubmR6zTWcChzGQhe2+MVD4KJDI75s1atMhJKtopvkCy0Bj5vfXOijthH8T+dAWcrzr+WZ8VgxWMj75A6sOUH2aoxwkET7So1hRNBhguEw6JCSDNdu1dA+K79onggltu8YTaZ0vij34iu+tQ5S6Ej2jEn8QnHfKAPgQ2KByQWyTF5gbNMLdHSFvO85QEfrxJcVmKifL9eDGOEFGKcPipCbWU6CgN57IFuTAehoFPGphofEOPr9hnganzBPOWic9c/wwdQY80SYTRqIdq/LS2KhpMtFMx592ESJtoDUFToHWtu8rM+ZofpGwtZvspYRUa0ZqaUKx98FCH8zcCYsYxf9j1HOLHBTrYC7Ml7otTY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C97D0CFCD1F5B645A1B272BD732EBC74@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e9ab54-0717-40b2-861b-08d7540ad427
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 20:36:18.5468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: whpnjBYJtkeFOwuFODiM58DUvsXdve63q0hhi7+SAmJNW+ERnWAS13rlOE/iRUgkf4ZNSY7A4Px29zedbec9uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4973
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 17, 2019 at 04:47:20PM +0000, Koenig, Christian wrote:

> > get_user_pages/hmm_range_fault() and invalidate_range_start() both are
> > called while holding mm->map_sem, so they are always serialized.
>=20
> Not even remotely.
>=20
> For calling get_user_pages()/hmm_range_fault() you only need to hold the=
=20
> mmap_sem in read mode.

Right
=20
> And IIRC invalidate_range_start() is sometimes called without holding=20
> the mmap_sem at all.

Yep
=20
> So again how are they serialized?

The 'driver lock' thing does it, read the hmm documentation, the hmm
approach is basically the only approach that was correct of all the
drivers..

So long as the 'driver lock' is held the range cannot become
invalidated as the 'driver lock' prevents progress of invalidation.

Holding the driver lock and using the seq based mmu_range_read_retry()
tells if the previous unlocked get_user_pages() is still valid or
needs to be discard.

So it doesn't matter if get_user_pages() races or not, the result is not
to be used until the driver lock is held and mmu_range_read_retry()
called, which provides the coherence.

It is the usual seqlock pattern.

Jason
