Return-Path: <linux-rdma+bounces-4806-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB72970108
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Sep 2024 10:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4891C21F58
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Sep 2024 08:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2BF14C5A7;
	Sat,  7 Sep 2024 08:52:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84AB42A96
	for <linux-rdma@vger.kernel.org>; Sat,  7 Sep 2024 08:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725699130; cv=none; b=LaEcFfYP06jAi13JmOaEMnwiMofOo8wAknUmeo9QjaV8sWYMoZl7lbrSyoHoewRAWWTYAf3JG07frcn4Iu0uCwzagy09ZN+PX1xyWoP9Y+1ckkDcxR1RsYLD02Xakc4yhFS8z9YsLpjDofN6NSu87fzMYj3xXK+vKPaZJ46UkVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725699130; c=relaxed/simple;
	bh=xcBuQB0Hbdv4WWggDI9Kz/I+K338/JTSeGCNtlBRGX8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gDEdTCsaOm3YzanNhWM87LThD8Y1325lnZBXeARiu4BkVp8QZ9cMzH5ii97S9dJ8b/qbXP6l1jr+lOXIFLFCB3s9ONHhgBjJ84LbpF+Tj7N9oE8kMKdT4JhkZ/Z2uD803vtgp9YoKmFicxgrBOwPaSOs0xCgeMrYA0eJre6AghU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4X16JQ6Cfkz1P80G;
	Sat,  7 Sep 2024 16:51:02 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 1A93214022D;
	Sat,  7 Sep 2024 16:52:04 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 7 Sep
 2024 16:52:03 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <sagi@grimberg.me>, <mgurtovoy@nvidia.com>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <linux-rdma@vger.kernel.org>,
	<dennis.dalessandro@cornelisnetworks.com>
CC: <chenjun102@huawei.com>, <zhangzekun11@huawei.com>
Subject: [PATCH 2/2] IB/qib: Remove unused declarations in header file
Date: Sat, 7 Sep 2024 16:38:22 +0800
Message-ID: <20240907083822.100942-3-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240907083822.100942-1-zhangzekun11@huawei.com>
References: <20240907083822.100942-1-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf500003.china.huawei.com (7.202.181.241)

The definition of qib_rc_rnr_retry() has been removed since
commit b4238e70579c ("IB/qib: Use new rdmavt timers"). Also, the definition
of mr_rcu_callback() has been remove since commit 7c2e11fe2dbe ("IB/qib:
Remove qp and mr functionality from qib"). So, let's remove the unused
declartions.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/infiniband/hw/qib/qib_verbs.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_verbs.h b/drivers/infiniband/hw/qib/qib_verbs.h
index 07548fac1d8e..408fe1ba74b9 100644
--- a/drivers/infiniband/hw/qib/qib_verbs.h
+++ b/drivers/infiniband/hw/qib/qib_verbs.h
@@ -303,8 +303,6 @@ int qib_check_send_wqe(struct rvt_qp *qp, struct rvt_swqe *wqe,
 
 struct ib_ah *qib_create_qp0_ah(struct qib_ibport *ibp, u16 dlid);
 
-void qib_rc_rnr_retry(unsigned long arg);
-
 void qib_rc_send_complete(struct rvt_qp *qp, struct ib_header *hdr);
 
 int qib_post_ud_send(struct rvt_qp *qp, const struct ib_send_wr *wr);
@@ -312,8 +310,6 @@ int qib_post_ud_send(struct rvt_qp *qp, const struct ib_send_wr *wr);
 void qib_ud_rcv(struct qib_ibport *ibp, struct ib_header *hdr,
 		int has_grh, void *data, u32 tlen, struct rvt_qp *qp);
 
-void mr_rcu_callback(struct rcu_head *list);
-
 void qib_migrate_qp(struct rvt_qp *qp);
 
 int qib_ruc_check_hdr(struct qib_ibport *ibp, struct ib_header *hdr,
-- 
2.17.1


