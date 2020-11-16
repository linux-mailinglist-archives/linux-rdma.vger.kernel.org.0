Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DE22B5269
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Nov 2020 21:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732373AbgKPUXV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Nov 2020 15:23:21 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:17355 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730917AbgKPUXV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Nov 2020 15:23:21 -0500
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb2dfb60000>; Tue, 17 Nov 2020 04:23:18 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Nov
 2020 20:23:18 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 16 Nov 2020 20:23:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kP349JPxuAUe5tit8+0eJsAXERv7O2lNKqMrXV6297Nm1+FFo5ll5I15HaFxJ7iCK2hDxjLdXUMXZ2VK+7cWVPYnrLAIjLPxVbcHDrRdywIPTI+C2/ne8uhRkmsOlkoWSn9PVoRQKsIv4i0lsfYMxZscOh45JM+ReqyQ3j6dynGCUP2u2wjGCwlctDCk/k/xGoHsJkFbHj6ebCL/ruO/gP0AWrI3z4DrAYObNtzr4yaLrlCHT03v69PLmNpgF0g1oor9lELeAs9RDmjM62HeJ88VPj21zSy/g/qKmf/dhEsKk4PHMvnCEn6GqqLH0NDPd5IaL772GSuyNaMtTd89Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWAJdzG41PYDl4nyqo3E2yEyZH8w348Nzc0LHxv3vZ4=;
 b=KsHaMLbCuuup06wQUswIewdXRo8AwnTC3ZNbcQGbpfj6vIdDyIxdLlyPi6JSSqGJw9xf15Yzj3r45Fqr1KaiIcEaqQL7oINykfH/G3MPNNixIIDqDivW0p84jjxslbBxOimepLW1h15YrMT0vm2+3aELDnSGNZb6JJNmDcCk/ihXvE9POywUZ/+S7tk5OtNK1MlKdSj/hwfpl55xV3k9OckTF8ukjU1DTG8xxgSDoHhxuyEcXBcVOvF2SBw/H77YlhstMuwPHn086uGJiIlq5ZEFgU4092biVDChMKr1CsHSK8qP0N3e67RGbbXgMXMO7WcvlKIid76p0NWk5XWpXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3305.namprd12.prod.outlook.com (2603:10b6:5:189::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Mon, 16 Nov
 2020 20:23:14 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 20:23:14 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 7/9] providers: Convert all providers to implement query_device_ex
Date:   Mon, 16 Nov 2020 16:23:08 -0400
Message-ID: <7-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
In-Reply-To: <0-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0017.namprd22.prod.outlook.com
 (2603:10b6:208:238::22) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR22CA0017.namprd22.prod.outlook.com (2603:10b6:208:238::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend Transport; Mon, 16 Nov 2020 20:23:12 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kel1q-006l8B-TO; Mon, 16 Nov 2020 16:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605558198; bh=LnSgc1sEYcE8JcKXca9nxTv3XWQwbdWNGlxEgKhdZYU=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         Subject:Date:Message-ID:In-Reply-To:References:
         Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType;
        b=ezfKSCV9SIM+jqBEjdVqTKoYomNbKmBIBGkibektfsJdwVUM8LiCGPgxPaRzuZV//
         zOcYmSyJESX6CmrCJfuAJ2LMWnlRYTkWfLLxdLKkVIeYH5ujgEUEZ0qUZNvH/1Nnbr
         IacHA+PhTtowPLJPQLeVFiBQBJitLB93I8KhS6zibPiZN+u9Ln9gsBkrj9iqgR6/oR
         5ksgiBljIjlw3UPmYg1L9rDjL/dRFcQlCP9TED3PM7BlQaoegGw9lhQ2cqmjrCMR2v
         P6k2kHs7Zls6/yyjNr2Fjx0tnJaXcv8e0Q0YftO42OfrAMvxDDA/iKIj6bOQyNCUti
         UiJADBmGXs5Tg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The kernel now supports query_device_ex for all drivers, there is no
reason to have a weird split where providers do different things.

All providers implement only query_device_ex and call
ibv_cmd_query_device_any() to get as much of the device_attr's as the
kernel can return.

The user facing ibv_query_device is emulated by requesting only the first
portion of the ibv_device_attr_ex structure using a shorter size.

Nearly all providers have a fairly simple pattern where they just call
ibv_cmd_query_device_any() and the manipulate the fw_version into a
string. A few return a device udata and process that as well.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 providers/bnxt_re/main.c           |  2 +-
 providers/bnxt_re/verbs.c          | 30 +++++++++++++++++++-----------
 providers/bnxt_re/verbs.h          |  5 +++--
 providers/cxgb4/dev.c              |  2 +-
 providers/cxgb4/libcxgb4.h         |  3 ++-
 providers/cxgb4/verbs.c            | 14 +++++++++-----
 providers/hfi1verbs/hfiverbs.c     |  2 +-
 providers/hfi1verbs/hfiverbs.h     |  5 +++--
 providers/hfi1verbs/verbs.c        | 13 ++++++++-----
 providers/hns/hns_roce_u.c         |  8 ++++++--
 providers/hns/hns_roce_u.h         |  3 ++-
 providers/hns/hns_roce_u_verbs.c   | 15 +++++++++------
 providers/i40iw/i40iw_umain.c      |  2 +-
 providers/i40iw/i40iw_umain.h      |  4 +++-
 providers/i40iw/i40iw_uverbs.c     | 18 +++++++++++-------
 providers/ipathverbs/ipathverbs.c  |  2 +-
 providers/ipathverbs/ipathverbs.h  |  5 +++--
 providers/ipathverbs/verbs.c       | 13 ++++++++-----
 providers/mthca/mthca.c            |  2 +-
 providers/mthca/mthca.h            |  3 ++-
 providers/mthca/verbs.c            | 13 +++++++++----
 providers/ocrdma/ocrdma_main.c     |  2 +-
 providers/ocrdma/ocrdma_main.h     |  4 +++-
 providers/ocrdma/ocrdma_verbs.c    | 20 ++++++++++++--------
 providers/qedr/qelr_main.c         |  2 +-
 providers/qedr/qelr_verbs.c        | 21 ++++++++++++---------
 providers/qedr/qelr_verbs.h        |  3 ++-
 providers/rxe/rxe.c                | 15 +++++++++------
 providers/siw/siw.c                | 20 +++++++++++---------
 providers/vmw_pvrdma/pvrdma.h      |  3 ++-
 providers/vmw_pvrdma/pvrdma_main.c |  2 +-
 providers/vmw_pvrdma/verbs.c       | 13 ++++++++-----
 32 files changed, 165 insertions(+), 104 deletions(-)

diff --git a/providers/bnxt_re/main.c b/providers/bnxt_re/main.c
index baeee733fdfbab..a78e6b98815dee 100644
--- a/providers/bnxt_re/main.c
+++ b/providers/bnxt_re/main.c
@@ -91,7 +91,7 @@ static const struct verbs_match_ent cna_table[] =3D {
 };
=20
 static const struct verbs_context_ops bnxt_re_cntx_ops =3D {
-	.query_device  =3D bnxt_re_query_device,
+	.query_device_ex =3D bnxt_re_query_device,
 	.query_port    =3D bnxt_re_query_port,
 	.alloc_pd      =3D bnxt_re_alloc_pd,
 	.dealloc_pd    =3D bnxt_re_free_pd,
diff --git a/providers/bnxt_re/verbs.c b/providers/bnxt_re/verbs.c
index 03237e7f810321..20f4e7dd08b37c 100644
--- a/providers/bnxt_re/verbs.c
+++ b/providers/bnxt_re/verbs.c
@@ -53,19 +53,24 @@
 #include "main.h"
 #include "verbs.h"
=20
-int bnxt_re_query_device(struct ibv_context *ibvctx,
-			 struct ibv_device_attr *dev_attr)
+int bnxt_re_query_device(struct ibv_context *context,
+			 const struct ibv_query_device_ex_input *input,
+			 struct ibv_device_attr_ex *attr, size_t attr_size)
 {
-	struct ibv_query_device cmd;
+	struct ib_uverbs_ex_query_device_resp resp;
+	size_t resp_size =3D sizeof(resp);
 	uint8_t fw_ver[8];
-	int status;
+	int err;
=20
-	memset(dev_attr, 0, sizeof(struct ibv_device_attr));
-	status =3D ibv_cmd_query_device(ibvctx, dev_attr, (uint64_t *)&fw_ver,
-				      &cmd, sizeof(cmd));
-	snprintf(dev_attr->fw_ver, 64, "%d.%d.%d.%d",
-		 fw_ver[0], fw_ver[1], fw_ver[2], fw_ver[3]);
-	return status;
+	err =3D ibv_cmd_query_device_any(context, input, attr, attr_size, &resp,
+				       &resp_size);
+	if (err)
+		return err;
+
+	memcpy(fw_ver, &resp.base.fw_ver, sizeof(resp.base.fw_ver));
+	snprintf(attr->orig_attr.fw_ver, 64, "%d.%d.%d.%d", fw_ver[0],
+		 fw_ver[1], fw_ver[2], fw_ver[3]);
+	return 0;
 }
=20
 int bnxt_re_query_port(struct ibv_context *ibvctx, uint8_t port,
@@ -773,7 +778,10 @@ static int bnxt_re_check_qp_limits(struct bnxt_re_cont=
ext *cntx,
 	struct ibv_device_attr devattr;
 	int ret;
=20
-	ret =3D bnxt_re_query_device(&cntx->ibvctx.context, &devattr);
+	ret =3D bnxt_re_query_device(
+		&cntx->ibvctx.context, NULL,
+		container_of(&devattr, struct ibv_device_attr_ex, orig_attr),
+		sizeof(devattr));
 	if (ret)
 		return ret;
 	if (attr->cap.max_send_sge > devattr.max_sge)
diff --git a/providers/bnxt_re/verbs.h b/providers/bnxt_re/verbs.h
index b9fd84bdbac9a8..1566709f096093 100644
--- a/providers/bnxt_re/verbs.h
+++ b/providers/bnxt_re/verbs.h
@@ -54,8 +54,9 @@
 #include <infiniband/driver.h>
 #include <infiniband/verbs.h>
=20
-int bnxt_re_query_device(struct ibv_context *uctx,
-			 struct ibv_device_attr *attr);
+int bnxt_re_query_device(struct ibv_context *context,
+			 const struct ibv_query_device_ex_input *input,
+			 struct ibv_device_attr_ex *attr, size_t attr_size);
 int bnxt_re_query_port(struct ibv_context *uctx, uint8_t port,
 		       struct ibv_port_attr *attr);
 struct ibv_pd *bnxt_re_alloc_pd(struct ibv_context *uctx);
diff --git a/providers/cxgb4/dev.c b/providers/cxgb4/dev.c
index 06948efb3f0105..76b78d9b29a71c 100644
--- a/providers/cxgb4/dev.c
+++ b/providers/cxgb4/dev.c
@@ -75,7 +75,7 @@ int t5_en_wc =3D 1;
 static LIST_HEAD(devices);
=20
 static const struct verbs_context_ops  c4iw_ctx_common_ops =3D {
-	.query_device =3D c4iw_query_device,
+	.query_device_ex =3D c4iw_query_device,
 	.query_port =3D c4iw_query_port,
 	.alloc_pd =3D c4iw_alloc_pd,
 	.dealloc_pd =3D c4iw_free_pd,
diff --git a/providers/cxgb4/libcxgb4.h b/providers/cxgb4/libcxgb4.h
index c5036d0b83c21e..f0658ab89f4aa5 100644
--- a/providers/cxgb4/libcxgb4.h
+++ b/providers/cxgb4/libcxgb4.h
@@ -191,7 +191,8 @@ static inline unsigned long_log2(unsigned long x)
 }
=20
 int c4iw_query_device(struct ibv_context *context,
-			     struct ibv_device_attr *attr);
+		      const struct ibv_query_device_ex_input *input,
+		      struct ibv_device_attr_ex *attr, size_t attr_size);
 int c4iw_query_port(struct ibv_context *context, uint8_t port,
 			   struct ibv_port_attr *attr);
=20
diff --git a/providers/cxgb4/verbs.c b/providers/cxgb4/verbs.c
index 32bae6906a1595..a28152fa32761c 100644
--- a/providers/cxgb4/verbs.c
+++ b/providers/cxgb4/verbs.c
@@ -47,24 +47,28 @@ bool is_64b_cqe;
=20
 #define MASKED(x) (void *)((unsigned long)(x) & c4iw_page_mask)
=20
-int c4iw_query_device(struct ibv_context *context, struct ibv_device_attr =
*attr)
+int c4iw_query_device(struct ibv_context *context,
+		      const struct ibv_query_device_ex_input *input,
+		      struct ibv_device_attr_ex *attr, size_t attr_size)
 {
-	struct ibv_query_device cmd;
+	struct ib_uverbs_ex_query_device_resp resp;
+	size_t resp_size =3D sizeof(resp);
 	uint64_t raw_fw_ver;
 	u8 major, minor, sub_minor, build;
 	int ret;
=20
-	ret =3D ibv_cmd_query_device(context, attr, &raw_fw_ver, &cmd,
-				   sizeof cmd);
+	ret =3D ibv_cmd_query_device_any(context, input, attr, attr_size, &resp,
+				       &resp_size);
 	if (ret)
 		return ret;
=20
+	raw_fw_ver =3D resp.base.fw_ver;
 	major =3D (raw_fw_ver >> 24) & 0xff;
 	minor =3D (raw_fw_ver >> 16) & 0xff;
 	sub_minor =3D (raw_fw_ver >> 8) & 0xff;
 	build =3D raw_fw_ver & 0xff;
=20
-	snprintf(attr->fw_ver, sizeof attr->fw_ver,
+	snprintf(attr->orig_attr.fw_ver, sizeof(attr->orig_attr.fw_ver),
 		 "%d.%d.%d.%d", major, minor, sub_minor, build);
=20
 	return 0;
diff --git a/providers/hfi1verbs/hfiverbs.c b/providers/hfi1verbs/hfiverbs.=
c
index 9bfb967c09791e..514a7e6b602cb7 100644
--- a/providers/hfi1verbs/hfiverbs.c
+++ b/providers/hfi1verbs/hfiverbs.c
@@ -90,7 +90,7 @@ static const struct verbs_match_ent hca_table[] =3D {
=20
 static const struct verbs_context_ops hfi1_ctx_common_ops =3D {
 	.free_context	=3D hfi1_free_context,
-	.query_device	=3D hfi1_query_device,
+	.query_device_ex =3D hfi1_query_device,
 	.query_port	=3D hfi1_query_port,
=20
 	.alloc_pd	=3D hfi1_alloc_pd,
diff --git a/providers/hfi1verbs/hfiverbs.h b/providers/hfi1verbs/hfiverbs.=
h
index b9e91d8072acf3..34977fc0bdfca2 100644
--- a/providers/hfi1verbs/hfiverbs.h
+++ b/providers/hfi1verbs/hfiverbs.h
@@ -194,8 +194,9 @@ static inline struct hfi1_rwqe *get_rwqe_ptr(struct hfi=
1_rq *rq,
 		  rq->max_sge * sizeof(struct ibv_sge)) * n);
 }
=20
-extern int hfi1_query_device(struct ibv_context *context,
-			      struct ibv_device_attr *attr);
+int hfi1_query_device(struct ibv_context *context,
+		      const struct ibv_query_device_ex_input *input,
+		      struct ibv_device_attr_ex *attr, size_t attr_size);
=20
 extern int hfi1_query_port(struct ibv_context *context, uint8_t port,
 			    struct ibv_port_attr *attr);
diff --git a/providers/hfi1verbs/verbs.c b/providers/hfi1verbs/verbs.c
index 275f8d511392a7..028552a23718cd 100644
--- a/providers/hfi1verbs/verbs.c
+++ b/providers/hfi1verbs/verbs.c
@@ -68,23 +68,26 @@
 #include "hfi-abi.h"
=20
 int hfi1_query_device(struct ibv_context *context,
-		       struct ibv_device_attr *attr)
+		      const struct ibv_query_device_ex_input *input,
+		      struct ibv_device_attr_ex *attr, size_t attr_size)
 {
-	struct ibv_query_device cmd;
+	struct ib_uverbs_ex_query_device_resp resp;
+	size_t resp_size =3D sizeof(resp);
 	uint64_t raw_fw_ver;
 	unsigned major, minor, sub_minor;
 	int ret;
=20
-	ret =3D ibv_cmd_query_device(context, attr, &raw_fw_ver,
-				   &cmd, sizeof cmd);
+	ret =3D ibv_cmd_query_device_any(context, input, attr, attr_size, &resp,
+				       &resp_size);
 	if (ret)
 		return ret;
=20
+	raw_fw_ver =3D resp.base.fw_ver;
 	major     =3D (raw_fw_ver >> 32) & 0xffff;
 	minor     =3D (raw_fw_ver >> 16) & 0xffff;
 	sub_minor =3D raw_fw_ver & 0xffff;
=20
-	snprintf(attr->fw_ver, sizeof attr->fw_ver,
+	snprintf(attr->orig_attr.fw_ver, sizeof(attr->orig_attr.fw_ver),
 		 "%d.%d.%d", major, minor, sub_minor);
=20
 	return 0;
diff --git a/providers/hns/hns_roce_u.c b/providers/hns/hns_roce_u.c
index c4370411d8aa33..23b317cc9b5fb8 100644
--- a/providers/hns/hns_roce_u.c
+++ b/providers/hns/hns_roce_u.c
@@ -74,7 +74,7 @@ static const struct verbs_context_ops hns_common_ops =3D =
{
 	.dereg_mr =3D hns_roce_u_dereg_mr,
 	.destroy_cq =3D hns_roce_u_destroy_cq,
 	.modify_cq =3D hns_roce_u_modify_cq,
-	.query_device =3D hns_roce_u_query_device,
+	.query_device_ex =3D hns_roce_u_query_device,
 	.query_port =3D hns_roce_u_query_port,
 	.query_qp =3D hns_roce_u_query_qp,
 	.reg_mr =3D hns_roce_u_reg_mr,
@@ -147,7 +147,11 @@ static struct verbs_context *hns_roce_alloc_context(st=
ruct ibv_device *ibdev,
 	verbs_set_ops(&context->ibv_ctx, &hns_common_ops);
 	verbs_set_ops(&context->ibv_ctx, &hr_dev->u_hw->hw_ops);
=20
-	if (hns_roce_u_query_device(&context->ibv_ctx.context, &dev_attrs))
+	if (hns_roce_u_query_device(&context->ibv_ctx.context, NULL,
+				    container_of(&dev_attrs,
+						 struct ibv_device_attr_ex,
+						 orig_attr),
+				    sizeof(dev_attrs)))
 		goto tptr_free;
=20
 	context->max_qp_wr =3D dev_attrs.max_qp_wr;
diff --git a/providers/hns/hns_roce_u.h b/providers/hns/hns_roce_u.h
index b0308d14820b06..0c2dc1e3441550 100644
--- a/providers/hns/hns_roce_u.h
+++ b/providers/hns/hns_roce_u.h
@@ -316,7 +316,8 @@ static inline struct  hns_roce_qp *to_hr_qp(struct ibv_=
qp *ibv_qp)
 }
=20
 int hns_roce_u_query_device(struct ibv_context *context,
-			    struct ibv_device_attr *attr);
+			    const struct ibv_query_device_ex_input *input,
+			    struct ibv_device_attr_ex *attr, size_t attr_size);
 int hns_roce_u_query_port(struct ibv_context *context, uint8_t port,
 			  struct ibv_port_attr *attr);
=20
diff --git a/providers/hns/hns_roce_u_verbs.c b/providers/hns/hns_roce_u_ve=
rbs.c
index 06fdbfac5e898d..bffd8df4f3f7a4 100644
--- a/providers/hns/hns_roce_u_verbs.c
+++ b/providers/hns/hns_roce_u_verbs.c
@@ -54,24 +54,27 @@ void hns_roce_init_qp_indices(struct hns_roce_qp *qp)
 }
=20
 int hns_roce_u_query_device(struct ibv_context *context,
-			    struct ibv_device_attr *attr)
+			    const struct ibv_query_device_ex_input *input,
+			    struct ibv_device_attr_ex *attr, size_t attr_size)
 {
+	struct ib_uverbs_ex_query_device_resp resp;
+	size_t resp_size =3D sizeof(resp);
 	int ret;
-	struct ibv_query_device cmd;
 	uint64_t raw_fw_ver;
 	unsigned int major, minor, sub_minor;
=20
-	ret =3D ibv_cmd_query_device(context, attr, &raw_fw_ver, &cmd,
-				   sizeof(cmd));
+	ret =3D ibv_cmd_query_device_any(context, input, attr, attr_size, &resp,
+				       &resp_size);
 	if (ret)
 		return ret;
=20
+	raw_fw_ver =3D resp.base.fw_ver;
 	major =3D (raw_fw_ver >> 32) & 0xffff;
 	minor =3D (raw_fw_ver >> 16) & 0xffff;
 	sub_minor =3D raw_fw_ver & 0xffff;
=20
-	snprintf(attr->fw_ver, sizeof(attr->fw_ver), "%d.%d.%03d", major, minor,
-		 sub_minor);
+	snprintf(attr->orig_attr.fw_ver, sizeof(attr->orig_attr.fw_ver),
+		 "%d.%d.%03d", major, minor, sub_minor);
=20
 	return 0;
 }
diff --git a/providers/i40iw/i40iw_umain.c b/providers/i40iw/i40iw_umain.c
index eef8cd50cabf43..c5ac0792ed6f83 100644
--- a/providers/i40iw/i40iw_umain.c
+++ b/providers/i40iw/i40iw_umain.c
@@ -95,7 +95,7 @@ static const struct verbs_match_ent hca_table[] =3D {
 };
=20
 static const struct verbs_context_ops i40iw_uctx_ops =3D {
-	.query_device	=3D i40iw_uquery_device,
+	.query_device_ex =3D i40iw_uquery_device,
 	.query_port	=3D i40iw_uquery_port,
 	.alloc_pd	=3D i40iw_ualloc_pd,
 	.dealloc_pd	=3D i40iw_ufree_pd,
diff --git a/providers/i40iw/i40iw_umain.h b/providers/i40iw/i40iw_umain.h
index 10385dfc8304e9..fe643dd1a04e06 100644
--- a/providers/i40iw/i40iw_umain.h
+++ b/providers/i40iw/i40iw_umain.h
@@ -151,7 +151,9 @@ static inline struct i40iw_uqp *to_i40iw_uqp(struct ibv=
_qp *ibqp)
 }
=20
 /* i40iw_uverbs.c */
-int i40iw_uquery_device(struct ibv_context *, struct ibv_device_attr *);
+int i40iw_uquery_device(struct ibv_context *context,
+			const struct ibv_query_device_ex_input *input,
+			struct ibv_device_attr_ex *attr, size_t attr_size);
 int i40iw_uquery_port(struct ibv_context *, uint8_t, struct ibv_port_attr =
*);
 struct ibv_pd *i40iw_ualloc_pd(struct ibv_context *);
 int i40iw_ufree_pd(struct ibv_pd *);
diff --git a/providers/i40iw/i40iw_uverbs.c b/providers/i40iw/i40iw_uverbs.=
c
index 71b59a7a812c17..c170bb33ef8b6e 100644
--- a/providers/i40iw/i40iw_uverbs.c
+++ b/providers/i40iw/i40iw_uverbs.c
@@ -55,23 +55,27 @@
  * @context: user context for the device
  * @attr: where to save all the mx resources from the driver
  **/
-int i40iw_uquery_device(struct ibv_context *context, struct ibv_device_att=
r *attr)
+int i40iw_uquery_device(struct ibv_context *context,
+			const struct ibv_query_device_ex_input *input,
+			struct ibv_device_attr_ex *attr, size_t attr_size)
 {
-	struct ibv_query_device cmd;
+	struct ib_uverbs_ex_query_device_resp resp;
+	size_t resp_size =3D sizeof(resp);
 	uint64_t i40iw_fw_ver;
 	int ret;
 	unsigned int minor, major;
=20
-	ret =3D ibv_cmd_query_device(context, attr, &i40iw_fw_ver, &cmd, sizeof(c=
md));
-	if (ret) {
-		fprintf(stderr, PFX "%s: query device failed and returned status code: %=
d\n", __func__, ret);
+	ret =3D ibv_cmd_query_device_any(context, input, attr, attr_size, &resp,
+				       &resp_size);
+	if (ret)
 		return ret;
-	}
=20
+	i40iw_fw_ver =3D resp.base.fw_ver;
 	major =3D (i40iw_fw_ver >> 16) & 0xffff;
 	minor =3D i40iw_fw_ver & 0xffff;
=20
-	snprintf(attr->fw_ver, sizeof(attr->fw_ver), "%d.%d", major, minor);
+	snprintf(attr->orig_attr.fw_ver, sizeof(attr->orig_attr.fw_ver),
+		 "%d.%d", major, minor);
=20
 	return 0;
 }
diff --git a/providers/ipathverbs/ipathverbs.c b/providers/ipathverbs/ipath=
verbs.c
index 0e1a58433d34b2..975f52d011c4c0 100644
--- a/providers/ipathverbs/ipathverbs.c
+++ b/providers/ipathverbs/ipathverbs.c
@@ -89,7 +89,7 @@ static const struct verbs_match_ent hca_table[] =3D {
=20
 static const struct verbs_context_ops ipath_ctx_common_ops =3D {
 	.free_context	=3D ipath_free_context,
-	.query_device	=3D ipath_query_device,
+	.query_device_ex =3D ipath_query_device,
 	.query_port	=3D ipath_query_port,
=20
 	.alloc_pd	=3D ipath_alloc_pd,
diff --git a/providers/ipathverbs/ipathverbs.h b/providers/ipathverbs/ipath=
verbs.h
index 694f1f44a48315..c5fa761f794567 100644
--- a/providers/ipathverbs/ipathverbs.h
+++ b/providers/ipathverbs/ipathverbs.h
@@ -173,8 +173,9 @@ static inline struct ipath_rwqe *get_rwqe_ptr(struct ip=
ath_rq *rq,
 		  rq->max_sge * sizeof(struct ibv_sge)) * n);
 }
=20
-extern int ipath_query_device(struct ibv_context *context,
-			      struct ibv_device_attr *attr);
+int ipath_query_device(struct ibv_context *context,
+		       const struct ibv_query_device_ex_input *input,
+		       struct ibv_device_attr_ex *attr, size_t attr_size);
=20
 extern int ipath_query_port(struct ibv_context *context, uint8_t port,
 			    struct ibv_port_attr *attr);
diff --git a/providers/ipathverbs/verbs.c b/providers/ipathverbs/verbs.c
index 505ea584e878de..e1b098a078584a 100644
--- a/providers/ipathverbs/verbs.c
+++ b/providers/ipathverbs/verbs.c
@@ -48,23 +48,26 @@
 #include "ipath-abi.h"
=20
 int ipath_query_device(struct ibv_context *context,
-		       struct ibv_device_attr *attr)
+		       const struct ibv_query_device_ex_input *input,
+		       struct ibv_device_attr_ex *attr, size_t attr_size)
 {
-	struct ibv_query_device cmd;
+	struct ib_uverbs_ex_query_device_resp resp;
+	size_t resp_size =3D sizeof(resp);
 	uint64_t raw_fw_ver;
 	unsigned major, minor, sub_minor;
 	int ret;
=20
-	ret =3D ibv_cmd_query_device(context, attr, &raw_fw_ver,
-				   &cmd, sizeof cmd);
+	ret =3D ibv_cmd_query_device_any(context, input, attr, attr_size, &resp,
+				       &resp_size);
 	if (ret)
 		return ret;
=20
+	raw_fw_ver =3D resp.base.fw_ver;
 	major     =3D (raw_fw_ver >> 32) & 0xffff;
 	minor     =3D (raw_fw_ver >> 16) & 0xffff;
 	sub_minor =3D raw_fw_ver & 0xffff;
=20
-	snprintf(attr->fw_ver, sizeof attr->fw_ver,
+	snprintf(attr->orig_attr.fw_ver, sizeof(attr->orig_attr.fw_ver),
 		 "%d.%d.%d", major, minor, sub_minor);
=20
 	return 0;
diff --git a/providers/mthca/mthca.c b/providers/mthca/mthca.c
index abce4866883d8b..809aae00ef26f4 100644
--- a/providers/mthca/mthca.c
+++ b/providers/mthca/mthca.c
@@ -92,7 +92,7 @@ static const struct verbs_match_ent hca_table[] =3D {
 };
=20
 static const struct verbs_context_ops mthca_ctx_common_ops =3D {
-	.query_device  =3D mthca_query_device,
+	.query_device_ex =3D mthca_query_device,
 	.query_port    =3D mthca_query_port,
 	.alloc_pd      =3D mthca_alloc_pd,
 	.dealloc_pd    =3D mthca_free_pd,
diff --git a/providers/mthca/mthca.h b/providers/mthca/mthca.h
index b7df2f734686c8..43c58fa44d1a07 100644
--- a/providers/mthca/mthca.h
+++ b/providers/mthca/mthca.h
@@ -273,7 +273,8 @@ struct mthca_db_table *mthca_alloc_db_tab(int uarc_size=
);
 void mthca_free_db_tab(struct mthca_db_table *db_tab);
=20
 int mthca_query_device(struct ibv_context *context,
-		       struct ibv_device_attr *attr);
+		       const struct ibv_query_device_ex_input *input,
+		       struct ibv_device_attr_ex *attr, size_t attr_size);
 int mthca_query_port(struct ibv_context *context, uint8_t port,
 		     struct ibv_port_attr *attr);
=20
diff --git a/providers/mthca/verbs.c b/providers/mthca/verbs.c
index 99e5ec661265a6..7ba5a4177b485c 100644
--- a/providers/mthca/verbs.c
+++ b/providers/mthca/verbs.c
@@ -42,22 +42,27 @@
 #include "mthca.h"
 #include "mthca-abi.h"
=20
-int mthca_query_device(struct ibv_context *context, struct ibv_device_attr=
 *attr)
+int mthca_query_device(struct ibv_context *context,
+		       const struct ibv_query_device_ex_input *input,
+		       struct ibv_device_attr_ex *attr, size_t attr_size)
 {
-	struct ibv_query_device cmd;
+	struct ib_uverbs_ex_query_device_resp resp;
+	size_t resp_size =3D sizeof(resp);
 	uint64_t raw_fw_ver;
 	unsigned major, minor, sub_minor;
 	int ret;
=20
-	ret =3D ibv_cmd_query_device(context, attr, &raw_fw_ver, &cmd, sizeof cmd=
);
+	ret =3D ibv_cmd_query_device_any(context, input, attr, attr_size, &resp,
+				       &resp_size);
 	if (ret)
 		return ret;
=20
+	raw_fw_ver =3D resp.base.fw_ver;
 	major     =3D (raw_fw_ver >> 32) & 0xffff;
 	minor     =3D (raw_fw_ver >> 16) & 0xffff;
 	sub_minor =3D raw_fw_ver & 0xffff;
=20
-	snprintf(attr->fw_ver, sizeof attr->fw_ver,
+	snprintf(attr->orig_attr.fw_ver, sizeof(attr->orig_attr.fw_ver),
 		 "%d.%d.%d", major, minor, sub_minor);
=20
 	return 0;
diff --git a/providers/ocrdma/ocrdma_main.c b/providers/ocrdma/ocrdma_main.=
c
index f7ed629de8b4cf..c955dd1ba6642f 100644
--- a/providers/ocrdma/ocrdma_main.c
+++ b/providers/ocrdma/ocrdma_main.c
@@ -68,7 +68,7 @@ static const struct verbs_match_ent ucna_table[] =3D {
 };
=20
 static const struct verbs_context_ops ocrdma_ctx_ops =3D {
-	.query_device =3D ocrdma_query_device,
+	.query_device_ex =3D ocrdma_query_device,
 	.query_port =3D ocrdma_query_port,
 	.alloc_pd =3D ocrdma_alloc_pd,
 	.dealloc_pd =3D ocrdma_free_pd,
diff --git a/providers/ocrdma/ocrdma_main.h b/providers/ocrdma/ocrdma_main.=
h
index aadefd9649ac90..33ea20e0c6066b 100644
--- a/providers/ocrdma/ocrdma_main.h
+++ b/providers/ocrdma/ocrdma_main.h
@@ -265,7 +265,9 @@ static inline struct ocrdma_ah *get_ocrdma_ah(struct ib=
v_ah *ibah)
 }
=20
 void ocrdma_init_ahid_tbl(struct ocrdma_devctx *ctx);
-int ocrdma_query_device(struct ibv_context *, struct ibv_device_attr *);
+int ocrdma_query_device(struct ibv_context *context,
+			const struct ibv_query_device_ex_input *input,
+			struct ibv_device_attr_ex *attr, size_t attr_size);
 int ocrdma_query_port(struct ibv_context *, uint8_t, struct ibv_port_attr =
*);
 struct ibv_pd *ocrdma_alloc_pd(struct ibv_context *);
 int ocrdma_free_pd(struct ibv_pd *);
diff --git a/providers/ocrdma/ocrdma_verbs.c b/providers/ocrdma/ocrdma_verb=
s.c
index 4ae35be9d2d9ee..688ff7d4f24043 100644
--- a/providers/ocrdma/ocrdma_verbs.c
+++ b/providers/ocrdma/ocrdma_verbs.c
@@ -68,17 +68,21 @@ static inline void ocrdma_swap_cpu_to_le(void *dst, uin=
t32_t len)
  * ocrdma_query_device
  */
 int ocrdma_query_device(struct ibv_context *context,
-			struct ibv_device_attr *attr)
+			const struct ibv_query_device_ex_input *input,
+			struct ibv_device_attr_ex *attr, size_t attr_size)
 {
-	struct ibv_query_device cmd;
-	uint64_t fw_ver;
 	struct ocrdma_device *dev =3D get_ocrdma_dev(context->device);
-	int status;
+	struct ib_uverbs_ex_query_device_resp resp;
+	size_t resp_size =3D sizeof(resp);
+	int ret;
=20
-	bzero(attr, sizeof *attr);
-	status =3D ibv_cmd_query_device(context, attr, &fw_ver, &cmd, sizeof cmd)=
;
-	memcpy(attr->fw_ver, dev->fw_ver, sizeof(dev->fw_ver));
-	return status;
+	ret =3D ibv_cmd_query_device_any(context, input, attr, attr_size, &resp,
+				       &resp_size);
+	if (ret)
+		return ret;
+
+	memcpy(attr->orig_attr.fw_ver, dev->fw_ver, sizeof(dev->fw_ver));
+	return 0;
 }
=20
 /*
diff --git a/providers/qedr/qelr_main.c b/providers/qedr/qelr_main.c
index bdfaa930f0c601..334972ae043cc4 100644
--- a/providers/qedr/qelr_main.c
+++ b/providers/qedr/qelr_main.c
@@ -87,7 +87,7 @@ static const struct verbs_match_ent hca_table[] =3D {
 };
=20
 static const struct verbs_context_ops qelr_ctx_ops =3D {
-	.query_device =3D qelr_query_device,
+	.query_device_ex =3D qelr_query_device,
 	.query_port =3D qelr_query_port,
 	.alloc_pd =3D qelr_alloc_pd,
 	.dealloc_pd =3D qelr_dealloc_pd,
diff --git a/providers/qedr/qelr_verbs.c b/providers/qedr/qelr_verbs.c
index 4e77a1976a9154..dab9cf67539704 100644
--- a/providers/qedr/qelr_verbs.c
+++ b/providers/qedr/qelr_verbs.c
@@ -75,26 +75,29 @@ static inline int qelr_wq_is_full(struct qelr_qp_hwq_in=
fo *info)
 }
=20
 int qelr_query_device(struct ibv_context *context,
-		      struct ibv_device_attr *attr)
+		      const struct ibv_query_device_ex_input *input,
+		      struct ibv_device_attr_ex *attr, size_t attr_size)
 {
-	struct ibv_query_device cmd;
+	struct ib_uverbs_ex_query_device_resp resp;
+	size_t resp_size =3D sizeof(resp);
 	uint64_t fw_ver;
 	unsigned int major, minor, revision, eng;
-	int status;
+	int ret;
=20
-	bzero(attr, sizeof(*attr));
-	status =3D ibv_cmd_query_device(context, attr, &fw_ver, &cmd,
-				      sizeof(cmd));
+	ret =3D ibv_cmd_query_device_any(context, input, attr, attr_size, &resp,
+				       &resp_size);
+	if (ret)
+		return ret;
=20
+	fw_ver =3D resp.base.fw_ver;
 	major =3D (fw_ver >> 24) & 0xff;
 	minor =3D (fw_ver >> 16) & 0xff;
 	revision =3D (fw_ver >> 8) & 0xff;
 	eng =3D fw_ver & 0xff;
=20
-	snprintf(attr->fw_ver, sizeof(attr->fw_ver),
+	snprintf(attr->orig_attr.fw_ver, sizeof(attr->orig_attr.fw_ver),
 		 "%d.%d.%d.%d", major, minor, revision, eng);
-
-	return status;
+	return 0;
 }
=20
 int qelr_query_port(struct ibv_context *context, uint8_t port,
diff --git a/providers/qedr/qelr_verbs.h b/providers/qedr/qelr_verbs.h
index bbfd4906b082e6..b5b43b19241904 100644
--- a/providers/qedr/qelr_verbs.h
+++ b/providers/qedr/qelr_verbs.h
@@ -41,7 +41,8 @@
 #include <util/udma_barrier.h>
=20
 int qelr_query_device(struct ibv_context *context,
-		      struct ibv_device_attr *attr);
+		      const struct ibv_query_device_ex_input *input,
+		      struct ibv_device_attr_ex *attr, size_t attr_size);
 int qelr_query_port(struct ibv_context *context, uint8_t port,
 		    struct ibv_port_attr *attr);
=20
diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
index 18e8c53dcd253a..d4357bac9d4d40 100644
--- a/providers/rxe/rxe.c
+++ b/providers/rxe/rxe.c
@@ -65,23 +65,26 @@ static const struct verbs_match_ent hca_table[] =3D {
 };
=20
 static int rxe_query_device(struct ibv_context *context,
-			    struct ibv_device_attr *attr)
+			    const struct ibv_query_device_ex_input *input,
+			    struct ibv_device_attr_ex *attr, size_t attr_size)
 {
-	struct ibv_query_device cmd;
+	struct ib_uverbs_ex_query_device_resp resp;
+	size_t resp_size =3D sizeof(resp);
 	uint64_t raw_fw_ver;
 	unsigned int major, minor, sub_minor;
 	int ret;
=20
-	ret =3D ibv_cmd_query_device(context, attr, &raw_fw_ver,
-				   &cmd, sizeof(cmd));
+	ret =3D ibv_cmd_query_device_any(context, input, attr, attr_size, &resp,
+				       &resp_size);
 	if (ret)
 		return ret;
=20
+	raw_fw_ver =3D resp.base.fw_ver;
 	major =3D (raw_fw_ver >> 32) & 0xffff;
 	minor =3D (raw_fw_ver >> 16) & 0xffff;
 	sub_minor =3D raw_fw_ver & 0xffff;
=20
-	snprintf(attr->fw_ver, sizeof(attr->fw_ver),
+	snprintf(attr->orig_attr.fw_ver, sizeof(attr->orig_attr.fw_ver),
 		 "%d.%d.%d", major, minor, sub_minor);
=20
 	return 0;
@@ -831,7 +834,7 @@ static int rxe_destroy_ah(struct ibv_ah *ibah)
 }
=20
 static const struct verbs_context_ops rxe_ctx_ops =3D {
-	.query_device =3D rxe_query_device,
+	.query_device_ex =3D rxe_query_device,
 	.query_port =3D rxe_query_port,
 	.alloc_pd =3D rxe_alloc_pd,
 	.dealloc_pd =3D rxe_dealloc_pd,
diff --git a/providers/siw/siw.c b/providers/siw/siw.c
index 0f94e614d16876..8f6dee4e58af56 100644
--- a/providers/siw/siw.c
+++ b/providers/siw/siw.c
@@ -20,26 +20,28 @@
 static const int siw_debug;
 static void siw_free_context(struct ibv_context *ibv_ctx);
=20
-static int siw_query_device(struct ibv_context *ctx,
-			    struct ibv_device_attr *attr)
+static int siw_query_device(struct ibv_context *context,
+			 const struct ibv_query_device_ex_input *input,
+			 struct ibv_device_attr_ex *attr, size_t attr_size)
 {
-	struct ibv_query_device cmd;
+	struct ib_uverbs_ex_query_device_resp resp;
+	size_t resp_size =3D sizeof(resp);
 	uint64_t raw_fw_ver;
 	unsigned int major, minor, sub_minor;
 	int rv;
=20
-	memset(&cmd, 0, sizeof(cmd));
-
-	rv =3D ibv_cmd_query_device(ctx, attr, &raw_fw_ver, &cmd, sizeof(cmd));
+	rv =3D ibv_cmd_query_device_any(context, input, attr, attr_size, &resp,
+				      &resp_size);
 	if (rv)
 		return rv;
=20
+	raw_fw_ver =3D resp.base.fw_ver;
 	major =3D (raw_fw_ver >> 32) & 0xffff;
 	minor =3D (raw_fw_ver >> 16) & 0xffff;
 	sub_minor =3D raw_fw_ver & 0xffff;
=20
-	snprintf(attr->fw_ver, sizeof(attr->fw_ver), "%d.%d.%d", major, minor,
-		 sub_minor);
+	snprintf(attr->orig_attr.fw_ver, sizeof(attr->orig_attr.fw_ver),
+		 "%d.%d.%d", major, minor, sub_minor);
=20
 	return 0;
 }
@@ -832,7 +834,7 @@ static const struct verbs_context_ops siw_context_ops =
=3D {
 	.post_recv =3D siw_post_recv,
 	.post_send =3D siw_post_send,
 	.post_srq_recv =3D siw_post_srq_recv,
-	.query_device =3D siw_query_device,
+	.query_device_ex =3D siw_query_device,
 	.query_port =3D siw_query_port,
 	.query_qp =3D siw_query_qp,
 	.reg_mr =3D siw_reg_mr,
diff --git a/providers/vmw_pvrdma/pvrdma.h b/providers/vmw_pvrdma/pvrdma.h
index 0db65773f5d003..bb6ba729d0e4bc 100644
--- a/providers/vmw_pvrdma/pvrdma.h
+++ b/providers/vmw_pvrdma/pvrdma.h
@@ -275,7 +275,8 @@ int pvrdma_alloc_buf(struct pvrdma_buf *buf, size_t siz=
e, int page_size);
 void pvrdma_free_buf(struct pvrdma_buf *buf);
=20
 int pvrdma_query_device(struct ibv_context *context,
-			struct ibv_device_attr *attr);
+			const struct ibv_query_device_ex_input *input,
+			struct ibv_device_attr_ex *attr, size_t attr_size);
 int pvrdma_query_port(struct ibv_context *context, uint8_t port,
 		      struct ibv_port_attr *attr);
=20
diff --git a/providers/vmw_pvrdma/pvrdma_main.c b/providers/vmw_pvrdma/pvrd=
ma_main.c
index 14a67c1cee3150..4f93b519dfa6b3 100644
--- a/providers/vmw_pvrdma/pvrdma_main.c
+++ b/providers/vmw_pvrdma/pvrdma_main.c
@@ -55,7 +55,7 @@ static void pvrdma_free_context(struct ibv_context *ibctx=
);
=20
 static const struct verbs_context_ops pvrdma_ctx_ops =3D {
 	.free_context =3D pvrdma_free_context,
-	.query_device =3D pvrdma_query_device,
+	.query_device_ex =3D pvrdma_query_device,
 	.query_port =3D pvrdma_query_port,
 	.alloc_pd =3D pvrdma_alloc_pd,
 	.dealloc_pd =3D pvrdma_free_pd,
diff --git a/providers/vmw_pvrdma/verbs.c b/providers/vmw_pvrdma/verbs.c
index e8423c01365e7b..815333691c3831 100644
--- a/providers/vmw_pvrdma/verbs.c
+++ b/providers/vmw_pvrdma/verbs.c
@@ -47,23 +47,26 @@
 #include "pvrdma.h"
=20
 int pvrdma_query_device(struct ibv_context *context,
-			struct ibv_device_attr *attr)
+			const struct ibv_query_device_ex_input *input,
+			struct ibv_device_attr_ex *attr, size_t attr_size)
 {
-	struct ibv_query_device cmd;
+	struct ib_uverbs_ex_query_device_resp resp;
+	size_t resp_size =3D sizeof(resp);
 	uint64_t raw_fw_ver;
 	unsigned major, minor, sub_minor;
 	int ret;
=20
-	ret =3D ibv_cmd_query_device(context, attr, &raw_fw_ver,
-				   &cmd, sizeof(cmd));
+	ret =3D ibv_cmd_query_device_any(context, input, attr, attr_size, &resp,
+				       &resp_size);
 	if (ret)
 		return ret;
=20
+	raw_fw_ver =3D resp.base.fw_ver;
 	major =3D (raw_fw_ver >> 32) & 0xffff;
 	minor =3D (raw_fw_ver >> 16) & 0xffff;
 	sub_minor =3D raw_fw_ver & 0xffff;
=20
-	snprintf(attr->fw_ver, sizeof(attr->fw_ver),
+	snprintf(attr->orig_attr.fw_ver, sizeof(attr->orig_attr.fw_ver),
 		 "%d.%d.%03d", major, minor, sub_minor);
=20
 	return 0;
--=20
2.29.2

