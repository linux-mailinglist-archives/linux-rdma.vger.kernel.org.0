Return-Path: <linux-rdma+bounces-6948-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F18A085BF
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2025 04:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F5AE7A432E
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2025 03:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990281E2607;
	Fri, 10 Jan 2025 03:02:50 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3306EB7D;
	Fri, 10 Jan 2025 03:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736478170; cv=none; b=eRYfDIFs9FiFexKo66+RmBQsYACGsnKXmhBEA1mBT1uOySj2mERn1H5H+RUZXOUp+ifr7aCxTM8dkP47OeP1VVUz8mBeyMS+WUVG3aMQGfVvQLXTXEgPZngjdoRfSBfTzXSq4dRk8ssokxRs6hcHpcpnIQOCLTcXzGD7VnifmBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736478170; c=relaxed/simple;
	bh=PoFZwUfzeCBansC+x8d2kOiuptlO4+C2rFRtly7gdSA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LYEvsN0jTbsM/ojZquybIuE4UMIjlMNR/qZYQXpLnUB6dgPDDLLOCWWwIo4TulyxMIc+nyXLt9lXF7bpSjYfZ+aI2qr0yXylQ9iP3UgGDqj5cMnRBtpTRuyOVJwMjrZP/egvOdq++XzHUDU/kJyQY7zdI4F4cSaFfEfnQuSLf8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5b7fa2c2ceff11efa216b1d71e6e1362-20250110
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
X-CID-O-INFO: VERSION:1.1.45,REQID:66896c9c-a050-4cea-9298-ef86ab9943c2,IP:10,
	URL:0,TC:0,Content:-5,EDM:-30,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-34
X-CID-INFO: VERSION:1.1.45,REQID:66896c9c-a050-4cea-9298-ef86ab9943c2,IP:10,UR
	L:0,TC:0,Content:-5,EDM:-30,RT:0,SF:-9,FILE:0,BULK:0,RULE:EDM_GN8D19FE,ACT
	ION:release,TS:-34
X-CID-META: VersionHash:6493067,CLOUDID:d536a11d8951e4a174428055e8f5ba22,BulkI
	D:250110110243EAKVXNKI,BulkQuantity:0,Recheck:0,SF:17|19|24|38|45|66|78|10
	2,TC:nil,Content:0|50,EDM:2,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 5b7fa2c2ceff11efa216b1d71e6e1362-20250110
X-User: zhaochenguang@kylinos.cn
Received: from localhost.localdomain [(223.70.160.239)] by mailgw.kylinos.cn
	(envelope-from <zhaochenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 238798041; Fri, 10 Jan 2025 11:02:41 +0800
From: Chenguang Zhao <zhaochenguang@kylinos.cn>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Moshe Shemesh <moshe@nvidia.com>
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH v3] net/mlx5: Fix variable not being completed when function returns
Date: Fri, 10 Jan 2025 11:02:35 +0800
Message-Id: <20250110030235.963644-1-zhaochenguang@kylinos.cn>
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

mlx5_core 0000:01:00.0: cmd_work_handler:877:(pid 3880418): failed to allocate command entry
INFO: task kworker/13:2:4055883 blocked for more than 120 seconds.
      Not tainted 4.19.90-25.44.v2101.ky10.aarch64 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
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

Fixes: 485d65e13571 ("net/mlx5: Add a timeout to acquire the command queue semaphore")

Signed-off-by: Chenguang Zhao zhaochenguang@kylinos.cn
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Acked-by: Tariq Toukan <tariqt@nvidia.com>
---
v3:
 - Delete commit messsage indentation
 - add Acked-by tag
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


