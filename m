Return-Path: <linux-rdma+bounces-10402-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5F4ABB3AB
	for <lists+linux-rdma@lfdr.de>; Mon, 19 May 2025 05:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50791893052
	for <lists+linux-rdma@lfdr.de>; Mon, 19 May 2025 03:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0421C1E412A;
	Mon, 19 May 2025 03:41:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3119E1AA1D2;
	Mon, 19 May 2025 03:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747626087; cv=none; b=Z3dPTXrHY9fA4A7GMIe/3LQLs9obPW27QPRa2G6R5rsqmAUyc9muZIgcov0nyjGt+CN/vzUlN0UR36kgwc7tICHkZ8Txw7R23wgRAl9pJUSu6BqoNxvmq+Sf6OP8+WQnHUuKDOiRR05Eq/ss0ZfTkF7uThO2WrUoUBANNslbA+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747626087; c=relaxed/simple;
	bh=YLy0bIxUyBEJ4MsErB/HNh/nkpkd4n4QESqkZKSikzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QsbMbJNrUnFGe+JukLUwMPHmkD8smO5JEnjdr4NqbIneXSYBqr97surTokoczp8IHVmppeKptL1Xn8jMWjXEod9EkxxrNjxpbLEsECs4DuSIKlN9J7utz5cBPf6ERinBCembg7m5snEKCa1nwfm/g9W6h7SWHndDBhDe6Ppcy+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowABXw8JNqCpoWNs_AQ--.48942S2;
	Mon, 19 May 2025 11:41:03 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
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
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: mlx5: vport: Add error handling in mlx5_query_nic_vport_qkey_viol_cntr()
Date: Mon, 19 May 2025 11:40:43 +0800
Message-ID: <20250519034043.1247-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABXw8JNqCpoWNs_AQ--.48942S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4ruF45tFy7Aw48Ww47CFg_yoW8AF4DpF
	47tr93XrykJa40v3WjkFWrZrs5CrWku3W09a4xt34fXr4qyr4DAr45AF9FgrWUurW8trZa
	yr42y3ZxCF98C37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAUHA2gqdptmMwACs1

The function mlx5_query_nic_vport_qkey_viol_cntr() calls the functuion
mlx5_query_nic_vport_context() but does not check its return value. This
could lead to undefined behavior if the query fails. A proper
implementation can be found in mlx5_nic_vport_query_local_lb().

Add error handling for mlx5_query_nic_vport_context(). If it fails, free
the out buffer via kvfree() and return error code.

Fixes: 9efa75254593 ("net/mlx5_core: Introduce access functions to query vport RoCE fields")
Cc: stable@vger.kernel.org # v4.5
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/mellanox/mlx5/core/vport.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
index 0d5f750faa45..276b162ccf18 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
@@ -518,20 +518,23 @@ int mlx5_query_nic_vport_qkey_viol_cntr(struct mlx5_core_dev *mdev,
 					u16 *qkey_viol_cntr)
 {
 	u32 *out;
-	int outlen = MLX5_ST_SZ_BYTES(query_nic_vport_context_out);
+	int ret, outlen = MLX5_ST_SZ_BYTES(query_nic_vport_context_out);
 
 	out = kvzalloc(outlen, GFP_KERNEL);
 	if (!out)
 		return -ENOMEM;
 
-	mlx5_query_nic_vport_context(mdev, 0, out);
+	ret = mlx5_query_nic_vport_context(mdev, 0, out);
+	if (ret)
+		goto out;
 
 	*qkey_viol_cntr = MLX5_GET(query_nic_vport_context_out, out,
 				   nic_vport_context.qkey_violation_counter);
-
+	ret = 0;
+out:
 	kvfree(out);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mlx5_query_nic_vport_qkey_viol_cntr);
 
-- 
2.42.0.windows.2


