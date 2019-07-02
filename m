Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE3B05D911
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2019 02:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfGCAdq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Jul 2019 20:33:46 -0400
Received: from mail-eopbgr10080.outbound.protection.outlook.com ([40.107.1.80]:18124
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726652AbfGCAdq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 2 Jul 2019 20:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJtGx4PkCuRACTU0P1T4Qum92TEAZ9p57W6xppYw/7w=;
 b=gSzqYBaruYiU0Ht5pEVesU0DK3QcMfRsA/MnZRv03tzUFZrUvmh6ZXITLU0c/GQk+erbzTkCUV/xLAT7Sie0kXz89X1vmC/o26yrslY33H+oOJ+qQa9igt+5OTJyRTdA1bBA/YwRktEigR8QwOdMlZR9Bq/8XfJovoiP6MT+cwo=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6016.eurprd05.prod.outlook.com (20.178.127.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 22:59:16 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2032.019; Tue, 2 Jul 2019
 22:59:16 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Christoph Hellwig <hch@lst.de>
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
Thread-Index: AQHVHY87cnj6rYaF00uB6DOqwK5J5aa35HaAgAAxJwCAAALKgA==
Date:   Tue, 2 Jul 2019 22:59:16 +0000
Message-ID: <20190702225911.GA11833@mellanox.com>
References: <20190608001452.7922-1-rcampbell@nvidia.com>
 <20190702195317.GT31718@mellanox.com> <20190702224912.GA24043@lst.de>
In-Reply-To: <20190702224912.GA24043@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:208:c0::44) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57ec13c7-bc4b-47da-4719-08d6ff40e85e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6016;
x-ms-traffictypediagnostic: VI1PR05MB6016:
x-microsoft-antispam-prvs: <VI1PR05MB601689AD153B34CC5B7C4B6ECFF80@VI1PR05MB6016.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(199004)(189003)(53936002)(102836004)(6512007)(6486002)(8676002)(76176011)(1076003)(99286004)(229853002)(6916009)(3846002)(6436002)(66476007)(52116002)(71190400001)(6246003)(8936002)(186003)(305945005)(6116002)(81156014)(81166006)(54906003)(26005)(386003)(71200400001)(316002)(14454004)(4326008)(6506007)(25786009)(446003)(476003)(7736002)(256004)(66066001)(7416002)(11346002)(36756003)(64756008)(66556008)(2616005)(86362001)(478600001)(4744005)(5660300002)(2906002)(68736007)(66946007)(66446008)(73956011)(486006)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6016;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u5/HLB79NxZclFWXBUKTF4jOZlEqnhnnMDrMYxfhGbOltKcB4c403SDzQlF5ld9Lyn5NipC2rohko6DbRJt+LP998EA7Mf4CnYzIha6RflauOW4/FR9toJXtvkuX2/NtaAVB9VTNctSSm0tgClZS1msIkQUcjXSTncgJQj4feuWZX79f6YFWYU3IlAN9W0/doChmVt4LvVv2pKefZ7iv+WL08LckM+zN2rY/8SSV3+6SOarO2kpLhr2DgIarnXa5PBpGR5bKw1ghKIn6SaKwWRuVnceqqwmfFLt0tSDcGk0hnzNg6cfk5LsSfFT7CroOErx4eDBgN1UEQEJymrc/uEQdwu6ayrrQQDCI43CSVTTfBK1Cq4hXMdsqYpCZiKxs7ZxhlSrem3L9OwaSvB6fwn6mFATihYOGVNXzcgZ71os=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C21602A5B8952E41ACC1E76FEF5C90F2@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ec13c7-bc4b-47da-4719-08d6ff40e85e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 22:59:16.4254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6016
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 03, 2019 at 12:49:12AM +0200, Christoph Hellwig wrote:
> On Tue, Jul 02, 2019 at 07:53:23PM +0000, Jason Gunthorpe wrote:
> > > I'm sending this out now since we are updating many of the HMM APIs
> > > and I think it will be useful.
> >=20
> > This make so much sense, I'd like to apply this in hmm.git, is there
> > any objection?
>=20
> As this creates a somewhat hairy conflict for amdgpu, wouldn't it be
> a better idea to wait a bit and apply it first thing for next merge
> window?

My thinking is that AMD GPU already has a monster conflict from this:

 int hmm_range_register(struct hmm_range *range,
-                      struct mm_struct *mm,
+                      struct hmm_mirror *mirror,
                       unsigned long start,
                       unsigned long end,
                       unsigned page_shift);

So, depending on how that is resolved we might want to do both API
changes at once.

Or we may have to revert the above change at this late date.

Waiting for AMDGPU team to discuss what process they want to use.

Jason
