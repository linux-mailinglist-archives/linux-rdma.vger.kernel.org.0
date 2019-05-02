Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54AC61213F
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2019 19:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfEBRrd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 May 2019 13:47:33 -0400
Received: from mail-eopbgr00041.outbound.protection.outlook.com ([40.107.0.41]:6469
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726145AbfEBRrd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 May 2019 13:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=be0YYBmFZMG0JqmJ/JIeXvJtxcJ6TTBtJoG0nkbaBOA=;
 b=QHJR9L4/kpM9l1B+kXMa9C7IUY2mbUDoKlxli+pxWQWoAkhC8VPpoBIRiof9UqHvRgSCC5dHtKe86P66O2X9U50CmjNSjnzdBhWRbfiG7wfp0rTGJBltfgMzO9iGCjITCi72bIBD7E3M3Q1ZxqEsJo8Cjs6eIaBNBbjjbhYKGNI=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4270.eurprd05.prod.outlook.com (52.133.12.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.16; Thu, 2 May 2019 17:47:26 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1856.008; Thu, 2 May 2019
 17:47:26 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Gal Pressman <galpress@amazon.com>,
        Doug Ledford <dledford@redhat.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leah Shalev <shalevl@amazon.com>,
        Dave Goodell <goodell@amazon.com>,
        Brian Barrett <bbarrett@amazon.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Sean Hefty <sean.hefty@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Steve Wise <larrystevenwise@gmail.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: [PATCH for-next v6 10/12] RDMA/efa: Add EFA verbs implementation
Thread-Topic: [PATCH for-next v6 10/12] RDMA/efa: Add EFA verbs implementation
Thread-Index: AQHVADyQt6YhcNgq2U2bxKGl+U/wYaZXgZ4AgAAE1wCAAJdCAA==
Date:   Thu, 2 May 2019 17:47:26 +0000
Message-ID: <20190502174722.GD27871@mellanox.com>
References: <1556707704-11192-1-git-send-email-galpress@amazon.com>
 <1556707704-11192-11-git-send-email-galpress@amazon.com>
 <20190501164020.GA18128@mellanox.com>
 <75f5ded6-ba85-bd67-1a2f-92525f7a6e28@amazon.com>
 <20190502084600.GQ7676@mtr-leonro.mtl.com>
In-Reply-To: <20190502084600.GQ7676@mtr-leonro.mtl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR16CA0030.namprd16.prod.outlook.com
 (2603:10b6:208:134::43) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [173.228.226.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a08e811e-082f-4203-6e75-08d6cf263d3b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4270;
x-ms-traffictypediagnostic: VI1PR05MB4270:
x-microsoft-antispam-prvs: <VI1PR05MB427091002D969833F0032CDFCF340@VI1PR05MB4270.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:556;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(2616005)(476003)(478600001)(446003)(7736002)(52116002)(2906002)(81166006)(54906003)(6436002)(102836004)(14454004)(53936002)(6916009)(6246003)(305945005)(486006)(6486002)(66946007)(6512007)(316002)(66556008)(4326008)(25786009)(68736007)(3846002)(186003)(73956011)(66476007)(229853002)(256004)(11346002)(66446008)(6116002)(64756008)(7416002)(76176011)(71200400001)(1076003)(81156014)(386003)(6506007)(66066001)(8676002)(5660300002)(53546011)(26005)(71190400001)(36756003)(8936002)(86362001)(99286004)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4270;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: H0pxPe6hj00v+iGp6VyIBGj8NSd1z4sjuNa733LWhZhHaIfZOhrDDnn38WC2ogzOWmdSgHg5GBclRddWbXmt6yyfEY5Q3QyrfIbGVJrpSSqj5C1+rjeAVCo3V4xU5QU7rmhN26zD3RqSK54H9p+RBs+RAUFfIKgal//3K5WQKQKs4bwwK1n2RPcSTIizEHYEL7W1Xy8jB528dp3chEnv/4rBw/6UF5ZRMfuTCo8bP4+cgq5JbfrEObrSUITv0HQuMnbjELUFXaIokMf+14VFv11A1gUJUNdIZK233MhbA22GP+9gTD4/tqrK3xhhJ/yA0Jva3gTkYxbJBNPRcbjf2sHoJ75DoWGJUYLuQpqgzUePQFIl8ERUnShwhTc9D+FwACeK41Z+47m8NPxqZSzI/TEkI4gISceQ0KSp8LtCu6g=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <91FE14B0144E784597087373C06BD951@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a08e811e-082f-4203-6e75-08d6cf263d3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 17:47:26.5528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4270
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 02, 2019 at 11:46:00AM +0300, Leon Romanovsky wrote:
> On Thu, May 02, 2019 at 11:28:40AM +0300, Gal Pressman wrote:
> > On 01-May-19 19:40, Jason Gunthorpe wrote:
> > > On Wed, May 01, 2019 at 01:48:22PM +0300, Gal Pressman wrote:
> > >
> > >> +int efa_mmap(struct ib_ucontext *ibucontext,
> > >> +	     struct vm_area_struct *vma)
> > >> +{
> > >> +	struct efa_ucontext *ucontext =3D to_eucontext(ibucontext);
> > >> +	struct efa_dev *dev =3D to_edev(ibucontext->device);
> > >> +	u64 length =3D vma->vm_end - vma->vm_start;
> > >> +	u64 key =3D vma->vm_pgoff << PAGE_SHIFT;
> > >> +	struct efa_mmap_entry *entry;
> > >> +
> > >> +	ibdev_dbg(&dev->ibdev,
> > >> +		  "start %#lx, end %#lx, length =3D %#llx, key =3D %#llx\n",
> > >> +		  vma->vm_start, vma->vm_end, length, key);
> > >> +
> > >> +	if (length % PAGE_SIZE !=3D 0 || !(vma->vm_flags & VM_SHARED)) {
> > >> +		ibdev_dbg(&dev->ibdev,
> > >> +			  "length[%#llx] is not page size aligned[%#lx] or VM_SHARED is =
not set [%#lx]\n",
> > >> +			  length, PAGE_SIZE, vma->vm_flags);
> > >> +		return -EINVAL;
> > >> +	}
> > >> +
> > >> +	if (vma->vm_flags & VM_EXEC) {
> > >> +		ibdev_dbg(&dev->ibdev, "Mapping executable pages is not permitted=
\n");
> > >> +		return -EPERM;
> > >> +	}
> > >> +	vma->vm_flags &=3D ~VM_MAYEXEC;
> > >
> > > Also we dropped the MAYEXEC stuff
> >
> > Latest commit that had any MAYEXEC changes is 4eb6ab13b991 ("RDMA: Remo=
ve
> > rdma_user_mmap_page"), where MAYEXEC is added not removed.
> > Am I missing a followup patch?
>=20
> I'm not aware of any.

It was a mistake it wasn't removed from that commit too.

Jason
