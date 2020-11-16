Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0EB2B5266
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Nov 2020 21:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732263AbgKPUXU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Nov 2020 15:23:20 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:34378 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732273AbgKPUXT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Nov 2020 15:23:19 -0500
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb2dfb50001>; Tue, 17 Nov 2020 04:23:17 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Nov
 2020 20:23:17 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 16 Nov 2020 20:23:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRsZoX2VZBqCUn7ja/kbGxqXOtt7ZZSiGsDDeUCqnjGjbUrHvaXPWDgABLiZJBrSx4T06nwbQUoAJVCf4pdjMbsMNgruahe1VroPit3/gz7EiRyssirfUFlUybJJ/nbHGeMVnX3MFhT8Z7K6S+G4dk/wvI260Ue4DEFR66d4ceaHdyC3gBnszWlBuJOztUoQJeEuMTXN8J+TAs5+JtKV50UvtWAxbP0M8zRPbuDPZlFuT1mtFF+dJkPCDnKNgBTt7Bk7TuWOjHDw8HglWs0HDjE6YmZcGIfX2dLI8hUk6W5dQPl/H9UO7zSkkoOdomdQM53a3qFhBbK3FxoT/N7ehA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eTkCR8woWkrC/G6SDMORKzsRZv71XqArzVZMUhPR8I=;
 b=JFiRBJTlT86rgK5lCqjk/VSN498Ln6U13qFmIiY6fwZyXhwNXZ6czPclhtStp8qldE+uytebVm+y3kCKAkYWWuygK7+gAqCevsh3ZWx2pUBsg1q5BtoLJdsVD7rr7OOh0AuXzoTgvOh4wxnXGY0m6bVWnKu3dn7f6BUfkGZSHr8qlxFatmvo6XDGvisieq2GecFzs+uvLN4GsAIDp+l+8JPwg9nzJpGx+ZtS93JFpw91PkweEn/ubFaPiKsgYXo/+Jx4P+iadpofcoNM8JIW87n69Yk2cbhrD+kr8S1ohp0hjh+uryIpbE8VmwGXeUpE8gNUr/FGg9C0cFTaZzcjYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3305.namprd12.prod.outlook.com (2603:10b6:5:189::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Mon, 16 Nov
 2020 20:23:15 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 20:23:15 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 9/9] verbs: Delete query_device() internal support
Date:   Mon, 16 Nov 2020 16:23:10 -0400
Message-ID: <9-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
In-Reply-To: <0-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0026.namprd19.prod.outlook.com
 (2603:10b6:208:178::39) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR19CA0026.namprd19.prod.outlook.com (2603:10b6:208:178::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28 via Frontend Transport; Mon, 16 Nov 2020 20:23:12 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kel1q-006l8I-Vh; Mon, 16 Nov 2020 16:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605558197; bh=HG4720+cJVyzYX1qqso0mFbPlQI5tUWkyTpDhb/SDJs=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         Subject:Date:Message-ID:In-Reply-To:References:
         Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType;
        b=MzlE12vGnq+k44czM3Wy/9Mhxs/izLC6WInQgoh6Jl1qJyg6tlAIIeNl6XU5cI7dA
         rasCefXUsqySBUmUOc13T5MeS0S4d9gmplL3/sVQScg77DXfy+t+9Afjt1pXIR07G0
         X8Kynmafc0X4BSUUFuZNaXwGKd8fwtfkQM1brOHklAhKEWNLP75h5GHmj9juyCK6jl
         a7RL/XRGXz2CZvg9EWCjd0yoFWfYiqeLXMZW21KCJFZxAGbf1FFLwMe7dcqiI4f3Mk
         8FfxZrsXcRyohKWsMICm3nQKZvEgkoHJOcTVDL8u/7yCDyD6wBCl91tIdbaMdZVxF1
         rDAPxzwPz01Bw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Now that all providers only implement the _ex API have the external API
call query_device_ex() directly and remove everything to do with
the internal query_device op.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 libibverbs/cmd.c       | 65 ------------------------------------------
 libibverbs/device.c    |  1 +
 libibverbs/driver.h    |  6 ----
 libibverbs/dummy_ops.c | 28 +-----------------
 libibverbs/verbs.c     |  5 +++-
 libibverbs/verbs.h     |  3 +-
 providers/cxgb4/dev.c  |  8 +++---
 7 files changed, 12 insertions(+), 104 deletions(-)

diff --git a/libibverbs/cmd.c b/libibverbs/cmd.c
index ec9750e7c04eb4..d7078823989bd2 100644
--- a/libibverbs/cmd.c
+++ b/libibverbs/cmd.c
@@ -47,71 +47,6 @@
=20
 bool verbs_allow_disassociate_destroy;
=20
-static void copy_query_dev_fields(struct ibv_device_attr *device_attr,
-				  struct ib_uverbs_query_device_resp *resp,
-				  uint64_t *raw_fw_ver)
-{
-	*raw_fw_ver				=3D resp->fw_ver;
-	device_attr->node_guid			=3D resp->node_guid;
-	device_attr->sys_image_guid		=3D resp->sys_image_guid;
-	device_attr->max_mr_size		=3D resp->max_mr_size;
-	device_attr->page_size_cap		=3D resp->page_size_cap;
-	device_attr->vendor_id			=3D resp->vendor_id;
-	device_attr->vendor_part_id		=3D resp->vendor_part_id;
-	device_attr->hw_ver			=3D resp->hw_ver;
-	device_attr->max_qp			=3D resp->max_qp;
-	device_attr->max_qp_wr			=3D resp->max_qp_wr;
-	device_attr->device_cap_flags		=3D resp->device_cap_flags;
-	device_attr->max_sge			=3D resp->max_sge;
-	device_attr->max_sge_rd			=3D resp->max_sge_rd;
-	device_attr->max_cq			=3D resp->max_cq;
-	device_attr->max_cqe			=3D resp->max_cqe;
-	device_attr->max_mr			=3D resp->max_mr;
-	device_attr->max_pd			=3D resp->max_pd;
-	device_attr->max_qp_rd_atom		=3D resp->max_qp_rd_atom;
-	device_attr->max_ee_rd_atom		=3D resp->max_ee_rd_atom;
-	device_attr->max_res_rd_atom		=3D resp->max_res_rd_atom;
-	device_attr->max_qp_init_rd_atom	=3D resp->max_qp_init_rd_atom;
-	device_attr->max_ee_init_rd_atom	=3D resp->max_ee_init_rd_atom;
-	device_attr->atomic_cap			=3D resp->atomic_cap;
-	device_attr->max_ee			=3D resp->max_ee;
-	device_attr->max_rdd			=3D resp->max_rdd;
-	device_attr->max_mw			=3D resp->max_mw;
-	device_attr->max_raw_ipv6_qp		=3D resp->max_raw_ipv6_qp;
-	device_attr->max_raw_ethy_qp		=3D resp->max_raw_ethy_qp;
-	device_attr->max_mcast_grp		=3D resp->max_mcast_grp;
-	device_attr->max_mcast_qp_attach	=3D resp->max_mcast_qp_attach;
-	device_attr->max_total_mcast_qp_attach	=3D resp->max_total_mcast_qp_attac=
h;
-	device_attr->max_ah			=3D resp->max_ah;
-	device_attr->max_fmr			=3D resp->max_fmr;
-	device_attr->max_map_per_fmr		=3D resp->max_map_per_fmr;
-	device_attr->max_srq			=3D resp->max_srq;
-	device_attr->max_srq_wr			=3D resp->max_srq_wr;
-	device_attr->max_srq_sge		=3D resp->max_srq_sge;
-	device_attr->max_pkeys			=3D resp->max_pkeys;
-	device_attr->local_ca_ack_delay		=3D resp->local_ca_ack_delay;
-	device_attr->phys_port_cnt		=3D resp->phys_port_cnt;
-}
-
-int ibv_cmd_query_device(struct ibv_context *context,
-			 struct ibv_device_attr *device_attr,
-			 uint64_t *raw_fw_ver,
-			 struct ibv_query_device *cmd, size_t cmd_size)
-{
-	struct ib_uverbs_query_device_resp resp;
-	int ret;
-
-	ret =3D execute_cmd_write(context, IB_USER_VERBS_CMD_QUERY_DEVICE, cmd,
-				cmd_size, &resp, sizeof(resp));
-	if (ret)
-		return ret;
-
-	memset(device_attr->fw_ver, 0, sizeof device_attr->fw_ver);
-	copy_query_dev_fields(device_attr, &resp, raw_fw_ver);
-
-	return 0;
-}
-
 int ibv_cmd_alloc_pd(struct ibv_context *context, struct ibv_pd *pd,
 		     struct ibv_alloc_pd *cmd, size_t cmd_size,
 		     struct ib_uverbs_alloc_pd_resp *resp, size_t resp_size)
diff --git a/libibverbs/device.c b/libibverbs/device.c
index e9c429a51c7dd1..331a0871b4a77b 100644
--- a/libibverbs/device.c
+++ b/libibverbs/device.c
@@ -320,6 +320,7 @@ static void set_lib_ops(struct verbs_context *vctx)
 #undef ibv_query_port
 	vctx->context.ops._compat_query_port =3D ibv_query_port;
 	vctx->query_port =3D __lib_query_port;
+	vctx->context.ops._compat_query_device =3D ibv_query_device;
=20
 	/*
 	 * In order to maintain backward/forward binary compatibility
diff --git a/libibverbs/driver.h b/libibverbs/driver.h
index 33998e227c98ec..359b17302fab5d 100644
--- a/libibverbs/driver.h
+++ b/libibverbs/driver.h
@@ -354,8 +354,6 @@ struct verbs_context_ops {
 			    struct ibv_ops_wr **bad_op);
 	int (*post_srq_recv)(struct ibv_srq *srq, struct ibv_recv_wr *recv_wr,
 			     struct ibv_recv_wr **bad_recv_wr);
-	int (*query_device)(struct ibv_context *context,
-			    struct ibv_device_attr *device_attr);
 	int (*query_device_ex)(struct ibv_context *context,
 			       const struct ibv_query_device_ex_input *input,
 			       struct ibv_device_attr_ex *attr,
@@ -449,10 +447,6 @@ int ibv_cmd_get_context(struct verbs_context *context,
 			struct ib_uverbs_get_context_resp *resp, size_t resp_size);
 int ibv_cmd_query_context(struct ibv_context *ctx,
 			  struct ibv_command_buffer *driver);
-int ibv_cmd_query_device(struct ibv_context *context,
-			 struct ibv_device_attr *device_attr,
-			 uint64_t *raw_fw_ver,
-			 struct ibv_query_device *cmd, size_t cmd_size);
 int ibv_cmd_create_flow_action_esp(struct ibv_context *ctx,
 				   struct ibv_flow_action_esp_attr *attr,
 				   struct verbs_flow_action *flow_action,
diff --git a/libibverbs/dummy_ops.c b/libibverbs/dummy_ops.c
index 711dfafb5caed5..b6f272dbd8f6de 100644
--- a/libibverbs/dummy_ops.c
+++ b/libibverbs/dummy_ops.c
@@ -377,35 +377,11 @@ static int post_srq_recv(struct ibv_srq *srq, struct =
ibv_recv_wr *recv_wr,
 	return EOPNOTSUPP;
 }
=20
-static int query_device(struct ibv_context *context,
-			struct ibv_device_attr *device_attr)
-{
-	const struct verbs_context_ops *ops =3D get_ops(context);
-
-	if (!ops->query_device_ex)
-		return EOPNOTSUPP;
-	return ops->query_device_ex(
-		context, NULL,
-		container_of(device_attr, struct ibv_device_attr_ex, orig_attr),
-		sizeof(*device_attr));
-}
-
-/* Provide a generic implementation for all providers that don't implement
- * query_device_ex.
- */
 static int query_device_ex(struct ibv_context *context,
 			   const struct ibv_query_device_ex_input *input,
 			   struct ibv_device_attr_ex *attr, size_t attr_size)
 {
-	if (input && input->comp_mask)
-		return EINVAL;
-
-	if (attr_size < sizeof(attr->orig_attr))
-		return EOPNOTSUPP;
-
-	memset(attr, 0, attr_size);
-
-	return ibv_query_device(context, &attr->orig_attr);
+	return EOPNOTSUPP;
 }
=20
 static int query_ece(struct ibv_qp *qp, struct ibv_ece *ece)
@@ -558,7 +534,6 @@ const struct verbs_context_ops verbs_dummy_ops =3D {
 	post_send,
 	post_srq_ops,
 	post_srq_recv,
-	query_device,
 	query_device_ex,
 	query_ece,
 	query_port,
@@ -680,7 +655,6 @@ void verbs_set_ops(struct verbs_context *vctx,
 	SET_OP(ctx, post_send);
 	SET_OP(vctx, post_srq_ops);
 	SET_OP(ctx, post_srq_recv);
-	SET_PRIV_OP(ctx, query_device);
 	SET_OP(vctx, query_device_ex);
 	SET_PRIV_OP_IC(vctx, query_ece);
 	SET_PRIV_OP_IC(ctx, query_port);
diff --git a/libibverbs/verbs.c b/libibverbs/verbs.c
index 7fc10240cf9def..18f5cba8c49525 100644
--- a/libibverbs/verbs.c
+++ b/libibverbs/verbs.c
@@ -156,7 +156,10 @@ LATEST_SYMVER_FUNC(ibv_query_device, 1_1, "IBVERBS_1.1=
",
 		   struct ibv_context *context,
 		   struct ibv_device_attr *device_attr)
 {
-	return get_ops(context)->query_device(context, device_attr);
+	return get_ops(context)->query_device_ex(
+		context, NULL,
+		container_of(device_attr, struct ibv_device_attr_ex, orig_attr),
+		sizeof(*device_attr));
 }
=20
 int __lib_query_port(struct ibv_context *context, uint8_t port_num,
diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
index ee57e0526d65b4..aafab2ab5547bd 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -1922,7 +1922,8 @@ struct ibv_device {
=20
 struct _compat_ibv_port_attr;
 struct ibv_context_ops {
-	void *(*_compat_query_device)(void);
+	int (*_compat_query_device)(struct ibv_context *context,
+				    struct ibv_device_attr *device_attr);
 	int (*_compat_query_port)(struct ibv_context *context,
 				  uint8_t port_num,
 				  struct _compat_ibv_port_attr *port_attr);
diff --git a/providers/cxgb4/dev.c b/providers/cxgb4/dev.c
index 76b78d9b29a71c..c42c2300f1751f 100644
--- a/providers/cxgb4/dev.c
+++ b/providers/cxgb4/dev.c
@@ -114,8 +114,6 @@ static struct verbs_context *c4iw_alloc_context(struct =
ibv_device *ibdev,
 	struct ibv_get_context cmd;
 	struct uc4iw_alloc_ucontext_resp resp;
 	struct c4iw_dev *rhp =3D to_c4iw_dev(ibdev);
-	struct ibv_query_device qcmd;
-	uint64_t raw_fw_ver;
 	struct ibv_device_attr attr;
=20
 	context =3D verbs_init_and_alloc_context(ibdev, cmd_fd, context, ibv_ctx,
@@ -143,8 +141,10 @@ static struct verbs_context *c4iw_alloc_context(struct=
 ibv_device *ibdev,
 	}=20
=20
 	verbs_set_ops(&context->ibv_ctx, &c4iw_ctx_common_ops);
-	if (ibv_cmd_query_device(&context->ibv_ctx.context, &attr,
-				 &raw_fw_ver, &qcmd, sizeof(qcmd)))
+	if (c4iw_query_device(&context->ibv_ctx.context, NULL,
+			      container_of(&attr, struct ibv_device_attr_ex,
+					   orig_attr),
+			      sizeof(attr)))
 		goto err_unmap;
=20
 	if (!rhp->mmid2ptr) {
--=20
2.29.2

