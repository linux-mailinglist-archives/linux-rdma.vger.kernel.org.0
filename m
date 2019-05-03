Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 173EE12D5A
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2019 14:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfECMSc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 May 2019 08:18:32 -0400
Received: from mail-eopbgr30058.outbound.protection.outlook.com ([40.107.3.58]:23202
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726289AbfECMSb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 3 May 2019 08:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n74iNLxd76yKtSh4quTO/xKWaz5ZE9H6XQ1CKgEgH7I=;
 b=ZL+BUSPUyGn9jc5w3/Z4EuB/QQgAc4JECUon6fMc8QcXNpYZteLQ6mBXEAsb0/C1bdGh4gU5af3x2WQbfYnPdGOhpPFuVdjJa9G+G/4p6rZM/1wo92HOAGDd8ip/6lDVU4pB9cWlqTUAQ0AXMjuJS8Mn3wUYg8Vmxze55HtvmYY=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4958.eurprd05.prod.outlook.com (20.177.51.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Fri, 3 May 2019 12:18:26 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1856.008; Fri, 3 May 2019
 12:18:26 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leah Shalev <shalevl@amazon.com>,
        Dave Goodell <goodell@amazon.com>,
        Brian Barrett <bbarrett@amazon.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Sean Hefty <sean.hefty@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Steve Wise <larrystevenwise@gmail.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: [PATCH for-next v6 10/12] RDMA/efa: Add EFA verbs implementation
Thread-Topic: [PATCH for-next v6 10/12] RDMA/efa: Add EFA verbs implementation
Thread-Index: AQHVAREut6YhcNgq2U2bxKGl+U/wYaZZKKgAgAApzYA=
Date:   Fri, 3 May 2019 12:18:26 +0000
Message-ID: <20190503121821.GA13315@mellanox.com>
References: <1556707704-11192-1-git-send-email-galpress@amazon.com>
 <1556707704-11192-11-git-send-email-galpress@amazon.com>
 <20190502180218.GA27746@mellanox.com>
 <aa4a148e-8c9e-e30e-26ae-4ae5b9cf7216@amazon.com>
In-Reply-To: <aa4a148e-8c9e-e30e-26ae-4ae5b9cf7216@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR1701CA0024.namprd17.prod.outlook.com
 (2603:10b6:405:15::34) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [65.23.217.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15b1a0f2-0c03-478e-63c5-08d6cfc171b4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4958;
x-ms-traffictypediagnostic: VI1PR05MB4958:
x-microsoft-antispam-prvs: <VI1PR05MB4958D7684DCAD2DF78990D34CF350@VI1PR05MB4958.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0026334A56
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39860400002)(396003)(136003)(199004)(189003)(26005)(102836004)(478600001)(2616005)(229853002)(305945005)(7736002)(52116002)(14454004)(11346002)(6506007)(186003)(53546011)(486006)(6436002)(476003)(68736007)(54906003)(25786009)(2906002)(256004)(14444005)(6486002)(6246003)(316002)(76176011)(446003)(36756003)(386003)(6916009)(3846002)(6116002)(81156014)(81166006)(8936002)(8676002)(99286004)(7416002)(66476007)(5660300002)(71190400001)(71200400001)(33656002)(66556008)(64756008)(66946007)(86362001)(66446008)(6512007)(73956011)(53936002)(66066001)(4326008)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4958;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aewXpmW3+WFonJEfXEfqYIPNP4sQYckaGK+PG0NJBjzv+68YkZn/MEVxVedTJ2MF30xQzMfcBzUjDieWbbDH4Mrru1pY11bNGFXJO1PCGVin7qDsVmhTAC0qSUXfsOBCjHIqPZkHOvrwKii52nwnSjhuiurwFzLcAglJkkTnT9plNLBM1dwgywLWjToqOZHEPVPT9nxuotSkqVQ8kN5fPOT/yuroCQ/M8vM+Kv2oPdA7AFxirAKoki83xqSu3wUUL1HuOYFz0qMW3snmWeh+JFBIs7MUMeFTCs4l63u1FCwHZqjIbPtcJ7dOfaf/Z8zELJjbt8ydwebCj/1boK3MYYS0Ke2A+16vhAEqzS4C0NjObILuZbNJJtXqgYWtc4ez3P4CD4qwSy3UdjHb99wfTZ3MkXe3zG0BepNzBQLav3Q=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <12DFDD96CA970044B5B8C3DF4E3B8021@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b1a0f2-0c03-478e-63c5-08d6cfc171b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2019 12:18:26.5951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4958
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 03, 2019 at 12:48:44PM +0300, Gal Pressman wrote:
> On 02-May-19 21:02, Jason Gunthorpe wrote:
> >=20
> > On Wed, May 01, 2019 at 01:48:22PM +0300, Gal Pressman wrote:
> >> +static int mmap_entry_insert(struct efa_dev *dev,
> >> +			     struct efa_ucontext *ucontext,
> >> +			     struct efa_mmap_entry *entry,
> >> +			     u8 mmap_flag)
> >> +{
> >> +	u32 mmap_page;
> >> +	int err;
> >> +
> >> +	err =3D xa_alloc(&ucontext->mmap_xa, &mmap_page, entry, xa_limit_32b=
,
> >> +		       GFP_KERNEL);
> >> +	if (err) {
> >> +		ibdev_dbg(&dev->ibdev, "mmap xarray full %d\n", err);
> >> +		return err;
> >> +	}
> >> +
> >> +	entry->key =3D (u64)mmap_page << PAGE_SHIFT;
> >> +	set_mmap_flag(&entry->key, mmap_flag);
> >=20
> > This doesn't look like it is in the right order..  There is no locking
> > here so the xa_alloc should only be called on a fully intialized entry
> >=20
> > And because there is no locking you also can't really have a
> > mmap_obj_entries_remove..
> >=20
> > I think this needs a mutex lock also head across mmap_get to be correct=
..
>=20
> What needs to be atomic here is the "mmap_page" allocations, which is gua=
ranteed
> by xa_alloc.
> A unique page is allocated for each insertion and then a key is generated=
 for
> the entry. The key needs the mmap page hence the order, a lock would be
> redundant as the sequence does not require it.
>=20
> There are no concurrent gets (to other operations) as the key will only b=
e
> accessed once the insertion is done and the response is returned (at this=
 point
> the entry is fully initialized).

nonsense, a hostile userspace can call parallel mmap to trigger races

> There are no concurrent removes as they only happen in error flow which h=
appens
> after all the relevant insertions are done (and won't be accessed) or whe=
n the
> ucontext is being deallocated which cannot happen simultaneously with any=
thing else.

Nope, also can be done in parallel with a hostile userspace

Jason
