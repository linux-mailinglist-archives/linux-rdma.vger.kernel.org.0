Return-Path: <linux-rdma+bounces-3448-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 039D8915321
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 18:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F6FD1C2262D
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 16:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406EC19D88B;
	Mon, 24 Jun 2024 16:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FkoOeIRj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB1A19D094
	for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2024 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719245372; cv=none; b=AFFJyE/WNgtkh4z6zcoQGa79ZEtnLou913+nTKUU7gIxlRwtixrwNaWQeKF9+r70XOVBrNwaiZ2EAuc+Ca1Q/yZWa0MBT/54qZ0F9cBnhI2hvDTxK5Py/zTuUFEN9bX9bgQaUji35tCRRzpGCJpKR/Saqbf0dCXG8ziitL1nN90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719245372; c=relaxed/simple;
	bh=LRQtr25A5ordjlDH7SYvoSWi9hWZ6jyKJ0EfA5qOW+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SNtpU/80nIbrv9kH3hpnQ3KWLuAHpvYXmM3tUjp1/DWEwTUWKgAAeKSMP6483FdpegT7QpSDBGsWdVQbW0jYUiCQP4xEwtKdvK7khXgLRINxH+MYkDbB1nk141A+kAKHazu9hU/ICaZwnLUDzpaVr3fTqoAJgHAW5x4Blgycrwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=FkoOeIRj; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719245370; x=1750781370;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/qGrctqkIMm1rwGQSF/GrEpuRRogznIR6BgaVcyZ8UY=;
  b=FkoOeIRjrocBjYAayOcrAFryPH1aaNl0POarDCCc5WcM8vFbgN0YWVp9
   D3AIzFcJ4oi/kYuwMwViCTewnHWoXi91sZe1dQeYZKNnjLg4AK8fAUUrE
   9HTYEkiYtMPRmAMVWqZiFsqBY/5yO06SU39QvaN/HtNcAaRPVFi6tl06v
   0=;
X-IronPort-AV: E=Sophos;i="6.08,262,1712620800"; 
   d="scan'208";a="305654956"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 16:09:27 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.17.79:41381]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.35.117:2525] with esmtp (Farcaster)
 id fc7ab1bb-58a9-4e0b-8be8-b602e94cbd01; Mon, 24 Jun 2024 16:09:26 +0000 (UTC)
X-Farcaster-Flow-ID: fc7ab1bb-58a9-4e0b-8be8-b602e94cbd01
Received: from EX19D013EUA001.ant.amazon.com (10.252.50.140) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 24 Jun 2024 16:09:25 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D013EUA001.ant.amazon.com (10.252.50.140) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 24 Jun 2024 16:09:25 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by mail-relay.amazon.com (10.252.134.102) with Microsoft
 SMTP Server id 15.2.1258.34 via Frontend Transport; Mon, 24 Jun 2024 16:09:24
 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>, "Firas
 Jahjah" <firasj@amazon.com>, Yonatan Nachum <ynachum@amazon.com>
Subject: [PATCH for-next 4/5] RDMA/efa: Move type conversion helpers to efa.h
Date: Mon, 24 Jun 2024 16:09:17 +0000
Message-ID: <20240624160918.27060-5-mrgolin@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240624160918.27060-1-mrgolin@amazon.com>
References: <20240624160918.27060-1-mrgolin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Move ib_ to efa_ types conversion functions to have them near the types
definitions and to reduce code in efa_verbs.c.

Reviewed-by: Firas Jahjah <firasj@amazon.com>
Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 drivers/infiniband/hw/efa/efa.h       | 35 +++++++++++++++++++++++++++
 drivers/infiniband/hw/efa/efa_verbs.c | 35 ---------------------------
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index 926f9ff1f60f..f1020bf85b78 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -142,6 +142,41 @@ struct efa_eq {
 	struct efa_irq irq;
 };
 
+static inline struct efa_dev *to_edev(struct ib_device *ibdev)
+{
+	return container_of(ibdev, struct efa_dev, ibdev);
+}
+
+static inline struct efa_ucontext *to_eucontext(struct ib_ucontext *ibucontext)
+{
+	return container_of(ibucontext, struct efa_ucontext, ibucontext);
+}
+
+static inline struct efa_pd *to_epd(struct ib_pd *ibpd)
+{
+	return container_of(ibpd, struct efa_pd, ibpd);
+}
+
+static inline struct efa_mr *to_emr(struct ib_mr *ibmr)
+{
+	return container_of(ibmr, struct efa_mr, ibmr);
+}
+
+static inline struct efa_qp *to_eqp(struct ib_qp *ibqp)
+{
+	return container_of(ibqp, struct efa_qp, ibqp);
+}
+
+static inline struct efa_cq *to_ecq(struct ib_cq *ibcq)
+{
+	return container_of(ibcq, struct efa_cq, ibcq);
+}
+
+static inline struct efa_ah *to_eah(struct ib_ah *ibah)
+{
+	return container_of(ibah, struct efa_ah, ibah);
+}
+
 int efa_query_device(struct ib_device *ibdev,
 		     struct ib_device_attr *props,
 		     struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 9c3e476e3f9c..34a9f86af9bd 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -127,41 +127,6 @@ struct pbl_context {
 	u8 physically_continuous;
 };
 
-static inline struct efa_dev *to_edev(struct ib_device *ibdev)
-{
-	return container_of(ibdev, struct efa_dev, ibdev);
-}
-
-static inline struct efa_ucontext *to_eucontext(struct ib_ucontext *ibucontext)
-{
-	return container_of(ibucontext, struct efa_ucontext, ibucontext);
-}
-
-static inline struct efa_pd *to_epd(struct ib_pd *ibpd)
-{
-	return container_of(ibpd, struct efa_pd, ibpd);
-}
-
-static inline struct efa_mr *to_emr(struct ib_mr *ibmr)
-{
-	return container_of(ibmr, struct efa_mr, ibmr);
-}
-
-static inline struct efa_qp *to_eqp(struct ib_qp *ibqp)
-{
-	return container_of(ibqp, struct efa_qp, ibqp);
-}
-
-static inline struct efa_cq *to_ecq(struct ib_cq *ibcq)
-{
-	return container_of(ibcq, struct efa_cq, ibcq);
-}
-
-static inline struct efa_ah *to_eah(struct ib_ah *ibah)
-{
-	return container_of(ibah, struct efa_ah, ibah);
-}
-
 static inline struct efa_user_mmap_entry *
 to_emmap(struct rdma_user_mmap_entry *rdma_entry)
 {
-- 
2.40.1


