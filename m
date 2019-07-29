Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 122237849B
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2019 07:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfG2Fw5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Jul 2019 01:52:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfG2Fw4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Jul 2019 01:52:56 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BEB920659;
        Mon, 29 Jul 2019 05:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564379574;
        bh=UiNBXbmf99+A8o4np2k48EixMun1+j7M93uj9CQm3L8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0+LuK+ZfLYUUwKvVLnCi9F/3wrH5QtwM4e91g8DZ/yNXIS7PxaNdv7Qqe8KhMvrK/
         PSY/Af4JgP2C2nrbpPUtcOGTqtUCzaE1Y4YaB3rk0/RLLHaaVscd3xM9JhPiNyItsb
         XhoqerhT2tee6svSxYvPrZm4qqxwAj2l62o/IEbI=
Date:   Mon, 29 Jul 2019 08:52:50 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Parav Pandit <parav@mellanox.com>
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] infiniband: mlx5: a possible null-pointer dereference in
 set_roce_addr()
Message-ID: <20190729055250.GL4674@mtr-leonro.mtl.com>
References: <f99031cc-795e-92bd-9310-29c669ada7dc@gmail.com>
 <AM0PR05MB48664AE114EE357CC33EA945D1DD0@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB4866CE3362B36EB4257C858ED1DD0@AM0PR05MB4866.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR05MB4866CE3362B36EB4257C858ED1DD0@AM0PR05MB4866.eurprd05.prod.outlook.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 29, 2019 at 05:26:30AM +0000, Parav Pandit wrote:
>
>
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> > owner@vger.kernel.org> On Behalf Of Parav Pandit
> > Sent: Monday, July 29, 2019 10:55 AM
> > To: Jia-Ju Bai <baijiaju1990@gmail.com>; leon@kernel.org;
> > dledford@redhat.com; jgg@ziepe.ca
> > Cc: linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: RE: [BUG] infiniband: mlx5: a possible null-pointer dereference in
> > set_roce_addr()
> >
> > Hi Jia,
> >
> > > -----Original Message-----
> > > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > > owner@vger.kernel.org> On Behalf Of Jia-Ju Bai
> > > Sent: Monday, July 29, 2019 7:47 AM
> > > To: leon@kernel.org; dledford@redhat.com; jgg@ziepe.ca
> > > Cc: linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: [BUG] infiniband: mlx5: a possible null-pointer dereference
> > > in
> > > set_roce_addr()
> > >
> > > In set_roce_addr(), there is an if statement on line 589 to check
> > > whether gid is
> > > NULL:
> > >      if (gid)
> > >
> > > When gid is NULL, it is used on line 613:
> > >      return mlx5_core_roce_gid_set(..., gid->raw, ...);
> > >
> > > Thus, a possible null-pointer dereference may occur.
> > >
> > > This bug is found by a static analysis tool STCheck written by us.
> > >
> > While static checker is right, it is not a real bug, because gid->raw pointer
> > points to GID entry itself so when GID is NULL, gid->raw is NULL too.
> >
> > One way to suppress the static checker warning/error is below patch.
> > Will let Leon review it.
> >
> > > I do not know how to correctly fix this bug, so I only report it.
> > >
> > >
> > > Best wishes,
> > > Jia-Ju Bai
> >
> > From 30e055dba77e595bf88aebd3a9c75ed76bc9c65a Mon Sep 17 00:00:00
> > 2001
> > From: Parav Pandit <parav@mellanox.com>
> > Date: Mon, 29 Jul 2019 00:13:21 -0500
> > Subject: [PATCH] IB/mlx5: Avoid static checker warning for NULL access
> >
> > union ib_gid *gid and gid->raw pointers refers to the same address.
> > However some static checker reports this as possible NULL access warning in
> > call to mlx5_core_roce_gid_set().
> >
> > To suppress such warning, instead of working on raw GID element, expose API
> > using union ib_gid*.
> >
> > Reported-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> > Signed-off-by: Parav Pandit <parav@mellanox.com>
> > ---
> >  drivers/infiniband/hw/mlx5/main.c                   |  2 +-
> >  drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c | 12 +++++++-----
> >  drivers/net/ethernet/mellanox/mlx5/core/lib/gid.c   |  5 +++--
> >  drivers/net/ethernet/mellanox/mlx5/core/rdma.c      |  2 +-
> >  include/linux/mlx5/driver.h                         |  4 +++-
> >  5 files changed, 15 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/mlx5/main.c
> > b/drivers/infiniband/hw/mlx5/main.c
> > index c2a5780cb394..e60785bad7ef 100644
> > --- a/drivers/infiniband/hw/mlx5/main.c
> > +++ b/drivers/infiniband/hw/mlx5/main.c
> > @@ -610,7 +610,7 @@ static int set_roce_addr(struct mlx5_ib_dev *dev, u8
> > port_num,
> >  	}
> >
> >  	return mlx5_core_roce_gid_set(dev->mdev, index, roce_version,
> > -				      roce_l3_type, gid->raw, mac,
> > +				      roce_l3_type, &gid, mac,
> >  				      vlan_id < VLAN_CFI_MASK, vlan_id,
> >  				      port_num);
> >  }
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c
> > b/drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c
> > index 4c50efe4e7f1..76b8236af9c7 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c
> > @@ -850,6 +850,7 @@ struct mlx5_fpga_conn *mlx5_fpga_conn_create(struct
> > mlx5_fpga_device *fdev,
> >  					     enum mlx5_ifc_fpga_qp_type
> > qp_type)  {
> >  	struct mlx5_fpga_conn *ret, *conn;
> > +	struct ib_gid remote_gid = {};
> >  	u8 *remote_mac, *remote_ip;
> >  	int err;
> >
> > @@ -876,11 +877,12 @@ struct mlx5_fpga_conn
> > *mlx5_fpga_conn_create(struct mlx5_fpga_device *fdev,
> >  		goto err;
> >  	}
> >
> > -	/* Build Modified EUI-64 IPv6 address from the MAC address */
> >  	remote_ip = MLX5_ADDR_OF(fpga_qpc, conn->fpga_qpc, remote_ip);
> > -	remote_ip[0] = 0xfe;
> > -	remote_ip[1] = 0x80;
> > -	addrconf_addr_eui48(&remote_ip[8], remote_mac);
> > +	memcpy(remote_gid.raw[0], remote_ip, sizeof(remote_gid.raw));
> > +	/* Build Modified EUI-64 IPv6 address from the MAC address */
> > +	remte_gid.raw[0] = 0xfe;
> > +	remte_gid.raw[1] = 0x80;
> > +	addrconf_addr_eui48(&remote_gid.raw[8], remote_mac);
> >
> >  	err = mlx5_core_reserved_gid_alloc(fdev->mdev, &conn-
> > >qp.sgid_index);
> >  	if (err) {
> > @@ -892,7 +894,7 @@ struct mlx5_fpga_conn *mlx5_fpga_conn_create(struct
> > mlx5_fpga_device *fdev,
> >  	err = mlx5_core_roce_gid_set(fdev->mdev, conn->qp.sgid_index,
> >  				     MLX5_ROCE_VERSION_2,
> >  				     MLX5_ROCE_L3_TYPE_IPV6,
> > -				     remote_ip, remote_mac, true, 0,
> > +				     &remote_gid, remote_mac, true, 0,
> >  				     MLX5_FPGA_PORT_NUM);
> >  	if (err) {
> >  		mlx5_fpga_err(fdev, "Failed to set SGID: %d\n", err); diff --git
> > a/drivers/net/ethernet/mellanox/mlx5/core/lib/gid.c
> > b/drivers/net/ethernet/mellanox/mlx5/core/lib/gid.c
> > index 7722a3f9bb68..9b8563a2bd50 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/gid.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/gid.c
> > @@ -120,7 +120,8 @@ unsigned int mlx5_core_reserved_gids_count(struct
> > mlx5_core_dev *dev)
> > EXPORT_SYMBOL_GPL(mlx5_core_reserved_gids_count);
> >
> >  int mlx5_core_roce_gid_set(struct mlx5_core_dev *dev, unsigned int index,
> > -			   u8 roce_version, u8 roce_l3_type, const u8 *gid,
> > +			   u8 roce_version, u8 roce_l3_type,
> > +			   const union ib_gid *gid,
> >  			   const u8 *mac, bool vlan, u16 vlan_id, u8 port_num)
> > {  #define MLX5_SET_RA(p, f, v) MLX5_SET(roce_addr_layout, p, f, v) @@ -
> > 145,7 +146,7 @@ int mlx5_core_roce_gid_set(struct mlx5_core_dev *dev,
> > unsigned int index,
> >  		ether_addr_copy(addr_mac, mac);
> >  		MLX5_SET_RA(in_addr, roce_version, roce_version);
> >  		MLX5_SET_RA(in_addr, roce_l3_type, roce_l3_type);
> > -		memcpy(addr_l3_addr, gid, gidsz);
> > +		memcpy(addr_l3_addr, &gid->raw[0], gidsz);
> >  	}
> >
> >  	if (MLX5_CAP_GEN(dev, num_vhca_ports) > 0) diff --git
> > a/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
> > b/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
> > index 17ce9dd56b13..2a4467346231 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
> > @@ -139,7 +139,7 @@ static int mlx5_rdma_add_roce_addr(struct
> > mlx5_core_dev *dev)
> >  	mlx5_rdma_make_default_gid(dev, &gid);
> >  	return mlx5_core_roce_gid_set(dev, 0,
> >  				      MLX5_ROCE_VERSION_1,
> > -				      0, gid.raw, mac,
> > +				      0, &gid, mac,
> >  				      false, 0, 1);
> >  }
> >
> > diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h index
> > 1e42c13819ae..691864e853be 100644
> > --- a/include/linux/mlx5/driver.h
> > +++ b/include/linux/mlx5/driver.h
> > @@ -47,6 +47,7 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/idr.h>
> >  #include <linux/notifier.h>
> > +#include <rdma/ib_verbs.h>
> >
> >  #include <linux/mlx5/device.h>
> >  #include <linux/mlx5/doorbell.h>
> > @@ -1002,7 +1003,8 @@ struct cpumask *
> >  mlx5_comp_irq_get_affinity_mask(struct mlx5_core_dev *dev, int vector);
> > unsigned int mlx5_core_reserved_gids_count(struct mlx5_core_dev *dev);  int
> > mlx5_core_roce_gid_set(struct mlx5_core_dev *dev, unsigned int index,
> > -			   u8 roce_version, u8 roce_l3_type, const u8 *gid,
> > +			   u8 roce_version, u8 roce_l3_type,
> > +			   const union ib_gid *gid,
> >  			   const u8 *mac, bool vlan, u16 vlan_id, u8 port_num);
> >
> >  static inline int fw_initializing(struct mlx5_core_dev *dev)
> > --
> > 2.19.2
>
> Leon just replied. Thanks.

Just to be clear, NAK.

Thanks
