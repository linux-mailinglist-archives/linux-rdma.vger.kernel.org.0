Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0164098113
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 19:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfHUROv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 13:14:51 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:21694 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726330AbfHUROu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 13:14:50 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7LH03ZY012093;
        Wed, 21 Aug 2019 10:14:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=JDTVP50z4QXnmG8ZwTPkebUmPAZfMoR4H/WynuCTN0Q=;
 b=TAj7RE2xyPPSBLnOvWHpEkx5LqG0KriyWRNMnbFwXuYavlgJTfOiihLdRVqzQLYUp/Ex
 7ioFq7hA5TDdTsAAEk3DK+DhF89RhPflAKL+bpGvXW7hulS88UICD0XbV9Gi+dYuEI5d
 jOx8ICc5YUhzCdGroTbzlPOxVoZyvPBKJA2wIZvGcRzU+K1RlfFCkbOSQrT+c1pf80ye
 8eYMvXE5FN8u2ko+BoTnad9/j/3tbmy17+p4XkseGdbRr/IqvMCsTL+l19/qkr3e36NI
 uvvh1+zpHpd8GqiPHvHBgUKX4YM6KlUiTJjsVe/jwhnSsdMCsKTWPu/++p2CSkKOSzWl EQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2ugu7fkd7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 21 Aug 2019 10:14:45 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 21 Aug
 2019 10:14:44 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.53) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 21 Aug 2019 10:14:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euW9xbxTU1gj3+skEUyZJTp/UUzPYuq7BHuM1XnrAG8ye3KAGzokYJ+z4iYtlXrfRP/e9V7hqMCT0GoDf5xS75Akf4r3M3hASGiFZ+tGlbwoGpWiCe3b79rs5bxezEp9/dnxre4ykN+Ls233GXeFca907xdwYPA8qdsmuFhuBlp/DQGzrlZw0QdiFE24nAUQ3Yc0wCES1LChada465zVSWMaFDsWCqYtis6DsXPmV8PsUBt3pYHbGYEZeEK9bFA5XznPT7lJ9X5tPOQRdGWznE+o5i9gtuT/lgV19tqWmpJ/yoLHTgbOSzu9bTyfWsTrbYFO/iQ0avVEUjMNGbTBHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDTVP50z4QXnmG8ZwTPkebUmPAZfMoR4H/WynuCTN0Q=;
 b=Ldv/2TqGe/xa3OG5TsQD9MIdx4xRjT9JE11MSaK4UsABgZjfK2Q/PyT58m3prZQc/Aq1tHHnb5XnU/byg+YIjkZJ8L9kny3tXHHuLmQha6i48p2MbzSE+3McRoXmQ+4ZDUquGCsyXRNM6OzSuZ42hQEHbFjBlPZS36rX3byDwhHA22+8H/C6egIk905PkyuRVZrU9/3ed5/0WSNL47JnRkYwXMt8hQZ6YjjRO7oq/bul/w43jZAS3yhsPWgXmiqPNwGdOCQnXzSqiH+Gd6Gw1W6QdEAA0/3kmLCd4MSSSXkv3P995rZmMo4OhOJ0rNAkiCyF8ii8pIi+uEa9H9IUpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDTVP50z4QXnmG8ZwTPkebUmPAZfMoR4H/WynuCTN0Q=;
 b=rdIQEnzMgSBwpZXa5A2nPEXlmaFRxq2Oqsr2L7fKZzg8paPDrNd4VZEBoRfssDOEoCWS9XWjg21Bn28cjhqfQ5vUjAExbDMdEv7IbeGWPnzhWB7jYKLGaWK+2VLUXxVa8c/PLrlKoYLH50Se0BSXg5KQSYmfBZZ32+W2sBTW9tU=
Received: from CH2PR18MB3175.namprd18.prod.outlook.com (52.132.244.149) by
 CH2PR18MB3432.namprd18.prod.outlook.com (52.132.247.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Wed, 21 Aug 2019 17:14:38 +0000
Received: from CH2PR18MB3175.namprd18.prod.outlook.com
 ([fe80::810a:1cbb:1b73:72d5]) by CH2PR18MB3175.namprd18.prod.outlook.com
 ([fe80::810a:1cbb:1b73:72d5%7]) with mapi id 15.20.2178.018; Wed, 21 Aug 2019
 17:14:38 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v7 rdma-next 2/7] RDMA/core: Create mmap
 database and cookie helper functions
Thread-Topic: [EXT] Re: [PATCH v7 rdma-next 2/7] RDMA/core: Create mmap
 database and cookie helper functions
Thread-Index: AQHVV1GzaBcLwMoagEypYNTXoU3KUacEBbGAgACDqWCAAUW1MIAAA5+AgAACoEA=
Date:   Wed, 21 Aug 2019 17:14:38 +0000
Message-ID: <CH2PR18MB3175EDB5640A3987D97A4DC0A1AA0@CH2PR18MB3175.namprd18.prod.outlook.com>
References: <20190820121847.25871-1-michal.kalderon@marvell.com>
 <20190820121847.25871-3-michal.kalderon@marvell.com>
 <20190820132125.GC29246@ziepe.ca>
 <MN2PR18MB31821E7411D0E44267F4A256A1AB0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <CH2PR18MB31752BE286837BFDCEE3B17CA1AA0@CH2PR18MB3175.namprd18.prod.outlook.com>
 <20190821165121.GE8653@ziepe.ca>
In-Reply-To: <20190821165121.GE8653@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.203.130.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fde44b68-6916-4271-4523-08d7265b0c4f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CH2PR18MB3432;
x-ms-traffictypediagnostic: CH2PR18MB3432:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR18MB34328B87ACAB6C30E871F9C9A1AA0@CH2PR18MB3432.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(189003)(199004)(6916009)(2906002)(14454004)(66446008)(66476007)(64756008)(66556008)(6506007)(3846002)(26005)(256004)(102836004)(9686003)(54906003)(6116002)(76176011)(11346002)(33656002)(446003)(7696005)(316002)(71190400001)(76116006)(66946007)(71200400001)(81156014)(81166006)(6246003)(5660300002)(229853002)(53936002)(86362001)(8676002)(7736002)(25786009)(305945005)(8936002)(486006)(74316002)(4326008)(99286004)(55016002)(52536014)(478600001)(186003)(66066001)(6436002)(476003)(130980200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR18MB3432;H:CH2PR18MB3175.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rNelCSlfr2F3xRia/oAvsANMAFULYZNEJyH+oen3sDJ9muG3H6NXTugKPgrIcQn4t0W2AynWklxCvcSeae4jrkgk8n7pfZwZH2bviingKye4ss3XJgbFHmlVo9c5OBQY4h67T6Sjaf9vTey+5dlPTRp21zF4hxSaKrN72n1uvEE/6TkWDHTbszRQQCj5kIPLfvpDtuP29PpASDdP+T2RCsybQg9Y7M0PCSXSNhCePcCuQAM+Zb+ANOeEwDJZV8KvtSetkm0FDgomS/+MvopbVArPpaUmBla7pviylu57prepAiykw3HO5Qr7hSsJaOVIgLN/2FGLoyzpcp1yR6EquQdlVvfY0uzajimn3tiwp+aPCBUSX1rCbvX37xO6O5bU44smn30e4pET8FqVFASv0alO8bs+cJrjESVjO9uWRgQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fde44b68-6916-4271-4523-08d7265b0c4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 17:14:38.4866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RsQnjkN58P5qI53/hWH+8v2FO4i/SyoChP8xZwn8iawI2+1G2JyuRiQxeF6XYvbS6cuksuLIQv+BJep+tv8xGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR18MB3432
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-21_05:2019-08-19,2019-08-21 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Wednesday, August 21, 2019 7:51 PM
>=20
> On Wed, Aug 21, 2019 at 04:47:47PM +0000, Michal Kalderon wrote:
> > > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > > owner@vger.kernel.org> On Behalf Of Michal Kalderon
> > >
> > > > From: Jason Gunthorpe <jgg@ziepe.ca>
> > > > Sent: Tuesday, August 20, 2019 4:21 PM
> > > >
> > > > On Tue, Aug 20, 2019 at 03:18:42PM +0300, Michal Kalderon wrote:
> > > > > Create some common API's for adding entries to a xa_mmap.
> > > > > Searching for an entry and freeing one.
> > > > >
> > > > > +
> > > > > +/**
> > > > > + * rdma_user_mmap_entry_insert() - Allocate and insert an entry
> > > > > +to the
> > > > mmap_xa.
> > > > > + *
> > > > > + * @ucontext: associated user context.
> > > > > + * @obj: opaque driver object that will be stored in the entry.
> > > > > + * @address: The address that will be mmapped to the user
> > > > > + * @length: Length of the address that will be mmapped
> > > > > + * @mmap_flag: opaque driver flags related to the address (For
> > > > > + *           example could be used for cachability)
> > > > > + *
> > > > > + * This function should be called by drivers that use the
> > > > > +rdma_user_mmap
> > > > > + * interface for handling user mmapped addresses. The database
> > > > > +is handled in
> > > > > + * the core and helper functions are provided to insert entries
> > > > > +into the
> > > > > + * database and extract entries when the user call mmap with
> > > > > +the given
> > > > key.
> > > > > + * The function returns a unique key that should be provided to
> > > > > +user, the user
> > > > > + * will use the key to map the given address.
> > > > > + *
> > > > > + * Return: unique key or RDMA_USER_MMAP_INVALID if entry was
> > > > > +not
> > > > added.
> > > > > + */
> > > > > +u64 rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext,
> > > > > +void
> > > > *obj,
> > > > > +				u64 address, u64 length, u8
> mmap_flag) {
> > > > > +	XA_STATE(xas, &ucontext->mmap_xa, 0);
> > > > > +	struct rdma_user_mmap_entry *entry;
> > > > > +	unsigned long index =3D 0, index_max;
> > > > > +	u32 xa_first, xa_last, npages;
> > > > > +	int err, i;
> > > > > +	void *ent;
> > > > > +
> > > > > +	entry =3D kzalloc(sizeof(*entry), GFP_KERNEL);
> > > > > +	if (!entry)
> > > > > +		return RDMA_USER_MMAP_INVALID;
> > > > > +
> > > > > +	entry->obj =3D obj;
> > > >
> > > > It is more a kernel pattern to have the driver allocate a
> > > > rdma_user_mmap_entry and extend it with its 'priv', then use
> > > > container_of
> > > then would we also want the driver to free the memory ?
> > > Or will it be ok to free it using the kref put callback ?
> >
> > Jason, I looked into this deeper today, it seems that since the Core
> > is the one handling the reference counting, and eventually Freeing the
> > object that it makes more sense to keep the allocation In core and not
> > in the drivers, since the driver won't be able to free The entry
> > without providing yet an additional callback function to the Core to
> > be called once the reference count reaches zero.
>=20
> This already added a callback to free the xa_entry, why can't it free all=
 the
> memory too when kref goes to 0?
True, could free it there. I just think we'll have a bit more duplication c=
ode
Between the drivers defining a very similar private structure and adding
Allocation calls before each of the rdma_user_mmap_insert function calls.=20
 And just to make sure I follow,=20
Do you mean creating the following structure per driver:=20
Struct <driver>_user_mmap_entry {
	struct rdma_user_mmap_entry umap_entry;
              ... <private fields> ...
}

Thanks again,=20
Michal

>=20
> Jason
