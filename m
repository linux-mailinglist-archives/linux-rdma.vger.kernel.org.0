Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69328EC56B
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2019 16:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfKAPMc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Nov 2019 11:12:32 -0400
Received: from mail-eopbgr50072.outbound.protection.outlook.com ([40.107.5.72]:45726
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727326AbfKAPMc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 1 Nov 2019 11:12:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgdC4d24Rdtu00wf76tr/TjDTx2aWKmDIzVNYGp5ljjpdhopFRK9GZbf0JfB5tok5L9rh3aoQI4VRmjBQVigpNBNc97tFv5QhSx3mAOWZr6brmy+Mndg0n09rRgcOpr4ihHtxRUl3hkfekp+e25Z1ioiBmjA4chhX8r03Xrmwz+DzI0z7f+cJVl3cya4U++b+PhuzmiOe6b0UR5doPtLZClyz0D249PtqnrlY+6cmRWtn1DfU0VAGK6W8oPa4fYhbymrzc/LVDrlagpcDWZBPmp//XmMICAy1zCcjKEKzogs4Rl4JBDBBw58bXO7okn5aJn1QoZm+zGqI9poxxaP4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBkO4Aj0byn7s6Bm0dFVLfpXWPn4l83nSzrjzVuIjYM=;
 b=cVHZJRIGZr9UlfgrqZBAOZlvrPTJSuatYApR3bYE2bRumC3sUFFk7Y2L7FMkZQf6oW8ozX0LUTqxknMoW00QMlPh+25T8tVL4e2BtCTaDthLsy6lR+N0ex9Vp6Y/MO7fazndK7grryy59ECQU8vALxxwmFsshkspOufk4Dv3Im1H7tkAy/q/HowhDTMwVmEVQWWK+m2mlNx7l78x34iU7QmdGjyIB97vJL01uczSDTGu3MHn2UzsABL0qb+CoPYhxl97jAOY6S5QjLhYSoNHEAEaMU5UwoCfH649qi2QAm+onspqx4z2E9sxvGv4nPb1JOSwM6fg5LgHWLsPNCMdpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBkO4Aj0byn7s6Bm0dFVLfpXWPn4l83nSzrjzVuIjYM=;
 b=bDHwJTdqflJxu7YIoWqMyjjeiyB25GsQ4j55aDhprJ65AXQxtK17c3ZyQDS4jBt3NqEFRR2LSlV9756M/MxeSLmPYTkowS+zZaNzQTRxP6VJNyMqD7VZO4snXRypdIaojIykpeYFPNJM8GvMHI001h0fNW849iHfj9T+rtypnxE=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB6272.eurprd05.prod.outlook.com (20.177.52.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.25; Fri, 1 Nov 2019 15:12:27 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 15:12:27 +0000
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
Thread-Index: AQHVjcvOUfhzqykxXkO0v7SQaQq3BKdyANqAgAAA3wCABGiEgIAAB7AA
Date:   Fri, 1 Nov 2019 15:12:27 +0000
Message-ID: <20191101151222.GN22766@mellanox.com>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-15-jgg@ziepe.ca>
 <a456ebd0-28cf-997b-31ff-72d9077a9b8e@amd.com>
 <20191029192544.GU22766@mellanox.com>
 <30b2f569-bf7a-5166-c98d-4a4a13d1351f@amd.com>
In-Reply-To: <30b2f569-bf7a-5166-c98d-4a4a13d1351f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR22CA0046.namprd22.prod.outlook.com
 (2603:10b6:404:37::32) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2778cc13-f4ca-4bcf-a336-08d75edde7fe
x-ms-traffictypediagnostic: VI1PR05MB6272:
x-microsoft-antispam-prvs: <VI1PR05MB6272CE1186E06EA63BEAFCCECF620@VI1PR05MB6272.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(199004)(189003)(71200400001)(3846002)(71190400001)(229853002)(7416002)(6436002)(36756003)(8936002)(4326008)(6916009)(6246003)(81166006)(4001150100001)(81156014)(256004)(6486002)(14444005)(6512007)(305945005)(316002)(8676002)(5024004)(54906003)(7736002)(1076003)(11346002)(476003)(2616005)(52116002)(33656002)(446003)(25786009)(66946007)(386003)(66476007)(66446008)(64756008)(6506007)(186003)(66556008)(99286004)(66066001)(86362001)(5660300002)(53546011)(14454004)(76176011)(102836004)(26005)(6116002)(2906002)(486006)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6272;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0PHZo1jiT1pkz33nCJj8So/VbYak/n14O0cbehhz3RR1ym22xMr9KmU+ZWIpMKKp1GJiXGv4CBcItN+k5mMgzadBxM4wqZ2otHp/FbvhGjL377p2XLoFgCwJMsPYcBIzqtZBQ8DeS3k0Zo+H1EtxytFNEGiaTmf5kKrTheDqgxmJSc6+thxaBdeO8THCsrvQPn6kFFUeS7R0/Uybm2ll/MRiQOL19dudiVLo94i+BjLenM2l90VDSfxjaQglwfhR3TIX3nQ4aMSm/HbtjsGgw2Lu3zto2kBGEB5G2AY4FSXjDG0rjtRW0Gw7X50RXwtSQjCFgoHylb9NK75usq4GiwBGrkm44kf4Sv3+SE3xDXHbIClXiaGswYGw14ROASHeGkWtVjB7DwFSZvI/fjMTRwjzZKGq3Q1Q61j+KSQyA+b1R4vq1u9UUOuEqZ0epj2b
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <57BD06A1E1219245833195A807EB8970@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2778cc13-f4ca-4bcf-a336-08d75edde7fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 15:12:27.2730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IAUkTm1jGhsDFiwCZ1GCJfQdaQdau5qLwgyjoO3DI3luUvfYVzzuKVYtAwoTn37NQaBhgOUxb+jgb9QRdBIpOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6272
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 01, 2019 at 02:44:51PM +0000, Yang, Philip wrote:
>=20
>=20
> On 2019-10-29 3:25 p.m., Jason Gunthorpe wrote:
> > On Tue, Oct 29, 2019 at 07:22:37PM +0000, Yang, Philip wrote:
> >> Hi Jason,
> >>
> >> I did quick test after merging amd-staging-drm-next with the
> >> mmu_notifier branch, which includes this set changes. The test result
> >> has different failures, app stuck intermittently, GUI no display etc. =
I
> >> am understanding the changes and will try to figure out the cause.
> >=20
> > Thanks! I'm not surprised by this given how difficult this patch was
> > to make. Let me know if I can assist in any way
> >=20
> > Please ensure to run with lockdep enabled.. Your symptops sounds sort
> > of like deadlocking?
> >=20
> Hi Jason,
>=20
> Attached patch fix several issues in amdgpu driver, maybe you can squash=
=20
> this into patch 14. With this is done, patch 12, 13, 14 is Reviewed-by=20
> and Tested-by Philip Yang <philip.yang@amd.com>

Wow, this is great thanks! Can you clarify what the problems you found
were? Was the bug the 'return !r' below?

I'll also add your signed off by

Here are some remarks:

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_mn.c
> index cb718a064eb4..c8bbd06f1009 100644
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> @@ -67,21 +67,15 @@ static bool amdgpu_mn_invalidate_gfx(struct mmu_range=
_notifier *mrn,
>  	struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
>  	long r;
> =20
> -	/*
> -	 * FIXME: Must hold some lock shared with
> -	 * amdgpu_ttm_tt_get_user_pages_done()
> -	 */
> -	mmu_range_set_seq(mrn, cur_seq);
> +	mutex_lock(&adev->notifier_lock);
> =20
> -	/* FIXME: Is this necessary? */
> -	if (!amdgpu_ttm_tt_affect_userptr(bo->tbo.ttm, range->start,
> -					  range->end))
> -		return true;
> +	mmu_range_set_seq(mrn, cur_seq);
> =20
> -	if (!mmu_notifier_range_blockable(range))
> +	if (!mmu_notifier_range_blockable(range)) {
> +		mutex_unlock(&adev->notifier_lock);
>  		return false;

This test for range_blockable should be before mutex_lock, I can move
it up

Also, do you know if notifier_lock is held while calling
amdgpu_ttm_tt_get_user_pages_done()? Can we add a 'lock assert held'
to amdgpu_ttm_tt_get_user_pages_done()?

> @@ -854,12 +853,20 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *=
bo, struct page **pages)
>  		r =3D -EPERM;
>  		goto out_unlock;
>  	}
> +	up_read(&mm->mmap_sem);
> +	timeout =3D jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
> +
> +retry:
> +	range->notifier_seq =3D mmu_range_read_begin(&bo->notifier);
> =20
> +	down_read(&mm->mmap_sem);
>  	r =3D hmm_range_fault(range, 0);
>  	up_read(&mm->mmap_sem);
> -
> -	if (unlikely(r < 0))
> +	if (unlikely(r <=3D 0)) {
> +		if ((r =3D=3D 0 || r =3D=3D -EBUSY) && !time_after(jiffies, timeout))
> +			goto retry;
>  		goto out_free_pfns;
> +	}

This isn't really right, a retry loop like this needs to go all the
way to mmu_range_read_retry() and done under the notifier_lock. ie
mmu_range_read_retry() can fail just as likely as hmm_range_fault()
can, and drivers are supposed to retry in both cases, with a single
timeout.

AFAICT it is a major bug that many places ignore the return code of
amdgpu_ttm_tt_get_user_pages_done() ???

However, this is all pre-existing bugs, so I'm OK go ahead with this
patch as modified. I advise AMD to make a followup patch ..

I'll add a FIXME note to this effect.

>  	for (i =3D 0; i < ttm->num_pages; i++) {
>  		pages[i] =3D hmm_device_entry_to_page(range, range->pfns[i]);
> @@ -916,7 +923,7 @@ bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt =
*ttm)
>  		gtt->range =3D NULL;
>  	}
> =20
> -	return r;
> +	return !r;

Ah is this the major error? hmm_range_valid() is inverted vs
mmu_range_read_retry()?

>  }
>  #endif
> =20
> @@ -997,10 +1004,18 @@ static void amdgpu_ttm_tt_unpin_userptr(struct ttm=
_tt *ttm)
>  	sg_free_table(ttm->sg);
> =20
>  #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
> -	if (gtt->range &&
> -	    ttm->pages[0] =3D=3D hmm_device_entry_to_page(gtt->range,
> -						      gtt->range->pfns[0]))
> -		WARN_ONCE(1, "Missing get_user_page_done\n");
> +	if (gtt->range) {
> +		unsigned long i;
> +
> +		for (i =3D 0; i < ttm->num_pages; i++) {
> +			if (ttm->pages[i] !=3D
> +				hmm_device_entry_to_page(gtt->range,
> +					      gtt->range->pfns[i]))
> +				break;
> +		}
> +
> +		WARN((i =3D=3D ttm->num_pages), "Missing get_user_page_done\n");
> +	}

Is this related/necessary? I can put it in another patch if it is just
debugging improvement? Please advise

Thanks a lot,
Jason
