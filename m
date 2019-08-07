Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D595E849A3
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 12:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfHGKe2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 06:34:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbfHGKe2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Aug 2019 06:34:28 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C954A2086D;
        Wed,  7 Aug 2019 10:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565174067;
        bh=/MlRzhpiMFdpyu3g3tg1PxXGCzxZQlzviI7RQn/UFWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RHu5788aRLmW4RXsmwqr0LyGp00VI3qMXLB41Dvha2jNypCoNs/lQv5NL17EfOjxt
         aS+00lEySI+XoyeO6T6TrX+bdayRtHxOAU7yzwMiEmE1BuAMfaY67fQtZTYg45/JhG
         YYVBnYTsLIeYripylPkdExkk/QOly0PWputpij7Y=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: [PATCH rdma-next 6/6] RDMA/nldev: Provide MR statistics
Date:   Wed,  7 Aug 2019 13:34:03 +0300
Message-Id: <20190807103403.8102-7-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190807103403.8102-1-leon@kernel.org>
References: <20190807103403.8102-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Erez Alfasi <ereza@mellanox.com>

Add RDMA nldev netlink interface for dumping MR
statistics information.

Output example:
ereza@dev~$: ./ibv_rc_pingpong -o -P -s 500000000
  local address:  LID 0x0001, QPN 0x00008a, PSN 0xf81096, GID ::

ereza@dev~$: rdma stat show mr
dev mlx5_0 mrn 2 page_faults 122071 page_invalidations 0
prefetched_pages 122071

Signed-off-by: Erez Alfasi <ereza@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/nldev.c | 51 +++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 694ded552687..23a686dbc7cd 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -756,6 +756,47 @@ static int fill_stat_hwcounter_entry(struct sk_buff *msg,
 	return -EMSGSIZE;
 }
 
+static int fill_stat_mr_entry(struct sk_buff *msg, bool has_cap_net_admin,
+			      struct rdma_restrack_entry *res, uint32_t port)
+{
+	struct ib_mr *mr = container_of(res, struct ib_mr, res);
+	struct ib_device *dev = mr->pd->device;
+	struct ib_umem_odp *umem_odp;
+	struct nlattr *table_attr;
+
+	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_MRN, res->id))
+		goto err;
+
+	if (fill_res_entry(dev, msg, res))
+		goto err;
+
+	if (!mr->umem->is_odp)
+		return 0;
+
+	umem_odp = to_ib_umem_odp(mr->umem);
+	table_attr = nla_nest_start(msg,
+				    RDMA_NLDEV_ATTR_STAT_HWCOUNTERS);
+
+	if (!table_attr)
+		return -EMSGSIZE;
+
+	if (fill_stat_hwcounter_entry(msg, "page_faults",
+				      umem_odp->odp_stats.faults))
+		goto err;
+	if (fill_stat_hwcounter_entry(msg, "page_invalidations",
+				      umem_odp->odp_stats.invalidations))
+		goto err;
+	if (fill_stat_hwcounter_entry(msg, "prefetched_pages",
+				      umem_odp->odp_stats.prefetched))
+		goto err;
+
+	nla_nest_end(msg, table_attr);
+
+	return 0;
+
+err:    return -EMSGSIZE;
+}
+
 static int fill_stat_counter_hwcounters(struct sk_buff *msg,
 					struct rdma_counter *counter)
 {
@@ -2012,7 +2053,10 @@ static int nldev_stat_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	case RDMA_NLDEV_ATTR_RES_QP:
 		ret = stat_get_doit_qp(skb, nlh, extack, tb);
 		break;
-
+	case RDMA_NLDEV_ATTR_RES_MR:
+		ret = res_get_common_doit(skb, nlh, extack, RDMA_RESTRACK_MR,
+					  fill_stat_mr_entry);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -2036,7 +2080,10 @@ static int nldev_stat_get_dumpit(struct sk_buff *skb,
 	case RDMA_NLDEV_ATTR_RES_QP:
 		ret = nldev_res_get_counter_dumpit(skb, cb);
 		break;
-
+	case RDMA_NLDEV_ATTR_RES_MR:
+		ret = res_get_common_dumpit(skb, cb, RDMA_RESTRACK_MR,
+					    fill_stat_mr_entry);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
-- 
2.20.1

