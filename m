Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F3D214CF6
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2020 16:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgGEOMH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Jul 2020 10:12:07 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:26530 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbgGEOMH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Jul 2020 10:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1593958326; x=1625494326;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VU7XjHB8EUpBv6/Qdq1C5G2Xw7FWSxsjHBUofwZQVB8=;
  b=LhivokKdH2etdj3CIbWG7fmhsEJAKGLZXRDDJq/EJAXCepIblb6gci4C
   Ybl0XaraXkQX72vGCHS5sL26GWMMvS8ji0vB5oU8ucdSoBQPImv/r7rq1
   4YF4j5CP4z6WT4DmjFSr7+BMxO95nT+367rC/m5SkXP0cE43sUZANApkP
   Q=;
IronPort-SDR: W1BS2ShV5J3XuP1xdnVFG718iUDWNdiZHc8XMABaqPU/ijj1WACG64y3bPHCSd7ye/1mwwvOxG
 F20GxgkjHhjA==
X-IronPort-AV: E=Sophos;i="5.75,316,1589241600"; 
   d="scan'208";a="49140728"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 05 Jul 2020 14:12:02 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com (Postfix) with ESMTPS id A83CEA276E;
        Sun,  5 Jul 2020 14:12:01 +0000 (UTC)
Received: from EX13D19EUB001.ant.amazon.com (10.43.166.229) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 5 Jul 2020 14:12:01 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 5 Jul 2020 14:11:59 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.212.32) by
 mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sun, 5 Jul 2020 14:11:58 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     Leon Romanovsky <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        "Gal Pressman" <galpress@amazon.com>
Subject: [PATCH for-next] RDMA/mlx5: Remove unused to_mibmr function
Date:   Sun, 5 Jul 2020 17:11:43 +0300
Message-ID: <20200705141143.47303-1-galpress@amazon.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The to_mibmr function is unused, remove it.

Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 2fd199c07dda..da03d762c6a2 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1078,11 +1078,6 @@ static inline struct mlx5_ib_rwq *to_mibrwq(struct mlx5_core_qp *core_qp)
 	return container_of(core_qp, struct mlx5_ib_rwq, core_qp);
 }
 
-static inline struct mlx5_ib_mr *to_mibmr(struct mlx5_core_mkey *mmkey)
-{
-	return container_of(mmkey, struct mlx5_ib_mr, mmkey);
-}
-
 static inline struct mlx5_ib_pd *to_mpd(struct ib_pd *ibpd)
 {
 	return container_of(ibpd, struct mlx5_ib_pd, ibpd);
-- 
2.27.0

