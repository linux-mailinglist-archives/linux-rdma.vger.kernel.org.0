Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF3ED7A65C
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2019 13:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfG3LCB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 07:02:01 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:31267 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfG3LCA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Jul 2019 07:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1564484519; x=1596020519;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yCSldScaRyFgomBdF1jMWL9F4rzNgQ50YeV1DaYru5Q=;
  b=ei4QFNnFJdKbxxqcJDwwwV2vDQk0A19dfVNEYWGDuIqKv57vjuMfF0I0
   l8JP/e/CgMfxDmimjvGWvX4dgbgQ4yCTimeEKUlzrb9uAZGAkoU/j2tCF
   cZluMsR4PjYIcdrtIxtmme7jCP9KbNWFZuZKFcCq1mQrThe87kBxlqxXq
   Q=;
X-IronPort-AV: E=Sophos;i="5.64,326,1559520000"; 
   d="scan'208";a="689177133"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2b-c300ac87.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 30 Jul 2019 11:01:57 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-c300ac87.us-west-2.amazon.com (Postfix) with ESMTPS id 8C582A20B3;
        Tue, 30 Jul 2019 11:01:57 +0000 (UTC)
Received: from EX13D19EUA004.ant.amazon.com (10.43.165.28) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 30 Jul 2019 11:01:57 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D19EUA004.ant.amazon.com (10.43.165.28) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 30 Jul 2019 11:01:56 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.136) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 30 Jul 2019 11:01:54 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        "Leon Romanovsky" <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-rc] RDMA/restrack: Track driver QP types in resource tracker
Date:   Tue, 30 Jul 2019 14:01:37 +0300
Message-ID: <20190730110137.37826-1-galpress@amazon.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The check for QP type different than XRC has wrongly excluded driver QP
types from the resource tracker.

Fixes: 78a0cd648a80 ("RDMA/core: Add resource tracking for create and destroy QPs")
Signed-off-by: Gal Pressman <galpress@amazon.com>
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

