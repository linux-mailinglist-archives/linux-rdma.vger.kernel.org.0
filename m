Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC162B5262
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Nov 2020 21:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732269AbgKPUXO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Nov 2020 15:23:14 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12625 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbgKPUXN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Nov 2020 15:23:13 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb2dfbb0000>; Mon, 16 Nov 2020 12:23:23 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Nov
 2020 20:23:12 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 16 Nov 2020 20:23:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsU0ejNyBy83Sj9tzZWtGmG2/80YE+EY56XAA/kVUfu5yMvcPPhJbgJL/xyFKldXRIlYFnRgng0CST2ovi5BArFFURZKUAPAGFrMidVhmKnCSJcmpVtWNpSBZchF6x2QxlnFZPmY3nwOlgq/yy8YpLeqrfzi8pOrX01IXUpK4YjMx9xhv2FjE2aZQcf/LV9r1Nj9bcL/jyHz4PCZX0ck7zZRfSKbT6+Xh1xIJZLf//XXSmxAjBfksdM2CkJ/5XhvYS6Hu/Xmk95xMW5UoMz9QkmLAOfpLGDaiwYCprP4vX72y4b5D+r1BlvRtmvtSnZ8yMAOFtSL6y6EHb+0htIlKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51s1+kWORPkJl090L1pmm00dTc7s19N82eli6m206aw=;
 b=Xv1a0ess24vUWAG87QM+KLx1WZGwr2LYT7ugHIKa99pS84pLgkBfF43rRgyvxOp6gkUz3orhAStCKzx1nEsDlkhZNXF9Sj3pDl4dgSDj6iF2AAnZBjSNJZC/vGYwzCPgeEYBXPThMc0H4J/+fgx6TI0ABwSE1KkuGIzl6EOfOgFgB9qGV0g7Yr0lzBp4/l9rvP/Bs2vim7T9uLObk/Pv7wtD76WC111USIBtJ/zA9iJn4gqXACulg5nKjaxvHVqcxm7DGc7bNArSz10rp8+akXdMBXrbeDamWMVbgPvcMWfvYBKmBXcgpW+43hZ/lJmX+wXjzPyw1lFC95YjQKNLYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3305.namprd12.prod.outlook.com (2603:10b6:5:189::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Mon, 16 Nov
 2020 20:23:11 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 20:23:11 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 3/9] mlx5: Move context initialization out of mlx5_query_device_ex()
Date:   Mon, 16 Nov 2020 16:23:04 -0400
Message-ID: <3-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
In-Reply-To: <0-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR11CA0001.namprd11.prod.outlook.com
 (2603:10b6:208:23b::6) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR11CA0001.namprd11.prod.outlook.com (2603:10b6:208:23b::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend Transport; Mon, 16 Nov 2020 20:23:11 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kel1q-006l7v-P8; Mon, 16 Nov 2020 16:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605558203; bh=GEePscrNeNY8DNgcLpwdv53Z3sJTM2FGoOcqyrl16ow=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         Subject:Date:Message-ID:In-Reply-To:References:
         Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType;
        b=aHV+NuqAL1d+PU4J6OVXtANPgNNK4ddJrUtYNkW5x9kGLFveqD5fXRekvZXo0vMZj
         xEyZ5yBXg3wp5EBkVNDJoPfGyfJN9Jp5tGbIvbbQ+O0XS4QVMD1CTJux/DdcacKnki
         EkF5bTCNojyWr04vrixLOr3RdWur3H5DTs4hLWRK/PjyTPi0E0VnW9nW/vo4osdD90
         KcJjrkxw10EeVDLzs2biLRfrxDPYNhfn1ouaxqgOjzKKLCraZEjzijpQrA0qbB6z8a
         SbAHSPjXjmK4mw+I+0mxfXTgdHd+ghIkGlQ8/ijjtiKZTctrz4MG6l3juoxDJnvuk5
         oPhD6+1YLeWlg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When the user calls mlx5_query_device_ex() it should not cause the context
values to be mutated, only the attribute should be returned.

Move this code to a dedicated function that is only called during context
setup.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 providers/mlx5/mlx5.c  | 10 +------
 providers/mlx5/mlx5.h  |  1 +
 providers/mlx5/verbs.c | 62 ++++++++++++++++++++++++++++--------------
 3 files changed, 44 insertions(+), 29 deletions(-)

diff --git a/providers/mlx5/mlx5.c b/providers/mlx5/mlx5.c
index 1378acf2e2f3af..06b9a52ebb3019 100644
--- a/providers/mlx5/mlx5.c
+++ b/providers/mlx5/mlx5.c
@@ -1373,7 +1373,6 @@ static int mlx5_set_context(struct mlx5_context *cont=
ext,
 {
 	struct verbs_context *v_ctx =3D &context->ibv_ctx;
 	struct ibv_port_attr port_attr =3D {};
-	struct ibv_device_attr_ex device_attr =3D {};
 	int cmd_fd =3D v_ctx->context.cmd_fd;
 	struct mlx5_device *mdev =3D to_mdev(v_ctx->context.device);
 	struct ibv_device *ibdev =3D v_ctx->context.device;
@@ -1518,14 +1517,7 @@ bf_done:
 			goto err_free;
 	}
=20
-	if (!mlx5_query_device_ex(&v_ctx->context, NULL, &device_attr,
-				  sizeof(struct ibv_device_attr_ex))) {
-		context->cached_device_cap_flags =3D
-			device_attr.orig_attr.device_cap_flags;
-		context->atomic_cap =3D device_attr.orig_attr.atomic_cap;
-		context->cached_tso_caps =3D device_attr.tso_caps;
-		context->max_dm_size =3D device_attr.max_dm_size;
-	}
+	mlx5_query_device_ctx(context);
=20
 	for (j =3D 0; j < min(MLX5_MAX_PORTS_NUM, context->num_ports); ++j) {
 		memset(&port_attr, 0, sizeof(port_attr));
diff --git a/providers/mlx5/mlx5.h b/providers/mlx5/mlx5.h
index 782d29bf757e0b..72e710b7b5e4aa 100644
--- a/providers/mlx5/mlx5.h
+++ b/providers/mlx5/mlx5.h
@@ -878,6 +878,7 @@ __be32 *mlx5_alloc_dbrec(struct mlx5_context *context, =
struct ibv_pd *pd,
 void mlx5_free_db(struct mlx5_context *context, __be32 *db, struct ibv_pd =
*pd,
 		  bool custom_alloc);
=20
+void mlx5_query_device_ctx(struct mlx5_context *mctx);
 int mlx5_query_device(struct ibv_context *context,
 		       struct ibv_device_attr *attr);
 int mlx5_query_device_ex(struct ibv_context *context,
diff --git a/providers/mlx5/verbs.c b/providers/mlx5/verbs.c
index 3622cae1df5017..42c984033d8eaa 100644
--- a/providers/mlx5/verbs.c
+++ b/providers/mlx5/verbs.c
@@ -3450,19 +3450,19 @@ static void get_pci_atomic_caps(struct ibv_context =
*context,
 	}
 }
=20
-static void get_lag_caps(struct ibv_context *ctx)
+static void get_lag_caps(struct mlx5_context *mctx)
 {
 	uint16_t opmod =3D MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE |
 		HCA_CAP_OPMOD_GET_CUR;
 	uint32_t out[DEVX_ST_SZ_DW(query_hca_cap_out)] =3D {};
 	uint32_t in[DEVX_ST_SZ_DW(query_hca_cap_in)] =3D {};
-	struct mlx5_context *mctx =3D to_mctx(ctx);
 	int ret;
=20
 	DEVX_SET(query_hca_cap_in, in, opcode, MLX5_CMD_OP_QUERY_HCA_CAP);
 	DEVX_SET(query_hca_cap_in, in, op_mod, opmod);
=20
-	ret =3D mlx5dv_devx_general_cmd(ctx, in, sizeof(in), out, sizeof(out));
+	ret =3D mlx5dv_devx_general_cmd(&mctx->ibv_ctx.context, in, sizeof(in),
+				      out, sizeof(out));
 	if (ret)
 		return;
=20
@@ -3512,6 +3512,41 @@ int mlx5_query_device_ex(struct ibv_context *context=
,
 	attr->packet_pacing_caps.supported_qpts =3D
 		resp.packet_pacing_caps.supported_qpts;
=20
+	major     =3D (raw_fw_ver >> 32) & 0xffff;
+	minor     =3D (raw_fw_ver >> 16) & 0xffff;
+	sub_minor =3D raw_fw_ver & 0xffff;
+	a =3D &attr->orig_attr;
+	snprintf(a->fw_ver, sizeof(a->fw_ver), "%d.%d.%04d",
+		 major, minor, sub_minor);
+
+	if (attr_size >=3D offsetof(struct ibv_device_attr_ex, pci_atomic_caps) +
+			sizeof(attr->pci_atomic_caps))
+		get_pci_atomic_caps(context, attr);
+
+	return 0;
+}
+
+void mlx5_query_device_ctx(struct mlx5_context *mctx)
+{
+	struct ibv_device_attr_ex device_attr;
+	struct mlx5_query_device_ex_resp resp;
+	size_t resp_size =3D sizeof(resp);
+
+	get_lag_caps(mctx);
+
+	if (!(mctx->cmds_supp_uhw & MLX5_USER_CMDS_SUPP_UHW_QUERY_DEVICE))
+		return;
+
+	if (ibv_cmd_query_device_any(&mctx->ibv_ctx.context, NULL, &device_attr,
+				     sizeof(device_attr), &resp.ibv_resp,
+				     &resp_size))
+		return;
+
+	mctx->cached_device_cap_flags =3D device_attr.orig_attr.device_cap_flags;
+	mctx->atomic_cap =3D device_attr.orig_attr.atomic_cap;
+	mctx->cached_tso_caps =3D device_attr.tso_caps;
+	mctx->max_dm_size =3D device_attr.max_dm_size;
+
 	if (resp.mlx5_ib_support_multi_pkt_send_wqes & MLX5_IB_ALLOW_MPW)
 		mctx->vendor_cap_flags |=3D MLX5_VENDOR_CAP_FLAGS_MPW_ALLOWED;
=20
@@ -3519,7 +3554,8 @@ int mlx5_query_device_ex(struct ibv_context *context,
 		mctx->vendor_cap_flags |=3D MLX5_VENDOR_CAP_FLAGS_ENHANCED_MPW;
=20
 	mctx->cqe_comp_caps.max_num =3D resp.cqe_comp_caps.max_num;
-	mctx->cqe_comp_caps.supported_format =3D resp.cqe_comp_caps.supported_for=
mat;
+	mctx->cqe_comp_caps.supported_format =3D
+		resp.cqe_comp_caps.supported_format;
 	mctx->sw_parsing_caps.sw_parsing_offloads =3D
 		resp.sw_parsing_caps.sw_parsing_offloads;
 	mctx->sw_parsing_caps.supported_qpts =3D
@@ -3544,25 +3580,11 @@ int mlx5_query_device_ex(struct ibv_context *contex=
t,
 		mctx->vendor_cap_flags |=3D MLX5_VENDOR_CAP_FLAGS_CQE_128B_PAD;
=20
 	if (resp.flags & MLX5_IB_QUERY_DEV_RESP_PACKET_BASED_CREDIT_MODE)
-		mctx->vendor_cap_flags |=3D MLX5_VENDOR_CAP_FLAGS_PACKET_BASED_CREDIT_MO=
DE;
+		mctx->vendor_cap_flags |=3D
+			MLX5_VENDOR_CAP_FLAGS_PACKET_BASED_CREDIT_MODE;
=20
 	if (resp.flags & MLX5_IB_QUERY_DEV_RESP_FLAGS_SCAT2CQE_DCT)
 		mctx->vendor_cap_flags |=3D MLX5_VENDOR_CAP_FLAGS_SCAT2CQE_DCT;
-
-	major     =3D (raw_fw_ver >> 32) & 0xffff;
-	minor     =3D (raw_fw_ver >> 16) & 0xffff;
-	sub_minor =3D raw_fw_ver & 0xffff;
-	a =3D &attr->orig_attr;
-	snprintf(a->fw_ver, sizeof(a->fw_ver), "%d.%d.%04d",
-		 major, minor, sub_minor);
-
-	if (attr_size >=3D offsetof(struct ibv_device_attr_ex, pci_atomic_caps) +
-			sizeof(attr->pci_atomic_caps))
-		get_pci_atomic_caps(context, attr);
-
-	get_lag_caps(context);
-
-	return 0;
 }
=20
 static int rwq_sig_enabled(struct ibv_context *context)
--=20
2.29.2

