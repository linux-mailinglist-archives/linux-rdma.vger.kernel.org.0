Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7ABCEC811
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2019 18:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfKARmi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Nov 2019 13:42:38 -0400
Received: from mail-eopbgr140052.outbound.protection.outlook.com ([40.107.14.52]:49029
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727123AbfKARmi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 1 Nov 2019 13:42:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bchm8DeQlCNYOXY/lj/ITNFi3RY6Y70l0brs3Kgf0Z/cj+5pqKYdzdx8gFxUpMoITPb+uwgELlQx5fH99P3HHv58Ydpu1x31aPK6gOA83rDB+tsQ9kJ9SpOszIszFOS945IWFcMba1fwVUIp/86rUqiAMJQnjHnm2DURV8iqUlY5QdIFhQKDEChKVAQpSyC5cfteDBXaq9ilrULSonXLv/DDTOAeKNrtvtYn3FEZOMTdvE9bsxMPZzU14eIOldheB/VZNddCO05NGoYF2G/5zbx5S/CjOQhm0Lxsq85BIaZJabjxFfSdzrwhCutWF4souHGuJMSs+VfYURlcbsVeAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWZJ+xeas6XhzceIPpCCcy37V5dyZk91GfPxboiHBZQ=;
 b=PNWAr0aEOsXfbuvKGQjuqjggCkMd1+b+Tw0EGDc3x4DvpoZzBti3ycOrU1KeyzxCO9+Ka6zwBLi6TUwF5hmvtwkj534NqxeCcn4e7Qi6tF+CZVaxWiAsTd4myadfrih36/tVIXrNjslhrJyvZDZXR1FVaDChPXC+W0O6Mqx40YlEJKNXYYlftOxGuEvymmhQLJotgeZ6shFZdT1SxRhRIDwNIAN7MCw8gIoWiKl835un6Zt2vHgx1CKBuA724qMkcsMLRdE3OkJDuFPxBAob9Rj+NyvYitKkzMpDG/Y4GtDyg780vAgb/GK0TfYuNC0f+1qMF65dmxgXvVFL6BhsNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWZJ+xeas6XhzceIPpCCcy37V5dyZk91GfPxboiHBZQ=;
 b=IBxSd8QnIBB29Fi945yOI//0OVLntYEAPyc8sdnJ79/SJkYbWuLz6YtSBh1G5ATrClJexcDK5IGRfv3x4aHWbRhmqdk9BehtIgieWxpnK7zt16VYvsIKsLbVHNoS1LJ9BQcZlVkHUEuk3/Fhf73cbi1m6zoQV1goZyexjVKpO50=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5437.eurprd05.prod.outlook.com (20.177.201.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.17; Fri, 1 Nov 2019 17:42:32 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 17:42:32 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     "Yang, Philip" <Philip.Yang@amd.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Juergen Gross <jgross@suse.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Christoph Hellwig <hch@infradead.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Petr Cvek <petrcvekcz@gmail.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH v2 14/15] drm/amdgpu: Use mmu_range_notifier instead of
 hmm_mirror
Thread-Topic: [PATCH v2 14/15] drm/amdgpu: Use mmu_range_notifier instead of
 hmm_mirror
Thread-Index: AQHVjcvOUfhzqykxXkO0v7SQaQq3BKdyANqAgAAA3wCABGiEgIAAB7AAgAANJwCAABzBgA==
Date:   Fri, 1 Nov 2019 17:42:32 +0000
Message-ID: <20191101174221.GO22766@mellanox.com>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-15-jgg@ziepe.ca>
 <a456ebd0-28cf-997b-31ff-72d9077a9b8e@amd.com>
 <20191029192544.GU22766@mellanox.com>
 <30b2f569-bf7a-5166-c98d-4a4a13d1351f@amd.com>
 <20191101151222.GN22766@mellanox.com>
 <8280fb65-a897-3d71-79f9-9f80d9e474e9@amd.com>
In-Reply-To: <8280fb65-a897-3d71-79f9-9f80d9e474e9@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR19CA0059.namprd19.prod.outlook.com
 (2603:10b6:208:19b::36) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 40141626-f1db-484e-9c1c-08d75ef2df5c
x-ms-traffictypediagnostic: VI1PR05MB5437:
x-microsoft-antispam-prvs: <VI1PR05MB543752CC8542C603489894ADCF620@VI1PR05MB5437.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(189003)(199004)(305945005)(66066001)(64756008)(316002)(1076003)(71200400001)(2906002)(99286004)(6436002)(76176011)(6486002)(52116002)(14454004)(478600001)(4326008)(81166006)(8936002)(8676002)(5660300002)(229853002)(186003)(26005)(54906003)(486006)(36756003)(66446008)(66556008)(66476007)(256004)(14444005)(81156014)(2616005)(6512007)(7416002)(6916009)(476003)(446003)(11346002)(86362001)(25786009)(71190400001)(386003)(102836004)(3846002)(6506007)(6116002)(7736002)(33656002)(6246003)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5437;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JHnX+mDnhQTEJ/8vRWmTqF5EqhjM5XCJczY0EKJOY8Aea4SmymXL7wo8LP9BXPuzMhvpPeVb+VyLcV+dHlQD39hwg7dvtyII/VwYvLaWnLQoJ0W+YEFopQdipxASU8gSgdRnq2zydilrKwKK7ZbWQ7qQf8LTCMZjeNYdbMuynq5b9JXbJ0fyOa+ElStvpVreC2F2DB2yqI4S5JmRoDRJ+Tw1k5HeUDB99hZwOLh0Kndy40ZFbOGIEKk2LKjfHif/Q9LA/PVz2uTk49XhcC0CqpHLWbPItX5218240Uw++tHVPv1I2te15kaQ7NhB1g9setU/+isjWN2Ka0mgoxweiaRDEidEw3JsiLsjlwwdxDf+ArueQ+HPdaHlQ3y8u5S7OKQkLnEyvQRZg50+hoRgkwiR4Q+nLMIv8Wk0lYLTrZzMnTLVtjOPHbPo403KYH1+
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AF9CCF2DA50D054FAB60B8932C09BE36@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40141626-f1db-484e-9c1c-08d75ef2df5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 17:42:32.2827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YX05WhGl/n9htcVT65uicoOpgdBYa3GCY1qv0+ia3D0HZbLhgadtvSD/dPNmwJPfCmu9fZ70dAanlqIa+EwjIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5437
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 01, 2019 at 03:59:26PM +0000, Yang, Philip wrote:
> > This test for range_blockable should be before mutex_lock, I can move
> > it up
> >=20
> yes, thanks.

Okay, I wrote it like this:

	if (mmu_notifier_range_blockable(range))
		mutex_lock(&adev->notifier_lock);
	else if (!mutex_trylock(&adev->notifier_lock))
		return false;

> > Also, do you know if notifier_lock is held while calling
> > amdgpu_ttm_tt_get_user_pages_done()? Can we add a 'lock assert held'
> > to amdgpu_ttm_tt_get_user_pages_done()?
>=20
> gpu side hold notifier_lock but kfd side doesn't. kfd side doesn't check=
=20
> amdgpu_ttm_tt_get_user_pages_done/mmu_range_read_retry return value but=20
> check mem->invalid flag which is updated from invalidate callback. It=20
> takes more time to change, I will come to another patch to fix it later.

Ah.. confusing, OK, I'll let you sort that

> > However, this is all pre-existing bugs, so I'm OK go ahead with this
> > patch as modified. I advise AMD to make a followup patch ..
> >=20
> yes, I will.

While you are here, this is also wrong:

int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
{
	down_read(&mm->mmap_sem);
	r =3D hmm_range_fault(range, 0);
	up_read(&mm->mmap_sem);
	if (unlikely(r <=3D 0)) {
		if ((r =3D=3D 0 || r =3D=3D -EBUSY) && !time_after(jiffies, timeout))
			goto retry;
		goto out_free_pfns;
	}

	for (i =3D 0; i < ttm->num_pages; i++) {
		pages[i] =3D hmm_device_entry_to_page(range, range->pfns[i]);

It is not allowed to read the results of hmm_range_fault() outside
locking, and in particular, we can't convert to a struct page.

This must be done inside the notifier_lock, after checking
mmu_range_read_retry(), all handling of the struct page must be
structured like that.

> >> @@ -997,10 +1004,18 @@ static void amdgpu_ttm_tt_unpin_userptr(struct =
ttm_tt *ttm)
> >>   	sg_free_table(ttm->sg);
> >>  =20
> >>   #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
> >> -	if (gtt->range &&
> >> -	    ttm->pages[0] =3D=3D hmm_device_entry_to_page(gtt->range,
> >> -						      gtt->range->pfns[0]))
> >> -		WARN_ONCE(1, "Missing get_user_page_done\n");
> >> +	if (gtt->range) {
> >> +		unsigned long i;
> >> +
> >> +		for (i =3D 0; i < ttm->num_pages; i++) {
> >> +			if (ttm->pages[i] !=3D
> >> +				hmm_device_entry_to_page(gtt->range,
> >> +					      gtt->range->pfns[i]))
> >> +				break;
> >> +		}
> >> +
> >> +		WARN((i =3D=3D ttm->num_pages), "Missing get_user_page_done\n");
> >> +	}
> >=20
> > Is this related/necessary? I can put it in another patch if it is just
> > debugging improvement? Please advise
> >=20
> I see this WARN backtrace now, but I didn't see it before. This is=20
> somehow related.

Hm, might be instructive to learn what is going on..

Thanks,
Jason
