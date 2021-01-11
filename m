Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1242F18FF
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Jan 2021 15:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbhAKO6s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Jan 2021 09:58:48 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12508 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730240AbhAKO6s (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Jan 2021 09:58:48 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ffc677f0002>; Mon, 11 Jan 2021 06:58:07 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 11 Jan
 2021 14:58:07 +0000
Received: from r-nvmx02.mtr.labs.mlnx (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 11 Jan 2021 14:58:04 +0000
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <dledford@redhat.com>,
        <jgg@nvidia.com>, <leonro@nvidia.com>, <sagi@grimberg.me>
CC:     <oren@nvidia.com>, <nitzanc@nvidia.com>, <sergeygo@nvidia.com>,
        <ngottlieb@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
        Israel Rukshin <israelr@nvidia.com>
Subject: [PATCH 3/4] IB/iser: enforce iser_max_sectors to be greater than 0
Date:   Mon, 11 Jan 2021 14:57:53 +0000
Message-ID: <20210111145754.56727-4-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210111145754.56727-1-mgurtovoy@nvidia.com>
References: <20210111145754.56727-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610377087; bh=ONJJB7ka4j717LmBK3cK6XlUOYmcdnDnEcXBgBjNaBU=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        b=DsfhoBf/LBpnbpojPRpimxWTy9e4J4i+p47diLhF33SyVFGmkGE9kZqhbbhP1O3CY
         UX7GIXGDVOZOoLjR5yR0zc4JD75mULOmSvA+2DczP9se+al7+JmVBhEWVDnyrOw7eq
         SYdjeqf+tAFtb5tAmwK2MvZTA2WJEFW0q51SlLPAUWKgTL7L44Y6zLzTmX64g/z9zV
         OfTrWt/zPGfV257/7O3jYVb58UivrZBPoFH+YXciMbaeuKQ92cRzUg8arkVKozW8Ap
         TkCsxsyOrHsc/+9KOxo6/JJMsmaLRJGC5YRKcLPb2uUtsvS7xE26+WEwAWg6gBfbwb
         5woVsGj2jdg4Q==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

A value of 0 will casue the driver to fail establishing a valid
connection to remote target.

The following can be seen in the log in this case:
"
iser: iser_connect: connecting to: 1.1.1.88:3260
iser: iser_cma_handler: address resolved (0): status 0 conn 00000000090aa4d=
e id 00000000167d3b5a
iser: iser_cma_handler: route resolved  (2): status 0 conn 00000000090aa4de=
 id 00000000167d3b5a
iser: iscsi_iser_ep_poll: iser conn 00000000090aa4de rc =3D 0
iser: iser_create_ib_conn_res: setting conn 00000000090aa4de cma_id 0000000=
0167d3b5a qp 00000000efa80660 max_send_wr 4619
iser_cma_handler: established (9): status 0 conn 00000000090aa4de id 000000=
00167d3b5a
iser: iser_connected_handler: remote qpn:1c7 my qpn:1c6
iser: iser_connected_handler: conn 00000000090aa4de: negotiated remote inva=
lidation
iser: iscsi_iser_ep_poll: iser conn 00000000090aa4de rc =3D 1
scsi host10: iSCSI Initiator over iSER
mlx5_core 0000:07:00.0: mlx5_cmd_check:769:(pid 616473): CREATE_MKEY(0x200)=
 op_mod(0x0) failed, status bad parameter(0x3), syndrome (0x3bf6f)
iser: iser_create_fastreg_desc: Failed to allocate ib_fast_reg_mr err=3D-22
iser: iser_alloc_rx_descriptors: failed allocating rx descriptors / data bu=
ffers
iser: iscsi_iser_ep_disconnect: ep 00000000d2040785 iser conn 00000000090aa=
4de
iser: iser_conn_terminate: iser_conn 00000000090aa4de state 3
iser: iser_free_ib_conn_res: freeing conn 00000000090aa4de cma_id 000000001=
67d3b5a qp 00000000efa80660
iser: iser_device_try_release: device 00000000dc871b1b refcount 0
"

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/infiniband/ulp/iser/iscsi_iser.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/=
ulp/iser/iscsi_iser.c
index 906f52873d63..fcfdeb5dea42 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.c
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
@@ -100,8 +100,9 @@ module_param_cb(max_lun, &iscsi_iser_size_ops, &iscsi_m=
ax_lun, S_IRUGO);
 MODULE_PARM_DESC(max_lun, "Max LUNs to allow per session, should > 0 (defa=
ult:512)");
=20
 unsigned int iser_max_sectors =3D ISER_DEF_MAX_SECTORS;
-module_param_named(max_sectors, iser_max_sectors, uint, S_IRUGO | S_IWUSR)=
;
-MODULE_PARM_DESC(max_sectors, "Max number of sectors in a single scsi comm=
and (default:1024");
+module_param_cb(max_sectors, &iscsi_iser_size_ops, &iser_max_sectors,
+		S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(max_sectors, "Max number of sectors in a single scsi comm=
and, should > 0 (default:1024)");
=20
 bool iser_always_reg =3D true;
 module_param_named(always_register, iser_always_reg, bool, S_IRUGO);
--=20
2.25.4

