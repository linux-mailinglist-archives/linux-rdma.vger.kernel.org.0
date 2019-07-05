Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6268B60B08
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jul 2019 19:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfGERYi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Jul 2019 13:24:38 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:7514 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727693AbfGERYi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Jul 2019 13:24:38 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x65HK1X2025227;
        Fri, 5 Jul 2019 10:24:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=q4O383wCNGItYSvtgxA9M1zde55ej3mRtzKUVt03qtc=;
 b=zFd5ZfxAg5uQ+5PfRqVzSmz1VY9g7hxxaIaRMzZ2GVvGqku0g/pW173b9KpURoFsudvW
 lzD/G3KbfwsFSaylDhMITSMu8YcmcMvYyndGqwh3sfM173ByzNSjmobwMrzaVvx4skQP
 oI7EPU3eqiAdGFcBikC3z1Z0pWF3JEd2ZCOVocx5vwKSi6Rz9LZCRxVvzUCuy1TgcRPc
 MTXksLYIgqQZOuZvfL8MqkUnc2qPuLnElUOF0+Ukurrlnr7Njskfxg55tyeLubwtb1US
 FywtSiDtAMVjOnPvwdglxd7ENbLJwkV9njc03uZpUSZ+kbDGyMWrxUqIG599xB9wCdEU uQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2tja5hr6f3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 05 Jul 2019 10:24:23 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 5 Jul
 2019 10:24:21 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.53) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 5 Jul 2019 10:24:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4O383wCNGItYSvtgxA9M1zde55ej3mRtzKUVt03qtc=;
 b=gSnzAS+2tUJ8wVBjRFXpJVT3Lx2KKF1F8YfcvCFkvB65/4CECh/0asnbBJLc3yxVtccYFcjFpsf/5tByL9fAUoXFqNDiuCL1EcXbMx3M/5pBNwGKsgvilQu4Gdlv7Nyu37uXN5DIPMKO2EMV683u9mzjG+uQ6hECvKMgWfUGHZo=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB2799.namprd18.prod.outlook.com (20.179.22.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.16; Fri, 5 Jul 2019 17:24:19 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::8cb3:f7d7:8bb2:c36e]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::8cb3:f7d7:8bb2:c36e%6]) with mapi id 15.20.2052.010; Fri, 5 Jul 2019
 17:24:19 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Gal Pressman <galpress@amazon.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        Ariel Elior <aelior@marvell.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [EXT] Re: [RFC rdma 1/3] RDMA/core: Create a common mmap function
Thread-Topic: [EXT] Re: [RFC rdma 1/3] RDMA/core: Create a common mmap
 function
Thread-Index: AQHVMXgY2ufVwbsMjkGRdCnidkmBy6a6ZueAgAHB8bCAAAIEAIAAHUlw
Date:   Fri, 5 Jul 2019 17:24:18 +0000
Message-ID: <MN2PR18MB3182F4496DA01CA2B113DF04A1F50@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190627135825.4924-2-michal.kalderon@marvell.com>
 <d6e9bc3b-215b-c6ea-11d2-01ae8f956bfa@amazon.com>
 <20190627155219.GA9568@ziepe.ca>
 <14e60be7-ae3a-8e86-c377-3bf126a215f0@amazon.com>
 <MN2PR18MB318228F0D3DA5EA03A56573DA1FC0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <MN2PR18MB3182EC9EA3E330E0751836FDA1F80@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20190702223126.GA11860@ziepe.ca>
 <85247f12-1d78-0e66-fadc-d04862511ca7@amazon.com>
 <20190704123511.GA3447@ziepe.ca>
 <MN2PR18MB318240185BE80841F1265D2FA1F50@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20190705153248.GB31543@ziepe.ca>
In-Reply-To: <20190705153248.GB31543@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [79.176.81.151]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5c0eae9-1655-404e-da66-08d7016d9ceb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2799;
x-ms-traffictypediagnostic: MN2PR18MB2799:
x-microsoft-antispam-prvs: <MN2PR18MB27995C76150FF658D96AD2A8A1F50@MN2PR18MB2799.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(376002)(366004)(396003)(136003)(346002)(199004)(189003)(54906003)(229853002)(6246003)(33656002)(9686003)(14454004)(3846002)(53936002)(6116002)(55016002)(52536014)(476003)(76116006)(66476007)(73956011)(186003)(5660300002)(66946007)(66446008)(446003)(6436002)(66556008)(478600001)(316002)(11346002)(64756008)(76176011)(68736007)(7736002)(26005)(66066001)(4326008)(25786009)(256004)(86362001)(8936002)(74316002)(2906002)(71190400001)(7696005)(102836004)(6506007)(81166006)(81156014)(71200400001)(53546011)(8676002)(99286004)(6916009)(486006)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2799;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: id0W6kbku3746xzHb+DuqodsOPVFOC66J1ogx2g3lEklMfnLCPa689BEIOVdgJe9xnAkwfezqpGWOzZ6GpJcyhdTrZaOUkkBZHsbiRtHqGf+SnjuWVi9V0b/QLiwNNq/vBGv1si9MPjuba4+Tscqkuc3Di/saM3x6pmbWvDfz3UtU3NaBb3v5ygsssFfff2+8VClwU7Si8lnao7zu5tx5lRBtraTpr6mRN1vH9426aoczEhAlFmt+hvi5ZVs99LPhk48Hhg8E3iFncClZtoSNLXOl2+KYMIspK8nWXL451+WRpIkFQ1nkESETJfSLC0z2pb73OXaKUm3cu9evYvrd0cy65HkDY5HHXiYNlMIjCP3FEeo08XwC7AV2EHAlZijvXmEzcay2n6lUcGF2xfDaPO6+HCtnWvxVdVP1MjMVW0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c0eae9-1655-404e-da66-08d7016d9ceb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 17:24:18.1985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mkalderon@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2799
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-05_06:,,
 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Friday, July 5, 2019 6:33 PM
>=20
> On Fri, Jul 05, 2019 at 03:29:03PM +0000, Michal Kalderon wrote:
> > > From: Jason Gunthorpe <jgg@ziepe.ca>
> > > Sent: Thursday, July 4, 2019 3:35 PM
> > >
> > > External Email
> > >
> > > On Wed, Jul 03, 2019 at 11:19:34AM +0300, Gal Pressman wrote:
> > > > On 03/07/2019 1:31, Jason Gunthorpe wrote:
> > > > >> Seems except Mellanox + hns the mmap flags aren't ABI.
> > > > >> Also, current Mellanox code seems like it won't benefit from
> > > > >> mmap cookie helper functions in any case as the mmap function
> > > > >> is very specific and the flags used indicate the address and
> > > > >> not just how to map
> > > it.
> > > > >
> > > > > IMHO, mlx5 has a goofy implementaiton here as it codes all of
> > > > > the object type, handle and cachability flags in one thing.
> > > >
> > > > Do we need object type flags as well in the generic mmap code?
> > >
> > > At the end of the day the driver needs to know what page to map
> > > during the mmap syscall.
> > >
> > > mlx5 does this by encoding the page type in the address, and then
> > > many types have seperate lookups based onthe offset for the actual
> page.
> > >
> > > IMHO the single lookup and opaque offset is generally better..
> > >
> > > Since the mlx5 scheme is ABI it can't be changed unfortunately.
> > >
> > > If you want to do user controlled cachability flags, or not, is a
> > > fair question, but they still become ABI..
> > >
> > > I'm wondering if it really makes sense to do that during the mmap,
> > > or if the cachability should be set as part of creating the cookie?
> > >
> > > > Another issue is that these flags aren't exposed in an ABI file,
> > > > so a userspace library can't really make use of it in current state=
.
> > >
> > > Woops.
> > >
> > > Ah, this is all ABI so you need to dig out of this hole ASAP :)
> > >
> > Jason, I didn't follow - what is all ABI?
> > currently EFA implementation encodes the cachability inside the key,
> > It's not exposed in ABI file and is opaque to user-space. The kernel
> > decides on the cachability And get's it back in the key when mmap is
> > called. It seems good enough for the current cases.
>=20
> Then the key 'offset' should not include cachability information at all.
>=20
Fair enough, so as you stated above the cachabiliy can be set in the cookie=
.=20
Would we still like to leave some bits for future ABI enhancements, request=
s, from user ?=20
Similar to a page type that mlx has ?=20

Thanks,
Michal


> Jason
