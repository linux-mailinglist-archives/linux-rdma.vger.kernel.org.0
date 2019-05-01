Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3414510725
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2019 12:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfEAKs6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 May 2019 06:48:58 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:32512 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfEAKs6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 May 2019 06:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1556707737; x=1588243737;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=yZEkefTzM4/bNXe2lvTX4uyDnh3X4hdBELRaLkvxQ6c=;
  b=ZpA4xB85yhIuKjl2HEH6P/Fk37SPBnJ3HczDFHH/jwvsnML2e/u+WExM
   x9bSu74vm7dedr765x9xUfJWWIvHv2d9qMSiq+aqsfIfamEHVrFzju6TF
   1u/Msr4IPzsrDBQmi1R6XK8WKxfXdW9Q5lLweqy1ie84/kPRVGNbtbWxV
   8=;
X-IronPort-AV: E=Sophos;i="5.60,417,1549929600"; 
   d="scan'208";a="672042648"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 May 2019 10:48:54 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x41AmnbC080924
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 1 May 2019 10:48:50 GMT
Received: from EX13D04UWA001.ant.amazon.com (10.43.160.47) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 1 May 2019 10:48:40 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D04UWA001.ant.amazon.com (10.43.160.47) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 1 May 2019 10:48:39 +0000
Received: from galpress-VirtualBox.hfa16.amazon.com (10.218.62.21) by
 mail-relay.amazon.com (10.43.62.226) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Wed, 1 May 2019 10:48:36 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leah Shalev <shalevl@amazon.com>,
        Dave Goodell <goodell@amazon.com>,
        Brian Barrett <bbarrett@amazon.com>,
        <linux-rdma@vger.kernel.org>, Sean Hefty <sean.hefty@intel.com>,
        "Dennis Dalessandro" <dennis.dalessandro@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Steve Wise <larrystevenwise@gmail.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        "Gal Pressman" <galpress@amazon.com>
Subject: [PATCH for-next v6 02/12] RDMA: Add EFA related definitions
Date:   Wed, 1 May 2019 13:48:14 +0300
Message-ID: <1556707704-11192-3-git-send-email-galpress@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556707704-11192-1-git-send-email-galpress@amazon.com>
References: <1556707704-11192-1-git-send-email-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add EFA driver ID to the IOCTL interface uapi.
This patch also adds unspecified node/transport type that will be used
by EFA (usnic is left unchanged as it's already part of our ABI).

Signed-off-by: Gal Pressman <galpress@amazon.com>
Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
Reviewed-by: Steve Wise <swise@opengridcomputing.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/sysfs.c          | 1 +
 drivers/infiniband/core/verbs.c          | 2 ++
 include/rdma/ib_verbs.h                  | 4 +++-
 include/uapi/rdma/rdma_user_ioctl_cmds.h | 1 +
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 2fe89754e592..5af1c1171730 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -1196,6 +1196,7 @@ static ssize_t node_type_show(struct device *device,
 	case RDMA_NODE_RNIC:	  return sprintf(buf, "%d: RNIC\n", dev->node_type);
 	case RDMA_NODE_USNIC:	  return sprintf(buf, "%d: usNIC\n", dev->node_type);
 	case RDMA_NODE_USNIC_UDP: return sprintf(buf, "%d: usNIC UDP\n", dev->node_type);
+	case RDMA_NODE_UNSPECIFIED: return sprintf(buf, "%d: unspecified\n", dev->node_type);
 	case RDMA_NODE_IB_SWITCH: return sprintf(buf, "%d: switch\n", dev->node_type);
 	case RDMA_NODE_IB_ROUTER: return sprintf(buf, "%d: router\n", dev->node_type);
 	default:		  return sprintf(buf, "%d: <unknown>\n", dev->node_type);
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 7313edc9f091..05657aea585d 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -218,6 +218,8 @@ rdma_node_get_transport(enum rdma_node_type node_type)
 		return RDMA_TRANSPORT_USNIC_UDP;
 	if (node_type == RDMA_NODE_RNIC)
 		return RDMA_TRANSPORT_IWARP;
+	if (node_type == RDMA_NODE_UNSPECIFIED)
+		return RDMA_TRANSPORT_UNSPECIFIED;
 
 	return RDMA_TRANSPORT_IB;
 }
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index de8724e5a727..6cf8c4bf369e 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -140,6 +140,7 @@ enum rdma_node_type {
 	RDMA_NODE_RNIC,
 	RDMA_NODE_USNIC,
 	RDMA_NODE_USNIC_UDP,
+	RDMA_NODE_UNSPECIFIED,
 };
 
 enum {
@@ -151,7 +152,8 @@ enum rdma_transport_type {
 	RDMA_TRANSPORT_IB,
 	RDMA_TRANSPORT_IWARP,
 	RDMA_TRANSPORT_USNIC,
-	RDMA_TRANSPORT_USNIC_UDP
+	RDMA_TRANSPORT_USNIC_UDP,
+	RDMA_TRANSPORT_UNSPECIFIED,
 };
 
 enum rdma_protocol_type {
diff --git a/include/uapi/rdma/rdma_user_ioctl_cmds.h b/include/uapi/rdma/rdma_user_ioctl_cmds.h
index 06c34d99be85..26213f49f5c8 100644
--- a/include/uapi/rdma/rdma_user_ioctl_cmds.h
+++ b/include/uapi/rdma/rdma_user_ioctl_cmds.h
@@ -102,6 +102,7 @@ enum rdma_driver_id {
 	RDMA_DRIVER_RXE,
 	RDMA_DRIVER_HFI1,
 	RDMA_DRIVER_QIB,
+	RDMA_DRIVER_EFA,
 };
 
 #endif
-- 
2.7.4

