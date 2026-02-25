Return-Path: <linux-rdma+bounces-17178-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIQTAKkFn2mZYgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17178-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 15:22:33 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1371C198A49
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 15:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 38C66305858D
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 14:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500CC3D410C;
	Wed, 25 Feb 2026 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMQF+tXJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122F53D34AD;
	Wed, 25 Feb 2026 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772029199; cv=none; b=JDEjt2nE+G1bIv1g9nQG2IkZxfv5JozQsvfpcO6oRndIRDdwDf9uDyS8DmtnVLVDAupY1B5mqxsMRoq3M9N477Dhjqorr3RQnsC3qTKllwah8zCD7qNBVGihhH9wQ+MGyk3KjB2AhNuwBqYZGd4gYFoYL/kqtVAdI8DdPA8e2j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772029199; c=relaxed/simple;
	bh=IWfIW+hzTkf5nStjv+pYV1pJ3Vmlm4ZHSTNuOGvG28E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mRD9eFRJ9dp2lSb9LtRmepPvR7KrU7sXPdgKhQJEfrh54F5j52kyGOb2kFfOwQ7B0QLg9Xr8/fukI6K2dGBPpcU4QuoLaRSFIYCQIxlCS8YWIZcoVdMYVRPO4/eS5JCcXCuKeDtX8apwCt+ky6DDfwCmxPPaJf/fGP2z6PU4SFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMQF+tXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48714C116D0;
	Wed, 25 Feb 2026 14:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772029198;
	bh=IWfIW+hzTkf5nStjv+pYV1pJ3Vmlm4ZHSTNuOGvG28E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aMQF+tXJfP7CBNQnr+pR/bKhDKwwVWOMiGQqTKj63Ty1JgOGxyrGyH+lGjtG6aj28
	 N+tolxetZSs4XEjYAxrJXbH5QvzMGq8+AuAfkw5TbV0+jIWmGb1QvALgc05f+noXJ4
	 dGoZHWPjKTvYv8IwqNk1gNzF99XmsMdhVXg14jEzBCZwOTwQK9TR1nnB/IsHrB8TIp
	 WQTn86d4i4bkuXh5TLKC6ltql3e5md4zkB87Gu+swkLUgSMoGIutrRvn3G5cslKAJj
	 tx7OicPUFRzHsNNfQlQmHBxWnH+8ZnWlcFIIIyiiGaKnVn6k9LxYVNs0keMISewCEr
	 fSjlrAvNMuiDw==
From: Leon Romanovsky <leon@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>
Subject: [PATCH rdma-next 6/6] RDMA/mlx5: Add VAR object query method for cross-process sharing
Date: Wed, 25 Feb 2026 16:19:36 +0200
Message-ID: <20260225-var-tlp-v1-6-fe14a7ac7731@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225-var-tlp-v1-0-fe14a7ac7731@nvidia.com>
References: <20260225-var-tlp-v1-0-fe14a7ac7731@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-47773
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_TO(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17178-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1371C198A49
X-Rspamd-Action: no action

From: Maher Sanalla <msanalla@nvidia.com>

Introduce MLX5_IB_METHOD_VAR_OBJ_QUERY to enable cross-process sharing
of VAR objects. This method allows a process that has imported the uverbs
fd via ibv_import_device() to query an existing VAR handle and obtain
the mmap parameters needed to map the VAR region into its address space.

This follows the same pattern as UVERBS_METHOD_QUERY_MR, allowing
userspace to implement mlx5dv_import_var() analogous to ibv_import_mr().

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c        | 47 +++++++++++++++++++++++++++++++-
 include/uapi/rdma/mlx5_user_ioctl_cmds.h |  8 ++++++
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 77cd11c6cca9..a75769f55d31 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4263,6 +4263,34 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_VAR_OBJ_ALLOC)(
 	return err;
 }
 
+static int UVERBS_HANDLER(MLX5_IB_METHOD_VAR_OBJ_QUERY)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct mlx5_user_mmap_entry *entry =
+		uverbs_attr_get_obj(attrs, MLX5_IB_ATTR_VAR_OBJ_QUERY_HANDLE);
+	u64 mmap_offset;
+	u32 length;
+	int err;
+
+	mmap_offset = mlx5_entry_to_mmap_offset(entry);
+	if (check_mul_overflow(entry->rdma_entry.npages, (u32)PAGE_SIZE, &length))
+		return -EOVERFLOW;
+
+	err = uverbs_copy_to(attrs, MLX5_IB_ATTR_VAR_OBJ_QUERY_MMAP_OFFSET,
+			     &mmap_offset, sizeof(mmap_offset));
+	if (err)
+		return err;
+
+	err = uverbs_copy_to(attrs, MLX5_IB_ATTR_VAR_OBJ_QUERY_PAGE_ID,
+			     &entry->page_idx, sizeof(entry->page_idx));
+	if (err)
+		return err;
+
+	err = uverbs_copy_to(attrs, MLX5_IB_ATTR_VAR_OBJ_QUERY_MMAP_LENGTH,
+			     &length, sizeof(length));
+	return err;
+}
+
 DECLARE_UVERBS_NAMED_METHOD(
 	MLX5_IB_METHOD_VAR_OBJ_ALLOC,
 	UVERBS_ATTR_IDR(MLX5_IB_ATTR_VAR_OBJ_ALLOC_HANDLE,
@@ -4289,10 +4317,27 @@ DECLARE_UVERBS_NAMED_METHOD_DESTROY(
 			UVERBS_ACCESS_DESTROY,
 			UA_MANDATORY));
 
+DECLARE_UVERBS_NAMED_METHOD(
+	MLX5_IB_METHOD_VAR_OBJ_QUERY,
+	UVERBS_ATTR_IDR(MLX5_IB_ATTR_VAR_OBJ_QUERY_HANDLE,
+			MLX5_IB_OBJECT_VAR,
+			UVERBS_ACCESS_READ,
+			UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(MLX5_IB_ATTR_VAR_OBJ_QUERY_PAGE_ID,
+			    UVERBS_ATTR_TYPE(u32),
+			    UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(MLX5_IB_ATTR_VAR_OBJ_QUERY_MMAP_LENGTH,
+			    UVERBS_ATTR_TYPE(u32),
+			    UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(MLX5_IB_ATTR_VAR_OBJ_QUERY_MMAP_OFFSET,
+			    UVERBS_ATTR_TYPE(u64),
+			    UA_MANDATORY));
+
 DECLARE_UVERBS_NAMED_OBJECT(MLX5_IB_OBJECT_VAR,
 			    UVERBS_TYPE_ALLOC_IDR(mmap_obj_cleanup),
 			    &UVERBS_METHOD(MLX5_IB_METHOD_VAR_OBJ_ALLOC),
-			    &UVERBS_METHOD(MLX5_IB_METHOD_VAR_OBJ_DESTROY));
+			    &UVERBS_METHOD(MLX5_IB_METHOD_VAR_OBJ_DESTROY),
+			    &UVERBS_METHOD(MLX5_IB_METHOD_VAR_OBJ_QUERY));
 
 static bool var_is_supported(struct ib_device *device)
 {
diff --git a/include/uapi/rdma/mlx5_user_ioctl_cmds.h b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
index 01a2a050e468..7db03b3fdae6 100644
--- a/include/uapi/rdma/mlx5_user_ioctl_cmds.h
+++ b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
@@ -146,9 +146,17 @@ enum mlx5_ib_var_obj_destroy_attrs {
 	MLX5_IB_ATTR_VAR_OBJ_DESTROY_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
 };
 
+enum mlx5_ib_var_obj_query_attrs {
+	MLX5_IB_ATTR_VAR_OBJ_QUERY_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
+	MLX5_IB_ATTR_VAR_OBJ_QUERY_PAGE_ID,
+	MLX5_IB_ATTR_VAR_OBJ_QUERY_MMAP_OFFSET,
+	MLX5_IB_ATTR_VAR_OBJ_QUERY_MMAP_LENGTH,
+};
+
 enum mlx5_ib_var_obj_methods {
 	MLX5_IB_METHOD_VAR_OBJ_ALLOC = (1U << UVERBS_ID_NS_SHIFT),
 	MLX5_IB_METHOD_VAR_OBJ_DESTROY,
+	MLX5_IB_METHOD_VAR_OBJ_QUERY,
 };
 
 enum mlx5_ib_uar_alloc_attrs {

-- 
2.53.0


