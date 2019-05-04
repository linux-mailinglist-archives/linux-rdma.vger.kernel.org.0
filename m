Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF21D136A4
	for <lists+linux-rdma@lfdr.de>; Sat,  4 May 2019 02:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbfEDAov (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 May 2019 20:44:51 -0400
Received: from mail-eopbgr130059.outbound.protection.outlook.com ([40.107.13.59]:54190
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726059AbfEDAov (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 3 May 2019 20:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBo3deXT5f5a6aQhkW9QTwt8kNxvH9FJprL1bNkKg0U=;
 b=iw+/42SKX3kb2eRbmSYH0BNS+PelUc94boMBQ5eBtG9mfzcIlNYUA5TkgN7mJBzf3M/0i58ZKLA0PNZBJYhCbj4t/jXvKudJtLoQr1X7Va8x71wZ5dUu2IcARa28n9AHwW9I1L599tad3UfsRzS0hbdq7t99POQ90EhmYXuyho0=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5200.eurprd05.prod.outlook.com (20.178.12.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Sat, 4 May 2019 00:44:46 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1856.008; Sat, 4 May 2019
 00:44:46 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Huy Nguyen <huyn@mellanox.com>, Martin Wilck <mwilck@suse.com>,
        Parav Pandit <parav@mellanox.com>
Subject: Re: [PATCH rdma-next v2 0/7] Allow RoCE GID attribute netdev
 detachment
Thread-Topic: [PATCH rdma-next v2 0/7] Allow RoCE GID attribute netdev
 detachment
Thread-Index: AQHVALtoigFZtXFsNEaBgQ/I0vM1taZaI6eA
Date:   Sat, 4 May 2019 00:44:46 +0000
Message-ID: <20190504004441.GA8449@mellanox.com>
References: <20190502074807.26566-1-leon@kernel.org>
In-Reply-To: <20190502074807.26566-1-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR01CA0035.prod.exchangelabs.com (2603:10b6:208:10c::48)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [65.119.211.164]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cea7b33-f45d-43b7-1cc9-08d6d029b44f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5200;
x-ms-traffictypediagnostic: VI1PR05MB5200:
x-microsoft-antispam-prvs: <VI1PR05MB52006B5DF98244870D06D48CCF360@VI1PR05MB5200.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0027ED21E7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(136003)(396003)(366004)(189003)(199004)(54534003)(25786009)(486006)(2616005)(66066001)(6512007)(99286004)(68736007)(53936002)(229853002)(107886003)(33656002)(6246003)(4326008)(2906002)(36756003)(3846002)(6116002)(86362001)(73956011)(26005)(66476007)(66556008)(54906003)(66946007)(186003)(6506007)(386003)(11346002)(66446008)(316002)(305945005)(64756008)(476003)(81166006)(81156014)(7736002)(102836004)(8676002)(1076003)(478600001)(6486002)(6436002)(71200400001)(71190400001)(5660300002)(6916009)(256004)(14444005)(5024004)(52116002)(14454004)(76176011)(8936002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5200;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gC1nh9hgedxr4gQM+cZpYqz0YcAg3OMb/bObj0AbxwI1844BDexWhGWqyukOCxMZL5T6/VRL3fSwJjrZq+zjJUexoiZLZaPGQz12iNv/n1Z4UwRJOIK6YZjoHjHoipPBlMhP2QpGXc8g5Ns5RG17nBZEqgv26dU00ETdPEgp3kE93fp/wjapy76f1M1fi9PtA34FDAE4IbzowctNn/44rFYj7xcWWsRxCNmlENOaxb5RAz6eyfU5nR3yBIfoakKwQ8JKyM5GUhVZX7GFTd0omgKZjrQJK2o/usBwjvjKPq/V9iRqtSQZD2s5+iZSgrrX6AXsps6kThJKHQPAijQL/+NYxoezkOVc4VEWjZzuSfmww82i97FK2D6Wr/yPtyzMeykEsf5YJBW33Z9txhqvEl9NzsHxMRpbQbjI0dZ2YpU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <59EA98E8F9D4A9449297996AD3BC0C47@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cea7b33-f45d-43b7-1cc9-08d6d029b44f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2019 00:44:46.0336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5200
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 02, 2019 at 10:48:00AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>=20
> Changelog:
>  v1 -> v2:
>  * Resent
>  v0 -> v1:
>  * Fixed wrong RCU pointer access in patch "RDMA/core: Allow detaching
>    gid attribute netdevice for RoCE"
>=20
> -----------------------------------------------------------------------
>=20
> >From Parav,
>=20
> This series covers following changes.
>=20
> 1. A fix in RXE to consider right reserved space of the netdev.
> 2. ib_cm to avoid accessing netdev of GID attribute.
> 3. Several RoCE drivers and net/smc needs to know the mac and vlan of
> the GID entry.
>=20
> Instead of open coded accessing netdev fields, we introduce an API
> to get such fields filled up using new API rdma_read_gid_l2_fields().
>=20
> 4. When there is active traffic through a GID, a QP/AH holds reference
> to this GID entry. GID entry holds reference to its attached netdevice.
> Due to this when netdevice (such as vlan netdev) is deleted by admin user=
,
> its refcount is not dropped.
>=20
> Therefore, use netdev under rcu lock so that netdev reference can be
> dropped when netdev and associated RoCE GID entry is deleted. This is
> facilitated by existing API rdma_read_gid_attr_ndev_rcu.
>=20
> Thanks
>=20
>=20
> Parav Pandit (7):
>   RDMA/rxe: Consider skb reserve space based on netdev of GID
>   IB/cm: Reduce dependency on gid attribute ndev check
>   RDMA: Introduce and use GID attr helper to read RoCE L2 fields
>   RDMA/cma: Use rdma_read_gid_attr_ndev_rcu to access netdev
>   RDMA/rxe: Use rdma_read_gid_attr_ndev_rcu to access netdev
>   net/smc: Use rdma_read_gid_l2_fields to L2 fields
>   RDMA/core: Allow detaching gid attribute netdevice for RoCE
>=20
>  drivers/infiniband/core/addr.c             |   1 +
>  drivers/infiniband/core/cache.c            | 117 +++++++++++++++++++--
>  drivers/infiniband/core/cm.c               |   5 +-
>  drivers/infiniband/core/cma.c              |  12 ++-
>  drivers/infiniband/core/sysfs.c            |  13 ++-
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c   |  18 ++--
>  drivers/infiniband/hw/hns/hns_roce_ah.c    |  14 +--
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c |   7 +-
>  drivers/infiniband/hw/mlx4/ah.c            |   8 +-
>  drivers/infiniband/hw/mlx4/qp.c            |   6 +-
>  drivers/infiniband/hw/mlx5/main.c          |  42 ++------
>  drivers/infiniband/hw/ocrdma/ocrdma_ah.c   |   9 +-
>  drivers/infiniband/hw/ocrdma/ocrdma_hw.c   |   7 +-
>  drivers/infiniband/hw/qedr/qedr_roce_cm.c  |  11 +-
>  drivers/infiniband/hw/qedr/verbs.c         |   5 +-
>  drivers/infiniband/sw/rxe/rxe_net.c        |  18 +++-
>  include/rdma/ib_cache.h                    |   4 +
>  include/rdma/ib_verbs.h                    |   2 +-
>  net/smc/smc_ib.c                           |  16 +--
>  19 files changed, 221 insertions(+), 94 deletions(-)

Now that we have the RCU pointer in the gid_attr it is really ugly
that the onstack version and the pointer version are the same type,
this needs a cleanup to add some kind of gid_attr_init structure
instead

But otherwise applied to for-next

Thanks,
Jason
