Return-Path: <linux-rdma+bounces-7427-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DD7A2881F
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 11:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFDEC1887E84
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 10:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DFA22B598;
	Wed,  5 Feb 2025 10:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kExXA1f1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD7C22A80B;
	Wed,  5 Feb 2025 10:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738751723; cv=none; b=Cbx5rBUCibsf9U/vSmPa2XyRUPoknM4EndZGNqS0G9xkLrfs+Ir+1Epsly8N0QWaj1q3Qc3Mrd3WMlgrDewl4k+HCP6r4h1ZhQFW2trjiG6vCiEZGxdabhtNBXTxUjkAsfLIxOGxCHYdeVid9BO3emFaplnboF5RSrOnGVNjeeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738751723; c=relaxed/simple;
	bh=Sho+agxWASg7IpR0l+ubU3+v0WDYiPyNp3M4L6etPeU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=C2yQUneYBahQKgour6Pc5G9+H75Rl8iFvidYXnLgJ9bAXwU1+a5Aufe6QJGvzdxjwjzdZsVaDsx2sJu2p2/5yNsSUqwdL7HcwVzaLJ9hfggYoLj59t3TbWVkVVGjZ//UVPEWdT4ucmAi8bPO92p+rYQst/EodgpqKoDGL9ANxQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kExXA1f1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 368BF203F58D;
	Wed,  5 Feb 2025 02:35:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 368BF203F58D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738751722;
	bh=77FhRdIDsL5g3ceMt06aQ2NDVZCKk8/I8o+IzUgf4hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kExXA1f1fxvjYP0RI31D2y5Sk/4FTgjzREWfOb3CoB6gv72EiJFUaRjQe0rjUini6
	 yPVNUGG3DLRSeH1kZLwsXoIf3TbRgUp2sQiVeaJXNfeD+97eFBe2OKdgUrt0vTrzuO
	 gnG2pdnGyA4hpIEohTrXAmrs75V0COlEn28g7WjU=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	shirazsaleem@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 2/2] RDMA/mana_ib: request error CQEs when supported
Date: Wed,  5 Feb 2025 02:35:13 -0800
Message-Id: <1738751713-16169-3-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738751713-16169-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1738751713-16169-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Request an adapter with error CQEs when it is supported.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/main.c    | 3 +++
 drivers/infiniband/hw/mana/mana_ib.h | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 3d4b8e2..e3230fe 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -794,6 +794,9 @@ int mana_ib_gd_create_rnic_adapter(struct mana_ib_dev *mdev)
 	req.hdr.dev_id = gc->mana_ib.dev_id;
 	req.notify_eq_id = mdev->fatal_err_eq->id;
 
+	if (mdev->adapter_caps.feature_flags & MANA_IB_FEATURE_CLIENT_ERROR_CQE_SUPPORT)
+		req.feature_flags |= MANA_IB_FEATURE_CLIENT_ERROR_CQE_REQUEST;
+
 	err = mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp);
 	if (err) {
 		ibdev_err(&mdev->ib_dev, "Failed to create RNIC adapter err %d", err);
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index baaeef0..ad716a9 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -211,6 +211,10 @@ struct mana_ib_query_adapter_caps_req {
 	struct gdma_req_hdr hdr;
 }; /*HW Data */
 
+enum mana_ib_adapter_features {
+	MANA_IB_FEATURE_CLIENT_ERROR_CQE_SUPPORT = BIT(4),
+};
+
 struct mana_ib_query_adapter_caps_resp {
 	struct gdma_resp_hdr hdr;
 	u32 max_sq_id;
@@ -234,6 +238,10 @@ struct mana_ib_query_adapter_caps_resp {
 	u64 feature_flags;
 }; /* HW Data */
 
+enum mana_ib_adapter_features_request {
+	MANA_IB_FEATURE_CLIENT_ERROR_CQE_REQUEST = BIT(1),
+}; /*HW Data */
+
 struct mana_rnic_create_adapter_req {
 	struct gdma_req_hdr hdr;
 	u32 notify_eq_id;
-- 
2.43.0


