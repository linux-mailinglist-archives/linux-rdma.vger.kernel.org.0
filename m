Return-Path: <linux-rdma+bounces-5353-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D19998034
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 10:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F901C23FFB
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 08:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0F01BCA14;
	Thu, 10 Oct 2024 08:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="h4b7maqG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from va-2-33.ptr.blmpb.com (va-2-33.ptr.blmpb.com [209.127.231.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6FB1B5EB0
	for <linux-rdma@vger.kernel.org>; Thu, 10 Oct 2024 08:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548004; cv=none; b=IxMWtOMXgcNJKPbzZeNzf/qlEbc6pstc/vPu9YIoKYo8Gmhqji31KATnH1ZbS6OH82W4ihZNogtg+KWe69sFxs6MdQmiSmQHbNYpYf1LaCVjHf1Fk1BIkoXRiZ8kzjjyUi8wXmozxULaAIaXxhOlgdDHBUy2XRAojgfBZjC9GrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548004; c=relaxed/simple;
	bh=fT4fDFx1jsOJQiSYAUObYqtR9OtS9WAoGWbeLCH3viU=;
	h=To:Cc:Content-Type:Message-Id:Mime-Version:From:Subject:Date; b=eL7hpEAECMA8Jul0Nf5wiBFtZgJPfCDPdRT0AmgMejNbO7hRWL/KAgd/BJOonCsQ2btpLOaGeRSwuAAKNCUxZwXk3VuVhbpbQFyNk56m0KEyisdfp0cMcAJVD8lj459f3GKAuHAMPEjm/uF93hF2hKTBn8VMUn4SlQe24Sla8eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=h4b7maqG; arc=none smtp.client-ip=209.127.231.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1728547855; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=4NTItYSHAeWZUHewyY4UX6IPby9PaFzKctAxOMqQBeg=;
 b=h4b7maqGVankXX82/1/gFwcrx7C9kp2bLTNNUbkqpFUqPJdKeTluX4oL4ORTi0c2L43MnV
 fhX9a3K+1qE97glWWB2/SooYvhHv4wseK/GGoTbkMWSeA/2vILTy+wfwaCswRyriwW6mS5
 ALuNO8Cnzgi/QReYnhLi0Z2fgN/57vvTcNpAvVSWAIKw0+ooHG2wXeQk9B/Q5+mBA9smwh
 tTnsfXI5A8H1fkTjhVzFrokH6rj0Moo70gSmKLXWYBJhC7wfKCQBSumjgAMdMcGFQzIEWk
 9llPDW5ur/uJgNsUPvye+jArMHuEWnKFXrcngKUKc9I4uAbJrTPJM1GWJ8k4lA==
To: <leonro@nvidia.com>, <jgg@nvidia.com>
Cc: <linux-rdma@vger.kernel.org>, "Tian Xin" <tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <20241010081049.1448826-3-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Tian Xin <tianx@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
From: "Tian Xin" <tianx@yunsilicon.com>
Subject: [PATCH 2/6] libxscale: Add support for pd and mr
Date: Thu, 10 Oct 2024 16:10:45 +0800
X-Lms-Return-Path: <lba+267078c0e+f9fb38+vger.kernel.org+tianx@yunsilicon.com>
Content-Transfer-Encoding: 7bit
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Thu, 10 Oct 2024 16:10:54 +0800

This patch adds support for pd and mr operations including:
1. alloc_pd
2. dealloc_pd
3. reg_mr
4. dereg_mr

Signed-off-by: Tian Xin <tianx@yunsilicon.com>
Signed-off-by: Wei Honggang <weihg@yunsilicon.com>
Signed-off-by: Zhao Qianwei <zhaoqw@yunsilicon.com>
Signed-off-by: Li Qiang <liq@yunsilicon.com>
Signed-off-by: Yan Lei <jacky@yunsilicon.com>
---
 providers/xscale/verbs.c  | 85 +++++++++++++++++++++++++++++++++++++++
 providers/xscale/xscale.c |  4 ++
 providers/xscale/xscale.h | 29 +++++++++++++
 3 files changed, 118 insertions(+)

diff --git a/providers/xscale/verbs.c b/providers/xscale/verbs.c
index 943665a8..ed265d6e 100644
--- a/providers/xscale/verbs.c
+++ b/providers/xscale/verbs.c
@@ -36,6 +36,91 @@ int xsc_query_port(struct ibv_context *context, u8 port,
 	return ibv_cmd_query_port(context, port, attr, &cmd, sizeof(cmd));
 }
 
+struct ibv_pd *xsc_alloc_pd(struct ibv_context *context)
+{
+	struct ibv_alloc_pd cmd;
+	struct xsc_alloc_pd_resp resp;
+	struct xsc_pd *pd;
+
+	pd = calloc(1, sizeof(*pd));
+	if (!pd)
+		return NULL;
+
+	if (ibv_cmd_alloc_pd(context, &pd->ibv_pd, &cmd, sizeof(cmd),
+			     &resp.ibv_resp, sizeof(resp))) {
+		free(pd);
+		return NULL;
+	}
+
+	atomic_init(&pd->refcount, 1);
+	pd->pdn = resp.pdn;
+	xsc_dbg(to_xctx(context)->dbg_fp, XSC_DBG_PD, "pd number:%u\n",
+		pd->pdn);
+
+	return &pd->ibv_pd;
+}
+
+int xsc_free_pd(struct ibv_pd *pd)
+{
+	int ret;
+	struct xsc_pd *xpd = to_xpd(pd);
+
+	if (atomic_load(&xpd->refcount) > 1)
+		return EBUSY;
+
+	ret = ibv_cmd_dealloc_pd(pd);
+	if (ret)
+		return ret;
+
+	xsc_dbg(to_xctx(pd->context)->dbg_fp, XSC_DBG_PD, "dealloc pd\n");
+	free(xpd);
+
+	return 0;
+}
+
+struct ibv_mr *xsc_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
+			  u64 hca_va, int acc)
+{
+	struct xsc_mr *mr;
+	struct ibv_reg_mr cmd;
+	int ret;
+	enum ibv_access_flags access = (enum ibv_access_flags)acc;
+	struct ib_uverbs_reg_mr_resp resp;
+
+	mr = calloc(1, sizeof(*mr));
+	if (!mr)
+		return NULL;
+
+	ret = ibv_cmd_reg_mr(pd, addr, length, hca_va, access, &mr->vmr, &cmd,
+			     sizeof(cmd), &resp, sizeof(resp));
+	if (ret) {
+		free(mr);
+		return NULL;
+	}
+	mr->alloc_flags = acc;
+
+	xsc_dbg(to_xctx(pd->context)->dbg_fp, XSC_DBG_MR, "lkey:%u, rkey:%u\n",
+		mr->vmr.ibv_mr.lkey, mr->vmr.ibv_mr.rkey);
+
+	return &mr->vmr.ibv_mr;
+}
+
+int xsc_dereg_mr(struct verbs_mr *vmr)
+{
+	int ret;
+
+	if (vmr->mr_type == IBV_MR_TYPE_NULL_MR)
+		goto free;
+
+	ret = ibv_cmd_dereg_mr(vmr);
+	if (ret)
+		return ret;
+
+free:
+	free(vmr);
+	return 0;
+}
+
 static void xsc_set_fw_version(struct ibv_device_attr *attr,
 			       union xsc_ib_fw_ver *fw_ver)
 {
diff --git a/providers/xscale/xscale.c b/providers/xscale/xscale.c
index c7be8127..cdc37fbd 100644
--- a/providers/xscale/xscale.c
+++ b/providers/xscale/xscale.c
@@ -33,6 +33,10 @@ static void xsc_free_context(struct ibv_context *ibctx);
 
 static const struct verbs_context_ops xsc_ctx_common_ops = {
 	.query_port = xsc_query_port,
+	.alloc_pd = xsc_alloc_pd,
+	.dealloc_pd = xsc_free_pd,
+	.reg_mr = xsc_reg_mr,
+	.dereg_mr = xsc_dereg_mr,
 	.query_device_ex = xsc_query_device_ex,
 	.free_context = xsc_free_context,
 };
diff --git a/providers/xscale/xscale.h b/providers/xscale/xscale.h
index 85538d93..3cef6781 100644
--- a/providers/xscale/xscale.h
+++ b/providers/xscale/xscale.h
@@ -120,6 +120,17 @@ struct xsc_context {
 	struct xsc_hw_ops *hw_ops;
 };
 
+struct xsc_pd {
+	struct ibv_pd ibv_pd;
+	u32 pdn;
+	atomic_int refcount;
+};
+
+struct xsc_mr {
+	struct verbs_mr vmr;
+	u32 alloc_flags;
+};
+
 union xsc_ib_fw_ver {
 	u64 data;
 	struct {
@@ -154,6 +165,17 @@ static inline struct xsc_context *to_xctx(struct ibv_context *ibctx)
 	return container_of(ibctx, struct xsc_context, ibv_ctx.context);
 }
 
+/* to_xpd always returns the real xsc_pd object ie the protection domain. */
+static inline struct xsc_pd *to_xpd(struct ibv_pd *ibpd)
+{
+	return container_of(ibpd, struct xsc_pd, ibv_pd);
+}
+
+static inline struct xsc_mr *to_xmr(struct ibv_mr *ibmr)
+{
+	return container_of(ibmr, struct xsc_mr, vmr.ibv_mr);
+}
+
 int xsc_query_device(struct ibv_context *context, struct ibv_device_attr *attr);
 int xsc_query_device_ex(struct ibv_context *context,
 			const struct ibv_query_device_ex_input *input,
@@ -161,4 +183,11 @@ int xsc_query_device_ex(struct ibv_context *context,
 int xsc_query_port(struct ibv_context *context, u8 port,
 		   struct ibv_port_attr *attr);
 
+struct ibv_pd *xsc_alloc_pd(struct ibv_context *context);
+int xsc_free_pd(struct ibv_pd *pd);
+
+struct ibv_mr *xsc_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
+			  u64 hca_va, int access);
+int xsc_dereg_mr(struct verbs_mr *mr);
+
 #endif /* XSC_H */
-- 
2.25.1

