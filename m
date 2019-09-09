Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54885AD51A
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2019 10:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388728AbfIIIwe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Sep 2019 04:52:34 -0400
Received: from mail-eopbgr20050.outbound.protection.outlook.com ([40.107.2.50]:15094
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727390AbfIIIwe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 9 Sep 2019 04:52:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpxixjV93caPBNHSJol1PigX3liKpRi+HIdXh1W5gY5q227usduf/gldW6J9qSaOYIyaVIkPlzKrXZkcQb1jadub/W/Q5DqaNViM7H26VU5wsxocvQwsaAUPYKDF5kYMqmOKdXLyVNzZhjpVGs60nx1GT4ttC8nBSPlczlrimz5vNm7daGL5AGmxtB8d2wxHabGDNAvOf0PBqfR+F4QWKhyfLpwM7R0WpYKgCI7ik1B0RBaDYpNczRWfXbU88uS5zDe6D5P2N4gvPr6VeNwhXfJpwoBLv2b4vcoUpJD/bOVh2j+iW9sWnp0NGlZHpVBwRIdLz7BJk53Oigmm6lbnxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wd0o5SKJJUZiGSSe7u8Ydkdbm+x/tg+IUZg98+lXe8Q=;
 b=NorLoPjp5TS+HKI8cXanWJtX22ztoD1ErCGT/YnZMoiLdHDnLz2Et76UldZqI6d0q7KpJCcS3aikvbCb3U57GHUn17wUwMxSA+R+bExy1i14juF3pobCfs36ITf2kC2vWlMEbiK+WQFEAYstevYNrzWRXpiaMzmjU46bihacOvO9YUY8mw7YhPELxFCb1SP5FSagB5KbwrCnbcFvr3l/pV820Nw80Vlmpb2kjN7vKE6wVJ0Im2SkN0XnNva2F7HJDBDtfYW9i//j2fEpf1d094+LWT2sE+zR+mLY2hWvCtiB1dB0kQS/hylqD8Vfgd9W24JRrU+3SLUfcAgzJuat4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wd0o5SKJJUZiGSSe7u8Ydkdbm+x/tg+IUZg98+lXe8Q=;
 b=f/+TAbb8yyn6gOE//6VBUpueTCc4EaF0XRP1GmOv4GRTfxbvGIAJlSypXQbIvrVqL2ZSINBqF14b+8ZSOUlJCMnuQ2Pt+kDXOwPdkiAqvPTvPghkXGVKJIM9ktXPxPRHf8kFNnbE+8x2jgtiwav/dVqHQqrsxWwvd2c09aM980A=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4703.eurprd05.prod.outlook.com (20.176.4.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Mon, 9 Sep 2019 08:51:50 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f%7]) with mapi id 15.20.2241.018; Mon, 9 Sep 2019
 08:51:50 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: Re: [PATCH rdma-next v1 3/4] RDMA/nldev: Provide MR statistics
Thread-Topic: [PATCH rdma-next v1 3/4] RDMA/nldev: Provide MR statistics
Thread-Index: AQHVXws6cFgL7Kd85EqSjLNj/9TCy6cjGYoA
Date:   Mon, 9 Sep 2019 08:51:50 +0000
Message-ID: <20190909085148.GD2843@mellanox.com>
References: <20190830081612.2611-1-leon@kernel.org>
 <20190830081612.2611-4-leon@kernel.org>
In-Reply-To: <20190830081612.2611-4-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MR2P264CA0089.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:32::29) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [148.69.85.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dea03123-9cad-400a-8731-08d73502f48c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4703;
x-ms-traffictypediagnostic: VI1PR05MB4703:|VI1PR05MB4703:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB470313C4525522E0669E96DCCFB70@VI1PR05MB4703.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:751;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(186003)(14454004)(5660300002)(33656002)(6506007)(386003)(316002)(54906003)(76176011)(52116002)(6486002)(99286004)(229853002)(6436002)(478600001)(25786009)(26005)(1076003)(6916009)(14444005)(256004)(102836004)(3846002)(6116002)(53936002)(8676002)(6512007)(81166006)(81156014)(7736002)(107886003)(476003)(8936002)(2616005)(6246003)(4326008)(36756003)(86362001)(66066001)(71200400001)(71190400001)(486006)(66476007)(66946007)(11346002)(305945005)(66446008)(64756008)(2906002)(66556008)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4703;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 73n118JQjWmVytvvaum6mn93sd5D5QaaBFfsYrtbQe4Jh3/azxPnltWTDbE5fGYkXQ+7JipWMhV/8XSqLeaH948LAtyE5MJ7gVpCu24HgiJuhjRWY5IFLSl+f9eQxRvAzOcdCx1RXqSflPvRjEkZHDqkK7+S6RawKB0DOUJA9YP0A4pgAkAnGvjUtXEMbx6+4Hqst61oMxcdXb03dxiPdLyQYBPJLe6iBpHgipcLWUWLnz9Jw7GASmJAioefM+gTt6RwHSy+eL+z4gR1touJP6at4/48LfwvfLV6tJJDG9bqJlhIs02q/TtsyDfbUm7moRO89FzSBymiYB2S3ZYb1P9PVDmPIEz+h3AnIi3Pa/6NVZ4fQdxvVIo63itgNJ+Ibb5nYQcWcvADRnbLBQjNXTu2SjEd6oCIEnvvN3kV0hM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <71BF2758FFD99047BE234C3178F68FA4@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dea03123-9cad-400a-8731-08d73502f48c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 08:51:50.6600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ImAJdEPsUryHzD9IHAUAsnmmbL3+imOp6oHATC0qHuKJesBKjbd8QKGoYl83gKCctbyjU7oFxiHIlUr4i+YUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4703
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 30, 2019 at 11:16:11AM +0300, Leon Romanovsky wrote:
> From: Erez Alfasi <ereza@mellanox.com>
>=20
> Add RDMA nldev netlink interface for dumping MR
> statistics information.
>=20
> Output example:
> ereza@dev~$: ./ibv_rc_pingpong -o -P -s 500000000
>   local address:  LID 0x0001, QPN 0x00008a, PSN 0xf81096, GID ::
>=20
> ereza@dev~$: rdma stat show mr
> dev mlx5_0 mrn 2 page_faults 122071 page_invalidations 0
> prefetched_pages 122071
>=20
> Signed-off-by: Erez Alfasi <ereza@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/core/device.c  |  1 +
>  drivers/infiniband/core/nldev.c   | 54 +++++++++++++++++++++++++++++--
>  drivers/infiniband/hw/mlx5/main.c | 16 +++++++++
>  include/rdma/ib_verbs.h           |  9 ++++++
>  4 files changed, 78 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/d=
evice.c
> index 99c4a55545cf..34a9e37c5c61 100644
> +++ b/drivers/infiniband/core/device.c
> @@ -2610,6 +2610,7 @@ void ib_set_device_ops(struct ib_device *dev, const=
 struct ib_device_ops *ops)
>  	SET_DEVICE_OP(dev_ops, get_dma_mr);
>  	SET_DEVICE_OP(dev_ops, get_hw_stats);
>  	SET_DEVICE_OP(dev_ops, get_link_layer);
> +	SET_DEVICE_OP(dev_ops, fill_odp_stats);
>  	SET_DEVICE_OP(dev_ops, get_netdev);
>  	SET_DEVICE_OP(dev_ops, get_port_immutable);
>  	SET_DEVICE_OP(dev_ops, get_vector_affinity);

I'm now curious what motivated placing the line here, apparently
randomly in a sorted list?

> +static int fill_stat_mr_entry(struct sk_buff *msg, bool has_cap_net_admi=
n,
> +			      struct rdma_restrack_entry *res, uint32_t port)
> +{
> +	struct ib_mr *mr =3D container_of(res, struct ib_mr, res);
> +	struct ib_device *dev =3D mr->pd->device;
> +	struct ib_odp_counters odp_stats;
> +	struct nlattr *table_attr;
> +
> +	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_MRN, res->id))
> +		goto err;
> +
> +	if (!dev->ops.fill_odp_stats)
> +		return 0;
> +
> +	if (!dev->ops.fill_odp_stats(mr, &odp_stats))
> +		return 0;

As Parav says this seems to be wrong for !ODP MRs. Can we even detect
!ODP at this point?

> +
> +	table_attr =3D nla_nest_start(msg,
> +				    RDMA_NLDEV_ATTR_STAT_HWCOUNTERS);
> +
> +	if (!table_attr)
> +		return -EMSGSIZE;
> +
> +	if (fill_stat_hwcounter_entry(msg, "page_faults",
> +				      (u64)atomic64_read(&odp_stats.faults)))

Why the cast?


> +static bool mlx5_ib_fill_odp_stats(struct ib_mr *ibmr,
> +				   struct ib_odp_counters *cnt)
> +{
> +	struct mlx5_ib_mr *mr =3D to_mmr(ibmr);
> +
> +	if (!is_odp_mr(mr))
> +		return false;
> +
> +	memcpy(cnt, &to_ib_umem_odp(mr->umem)->odp_stats,
> +	       sizeof(struct ib_odp_counters));

Can't memcpy atomic64, have to open code a copy using atomic64_read.

> @@ -6316,6 +6331,7 @@ static const struct ib_device_ops mlx5_ib_dev_ops =
=3D {
>  	.get_dev_fw_str =3D get_dev_fw_str,
>  	.get_dma_mr =3D mlx5_ib_get_dma_mr,
>  	.get_link_layer =3D mlx5_ib_port_link_layer,
> +	.fill_odp_stats =3D mlx5_ib_fill_odp_stats,

Randomly again..

Jason
