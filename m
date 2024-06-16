Return-Path: <linux-rdma+bounces-3174-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505FC909E5F
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 18:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003432817C7
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 16:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95551AAA5;
	Sun, 16 Jun 2024 16:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpd0M4s/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777EC2940D;
	Sun, 16 Jun 2024 16:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718554152; cv=none; b=KkTHZQbKTc6h3Nsf0cBjJAiAK4Ni504GkPz4CSxp7l8H1XGUaoGzqDjZhULrwrfMBLXLgYpzOPqVm4cKZPxCm4GDGzf48/0kJPK9EHOar/ox+QfIZ1uLZ6pW7TN9ivAl326uuFgkfutozY+A7UmyyJpmG8A5I3pMud8mebiEsMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718554152; c=relaxed/simple;
	bh=jXM2KKpup27xvv8O8vK+fV5Vuwb0lMP9UtlGndw9roc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izFDFFgnLAelT+zOjLVgRQykpSo2ADXz9qtKzF/OLe55iAgvJeLhj8mZSoiMC3S1pPVko1xYt8GATtyV99YAfoy/fpsp4Dczg2FIyipwWrB56Gree+ORZCB0/ES11I7cVwI7IUUKvKpplpSQMGZ8DlSk4qfdJ2qE/EDpqqDYFs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpd0M4s/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77341C2BBFC;
	Sun, 16 Jun 2024 16:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718554152;
	bh=jXM2KKpup27xvv8O8vK+fV5Vuwb0lMP9UtlGndw9roc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kpd0M4s/Wd/MJyvKcr/944JCWKvMLZ1lfpVtCN182ZZtCtbzenK/aRW/qGMvJ5HzS
	 IppdiHBoEzBgesbtM3tuYYW7MhYLKgFGVJHLqy7f8MH89ZjVZs0jjJqBX4aUkUOyxo
	 nMXL/k86NnTvhhwi1u3fVp2U0xW/KG0mrR/9O694zmPKHWoFM9iAKmj1fGcnkx6j0B
	 t64X+0k7MTTuFk0UhpDgZJmDTZDzY+lbXU8Y0CJGFhvAUfcMSaa1bv1u4I2FI4o39J
	 OIFMF4lswshIFRJY062hUBxknSStBAdgNMWDF/bb61DLSARnGc3ve/6P3tbICIdLfj
	 Uvtphsz36RSOg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Zhang <markzhang@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH rdma-next 06/12] RDMA/core: Create GSI QP only when CM is supported
Date: Sun, 16 Jun 2024 19:08:38 +0300
Message-ID: <c449ebd955923b0e54c58832fd322f9d461b37a0.1718553901.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718553901.git.leon@kernel.org>
References: <cover.1718553901.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Zhang <markzhang@nvidia.com>

GSI QP is not needed if the port doesn't support connection management.
In following patches mlx5 is going to support IB ports that doesn't
support CM.

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/agent.c | 32 ++++++++++++++++++++++----------
 drivers/infiniband/core/mad.c   |  9 ++++++---
 2 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/core/agent.c b/drivers/infiniband/core/agent.c
index f82b4260de42..3bb46696731e 100644
--- a/drivers/infiniband/core/agent.c
+++ b/drivers/infiniband/core/agent.c
@@ -59,7 +59,16 @@ __ib_get_agent_port(const struct ib_device *device, int port_num)
 	struct ib_agent_port_private *entry;
 
 	list_for_each_entry(entry, &ib_agent_port_list, port_list) {
-		if (entry->agent[1]->device == device &&
+		/* Need to check both agent[0] and agent[1], as an agent port
+		 * may only have one of them
+		 */
+		if (entry->agent[0] &&
+		    entry->agent[0]->device == device &&
+		    entry->agent[0]->port_num == port_num)
+			return entry;
+
+		if (entry->agent[1] &&
+		    entry->agent[1]->device == device &&
 		    entry->agent[1]->port_num == port_num)
 			return entry;
 	}
@@ -172,14 +181,16 @@ int ib_agent_port_open(struct ib_device *device, int port_num)
 		}
 	}
 
-	/* Obtain send only MAD agent for GSI QP */
-	port_priv->agent[1] = ib_register_mad_agent(device, port_num,
-						    IB_QPT_GSI, NULL, 0,
-						    &agent_send_handler,
-						    NULL, NULL, 0);
-	if (IS_ERR(port_priv->agent[1])) {
-		ret = PTR_ERR(port_priv->agent[1]);
-		goto error3;
+	if (rdma_cap_ib_cm(device, port_num)) {
+		/* Obtain send only MAD agent for GSI QP */
+		port_priv->agent[1] = ib_register_mad_agent(device, port_num,
+							    IB_QPT_GSI, NULL, 0,
+							    &agent_send_handler,
+							    NULL, NULL, 0);
+		if (IS_ERR(port_priv->agent[1])) {
+			ret = PTR_ERR(port_priv->agent[1]);
+			goto error3;
+		}
 	}
 
 	spin_lock_irqsave(&ib_agent_port_list_lock, flags);
@@ -212,7 +223,8 @@ int ib_agent_port_close(struct ib_device *device, int port_num)
 	list_del(&port_priv->port_list);
 	spin_unlock_irqrestore(&ib_agent_port_list_lock, flags);
 
-	ib_unregister_mad_agent(port_priv->agent[1]);
+	if (port_priv->agent[1])
+		ib_unregister_mad_agent(port_priv->agent[1]);
 	if (port_priv->agent[0])
 		ib_unregister_mad_agent(port_priv->agent[0]);
 
diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 674344eb8e2f..7439e47ff951 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -2983,9 +2983,12 @@ static int ib_mad_port_open(struct ib_device *device,
 		if (ret)
 			goto error6;
 	}
-	ret = create_mad_qp(&port_priv->qp_info[1], IB_QPT_GSI);
-	if (ret)
-		goto error7;
+
+	if (rdma_cap_ib_cm(device, port_num)) {
+		ret = create_mad_qp(&port_priv->qp_info[1], IB_QPT_GSI);
+		if (ret)
+			goto error7;
+	}
 
 	snprintf(name, sizeof(name), "ib_mad%u", port_num);
 	port_priv->wq = alloc_ordered_workqueue(name, WQ_MEM_RECLAIM);
-- 
2.45.2


