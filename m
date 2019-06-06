Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA96F377CC
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 17:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbfFFPZy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 11:25:54 -0400
Received: from mail-eopbgr140071.outbound.protection.outlook.com ([40.107.14.71]:29819
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729077AbfFFPZy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 6 Jun 2019 11:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWcAHdRQnqzHGJAKFZ2q4k/hoMaigFKEFslTi5hvcF0=;
 b=iKCdZuFeCZfsiVUojWwWi4mal8IjuxvXWQpE5dHU4Rmio4RRjWH/hAOHy/xB7P66oIaBEaAY+rfYQIBHwaq+CyJkyPxjGEQS50Kva4mCMadlJ550q3Au751OvJlyAlL4BbcmppOjnRGuN8051tv8c+GP+c5HlPds9xqx8wqOvJA=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6333.eurprd05.prod.outlook.com (20.179.25.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Thu, 6 Jun 2019 15:25:49 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1965.011; Thu, 6 Jun 2019
 15:25:49 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Christoph Hellwig <hch@infradead.org>,
        Dave Airlie <airlied@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jerome Glisse <jglisse@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: RFC: Run a dedicated hmm.git for 5.3
Thread-Topic: RFC: Run a dedicated hmm.git for 5.3
Thread-Index: AQHVHHwepzoj9aeiT0uMK+ZOBPXi0w==
Date:   Thu, 6 Jun 2019 15:25:49 +0000
Message-ID: <20190606152543.GE17392@mellanox.com>
References: <20190523155207.GC5104@redhat.com>
 <20190523163429.GC12159@ziepe.ca> <20190523173302.GD5104@redhat.com>
 <20190523175546.GE12159@ziepe.ca> <20190523182458.GA3571@redhat.com>
 <20190523191038.GG12159@ziepe.ca> <20190524064051.GA28855@infradead.org>
 <20190524124455.GB16845@ziepe.ca>
 <20190525155210.8a9a66385ac8169d0e144225@linux-foundation.org>
 <20190527191247.GA12540@ziepe.ca>
In-Reply-To: <20190527191247.GA12540@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR01CA0022.prod.exchangelabs.com (2603:10b6:208:10c::35)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a638c50-562c-4409-f22b-08d6ea9340bd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6333;
x-ms-traffictypediagnostic: VI1PR05MB6333:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR05MB6333E902FD50A38DF264B3ABCF170@VI1PR05MB6333.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(376002)(39860400002)(366004)(199004)(189003)(43544003)(446003)(26005)(2616005)(476003)(11346002)(36756003)(186003)(486006)(6436002)(966005)(76176011)(14454004)(102836004)(6506007)(5660300002)(478600001)(1076003)(6306002)(386003)(52116002)(99286004)(54906003)(110136005)(86362001)(316002)(33656002)(8936002)(3846002)(6116002)(6246003)(66066001)(68736007)(305945005)(229853002)(6512007)(6486002)(66946007)(2906002)(53936002)(73956011)(66476007)(256004)(66556008)(71200400001)(71190400001)(7416002)(81156014)(8676002)(66446008)(4326008)(81166006)(64756008)(7736002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6333;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AbJMCQcRGx9GTjWdfJZrJkodaWaHU/JEUcYmTQNuI1w1hmmo5HaPZy3bzn+RxLTsmKB0jVP1VQbc+d43iYsdABOBAIMEr+PtjtaBEvdAFdcPsDKQ+6DO9h2ebIQvO8hoR4BKKkEZkMXy0rXbyC8ttg3Btv1bAaeJRHu/eIqndvUulVfqWVvMIuAqQV325AsIPDHoQ1kOg7lazgufEpym7HhgzStKIDX4uVCOppK7EqQi8i03qsmqDwP/KNXZIj6r8Zh69frCkB4cLPnFQJpdxt4YjyUOe8bQTlatVlvhDKh9pjNZ7QrqohJdoXaTko913JGpSQSiX7hy+90BxykxTKbQX76IpD9XiKwGq1gnczsUXNsnegLddEcBdPVmZ+em85ZXCNwb/HKkYmU/3+qr78ma9nsCxBm9GB4q0qvHXeY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <994523D7B122E1489B649951953089FD@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a638c50-562c-4409-f22b-08d6ea9340bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 15:25:49.2982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6333
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 27, 2019 at 04:12:47PM -0300, Jason Gunthorpe wrote:
> On Sat, May 25, 2019 at 03:52:10PM -0700, Andrew Morton wrote:
> > On Fri, 24 May 2019 09:44:55 -0300 Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
> >=20
> > > Now that -mm merged the basic hmm API skeleton I think running like
> > > this would get us quickly to the place we all want: comprehensive in =
tree
> > > users of hmm.
> > >=20
> > > Andrew, would this be acceptable to you?
> >=20
> > Sure.  Please take care not to permit this to reduce the amount of
> > exposure and review which the core HMM pieces get.
>=20
> Certainly, thanks all
>=20
> Jerome: I started a HMM branch on v5.2-rc2 in the rdma.git here:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
> https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=3Dhm=
m

I did a first round of collecting patches for hmm.git

Andrew, I'm checking linux-next and to stay co-ordinated, I see the
patches below are in your tree and now also in hmm.git. Can you please
drop them from your tree?=20

5b693741de2ace mm/hmm.c: suppress compilation warnings when CONFIG_HUGETLB_=
PAGE is not set
b2870fb882599a mm/hmm.c: only set FAULT_FLAG_ALLOW_RETRY for non-blocking
dff7babf8ae9f1 mm/hmm.c: support automatic NUMA balancing

I checked that the other two patches in -next also touching hmm.c are
best suited to go through your tree:

a76b9b318a7180 mm/devm_memremap_pages: fix final page put race
fc64c058d01b98 mm/memremap: rename and consolidate SECTION_SIZE

StephenR: Can you pick up the hmm branch from rdma.git for linux-next for
this cycle? As above we are moving the patches from -mm to hmm.git, so
there will be a conflict in -next until Andrew adjusts his tree,
thanks!

Regards,
Jason
(hashes are from today's linux-next)
