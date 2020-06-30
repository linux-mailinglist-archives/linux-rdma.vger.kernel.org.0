Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5031320FC6C
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2020 21:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgF3TEV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jun 2020 15:04:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:7972 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbgF3TEU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jun 2020 15:04:20 -0400
IronPort-SDR: /HfLJkF2hhtWwfMeD9OTLbG2ZCvbFzm7yL1VWRCtQeRWp3stgn0y7BcXfCcTJ5JZWUpuEESkJu
 Tv0+ugB58a9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="125987600"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="125987600"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 12:04:18 -0700
IronPort-SDR: SHTF59KJ+M9nRB1g8dgIXUmJOcn1NptaRxioIXtgORoPp7WmtehjwMp6L8cngIu8Brh3+a5OfL
 a50LQTRWB0tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="321013986"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jun 2020 12:04:17 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 30 Jun 2020 12:04:17 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 30 Jun 2020 12:04:17 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 30 Jun 2020 12:04:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mn6z+VQJot9/kpp0rYCEcRiwSWDZC6/Drg02TV9Mq9JA3suGxA7qUhG4r+3MKl2xgJKZqkcWkEVMZax5vawN3lehQMADyEB13EIu7IcWXEntIaUD97XVFJPoVRYg0o3qMToClGcbq3HixZOV9WWPQpH2UrlSZIdks0471V+TBGKrHZtJpulMCkkSbHaOi15aJW5ec5sHLKAT3ePXGNRshh52We94+GKWy2UZpZgELT2ZmsEJHqzpOtjCfYfl/hzOH9Mn184VsYiqdVsb5ibt7cB2CHnCpkwBev88C1e1BEVCuzpXREE/owpo7q8HxGZDSOBn22faweS1SSdOJffe9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKbPBHEkKOK94I74ZvQQWW8AZGVTW2qtWI1jgoeZoXI=;
 b=cC5mSo3C5Z+km/zUl94S8JjM8zXqhiDLo1+W+NItWki8Ul73jRyhfglhBc9OgnFa94lbSpc4FswvTNBDly0WRVYKq8eziTGAEVw/6pKg8IN7T7jztlXlLJlnohcG1SkuSldgVD2K4oa9Sucpsa7I+7Uv3Wa3LXsWgjqAJVINhqd6242aTsmuJtw6OQOk3eoBREnAVrzdGlyZ1gtTHa6QuRYLbq0fdOnGp5baBAlp8ANJdye33/k6tRg8b2FTpWGMv3qPZA4YlEj55i3REKMsoCQhcrxdyK9BB4muvmnObaQq77vT6kdmkZwxdjknLECkG9nVOQc8sOaNFmSqLnd+qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKbPBHEkKOK94I74ZvQQWW8AZGVTW2qtWI1jgoeZoXI=;
 b=tOo9uvF8YOanUdzHdq1liIBNx4bLJdRCT14mMO7VlQ2IUFw3PXrgkyVFNZb1fMP16PCwRJNALk/t9rhHhWZcAyRqGTHVH7HeMnvsPBkr1sgr7/KKCDceA76StLQalcKB4kxg1Yj6Yi7dPzf9hRu/FfSOYCXiBoef9Zp/gQFb9UM=
Received: from MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24)
 by MWHPR11MB1536.namprd11.prod.outlook.com (2603:10b6:301:b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Tue, 30 Jun
 2020 19:04:14 +0000
Received: from MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::ed68:a00b:2bb0:21cf]) by MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::ed68:a00b:2bb0:21cf%8]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 19:04:14 +0000
From:   "Xiong, Jianxin" <jianxin.xiong@intel.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Leon Romanovsky <leon@kernel.org>,
        "Vetter, Daniel" <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: RE: [RFC PATCH v2 1/3] RDMA/umem: Support importing dma-buf as user
 memory region
Thread-Topic: [RFC PATCH v2 1/3] RDMA/umem: Support importing dma-buf as user
 memory region
Thread-Index: AQHWTjmSaTqIEVg9iU+qhadeTgD/7ajxhWig
Date:   Tue, 30 Jun 2020 19:04:14 +0000
Message-ID: <MW3PR11MB45559642DF72752C3FB83FA6E56F0@MW3PR11MB4555.namprd11.prod.outlook.com>
References: <1593451903-30959-1-git-send-email-jianxin.xiong@intel.com>
 <1593451903-30959-2-git-send-email-jianxin.xiong@intel.com>
In-Reply-To: <1593451903-30959-2-git-send-email-jianxin.xiong@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c6df0e8-ff8e-4afe-e573-08d81d2861ca
x-ms-traffictypediagnostic: MWHPR11MB1536:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB15367DC6DFE580C9444E6056E56F0@MWHPR11MB1536.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:635;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ASeWrrxMco2PhMH3LG8mIJ9KmHvoIXWSo2tRxGKeceNQTAkm4Xry6JHwKG+HnjyhE4gTI/PJlv7PVE3akdD42tt99MRaIkRhj0AKbbBuUBbHRCSfxaI/Z9dkPExBjewPVIum3twIsq9e6A91OFiw+dZH2OPiG4wXIFTpGNwzX53vIv1E5EHgzhIf+uvSVEPSNsh0Jj3CGta9TRtBgJ1oVlVf7P4CPyY4kXRmjsI8b9fu+1m7wy2ft032jkjnVAgq/z1NR6N8z43V6Gj46ewcW0RsJgKEVJxmReajVde9yU+wc0Y6q6Hzz1+ImMwvPTtTprKZXVak5ZF2I6f5QOrJ9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4555.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(5660300002)(6916009)(6506007)(4326008)(53546011)(478600001)(66476007)(66556008)(66946007)(66446008)(64756008)(7696005)(83380400001)(52536014)(33656002)(71200400001)(55016002)(186003)(76116006)(86362001)(26005)(316002)(8676002)(8936002)(54906003)(2906002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: tRlki+VTm8MRwEwtjjDNrKcUaARkRqFywXhohVgejKwuTUVJ+l67vddPM/lf+42bnHBib0f6TB/0Wzrqp34xqlgQW6ju7gXBNqbiANY+cfitGUHYBt8m/fG4f5v7JNCb0MfV7ufhrnE6hHsjRxVYNatN1wj3jJ1nsx8P8GUyC2IcPY4kSsPezvAQSKVu85LrGyZVEaj79PGJLLb6DL/9D/7jfxk7zNGs2clXxG/Xbs7QTDI0W71s3ad8EVCShSQy2f8tz0W6KICWYXRdc+EoTCkAkq0xkyoU3CEpRdXAHSWk0HrEp3A5CHuerPqPD3iJC0DMiWvHvwSoU8LsmaRYXqE2SICKIBLe1f7Hq1yVOtW7H902M93ILUQM7XkkdMXlS68jdb9Un0QW2sOV1ygc1lZ2/ob9IS5aQY2pggxxhRCgfUo8UVuoDRuDdtn5iWYpxsTgydXivhAJ80IglFBl3edFtUEy16xRDTdvLTLD0tgVirO9pWpwNtdCzDeRADQv
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4555.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c6df0e8-ff8e-4afe-e573-08d81d2861ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 19:04:14.8802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zPwMde8CTsnFb6CwMrSNpdUyM+Jf3rbRf5Zk9U5C+LFdZ02gvYAjk0/QkJ6aYCq79oOfmHXWZW7XpY4dkojgtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1536
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Cc'd drm people.

> -----Original Message-----
> From: Xiong, Jianxin <jianxin.xiong@intel.com>
> Sent: Monday, June 29, 2020 10:32 AM
> To: linux-rdma@vger.kernel.org
> Cc: Xiong, Jianxin <jianxin.xiong@intel.com>; Doug Ledford <dledford@redh=
at.com>; Jason Gunthorpe <jgg@ziepe.ca>; Sumit Semwal
> <sumit.semwal@linaro.org>; Leon Romanovsky <leon@kernel.org>; Vetter, Dan=
iel <daniel.vetter@intel.com>
> Subject: [RFC PATCH v2 1/3] RDMA/umem: Support importing dma-buf as user =
memory region
>=20
> Dma-buf is a standard cross-driver buffer sharing mechanism that can be
> used to support peer-to-peer access from RDMA devices.
>=20
> Device memory exported via dma-buf can be associated with a file
> descriptor. This is passed to the user space as a property associated
> with the buffer allocation. When the buffer is registered as a memory
> region, the file descriptor is passed to the RDMA driver along with
> other parameters.
>=20
> Implement the common code for importing dma-buf object, and pinning and
> mapping dma-buf pages.
>=20
> Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
> Reviewed-by: Sean Hefty <sean.hefty@intel.com>
> Acked-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
> ---
>  drivers/infiniband/core/Makefile      |   2 +-
>  drivers/infiniband/core/umem.c        |   4 ++
>  drivers/infiniband/core/umem_dmabuf.c | 105 ++++++++++++++++++++++++++++=
++++++
>  drivers/infiniband/core/umem_dmabuf.h |  11 ++++
>  include/rdma/ib_umem.h                |  14 ++++-
>  5 files changed, 134 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/infiniband/core/umem_dmabuf.c
>  create mode 100644 drivers/infiniband/core/umem_dmabuf.h
>=20
> diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/M=
akefile
> index d1b14887..0d4efa0 100644
> --- a/drivers/infiniband/core/Makefile
> +++ b/drivers/infiniband/core/Makefile
> @@ -37,5 +37,5 @@ ib_uverbs-y :=3D			uverbs_main.o uverbs_cmd.o uverbs_ma=
rshall.o \
>  				uverbs_std_types_mr.o uverbs_std_types_counters.o \
>  				uverbs_uapi.o uverbs_std_types_device.o \
>  				uverbs_std_types_async_fd.o
> -ib_uverbs-$(CONFIG_INFINIBAND_USER_MEM) +=3D umem.o
> +ib_uverbs-$(CONFIG_INFINIBAND_USER_MEM) +=3D umem.o umem_dmabuf.o
>  ib_uverbs-$(CONFIG_INFINIBAND_ON_DEMAND_PAGING) +=3D umem_odp.o
> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/ume=
m.c
> index 82455a1..bf1a6c1 100644
> --- a/drivers/infiniband/core/umem.c
> +++ b/drivers/infiniband/core/umem.c
> @@ -2,6 +2,7 @@
>   * Copyright (c) 2005 Topspin Communications.  All rights reserved.
>   * Copyright (c) 2005 Cisco Systems.  All rights reserved.
>   * Copyright (c) 2005 Mellanox Technologies. All rights reserved.
> + * Copyright (c) 2020 Intel Corporation. All rights reserved.
>   *
>   * This software is available to you under a choice of one of two
>   * licenses.  You may choose to be licensed under the terms of the GNU
> @@ -42,6 +43,7 @@
>  #include <rdma/ib_umem_odp.h>
>=20
>  #include "uverbs.h"
> +#include "umem_dmabuf.h"
>=20
>  static void __ib_umem_release(struct ib_device *dev, struct ib_umem *ume=
m, int dirty)
>  {
> @@ -317,6 +319,8 @@ void ib_umem_release(struct ib_umem *umem)
>  {
>  	if (!umem)
>  		return;
> +	if (umem->is_dmabuf)
> +		return ib_umem_dmabuf_release(umem);
>  	if (umem->is_odp)
>  		return ib_umem_odp_release(to_ib_umem_odp(umem));
>=20
> diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/c=
ore/umem_dmabuf.c
> new file mode 100644
> index 0000000..406ca64
> --- /dev/null
> +++ b/drivers/infiniband/core/umem_dmabuf.c
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> +/*
> + * Copyright (c) 2020 Intel Corporation. All rights reserved.
> + */
> +
> +#include <linux/dma-buf.h>
> +#include <linux/dma-mapping.h>
> +
> +#include "uverbs.h"
> +
> +struct ib_umem_dmabuf {
> +	struct ib_umem	umem;
> +	struct dma_buf	*dmabuf;
> +	struct dma_buf_attachment *attach;
> +	struct sg_table *sgt;
> +};
> +
> +static inline struct ib_umem_dmabuf *to_ib_umem_dmabuf(struct ib_umem *u=
mem)
> +{
> +	return container_of(umem, struct ib_umem_dmabuf, umem);
> +}
> +
> +struct ib_umem *ib_umem_dmabuf_get(struct ib_device *device,
> +				   unsigned long addr, size_t size,
> +				   int dmabuf_fd, int access)
> +{
> +	struct ib_umem_dmabuf *umem_dmabuf;
> +	struct sg_table *sgt;
> +	enum dma_data_direction dir;
> +	long ret;
> +	unsigned long end;
> +
> +	if (check_add_overflow(addr, size, &end))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (unlikely(PAGE_ALIGN(end) < PAGE_SIZE))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (access & IB_ACCESS_ON_DEMAND)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	umem_dmabuf =3D kzalloc(sizeof(*umem_dmabuf), GFP_KERNEL);
> +	if (!umem_dmabuf)
> +		return ERR_PTR(-ENOMEM);
> +
> +	umem_dmabuf->umem.ibdev =3D device;
> +	umem_dmabuf->umem.length =3D size;
> +	umem_dmabuf->umem.address =3D addr;
> +	umem_dmabuf->umem.writable =3D ib_access_writable(access);
> +	umem_dmabuf->umem.is_dmabuf =3D 1;
> +
> +	umem_dmabuf->dmabuf =3D dma_buf_get(dmabuf_fd);
> +	if (IS_ERR(umem_dmabuf->dmabuf)) {
> +		ret =3D PTR_ERR(umem_dmabuf->dmabuf);
> +		goto out_free_umem;
> +	}
> +
> +	umem_dmabuf->attach =3D dma_buf_attach(umem_dmabuf->dmabuf,
> +					     device->dma_device);
> +	if (IS_ERR(umem_dmabuf->attach)) {
> +		ret =3D PTR_ERR(umem_dmabuf->attach);
> +		goto out_release_dmabuf;
> +	}
> +
> +	dir =3D umem_dmabuf->umem.writable ? DMA_BIDIRECTIONAL : DMA_FROM_DEVIC=
E;
> +	sgt =3D dma_buf_map_attachment(umem_dmabuf->attach, dir);
> +	if (IS_ERR(sgt)) {
> +		ret =3D PTR_ERR(sgt);
> +		goto out_detach_dmabuf;
> +	}
> +
> +	umem_dmabuf->sgt =3D sgt;
> +	umem_dmabuf->umem.sg_head =3D *sgt;
> +	umem_dmabuf->umem.nmap =3D sgt->nents;
> +	return &umem_dmabuf->umem;
> +
> +out_detach_dmabuf:
> +	dma_buf_detach(umem_dmabuf->dmabuf, umem_dmabuf->attach);
> +
> +out_release_dmabuf:
> +	dma_buf_put(umem_dmabuf->dmabuf);
> +
> +out_free_umem:
> +	kfree(umem_dmabuf);
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL(ib_umem_dmabuf_get);
> +
> +void ib_umem_dmabuf_release(struct ib_umem *umem)
> +{
> +	enum dma_data_direction dir;
> +	struct ib_umem_dmabuf *umem_dmabuf =3D to_ib_umem_dmabuf(umem);
> +
> +	dir =3D umem_dmabuf->umem.writable ? DMA_BIDIRECTIONAL : DMA_FROM_DEVIC=
E;
> +
> +	/*
> +	 * Only use the original sgt returned from dma_buf_map_attachment(),
> +	 * otherwise the scatterlist may be freed twice due to the map caching
> +	 * mechanism.
> +	 */
> +	dma_buf_unmap_attachment(umem_dmabuf->attach, umem_dmabuf->sgt, dir);
> +	dma_buf_detach(umem_dmabuf->dmabuf, umem_dmabuf->attach);
> +	dma_buf_put(umem_dmabuf->dmabuf);
> +	kfree(umem_dmabuf);
> +}
> diff --git a/drivers/infiniband/core/umem_dmabuf.h b/drivers/infiniband/c=
ore/umem_dmabuf.h
> new file mode 100644
> index 0000000..485f653
> --- /dev/null
> +++ b/drivers/infiniband/core/umem_dmabuf.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
> +/*
> + * Copyright (c) 2020 Intel Corporation. All rights reserved.
> + */
> +
> +#ifndef UMEM_DMABUF_H
> +#define UMEM_DMABUF_H
> +
> +void ib_umem_dmabuf_release(struct ib_umem *umem);
> +
> +#endif /* UMEM_DMABUF_H */
> diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
> index e3518fd..78331ce 100644
> --- a/include/rdma/ib_umem.h
> +++ b/include/rdma/ib_umem.h
> @@ -1,5 +1,6 @@
>  /*
>   * Copyright (c) 2007 Cisco Systems.  All rights reserved.
> + * Copyright (c) 2020 Intel Corporation.  All rights reserved.
>   *
>   * This software is available to you under a choice of one of two
>   * licenses.  You may choose to be licensed under the terms of the GNU
> @@ -40,6 +41,7 @@
>=20
>  struct ib_ucontext;
>  struct ib_umem_odp;
> +struct ib_umem_dmabuf;
>=20
>  struct ib_umem {
>  	struct ib_device       *ibdev;
> @@ -48,6 +50,7 @@ struct ib_umem {
>  	unsigned long		address;
>  	u32 writable : 1;
>  	u32 is_odp : 1;
> +	u32 is_dmabuf : 1;
>  	struct work_struct	work;
>  	struct sg_table sg_head;
>  	int             nmap;
> @@ -78,6 +81,9 @@ int ib_umem_copy_from(void *dst, struct ib_umem *umem, =
size_t offset,
>  unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
>  				     unsigned long pgsz_bitmap,
>  				     unsigned long virt);
> +struct ib_umem *ib_umem_dmabuf_get(struct ib_device *device,
> +				   unsigned long addr, size_t size,
> +				   int dmabuf_fd, int access);
>=20
>  #else /* CONFIG_INFINIBAND_USER_MEM */
>=20
> @@ -100,7 +106,13 @@ static inline int ib_umem_find_best_pgsz(struct ib_u=
mem *umem,
>  					 unsigned long virt) {
>  	return -EINVAL;
>  }
> +static inline struct ib_umem *ib_umem_dmabuf_get(struct ib_device *devic=
e,
> +						 unsigned long addr,
> +						 size_t size, int dmabuf_fd,
> +						 int access)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
>=20
>  #endif /* CONFIG_INFINIBAND_USER_MEM */
> -
>  #endif /* IB_UMEM_H */
> --
> 1.8.3.1

