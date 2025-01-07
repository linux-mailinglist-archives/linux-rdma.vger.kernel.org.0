Return-Path: <linux-rdma+bounces-6875-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13770A03B7A
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 10:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F354E165B53
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 09:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BF81E4113;
	Tue,  7 Jan 2025 09:47:58 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from stargate.chelsio.com (stargate.chelsio.com [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A9E1E3DE5
	for <linux-rdma@vger.kernel.org>; Tue,  7 Jan 2025 09:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736243278; cv=none; b=EUKqV1sxrjydmTsC6DlgD0j1vqfijXfeaqq5+DfqJg11XKK4KJSIejgEjOiVeUAxtOFsRYADaDMzvjxFPp8wuEKs60XzmrHaYWUiUC2EB+OIyb8t4Tgrn9Z4ktlpAirV4+l+28Ua+I+n7pFyT3jyUSLQXGl7GyP6Bilga48ejRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736243278; c=relaxed/simple;
	bh=mNm4MUiVoC6M1Wk/+e7+RC4/uAGG7Zn6tLTZFe46hxA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mXu+OTVVHuR7FSVS5Dx6Uv5kW0PY7yksvmCHRqthBr+ak5u2r4oQ7Q1KGH+z0QQhJvd6I3g+SvLWlr8o8PCn5TWBnTeQ7mm49dyG9LK57DtmreTSEOLWGUPxHUI4UOER98gyq12RdjcNywNglfHPZjRhlTDJoAn+Vk9sXxY4YhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from beagle5.blr.asicdesigners.com (beagle5.blr.asicdesigners.com [10.193.80.119])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 5079lfm2008941;
	Tue, 7 Jan 2025 01:47:42 -0800
From: Anumula Murali Mohan Reddy <anumula@chelsio.com>
To: jgg@nvidia.com, leonro@nvidia.com
Cc: linux-rdma@vger.kernel.org, bharat@chelsio.com,
        Anumula Murali Mohan Reddy <anumula@chelsio.com>
Subject: [PATCH for-rc v2] RDMA/cxgb4: notify rdma stack for IB_EVENT_QP_LAST_WQE_REACHED event
Date: Tue,  7 Jan 2025 15:20:53 +0530
Message-Id: <20250107095053.81007-1-anumula@chelsio.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch sends IB_EVENT_QP_LAST_WQE_REACHED event on a QP that is in
error state and associated with an SRQ. This behaviour is incorporated
in flush_qp() which is called when QP transitions to error state.
Supports SRQ drain functionality added by commit 844bc12e6da3 ("IB/core:
add support for draining Shared receive queues")

Fixes: 844bc12e6da3 ("IB/core: add support for draining Shared receive queues")
Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
Changes since v1:
Addressed previous review comments
---
 drivers/infiniband/hw/cxgb4/qp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
index 7b5c4522b426..10f61bc16dd5 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -1599,6 +1599,7 @@ static void __flush_qp(struct c4iw_qp *qhp, struct c4iw_cq *rchp,
 	int count;
 	int rq_flushed = 0, sq_flushed;
 	unsigned long flag;
+	struct ib_event ev;
 
 	pr_debug("qhp %p rchp %p schp %p\n", qhp, rchp, schp);
 
@@ -1607,6 +1608,14 @@ static void __flush_qp(struct c4iw_qp *qhp, struct c4iw_cq *rchp,
 	if (schp != rchp)
 		spin_lock(&schp->lock);
 	spin_lock(&qhp->lock);
+	if (qhp->srq) {
+		if (qhp->attr.state == C4IW_QP_STATE_ERROR && qhp->ibqp.event_handler) {
+			ev.device = qhp->ibqp.device;
+			ev.element.qp = &qhp->ibqp;
+			ev.event = IB_EVENT_QP_LAST_WQE_REACHED;
+			qhp->ibqp.event_handler(&ev, qhp->ibqp.qp_context);
+		}
+	}
 
 	if (qhp->wq.flushed) {
 		spin_unlock(&qhp->lock);
-- 
2.39.3


