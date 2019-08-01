Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F15597D99B
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 12:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbfHAKoa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 06:44:30 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:14028 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbfHAKoa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Aug 2019 06:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1564656269; x=1596192269;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HKNDeTgEKK+1zL9bRzDl2a6HwQexWp6he5OUJjuN/+g=;
  b=g631aqFid6KiDdpXxgqqUN3ii1dL900eiFdr/d8wt8NDnSAJPjspZ/mX
   snGI6UflUbwizDZt0F2uI2eDaapyHmImShWYW7EWK5YTlDK+LwMIGtqB+
   4ws0e9oRHhvuZ83jZWG+QyNYfQRQogpaIRwfyIp0+a7YQCjENW2mth7V7
   c=;
X-IronPort-AV: E=Sophos;i="5.64,333,1559520000"; 
   d="scan'208";a="744674338"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 01 Aug 2019 10:44:28 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id 9167CA23B4;
        Thu,  1 Aug 2019 10:44:27 +0000 (UTC)
Received: from EX13D19EUA002.ant.amazon.com (10.43.165.247) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 1 Aug 2019 10:44:26 +0000
Received: from EX13MTAUEB001.ant.amazon.com (10.43.60.96) by
 EX13D19EUA002.ant.amazon.com (10.43.165.247) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 1 Aug 2019 10:44:25 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.138) by
 mail-relay.amazon.com (10.43.60.129) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 1 Aug 2019 10:44:23 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Leon Romanovsky" <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-rc v3] RDMA/restrack: Track driver QP types in resource tracker
Date:   Thu, 1 Aug 2019 13:43:54 +0300
Message-ID: <20190801104354.11417-1-galpress@amazon.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The check for QP type different than XRC has excluded driver QP
types from the resource tracker.
As a result, "rdma resource show" user command would not show opened
driver QPs which does not reflect the real state of the system.

Check QP type explicitly instead of assuming enum values/ordering.

Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
v3:
* Reword commit message
* Change the commit in Fixes: line

v2:
* Improve commit message
---
 drivers/infiniband/core/core_priv.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index 589ed805e0ad..3a8b0911c3bc 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -321,7 +321,9 @@ static inline struct ib_qp *_ib_create_qp(struct ib_device *dev,
 					  struct ib_udata *udata,
 					  struct ib_uobject *uobj)
 {
+	enum ib_qp_type qp_type = attr->qp_type;
 	struct ib_qp *qp;
+	bool is_xrc;
 
 	if (!dev->ops.create_qp)
 		return ERR_PTR(-EOPNOTSUPP);
@@ -339,7 +341,8 @@ static inline struct ib_qp *_ib_create_qp(struct ib_device *dev,
 	 * and more importantly they are created internaly by driver,
 	 * see mlx5 create_dev_resources() as an example.
 	 */
-	if (attr->qp_type < IB_QPT_XRC_INI) {
+	is_xrc = qp_type == IB_QPT_XRC_INI || qp_type == IB_QPT_XRC_TGT;
+	if ((qp_type < IB_QPT_MAX && !is_xrc) || qp_type == IB_QPT_DRIVER) {
 		qp->res.type = RDMA_RESTRACK_QP;
 		if (uobj)
 			rdma_restrack_uadd(&qp->res);
-- 
2.22.0

