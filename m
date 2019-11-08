Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 800B3F3CE5
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2019 01:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbfKHAdI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Nov 2019 19:33:08 -0500
Received: from mail-eopbgr40065.outbound.protection.outlook.com ([40.107.4.65]:55366
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725940AbfKHAdI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 7 Nov 2019 19:33:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBcMBjTI71dP/+ipjNzMnQnW9kLBOcXIQdVblia02dSJuZMP719DiaYIP1v2IW+TCgail6QcRtuhpI47Xfa6qFGxJSTxco5JU83BnsjRXuXXoXfvwRQpPYBJLn80DMCsu45lzL4Stt+qMNZOF+Gf9d01JoplAc+/ZXNmWzvXLOgZL+/kvY0BAq6s6NqC3MhCM1Br4I2zu+lhkNm6HmWvqiko1haeakVnWpjbn/3M+gZ5v4QXXG6Ra6k1nSsztRVMiyOZwZqpnm3fMVqvpkI9evdLSwekofBvqPbC9C7UOsSxE/owbRUoDB6PA/jPu9W1bDd671okObUycnSwamemOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYaNCgu6fDmNG38MoUWz5BSjWcnqxxpDYrDST05027s=;
 b=OdVgxmzYIn7MYa+7JC1d7IdVUxZsaUHPSrTbCXl6Q4aJjXmS5n3qplXw9buAnUIGHSjGEr3/HU9edHGFPwS41ACXyF7BUsqd8mut3hkwof0bo7hVuBWkJ5Ayn6tThOXjv1LjlAx7TLfKCg8WMNMNq8J/lN2WX0dsS4EjLnPqRSRR0+BG9j90eWhmv3BmaEKAmM7gxkh2/RUzIuveghOTlCo7u36woqisenNmfu67L3QiExoGx7i4Dz9HCBlOPikksscH7RDfTaMZNwCrTaSq9plAV0/jJfq4B2JVGHLiei03+5YWTtezKnqlFKW/btD9K1DzDWFaUhmM5LESZZ5PrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYaNCgu6fDmNG38MoUWz5BSjWcnqxxpDYrDST05027s=;
 b=M77qH3/0OVMBl+zFKOfz7HKYPC1wr2cUwYE0ijUr9NSIkLmD9VRQg4ncsCCrLb+Ku/+klJYktOm3Hkkix49AxSDSpZUucx9QI0RWQ+iOHlWkEJrZvVasw8ib0HCCII2HLFrCxrZNxyEH4/usmFae5QwVm3wl7ek4zZ3ytAYq5Is=
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com (52.135.129.16) by
 DB7PR05MB5658.eurprd05.prod.outlook.com (20.178.104.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Fri, 8 Nov 2019 00:32:25 +0000
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::451b:7808:4468:e116]) by DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::451b:7808:4468:e116%7]) with mapi id 15.20.2430.023; Fri, 8 Nov 2019
 00:32:25 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Jerome Glisse <jglisse@redhat.com>
CC:     John Hubbard <jhubbard@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Petr Cvek <petrcvekcz@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v2 02/15] mm/mmu_notifier: add an interval tree notifier
Thread-Topic: [PATCH v2 02/15] mm/mmu_notifier: add an interval tree notifier
Thread-Index: AQHVjcvJYOye0EiwZkisYK74G5bmhqd+54eAgAAdRYCAAS6QAIAADtYAgAA6K4A=
Date:   Fri, 8 Nov 2019 00:32:25 +0000
Message-ID: <20191108003219.GD21728@mellanox.com>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-3-jgg@ziepe.ca>
 <35c2b322-004e-0e18-87e4-1920dc71bfd5@nvidia.com>
 <20191107020807.GA747656@redhat.com> <20191107201102.GC21728@mellanox.com>
 <20191107210408.GA4716@redhat.com>
In-Reply-To: <20191107210408.GA4716@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR17CA0008.namprd17.prod.outlook.com
 (2603:10b6:208:15e::21) To DB7PR05MB4138.eurprd05.prod.outlook.com
 (2603:10a6:5:23::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d26534f1-6eac-4968-d2ff-08d763e32082
x-ms-traffictypediagnostic: DB7PR05MB5658:
x-microsoft-antispam-prvs: <DB7PR05MB56586DDC665DF19B6934D944CF7B0@DB7PR05MB5658.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(189003)(199004)(76176011)(66476007)(86362001)(99286004)(316002)(66066001)(7736002)(54906003)(52116002)(25786009)(7416002)(33656002)(8676002)(229853002)(8936002)(305945005)(81156014)(1076003)(6486002)(6916009)(71200400001)(71190400001)(6436002)(478600001)(81166006)(6116002)(186003)(6512007)(14454004)(2616005)(256004)(3846002)(486006)(102836004)(476003)(11346002)(66946007)(26005)(2906002)(66446008)(36756003)(66556008)(64756008)(386003)(6506007)(5660300002)(6246003)(446003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB5658;H:DB7PR05MB4138.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aR3+CBY5exG+qfahxZBv7qpPzZYjAMu6L8cM3rmPuvmA70D2Xm2wD+Dom9qF6zQ3LuapK8j+e9z4oGswirL75KM2Q1cirRPsc5+RGTf+CCEAHt+RP/KmLaICytBqmxUw9KnPoHSi5rf5HFuaXpix4bEnkkbwURUV5rJ1wTM8CQEeDo2+g8Rkgs5GPe6hqfKPtuGxzWF7VsBUgMomE2LImCBLbXEqEwOlxYZrrAmJVLIStrRclVEdV3TtOmrHeqnULfxTxgAXargO7Dkxn0Z4zk3/xKMQzT8tCoNEXBluXwU/KjOmY7xKOd0RLQ6tyALW2YysLfTl0eSUCCJeDJf81wx0q2le8GVBk3r1naCx16emBufGQSNiyUYGEXuyChQSLMGYXSuvIoTUqAgsraQwCbn+e83t/z19HbsnUF/EvHilwQA1FBhNOwqisy+tvuRO
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <CAE59E75CD4E2749812E69DF0E0B124B@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d26534f1-6eac-4968-d2ff-08d763e32082
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 00:32:25.4242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qCyf7ALEOu0J2H1/c5jNA8RXYUSDW1iOARvpVlrQHqRzz8Op6L8j9mqCZU9zP8fzzk+JT2Yb8i3aQBwRUxEsdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB5658
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 07, 2019 at 04:04:08PM -0500, Jerome Glisse wrote:
> On Thu, Nov 07, 2019 at 08:11:06PM +0000, Jason Gunthorpe wrote:
> > On Wed, Nov 06, 2019 at 09:08:07PM -0500, Jerome Glisse wrote:
> >=20
> > > >=20
> > > > Extra credit: IMHO, this clearly deserves to all be in a new mmu_ra=
nge_notifier.h
> > > > header file, but I know that's extra work. Maybe later as a follow-=
up patch,
> > > > if anyone has the time.
> > >=20
> > > The range notifier should get the event too, it would be a waste, i t=
hink it is
> > > an oversight here. The release event is fine so NAK to you separate e=
vent. Event
> > > is really an helper for notifier i had a set of patch for nouveau to =
leverage
> > > this i need to resucite them. So no need to split thing, i would just=
 forward
> > > the event ie add event to mmu_range_notifier_ops.invalidate() i faile=
d to catch
> > > that in v1 sorry.
> >=20
> > I think what you mean is already done?
> >=20
> > struct mmu_range_notifier_ops {
> > 	bool (*invalidate)(struct mmu_range_notifier *mrn,
> > 			   const struct mmu_notifier_range *range,
> > 			   unsigned long cur_seq);
>=20
> Yes it is sorry, i got confuse with mmu_range_notifier and mmu_notifier_r=
ange :)
> It is almost a palyndrome structure ;)

Lets change the name then, this is clearly not working. I'll reflow
everything tomorrow

Jason
