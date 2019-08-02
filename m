Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2CD57F0C6
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2019 11:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391212AbfHBJc2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Aug 2019 05:32:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40863 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391224AbfHBJc1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Aug 2019 05:32:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id r1so76422094wrl.7
        for <linux-rdma@vger.kernel.org>; Fri, 02 Aug 2019 02:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QHseks1UrCm+cqNT+WObBFJrUbAEEcKpGWLndko7VnY=;
        b=kkZxtdhL6T0r3H6qS/KZ78ymbfC0dFrO75yxg7Bgym0NjKDTcecRGMpG/b+lhFVtTF
         4ia2VKZnRGK6di72oryKG4bLckQ7MZSn5wsV0QBiCITPHLEKgSFixHrxcaIDrAZBGNJ9
         90mKkt6J0HvnHgdHrBINtnWAmQ9mdXmOgDI3AlkscftFNna8XuqZq0J4DPsUZlZyfBwM
         JGNfX/BOp7W0WcjURcoBNm2P2DiJ0Lz6h5KHhK4FLPCM4msXdh/z2LeXj5m064/ZlkoY
         0OhhAiIKeNxfCKgfONScPivxA7WKi4lddbX8pyhJFm1RnZyByxgtIXCkNR23bGCTvb2h
         0rzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QHseks1UrCm+cqNT+WObBFJrUbAEEcKpGWLndko7VnY=;
        b=niwUu3a/PpyLW9VAXCvYsrtuVhkowsV/mBaVAflAIWHo7Ed0LDws6n5HP0S2XzaCsQ
         pt+AbhGBTfGO2jM6VmOAdv7jLIt2seMB8y8x2oDhPu2Ct6ae3n15iizmbcJtOdPceI52
         IFBPvHRHQOd6PXLyVrwubRQl9SC6HWx0pfJqCBDKEUdEhB3QdNK3MVcECw9gVsTRcQLL
         kDSfVWraw+ET3Wik/PPiJT9mqPl2uxpR4MlBA+qSaF8VHyy/BIVnrwe1WlnM9I46O5jm
         Xj1+ccwUNfWQebj1hgKMg2KdjVxAy6iyVfzjtCt/okNzGfbekYblRgXCZQ2KEkBUgJOu
         09FA==
X-Gm-Message-State: APjAAAVYUCWF+HCtG9zCg9rNJTmAhE/Xl8cQ+3O0cQhjJ7fmqfVQEEbl
        AQxN/KyWEsr5PuN4egxm7V9NpPJb
X-Google-Smtp-Source: APXvYqy1LUsUeqgTQNwgRGivQ4IlKY/Sgn1IREfsmqb8JH4SRqEfirtgYgTlpo/XTg3WViPo3jIviw==
X-Received: by 2002:adf:d08e:: with SMTP id y14mr116582127wrh.309.1564738344612;
        Fri, 02 Aug 2019 02:32:24 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-109-65-15-211.red.bezeqint.net. [109.65.15.211])
        by smtp.gmail.com with ESMTPSA id w23sm80651404wmi.45.2019.08.02.02.32.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 02:32:24 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leon@kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        Moni Shoua <monis@mellanox.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Andrew Boyer <aboyer@tobark.org>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next V3 1/4] RDMA: Introduce ib_port_phys_state enum
Date:   Fri,  2 Aug 2019 12:32:07 +0300
Message-Id: <20190802093210.5705-2-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802093210.5705-1-kamalheib1@gmail.com>
References: <20190802093210.5705-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In order to improve readability, add ib_port_phys_state enum to replace
the use of magic numbers.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
Reviewed-by: Andrew Boyer <aboyer@tobark.org>
---
 drivers/infiniband/core/sysfs.c              | 24 +++++++++++++-------
 drivers/infiniband/hw/bnxt_re/ib_verbs.c     |  4 ++--
 drivers/infiniband/hw/efa/efa_verbs.c        |  2 +-
 drivers/infiniband/hw/hns/hns_roce_device.h  | 10 --------
 drivers/infiniband/hw/hns/hns_roce_main.c    |  3 ++-
 drivers/infiniband/hw/mlx4/main.c            |  3 ++-
 drivers/infiniband/hw/mlx5/main.c            |  4 ++--
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c  |  4 ++--
 drivers/infiniband/hw/qedr/verbs.c           |  4 ++--
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c |  7 +++---
 drivers/infiniband/sw/rxe/rxe.h              |  4 ----
 drivers/infiniband/sw/rxe/rxe_param.h        |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c        |  6 ++---
 drivers/infiniband/sw/siw/siw_verbs.c        |  3 ++-
 include/rdma/ib_verbs.h                      | 10 ++++++++
 15 files changed, 49 insertions(+), 41 deletions(-)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index b477295a96c2..46722e04f6e1 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -301,14 +301,22 @@ static ssize_t phys_state_show(struct ib_port *p, struct port_attribute *unused,
 		return ret;
 
 	switch (attr.phys_state) {
-	case 1:  return sprintf(buf, "1: Sleep\n");
-	case 2:  return sprintf(buf, "2: Polling\n");
-	case 3:  return sprintf(buf, "3: Disabled\n");
-	case 4:  return sprintf(buf, "4: PortConfigurationTraining\n");
-	case 5:  return sprintf(buf, "5: LinkUp\n");
-	case 6:  return sprintf(buf, "6: LinkErrorRecovery\n");
-	case 7:  return sprintf(buf, "7: Phy Test\n");
-	default: return sprintf(buf, "%d: <unknown>\n", attr.phys_state);
+	case IB_PORT_PHYS_STATE_SLEEP:
+		return sprintf(buf, "1: Sleep\n");
+	case IB_PORT_PHYS_STATE_POLLING:
+		return sprintf(buf, "2: Polling\n");
+	case IB_PORT_PHYS_STATE_DISABLED:
+		return sprintf(buf, "3: Disabled\n");
+	case IB_PORT_PHYS_STATE_PORT_CONFIGURATION_TRAINING:
+		return sprintf(buf, "4: PortConfigurationTraining\n");
+	case IB_PORT_PHYS_STATE_LINK_UP:
+		return sprintf(buf, "5: LinkUp\n");
+	case IB_PORT_PHYS_STATE_LINK_ERROR_RECOVERY:
+		return sprintf(buf, "6: LinkErrorRecovery\n");
+	case IB_PORT_PHYS_STATE_PHY_TEST:
+		return sprintf(buf, "7: Phy Test\n");
+	default:
+		return sprintf(buf, "%d: <unknown>\n", attr.phys_state);
 	}
 }
 
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 098ab883733e..f9e97d0cc459 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -220,10 +220,10 @@ int bnxt_re_query_port(struct ib_device *ibdev, u8 port_num,
 
 	if (netif_running(rdev->netdev) && netif_carrier_ok(rdev->netdev)) {
 		port_attr->state = IB_PORT_ACTIVE;
-		port_attr->phys_state = 5;
+		port_attr->phys_state = IB_PORT_PHYS_STATE_LINK_UP;
 	} else {
 		port_attr->state = IB_PORT_DOWN;
-		port_attr->phys_state = 3;
+		port_attr->phys_state = IB_PORT_PHYS_STATE_DISABLED;
 	}
 	port_attr->max_mtu = IB_MTU_4096;
 	port_attr->active_mtu = iboe_get_mtu(rdev->netdev->mtu);
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 32d3b3deabce..70851bd7f801 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -333,7 +333,7 @@ int efa_query_port(struct ib_device *ibdev, u8 port,
 	props->lmc = 1;
 
 	props->state = IB_PORT_ACTIVE;
-	props->phys_state = 5;
+	props->phys_state = IB_PORT_PHYS_STATE_LINK_UP;
 	props->gid_tbl_len = 1;
 	props->pkey_tbl_len = 1;
 	props->active_speed = IB_SPEED_EDR;
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index b39497a13b61..12a2b8565771 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -989,16 +989,6 @@ struct hns_roce_hw {
 	const struct ib_device_ops *hns_roce_dev_srq_ops;
 };
 
-enum hns_phy_state {
-	HNS_ROCE_PHY_SLEEP		= 1,
-	HNS_ROCE_PHY_POLLING		= 2,
-	HNS_ROCE_PHY_DISABLED		= 3,
-	HNS_ROCE_PHY_TRAINING		= 4,
-	HNS_ROCE_PHY_LINKUP		= 5,
-	HNS_ROCE_PHY_LINKERR		= 6,
-	HNS_ROCE_PHY_TEST		= 7
-};
-
 struct hns_roce_dev {
 	struct ib_device	ib_dev;
 	struct platform_device  *pdev;
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 1e4ba48f5613..1b757cc924c3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -262,7 +262,8 @@ static int hns_roce_query_port(struct ib_device *ib_dev, u8 port_num,
 	props->state = (netif_running(net_dev) && netif_carrier_ok(net_dev)) ?
 			IB_PORT_ACTIVE : IB_PORT_DOWN;
 	props->phys_state = (props->state == IB_PORT_ACTIVE) ?
-			     HNS_ROCE_PHY_LINKUP : HNS_ROCE_PHY_DISABLED;
+			     IB_PORT_PHYS_STATE_LINK_UP :
+			     IB_PORT_PHYS_STATE_DISABLED;
 
 	spin_unlock_irqrestore(&hr_dev->iboe.lock, flags);
 
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 8790101facb7..8d2f1e38b891 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -734,7 +734,8 @@ static int ib_link_query_port(struct ib_device *ibdev, u8 port,
 
 static u8 state_to_phys_state(enum ib_port_state state)
 {
-	return state == IB_PORT_ACTIVE ? 5 : 3;
+	return state == IB_PORT_ACTIVE ?
+		IB_PORT_PHYS_STATE_LINK_UP : IB_PORT_PHYS_STATE_DISABLED;
 }
 
 static int eth_link_query_port(struct ib_device *ibdev, u8 port,
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 4a3d700cd783..af1986b4aa7d 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -535,7 +535,7 @@ static int mlx5_query_port_roce(struct ib_device *device, u8 port_num,
 	props->max_msg_sz       = 1 << MLX5_CAP_GEN(dev->mdev, log_max_msg);
 	props->pkey_tbl_len     = 1;
 	props->state            = IB_PORT_DOWN;
-	props->phys_state       = 3;
+	props->phys_state       = IB_PORT_PHYS_STATE_DISABLED;
 
 	mlx5_query_nic_vport_qkey_viol_cntr(mdev, &qkey_viol_cntr);
 	props->qkey_viol_cntr = qkey_viol_cntr;
@@ -561,7 +561,7 @@ static int mlx5_query_port_roce(struct ib_device *device, u8 port_num,
 
 	if (netif_running(ndev) && netif_carrier_ok(ndev)) {
 		props->state      = IB_PORT_ACTIVE;
-		props->phys_state = 5;
+		props->phys_state = IB_PORT_PHYS_STATE_LINK_UP;
 	}
 
 	ndev_ib_mtu = iboe_get_mtu(ndev->mtu);
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index bccc11378109..e8267e590772 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -163,10 +163,10 @@ int ocrdma_query_port(struct ib_device *ibdev,
 	netdev = dev->nic_info.netdev;
 	if (netif_running(netdev) && netif_oper_up(netdev)) {
 		port_state = IB_PORT_ACTIVE;
-		props->phys_state = 5;
+		props->phys_state = IB_PORT_PHYS_STATE_LINK_UP;
 	} else {
 		port_state = IB_PORT_DOWN;
-		props->phys_state = 3;
+		props->phys_state = IB_PORT_PHYS_STATE_DISABLED;
 	}
 	props->max_mtu = IB_MTU_4096;
 	props->active_mtu = iboe_get_mtu(netdev->mtu);
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 0c6a4bc848f5..6f3ce86019b7 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -221,10 +221,10 @@ int qedr_query_port(struct ib_device *ibdev, u8 port, struct ib_port_attr *attr)
 	/* *attr being zeroed by the caller, avoid zeroing it here */
 	if (rdma_port->port_state == QED_RDMA_PORT_UP) {
 		attr->state = IB_PORT_ACTIVE;
-		attr->phys_state = 5;
+		attr->phys_state = IB_PORT_PHYS_STATE_LINK_UP;
 	} else {
 		attr->state = IB_PORT_DOWN;
-		attr->phys_state = 3;
+		attr->phys_state = IB_PORT_PHYS_STATE_DISABLED;
 	}
 	attr->max_mtu = IB_MTU_4096;
 	attr->active_mtu = iboe_get_mtu(dev->ndev->mtu);
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index a354c7c86547..556b8e44a51c 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -356,13 +356,14 @@ int usnic_ib_query_port(struct ib_device *ibdev, u8 port,
 
 	if (!us_ibdev->ufdev->link_up) {
 		props->state = IB_PORT_DOWN;
-		props->phys_state = 3;
+		props->phys_state = IB_PORT_PHYS_STATE_DISABLED;
 	} else if (!us_ibdev->ufdev->inaddr) {
 		props->state = IB_PORT_INIT;
-		props->phys_state = 4;
+		props->phys_state =
+			IB_PORT_PHYS_STATE_PORT_CONFIGURATION_TRAINING;
 	} else {
 		props->state = IB_PORT_ACTIVE;
-		props->phys_state = 5;
+		props->phys_state = IB_PORT_PHYS_STATE_LINK_UP;
 	}
 
 	props->port_cap_flags = 0;
diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index ecf6e659c0da..fb07eed9e402 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -65,10 +65,6 @@
  */
 #define RXE_UVERBS_ABI_VERSION		2
 
-#define RDMA_LINK_PHYS_STATE_LINK_UP	(5)
-#define RDMA_LINK_PHYS_STATE_DISABLED	(3)
-#define RDMA_LINK_PHYS_STATE_POLLING	(2)
-
 #define RXE_ROCE_V2_SPORT		(0xc000)
 
 static inline u32 rxe_crc32(struct rxe_dev *rxe,
diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 1abed47ca221..fe5207386700 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -154,7 +154,7 @@ enum rxe_port_param {
 	RXE_PORT_ACTIVE_WIDTH		= IB_WIDTH_1X,
 	RXE_PORT_ACTIVE_SPEED		= 1,
 	RXE_PORT_PKEY_TBL_LEN		= 64,
-	RXE_PORT_PHYS_STATE		= 2,
+	RXE_PORT_PHYS_STATE		= IB_PORT_PHYS_STATE_POLLING,
 	RXE_PORT_SUBNET_PREFIX		= 0xfe80000000000000ULL,
 };
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 4ebdfcf4d33e..623129f27f5a 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -69,11 +69,11 @@ static int rxe_query_port(struct ib_device *dev,
 			      &attr->active_width);
 
 	if (attr->state == IB_PORT_ACTIVE)
-		attr->phys_state = RDMA_LINK_PHYS_STATE_LINK_UP;
+		attr->phys_state = IB_PORT_PHYS_STATE_LINK_UP;
 	else if (dev_get_flags(rxe->ndev) & IFF_UP)
-		attr->phys_state = RDMA_LINK_PHYS_STATE_POLLING;
+		attr->phys_state = IB_PORT_PHYS_STATE_POLLING;
 	else
-		attr->phys_state = RDMA_LINK_PHYS_STATE_DISABLED;
+		attr->phys_state = IB_PORT_PHYS_STATE_DISABLED;
 
 	mutex_unlock(&rxe->usdev_lock);
 
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 32dc79d0e898..404e7ca4b30c 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -206,7 +206,8 @@ int siw_query_port(struct ib_device *base_dev, u8 port,
 	attr->gid_tbl_len = 1;
 	attr->max_msg_sz = -1;
 	attr->max_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
-	attr->phys_state = sdev->state == IB_PORT_ACTIVE ? 5 : 3;
+	attr->phys_state = sdev->state == IB_PORT_ACTIVE ?
+		IB_PORT_PHYS_STATE_LINK_UP : IB_PORT_PHYS_STATE_DISABLED;
 	attr->pkey_tbl_len = 1;
 	attr->port_cap_flags = IB_PORT_CM_SUP | IB_PORT_DEVICE_MGMT_SUP;
 	attr->state = sdev->state;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index c5f8a9f17063..27fe844cff42 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -451,6 +451,16 @@ enum ib_port_state {
 	IB_PORT_ACTIVE_DEFER	= 5
 };
 
+enum ib_port_phys_state {
+	IB_PORT_PHYS_STATE_SLEEP = 1,
+	IB_PORT_PHYS_STATE_POLLING = 2,
+	IB_PORT_PHYS_STATE_DISABLED = 3,
+	IB_PORT_PHYS_STATE_PORT_CONFIGURATION_TRAINING = 4,
+	IB_PORT_PHYS_STATE_LINK_UP = 5,
+	IB_PORT_PHYS_STATE_LINK_ERROR_RECOVERY = 6,
+	IB_PORT_PHYS_STATE_PHY_TEST = 7,
+};
+
 enum ib_port_width {
 	IB_WIDTH_1X	= 1,
 	IB_WIDTH_2X	= 16,
-- 
2.20.1

