Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 756C2D31B1
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2019 21:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbfJJTto (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Oct 2019 15:49:44 -0400
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:11202
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725867AbfJJTto (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Oct 2019 15:49:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdR0k4bKOloEmC3qJyRteclHiseuy74e28QbVZPwgOq5z39S7OTNnALwvp74JbQr46rDo3KExgRgJzM9FmjMiMyF9AQYMqNukr2Nm8vOsts2Pzn6fmjwdC7Pditwc255tmqwHcVxJcLZ5LK5drKHV8rwONG950Io5cSFaUrnHYw9ReWkRf+Y2xKVSc6O+lI+fmei81Y9FpPfC+KI1YOCq1dmRMJjPneWm1oLLzNJxxdsEJ6zqHKaLGlZMTEMEkb/XU2EYRyIG1TpupERJXBmQs6qVVgx2soHpqHK4xKtzxbvnj5dSEHKEy60+lNDJuu2zM+hllriN+qwWcEl4V01hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sw5ZM0kxZCjHsoquq1YkA8bkl+6zrLVR4d7fW3D8pGM=;
 b=gOMGeLTrismpSjO3gYfnlg7Jl4IpKeElr1htIslxEgQg1FD5ZwpjYxtzOPxkH9O1Won6jUTwvpE+kes2sTtS6mYl5tqgxk6LdXJQQUPYnOmovfiwuBV+hZhO6D/RMJgDlh/ypLdQcd1tDRG2117DL7jKbyggynNhOY8V9oWsWx0ynGf2MfCCfq9qV6+Lb86DfiU0ZLFePA4r12+CWwf0GHZYGNBjq17cEVsDUpaKwT8czvbXd1lQSETH3VVnGQ0fenBpRLm85o4eo7/cvS3WAdDuSte2T8X0scvUQksDQsO3mlnfb8NEt1m9K++7DGxNMkzBL/pave+8MJRibwD9xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sw5ZM0kxZCjHsoquq1YkA8bkl+6zrLVR4d7fW3D8pGM=;
 b=Mo5WCyiTVPI0zIIUVJlKcWThclsmjcfQ6mwRJOpjyvZww79okgSgZH+sLQ0Ib7XUlnEy9wNGW+R21ddO59SZY0G4KjiND8vVSuhDq4fIA3CRFccYe8L2Kk83Q7ZwB83D3RBN3z6FdJqrlkzncGdJDtVga5U8d3KShednyKadoYU=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB3183.eurprd05.prod.outlook.com (10.170.237.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Thu, 10 Oct 2019 19:49:40 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0%7]) with mapi id 15.20.2347.016; Thu, 10 Oct 2019
 19:49:40 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: Re: [PATCH rdma-next v2 1/4] IB/mlx5: Introduce ODP diagnostic
 counters
Thread-Topic: [PATCH rdma-next v2 1/4] IB/mlx5: Introduce ODP diagnostic
 counters
Thread-Index: AQHVfF4C06r9wF2Q00iuzj9RDI6vr6dRLF2AgAJtqoCAALTtAA==
Date:   Thu, 10 Oct 2019 19:49:40 +0000
Message-ID: <20191010194936.GI11569@mellanox.com>
References: <20191006155139.30632-1-leon@kernel.org>
 <20191006155139.30632-2-leon@kernel.org>
 <20191008195701.GE22714@mellanox.com> <20191010090203.GJ5855@unreal>
In-Reply-To: <20191010090203.GJ5855@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR17CA0024.namprd17.prod.outlook.com
 (2603:10b6:208:15e::37) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12f0cafa-3b0f-4736-fb2a-08d74dbafcf8
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR05MB3183:|VI1PR05MB3183:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB318338DACB684BBAC9AE55BBCF940@VI1PR05MB3183.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39850400004)(136003)(346002)(366004)(376002)(199004)(189003)(6506007)(99286004)(102836004)(66066001)(54906003)(33656002)(1076003)(14454004)(386003)(316002)(8676002)(305945005)(52116002)(81156014)(81166006)(86362001)(8936002)(76176011)(186003)(256004)(486006)(7736002)(14444005)(476003)(25786009)(6486002)(6916009)(6436002)(11346002)(71190400001)(71200400001)(229853002)(66556008)(5660300002)(64756008)(66446008)(2616005)(478600001)(66946007)(36756003)(4326008)(26005)(66476007)(2906002)(6116002)(6512007)(3846002)(6246003)(107886003)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3183;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +PExCk+W9aAN2Ofd2izLhAyAhu2E1ejZGF/ISvhnsGlc289zfhQiTaYdXIFbYhjDlUNw8gOrYosbp9PQoHhrtO51bqXnom5zC4bAdFEhb7026LeTyu4qJzxiXHmRgSwovvl11xWQsSFWblH9lEs7EE6igp6+Qjc1Tx56zs8+D98C6uYw7lUSK4sAONlF69U50KyhHr7UwugQ0l6VFGbewpuk2qw7MoG6RdHChkVV4qVxTBZwV0yMZ1qMQq4N+8njqRKvJjTcq1BYLEA6NA+E+Q+y7GjkGAui6WFsUTX9au8Jqz0GOeJmbZ4/9NmUyVosC9uLEZM5DNleoRc59FE2CuZvZi6OoqJ6QnFRuA8EJqDrno3FtSaFLbM2eDZYrcuAqMZWKMnBDzh83yaMsbl84fbmh0s8QNEIfbOEM/QLCeA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F63212729ABA82408FC4BC8547844DBD@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f0cafa-3b0f-4736-fb2a-08d74dbafcf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 19:49:40.1215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S7gfq0tPPsVYso8R577DfyRKSOlRj2c+lw7t8mvzVBxSyssm9+aSSjvVf0jVKrmhIgcF7SJVjHQuH7r/7esngg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3183
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 10, 2019 at 12:02:03PM +0300, Leon Romanovsky wrote:

> > >  static inline bool is_odp_mr(struct mlx5_ib_mr *mr)
> > > diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw=
/mlx5/odp.c
> > > index 95cf0249b015..966783bfb557 100644
> > > +++ b/drivers/infiniband/hw/mlx5/odp.c
> > > @@ -261,6 +261,10 @@ void mlx5_ib_invalidate_range(struct ib_umem_odp=
 *umem_odp, unsigned long start,
> > >  				blk_start_idx =3D idx;
> > >  				in_block =3D 1;
> > >  			}
> > > +
> > > +			/* Count page invalidations */
> > > +			mlx5_update_odp_stats(mr, invalidations,
> > > +					      (idx - blk_start_idx + 1));
> >
> > I feel like these should be batched and the atomic done once at the
> > end of the routine..
>=20
> We can, but does it worth it?

Probably since it is so simple, atomics are very expensive

> For various reasons we are delaying this series for months already.
> Let's drop "prefetch" counter for now and merge everything without
> it.

OK, I guess the counters are extendible as we go along, however see below:

> > This is also not quite right for prefetch as we are doing a form of
> > prefetching in the mlx5_ib_mr_rdma_pfault_handler() too, although it
> > is less clear how to count those. Maybe this should be split to SQ/RQ
> > faults?
>=20
> mlx5_ib_mr_rdma_pfault_handler() calls to pagefault_single_data_segment()
> without MLX5_PF_FLAGS_PREFETCH, so I'm unsure that this counter should
> count mlx5_ib_mr_rdma_pfault_handler() pagefaults.
>=20
> However the idea to separate SQ/RQ for everything sounds appealing.

Let's at least have a well defined counter design. SQ/RQ seems like a
good split to me as they have quite different behavior on mlx5
hardware, so splitting the existing counter seems good anyhow

Jason
