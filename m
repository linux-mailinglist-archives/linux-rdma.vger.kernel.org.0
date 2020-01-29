Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C404D14C6CA
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jan 2020 08:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgA2HSc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jan 2020 02:18:32 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:49642 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgA2HSc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Jan 2020 02:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1580282312; x=1611818312;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NJWm6UDJJ+sACEG0O2QWO5Nxnw7O1yGlZPc/x5HRk94=;
  b=BndE6zRVH7eiuktkIm9JIBOEW2wc5v9gKcOZP39f0V/9CCX0EoxVe4uC
   mSdkHVymJSe8lQXG+hRuk6Aq7DUrMuhPSnmb3Af77T3KuJTHyWz3zCSEg
   8TEJofBXNAL5ceSEqcRlA1mpNsUcYihfQTBP4RMBGYqwioHc+wR4Y3MI2
   A=;
IronPort-SDR: D7OtzXQL5k2z4YCBhIC27j2exBi/BspL27//EuqSw1cZ4ciiLhu1j87fhtvggjviRYHa7yWQZK
 rb+pYM9iy26g==
X-IronPort-AV: E=Sophos;i="5.70,376,1574121600"; 
   d="scan'208";a="21733933"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-859fe132.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 29 Jan 2020 07:18:19 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (Postfix) with ESMTPS id D71C2223056;
        Wed, 29 Jan 2020 07:18:18 +0000 (UTC)
Received: from EX13D19EUB001.ant.amazon.com (10.43.166.229) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Wed, 29 Jan 2020 07:18:18 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 29 Jan 2020 07:18:16 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.139) by
 mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Wed, 29 Jan 2020 07:18:15 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next] RDMA/efa: Mask access flags with the correct optional range
Date:   Wed, 29 Jan 2020 09:18:03 +0200
Message-ID: <20200129071803.40117-1-galpress@amazon.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The uapi value IB_UVERBS_ACCESS_OPTIONAL_RANGE shouldn't be used inside
the driver, use IB_ACCESS_OPTIONAL instead.

Fixes: 86dd738cf20c ("RDMA/efa: Allow passing of optional access flags for MR registration")
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index a556572058ff..68798b66b84e 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1367,7 +1367,7 @@ struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
 		IB_ACCESS_LOCAL_WRITE |
 		(is_rdma_read_cap(dev) ? IB_ACCESS_REMOTE_READ : 0);
 
-	access_flags &= ~IB_UVERBS_ACCESS_OPTIONAL_RANGE;
+	access_flags &= ~IB_ACCESS_OPTIONAL;
 	if (access_flags & ~supp_access_flags) {
 		ibdev_dbg(&dev->ibdev,
 			  "Unsupported access flags[%#x], supported[%#x]\n",
-- 
2.25.0

