Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E25437A9D0
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2019 15:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731022AbfG3Nhh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 09:37:37 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:59782 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfG3Nhh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Jul 2019 09:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1564493856; x=1596029856;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I/qRr5HxK9SWj8fkEIzopDoqmNALWpWtnm1aFfPQB3M=;
  b=ThbA841ke+k9jNt+IEzst3w5zmYQecoODkL4PJzuda07YOLTgSz1CBqg
   pT26I0AIfq8R7lqVK1KIrdcmqr19WxC4KAlHO5upmMLgTY6bRLpdH/iNR
   3wtq6MnnuYGKbEzMYXAWeWA15JTFSF/XwIUTFvet00+mn3lhvqiDeuDft
   U=;
X-IronPort-AV: E=Sophos;i="5.64,326,1559520000"; 
   d="scan'208";a="413048336"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 30 Jul 2019 13:37:34 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com (Postfix) with ESMTPS id 04DF4A0337;
        Tue, 30 Jul 2019 13:37:32 +0000 (UTC)
Received: from EX13D19EUB002.ant.amazon.com (10.43.166.78) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 30 Jul 2019 13:37:32 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D19EUB002.ant.amazon.com (10.43.166.78) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 30 Jul 2019 13:37:31 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.136) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 30 Jul 2019 13:37:28 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        "Leon Romanovsky" <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-rc v2] RDMA/restrack: Track driver QP types in resource tracker
Date:   Tue, 30 Jul 2019 16:37:20 +0300
Message-ID: <20190730133720.62548-1-galpress@amazon.com>
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
As a result, "rdma resource show" user command would not show opened
driver QPs which does not reflect the real state of the system.

Check QP type explicitly instead of improperly assuming enum
values/ordering.

Fixes: 78a0cd648a80 ("RDMA/core: Add resource tracking for create and destroy QPs")
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
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

