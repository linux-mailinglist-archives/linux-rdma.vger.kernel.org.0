Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A70B298841
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Oct 2020 09:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1771576AbgJZI1P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Oct 2020 04:27:15 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:50496 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1769975AbgJZI1P (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Oct 2020 04:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1603700834; x=1635236834;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0SYcl9zIfN1Ol/7bEO0rtGMICRQDms04NAG/kl8Zuz8=;
  b=DmCmVD3UnN7dNHzvzJbNreId7N24KmCiD2cEDlzxwD4LQbjMJM7Nev6k
   zmITaVKEXHZ3xCZdl53uvw5kGnvmmbk7bguopjwCVNJaA/OUFc85SVo5i
   2/wZXMsEB8tCVHopIpAUs6xKQA5fU+DRIRdsniGdTEpI6oHbuNqm2oimt
   k=;
X-IronPort-AV: E=Sophos;i="5.77,417,1596499200"; 
   d="scan'208";a="80232276"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 26 Oct 2020 08:26:50 +0000
Received: from EX13D19EUA003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com (Postfix) with ESMTPS id DD8B9A068C;
        Mon, 26 Oct 2020 08:26:47 +0000 (UTC)
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D19EUA003.ant.amazon.com (10.43.165.175) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 26 Oct 2020 08:26:31 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.212.27) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 26 Oct 2020 08:26:27 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: [PATCH for-next] RDMA/uverbs: Fix false error in query gid IOCTL
Date:   Mon, 26 Oct 2020 10:26:21 +0200
Message-ID: <20201026082621.32463-1-galpress@amazon.com>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Some drivers (such as EFA) have a GID table, but aren't IB/RoCE devices.
Remove the unnecessary rdma_ib_or_roce() check.

Fixes: 9f85cbe50aa0 ("RDMA/uverbs: Expose the new GID query API to user space")
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/core/uverbs_std_types_device.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_std_types_device.c b/drivers/infiniband/core/uverbs_std_types_device.c
index f367d523a46b..302f898c5833 100644
--- a/drivers/infiniband/core/uverbs_std_types_device.c
+++ b/drivers/infiniband/core/uverbs_std_types_device.c
@@ -401,9 +401,6 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_GID_ENTRY)(
 	if (!rdma_is_port_valid(ib_dev, port_num))
 		return -EINVAL;
 
-	if (!rdma_ib_or_roce(ib_dev, port_num))
-		return -EOPNOTSUPP;
-
 	gid_attr = rdma_get_gid_attr(ib_dev, port_num, gid_index);
 	if (IS_ERR(gid_attr))
 		return PTR_ERR(gid_attr);

base-commit: c7a198c700763ac89abbb166378f546aeb9afb33
-- 
2.29.1

