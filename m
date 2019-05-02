Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0C4A12146
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2019 19:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfEBRwS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 May 2019 13:52:18 -0400
Received: from mail-eopbgr40047.outbound.protection.outlook.com ([40.107.4.47]:61183
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725962AbfEBRwS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 May 2019 13:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTke92JOpHCZY31hSqISXIhThpEBXgB7p+cTzP1HI6g=;
 b=K3zdxipsv/fGM5WjnfvwzSjMmevL+nFXh1Ebqpu99cIsjNJdKiYlAGyJPRqHjB72OnD89mdw5tt5+ThhKqOkKdFem+rQ2BdtaOXS0TIklT7OzKNVG0HRlHnbtIQxZVNKjScKOYmsTh4vCdYNByuEhTRbrmXef/PoYuHqYinv/9E=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4878.eurprd05.prod.outlook.com (20.177.51.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.18; Thu, 2 May 2019 17:52:14 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1856.008; Thu, 2 May 2019
 17:52:14 +0000
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
Thread-Index: AQHVADxft6YhcNgq2U2bxKGl+U/wYaZXgZwAgACdcwA=
Date:   Thu, 2 May 2019 17:52:14 +0000
Message-ID: <20190502175210.GE27871@mellanox.com>
References: <1556707704-11192-1-git-send-email-galpress@amazon.com>
 <1556707704-11192-11-git-send-email-galpress@amazon.com>
 <20190501163852.GA18049@mellanox.com>
 <a5428152-3dab-cbf9-cf5f-0df9b8322bd7@amazon.com>
In-Reply-To: <a5428152-3dab-cbf9-cf5f-0df9b8322bd7@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR01CA0018.prod.exchangelabs.com (2603:10b6:208:10c::31)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [173.228.226.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cca8e42e-dbd2-46e9-d4a1-08d6cf26e8d4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4878;
x-ms-traffictypediagnostic: VI1PR05MB4878:
x-microsoft-antispam-prvs: <VI1PR05MB48780504EC154A3C964D3E36CF340@VI1PR05MB4878.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(73956011)(68736007)(3846002)(25786009)(6116002)(64756008)(6246003)(86362001)(14444005)(54906003)(66556008)(6512007)(66946007)(66446008)(33656002)(6486002)(36756003)(7416002)(66476007)(256004)(229853002)(4326008)(53936002)(305945005)(6436002)(8676002)(66066001)(81156014)(478600001)(8936002)(76176011)(52116002)(14454004)(7736002)(102836004)(386003)(1076003)(486006)(71190400001)(476003)(446003)(6506007)(99286004)(81166006)(2616005)(11346002)(186003)(316002)(26005)(71200400001)(5660300002)(6916009)(53546011)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4878;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mgky2abMxMDIuRMbDhbQsq+rRA3Gi8RytgRgjMqTby9c09OOemK83JCN4hrXQ/m6/XBfg8iOMAibPT/c8CsY+gD3JkIggUD4RwD79rliULn6Zk35krOG96jr9/RAUbE4zlytN1ESeXO7QMAoL/od5BgL4mj+Z85qoWpfRuvww9EQEtqg8swWqn4q3AgJDuSnzYKjwy/xiGiH9dAzQbS2pDK4/C/zumceIifWjXubb74u72mG+9d32Lyo31FnVk8qJveFIvCqEvn7QN0GeVeWEsX625xIiMlGfA3edhDQlMCitCNyzTW4UeJLzhpfXDKNoMKuuK/rSn8ZHBww0SD9vGXnE8p39wIN6wBo+Rsd9M0gWsrbZnnqbAtSm+KrsIvvHUYnxj2lybIUTMoTVJ0k/qPeRfgFIiJBlQcU6+zXuJ8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0DE0F16391158B4AB4940CD8C7D37AF7@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cca8e42e-dbd2-46e9-d4a1-08d6cf26e8d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 17:52:14.3984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4878
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 02, 2019 at 11:28:38AM +0300, Gal Pressman wrote:
> On 01-May-19 19:38, Jason Gunthorpe wrote:
> >> +static int __efa_mmap(struct efa_dev *dev,
> >> +		      struct efa_ucontext *ucontext,
> >> +		      struct vm_area_struct *vma,
> >> +		      struct efa_mmap_entry *entry)
> >> +{
> >> +	u8 mmap_flag =3D get_mmap_flag(entry->key);
> >> +	u64 pfn =3D entry->address >> PAGE_SHIFT;
> >> +	u64 address =3D entry->address;
> >> +	u64 length =3D entry->length;
> >> +	unsigned long va;
> >> +	int err;
> >> +
> >> +	ibdev_dbg(&dev->ibdev,
> >> +		  "Mapping address[%#llx], length[%#llx], mmap_flag[%d]\n",
> >> +		  address, length, mmap_flag);
> >> +
> >> +	switch (mmap_flag) {
> >> +	case EFA_MMAP_IO_NC:
> >> +		err =3D rdma_user_mmap_io(&ucontext->ibucontext, vma, pfn, length,
> >> +					pgprot_noncached(vma->vm_page_prot));
> >> +		break;
> >> +	case EFA_MMAP_IO_WC:
> >> +		err =3D rdma_user_mmap_io(&ucontext->ibucontext, vma, pfn, length,
> >> +					pgprot_writecombine(vma->vm_page_prot));
> >> +		break;
> >> +	case EFA_MMAP_DMA_PAGE:
> >> +		for (va =3D vma->vm_start; va < vma->vm_end;
> >> +		     va +=3D PAGE_SIZE, pfn++) {
> >> +			err =3D vm_insert_page(vma, va, pfn_to_page(pfn));
> >> +			if (err)
> >> +				break
> >=20
> > This loop doesn't bound the number of pfns it accesses, so it is a
> > security problem.
> >=20
> > The core code was checking this before
>=20
> Thanks Jason,
> Core code was checking for
> if (vma->vm_end - vma->vm_start !=3D size)
> 	return ERR_PTR(-EINVAL);
>=20
> Our code explicitly sets size as 'vma->vm_end - vma->vm_start'.
> In addition, we validate that the mapping size matches the size of the al=
located
> buffers which are being mapped (and bounded).

I think it is sketchy to write things like this - pfn is range bound
by entry->size, so that is what should be tested against, not some
indirect inference based on the vma

Jason
