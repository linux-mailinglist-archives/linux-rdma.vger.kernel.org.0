Return-Path: <linux-rdma+bounces-11759-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04295AEDA4C
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 12:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A58E7A9694
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 10:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD7F2586C8;
	Mon, 30 Jun 2025 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqIkmwa9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E15425A655
	for <linux-rdma@vger.kernel.org>; Mon, 30 Jun 2025 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751280774; cv=none; b=lsiaFgakByNfUPmyeIGLhe46fgEeEsLpnhQVgCg5rf0pbrZiyzrl6uRt/OI8K9aVTnjq0tP03v2HeEuVMgGD9Oa9eGDD6XW6sSD4VceFDv3urmCQIRHz3BAPA0Gc+qIJKMRbgZUYeoJYyEXkO81MJ8U2xEwWwNosK7dcEVw2l78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751280774; c=relaxed/simple;
	bh=XEuHXlk60GFEVErQ3WIdITG8HphrCLNAXp/UTfaFdTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7lxKIZedXl9vdzU9afbVGQh7hc+Fxbtab0FdOIne08oLtP1xnOoaNGU9g+HlMNVEsYdoqL0v0d1FHVMo5H1bAxDhBUj8l3CtsmT79MUII7XpQBAm7Zq7eEkeNca+xtBii661x2hg7dGnsxvYrLKOY1KKDPOBMFp3tuyGU18YzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqIkmwa9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E743C4CEE3;
	Mon, 30 Jun 2025 10:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751280773;
	bh=XEuHXlk60GFEVErQ3WIdITG8HphrCLNAXp/UTfaFdTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QqIkmwa9/8IENxlKhYOZPoMn797o4MEbb8cR1AACt/TSPUqHn2rgqzmSvhN1J6V9F
	 sCzxOspo6ZJh5EGrEfu2FW+Wm9mXbyj3T8uk9X2CtzyTwdhk9phgv32oC68xuKNAYu
	 1lqxyp2+tJI4/B+yoFWTkOqTMVwKWLPuuz3Jx1PH+encgu6Btcca3WzkpjOJfhnAcg
	 ajJk3FMr89rlgPiglRzrEnASNU1xORzD0/rMh4c1I6ssKzWFnOKnBSGZe8huYMcS1p
	 3JJ4Ug92zXw7r08v7eKRtIatQsXWme889AOmfvoEtDr2X9r0zmnw5N+hCdVHlg1tjm
	 Bs1y63KjqiCkw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Zhang <markzhang@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Or Har-Toov <ohartoov@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>
Subject: [PATCH rdma-next 4/5] RDMA/ucma: Support query resolved service records
Date: Mon, 30 Jun 2025 13:52:34 +0300
Message-ID: <1090ee7c00c3f8058c4f9e7557de983504a16715.1751279794.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751279793.git.leonro@nvidia.com>
References: <cover.1751279793.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Zhang <markzhang@nvidia.com>

Enable user-space to query resolved service records through a ucma
command when a RDMA_CM_EVENT_ADDRINFO_RESOLVED event is received.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Reviewed-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/ucma.c   | 40 ++++++++++++++++++++++++++++++++
 include/uapi/rdma/ib_user_sa.h   | 14 +++++++++++
 include/uapi/rdma/rdma_user_cm.h |  8 ++++++-
 3 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 1915f4e68308..3b9ca6d7a21b 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1021,6 +1021,43 @@ static ssize_t ucma_query_gid(struct ucma_context *ctx,
 	return ret;
 }
 
+static ssize_t ucma_query_ib_service(struct ucma_context *ctx,
+				     void __user *response, int out_len)
+{
+	struct rdma_ucm_query_ib_service_resp *resp;
+	int n, ret = 0;
+
+	if (out_len < sizeof(struct rdma_ucm_query_ib_service_resp))
+		return -ENOSPC;
+
+	if (!ctx->cm_id->route.service_recs)
+		return -ENODATA;
+
+	resp = kzalloc(out_len, GFP_KERNEL);
+	if (!resp)
+		return -ENOMEM;
+
+	resp->num_service_recs = ctx->cm_id->route.num_service_recs;
+
+	n = (out_len - sizeof(struct rdma_ucm_query_ib_service_resp)) /
+		sizeof(struct ib_user_service_rec);
+
+	if (!n)
+		goto out;
+
+	if (n > ctx->cm_id->route.num_service_recs)
+		n = ctx->cm_id->route.num_service_recs;
+
+	memcpy(resp->recs, ctx->cm_id->route.service_recs,
+	       sizeof(*resp->recs) * n);
+	if (copy_to_user(response, resp, struct_size(resp, recs, n)))
+		ret = -EFAULT;
+
+out:
+	kfree(resp);
+	return ret;
+}
+
 static ssize_t ucma_query(struct ucma_file *file,
 			  const char __user *inbuf,
 			  int in_len, int out_len)
@@ -1049,6 +1086,9 @@ static ssize_t ucma_query(struct ucma_file *file,
 	case RDMA_USER_CM_QUERY_GID:
 		ret = ucma_query_gid(ctx, response, out_len);
 		break;
+	case RDMA_USER_CM_QUERY_IB_SERVICE:
+		ret = ucma_query_ib_service(ctx, response, out_len);
+		break;
 	default:
 		ret = -ENOSYS;
 		break;
diff --git a/include/uapi/rdma/ib_user_sa.h b/include/uapi/rdma/ib_user_sa.h
index 435155d6e1c6..acfa20816bc6 100644
--- a/include/uapi/rdma/ib_user_sa.h
+++ b/include/uapi/rdma/ib_user_sa.h
@@ -74,4 +74,18 @@ struct ib_user_path_rec {
 	__u8	preference;
 };
 
+struct ib_user_service_rec {
+	__be64	id;
+	__u8	gid[16];
+	__be16	pkey;
+	__u8	reserved[2];
+	__be32	lease;
+	__u8	key[16];
+	__u8	name[64];
+	__u8	data_8[16];
+	__be16	data_16[8];
+	__be32	data_32[4];
+	__be64	data_64[2];
+};
+
 #endif /* IB_USER_SA_H */
diff --git a/include/uapi/rdma/rdma_user_cm.h b/include/uapi/rdma/rdma_user_cm.h
index 8799623bcba0..00501da0567e 100644
--- a/include/uapi/rdma/rdma_user_cm.h
+++ b/include/uapi/rdma/rdma_user_cm.h
@@ -148,7 +148,8 @@ struct rdma_ucm_resolve_route {
 enum {
 	RDMA_USER_CM_QUERY_ADDR,
 	RDMA_USER_CM_QUERY_PATH,
-	RDMA_USER_CM_QUERY_GID
+	RDMA_USER_CM_QUERY_GID,
+	RDMA_USER_CM_QUERY_IB_SERVICE
 };
 
 struct rdma_ucm_query {
@@ -188,6 +189,11 @@ struct rdma_ucm_query_path_resp {
 	struct ib_path_rec_data path_data[];
 };
 
+struct rdma_ucm_query_ib_service_resp {
+	__u32 num_service_recs;
+	struct ib_user_service_rec recs[];
+};
+
 struct rdma_ucm_conn_param {
 	__u32 qp_num;
 	__u32 qkey;
-- 
2.50.0


