Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EDF2B5263
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Nov 2020 21:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgKPUXO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Nov 2020 15:23:14 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3319 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732263AbgKPUXN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Nov 2020 15:23:13 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb2dfb50000>; Mon, 16 Nov 2020 12:23:17 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Nov
 2020 20:23:13 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 16 Nov 2020 20:23:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHYZPW32qZBG26Wu7wUixUoNs9OsY4SGDNu0aFGd9K7O16wPo6VjPyq94tEYQPJQFkiVTDFGBKhUikkuIivjANhma7OAki9jcjFCGedVINRXLwKMAMnhqDgsPh07lI3kJU+e33Kgb7b2swJKn9JAtnsPiVv4BCLSgEhTQk4kBwHItYbq3QGn5YdvxP420oUPfUbHF2Y/C8LrdwDKDw16EFdKPhpEKhlN5+ezWocmo9sYMIT4FbzPYHyjnEfYogjc371bPfnzaLNSoEAQqrfk54d+ehQiLsgBLSbfu3fmotKN3jytZGHumld84EfafiudIkB5W4S2v2BdoVDhIGLX/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOR8kxl7+Glby/qXr/Fr3WAwO0foD8dN/e8zqeHT6t4=;
 b=k+Ng0fsHcggAJg2ui2W8fHxMLB7s/FX2bTizpejXCywfDKGqwgwWTT/RrgGsg6iq8D3PaRo+07047R0CyBvdZQDvBmEd5gFrZj+Jr5s92Txut7vFHLHsfwA4yySUGp5VBfD3dNoZPU3vML+FVlYqOrGtpdIxieu5nhTwxt6q9RsvypOzxYmrA+fp2ODXmLaU2hvIf+eKVoHh9g96D3qJAgnqCeGDfBzgNxisKdDvdk2/XhuezTBF89cKbyZNNKZzGOnJuSU+saSerd2bOvsNts73FvbjnTg8aL0suqwQb+YOSWfMz8qjLqLSm5cAqvw13iJMfkX9OJ736NKIWKeXtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3305.namprd12.prod.outlook.com (2603:10b6:5:189::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Mon, 16 Nov
 2020 20:23:12 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 20:23:12 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 5/9] mlx4: Move the context intialization out of mlx4_query_device_ex()
Date:   Mon, 16 Nov 2020 16:23:06 -0400
Message-ID: <5-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
In-Reply-To: <0-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR11CA0021.namprd11.prod.outlook.com
 (2603:10b6:208:23b::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR11CA0021.namprd11.prod.outlook.com (2603:10b6:208:23b::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28 via Frontend Transport; Mon, 16 Nov 2020 20:23:11 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kel1q-006l82-RL; Mon, 16 Nov 2020 16:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605558197; bh=ztaESyD2IsmnAT7uarJTmK7wOFWIR1BHA6TG7EpqhUU=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         Subject:Date:Message-ID:In-Reply-To:References:
         Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType;
        b=a2pQPspJHTbUL5Lqh0yOizCLZDtIl4aefDlF6AHpV6lb6/aJ5ewSOjUaRz+pIJps+
         ZzlU7prdR3HSqZgflGcXY9VpKLagKkNh+igOjfz+/nRo9XKmiXHEdx/icIZRklOedn
         yLR9xeh0eVe06PdLOWLomKsd8VgD/pwxWDL9WjvAmEWOvtrs8RZ4SOGW0zrlR7oe7B
         bD4tyQxezxN056mcavtda/R230gIsdWoiABfRGqCiP/bFKd8jm0KuxSm+2YtaV+pSs
         Ufl5Wiu9YzZ176pGBQpi9eJkpai6h4eLjiomXyHZIxJIZZnDzt7K8xQ2L4jhH/OaC/
         zIM250h7Smc1w==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When the user calls mlx4_query_device_ex() it should not cause the context
values to be mutated, only the attribute shuld be returned.

Move this code to a dedicated function that is only called during context
setup.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 providers/mlx4/mlx4.c  | 33 +-------------------------------
 providers/mlx4/mlx4.h  |  1 +
 providers/mlx4/verbs.c | 43 +++++++++++++++++++++++++++++++++++-------
 3 files changed, 38 insertions(+), 39 deletions(-)

diff --git a/providers/mlx4/mlx4.c b/providers/mlx4/mlx4.c
index c4a3c557fea426..619b841d788cb2 100644
--- a/providers/mlx4/mlx4.c
+++ b/providers/mlx4/mlx4.c
@@ -136,28 +136,6 @@ static const struct verbs_context_ops mlx4_ctx_ops =3D=
 {
 	.free_context =3D mlx4_free_context,
 };
=20
-static int mlx4_map_internal_clock(struct mlx4_device *mdev,
-				   struct ibv_context *ibv_ctx)
-{
-	struct mlx4_context *context =3D to_mctx(ibv_ctx);
-	void *hca_clock_page;
-
-	hca_clock_page =3D mmap(NULL, mdev->page_size,
-			      PROT_READ, MAP_SHARED, ibv_ctx->cmd_fd,
-			      mdev->page_size * 3);
-
-	if (hca_clock_page =3D=3D MAP_FAILED) {
-		fprintf(stderr, PFX
-			"Warning: Timestamp available,\n"
-			"but failed to mmap() hca core clock page.\n");
-		return -1;
-	}
-
-	context->hca_core_clock =3D hca_clock_page +
-		(context->core_clock.offset & (mdev->page_size - 1));
-	return 0;
-}
-
 static struct verbs_context *mlx4_alloc_context(struct ibv_device *ibdev,
 						  int cmd_fd,
 						  void *private_data)
@@ -170,7 +148,6 @@ static struct verbs_context *mlx4_alloc_context(struct =
ibv_device *ibdev,
 	__u16				bf_reg_size;
 	struct mlx4_device              *dev =3D to_mdev(ibdev);
 	struct verbs_context		*verbs_ctx;
-	struct ibv_device_attr_ex	dev_attrs;
=20
 	context =3D verbs_init_and_alloc_context(ibdev, cmd_fd, context, ibv_ctx,
 					       RDMA_DRIVER_MLX4);
@@ -242,15 +219,7 @@ static struct verbs_context *mlx4_alloc_context(struct=
 ibv_device *ibdev,
=20
 	verbs_set_ops(verbs_ctx, &mlx4_ctx_ops);
=20
-	context->hca_core_clock =3D NULL;
-	memset(&dev_attrs, 0, sizeof(dev_attrs));
-	if (!mlx4_query_device_ex(&verbs_ctx->context, NULL, &dev_attrs,
-				  sizeof(struct ibv_device_attr_ex))) {
-		context->max_qp_wr =3D dev_attrs.orig_attr.max_qp_wr;
-		context->max_sge =3D dev_attrs.orig_attr.max_sge;
-		if (context->core_clock.offset_valid)
-			mlx4_map_internal_clock(dev, &verbs_ctx->context);
-	}
+	mlx4_query_device_ctx(dev, context);
=20
 	return verbs_ctx;
=20
diff --git a/providers/mlx4/mlx4.h b/providers/mlx4/mlx4.h
index 479c39d0a69fc4..3c0787144e7e51 100644
--- a/providers/mlx4/mlx4.h
+++ b/providers/mlx4/mlx4.h
@@ -304,6 +304,7 @@ __be32 *mlx4_alloc_db(struct mlx4_context *context, enu=
m mlx4_db_type type);
 void mlx4_free_db(struct mlx4_context *context, enum mlx4_db_type type,
 		  __be32 *db);
=20
+void mlx4_query_device_ctx(struct mlx4_device *mdev, struct mlx4_context *=
mctx);
 int mlx4_query_device(struct ibv_context *context,
 		       struct ibv_device_attr *attr);
 int mlx4_query_device_ex(struct ibv_context *context,
diff --git a/providers/mlx4/verbs.c b/providers/mlx4/verbs.c
index 512297f2eebac0..4fe5c1d87d6d91 100644
--- a/providers/mlx4/verbs.c
+++ b/providers/mlx4/verbs.c
@@ -38,6 +38,7 @@
 #include <string.h>
 #include <pthread.h>
 #include <errno.h>
+#include <sys/mman.h>
=20
 #include <util/mmio.h>
=20
@@ -70,7 +71,6 @@ int mlx4_query_device_ex(struct ibv_context *context,
 			 struct ibv_device_attr_ex *attr,
 			 size_t attr_size)
 {
-	struct mlx4_context *mctx =3D to_mctx(context);
 	struct mlx4_query_device_ex_resp resp =3D {};
 	struct mlx4_query_device_ex cmd =3D {};
 	uint64_t raw_fw_ver;
@@ -90,12 +90,6 @@ int mlx4_query_device_ex(struct ibv_context *context,
 	attr->tso_caps.max_tso =3D resp.tso_caps.max_tso;
 	attr->tso_caps.supported_qpts =3D resp.tso_caps.supported_qpts;
=20
-	if (resp.comp_mask & MLX4_IB_QUERY_DEV_RESP_MASK_CORE_CLOCK_OFFSET) {
-		mctx->core_clock.offset =3D resp.hca_core_clock_offset;
-		mctx->core_clock.offset_valid =3D 1;
-	}
-	mctx->max_inl_recv_sz =3D resp.max_inl_recv_sz;
-
 	major     =3D (raw_fw_ver >> 32) & 0xffff;
 	minor     =3D (raw_fw_ver >> 16) & 0xffff;
 	sub_minor =3D raw_fw_ver & 0xffff;
@@ -106,6 +100,41 @@ int mlx4_query_device_ex(struct ibv_context *context,
 	return 0;
 }
=20
+void mlx4_query_device_ctx(struct mlx4_device *mdev, struct mlx4_context *=
mctx)
+{
+	struct ibv_device_attr_ex device_attr;
+	struct mlx4_query_device_ex_resp resp;
+	size_t resp_size =3D sizeof(resp);
+
+	if (ibv_cmd_query_device_any(&mctx->ibv_ctx.context, NULL,
+				       &device_attr, sizeof(device_attr),
+				       &resp.ibv_resp, &resp_size))
+		return;
+
+	mctx->max_qp_wr =3D device_attr.orig_attr.max_qp_wr;
+	mctx->max_sge =3D device_attr.orig_attr.max_sge;
+	mctx->max_inl_recv_sz =3D resp.max_inl_recv_sz;
+
+	if (resp.comp_mask & MLX4_IB_QUERY_DEV_RESP_MASK_CORE_CLOCK_OFFSET) {
+		void *hca_clock_page;
+
+		mctx->core_clock.offset =3D resp.hca_core_clock_offset;
+		mctx->core_clock.offset_valid =3D 1;
+
+		hca_clock_page =3D
+			mmap(NULL, mdev->page_size, PROT_READ, MAP_SHARED,
+			     mctx->ibv_ctx.context.cmd_fd, mdev->page_size * 3);
+		if (hca_clock_page !=3D MAP_FAILED)
+			mctx->hca_core_clock =3D
+				hca_clock_page + (mctx->core_clock.offset &
+						  (mdev->page_size - 1));
+		else
+			fprintf(stderr, PFX
+				"Warning: Timestamp available,\n"
+				"but failed to mmap() hca core clock page.\n");
+	}
+}
+
 static int mlx4_read_clock(struct ibv_context *context, uint64_t *cycles)
 {
 	uint32_t clockhi, clocklo, clockhi1;
--=20
2.29.2

