Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E83E1BC415
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2019 10:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438987AbfIXIZq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Sep 2019 04:25:46 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:55682 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2438961AbfIXIZp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Sep 2019 04:25:45 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8O8HId1014337;
        Tue, 24 Sep 2019 01:25:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=G+7/ljH9O3GcmuorfT2zMU228Q9OsIQKFQVwCgeAjv4=;
 b=JT/rM0ebZJ8CLNkEihGIgJGYnVgNsHF0We7BMP2ibRPW+w0QrRUIR+Q7ZJbgqZwhKG9b
 LbcQuZbo0QFSnFa3BYPx6IYl0r589vpijj2d8gPPr8AfNVAlxWksx7CzlhemCOk0mIjs
 BnGyLEPiVy8rpJxpLmn4kz3dK0bFMssK2+dQLgkKLlrCDHVfp/OIo4+1sl1VRHNnrpuA
 LIz0eDxocmPFiidiRd7JOaH8JPFeUnJeYLYaVDTNokRuO6z2ppx4/ifd6GjzsdqbE3JO
 xicCXOud6BefhYfVSnW+NTWbGYRPo+ZMRwecz0VYs6Kfc+j/EHADPHfzBmDuzW7u4QuX iQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2v5kckryp3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 24 Sep 2019 01:25:37 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 24 Sep
 2019 01:25:36 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.51) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 24 Sep 2019 01:25:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MsqyojzuqqMirLVCiCOxkjLYeLVNhF9a2phzOcKTG07Ht6Z/WOIoafRWqsFoGGK9wynZhM0s1/g2PGffJ+jeZtDyHOc8KxkRAnVmB4FAgr0NdyqH+jFiABQ4z+07td/jKQBb5jI6WqtHo/NdocR+SbCkhqPGVJmqa1GeIquTmqOiSetLf5Efnx8al0Fga2xKxQDhC2yrVWFHiNb643NevzCsaazuW/Ac60L8WJXZUPflynrb7sw5ipbWhPlruuAG1i96GGO4I7hWaZ39Mnsim+Pu3oatVi/KC4KMemnLEEePdAnBGByHKgu4xokos6j8YUsueQ2ugQFr59+9NV68UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+7/ljH9O3GcmuorfT2zMU228Q9OsIQKFQVwCgeAjv4=;
 b=nf62P7Sut1yjX8luNXKcZYX8mzOaNmy3wBHo9lbhRUiJI2LlQ2acVQuVIS5cbnUimXFq0Fw9TsOtbAxqQqJNriaCzKDxkPTHaLAE4W0guni+yTNIXIDFankOYuYI/ruJZMN87/QXV+hubl4KYv8Xsf0IpqeaMa3Xj26HHcwip22SRh5LVVYDF5LSVWZk/Hq4OLpKyTzxqyWKl6oiA1hh3RnsEPpjUAgkTeatMfVIHSmiDjXKEBVSgA275qifncNbCIA8vwHdhgSBD7E9THcNAJFPKtE05SvCKCFDJaOrKG68s/AXj0Ul9/CVFkXMVCUdux4JIURtV6Wy4y7B8uaRqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+7/ljH9O3GcmuorfT2zMU228Q9OsIQKFQVwCgeAjv4=;
 b=I/hwwC0nxGuuSYKOCZtsgEC0HsivNrkqFVGUOFpnxagEcXYxkeXApoUctTBPzmWvY6eXQzmqgKLeDix5PpkDeGrZt/vk2yt3ZeRZHQNNTYe9y9o7FDLPx26NmNlN3wUD9ye1/knH7TFxPeke2vxRa/afJJMCvk6kayeYQ7Ank/8=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3055.namprd18.prod.outlook.com (20.178.255.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.19; Tue, 24 Sep 2019 08:25:35 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 08:25:35 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Gal Pressman <galpress@amazon.com>,
        Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v11 rdma-next 5/7] RDMA/qedr: Use the common
 mmap API
Thread-Topic: [EXT] Re: [PATCH v11 rdma-next 5/7] RDMA/qedr: Use the common
 mmap API
Thread-Index: AQHVb7ju3H5srlnZKEWQePz8q/pg2ac4//HggABGfICAAT1F0A==
Date:   Tue, 24 Sep 2019 08:25:34 +0000
Message-ID: <MN2PR18MB3182A3C331E573CBB6A00380A1840@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190905100117.20879-1-michal.kalderon@marvell.com>
 <20190905100117.20879-6-michal.kalderon@marvell.com>
 <20190919175546.GD4132@ziepe.ca>
 <af160e72-bcc3-c511-8757-a21b33bd9e5c@amazon.com>
 <MN2PR18MB31828BDF43D9CA65A7BF1BC8A1850@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20190923132933.GC12047@ziepe.ca>
In-Reply-To: <20190923132933.GC12047@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.203.130.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71b7f4fb-7ccf-4141-a082-08d740c8c5c4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3055;
x-ms-traffictypediagnostic: MN2PR18MB3055:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB305533FAF99E67659CD5F7D9A1840@MN2PR18MB3055.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(199004)(189003)(7736002)(76116006)(54906003)(229853002)(25786009)(3846002)(7696005)(86362001)(14454004)(305945005)(6116002)(102836004)(52536014)(486006)(476003)(5660300002)(11346002)(446003)(71190400001)(6506007)(6916009)(8676002)(53546011)(66946007)(316002)(66476007)(64756008)(66446008)(66556008)(74316002)(9686003)(4326008)(55016002)(71200400001)(186003)(256004)(478600001)(99286004)(26005)(8936002)(81166006)(81156014)(66066001)(76176011)(2906002)(33656002)(6246003)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3055;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: teR7UU6rzT5NOphHmcrtRnGKWcSMOxoVov7lFrNEAT429T+Qldt6I5YZX1SoBKkH/o8YGsQnfvqWFCB7BraNafZTFSOUc47kmYRtwWkIyB5RbTWJ/g/GqMZcUUwqmEt0BZ/WV8hpFbGhw8zDME7oe/NyFF8BixjJ1Pf949LzH38LK0OvdBgI5GWxzBu1hJgAur0cvEfM0Vg/T8MKMS62EnWw/4xH3p7v1AqZbKyDjTZrA5DLjqENUA1fmnS+t2rBRjSPdMsPaJF8XDgRSfb502/jocVLdTzZi8VEG3KCpdNXALTlUj3PXxEG3h5hXamQmMk5e3sWJBmYWnvwkoXTcuS4+uiLuoHdwJS5JBB+rJnwtk6kQ68zYu+T5/3coUAMQJBnqELWRd2HTqwaJ8WHSxMoD9uuN1Jg0GCq0lGB5Ak=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b7f4fb-7ccf-4141-a082-08d740c8c5c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 08:25:34.5652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TWo3ls3DyIHGVzaD+y7lH69EO4aawv6Co113gTs/dZLhuKuU3dJaBmPrnsJaQjdkqiAXo66oqQu6u/zLy7WGIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3055
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-24_04:2019-09-23,2019-09-24 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Monday, September 23, 2019 4:30 PM
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Mon, Sep 23, 2019 at 09:21:37AM +0000, Michal Kalderon wrote:
> > > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > > owner@vger.kernel.org> On Behalf Of Gal Pressman
> > >
> > > On 19/09/2019 20:55, Jason Gunthorpe wrote:
> > > > Huh. If you recall we did all this work with the XA and the free
> > > > callback because you said qedr was mmaping BAR pages that had some
> > > > HW lifetime associated with them, and the HW resource was not to
> > > > be reallocated until all users were gone.
> > > >
> > > > I think it would be a better example of this API if you pulled the
> > > >
> > > >  	dev->ops->rdma_remove_user(dev->rdma_ctx, ctx->dpi);
> > > >
> > > > Into qedr_mmap_free().
> > > >
> > > > Then the rdma_user_mmap_entry_remove() will call it naturally as
> > > > it does entry_put() and if we are destroying the ucontext we
> > > > already know the mmaps are destroyed.
> > > >
> > > > Maybe the same basic comment for EFA, not sure. Gal?
> > >
> > > That's what EFA already does in this series, no?
> > > We no longer remove entries on dealloc_ucontext, only when the entry
> > > is freed.
> >
> > Actually, I think most of the discussions you had on the topic were
> > with Gal, but Some apply to qedr as well, however, for qedr, the only
> > hw resource we allocate (bar) is on alloc_ucontext , therefore we were
> > safe to free it on dealloc_ucontext as all mappings were already
> > zapped. Making the mmap_free a bit redundant for qedr except for the
> need to free the entry.
>=20
> I think if we are changing things to use this new interface then you shou=
ld
> consistenly code so that the lifetime of the object in the mmap_entry is
> entirely controlled by the mmap_entry and not also split to the ucontext.
>=20
> Having mmapable object lifetimes linked to the ucontext is a bit of a hac=
k
> really
>=20
Ok, but the ucontext "hack" will need to remain for other drivers.=20

> Jason
