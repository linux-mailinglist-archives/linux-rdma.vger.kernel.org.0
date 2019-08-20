Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFA9896B7C
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2019 23:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbfHTVbA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Aug 2019 17:31:00 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:37588 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730273AbfHTVa7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Aug 2019 17:30:59 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7KLU2pl018234;
        Tue, 20 Aug 2019 14:30:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=T48mtgX+ETv7DTOmJ5OSKUONcb4PgiIPPoNA97922I4=;
 b=FjMj4W4jhVoPRpi57D3k7EPXg8g9CVwuB/f/g//DppQBQDeq+S/CjlVcqZ2PSSmWwuh2
 GZjuAlkQRAEe3Y9gBoBlqR/uX4ytZLtCRYlD7kVPWnDE2LYecn+gngG9vroefOEW0uuo
 RUG6wIs7BfFtPLz/nKfbkLFg7K0rXNGYqh8ZrO82FSNWkc+m6H8UWOzH/MnKVJqa5EvI
 Flon/sgaazDKIy2VGS2pUZlucViMI1xgNnYv8OycPV/d2f5BjHot2xmA+oqXRykUWFRt
 S8FS0AfMUW4mT7/b7N/5kH6PSVT1fc2pSpGTdD3B45WA7Dst/aNh9wHGnogBy2XcXj9f JQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2ug8a9by6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 20 Aug 2019 14:30:56 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 20 Aug
 2019 14:30:55 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.54) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 20 Aug 2019 14:30:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQJDLPI8GvuU/VhvbGuT4fCAS0FMXqoWE6BPuZZqmEVE9oNEfEe9IhW5FwLNF4A09XDAxkguegZXNAeZtvv+75g2KKHRRRxA8eTY+JOx0sxYlc3ceX2nKMm6HozpHSVFp1aP/p4CoivWDgiDhpwxl9H7VTPn/+rI4joKbDoqCtd7WDt4RIFiNEzc+wAtDoIKb10T6hesQX2wmmn7n3U+xkIwl99zXJ8jE86YvwJ4XfHrCpFzy4YiXIHkynJmPUR0GZfaSAH8ZgMOpwRje/TKkyMM538CXGJWHv84q9fm7Pn7TlRJLFWCsza2WOPbyIlMhU2YI/LqA/DCLuQubZXHDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T48mtgX+ETv7DTOmJ5OSKUONcb4PgiIPPoNA97922I4=;
 b=f3mC8E/0WrfpOT8lJ7zEUCSLN6JGmTecte1T7vEjJIFZ75vfQPSHYeI9SJcHOQLb/TLHRSaM+IRAPLGv14NYjqPoWZcb6vtgmyRDEXQfGr7UbQvY/1MdY4FZS7mnDmZhqQ8RDa9uMm5hu0lViRoTq352Mi1peDlVo9eYDIhlHDL5UHW/3jzfVX0b3wtp04s3ZxNJZKSI8SEHK7nIXeWETtC8XBaLnOSlOfP77Wv2gtClXhp08Sggp13V4+pQLh1GP4EJBORSimwgTtQQdMKSUKHaVVkek8FmV7smwJqs2UfXDCrudTHp+Nmx27LWnPhRT/O8lTjTTUJ+1t24qn1mPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T48mtgX+ETv7DTOmJ5OSKUONcb4PgiIPPoNA97922I4=;
 b=sR7uegFSXeW1ERRUhXbUXiNPXBERPT04kRJlCLv29yvFyroJJ6bMndOu4a/xOdNJZc8IX0PFRDdh8rhJe9kd8qrav8Tu/sNr5q8r+laBV/7vXqKraoXEDX3d1hDwRC2esxTDo3qxVgJgJz6PZS89BmsmP35jU3pwhTXOp6azTVI=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3357.namprd18.prod.outlook.com (10.255.238.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 20 Aug 2019 21:30:51 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::f001:1b96:3396:1781]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::f001:1b96:3396:1781%5]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 21:30:51 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Ariel Elior <aelior@marvell.com>
Subject: RE: [PATCH v7 rdma-next 1/7] RDMA/core: Move core content from
 ib_uverbs to ib_core
Thread-Topic: [PATCH v7 rdma-next 1/7] RDMA/core: Move core content from
 ib_uverbs to ib_core
Thread-Index: AQHVV1GwGCRn/XfymEKuSvdhB7Bdf6cD/yqAgACNMfA=
Date:   Tue, 20 Aug 2019 21:30:50 +0000
Message-ID: <MN2PR18MB3182CAADFAD352E8FD4A2169A1AB0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190820121847.25871-1-michal.kalderon@marvell.com>
 <20190820121847.25871-2-michal.kalderon@marvell.com>
 <20190820125803.GB29246@ziepe.ca>
In-Reply-To: <20190820125803.GB29246@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [79.178.37.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 107ad16e-2750-4cc5-e5ae-08d725b5ac9d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3357;
x-ms-traffictypediagnostic: MN2PR18MB3357:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3357272B1B61771DEBA67AD4A1AB0@MN2PR18MB3357.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(189003)(199004)(8936002)(7696005)(76176011)(71190400001)(478600001)(71200400001)(14454004)(45080400002)(86362001)(14444005)(26005)(186003)(256004)(4326008)(9686003)(25786009)(76116006)(66476007)(107886003)(8676002)(81156014)(6436002)(81166006)(55016002)(66946007)(66556008)(66446008)(64756008)(2906002)(316002)(5660300002)(6246003)(53936002)(305945005)(7736002)(33656002)(66066001)(229853002)(52536014)(3846002)(102836004)(6116002)(6916009)(11346002)(486006)(476003)(446003)(99286004)(54906003)(74316002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3357;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kmd6YO7tMxi/bEApxYLoJMCRkc++wt94pR5KMjF/yjJk/cQPWsS+KELwaJEjJAJO/rAF4eVn0PUdiT1X2of0VQa/9YHtZ4KUfvmuCA8Fl4X1x7pRmz2IyuokSs8SWEoggFf18IVeMOFZzdnrHTX3fTlVxfvTUb6ehaNwdMFxNgNhJVAx8vdG8wXOwgemHxaDimdg/Fea4NziKHB3OskQbJh0jGHVMZ+vphNSx4eARaMkWXq6kE6JkEo2BgCsQ4KmoPPBgUBZ85Oz+0YkVPqOjvcYQyQZRyEBHNgsZUOc2JZupB6P9iM1pAs+69k17uM7J4b3drF3RQOWHsIrC6u/AEq48uRN6mbYNV3yiXZc55OR3ZUp2o6eRyEloUljuOYcGPfJn7fWGH3IqQsCqoFI4AB5IEPbZoMKquYXYCnGP/8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 107ad16e-2750-4cc5-e5ae-08d725b5ac9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 21:30:50.9882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wohc43GffrSBN63C58bo5p37d2eu+fE/+XPKApqX8FZ3NUGCdRTucVglrm2D47E/ZSx3IStp7fzIdOkv1lcMVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3357
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-20_10:2019-08-19,2019-08-20 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Jason Gunthorpe
>=20
> On Tue, Aug 20, 2019 at 03:18:41PM +0300, Michal Kalderon wrote:
> > Move functionality that is called by the driver, which is related to
> > umap, to a new file that will be linked in ib_core.
> > This is a first step in later enabling ib_uverbs to be optional.
> > vm_ops is now initialized in ib_uverbs_mmap instead of priv_init to
> > avoid having to move all the rdma_umap functions as well.
>=20
> Sneaky, lets please have a comment though
>
Sure, will add.=20
=20
> > +/*
> > + * Each time we map IO memory into user space this keeps track of the
> mapping.
> > + * When the device is hot-unplugged we 'zap' the mmaps in user space
> > +to point
> > + * to the zero page and allow the hot unplug to proceed.
> > + *
> > + * This is necessary for cases like PCI physical hot unplug as the
> > +actual BAR
> > + * memory may vanish after this and access to it from userspace could
> MCE.
> > + *
> > + * RDMA drivers supporting disassociation must have their user space
> > +designed
> > + * to cope in some way with their IO pages going to the zero page.
> > + */
> > +void rdma_umap_priv_init(struct rdma_umap_priv *priv,
> > +			 struct vm_area_struct *vma)
> > +{
> > +	struct ib_uverbs_file *ufile =3D vma->vm_file->private_data;
> > +
> > +	priv->vma =3D vma;
> > +	vma->vm_private_data =3D priv;
>=20
>    /* vm_ops is setup in ib_uverbs_mmap() to avoid module dependencies */
ok
>=20
> > +
> > +	mutex_lock(&ufile->umap_lock);
> > +	list_add(&priv->list, &ufile->umaps);
> > +	mutex_unlock(&ufile->umap_lock);
> > +}
> > +EXPORT_SYMBOL(rdma_umap_priv_init);
>=20
> Does rdma_umap_open need to set ops too, or does the VM initialize it
> already?
Will double check
>=20
> Jason
