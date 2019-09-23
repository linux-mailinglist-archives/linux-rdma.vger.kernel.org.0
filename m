Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 893A5BB183
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2019 11:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405899AbfIWJgL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 05:36:11 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:6640 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405796AbfIWJgL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Sep 2019 05:36:11 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8N9YeHI019224;
        Mon, 23 Sep 2019 02:36:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=bp//AN67z4poKHI9oLSfa4TNySWNwq71JAi8rl3R/pI=;
 b=uI8ekC9St8D/X+GjKkH8ijKKaOzag7S/Kes9pXx07M8lukQTqF+SVJ4KFZt0XhMXGQpj
 epW6MYssmHC+PecJjRgTml9KKLKMNw7l/6/3VqrxaKS+qhAYJzAICdZG5JBRY/6ktXLc
 AgcmypDdePIMAH4Hz6L7kCV827l/tQ7guNjKWXb8j94Yj7VZXcLEJea96mg1moYemc3N
 +GeMtdf5RPfjawMVctbXUZmMDuDE7LZ8O6XezYJGcmPw63MwDIWlAk974V0RZrY+8F4R
 Y/N17bo3seRmEHvTdTkP8BviunzxT6nT6t2ZRIL6Lb5mMsv3P/Fk/uK+LQD7aRDPp2Hk kA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2v5kckn6ja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 23 Sep 2019 02:36:05 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 23 Sep
 2019 02:36:03 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.50) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 23 Sep 2019 02:36:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILl2eyXA00Zmm8xOC7b7B4NyZR9taLhY+MUT2QVqKTQscKGnAHbhehsqT1ZCYZQzd5fAZEt+t80Kaq+FnUQ6BTcaKQ/9/ByrcI9vmBn2QZ4XlMsBPEMeCSHjy6SbcMZleid8NuiP9lBL+SwkyL99EFfn37/8AoHZxV+XJaIfzd7iQNF6kRNPlHBdoNXWEkdThKA9REfCcgLEjqLxj5LttK9RaQy/g61a9q+mi2ksp8zt40MtufS+BoGz+Rv9wXqaGW1VFwvTNzSGVYiqha+tNEJOZJsBKin5Qb+r9bLZstNpteejLP3yq5M3x6Tpd62XTVL30ZPXTBfN5OXAXC2fHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bp//AN67z4poKHI9oLSfa4TNySWNwq71JAi8rl3R/pI=;
 b=ZdVlrs6XWDmbaUYbMn6mizgFgZoZgOIW+uuacdKMkDCvoUpiBJMpRlvbZ/WAa+NY3I6Ck8jyD8NLT4twRDZKl68DOXgn7Eao4qngoEz7LKU7C0taT9kZmqfPoZnC4gznUvcpbRsHh8H0y/DG+aXW4hg/PYqdKQ0CD011CHUfBvtMlwSmtWs5LaY19vlovFV4c81PX5FFzAWKLZBSj7TCtIKM0Jb6yyLETta5suGjrJVg5/71V0bIkZtzYOgQA0xes4zp1IE1yJWEiDjrY25dmFOqWAo6eOEe5dVn1J+RPgz6uI9+XNbWW1x0JpecsAVRFObo5TI6for3cAX3ajgItw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bp//AN67z4poKHI9oLSfa4TNySWNwq71JAi8rl3R/pI=;
 b=XUNw7kiNoLaKRCYrdVAF5Pycz/qe0KjCsTkak1R+ABeuzJxIF762Wo0wF0pzyzeJSw7rVAvDP+dPMzc5GVLfsavKMUnqpLFhndtzP6NMU2GXEdkYbSrwijlvwjLbWv/N4JKXsAdcP2iN9TUNRrwsRszMoIRAh57HNQp1fMRM3/s=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3344.namprd18.prod.outlook.com (10.255.238.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Mon, 23 Sep 2019 09:36:01 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8%7]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 09:36:01 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v11 rdma-next 2/7] RDMA/core: Create mmap
 database and cookie helper functions
Thread-Topic: [EXT] Re: [PATCH v11 rdma-next 2/7] RDMA/core: Create mmap
 database and cookie helper functions
Thread-Index: AQHVY9EbgU9u1ehEnECRiayMwe50F6czYqUAgAW5klA=
Date:   Mon, 23 Sep 2019 09:36:01 +0000
Message-ID: <MN2PR18MB31822DCFCA312D6A455A000BA1850@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190905100117.20879-1-michal.kalderon@marvell.com>
 <20190905100117.20879-3-michal.kalderon@marvell.com>
 <20190919180746.GF4132@ziepe.ca>
In-Reply-To: <20190919180746.GF4132@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.199.69.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2960243d-1ee2-4f1e-96d2-08d74009728a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3344;
x-ms-traffictypediagnostic: MN2PR18MB3344:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3344629DCED8D22CA49B8F00A1850@MN2PR18MB3344.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0169092318
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(136003)(39850400004)(366004)(346002)(396003)(376002)(199004)(189003)(14454004)(256004)(9686003)(54906003)(66946007)(81156014)(66446008)(64756008)(66556008)(66476007)(52536014)(81166006)(8936002)(2906002)(99286004)(5660300002)(229853002)(14444005)(6436002)(8676002)(55016002)(186003)(7696005)(33656002)(74316002)(6116002)(4326008)(25786009)(478600001)(316002)(6246003)(76176011)(305945005)(6916009)(102836004)(6506007)(66066001)(3846002)(71200400001)(11346002)(71190400001)(7736002)(86362001)(486006)(26005)(446003)(476003)(76116006)(130980200001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3344;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X1CUxDXsygz50GZdoTjmRuk6OSy1IKduy9RMiJi5zj+Gg5ABHEtdmfziW19PqLUR3kTVAY7so7JJwEt2380cfWTdQkGzRSe7ymO+dqUuplAz17FC27EldSM8aL5yb6VyVtW25OyGV66iqUUYS1T0zL8Nmf6QiTKHfljcsv6+pjG+rJaWJWohkt0lWep/YFY3h2ytt03rtTKeDZ2NkdwHwW/i8nMXeQlL5VlJDGFLnx/eVsN3147ITnuZ56TuCrVtkkMEn4Yhsutu2KVa7cRUnh8SIa6azsCWtOnQ4JJEaXiH16nHfb+plZjWa25ZFYSyB4pga62+av1QFIosus16YpCSwToQf/9Bjj7rg7JDMm2uSLhMFhGTkBnd4bE8+7dR41kybsc6jjqp+5GMsC4PM0d2W70ckzdagt+UweBxS+8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2960243d-1ee2-4f1e-96d2-08d74009728a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2019 09:36:01.4824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JiAKj5TPsk0qxC2JVCB9csg3LwTGqb0qq/w7V96zKP1FYlenNMnn37u2MKhau87M1UHBqIzhFJ95/80m6gzsuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3344
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-23_03:2019-09-23,2019-09-23 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Thursday, September 19, 2019 9:08 PM
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Thu, Sep 05, 2019 at 01:01:12PM +0300, Michal Kalderon wrote:
> > +/**
> > + * rdma_user_mmap_entry_remove() - Remove a key's entry from the
> > +mmap_xa
> > + *
> > + * @ucontext: associated user context.
> > + * @key: the key to be deleted
> > + *
> > + * This function will find if there is an entry matching the key and
> > +if so
> > + * decrease its refcnt, which will in turn delete the entry if
> > + * its refcount reaches zero.
> > + */
> > +void rdma_user_mmap_entry_remove(struct ib_ucontext *ucontext,
> u64
> > +key)
>=20
> Since the struct rdma_user_mmap_entry already has both of these, doesn't
> it make more sense to pass in the struct pointer to _remove than store th=
e
> key?
>=20
> Ie replace things like ctx->db_key with a pointer and make the
> rdma_user_mmap_get_key() into a header inline
>=20
>=20
> > +/**
> > + * rdma_user_mmap_entry_insert() - Allocate and insert an entry to the
> mmap_xa.
> > + *
> > + * @ucontext: associated user context.
> > + * @entry: the entry to insert into the mmap_xa
> > + * @length: length of the address that will be mmapped
> > + *
> > + * This function should be called by drivers that use the
> > +rdma_user_mmap
> > + * interface for handling user mmapped addresses. The database is
> > +handled in
> > + * the core and helper functions are provided to insert entries into
> > +the
> > + * database and extract entries when the user call mmap with the given
> key.
> > + * The function returns a unique key that should be provided to user,
> > +the user
> > + * will use the key to retrieve information such as address to
> > + * be mapped and how.
> > + *
> > + * Return: unique key or RDMA_USER_MMAP_INVALID if entry was not
> added.
> > + */
> > +u64 rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext,
> > +				struct rdma_user_mmap_entry *entry,
> > +				size_t length)
>=20
> The similarly we don't need to return a u64 here and the sort of ugly
> RDMA_USER_MMAP_INVALID can go away

So you mean add a return code here ? and on failure driver will delete the=
=20
Allocated xx_user_mmap_entry and not store it in xx_key ?=20

>=20
> Jason
