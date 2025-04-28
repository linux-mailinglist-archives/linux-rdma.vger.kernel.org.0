Return-Path: <linux-rdma+bounces-9875-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175F3A9EF1B
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Apr 2025 13:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 281113A66D4
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Apr 2025 11:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6987C1E4929;
	Mon, 28 Apr 2025 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p17cloKm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282D61B0406
	for <linux-rdma@vger.kernel.org>; Mon, 28 Apr 2025 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745839828; cv=none; b=soisSvmEHNiCEAMJVfThHTzF3hVwk+O6PIGu3Cnef6VEILHMnxLdw2tGodtFpqke9lbYvds/iuyE7WcDNTQyupE6jm+NtDEtdZTe4jbZtJCWdNV03EH/WsA4aloRVTu2/Vgv3r2dfqat5PRPRkKE+g95XBpOOzAxfiM7VUxxaCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745839828; c=relaxed/simple;
	bh=xT7a2Eo+H9ozw+UKVu0BdeUKNSIzyB4O9QyxU/+KLWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kZ3HG2IAKkzp86ZmJPIHMfHI4wiwr3Ua7nsxmNrv9cERKhuh3AispV3madTKexmbQgqRFnvAqrssqQvh+u/gFVTAY1mr9E8KrfezwP0cbz09X+A4eqrjgmBoYxVxUnFRO65GA1o7o2BXOgW0ewxA9Q+FwaTSrz5Y+wbYxWCwJb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p17cloKm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E056EC4CEE9;
	Mon, 28 Apr 2025 11:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745839827;
	bh=xT7a2Eo+H9ozw+UKVu0BdeUKNSIzyB4O9QyxU/+KLWI=;
	h=From:To:Cc:Subject:Date:From;
	b=p17cloKm6BgD2SaoF1oLsWuwu+amj+t5SjsaN+G5MaZYwb4XJzd45K46tlkngiUPz
	 /qov5XUftq5mj4l+c69J4/OIPhYO2oeMOOdwwCF2dfLPpbPPvZi7GPf1ppxZITGN3v
	 fRw7kZkiR72Jg1Ga6SczE/7s5Bd8sWua6QSu4WhJrTk7mrXsWJ7FOs5ZrCwfUTicXj
	 8B8xj+uzJsRKGazuzXbz2FG6dmhYW9Qhk4O04AX8UqXSCjDtJne6t55ZotsVOTa9oF
	 J3b7k6XdL0sPSIVZYDIIeHqkioPVHRCGzx6yEfx5WyN7OALYdwRc3eUpRl/Jgc28GW
	 UfxAAdVWEto4g==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Or Har-Toov <ohartoov@nvidia.com>,
	Sean Hefty <shefty@nvidia.com>
Subject: [PATCH rdma-next] IB/cm: Drop lockdep assert and WARN when freeing old msg
Date: Mon, 28 Apr 2025 14:30:18 +0300
Message-ID: <0c364c29142f72b7875fdeba51f3c9bd6ca863ee.1745839788.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vlad Dumitrescu <vdumitrescu@nvidia.com>

The send completion handler can run after cm_id has advanced to another
message.  The cm_id lock is not needed in this case, but a recent change
re-used cm_free_priv_msg(), which asserts that the lock is held and
WARNs if the cm_id's currently outstanding msg is different than the one
being freed.

Fixes: 1e5159219076 ("IB/cm: Do not hold reference on cm_id unless needed")
Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Reviewed-by: Sean Hefty <shefty@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index effa53dd6800..e64cbd034a2a 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -3786,7 +3786,8 @@ static void cm_process_send_error(struct cm_id_private *cm_id_priv,
 	spin_lock_irq(&cm_id_priv->lock);
 	if (msg != cm_id_priv->msg) {
 		spin_unlock_irq(&cm_id_priv->lock);
-		cm_free_priv_msg(msg);
+		cm_free_msg(msg);
+		cm_deref_id(cm_id_priv);
 		return;
 	}
 	cm_free_priv_msg(msg);
-- 
2.49.0


