Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97442F8B8D
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2019 10:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbfKLJR4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Nov 2019 04:17:56 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:39380 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfKLJRz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Nov 2019 04:17:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1573550274; x=1605086274;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9WsgdDuZaxfUao+gPg25tcZR1QXf5y4ELsLVQXSfW50=;
  b=fpuYl0ojHbrOkViFySlcLVeLm7IWApd8w8eyzfSt03LnDVcPQAuxD9St
   Q/VrC/0TXeGxe4njWI9G5oGYka2O2Ijix3Zk4xMWNEJAsD6JMLxjwkF1U
   MDKJhPoF9CPm/zjtw4ics8l/XaEENASwoaTHSpxJtixQZ2aNsIjY1n8hB
   s=;
IronPort-SDR: 9B4ubGWnmD+F2gRzmHVUe/xDPrf9pzHpRsi8xTAUfm+PZwokq95+eXdUUzTna0hX3BqtxjX1b/
 bg8P7B3BnKHQ==
X-IronPort-AV: E=Sophos;i="5.68,295,1569283200"; 
   d="scan'208";a="3939248"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-8549039f.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 12 Nov 2019 09:17:53 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-8549039f.us-west-2.amazon.com (Postfix) with ESMTPS id C7C2EA1B7E;
        Tue, 12 Nov 2019 09:17:51 +0000 (UTC)
Received: from EX13D19EUA003.ant.amazon.com (10.43.165.175) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Nov 2019 09:17:51 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D19EUA003.ant.amazon.com (10.43.165.175) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Nov 2019 09:17:50 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.136) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 12 Nov 2019 09:17:47 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>,
        "Daniel Kranzdorf" <dkkranzd@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: [PATCH for-next 1/3] RDMA/efa: Store network attributes in device attributes
Date:   Tue, 12 Nov 2019 11:17:35 +0200
Message-ID: <20191112091737.40204-2-galpress@amazon.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112091737.40204-1-galpress@amazon.com>
References: <20191112091737.40204-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There's no reason to separate the network attributes from all other
device attributes. Embed the fields inside the device attributes and
query them all in one function.

Reviewed-by: Daniel Kranzdorf <dkkranzd@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa.h         |  2 --
 drivers/infiniband/hw/efa/efa_com_cmd.c | 34 +++++++++----------------
 drivers/infiniband/hw/efa/efa_com_cmd.h |  9 ++-----
 drivers/infiniband/hw/efa/efa_main.c    | 16 ------------
 drivers/infiniband/hw/efa/efa_verbs.c   |  8 +++---
 5 files changed, 18 insertions(+), 51 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index 2bda07078b97..aa7396a1588a 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -60,8 +60,6 @@ struct efa_dev {
 	u64 mem_bar_len;
 	u64 db_bar_addr;
 	u64 db_bar_len;
-	u8 addr[EFA_GID_SIZE];
-	u32 mtu;
 
 	int admin_msix_vector_idx;
 	struct efa_irq admin_irq;
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index c079f1332082..4713c2756ad3 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -423,28 +423,6 @@ static int efa_com_get_feature(struct efa_com_dev *edev,
 	return efa_com_get_feature_ex(edev, get_resp, feature_id, 0, 0);
 }
 
-int efa_com_get_network_attr(struct efa_com_dev *edev,
-			     struct efa_com_get_network_attr_result *result)
-{
-	struct efa_admin_get_feature_resp resp;
-	int err;
-
-	err = efa_com_get_feature(edev, &resp,
-				  EFA_ADMIN_NETWORK_ATTR);
-	if (err) {
-		ibdev_err_ratelimited(edev->efa_dev,
-				      "Failed to get network attributes %d\n",
-				      err);
-		return err;
-	}
-
-	memcpy(result->addr, resp.u.network_attr.addr,
-	       sizeof(resp.u.network_attr.addr));
-	result->mtu = resp.u.network_attr.mtu;
-
-	return 0;
-}
-
 int efa_com_get_device_attr(struct efa_com_dev *edev,
 			    struct efa_com_get_device_attr_result *result)
 {
@@ -501,6 +479,18 @@ int efa_com_get_device_attr(struct efa_com_dev *edev,
 	result->max_llq_size = resp.u.queue_attr.max_llq_size;
 	result->sub_cqs_per_cq = resp.u.queue_attr.sub_cqs_per_cq;
 
+	err = efa_com_get_feature(edev, &resp, EFA_ADMIN_NETWORK_ATTR);
+	if (err) {
+		ibdev_err_ratelimited(edev->efa_dev,
+				      "Failed to get network attributes %d\n",
+				      err);
+		return err;
+	}
+
+	memcpy(result->addr, resp.u.network_attr.addr,
+	       sizeof(resp.u.network_attr.addr));
+	result->mtu = resp.u.network_attr.mtu;
+
 	return 0;
 }
 
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.h b/drivers/infiniband/hw/efa/efa_com_cmd.h
index 7f6c13052f49..6134d13ecc6f 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.h
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.h
@@ -100,14 +100,11 @@ struct efa_com_destroy_ah_params {
 	u16 pdn;
 };
 
-struct efa_com_get_network_attr_result {
-	u8 addr[EFA_GID_SIZE];
-	u32 mtu;
-};
-
 struct efa_com_get_device_attr_result {
+	u8 addr[EFA_GID_SIZE];
 	u64 page_size_cap;
 	u64 max_mr_pages;
+	u32 mtu;
 	u32 fw_version;
 	u32 admin_api_version;
 	u32 device_version;
@@ -271,8 +268,6 @@ int efa_com_create_ah(struct efa_com_dev *edev,
 		      struct efa_com_create_ah_result *result);
 int efa_com_destroy_ah(struct efa_com_dev *edev,
 		       struct efa_com_destroy_ah_params *params);
-int efa_com_get_network_attr(struct efa_com_dev *edev,
-			     struct efa_com_get_network_attr_result *result);
 int efa_com_get_device_attr(struct efa_com_dev *edev,
 			    struct efa_com_get_device_attr_result *result);
 int efa_com_get_hw_hints(struct efa_com_dev *edev,
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 0e3050d01b75..faf3ff1bca2a 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -30,15 +30,6 @@ MODULE_DEVICE_TABLE(pci, efa_pci_tbl);
 	(BIT(EFA_ADMIN_FATAL_ERROR) | BIT(EFA_ADMIN_WARNING) | \
 	 BIT(EFA_ADMIN_NOTIFICATION) | BIT(EFA_ADMIN_KEEP_ALIVE))
 
-static void efa_update_network_attr(struct efa_dev *dev,
-				    struct efa_com_get_network_attr_result *network_attr)
-{
-	memcpy(dev->addr, network_attr->addr, sizeof(network_attr->addr));
-	dev->mtu = network_attr->mtu;
-
-	dev_dbg(&dev->pdev->dev, "Full address %pI6\n", dev->addr);
-}
-
 /* This handler will called for unknown event group or unimplemented handlers */
 static void unimplemented_aenq_handler(void *data,
 				       struct efa_admin_aenq_entry *aenq_e)
@@ -234,7 +225,6 @@ static const struct ib_device_ops efa_dev_ops = {
 
 static int efa_ib_device_add(struct efa_dev *dev)
 {
-	struct efa_com_get_network_attr_result network_attr;
 	struct efa_com_get_hw_hints_result hw_hints;
 	struct pci_dev *pdev = dev->pdev;
 	int err;
@@ -250,12 +240,6 @@ static int efa_ib_device_add(struct efa_dev *dev)
 	if (err)
 		return err;
 
-	err = efa_com_get_network_attr(&dev->edev, &network_attr);
-	if (err)
-		goto err_release_doorbell_bar;
-
-	efa_update_network_attr(dev, &network_attr);
-
 	err = efa_com_get_hw_hints(&dev->edev, &hw_hints);
 	if (err)
 		goto err_release_doorbell_bar;
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index b242ea7a3bc8..0d09b365be48 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -232,9 +232,9 @@ int efa_query_port(struct ib_device *ibdev, u8 port,
 	props->pkey_tbl_len = 1;
 	props->active_speed = IB_SPEED_EDR;
 	props->active_width = IB_WIDTH_4X;
-	props->max_mtu = ib_mtu_int_to_enum(dev->mtu);
-	props->active_mtu = ib_mtu_int_to_enum(dev->mtu);
-	props->max_msg_sz = dev->mtu;
+	props->max_mtu = ib_mtu_int_to_enum(dev->dev_attr.mtu);
+	props->active_mtu = ib_mtu_int_to_enum(dev->dev_attr.mtu);
+	props->max_msg_sz = dev->dev_attr.mtu;
 	props->max_vl_num = 1;
 
 	return 0;
@@ -295,7 +295,7 @@ int efa_query_gid(struct ib_device *ibdev, u8 port, int index,
 {
 	struct efa_dev *dev = to_edev(ibdev);
 
-	memcpy(gid->raw, dev->addr, sizeof(dev->addr));
+	memcpy(gid->raw, dev->dev_attr.addr, sizeof(dev->dev_attr.addr));
 
 	return 0;
 }
-- 
2.23.0

