Return-Path: <linux-rdma+bounces-15388-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C956D081B4
	for <lists+linux-rdma@lfdr.de>; Fri, 09 Jan 2026 10:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03E30307A543
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jan 2026 09:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71E33321B3;
	Fri,  9 Jan 2026 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NEz8xk+a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D062D358D3C;
	Fri,  9 Jan 2026 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949666; cv=none; b=k29LKCB7cb2cz43wAksL9sA/905zdzkTHfBedklliPnwJrguPt0AEPwTY/Bs1aso/Fu3x+kJSRQ6cuNMIC8jSQ0LUQzb/CWcXYyLVFkeeNCiEvi/rOLAucpwt5Rm8JuR/foMQeRiZVAIyuu14ZGPHX5/aXkaAtI5kjgs+C2JLeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949666; c=relaxed/simple;
	bh=3hwaGAcFcggIgpihes8MMjjJIldk8j4e67WpwcS7sYE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OA0+wKBbtWLOGVS5S/KxIqn3pN+aVGH+/lGyM0K0WIzycF8OwkHSWuaO4i4GWcrAFdu2GwJ+dnQn36FEj6AKRnmXsx4gXLDJywLWa6rIulBDLAzGdy1SmzG2F3J40Jg0Ynd5tRH4KuYm9gVn+LdJ9xs0a+BbUb7MEQCg4ZgXzao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NEz8xk+a; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=9U
	mGaF8kB2z7vJpTD1/CORh1KAvWfraUhIxE9qUDlWM=; b=NEz8xk+aRn+bkboOMJ
	iR7EfXiHiymGwlGqL3PeAvYnBls2I2g9bDqGYNhTKq10Ab4PxDAtowZjUCRBz9Kl
	hPRXdoalvsBT1Pio4dPZ11l0j6q7BkLmh7HT1HbI94Wr5SRz4uE7Fr8rzIf0vxyo
	qOep4QLK1sJiEbwACi+a5sG4w=
Received: from zengchi (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBXuCMsxWBpFG8wKw--.19983S2;
	Fri, 09 Jan 2026 17:06:54 +0800 (CST)
From: Zeng Chi <zeng_chi911@163.com>
To: saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zengchi@kylinos.cn
Subject: [PATCH] net/mlx5: Fix return type mismatch in mlx5_esw_vport_vhca_id()
Date: Fri,  9 Jan 2026 17:06:50 +0800
Message-Id: <20260109090650.1734268-1-zeng_chi911@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgBXuCMsxWBpFG8wKw--.19983S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr1xAw48CFWDZrWUCr1fCrg_yoWkCrbEg3
	WUXF43Xw4q9Fn8Kr1rWrWYgrWI9r1DWFZ3CFZ2vFZ8Jw4q9w1DJ3y8Z3WfAryxWr18XFyD
	Ga12vayav34jvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8jsj5UUUUU==
X-CM-SenderInfo: 52hqws5fklmiqr6rljoofrz/xtbCwA7uqmlgxS4z4AAA37

From: Zeng Chi <zengchi@kylinos.cn>

The function mlx5_esw_vport_vhca_id() is declared to return bool,
but returns -EOPNOTSUPP (-45), which is an int error code. This
causes a signedness bug as reported by smatch.

This patch fixes this smatch report:
drivers/net/ethernet/mellanox/mlx5/core/eswitch.h:981 mlx5_esw_vport_vhca_id()
warn: signedness bug returning '(-45)'

Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index ad1073f7b79f..e7fe43799b23 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -1009,7 +1009,7 @@ mlx5_esw_host_functions_enabled(const struct mlx5_core_dev *dev)
 static inline bool
 mlx5_esw_vport_vhca_id(struct mlx5_eswitch *esw, u16 vportn, u16 *vhca_id)
 {
-	return -EOPNOTSUPP;
+	return false;
 }
 
 #endif /* CONFIG_MLX5_ESWITCH */
-- 
2.25.1


