Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6D1584994
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 12:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbfHGKcB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 06:32:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51437 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfHGKbx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Aug 2019 06:31:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so81290063wma.1
        for <linux-rdma@vger.kernel.org>; Wed, 07 Aug 2019 03:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B9IXh6K9ct1sBmNyIzi/5lecswjgE0r1IjZnFRecAr8=;
        b=s2Gt82Uca32k5CpZkyvnMZ1ahN+Av5EqYD32l7oYMtTznsJ/qpjCyK/v3B9kerBnnA
         Ry4/74DRbmWd885B3zNRpxszNGO/7jF9clilB+LkKoCUwse5Ho22jFL2Hju7pEVhA9L9
         lDR7fnBZx9wqBJJVxgkzsWX2N0a0bU7KGnyVFcDQjNPLdQKCoOT/cWhb4LQaG2Zus3HG
         UKnCKsB46hF57wksEDnAT2xAaMyXcsh3IPZM/z/lG7MXek6cQeSGHKVY1Z0YW3mppuc8
         69xEp+JezEi10UEShNzKV1eD7RFrEDGy7QO4HguNb2o2sEjLAcJDHr5wGkQnbVPHpwKm
         tgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B9IXh6K9ct1sBmNyIzi/5lecswjgE0r1IjZnFRecAr8=;
        b=cMRJDvZjTrCfK+6v0K1z1ieE4a/vUCtaZjktAlfzaTbKydv6ZF+OpPhJum2//uL9tW
         rkjnoyZ/olAeyMerYPL1a+z3X0rP6tHMsS9NB1x7Fw7midKeW0c/uMB/Y0umtnu18xmn
         1R4m/91N35BFeEHh5mYyMFWa2srkPjTawSw6bBTzZmubkTENw7FxyRRZma9kQxOea1Sj
         4pWpwqHF1U5l0ZvF6PfW383878ksrO0Mf56Ag8EqB/BEEZnaNxMvpFsm4TlQj+WZ+pQY
         EhtIeKkrY/7iUp5PSjTVy8kpTI4/ao5aOPYNgogzeglqZCRXvsBk9XdgZkfaMRyx1eXB
         EtLQ==
X-Gm-Message-State: APjAAAXC7fFuypC35Hx7e3xDJ5STzuKb6FhhJo+JpVoFjfoxqfycRGRA
        0ylCsooMF1auh4dlGIGsMuCpTpET8k4=
X-Google-Smtp-Source: APXvYqyziqLBRyuwa2mv2/Bvm65I/JKEVZZpd48wnsWNr+9O1AbtVh4QrWoxq96XNW+nZD8+og64PQ==
X-Received: by 2002:a7b:c215:: with SMTP id x21mr10105812wmi.38.1565173910137;
        Wed, 07 Aug 2019 03:31:50 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-109-66-104-187.red.bezeqint.net. [109.66.104.187])
        by smtp.gmail.com with ESMTPSA id o3sm79713845wrs.59.2019.08.07.03.31.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 03:31:49 -0700 (PDT)
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
        Kamal Heib <kamalheib1@gmail.com>,
        Michal Kalderon <michal.kalderon@marvell.com>
Subject: [PATCH for-next V4 1/4] RDMA: Introduce ib_port_phys_state enum
Date:   Wed,  7 Aug 2019 13:31:35 +0300
Message-Id: <20190807103138.17219-2-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807103138.17219-1-kamalheib1@gmail.com>
References: <20190807103138.17219-1-kamalheib1@gmail.com>
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
Acked-by: Michal Kalderon <michal.kalderon@marvell.com>
Acked-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/core/sysfs.c              | 30 +++++++++++++-------
 drivers/infiniband/hw/bnxt_re/ib_verbs.c     |  4 +--
 drivers/infiniband/hw/efa/efa_verbs.c        |  2 +-
 drivers/infiniband/hw/hns/hns_roce_device.h  | 10 -------
 drivers/infiniband/hw/hns/hns_roce_main.c    |  3 +-
 drivers/infiniband/hw/mlx4/main.c            |  3 +-
 drivers/infiniband/hw/mlx5/main.c            |  4 +--
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c  |  4 +--
 drivers/infiniband/hw/qedr/verbs.c           |  4 +--
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c |  7 +++--
 drivers/infiniband/sw/rxe/rxe.h              |  4 ---
 drivers/infiniband/sw/rxe/rxe_param.h        |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c        |  6 ++--
 drivers/infiniband/sw/siw/siw_verbs.c        |  3 +-
 include/rdma/ib_verbs.h                      | 10 +++++++
 15 files changed, 53 insertions(+), 43 deletions(-)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index b477295a96c2..a0cb33943510 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -289,6 +289,24 @@ static ssize_t rate_show(struct ib_port *p, struct port_attribute *unused,
 		       ib_width_enum_to_int(attr.active_width), speed);
 }
 
+static const char *phys_state_to_str(enum ib_port_phys_state phys_state)
+{
+	static const char * phys_state_str[] = {
+		"Unknown",
+		"Sleep",
+		"Polling",
+		"Disabled",
+		"PortConfigurationTraining",
+		"LinkUp",
+		"LinkErrorRecovery",
+		"PhyTest",
+	};
+
+	if (phys_state < ARRAY_SIZE(phys_state_str))
+		return phys_state_str[phys_state];
+	return "Unknown";
+}
+
 static ssize_t phys_state_show(struct ib_port *p, struct port_attribute *unused,
 			       char *buf)
 {
@@ -300,16 +318,8 @@ static ssize_t phys_state_show(struct ib_port *p, struct port_attribute *unused,
 	if (ret)
 		return ret;
 
-	switch (attr.phys_state) {
-	case 1:  return sprintf(buf, "1: Sleep\n");
-	case 2:  return sprintf(buf, "2: Polling\n");
-	case 3:  return sprintf(buf, "3: Disabled\n");
-	case 4:  return sprintf(buf, "4: PortConfigurationTraining\n");
-	case 5:  return sprintf(buf, "5: LinkUp\n");
-	case 6:  return sprintf(buf, "6: LinkErrorRecovery\n");
-	case 7:  return sprintf(buf, "7: Phy Test\n");
-	default: return sprintf(buf, "%d: <unknown>\n", attr.phys_state);
-	}
+	return sprintf(buf, "%d: %s\n", attr.phys_state,
+		       phys_state_to_str(attr.phys_state));
 }
 
 static ssize_t link_layer_show(struct ib_port *p, struct port_attribute *unused,
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

