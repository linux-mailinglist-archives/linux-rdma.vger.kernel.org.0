Return-Path: <linux-rdma+bounces-9113-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D143AA78B1E
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 11:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D60E18934C6
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Apr 2025 09:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A145E2356A6;
	Wed,  2 Apr 2025 09:32:43 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B47720DD4B;
	Wed,  2 Apr 2025 09:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743586363; cv=none; b=A3uPQbhZG7tNyVZIjhACS2CpEdFmdJCm8BoUNgzVFprQq4wFWkZYFfJHWSbj4Mn09jgAvLXLC+0igyfGRcHsROT1RCvecN6dZCizAMeQO/lq4v3Otk8G5vzFw2olsuSw7jyb5Y1TK4bSMV4JlIXxRRwFaUzr13FStONa8zWlfZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743586363; c=relaxed/simple;
	bh=2PAdBlm2iE+helgRQkij09k015rNc1HojNJjuskui2U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XW3TZZdS97OGJK8j5KJo6yvQMoKd9tFit/c67wBAMnK3M3HcAoFEdaenafjXyEKIvZ0eyumPkCFu7IoA3ZdgyNZxDpXr02KcbWDfiwX9DMikKSevae+6P5Ie/Gx3P2ZK1CxoOjiVmQJMnqDkhEbdGJXuiM8vKfi3fI8RttryIdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201616.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202504021732240994;
        Wed, 02 Apr 2025 17:32:24 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 Jtjnmail201616.home.langchao.com (10.100.2.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Apr 2025 17:32:24 +0800
Received: from locahost.localdomain.com (10.94.17.92) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server id
 15.1.2507.39; Wed, 2 Apr 2025 17:32:23 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <saeedm@nvidia.com>, <tariqt@nvidia.com>, <leon@kernel.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <maord@nvidia.com>,
	<lariel@nvidia.com>, <paulb@nvidia.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Charles Han <hanchunchao@inspur.com>
Subject: [PATCH] net/mlx5e: fix potential null dereference in mlx5e_tc_nic_create_miss_table
Date: Wed, 2 Apr 2025 17:32:20 +0800
Message-ID: <20250402093221.3253-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2025402173224611767681e19845ec8a9450d9d607af6
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

mlx5_get_flow_namespace() may return a NULL pointer, dereferencing it
without NULL check may lead to NULL dereference.
Add a NULL check for ns.

Fixes: 66cb64e292d2 ("net/mlx5e: TC NIC mode, fix tc chains miss table")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 9ba99609999f..9c524d8c0e5a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -5216,6 +5216,10 @@ static int mlx5e_tc_nic_create_miss_table(struct mlx5e_priv *priv)
 	ft_attr.level = MLX5E_TC_MISS_LEVEL;
 	ft_attr.prio = 0;
 	ns = mlx5_get_flow_namespace(priv->mdev, MLX5_FLOW_NAMESPACE_KERNEL);
+	if (!ns) {
+		mlx5_core_warn(priv->mdev, "Failed to get flow namespace\n");
+		return -EOPNOTSUPP;
+	}
 
 	*ft = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
 	if (IS_ERR(*ft)) {
-- 
2.43.0


