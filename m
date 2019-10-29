Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA5ABE8ECE
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 18:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfJ2R6w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 13:58:52 -0400
Received: from mail-eopbgr10046.outbound.protection.outlook.com ([40.107.1.46]:63299
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726635AbfJ2R6v (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 13:58:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/aOjjQDz8d9Mm6varQGF8jp/xq1lmjl5QDdMn0S62SapyLs/AZZIOkViEJW3nX2iLuwokKCbfnRdVBZA+FsnowKTTVGD1zm6/JQ1rNPcLO2gBlefETsHcQGbY2IXEuV5+KtYzQdKm/A9129I6l2BNAYG1pU/hUvjant8uwknK+7H4dr97GMdiN1d01MwKXp85g8GYeuVKfHftcic/VtgnpC6yMBbg0HkQ93uHhWN9ZlrPvnMP+7/MkkPXt76yHfBxdpIKWP+FvSs74c07QAHgjffOwcdOzkC6RKHtutwGFy53HHOBUOu+OtEXQjjCFi+kdvgglTcvx4bE48FSTyFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSQguOojldxDIgqXX9mQB+qZML/3xmPSJVsJ8JqluyU=;
 b=jSENAZRdNjFxl5Qi6uhHLdmOmA6wFqDpGVusuZfTeLnJFi8OpSvDYxZ4wagMKlYxcz9W525i5BlJfwjOlkZEHjuuKwFM9RDoXijDdrQlAHxXnydxwy7BGiRLIzygHaqHZudS6CSnNYC8SoupGH/qtmjtlDmava/FhGEAkzd4b2fNB8cIztTNgkaVvOKSbyO5LrNYyPQ8xLp6pw9khngLNGSPV+ocZ8M2E5e7aRXFqYVglOvvRTpEq/BbvoX72VdvTwmbl8/ebGY7V2hhfm+OQRrmDZFff7tM4mhYS3SN0O0A1eEITjsA4r/VfjGex3ZtxBkSvY7H7RvnI11XvbpIgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSQguOojldxDIgqXX9mQB+qZML/3xmPSJVsJ8JqluyU=;
 b=r0oMosMZ0BuDzomz54fTiEWmAtaDaKsLGvQOFLszKzW7MMPwAlz5sRh8BVOLlHkDsTgasxDU9rIIVRQlOEnXG1gX/Nd76JcGCh/eaomAZ0jUdGpGegpeVDwNJUKDAeiWxyI8MOLwoDcdyq6ojXS3v8DuGk3z6fpv45dofZyWeuY=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5086.eurprd05.prod.outlook.com (20.177.48.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 17:58:41 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2387.027; Tue, 29 Oct 2019
 17:58:41 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] mm/hmm/test: add self tests for HMM
Thread-Topic: [PATCH v3 3/3] mm/hmm/test: add self tests for HMM
Thread-Index: AQHVidvRl0DiLfVRckS4hHS5dqmJyadx8UKA
Date:   Tue, 29 Oct 2019 17:58:41 +0000
Message-ID: <20191029175837.GS22766@mellanox.com>
References: <20191023195515.13168-1-rcampbell@nvidia.com>
 <20191023195515.13168-4-rcampbell@nvidia.com>
In-Reply-To: <20191023195515.13168-4-rcampbell@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR02CA0104.namprd02.prod.outlook.com
 (2603:10b6:208:51::45) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0893803f-6f30-4acb-560d-08d75c99a1c1
x-ms-traffictypediagnostic: VI1PR05MB5086:
x-microsoft-antispam-prvs: <VI1PR05MB5086B73BA08A9B292B35677DCF610@VI1PR05MB5086.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(189003)(199004)(36756003)(71200400001)(5660300002)(64756008)(1076003)(6246003)(66446008)(86362001)(25786009)(14454004)(66946007)(76176011)(99286004)(52116002)(33656002)(7736002)(186003)(66476007)(66556008)(229853002)(102836004)(256004)(14444005)(6506007)(386003)(11346002)(6486002)(476003)(66066001)(71190400001)(6116002)(26005)(305945005)(478600001)(446003)(3846002)(6512007)(486006)(2616005)(81156014)(81166006)(316002)(8676002)(6916009)(4326008)(8936002)(6436002)(54906003)(2906002)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5086;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TF1PyZJ8qfupmOxmUd9oqOLbp0d8JeIqzOzk7eK7mUygjDR8dm53nipMfXFUJZ6wTdpVXwvgY7cnMRjdF/hRdOGqPhvo6GldIai3TxOYft+TuqAFYuIh7++0VD6pI8LDqwHj80i3CsueSlVYJDPjHxN9lvwb7W4tLCMgpWms7E4hfrDnf04ckPqJpkEwWhwsZ1pcXdU0X/S9lLIQWjr43e5lC3bNOa4JRp/jCvmz/mOqX9bHYhJdoEOQqDgqAAw7mHhxjep1cjXAjdNG7O7qV+T+CEKQUimJcwhJT1ZFXNoBjM+R/AvGxaH63HOD3+dEUl7R/OfuHt1GGOspK6K2SKV5UGi1kwGbGPzrL65/aJHpQffHNq1BZNJ5aiEGBiv9qXZsEMmCMOgeMlm5IK6CdBL+bfZRbFZFM7fky0XCnd3f9g9zEEU8u+Sg2t7P3YDZ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <656EB55AB16D594BA1279C5FBD98231B@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0893803f-6f30-4acb-560d-08d75c99a1c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 17:58:41.2756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1QT+zFgEGwSKGNgaMrGVmBrpl2CHQF52YoaQtUhWRdKADqBOfvBcVEn5PZBMbn30pVCc39rx0yvQQZuzAjhs6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5086
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 23, 2019 at 12:55:15PM -0700, Ralph Campbell wrote:
> Add self tests for HMM.
>
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
>  MAINTAINERS                            |    3 +
>  drivers/char/Kconfig                   |   11 +
>  drivers/char/Makefile                  |    1 +
>  drivers/char/hmm_dmirror.c             | 1566 ++++++++++++++++++++++++
>  include/Kbuild                         |    1 +
>  include/uapi/linux/hmm_dmirror.h       |   74 ++
>  tools/testing/selftests/vm/.gitignore  |    1 +
>  tools/testing/selftests/vm/Makefile    |    3 +
>  tools/testing/selftests/vm/config      |    3 +
>  tools/testing/selftests/vm/hmm-tests.c | 1311 ++++++++++++++++++++
>  tools/testing/selftests/vm/run_vmtests |   16 +
>  tools/testing/selftests/vm/test_hmm.sh |   97 ++
>  12 files changed, 3087 insertions(+)
>  create mode 100644 drivers/char/hmm_dmirror.c
>  create mode 100644 include/uapi/linux/hmm_dmirror.h
>  create mode 100644 tools/testing/selftests/vm/hmm-tests.c
>  create mode 100755 tools/testing/selftests/vm/test_hmm.sh

This is really big, it would be nice to get a comment from the various
kernel testing folks if this approach makes sense with the test
frameworks. Do we have other drivers that are only intended to be used
by selftests?

Frankly, I'm not super excited about the idea of a 'test driver', it
seems more logical for testing to have some way for a test harness to
call hmm_range_fault() under various conditions and check the results?

It seems especially over-complicated to use a full page table layout
for this, wouldn't something simple like an xarray be good enough for
test purposes?

> +/*
> + * Below are the file operation for the dmirror device file. Only ioctl =
matters.
> + *
> + * Note this is highly specific to the dmirror device driver and should =
not be
> + * construed as an example on how to design the API a real device driver=
 would
> + * expose to userspace.
> + */
> +static ssize_t dmirror_fops_read(struct file *filp,
> +			       char __user *buf,
> +			       size_t count,
> +			       loff_t *ppos)
> +{
> +	return -EINVAL;
> +}
> +
> +static ssize_t dmirror_fops_write(struct file *filp,
> +				const char __user *buf,
> +				size_t count,
> +				loff_t *ppos)
> +{
> +	return -EINVAL;
> +}
> +
> +static int dmirror_fops_mmap(struct file *filp, struct vm_area_struct *v=
ma)
> +{
> +	/* Forbid mmap of the dmirror device file. */
> +	return -EINVAL;
> +}

I'm pretty sure these can just be left as NULL in the fops?

> +static int dmirror_fault(struct dmirror *dmirror,
> +			 unsigned long start,
> +			 unsigned long end,
> +			 bool write)
> +{
> +	struct mm_struct *mm =3D dmirror->mirror.hmm->mmu_notifier.mm;
> +	unsigned long addr;
> +	unsigned long next;
> +	uint64_t pfns[64];
> +	struct hmm_range range =3D {
> +		.pfns =3D pfns,
> +		.flags =3D dmirror_hmm_flags,
> +		.values =3D dmirror_hmm_values,
> +		.pfn_shift =3D DPT_SHIFT,
> +		.pfn_flags_mask =3D ~(dmirror_hmm_flags[HMM_PFN_VALID] |
> +				    dmirror_hmm_flags[HMM_PFN_WRITE]),
> +		.default_flags =3D dmirror_hmm_flags[HMM_PFN_VALID] |
> +				(write ? dmirror_hmm_flags[HMM_PFN_WRITE] : 0),
> +	};
> +	int ret =3D 0;
> +
> +	for (addr =3D start; addr < end; ) {
> +		long count;
> +
> +		next =3D min(addr + (ARRAY_SIZE(pfns) << PAGE_SHIFT), end);
> +		range.start =3D addr;
> +		range.end =3D next;
> +
> +		down_read(&mm->mmap_sem);
> +
> +		ret =3D hmm_range_register(&range, &dmirror->mirror);
> +		if (ret) {
> +			up_read(&mm->mmap_sem);
> +			break;
> +		}
> +
> +		if (!hmm_range_wait_until_valid(&range,
> +						DMIRROR_RANGE_FAULT_TIMEOUT)) {
> +			hmm_range_unregister(&range);
> +			up_read(&mm->mmap_sem);
> +			continue;
> +		}
> +
> +		count =3D hmm_range_fault(&range, 0);
> +		if (count < 0) {
> +			ret =3D count;
> +			hmm_range_unregister(&range);
> +			up_read(&mm->mmap_sem);
> +			break;
> +		}
> +
> +		if (!hmm_range_valid(&range)) {

There is no 'driver lock' being held here, how does this work?
Shouldn't it hold dmirror->mutex for this sequence?

> +			hmm_range_unregister(&range);
> +			up_read(&mm->mmap_sem);
> +			continue;
> +		}
> +		mutex_lock(&dmirror->mutex);
> +		ret =3D dmirror_pt_walk(dmirror, dmirror_do_fault,
> +				      addr, next, &range, true);
> +		mutex_unlock(&dmirror->mutex);

Ie move it down into this block

> +		hmm_range_unregister(&range);
> +		up_read(&mm->mmap_sem);
> +		if (ret)
> +			break;
> +
> +		addr =3D next;
> +	}
> +
> +	return ret;
> +}

> +static int dmirror_read(struct dmirror *dmirror,
> +			struct hmm_dmirror_cmd *cmd)
> +{

Why not just use pread()/pwrite() for this instead of an ioctl?

> +	struct dmirror_bounce bounce;
> +	unsigned long start, end;
> +	unsigned long size =3D cmd->npages << PAGE_SHIFT;
> +	int ret;
> +
> +	start =3D cmd->addr;
> +	end =3D start + size;
> +	if (end < start)
> +		return -EINVAL;
> +
> +	ret =3D dmirror_bounce_init(&bounce, start, size);
> +	if (ret)
> +		return ret;
> +
> +static int dmirror_snapshot(struct dmirror *dmirror,
> +			    struct hmm_dmirror_cmd *cmd)
> +{
> +	struct mm_struct *mm =3D dmirror->mirror.hmm->mmu_notifier.mm;
> +	unsigned long start, end;
> +	unsigned long size =3D cmd->npages << PAGE_SHIFT;
> +	unsigned long addr;
> +	unsigned long next;
> +	uint64_t pfns[64];
> +	unsigned char perm[64];
> +	char __user *uptr;
> +	struct hmm_range range =3D {
> +		.pfns =3D pfns,
> +		.flags =3D dmirror_hmm_flags,
> +		.values =3D dmirror_hmm_values,
> +		.pfn_shift =3D DPT_SHIFT,
> +		.pfn_flags_mask =3D ~0ULL,
> +	};
> +	int ret =3D 0;
> +
> +	start =3D cmd->addr;
> +	end =3D start + size;
> +	uptr =3D (void __user *)cmd->ptr;
> +
> +	for (addr =3D start; addr < end; ) {
> +		long count;
> +		unsigned long i;
> +		unsigned long n;
> +
> +		next =3D min(addr + (ARRAY_SIZE(pfns) << PAGE_SHIFT), end);
> +		range.start =3D addr;
> +		range.end =3D next;
> +
> +		down_read(&mm->mmap_sem);
> +
> +		ret =3D hmm_range_register(&range, &dmirror->mirror);
> +		if (ret) {
> +			up_read(&mm->mmap_sem);
> +			break;
> +		}
> +
> +		if (!hmm_range_wait_until_valid(&range,
> +						DMIRROR_RANGE_FAULT_TIMEOUT)) {
> +			hmm_range_unregister(&range);
> +			up_read(&mm->mmap_sem);
> +			continue;
> +		}
> +
> +		count =3D hmm_range_fault(&range, HMM_FAULT_SNAPSHOT);
> +		if (count < 0) {
> +			ret =3D count;
> +			hmm_range_unregister(&range);
> +			up_read(&mm->mmap_sem);
> +			if (ret =3D=3D -EBUSY)
> +				continue;
> +			break;
> +		}
> +
> +		if (!hmm_range_valid(&range)) {

Same as for dmirror_fault

> +			hmm_range_unregister(&range);
> +			up_read(&mm->mmap_sem);
> +			continue;
> +		}
> +
> +		n =3D (next - addr) >> PAGE_SHIFT;
> +		for (i =3D 0; i < n; i++)
> +			dmirror_mkentry(dmirror, &range, perm + i, pfns[i]);

Is this missing locking too?

> +static int dmirror_remove(struct platform_device *pdev)
> +{
> +	/* all probe actions are unwound by devm */
> +	return 0;
> +}
> +
> +static struct platform_driver dmirror_device_driver =3D {
> +	.probe		=3D dmirror_probe,
> +	.remove		=3D dmirror_remove,
> +	.driver		=3D {
> +		.name	=3D "HMM_DMIRROR",
> +	},
> +};

This presence of a platform_driver and device is very confusing. I'm
sure Greg KH would object to this as a misuse of platform drivers.

A platform device isn't needed to create a char dev, so what is this for?

> diff --git a/include/Kbuild b/include/Kbuild
> index ffba79483cc5..6ffb44a45957 100644
> --- a/include/Kbuild
> +++ b/include/Kbuild
> @@ -1063,6 +1063,7 @@ header-test-			+=3D uapi/linux/coda_psdev.h
>  header-test-			+=3D uapi/linux/errqueue.h
>  header-test-			+=3D uapi/linux/eventpoll.h
>  header-test-			+=3D uapi/linux/hdlc/ioctl.h
> +header-test-			+=3D uapi/linux/hmm_dmirror.h

Why? This list should only be updated if the header is broken in some
way.


> diff --git a/tools/testing/selftests/vm/hmm-tests.c b/tools/testing/selft=
ests/vm/hmm-tests.c
> new file mode 100644
> index 000000000000..f4ae6188fd0e
> --- /dev/null
> +++ b/tools/testing/selftests/vm/hmm-tests.c
> @@ -0,0 +1,1311 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2013 Red Hat Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

btw, I think if a SPDX is present I don't think the license text is
required, just the copyright.

I think these tests should also study the various case of invoke
pte_hole, ie faulting/snappshotting before/after a vma, or across a
vma range with a hole, etc, etc.

Jason
