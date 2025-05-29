Return-Path: <linux-rdma+bounces-10894-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22736AC7A00
	for <lists+linux-rdma@lfdr.de>; Thu, 29 May 2025 09:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3BE916BDA6
	for <lists+linux-rdma@lfdr.de>; Thu, 29 May 2025 07:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBCF2192F3;
	Thu, 29 May 2025 07:59:07 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B9A215F48;
	Thu, 29 May 2025 07:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748505547; cv=none; b=Q/vzGfoMFpmS9uvwMgLG/bZqmdP10slAqUX/QICEzEsgl5cdPW2hXxNexe9MLgByTqgHj4mUv8W/o6oFeNqR/NgTjO/347LQzoO5F43KducDuyBj2ipBUQ3Ag7GxanWIYckkbHyx2TY21ColXR3oUXwWCqWv7sWmUTWrAeqmcxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748505547; c=relaxed/simple;
	bh=Wqy/FDsp5bWWI3oEfTRpmfQFG898Jzzy1TADAX/Wars=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=EyLm31wkIIxNpYP1luZJ7aHlG8vncMAHgca5drgUGL4Jo4NQpcs/lQY21a1PF+kV0imPRRu4VjXW6VqEq1jeqn5qfFaRgBwv/hoYKgNbrorAaCCdvvmZ/JNC1W9DixYgNq0uVNfWQqot6D55DZw0fTN+aYfUDvflyWixbI4SiGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c49cf0cc3c6211f0b29709d653e92f7d-20250529
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, UD_TRUSTED
	CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:3df438d5-7283-44c2-a233-e93b6b20ed43,IP:10,
	URL:0,TC:0,Content:-25,EDM:-30,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,A
	CTION:release,TS:-50
X-CID-INFO: VERSION:1.1.45,REQID:3df438d5-7283-44c2-a233-e93b6b20ed43,IP:10,UR
	L:0,TC:0,Content:-25,EDM:-30,RT:0,SF:-5,FILE:0,BULK:0,RULE:EDM_GN8D19FE,AC
	TION:release,TS:-50
X-CID-META: VersionHash:6493067,CLOUDID:bd503cf46284c5e6937e188a2f6aea97,BulkI
	D:250529155858ZTUX9W41,BulkQuantity:0,Recheck:0,SF:19|24|38|44|66|72|78|10
	2,TC:nil,Content:0|50,EDM:2,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-UUID: c49cf0cc3c6211f0b29709d653e92f7d-20250529
X-User: zhaochenguang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhaochenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1406889021; Thu, 29 May 2025 15:58:55 +0800
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
Subject: [PATCH net v2] net/mlx5: Flag state up only after cmdif is ready
Date: Thu, 29 May 2025 15:58:49 +0800
Message-Id: <20250529075849.243096-1-zhaochenguang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When driver is reloading during recovery flow, it can't get new commands
till command interface is up again. Otherwise we may get to null pointer
trying to access non initialized command structures.

The issue can be reproduced using the following script:

1)Use following script to trigger PCI error.

for((i=1;i<1000;i++));
do
echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/reset
echo “pci reset test $i times”
done

2) Use following script to read speed.

while true; do cat /sys/class/net/eth0/speed &> /dev/null; done

task: ffff885f42820fd0 ti: ffff88603f758000 task.ti: ffff88603f758000
RIP: 0010:[] [] dma_pool_alloc+0x1ab/0×290
RSP: 0018:ffff88603f75baf0 EFLAGS: 00010046
RAX: 0000000000000246 RBX: ffff882f77d90c80 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 00000000000080d0 RDI: ffff882f77d90d10
RBP: ffff88603f75bb20 R08: 0000000000019ba0 R09: ffff88017fc07c00
R10: ffffffffc0a9c384 R11: 0000000000000246 R12: ffff882f77d90d00
R13: 00000000000080d0 R14: ffff882f77d90d10 R15: ffff88340b6c5ea8
FS: 00007efce8330740(0000) GS:ffff885f4da00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000003454fc6000 CR4: 00000000003407e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call trace:
 mlx5_alloc_cmd_msg+0xb4/0×2a0 [mlx5_core]
 mlx5_alloc_cmd_msg+0xd3/0×2a0 [mlx5_core]
 cmd_exec+0xcf/0×8a0 [mlx5_core]
 mlx5_cmd_exec+0x33/0×50 [mlx5_core]
 mlx5_core_access_reg+0xf1/0×170 [mlx5_core]
 mlx5_query_port_ptys+0x64/0×70 [mlx5_core]
 mlx5e_get_link_ksettings+0x5c/0×360 [mlx5_core]
 __ethtool_get_link_ksettings+0xa6/0×210
 speed_show+0x78/0xb0
 dev_attr_show+0x23/0×60
 sysfs_read_file+0x99/0×190
 vfs_read+0x9f/0×170
 SyS_read+0x7f/0xe0
 tracesys+0xe3/0xe8

Fixes: a80d1b68c8b7a0 ("net/mlx5: Break load_one into three stages")
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
v2:
 - Add net subject prefix as Paolo suggested
 - Add Fixes tag
 - Add issus reproduction script and call trace

v1:
 https://lore.kernel.org/all/20250527013723.242599-1-zhaochenguang@kylinos.cn/
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


