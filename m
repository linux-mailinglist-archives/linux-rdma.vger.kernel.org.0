Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8D47CEA4
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 22:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfGaUcc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 16:32:32 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46063 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfGaUcc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Jul 2019 16:32:32 -0400
Received: by mail-pg1-f195.google.com with SMTP id o13so32618955pgp.12
        for <linux-rdma@vger.kernel.org>; Wed, 31 Jul 2019 13:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:content-transfer-encoding:mime-version:subject:date:references
         :to:in-reply-to:message-id;
        bh=ZAjFKriDLhvwcjuYt2zq29IvgUru9uaqwoRyKphjvxQ=;
        b=Gb2ON3TVhv43IdG4cRuELhsg/5hTNxgmpZ1P8iHMOMNAK/uNWBiBRtw7O821ST9Ju0
         gpV8fxeLsNoEYpU8xD3kTqAex9W8epE6ZKeOinfg7XqLclJQu9CW1NLAuDBVyEnX14ak
         tWMBD3NT6iv44IUS6IDzR0TRw41X9nOuRD+cipO+e3gQQjnuruqIh8GKrOG13e3HpvhA
         wmddUtStGMcb6ORTIUSIBDts1aURkNekz70F9L66qemAe+cq6j+AVsszJ+wfM5iWq/sA
         1zTMaqejlGgXRrzfy53vGPrwi0oNqsfNCVCYDbYdgUgzCv4H+hs2f7c4aFxj8YOWdd9c
         P6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:date:references:to:in-reply-to:message-id;
        bh=ZAjFKriDLhvwcjuYt2zq29IvgUru9uaqwoRyKphjvxQ=;
        b=YoY616duZda0JORZAlLvPu0YiPlbmWDgnGEa0UGJJO2WYMwpHvrr7O4wmRefUDlh5z
         bzHMwR6SBTHA2sguX8c7X5/zFWOBvQBX1wA/neEzOS1L1rmnfjuN/ZHq9QJ50xAg2jeY
         NBHfhnzEPYczUwwlODvhNq99OtHtUPfbM6QyBJEtjiEh+DtH1oJk3xD6LadIRatdkRWo
         Exp5/4CFBZ4TOqZjVvVl3fcEC9PRt3MdQ0xsviqzm7TWLFo61/fioyvP4gVbxmSI4/cR
         YCOpn7UtYAnRGqRlTZTCX6F8ddJ2KQGwH0prtijKJpyvExQmH2QC5Zs+ChBtYx7Q4Sf2
         zPWw==
X-Gm-Message-State: APjAAAVfcLnCQvdmkbfnZ4bU9+TY7oMkxB78haIlxdQ9VZ87ep2XNkcf
        mrRkWVvtbzVx01T0lCwRzdN75SsyGwpKzw==
X-Google-Smtp-Source: APXvYqwSyzEUCNa6SemFB9JpV5gVcsAOd4AU9jmJo8N0fyNOa4mAdpRpTczZbQuobRC2HWVmEk3Acw==
X-Received: by 2002:a63:8a43:: with SMTP id y64mr114575534pgd.104.1564605151393;
        Wed, 31 Jul 2019 13:32:31 -0700 (PDT)
Received: from [192.168.35.2] ([12.1.37.26])
        by smtp.gmail.com with ESMTPSA id 196sm74124688pfy.167.2019.07.31.13.32.30
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 13:32:30 -0700 (PDT)
From:   Andrew Boyer <aboyer@pensando.io>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH for-next V2 1/4] RDMA: Introduce ib_port_phys_state enum
Date:   Wed, 31 Jul 2019 16:32:28 -0400
References: <20190731202459.19570-1-kamalheib1@gmail.com>
 <20190731202459.19570-2-kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
In-Reply-To: <20190731202459.19570-2-kamalheib1@gmail.com>
Message-Id: <C1FE5FDF-969E-4616-9ACA-79D819F7E5B4@pensando.io>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thanks! I meant to do this two years ago.

Reviewed-by: Andrew Boyer <aboyer@tobark.org>

> On Jul 31, 2019, at 4:24 PM, Kamal Heib <kamalheib1@gmail.com> wrote:
>=20
> In order to improve readability, add ib_port_phys_state enum to =
replace
> the use of magic numbers.
>=20
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
> drivers/infiniband/core/sysfs.c              | 24 +++++++++++++-------
> drivers/infiniband/hw/bnxt_re/ib_verbs.c     |  4 ++--
> drivers/infiniband/hw/efa/efa_verbs.c        |  2 +-
> drivers/infiniband/hw/mlx5/main.c            |  4 ++--
> drivers/infiniband/hw/ocrdma/ocrdma_verbs.c  |  4 ++--
> drivers/infiniband/hw/qedr/verbs.c           |  4 ++--
> drivers/infiniband/hw/usnic/usnic_ib_verbs.c |  7 +++---
> drivers/infiniband/sw/rxe/rxe.h              |  4 ----
> drivers/infiniband/sw/rxe/rxe_param.h        |  2 +-
> drivers/infiniband/sw/rxe/rxe_verbs.c        |  6 ++---
> drivers/infiniband/sw/siw/siw_verbs.c        |  3 ++-
> include/rdma/ib_verbs.h                      | 10 ++++++++
> 12 files changed, 45 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/infiniband/core/sysfs.c =
b/drivers/infiniband/core/sysfs.c
> index b477295a96c2..46722e04f6e1 100644
> --- a/drivers/infiniband/core/sysfs.c
> +++ b/drivers/infiniband/core/sysfs.c
> @@ -301,14 +301,22 @@ static ssize_t phys_state_show(struct ib_port =
*p, struct port_attribute *unused,
> 		return ret;
>=20
> 	switch (attr.phys_state) {
> -	case 1:  return sprintf(buf, "1: Sleep\n");
> -	case 2:  return sprintf(buf, "2: Polling\n");
> -	case 3:  return sprintf(buf, "3: Disabled\n");
> -	case 4:  return sprintf(buf, "4: PortConfigurationTraining\n");
> -	case 5:  return sprintf(buf, "5: LinkUp\n");
> -	case 6:  return sprintf(buf, "6: LinkErrorRecovery\n");
> -	case 7:  return sprintf(buf, "7: Phy Test\n");
> -	default: return sprintf(buf, "%d: <unknown>\n", =
attr.phys_state);
> +	case IB_PORT_PHYS_STATE_SLEEP:
> +		return sprintf(buf, "1: Sleep\n");
> +	case IB_PORT_PHYS_STATE_POLLING:
> +		return sprintf(buf, "2: Polling\n");
> +	case IB_PORT_PHYS_STATE_DISABLED:
> +		return sprintf(buf, "3: Disabled\n");
> +	case IB_PORT_PHYS_STATE_PORT_CONFIGURATION_TRAINING:
> +		return sprintf(buf, "4: PortConfigurationTraining\n");
> +	case IB_PORT_PHYS_STATE_LINK_UP:
> +		return sprintf(buf, "5: LinkUp\n");
> +	case IB_PORT_PHYS_STATE_LINK_ERROR_RECOVERY:
> +		return sprintf(buf, "6: LinkErrorRecovery\n");
> +	case IB_PORT_PHYS_STATE_PHY_TEST:
> +		return sprintf(buf, "7: Phy Test\n");
> +	default:
> +		return sprintf(buf, "%d: <unknown>\n", attr.phys_state);
> 	}
> }
>=20
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c =
b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> index a91653aabf38..ca6306c24881 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -220,10 +220,10 @@ int bnxt_re_query_port(struct ib_device *ibdev, =
u8 port_num,
>=20
> 	if (netif_running(rdev->netdev) && =
netif_carrier_ok(rdev->netdev)) {
> 		port_attr->state =3D IB_PORT_ACTIVE;
> -		port_attr->phys_state =3D 5;
> +		port_attr->phys_state =3D IB_PORT_PHYS_STATE_LINK_UP;
> 	} else {
> 		port_attr->state =3D IB_PORT_DOWN;
> -		port_attr->phys_state =3D 3;
> +		port_attr->phys_state =3D IB_PORT_PHYS_STATE_DISABLED;
> 	}
> 	port_attr->max_mtu =3D IB_MTU_4096;
> 	port_attr->active_mtu =3D iboe_get_mtu(rdev->netdev->mtu);
> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c =
b/drivers/infiniband/hw/efa/efa_verbs.c
> index df77bc312a25..f36071a92f97 100644
> --- a/drivers/infiniband/hw/efa/efa_verbs.c
> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> @@ -306,7 +306,7 @@ int efa_query_port(struct ib_device *ibdev, u8 =
port,
> 	props->lmc =3D 1;
>=20
> 	props->state =3D IB_PORT_ACTIVE;
> -	props->phys_state =3D 5;
> +	props->phys_state =3D IB_PORT_PHYS_STATE_LINK_UP;
> 	props->gid_tbl_len =3D 1;
> 	props->pkey_tbl_len =3D 1;
> 	props->active_speed =3D IB_SPEED_EDR;
> diff --git a/drivers/infiniband/hw/mlx5/main.c =
b/drivers/infiniband/hw/mlx5/main.c
> index c2a5780cb394..bc4d7dca170f 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -535,7 +535,7 @@ static int mlx5_query_port_roce(struct ib_device =
*device, u8 port_num,
> 	props->max_msg_sz       =3D 1 << MLX5_CAP_GEN(dev->mdev, =
log_max_msg);
> 	props->pkey_tbl_len     =3D 1;
> 	props->state            =3D IB_PORT_DOWN;
> -	props->phys_state       =3D 3;
> +	props->phys_state       =3D IB_PORT_PHYS_STATE_DISABLED;
>=20
> 	mlx5_query_nic_vport_qkey_viol_cntr(mdev, &qkey_viol_cntr);
> 	props->qkey_viol_cntr =3D qkey_viol_cntr;
> @@ -561,7 +561,7 @@ static int mlx5_query_port_roce(struct ib_device =
*device, u8 port_num,
>=20
> 	if (netif_running(ndev) && netif_carrier_ok(ndev)) {
> 		props->state      =3D IB_PORT_ACTIVE;
> -		props->phys_state =3D 5;
> +		props->phys_state =3D IB_PORT_PHYS_STATE_LINK_UP;
> 	}
>=20
> 	ndev_ib_mtu =3D iboe_get_mtu(ndev->mtu);
> diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c =
b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> index bccc11378109..e8267e590772 100644
> --- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> +++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> @@ -163,10 +163,10 @@ int ocrdma_query_port(struct ib_device *ibdev,
> 	netdev =3D dev->nic_info.netdev;
> 	if (netif_running(netdev) && netif_oper_up(netdev)) {
> 		port_state =3D IB_PORT_ACTIVE;
> -		props->phys_state =3D 5;
> +		props->phys_state =3D IB_PORT_PHYS_STATE_LINK_UP;
> 	} else {
> 		port_state =3D IB_PORT_DOWN;
> -		props->phys_state =3D 3;
> +		props->phys_state =3D IB_PORT_PHYS_STATE_DISABLED;
> 	}
> 	props->max_mtu =3D IB_MTU_4096;
> 	props->active_mtu =3D iboe_get_mtu(netdev->mtu);
> diff --git a/drivers/infiniband/hw/qedr/verbs.c =
b/drivers/infiniband/hw/qedr/verbs.c
> index 27d90a84ea01..1373312aec58 100644
> --- a/drivers/infiniband/hw/qedr/verbs.c
> +++ b/drivers/infiniband/hw/qedr/verbs.c
> @@ -221,10 +221,10 @@ int qedr_query_port(struct ib_device *ibdev, u8 =
port, struct ib_port_attr *attr)
> 	/* *attr being zeroed by the caller, avoid zeroing it here */
> 	if (rdma_port->port_state =3D=3D QED_RDMA_PORT_UP) {
> 		attr->state =3D IB_PORT_ACTIVE;
> -		attr->phys_state =3D 5;
> +		attr->phys_state =3D IB_PORT_PHYS_STATE_LINK_UP;
> 	} else {
> 		attr->state =3D IB_PORT_DOWN;
> -		attr->phys_state =3D 3;
> +		attr->phys_state =3D IB_PORT_PHYS_STATE_DISABLED;
> 	}
> 	attr->max_mtu =3D IB_MTU_4096;
> 	attr->active_mtu =3D iboe_get_mtu(dev->ndev->mtu);
> diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c =
b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
> index eeb07b245ef9..4f8f1d3eb559 100644
> --- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
> +++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
> @@ -356,13 +356,14 @@ int usnic_ib_query_port(struct ib_device *ibdev, =
u8 port,
>=20
> 	if (!us_ibdev->ufdev->link_up) {
> 		props->state =3D IB_PORT_DOWN;
> -		props->phys_state =3D 3;
> +		props->phys_state =3D IB_PORT_PHYS_STATE_DISABLED;
> 	} else if (!us_ibdev->ufdev->inaddr) {
> 		props->state =3D IB_PORT_INIT;
> -		props->phys_state =3D 4;
> +		props->phys_state =3D
> +			IB_PORT_PHYS_STATE_PORT_CONFIGURATION_TRAINING;
> 	} else {
> 		props->state =3D IB_PORT_ACTIVE;
> -		props->phys_state =3D 5;
> +		props->phys_state =3D IB_PORT_PHYS_STATE_LINK_UP;
> 	}
>=20
> 	props->port_cap_flags =3D 0;
> diff --git a/drivers/infiniband/sw/rxe/rxe.h =
b/drivers/infiniband/sw/rxe/rxe.h
> index ecf6e659c0da..fb07eed9e402 100644
> --- a/drivers/infiniband/sw/rxe/rxe.h
> +++ b/drivers/infiniband/sw/rxe/rxe.h
> @@ -65,10 +65,6 @@
>  */
> #define RXE_UVERBS_ABI_VERSION		2
>=20
> -#define RDMA_LINK_PHYS_STATE_LINK_UP	(5)
> -#define RDMA_LINK_PHYS_STATE_DISABLED	(3)
> -#define RDMA_LINK_PHYS_STATE_POLLING	(2)
> -
> #define RXE_ROCE_V2_SPORT		(0xc000)
>=20
> static inline u32 rxe_crc32(struct rxe_dev *rxe,
> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h =
b/drivers/infiniband/sw/rxe/rxe_param.h
> index 1abed47ca221..fe5207386700 100644
> --- a/drivers/infiniband/sw/rxe/rxe_param.h
> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
> @@ -154,7 +154,7 @@ enum rxe_port_param {
> 	RXE_PORT_ACTIVE_WIDTH		=3D IB_WIDTH_1X,
> 	RXE_PORT_ACTIVE_SPEED		=3D 1,
> 	RXE_PORT_PKEY_TBL_LEN		=3D 64,
> -	RXE_PORT_PHYS_STATE		=3D 2,
> +	RXE_PORT_PHYS_STATE		=3D IB_PORT_PHYS_STATE_POLLING,
> 	RXE_PORT_SUBNET_PREFIX		=3D 0xfe80000000000000ULL,
> };
>=20
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c =
b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 4ebdfcf4d33e..623129f27f5a 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -69,11 +69,11 @@ static int rxe_query_port(struct ib_device *dev,
> 			      &attr->active_width);
>=20
> 	if (attr->state =3D=3D IB_PORT_ACTIVE)
> -		attr->phys_state =3D RDMA_LINK_PHYS_STATE_LINK_UP;
> +		attr->phys_state =3D IB_PORT_PHYS_STATE_LINK_UP;
> 	else if (dev_get_flags(rxe->ndev) & IFF_UP)
> -		attr->phys_state =3D RDMA_LINK_PHYS_STATE_POLLING;
> +		attr->phys_state =3D IB_PORT_PHYS_STATE_POLLING;
> 	else
> -		attr->phys_state =3D RDMA_LINK_PHYS_STATE_DISABLED;
> +		attr->phys_state =3D IB_PORT_PHYS_STATE_DISABLED;
>=20
> 	mutex_unlock(&rxe->usdev_lock);
>=20
> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c =
b/drivers/infiniband/sw/siw/siw_verbs.c
> index 32dc79d0e898..404e7ca4b30c 100644
> --- a/drivers/infiniband/sw/siw/siw_verbs.c
> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
> @@ -206,7 +206,8 @@ int siw_query_port(struct ib_device *base_dev, u8 =
port,
> 	attr->gid_tbl_len =3D 1;
> 	attr->max_msg_sz =3D -1;
> 	attr->max_mtu =3D ib_mtu_int_to_enum(sdev->netdev->mtu);
> -	attr->phys_state =3D sdev->state =3D=3D IB_PORT_ACTIVE ? 5 : 3;
> +	attr->phys_state =3D sdev->state =3D=3D IB_PORT_ACTIVE ?
> +		IB_PORT_PHYS_STATE_LINK_UP : =
IB_PORT_PHYS_STATE_DISABLED;
> 	attr->pkey_tbl_len =3D 1;
> 	attr->port_cap_flags =3D IB_PORT_CM_SUP | =
IB_PORT_DEVICE_MGMT_SUP;
> 	attr->state =3D sdev->state;
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index c5f8a9f17063..27fe844cff42 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -451,6 +451,16 @@ enum ib_port_state {
> 	IB_PORT_ACTIVE_DEFER	=3D 5
> };
>=20
> +enum ib_port_phys_state {
> +	IB_PORT_PHYS_STATE_SLEEP =3D 1,
> +	IB_PORT_PHYS_STATE_POLLING =3D 2,
> +	IB_PORT_PHYS_STATE_DISABLED =3D 3,
> +	IB_PORT_PHYS_STATE_PORT_CONFIGURATION_TRAINING =3D 4,
> +	IB_PORT_PHYS_STATE_LINK_UP =3D 5,
> +	IB_PORT_PHYS_STATE_LINK_ERROR_RECOVERY =3D 6,
> +	IB_PORT_PHYS_STATE_PHY_TEST =3D 7,
> +};
> +
> enum ib_port_width {
> 	IB_WIDTH_1X	=3D 1,
> 	IB_WIDTH_2X	=3D 16,
> --=20
> 2.20.1
>=20

