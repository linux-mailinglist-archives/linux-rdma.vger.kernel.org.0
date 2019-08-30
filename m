Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFDE3A34D1
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2019 12:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfH3KTU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Aug 2019 06:19:20 -0400
Received: from mail-eopbgr30082.outbound.protection.outlook.com ([40.107.3.82]:53978
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727326AbfH3KTT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Aug 2019 06:19:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZmG59lYnzGS7gfisv0F1mUUyb2VRmeaMIDMakPjlF1TxKbpuOfirpawz+AeXEtZMxenj4EEbadyEVmuCtrCAUL1p8ZIBjQ2MJKoNAdjh7I3JECLcKiJVKa9a19vg+/IgSPTDokr4lvJ0Ea3adclvCo+PCLpib47syPtPZClj4F+33SMlANatN2lrkOz2u8T3nYXKhKL1+OfrpVcL87OqHTHZVNS4mOZKyB76rNy8zc9Vx+1v93++auo6vU6/Y8euIJ21BDJG8IzPydEdi7XmydXkCNtvFc6LdJdRU4skNRxcldNo3JPxUhMGIgON+hhE1BRwomeookMbAF6J6b8bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwZGxQ7B6Ht3Fy9mVvlcKY80xm8NrF8B4WZmzLpLsz0=;
 b=R0/a4x2JZwNWa0jS7XGmzS8XpRsK3IjMWun5GvdVtSDb6JVcUDFA4qbrTTMph1v9oS6T3/LwgRKferoPzZLQe2cN1cECFNfcvQcJhTVvDGYm1Xx4BjrMgEZVIZp13FEhtBUKVb6/5o6piVKan4OdZjJ7DOZwFm71ZelywVOPiEIgm5Mfol4ZzCRNIK/y8br54jDHCuE0Z9kJMIDv9nYA5Eq/m3bjNYS03IBwkR5tZeuBZZedtw+cuGhqdUS7UZP+2GmlcVLTeF3zPjJQoac8oUl29BkATAH62rX1iRu2NTQhChgE1O7vCw30RvhqcLxXA5He805KV9cXqyeezpifXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwZGxQ7B6Ht3Fy9mVvlcKY80xm8NrF8B4WZmzLpLsz0=;
 b=ADW6B2OIU2uWbpkUMsKlzH39FVmKK6QV4GsaNt6H2Gvqu+Sssj5B8D6ySG5Y867gJszYPYt4WjZ8NdfDWE8LU4Sf86cg6tKpLCQXtUW7ZKavCyH6C6nZTEqxltcxuvE+LxytKl5lABSPQP3eRG3KW58KZ6I4LHZKsGVvYy9GlIE=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB5010.eurprd05.prod.outlook.com (20.177.41.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Fri, 30 Aug 2019 10:18:35 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::216f:f548:1db0:41ea]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::216f:f548:1db0:41ea%6]) with mapi id 15.20.2199.021; Fri, 30 Aug 2019
 10:18:35 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: RE: [PATCH rdma-next v1 3/4] RDMA/nldev: Provide MR statistics
Thread-Topic: [PATCH rdma-next v1 3/4] RDMA/nldev: Provide MR statistics
Thread-Index: AQHVXws90ig9Yg1V4Ua7T78ElUX516cTejiA
Date:   Fri, 30 Aug 2019 10:18:35 +0000
Message-ID: <AM0PR05MB4866C7620535722AD791DA7FD1BD0@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <20190830081612.2611-1-leon@kernel.org>
 <20190830081612.2611-4-leon@kernel.org>
In-Reply-To: <20190830081612.2611-4-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [106.51.18.188]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 885e853f-1907-4bb1-277d-08d72d336adc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR05MB5010;
x-ms-traffictypediagnostic: AM0PR05MB5010:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB50108EC570C7ADC211BC0984D1BD0@AM0PR05MB5010.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:605;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(189003)(199004)(13464003)(305945005)(7736002)(74316002)(25786009)(55016002)(6636002)(9686003)(229853002)(5660300002)(86362001)(4326008)(66476007)(81166006)(81156014)(66556008)(64756008)(478600001)(66446008)(8676002)(66946007)(9456002)(52536014)(6436002)(8936002)(6246003)(107886003)(53936002)(66066001)(2906002)(11346002)(476003)(446003)(486006)(55236004)(54906003)(53546011)(6506007)(316002)(256004)(110136005)(14444005)(76116006)(186003)(6116002)(102836004)(99286004)(71190400001)(3846002)(71200400001)(14454004)(33656002)(76176011)(26005)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB5010;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CALUYlZszRp+QmEz9OUAPIgdx+hmSqd7DmT1KwKDZdRdrZQntcGCl6lHItqp8zmbT2eDH1qZSwXyHZL8OJ6wBhNr+MWrNz9aIrlxkMPor2kt6jLdfyTJd3V6q+VzMcCR1t2B9EWC3fT6N2367opH3ybV8fzX0UlU9O7XlUJyoEqFTfUMxQ07hBwW2cg5LUHlc4WvCDtawRTybVFPZEiu4A4rBNZNR+JJ2A+hLhlOQYUQjHaUQzAtEpiPVyDNEHFqScvDXbGiuUNtL9FuFNIXd4BeGX7d2049ca0EJ3Z93Q4HkfrYYlUNaYx8mCnOXajzBGhdR8nXL/n6J9Y8+6QFPJpDTxUxP6dNDx6Cg4SW4Uu19UFDKtcSikNy1Nyz7VS4R5qNvNaOqZnNk5Zzynz21b+b0HM+CyGZ/hBeDbc+k84=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 885e853f-1907-4bb1-277d-08d72d336adc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 10:18:35.3790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bJrayYzHQxeLtYxN2/NfXtNY2oQSpnhVfq3B6u7vKbqM9puqV4wu9TQaCPXYA/uMYfDDNOqIA7It1007fktfng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5010
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Leon Romanovsky
> Sent: Friday, August 30, 2019 1:46 PM
> To: Doug Ledford <dledford@redhat.com>; Jason Gunthorpe
> <jgg@mellanox.com>
> Cc: Leon Romanovsky <leonro@mellanox.com>; RDMA mailing list <linux-
> rdma@vger.kernel.org>; Erez Alfasi <ereza@mellanox.com>
> Subject: [PATCH rdma-next v1 3/4] RDMA/nldev: Provide MR statistics
>=20
> From: Erez Alfasi <ereza@mellanox.com>
>=20
> Add RDMA nldev netlink interface for dumping MR statistics information.
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
> ---
>  drivers/infiniband/core/device.c  |  1 +
>  drivers/infiniband/core/nldev.c   | 54 +++++++++++++++++++++++++++++--
>  drivers/infiniband/hw/mlx5/main.c | 16 +++++++++
>  include/rdma/ib_verbs.h           |  9 ++++++
>  4 files changed, 78 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/infiniband/core/device.c
> b/drivers/infiniband/core/device.c
> index 99c4a55545cf..34a9e37c5c61 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -2610,6 +2610,7 @@ void ib_set_device_ops(struct ib_device *dev,
> const struct ib_device_ops *ops)
>  	SET_DEVICE_OP(dev_ops, get_dma_mr);
>  	SET_DEVICE_OP(dev_ops, get_hw_stats);
>  	SET_DEVICE_OP(dev_ops, get_link_layer);
> +	SET_DEVICE_OP(dev_ops, fill_odp_stats);
>  	SET_DEVICE_OP(dev_ops, get_netdev);
>  	SET_DEVICE_OP(dev_ops, get_port_immutable);
>  	SET_DEVICE_OP(dev_ops, get_vector_affinity); diff --git
> a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c index
> 47f7fe5432db..47fee3d68cb9 100644
> --- a/drivers/infiniband/core/nldev.c
> +++ b/drivers/infiniband/core/nldev.c
> @@ -37,6 +37,7 @@
>  #include <net/netlink.h>
>  #include <rdma/rdma_cm.h>
>  #include <rdma/rdma_netlink.h>
> +#include <rdma/ib_umem_odp.h>
>=20
>  #include "core_priv.h"
>  #include "cma_priv.h"
> @@ -748,6 +749,49 @@ static int fill_stat_hwcounter_entry(struct sk_buff
> *msg,
>  	return -EMSGSIZE;
>  }
>=20
> +static int fill_stat_mr_entry(struct sk_buff *msg, bool has_cap_net_admi=
n,
> +			      struct rdma_restrack_entry *res, uint32_t port) {
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
> +
> +	table_attr =3D nla_nest_start(msg,
> +				    RDMA_NLDEV_ATTR_STAT_HWCOUNTERS);
> +
> +	if (!table_attr)
> +		return -EMSGSIZE;
> +
> +	if (fill_stat_hwcounter_entry(msg, "page_faults",
> +				      (u64)atomic64_read(&odp_stats.faults)))
> +		goto err_table;
> +	if (fill_stat_hwcounter_entry(
> +		    msg, "page_invalidations",
> +		    (u64)atomic64_read(&odp_stats.invalidations)))
> +		goto err_table;
> +	if (fill_stat_hwcounter_entry(msg, "prefetched_pages",
> +
> (u64)atomic64_read(&odp_stats.prefetched)))
> +		goto err_table;
> +
> +	nla_nest_end(msg, table_attr);
> +	return 0;
> +
> +err_table:
> +	nla_nest_cancel(msg, table_attr);
> +err:
> +	return -EMSGSIZE;
> +}
> +
>  static int fill_stat_counter_hwcounters(struct sk_buff *msg,
>  					struct rdma_counter *counter)
>  {
> @@ -2008,7 +2052,10 @@ static int nldev_stat_get_doit(struct sk_buff *skb=
,
> struct nlmsghdr *nlh,
>  	case RDMA_NLDEV_ATTR_RES_QP:
>  		ret =3D stat_get_doit_qp(skb, nlh, extack, tb);
>  		break;
> -
> +	case RDMA_NLDEV_ATTR_RES_MR:
> +		ret =3D res_get_common_doit(skb, nlh, extack,
> RDMA_RESTRACK_MR,
> +					  fill_stat_mr_entry);
> +		break;
>  	default:
>  		ret =3D -EINVAL;
>  		break;
> @@ -2032,7 +2079,10 @@ static int nldev_stat_get_dumpit(struct sk_buff
> *skb,
>  	case RDMA_NLDEV_ATTR_RES_QP:
>  		ret =3D nldev_res_get_counter_dumpit(skb, cb);
>  		break;
> -
> +	case RDMA_NLDEV_ATTR_RES_MR:
> +		ret =3D res_get_common_dumpit(skb, cb,
> RDMA_RESTRACK_MR,
> +					    fill_stat_mr_entry);
> +		break;
>  	default:
>  		ret =3D -EINVAL;
>  		break;
> diff --git a/drivers/infiniband/hw/mlx5/main.c
> b/drivers/infiniband/hw/mlx5/main.c
> index 07aecba16019..05095fda03cc 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -67,6 +67,7 @@
>  #include <rdma/uverbs_std_types.h>
>  #include <rdma/mlx5_user_ioctl_verbs.h>  #include
> <rdma/mlx5_user_ioctl_cmds.h>
> +#include <rdma/ib_umem_odp.h>
>=20
>  #define UVERBS_MODULE_NAME mlx5_ib
>  #include <rdma/uverbs_named_ioctl.h>
> @@ -121,6 +122,20 @@ struct mlx5_ib_dev
> *mlx5_ib_get_ibdev_from_mpi(struct mlx5_ib_multiport_info *mp
>  	return dev;
>  }
>=20
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
> +
> +	return true;
> +}
> +
>  static enum rdma_link_layer
>  mlx5_port_type_cap_to_rdma_ll(int port_type_cap)  { @@ -6316,6 +6331,7
> @@ static const struct ib_device_ops mlx5_ib_dev_ops =3D {
>  	.get_dev_fw_str =3D get_dev_fw_str,
>  	.get_dma_mr =3D mlx5_ib_get_dma_mr,
>  	.get_link_layer =3D mlx5_ib_port_link_layer,
> +	.fill_odp_stats =3D mlx5_ib_fill_odp_stats,
>  	.map_mr_sg =3D mlx5_ib_map_mr_sg,
>  	.map_mr_sg_pi =3D mlx5_ib_map_mr_sg_pi,
>  	.mmap =3D mlx5_ib_mmap,
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h index
> de5bc352f473..48d6513b3b59 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -72,6 +72,7 @@
>  #define IB_FW_VERSION_NAME_MAX	ETHTOOL_FWVERS_LEN
>=20
>  struct ib_umem_odp;
> +struct ib_odp_counters;
>=20
>  extern struct workqueue_struct *ib_wq;
>  extern struct workqueue_struct *ib_comp_wq; @@ -2566,6 +2567,14 @@
> struct ib_device_ops {
>  	 */
>  	int (*counter_update_stats)(struct rdma_counter *counter);
>=20
> +	/**
> +	 * fill_odp_stats - Fill MR ODP stats into a given
> +	 * ib_odp_counters struct.
> +	 * Return value - true in case counters has been filled,
> +	 * false otherwise (if its non-ODP registered MR for example).
> +	 */
> +	bool (*fill_odp_stats)(struct ib_mr *mr, struct ib_odp_counters
> *cnt);
> +
Requesting ODP stats on non-ODP MR is an error.
Instead of returning bool, please return int =3D -EINVAL as an error for no=
n ODP MRs.

>  	DECLARE_RDMA_OBJ_SIZE(ib_ah);
>  	DECLARE_RDMA_OBJ_SIZE(ib_cq);
>  	DECLARE_RDMA_OBJ_SIZE(ib_pd);
> --
> 2.20.1

