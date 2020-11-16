Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE202B5267
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Nov 2020 21:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732273AbgKPUXU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Nov 2020 15:23:20 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:43069 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732296AbgKPUXU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Nov 2020 15:23:20 -0500
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb2dfb70000>; Tue, 17 Nov 2020 04:23:19 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Nov
 2020 20:23:19 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 16 Nov 2020 20:23:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZ8GRjlUmg3htAfvorM0/hC8Z+22jxN5ZKmhA8k/SdY6zXv7IQj4eeTQd1wpV1EhcS/elliIaAtzZWvbxCBefB+hqd8PuJGZ1LhQ9RLOg7DHMwuE2jHaDI2vNrXdAFEt1FCr9eqMtF3anaFC7Ykmh+UyVRfbkAshV6zaPIeV/L7BHQ86Fvyr2UpFOGiqGQ3WRQEHKAARljz2nhA1YMadBApT8BwT2+FiAohOuQumyv4em62G4/SiiTnrvbFY2Tn7xUfUSQlVPbDqEZ5pbksIZX1LEwsb3C0xhBmLGCmgMFB7fcyZRydRmQSgFNCa0mL8TcsQnUA9B61UOiLkM2A8Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EnnM0es8CU1PxAsd9gvqh2VIRy8netKPwRkme9VR7c=;
 b=iwajj08ZUFDpNhnz83xnqeNbstLSg1fqQ1GbAdNiPT6qCPtwybZopHPHBRewi9XXWiT70PzJE/Zi1BuMQ9ZhoBThmZNqe2THfxsb8Z29lQ6UuJeAEYBWvuHS48bUpyqZuMKB4Ihzl2hekoLHXZPrjx8N4cmtSTTR9t22uVtHaIK+1ARxDgwPtHWopKJsavky+cEMnMCvdNvJ0C1rnsKAY6LmoMUJC5q1A3MvV8weSLUbPuoqCJFjv/RXEh6m7DBlBrQ5Q21fClAhjoUpB9QQXJKK8vjeODgKZwir/NOdCdFF/Y5hv4tCwXlyO6PQ+6vDumoglboHKpyRmoZermwGQQ==
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
CC:     Gal Pressman <galpress@amazon.com>
Subject: [PATCH 4/9] efa: Move the context intialization out of efa_query_device_ex()
Date:   Mon, 16 Nov 2020 16:23:05 -0400
Message-ID: <4-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
In-Reply-To: <0-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0008.namprd19.prod.outlook.com
 (2603:10b6:208:178::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR19CA0008.namprd19.prod.outlook.com (2603:10b6:208:178::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend Transport; Mon, 16 Nov 2020 20:23:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kel1q-006l7z-Q0; Mon, 16 Nov 2020 16:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605558199; bh=MvlJR4z3rc0QfhINWKcWhq0XqLO/+ljYEfZwMSN/l9Q=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         CC:Subject:Date:Message-ID:In-Reply-To:References:
         Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType;
        b=aM1md6eqVbkI012Z2x8XTbPqVbKLS6Q8P9xkpP8p/jZCIni9/glTeoq3QwFrpjZdr
         cLVX+lafbnjb9Fv22DCYfTDMllFB+pQ1Ptp2Ha/cvWZ+LVFjO/2+qRbjp/h1taYPao
         QTpNthNTY9e/g+R9JwRNT6+wLdGut8j0HQAH6Y5wYL2SZemVgKM2h6hltd35rTvcBm
         mb87FXfYkwkNGEQ6lsrhO1KLmhUUZ/PwzRtuZ0WT+VKVA0ITtjEWLDqiuRFPcXx0Jh
         C3cPULw8PoMuV25MmR9RYAyBXRgYl9sw3UzZvgDx6Wr+DFYBvd+8EejHNvBOOI9kLr
         Y68m6AoElnkNw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When the user calls efa_query_device_ex() it should not cause the context
values to be mutated, only the attribute shuld be returned.

Move this code to a dedicated function that is only called during context
setup.

Cc: Gal Pressman <galpress@amazon.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 providers/efa/efa.c   | 14 +------------
 providers/efa/verbs.c | 46 +++++++++++++++++++++++++++++++++++--------
 providers/efa/verbs.h |  1 +
 3 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/providers/efa/efa.c b/providers/efa/efa.c
index 35f9b246a711ec..b24c14f7fa1fe1 100644
--- a/providers/efa/efa.c
+++ b/providers/efa/efa.c
@@ -54,10 +54,7 @@ static struct verbs_context *efa_alloc_context(struct ib=
v_device *vdev,
 {
 	struct efa_alloc_ucontext_resp resp =3D {};
 	struct efa_alloc_ucontext cmd =3D {};
-	struct ibv_device_attr_ex attr;
-	unsigned int qp_table_sz;
 	struct efa_context *ctx;
-	int err;
=20
 	cmd.comp_mask |=3D EFA_ALLOC_UCONTEXT_CMD_COMP_TX_BATCH;
 	cmd.comp_mask |=3D EFA_ALLOC_UCONTEXT_CMD_COMP_MIN_SQ_WR;
@@ -86,17 +83,8 @@ static struct verbs_context *efa_alloc_context(struct ib=
v_device *vdev,
=20
 	verbs_set_ops(&ctx->ibvctx, &efa_ctx_ops);
=20
-	err =3D efa_query_device_ex(&ctx->ibvctx.context, NULL, &attr,
-				  sizeof(attr));
-	if (err)
+	if (!efa_query_device_ctx(ctx))
 		goto err_free_spinlock;
-
-	qp_table_sz =3D roundup_pow_of_two(attr.orig_attr.max_qp);
-	ctx->qp_table_sz_m1 =3D qp_table_sz - 1;
-	ctx->qp_table =3D calloc(qp_table_sz, sizeof(*ctx->qp_table));
-	if (!ctx->qp_table)
-		goto err_free_spinlock;
-
 	return &ctx->ibvctx;
=20
 err_free_spinlock:
diff --git a/providers/efa/verbs.c b/providers/efa/verbs.c
index 1a9633155c62f8..52d6285f1f409c 100644
--- a/providers/efa/verbs.c
+++ b/providers/efa/verbs.c
@@ -106,14 +106,6 @@ int efa_query_device_ex(struct ibv_context *context,
 	if (err)
 		return err;
=20
-	ctx->device_caps =3D resp.device_caps;
-	ctx->max_sq_wr =3D resp.max_sq_wr;
-	ctx->max_rq_wr =3D resp.max_rq_wr;
-	ctx->max_sq_sge =3D resp.max_sq_sge;
-	ctx->max_rq_sge =3D resp.max_rq_sge;
-	ctx->max_rdma_size =3D resp.max_rdma_size;
-	ctx->max_wr_rdma_sge =3D a->max_sge_rd;
-
 	a->max_qp_wr =3D min_t(int, a->max_qp_wr,
 			     ctx->max_llq_size / sizeof(struct efa_io_tx_wqe));
 	snprintf(a->fw_ver, sizeof(a->fw_ver), "%u.%u.%u.%u",
@@ -122,6 +114,44 @@ int efa_query_device_ex(struct ibv_context *context,
 	return 0;
 }
=20
+int efa_query_device_ctx(struct efa_context *ctx)
+{
+	struct ibv_device_attr_ex attr;
+	struct efa_query_device_ex_resp resp;
+	size_t resp_size =3D sizeof(resp);
+	unsigned int qp_table_sz;
+	int err;
+
+	if (ctx->cmds_supp_udata_mask & EFA_USER_CMDS_SUPP_UDATA_QUERY_DEVICE) {
+		err =3D ibv_cmd_query_device_any(&ctx->ibvctx.context, NULL,
+					       &attr, sizeof(attr),
+					       &resp.ibv_resp, &resp_size);
+		if (err)
+			return err;
+
+		ctx->device_caps =3D resp.device_caps;
+		ctx->max_sq_wr =3D resp.max_sq_wr;
+		ctx->max_rq_wr =3D resp.max_rq_wr;
+		ctx->max_sq_sge =3D resp.max_sq_sge;
+		ctx->max_rq_sge =3D resp.max_rq_sge;
+		ctx->max_rdma_size =3D resp.max_rdma_size;
+		ctx->max_wr_rdma_sge =3D attr.orig_attr.max_sge_rd;
+	} else {
+		err =3D ibv_cmd_query_device_any(&ctx->ibvctx.context, NULL,
+					       &attr, sizeof(attr.orig_attr),
+					       NULL, NULL);
+		if (err)
+			return err;
+	}
+
+	qp_table_sz =3D roundup_pow_of_two(attr.orig_attr.max_qp);
+	ctx->qp_table_sz_m1 =3D qp_table_sz - 1;
+	ctx->qp_table =3D calloc(qp_table_sz, sizeof(*ctx->qp_table));
+	if (!ctx->qp_table)
+		return ENOMEM;
+	return 0;
+}
+
 int efadv_query_device(struct ibv_context *ibvctx,
 		       struct efadv_device_attr *attr,
 		       uint32_t inlen)
diff --git a/providers/efa/verbs.h b/providers/efa/verbs.h
index da022e615af064..3b0e4e0d498761 100644
--- a/providers/efa/verbs.h
+++ b/providers/efa/verbs.h
@@ -9,6 +9,7 @@
 #include <infiniband/driver.h>
 #include <infiniband/verbs.h>
=20
+int efa_query_device_ctx(struct efa_context *ctx);
 int efa_query_device(struct ibv_context *uctx, struct ibv_device_attr *att=
r);
 int efa_query_port(struct ibv_context *uctx, uint8_t port,
 		   struct ibv_port_attr *attr);
--=20
2.29.2

