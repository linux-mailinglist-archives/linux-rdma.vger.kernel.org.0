Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF8ACAD509
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2019 10:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389488AbfIIIpl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Sep 2019 04:45:41 -0400
Received: from mail-eopbgr60046.outbound.protection.outlook.com ([40.107.6.46]:55862
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726302AbfIIIpl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 9 Sep 2019 04:45:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRb4+OQy//eCz7WXdVNxjMaYKCc9Xyzxmul3rHf70HaYC2gGupyQ2BM0vUsBkKNKr97+zqUocjjRDwpsco2k8BDWUjKhyhdL9ioxjbtPLTJ+belVe5cfkFz83i/WT/L3148F80GFOn2i0hJJ0NZ7SeUo79WC9y4dEpFmg2R2NnuiiE50eNvdOWxU0f4MZizsksp306/G8IK5y7GiYR/eQsbE6Idyrp0hy5xvq1iQB4Sz/TAVKTp0BOoT4mEeCibhSp3IlEDyxjsPnntYzcpHryMi2YlgTYLIwMMgddObnJaPQN//YA83uH0ogOg0CULeePSHdQowbl6e1UexBPzrmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHGsjkiKHiqIY3368aEa0tRg+VDxyPO6VvyqIZbxJRA=;
 b=I34p/Otzo9zVaJ7XeptAcLp86PkBo6H0oNzbJBEUYTPQniwC+igqNeG384VTNP48KJ3Kya4mn5hc7haXN4nqsXR0fVDigsEvBHlc4ifDrfSPVI0QkNw+UCQiGzUabcaakp89mN6WB3a0ZTyLy/r2ZejGCDP4p5ZLs/IYVrZTJkfij0UoaUCTrl1jLoY/OQi8csXU7NDAI/tWkDKZbTYzY3p5SllEEC9tSbWpogHc/Wid+tTum+sJVb4WBQrLcI5RqIu7mhl5Nvyb7NZaKthgAG4Of8KAKw0J6OwOdL70Smv93EnvLS9amMD1MlnTQhYGMIe4AtV7Kd2PmzxqOrBsHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHGsjkiKHiqIY3368aEa0tRg+VDxyPO6VvyqIZbxJRA=;
 b=HWRWXVHJJjd0iNNE4DON13ado78ujJoDGzW7ryUeddVZ7B89PdhTk+skQkgNpmqAVQmDh/5ZR2eUuhGQC/1MxPZZEK2vAITGzDchaBUW48O1ZVqbSUhtQqpQHU4EJE0yTINFtN8HSaM4tEWVkXRFCLUh06YKRvdewbgzL9pmUII=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6575.eurprd05.prod.outlook.com (20.179.25.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.19; Mon, 9 Sep 2019 08:45:37 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f%7]) with mapi id 15.20.2241.018; Mon, 9 Sep 2019
 08:45:37 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: Re: [PATCH rdma-next v1 1/4] IB/mlx5: Introduce ODP diagnostic
 counters
Thread-Topic: [PATCH rdma-next v1 1/4] IB/mlx5: Introduce ODP diagnostic
 counters
Thread-Index: AQHVXws34+PmbRzEv0eiqY4pwz3WIqcjF86A
Date:   Mon, 9 Sep 2019 08:45:36 +0000
Message-ID: <20190909084535.GB2843@mellanox.com>
References: <20190830081612.2611-1-leon@kernel.org>
 <20190830081612.2611-2-leon@kernel.org>
In-Reply-To: <20190830081612.2611-2-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MR2P264CA0107.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:33::23) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [148.69.85.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4374dfd-19f8-40b7-ae22-08d7350215c3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6575;
x-ms-traffictypediagnostic: VI1PR05MB6575:|VI1PR05MB6575:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB6575B1C8F29D6F0A070A5CA9CFB70@VI1PR05MB6575.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(199004)(189003)(8936002)(52116002)(26005)(66066001)(5660300002)(6916009)(476003)(229853002)(25786009)(478600001)(86362001)(81156014)(81166006)(8676002)(1076003)(11346002)(7736002)(6512007)(186003)(107886003)(2906002)(66946007)(66476007)(66446008)(6246003)(14454004)(66556008)(54906003)(316002)(446003)(64756008)(99286004)(76176011)(71190400001)(71200400001)(6486002)(53936002)(3846002)(6116002)(4326008)(102836004)(33656002)(305945005)(386003)(6436002)(256004)(36756003)(2616005)(486006)(6506007)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6575;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TOdzEoHua6vmqPYrC0A3YHYe/i9npCUvPPyqBbnUKTcpgKYOpSxIJ93cFgomKC7RRC3oqo5A8ugHfjTKBvoK2JPYKIoM47IpdDwPB4LKVkHcZmWyV9lR+t/T3VLFH0xmp2Tvx69GLdHLZJOMrVOXXb8HUMntn1Zm9tSMpd/kFxj9xftGCCRx9NOhPXxH0A0chVOmHoJEruZRO4B77amW48ziOXF4Yxw1Pw5jbWIJ8ChcNWHB5jwnyEcthQVCYRrcFjHj0ML5enWsktezUm255Ip+O5TDwoB6/gsyyT9pTrufOtFZwVdHmAVTZdcZqpVma/FuMTKwZ7pJjOr7YGHwydoY8w74Y8weiXerwotgmwDTxAOY8WKKSnJPxKdwYYym/rvVD3IhQ0AAz0LqNWstu5b49h+lYdXVb7K82ORG8QY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FF9D92D1DD4FBE4D9DECE74C051D8351@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4374dfd-19f8-40b7-ae22-08d7350215c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 08:45:37.0894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /sukzsQviB+UzYT78Jpvu043n39+Y5hZ4oZjEPzcs7qXIFTWor3XinWqa8+FpfQvCVGMwQAXRsJN52Do7SWspg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6575
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 30, 2019 at 11:16:09AM +0300, Leon Romanovsky wrote:
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
>  drivers/infiniband/hw/mlx5/odp.c | 18 ++++++++++++++++++
>  include/rdma/ib_umem_odp.h       | 14 ++++++++++++++
>  2 files changed, 32 insertions(+)
>=20
> diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx=
5/odp.c
> index 905936423a03..b7c8a49ac753 100644
> +++ b/drivers/infiniband/hw/mlx5/odp.c
> @@ -287,6 +287,10 @@ void mlx5_ib_invalidate_range(struct ib_umem_odp *um=
em_odp, unsigned long start,
> =20
>  	ib_umem_odp_unmap_dma_pages(umem_odp, start, end);
> =20
> +	/* Count page invalidations */
> +	ib_update_odp_stats(umem_odp, invalidations,
> +			    ib_umem_odp_num_pages(umem_odp));

This doesn't seem right, it should only count the number of pages that
were actually removed from the mapping

> diff --git a/include/rdma/ib_umem_odp.h b/include/rdma/ib_umem_odp.h
> index b37c674b7fe6..3359e34516da 100644
> +++ b/include/rdma/ib_umem_odp.h
> @@ -37,6 +37,12 @@
>  #include <rdma/ib_verbs.h>
>  #include <linux/interval_tree.h>
> =20
> +struct ib_odp_counters {
> +	atomic64_t faults;
> +	atomic64_t invalidations;
> +	atomic64_t prefetched;
> +};
> +
>  struct ib_umem_odp {
>  	struct ib_umem umem;
>  	struct ib_ucontext_per_mm *per_mm;
> @@ -62,6 +68,11 @@ struct ib_umem_odp {
>  	struct mutex		umem_mutex;
>  	void			*private; /* for the HW driver to use. */
> =20
> +	/*
> +	 * ODP diagnostic counters.
> +	 */
> +	struct ib_odp_counters odp_stats;

This really belongs in the MR not the umem

>  	int notifiers_seq;
>  	int notifiers_count;
>  	int npages;
> @@ -106,6 +117,9 @@ static inline size_t ib_umem_odp_num_pages(struct ib_=
umem_odp *umem_odp)
>  	       umem_odp->page_shift;
>  }
> =20
> +#define ib_update_odp_stats(umem_odp, counter_name, value)		    \
> +	atomic64_add(value, &(umem_odp->odp_stats.counter_name))

Missing brackets in a macro

Jason
