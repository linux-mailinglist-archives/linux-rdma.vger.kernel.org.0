Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEF31AD081
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2020 21:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgDPTlh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Apr 2020 15:41:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:22190 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgDPTlg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Apr 2020 15:41:36 -0400
IronPort-SDR: HIanhEREORJaTYHun25AHgQllKzZj1Qe/GWd79aavUv4mry7I5tL0nrWkG4m1mE2GUGZ/G2pQJ
 ILQOXQ/mhy6g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 12:41:36 -0700
IronPort-SDR: +RI4viDJiL5CeAnuVortgOvIrBXaiEYhoQsnMWlJ2j+tZ6LueFl79FMmX8SMbSmzyqT3TI+3+l
 8M9d9hNYcmRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,392,1580803200"; 
   d="scan'208";a="253973394"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga003.jf.intel.com with ESMTP; 16 Apr 2020 12:41:35 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 12:41:35 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 16 Apr 2020 12:41:35 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 16 Apr 2020 12:41:35 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 12:41:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwE9kqkAwT7rD1M0l+GGowdNC0PKK1xL+IYdp6CsHSq4aSIuT2vnB5gVwht7lkFrePu3WUcjR8ocJIyeWKQLdV6gQ1B5tTfoY3HoVVDQbBsZL7ORj7iaLES12wAHXvAo+f1ERsDqpq/XlBDlgyHUL3lrv1/fx7P2SWC84PnBsdAsvuaXOi19fVY11kmi0U1Ayybt6AYtYMeo0ch24DXoLDpnltUwc691nMMQrFob1aMvg5yzFuNKLdVFzxxorJvHbcUeKHmGvaHU7s+zvjlLP6vgLztbPFiXyzVwER9gvkwfIbfn/xPyxYD+Ehl4H9BiDrGKXst6cVPaY9Z0l5fBXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b40uOFXuluwp80zpD1BIiFlc+uw5WIAK9x+0fWJ20VQ=;
 b=ffcw+6fydxcrxqzE1fWQQ0MXF7O+prD3ZZO7G3Z76k6ZFk3ZkafDYdDc/u4KaTzbOk+7pB77mdz75tBYDV71QSeFk7Pt8W+9UNcWEv2B5f1ezTRl536Sru8/KXzseyYqRBal0sVUEUd+jd3/kJaMt5W2150IPxGanNbSl1+DLkBeoMzJ5BUeDbOcWi0O+3+qJcjCTdlkcinfEf4eWr4P9CpBapiZw9cmvRGkWX+KP5/jHZ3LOZCeJjFVaWlSn3f4B7Gmk4BzhnOzynu7u5Nhre7sQ71uKLZijrlV9MQPUweb3XS5XB1bGKp0/YQjYdgGznvrnPpRcC/s1ky1ewbhlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b40uOFXuluwp80zpD1BIiFlc+uw5WIAK9x+0fWJ20VQ=;
 b=MvPflUK2QgG1t7Ho8t88MtPqkEGZFDkcqxi5uFomW4Db+oDysvFRICvQc+StkokxkxxxCEpDcuCyHVWja9xqSD7HcNzlvh+Xr96uqpNlAHlhkTpmTrW8Ko//bxGdmZ6uKqOPESHugrOA2Ji4c4EiYQ64sgHaxLDkswWbIxvU6EI=
Received: from MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24)
 by MW3PR11MB4524.namprd11.prod.outlook.com (2603:10b6:303:2c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Thu, 16 Apr
 2020 19:41:33 +0000
Received: from MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::1916:3bdd:3f40:fd36]) by MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::1916:3bdd:3f40:fd36%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 19:41:33 +0000
From:   "Xiong, Jianxin" <jianxin.xiong@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Leon Romanovsky" <leon@kernel.org>
Subject: RE: [RFC PATCH 1/3] RDMA/umem: Support importing dma-buf as user
 memory region
Thread-Topic: [RFC PATCH 1/3] RDMA/umem: Support importing dma-buf as user
 memory region
Thread-Index: AQHWFBA18200UyEIcUiReZoCYrPtRKh8ChWAgAASxpA=
Date:   Thu, 16 Apr 2020 19:41:33 +0000
Message-ID: <MW3PR11MB4555DDC186D6F5EF30771EB0E5D80@MW3PR11MB4555.namprd11.prod.outlook.com>
References: <1587056973-101760-1-git-send-email-jianxin.xiong@intel.com>
 <1587056973-101760-2-git-send-email-jianxin.xiong@intel.com>
 <20200416180151.GU5100@ziepe.ca>
In-Reply-To: <20200416180151.GU5100@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jianxin.xiong@intel.com; 
x-originating-ip: [73.53.14.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e20dd4b-6f3e-4183-f35b-08d7e23e2b31
x-ms-traffictypediagnostic: MW3PR11MB4524:
x-microsoft-antispam-prvs: <MW3PR11MB4524F2215BF7244214A1EF4CE5D80@MW3PR11MB4524.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4555.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(396003)(376002)(39860400002)(136003)(346002)(366004)(71200400001)(6506007)(186003)(2906002)(5660300002)(33656002)(7696005)(4326008)(26005)(9686003)(55016002)(478600001)(6916009)(86362001)(66446008)(52536014)(64756008)(66946007)(66556008)(8676002)(81156014)(76116006)(316002)(54906003)(8936002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XBchv93vepCxOOR8AmJxeX1fcPlgHHrVtqj0y466Ye/YThuzs8H32ElZKs/KynxVFMHGIOLk0cGCJMzJeCCq4PhVaL8QQ59ZLBpkZhcOkC9cb2qW0wOdsHqnmlh+zcoKCMc75J6UrhNmUE5hA3Hz4o6eq0X8Cxdrn5yzsohRQodJ/wUTh9UO16T9+uL9E3r6gIj470ClphQk2oFqxbXipwt2YOVC3eVpgbMzR6Cu9sCC3xeGAjjsB86lMh2fhpXbPYEj7BEkDhBOLTQqpivw2EJPl5ub7xTjGeOSdC+30gmf3M3YrCclpmDRmGpnfenWy+4w/dHAFOoOublFq3mAeDEINqxsy8kh7TR6euJk8FobdnjVGtZdO/1XgZ6rQ8uHDa80ZgpQIpETdQzGHprZ/ocLQiWIHdr6pXwxvUjbwOBVmM/u4OF6dDON2zIvGGNl
x-ms-exchange-antispam-messagedata: 2k5V0NI5qHLURev1dq3yxCiJb/sN57MNU/ytkLpX3kbd6U54ew+8NtlmIaC20H/lk9FVZnsfVuVg5bEzUNMYvTZgxVbsc+OS6wEtoZcNC6oEc8GBoOd24QIn3JnDzGxuEnZujKQvJzkYb2jpFceNLw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e20dd4b-6f3e-4183-f35b-08d7e23e2b31
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 19:41:33.5483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zM0xEqMrowpCcMxci16qOqsxr70Lb5dt/vbBYBdsJaKvMRbFaqBvb7CHbwjH+lNpdscIQyIjknKaphUlyvWpKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4524
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> > +config INFINIBAND_DMABUF
> > +	bool "InfiniBand dma-buf support"
> > +	depends on INFINIBAND_USER_MEM
>=20
> select ..some kind of DMABUF symbol...

Good catch. Will add the dependency.

>=20
> > +	default n
> > +	help
> > +	  Support for dma-buf based user memory.
> > +	  This allows userspace processes register memory regions
> > +	  backed by device memory exported as dma-buf, and thus
> > +	  enables RDMA operations using device memory.
>=20
> See remarks on the cover letter

Thanks.

> > +struct ib_umem *ib_umem_dmabuf_get(struct ib_device *device,
> > +				   unsigned long addr, size_t size,
> > +				   int dmabuf_fd, int access)
> > +{
> > +	struct ib_umem_dmabuf *umem_dmabuf;
> > +	struct sg_table *sgt;
> > +	enum dma_data_direction dir;
> > +	long ret;
> > +
> > +	if (((addr + size) < addr) ||
> > +	    PAGE_ALIGN(addr + size) < (addr + size))
> > +		return ERR_PTR(-EINVAL);
>=20
> This math validating the user parameters can overflow in various bad ways

This is modeled after the original ib_umem_get() function. Let me see how i=
t can be done better.

>=20
> > +	if (!can_do_mlock())
> > +		return ERR_PTR(-EPERM);
>=20
> Why?

Hmm. Probably not needed.

>=20
> > +	umem_dmabuf->umem.ibdev =3D device;
> > +	umem_dmabuf->umem.length =3D size;
> > +	umem_dmabuf->umem.address =3D addr;
> > +	umem_dmabuf->umem.writable =3D ib_access_writable(access);
> > +	umem_dmabuf->umem.is_dmabuf =3D 1;
> > +	umem_dmabuf->umem.owning_mm =3D current->mm;
>=20
> Why does this need to store owning_mm?

For the mmdrop() call. But again, the mmgrab() and mmdrop() calls are proba=
bly not needed.
=20
>=20
> > +	umem_dmabuf->fd =3D dmabuf_fd;
>=20
> Doesn't need to store fd
>=20

You are right.=20

> > +void ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf) {
> > +	enum dma_data_direction dir;
> > +
> > +	dir =3D umem_dmabuf->umem.writable ? DMA_BIDIRECTIONAL :
> > +DMA_FROM_DEVICE;
> > +
> > +	/*
> > +	 * Only use the original sgt returned from dma_buf_map_attachment(),
> > +	 * otherwise the scatterlist may be freed twice due to the map cachin=
g
> > +	 * mechanism.
> > +	 */
> > +	dma_buf_unmap_attachment(umem_dmabuf->attach, umem_dmabuf->sgt, dir);
> > +	dma_buf_detach(umem_dmabuf->dmabuf, umem_dmabuf->attach);
> > +	dma_buf_put(umem_dmabuf->dmabuf);
> > +	mmdrop(umem_dmabuf->umem.owning_mm);
> > +	kfree(umem_dmabuf);
> > +}
> > +EXPORT_SYMBOL(ib_umem_dmabuf_release);
>=20
> Why is this an EXPORT_SYMBOL?

It is called from ib_umem_release() which is in a different file.

>=20
> > diff --git a/include/rdma/ib_umem_dmabuf.h
> > b/include/rdma/ib_umem_dmabuf.h new file mode 100644 index
> > 0000000..e82b205
> > +++ b/include/rdma/ib_umem_dmabuf.h
>=20
> This should not be a public header
>=20

It's put there to be consistent with similar headers such as "ib_umem_odp.h=
". Can be changed.

> > @@ -0,0 +1,50 @@
> > +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
> > +/*
> > + * Copyright (c) 2020 Intel Corporation. All rights reserved.
> > + */
> > +
> > +#ifndef IB_UMEM_DMABUF_H
> > +#define IB_UMEM_DMABUF_H
> > +
> > +#include <linux/dma-buf.h>
> > +#include <rdma/ib_umem.h>
> > +#include <rdma/ib_verbs.h>
> > +
> > +struct ib_umem_dmabuf {
> > +	struct ib_umem	umem;
> > +	int		fd;
> > +	struct dma_buf	*dmabuf;
> > +	struct dma_buf_attachment *attach;
> > +	struct sg_table *sgt;
>=20
> Probably the ib_umem should be changed to hold a struct sg_table. Not cle=
ar to me why dma_buf wants to allocate this as a pointer..

ib_umem does hold a structure sg_table. The pointer field here is needed to=
 avoid double free when the dma-buf is unmapped and detached. The internal =
caching mechanism of dma-buf checks the value of sgt itself to determine if=
 a sg table needs to be freed at the time of unmapping or detaching. Passin=
g the address of the sg table structure of ib_umem would lead to double fre=
e.=20

>=20
> Also this can be in umem_dmabuf.c
>=20
> > +static inline struct ib_umem_dmabuf *to_ib_umem_dmabuf(struct ib_umem
> > +*umem) {
> > +	return container_of(umem, struct ib_umem_dmabuf, umem); }
>=20
> Put in ummem_dmabuf.c

Will do.

>=20
> > +
> > +#ifdef CONFIG_INFINIBAND_DMABUF
> > +
> > +struct ib_umem *ib_umem_dmabuf_get(struct ib_device *device,
> > +				   unsigned long addr, size_t size,
> > +				   int dmabuf_fd, int access);
> > +
> > +void ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf);
> > +
> > +#else /* CONFIG_INFINIBAND_DMABUF */
> > +
> > +static inline struct ib_umem *ib_umem_dmabuf_get(struct ib_device *dev=
ice,
> > +						 unsigned long addr,
> > +						 size_t size, int dmabuf_fd,
> > +						 int access)
> > +{
> > +	return ERR_PTR(-EINVAL);
> > +}
>=20
> This should be in the existing ib_umem.h
>=20

Good. Thanks.

> > +
> > +static inline void ib_umem_dmabuf_release(struct ib_umem_dmabuf
> > +*umem_dmabuf) { }
>=20
> In uverbs_priv.h
>=20

Will do.

> Jason
