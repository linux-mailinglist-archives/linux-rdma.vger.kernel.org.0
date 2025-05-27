Return-Path: <linux-rdma+bounces-10742-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F9DAC45F3
	for <lists+linux-rdma@lfdr.de>; Tue, 27 May 2025 03:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 313453B6328
	for <lists+linux-rdma@lfdr.de>; Tue, 27 May 2025 01:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C2413AA3E;
	Tue, 27 May 2025 01:37:40 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320AE2CA9;
	Tue, 27 May 2025 01:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748309860; cv=none; b=Ma14zwEETsRAe41HOuqekPIJMCbXlTF8/Up9jtr64Q0EXuI0Sd7CmbpftHjaPwvql71ZRfm6rO9WG6HvPA3a6q1Ho/zlxxoh884q2MEtbKI9aHZHxVy90YTJt5hryt1nx5SdjEWXff4DRHIWm3FfIYgXrkEk9VgnQHu0mY/KcTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748309860; c=relaxed/simple;
	bh=pbGrf70WuVs3YlkzIH2h7srYzjq+d+2zO5jywaGI35g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ggFQpxgwZ2cyu5qj/OkVVBu4Q/GerGcKvBYeK3T0c0sTO8jhdZcwbkFxiiKequg0FErp/3soR6Ju5bVf+OnljgWcuBBw4/RrPM1RxE/SHa0OTN9Ql6QV0B6bT/JEvX/95750vt+l2FWGbhCzYvQq+mq0ItkEF6nZySkXA6xXsF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 269f6fa83a9b11f0b29709d653e92f7d-20250527
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:b3edf028-c6c0-4aff-a5be-e49ceee0d7ed,IP:10,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:8,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-7
X-CID-INFO: VERSION:1.1.45,REQID:b3edf028-c6c0-4aff-a5be-e49ceee0d7ed,IP:10,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:8,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-7
X-CID-META: VersionHash:6493067,CLOUDID:b05fd3528457c1948b45fc94d07ca05a,BulkI
	D:250527093732DL80ZNKU,BulkQuantity:0,Recheck:0,SF:16|19|24|38|44|66|78|10
	2,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,B
	EC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_USA,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 269f6fa83a9b11f0b29709d653e92f7d-20250527
X-User: zhaochenguang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhaochenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1422044838; Tue, 27 May 2025 09:37:29 +0800
From: Chenguang Zhao <zhaochenguang@kylinos.cn>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH] net/mlx5: Flag state up only after cmdif is ready
Date: Tue, 27 May 2025 09:37:23 +0800
Message-Id: <20250527013723.242599-1-zhaochenguang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When driver is reloading during recovery flow, it can't get new commands
till command interface is up again. Otherwise we may get to null pointer
trying to access non initialized command structures.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 41e8660c819c..713f1f4f2b42 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1210,6 +1210,9 @@ static int mlx5_function_enable(struct mlx5_core_dev *dev, bool boot, u64 timeou
 	dev->caps.embedded_cpu = mlx5_read_embedded_cpu(dev);
 	mlx5_cmd_set_state(dev, MLX5_CMDIF_STATE_UP);
 
+	/* remove any previous indication of internal error */
+	dev->state = MLX5_DEVICE_STATE_UP;
+
 	err = mlx5_core_enable_hca(dev, 0);
 	if (err) {
 		mlx5_core_err(dev, "enable hca failed\n");
@@ -1602,8 +1605,6 @@ int mlx5_load_one_devl_locked(struct mlx5_core_dev *dev, bool recovery)
 		mlx5_core_warn(dev, "interface is up, NOP\n");
 		goto out;
 	}
-	/* remove any previous indication of internal error */
-	dev->state = MLX5_DEVICE_STATE_UP;
 
 	if (recovery)
 		timeout = mlx5_tout_ms(dev, FW_PRE_INIT_ON_RECOVERY_TIMEOUT);
-- 
2.25.1


