Return-Path: <linux-rdma+bounces-10410-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A126ABBC4E
	for <lists+linux-rdma@lfdr.de>; Mon, 19 May 2025 13:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B783018952D5
	for <lists+linux-rdma@lfdr.de>; Mon, 19 May 2025 11:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493A5274FD0;
	Mon, 19 May 2025 11:28:08 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70211A83E5;
	Mon, 19 May 2025 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747654088; cv=none; b=aS7c0WRi/L8GdLA1CcSnhnvo/vX7fGwXKfI8DuJuOUXSm4FGEUB2RE4/H5DucG+cAnvZIIWjkZlgEoMVNowToRRziCVKGrhxnyU/y9CP/HRGHsFTwAisVqsppQxI740+Qr1Txa3mKHdvD+2lUNtN8bsRgzZOsjG5W5HMROhoxzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747654088; c=relaxed/simple;
	bh=62KNHemGCt9ujb3bMOyHVR1nvMO7BmLJB6iPAcy/NhY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sfY3g1Pw3xYl7X5uNX4dVYAaYqxytxhdhwP3T9QbtY9sQNlmVVTyA/42+sO2r/9wwl014WJk6HiJ6WC3WsG264MhWr98F31JKLIajUsnftTA+YF6noe8x6+nK7cmUW9V5y808UY4u+VTKlLdHtMJKk5Pf+DjgKgUy+rNh8M5PNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201603.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202505191927496087;
        Mon, 19 May 2025 19:27:49 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201603.home.langchao.com (10.100.2.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 May 2025 19:27:50 +0800
Received: from locahost.localdomain.com (10.94.15.43) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 May 2025 19:27:49 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <saeedm@nvidia.com>, <tariqt@nvidia.com>, <leon@kernel.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <roid@nvidia.com>,
	<jianbol@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Charles Han
	<hanchunchao@inspur.com>
Subject: [PATCH] net/mlx5: Add NULL check in mlx5e_tc_nic_create_miss_table
Date: Mon, 19 May 2025 19:27:47 +0800
Message-ID: <20250519112747.12365-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201613.home.langchao.com (10.100.2.13) To
 jtjnmail201607.home.langchao.com (10.100.2.7)
tUid: 20255191927499150479c3056b2679b7066a59f5b35f2
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The mlx5e_tc_nic_create_miss_table() function did not check the
return value of mlx5_get_flow_namespace(). This could lead to
subsequent code using an invalid flow namespace pointer,
potentially causing crashes or undefined behavior.

Fixes: 794131c40850 ("net/mlx5: E-Switch, Return EBUSY if can't get mode lock")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index f1d908f61134..81f0db29a2bb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -5213,6 +5213,10 @@ static int mlx5e_tc_nic_create_miss_table(struct mlx5e_priv *priv)
 	ft_attr.level = MLX5E_TC_MISS_LEVEL;
 	ft_attr.prio = 0;
 	ns = mlx5_get_flow_namespace(priv->mdev, MLX5_FLOW_NAMESPACE_KERNEL);
+	if (!ns) {
+		mlx5_core_err(priv->mdev, "Failed to get flow namespace\n");
+		return -EOPNOTSUPP;
+	}
 
 	*ft = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
 	if (IS_ERR(*ft)) {
-- 
2.43.0


