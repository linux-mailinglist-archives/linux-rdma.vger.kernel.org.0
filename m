Return-Path: <linux-rdma+bounces-4701-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A46B96863E
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 13:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA4C281593
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 11:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05BE1D3643;
	Mon,  2 Sep 2024 11:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SND1Aw0e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F4D1D3184
	for <linux-rdma@vger.kernel.org>; Mon,  2 Sep 2024 11:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725276574; cv=none; b=Jj3Pq/K5d+9/UhphM89IDK3HVSQ2qZye44HKl9FvMLnVoJKP3HDVrgb866tmEGpcb/KcLnA4mECbQvtaLHjxmmTGykZShW5EK0NYvV3WlNHOGJfqiqXzERUaWAwJTRTZRFrHqk5orcWt7cV/Da2hdY4Pn5iFjUn3Rd5/AcTtSz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725276574; c=relaxed/simple;
	bh=Yt21MzRJGUe5HjT3hcJXSIFC0Wz0DEcpPi0N0lmerMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NM4DNKcJexYT6fYP3t56s7eIAuZrvwvWlLrW8GfAD5bFp/CDCwSvnqfuT2si9MbMgoK2OsalM9JDfFmJDtjrU17hGzJL+7/kwj5KSqVaVpHYVsyE7btmh6pm0Cr0ZH5D11EcJvtEtJY9YV7ig3fN0zUhlRfgauFpoXFCfPBMEJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SND1Aw0e; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725276565; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=irlOFAPN+vuViiYG6kuLdwFaR5Cc9jBUNhyBok0lvbY=;
	b=SND1Aw0eor5BQ1cQiQUUFXadasZYMaCsoOcJ3N6AB2QaFL9RzNNR3uefR+gqOd6ytUJi3w6BMQGePM00YEAd1p2IYyHLkrxo5C92BPgKrvfOsOVElBM5Ycn4ZpeEMXDRpiHFCjdncnTo9JKqoZniRJzuKpiP5zcz41FNlKzwcpU=
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0WE8BdmP_1725276564)
          by smtp.aliyun-inc.com;
          Mon, 02 Sep 2024 19:29:24 +0800
From: Cheng Xu <chengyou@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	KaiShen@linux.alibaba.com
Subject: [PATCH for-next v3 2/3] RDMA/erdma: Add disassociate ucontext support
Date: Mon,  2 Sep 2024 19:29:19 +0800
Message-Id: <20240902112920.58749-3-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240902112920.58749-1-chengyou@linux.alibaba.com>
References: <20240902112920.58749-1-chengyou@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All IO pages mapped to user space are handled by rdma_user_mmap_io,
so add empty stub for disassociate ucontext.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_main.c  | 1 +
 drivers/infiniband/hw/erdma/erdma_verbs.c | 4 ++++
 drivers/infiniband/hw/erdma/erdma_verbs.h | 1 +
 3 files changed, 6 insertions(+)

diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
index 9defbd55893a..62f497a71004 100644
--- a/drivers/infiniband/hw/erdma/erdma_main.c
+++ b/drivers/infiniband/hw/erdma/erdma_main.c
@@ -490,6 +490,7 @@ static const struct ib_device_ops erdma_device_ops = {
 	.dereg_mr = erdma_dereg_mr,
 	.destroy_cq = erdma_destroy_cq,
 	.destroy_qp = erdma_destroy_qp,
+	.disassociate_ucontext = erdma_disassociate_ucontext,
 	.get_dma_mr = erdma_get_dma_mr,
 	.get_hw_stats = erdma_get_hw_stats,
 	.get_port_immutable = erdma_get_port_immutable,
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 40c9b6e46b82..48b08a15e6a8 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -1700,6 +1700,10 @@ int erdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	return ret;
 }
 
+void erdma_disassociate_ucontext(struct ib_ucontext *ibcontext)
+{
+}
+
 void erdma_set_mtu(struct erdma_dev *dev, u32 mtu)
 {
 	struct erdma_cmdq_config_mtu_req req;
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/infiniband/hw/erdma/erdma_verbs.h
index 4f02ba06b210..b7478376eb80 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.h
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
@@ -344,6 +344,7 @@ int erdma_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int mask,
 		    struct ib_udata *data);
 int erdma_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata);
 int erdma_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
+void erdma_disassociate_ucontext(struct ib_ucontext *ibcontext);
 int erdma_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
 struct ib_mr *erdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
 				u64 virt, int access, struct ib_udata *udata);
-- 
2.31.1


