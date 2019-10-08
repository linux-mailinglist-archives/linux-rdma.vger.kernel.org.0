Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9A2BD01CD
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2019 21:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbfJHT5K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Oct 2019 15:57:10 -0400
Received: from mail-eopbgr50075.outbound.protection.outlook.com ([40.107.5.75]:43330
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729616AbfJHT5J (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Oct 2019 15:57:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcUSoD7DA1aUB8L9EC9nqrEQMusNBuOsetnrdqOhNkb09Y2UjmwN7oZwG1WbhKd0FW689yQ7PIXnA7XWiCNTFaJdnFsqa3bB5Ja9tynIuiKNQegR5m7fAHK1yT6VhmNcAGjY/+ibKrpAJXmYMjupzv/tSF50i/Y3dTtt/NJflWakJiuT9opWmzeBoqr8D2GuVabEi0lyeZTiq09smtTh7uxNJtBdtAiWP1yRW37PdKee05zSulJ6uiNxaem5iRAk9aPmY6j1eYF1gtFOLBzwZQTGIOH6/vjuGRrEQQEP1yekC7rlZEdLbjsFahDBtxp6H5TGmP8yKZbs9Vhu/AG62A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3zQMCxOBnrHM3w2YwQLK/MLMYZ91PctV93ZfZMQeMA=;
 b=N+ifQy57TBqgym+rtnZkJo5GhLGt2yc//umjVFSett6alhKbo4Zy/MWdnC8jEI5JPa48l3nPjtcU9OAnNMcKPtZC/04cMODwmU7PP0fGpq4A7XiEJuTfVV9dp4EV4X6FGpYUU24nO00X2YPFbaLDE8GYCu6e5BHnQJZ4/t8UMuFO2WzQQkIXf3aBMJzgGlglEyeWuIk961w4UjkwGdvYcguuOcId35LB/510t/vdCZZqra5hZsmh1NldIKUhNucJE1uw46qr5u7sOREGDDTMVXQYeJtbqxgLEEzyDrmC1M3A5nKkhEexYYfi46F8Kc8MHdRNWwJ9PZgC9YM66TheBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3zQMCxOBnrHM3w2YwQLK/MLMYZ91PctV93ZfZMQeMA=;
 b=pNWIrkArSMkw35yVTh/S86QmaqyBoOvVk5vT5EVAphobeFYKNPRLRP7YeuWpThDcjncwLRlVgFaHccMsk7DKJU0EMW+PLHALGGz2HUqdnIQH/+xwynONZ32FH7Abc906/H2p5Yf0eUwmCB58EC+tsABC6oU9wL9jLQBFrT4ZNuQ=
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com (52.135.129.16) by
 DB7PR05MB5541.eurprd05.prod.outlook.com (20.177.122.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.23; Tue, 8 Oct 2019 19:57:05 +0000
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::18c2:3d9e:4f04:4043]) by DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::18c2:3d9e:4f04:4043%3]) with mapi id 15.20.2327.023; Tue, 8 Oct 2019
 19:57:05 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: Re: [PATCH rdma-next v2 1/4] IB/mlx5: Introduce ODP diagnostic
 counters
Thread-Topic: [PATCH rdma-next v2 1/4] IB/mlx5: Introduce ODP diagnostic
 counters
Thread-Index: AQHVfF4C06r9wF2Q00iuzj9RDI6vr6dRLF2A
Date:   Tue, 8 Oct 2019 19:57:05 +0000
Message-ID: <20191008195701.GE22714@mellanox.com>
References: <20191006155139.30632-1-leon@kernel.org>
 <20191006155139.30632-2-leon@kernel.org>
In-Reply-To: <20191006155139.30632-2-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YT1PR01CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::21)
 To DB7PR05MB4138.eurprd05.prod.outlook.com (2603:10a6:5:23::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd3aafb3-ad9d-493f-d37e-08d74c29b194
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DB7PR05MB5541:|DB7PR05MB5541:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR05MB554161BB385A5CBCE098EC1FCF9A0@DB7PR05MB5541.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(199004)(189003)(71200400001)(66946007)(256004)(6436002)(71190400001)(66476007)(66446008)(64756008)(86362001)(66556008)(7736002)(305945005)(14444005)(478600001)(25786009)(229853002)(14454004)(6486002)(2906002)(4326008)(6512007)(36756003)(107886003)(6246003)(33656002)(11346002)(2616005)(476003)(446003)(8676002)(81166006)(81156014)(26005)(6916009)(76176011)(316002)(486006)(54906003)(8936002)(3846002)(99286004)(5660300002)(52116002)(102836004)(386003)(6506007)(66066001)(186003)(1076003)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB5541;H:DB7PR05MB4138.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HhAqoADmVMRRDax4/0TSfjgfSx7eUs9Ni65rGPSIG86UN7nXqaV9cl3r6eBtdNiKIvrOFQ5gUI+8vY+eKmrsGKcQ5UzItiWW4vyrEEPHLFRZ76cyJgKzv3grYZXNGt++j6+u50IZ7p7f+An0ruD9bcQUu5CuxuAfYxG4BQR/UkzcEq6Qfi27AH2Io3cumW+rTndvpgnTj3xnm5o7VkWWOLuggjEXWd4X5E8EtggflV3FeNgWHAb+MeC3or4oWqEwtnZaXHUk7ajzyzb79FCixxLSgVHzwm2wlq9tUhNKyZjCiqNbPt3Tj9nGtLSSxPVynvLiOau/LrJzlLZ93oocAQ3W60Q399LWCwMTty610MwkyL+5N34ZQDzqvXBsZBtQV/Wk1q2w6tk9lq+Qrb3/eM0crAnnoNbA0YKF11nj+OU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8C49B06D720B1A4FAD3278C19FEDFCA3@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3aafb3-ad9d-493f-d37e-08d74c29b194
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 19:57:05.7672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 611B/G8cK/ecLFmPDm1HEcOXuJ8+mq9gpMvgpoI44TTG+ZdtaKt/WGcGDSyscxOZ5h5gWSZtNmoKAzT0vPgXMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB5541
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 06, 2019 at 06:51:36PM +0300, Leon Romanovsky wrote:
> From: Erez Alfasi <ereza@mellanox.com>
>=20
> Introduce ODP diagnostic counters and count the following
> per MR within IB/mlx5 driver:
>  1) Page faults:
> 	Total number of faulted pages.
>  2) Page invalidations:
> 	Total number of pages invalidated by the OS during all
> 	invalidation events. The translations can be no longer
> 	valid due to either non-present pages or mapping changes.
>  3) Prefetched pages:
> 	When prefetching a page, page fault is generated
> 	in order to bring the page to the main memory.
> 	The prefetched pages counter will be updated
> 	during a page fault flow only if it was derived
> 	from prefetching operation.
>=20
> Signed-off-by: Erez Alfasi <ereza@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |  4 ++++
>  drivers/infiniband/hw/mlx5/odp.c     | 18 ++++++++++++++++++
>  include/rdma/ib_verbs.h              |  6 ++++++
>  3 files changed, 28 insertions(+)
>=20
> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw=
/mlx5/mlx5_ib.h
> index bf30d53d94dc..5aae05ebf64b 100644
> +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> @@ -585,6 +585,9 @@ struct mlx5_ib_dm {
>  					  IB_ACCESS_REMOTE_READ   |\
>  					  IB_ZERO_BASED)
> =20
> +#define mlx5_update_odp_stats(mr, counter_name, value)		\
> +	atomic64_add(value, &((mr)->odp_stats.counter_name))
> +
>  struct mlx5_ib_mr {
>  	struct ib_mr		ibmr;
>  	void			*descs;
> @@ -622,6 +625,7 @@ struct mlx5_ib_mr {
>  	wait_queue_head_t       q_leaf_free;
>  	struct mlx5_async_work  cb_work;
>  	atomic_t		num_pending_prefetch;
> +	struct ib_odp_counters	odp_stats;
>  };
> =20
>  static inline bool is_odp_mr(struct mlx5_ib_mr *mr)
> diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx=
5/odp.c
> index 95cf0249b015..966783bfb557 100644
> +++ b/drivers/infiniband/hw/mlx5/odp.c
> @@ -261,6 +261,10 @@ void mlx5_ib_invalidate_range(struct ib_umem_odp *um=
em_odp, unsigned long start,
>  				blk_start_idx =3D idx;
>  				in_block =3D 1;
>  			}
> +
> +			/* Count page invalidations */
> +			mlx5_update_odp_stats(mr, invalidations,
> +					      (idx - blk_start_idx + 1));

I feel like these should be batched and the atomic done once at the
end of the routine..

>  		} else {
>  			u64 umr_offset =3D idx & umr_block_mask;
> =20
> @@ -287,6 +291,7 @@ void mlx5_ib_invalidate_range(struct ib_umem_odp *ume=
m_odp, unsigned long start,
> =20
>  	ib_umem_odp_unmap_dma_pages(umem_odp, start, end);
> =20
> +
>  	if (unlikely(!umem_odp->npages && mr->parent &&
>  		     !umem_odp->dying)) {
>  		WRITE_ONCE(umem_odp->dying, 1);
> @@ -801,6 +806,19 @@ static int pagefault_single_data_segment(struct mlx5=
_ib_dev *dev,
>  		if (ret < 0)
>  			goto srcu_unlock;
> =20
> +		/*
> +		 * When prefetching a page, page fault is generated
> +		 * in order to bring the page to the main memory.
> +		 * In the current flow, page faults are being counted.
> +		 * Prefetched pages counter will be updated as well
> +		 * only if the current page fault flow was derived
> +		 * from prefetching flow.
> +		 */
> +		mlx5_update_odp_stats(mr, faults, ret);
> +
> +		if (prefetch)
> +			mlx5_update_odp_stats(mr, prefetched, ret);

Hm, I'm about to post a series that eliminates 'prefetch' here..

This is also not quite right for prefetch as we are doing a form of
prefetching in the mlx5_ib_mr_rdma_pfault_handler() too, although it
is less clear how to count those. Maybe this should be split to SQ/RQ
faults?

Jason
