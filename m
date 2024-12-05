Return-Path: <linux-rdma+bounces-6304-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FCA9E57D4
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 14:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4162E286752
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 13:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9082219A68;
	Thu,  5 Dec 2024 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaBuwbSM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DC0219A66
	for <linux-rdma@vger.kernel.org>; Thu,  5 Dec 2024 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733406652; cv=none; b=W/gtKnVWN8NmUxmUzAh+/wNN+fkaoR0z0ZW22WlNaB83XTfcBNVDsUDPrbneKrc1qeNL+LK0sodVpzVLtChTZk1Dfa5cVR9tVq3o7ql7pjRmKSivs+exZV9xrVU7u0sPEtrL2005pAY1iEjCIsUmlvd7dxieEHZ7wvPhLopN210=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733406652; c=relaxed/simple;
	bh=ZczzilvhBzoHP0XP8CgeNMTwOM2wl9FcSBFZzQ+Ojkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VfRwhprOjmWeTIWHpYzrtFRzc2fEofui3lSMkm4esO+hycG84S5zMfjYypFT0IiHoMEAEl2bveqWrHD0MhrV9DjYgTti5WTKXSWS7bRdgMxmj/J1K1Yly5J6kQDALH51pI1HgUusQ3g2euSp2cs0XY/JEkG+2xlh2uzuLZ8/Wls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaBuwbSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB55C4CED1;
	Thu,  5 Dec 2024 13:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733406652;
	bh=ZczzilvhBzoHP0XP8CgeNMTwOM2wl9FcSBFZzQ+Ojkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WaBuwbSMeLOkLdfwoKndGlyirzP54zUKOovTgUKMIfNEMBFLTY3O1W/ZsiKue/EQ8
	 +tIxH+QidzA1vdVcW676wb9CwSh8xHCYETu68BirvCsOxcj7e35qLzgJndvlQhKw3z
	 RGOkDD6psNlp03yAsQPWOllSwNXngpGPDP7GT9b6ItFKUIQwUG2gkMZL1Sl2i/2pQ4
	 H5HzzLUsKhjVOpg+rNmnyyo4pBUsHQiXgJwr4+Jhb0TZRaWX7rsVbk7GyPJ7eVk2NM
	 a237/pd0TJvCxoPqPEskWXm+Ym4qNVi74eDBNccUUXf91gxBBSE/XH0uXwzeQO3AOm
	 jGpTM+rm5qesQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Sean Hefty <shefty@nvidia.com>
Subject: [PATCH rdma-next 5/9] IB/umad: Set deadline when sending non-RMPP MADs
Date: Thu,  5 Dec 2024 15:49:35 +0200
Message-ID: <3ddefc7bd188b15b9f03aebf469630f30f62bea2.1733405453.git.leon@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733405453.git.leon@kernel.org>
References: <cover.1733405453.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vlad Dumitrescu <vdumitrescu@nvidia.com>

Change semantics of the UAPI struct ib_user_mad_hdr retries and
timeout_ms fields.  Given the current implementation, users likely
expect the total timeout to be (retries + 1) * timeout_ms.  Use that
as MAD deadline.

This allows changes to the MAD layer's internal retry algorithm, for
non-RMPP agents, without affecting the total timeout experienced by
userspace.

Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Reviewed-by: Sean Hefty <shefty@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/user_mad.c |  8 ++++++++
 include/uapi/rdma/ib_user_mad.h    | 12 ++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index fd67fc9fe85a..3da6c0295657 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -650,6 +650,14 @@ static ssize_t ib_umad_write(struct file *filp, const char __user *buf,
 		}
 	}
 
+	if (!ib_mad_kernel_rmpp_agent(agent) && packet->mad.hdr.timeout_ms) {
+		ret = ib_set_mad_deadline(packet->msg,
+					  (packet->mad.hdr.retries + 1) *
+						  packet->mad.hdr.timeout_ms);
+		if (ret)
+			goto err_send;
+	}
+
 	ret = ib_post_send_mad(packet->msg, NULL);
 	if (ret)
 		goto err_send;
diff --git a/include/uapi/rdma/ib_user_mad.h b/include/uapi/rdma/ib_user_mad.h
index 10b5f6a4c677..1e9c20a44e50 100644
--- a/include/uapi/rdma/ib_user_mad.h
+++ b/include/uapi/rdma/ib_user_mad.h
@@ -57,7 +57,11 @@
  *   received (transaction ID in data[] will be set to TID of original
  *   request) (ignored on send)
  * @timeout_ms - Milliseconds to wait for response (unset on receive)
- * @retries - Number of automatic retries to attempt
+ *   before issuing a retry
+ * @retries - Maximum number of automatic retries to attempt. Actual
+ *   number of retries could be less if (@retries + 1) * @timeout_ms
+ *   is exceeded. When the registration request sets @rmpp_version,
+ *   it applies per RMPP window
  * @qpn - Remote QP number received from/to be sent to
  * @qkey - Remote Q_Key to be sent with (unset on receive)
  * @lid - Remote lid received from/to be sent to
@@ -100,7 +104,11 @@ struct ib_user_mad_hdr_old {
  *   received (transaction ID in data[] will be set to TID of original
  *   request) (ignored on send)
  * @timeout_ms - Milliseconds to wait for response (unset on receive)
- * @retries - Number of automatic retries to attempt
+ *   before issuing a retry
+ * @retries - Maximum number of automatic retries to attempt. Actual
+ *   number of retries could be less if (@retries + 1) * @timeout_ms
+ *   is exceeded. When the registration request sets @rmpp_version,
+ *   it applies per RMPP window
  * @qpn - Remote QP number received from/to be sent to
  * @qkey - Remote Q_Key to be sent with (unset on receive)
  * @lid - Remote lid received from/to be sent to
-- 
2.47.0


