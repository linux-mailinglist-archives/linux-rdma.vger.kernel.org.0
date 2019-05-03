Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 010A712D73
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2019 14:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfECMVZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 May 2019 08:21:25 -0400
Received: from mail-eopbgr30073.outbound.protection.outlook.com ([40.107.3.73]:64167
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727089AbfECMVY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 3 May 2019 08:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXuYROVQlyfdSE78thNRkTOy7P+vLzFnbu1154YNue8=;
 b=D64pHGF2moEFS7MlmAab3sbaq3b6LxohADdcccSXnNwF6Wjexffb7lXrZQVUVar9Dg35m6fV1TVXEliJKAsXYHSRZ0TgooXMRRhR+0yPrwK1flzzBw9qt/Et9LTcoelIWnUE2yhxaDQODx62AWfi5Y2zM/IWfiXH42L2i97mIVo=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB3327.eurprd05.prod.outlook.com (10.170.238.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Fri, 3 May 2019 12:21:19 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1856.008; Fri, 3 May 2019
 12:21:19 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Leon Romanovsky <leon@kernel.org>,
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
Thread-Index: AQHVADyQt6YhcNgq2U2bxKGl+U/wYaZXgZ4AgAAE1wCAAJdCAIABCDIAgAAvBAA=
Date:   Fri, 3 May 2019 12:21:19 +0000
Message-ID: <20190503122114.GD13315@mellanox.com>
References: <1556707704-11192-1-git-send-email-galpress@amazon.com>
 <1556707704-11192-11-git-send-email-galpress@amazon.com>
 <20190501164020.GA18128@mellanox.com>
 <75f5ded6-ba85-bd67-1a2f-92525f7a6e28@amazon.com>
 <20190502084600.GQ7676@mtr-leonro.mtl.com>
 <20190502174722.GD27871@mellanox.com>
 <f77f2b44-27d7-f8e2-311e-57b5a89d3ed2@amazon.com>
In-Reply-To: <f77f2b44-27d7-f8e2-311e-57b5a89d3ed2@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN7PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:406:bc::43) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [65.23.217.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37d3808e-5707-4da0-52cf-08d6cfc1d8db
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB3327;
x-ms-traffictypediagnostic: VI1PR05MB3327:
x-microsoft-antispam-prvs: <VI1PR05MB33279474379A9D5D5623FA95CF350@VI1PR05MB3327.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0026334A56
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(366004)(346002)(396003)(199004)(189003)(3846002)(76176011)(25786009)(6116002)(6916009)(66066001)(33656002)(99286004)(486006)(64756008)(66446008)(4326008)(102836004)(71190400001)(6246003)(7416002)(5660300002)(6486002)(81156014)(53546011)(6512007)(81166006)(8936002)(8676002)(386003)(6506007)(71200400001)(53936002)(66946007)(305945005)(66556008)(66476007)(186003)(52116002)(73956011)(14454004)(26005)(2616005)(7736002)(476003)(256004)(2906002)(36756003)(1076003)(11346002)(316002)(68736007)(54906003)(86362001)(6436002)(446003)(478600001)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3327;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fQG2LF9au0NztPRYoV3h6ytAL9c4tB0IKUi6rJrc892uC73whdd7yXm4Ywq+j3xHAIFEdsGUP9qMqFP33PFO8oX9xsQvquMI6j0dOSPXv/jntYyLxTsw9KMa7yA87hg0EmiZ+aMDTb+PAt0JmGyGaehJcY3WodMWCcYmZSB04M19qTXOAqZrUreEeQJDuHBFmuhNSmxm3dkXYH4BQIq8+3/TEfRU5jnqXQhErhpiM+AOy8qqQV/4Q+dIxElPI2sXc71ek20IddAdaUgfPoid8SOedsAkoV/jyrsfKl2lcaljzmZRHpeq/Khuw75RYfoKIoL2hXuHKEKTGXgJxFiLb/QU0nsPukl9RKt1xHhCRxUhL2NNe94M1tmcLHXewDrZssJBcl/vKv8pIbc/+auCxTyHTcbfVlV06Lpn5rL2unE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <809077C9B9E9C74C87C3218AABA30548@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d3808e-5707-4da0-52cf-08d6cfc1d8db
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2019 12:21:19.6005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3327
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 03, 2019 at 12:32:58PM +0300, Gal Pressman wrote:
> On 02-May-19 20:47, Jason Gunthorpe wrote:
> > On Thu, May 02, 2019 at 11:46:00AM +0300, Leon Romanovsky wrote:
> >> On Thu, May 02, 2019 at 11:28:40AM +0300, Gal Pressman wrote:
> >>> On 01-May-19 19:40, Jason Gunthorpe wrote:
> >>>> On Wed, May 01, 2019 at 01:48:22PM +0300, Gal Pressman wrote:
> >>>>
> >>>>> +int efa_mmap(struct ib_ucontext *ibucontext,
> >>>>> +	     struct vm_area_struct *vma)
> >>>>> +{
> >>>>> +	struct efa_ucontext *ucontext =3D to_eucontext(ibucontext);
> >>>>> +	struct efa_dev *dev =3D to_edev(ibucontext->device);
> >>>>> +	u64 length =3D vma->vm_end - vma->vm_start;
> >>>>> +	u64 key =3D vma->vm_pgoff << PAGE_SHIFT;
> >>>>> +	struct efa_mmap_entry *entry;
> >>>>> +
> >>>>> +	ibdev_dbg(&dev->ibdev,
> >>>>> +		  "start %#lx, end %#lx, length =3D %#llx, key =3D %#llx\n",
> >>>>> +		  vma->vm_start, vma->vm_end, length, key);
> >>>>> +
> >>>>> +	if (length % PAGE_SIZE !=3D 0 || !(vma->vm_flags & VM_SHARED)) {
> >>>>> +		ibdev_dbg(&dev->ibdev,
> >>>>> +			  "length[%#llx] is not page size aligned[%#lx] or VM_SHARED is=
 not set [%#lx]\n",
> >>>>> +			  length, PAGE_SIZE, vma->vm_flags);
> >>>>> +		return -EINVAL;
> >>>>> +	}
> >>>>> +
> >>>>> +	if (vma->vm_flags & VM_EXEC) {
> >>>>> +		ibdev_dbg(&dev->ibdev, "Mapping executable pages is not permitte=
d\n");
> >>>>> +		return -EPERM;
> >>>>> +	}
> >>>>> +	vma->vm_flags &=3D ~VM_MAYEXEC;
> >>>>
> >>>> Also we dropped the MAYEXEC stuff
> >>>
> >>> Latest commit that had any MAYEXEC changes is 4eb6ab13b991 ("RDMA: Re=
move
> >>> rdma_user_mmap_page"), where MAYEXEC is added not removed.
> >>> Am I missing a followup patch?
> >>
> >> I'm not aware of any.
> >=20
> > It was a mistake it wasn't removed from that commit too.
>=20
> Can you explain please?

We dropped all the MAYEXEC stuff and that case got missed - it should
have been dropped too

Jason
