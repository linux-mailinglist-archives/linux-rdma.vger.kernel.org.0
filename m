Return-Path: <linux-rdma+bounces-7805-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCE4A39804
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2025 11:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19AE8188F77D
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2025 10:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15EC235346;
	Tue, 18 Feb 2025 10:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gDiw9n9w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1289F145B25;
	Tue, 18 Feb 2025 10:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872946; cv=none; b=UTH16CQVh6GPBxPs1MtX8EgbYy2+VRh+hV1V/JErReelC5KiVv1xp/7eqFY7U0Fv1Cr5TD6pGE9h89amVA/i8dFuXzyqTwDyjROmN2YfwWE3adTVD85Nm1e7lxAZBq2rxiDTkJBDHjZgFkkScqAkASC9Fpkv83hGlcWKEPyndmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872946; c=relaxed/simple;
	bh=bfhjun/v6GFqKm1VtRNA5xQh70UXRMMenJZlmNZM/Jw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i+t4UJ1T/nV+VggKbSD2M4+HR95kc988ZdtD2YMtl699NMwscEWGaXZtMLGa9jw9rjdlwuAOuGfasJlM/9Nphipw2y3NVL2U26bY1n+HIH5soQTxZr8Oh2FMmpoKzWF9lU1EHnzDtJZjjWTDCKyzR4+XxjlYUhRPrEqFM9uYxSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gDiw9n9w; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=2Mc8P
	u/rsOzC1vIK6g9KcWVd9sEQmmUj0kVoTaT0yOg=; b=gDiw9n9wC46awWYx9WiP4
	XUkHGcbeGsNyVhje00WKmsQc7wnxjzJzB1tkOGuuM3ndbOZYJm0ATZr5F3RmGqOO
	S+HGplw6fWGVyD+Kk39PRabKlFOIdhjcJVkT9mpOQUsRnlJHhKpIM+UaIBBswZkQ
	P8XNd6Kfffsg4MIYUYbF2Y=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wC3SPmaWrRnJxflMQ--.26424S4;
	Tue, 18 Feb 2025 18:02:04 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: leon@kernel.org,
	jgg@ziepe.ca,
	sd@queasysnail.net,
	phaddad@nvidia.com
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] mlx5: Add check for get_macsec_device()
Date: Tue, 18 Feb 2025 18:02:00 +0800
Message-Id: <20250218100200.2535141-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3SPmaWrRnJxflMQ--.26424S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw4UuryfGry8ArWkCry3Arb_yoWkCrgEgF
	48Zr97ZwnYkFsYkF1a9r1fWryFkw4qgw12qFZrtF97Z347XF1DXrW0qFsagr4UXry3ury5
	Gw13Cw1rJry3GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRN9a9UUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/1tbiqBf3bme0WpEBEwAAss

Add check for the return value of get_macsec_device() in
mlx5r_del_gid_macsec_operations() to prevent null pointer
dereference.

Fixes: 58dbd6428a68 ("RDMA/mlx5: Handles RoCE MACsec steering rules addition and deletion")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/infiniband/hw/mlx5/macsec.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/macsec.c b/drivers/infiniband/hw/mlx5/macsec.c
index 3c56eb5eddf3..623b0a58f721 100644
--- a/drivers/infiniband/hw/mlx5/macsec.c
+++ b/drivers/infiniband/hw/mlx5/macsec.c
@@ -354,6 +354,11 @@ void mlx5r_del_gid_macsec_operations(const struct ib_gid_attr *attr)
 		}
 	}
 	macsec_device = get_macsec_device(ndev, &dev->macsec.macsec_devices_list);
+	if (!macsec_device) {
+		dev_put(ndev);
+		mutex_unlock(&dev->macsec.lock);
+		return;
+	}
 	mlx5_macsec_del_roce_rule(attr->index, dev->mdev->macsec_fs,
 				  &macsec_device->tx_rules_list, &macsec_device->rx_rules_list);
 	mlx5_macsec_del_roce_gid(macsec_device, attr->index);
-- 
2.25.1


