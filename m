Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38FC55A809
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Jun 2019 03:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfF2B0z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jun 2019 21:26:55 -0400
Received: from mail-eopbgr00068.outbound.protection.outlook.com ([40.107.0.68]:37738
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726643AbfF2B0z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jun 2019 21:26:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=dVU6EjM1E6sxjJV1Gh08uUh3hZgW2aEc3e8MWgnCa9z6NxRGFGvtE7dWjc9FxlA/7ipboaqtDXPFEFThrX4PxN5qxzddkagn8ddx1o5zIMzfdghpojVylG2Om7rg7DnxYSxLS6Xl/KfP1nZyIOEIPifQI53fHKgyz1bmOKJ+5/o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ag+6jEF+F6+OokBA0HD2aBHg7vs3K7kaRFcBJ0RKsFU=;
 b=gLDGta1UziHzN+lOtMnklHQ0EMwk4eYGvLcbFeEPT5xSQi3/iPL576mUPDvv+iYx2ljTU16wD9cbdliG2Dx4BDn7CETMKLq+VUMUp0Yk0y3DlOjIz0uHLbxxx/c2p+PGR/AvgPRk549l9iF9JyuvPxQDJdXsk7R1wX0HVbxN3r8=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ag+6jEF+F6+OokBA0HD2aBHg7vs3K7kaRFcBJ0RKsFU=;
 b=MPuo611VLENAsSCMac887wZ1q0uSeQOnghN9SEksR5gFupwSEJ2wwRL4Ls5ezorPjSn6v8AsZL/38HHQSaI4P/Gj44T0KFJMh4Ui1GYOTWBmgG7cwtOsDlMLo+i2RxpYJM6y4Hycvx1E0vcUeSwXcpmwi09TElAmHUVDagX7Afk=
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com (52.135.129.16) by
 DB7PR05MB5448.eurprd05.prod.outlook.com (20.177.123.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Sat, 29 Jun 2019 01:26:51 +0000
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::9115:7752:2368:e7ec]) by DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::9115:7752:2368:e7ec%4]) with mapi id 15.20.2008.017; Sat, 29 Jun 2019
 01:26:51 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Philip Yang <Philip.Yang@amd.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v4 hmm 00/12]
Thread-Topic: [PATCH v4 hmm 00/12]
Thread-Index: AQHVKtAUPOKL68Liy0elJQpXS2vDJqax3ckA
Date:   Sat, 29 Jun 2019 01:26:51 +0000
Message-ID: <20190629012642.GA22386@mellanox.com>
References: <20190624210110.5098-1-jgg@ziepe.ca>
In-Reply-To: <20190624210110.5098-1-jgg@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::38) To DB7PR05MB4138.eurprd05.prod.outlook.com
 (2603:10a6:5:23::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [207.164.2.174]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3cd0919-d863-4e93-f241-08d6fc30dc17
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR05MB5448;
x-ms-traffictypediagnostic: DB7PR05MB5448:
x-microsoft-antispam-prvs: <DB7PR05MB5448226E2534D95BB92B52B0CFFF0@DB7PR05MB5448.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0083A7F08A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(376002)(39850400004)(136003)(346002)(54164003)(189003)(199004)(7416002)(11346002)(66066001)(36756003)(68736007)(25786009)(26005)(4326008)(71190400001)(446003)(6506007)(14444005)(33656002)(256004)(486006)(316002)(478600001)(2616005)(54906003)(2501003)(102836004)(110136005)(66556008)(99286004)(71200400001)(386003)(2906002)(66446008)(305945005)(73956011)(3846002)(64756008)(86362001)(476003)(8936002)(14454004)(66476007)(52116002)(6246003)(7736002)(229853002)(81156014)(6486002)(81166006)(53936002)(5660300002)(8676002)(66946007)(76176011)(6116002)(6512007)(1076003)(6436002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB5448;H:DB7PR05MB4138.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uNvFoRmVGDVSHhDEFJZzAgE/XcB/C+Ez+jYnevegu9gBRMSBrlSAD+espuT54aQNqZA97MiUgQoBSQAgl7WGN2tX5rEpdQ96Is1Pz2p9HZmhKMg98vQjAcPXCmOV882cuwrIEIG7qpZ4WGaJsOQ9dSpdFtCA9ODIWadC3lwLDUR/eRWpNOcAs2DFnvz2HTONoOkTA8aXwOBQ57O5cvYS7/DoDtZR0V1eYh++iVVUHMJVh3DXAwoBEYEF3I2pbO4/nVsUK7FmvB/BWEOOOujyX1eLttwYF9w8vhgJpLgLCsB7oyBhMdFJj/UgTrgPXJUrTbfpS1uca3TgeXNSyH5QjVCYvBymRtS91AkpT5mg8T5Yivan29Dwpm5C21eA5OoKL/5HL1g9cjXhDxUmD6y1qXLKOuOQBL9gT3T60TFI02U=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <381E97B2C5DFB24EBF1D7DB5781C70C6@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3cd0919-d863-4e93-f241-08d6fc30dc17
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2019 01:26:51.2633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB5448
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 24, 2019 at 06:00:58PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
>=20
> This patch series arised out of discussions with Jerome when looking at t=
he
> ODP changes, particularly informed by use after free races we have alread=
y
> found and fixed in the ODP code (thanks to syzkaller) working with mmu
> notifiers, and the discussion with Ralph on how to resolve the lifetime m=
odel.
>=20
> Overall this brings in a simplified locking scheme and easy to explain
> lifetime model:
>=20
>  If a hmm_range is valid, then the hmm is valid, if a hmm is valid then t=
he mm
>  is allocated memory.
>=20
>  If the mm needs to still be alive (ie to lock the mmap_sem, find a vma, =
etc)
>  then the mmget must be obtained via mmget_not_zero().
>=20
> The use of unlocked reads on 'hmm->dead' are also eliminated in favour of
> using standard mmget() locking to prevent the mm from being released. Man=
y of
> the debugging checks of !range->hmm and !hmm->mm are dropped in favour of
> poison - which is much clearer as to the lifetime intent.
>=20
> The trailing patches are just some random cleanups I noticed when reviewi=
ng
> this code.
>=20
> I'll apply this in the next few days - the only patch that doesn't have e=
nough
> Reviewed-bys is 'mm/hmm: Remove confusing comment and logic from hmm_rele=
ase',
> which had alot of questions, I still think it is good. If people really d=
on't
> like it I'll drop it.
>=20
> Thanks to everyone who took time to look at this!
>=20
> Jason Gunthorpe (12):
>   mm/hmm: fix use after free with struct hmm in the mmu notifiers
>   mm/hmm: Use hmm_mirror not mm as an argument for hmm_range_register
>   mm/hmm: Hold a mmgrab from hmm to mm
>   mm/hmm: Simplify hmm_get_or_create and make it reliable
>   mm/hmm: Remove duplicate condition test before wait_event_timeout
>   mm/hmm: Do not use list*_rcu() for hmm->ranges
>   mm/hmm: Hold on to the mmget for the lifetime of the range
>   mm/hmm: Use lockdep instead of comments
>   mm/hmm: Remove racy protection against double-unregistration
>   mm/hmm: Poison hmm_range during unregister
>   mm/hmm: Remove confusing comment and logic from hmm_release
>   mm/hmm: Fix error flows in hmm_invalidate_range_start

I think we are done now, so applied to hmm.git, thank you to everyone.

I expect some conflicts in linux-next with the AMD DRM driver, we need
to decide how to handle them.

Jason
