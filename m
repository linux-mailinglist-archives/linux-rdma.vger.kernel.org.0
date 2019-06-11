Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14D573CABD
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 14:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390106AbfFKMJ5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jun 2019 08:09:57 -0400
Received: from mail-eopbgr60061.outbound.protection.outlook.com ([40.107.6.61]:23011
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387538AbfFKMJ5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Jun 2019 08:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpLquUaVod3NIxVCkG4K5nSz6vnf/zQbssOilLiqE00=;
 b=oYgTws4DckE8UjcCJyTmrsH0TIx4In0a+8u5tbuAh2MRvj5giJvHKvU/BnaJA93ArAvuS0MDM8mt2xYANGozG8uWwoETjQFPK2stjDTmpVpck/MDaEIgcF2TaIf1ZgqiVO/0G6xKY69U4rVKVo6riVbY1id1KJeGeybBdnH58CE=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.186.14) by
 AM4PR05MB3186.eurprd05.prod.outlook.com (10.171.191.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.15; Tue, 11 Jun 2019 12:09:53 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::74f5:6663:e5fa:3d6a]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::74f5:6663:e5fa:3d6a%5]) with mapi id 15.20.1965.017; Tue, 11 Jun 2019
 12:09:53 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH rdma-next v3 05/17] RDMA/counter: Add set/clear per-port
 auto mode support
Thread-Topic: [PATCH rdma-next v3 05/17] RDMA/counter: Add set/clear per-port
 auto mode support
Thread-Index: AQHVHFY1x33be44qWUeq3BFLSyZcS6aWZHYA
Date:   Tue, 11 Jun 2019 12:09:53 +0000
Message-ID: <20190611120950.GK6369@mtr-leonro.mtl.com>
References: <20190606105345.8546-1-leon@kernel.org>
 <20190606105345.8546-6-leon@kernel.org>
In-Reply-To: <20190606105345.8546-6-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR02CA0013.eurprd02.prod.outlook.com
 (2603:10a6:20b:6e::26) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:3::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91e71632-91dc-486d-9962-08d6ee65b5b8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM4PR05MB3186;
x-ms-traffictypediagnostic: AM4PR05MB3186:
x-microsoft-antispam-prvs: <AM4PR05MB318687D97B2CA36D8BA8A634B0ED0@AM4PR05MB3186.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 006546F32A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(366004)(189003)(199004)(86362001)(11346002)(66946007)(9686003)(446003)(53936002)(54906003)(107886003)(6512007)(73956011)(66556008)(66446008)(66476007)(64756008)(476003)(316002)(102836004)(110136005)(68736007)(76176011)(386003)(14444005)(486006)(99286004)(256004)(6246003)(186003)(6506007)(52116002)(26005)(33656002)(2906002)(6636002)(8936002)(5660300002)(71200400001)(71190400001)(3846002)(81156014)(6116002)(14454004)(4326008)(66066001)(25786009)(1076003)(6436002)(478600001)(81166006)(305945005)(7736002)(229853002)(6486002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3186;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8P1O2HiTPI7WJmeie7Ywgdw2AxjZrCSQaMSRfFpLPeTZuuvVSmHLGZBmEfsTMPQHPjtK3jYcYi9tqj3ebeuvfWDkwzScqw17SEDuMJf6+P9RwSydVui3hwO9ncsW3FPjpNQfQNLHj/ObNP9vXR+uHCxrDeClwIJm1hk2e2Lkc7pwPf7CDdz1GZZ1SPhTyeA3qRY68pCbBDZ3iE69I2+W+6n6F55Hj/LqYmHuV5LGPJ+vZSmsam5sKxGL9lHNMrGYlcGQapFogwgQJ66CRrF/G2TJyRvdsowPkMPtGmrwq3Q1ILgNu1A+b6u8NbzEKc+p22MUhU60I+8qcUgNxCJHZ27qQTf0ID3SIw518q7jJKsbY8rs2xAmyw+FGWKe88GxlvU2sJN9rTQf+5BqhumllnljG96WsbCDqxTZ9iwjhFY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <088D0CA7E2F98849914E52E88B206539@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e71632-91dc-486d-9962-08d6ee65b5b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2019 12:09:53.1533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonro@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3186
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 06, 2019 at 01:53:33PM +0300, Leon Romanovsky wrote:
> From: Mark Zhang <markz@mellanox.com>
>
> Add an API to support set/clear per-port auto mode.
>
> Signed-off-by: Mark Zhang <markz@mellanox.com>
> Reviewed-by: Majd Dibbiny <majd@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/Makefile   |  2 +-
>  drivers/infiniband/core/counters.c | 74 ++++++++++++++++++++++++++++++
>  drivers/infiniband/core/device.c   |  7 ++-
>  include/rdma/ib_verbs.h            |  2 +
>  include/rdma/rdma_counter.h        | 24 ++++++++++
>  include/uapi/rdma/rdma_netlink.h   | 26 +++++++++++
>  6 files changed, 133 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/infiniband/core/counters.c
>
> diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/M=
akefile
> index 313f2349b518..cddf748c15c9 100644
> --- a/drivers/infiniband/core/Makefile
> +++ b/drivers/infiniband/core/Makefile
> @@ -12,7 +12,7 @@ ib_core-y :=3D			packer.o ud_header.o verbs.o cq.o rw.o=
 sysfs.o \
>  				device.o fmr_pool.o cache.o netlink.o \
>  				roce_gid_mgmt.o mr_pool.o addr.o sa_query.o \
>  				multicast.o mad.o smi.o agent.o mad_rmpp.o \
> -				nldev.o restrack.o
> +				nldev.o restrack.o counters.o
>
>  ib_core-$(CONFIG_SECURITY_INFINIBAND) +=3D security.o
>  ib_core-$(CONFIG_CGROUP_RDMA) +=3D cgroup.o
> diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core=
/counters.c
> new file mode 100644
> index 000000000000..6cae8bf14997
> --- /dev/null
> +++ b/drivers/infiniband/core/counters.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +/*
> + * Copyright (c) 2019 Mellanox Technologies. All rights reserved.
> + */
> +#include <rdma/ib_verbs.h>
> +#include <rdma/rdma_counter.h>
> +
> +#include "core_priv.h"
> +#include "restrack.h"
> +
> +#define ALL_AUTO_MODE_MASKS (RDMA_COUNTER_MASK_QP_TYPE)
> +
> +static int __counter_set_mode(struct rdma_counter_mode *curr,
> +			      enum rdma_nl_counter_mode new_mode,
> +			      enum rdma_nl_counter_mask new_mask)
> +{
> +	if ((new_mode =3D=3D RDMA_COUNTER_MODE_AUTO) &&
> +	    ((new_mask & (~ALL_AUTO_MODE_MASKS)) ||
> +	     (curr->mode !=3D RDMA_COUNTER_MODE_NONE)))
> +		return -EINVAL;
> +
> +	curr->mode =3D new_mode;
> +	curr->mask =3D new_mask;
> +	return 0;
> +}
> +
> +/**
> + * rdma_counter_set_auto_mode() - Turn on/off per-port auto mode
> + *
> + * When @on is true, the @mask must be set
> + */
> +int rdma_counter_set_auto_mode(struct ib_device *dev, u8 port,
> +			       bool on, enum rdma_nl_counter_mask mask)
> +{
> +	struct rdma_port_counter *port_counter;
> +	int ret;
> +
> +	port_counter =3D &dev->port_data[port].port_counter;
> +	mutex_lock(&port_counter->lock);
> +	if (on) {
> +		ret =3D __counter_set_mode(&port_counter->mode,
> +					 RDMA_COUNTER_MODE_AUTO, mask);
> +	} else {
> +		if (port_counter->mode.mode !=3D RDMA_COUNTER_MODE_AUTO) {
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
> +		ret =3D __counter_set_mode(&port_counter->mode,
> +					 RDMA_COUNTER_MODE_NONE, 0);
> +	}
> +
> +out:
> +	mutex_unlock(&port_counter->lock);
> +	return ret;
> +}
> +
> +void rdma_counter_init(struct ib_device *dev)
> +{
> +	struct rdma_port_counter *port_counter;
> +	u32 port;
> +
> +	if (!dev->port_data)

It should be "if (!dev->ops.alloc_hw_stats || !dev->port_data)",
otherwise mlx4 in SR-IOV crashes while loading mlx4_ib.

Thanks
