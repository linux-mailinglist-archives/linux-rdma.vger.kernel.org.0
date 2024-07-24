Return-Path: <linux-rdma+bounces-3953-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2073193B97F
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 01:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB78A1F220BF
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2024 23:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9D71448C1;
	Wed, 24 Jul 2024 23:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JBXMvyre"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA1A13BC3E
	for <linux-rdma@vger.kernel.org>; Wed, 24 Jul 2024 23:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721864440; cv=none; b=pZffVt5GDQirs4c9Thhz8UdKeaxOjBaTYiQG2TYgFr9/qLPxQEvEVIMQLdd6qf2typcbwyY0N+4YKHOZh7bbRBi9u+w9r95730vciwj8LXjzOW+nm2gzCGnkLNk7HzHQtuYr1Iz/1kf4BGD9X1T5kLisxVA2Ky9Mi9FQH0nndd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721864440; c=relaxed/simple;
	bh=Q2USVksmYtK7mddJ+9HZDrvw38qok5ardrI1zRf6+y8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IKCW1HV5snGPty3pq7rPyq0nGtswS/X6gBQEGUPje1FKE8sB9qHqkOTrf2b0ZQ09RW8rouZLvfyl9wmND42kfg48tUBXErKQZiZ5dNfw6Z9TC6lZDQcTJQnQCHJHjdXCPLLURwY5M9GJpGeiF6JNvKneNY7ruI8/g2KkwD2c5Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JBXMvyre; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721864440; x=1753400440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q2USVksmYtK7mddJ+9HZDrvw38qok5ardrI1zRf6+y8=;
  b=JBXMvyreudz+yBpf5c80TWsIQHOhZPxPK7xqoZVFL5LAFMVhhny6B1Gc
   FP9qYyPe9lXtFDpg7uA6wOhKxPnDIslCimM0JpXgPvZGcc+hR1FGcwAj1
   QPp2PAxnDVq39/QdwaQ1a6AV845fnrJfz+KIG6syP77ifDasXChTYW5TU
   sB9To8TkvidsV7w4U9pPkJHRQRvirJTdHSmWTyyhmpOTVCYOjr4IH/Pq1
   dMiWRAvGDt0n2Gs9RFXqAFsh7/F8rdFHzVYH4s08pr7nMWYa97CQEV6Fw
   /7BWOyfBPvtwfwn5lRkPud9j0aKDV0HQGvBONnEG4qvTrAUufpvqgyZDJ
   w==;
X-CSE-ConnectionGUID: MCzGs1y1T1+ot9HWGimrVQ==
X-CSE-MsgGUID: 2uFV/nmzRu2+77L37K7IUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="44999745"
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="44999745"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 16:40:37 -0700
X-CSE-ConnectionGUID: aRJiCRpcQtCWv7tUBD4OSA==
X-CSE-MsgGUID: 9AC7/ACsQXiFAp7RYNh6Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="52426006"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.96.138])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 16:40:35 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	mustafa.ismail@intel.com,
	Joshua Hay <joshua.a.hay@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [RFC PATCH 04/25] idpf: prevent deadlock with irdma get link settings
Date: Wed, 24 Jul 2024 18:38:56 -0500
Message-Id: <20240724233917.704-5-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20240724233917.704-1-tatyana.e.nikolova@intel.com>
References: <20240724233917.704-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Hay <joshua.a.hay@intel.com>

When the rdma core deinitializes (reset or remove), it is calling
get_link_ksettings. Add logic to get link settings to avoid even taking
the lock during a reset or remove, since we will not care what the link
settings are in that state anyways.

Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 1885ba6..48f1677 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -1310,20 +1310,25 @@ static void idpf_set_msglevel(struct net_device *netdev, u32 data)
 static int idpf_get_link_ksettings(struct net_device *netdev,
 				   struct ethtool_link_ksettings *cmd)
 {
+	struct idpf_adapter *adapter = idpf_netdev_to_adapter(netdev);
 	struct idpf_vport *vport;
 
-	idpf_vport_ctrl_lock(netdev);
-	vport = idpf_netdev_to_vport(netdev);
-
 	ethtool_link_ksettings_zero_link_mode(cmd, supported);
 	cmd->base.autoneg = AUTONEG_DISABLE;
 	cmd->base.port = PORT_NONE;
+	cmd->base.duplex = DUPLEX_UNKNOWN;
+	cmd->base.speed = SPEED_UNKNOWN;
+
+	if (idpf_is_reset_in_prog(adapter) ||
+	    test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
+		return 0;
+
+	idpf_vport_ctrl_lock(netdev);
+	vport = idpf_netdev_to_vport(netdev);
+
 	if (vport->link_up) {
 		cmd->base.duplex = DUPLEX_FULL;
 		cmd->base.speed = vport->link_speed_mbps;
-	} else {
-		cmd->base.duplex = DUPLEX_UNKNOWN;
-		cmd->base.speed = SPEED_UNKNOWN;
 	}
 
 	idpf_vport_ctrl_unlock(netdev);
-- 
1.8.3.1


