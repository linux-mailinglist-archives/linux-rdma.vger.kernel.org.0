Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75EE396B5D
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2019 23:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbfHTVXa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Aug 2019 17:23:30 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:18080 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728283AbfHTVXa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Aug 2019 17:23:30 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7KLJMU3021018;
        Tue, 20 Aug 2019 14:23:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=Ty14H8bz0hKszyXx9l1o1q+RJxbTgz50q82XRlgGrdA=;
 b=GEUAzdNMzo7vE+ipvxBgg9lMhweLu+5GwOzWptxZSO9YD7ovIDMBIkh0REf6XMhk5RnD
 1a7MyNl2fXOGqjUr1z11j+F4MARAaNHO+1XOUXt9e0FEidf6DTL1H2AWRHzMoSTVN+ev
 ilSQZLvBPBD0Q2WVzw6eB5mTzTmW0Szb+RQILVeJ5EY3Ict3F/E2iGX5niFwtlcfkiJ6
 VI2kkkScKQIWY77seTQHgfa2GET8333wPL1Z+JS+s7exbC8nRjOaPLeH0HbR7z5RwjTj
 awcnh0QaDcIARDQDNMPuXWJAvEb4DWzbxSdyF08phiEbGFsgMhKonRwVyPmTd2F1/0rp xw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2ug8d7bqb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 20 Aug 2019 14:23:19 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 20 Aug
 2019 14:23:18 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.53) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 20 Aug 2019 14:23:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzYnA7fVMN3YdOLJ6NIxR9Xz9d91GMQ087LUE18eKLNl3ovpiUPfu3ay6JRVuVcczU+Vv/06NCXJgrb7Gb5ZnfFMK75AhVLyPlyJ3qW80HS/T9Y7Act/a57SG60NzurEjvZdYIvt6AoFE2E0MQS0z8RUpYogw+ih4U/DAMZxYVgj9KSeVQZZ4aGs00rN3GHXea2wMsnUydpX6OZ+nVIMG1SpEpKYzENNyPBM1erFE9I+oM49T0bamPEoaEHlpDh10pT75pqEjxFxZcblS6GXX39rHDpCUIbVd+MsXn1OIJeXO2B0xA1GkhKqIkxtotsXLdVJon/nmesitoMpRogpJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ty14H8bz0hKszyXx9l1o1q+RJxbTgz50q82XRlgGrdA=;
 b=CcSmbQmrSFdrStSSz+pEKQIaXRS0sZLcYqLJyUCHeRu9fGTOk6HgheTgU9s+UW1gtmpDhiuyanGt+sPXdZXG+3d6hy3Posp9KOP2rYvT6/FBXZQUPn1IKew7dQ59WnkCquLTJ95j7VSOOD4gPQIkQyZ5BxkqNA8TaiBNEvnJAomX42YBZXnBNv3i3h8CN1XGFmyvAm9CYLrgnHJ6E2em2snRAdSCdrPTXINLwqkW4um/U3Kpjwq8CA9IlFavyybe7iHT7aHPtCHKgxIbeICelpEBVZJv6uD0UvBoi41+KWoOBl6fUsc/8uwqAKqd6LMFgzIV6EWZFdx2+vPOfnXIBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ty14H8bz0hKszyXx9l1o1q+RJxbTgz50q82XRlgGrdA=;
 b=oRzaMSbDslgwrX46EziQVY3MJnEIvn6naiLxEYjMR/Sy0hKoISyfmyZuxnqzRz0PW00WPSTZqao9M52VZ/EhUlwhqfb89qnrRupsk/1eKUUmDfW83OUyIyUbRQpQDyBy61synlo5y175oLoRXGzW5ynuXAPgX37IHj97PK0twv4=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3357.namprd18.prod.outlook.com (10.255.238.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 20 Aug 2019 21:23:10 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::f001:1b96:3396:1781]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::f001:1b96:3396:1781%5]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 21:23:09 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Ariel Elior <aelior@marvell.com>
Subject: RE: [EXT] Re: [PATCH v7 rdma-next 2/7] RDMA/core: Create mmap
 database and cookie helper functions
Thread-Topic: [EXT] Re: [PATCH v7 rdma-next 2/7] RDMA/core: Create mmap
 database and cookie helper functions
Thread-Index: AQHVV1GzaBcLwMoagEypYNTXoU3KUacEBbGAgACDqWA=
Date:   Tue, 20 Aug 2019 21:23:09 +0000
Message-ID: <MN2PR18MB31821E7411D0E44267F4A256A1AB0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190820121847.25871-1-michal.kalderon@marvell.com>
 <20190820121847.25871-3-michal.kalderon@marvell.com>
 <20190820132125.GC29246@ziepe.ca>
In-Reply-To: <20190820132125.GC29246@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [79.178.37.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d51c56c-8bdc-46f0-1322-08d725b499c1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3357;
x-ms-traffictypediagnostic: MN2PR18MB3357:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3357ACE4F5EA3CB58964EE58A1AB0@MN2PR18MB3357.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(199004)(189003)(66066001)(52536014)(229853002)(33656002)(6916009)(102836004)(3846002)(6116002)(5660300002)(2906002)(316002)(30864003)(305945005)(53936002)(7736002)(6246003)(99286004)(74316002)(6506007)(54906003)(476003)(486006)(11346002)(446003)(14444005)(86362001)(186003)(26005)(76176011)(7696005)(71190400001)(8936002)(14454004)(478600001)(71200400001)(81166006)(6436002)(66946007)(64756008)(66446008)(66556008)(55016002)(53946003)(9686003)(4326008)(256004)(107886003)(81156014)(8676002)(25786009)(66476007)(76116006)(130980200001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3357;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PmE5eDXqoTyKBvAgEB3ut8D2w5JCeX7BuLnLeTv8RZmJwIirfBXaNmcFP+h5NyWEWDMoxEji2B7Arg1W7hA0pgQP6hN3P67PzOnqwY9ucRbzN/ep80t8eewfe4Zve7zaQaegtAulis0N4dGZx56KfUj3exA++AKegRY9jnAU1o0YJlKYNtThElKM9aWrGlQ5J9fMSwxbnsnXxLCuj5ozQG/sQmQBLeMc8lx4tzP877AstCW2mf3Nzy+TIzryUcyOmnAfxDFTy8cajlkEuOyCY3Ow1eEv/OBOVp0Cdzl27f0mImk2CZNfLObBeC83MrVVtBa8NqQzYqnrjiWf0OdIHeZJ3v8HTYov3HDoVOPlG0yAPKB/Xqz7J2wX2BnS4xj6kwFhwkV0xRuT+iGjqjpZrpuN2MNs+crkDFf3MnuKHzk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d51c56c-8bdc-46f0-1322-08d725b499c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 21:23:09.8204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f34d2LuD1retFGgF/ZKHCmB/ZQZJIxj+485zQekhuy7sykP+sH97sDladwGTiEBd6WakmlLnOPrT+Fb99/eTjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3357
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-20_10:2019-08-19,2019-08-20 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Tuesday, August 20, 2019 4:21 PM
>=20
> ----------------------------------------------------------------------
> On Tue, Aug 20, 2019 at 03:18:42PM +0300, Michal Kalderon wrote:
> > Create some common API's for adding entries to a xa_mmap.
> > Searching for an entry and freeing one.
> >
> > Most of the code was copied from the efa driver almost as is, just
> > renamed function to be generic and not efa specific.
> > In addition to original code, the xa_mmap entries are now linked to a
> > umap_priv object and reference counted according to umap operations.
> > The fact that this code moved to core enabled managing it differently,
> > so that now entries can be removed and deleted when driver+user are
> > done with them. This enabled changing the insert algorithm in
> > comparison to what was done in efa.
> >
> > Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
> > Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
> >  drivers/infiniband/core/core_priv.h      |  12 +-
> >  drivers/infiniband/core/device.c         |   1 +
> >  drivers/infiniband/core/ib_core_uverbs.c | 343
> +++++++++++++++++++++++++++++--
> >  drivers/infiniband/core/rdma_core.c      |   1 +
> >  drivers/infiniband/core/uverbs_cmd.c     |   1 +
> >  drivers/infiniband/core/uverbs_main.c    |  18 +-
> >  include/rdma/ib_verbs.h                  |  41 +++-
> >  7 files changed, 381 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/core_priv.h
> > b/drivers/infiniband/core/core_priv.h
> > index 6850e973401c..4951ecfbf133 100644
> > +++ b/drivers/infiniband/core/core_priv.h
> > @@ -388,9 +388,17 @@ void rdma_nl_net_exit(struct rdma_dev_net
> *rnet);
> > struct rdma_umap_priv {
> >  	struct vm_area_struct *vma;
> >  	struct list_head list;
> > +	struct rdma_user_mmap_entry *entry;
> >  };
> >
> > -void rdma_umap_priv_init(struct rdma_umap_priv *priv,
> > -			 struct vm_area_struct *vma);
> > +int rdma_umap_priv_init(struct vm_area_struct *vma,
> > +			struct rdma_user_mmap_entry *entry);
> > +
> > +void rdma_umap_priv_delete(struct ib_uverbs_file *ufile,
> > +			   struct rdma_umap_priv *priv);
> > +
> > +void rdma_user_mmap_entries_remove_free(struct ib_ucontext
> > +*ucontext); void rdma_user_mmap_entry_put(struct ib_ucontext
> *ucontext,
> > +			      struct rdma_user_mmap_entry *entry);
> >
> >  #endif /* _CORE_PRIV_H */
> > diff --git a/drivers/infiniband/core/device.c
> > b/drivers/infiniband/core/device.c
> > index 8892862fb759..229977237d1a 100644
> > +++ b/drivers/infiniband/core/device.c
> > @@ -2594,6 +2594,7 @@ void ib_set_device_ops(struct ib_device *dev,
> const struct ib_device_ops *ops)
> >  	SET_DEVICE_OP(dev_ops, map_mr_sg_pi);
> >  	SET_DEVICE_OP(dev_ops, map_phys_fmr);
> >  	SET_DEVICE_OP(dev_ops, mmap);
> > +	SET_DEVICE_OP(dev_ops, mmap_free);
> >  	SET_DEVICE_OP(dev_ops, modify_ah);
> >  	SET_DEVICE_OP(dev_ops, modify_cq);
> >  	SET_DEVICE_OP(dev_ops, modify_device); diff --git
> > a/drivers/infiniband/core/ib_core_uverbs.c
> > b/drivers/infiniband/core/ib_core_uverbs.c
> > index cab7dc922cf0..cce20172cd71 100644
> > +++ b/drivers/infiniband/core/ib_core_uverbs.c
> > @@ -36,41 +36,98 @@
> >  #include "uverbs.h"
> >  #include "core_priv.h"
> >
> > -/*
> > - * Each time we map IO memory into user space this keeps track of the
> mapping.
> > - * When the device is hot-unplugged we 'zap' the mmaps in user space
> > to point
> > - * to the zero page and allow the hot unplug to proceed.
> > +/**
> > + * rdma_umap_priv_init() - Initialize the private data of a vma
> > + *
> > + * @vma: The vm area struct that needs private data
> > + * @entry: entry into the mmap_xa that needs to be linked with
> > + *       this vma
> > + *
> > + * Each time we map IO memory into user space this keeps track
> > + * of the mapping. When the device is hot-unplugged we 'zap' the
> > + * mmaps in user space to point to the zero page and allow the
> > + * hot unplug to proceed.
> >   *
> >   * This is necessary for cases like PCI physical hot unplug as the act=
ual BAR
> >   * memory may vanish after this and access to it from userspace could
> MCE.
> >   *
> >   * RDMA drivers supporting disassociation must have their user space
> designed
> >   * to cope in some way with their IO pages going to the zero page.
> > + *
> > + * We extended the umap list usage to track all memory that was
> > + mapped by
> > + * user space and not only the IO memory. This will occur for drivers
> > + that use
> > + * the mmap_xa database and helper functions
> > + *
> > + * Return 0 on success or -ENOMEM if out of memory
> >   */
> > -void rdma_umap_priv_init(struct rdma_umap_priv *priv,
> > -			 struct vm_area_struct *vma)
> > +int rdma_umap_priv_init(struct vm_area_struct *vma,
> > +			struct rdma_user_mmap_entry *entry)
> >  {
> >  	struct ib_uverbs_file *ufile =3D vma->vm_file->private_data;
> > +	struct rdma_umap_priv *priv;
> > +
> > +	/* If the xa_mmap is used, private data will already be initialized.
> > +	 * this is required for the cases that rdma_user_mmap_io is called
> > +	 * from drivers that don't use the xa_mmap database yet
> > +	 */
> > +	if (vma->vm_private_data)
> > +		return 0;
>=20
> ?? Still have to track the ufile->umaps though
If the driver uses the mmap_xa this function will be called in an earlier s=
tage
And umaps will be updated, the vm_private_data will be initialized in this =
case
once the driver calls rdma_user_mmap_io and therefore there is no action
that needs to be taken.=20


>=20
> > +/**
> > + * rdma_user_mmap_entry_put() - drop reference to the mmap entry
> > + *
> > + * @ucontext: associated user context.
> > + * @entry: An entry in the mmap_xa.
> > + *
> > + * This function is called when the mapping is closed or when
> > + * the driver is done with the entry for some other reason.
> > + * Should be called after rdma_user_mmap_entry_get was called
> > + * and entry is no longer needed. This function will erase the
> > + * entry and free it if it's refcnt reaches zero.
> > + */
> > +void rdma_user_mmap_entry_put(struct ib_ucontext *ucontext,
> > +			      struct rdma_user_mmap_entry *entry) {
> > +	WARN_ON(!kref_read(&entry->ref));
>=20
> kref_put does this internally when refcount debugging is enabled
Ok, will remove, thanks.
>=20
> > +	kref_put(&entry->ref, rdma_user_mmap_entry_free); }
> > +EXPORT_SYMBOL(rdma_user_mmap_entry_put);
> > +
> > +/**
> > + * rdma_user_mmap_entry_remove() - Remove a key's entry from the
> > +mmap_xa
> > + *
> > + * @ucontext: associated user context.
> > + * @key: The key to be deleted
> > + *
> > + * This function will find if there is an entry matching the key and
> > +if so
> > + * decrease it's refcnt, which will in turn delete the entry if its
> > +refcount
> > + * reaches zero.
> > + */
> > +void rdma_user_mmap_entry_remove(struct ib_ucontext *ucontext,
> u64
> > +key) {
> > +	struct rdma_user_mmap_entry *entry;
> > +	u32 mmap_page;
> > +
> > +	if (key =3D=3D RDMA_USER_MMAP_INVALID)
> > +		return;
> > +
> > +	mmap_page =3D key >> PAGE_SHIFT;
> > +	if (mmap_page > U32_MAX)
> > +		return;
> > +
> > +	entry =3D xa_load(&ucontext->mmap_xa, mmap_page);
> > +	if (!entry)
> > +		return;
> > +
> > +	rdma_user_mmap_entry_put(ucontext, entry); }
> > +EXPORT_SYMBOL(rdma_user_mmap_entry_remove);
> > +
> > +/**
> > + * rdma_user_mmap_entry_insert() - Allocate and insert an entry to the
> mmap_xa.
> > + *
> > + * @ucontext: associated user context.
> > + * @obj: opaque driver object that will be stored in the entry.
> > + * @address: The address that will be mmapped to the user
> > + * @length: Length of the address that will be mmapped
> > + * @mmap_flag: opaque driver flags related to the address (For
> > + *           example could be used for cachability)
> > + *
> > + * This function should be called by drivers that use the
> > +rdma_user_mmap
> > + * interface for handling user mmapped addresses. The database is
> > +handled in
> > + * the core and helper functions are provided to insert entries into
> > +the
> > + * database and extract entries when the user call mmap with the given
> key.
> > + * The function returns a unique key that should be provided to user,
> > +the user
> > + * will use the key to map the given address.
> > + *
> > + * Return: unique key or RDMA_USER_MMAP_INVALID if entry was not
> added.
> > + */
> > +u64 rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext, void
> *obj,
> > +				u64 address, u64 length, u8 mmap_flag) {
> > +	XA_STATE(xas, &ucontext->mmap_xa, 0);
> > +	struct rdma_user_mmap_entry *entry;
> > +	unsigned long index =3D 0, index_max;
> > +	u32 xa_first, xa_last, npages;
> > +	int err, i;
> > +	void *ent;
> > +
> > +	entry =3D kzalloc(sizeof(*entry), GFP_KERNEL);
> > +	if (!entry)
> > +		return RDMA_USER_MMAP_INVALID;
> > +
> > +	entry->obj =3D obj;
>=20
> It is more a kernel pattern to have the driver allocate a
> rdma_user_mmap_entry and extend it with its 'priv', then use container_of
then would we also want the driver to free the memory ?=20
Or will it be ok to free it using the kref put callback ?=20
>=20
>=20
> > +	entry->address =3D address;
> > +	entry->length =3D length;
> > +	kref_init(&entry->ref);
> > +	entry->mmap_flag =3D mmap_flag;
> > +	entry->ucontext =3D ucontext;
> > +
> > +	xa_lock(&ucontext->mmap_xa);
> > +
> > +	/* We want to find an empty range */
> > +	npages =3D (u32)DIV_ROUND_UP(length, PAGE_SIZE);
> > +	do {
> > +		/* First find an empty index */
> > +		xas_find_marked(&xas, U32_MAX, XA_FREE_MARK);
> > +		if (xas.xa_node =3D=3D XAS_RESTART)
> > +			goto err_unlock;
> > +
> > +		xa_first =3D xas.xa_index;
> > +
> > +		/* Is there enough room to have the range? */
> > +		if (check_add_overflow(xa_first, npages, &xa_last))
> > +			goto err_unlock;
> > +
> > +		/* Iterate over all present entries in the range. If a present
> > +		 * entry exists we will finish this with the largest index
> > +		 * occupied in the range which will serve as the start of the
> > +		 * new search
> > +		 */
> > +		index_max =3D xa_last;
> > +		xa_for_each_start(&ucontext->mmap_xa, index, ent,
> xa_first)
>=20
> I think this can just be written as xas_next_entry() ?
>=20
> And if it returns something we know the range xa_first -> xas.xa_index is=
 not
> occupied, then check if it has the right size? Otherwise the range xa_fir=
st ->
> U32_MAX
Seems cleaner thanks, will take a look.=20
>=20
>=20
> > +			if (index < xa_last)
> > +				index_max =3D index;
> > +			else
> > +				break;
> > +		if (index_max =3D=3D xa_last) /* range is free */
> > +			break;
> > +		/* o/w start again from largest index found in range */
> > +		xas_set(&xas, index_max);
> > +	} while (true);
> > +
> > +	for (i =3D xa_first; i < xa_last; i++) {
> > +		err =3D __xa_insert(&ucontext->mmap_xa, i, entry,
> GFP_KERNEL);
>=20
> Hum, keep in mind this is a bit tricky as the __xa_insert will drop the x=
a_lock
> lock to allocate and a parallel thread could jump into the gap
>=20
> This seems undesirable, so we probably need to enclose the whole thing in=
 a
> sleeping mutex. Can probably use the umap_lock
I didn't take this into account, thanks, will take a look.

>=20
> > +void rdma_user_mmap_entries_remove_free(struct ib_ucontext
> *ucontext)
> > +{
> > +	struct rdma_user_mmap_entry *entry;
> > +	unsigned long mmap_page;
> > +
> > +	WARN_ON(!xa_empty(&ucontext->mmap_xa));
> > +	xa_for_each(&ucontext->mmap_xa, mmap_page, entry) {
> > +		ibdev_dbg(ucontext->device,
> > +			  "mmap: obj[0x%p] key[%#llx] addr[%#llx] len[%#llx]
> removed\n",
> > +			  entry->obj, rdma_user_mmap_get_key(entry),
> > +			  entry->address, entry->length);
> > +
> > +		/* override the refcnt to make sure entry is deleted */
> > +		kref_init(&entry->ref);
>=20
> Yikes, no. The zap flow has to clean this up so the kref goes naturally t=
o zero.
Ok thanks
>=20
> > +		rdma_user_mmap_entry_put(ucontext, entry);
> > +	}
> > +}
> > +EXPORT_SYMBOL(rdma_user_mmap_entries_remove_free);
> > diff --git a/drivers/infiniband/core/rdma_core.c
> > b/drivers/infiniband/core/rdma_core.c
> > index ccf4d069c25c..7166741834c8 100644
> > +++ b/drivers/infiniband/core/rdma_core.c
> > @@ -817,6 +817,7 @@ static void ufile_destroy_ucontext(struct
> ib_uverbs_file *ufile,
> >  	rdma_restrack_del(&ucontext->res);
> >
> >  	ib_dev->ops.dealloc_ucontext(ucontext);
> > +	rdma_user_mmap_entries_remove_free(ucontext);
> >  	kfree(ucontext);
> >
> >  	ufile->ucontext =3D NULL;
> > diff --git a/drivers/infiniband/core/uverbs_cmd.c
> > b/drivers/infiniband/core/uverbs_cmd.c
> > index 7ddd0e5bc6b3..4903e6eee854 100644
> > +++ b/drivers/infiniband/core/uverbs_cmd.c
> > @@ -254,6 +254,7 @@ static int ib_uverbs_get_context(struct
> > uverbs_attr_bundle *attrs)
> >
> >  	mutex_init(&ucontext->per_mm_list_lock);
> >  	INIT_LIST_HEAD(&ucontext->per_mm_list);
> > +	xa_init_flags(&ucontext->mmap_xa, XA_FLAGS_ALLOC);
> >
> >  	ret =3D get_unused_fd_flags(O_CLOEXEC);
> >  	if (ret < 0)
> > diff --git a/drivers/infiniband/core/uverbs_main.c
> > b/drivers/infiniband/core/uverbs_main.c
> > index 180a5e0f70e4..80d0d3467d93 100644
> > +++ b/drivers/infiniband/core/uverbs_main.c
> > @@ -802,7 +802,7 @@ static void rdma_umap_open(struct
> vm_area_struct
> > *vma)  {
> >  	struct ib_uverbs_file *ufile =3D vma->vm_file->private_data;
> >  	struct rdma_umap_priv *opriv =3D vma->vm_private_data;
> > -	struct rdma_umap_priv *priv;
> > +	int ret;
> >
> >  	if (!opriv)
> >  		return;
> > @@ -816,10 +816,12 @@ static void rdma_umap_open(struct
> vm_area_struct *vma)
> >  	if (!ufile->ucontext)
> >  		goto out_unlock;
> >
> > -	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
> > -	if (!priv)
> > +	if (opriv->entry)
> > +		kref_get(&opriv->entry->ref);
> > +
> > +	ret =3D rdma_umap_priv_init(vma, opriv->entry);
> > +	if (ret)
> >  		goto out_unlock;
> > -	rdma_umap_priv_init(priv, vma);
> >
> >  	up_read(&ufile->hw_destroy_rwsem);
> >  	return;
> > @@ -844,15 +846,15 @@ static void rdma_umap_close(struct
> vm_area_struct *vma)
> >  	if (!priv)
> >  		return;
> >
> > +	if (priv->entry)
> > +		rdma_user_mmap_entry_put(ufile->ucontext, priv->entry);
> > +
> >  	/*
> >  	 * The vma holds a reference on the struct file that created it, whic=
h
> >  	 * in turn means that the ib_uverbs_file is guaranteed to exist at
> >  	 * this point.
> >  	 */
> > -	mutex_lock(&ufile->umap_lock);
> > -	list_del(&priv->list);
> > -	mutex_unlock(&ufile->umap_lock);
> > -	kfree(priv);
> > +	rdma_umap_priv_delete(ufile, priv);
> >  }
> >
> >  /*
> > diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h index
> > 391499008a22..b66c197a7079 100644
> > +++ b/include/rdma/ib_verbs.h
> > @@ -1479,6 +1479,7 @@ struct ib_ucontext {
> >  	 * Implementation details of the RDMA core, don't use in drivers:
> >  	 */
> >  	struct rdma_restrack_entry res;
> > +	struct xarray mmap_xa;
> >  };
> >
> >  struct ib_uobject {
> > @@ -2259,6 +2260,19 @@ struct iw_cm_conn_param;
> >
> >  #define DECLARE_RDMA_OBJ_SIZE(ib_struct) size_t size_##ib_struct
> >
> > +#define RDMA_USER_MMAP_FLAG_SHIFT 56
> > +#define RDMA_USER_MMAP_PAGE_MASK
> GENMASK(EFA_MMAP_FLAG_SHIFT - 1, 0)
>=20
> Why is something called EFA_MMAP_FLAGS_SHIFT in ib_verbs.h?
I have nothing to say in my defense. Will remove.=20
>=20
> Jason
