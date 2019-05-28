Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 946152CECE
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 20:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfE1Sll (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 May 2019 14:41:41 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:56706 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726400AbfE1Sll (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 May 2019 14:41:41 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4SIVhhQ013925;
        Tue, 28 May 2019 11:41:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=GrenTS/jLTnqhytj5Y2V9pxhB3FSCMHkWa17hBz923k=;
 b=g3AVCGOuK5dXJ2GxkO/MmnSYfxwiWW8QKJ1w1IaFOyHk/IZU9shHAqoJhwIwBjbZuPdR
 f0RbE9B4tjxZz14dNIdV/oywj1wmft4AuWsuJufHQqxPfrlZ7F7xap4C72kiRH7nVJbL
 t+ibgePkUVnLm777hevW1/M5Vs/zFvG7tG38tcZ8zu3S4PW/fErqbykMk+HpK2TIwy4D
 uVIQoRtDvTx7KWvoo9iktvmwcl5Ik6dGwLTYj6e6JqwtRIYQJDBlu6GrroVrztu+5tOQ
 DeWnSUtCQ7wYWn6/Jo/dlvQSUSBce5LSwo4N0Ev/EFtlYOE8xLtEZbR8XvPm6Iu4d4wr ng== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2ss6w6s3pw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 28 May 2019 11:41:31 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 28 May
 2019 11:41:30 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (104.47.50.58) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 28 May 2019 11:41:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrenTS/jLTnqhytj5Y2V9pxhB3FSCMHkWa17hBz923k=;
 b=Liz1mNJ0DGIf4kWGnuR891LCnmMjAS0t2mdh+Ij/nf0sf6qJKVP7Hgu7PvEvU6WX9Uxb1xP9NVe/f5Zk6RZVWTPE5gTU/9Z77EWWTh2F1zJqlyeP5NiLcO+z7zizlI0VnI6YU5uoPPiK8QDyTgCjN+5/leV57TsLjf0Teo2seTo=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.22; Tue, 28 May 2019 18:41:28 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9880:2b8b:52e5:b413]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9880:2b8b:52e5:b413%3]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 18:41:28 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Ariel Elior <aelior@marvell.com>, "jgg@zeipe.ca" <jgg@zeipe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v2 rdma-next 1/2] RDMA/qedr: Add doorbell
 overflow recovery support
Thread-Topic: [EXT] Re: [PATCH v2 rdma-next 1/2] RDMA/qedr: Add doorbell
 overflow recovery support
Thread-Index: AQHVFUf8y7Hf1AUzJkOck2OdofgQ9KaAttMAgAAjSYA=
Date:   Tue, 28 May 2019 18:41:28 +0000
Message-ID: <MN2PR18MB318249A0D35E51A5B4E30131A11E0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190528112401.14958-1-michal.kalderon@marvell.com>
 <20190528112401.14958-2-michal.kalderon@marvell.com>
 <20190528161624.GB31301@ziepe.ca>
In-Reply-To: <20190528161624.GB31301@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [79.181.13.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9396752c-eac7-4330-a94c-08d6e39c18b9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR18MB3182;
x-ms-traffictypediagnostic: MN2PR18MB3182:
x-microsoft-antispam-prvs: <MN2PR18MB31826FB64AD8984E237B295DA11E0@MN2PR18MB3182.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(396003)(39860400002)(136003)(51234002)(189003)(199004)(8676002)(256004)(33656002)(81166006)(14444005)(52536014)(3846002)(9686003)(81156014)(6116002)(305945005)(102836004)(8936002)(316002)(54906003)(7696005)(76116006)(25786009)(99286004)(7736002)(26005)(64756008)(66556008)(66476007)(66446008)(73956011)(66946007)(4326008)(6506007)(76176011)(6246003)(86362001)(71190400001)(71200400001)(186003)(11346002)(476003)(55016002)(446003)(74316002)(6436002)(2906002)(68736007)(5660300002)(6916009)(478600001)(53936002)(66066001)(486006)(14454004)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3182;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: baJqtof2PGF0Z1g8n6NFboZzpNXP4pPOCyScsbfMBYtRGLSCqIRwYeBtecbbuC1Slm4XVastjZqNkP7Qg+Q+V+hwZCn3v4IUCUeHUa1uvQRdue9T/4AiF70Vd8v+JmjsJBMrwPPQ6HVPpIQ63o31gG/oJhGBTwvVJHjdUQeqpvdUf/B/JLYSJqAr3dDesHv96aIsgV9SyvP26DTEORjeoVqpVmTX76SJHzyJ7omm2Mi4SR416ZUf5+emYuJXQsrWFH/kDiZfOLiM+P64PLjlOzvmIxEY/uhiYgRLNLnMiqB/+gVjn9dr6bFhllaujyEH27Wm7UnEVMfsP8yWw4XieJ6P7pZDyZ+s/a+At6T0w5ns/7Q7Q5GbdzzoIPEfi6iaNNk2psTkj+l6tFpzwLtWOaPfxkrIM8sLA/LoXz3Umds=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9396752c-eac7-4330-a94c-08d6e39c18b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 18:41:28.6978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mkalderon@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3182
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-28_08:,,
 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Tuesday, May 28, 2019 7:16 PM
>=20
> ----------------------------------------------------------------------
> On Tue, May 28, 2019 at 02:24:00PM +0300, Michal Kalderon wrote:
>=20
> > +static int qedr_init_user_db_rec(struct ib_udata *udata,
> > +				 struct qedr_dev *dev, struct qedr_userq *q,
> > +				 u64 db_rec_addr, int access, int dmasync) {
> > +	/* Aborting for non doorbell userqueue (SRQ) */
> > +	if (db_rec_addr =3D=3D 0)
> > +		return 0;
> > +
> > +	q->db_rec_addr =3D db_rec_addr;
> > +	q->db_rec_umem =3D ib_umem_get(udata, q->db_rec_addr,
> PAGE_SIZE,
> > +				     access, dmasync);
> > +
> > +	if (IS_ERR(q->db_rec_umem)) {
> > +		DP_ERR(dev,
> > +		       "create user queue: failed db_rec ib_umem_get, error
> was %ld, db_rec_addr was %llx\n",
> > +		       PTR_ERR(q->db_rec_umem), db_rec_addr);
> > +		return PTR_ERR(q->db_rec_umem);
> > +	}
> > +
> > +	q->db_rec_page =3D sg_page(q->db_rec_umem->sg_head.sgl);
> > +	q->db_rec_virt =3D kmap(q->db_rec_page);
>=20
> Is this something new? You are much better to use user-triggered mmap to
> get a shared page than to use long term kmap.
This was the fix for previously using sg_virt which as you stated won't alw=
ays work.=20
Just to make sure I understand, by user-triggered mmap do you mean allocati=
ng the
memory in kernel and passing the physical pointer to user to mmap it ?=20
thanks


>=20
> >  		cq->ibcq.cqe =3D chain_entries;
> > +		cq->q.db_addr =3D (void __iomem *)(uintptr_t)ctx->dpi_addr +
> > +			db_offset;
>=20
> Seems like something has gone wrong here if you have to type __iomem like
> this
The dpi_addr is an io address to the doorbell-bar received from the qed mod=
ule,
the qed/qedr interface passes it as a u64 ( it is casted from u8 __iomem * =
to u64)
so I need to cast it back.=20

>=20
> Jason
