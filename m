Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC3CFF0C
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2019 19:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbfD3Rnv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Apr 2019 13:43:51 -0400
Received: from mail-eopbgr00056.outbound.protection.outlook.com ([40.107.0.56]:19424
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725942AbfD3Rnv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Apr 2019 13:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m62DSqA+AUDdp32hpD7MJ2104dSk/7X5amOsCvibtY0=;
 b=W0kKOaaxZe1KGJflXz+Wk6w4SArXRb9aE8T3DBL2ZwwAp8hfRhgPE9GJ1Mo6vvHOw9ePPxb8o4fHWPNqsMW2p1q/66OvxUjrO0ojXD4D4vrqIZ+F6XFmnDTr/wZMd0gO2hWkAvs7vMlXT9WSLtOzz/O40WuP1JLgwD7Ix6A+uJE=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5486.eurprd05.prod.outlook.com (20.177.63.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.16; Tue, 30 Apr 2019 17:43:48 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1835.018; Tue, 30 Apr 2019
 17:43:48 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next] RDMA/umem: Move page_shift from ib_umem to
 ib_odp_umem
Thread-Topic: [PATCH rdma-next] RDMA/umem: Move page_shift from ib_umem to
 ib_odp_umem
Thread-Index: AQHU/mgfjrN8YHVwU0Okm/LE+T+ZC6ZU9pmAgAAFGIA=
Date:   Tue, 30 Apr 2019 17:43:48 +0000
Message-ID: <20190430174343.GB7808@mellanox.com>
References: <20190429084653.31087-1-leon@kernel.org>
 <9DD61F30A802C4429A01CA4200E302A7A5ACC80D@fmsmsx124.amr.corp.intel.com>
In-Reply-To: <9DD61F30A802C4429A01CA4200E302A7A5ACC80D@fmsmsx124.amr.corp.intel.com>
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
x-originating-ip: [173.228.226.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cade318-eace-4d34-8065-08d6cd936658
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5486;
x-ms-traffictypediagnostic: VI1PR05MB5486:
x-microsoft-antispam-prvs: <VI1PR05MB5486F936C034B9D77C717350CF3A0@VI1PR05MB5486.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(136003)(366004)(396003)(189003)(199004)(6116002)(107886003)(52116002)(76176011)(305945005)(99286004)(7736002)(25786009)(3846002)(68736007)(4326008)(8936002)(5660300002)(33656002)(6512007)(316002)(86362001)(66556008)(66476007)(14454004)(2906002)(66446008)(97736004)(73956011)(6246003)(54906003)(66946007)(486006)(6486002)(66066001)(36756003)(6916009)(102836004)(476003)(229853002)(71190400001)(71200400001)(256004)(11346002)(64756008)(446003)(2616005)(26005)(1076003)(186003)(81156014)(6436002)(386003)(14444005)(81166006)(6506007)(8676002)(53936002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5486;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 60Otu7zH97W+IhQYDKtJAz0L7opBOn6a0N+sU0NpNsiqVKTM2aiZx4zc/7ZoJsedC+YqteEjGd+v30/DcO1LRaeJv+hBv6AtkNSY4frCi7w7ZK9lcDJ60mfujEahxYDtTs7AUC0S2FV+emSFTvU7+R21NY86+FpRYaJyn+tDNHhOZozxXrkAxACZVdyGaKUFPvn0MB8CTNrUAF/xQHvpYCGKis4ZOv8f3ZWieYbEcdfAfzkAnUAiiOtGTwlq/WsUikSS/+bQ6NUDYQ8ZFB1ODdErVW54yMP4o5vbTR2tYO7dqglyfUj8ESj1qIFhahvHGLXtYMbNshpkCG+edZaQvWjvH033Q9OXaRvW3mOpcrlR03MHzApUM787i9WIV5DxmuqWbbXGEf4uP5nPxHV21kNCytqjT7AiFhNy6xGceXw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AADACB4E88279B4DA303F99C0602DA88@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cade318-eace-4d34-8065-08d6cd936658
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 17:43:48.2928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5486
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 30, 2019 at 05:25:29PM +0000, Saleem, Shiraz wrote:
> >@@ -409,13 +405,13 @@ int ib_umem_odp_get(struct ib_umem_odp
> >*umem_odp, int access)
> > 		struct hstate *h;
> >
> > 		down_read(&mm->mmap_sem);
> >-		vma =3D find_vma(mm, ib_umem_start(umem));
> >+		vma =3D find_vma(mm, ib_umem_start(umem_odp));
> > 		if (!vma || !is_vm_hugetlb_page(vma)) {
> > 			up_read(&mm->mmap_sem);
> > 			return -EINVAL;
> > 		}
> > 		h =3D hstate_vma(vma);
> >-		umem->page_shift =3D huge_page_shift(h);
> >+		umem_odp->page_shift =3D huge_page_shift(h);
> > 		up_read(&mm->mmap_sem);
> > 		umem->hugetlb =3D 1;
>=20
> Is scanning VMA to compute huge page shift a good idea? Why does ODP MRs =
need to do this?
> Shouldn't we be looking at addresses after DMA translation to upgrade pag=
e shift? And isn't
> this already in place with mlx5_ib_cont_pages()?

It is unclear to me if ODP is really working as best it can here or
not, it may not really support huge contiguous regions as well as
could be expected :\

> >@@ -595,15 +588,15 @@ int ib_umem_odp_map_dma_pages(struct
> >ib_umem_odp *umem_odp, u64 user_virt,
> > 	if (access_mask =3D=3D 0)
> > 		return -EINVAL;
> >
> >-	if (user_virt < ib_umem_start(umem) ||
> >-	    user_virt + bcnt > ib_umem_end(umem))
> >+	if (user_virt < ib_umem_start(umem_odp) ||
> >+	    user_virt + bcnt > ib_umem_end(umem_odp))
> > 		return -EFAULT;
> >
> > 	local_page_list =3D (struct page **)__get_free_page(GFP_KERNEL);
> > 	if (!local_page_list)
> > 		return -ENOMEM;
> >
> >-	page_shift =3D umem->page_shift;
> >+	page_shift =3D umem_odp->page_shift;
>=20
> page_shift should be unsigned int?

I think many of the types are wrong in the ODP code.. Certainly
shouldn't be int


> >diff --git a/drivers/infiniband/hw/mlx5/mem.c b/drivers/infiniband/hw/ml=
x5/mem.c
> >index 9f90be296ee0..1619fdb6526b 100644
> >+++ b/drivers/infiniband/hw/mlx5/mem.c
> >@@ -55,9 +55,10 @@ void mlx5_ib_cont_pages(struct ib_umem *umem, u64
> >addr,
> > 	int i =3D 0;
> > 	struct scatterlist *sg;
> > 	int entry;
> >-	unsigned long page_shift =3D umem->page_shift;
> >
> > 	if (umem->is_odp) {
> >+		unsigned long page_shift =3D to_ib_umem_odp(umem)-
> >>page_shift;
> =20
> unsigned int?

Sure

> >+static inline size_t ib_umem_odp_num_pages(struct ib_umem_odp
> >+*umem_odp) {
> >+	return (ib_umem_end(umem_odp) - ib_umem_start(umem_odp)) >>
> >+PAGE_SHIFT; }
> >+
> > /*
> >  * The lower 2 bits of the DMA address signal the R/W permissions for
> >  * the entry. To upgrade the permissions, provide the appropriate
>=20
> Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>

Thanks!
Jason
