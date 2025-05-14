Return-Path: <linux-rdma+bounces-10338-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3560AB633F
	for <lists+linux-rdma@lfdr.de>; Wed, 14 May 2025 08:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2833E188FF54
	for <lists+linux-rdma@lfdr.de>; Wed, 14 May 2025 06:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244241FF1A0;
	Wed, 14 May 2025 06:36:52 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107BB13E41A;
	Wed, 14 May 2025 06:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747204612; cv=none; b=Cl4VjqhidngvPKydOSGSmnlr5Mhsnd0xxslta93jt47sx4CQBUjfZ604av+aoU8xz3x8xWSm1485pXrDyVFuGl5EX9DgkUgmfODT020pw5CSS9+OpO6bsOLizS+wRxQRsJojW4c9YgkYEfmmK/vHfyEzN0Loz23Dew63osHx8ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747204612; c=relaxed/simple;
	bh=bMIa2BRSwmnZjClnawiaVXyNgLiSDcTfbct3Hk8M4fs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UDEYHXLijHdXO1s/CxkrCCfDOCon88cP950RJfQlTbMu/6eeLdGQZoNJnmOGIPcfoBSDZZUehfH8LaVDXDQkkFjJGzS2RX0R4/Ciuhn26HijXgVejBhHZ84JiIEc8Rkyz7ktrkRDkeYyw3PszVluHCCGTFHprt5R2+PDfwDwB/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowAAn0DztOSRog2j1FA--.57022S2;
	Wed, 14 May 2025 14:36:30 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] net/mlx5: Use to_delayed_work()
Date: Wed, 14 May 2025 14:34:37 +0800
Message-Id: <20250514063437.2513810-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAn0DztOSRog2j1FA--.57022S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw1xJF4fZw4fGFyxAw1UKFg_yoWfurc_u3
	sIvryfuF1Ykrn3Kr43ur4fCayv9w4v9wsagFZYgFW5J3yDKr1UZ34kZ3srCryfWr15ZF9x
	GwsIya13C39rJjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8AwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUcjjkUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Use to_delayed_work() instead of open-coding it.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index e53dbdc0a7a1..b1aeea7c4a91 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -927,8 +927,7 @@ static void mlx5_cmd_comp_handler(struct mlx5_core_dev *dev, u64 vec, bool force
 
 static void cb_timeout_handler(struct work_struct *work)
 {
-	struct delayed_work *dwork = container_of(work, struct delayed_work,
-						  work);
+	struct delayed_work *dwork = to_delayed_work(work);
 	struct mlx5_cmd_work_ent *ent = container_of(dwork,
 						     struct mlx5_cmd_work_ent,
 						     cb_timeout_work);
-- 
2.25.1


