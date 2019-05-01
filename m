Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9D410B75
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2019 18:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfEAQkc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 May 2019 12:40:32 -0400
Received: from mail-eopbgr20048.outbound.protection.outlook.com ([40.107.2.48]:5441
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726101AbfEAQkc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 1 May 2019 12:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0uOwLpljt4aXvkOotat6evv/lZxenXu+QOkDQmGUO0=;
 b=idu4ETh20etNOUxtm6aNLta+IqycR/E25gbLcqS7dxrVKUHk3+cuLoWdZiZKaSrkjKpmgvf3y3bWDOmu2odrABLBjf/gGcIMJwUlwH6RndSv1mWDrjp5R7EoIYlPJj7w8Aen58ATp4RCKa3ATuuXXOtdedov6K+/n06ryK7RuFo=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5214.eurprd05.prod.outlook.com (20.178.12.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Wed, 1 May 2019 16:40:24 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1835.018; Wed, 1 May 2019
 16:40:24 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leah Shalev <shalevl@amazon.com>,
        Dave Goodell <goodell@amazon.com>,
        Brian Barrett <bbarrett@amazon.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Sean Hefty <sean.hefty@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Steve Wise <larrystevenwise@gmail.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: [PATCH for-next v6 10/12] RDMA/efa: Add EFA verbs implementation
Thread-Topic: [PATCH for-next v6 10/12] RDMA/efa: Add EFA verbs implementation
Thread-Index: AQHVADyQt6YhcNgq2U2bxKGl+U/wYQ==
Date:   Wed, 1 May 2019 16:40:24 +0000
Message-ID: <20190501164020.GA18128@mellanox.com>
References: <1556707704-11192-1-git-send-email-galpress@amazon.com>
 <1556707704-11192-11-git-send-email-galpress@amazon.com>
In-Reply-To: <1556707704-11192-11-git-send-email-galpress@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR01CA0035.prod.exchangelabs.com (2603:10b6:208:71::48)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [173.228.226.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 981246ae-dd1d-47d3-34fe-08d6ce53b581
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5214;
x-ms-traffictypediagnostic: VI1PR05MB5214:
x-microsoft-antispam-prvs: <VI1PR05MB5214BF92FD04AC733A298EACCF3B0@VI1PR05MB5214.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 00246AB517
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(396003)(376002)(39860400002)(189003)(199004)(305945005)(81166006)(8676002)(7736002)(2616005)(6436002)(14454004)(11346002)(446003)(476003)(81156014)(33656002)(68736007)(52116002)(66476007)(66556008)(73956011)(2906002)(71200400001)(71190400001)(76176011)(1076003)(256004)(64756008)(3846002)(66446008)(66946007)(6116002)(86362001)(26005)(478600001)(486006)(229853002)(99286004)(7416002)(53936002)(54906003)(36756003)(4326008)(4744005)(8936002)(6512007)(6486002)(66066001)(102836004)(6506007)(386003)(6246003)(186003)(5660300002)(25786009)(6916009)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5214;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1/9f2znU5k/iraS2iEZ8TGzPub3IMurYSHP9m/F/BsXWEafdXfDqsi6jAEd+kjmHEIYB4IGE7zvlamUvV4g1d0P0vU2RZ4gi6DDg9qzfLJ18NvN5zDxQ192IamjvFUdkgJTlbpyH7tXTUd34ClNal4ZkA6h8RSnxB3UWPyO+eu3Z0Bkt+qcSwqQvFp4KqouumVK/xRu11FXrS9iHmdDrzv2PTGrnUWEyCwM5/5x6eV5R9N7RsTBi1BCl+Pp3eexj/ZpQah4ohnoWOwQL8wewyq1xiaJHSV1cDGg9s76GyrjSq+z5IGFh8ZVrTyls6+bE2X5KsM1f1HeSJu8m3TjVGNCWJy36wdiIL3lSLdg7n4ZP3yVv7UmbB62dtBHV7bsRccrwK+Twjl4+qypcCrjIu5xdKrHrdEGFMiXMht22IpE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9CAF07EC41C90141B65B93995985F2B1@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 981246ae-dd1d-47d3-34fe-08d6ce53b581
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2019 16:40:24.4856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5214
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 01, 2019 at 01:48:22PM +0300, Gal Pressman wrote:

> +int efa_mmap(struct ib_ucontext *ibucontext,
> +	     struct vm_area_struct *vma)
> +{
> +	struct efa_ucontext *ucontext =3D to_eucontext(ibucontext);
> +	struct efa_dev *dev =3D to_edev(ibucontext->device);
> +	u64 length =3D vma->vm_end - vma->vm_start;
> +	u64 key =3D vma->vm_pgoff << PAGE_SHIFT;
> +	struct efa_mmap_entry *entry;
> +
> +	ibdev_dbg(&dev->ibdev,
> +		  "start %#lx, end %#lx, length =3D %#llx, key =3D %#llx\n",
> +		  vma->vm_start, vma->vm_end, length, key);
> +
> +	if (length % PAGE_SIZE !=3D 0 || !(vma->vm_flags & VM_SHARED)) {
> +		ibdev_dbg(&dev->ibdev,
> +			  "length[%#llx] is not page size aligned[%#lx] or VM_SHARED is not s=
et [%#lx]\n",
> +			  length, PAGE_SIZE, vma->vm_flags);
> +		return -EINVAL;
> +	}
> +
> +	if (vma->vm_flags & VM_EXEC) {
> +		ibdev_dbg(&dev->ibdev, "Mapping executable pages is not permitted\n");
> +		return -EPERM;
> +	}
> +	vma->vm_flags &=3D ~VM_MAYEXEC;

Also we dropped the MAYEXEC stuff

Jason
