Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3D129CEA2
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2019 13:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731011AbfHZLxU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Aug 2019 07:53:20 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:17734 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729961AbfHZLxU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Aug 2019 07:53:20 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7QBog19032733;
        Mon, 26 Aug 2019 04:53:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=J2A4eF/LDi0UyCTjjxSkNV3f9aiqA9AbY5zj9yfOayg=;
 b=ZshS0WII3L9VftZNxj37+JgWURsK9dpltZovY2rczpCy1B+VSvq1S1Fd3yizJuZayRyB
 4b4jZgK6ADwYbKSKFKSJ0d2zlk4CpswLYJpA27S53kC3b0bL8SVuSS58GqZD9DkG+13F
 BT5+1KSgSi0IMbKrvee6pjYppGDusrmJkRW6GRjl3dCxPWA0AM+xO4vx6SA6WfDSvd9j
 Xe+aY8b3Omx7enN18yI9n5k9uVVO7AA1c0OVDZkLJRjQcJBpaC997XzwO1BspCYwcVQ2
 exGdfMPhVt3DRM63u+e2v0xaDNHURQabTY/ATYMwbPplU3n3kGDufVQJcPhAI1KjVhpb uw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2uk2kpxv5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 26 Aug 2019 04:53:16 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 26 Aug
 2019 04:53:15 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.57) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 26 Aug 2019 04:53:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0KHgwVuSPvDSJII1uFTkv1exnF7f5yfOSOS1obX2rT2w+jPeDew8l/JehUVnEclPooYnimXxIcEGiOKA5E2D5JBrct954njvfPmjuzOtPFirxPGUHu03IFXLtkYlqmZjm1KGEr8ng/oNvslKH3/jxugavveul4bGsESyq/0hIeuKvCWvpvs3X6JloSFFUhAFHVB9R49p4NpQVge/iZQFdR2EPquQaRUlpcTPMIuOfGghTbX+onu5o9kBLv7QbQLDHlnEaGhfVsXaeFBtdcPnaRmxXXkmAoTf426hRrXxqx+20Ay7ZTlchYe8tzurmFHRJ7+5Na16arbP5kmqjRe/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2A4eF/LDi0UyCTjjxSkNV3f9aiqA9AbY5zj9yfOayg=;
 b=i0WfvBNNgHrD0QlG1fRT+/Ec35JXP6HH6SCPjoYJ34wQ0PEdfl98emtHLcI6/oTCqlXKPFQbz/jNo1zthGE+SBem9n8h71mh5WS3c1W2IrXa4O2vnUAmlXEOSsZ6FLFGcl8ss2sPOrdbrXdMf6RdcRolRp17/DPHTZpi9ksUTgi2v8vinjTdpW/yvadaud/mbWjFk5m7feVqhPkDYd/0aMGrMUMMI46+cscPuyLoK607MIaYwXf5g+KtMhmjEybkbPfcuJ3nCDtLuh1qp7x307rv7gLdrKMrtYFEKUhQ3MNHiS1XgcT0gJQ12PG5IBW6/Lf/0VXCwqon33CiVvnHAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2A4eF/LDi0UyCTjjxSkNV3f9aiqA9AbY5zj9yfOayg=;
 b=EJsegu+Ht7jjV/yUAPu/pwrR/8hLrvWhvZ/CiI9yGKWZxp7fHbvJ24QBrCxtOWQWj9H3T1tkWPQW5ggkQpL6alqQF3Mp/Qrqq3ONnpOPzdjVKqMqIKCqzhTsbpU79M9HLTRib+YMflY/8f/Zy1wnxmEaalrsUOt4p58GEfrZ2qk=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3295.namprd18.prod.outlook.com (10.255.237.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 26 Aug 2019 11:53:10 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::f001:1b96:3396:1781]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::f001:1b96:3396:1781%5]) with mapi id 15.20.2199.020; Mon, 26 Aug 2019
 11:53:10 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     "galpress@amazon.com" <galpress@amazon.com>
CC:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: RE: [EXT] Re: [PATCH v7 rdma-next 2/7] RDMA/core: Create mmap
 database and cookie helper functions
Thread-Topic: [EXT] Re: [PATCH v7 rdma-next 2/7] RDMA/core: Create mmap
 database and cookie helper functions
Thread-Index: AQHVV1GzaBcLwMoagEypYNTXoU3KUacEBbGAgACDqWCAAUW1MIAAA5+AgAACoECAAAojAIAHewgg
Date:   Mon, 26 Aug 2019 11:53:09 +0000
Message-ID: <MN2PR18MB318200091BB02266B29125DAA1A10@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190820121847.25871-1-michal.kalderon@marvell.com>
 <20190820121847.25871-3-michal.kalderon@marvell.com>
 <20190820132125.GC29246@ziepe.ca>
 <MN2PR18MB31821E7411D0E44267F4A256A1AB0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <CH2PR18MB31752BE286837BFDCEE3B17CA1AA0@CH2PR18MB3175.namprd18.prod.outlook.com>
 <20190821165121.GE8653@ziepe.ca>
 <CH2PR18MB3175EDB5640A3987D97A4DC0A1AA0@CH2PR18MB3175.namprd18.prod.outlook.com>
 <20190821173702.GG8653@ziepe.ca>
In-Reply-To: <20190821173702.GG8653@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.203.130.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2d0dfb2-285e-4eae-74b2-08d72a1bf78a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3295;
x-ms-traffictypediagnostic: MN2PR18MB3295:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3295C16DF30C9F38FFB5D8F6A1A10@MN2PR18MB3295.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39850400004)(346002)(366004)(136003)(376002)(189003)(199004)(86362001)(186003)(74316002)(305945005)(2906002)(7736002)(2351001)(5640700003)(6436002)(3846002)(6116002)(33656002)(66556008)(66946007)(66476007)(2501003)(66446008)(52536014)(64756008)(5660300002)(71190400001)(14444005)(256004)(71200400001)(76116006)(6506007)(14454004)(316002)(99286004)(76176011)(54906003)(7696005)(6916009)(476003)(486006)(229853002)(81156014)(53936002)(66066001)(8676002)(8936002)(1730700003)(81166006)(55016002)(9686003)(4326008)(25786009)(478600001)(102836004)(446003)(11346002)(6246003)(26005)(130980200001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3295;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JrmEl5DpBfP4OTTWmnBbp0MDlW8GAKNegeAgH88fdh1snok++mM24WwJf8p8vwtYgbsZxfv1xQI1+VHrmVmXLHgSm1GUSF+y/yPNMGL3/2heFaotfGu3JGYPu/L/L1T7ydYPhumPqtH4t2k/avD07gVQD14HqA5rCtTTiR83d5MG8tW/qtr7WleHdgwXHihl2rnbehAc+4E7HAK9neJ7/V9XoAc/OPZZPDorbu6rGHAU50tVfng5ThHNGvdqv3ykn5xh439nqLmx+GNxM65unXxYjMR+T7EqDM4WCXt+Py1yn2Xmg28+gVcAFkY5KRXnXTSUVo0Z7a9gEAzxDly6y/4jo+6xxW4lWX5iQfClTYnmptsv/nyDMwiz35WQ78LszBrZUw4Y1YOQP5CgWPvHVBAhagqae1AVjCS/sxY28PE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d0dfb2-285e-4eae-74b2-08d72a1bf78a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 11:53:09.9615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B2bRdFNDpBjkaSAFTdqgX1E11zBx31VIvTM4ZOtfNvS5PvV5q+h1I2xFkXwh54pmUOaPdhQvUl1eaHysZCLqmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3295
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-26_07:2019-08-26,2019-08-26 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Wednesday, August 21, 2019 8:37 PM
>=20
> On Wed, Aug 21, 2019 at 05:14:38PM +0000, Michal Kalderon wrote:
>=20
> > > > Jason, I looked into this deeper today, it seems that since the
> > > > Core is the one handling the reference counting, and eventually
> > > > Freeing the object that it makes more sense to keep the allocation
> > > > In core and not in the drivers, since the driver won't be able to
> > > > free The entry without providing yet an additional callback
> > > > function to the Core to be called once the reference count reaches
> zero.
> > >
> > > This already added a callback to free the xa_entry, why can't it
> > > free all the memory too when kref goes to 0?
> > True, could free it there. I just think we'll have a bit more
> > duplication code
>=20
> Well, the drivers already needed to allocate something right?
>=20
> > Between the drivers defining a very similar private structure and
> > adding Allocation calls before each of the rdma_user_mmap_insert
> function calls.
> >  And just to make sure I follow,
> > Do you mean creating the following structure per driver:
> > Struct <driver>_user_mmap_entry {
> > 	struct rdma_user_mmap_entry umap_entry;
> >               ... <private fields> ...
> > }
>=20
> Yes, that is the general pattern
Gal,=20

Following this request from Jason I took another look at the obj that origi=
nally
Was stored in efa_user_mmap_entry, this was used only in debug prints.=20
Do you see added value in storing this obj? or do you agree
We can drop it ?=20
Thanks,
Michal


>=20
> Jaosn
