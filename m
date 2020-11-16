Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0B52B526D
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Nov 2020 21:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732296AbgKPUXW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Nov 2020 15:23:22 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:41714 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732338AbgKPUXV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Nov 2020 15:23:21 -0500
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb2dfb80000>; Tue, 17 Nov 2020 04:23:20 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Nov
 2020 20:23:20 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 16 Nov 2020 20:23:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOBShVJgNWcLI4/X1aew8msDUQOlIvBWmnjGJgDIWWWYkxnNXoqRW3a4rls2gzSktQ7ycIS/bue6W9cZbIdM8WCjBtLyppkjHpk3L6z9RqBq7fPi62DI90zB3f4T1vr5bmKjyOwSUWGBEFitkz7kQnbJLpIaMmgIElWx017boYW+KfgN8KZ5yFLtTHYrYjJMkR0ljSBi2jl4tmpdM3mOt7YlZLT7Dh/UtygeimONrKDX5dIJnte87eV/J/faThkXbEZ+lwnKW140LQR6/TpfvpkXgl/AI3PMsa1mFPrZWYPYH9QmdwTyfvKb/G9Q6Nh7Qi0UCn5TKge3myvBbnqdaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqEXq/nsH8uNY37KeLcHiX720dv29a5KRuWdnUVvS3A=;
 b=ccNzaniqzoi2UUmBVfdXQUHMvnTz+yKbwQ8IBQNRwCycyAtrl/X8FJoQwt9fjEBpLAtFZmjnXU0FeOB11104C/6HdEg5CvDuNoSGwJECGyccq9Yis4MtNf8XVDF7az9PnO7luwnZRP1dAqhfKtxqb7T377037w4eSY+I/WQAJrRMD0BYTeiwv2ty7x5VBXLI5rCXnIoXwoWLjVaGtqsgaKnBg58a9WsQ7Sl/k0LaXuWFvX82v2so/NLj1kPpb1qFqq7+7pnF4wvtJK5wFWxiAaW9ovF45NRW9pOwogragkC/sD4m7LlUBf4s/YnLFdA9wxwTProUWB/JG5IZ1SDrLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3305.namprd12.prod.outlook.com (2603:10b6:5:189::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Mon, 16 Nov
 2020 20:23:16 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 20:23:16 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 6/9] providers: Remove normal query_device() from providers that have _ex
Date:   Mon, 16 Nov 2020 16:23:07 -0400
Message-ID: <6-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
In-Reply-To: <0-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0015.namprd22.prod.outlook.com
 (2603:10b6:208:238::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR22CA0015.namprd22.prod.outlook.com (2603:10b6:208:238::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28 via Frontend Transport; Mon, 16 Nov 2020 20:23:15 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kel1q-006l87-SE; Mon, 16 Nov 2020 16:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605558200; bh=yCAtk7tRWNCdxVYMX4hqFw1dOCF93202jEr/2cgCb6g=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         Subject:Date:Message-ID:In-Reply-To:References:
         Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType;
        b=WwdEoURsmeRyfgqx0fLcM5fCptIhtwEswmcei4skhqa60A6bb/KXw31BTGZt6wBe+
         CDsnqilxN9XzMFNYmIx+/8uc8NbsfHz7GR9Rz2v7v1np/1Yg+uR2uDKvqvy9wf1twA
         kBmYUvs1GUs74GpT9zJZbY9Z/LLSVRV8Ej8PtcaiAwtS/5x5M70CKQKkMttBkcqfLE
         MUCUpS3Nt0p1Jzs87RdVDFZy5dY3n0o6Us1tHGX8S06Se1YpC4WqQBX8+a6EYfVDBy
         /v1h2bPkv3vbMi5rjq6xCKd3kb2/ZKNarHAyuQ/mqK7vqxq/WWQoVSfD3JsNP3EULP
         hjQTJ4MW/0VSA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The ex callback can implement both versions, no reason for duplicate
code in two paths. Have the core code call the _ex version instead.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 libibverbs/dummy_ops.c |  9 ++++-
 providers/efa/efa.c    |  1 -
 providers/efa/verbs.c  | 36 +++++---------------
 providers/efa/verbs.h  |  1 -
 providers/mlx4/mlx4.c  |  1 -
 providers/mlx4/mlx4.h  |  2 --
 providers/mlx4/verbs.c | 45 +++++++++----------------
 providers/mlx5/mlx5.c  |  1 -
 providers/mlx5/mlx5.h  |  2 --
 providers/mlx5/verbs.c | 75 +++++++++++++++++-------------------------
 10 files changed, 61 insertions(+), 112 deletions(-)

diff --git a/libibverbs/dummy_ops.c b/libibverbs/dummy_ops.c
index e5af9e4eac8e34..711dfafb5caed5 100644
--- a/libibverbs/dummy_ops.c
+++ b/libibverbs/dummy_ops.c
@@ -380,7 +380,14 @@ static int post_srq_recv(struct ibv_srq *srq, struct i=
bv_recv_wr *recv_wr,
 static int query_device(struct ibv_context *context,
 			struct ibv_device_attr *device_attr)
 {
-	return EOPNOTSUPP;
+	const struct verbs_context_ops *ops =3D get_ops(context);
+
+	if (!ops->query_device_ex)
+		return EOPNOTSUPP;
+	return ops->query_device_ex(
+		context, NULL,
+		container_of(device_attr, struct ibv_device_attr_ex, orig_attr),
+		sizeof(*device_attr));
 }
=20
 /* Provide a generic implementation for all providers that don't implement
diff --git a/providers/efa/efa.c b/providers/efa/efa.c
index b24c14f7fa1fe1..f6d314dad51e58 100644
--- a/providers/efa/efa.c
+++ b/providers/efa/efa.c
@@ -40,7 +40,6 @@ static const struct verbs_context_ops efa_ctx_ops =3D {
 	.poll_cq =3D efa_poll_cq,
 	.post_recv =3D efa_post_recv,
 	.post_send =3D efa_post_send,
-	.query_device =3D efa_query_device,
 	.query_device_ex =3D efa_query_device_ex,
 	.query_port =3D efa_query_port,
 	.query_qp =3D efa_query_qp,
diff --git a/providers/efa/verbs.c b/providers/efa/verbs.c
index 52d6285f1f409c..d50206c13d4295 100644
--- a/providers/efa/verbs.c
+++ b/providers/efa/verbs.c
@@ -56,27 +56,6 @@ struct efa_wq_init_attr {
 	uint16_t sub_cq_idx;
 };
=20
-int efa_query_device(struct ibv_context *ibvctx,
-		     struct ibv_device_attr *dev_attr)
-{
-	struct efa_context *ctx =3D to_efa_context(ibvctx);
-	struct ibv_query_device cmd;
-	uint8_t fw_ver[8];
-	int err;
-
-	err =3D ibv_cmd_query_device(ibvctx, dev_attr, (uint64_t *)&fw_ver,
-				   &cmd, sizeof(cmd));
-	if (err)
-		return err;
-
-	dev_attr->max_qp_wr =3D min_t(int, dev_attr->max_qp_wr,
-				    ctx->max_llq_size / sizeof(struct efa_io_tx_wqe));
-	snprintf(dev_attr->fw_ver, sizeof(dev_attr->fw_ver), "%u.%u.%u.%u",
-		 fw_ver[0], fw_ver[1], fw_ver[2], fw_ver[3]);
-
-	return 0;
-}
-
 int efa_query_port(struct ibv_context *ibvctx, uint8_t port,
 		   struct ibv_port_attr *port_attr)
 {
@@ -91,23 +70,24 @@ int efa_query_device_ex(struct ibv_context *context,
 			size_t attr_size)
 {
 	struct efa_context *ctx =3D to_efa_context(context);
-	int cmd_supp_uhw =3D ctx->cmds_supp_udata_mask &
-			   EFA_USER_CMDS_SUPP_UDATA_QUERY_DEVICE;
 	struct ibv_device_attr *a =3D &attr->orig_attr;
 	struct efa_query_device_ex_resp resp =3D {};
-	struct ibv_query_device_ex cmd =3D {};
+	size_t resp_size =3D (ctx->cmds_supp_udata_mask &
+			    EFA_USER_CMDS_SUPP_UDATA_QUERY_DEVICE) ?
+				   sizeof(resp) :
+				   sizeof(resp.ibv_resp);
 	uint8_t fw_ver[8];
 	int err;
=20
-	err =3D ibv_cmd_query_device_ex(
-		context, input, attr, attr_size, (uint64_t *)&fw_ver, &cmd,
-		sizeof(cmd), &resp.ibv_resp,
-		cmd_supp_uhw ? sizeof(resp) : sizeof(resp.ibv_resp));
+	err =3D ibv_cmd_query_device_any(context, input, attr, attr_size,
+				       &resp.ibv_resp, &resp_size);
 	if (err)
 		return err;
=20
 	a->max_qp_wr =3D min_t(int, a->max_qp_wr,
 			     ctx->max_llq_size / sizeof(struct efa_io_tx_wqe));
+	memcpy(fw_ver, &resp.ibv_resp.base.fw_ver,
+	       sizeof(resp.ibv_resp.base.fw_ver));
 	snprintf(a->fw_ver, sizeof(a->fw_ver), "%u.%u.%u.%u",
 		 fw_ver[0], fw_ver[1], fw_ver[2], fw_ver[3]);
=20
diff --git a/providers/efa/verbs.h b/providers/efa/verbs.h
index 3b0e4e0d498761..b7ae3f0a15c00c 100644
--- a/providers/efa/verbs.h
+++ b/providers/efa/verbs.h
@@ -10,7 +10,6 @@
 #include <infiniband/verbs.h>
=20
 int efa_query_device_ctx(struct efa_context *ctx);
-int efa_query_device(struct ibv_context *uctx, struct ibv_device_attr *att=
r);
 int efa_query_port(struct ibv_context *uctx, uint8_t port,
 		   struct ibv_port_attr *attr);
 int efa_query_device_ex(struct ibv_context *context,
diff --git a/providers/mlx4/mlx4.c b/providers/mlx4/mlx4.c
index 619b841d788cb2..1e71cde4a1f9dc 100644
--- a/providers/mlx4/mlx4.c
+++ b/providers/mlx4/mlx4.c
@@ -84,7 +84,6 @@ static const struct verbs_match_ent hca_table[] =3D {
 };
=20
 static const struct verbs_context_ops mlx4_ctx_ops =3D {
-	.query_device  =3D mlx4_query_device,
 	.query_port    =3D mlx4_query_port,
 	.alloc_pd      =3D mlx4_alloc_pd,
 	.dealloc_pd    =3D mlx4_free_pd,
diff --git a/providers/mlx4/mlx4.h b/providers/mlx4/mlx4.h
index 3c0787144e7e51..6c6ffc77657463 100644
--- a/providers/mlx4/mlx4.h
+++ b/providers/mlx4/mlx4.h
@@ -305,8 +305,6 @@ void mlx4_free_db(struct mlx4_context *context, enum ml=
x4_db_type type,
 		  __be32 *db);
=20
 void mlx4_query_device_ctx(struct mlx4_device *mdev, struct mlx4_context *=
mctx);
-int mlx4_query_device(struct ibv_context *context,
-		       struct ibv_device_attr *attr);
 int mlx4_query_device_ex(struct ibv_context *context,
 			 const struct ibv_query_device_ex_input *input,
 			 struct ibv_device_attr_ex *attr,
diff --git a/providers/mlx4/verbs.c b/providers/mlx4/verbs.c
index 4fe5c1d87d6d91..ea8e882bb363ba 100644
--- a/providers/mlx4/verbs.c
+++ b/providers/mlx4/verbs.c
@@ -45,51 +45,36 @@
 #include "mlx4.h"
 #include "mlx4-abi.h"
=20
-int mlx4_query_device(struct ibv_context *context, struct ibv_device_attr =
*attr)
-{
-	struct ibv_query_device cmd;
-	uint64_t raw_fw_ver;
-	unsigned major, minor, sub_minor;
-	int ret;
-
-	ret =3D ibv_cmd_query_device(context, attr, &raw_fw_ver, &cmd, sizeof cmd=
);
-	if (ret)
-		return ret;
-
-	major     =3D (raw_fw_ver >> 32) & 0xffff;
-	minor     =3D (raw_fw_ver >> 16) & 0xffff;
-	sub_minor =3D raw_fw_ver & 0xffff;
-
-	snprintf(attr->fw_ver, sizeof attr->fw_ver,
-		 "%d.%d.%03d", major, minor, sub_minor);
-
-	return 0;
-}
-
 int mlx4_query_device_ex(struct ibv_context *context,
 			 const struct ibv_query_device_ex_input *input,
 			 struct ibv_device_attr_ex *attr,
 			 size_t attr_size)
 {
-	struct mlx4_query_device_ex_resp resp =3D {};
-	struct mlx4_query_device_ex cmd =3D {};
+	struct mlx4_query_device_ex_resp resp;
+	size_t resp_size =3D sizeof(resp);
 	uint64_t raw_fw_ver;
 	unsigned sub_minor;
 	unsigned major;
 	unsigned minor;
 	int err;
=20
-	err =3D ibv_cmd_query_device_ex(context, input, attr, attr_size,
-				      &raw_fw_ver, &cmd.ibv_cmd, sizeof(cmd),
-				      &resp.ibv_resp, sizeof(resp));
+	err =3D ibv_cmd_query_device_any(context, input, attr, attr_size,
+				       &resp.ibv_resp, &resp_size);
 	if (err)
 		return err;
=20
-	attr->rss_caps.rx_hash_fields_mask =3D resp.rss_caps.rx_hash_fields_mask;
-	attr->rss_caps.rx_hash_function =3D resp.rss_caps.rx_hash_function;
-	attr->tso_caps.max_tso =3D resp.tso_caps.max_tso;
-	attr->tso_caps.supported_qpts =3D resp.tso_caps.supported_qpts;
+	if (attr_size >=3D offsetofend(struct ibv_device_attr_ex, rss_caps)) {
+		attr->rss_caps.rx_hash_fields_mask =3D
+			resp.rss_caps.rx_hash_fields_mask;
+		attr->rss_caps.rx_hash_function =3D
+			resp.rss_caps.rx_hash_function;
+	}
+	if (attr_size >=3D offsetofend(struct ibv_device_attr_ex, tso_caps)) {
+		attr->tso_caps.max_tso =3D resp.tso_caps.max_tso;
+		attr->tso_caps.supported_qpts =3D resp.tso_caps.supported_qpts;
+	}
=20
+	raw_fw_ver =3D resp.ibv_resp.base.fw_ver;
 	major     =3D (raw_fw_ver >> 32) & 0xffff;
 	minor     =3D (raw_fw_ver >> 16) & 0xffff;
 	sub_minor =3D raw_fw_ver & 0xffff;
diff --git a/providers/mlx5/mlx5.c b/providers/mlx5/mlx5.c
index 06b9a52ebb3019..cf0a62928705bc 100644
--- a/providers/mlx5/mlx5.c
+++ b/providers/mlx5/mlx5.c
@@ -90,7 +90,6 @@ uint32_t mlx5_debug_mask =3D 0;
 int mlx5_freeze_on_error_cqe;
=20
 static const struct verbs_context_ops mlx5_ctx_common_ops =3D {
-	.query_device  =3D mlx5_query_device,
 	.query_port    =3D mlx5_query_port,
 	.alloc_pd      =3D mlx5_alloc_pd,
 	.async_event   =3D mlx5_async_event,
diff --git a/providers/mlx5/mlx5.h b/providers/mlx5/mlx5.h
index 72e710b7b5e4aa..8821015c6d503e 100644
--- a/providers/mlx5/mlx5.h
+++ b/providers/mlx5/mlx5.h
@@ -879,8 +879,6 @@ void mlx5_free_db(struct mlx5_context *context, __be32 =
*db, struct ibv_pd *pd,
 		  bool custom_alloc);
=20
 void mlx5_query_device_ctx(struct mlx5_context *mctx);
-int mlx5_query_device(struct ibv_context *context,
-		       struct ibv_device_attr *attr);
 int mlx5_query_device_ex(struct ibv_context *context,
 			 const struct ibv_query_device_ex_input *input,
 			 struct ibv_device_attr_ex *attr,
diff --git a/providers/mlx5/verbs.c b/providers/mlx5/verbs.c
index 42c984033d8eaa..5882e209b06b54 100644
--- a/providers/mlx5/verbs.c
+++ b/providers/mlx5/verbs.c
@@ -65,27 +65,6 @@ static inline int is_xrc_tgt(int type)
 	return type =3D=3D IBV_QPT_XRC_RECV;
 }
=20
-int mlx5_query_device(struct ibv_context *context, struct ibv_device_attr =
*attr)
-{
-	struct ibv_query_device cmd;
-	uint64_t raw_fw_ver;
-	unsigned major, minor, sub_minor;
-	int ret;
-
-	ret =3D ibv_cmd_query_device(context, attr, &raw_fw_ver, &cmd, sizeof cmd=
);
-	if (ret)
-		return ret;
-
-	major     =3D (raw_fw_ver >> 32) & 0xffff;
-	minor     =3D (raw_fw_ver >> 16) & 0xffff;
-	sub_minor =3D raw_fw_ver & 0xffff;
-
-	snprintf(attr->fw_ver, sizeof attr->fw_ver,
-		 "%d.%d.%04d", major, minor, sub_minor);
-
-	return 0;
-}
-
 static int mlx5_read_clock(struct ibv_context *context, uint64_t *cycles)
 {
 	unsigned int clockhi, clocklo, clockhi1;
@@ -3481,37 +3460,47 @@ int mlx5_query_device_ex(struct ibv_context *contex=
t,
 			 size_t attr_size)
 {
 	struct mlx5_context *mctx =3D to_mctx(context);
-	struct mlx5_query_device_ex_resp resp;
-	struct mlx5_query_device_ex cmd;
+	struct mlx5_query_device_ex_resp resp =3D {};
+	size_t resp_size =3D
+		(mctx->cmds_supp_uhw & MLX5_USER_CMDS_SUPP_UHW_QUERY_DEVICE) ?
+			sizeof(resp) :
+			sizeof(resp.ibv_resp);
 	struct ibv_device_attr *a;
 	uint64_t raw_fw_ver;
 	unsigned sub_minor;
 	unsigned major;
 	unsigned minor;
 	int err;
-	int cmd_supp_uhw =3D mctx->cmds_supp_uhw &
-		MLX5_USER_CMDS_SUPP_UHW_QUERY_DEVICE;
=20
-	memset(&cmd, 0, sizeof(cmd));
-	memset(&resp, 0, sizeof(resp));
-	err =3D ibv_cmd_query_device_ex(
-		context, input, attr, attr_size, &raw_fw_ver, &cmd.ibv_cmd,
-		sizeof(cmd), &resp.ibv_resp,
-		cmd_supp_uhw ? sizeof(resp) : sizeof(resp.ibv_resp));
+	err =3D ibv_cmd_query_device_any(context, input, attr, attr_size,
+				       &resp.ibv_resp, &resp_size);
 	if (err)
 		return err;
=20
-	attr->tso_caps.max_tso =3D resp.tso_caps.max_tso;
-	attr->tso_caps.supported_qpts =3D resp.tso_caps.supported_qpts;
-	attr->rss_caps.rx_hash_fields_mask =3D resp.rss_caps.rx_hash_fields_mask;
-	attr->rss_caps.rx_hash_function =3D resp.rss_caps.rx_hash_function;
-	attr->packet_pacing_caps.qp_rate_limit_min =3D
-		resp.packet_pacing_caps.qp_rate_limit_min;
-	attr->packet_pacing_caps.qp_rate_limit_max =3D
-		resp.packet_pacing_caps.qp_rate_limit_max;
-	attr->packet_pacing_caps.supported_qpts =3D
-		resp.packet_pacing_caps.supported_qpts;
+	if (attr_size >=3D offsetofend(struct ibv_device_attr_ex, tso_caps)) {
+		attr->tso_caps.max_tso =3D resp.tso_caps.max_tso;
+		attr->tso_caps.supported_qpts =3D resp.tso_caps.supported_qpts;
+	}
+	if (attr_size >=3D offsetofend(struct ibv_device_attr_ex, rss_caps)) {
+		attr->rss_caps.rx_hash_fields_mask =3D
+			resp.rss_caps.rx_hash_fields_mask;
+		attr->rss_caps.rx_hash_function =3D
+			resp.rss_caps.rx_hash_function;
+	}
+	if (attr_size >=3D
+	    offsetofend(struct ibv_device_attr_ex, packet_pacing_caps)) {
+		attr->packet_pacing_caps.qp_rate_limit_min =3D
+			resp.packet_pacing_caps.qp_rate_limit_min;
+		attr->packet_pacing_caps.qp_rate_limit_max =3D
+			resp.packet_pacing_caps.qp_rate_limit_max;
+		attr->packet_pacing_caps.supported_qpts =3D
+			resp.packet_pacing_caps.supported_qpts;
+	}
+
+	if (attr_size >=3D offsetofend(struct ibv_device_attr_ex, pci_atomic_caps=
))
+		get_pci_atomic_caps(context, attr);
=20
+	raw_fw_ver =3D resp.ibv_resp.base.fw_ver;
 	major     =3D (raw_fw_ver >> 32) & 0xffff;
 	minor     =3D (raw_fw_ver >> 16) & 0xffff;
 	sub_minor =3D raw_fw_ver & 0xffff;
@@ -3519,10 +3508,6 @@ int mlx5_query_device_ex(struct ibv_context *context=
,
 	snprintf(a->fw_ver, sizeof(a->fw_ver), "%d.%d.%04d",
 		 major, minor, sub_minor);
=20
-	if (attr_size >=3D offsetof(struct ibv_device_attr_ex, pci_atomic_caps) +
-			sizeof(attr->pci_atomic_caps))
-		get_pci_atomic_caps(context, attr);
-
 	return 0;
 }
=20
--=20
2.29.2

