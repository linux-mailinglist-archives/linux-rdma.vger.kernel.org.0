Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFDE36359E
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Apr 2021 15:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhDRNmJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Apr 2021 09:42:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhDRNmJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 18 Apr 2021 09:42:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EDD661057;
        Sun, 18 Apr 2021 13:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618753301;
        bh=ciDcjUWkxlCkMBAB51gI+SXaU3a6KSTe4YwawK2Gw2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fUvZj/q7PTtUQyLNa1s4JIsSajRjVekpugIn6mLfraOkk04e7xJxWs4n+YTr5ULwO
         RM6R/aqx53baDzHQWRO/lW7IuFHHFhJvkVpyYBj92QRtmRf6YWei8kNsrnikRMbeZ/
         ahBw6LEU+XRETC0VNO3TeqNr+iutMmuhfgmj887/iD3PaE4TYsdMeyHyoDxTUlt5Kf
         X9DvaXo+nIvTvy+ljHRAbwbMT4Nl5jybtMfncygt3EOsdXLCw2SXDkH0H5ugw1YpOX
         J4CzzCR97YFSFMUh9FpSf9+XSZtkor5A4cJlyTwAny+vWE2VLaccOKYsume1yfDWDc
         oXJq8nGOYJsdA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Neta Ostrovsky <netao@nvidia.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-next 4/4] RDMA/nldev: Add QP numbers to SRQ information
Date:   Sun, 18 Apr 2021 16:41:26 +0300
Message-Id: <79a4bd4caec2248fd9583cccc26786af8e4414fc.1618753110.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618753110.git.leonro@nvidia.com>
References: <cover.1618753110.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Neta Ostrovsky <netao@nvidia.com>

Add QP numbers that are associated with the SRQ to the SRQ information.
The QPs are displayed in a range form.

Sample output:

$ rdma res show srq
dev ibp8s0f0 srqn 0 type BASIC pdn 3 comm [ib_ipoib]
dev ibp8s0f0 srqn 4 type BASIC lqpn 125-128,130-140 pdn 9 pid 3581 comm ibv_srq_pingpon
dev ibp8s0f0 srqn 5 type BASIC lqpn 141-156 pdn 10 pid 3584 comm ibv_srq_pingpon
dev ibp8s0f0 srqn 6 type BASIC lqpn 157-172 pdn 11 pid 3590 comm ibv_srq_pingpon
dev ibp8s0f1 srqn 0 type BASIC pdn 3 comm [ib_ipoib]
dev ibp8s0f1 srqn 1 type BASIC lqpn 329-344 pdn 4 pid 3586 comm ibv_srq_pingpon

$ rdma res show srq lqpn 126-141
dev ibp8s0f0 srqn 4 type BASIC lqpn 126-128,130-140 pdn 9 pid 3581 comm ibv_srq_pingpon
dev ibp8s0f0 srqn 5 type BASIC lqpn 141 pdn 10 pid 3584 comm ibv_srq_pingpon

$ rdma res show srq lqpn 127
dev ibp8s0f0 srqn 4 type BASIC lqpn 127 pdn 9 pid 3581 comm ibv_srq_pingpon

Signed-off-by: Neta Ostrovsky <netao@nvidia.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/nldev.c  | 91 ++++++++++++++++++++++++++++++++
 include/uapi/rdma/rdma_netlink.h |  2 +
 2 files changed, 93 insertions(+)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index a852af0d3045..bd7f675463f6 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -135,6 +135,8 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_RES_SRQ]		= { .type = NLA_NESTED },
 	[RDMA_NLDEV_ATTR_RES_SRQN]		= { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_RES_SRQ_ENTRY]		= { .type = NLA_NESTED },
+	[RDMA_NLDEV_ATTR_MIN_RANGE]		= { .type = NLA_U32 },
+	[RDMA_NLDEV_ATTR_MAX_RANGE]		= { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_SM_LID]		= { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_SUBNET_PREFIX]		= { .type = NLA_U64 },
 	[RDMA_NLDEV_ATTR_STAT_AUTO_MODE_MASK]	= { .type = NLA_U32 },
@@ -723,6 +725,92 @@ static int fill_res_ctx_entry(struct sk_buff *msg, bool has_cap_net_admin,
 	return fill_res_name_pid(msg, res);
 }
 
+static int fill_res_range_qp_entry(struct sk_buff *msg, uint32_t min_range,
+				   uint32_t max_range)
+{
+	struct nlattr *entry_attr;
+
+	if (!min_range)
+		return 0;
+
+	entry_attr = nla_nest_start(msg, RDMA_NLDEV_ATTR_RES_QP_ENTRY);
+	if (!entry_attr)
+		return -EMSGSIZE;
+
+	if (min_range == max_range) {
+		if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_LQPN, min_range))
+			goto err;
+	} else {
+		if (nla_put_u32(msg, RDMA_NLDEV_ATTR_MIN_RANGE, min_range))
+			goto err;
+		if (nla_put_u32(msg, RDMA_NLDEV_ATTR_MAX_RANGE, max_range))
+			goto err;
+	}
+	nla_nest_end(msg, entry_attr);
+	return 0;
+
+err:
+	nla_nest_cancel(msg, entry_attr);
+	return -EMSGSIZE;
+}
+
+static int fill_res_srq_qps(struct sk_buff *msg, struct ib_srq *srq)
+{
+	uint32_t min_range = 0, prev = 0;
+	struct rdma_restrack_entry *res;
+	struct rdma_restrack_root *rt;
+	struct nlattr *table_attr;
+	struct ib_qp *qp = NULL;
+	unsigned long id = 0;
+
+	table_attr = nla_nest_start(msg, RDMA_NLDEV_ATTR_RES_QP);
+	if (!table_attr)
+		return -EMSGSIZE;
+
+	rt = &srq->device->res[RDMA_RESTRACK_QP];
+	xa_lock(&rt->xa);
+	xa_for_each(&rt->xa, id, res) {
+		if (!rdma_restrack_get(res))
+			continue;
+
+		qp = container_of(res, struct ib_qp, res);
+		if (!qp->srq || (qp->srq->res.id != srq->res.id)) {
+			rdma_restrack_put(res);
+			continue;
+		}
+
+		if (qp->qp_num < prev)
+			/* qp_num should be ascending */
+			goto err_loop;
+
+		if (min_range == 0) {
+			min_range = qp->qp_num;
+		} else if (qp->qp_num > (prev + 1)) {
+			if (fill_res_range_qp_entry(msg, min_range, prev))
+				goto err_loop;
+
+			min_range = qp->qp_num;
+		}
+		prev = qp->qp_num;
+		rdma_restrack_put(res);
+	}
+
+	xa_unlock(&rt->xa);
+
+	if (fill_res_range_qp_entry(msg, min_range, prev))
+		goto err;
+
+	nla_nest_end(msg, table_attr);
+	return 0;
+
+err_loop:
+	rdma_restrack_put(res);
+	xa_unlock(&rt->xa);
+err:
+	nla_nest_cancel(msg, table_attr);
+	return -EMSGSIZE;
+}
+
 static int fill_res_srq_entry(struct sk_buff *msg, bool has_cap_net_admin,
 			      struct rdma_restrack_entry *res, uint32_t port)
 {
@@ -743,6 +831,9 @@ static int fill_res_srq_entry(struct sk_buff *msg, bool has_cap_net_admin,
 			goto err;
 	}
 
+	if (fill_res_srq_qps(msg, srq))
+		goto err;
+
 	return fill_res_name_pid(msg, res);
 
 err:
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index 9abce20d39ad..2c8d405ec924 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -544,6 +544,8 @@ enum rdma_nldev_attr {
 	RDMA_NLDEV_ATTR_RES_SRQ_ENTRY,		/* nested table */
 	RDMA_NLDEV_ATTR_RES_SRQN,		/* u32 */
 
+	RDMA_NLDEV_ATTR_MIN_RANGE,		/* u32 */
+	RDMA_NLDEV_ATTR_MAX_RANGE,		/* u32 */
 	/*
 	 * Always the end
 	 */
-- 
2.30.2

