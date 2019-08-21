Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC7F19809D
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 18:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbfHUQsA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 12:48:00 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:51366 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729673AbfHUQr5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 12:47:57 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7LGjD5k024235;
        Wed, 21 Aug 2019 09:47:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=l9U6KhJQaEBL/uxAbw74pG9KIaBUSXDXQ4MJIx0uV90=;
 b=HNvjQhQeugmz+rHQkNBZsEVRYlDTW2WEHu14u84kJLlavRym3diRhWazjSg57iNYcqVv
 hD3+GXDpRl7R/6TDS3j6AOO0m6ut4N3oSwKs7VSZgCfUXoH4nOLgTrsjsyDM+b9H182T
 J8DQ+ToG4sMujqRSaw8SHbj/PmgMk6oPBjEfysG5kfnyQZfm0ZNgDk1ttPfpAc4tmGTQ
 jZ60obdPFCDjw3WYGgIVdcNeFeYd0zm53n5KNQBdHEv3dAZeku17QSGzMJd7ANocy6Ga
 WAfuoY6DZcqvv96gkm5GtT5UzqrUx1iRmB71WvR43o8OUGR3q1MxwyjJA/ImjRLjK774 Bw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2ugu7fk9c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 21 Aug 2019 09:47:53 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 21 Aug
 2019 09:47:52 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.50) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 21 Aug 2019 09:47:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/dUXn2r7xpGpeMOrIgkyJoivnIAdcASuZmD7qwRhPGBOfqFdqKmk7YVmrYZIhcwSQcz5lvlLRKIj87/atSWFk7brlFL1ZzXnVulo2gZ3JDZCTQVQIIKLBQsf+xoarmHTRltvFcZxCCZSm2Wyz+7AOorLVaidIUTmGdG4ACuozDLYPbk6Q5D2Dm8I0YyUOCxJBxkoUo7m+CqPuLZt3jdtLzSimxgVr2a3dmmnHA7L6+0JR7ztk/xNCCQoW7Ye4Gw/EEwefvHHZ6PTm/39gD8I0pAOjzL1Ck+T82b3/Ig0O8Gdbi+8+FBnKAenZPmBAK6fbt1XkGIKhcjekW4+lq0vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9U6KhJQaEBL/uxAbw74pG9KIaBUSXDXQ4MJIx0uV90=;
 b=kr24IhBPqqYMkJrtQuL0GfUk1ToC6XN7uv5vmzXeda1bnd8dWdJWo8sg7mH3yUKkOQYfI3tLzbRzRE1WLWCgVC5i4d+XaeNZmCpMJCA7kriIJO20nQo4cx+0kzoNpvaWQc2/5MskwL1Q9CBYHrDp5W5ZTabuTgtpEOs3TxN/R2iF/mPX6HKNucFYevolxF6Vp41wLJQZ3HFnXsiPWyNZ06zPz4xUoqSUfjXRKyt+2CoY8gYPvV5Vh/34erXYrwiGx1U4jY+jMm4X7fXr342XXlQ8tZxFfFJBJ9MHhJj0ZVHCQoR7iMuTaKkr1AT83Lv93Gt/fSTxDXq8IDtevZigeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9U6KhJQaEBL/uxAbw74pG9KIaBUSXDXQ4MJIx0uV90=;
 b=S1XNcizx5HkScmgpte2do3b08Xh242Ju0WF0oyjOApxiiQK/GMUfQGRleoYNYoPZdhewmxiDYZ4la7X0bbv+4uFLJFKfong3laJ1uVzM7mkThCMzyK0LlTfETLLYxQSqtBoBrRAlV0KNdq4tRK9/AQU+2C32zw6HBXW+wAXz/B8=
Received: from CH2PR18MB3175.namprd18.prod.outlook.com (52.132.244.149) by
 CH2PR18MB3256.namprd18.prod.outlook.com (52.132.245.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Wed, 21 Aug 2019 16:47:47 +0000
Received: from CH2PR18MB3175.namprd18.prod.outlook.com
 ([fe80::810a:1cbb:1b73:72d5]) by CH2PR18MB3175.namprd18.prod.outlook.com
 ([fe80::810a:1cbb:1b73:72d5%7]) with mapi id 15.20.2178.018; Wed, 21 Aug 2019
 16:47:47 +0000
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
Thread-Index: AQHVV1GzaBcLwMoagEypYNTXoU3KUacEBbGAgACDqWCAAUW1MA==
Date:   Wed, 21 Aug 2019 16:47:47 +0000
Message-ID: <CH2PR18MB31752BE286837BFDCEE3B17CA1AA0@CH2PR18MB3175.namprd18.prod.outlook.com>
References: <20190820121847.25871-1-michal.kalderon@marvell.com>
 <20190820121847.25871-3-michal.kalderon@marvell.com>
 <20190820132125.GC29246@ziepe.ca>
 <MN2PR18MB31821E7411D0E44267F4A256A1AB0@MN2PR18MB3182.namprd18.prod.outlook.com>
In-Reply-To: <MN2PR18MB31821E7411D0E44267F4A256A1AB0@MN2PR18MB3182.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.203.130.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41e60e68-5eab-4a67-d2b4-08d726574c42
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CH2PR18MB3256;
x-ms-traffictypediagnostic: CH2PR18MB3256:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR18MB32560491748D9518D96B0A32A1AA0@CH2PR18MB3256.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(189003)(199004)(8936002)(76176011)(2906002)(11346002)(26005)(186003)(486006)(54906003)(99286004)(6506007)(66446008)(66556008)(66476007)(71200400001)(446003)(256004)(4326008)(71190400001)(66946007)(7696005)(33656002)(7736002)(74316002)(25786009)(55016002)(229853002)(107886003)(9686003)(6436002)(81156014)(6916009)(53936002)(305945005)(8676002)(81166006)(14454004)(66066001)(64756008)(6116002)(76116006)(6246003)(478600001)(102836004)(476003)(5660300002)(52536014)(316002)(3846002)(86362001)(130980200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR18MB3256;H:CH2PR18MB3175.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dEvTDbtFgcFkLFX+m/Qf1SVIwjZ2VNy+3kmhmJfCSqr6yZeB6OlBH9r2hTXhkyFd2tF9sQEEis+t3aEFnQ893+foFEnFpybX3+k1IGY/ueek/S9fzPVpYKT+cUFibqJYdchfuvoxuPQkkFdaE+Wpept+SsMQJClyzFSKw8qXzy2/u7e6gV2n8PwUrxes5flhqc83ay1+7mkVmBtBCQu6Z0mJqb2BxVxmBqonuGBps/1WP+aeanXoyNNLqB/o26rMDEMLzlAX316ptfu93eMt9xHIeb4ZsLbqiU2a9om7ocSu71YFPIalmLLkdXkEOAUz1q8tQnBy2/gVNHb+y5M5rNY1dr1dlbi6Vr4AIn5CSJauPTmTKuU3MeTb/kQdXqgovecxlE+6GXudwAzyglur25KEvOZuKFHDA3GoztpibuE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e60e68-5eab-4a67-d2b4-08d726574c42
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 16:47:47.8203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5u/a+ssfkuScBj8mtDBYkH+VDol6tV9U0dUiU2gPsEbagFRGrW8c/1sf9HYq92bRvu7GZdnab/MipdFqsV/Aug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR18MB3256
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-21_05:2019-08-19,2019-08-21 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Michal Kalderon
>=20
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Tuesday, August 20, 2019 4:21 PM
> >
> > ----------------------------------------------------------------------
> > On Tue, Aug 20, 2019 at 03:18:42PM +0300, Michal Kalderon wrote:
> > > Create some common API's for adding entries to a xa_mmap.
> > > Searching for an entry and freeing one.
> > >
> > > +
> > > +/**
> > > + * rdma_user_mmap_entry_insert() - Allocate and insert an entry to
> > > +the
> > mmap_xa.
> > > + *
> > > + * @ucontext: associated user context.
> > > + * @obj: opaque driver object that will be stored in the entry.
> > > + * @address: The address that will be mmapped to the user
> > > + * @length: Length of the address that will be mmapped
> > > + * @mmap_flag: opaque driver flags related to the address (For
> > > + *           example could be used for cachability)
> > > + *
> > > + * This function should be called by drivers that use the
> > > +rdma_user_mmap
> > > + * interface for handling user mmapped addresses. The database is
> > > +handled in
> > > + * the core and helper functions are provided to insert entries
> > > +into the
> > > + * database and extract entries when the user call mmap with the
> > > +given
> > key.
> > > + * The function returns a unique key that should be provided to
> > > +user, the user
> > > + * will use the key to map the given address.
> > > + *
> > > + * Return: unique key or RDMA_USER_MMAP_INVALID if entry was not
> > added.
> > > + */
> > > +u64 rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext, void
> > *obj,
> > > +				u64 address, u64 length, u8 mmap_flag) {
> > > +	XA_STATE(xas, &ucontext->mmap_xa, 0);
> > > +	struct rdma_user_mmap_entry *entry;
> > > +	unsigned long index =3D 0, index_max;
> > > +	u32 xa_first, xa_last, npages;
> > > +	int err, i;
> > > +	void *ent;
> > > +
> > > +	entry =3D kzalloc(sizeof(*entry), GFP_KERNEL);
> > > +	if (!entry)
> > > +		return RDMA_USER_MMAP_INVALID;
> > > +
> > > +	entry->obj =3D obj;
> >
> > It is more a kernel pattern to have the driver allocate a
> > rdma_user_mmap_entry and extend it with its 'priv', then use
> > container_of
> then would we also want the driver to free the memory ?
> Or will it be ok to free it using the kref put callback ?

Jason, I looked into this deeper today, it seems that since the=20
Core is the one handling the reference counting, and eventually
Freeing the object that it makes more sense to keep the allocation
In core and not in the drivers, since the driver won't be able to free
The entry without providing yet an additional callback function to the
Core to be called once the reference count reaches zero.=20

> >
> >
> > > +void rdma_user_mmap_entries_remove_free(struct ib_ucontext
> > *ucontext)
> > > +{
> > > +	struct rdma_user_mmap_entry *entry;
> > > +	unsigned long mmap_page;
> > > +
> > > +	WARN_ON(!xa_empty(&ucontext->mmap_xa));
> > > +	xa_for_each(&ucontext->mmap_xa, mmap_page, entry) {
> > > +		ibdev_dbg(ucontext->device,
> > > +			  "mmap: obj[0x%p] key[%#llx] addr[%#llx] len[%#llx]
> > removed\n",
> > > +			  entry->obj, rdma_user_mmap_get_key(entry),
> > > +			  entry->address, entry->length);
> > > +
> > > +		/* override the refcnt to make sure entry is deleted */
> > > +		kref_init(&entry->ref);
> >
> > Yikes, no. The zap flow has to clean this up so the kref goes naturally=
 to
> zero.
> Ok thanks
This actually turned out to be completely redundant, I'll leave the WARN_ON=
 check only
And remove the function entirely, all entries should be removed prior to th=
is, and if we
Reached here it means the refcnt won't go down to zero anyway and entries w=
on't be=20
Removed. This will only happen with a bug.=20

Thanks,=20
Michal
