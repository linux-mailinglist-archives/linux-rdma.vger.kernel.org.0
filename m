Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E65E72CF49
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 21:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfE1TPK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 May 2019 15:15:10 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:45884 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726619AbfE1TPK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 May 2019 15:15:10 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4SJAsnk017005;
        Tue, 28 May 2019 12:14:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=G1/i14YcZCbVcLIhFlfEsw4jwrxhrvqWp9n44X9zg1I=;
 b=TjJTe5EFLvOKMiB6+QMMex1j26LqXKWgItHkGlJFORC7w10lSo1ssiXPyxnif42zZZax
 0Oi/f04WYVCEzbmnWT4yA2U+rMIbvd57+mGssJHqP4xG5mYwWeGve3LM84PzwN+PmSwv
 PbApx9Avlg2/dC4KFwouK6L/wAz8wfEmCe2pt0E+1CxRxq5q/v8fwbr+JErbLq7KQaQF
 /3HWLmwJaf2O20uL2FBlfZ9Hf/owzAwjKszEPLRjDitpwVIlT3Usr+qQJuOTgntg45yP
 uFmsstHR52i5R4YL4WdaER3v6V3ff0cbhLnFQHbdl7dAaMJTnZL2g8cNbgHvaFQI5Z8T aw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2ss270jbug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 28 May 2019 12:14:57 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 28 May
 2019 12:14:55 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.50) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 28 May 2019 12:14:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1/i14YcZCbVcLIhFlfEsw4jwrxhrvqWp9n44X9zg1I=;
 b=hYQ517xCnLm+gkeMG0ABorscjDHYT3KESHT373ND8moBpPLPAZ+2FVM2fLGEcGdsb91572K3XQqF7jhTw8op/L7d9OjUAahWzy89CGRESVNUQX4OpGILoN7RRAnpAnhXZl1SGrN3JU6Oe7ELDDJqs7gjux80NLTeEJkCZDn7NFY=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB2863.namprd18.prod.outlook.com (20.179.21.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16; Tue, 28 May 2019 19:14:54 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9880:2b8b:52e5:b413]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9880:2b8b:52e5:b413%3]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 19:14:54 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v2 rdma-next 1/2] RDMA/qedr: Add doorbell
 overflow recovery support
Thread-Topic: [EXT] Re: [PATCH v2 rdma-next 1/2] RDMA/qedr: Add doorbell
 overflow recovery support
Thread-Index: AQHVFUf8y7Hf1AUzJkOck2OdofgQ9KaAttMAgAAjSYCAAAcAgIAAByJQ
Date:   Tue, 28 May 2019 19:14:54 +0000
Message-ID: <MN2PR18MB31822F630FDCC5191EDB8099A11E0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190528112401.14958-1-michal.kalderon@marvell.com>
 <20190528112401.14958-2-michal.kalderon@marvell.com>
 <20190528161624.GB31301@ziepe.ca>
 <MN2PR18MB318249A0D35E51A5B4E30131A11E0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20190528184745.GD31301@ziepe.ca>
In-Reply-To: <20190528184745.GD31301@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [79.181.13.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9eb5f218-cf19-4f8a-65bb-08d6e3a0c42c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2863;
x-ms-traffictypediagnostic: MN2PR18MB2863:
x-microsoft-antispam-prvs: <MN2PR18MB28630C69885CCBBFB8102BDDA11E0@MN2PR18MB2863.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(366004)(39860400002)(396003)(189003)(199004)(51234002)(73956011)(76116006)(6436002)(66946007)(6246003)(55016002)(53936002)(66556008)(66446008)(9686003)(64756008)(7736002)(14444005)(71200400001)(52536014)(33656002)(6116002)(74316002)(5660300002)(3846002)(66066001)(71190400001)(478600001)(305945005)(54906003)(256004)(68736007)(316002)(26005)(476003)(102836004)(8936002)(25786009)(4326008)(66476007)(229853002)(6506007)(7696005)(99286004)(14454004)(486006)(6916009)(81156014)(86362001)(446003)(11346002)(2906002)(8676002)(186003)(81166006)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2863;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bo7KJXstrWMOMY1NV1kt/K9WFlV9ZMegfN4FTwdPuDh51wZ01yYjcLYbOtpok3Y9iVwaUkuYVptj/bIXVUfBdirC2vcGN4NeTwP+4EMrQu/bYW/uoLXTXJdLiwLY1v7hv6NTWAojuBzUCm3KHRDXn3KWBGNkgJc90cKfXOKV/TxbiRoxl+ctxbncFphR8qGxToOY7L2tnIGj+r+/no6eCtMjLo2Fo03S0g0V7Yg243OEEHGGYTFezmCqQw98FMrQXV8MVq3GeZmqLA4jtXVhjrmlokWgI0PMvtrl8iwi9ZVpAeO7Pypsnq7vAS7w0dJInsSrxEHX3+yIC/A6Gm1YbjUh5IFOJKEGBSY6k4hc2fkLt0wpv7mHNol02oqAJ7QHe1HY0Hka9KGdhkPJfvC+wCGj0VCwHZrjW5DOt+e5nhM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb5f218-cf19-4f8a-65bb-08d6e3a0c42c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 19:14:54.3601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mkalderon@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2863
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-28_08:,,
 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Jason Gunthorpe
>=20
> On Tue, May 28, 2019 at 06:41:28PM +0000, Michal Kalderon wrote:
> > > From: Jason Gunthorpe <jgg@ziepe.ca>
> > > Sent: Tuesday, May 28, 2019 7:16 PM
> > >
> > > On Tue, May 28, 2019 at 02:24:00PM +0300, Michal Kalderon wrote:
> > >
> > > > +static int qedr_init_user_db_rec(struct ib_udata *udata,
> > > > +				 struct qedr_dev *dev, struct qedr_userq *q,
> > > > +				 u64 db_rec_addr, int access, int dmasync) {
> > > > +	/* Aborting for non doorbell userqueue (SRQ) */
> > > > +	if (db_rec_addr =3D=3D 0)
> > > > +		return 0;
> > > > +
> > > > +	q->db_rec_addr =3D db_rec_addr;
> > > > +	q->db_rec_umem =3D ib_umem_get(udata, q->db_rec_addr,
> > > PAGE_SIZE,
> > > > +				     access, dmasync);
> > > > +
> > > > +	if (IS_ERR(q->db_rec_umem)) {
> > > > +		DP_ERR(dev,
> > > > +		       "create user queue: failed db_rec ib_umem_get, error
> > > was %ld, db_rec_addr was %llx\n",
> > > > +		       PTR_ERR(q->db_rec_umem), db_rec_addr);
> > > > +		return PTR_ERR(q->db_rec_umem);
> > > > +	}
> > > > +
> > > > +	q->db_rec_page =3D sg_page(q->db_rec_umem->sg_head.sgl);
> > > > +	q->db_rec_virt =3D kmap(q->db_rec_page);
> > >
> > > Is this something new? You are much better to use user-triggered
> > > mmap to get a shared page than to use long term kmap.
> >
> > This was the fix for previously using sg_virt which as you stated won't
> always work.
> > Just to make sure I understand, by user-triggered mmap do you mean
> > allocating the memory in kernel and passing the physical pointer to
> > user to mmap it ?
>=20
> Yes, if the ABI allows for it, this is a better choice for this kind of l=
ong lived
> usage.
>=20
Ok thanks, will take a look at it.=20

> > > >  		cq->ibcq.cqe =3D chain_entries;
> > > > +		cq->q.db_addr =3D (void __iomem *)(uintptr_t)ctx->dpi_addr +
> > > > +			db_offset;
> > >
> > > Seems like something has gone wrong here if you have to type __iomem
> > > like this
> > The dpi_addr is an io address to the doorbell-bar received from the
> > qed module, the qed/qedr interface passes it as a u64 ( it is casted
> > from u8 __iomem * to u64) so I need to cast it back.
>=20
> Don't cast __iommem * to u8. Make a patch to fix it.
>=20
Ok

> Jason
