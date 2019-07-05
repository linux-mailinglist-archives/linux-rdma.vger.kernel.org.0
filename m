Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D10D46094C
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2019 17:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfGEP3m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Jul 2019 11:29:42 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:33692 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726012AbfGEP3l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Jul 2019 11:29:41 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x65FPjBq030366;
        Fri, 5 Jul 2019 08:29:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=Bz+DyiHc8Qb2/VoW52NUdZ+cMDoTkohl5FhrEen7fnU=;
 b=bC8mts0nV/s4FteA/v0EyIhD2SPMkN9WFnsT1OlF/6cNQy02ehjxw4FFWYOBIUFqq16p
 pqzr83jYq9r13GWICxSFEfkxGAfUMYUqIaa4WJU1TvI1QC83Pen8Yci9r51lzub2KKW3
 unmOuXZxcVGkXOIWBS8GOQ9Imrww5nSPd1zK42JNeqZ+ovmJU2bCPoWY6ACXSMuPMwbp
 GhpOVek+mUPCUACZ0iP/Tlz0nBCY5hipV3zOiubKJjcRz2sQKP1GtKXk2y5SxmO4diR0
 QqcxkklQYDvft5LNqgIsnzGFmZOeVKDibielSCNbX5yhZB0/quwZChclyPiTiynABJ6n 7g== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2thjyrce78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 05 Jul 2019 08:29:06 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 5 Jul
 2019 08:29:04 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.59) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 5 Jul 2019 08:29:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bz+DyiHc8Qb2/VoW52NUdZ+cMDoTkohl5FhrEen7fnU=;
 b=Stnp5UPNj94c9mBqtGq9Xtp9Qq9Q/s6/0jSaypjtARz0YOeQUb/QHnxKfXWEXFlOeHN6cT58YBGpzGUqWMXX+8r8RTuhy4/DgKboR+DzOhig+lE9xiGtLIhxOLt4DIX5rTGZdMnU3NoUT28o3FHf/I+vNVTjt4SmFfr92HmnYOg=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3006.namprd18.prod.outlook.com (20.179.84.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Fri, 5 Jul 2019 15:29:03 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::8cb3:f7d7:8bb2:c36e]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::8cb3:f7d7:8bb2:c36e%6]) with mapi id 15.20.2052.010; Fri, 5 Jul 2019
 15:29:03 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Gal Pressman <galpress@amazon.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        Ariel Elior <aelior@marvell.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [EXT] Re: [RFC rdma 1/3] RDMA/core: Create a common mmap function
Thread-Topic: [EXT] Re: [RFC rdma 1/3] RDMA/core: Create a common mmap
 function
Thread-Index: AQHVMXgY2ufVwbsMjkGRdCnidkmBy6a6ZueAgAHB8bA=
Date:   Fri, 5 Jul 2019 15:29:03 +0000
Message-ID: <MN2PR18MB318240185BE80841F1265D2FA1F50@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190627135825.4924-1-michal.kalderon@marvell.com>
 <20190627135825.4924-2-michal.kalderon@marvell.com>
 <d6e9bc3b-215b-c6ea-11d2-01ae8f956bfa@amazon.com>
 <20190627155219.GA9568@ziepe.ca>
 <14e60be7-ae3a-8e86-c377-3bf126a215f0@amazon.com>
 <MN2PR18MB318228F0D3DA5EA03A56573DA1FC0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <MN2PR18MB3182EC9EA3E330E0751836FDA1F80@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20190702223126.GA11860@ziepe.ca>
 <85247f12-1d78-0e66-fadc-d04862511ca7@amazon.com>
 <20190704123511.GA3447@ziepe.ca>
In-Reply-To: <20190704123511.GA3447@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [79.176.81.151]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c112ede7-6560-4f5b-4765-08d7015d82bc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3006;
x-ms-traffictypediagnostic: MN2PR18MB3006:
x-microsoft-antispam-prvs: <MN2PR18MB3006F24C8C3B6D41FCC47174A1F50@MN2PR18MB3006.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(39850400004)(366004)(136003)(199004)(189003)(4326008)(2906002)(66066001)(476003)(7696005)(8936002)(52536014)(74316002)(229853002)(66446008)(478600001)(73956011)(186003)(7736002)(76116006)(66556008)(256004)(64756008)(54906003)(26005)(316002)(66476007)(66946007)(305945005)(9686003)(55016002)(99286004)(6436002)(3846002)(6116002)(6506007)(53546011)(86362001)(33656002)(8676002)(11346002)(81166006)(6246003)(14454004)(76176011)(110136005)(71200400001)(486006)(71190400001)(25786009)(102836004)(68736007)(81156014)(53936002)(446003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3006;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +8PoOHEIB65UqIU+vytPSXuROkAzMxvuwYDg3PXTpWc0RSA5/0+t/xKggF5J91NhDJayL/A70ZOJe+A1w4FEa78adsb+KT31zyl1weeX2DYiHAV1JBYAt5ZPfvkuOpMlmKu2kxz8f1DrwmpoKSrvaOHTQh1FsbDAFJ7hcFUYNGGazQlOUvzOg0qlUFol4JPGEiuYucy/cfTciMvApcPCkPd5q8IabX0q/9z06Wv3F5o46JfGZ5/3NxKfwxBMtN9WWLXhD45x0G+rgzfrUcSSDZOgxgt+tY7tvCBrOtDmv58LSoO6yR9l8sgZ2eePVmz3InXkISYD8JTZcNa7OHR4mYiwi41nvlGNQn0xmEre41fqt+G9/S6CNqtgwr8o04MO3EYPQaFro7/aKYVqziCg6+XMk7Za9DBisQfo691YH3s=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c112ede7-6560-4f5b-4765-08d7015d82bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 15:29:03.1868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mkalderon@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3006
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-05_05:,,
 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Thursday, July 4, 2019 3:35 PM
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Wed, Jul 03, 2019 at 11:19:34AM +0300, Gal Pressman wrote:
> > On 03/07/2019 1:31, Jason Gunthorpe wrote:
> > >> Seems except Mellanox + hns the mmap flags aren't ABI.
> > >> Also, current Mellanox code seems like it won't benefit from mmap
> > >> cookie helper functions in any case as the mmap function is very
> > >> specific and the flags used indicate the address and not just how to=
 map
> it.
> > >
> > > IMHO, mlx5 has a goofy implementaiton here as it codes all of the
> > > object type, handle and cachability flags in one thing.
> >
> > Do we need object type flags as well in the generic mmap code?
>=20
> At the end of the day the driver needs to know what page to map during th=
e
> mmap syscall.
>=20
> mlx5 does this by encoding the page type in the address, and then many
> types have seperate lookups based onthe offset for the actual page.
>=20
> IMHO the single lookup and opaque offset is generally better..
>=20
> Since the mlx5 scheme is ABI it can't be changed unfortunately.
>=20
> If you want to do user controlled cachability flags, or not, is a fair qu=
estion,
> but they still become ABI..
>=20
> I'm wondering if it really makes sense to do that during the mmap, or if =
the
> cachability should be set as part of creating the cookie?
>=20
> > Another issue is that these flags aren't exposed in an ABI file, so a
> > userspace library can't really make use of it in current state.
>=20
> Woops.
>=20
> Ah, this is all ABI so you need to dig out of this hole ASAP :)
>
Jason, I didn't follow - what is all ABI?=20
currently EFA implementation encodes the cachability inside the key,
It's not exposed in ABI file and is opaque to user-space. The kernel decide=
s on the cachability
And get's it back in the key when mmap is called. It seems good enough for =
the current cases. =20
Thanks ,=20
Michal
=20
> Jason
