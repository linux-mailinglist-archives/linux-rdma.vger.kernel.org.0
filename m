Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25B285AF44
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Jun 2019 09:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfF3HxC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 30 Jun 2019 03:53:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfF3HxC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 30 Jun 2019 03:53:02 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38483208C4;
        Sun, 30 Jun 2019 07:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561881180;
        bh=cfSVzD0L9ocehuDxiWqQphAUsNV1J6H8e2mjpM3dupk=;
        h=From:To:Cc:Subject:Date:From;
        b=wYLQQPJhxpPg1A3wUAXOGk9l19sg6YylK1+JU8iiPEhXHdaaaKxGKjzpVjiFCEHqH
         cYuiKpX6ANHVnhFG1UZhh29gi4KohsfQJP/UsMfOnN3xqtPLFOcQlERYd7xOYKRIx4
         rB0ummeQphqcTPgaT5WvggMpfiDjczSiLfH79EM0=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Parav Pandit <parav@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH rdma-next] IB/mlx5: Fixed reporting counters on 2nd port for Dual port RoCE
Date:   Sun, 30 Jun 2019 10:52:52 +0300
Message-Id: <20190630075252.9833-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

Currently during dual port IB device registration in below code flow,

ib_register_device()
  ib_device_register_sysfs()
    ib_setup_port_attrs()
      add_port()
        get_counter_table()
          get_perf_mad()
            process_mad()
              mlx5_ib_process_mad()

mlx5_ib_process_mad() fails on 2nd port when both the ports are not
fully setup at the device level (because 2nd port is unaffiliated).

As a result, get_perf_mad() registers different PMA counter group for
1st and 2nd port, namely pma_counter_ext and pma_counter. However both
ports have the same capability and counter offsets.

Due to this when counters are read by the user via sysfs in below code
flow, counters are queried from wrong location from the device mainly
from PPCNT instead of VPORT counters.

show_pma_counter()
  get_perf_mad()
    process_mad()
      mlx5_ib_process_mad()
        process_pma_cmd()

This shows all zero counters for 2nd port.

To overcome this, process_pma_cmd() is invoked, and when unaffiliated port is not
yet setup during device registration phase, make the query on the first port.
while at it, only process_pma_cmd() needs to work on the native port
number and underlying mdev, so shift the get, put calls to where its needed
inside process_pma_cmd().

Fixes: 212f2a87b74f ("IB/mlx5: Route MADs for dual port RoCE")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mad.c | 60 +++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mad.c b/drivers/infiniband/hw/mlx5/mad.c
index 6c529e6f3a01..348c1df69cdc 100644
--- a/drivers/infiniband/hw/mlx5/mad.c
+++ b/drivers/infiniband/hw/mlx5/mad.c
@@ -200,19 +200,33 @@ static void pma_cnt_assign(struct ib_pma_portcounters *pma_cnt,
 			     vl_15_dropped);
 }

-static int process_pma_cmd(struct mlx5_core_dev *mdev, u8 port_num,
+static int process_pma_cmd(struct mlx5_ib_dev *dev, u8 port_num,
 			   const struct ib_mad *in_mad, struct ib_mad *out_mad)
 {
-	int err;
+	struct mlx5_core_dev *mdev;
+	bool native_port = true;
+	u8 mdev_port_num;
 	void *out_cnt;
+	int err;

+	mdev = mlx5_ib_get_native_port_mdev(dev, port_num, &mdev_port_num);
+	if (!mdev) {
+		/* Fail to get the native port, likely due to 2nd port is still
+		 * unaffiliated. In such case default to 1st port and attached
+		 * PF device.
+		 */
+		native_port = false;
+		mdev = dev->mdev;
+		mdev_port_num = 1;
+	}
 	/* Declaring support of extended counters */
 	if (in_mad->mad_hdr.attr_id == IB_PMA_CLASS_PORT_INFO) {
 		struct ib_class_port_info cpi = {};

 		cpi.capability_mask = IB_PMA_CLASS_CAP_EXT_WIDTH;
 		memcpy((out_mad->data + 40), &cpi, sizeof(cpi));
-		return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY;
+		err = IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY;
+		goto done;
 	}

 	if (in_mad->mad_hdr.attr_id == IB_PMA_PORT_COUNTERS_EXT) {
@@ -221,11 +235,13 @@ static int process_pma_cmd(struct mlx5_core_dev *mdev, u8 port_num,
 		int sz = MLX5_ST_SZ_BYTES(query_vport_counter_out);

 		out_cnt = kvzalloc(sz, GFP_KERNEL);
-		if (!out_cnt)
-			return IB_MAD_RESULT_FAILURE;
+		if (!out_cnt) {
+			err = IB_MAD_RESULT_FAILURE;
+			goto done;
+		}

 		err = mlx5_core_query_vport_counter(mdev, 0, 0,
-						    port_num, out_cnt, sz);
+						    mdev_port_num, out_cnt, sz);
 		if (!err)
 			pma_cnt_ext_assign(pma_cnt_ext, out_cnt);
 	} else {
@@ -234,20 +250,23 @@ static int process_pma_cmd(struct mlx5_core_dev *mdev, u8 port_num,
 		int sz = MLX5_ST_SZ_BYTES(ppcnt_reg);

 		out_cnt = kvzalloc(sz, GFP_KERNEL);
-		if (!out_cnt)
-			return IB_MAD_RESULT_FAILURE;
+		if (!out_cnt) {
+			err = IB_MAD_RESULT_FAILURE;
+			goto done;
+		}

-		err = mlx5_core_query_ib_ppcnt(mdev, port_num,
+		err = mlx5_core_query_ib_ppcnt(mdev, mdev_port_num,
 					       out_cnt, sz);
 		if (!err)
 			pma_cnt_assign(pma_cnt, out_cnt);
-		}
-
+	}
 	kvfree(out_cnt);
-	if (err)
-		return IB_MAD_RESULT_FAILURE;
-
-	return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY;
+	err = err ? IB_MAD_RESULT_FAILURE :
+		    IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY;
+done:
+	if (native_port)
+		mlx5_ib_put_native_port_mdev(dev, port_num);
+	return err;
 }

 int mlx5_ib_process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,
@@ -259,8 +278,6 @@ int mlx5_ib_process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,
 	struct mlx5_ib_dev *dev = to_mdev(ibdev);
 	const struct ib_mad *in_mad = (const struct ib_mad *)in;
 	struct ib_mad *out_mad = (struct ib_mad *)out;
-	struct mlx5_core_dev *mdev;
-	u8 mdev_port_num;
 	int ret;

 	if (WARN_ON_ONCE(in_mad_size != sizeof(*in_mad) ||
@@ -269,19 +286,14 @@ int mlx5_ib_process_mad(struct ib_device *ibdev, int mad_flags, u8 port_num,

 	memset(out_mad->data, 0, sizeof(out_mad->data));

-	mdev = mlx5_ib_get_native_port_mdev(dev, port_num, &mdev_port_num);
-	if (!mdev)
-		return IB_MAD_RESULT_FAILURE;
-
-	if (MLX5_CAP_GEN(mdev, vport_counters) &&
+	if (MLX5_CAP_GEN(dev->mdev, vport_counters) &&
 	    in_mad->mad_hdr.mgmt_class == IB_MGMT_CLASS_PERF_MGMT &&
 	    in_mad->mad_hdr.method == IB_MGMT_METHOD_GET) {
-		ret = process_pma_cmd(mdev, mdev_port_num, in_mad, out_mad);
+		ret = process_pma_cmd(dev, port_num, in_mad, out_mad);
 	} else {
 		ret =  process_mad(ibdev, mad_flags, port_num, in_wc, in_grh,
 				   in_mad, out_mad);
 	}
-	mlx5_ib_put_native_port_mdev(dev, port_num);
 	return ret;
 }

--
2.20.1

