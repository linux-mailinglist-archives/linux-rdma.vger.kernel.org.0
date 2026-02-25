Return-Path: <linux-rdma+bounces-17177-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOOsOokFn2mZYgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17177-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 15:22:01 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C882198A2B
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 15:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 19D473052AD8
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 14:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A2B3D3D12;
	Wed, 25 Feb 2026 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scaT0NcX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0B83D3D0B;
	Wed, 25 Feb 2026 14:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772029196; cv=none; b=NSF/I1VUWKeO4UrhsaJeeBxpEj0oCbXL/I18NaI3OwtxYcs2y6jpmsjUIWZZ8vgN/GYAJ5KF8hHeiRTQ4uBx4tiKN8EQqvYCeLc7bQnQDICpGfQtLm+dEEfUnQDuPZXkyK1Qr+jxkR9RptXTMzLuP9hMu30i60Ly33ca1fGqBlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772029196; c=relaxed/simple;
	bh=w3TVcaeOV/ur73vBlLQPPQzK3QrbtKyo5WZcT/7pBK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0gz858impADsOZr3LEsXFdexj2TxpZd4zIlyoSI+HKKlpTJdpo0h25dCb49LcnlIPV9HfNNovqujRIG+OpE+XfGlqo+SzrDHLFNuRwgitW1UxgpgTUIhcEUD+NzemCB3hwjrvulvoysduMcDbUB5bTtwWD/4r8LRZ93nf1iiNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scaT0NcX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB42C2BC86;
	Wed, 25 Feb 2026 14:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772029195;
	bh=w3TVcaeOV/ur73vBlLQPPQzK3QrbtKyo5WZcT/7pBK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=scaT0NcXf0zU+C6dGUJOkJHE0QSd2C6ZMVxUG+X7zGAUrKKTOAM4zVG4feH4rCiaN
	 LRqXJDXevdkKfDKCVcYjYfJJvty3CTT4PQFNjgpq+C09CiW01g9HIBWupldyoMev7h
	 QyN5w8EDIc2MtcMAsGdHhK14yCbAaEiHWVaS3Y+6TqGJmCq5zUJLRu2a2yHkywR4dC
	 PxRESsYQnC1ZST3v8mnWMKQcMXON5aleEH/008bxSUKrILL42izhRDXFVG9PXv8Cm5
	 QXUVGc9O2SLzSb8UpMHihbyJtQtzoWdWloT5lwh8M5M9ns8uPDArZQHfjmIunBf0ii
	 mS9bEkYpJfXkw==
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
Subject: [PATCH rdma-next 5/6] RDMA/mlx5: Add support for TLP VAR allocation
Date: Wed, 25 Feb 2026 16:19:35 +0200
Message-ID: <20260225-var-tlp-v1-5-fe14a7ac7731@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17177-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C882198A2B
X-Rspamd-Action: no action

From: Maher Sanalla <msanalla@nvidia.com>

Extend the VAR allocation UAPI to accept an optional flags attribute,
allowing userspace to request TLP VAR allocation via the
MLX5_IB_UAPI_VAR_ALLOC_FLAG_TLP flag.

When the TLP flag "MLX5_IB_UAPI_VAR_ALLOC_FLAG_TLP" is specified,
the driver selects the TLP VAR region for allocation instead of the
regular VirtIO VAR region.

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c         | 40 ++++++++++++++++++++++++++-----
 include/uapi/rdma/mlx5_user_ioctl_cmds.h  |  1 +
 include/uapi/rdma/mlx5_user_ioctl_verbs.h |  4 ++++
 3 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 424426a2cd76..77cd11c6cca9 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4153,7 +4153,7 @@ static int mlx5_rdma_user_mmap_entry_insert(struct mlx5_ib_ucontext *c,
 }
 
 static struct mlx5_user_mmap_entry *
-alloc_var_entry(struct mlx5_ib_ucontext *c)
+alloc_var_entry(struct mlx5_ib_ucontext *c, u32 flags)
 {
 	struct mlx5_user_mmap_entry *entry;
 	struct mlx5_var_region *var_region;
@@ -4162,7 +4162,11 @@ alloc_var_entry(struct mlx5_ib_ucontext *c)
 	int err;
 
 	var_table = &to_mdev(c->ibucontext.device)->var_table;
-	var_region = &var_table->var_region;
+	if (flags & MLX5_IB_UAPI_VAR_ALLOC_FLAG_TLP)
+		var_region = &var_table->tlp_var_region;
+	else
+		var_region = &var_table->var_region;
+
 	entry = kzalloc_obj(*entry);
 	if (!entry)
 		return ERR_PTR(-ENOMEM);
@@ -4182,7 +4186,9 @@ alloc_var_entry(struct mlx5_ib_ucontext *c)
 	entry->address = var_region->hw_start_addr +
 				(page_idx * var_region->stride_size);
 	entry->page_idx = page_idx;
-	entry->mmap_flag = MLX5_IB_MMAP_TYPE_VAR;
+	entry->mmap_flag = flags & MLX5_IB_UAPI_VAR_ALLOC_FLAG_TLP ?
+				   MLX5_IB_MMAP_TYPE_TLP_VAR :
+				   MLX5_IB_MMAP_TYPE_VAR;
 
 	err = mlx5_rdma_user_mmap_entry_insert(c, entry,
 					       var_region->stride_size);
@@ -4205,9 +4211,10 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_VAR_OBJ_ALLOC)(
 {
 	struct ib_uobject *uobj = uverbs_attr_get_uobject(
 		attrs, MLX5_IB_ATTR_VAR_OBJ_ALLOC_HANDLE);
-	struct mlx5_ib_ucontext *c;
 	struct mlx5_user_mmap_entry *entry;
+	struct mlx5_ib_ucontext *c;
 	u64 mmap_offset;
+	u32 flags = 0;
 	u32 length;
 	int err;
 
@@ -4215,7 +4222,24 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_VAR_OBJ_ALLOC)(
 	if (IS_ERR(c))
 		return PTR_ERR(c);
 
-	entry = alloc_var_entry(c);
+	err = uverbs_get_flags32(&flags, attrs,
+				 MLX5_IB_ATTR_VAR_OBJ_ALLOC_FLAGS,
+				 MLX5_IB_UAPI_VAR_ALLOC_FLAG_TLP);
+	if (err)
+		return err;
+
+	if (flags & MLX5_IB_UAPI_VAR_ALLOC_FLAG_TLP) {
+		if (!MLX5_CAP_GEN(to_mdev(c->ibucontext.device)->mdev,
+				  tlp_device_emulation_manager))
+			return -EOPNOTSUPP;
+	} else {
+		if (!(MLX5_CAP_GEN_64(to_mdev(c->ibucontext.device)->mdev,
+				      general_obj_types) &
+		      MLX5_GENERAL_OBJ_TYPES_CAP_VIRTIO_NET_Q))
+			return -EOPNOTSUPP;
+	}
+
+	entry = alloc_var_entry(c, flags);
 	if (IS_ERR(entry))
 		return PTR_ERR(entry);
 
@@ -4245,6 +4269,9 @@ DECLARE_UVERBS_NAMED_METHOD(
 			MLX5_IB_OBJECT_VAR,
 			UVERBS_ACCESS_NEW,
 			UA_MANDATORY),
+	UVERBS_ATTR_FLAGS_IN(MLX5_IB_ATTR_VAR_OBJ_ALLOC_FLAGS,
+			     enum mlx5_ib_uapi_var_alloc_flags,
+			     UA_OPTIONAL),
 	UVERBS_ATTR_PTR_OUT(MLX5_IB_ATTR_VAR_OBJ_ALLOC_PAGE_ID,
 			   UVERBS_ATTR_TYPE(u32),
 			   UA_MANDATORY),
@@ -4272,7 +4299,8 @@ static bool var_is_supported(struct ib_device *device)
 	struct mlx5_ib_dev *dev = to_mdev(device);
 
 	return (MLX5_CAP_GEN_64(dev->mdev, general_obj_types) &
-			MLX5_GENERAL_OBJ_TYPES_CAP_VIRTIO_NET_Q);
+			MLX5_GENERAL_OBJ_TYPES_CAP_VIRTIO_NET_Q) ||
+		MLX5_CAP_GEN(dev->mdev, tlp_device_emulation_manager);
 }
 
 static struct mlx5_user_mmap_entry *
diff --git a/include/uapi/rdma/mlx5_user_ioctl_cmds.h b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
index 18f9fe070213..01a2a050e468 100644
--- a/include/uapi/rdma/mlx5_user_ioctl_cmds.h
+++ b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
@@ -139,6 +139,7 @@ enum mlx5_ib_var_alloc_attrs {
 	MLX5_IB_ATTR_VAR_OBJ_ALLOC_MMAP_OFFSET,
 	MLX5_IB_ATTR_VAR_OBJ_ALLOC_MMAP_LENGTH,
 	MLX5_IB_ATTR_VAR_OBJ_ALLOC_PAGE_ID,
+	MLX5_IB_ATTR_VAR_OBJ_ALLOC_FLAGS,
 };
 
 enum mlx5_ib_var_obj_destroy_attrs {
diff --git a/include/uapi/rdma/mlx5_user_ioctl_verbs.h b/include/uapi/rdma/mlx5_user_ioctl_verbs.h
index 8f86e79d78a5..ef295b38a1cf 100644
--- a/include/uapi/rdma/mlx5_user_ioctl_verbs.h
+++ b/include/uapi/rdma/mlx5_user_ioctl_verbs.h
@@ -100,6 +100,10 @@ enum mlx5_ib_uapi_query_port_flags {
 	MLX5_IB_UAPI_QUERY_PORT_ESW_OWNER_VHCA_ID	= 1 << 5,
 };
 
+enum mlx5_ib_uapi_var_alloc_flags {
+	MLX5_IB_UAPI_VAR_ALLOC_FLAG_TLP = 1 << 0,
+};
+
 struct mlx5_ib_uapi_reg {
 	__u32 value;
 	__u32 mask;

-- 
2.53.0


