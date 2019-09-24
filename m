Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13042BC422
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2019 10:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394959AbfIXIbX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Sep 2019 04:31:23 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:57560 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390364AbfIXIbX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Sep 2019 04:31:23 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8O8UiAd027381;
        Tue, 24 Sep 2019 01:31:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=tJYwOol7U07KCgVk6c8pxYdz9f06TzncAEMkiJ5ezFE=;
 b=eL3iKWdEeZhfiaNuvUWa4Gmpp5ITsly3dFIAt1UtSIRjqybVpnbQ0lyPJEz73vYcDTjW
 5D+PQ72SYoiy3WFwtc3mQ7SgFxhgFFSnw/kIWcoH7oopvdmxuaLPPuSchvbMPqzC0MDj
 y80HTX0Qg7FL01bTvdx3cWZfn3ZZk+ZFMrQai76b9zBpATUB309IhQ1J79n6sPkoNOeb
 r2LTUtsp7MVas9P0bj/NRP7ccWtGdIivVTnizgDEu4803OgEujeDb0AxXooEYdSjsq7F
 KeC7tPjz6UCnok2RX3fXf3TKKgvsEjIBW5Xhzv2BR3itbgtviu2hsrhHRdK4QSaTBRj2 Og== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2v5h7qhwhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 24 Sep 2019 01:31:19 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 24 Sep
 2019 01:31:18 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.53) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 24 Sep 2019 01:31:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcS2pqkiCijBIYLuua0QQ058LcGI8XH0ZzXl1zmQRz+y9EJeaZsS2UDKCS6jJSQICbtdmHApDST4LhEfI1o7i3RIEUzll/k8qVdcO0H3b8Tjh2QP0tGIdZsCzpg+2SaPFPPTE+SfKVguLiz2k9YUDEFjlO6gwbNUeAx0KDQuN551WsV75l1aWuXClCxEydmAfiwELB/ETjtuNdE5CecD8MTIeL+xQujdbVaorVihZh8edKbBLk8capk8xjNE3G6w0d+4xt8bJJZWTvFrLgrr1FZNrwcms+Mw0S2liXIxP5BOtIU30l3sP0lvjdwbng+Z9LepYCM5bR60nSq/T4MBQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJYwOol7U07KCgVk6c8pxYdz9f06TzncAEMkiJ5ezFE=;
 b=E7SEZdSxQej/oPPQGhTFYKxww3sXW73nPG4h3SEyQuxqoUyiiZyGLO2zSopKVS6cpspC2NV5mr8yQrAgjHshVyqm8uIPhCaYIMvHA9S74zs+ZtfsJwe1Z4jxjOusQ7xydX0gdsM+ZprbhcS6TTpVHyj6yHpVqHVEjMxZp4PM1SSdQRFLSZgsqVu0q1uhrTvGSB0ldVsYf4Z1tqHxKc7SK7s1iK0YXKHkV4kguxL1rljcTAtx/wUNoEPwawY0me9Vsw3uMoyIVTczO+X3DiA8e2PhWq5xxTGIzKPRkOLkEIPN+5Te7zfIQmf1PNkaQzF/4Y+FW70nBO5iB+qxvn/oKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJYwOol7U07KCgVk6c8pxYdz9f06TzncAEMkiJ5ezFE=;
 b=jeMmQMdS/C4SyZD7VI9zjZBYYT7Hh15bO330yHSMa2eseskeMPm/8kuLELQ1+pw8VblrH3ef7m8L7Nu51FOdbIx/IERHBk1AeUjOmRZA0Myu4aO/3oQ5n6OG5vtuleORyH3BaZjMaCrMKfrZWx0bYwKd7y4ZQT5dXmUqySdYokU=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB2943.namprd18.prod.outlook.com (20.179.22.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Tue, 24 Sep 2019 08:31:16 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 08:31:16 +0000
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
Thread-Index: AQHVY9EbgU9u1ehEnECRiayMwe50F6czYqUAgAW5klCAAEIlAIABPUuQ
Date:   Tue, 24 Sep 2019 08:31:16 +0000
Message-ID: <MN2PR18MB3182E0034A68DF1452BA73C6A1840@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190905100117.20879-1-michal.kalderon@marvell.com>
 <20190905100117.20879-3-michal.kalderon@marvell.com>
 <20190919180746.GF4132@ziepe.ca>
 <MN2PR18MB31822DCFCA312D6A455A000BA1850@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20190923133000.GD12047@ziepe.ca>
In-Reply-To: <20190923133000.GD12047@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.203.130.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9f1a78d-459c-4da4-abaf-08d740c9917c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2943;
x-ms-traffictypediagnostic: MN2PR18MB2943:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB29432064B1C3F8E21911F671A1840@MN2PR18MB2943.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(366004)(346002)(39850400004)(136003)(199004)(189003)(26005)(6436002)(99286004)(11346002)(81156014)(81166006)(66946007)(76176011)(9686003)(33656002)(8936002)(256004)(55016002)(476003)(14444005)(54906003)(446003)(229853002)(7696005)(478600001)(66476007)(66556008)(14454004)(8676002)(102836004)(186003)(6246003)(6506007)(6916009)(52536014)(66446008)(66066001)(316002)(4326008)(64756008)(305945005)(6116002)(5660300002)(25786009)(7736002)(3846002)(71190400001)(71200400001)(76116006)(2906002)(486006)(86362001)(74316002)(130980200001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2943;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lweTiitAb5EIuJAhv4DDgDn9QiY36ccrHaczM0ibTvu1nywlN1FOpUty8gCWv8fBet7PAtdahNbdb1Q6M0dHZ7vZGXPTOdRDtqnrIeKORIkIkdrZhjTNbXp0Ok3P8FZKPMiS1A94T37xczJikbi5B5TBKoJZvrusH1ewrN0TqDDRBDQ5blcftGpltEAqbZgm83Beo7AQqByKm9gxxoPnqpZ15oHILhSXbhBymv4i85ZyqnglpWG4Rve1C+CntWZbquUtPL0TZqlfjzjWCImJANCf7hVlvklNBx9wR2kXx7JVro2i/+wflpjneIiqkvnAabCPfQhcgw3ooulL+lzeAVGGB+rPjX7HI152nZ64PE/4L2eQzDllEb61LnPI17/P+O8ZTEp5RDBXEkDnwxUgipa2puzCamGpWZpcn1+8mB0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f1a78d-459c-4da4-abaf-08d740c9917c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 08:31:16.7616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fB6dfIUebH3ZzcXsym6SuvtnHQBazAcL4QNZLl6/H6VaY/XKBo6GEkQTbO9SU00qJO/bdOic5y5NJZuIXD7KwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2943
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-24_04:2019-09-23,2019-09-24 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Jason Gunthorpe
>=20
> On Mon, Sep 23, 2019 at 09:36:01AM +0000, Michal Kalderon wrote:
> > > > + * will use the key to retrieve information such as address to
> > > > + * be mapped and how.
> > > > + *
> > > > + * Return: unique key or RDMA_USER_MMAP_INVALID if entry was
> not
> > > added.
> > > > + */
> > > > +u64 rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext,
> > > > +				struct rdma_user_mmap_entry *entry,
> > > > +				size_t length)
> > >
> > > The similarly we don't need to return a u64 here and the sort of
> > > ugly RDMA_USER_MMAP_INVALID can go away
> >
> > So you mean add a return code here ? and on failure driver will delete
> > the Allocated xx_user_mmap_entry and not store it in xx_key ?
>=20
> I'm not sure what this means
>=20
Before fixing: driver allocated rdma_user_mmap_entry, receives a key and st=
ores
The key, if the key received is INVALID the driver frees the allocated entr=
y.=20
Wanted to make sure I understand correctly that you're requesting I change =
the
Function to return an error code, and on success the driver will store the =
pointer
To the mmap_entry structure and on failure free it ?=20
And the driver will not hold the value of the key, instead call a helper fu=
nction if it is required ?=20
Thanks,
Michal

> Jason
