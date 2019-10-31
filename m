Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD8A1EB074
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2019 13:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfJaMmI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 31 Oct 2019 08:42:08 -0400
Received: from mail-eopbgr30044.outbound.protection.outlook.com ([40.107.3.44]:59538
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726506AbfJaMmI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 31 Oct 2019 08:42:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeOq8C9g0kdZUjjczHs7Xad72XIL80YIY571PEOMRpiAKmCHKdpIVYEsJbMd5ru2q3MCRMzmkkocBnehOLzWkTovdKDtZYoDQJiUVx5bA9uH6MxQsIPV8PUvgAz/md4QY+WUPGxTNsk9++sydcr2pQ3fmS2hQF5pSlEuX7GpjEGqfEm3ZO+yBZKCs477AWOkFI1R98WQmCiBO49C9s0fhyIiidF21I3hl6XO9TPaNjroNX0Q8wmaPSa4JUSVURh186RaasPscnbuZY9W/bD/V+lFj2wbOkH0CZagXJ3eexWZAY+XHwiB+pEw9FbnfdFMFevb/ZL5phz7rK63jCDFFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4+BqV5ABwCFwJ4oVNgRoZ1Nbe1WjCm6P0NnqGhgMK4=;
 b=E9WC2BnvyUZAGz/n9baw+t6sQ/aMD7vJ/pvkdt7YcxvYz9v6FQhmQOyyqbTLq/PrFu07Jt1ZsDLHNfT0BnduX61g8ebnvR1iiDfyRGUhuFQtNHkjww6NZVILUxQq6B+29eS6FH4W169087Bulkui622TIyXoMGXna+ePf6OJJ9gZzABx70xZIw3b13rVQ0mIN7CAO2IvRiGZh5O13/MNDyMXyVQEAZtYeJAlFkrhEqAVN5+XM/ClTc0ddYK/DdJQZ/ZvtpPpcEiDYTfJP+kkyn36Z9a3XlKRw32kDFKppqmXQRyMuDupSyEI6tfIWz4YvgcQrvP5AQ5s1s72VZWpXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4+BqV5ABwCFwJ4oVNgRoZ1Nbe1WjCm6P0NnqGhgMK4=;
 b=KW35GtCHtISOl+Kk8nlRCHUVNCeYcoZ0HVMopzupFGSpfJXklzQ1xLNL3QwT4tkW/lPihnOc8rOMI7/bk4ueAHHhCy5IcgTJL9GOW8AJvxgj+kWmMSX9nsR1J+zUdSV3uRe0WgPa4YsEdxZx40LZkrlMzu1mu8ukedoSaZf6WKA=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5840.eurprd05.prod.outlook.com (20.178.123.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.23; Thu, 31 Oct 2019 12:42:04 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2387.028; Thu, 31 Oct 2019
 12:42:04 +0000
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
Thread-Index: AQHVidvRl0DiLfVRckS4hHS5dqmJyadx8UKAgAA3LICAACCkgIABo4oAgADQ2QA=
Date:   Thu, 31 Oct 2019 12:42:03 +0000
Message-ID: <20191031124200.GJ22766@mellanox.com>
References: <20191023195515.13168-1-rcampbell@nvidia.com>
 <20191023195515.13168-4-rcampbell@nvidia.com>
 <20191029175837.GS22766@mellanox.com>
 <3ffecdc6-625f-ebea-8fb4-984fe6ca90f3@nvidia.com>
 <20191029231255.GX22766@mellanox.com>
 <f42d06e2-ca08-acdd-948d-2803079a13c2@nvidia.com>
In-Reply-To: <f42d06e2-ca08-acdd-948d-2803079a13c2@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR02CA0081.namprd02.prod.outlook.com
 (2603:10b6:208:51::22) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c76b79f7-458c-4f91-ec16-08d75dffbb67
x-ms-traffictypediagnostic: VI1PR05MB5840:
x-microsoft-antispam-prvs: <VI1PR05MB5840721564872BC513288BFFCF630@VI1PR05MB5840.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02070414A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(189003)(199004)(36756003)(71200400001)(71190400001)(476003)(14444005)(446003)(11346002)(2906002)(2616005)(256004)(86362001)(33656002)(1076003)(6116002)(5660300002)(6916009)(486006)(316002)(3846002)(6512007)(229853002)(6436002)(54906003)(4326008)(6486002)(26005)(8676002)(186003)(25786009)(99286004)(6246003)(305945005)(52116002)(81166006)(81156014)(7736002)(386003)(76176011)(6506007)(478600001)(102836004)(8936002)(66446008)(66066001)(14454004)(66946007)(66476007)(64756008)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5840;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +pvlvGR4nSEsPJ3TrSyWLzaW9U3MwNNBia1b+okW0wcfwsetP35xdywwPNUruqPxmFRJJhfIJgzftznThKbaHcuXZhk8w51F6QNgWFIUZgHj3YZy4mVbp7sUUG7hff/mv//TN+0/u1GhtyV27bTz6vWngJakDjf3xiDNrrDf9bGCVEvR1zlvqzxju9yWhOhbdEeMvxgPvnMNOv+U2cKzPu22+pwmeuJvOxguPAqnII7wRGwR2DIJuR6hKe+ZKCLRPrBSajXX6KFplOnRyq/mkvNei28Rb3PTqbVbqagHNF2JmQUi4+1Bcj4C6MbGxMDZ6R1Wf/zbjh6i/IApDn6h+3RXP+UQgb66uPPYs2nk7NHIljijKV3vGUvl8NiqRkvReb93LkRFy9juwZTeuG4vd5TZQvlfOII16GvyTxvq/btWtCJgCmzdLz7PKndiZ4M7
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20704D111969E44091B76631E43CF7B2@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c76b79f7-458c-4f91-ec16-08d75dffbb67
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2019 12:42:04.1106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: irErugRJVLgiMcxkh1a3QVBjvIfaKXWSpTu1mBDKGJHz+uysgSNHi0D+Hk7nt7IsGvpSN3FPSEef6vxO/Xim0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5840
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 30, 2019 at 05:14:30PM -0700, Ralph Campbell wrote:

> > Well, that is good, is it also under drivers/char? It kind feels like
> > it should not be there...
>=20
> I think most of the test modules live in lib/ but I wasn't sure that
> was the right place for the HMM test driver.
> If you think that is better, I can easily move it.

It would be good to get the various test people involved in this, I
really don't know.
=20
> > > > It seems especially over-complicated to use a full page table layou=
t
> > > > for this, wouldn't something simple like an xarray be good enough f=
or
> > > > test purposes?
> > >=20
> > > Possibly. A page table is really just a lookup table from virtual add=
ress
> > > to pfn/page. Part of the rationale was to mimic what a real device
> > > might do.
> >=20
> > Well, but the details of the page table layout don't see really
> > important to this testing, IMHO.
>=20
> One problem with XArray is that on 32-bit machines the value would
> need to be u64 to hold a pfn which won't fit in a ULONG_MAX.
> I guess we could make the driver 64-bit only.

Why would a 32 bit machine need a 64 bit pfn?

Jason
