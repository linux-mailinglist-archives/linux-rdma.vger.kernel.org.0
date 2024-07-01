Return-Path: <linux-rdma+bounces-3593-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C4391E012
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 15:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223EF1C225A6
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 13:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B665615DBD6;
	Mon,  1 Jul 2024 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eRBolBwC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D48E146017;
	Mon,  1 Jul 2024 13:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719838813; cv=none; b=EGgCaHJxS+YpuWwpM5UPt3bvJn8NnDOfXSGJi2wj3UG5Td53OMVOgupEUk0UI/JCISyTZWaPSj8a3w1EfMeJ+VuqETP/BRsIFkL72rvzG9uVjVChKp6kT49L2tObF/vy4Rwemlp+XoFZ4uhaDNqTxzzZg/3wJu1x1rz4NdBJ0Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719838813; c=relaxed/simple;
	bh=G/xOlPYe3vF5oKjhIB7GW4ffAy3SSJ2aL4UQN6CovZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=bDn+4g1V5zs8cwY6+tm0tuBlUE/26OgM2QrwW7kUWgcliMwzi2ZzoYn75SYMp+2jLllYhzKJKb/0RfkdwUrRoNl+OuIk7rbpEFtaM2bdTX74kCa8hWnRL17jtZ9r43flpSZGD9BBSsezfufspIsYuXo/FsvNDyB8QZC5c+T1J7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eRBolBwC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3B4B820B7004;
	Mon,  1 Jul 2024 06:00:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3B4B820B7004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1719838805;
	bh=zzK5OuTFvzx/ju5sunPw2VL6Q836V9zKxrgDi0Ynufw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eRBolBwCEfEP1Uao3huhzX7M3wgtQqVMefS3sT7f7Dy0uxkOz7zR63vNtGwI6DuCq
	 Dj+OYf061lAyHMqXKTbDrYHd4xpJaf1hdw7zEdMXUIH9Tn0Eq3BxhP1ypbjbCXGw2+
	 Zq6IFAtp4G/DMWw2cvCqyLGEdhwOoz9Hg95DQhvQ=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	pabeni@redhat.com,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	edumazet@google.com,
	kuba@kernel.org,
	davem@davemloft.net,
	decui@microsoft.com,
	wei.liu@kernel.org,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 1/2] net: mana: introduce helper to get a master netdev
Date: Mon,  1 Jul 2024 05:58:55 -0700
Message-Id: <1719838736-20338-2-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1719838736-20338-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1719838736-20338-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Add helper to get a master netdevice for a given port.
When mana is used with netvsc, the VF netdev is controlled
by an upper netvsc device. In a baremetal case, the VF
netdev is the master device.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 18 ++++++++++++++++++
 include/net/mana/mana.h                       |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index d087cf9..b893339 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2948,3 +2948,21 @@ out:
 	gd->gdma_context = NULL;
 	kfree(ac);
 }
+
+/* the caller should hold rcu_read_lock */
+struct net_device *mana_get_master_netdev_rcu(struct mana_context *ac, u32 port_index)
+{
+	struct net_device *ndev;
+
+	if (port_index >= ac->num_ports)
+		return NULL;
+
+	/* When mana is used in netvsc, the upper netdevice should be returned. */
+	if (ac->ports[port_index]->flags & IFF_SLAVE)
+		ndev = netdev_master_upper_dev_get_rcu(ac->ports[port_index]);
+	else
+		ndev = ac->ports[port_index];
+
+	return ndev;
+}
+EXPORT_SYMBOL_NS(mana_get_master_netdev_rcu, NET_MANA);
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 46f741e..2d3625c 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -797,4 +797,6 @@ void mana_destroy_wq_obj(struct mana_port_context *apc, u32 wq_type,
 int mana_cfg_vport(struct mana_port_context *apc, u32 protection_dom_id,
 		   u32 doorbell_pg_id);
 void mana_uncfg_vport(struct mana_port_context *apc);
+
+struct net_device *mana_get_master_netdev_rcu(struct mana_context *ac, u32 port_index);
 #endif /* _MANA_H */
-- 
2.43.0


