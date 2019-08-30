Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10B13A2F6A
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2019 08:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfH3GK1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Aug 2019 02:10:27 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:52244 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726581AbfH3GK1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Aug 2019 02:10:27 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7U6ALk6027002;
        Thu, 29 Aug 2019 23:10:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=X60eThtCE1PUXaqmv2gW7oaclKvDa2CpaddLS+/Ue2w=;
 b=ocJtDf7lvmPK98LBfqXf9jQ8/JOOKCjjYH5isEdinYKZJGvpLoEYxvulgLAE25spuQAq
 WGCuzkSQ7wd0OqGPGWVjIhEDoTcJiVIQTx/fxLNeQ94qw4ZF5M8D3Qsylwq1VaYK1b8t
 eaM14b1Irkcc8kv2qW3oao0E02k3M3X1GJRgaqh0tk4kPl1j7DA+271w6Z6NUZgbdNBI
 pBje0jmyUG4ut0BQ5WRbYA5sVwAZ/hO9TUs2fi7sjaKIQfUwg5qlpRHeYJDkhxctgiL7
 9UPXqr4wi5hQE6RyMz3e8JtDrcSJlxkZY1oiF1wMZlDGMIHvQwxvE9uPBdW4xAFQ2HKc SQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2uk4rkye69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 29 Aug 2019 23:10:21 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 29 Aug
 2019 23:10:19 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.53) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 29 Aug 2019 23:10:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkVaaBUJqX13XCleFsRmr/r+evbtJtSXGeYBa8dRfVpEpxQzvu55YpsDlRAO6raUl1Ep1RxIo9ud0sgDVDaUB93XZPAfNG5Df9/Y+QsZ04yO+10LA9b/SQKGSCCL1N+Iys5EuUKm5YAsmJQX+RkIV+kmCqTl1YuW9hvA7DPPxBQEGUCjIqY9dTmZElbeFJAkz/bvo2sZBHeiRLcYdRXx6EB55XOAneOlt2UHSitewA6McTfz6TZNWakjJYPQ0AxQv7CNYIb1+FPpol0fHnxBVnCIumntjY6ocYrIw0VO8whS9gCVLVIxjnUnZiqocxSYUDSoDcDEfcxtcB2Lome1aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X60eThtCE1PUXaqmv2gW7oaclKvDa2CpaddLS+/Ue2w=;
 b=LNQb9hetcrVWy89k6RdnOQasT+8vMErUFhwkLoBy5FH9IHGyAWBOQZuP5a9eJLO8A9ZI1u8zFInz2T0hBRDknRQpr1V0EV1BLKibXaeRSHFAXgE5N0VAeNgS2mFMYxpiK1CQp6i1HPYy1I5n2HdtdD/VxzVMz6ctrw5I2zDy1pvbm1MohLDA/WnbgvDCJbbpKyJ+bMTuWklh4h0w30vHJvZTOj4KXyQp4L4sGvkIEmmvq9Ya8I7JjQCYUtM9zKME2v05GUMcnmvioagkCu1SHEuePfI1L1ji6P493L2JnVJdbMXdlJBGclpwsUoqbgbDCUmBm0GNklPEwWoIxQqBjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X60eThtCE1PUXaqmv2gW7oaclKvDa2CpaddLS+/Ue2w=;
 b=OnY+0mkJH6VGpJj3kKmO+PO6bJjmZnmUKuvcjzG099iYmaDN16ENAaA97zECU/waQeBJ2r0QEYn2d4lxYfTk/5E/NcqUbCoTCxg/PFp7LdjwR7D+GOOf2axldhdm9HjnxdrEvItrim9hhwOUN1nC0eHQCUpw08I2sFuzBnGvpUU=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB2845.namprd18.prod.outlook.com (20.178.255.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.19; Fri, 30 Aug 2019 06:10:17 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::f001:1b96:3396:1781]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::f001:1b96:3396:1781%5]) with mapi id 15.20.2199.021; Fri, 30 Aug 2019
 06:10:17 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Gal Pressman <galpress@amazon.com>
CC:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Ariel Elior <aelior@marvell.com>
Subject: RE: [EXT] Re: [PATCH v8 rdma-next 2/7] RDMA/core: Create mmap
 database and cookie helper functions
Thread-Topic: [EXT] Re: [PATCH v8 rdma-next 2/7] RDMA/core: Create mmap
 database and cookie helper functions
Thread-Index: AQHVXNu+Ne38Cy3bjkmLPDht9fJMUqcSAhOAgAASMQCAASQIcA==
Date:   Fri, 30 Aug 2019 06:10:17 +0000
Message-ID: <MN2PR18MB318248829C3D43392556DC4EA1BD0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190827132846.9142-1-michal.kalderon@marvell.com>
 <20190827132846.9142-3-michal.kalderon@marvell.com>
 <4d80bab8-d48c-70b3-52ba-494c98e8a349@amazon.com>
 <20190829124052.GA17115@ziepe.ca>
In-Reply-To: <20190829124052.GA17115@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [79.177.63.148]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7cb500d4-ec12-471f-d533-08d72d10baee
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2845;
x-ms-traffictypediagnostic: MN2PR18MB2845:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB2845FE31F8FB8D97DE76ADB6A1BD0@MN2PR18MB2845.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(55674003)(199004)(189003)(7736002)(478600001)(14454004)(66446008)(66556008)(64756008)(76116006)(71190400001)(71200400001)(66946007)(316002)(66476007)(74316002)(8936002)(8676002)(81166006)(305945005)(86362001)(81156014)(7696005)(102836004)(99286004)(6116002)(186003)(26005)(3846002)(5660300002)(6436002)(4326008)(76176011)(110136005)(486006)(54906003)(476003)(446003)(33656002)(6506007)(53546011)(11346002)(2906002)(256004)(14444005)(9686003)(229853002)(66066001)(55016002)(25786009)(107886003)(53936002)(6246003)(52536014)(130980200001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2845;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +qdLo4vpO3FefnLcbvd1t1tuaWOGZHa7tHyxEl4qjDtGrpnMNKbvkQ8L3zJLHL1r6nV9Y5b1wdqO4QcVtfaJPNZPt0wfrAVsdFT36F7XldfQpxDrE1G+uAZtQTo861HMsyzGqfhUQhRRtyuX4Z8geHwkEzGTxRN/9NJ3ALjouiX7bI10TUyK41udhBjUXq+MPACkMotOZkMllF+jLB4aO1M7P/roBXX8C7ngwPYeeg/qsJfs51pgT4fdbh+AbXTPvvSkvcVddNFX+bE5eJgeqNR8vYx8ZmKptXbeiqdXkIR3jLR0UoA7fed1dl7IZWPkdFfna5b+Vaj71fgzeNfCfvTsHgWKB0VOPyWkvzKLzpLObIhX5uWVnyDFqCgE2pQIZPAG02b4JNCBRxHD4LhNqsKai0UXgXO6WV5B//Xmx2w=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb500d4-ec12-471f-d533-08d72d10baee
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 06:10:17.3526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f1vfOKP4zZWv7vdJZ36pAvV3D/kOKgGW95WFEZLixO+A2NjrU7N+BEUGpD+wXHXy2MvWK7oWrhKpLoWSCshn0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2845
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-08-30_02:2019-08-29,2019-08-30 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Thursday, August 29, 2019 3:41 PM
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Thu, Aug 29, 2019 at 02:35:45PM +0300, Gal Pressman wrote:
> > On 27/08/2019 16:28, Michal Kalderon wrote:
> > > +/**
> > > + * rdma_user_mmap_entry_get() - Get an entry from the mmap_xa.
> > > + *
> > > + * @ucontext: associated user context.
> > > + * @key: the key received from rdma_user_mmap_entry_insert which
> > > + *     is provided by user as the address to map.
> > > + * @len: the length the user wants to map.
> > > + * @vma: the vma related to the current mmap call.
> > > + *
> > > + * This function is called when a user tries to mmap a key it
> > > + * initially received from the driver. The key was created by
> > > + * the function rdma_user_mmap_entry_insert. The function should
> > > + * be called only once per mmap. It initializes the vma and
> > > + * increases the entries ref-count. Once the memory is unmapped
> > > + * the ref-count will decrease. When the refcount reaches zero
> > > + * the entry will be deleted.
> > > + *
> > > + * Return an entry if exists or NULL if there is no match.
> > > + */
> > > +struct rdma_user_mmap_entry *
> > > +rdma_user_mmap_entry_get(struct ib_ucontext *ucontext, u64 key,
> u64 len,
> > > +			 struct vm_area_struct *vma)
> > > +{
> > > +	struct rdma_user_mmap_entry *entry;
> > > +	u64 mmap_page;
> > > +
> > > +	mmap_page =3D key >> PAGE_SHIFT;
> > > +	if (mmap_page > U32_MAX)
> > > +		return NULL;
> > > +
> > > +	entry =3D xa_load(&ucontext->mmap_xa, mmap_page);
> > > +	if (!entry)
> > > +		return NULL;
> >
> > I'm probably missing something, what happens if an insertion is done,
> > a get is called and right at this point (before kref_get) the entry is
> > being removed (and freed by the driver)?
>=20
> Yes, things are wrong here.. It should hold xa_lock to protect entry unti=
l the
> kref is obtained and this must use kref_get_unless_zero() as the kref cou=
ld
> be 0 while still in the xarray.
>=20
> > > +	for (i =3D 0; i < entry->npages; i++) {
> > > +		xa_erase(&ucontext->mmap_xa, entry->mmap_page + i);
>=20
> This is better to use __xa_erase and hold the xa_lock outside the loop
Ok, will fix

>=20
> > > +	/* We want the whole allocation to be done without interruption
> > > +	 * from a different thread. The allocation requires finding a
> > > +	 * free range and storing. During the xa_insert the lock could be
> > > +	 * released, we don't want another thread taking the gap.
> > > +	 */
> > > +	mutex_lock(&ufile->umap_lock);
> > > +
> > > +	xa_lock(&ucontext->mmap_xa);
> >
> > Doesn't the mutex replace the xa_lock?
>=20
> No, absolutely not. xarray must hold its internal lock when required. The
> external lock is only about protecting the contents
>=20
> I'm not sure why this needs to hold this mutex, the spinlock looks OK.
>=20
You pointed this out in "v7" xa_insert can release the lock while allocatin=
g memory leading
To a race that another thread could squeeze into the gap in the meantime.=20

> > > +
> > > +	/* We want to find an empty range */
> > > +	npages =3D (u32)DIV_ROUND_UP(length, PAGE_SIZE);
> > > +	entry->npages =3D npages;
> > > +	do {
> > > +		/* First find an empty index */
> > > +		xas_find_marked(&xas, U32_MAX, XA_FREE_MARK);
> > > +		if (xas.xa_node =3D=3D XAS_RESTART)
> > > +			goto err_unlock;
> > > +
> > > +		xa_first =3D xas.xa_index;
> > > +
> > > +		/* Is there enough room to have the range? */
> > > +		if (check_add_overflow(xa_first, npages, &xa_last))
> > > +			goto err_unlock;
> > > +
> > > +		/* Now look for the next present entry. If such doesn't
> > > +		 * exist, we found an empty range and can proceed
> > > +		 */
> > > +		xas_next_entry(&xas, xa_last - 1);
> > > +		if (xas.xa_node =3D=3D XAS_BOUNDS || xas.xa_index >=3D xa_last)
> > > +			break;
> > > +		/* o/w look for the next free entry */
> > > +	} while (true);
>=20
> while(true) not do/while is the usual convention
ok
>=20
> Jason
