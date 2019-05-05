Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0AE13F6E
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2019 14:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbfEEMhc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 May 2019 08:37:32 -0400
Received: from mail-eopbgr50079.outbound.protection.outlook.com ([40.107.5.79]:47364
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727547AbfEEMhc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 5 May 2019 08:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAURMSJ3g3p9gxLKrZB32hgCa9gGzmRfylMkMBHtc2Y=;
 b=r+SVTj4Glq1YCvPgALNE5+iJnQRIp4bOBPnmCNl40k7UexkWVXwaNIY6MUP9YmS34iPZPCCZCOsPT2AGteZ5HNLgZeV5Txhq3iBYJ/oJukQwunSPpM2pPjjIv/71u7DMi1ugIgASpJD1oEdrodE8//NORcvlzZYI7XC3X8j0rLc=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6301.eurprd05.prod.outlook.com (20.179.24.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Sun, 5 May 2019 12:37:26 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1856.012; Sun, 5 May 2019
 12:37:26 +0000
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
Thread-Index: AQHVADyQt6YhcNgq2U2bxKGl+U/wYaZXgZ4AgAAE1wCAAJdCAIABCDIAgAAvBACAAtUjAIAAVAeA
Date:   Sun, 5 May 2019 12:37:26 +0000
Message-ID: <20190505123721.GC30659@mellanox.com>
References: <1556707704-11192-1-git-send-email-galpress@amazon.com>
 <1556707704-11192-11-git-send-email-galpress@amazon.com>
 <20190501164020.GA18128@mellanox.com>
 <75f5ded6-ba85-bd67-1a2f-92525f7a6e28@amazon.com>
 <20190502084600.GQ7676@mtr-leonro.mtl.com>
 <20190502174722.GD27871@mellanox.com>
 <f77f2b44-27d7-f8e2-311e-57b5a89d3ed2@amazon.com>
 <20190503122114.GD13315@mellanox.com>
 <b803ae84-669f-62e5-f230-d671becdac85@amazon.com>
In-Reply-To: <b803ae84-669f-62e5-f230-d671becdac85@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::46) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3dd6e131-bd20-4af5-827a-08d6d1566d98
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6301;
x-ms-traffictypediagnostic: VI1PR05MB6301:
x-microsoft-antispam-prvs: <VI1PR05MB6301F232566A3EA221F032F2CF370@VI1PR05MB6301.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 00286C0CA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(366004)(396003)(189003)(199004)(25786009)(33656002)(36756003)(53936002)(6246003)(6512007)(4326008)(71190400001)(71200400001)(1076003)(7736002)(66946007)(73956011)(66446008)(64756008)(66556008)(66476007)(7416002)(305945005)(478600001)(8936002)(8676002)(81166006)(81156014)(76176011)(86362001)(102836004)(53546011)(6506007)(386003)(186003)(11346002)(229853002)(446003)(2616005)(68736007)(6486002)(6916009)(66066001)(256004)(6436002)(26005)(486006)(476003)(3846002)(2906002)(6116002)(316002)(99286004)(14454004)(54906003)(5660300002)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6301;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: G4dlLwUcwu4XpisIOJkbwUOLYGrj8Vg5IpI1GnbEXak/2cE8eLuAGWfEzqoeSpwAKVDKT59MjSX3cf/8T3MX0jASe1JzC882kDf3MHuh0gQsp+fIN88TCRi0PYXzINKQ3Hnx62nqea42ZiAYzRYP+Buuf/v+lFv4OXw/0uqWcJdBfA+pmwU4YxJ2++8oJqk0I0cbI4pB5D/h66g7Fvw7nu6T1zNzsZP0hXF9qKEF0pQup1DKSZXXttztuzAU0wwCCjYlIWM8t9S1NK/XD6r0GCCN6pa0FAIvwOWM2Fs6vWHPCWwXhMfXO4h7EIpVi1gUBBeBIoHJXvk7be4zdEX8P+BhAG5olMO9ntSA4twlrZHayhA8t+7sZ8DbyP8dtmaK6QNlQwlY2WKCDZ+EgIk51TW0uS2WC+TJkzUhytlbx3Q=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <87C03FABFA2D9A499127324A675CDFFB@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd6e131-bd20-4af5-827a-08d6d1566d98
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2019 12:37:26.0251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6301
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 05, 2019 at 10:36:36AM +0300, Gal Pressman wrote:
> On 03-May-19 15:21, Jason Gunthorpe wrote:
> > On Fri, May 03, 2019 at 12:32:58PM +0300, Gal Pressman wrote:
> >> On 02-May-19 20:47, Jason Gunthorpe wrote:
> >>> On Thu, May 02, 2019 at 11:46:00AM +0300, Leon Romanovsky wrote:
> >>>> On Thu, May 02, 2019 at 11:28:40AM +0300, Gal Pressman wrote:
> >>>>> On 01-May-19 19:40, Jason Gunthorpe wrote:
> >>>>>> On Wed, May 01, 2019 at 01:48:22PM +0300, Gal Pressman wrote:
> >>>>>>
> >>>>>>> +int efa_mmap(struct ib_ucontext *ibucontext,
> >>>>>>> +	     struct vm_area_struct *vma)
> >>>>>>> +{
> >>>>>>> +	struct efa_ucontext *ucontext =3D to_eucontext(ibucontext);
> >>>>>>> +	struct efa_dev *dev =3D to_edev(ibucontext->device);
> >>>>>>> +	u64 length =3D vma->vm_end - vma->vm_start;
> >>>>>>> +	u64 key =3D vma->vm_pgoff << PAGE_SHIFT;
> >>>>>>> +	struct efa_mmap_entry *entry;
> >>>>>>> +
> >>>>>>> +	ibdev_dbg(&dev->ibdev,
> >>>>>>> +		  "start %#lx, end %#lx, length =3D %#llx, key =3D %#llx\n",
> >>>>>>> +		  vma->vm_start, vma->vm_end, length, key);
> >>>>>>> +
> >>>>>>> +	if (length % PAGE_SIZE !=3D 0 || !(vma->vm_flags & VM_SHARED)) =
{
> >>>>>>> +		ibdev_dbg(&dev->ibdev,
> >>>>>>> +			  "length[%#llx] is not page size aligned[%#lx] or VM_SHARED =
is not set [%#lx]\n",
> >>>>>>> +			  length, PAGE_SIZE, vma->vm_flags);
> >>>>>>> +		return -EINVAL;
> >>>>>>> +	}
> >>>>>>> +
> >>>>>>> +	if (vma->vm_flags & VM_EXEC) {
> >>>>>>> +		ibdev_dbg(&dev->ibdev, "Mapping executable pages is not permit=
ted\n");
> >>>>>>> +		return -EPERM;
> >>>>>>> +	}
> >>>>>>> +	vma->vm_flags &=3D ~VM_MAYEXEC;
> >>>>>>
> >>>>>> Also we dropped the MAYEXEC stuff
> >>>>>
> >>>>> Latest commit that had any MAYEXEC changes is 4eb6ab13b991 ("RDMA: =
Remove
> >>>>> rdma_user_mmap_page"), where MAYEXEC is added not removed.
> >>>>> Am I missing a followup patch?
> >>>>
> >>>> I'm not aware of any.
> >>>
> >>> It was a mistake it wasn't removed from that commit too.
> >>
> >> Can you explain please?
> >=20
> > We dropped all the MAYEXEC stuff and that case got missed - it should
> > have been dropped too
>=20
> Why is MAYEXEC not needed?

There was a big thread about it.. It currently breaks userspace that
uses GNU_STACK=3DRWX

Jason
