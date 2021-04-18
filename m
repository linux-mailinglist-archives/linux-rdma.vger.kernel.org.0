Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371EB36359F
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Apr 2021 15:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhDRNmN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Apr 2021 09:42:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhDRNmM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 18 Apr 2021 09:42:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D41F861057;
        Sun, 18 Apr 2021 13:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618753304;
        bh=ihQ/flDfU2IR080OOHP+nR3KrWuPRftQMs3JcB6o65c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GK8gXE9vgSfmb8SWXH8dp/uCwNXzd4gyZif7HXPGHJQ6Fr1pZZpnmwPCK9AzVjG9k
         zFPMhVRN4a3rSXpr0UoAa9jEEnox7lryjxjBTj3u3WVjb2AP3cU4TY8v0cnHrqIT/N
         f8FvB3muIreACSeUUte/hqCbii7gBTQmxdgv0pZjOsLzreYXnfAd1KKxisnelSHyuO
         m/TkUFSyX5njb/jrPfUMQvOZYbuXXU32AQE/zu2gqrdqOGoYseoOCbzNvGvJDWxb0L
         phUYJv0Z7dqcpqOINAS3BnfF5awtwpzuqyUzxrli09fypauyUVqgaLlfYzC4eVWf3f
         xQxQfrApNH/sg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Neta Ostrovsky <netao@nvidia.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-next 1/4] RDMA/nldev: Return context information
Date:   Sun, 18 Apr 2021 16:41:23 +0300
Message-Id: <5c956acfeac4e9d532988575f3da7d64cb449374.1618753110.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618753110.git.leonro@nvidia.com>
References: <cover.1618753110.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Neta Ostrovsky <netao@nvidia.com>

Extend the RDMA nldev return a context information, like ctx number and
process ID that created that context. This functionality is helpful to
find orphan contexts that are not closed for some reason.

Sample output:

$ rdma res show ctx
dev ibp8s0f0 ctxn 0 pid 980 comm ibv_rc_pingpong
dev ibp8s0f0 ctxn 1 pid 981 comm ibv_rc_pingpong
dev ibp8s0f0 ctxn 2 pid 992 comm ibv_rc_pingpong
dev ibp8s0f1 ctxn 0 pid 984 comm ibv_rc_pingpong
dev ibp8s0f1 ctxn 1 pid 987 comm ibv_rc_pingpong

$ rdma res show ctx dev ibp8s0f1
dev ibp8s0f1 ctxn 0 pid 984 comm ibv_rc_pingpong
dev ibp8s0f1 ctxn 1 pid 987 comm ibv_rc_pingpong

Signed-off-by: Neta Ostrovsky <netao@nvidia.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/nldev.c  | 27 +++++++++++++++++++++++++++
 include/uapi/rdma/rdma_netlink.h |  5 +++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index b8dc002a2478..d33d212298f6 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -92,7 +92,9 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_RES_CQE]		= { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_RES_CQN]		= { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_RES_CQ_ENTRY]		= { .type = NLA_NESTED },
+	[RDMA_NLDEV_ATTR_RES_CTX]		= { .type = NLA_NESTED },
 	[RDMA_NLDEV_ATTR_RES_CTXN]		= { .type = NLA_U32 },
+	[RDMA_NLDEV_ATTR_RES_CTX_ENTRY]		= { .type = NLA_NESTED },
 	[RDMA_NLDEV_ATTR_RES_DST_ADDR]		= {
 			.len = sizeof(struct __kernel_sockaddr_storage) },
 	[RDMA_NLDEV_ATTR_RES_IOVA]		= { .type = NLA_U64 },
@@ -703,6 +705,20 @@ static int fill_res_pd_entry(struct sk_buff *msg, bool has_cap_net_admin,
 err:	return -EMSGSIZE;
 }
 
+static int fill_res_ctx_entry(struct sk_buff *msg, bool has_cap_net_admin,
+			      struct rdma_restrack_entry *res, uint32_t port)
+{
+	struct ib_ucontext *ctx = container_of(res, struct ib_ucontext, res);
+
+	if (rdma_is_kernel_res(res))
+		return 0;
+
+	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_CTXN, ctx->res.id))
+		return -EMSGSIZE;
+
+	return fill_res_name_pid(msg, res);
+}
+
 static int fill_stat_counter_mode(struct sk_buff *msg,
 				  struct rdma_counter *counter)
 {
@@ -1236,6 +1252,12 @@ static const struct nldev_fill_res_entry fill_entries[RDMA_RESTRACK_MAX] = {
 		.entry = RDMA_NLDEV_ATTR_STAT_COUNTER_ENTRY,
 		.id = RDMA_NLDEV_ATTR_STAT_COUNTER_ID,
 	},
+	[RDMA_RESTRACK_CTX] = {
+		.nldev_attr = RDMA_NLDEV_ATTR_RES_CTX,
+		.flags = NLDEV_PER_DEV,
+		.entry = RDMA_NLDEV_ATTR_RES_CTX_ENTRY,
+		.id = RDMA_NLDEV_ATTR_RES_CTXN,
+	},
 };
 
 static int res_get_common_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
@@ -1476,6 +1498,7 @@ RES_GET_FUNCS(pd, RDMA_RESTRACK_PD);
 RES_GET_FUNCS(mr, RDMA_RESTRACK_MR);
 RES_GET_FUNCS(mr_raw, RDMA_RESTRACK_MR);
 RES_GET_FUNCS(counter, RDMA_RESTRACK_COUNTER);
+RES_GET_FUNCS(ctx, RDMA_RESTRACK_CTX);
 
 static LIST_HEAD(link_ops);
 static DECLARE_RWSEM(link_ops_rwsem);
@@ -2139,6 +2162,10 @@ static const struct rdma_nl_cbs nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
 		.doit = nldev_res_get_pd_doit,
 		.dump = nldev_res_get_pd_dumpit,
 	},
+	[RDMA_NLDEV_CMD_RES_CTX_GET] = {
+		.doit = nldev_res_get_ctx_doit,
+		.dump = nldev_res_get_ctx_dumpit,
+	},
 	[RDMA_NLDEV_CMD_SYS_GET] = {
 		.doit = nldev_sys_get_doit,
 	},
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index d2f5b8396243..9ec4d4e241fa 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -293,6 +293,8 @@ enum rdma_nldev_command {
 
 	RDMA_NLDEV_CMD_RES_MR_GET_RAW,
 
+	RDMA_NLDEV_CMD_RES_CTX_GET, /* can dump */
+
 	RDMA_NLDEV_NUM_OPS
 };
 
@@ -533,6 +535,9 @@ enum rdma_nldev_attr {
 
 	RDMA_NLDEV_ATTR_RES_RAW,	/* binary */
 
+	RDMA_NLDEV_ATTR_RES_CTX,		/* nested table */
+	RDMA_NLDEV_ATTR_RES_CTX_ENTRY,		/* nested table */
+
 	/*
 	 * Always the end
 	 */
-- 
2.30.2

