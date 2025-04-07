Return-Path: <linux-rdma+bounces-9171-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9215BA7D5DA
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 09:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686F717637D
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 07:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25E72356D6;
	Mon,  7 Apr 2025 07:21:59 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2643F22DF8C;
	Mon,  7 Apr 2025 07:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744010519; cv=none; b=tZ8DY7lVW0kLl11RWyAfMFTReleH7X97pNB93pp6vA0ws1iyGG3c46TBQDb1cExwICWx0Yc4j9u7lWJZXK07/ulcyHQ5D0Ii3CQZON5hTKelBWpGTWhxIw2kPKtb7/57rQa/yfPbnrG9tsST3Hm5+e9zY1cvuim3SiZGyxw/FWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744010519; c=relaxed/simple;
	bh=gwlbrJ4E+kM2LfDpPto20YwjkS8MNLC7fHkGVJptOIQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dur0eitt8nXMqTjgO8lFz/DqVNjhhkhkws37IvXv2Rl75r5ikSDk5AvHH1mRi4mSmTUULU2Rc+28hgb5jip5AX6FBhJsCBqDXxlpBzUxd8lqGS9H7Nde/so0FmzO8RGx875wQSxi4f8tXhuWeSIoI7BJqBJctrZHiDZ1Er93ISk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201606.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202504071520345929;
        Mon, 07 Apr 2025 15:20:34 +0800
Received: from locahost.localdomain.com (10.94.5.217) by
 jtjnmail201606.home.langchao.com (10.100.2.6) with Microsoft SMTP Server id
 15.1.2507.39; Mon, 7 Apr 2025 15:20:34 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <saeedm@nvidia.com>, <tariqt@nvidia.com>, <leon@kernel.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <lariel@nvidia.com>,
	<paulb@nvidia.com>, <maord@nvidia.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Charles Han <hanchunchao@inspur.com>
Subject: [PATCH V2] net/mlx5e: fix potential null dereference in mlx5e_tc_nic_create_miss_table
Date: Mon, 7 Apr 2025 15:20:31 +0800
Message-ID: <20250407072032.5232-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0e08292e-9280-4ef6-baf7-e9f642d33177@gmail.com>
References: <0e08292e-9280-4ef6-baf7-e9f642d33177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2025407152034ba30f3d455ddc3e2cb5a8f6e9b48885a
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
index 9ba99609999f..c2f23ac95c3d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -5216,6 +5216,10 @@ static int mlx5e_tc_nic_create_miss_table(struct mlx5e_priv *priv)
 	ft_attr.level = MLX5E_TC_MISS_LEVEL;
 	ft_attr.prio = 0;
 	ns = mlx5_get_flow_namespace(priv->mdev, MLX5_FLOW_NAMESPACE_KERNEL);
+	if (!ns) {
+		netdev_err(priv->mdev, "Failed to get flow namespace\n");
+		return -EOPNOTSUPP;
+	}
 
 	*ft = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
 	if (IS_ERR(*ft)) {
-- 
2.43.0


