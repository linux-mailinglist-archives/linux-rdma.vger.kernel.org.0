Return-Path: <linux-rdma+bounces-13356-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6410B57225
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 10:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61BE017DF3D
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 08:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A862EA17F;
	Mon, 15 Sep 2025 07:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hw5dHaey"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54122D3212;
	Mon, 15 Sep 2025 07:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923174; cv=none; b=iJllE5VSnR0LINtfnt8+SqIXn0mypu2m695T49NPsHj7RF+26twy8wWhJWawpSe91BBdu95e6soMAJv43Muyk+HR0zoEnSJXJLsC1rsaR/Zrs4z7jJWy9XvqqWYwEIwtUB5zh1yE7rn95blbjAfHMwBLDzoxk4JBchEkCWB2FxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923174; c=relaxed/simple;
	bh=9gujTLiqLHjjINMpkRbHhV8wQb6Epk5lqXdJd/pFwy8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=VXqjGhYqvMhkxpxE3F1XHKX7wYmdrMjN/MNrAwuQTrRJtax7tEkxFL/FeuaprwChwz9kgLV6ucEh6oo/enYDfeg3NAKdCL8QCh3Xh7iOdSu2fBLwmBbjzQ2FfwBCU0TDFupbnXcZYPpvhNuUG2Ped7hY8BNKnfqo8hgZhuMr4Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hw5dHaey; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id 4146B211AA26; Mon, 15 Sep 2025 00:59:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4146B211AA26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757923172;
	bh=Nz0oO5BYuVZk608Ctk/BPbO9/lnJ/evA3f086VgS9pI=;
	h=From:To:Cc:Subject:Date:From;
	b=hw5dHaeywF2B1awA8Dkp4mU3qjv1n+AZ0PK86ZDKN1CzOfnyGc/T/Y4qEMWtM5gr3
	 2afH7tV4tLbNikuZoxZfAevjhu9tdnO2IrBoW+U1TtwFItVDmTOSd3Cfeh6anTb2bU
	 DGenyyo8fhydFuO5XE8B+B3wd64CAo+xhSOhqzR0=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	shirazsaleem@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 1/1] RDMA/mana_ib: Extend modify QP
Date: Mon, 15 Sep 2025 00:59:32 -0700
Message-Id: <1757923172-4475-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Shiraz Saleem <shirazsaleem@microsoft.com>

Extend modify QP to support further attributes: local_ack_timeout, UD qkey,
rate_limit, qp_access_flags, flow_label, max_rd_atomic.

Signed-off-by: Shiraz Saleem <shirazsaleem@microsoft.com>
Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/mana_ib.h | 11 +++++++++--
 drivers/infiniband/hw/mana/qp.c      |  9 +++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index af09a3e6c..9d36232ed 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -412,7 +412,7 @@ struct mana_ib_ah_attr {
 	u8 traffic_class;
 	u16 src_port;
 	u16 dest_port;
-	u32 reserved;
+	u32 flow_label;
 };
 
 struct mana_rnic_set_qp_state_req {
@@ -429,8 +429,15 @@ struct mana_rnic_set_qp_state_req {
 	u32 retry_cnt;
 	u32 rnr_retry;
 	u32 min_rnr_timer;
-	u32 reserved;
+	u32 rate_limit;
 	struct mana_ib_ah_attr ah_attr;
+	u64 reserved1;
+	u32 qkey;
+	u32 qp_access_flags;
+	u8 local_ack_timeout;
+	u8 max_rd_atomic;
+	u16 reserved2;
+	u32 reserved3;
 }; /* HW Data */
 
 struct mana_rnic_set_qp_state_resp {
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index a6bf4d539..48c1f4977 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -735,6 +735,8 @@ static int mana_ib_gd_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	int err;
 
 	mana_gd_init_req_hdr(&req.hdr, MANA_IB_SET_QP_STATE, sizeof(req), sizeof(resp));
+
+	req.hdr.req.msg_version = GDMA_MESSAGE_V3;
 	req.hdr.dev_id = mdev->gdma_dev->dev_id;
 	req.adapter = mdev->adapter_handle;
 	req.qp_handle = qp->qp_handle;
@@ -748,6 +750,12 @@ static int mana_ib_gd_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	req.retry_cnt = attr->retry_cnt;
 	req.rnr_retry = attr->rnr_retry;
 	req.min_rnr_timer = attr->min_rnr_timer;
+	req.rate_limit = attr->rate_limit;
+	req.qkey = attr->qkey;
+	req.local_ack_timeout = attr->timeout;
+	req.qp_access_flags = attr->qp_access_flags;
+	req.max_rd_atomic = attr->max_rd_atomic;
+
 	if (attr_mask & IB_QP_AV) {
 		ndev = mana_ib_get_netdev(&mdev->ib_dev, ibqp->port);
 		if (!ndev) {
@@ -774,6 +782,7 @@ static int mana_ib_gd_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 							  ibqp->qp_num, attr->dest_qp_num);
 		req.ah_attr.traffic_class = attr->ah_attr.grh.traffic_class >> 2;
 		req.ah_attr.hop_limit = attr->ah_attr.grh.hop_limit;
+		req.ah_attr.flow_label = attr->ah_attr.grh.flow_label;
 	}
 
 	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
-- 
2.43.0


