Return-Path: <linux-rdma+bounces-11295-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 376EFAD8A3C
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Jun 2025 13:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEA2C7AE0D8
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Jun 2025 11:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC122D6633;
	Fri, 13 Jun 2025 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rcj58bYi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60E52D540C;
	Fri, 13 Jun 2025 11:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749813632; cv=none; b=E3eSyEw6Fr9op1bX5wNQHIRFbQ5yTzmpIU0h5PL2jVugRJGdC6nGn0PHkmDKMEwyCabQ3nT3bN9q2LmeT9GqptxxNk2s+4j1zwoMRXaRnMwqDFiUFNsa1LaLtWKBs6ioyqPmfP+7PdG9zjjt3kNfHhteZL7RtECYvxrjfqjXvVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749813632; c=relaxed/simple;
	bh=T8M8l/OSfqF6LAD2opiryZllIbiWH12cgjvJos95K/A=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=YYOxnP05Q1jpux4uYBBqSAeKcXO4PyhSxKaA7w8ljI28DLZccLckYnaz7I9k4FOwDGdceBH4ZGrSBi4dPn6oHcPNHt+Su+YkObEdDJ4eCoxgbxOAw/m0zwKfSrkfMNKyGvqaZooqU/FC38qMU3J18edGd1BHx+XkYrxt4HveziM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rcj58bYi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 43663201C775; Fri, 13 Jun 2025 04:20:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 43663201C775
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749813630;
	bh=cP2o3EuJ+p3R1t0enkJckW1hpdqJe16ROT2UBloMEak=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rcj58bYikfHixGsadDstumxnYOpQ2cczgQ3tPbZwypPNycE6iiYQASD14+rtR5Wxq
	 1INnpJ4W3DvFB4MjF9rkd6z4E3lQJlUfrhTkPAkViR8/nDALW7FoN/fnnsuUZaYGVJ
	 fCtUEwxNuq+aG/kxvnMEMUBJs4AfjzPvpf5xXjIY=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	longli@microsoft.com,
	kotaranov@microsoft.com,
	horms@kernel.org,
	shirazsaleem@microsoft.com,
	leon@kernel.org,
	ernis@linux.microsoft.com,
	shradhagupta@linux.microsoft.com,
	schakrabarti@linux.microsoft.com,
	gerhard@engleder-embedded.com,
	rosenp@gmail.com,
	sdf@fomichev.me,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v2 1/4] net: mana: Fix potential deadlocks in mana napi ops
Date: Fri, 13 Jun 2025 04:20:24 -0700
Message-Id: <1749813627-8377-2-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749813627-8377-1-git-send-email-ernis@linux.microsoft.com>
References: <1749813627-8377-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

When net_shaper_ops are enabled for MANA, netdev_ops_lock
becomes active.

MANA VF setup/teardown by netvsc follows this call chain:

netvsc_vf_setup()
        dev_change_flags()
		...
         __dev_open() OR __dev_close()

dev_change_flags() holds the netdev mutex via netdev_lock_ops.

Meanwhile, mana_create_txq() and mana_create_rxq() in mana_open()
path call NAPI APIs (netif_napi_add_tx(), netif_napi_add_weight(),
napi_enable()), which also try to acquire the same lock, risking
deadlock.

Similarly in the teardown path (mana_close()), netif_napi_disable()
and netif_napi_del(), contend for the same lock.

Switch to the _locked variants of these APIs to avoid deadlocks
when the netdev_ops_lock is held.

Fixes: d4c22ec680c8 ("net: hold netdev instance lock during ndo_open/ndo_stop")
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
---
Changes in v2:
* Use netdev_lock_ops_to_full() instead of if...else statements for napi
  APIs.
* Edit commit message.
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 30 +++++++++++++------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index e68b8190bb7a..ca5e9c3d374b 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1912,8 +1912,11 @@ static void mana_destroy_txq(struct mana_port_context *apc)
 		napi = &apc->tx_qp[i].tx_cq.napi;
 		if (apc->tx_qp[i].txq.napi_initialized) {
 			napi_synchronize(napi);
-			napi_disable(napi);
-			netif_napi_del(napi);
+			netdev_lock_ops_to_full(napi->dev);
+			napi_disable_locked(napi);
+			netif_napi_del_locked(napi);
+			netdev_unlock_full_to_ops(napi->dev);
 			apc->tx_qp[i].txq.napi_initialized = false;
 		}
 		mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i].tx_object);
@@ -2065,8 +2068,11 @@ static int mana_create_txq(struct mana_port_context *apc,
 
 		mana_create_txq_debugfs(apc, i);
 
-		netif_napi_add_tx(net, &cq->napi, mana_poll);
-		napi_enable(&cq->napi);
+		set_bit(NAPI_STATE_NO_BUSY_POLL, &cq->napi.state);
+		netdev_lock_ops_to_full(net);
+		netif_napi_add_locked(net, &cq->napi, mana_poll);
+		napi_enable_locked(&cq->napi);
+		netdev_unlock_full_to_ops(net);
 		txq->napi_initialized = true;
 
 		mana_gd_ring_cq(cq->gdma_cq, SET_ARM_BIT);
@@ -2102,9 +2108,11 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
 	if (napi_initialized) {
 		napi_synchronize(napi);
 
-		napi_disable(napi);
-
-		netif_napi_del(napi);
+		netdev_lock_ops_to_full(napi->dev);
+		napi_disable_locked(napi);
+		netif_napi_del_locked(napi);
+		netdev_unlock_full_to_ops(napi->dev);
 	}
 	xdp_rxq_info_unreg(&rxq->xdp_rxq);
 
@@ -2355,14 +2363,18 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 
 	gc->cq_table[cq->gdma_id] = cq->gdma_cq;
 
-	netif_napi_add_weight(ndev, &cq->napi, mana_poll, 1);
+	netdev_lock_ops_to_full(ndev);
+	netif_napi_add_weight_locked(ndev, &cq->napi, mana_poll, 1);
+	netdev_unlock_full_to_ops(ndev);
 
 	WARN_ON(xdp_rxq_info_reg(&rxq->xdp_rxq, ndev, rxq_idx,
 				 cq->napi.napi_id));
 	WARN_ON(xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq, MEM_TYPE_PAGE_POOL,
 					   rxq->page_pool));
 
-	napi_enable(&cq->napi);
+	netdev_lock_ops_to_full(ndev);
+	napi_enable_locked(&cq->napi);
+	netdev_unlock_full_to_ops(ndev);
 
 	mana_gd_ring_cq(cq->gdma_cq, SET_ARM_BIT);
 out:
-- 
2.34.1


