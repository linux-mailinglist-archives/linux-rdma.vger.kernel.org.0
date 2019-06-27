Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 700B358254
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2019 14:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfF0MQy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jun 2019 08:16:54 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:35644 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726480AbfF0MQy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Jun 2019 08:16:54 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RCFKjC018572;
        Thu, 27 Jun 2019 05:16:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=fnqJO613oGukGX/XTwaYU/9qxkxsVhuxXDOYb77onXw=;
 b=gUW7RntBj2we14SIUOBKbNVEWsS/KUJ/ChMMc1zAM7zVeMgQzSPeLc0W2RRWvNYhhKaN
 Jm8VSRYu38OZoLKnmpYcXVCzCIGMUbOJY3oqYftsXgBtBBr18aFFNVNOYrDJ+69hm5kf
 5tintPf9+1Vt//0bJ4TT0oto4OV6SinCSfgVfAkuBKajEM38Kd+zWBT+YeX6zH+bwtX1
 Tql605ki1gmr2k+8MjhqMKykw3EvGQ9Oc0tVgOv839jsXw4RV4tc7eonZqdV3ZbDgo84
 PCQefU84hQJtm4+B9plbaEqW9SS0uEXBfMiOjYHLlBWHWamxQYqx1IfUJlby+w5qr8ed eg== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2tcvrs86ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 27 Jun 2019 05:16:29 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 27 Jun
 2019 05:16:28 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.55) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 27 Jun 2019 05:16:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=oHRMCAKiQlEuuEAgzs3zWecyizbqJzmUyl6bXq3QEO4Bs53Og+BkbolRGaezokwIopiuRRCpnUYsc9sGYjfDedIf00KDY9XSRYzkQZBX9RERu9/7DDkW5ill7pp90PdSKQljeRMpJ7IO47aK0KiYwAZp+h5qa/5l21MULfNmCYY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnqJO613oGukGX/XTwaYU/9qxkxsVhuxXDOYb77onXw=;
 b=g1JC2tQLK4Xd1lz9AnPtzXPUbGO/DxiVXgy2ol20KY+ew8CZUGcTG+fItdwOppHqaYMzh+7i5mAnDQimVIU4RJC+nY3zjOJPnTDTfKk2HIu2Y55N7GBUviQi5+P6XM65vBGBjPxpeNvnBBL3viqFI5XZi9SagIfzS4UvvddX33w=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnqJO613oGukGX/XTwaYU/9qxkxsVhuxXDOYb77onXw=;
 b=pHXAW1WhEddrhdAhM8YvC19mIADretmr51u/tdAQCVLZ6M8enVBP8krkWJMt6AM5chwWgR7TmrWvt4MPzhT7KtSmysu2lCVFS0SNwE8rB2oW/V4AEmYKPmlQBtrLFAMcK4IxqxB8/soup1uIc6MR7LWS4QqnLJY0kcUIMpmz9d8=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB2685.namprd18.prod.outlook.com (20.179.82.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Thu, 27 Jun 2019 12:16:23 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9880:2b8b:52e5:b413]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9880:2b8b:52e5:b413%3]) with mapi id 15.20.2008.017; Thu, 27 Jun 2019
 12:16:23 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v4 rdma-next 2/3] RDMA/qedr: Add doorbell overflow
 recovery support
Thread-Topic: [PATCH v4 rdma-next 2/3] RDMA/qedr: Add doorbell overflow
 recovery support
Thread-Index: AQHVKne/p0al+6AIWk6ybk0dKVF9w6aszVsAgAKgxoA=
Date:   Thu, 27 Jun 2019 12:16:22 +0000
Message-ID: <MN2PR18MB318289B11FB45CF296FE8EEDA1FD0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190624102809.8793-1-michal.kalderon@marvell.com>
 <20190624102809.8793-3-michal.kalderon@marvell.com>
 <20190625200404.GA17378@mellanox.com>
In-Reply-To: <20190625200404.GA17378@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.186.1.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31641441-fbc6-4c89-2c93-08d6faf9452c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2685;
x-ms-traffictypediagnostic: MN2PR18MB2685:
x-microsoft-antispam-prvs: <MN2PR18MB26858837F60269B1C339E910A1FD0@MN2PR18MB2685.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(366004)(136003)(39850400004)(51914003)(199004)(189003)(25786009)(8676002)(73956011)(66946007)(76116006)(8936002)(446003)(11346002)(305945005)(476003)(74316002)(66556008)(66476007)(33656002)(64756008)(486006)(81156014)(66446008)(81166006)(7736002)(14444005)(256004)(4326008)(2906002)(68736007)(478600001)(71190400001)(71200400001)(14454004)(86362001)(102836004)(55016002)(6436002)(3846002)(9686003)(7696005)(76176011)(6246003)(6506007)(26005)(53936002)(229853002)(186003)(54906003)(66066001)(6916009)(316002)(99286004)(5660300002)(6116002)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2685;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CQ1G3lMRqnglBV/AyVWLUYwv9ycsKWVxlSJbdV5O0v6dFaumT3MxoCYbqLYK/0QP12mfmgNkc4EiP665i4ADruQtMuhsOOHMAIp4YTBgh06az2eD+lsA+qX153aFXzwYrAkq9Vp0kDziFudePNTWC4yNXzyq/fJt/9+0G01fZpno/vGPmT7AVR8W4iy3D9m8l5RO4fGR3xosbX6/apyvPua/hTPnXwGIS5MU2DQKnu2pyKzRUcxFhar6ofgRIqlq+Vddgy7a8plaKZjY38sW3ZG9ma4OyUDgk01GbEWzgi4aMFibUms2TT1HjOwIjtS/OFE2KHCxqs8gfa4hjbTj3S71F71AWtP2SKzjj4irsKPMDswOr44kZRQBxlKtVmINgXzacJ8buanYRiClXjCBwP7W/oxSmTb6oPM47y6UehQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 31641441-fbc6-4c89-2c93-08d6faf9452c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 12:16:23.2218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mkalderon@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2685
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_07:,,
 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Jason Gunthorpe <jgg@mellanox.com>
> Sent: Tuesday, June 25, 2019 11:04 PM
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Mon, Jun 24, 2019 at 01:28:08PM +0300, Michal Kalderon wrote:
>=20
> > +/* Map the kernel doorbell recovery memory entry */ int
> > +qedr_mmap_db_rec(struct vm_area_struct *vma) {
> > +	unsigned long len =3D vma->vm_end - vma->vm_start;
> > +
> > +	return remap_pfn_range(vma, vma->vm_start,
> > +			       vma->vm_pgoff,
> > +			       len, vma->vm_page_prot);
> > +}
> > +
> >  int qedr_mmap(struct ib_ucontext *context, struct vm_area_struct
> > *vma)  {
> >  	struct qedr_ucontext *ucontext =3D get_qedr_ucontext(context); @@
> > -390,6 +446,8 @@ int qedr_mmap(struct ib_ucontext *context, struct
> vm_area_struct *vma)
> >  	unsigned long phys_addr =3D vma->vm_pgoff << PAGE_SHIFT;
> >  	unsigned long len =3D (vma->vm_end - vma->vm_start);
> >  	unsigned long dpi_start;
> > +	struct qedr_mm *mm;
> > +	int rc;
> >
> >  	dpi_start =3D dev->db_phys_addr + (ucontext->dpi *
> > ucontext->dpi_size);
> >
> > @@ -405,29 +463,28 @@ int qedr_mmap(struct ib_ucontext *context,
> struct vm_area_struct *vma)
> >  		return -EINVAL;
> >  	}
> >
> > -	if (!qedr_search_mmap(ucontext, phys_addr, len)) {
> > -		DP_ERR(dev, "failed mmap, vm_pgoff=3D0x%lx is not
> authorized\n",
> > +	mm =3D qedr_remove_mmap(ucontext, phys_addr, len);
> > +	if (!mm) {
> > +		DP_ERR(dev, "failed to remove mmap, vm_pgoff=3D0x%lx\n",
> >  		       vma->vm_pgoff);
> >  		return -EINVAL;
> >
>=20
> This is so gross, please follow the pattern other drivers use for managin=
g the
> mmap cookie
>=20
> In fact I am sick of seeing drivers wrongly re-implement this, so you now=
 get
> the job to make some proper core helpers to manage mmap cookies for
> drivers.
>=20
> The EFA driver is probably the best example, I suggest you move that code=
 to
> a common file in ib-core and use it here instead of redoing yet again ano=
ther
> broken version.
>=20
> siw has another copy of basically the same thing.
Hi Jason,=20

Thanks for the feedback. I looked at the efa driver and it seems perhaps we=
 can make
the entire mmap code common and not just some core helpers.=20
I will send out an RFC with modifying the EFA + QEDR driver accordingly to =
get your input.
Thanks,=20
Michal=20

>=20
> > +static int qedr_init_user_db_rec(struct ib_udata *udata,
> > +				 struct qedr_dev *dev, struct qedr_userq *q,
> > +				 bool requires_db_rec)
> > +{
> > +	struct qedr_ucontext *uctx =3D
> > +		rdma_udata_to_drv_context(udata, struct qedr_ucontext,
> > +					  ibucontext);
> > +
> > +	/* Aborting for non doorbell userqueue (SRQ) or non-supporting lib
> */
> > +	if (requires_db_rec =3D=3D 0 || !uctx->db_rec)
> > +		return 0;
> > +
> > +	/* Allocate a page for doorbell recovery, add to mmap ) */
> > +	q->db_rec_data =3D (void *)get_zeroed_page(GFP_KERNEL);
>=20
> Pages obtained by get_zeroed_page shuld not be inserted by
> remap_pfn_range, those cases need to use vm_insert_page instead.
Thanks.

>=20
> >  struct qedr_alloc_ucontext_resp {
> >  	__aligned_u64 db_pa;
> > @@ -74,6 +83,7 @@ struct qedr_create_cq_uresp {
> >  	__u32 db_offset;
> >  	__u16 icid;
> >  	__u16 reserved;
> > +	__u64 db_rec_addr;
> >  };
>=20
> All uapi u64s need to be __aligned_u64 in this file.
>=20
> > +/* doorbell recovery entry allocated and populated by userspace
> > +doorbelling
> > + * entities and mapped to kernel. Kernel uses this to register
> > +doorbell
> > + * information with doorbell drop recovery mechanism.
> > + */
> > +struct qedr_user_db_rec {
> > +	__aligned_u64 db_data; /* doorbell data */ };
>=20
> like this one :\
>=20
> Jason
