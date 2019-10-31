Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37791EB62E
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2019 18:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbfJaRer (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 31 Oct 2019 13:34:47 -0400
Received: from mail-eopbgr70079.outbound.protection.outlook.com ([40.107.7.79]:17415
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728742AbfJaRer (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 31 Oct 2019 13:34:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyDVHc9u4ojQxUHloUhl4xtKdMjsIsVyUFwQgOPp01FlAywTYzFg738/jdCR7p1QH/zCf32Il+9gBUWHCZMWwVsl3elSRGj4Cij0n9HLdYLHHg/5k2OjHWHURjOBPCml+4rdTph+Ojt2k6Bk9RGwKhjJupYcQzP8BXyd39/BEgJayiU2ubKI49HR90SUfDsboUlTFJHymDblXYJERjnFDmzyUEEQIm/LyxcNGrdf/len+vk+zmxk1ygQkKfsSDyEEu4feCcZeIVQkWvDgO7myfnjz/4Ua2Z4xxG1vzLx6U8xABKAelebRyjYGAPE1K4JaLzsmxhc4q4vUm0AWOS78Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBtQzx54/3eZlsu3gdbnLEXdBp6ghsGP/eNaHUgtYsU=;
 b=Yx93msjxTlfZaNb/pwzOLDnI/flCVcoB7TwOyP1gKZVnbFeECTp1Xle+ZoiKbo1AqEBtxLBNzNiso3C4o+pJDwPgQoDMgAZvkrQhd7nvvNxR8LLltOy4YKjjZ4IzBDVJj3uDinTiejx08qjvLxmKOUVPSqnX5ix8eBo1QtDsFSXMyboI67cuSQIhR3e6nKZoPBsyhKl+5xQpjqolIXBGq1qF7Sj6L6H58LL2fD+oPt9zdUJRjR+C0tvJ8QcU0Cx6Ol+Cj31GMtzV0g4PttEfhdPewCbp2wd/iz/mCQlwETSpOM6WroUmq2/t6OzHeuriaMiL6UUR/a/wceH+w+VnlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBtQzx54/3eZlsu3gdbnLEXdBp6ghsGP/eNaHUgtYsU=;
 b=ejy2WaqecyooCZU5PephBr/QvnaLKI7+1yyylG+EzBwDEWMZ4MbVT7ks0aHuMBSayupXtp1zpu6GSXCbSeDE6/PuO7d7pfKgnkuF90AEj8QRKQPhN29qNIBC2/J2zKS4w+/DGathIvDZh5DAICNlz4LCf1NIm2DY5K3bpMH7oB4=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4671.eurprd05.prod.outlook.com (20.176.3.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Thu, 31 Oct 2019 17:34:42 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2387.028; Thu, 31 Oct 2019
 17:34:42 +0000
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
Thread-Index: AQHVidvRl0DiLfVRckS4hHS5dqmJyadx8UKAgAA3LICAACCkgIABo4oAgADQ2QCAAE/3AIAAAcwA
Date:   Thu, 31 Oct 2019 17:34:42 +0000
Message-ID: <20191031173438.GL22766@mellanox.com>
References: <20191023195515.13168-1-rcampbell@nvidia.com>
 <20191023195515.13168-4-rcampbell@nvidia.com>
 <20191029175837.GS22766@mellanox.com>
 <3ffecdc6-625f-ebea-8fb4-984fe6ca90f3@nvidia.com>
 <20191029231255.GX22766@mellanox.com>
 <f42d06e2-ca08-acdd-948d-2803079a13c2@nvidia.com>
 <20191031124200.GJ22766@mellanox.com>
 <a6b49a4e-a194-ce0b-685f-5e597072aeee@nvidia.com>
In-Reply-To: <a6b49a4e-a194-ce0b-685f-5e597072aeee@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:208:c0::35) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3434cb44-4f17-427b-931a-08d75e289cd3
x-ms-traffictypediagnostic: VI1PR05MB4671:
x-microsoft-antispam-prvs: <VI1PR05MB467156EAAEA441F7125EE3BACF630@VI1PR05MB4671.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02070414A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(189003)(199004)(6436002)(4326008)(36756003)(186003)(66476007)(476003)(66556008)(64756008)(6916009)(66446008)(6506007)(33656002)(66946007)(26005)(316002)(6246003)(11346002)(446003)(2616005)(486006)(66066001)(102836004)(25786009)(229853002)(6486002)(14444005)(6116002)(478600001)(99286004)(14454004)(54906003)(256004)(386003)(6512007)(3846002)(71200400001)(76176011)(71190400001)(86362001)(1076003)(305945005)(52116002)(7736002)(81166006)(81156014)(8676002)(2906002)(5660300002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4671;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qfPtVM8E9Aj187lYTgVJ6BVN6t/xNP1eUbG5C24IqkRVhkzw05cywjPexGDLeqrzjvBrfkxFiOfBuzgqN7XbJD3DUxpuNJEhDL+Ycf/H8Un+84CYaoTrKGAYjYO3EL04Pj9h482rX0zV2j/JB5OjryUxzWMlBhB+Mb6gipho3ho1hvs/J/WLip4xYb0LBb5RMEGduPMbohls8J9XMKcqc354rWwhdYN59KgnC3huEOGUcZOvz5IA2LliU1LBuVapwMH7syOLWzfu5jZB16if7bcHdhiFLyw+QldtrJ6N1GeGKbZ1LooFDRbeark54hxjQh2TlEPLipWWhO/WGpkWJEeR3LVh83eibfK6bNV9yXJurSMv1n23K9pEEn5Yc+jhUrvxdumuSy4cEkZVQdJQGxDmYyhpkyNZpdaiTpeT4w8AYOZM19VIBTRq76F0QfHT
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7B4A1F8CF57DCC4C90A11D864E35D0FD@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3434cb44-4f17-427b-931a-08d75e289cd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2019 17:34:42.1157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rfrxOddc/pWv6ibOW6NX7zTWWW7a0fxNSQ0UBhFAgmZ3bWPY8xFgyTr5WKmflj9FPLf0tMqP/7FXQpWghtw81w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4671
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 31, 2019 at 10:28:12AM -0700, Ralph Campbell wrote:
> > > > > > It seems especially over-complicated to use a full page table l=
ayout
> > > > > > for this, wouldn't something simple like an xarray be good enou=
gh for
> > > > > > test purposes?
> > > > >=20
> > > > > Possibly. A page table is really just a lookup table from virtual=
 address
> > > > > to pfn/page. Part of the rationale was to mimic what a real devic=
e
> > > > > might do.
> > > >=20
> > > > Well, but the details of the page table layout don't see really
> > > > important to this testing, IMHO.
> > >=20
> > > One problem with XArray is that on 32-bit machines the value would
> > > need to be u64 to hold a pfn which won't fit in a ULONG_MAX.
> > > I guess we could make the driver 64-bit only.
> >=20
> > Why would a 32 bit machine need a 64 bit pfn?
> >=20
>=20
> On x86, Physical Address Extension (PAE) uses a 64 bit PTE.
> See arch/x86/include/asm/pgtable_32_types.h which includes
> arch/x86/include/asm/pgtable-3level_types.h.

That is the content of the PTE, not the address of the PTE. In this
case the xarray index is the 'virtual' address of the fictional device
and it can easily be 32 bits with no problem

Jason
