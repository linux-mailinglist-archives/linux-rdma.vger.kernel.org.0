Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE40BE5CD
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2019 21:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387971AbfIYTiU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Sep 2019 15:38:20 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:60622 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728595AbfIYTiU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Sep 2019 15:38:20 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8PJc4iL032071;
        Wed, 25 Sep 2019 12:38:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=DNj7tn3PXOPd5jp0oGMBXKNL0jMHtpbyJR5KoZCU74g=;
 b=FX9EJCw25DubV9WIWs94YosUaIEHjNe85jXX0z1qrScErz4l8doZ5Y7cTqlJACr0gFNo
 D39BiNW0/opcnOYAcwpoQsslVOdO1vxOBG1qEpN28urTm8K7GK4dvQhsXPNHrIrU/SSg
 G87SXxnXO8w25S1XEL7Jhc/hyeFvZB7m5l7/U+RyJ2JEuwapYvV+bDRCwzQWFY2iLp7D
 IbtkE3PwfHDLtT3D9H8XK9e77KxFH2FwDvFG9oMQNcje3HmwoNJ56KzLSj56wfnkKgqv
 fFOMA/YKnMlm9tmNF6bDV90y6c0Q+lEl5NvhWx5IcvIT5+7PVSqXk+XoPddAaAxbVWNO rA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2v8ejgg01y-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 25 Sep 2019 12:38:15 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 25 Sep
 2019 12:37:39 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.57) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 25 Sep 2019 12:37:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhnnvUxCp/2QkBWtrXP3PtUEgtaPoUtcxvLuCdNrRL1tS9wiqPrz23UvD05ZjCszKwXotKUv2qttBM4IRICsGUBIqk+FXRuTAMhi5sLU69bc8Lev9g2hOGU+F+4XYJEXnwkPsj2G7g/IApwNPEEqrubWeWlbdPqkAREk5vuwnMWvA7wRU3kViFEJ9hOGAehrGV0Gcj9hV2uTV+9sXPuGlnvM+G0tMfjZq+EVa52KoiY72XyBxzDxC+vmVfAWovP6HDoH3iMVUmRfxPP4wUQFRl5wKjoRgaQr8aak96zHajETxxtd99IX+sGgUSQIQHEk+wwW5MxY5txw7Wu1XIQ7zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNj7tn3PXOPd5jp0oGMBXKNL0jMHtpbyJR5KoZCU74g=;
 b=mYYOuh859s1GxZGKYESTmY8s9uq502zOUJMmTiI2sHoXA1wsWjLCKZTvMSERWoyhnIfOcqrQs4rgXhDZy0mLNBgyqjG7lKrtlyoVjiGx9ODfXFnUpaTdQxNz3WkoL+8aiN07qf3XQwhsD3h+WcIAkRuTm8nGgjJT8SMJ7AwDvkGk8QbfllzO/T9baPl9IV0N9kOYgYIhHwLnunnCoM0u7QNp+VrBYgwFkta2SsLs78+i1x5dFzmOncdHSM47+wN+8xCFwoQsE6vu4j5e4NTE291slJuutsQHRqTRhh7JGig38w6azz6WXk1JAO2VD29PwWId2r19An1V05mA7Fxw1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNj7tn3PXOPd5jp0oGMBXKNL0jMHtpbyJR5KoZCU74g=;
 b=OjE4DN0C1wSG3+/902G/3SfKhv1W8rMhXBNhDExhD7m5yHqN3N9dfsvyQJGj2jfCPmalarAAWKZN41605fE5UpEiI4kjBkH+lXARhW3ivn/njbW05fL7dHby2Z/+QHyEBS3+OukPv4LJInaIA45iybv/gbvLm/uweSHntyI6wS0=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB2862.namprd18.prod.outlook.com (20.179.22.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.16; Wed, 25 Sep 2019 19:37:38 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8%7]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 19:37:38 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Gal Pressman <galpress@amazon.com>,
        Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v11 rdma-next 6/7] RDMA/qedr: Add doorbell
 overflow recovery support
Thread-Topic: [EXT] Re: [PATCH v11 rdma-next 6/7] RDMA/qedr: Add doorbell
 overflow recovery support
Thread-Index: AQHVb7eu6P3hyDpKHUmWhq7ahb1Rdqc0keGAgAg2/gCAAARtgIAAAF7A
Date:   Wed, 25 Sep 2019 19:37:38 +0000
Message-ID: <MN2PR18MB3182090D42CE1A01CF8C9D18A1870@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190905100117.20879-1-michal.kalderon@marvell.com>
 <20190905100117.20879-7-michal.kalderon@marvell.com>
 <20190919180224.GE4132@ziepe.ca>
 <a0e19fb2-cd5c-4394-16d6-75ac856340b4@amazon.com>
 <20190920133817.GB7095@ziepe.ca>
 <MN2PR18MB3182FEF24664E620E357B83AA1870@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20190925192101.GA626@ziepe.ca>
In-Reply-To: <20190925192101.GA626@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [109.66.1.192]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08bd0f53-dc81-41da-525b-08d741efd2ac
x-ms-traffictypediagnostic: MN2PR18MB2862:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB2862B02F965E252DFBA99309A1870@MN2PR18MB2862.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(189003)(199004)(316002)(64756008)(66446008)(66556008)(66476007)(66946007)(8936002)(9686003)(6246003)(76116006)(8676002)(55016002)(6916009)(81166006)(81156014)(52536014)(5660300002)(66066001)(256004)(6436002)(4326008)(305945005)(74316002)(476003)(71200400001)(486006)(71190400001)(7736002)(25786009)(229853002)(186003)(26005)(11346002)(33656002)(446003)(99286004)(7696005)(6506007)(53546011)(102836004)(86362001)(478600001)(14454004)(3846002)(6116002)(76176011)(2906002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2862;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MSV8Jw7DRUY3iOoj25AGFciBBkz/adolHPqPH292X8TB2EpP4m2AOt6pwgMjQgnbI096Qs5sqS7d32OyUDOic/tzV2ZXlGGoFEWBLrdkKO6Rn4ZGk4Y4nbiNwQKJNjl8GitUkFDwMuzehz7sHbTBHaTnDvO/CaQEMMtZ9CyNZdSYQkahEROPIckcwY2kxdbwiK2qdFvRPhYzo29scQ7tQii/D4NBqoCKGJ4TdZG+8dtNR1MejR8HgoqB7LPU9LqYLRwV6ChtkAkWpXX4gynCBApUrBRClAE5OAvPDEiPRHuBQ/vl6sngAn0UkwWJL9xC5kZ6T9a9wwqm7XDk2DUONN4zkFbKd7Xxh2QyLlZmlSCWl915Pi3gF9MrlDoPBc8drwU3+L/L8poBe+WSlaYe7JGLmlP+sHbUzFGOJ5vLWFU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 08bd0f53-dc81-41da-525b-08d741efd2ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 19:37:38.2043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v6K/yCRaSFTaxJKPdSCQajCHnruilki7kFx5lcBV5sNg3J5/AS1LrjnxGAtrYqUrg34LtSt6WxDnsC1JajXK9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2862
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-25_09:2019-09-25,2019-09-25 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Jason Gunthorpe
>=20
> On Wed, Sep 25, 2019 at 07:16:23PM +0000, Michal Kalderon wrote:
> > > From: Jason Gunthorpe <jgg@ziepe.ca>
> > > Sent: Friday, September 20, 2019 4:38 PM
> > >
> > > External Email
> > >
> > > On Fri, Sep 20, 2019 at 04:30:52PM +0300, Gal Pressman wrote:
> > > > On 19/09/2019 21:02, Jason Gunthorpe wrote:
> > > > > On Thu, Sep 05, 2019 at 01:01:16PM +0300, Michal Kalderon wrote:
> > > > >
> > > > >> @@ -347,6 +360,9 @@ void qedr_mmap_free(struct
> > > rdma_user_mmap_entry
> > > > >> *rdma_entry)  {
> > > > >>  	struct qedr_user_mmap_entry *entry =3D
> > > > >> get_qedr_mmap_entry(rdma_entry);
> > > > >>
> > > > >> +	if (entry->mmap_flag =3D=3D QEDR_USER_MMAP_PHYS_PAGE)
> > > > >> +		free_page((unsigned long)phys_to_virt(entry-
> >address));
> > > > >> +
> > > > >
> > > > > While it isn't wrong it do it this way, we don't need this
> > > > > mmap_free() stuff for normal CPU pages. Those are refcounted and
> > > > > qedr can simply call free_page() during the teardown of the
> > > > > uobject that is using the this page. This is what other drivers a=
lready
> do.
> > > >
> > > > This is pretty much what EFA does as well.  When we allocate pages
> > > > for the user (CQ for example), we DMA map them and later on mmap
> > > > them to the user. We expect those pages to remain until the entry
> > > > is freed, how can we call free_page, who is holding a refcount on
> > > > those except for the driver?
> > >
> > > free_page is kind of a lie, it is more like put_page (see
> > > __free_pages). I think the difference is that it assumes the page
> > > came from alloc_page and skips some generic stuff when freeing it.
> > >
> > > When the driver does vm_insert_page the vma holds another refcount
> > > and the refcount does not go to zero until that page drops out of
> > > the vma (ie at the same time mmap_free above is called).
> > >
> > > Then __put_page will do the free_unref_page(), etc.
> > >
> > > So for CPU pages it is fine to not use mmap_free so long as
> > > vm_insert_page is used
>=20
> > Jason, by adding the kref to the rdma_user_mmap_entry we sort of
> > disable the option of being sure the entry is removed from the mmap
> > xarray when it is removed by the driver (this will only decrease the
> > refcnt).  If we call free_page during the uobject teardown, we can't
> > be sure the entry is removed from the mmap_xa, this could lead to us
> > having an entry in the mmap_xa that points to an invalid page.
>=20
> I suppose I was expecting that the when the object was no longer to be
> shown to userspace the mmap_xa's were somehow neutralized too so new
> mmaps cannot be established.
Adding/removing entries is dynamic and done on qp / cq creation and destruc=
tion,=20
Could be done all the time. To neutralize them is only to add some interfac=
e that
Make sure the entry is deleted like wait for the event that refcnt reaches =
zero before freeing the memory,=20
Or leave it as it is now and only free the memory in the mmap_free.=20


>=20
> Jason
