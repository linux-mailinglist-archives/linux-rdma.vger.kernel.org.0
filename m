Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D141BB12F
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2019 11:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfIWJQK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 05:16:10 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:52058 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726462AbfIWJQJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Sep 2019 05:16:09 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8N99YLI003274;
        Mon, 23 Sep 2019 02:15:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=oF1lJdZXLoJk0iliLxlaZzEQ4QASkNesmdYr+9NGOuw=;
 b=d1yQ8TcxuUuCWlyxgdR/4122bohp4vYR24AsaSkjDYv39kfUiqed9bj0XscwgySivT/s
 mbGQ5kwM5Tv8EYz8ac83TF5k1qdHI+pxsaItQQ2w5AyhQ/iqkm5i1Xgpt7SELB81MALr
 1skgEaCRGMDouXnHjeuHAukglKluZDvVBtfh8RRAjnMSRx2FDLc4wpdxhdE6bpZMsclu
 VZktWDr8sT1GJI6wv+LnnQPikC7a9otxRYlFMF7O6C/yI8X9elhakmY1U9HMEyoEqgAT
 JSEiaTB1Ex/qYtUWPyBqLDOvXwp6j+TC/SddSsrX0/Cqf/yU56NXqiWqKQb02i882C7y Bg== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2v5kckn4dv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 23 Sep 2019 02:15:58 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 23 Sep
 2019 02:15:56 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.57) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 23 Sep 2019 02:15:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNM4UhFi2vPSopbqcmAAsrNicyByR3MLtnnGklBt/r3uUopoCLG56DJoHVOFp9UtzrCorkKARPxi56G5I/v6bCHUHuocCYw4z7RMRYHmQIFXcI28/WR1oyLk26oQlvTU+f0ShHEkT7pFP74LwjolRVgExjb6fgeAJoyMj6D/jTsZxnyc0Uwp2yxwvkoiDJfB6h/XxYnpRvaNlmRA9GsOVjhyiA24t4NLQMleYkPlp8dz+l8Vwz1ytDTvXLO0uxWEE3SApd6NtZ/ovyyX1yCfnKH74LUV7iedGPFPfBnS2k9oF4bu2D0B9zblMYoIQqkF4Hvl09FzfZBZH4kX7ZivWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oF1lJdZXLoJk0iliLxlaZzEQ4QASkNesmdYr+9NGOuw=;
 b=DpVlloB1oW2beT2a308C65gyiF7RtNXgYXq/sTD+ZcSpRVCHeZYwLSnuxFjPn6xBGwaF0TjrDNmqxO8eqz81cTcRSxQ+7vXkqaLYi5sBZLsMhVcMw0RQA7pa0zqFqBVFXbviqLTfVPQO8BqSq3AwrWOGdc6hspL8xIOAPRn4DReBFbc81ZS9as6LA45DbuhlkDuA40OiUGxIaGYzWxEbIhvisgQGjVbp0S6HMFl73tezIgPxr0siySmxc/60gN7r9Wm7evJfa2VAZLnrVX/h/x/E+BibbpLeF41Rm3V74eNknN1UKLucKfw7qCPXI1/6te0xh6jg8kr6hAl5ydShpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oF1lJdZXLoJk0iliLxlaZzEQ4QASkNesmdYr+9NGOuw=;
 b=qZmNlPZBu1FvJWU+KUtGwZVC13dVdyF4QIkARFvfqaC3loY0L3XWi+3eiOskzxCVeCpd4nbeKWGVARCrQxJXIprzU/O1DphEiFCGWMqEKknM1OdM8FhJ3qymD7QQ/hkiVPiXo2SRxPBH9FiDmyz/BBqCv9PCt3LWbEtxm6flGdg=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3327.namprd18.prod.outlook.com (10.255.238.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.21; Mon, 23 Sep 2019 09:15:54 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8%7]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 09:15:54 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v11 rdma-next 3/7] RDMA/efa: Use the common mmap_xa
 helpers
Thread-Topic: [PATCH v11 rdma-next 3/7] RDMA/efa: Use the common mmap_xa
 helpers
Thread-Index: AQHVY9Ecmk+iuGE1IkmkMy7TMSD9EKczWg2AgAW7lHA=
Date:   Mon, 23 Sep 2019 09:15:54 +0000
Message-ID: <MN2PR18MB31823E8EADC7E27A12D09423A1850@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190905100117.20879-1-michal.kalderon@marvell.com>
 <20190905100117.20879-4-michal.kalderon@marvell.com>
 <20190919173701.GB4132@ziepe.ca>
In-Reply-To: <20190919173701.GB4132@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.199.69.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58056772-8c2d-462c-d1b4-08d74006a305
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR18MB3327;
x-ms-traffictypediagnostic: MN2PR18MB3327:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3327BF39658EE283213C0B6CA1850@MN2PR18MB3327.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0169092318
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(376002)(346002)(366004)(136003)(396003)(199004)(189003)(4326008)(2906002)(305945005)(8936002)(476003)(33656002)(3846002)(6916009)(74316002)(7736002)(52536014)(6116002)(102836004)(76176011)(446003)(99286004)(11346002)(66066001)(7696005)(486006)(71200400001)(71190400001)(26005)(81156014)(229853002)(66946007)(76116006)(55016002)(6506007)(6436002)(186003)(66556008)(64756008)(86362001)(9686003)(478600001)(8676002)(14454004)(81166006)(256004)(316002)(25786009)(5660300002)(66446008)(6246003)(66476007)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3327;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XLwhnA8mPb3lwsLDODEppHkJZX9Ryy2VFHvjrysjvBCvJXx0VTczf6GzWhekMmQUrmUKQsHEIsDxw1RsXB1Gs0JtdfDfDC+Cgo6Rtrk1KeA+LygYhAaW3SqTFeMHxZskcLxTE8vgH7KqV76GXThV97+FlqQhpkyPDKX/DHBf1C0qLbuDoCTR+UQd9Kd22sYZsUZ2Lw/Ojx4MVGRb/LR9zL9IdTAy3S54hKtpnZiVVCuFnLi35MgkySeUKzACSEc05O4qL1dIl+OhYnFh1PTPP5tJH0VfSQcAev+upVjq23z45mvjFHWOJgKiSds5O23cmK74MdIJ7kBkvR0kKK76Y7bgpxhcL2ts+6weDkOBfP/JUK2pkN6Mp0n1nyZrobxV0qABkqLW9UGK7W0GavSCAZuz7zi1DTZrsVyk5i1uD1k=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 58056772-8c2d-462c-d1b4-08d74006a305
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2019 09:15:54.3924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ohtf0ufL/ET4Ec1ZGD1ALYb/1A2mQ4IwE/25B0UuFrjK3U6dO75EYMZA7ggIXA7vxB3ZP7bMES4kvsm/7pqF3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3327
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-23_03:2019-09-23,2019-09-23 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Jason Gunthorpe
>=20
> On Thu, Sep 05, 2019 at 01:01:13PM +0300, Michal Kalderon wrote:
> >  static int __efa_mmap(struct efa_dev *dev, struct efa_ucontext
> *ucontext,
> > -		      struct vm_area_struct *vma, u64 key, u64 length)
> > +		      struct vm_area_struct *vma, u64 key, size_t length)
> >  {
> > -	struct efa_mmap_entry *entry;
> > +	struct rdma_user_mmap_entry *rdma_entry;
> > +	struct efa_user_mmap_entry *entry;
> >  	unsigned long va;
> >  	u64 pfn;
> >  	int err;
> >
> > -	entry =3D mmap_entry_get(dev, ucontext, key, length);
> > -	if (!entry) {
> > +	rdma_entry =3D rdma_user_mmap_entry_get(&ucontext-
> >ibucontext, key,
> > +					      length, vma);
> > +	if (!rdma_entry) {
>=20
> This allocates memory and assigns it to vma->vm_private
>=20
> >  		ibdev_dbg(&dev->ibdev, "key[%#llx] does not have valid
> entry\n",
> >  			  key);
> >  		return -EINVAL;
> >  	}
> > +	entry =3D to_emmap(rdma_entry);
> > +	if (entry->length !=3D length) {
> > +		ibdev_dbg(&dev->ibdev,
> > +			  "key[%#llx] does not have valid length[%#zx]
> expected[%#zx]\n",
> > +			  key, length, entry->length);
> > +		err =3D -EINVAL;
> > +		goto err;
>=20
> Now we take an error..
>=20
> > +err:
> > +	rdma_user_mmap_entry_put(&ucontext->ibucontext,
> > +				 rdma_entry);
>=20
> And this leaks the struct rdma_umap_priv
>=20
> I said this already, but it looks wrong that rdma_umap_priv_init() is tes=
ting
> vm_private_data. rdma_user_mmap_io should accept the struct
> rdma_user_mmap_entry pointer so it can directly and always create the pri=
v
> instead of trying to pass allocated memory through the vm_private
>=20
> The only place that should set vm_private_data is rdma_user_mmap_io()
> and once it succeeds the driver must return success back through
> file_operations->mmap()
>=20
> This hidden detail should also be noted in the comment for
> rdma_user_mmap_io..

I actually misunderstood you before and thought that we want to maintain al=
l mappings in umap.=20
Now I understand you meant only the io mappings, since they're not referenc=
ed counted by the mm system.=20
I'll revert the changes and add an additional parameter to rdma_user_mmap_i=
o ->=20
However, this means more changes in drivers that call this function and don=
't use the mmap_xa,=20
Should I add an additional interface ? or are you OK with me sending NULL t=
o the additional parameter from=20
all drivers using the interface ? (hns, mlx4, mlx5)=20
Also, who should increase the refcnt of rdma_user_mmap_entry when it is set=
 to the vma private data ?=20
The caller of rdma_user_mmap_io or inside rdma_user_mmap_io function ?=20
This will definitely simplify things. =20


>=20
> Jason
