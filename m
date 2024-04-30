Return-Path: <linux-rdma+bounces-2153-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEF28B6F7B
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 12:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E5E284B24
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 10:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7160113D62E;
	Tue, 30 Apr 2024 10:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/O2nECW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6EB13D29F;
	Tue, 30 Apr 2024 10:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714472322; cv=none; b=j8Fs0SoVJ8bhT8uFFv5EBugzuPI875rPqcd90A9542Yx7dVljCB+gTeTpMYrauuvEc0j9c8rbwiyZuIrFQcOX5rSk0aGDRwC02OlhSY5M1DMomhDs/RI+1anOXGo20c32BJp4OIgSa6fwTj67KhhBSK5TrBPMMOFmL5hadfQ0Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714472322; c=relaxed/simple;
	bh=xcCoDx2SLp41DOXX9G4v/hl5Qy/EqrXmj92zGErUhKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jd8TKAq40276PHe4+IUzdIiNMNkg9Y8T4HCFJjQBH0IIeCy3BhfqLb0v/eVXPJ0PDkmLCTwkNn6TJf7nMlQGK+NLjfxyoJASpkXrwEb3zmntSWZmZ/TWbn8C8SSKLXJo20zJP2GPg0BteQ6irN082xMA+OA9XDlzDo4wyn7he8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/O2nECW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0A1C2BBFC;
	Tue, 30 Apr 2024 10:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714472322;
	bh=xcCoDx2SLp41DOXX9G4v/hl5Qy/EqrXmj92zGErUhKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L/O2nECW51RdQWPDCwJf8Gdv44JazUFAX+9MKmekKTEauVQLWHjREQsrXgaqYzRW+
	 P4ekXC5g9GwHaFsqEkLn61k/nSq/AmsAn7VLKDhntThW3nsCE/LiMksjnZg1VnwPo+
	 eLPqbrFqyU8SFvgHJMMxHRuFVLfKrWu7eAaZd35alrQ7Hz67f3jL5xQj27PdiKUNqU
	 5N1lPeLzkePu89tlzOu+VjLdG/CvESM4hsfCWAKQ0Y/lW8slxwL0EfuPBaZVB3GH/u
	 /iZgJUCpkuHVQYlJpfTad2v/LqHCGXz6DJmasjiWPek2Uh1X2lUiFMKW8vdc0jeZHN
	 HvP9clEZhnXzQ==
From: Leon Romanovsky <leon@kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	linux-netdev <netdev@vger.kernel.org>,
	RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH iproute2-next 2/2] rdma: Add an option to display driver-specific QPs in the rdma tool
Date: Tue, 30 Apr 2024 13:18:20 +0300
Message-ID: <71cf1e53d0255fd0979e05e9004993f0f9684812.1714472040.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714472040.git.leonro@nvidia.com>
References: <cover.1714472040.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chiara Meiohas <cmeiohas@nvidia.com>

Utilize the -dd flag (driver-specific details) in the rdmatool
to view driver-specific QPs which are not exposed yet.

The following examples show mlx5 UMR QP which is visible now:

$ rdma resource show qp link ibp8s0f1
link ibp8s0f1/1 lqpn 360 type UD state RTS sq-psn 0 comm [mlx5_ib]
link ibp8s0f1/1 lqpn 0 type SMI state RTS sq-psn 0 comm [ib_core]
link ibp8s0f1/1 lqpn 1 type GSI state RTS sq-psn 0 comm [ib_core]

$ rdma resource show qp link ibp8s0f1 -dd
link ibp8s0f1/1 lqpn 360 type UD state RTS sq-psn 0 comm [mlx5_ib]
link ibp8s0f1/1 lqpn 465 type DRIVER subtype REG_UMR state RTS sq-psn 0 comm [mlx5_ib]
link ibp8s0f1/1 lqpn 0 type SMI state RTS sq-psn 0 comm [ib_core]
link ibp8s0f1/1 lqpn 1 type GSI state RTS sq-psn 0 comm [ib_core]

$ rdma resource show
0: ibp8s0f0: pd 3 cq 4 qp 3 cm_id 0 mr 0 ctx 0 srq 2
1: ibp8s0f1: pd 3 cq 4 qp 3 cm_id 0 mr 0 ctx 0 srq 2

$ rdma resource show -dd
0: ibp8s0f0: pd 3 cq 4 qp 4 cm_id 0 mr 0 ctx 0 srq 2
1: ibp8s0f1: pd 3 cq 4 qp 4 cm_id 0 mr 0 ctx 0 srq 2

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 rdma/res-qp.c | 15 +++++++++++++++
 rdma/res.c    |  5 +++++
 rdma/utils.c  |  1 +
 3 files changed, 21 insertions(+)

diff --git a/rdma/res-qp.c b/rdma/res-qp.c
index 65ff54ab..a47225df 100644
--- a/rdma/res-qp.c
+++ b/rdma/res-qp.c
@@ -40,6 +40,15 @@ static void print_type(uint32_t val)
 	print_string(PRINT_ANY, "type", "type %s ", qp_types_to_str(val));
 }
 
+/*
+ * print the subtype only if the QPT is IB_QPT_DRIVER
+ */
+static void print_subtype(uint8_t type, const char *sub_type)
+{
+	if (type == 0xFF && sub_type)
+		print_string(PRINT_ANY, "subtype", "subtype %s ", sub_type);
+}
+
 static void print_state(uint32_t val)
 {
 	print_string(PRINT_ANY, "state", "state %s ", qp_states_to_str(val));
@@ -81,6 +90,7 @@ static int res_qp_line(struct rd *rd, const char *name, int idx,
 {
 	uint32_t lqpn, rqpn = 0, rq_psn = 0, sq_psn;
 	uint8_t type, state, path_mig_state = 0;
+	const char* sub_type = NULL;
 	uint32_t port = 0, pid = 0;
 	uint32_t pdn = 0;
 	char *comm = NULL;
@@ -134,6 +144,10 @@ static int res_qp_line(struct rd *rd, const char *name, int idx,
 		    nla_line[RDMA_NLDEV_ATTR_RES_PATH_MIG_STATE]))
 		goto out;
 
+	if (nla_line[RDMA_NLDEV_ATTR_RES_SUBTYPE])
+		sub_type =
+			mnl_attr_get_str(nla_line[RDMA_NLDEV_ATTR_RES_SUBTYPE]);
+
 	type = mnl_attr_get_u8(nla_line[RDMA_NLDEV_ATTR_RES_TYPE]);
 	if (rd_is_string_filtered_attr(rd, "type", qp_types_to_str(type),
 				       nla_line[RDMA_NLDEV_ATTR_RES_TYPE]))
@@ -164,6 +178,7 @@ static int res_qp_line(struct rd *rd, const char *name, int idx,
 	print_rqpn(rqpn, nla_line);
 
 	print_type(type);
+	print_subtype(type, sub_type);
 	print_state(state);
 
 	print_rqpsn(rq_psn, nla_line);
diff --git a/rdma/res.c b/rdma/res.c
index 3e024134..c311513a 100644
--- a/rdma/res.c
+++ b/rdma/res.c
@@ -99,6 +99,8 @@ int _res_send_idx_msg(struct rd *rd, uint32_t command, mnl_cb_t callback,
 				 RDMA_NLDEV_ATTR_PORT_INDEX, rd->port_idx);
 
 	mnl_attr_put_u32(rd->nlh, id, idx);
+	mnl_attr_put_u8(rd->nlh, RDMA_NLDEV_ATTR_DRIVER_DETAILS,
+			rd->show_driver_details);
 
 	if (command == RDMA_NLDEV_CMD_STAT_GET)
 		mnl_attr_put_u32(rd->nlh, RDMA_NLDEV_ATTR_STAT_RES,
@@ -121,6 +123,9 @@ int _res_send_msg(struct rd *rd, uint32_t command, mnl_cb_t callback)
 		flags |= NLM_F_DUMP;
 
 	rd_prepare_msg(rd, command, &seq, flags);
+
+	mnl_attr_put_u8(rd->nlh, RDMA_NLDEV_ATTR_DRIVER_DETAILS,
+			rd->show_driver_details);
 	mnl_attr_put_u32(rd->nlh, RDMA_NLDEV_ATTR_DEV_INDEX, rd->dev_idx);
 	if (rd->port_idx)
 		mnl_attr_put_u32(rd->nlh,
diff --git a/rdma/utils.c b/rdma/utils.c
index 27595a38..0f41013a 100644
--- a/rdma/utils.c
+++ b/rdma/utils.c
@@ -423,6 +423,7 @@ static const enum mnl_attr_data_type nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_RES_SQ_PSN]		= MNL_TYPE_U32,
 	[RDMA_NLDEV_ATTR_RES_PATH_MIG_STATE]	= MNL_TYPE_U8,
 	[RDMA_NLDEV_ATTR_RES_TYPE]		= MNL_TYPE_U8,
+	[RDMA_NLDEV_ATTR_RES_SUBTYPE]           = MNL_TYPE_NUL_STRING,
 	[RDMA_NLDEV_ATTR_RES_STATE]		= MNL_TYPE_U8,
 	[RDMA_NLDEV_ATTR_RES_PID]		= MNL_TYPE_U32,
 	[RDMA_NLDEV_ATTR_RES_KERN_NAME]	= MNL_TYPE_NUL_STRING,
-- 
2.44.0


