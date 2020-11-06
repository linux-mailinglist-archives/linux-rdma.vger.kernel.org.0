Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6632A8BFE
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Nov 2020 02:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732743AbgKFBLn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Nov 2020 20:11:43 -0500
Received: from mga04.intel.com ([192.55.52.120]:63511 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732396AbgKFBLm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Nov 2020 20:11:42 -0500
IronPort-SDR: 95oC3UWeUueS3ehJ81wGvJrToYGbC58hpltWj6TUdkn0z5bjTEEOSOkPbrqV2rB2LN3lHf8Z2f
 Kg6U143ZB4AA==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="166895222"
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="166895222"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 17:11:41 -0800
IronPort-SDR: gFm0HnoF1b4MPH0S75B7n1nsA49RuJj+bwj1ne7WBZlAw1rgAJiMWxmUTaA1Zz2xHCIeR3FhdX
 URCoTHS8006g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="364532222"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 05 Nov 2020 17:11:41 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 5 Nov 2020 17:11:41 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 5 Nov 2020 17:11:41 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 5 Nov 2020 17:11:40 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 5 Nov 2020 17:11:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IG9A0bUZo7QttAbcb2zG4CjVeNBTRpT/1/B8duXH0YYD4i7XOY0KPmjszcVYxCbgEOmZEM0W63QOeLZ3i+3t1CDNhY1ARReDzGt+KhcZfgJ/aqyXsj0gbPNSN6iNDqvsfjku9l6EfJbRTrdDXHBNzYt3ibSsaeiP7SHnNOqORMGuY03h6N4JXhVnKhVACb6iuC4a4txUeGQBO2QFPBB1a18I54r0WAwGSbUIciYEWgby+T4p79Hg3RBkGbGcTAMCfvHtb2ig52tENie6h9jCW+nrfOhsiC0SRkQpPfCccfx0nyAqAoJvMYKgEuywboHrv8FzH/zHbQe+MP8CNzVYQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzzPo+YaeMYLnsjD6NOHSBRQOrQ/0aTbCFaa5MI/o7o=;
 b=fWrpZQgny0jX7/rzMJk6qVZblNxb3tLQbDfx0WbrwuM8dJnyauN6vUBsBB5Zpt/f1cviqRdORhmms8ClVDk8HeyW9ZFcilvcgYR4oaVQSUdz/TwOIc2hhZWUUQMd526iHShMoiEKE4YlVdm/NSDClAqDzvTtazFwVOAQItIz9OnD7hyTDRGpvyXmXir43nErK+4Eic25I5mCtNLKuOf8E20vfUdIL8aHeFB/6Gp/qSxbiP6lZKQvoqk51ku5ZyOLQ/8plFcoIzNKWvZ+8DBWOQVY/gsHsHxjQME7PhIgPc7w18AoHuSSMx+ByDtr694GsXTM5vqDG6/e3/BIcZ6EGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzzPo+YaeMYLnsjD6NOHSBRQOrQ/0aTbCFaa5MI/o7o=;
 b=NWLGeU5ErkgPhSYf7VUW/wu1KdTUHaNLC1VZYHrJ9k10I0JsFBD+t1oNMTKA0IEBwXDWNQpK3W8Ro+3vzzuI7EfBUugmz7mrhTCqPXQ0AqE03Q5WBGt1KnKzcYf9XM+JQxtjVNpyna505uvwA2hdjBKm/ledr4pKvZ/E2F+GnhU=
Received: from MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24)
 by MW3PR11MB4682.namprd11.prod.outlook.com (2603:10b6:303:2e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 6 Nov
 2020 01:11:38 +0000
Received: from MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::8d73:60dd:89aa:99a9]) by MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::8d73:60dd:89aa:99a9%8]) with mapi id 15.20.3499.032; Fri, 6 Nov 2020
 01:11:38 +0000
From:   "Xiong, Jianxin" <jianxin.xiong@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Doug Ledford" <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        "Sumit Semwal" <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>
Subject: RE: [PATCH v8 4/5] RDMA/mlx5: Support dma-buf based userspace memory
 region
Thread-Topic: [PATCH v8 4/5] RDMA/mlx5: Support dma-buf based userspace memory
 region
Thread-Index: AQHWs8PUPSOsvCazDkuCn814worrwKm6PxCAgAAGexA=
Date:   Fri, 6 Nov 2020 01:11:38 +0000
Message-ID: <MW3PR11MB45556A1524ABE605698B9A8EE5ED0@MW3PR11MB4555.namprd11.prod.outlook.com>
References: <1604616489-69267-1-git-send-email-jianxin.xiong@intel.com>
 <1604616489-69267-5-git-send-email-jianxin.xiong@intel.com>
 <20201106002515.GM36674@ziepe.ca>
In-Reply-To: <20201106002515.GM36674@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.53.14.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50bf161e-5f18-4c9d-f206-08d881f0e9b4
x-ms-traffictypediagnostic: MW3PR11MB4682:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB468230787D0D90681D915453E5ED0@MW3PR11MB4682.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 93JNa57BYUr236iFy2r+OAEQkUbCoc3qUbDjX2XX9z5/xzXYa8QJV8wIEr/hqv1mpDWKgG/dyD1nJWi4F9keHAlBXPHJpAX92E1+kqvX4qKATTaYFeanWlLwhG2zGtEkH9U6CDASUbMaWVqAU4dVvjn23f7tQfcPHNhE4mAcpyHKdqU1+TlLXFGRWzK9pcf1gENfjryXPHAVFAMAQ4yX4/hGHSs2VrYQqutKE3wJoLD4U2bwveylBBZ5AcL2H2m10nvEcALBDZQXnPME1CXKd6IuJBTn7aZIiE3RnTex1UpGp6rXPz2hAIDmeDXKN+Cs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4555.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(6916009)(5660300002)(107886003)(2906002)(8676002)(54906003)(86362001)(76116006)(64756008)(8936002)(66446008)(66946007)(316002)(4326008)(55016002)(83380400001)(6506007)(53546011)(71200400001)(66476007)(33656002)(52536014)(186003)(478600001)(26005)(7696005)(66556008)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: GHNpAHDz0PyEDAbeT5CNrzZ86ELy1Z7tWBh7xY2PZ1rx0wTbSLHOKfa2us62R+4JyMJLzdfZsACwSkNtbKXUSWjyBDOhF7Bd9+WSOH8gzbKaYobKBY6uWKGvCKtaW6dtbUemWQHdZImdnLv6DRukBRkSk0acGtU3w4C0VtYgdLBFHrVWCnYd+yu2EkrB0tYV+6G4iJNzCIuLnPqRPPH0CpV4h+Tv1N/pDYMGhUquMDVVQqjLbsELMHQSVlC+c74XsBaX8fi8LoDn/eESRKtVn6jtVghra4ZTV+wgO2bp9G/XuelcT9GuYeOokk2Xuheuy+QOKBtghiOBea6xLL8mlYFsviC1lBrjz4u+5h3H71BlJ/xJrRUBH0lmU4aKaRz7SS7X/zp2RyzDn2wWNAB6hoSFZyxXBvWEF4YdAMYPhFqMjglN1OgqIf5I7AXO7Qu0+BdFHleG+J7OrqKT6vtkz9Y691wUURo8CbITyvLfht+1PgwJKI43pYxzUL5ZJWVA74QWbAzZFamnQdRIgH8WTwIQkyveRqPvyiZYSfCpDlsBvp+6Gi+wR2Lg5TRkH9TeQBKdzWDwsQfq/P8hw6iPrn/acjE3/Mhi3xqeV5vnBlPUURzXuoTr4kK1PEgM6hGTtXlf9f3Xnf2rlsxMB+Ir3g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4555.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50bf161e-5f18-4c9d-f206-08d881f0e9b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2020 01:11:38.4884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ojl0dGbv9EM+1p7iJwuskkySQc6Kzm0YOjJgxqpTbp5GKOKqoM4WolOeXZ1BJDdJzHbt1QbZmqUwtweaR5leqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4682
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Thursday, November 05, 2020 4:25 PM
> To: Xiong, Jianxin <jianxin.xiong@intel.com>
> Cc: linux-rdma@vger.kernel.org; dri-devel@lists.freedesktop.org; Doug Led=
ford <dledford@redhat.com>; Leon Romanovsky
> <leon@kernel.org>; Sumit Semwal <sumit.semwal@linaro.org>; Christian Koen=
ig <christian.koenig@amd.com>; Vetter, Daniel
> <daniel.vetter@intel.com>
> Subject: Re: [PATCH v8 4/5] RDMA/mlx5: Support dma-buf based userspace me=
mory region
>=20
> On Thu, Nov 05, 2020 at 02:48:08PM -0800, Jianxin Xiong wrote:
> > @@ -966,7 +969,10 @@ static struct mlx5_ib_mr *alloc_mr_from_cache(stru=
ct ib_pd *pd,
> >  	struct mlx5_ib_mr *mr;
> >  	unsigned int page_size;
> >
> > -	page_size =3D mlx5_umem_find_best_pgsz(umem, mkc, log_page_size, 0, i=
ova);
> > +	if (umem->is_dmabuf)
> > +		page_size =3D ib_umem_find_best_pgsz(umem, PAGE_SIZE, iova);
>=20
> You said the sgl is not set here, why doesn't this crash? It is certainly=
 wrong to call this function without a SGL.

The sgl is NULL, and nmap is 0. The 'for_each_sg' loop is just skipped and =
won't crash.

>=20
> > +/**
> > + * mlx5_ib_fence_dmabuf_mr - Stop all access to the dmabuf MR
> > + * @mr: to fence
> > + *
> > + * On return no parallel threads will be touching this MR and no DMA
> > +will be
> > + * active.
> > + */
> > +void mlx5_ib_fence_dmabuf_mr(struct mlx5_ib_mr *mr) {
> > +	struct ib_umem_dmabuf *umem_dmabuf =3D to_ib_umem_dmabuf(mr->umem);
> > +
> > +	/* Prevent new page faults and prefetch requests from succeeding */
> > +	xa_erase(&mr->dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key));
> > +
> > +	/* Wait for all running page-fault handlers to finish. */
> > +	synchronize_srcu(&mr->dev->odp_srcu);
> > +
> > +	wait_event(mr->q_deferred_work,
> > +!atomic_read(&mr->num_deferred_work));
> > +
> > +	dma_resv_lock(umem_dmabuf->attach->dmabuf->resv, NULL);
> > +	mlx5_mr_cache_invalidate(mr);
> > +	umem_dmabuf->private =3D NULL;
> > +	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
> > +
> > +	if (!mr->cache_ent) {
> > +		mlx5_core_destroy_mkey(mr->dev->mdev, &mr->mmkey);
> > +		WARN_ON(mr->descs);
> > +	}
> > +}
>=20
> I would expect this to call ib_umem_dmabuf_unmap_pages() ?
>=20
> Who calls it on the dereg path?
>=20
> This looks quite strange to me, it calls ib_umem_dmabuf_unmap_pages() onl=
y from the invalidate callback?
>

It is also called from ib_umem_dmabuf_release().=20
=20
> I feel uneasy how this seems to assume everything works sanely, we can ha=
ve parallel page faults so pagefault_dmabuf_mr() can be called
> multiple times after an invalidation, and it doesn't protect itself again=
st calling ib_umem_dmabuf_map_pages() twice.
>=20
> Perhaps the umem code should keep track of the current map state and exit=
 if there is already a sgl. NULL or not NULL sgl would do and
> seems quite reasonable.
>=20

Ib_umem_dmabuf_map() already checks the sgl and will do nothing if it is al=
ready set.

> > @@ -810,22 +871,31 @@ static int pagefault_mr(struct mlx5_ib_mr *mr, u6=
4 io_virt, size_t bcnt,
> >  			u32 *bytes_mapped, u32 flags)
> >  {
> >  	struct ib_umem_odp *odp =3D to_ib_umem_odp(mr->umem);
> > +	struct ib_umem_dmabuf *umem_dmabuf =3D to_ib_umem_dmabuf(mr->umem);
> >
> >  	lockdep_assert_held(&mr->dev->odp_srcu);
> >  	if (unlikely(io_virt < mr->mmkey.iova))
> >  		return -EFAULT;
> >
> > -	if (!odp->is_implicit_odp) {
> > +	if (is_dmabuf_mr(mr) || !odp->is_implicit_odp) {
> >  		u64 user_va;
> > +		u64 end;
> >
> >  		if (check_add_overflow(io_virt - mr->mmkey.iova,
> > -				       (u64)odp->umem.address, &user_va))
> > +				       (u64)mr->umem->address, &user_va))
> >  			return -EFAULT;
> > -		if (unlikely(user_va >=3D ib_umem_end(odp) ||
> > -			     ib_umem_end(odp) - user_va < bcnt))
> > +		if (is_dmabuf_mr(mr))
> > +			end =3D mr->umem->address + mr->umem->length;
> > +		else
> > +			end =3D ib_umem_end(odp);
> > +		if (unlikely(user_va >=3D end || end - user_va < bcnt))
> >  			return -EFAULT;
> > -		return pagefault_real_mr(mr, odp, user_va, bcnt, bytes_mapped,
> > -					 flags);
> > +		if (is_dmabuf_mr(mr))
> > +			return pagefault_dmabuf_mr(mr, umem_dmabuf, user_va,
> > +						   bcnt, bytes_mapped, flags);
>=20
> But this doesn't care about user_va or bcnt it just triggers the whole th=
ing to be remapped, so why calculate it?

The range check is still needed, in order to catch application errors of us=
ing incorrect address or count in verbs command. Passing the values further=
 in is to allow pagefault_dmabuf_mr to
generate return value and set bytes_mapped in a way consistent with the pag=
e fault handler
chain.
 =20
>=20
> Jason
