Return-Path: <linux-rdma+bounces-3288-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB1E90E218
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 05:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1E311C20EBF
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 03:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E034B5A6;
	Wed, 19 Jun 2024 03:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="etw4oHKS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A54A2139D3;
	Wed, 19 Jun 2024 03:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718769258; cv=none; b=fbjfZNv4eGtvEjgiXwtydtVJZ2LKBU8KzOt2lHZ6YmBetEqJL/Wv7vBLL6/zAg9LonAntpFrW8e9jSyoxzpB1laU4ViV+5bES6tfku3hiV1r4bRdxuywtB00d9X9CawUJCqi6V43dv84B11Bo2HgJfuL8aFmHw0CcVrII88HP+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718769258; c=relaxed/simple;
	bh=/oSabxE/ch5IEDlTL+1hrIBJeZ/HOsHpZKFA4WnW2sU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cP/ge5v4B5NkgBBqfSYZ7S+cyDWBgHKo8Ei+lg4O7GPKXbxL0gav2Ei1MAlgR2gj2/lUt115VoTuFhnTCLlzaXv/rdxvfq0vR/ezhzZgv2DMaaXqTqy/kVjWMYDV66d7Lv6Glk9JCkGKqFqDXp7BB3qMSetiZ2QAyxT1n45HYgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=etw4oHKS; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718769247; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=zpCVvcHtd67Za3x/M3or94oTHaNa/owvso3OqIt3FBw=;
	b=etw4oHKSIcxwVQV7wFoArE1EP0RDeHFTI9uOh05QPMVmZQbneUyayi6I03vwYgH3QGkGO84RD3Z1ZKgvSedWZXLqqNoUM+MOkJc3tlWwtZv+LXhj+PO9i1fp11Ox/cxZ7w+LpzBlscGY/mA3bYv2/8F7P+vED7/ZDqcC4xzHOAk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W8mhgUN_1718769237;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W8mhgUN_1718769237)
          by smtp.aliyun-inc.com;
          Wed, 19 Jun 2024 11:54:07 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: saeedm@nvidia.com
Cc: leon@kernel.org,
	tariqt@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] net/mlx5: Lag, Remove NULL check before dev_{put, hold}
Date: Wed, 19 Jun 2024 11:53:57 +0800
Message-Id: <20240619035357.45567-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The call netdev_{put, hold} of dev_{put, hold} will check NULL, so there
is no need to check before using dev_{put, hold}, remove it to silence
the warning:

./drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c:1518:2-10: WARNING: NULL check before dev_{put, hold} functions is not needed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9361
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index d0871c46b8c5..a2fd9a84f877 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -1514,8 +1514,7 @@ struct net_device *mlx5_lag_get_roce_netdev(struct mlx5_core_dev *dev)
 	} else {
 		ndev = ldev->pf[MLX5_LAG_P1].netdev;
 	}
-	if (ndev)
-		dev_hold(ndev);
+	dev_hold(ndev);
 
 unlock:
 	spin_unlock_irqrestore(&lag_lock, flags);
-- 
2.20.1.7.g153144c


