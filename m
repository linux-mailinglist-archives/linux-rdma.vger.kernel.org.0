Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28EB813F6C
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2019 14:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbfEEMfK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 May 2019 08:35:10 -0400
Received: from mail-eopbgr150053.outbound.protection.outlook.com ([40.107.15.53]:17922
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725811AbfEEMfJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 5 May 2019 08:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpEZ++d/jK08LaaVs5uLMAvN3KFF1Qwh1UgkUYUGwW4=;
 b=QcOn/TpG4KGv9jWjUOt2pfH46n7OAwUVTVfapmI8aSnECPmnmuuf6gA2/oX9zB1gvTPdWHKT7bX5T+dzEnkaVvrPxvULvyi1nDkodx/dNndzXfD6dPRyYR64GtrL1+G6j3NIriU7xOkUOl/AqlTfoQtffZfQFxkgc1UN8AMpyAU=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4848.eurprd05.prod.outlook.com (20.177.50.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Sun, 5 May 2019 12:35:05 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1856.012; Sun, 5 May 2019
 12:35:05 +0000
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
Thread-Index: AQHVARLft6YhcNgq2U2bxKGl+U/wYaZZKheAgAAowYCAAt+4gIAASTIA
Date:   Sun, 5 May 2019 12:35:05 +0000
Message-ID: <20190505123500.GA30659@mellanox.com>
References: <1556707704-11192-1-git-send-email-galpress@amazon.com>
 <1556707704-11192-11-git-send-email-galpress@amazon.com>
 <20190502181425.GA28282@mellanox.com>
 <7de52e1f-7d4a-354f-a0f6-b8f7eb13ce35@amazon.com>
 <20190503121947.GB13315@mellanox.com>
 <ed36cf91-7420-2533-9202-fa1126bd467b@amazon.com>
In-Reply-To: <ed36cf91-7420-2533-9202-fa1126bd467b@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR01CA0091.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::20) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a93db9a-c322-4720-5eea-08d6d15619d1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4848;
x-ms-traffictypediagnostic: VI1PR05MB4848:
x-microsoft-antispam-prvs: <VI1PR05MB48487366204A6F9300D1B685CF370@VI1PR05MB4848.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 00286C0CA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(346002)(366004)(199004)(189003)(54906003)(2616005)(5660300002)(26005)(256004)(25786009)(53936002)(6246003)(6436002)(6916009)(1076003)(6486002)(81156014)(81166006)(8936002)(71190400001)(68736007)(2906002)(229853002)(71200400001)(3846002)(6116002)(7416002)(6512007)(33656002)(8676002)(86362001)(486006)(66066001)(316002)(14454004)(73956011)(305945005)(7736002)(102836004)(99286004)(446003)(478600001)(186003)(11346002)(52116002)(476003)(76176011)(64756008)(66446008)(66556008)(66476007)(66946007)(36756003)(386003)(6506007)(53546011)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4848;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pEFkMzM9YjA2i6hhXlmy12dtMWfog7XUIklbrmpU0z/9MUjpHCPQLpmymd1Nu0D0i9rWP7BCym8GksodF798TRZQJprGEK33m4/By29eUsiVTcOWhkYzB8of3Sb3cdSldZ7qKEKw95X82NanNnxJErxnVC59rVEl+g9FqQS0+Y8ZPxx1+geCeF2m/BHuQdvexBzTJNyGArBjIEBMdoImhgLSvFrhbyIBWSZeXE6B4Fi6DeixP+8Va9BgIqkhpgF6fYNzP0WbHMhCGIheREEpuaFlM33gRdL8U7ZxwzaQ9qDJLfFDWD4bssHCY7Gx97JRMiPccKn9nktGM7DbA9XEPqpR9Y914UNUq33DrVUvpywDEWIrnWh+quWa/2qAy/SuzPHj4Xpfozygi/BhO3W/8CARRgLtB8Vi4FNv7mOrRHA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F5EC62FB5711C64EA7211933F5E07080@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a93db9a-c322-4720-5eea-08d6d15619d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2019 12:35:05.4451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4848
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 05, 2019 at 11:13:01AM +0300, Gal Pressman wrote:
> On 03-May-19 15:19, Jason Gunthorpe wrote:
> > On Fri, May 03, 2019 at 12:53:55PM +0300, Gal Pressman wrote:
> >> On 02-May-19 21:14, Jason Gunthorpe wrote:
> >>> On Wed, May 01, 2019 at 01:48:22PM +0300, Gal Pressman wrote:
> >>>
> >>>> +/* create a page buffer list from a mapped user memory region */
> >>>> +static int pbl_create(struct efa_dev *dev,
> >>>> +		      struct pbl_context *pbl,
> >>>> +		      struct ib_umem *umem,
> >>>> +		      int hp_cnt,
> >>>> +		      u8 hp_shift)
> >>>> +{
> >>>> +	int err;
> >>>> +
> >>>> +	pbl->pbl_buf_size_in_bytes =3D hp_cnt * EFA_CHUNK_PAYLOAD_PTR_SIZE=
;
> >>>> +	pbl->pbl_buf =3D kzalloc(pbl->pbl_buf_size_in_bytes,
> >>>> +			       GFP_KERNEL | __GFP_NOWARN);
> >>>> +	if (pbl->pbl_buf) {
> >>>> +		pbl->physically_continuous =3D 1;
> >>>> +		err =3D umem_to_page_list(dev, umem, pbl->pbl_buf, hp_cnt,
> >>>> +					hp_shift);
> >>>> +		if (err)
> >>>> +			goto err_continuous;
> >>>> +		err =3D pbl_continuous_initialize(dev, pbl);
> >>>> +		if (err)
> >>>> +			goto err_continuous;
> >>>> +	} else {
> >>>> +		pbl->physically_continuous =3D 0;
> >>>> +		pbl->pbl_buf =3D vzalloc(pbl->pbl_buf_size_in_bytes);
> >>>> +		if (!pbl->pbl_buf)
> >>>> +			return -ENOMEM;
> >>>
> >>> This way to fallback seems ugly, I think you should just call kvzallo=
c
> >>> and check for continuity during the umem_to_page_list
> >>
> >> I've considered using kvzalloc, but it doesn't really fit this use cas=
e.
> >=20
> > It does, you just check for continuity when building the pbl instead
> > of assuming it based on how it was created. It isn't hard, and drivers
> > shouldn't abuse APIs like this
>=20
> This is by no means abusing the API..

It is, vzalloc isn't just kzalloc followed by vzalloc and you
shouldn't expec the two to be the same. Most likely the above has bad
behavior if it triggers reclaim.

Jason
