Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67C1BEC861
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2019 19:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725536AbfKASVM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Nov 2019 14:21:12 -0400
Received: from mail-eopbgr130058.outbound.protection.outlook.com ([40.107.13.58]:36783
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725989AbfKASVM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 1 Nov 2019 14:21:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkIlIG85b9ACWFy9reH0jRILGQNySHdqVQR64w/uzKYm5GTkz835FjgrwshRGgyzWxwcth4ipmQVBPWuK20ngr/wuRwmetgQEEvp0EtA06x62ZO+oUChlfAfvzwCdJR4HQS+0uzBmyligOF4srbHmkBfGN2cxTU+E5ocJRJ++TcbuaUlXhzagnsYJ5+ul08y845BF1R10DUhgpEpIFHuBMyM/9rVN/guw5xO4fuXTg9gemhCaSQQZaxKlZR1m57LMhYk+BcRp3s8l1fA8pBsOVg7RDZlGiJluzL2zyuKtm8VVUIbjbrjNo4zuyfHFJ4P/xfZ06tau2fvklClBEV1NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kF8vKQntyNYsBxGxQvVYyiW6RqO65RRaLmW947DAoGA=;
 b=AhHFdRgY7dikywn45HiI86lXdZsi8WgiR1KDQF4Mbn45zN6c0oDLLcunQndOpH7nGDjXM4OGYb4S/8phuQNQZmkFPG6quA0nbaItJ3zyoNRctekeje65rfs7WAyT6U/TJUGJWhD+LUdc3UWns7xwYJfHVAfaHzKj2EGoykuXl3kPewVFBLhrbqBJnXRbRflO0/hfRO+qV2qf4E85/GvQvkK8ZBYfFi+Ru/rH4q48Q6THQQhCu4trzuf8GYAIfZKC2PVAK+zVocCP83fdRY051vj2RAzHZRmcOb4QfKfdH76FT2cx6cd7s0h972A5q6GHVxj8z6nL/CO+A12zVivs7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kF8vKQntyNYsBxGxQvVYyiW6RqO65RRaLmW947DAoGA=;
 b=eM79Sa7oPnmD8fZFOSkpPk8Zu46YWMMzRCK8D6sQWhZvrLYsbFdW1MtX1KnxdDf/PctHmfXigqFkZsSAyQpEDvfeQQp3PHKsOhwPxM1gvdheQnFTF2rxiMnCFpBYEsumNR/sLQs+HsLBF/oZqawU0xUgtSCBVJa2kZrx8GkvLs8=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5853.eurprd05.prod.outlook.com (20.178.125.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Fri, 1 Nov 2019 18:21:07 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 18:21:07 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     "Yang, Philip" <Philip.Yang@amd.com>,
        Jerome Glisse <jglisse@redhat.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
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
Thread-Index: AQHVjcvOUfhzqykxXkO0v7SQaQq3BKdyANqAgAAA3wCABGiEgIAAPGcA
Date:   Fri, 1 Nov 2019 18:21:06 +0000
Message-ID: <20191101182102.GQ22766@mellanox.com>
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
x-clientproxiedby: MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8dfa72ed-91de-48e5-aa0e-08d75ef8431a
x-ms-traffictypediagnostic: VI1PR05MB5853:
x-microsoft-antispam-prvs: <VI1PR05MB58532EE395A4046BBCE3BDC7CF620@VI1PR05MB5853.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(199004)(189003)(256004)(8936002)(66476007)(66556008)(2616005)(446003)(4326008)(11346002)(476003)(478600001)(316002)(66946007)(64756008)(6486002)(6436002)(186003)(6246003)(99286004)(86362001)(71190400001)(386003)(71200400001)(229853002)(8676002)(6512007)(26005)(66446008)(7416002)(486006)(6506007)(102836004)(6116002)(52116002)(7736002)(25786009)(1076003)(66066001)(305945005)(81166006)(81156014)(76176011)(36756003)(3846002)(2906002)(54906003)(5660300002)(110136005)(14444005)(33656002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5853;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jPwOgY/hIP0LtY+dQlOxGJl3acxXoYJXK3aUAWCEOJwTBzHvWDpgrCMcdpTAzYwVybyGdJTr7mTIociRf7m6lPf3t2AVJ9tPNyM2z5PTnvapgs6WbsPS4zN+gKbZYG+D/EG+H9hDXg5dxDXS0Ig3w2SSNt8yROmYsoI619ySLGqSQa05ZdmpU7dn16YgZWzEEK/slfIeZkwnUOjdKvgM0VMBvSh7lJ25XAhSjVrpomxLoQz1X/Uhjijq4He8WoXA+5gwnvpKuEECpVwHe1pSC2geDJXfhwd77KgGtapS6upiBN6+dBqBP3HvAbM2Smaa0L4glGO/lNMDWucXx4vc27TeUCWItRDSRB8tjohf52FiEVF2vFxEaNKSFDRIDyyg10BwWDVBbL1MG7LaXlvlbzzY1j7u61OOE3673t8XnxMTmQ0+uK1o0PiS5xt87T1P
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BCECA9D0A65ADC4A904C52D0F1BF1A4A@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfa72ed-91de-48e5-aa0e-08d75ef8431a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 18:21:06.9734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ve/HA1olu6L2MB6fAFm5q8Med2HekEUOECkay3snQNY9Hr/GEgTtXHcwvSKoNiwhuY8V1oE4/mJcE7HU85CBPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5853
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 01, 2019 at 02:44:51PM +0000, Yang, Philip wrote:
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

I was reflecting on why this suddently became necessary, and I think
what might be happening is that hmm_range_fault() is trigging
invalidations as it runs (ie it is faulting in pages or something) and
that in turn causes the mrn to need retry.

The hmm version of this had a bug where a full
invalidate_range_start/end pair would not trigger retry, so this this
didn't happen.

This is unfortunate as the retry is unnecessary, but at this time I
can't think of a good way to separate an ignorable synchronous
invalidation caused by hmm_range_fault from an async one that cannot
be ignored..

A basic fix would be to not update the mrq seq in the notifier if
the invalidate is triggered by hmm_range_fault, but that seems
difficult to determine..

Any thoughts Jerome?

Jason
