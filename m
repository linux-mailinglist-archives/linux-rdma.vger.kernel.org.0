Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B728DF525
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 20:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfJUScb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 14:32:31 -0400
Received: from mail-eopbgr70055.outbound.protection.outlook.com ([40.107.7.55]:18574
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730079AbfJUScb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Oct 2019 14:32:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DU4ZQr7ao4bqfhlsjC6E0vYit0wG3x2WQOl38bLCs9H4TmJOIAN0cCx4+1bY7fqFdAlN/y/YTwYOJULVlYlfKNSGcVmi5VdaO0+R6Qj1quCsHEZf81ABR/4kjOzJ5qjBn02v3T1M9rLO01/zcxlfjbRswV5FIMlxLfgKEOlDcmBioMV0aeh6AhtTcLvQJbdK5Vi0NVsEjVEMU7NgZhH1I7XrUhUHViySaKVVaISeiXIlACY3zNmEBSAuXf7XgrZJYnhCMjdGm2Ni1OGCjYQoaDV9/K7I7eSS9UXmefDRFENR3CJR4FpCoRfkzZ8xfNHw7qolTMqKuTVuIMDSyBb4Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pfk5WI1mKhPG1BDH7mSd6XeV/DusEQl9wtLlRGnvrvA=;
 b=oMEfzfkDIMAvlZwSDR2nGY3YQ18pi2Kc0zTunwYfBrCH0JoAlfOtjqIAMPWX1C5x1PrLo23r/KCtOEe/JqFxdUSdbKj/OIYUU5U+LHboRAlcjf6XJxHDGmMpPtvPUgqlO3tmglsar+fUEKPOqDSnBdxpyuFFButQBMTwygsyM8FkpgGtmvv2Qqi8jVeHZWkQ2N3E06UNjWiQAtQDPL4/tXom6bqtIvA92Zemr7Ma2oMeAJkAuxzXeYiSD/N1zYlEEAfgdBY5TSiOmjvGah//mIjF49TJ5YKMPO5r/jVQZIKbe8qO4z1463DDGFSBnyYZuWXplDhZ3qsLR8/5PGA9tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pfk5WI1mKhPG1BDH7mSd6XeV/DusEQl9wtLlRGnvrvA=;
 b=jGPA5gT+V6lotsf9RA/XNCnp3uCDH9KPSHTEA8PWJrIkS3onoKZofRWgG5OoOwNJrvZFNB9brlDdCB3MczFlD1DnvOeOLOzVlj8ojyLL+YQyUl8/RbIbuUCPXF1iuglaF0n5lhLUJyCM+yq0rXa19dg/ExsQWe2zyymXoaaN9Zg=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB6045.eurprd05.prod.outlook.com (20.178.204.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.20; Mon, 21 Oct 2019 18:32:24 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0%7]) with mapi id 15.20.2347.029; Mon, 21 Oct 2019
 18:32:24 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2 1/3] mm/hmm: make full use of walk_page_range()
Thread-Topic: [PATCH v2 1/3] mm/hmm: make full use of walk_page_range()
Thread-Index: AQHVg5nmL5ucMsNaN0qxjX25bt9BSKdldIsA
Date:   Mon, 21 Oct 2019 18:32:24 +0000
Message-ID: <20191021183220.GF6285@mellanox.com>
References: <20191015204814.30099-1-rcampbell@nvidia.com>
 <20191015204814.30099-2-rcampbell@nvidia.com>
In-Reply-To: <20191015204814.30099-2-rcampbell@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:208:120::16) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03f715c6-84bd-4be9-ed95-08d756550483
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR05MB6045:
x-microsoft-antispam-prvs: <VI1PR05MB6045CE76ADEC5A7754495129CF690@VI1PR05MB6045.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0197AFBD92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(189003)(199004)(52116002)(14444005)(256004)(76176011)(86362001)(66476007)(66556008)(64756008)(66446008)(66946007)(316002)(6486002)(99286004)(8676002)(54906003)(25786009)(71190400001)(71200400001)(6436002)(36756003)(1076003)(6512007)(486006)(33656002)(476003)(66066001)(26005)(102836004)(446003)(5660300002)(11346002)(6246003)(186003)(81156014)(81166006)(8936002)(2616005)(6916009)(478600001)(229853002)(305945005)(386003)(6506007)(2906002)(14454004)(7736002)(4326008)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6045;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1BUaYRnny8hWrLILUeI06uR3b+uQZxXHuHt6sC4URsv/LQeOLok62nn0FZCDdeC4Z+Knfbg5htFkXB+S+NKMZwiksVuk8KmEXLidnjtR8lus11KrcpbqGsD4mMwmPnDTitiIKJjeDVTS2OMXUisLDtw5rQHYXCah4m5nyEh5AiWh005Asf3JWsDTyy/opGbNTWyvxm/tuXaHKKL9+ITrG9X/Z4L+y2nlyNx3XShkYWsVJTy23710qQGlpRFp11fWF9i8bG+vAvENygwO/0iNjTVZw6bhqkE/BGmOgBTVko+5WxYDOjsOMqf9tFIHhXg5fqB5WSWZAbOl9me21nlF1eqGap4IFOI/fe0WYDqa7oJxI/sDvwL2cnz1Pu8PVxjxDEJ6lGwMVQybchflbBsCqHggqTfUUvHCxGpc5ONFYBvibXFkB9+nT054cOyH19QR
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <39742CA95552C943BCDC821295D69375@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f715c6-84bd-4be9-ed95-08d756550483
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2019 18:32:24.6167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oUtQkBl9efWUPkamxE365x/Sek1LMLa9smhAjfBThsmTkySpCLKeQCZ8lleEqVa5ACIxBBjeH1l/VC/xZq+vPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6045
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 15, 2019 at 01:48:12PM -0700, Ralph Campbell wrote:

> +static bool hmm_range_needs_fault(unsigned long addr, unsigned long end,
> +				  const struct hmm_vma_walk *hmm_vma_walk)

This has a very similar name to hmm_range_need_fault(), and seems like
it does the same thing?

> +static int hmm_vma_walk_test(unsigned long start, unsigned long end,
> +			     struct mm_walk *walk)
> +{
> +	struct hmm_vma_walk *hmm_vma_walk =3D walk->private;
> +	struct hmm_range *range =3D hmm_vma_walk->range;
> +	struct vm_area_struct *vma =3D walk->vma;
> +
> +	/* If range is no longer valid, force retry. */
> +	if (!range->valid)
> +		return -EBUSY;
> +
> +	/*
> +	 * Skip vma ranges that don't have struct page backing them or
> +	 * map I/O devices directly.
> +	 */
> +	if (vma->vm_flags & (VM_IO | VM_PFNMAP | VM_MIXEDMAP))
> +		return -EFAULT;
> +
> +	/*
> +	 * If the vma does not allow read access, then assume that it does not
> +	 * allow write access either. HMM does not support architectures
> +	 * that allow write without read.
> +	 */
> +	if (!(vma->vm_flags & VM_READ)) {
> +		/*
> +		 * Check to see if a fault is requested for any page in the
> +		 * range.
> +		 */
> +		if (hmm_range_needs_fault(start, end, hmm_vma_walk))
> +			return -EFAULT;

Is this change to call hmm_range_needs_fault another bug fix?

Jason
