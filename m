Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF8736359D
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Apr 2021 15:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhDRNmG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Apr 2021 09:42:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhDRNmF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 18 Apr 2021 09:42:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F4E061057;
        Sun, 18 Apr 2021 13:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618753297;
        bh=tXgwfO/yXs6jZSq+SqoWxAy5cpv0WDFzMpBgfWDooGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tkGM6FQmqBv3B+VVNs9CUa7xfxR79BJYQ9e9UIg7UoPkDL0kdQXr63JR1/1LOubMi
         X5soFUBu8YG1yiYLOyO8LfmX6H5MXkeXhsmCk+t6Bda8zkoo1L9Qj5l5cRMdqdjcYk
         CR8FQ/8laUF1f7+koGEhA3g/AiQah3fz47iI1MUgdu4oP/zMfFaVnV9vNle5Jx9hNw
         Kh+V/KAPp3hYg0Q+UQ/pceVQPkPGgLyOvZPWtdEsincbdj4Y4qEdxrHSrCOyoaOQL7
         j/qKz97HkbWlSgwNe5RM/ZyBHArRE96liq73AZ2U3z4mwdBmeEYfBxG1h/fLcqAVMt
         OKMuBz4DDJjBg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Neta Ostrovsky <netao@nvidia.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-next 3/4] RDMA/nldev: Return SRQ information
Date:   Sun, 18 Apr 2021 16:41:25 +0300
Message-Id: <322f9210b95812799190dd4a0fb92f3a3bba0333.1618753110.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618753110.git.leonro@nvidia.com>
References: <cover.1618753110.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Neta Ostrovsky <netao@nvidia.com>

Extend the RDMA nldev return a SRQ information, like SRQ number,
SRQ type, PD number, CQ number and process ID that created that SRQ.

Sample output:

$ rdma res show srq
dev ibp8s0f0 srqn 0 type BASIC pdn 3 comm [ib_ipoib]
dev ibp8s0f0 srqn 4 type BASIC pdn 9 pid 3581 comm ibv_srq_pingpon
dev ibp8s0f0 srqn 5 type BASIC pdn 10 pid 3584 comm ibv_srq_pingpon
dev ibp8s0f0 srqn 6 type BASIC pdn 11 pid 3590 comm ibv_srq_pingpon
dev ibp8s0f1 srqn 0 type BASIC pdn 3 comm [ib_ipoib]
dev ibp8s0f1 srqn 1 type BASIC pdn 4 pid 3586 comm ibv_srq_pingpon

Signed-off-by: Neta Ostrovsky <netao@nvidia.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/nldev.c  | 42 ++++++++++++++++++++++++++++++++
 include/uapi/rdma/rdma_netlink.h |  6 +++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index d33d212298f6..a852af0d3045 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -132,6 +132,9 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_RES_TYPE]		= { .type = NLA_U8 },
 	[RDMA_NLDEV_ATTR_RES_UNSAFE_GLOBAL_RKEY]= { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_RES_USECNT]		= { .type = NLA_U64 },
+	[RDMA_NLDEV_ATTR_RES_SRQ]		= { .type = NLA_NESTED },
+	[RDMA_NLDEV_ATTR_RES_SRQN]		= { .type = NLA_U32 },
+	[RDMA_NLDEV_ATTR_RES_SRQ_ENTRY]		= { .type = NLA_NESTED },
 	[RDMA_NLDEV_ATTR_SM_LID]		= { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_SUBNET_PREFIX]		= { .type = NLA_U64 },
 	[RDMA_NLDEV_ATTR_STAT_AUTO_MODE_MASK]	= { .type = NLA_U32 },
@@ -387,6 +390,7 @@ static int fill_res_info(struct sk_buff *msg, struct ib_device *device)
 		[RDMA_RESTRACK_CM_ID] = "cm_id",
 		[RDMA_RESTRACK_MR] = "mr",
 		[RDMA_RESTRACK_CTX] = "ctx",
+		[RDMA_RESTRACK_SRQ] = "srq",
 	};
 
 	struct nlattr *table_attr;
@@ -719,6 +723,32 @@ static int fill_res_ctx_entry(struct sk_buff *msg, bool has_cap_net_admin,
 	return fill_res_name_pid(msg, res);
 }
 
+static int fill_res_srq_entry(struct sk_buff *msg, bool has_cap_net_admin,
+			      struct rdma_restrack_entry *res, uint32_t port)
+{
+	struct ib_srq *srq = container_of(res, struct ib_srq, res);
+
+	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_SRQN, srq->res.id))
+		goto err;
+
+	if (nla_put_u8(msg, RDMA_NLDEV_ATTR_RES_TYPE, srq->srq_type))
+		goto err;
+
+	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PDN, srq->pd->res.id))
+		goto err;
+
+	if (ib_srq_has_cq(srq->srq_type)) {
+		if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_CQN,
+				srq->ext.cq->res.id))
+			goto err;
+	}
+
+	return fill_res_name_pid(msg, res);
+
+err:
+	return -EMSGSIZE;
+}
+
 static int fill_stat_counter_mode(struct sk_buff *msg,
 				  struct rdma_counter *counter)
 {
@@ -1258,6 +1288,13 @@ static const struct nldev_fill_res_entry fill_entries[RDMA_RESTRACK_MAX] = {
 		.entry = RDMA_NLDEV_ATTR_RES_CTX_ENTRY,
 		.id = RDMA_NLDEV_ATTR_RES_CTXN,
 	},
+	[RDMA_RESTRACK_SRQ] = {
+		.nldev_attr = RDMA_NLDEV_ATTR_RES_SRQ,
+		.flags = NLDEV_PER_DEV,
+		.entry = RDMA_NLDEV_ATTR_RES_SRQ_ENTRY,
+		.id = RDMA_NLDEV_ATTR_RES_SRQN,
+	},
+
 };
 
 static int res_get_common_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
@@ -1499,6 +1536,7 @@ RES_GET_FUNCS(mr, RDMA_RESTRACK_MR);
 RES_GET_FUNCS(mr_raw, RDMA_RESTRACK_MR);
 RES_GET_FUNCS(counter, RDMA_RESTRACK_COUNTER);
 RES_GET_FUNCS(ctx, RDMA_RESTRACK_CTX);
+RES_GET_FUNCS(srq, RDMA_RESTRACK_SRQ);
 
 static LIST_HEAD(link_ops);
 static DECLARE_RWSEM(link_ops_rwsem);
@@ -2166,6 +2204,10 @@ static const struct rdma_nl_cbs nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
 		.doit = nldev_res_get_ctx_doit,
 		.dump = nldev_res_get_ctx_dumpit,
 	},
+	[RDMA_NLDEV_CMD_RES_SRQ_GET] = {
+		.doit = nldev_res_get_srq_doit,
+		.dump = nldev_res_get_srq_dumpit,
+	},
 	[RDMA_NLDEV_CMD_SYS_GET] = {
 		.doit = nldev_sys_get_doit,
 	},
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index 9ec4d4e241fa..9abce20d39ad 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -295,6 +295,8 @@ enum rdma_nldev_command {
 
 	RDMA_NLDEV_CMD_RES_CTX_GET, /* can dump */
 
+	RDMA_NLDEV_CMD_RES_SRQ_GET, /* can dump */
+
 	RDMA_NLDEV_NUM_OPS
 };
 
@@ -538,6 +540,10 @@ enum rdma_nldev_attr {
 	RDMA_NLDEV_ATTR_RES_CTX,		/* nested table */
 	RDMA_NLDEV_ATTR_RES_CTX_ENTRY,		/* nested table */
 
+	RDMA_NLDEV_ATTR_RES_SRQ,		/* nested table */
+	RDMA_NLDEV_ATTR_RES_SRQ_ENTRY,		/* nested table */
+	RDMA_NLDEV_ATTR_RES_SRQN,		/* u32 */
+
 	/*
 	 * Always the end
 	 */
-- 
2.30.2

