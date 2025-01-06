Return-Path: <linux-rdma+bounces-6828-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D09A0218C
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 10:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C72A3A2BF4
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 09:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1111D7E4B;
	Mon,  6 Jan 2025 09:14:44 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6608C73451;
	Mon,  6 Jan 2025 09:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736154884; cv=none; b=JXzkwzN8pMe1PJxPl6QflOjakrb4ainEN7es5rXZKwDvLTQ53rCoobOcgJSBA0sfp4snOBUI9SOHQuAUHHeK8u3ODB0hF8dvs6ZbtWiG1CyqN2Sir9BdQggNjMl9AE1rb1zVmi0ufcifLvZ89dU5xRrOdNeigydSN3bWtW7g8PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736154884; c=relaxed/simple;
	bh=2h85PlXOibt5ZYISHaWad7JB7lZUNHsMN+lZ2aFAPXo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pVVEXDrRpkt9bdyWkaVKXx7CpRRSx3DZvpGHz6Ne3qiLxpSHVwAAz+WytmKJpGxllU/GnCSwnzRuGjuUsPEqKtArT3DmGGtfhmeJoI9EOkvDthNvbtZJuMh1YGbV+e6O8BDDsCqcvyt+3ijV0PKsSCJA9jJz/2N/F/U4pfpJZm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a504dd70cc0e11efa216b1d71e6e1362-20250106
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:c611a422-6b4d-411c-b4eb-caccfa52d457,IP:10,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-24
X-CID-INFO: VERSION:1.1.45,REQID:c611a422-6b4d-411c-b4eb-caccfa52d457,IP:10,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-24
X-CID-META: VersionHash:6493067,CLOUDID:8742086dd31c12bd01e96ec0e303e1df,BulkI
	D:250106171434K6ZSZBQC,BulkQuantity:0,Recheck:0,SF:17|19|24|38|43|66|74|78
	|102,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: a504dd70cc0e11efa216b1d71e6e1362-20250106
X-User: zhaochenguang@kylinos.cn
Received: from localhost.localdomain [(223.70.160.239)] by mailgw.kylinos.cn
	(envelope-from <zhaochenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1492161839; Mon, 06 Jan 2025 17:14:34 +0800
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
Subject: [PATCH] net/mlx5: Fix variable not being completed when function returns
Date: Mon,  6 Jan 2025 17:14:26 +0800
Message-Id: <20250106091426.256243-1-zhaochenguang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

    The cmd_work_handler function returns from the child function
    cmd_alloc_index because the allocate command entry fails,
    Before returning, there is no complete ent->slotted.

    The patch fixes it.

	Trace:

     mlx5_core 0000:01:00.0: cmd_work_handler:877:(pid 3880418): failed to
	  allocate command entry
     INFO: task kworker/13:2:4055883 blocked for more than 120 seconds.
           Not tainted 4.19.90-25.44.v2101.ky10.aarch64 #1
     "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
	  this message.
     kworker/13:2    D    0 4055883      2 0x00000228
     Workqueue: events mlx5e_tx_dim_work [mlx5_core]
     Call trace:
      __switch_to+0xe8/0x150
      __schedule+0x2a8/0x9b8
      schedule+0x2c/0x88
      schedule_timeout+0x204/0x478
      wait_for_common+0x154/0x250
      wait_for_completion+0x28/0x38
      cmd_exec+0x7a0/0xa00 [mlx5_core]
      mlx5_cmd_exec+0x54/0x80 [mlx5_core]
      mlx5_core_modify_cq+0x6c/0x80 [mlx5_core]
      mlx5_core_modify_cq_moderation+0xa0/0xb8 [mlx5_core]
      mlx5e_tx_dim_work+0x54/0x68 [mlx5_core]
      process_one_work+0x1b0/0x448
      worker_thread+0x54/0x468
      kthread+0x134/0x138
      ret_from_fork+0x10/0x18

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index 6bd8a18e3af3..e733b81e18a2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -1013,6 +1013,7 @@ static void cmd_work_handler(struct work_struct *work)
 				complete(&ent->done);
 			}
 			up(&cmd->vars.sem);
+			complete(&ent->slotted);
 			return;
 		}
 	} else {
-- 
2.25.1


