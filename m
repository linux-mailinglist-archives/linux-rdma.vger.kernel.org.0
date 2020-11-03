Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB1D2A4649
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Nov 2020 14:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgKCN0t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Nov 2020 08:26:49 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:61008 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbgKCN0t (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Nov 2020 08:26:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1604410009; x=1635946009;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nc9mJG+Fwk1JYj0W0VjYTgCVoNbfskKfJWByyrrHzpI=;
  b=spCzPkFqBHXMAhSgG1WcPmRATOZRCed81xdNbLkOgDPsnY9PsOM4pcWu
   /HDzQnNkSMf6ndvToZqNfuWymsLsT/2SUc7TBLJnVUlyqZQpHOp1azAL4
   UEFRsNBbbhgTqEooiLDuUhPAEqnoiIBCob3/z6mTjSrLywVz09+IwXWyz
   E=;
X-IronPort-AV: E=Sophos;i="5.77,448,1596499200"; 
   d="scan'208";a="91371917"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-859fe132.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 03 Nov 2020 13:26:42 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (Postfix) with ESMTPS id F16452232F0;
        Tue,  3 Nov 2020 13:26:41 +0000 (UTC)
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 3 Nov 2020 13:26:40 +0000
Received: from 8c85908914bf.ant.amazon.com (10.85.94.34) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 3 Nov 2020 13:26:37 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next] RDMA/nldev: Add parent bdf to device information dump
Date:   Tue, 3 Nov 2020 15:26:27 +0200
Message-ID: <20201103132627.67642-1-galpress@amazon.com>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add the ability to query the device's bdf through rdma tool netlink
command (in addition to the sysfs infra).

In case of virtual devices (rxe/siw), the netdev bdf will be shown.

Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/core/nldev.c  | 10 +++++++++-
 include/uapi/rdma/rdma_netlink.h |  5 +++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 12d29d54a081..9704b1449c01 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -291,7 +291,15 @@ static int fill_dev_info(struct sk_buff *msg, struct ib_device *device)
 	else if (rdma_protocol_usnic(device, port))
 		ret = nla_put_string(msg, RDMA_NLDEV_ATTR_DEV_PROTOCOL,
 				     "usnic");
-	return ret;
+	if (ret)
+		return ret;
+
+	if (device->dev.parent)
+		if (nla_put_string(msg, RDMA_NLDEV_PARENT_BDF,
+				   dev_name(device->dev.parent)))
+			return -EMSGSIZE;
+
+	return 0;
 }
 
 static int fill_port_info(struct sk_buff *msg,
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index d2f5b8396243..7495104668eb 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -533,6 +533,11 @@ enum rdma_nldev_attr {
 
 	RDMA_NLDEV_ATTR_RES_RAW,	/* binary */
 
+	/*
+	 * Parent device BDF (bus, device, function).
+	 */
+	RDMA_NLDEV_PARENT_BDF,			/* string */
+
 	/*
 	 * Always the end
 	 */
-- 
2.29.1

