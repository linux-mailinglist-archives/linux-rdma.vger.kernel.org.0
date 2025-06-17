Return-Path: <linux-rdma+bounces-11380-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B80D7ADC318
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 09:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543B83AAC50
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 07:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AABA28F51B;
	Tue, 17 Jun 2025 07:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dCbvP2vc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D7B28D85F;
	Tue, 17 Jun 2025 07:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750144661; cv=none; b=NniGItvggStPMSE+plSA8/hgOYcdVvWHPUCXh5LfqPSxJuD08Mi/ulePasLWLksOYnUhFvueLg9haMEeLaYOk7jtiTrDUn7GRT7IAvdNCcJfj/znpnnYtJ7dJn7hmKWFnpGHQQ/3OBg1ifJVdewOGnZX3M1vGjdR1oeK9gDyQQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750144661; c=relaxed/simple;
	bh=Ct7FDrS3M3uAv+MZhiXEaaG8lFl/ycm5IWFUOcYtLp0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=KOE8JAI+GklYXr1z9pLhXLFrIzLJ1y1P4BT9FjsFUzqIatSvJRza0+LDthFTGkWbwTdn6xmMtV8rHfrilfGlziRO++wfYifzX053Ckn0WfYzTYw/G1PTKu7XZpM/T+tNVF3iJNq8QsjOOdh3xMWc7bSJ8zyCDo/UopT8QbX+S7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dCbvP2vc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id C892321176DA; Tue, 17 Jun 2025 00:17:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C892321176DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1750144659;
	bh=S+eb/WCveT3/EbB9nEUJwz1zEQAKiZsTsFJG8kvsRyY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dCbvP2vcaHCQ87FSNY56TjbF55q9dwHe8Z7GocUESrw4syWJ/SYsEKcjKoQ4Wn+lW
	 rUgeDPjoBwbL8Zn/m5GtIN8sYusge3Qwjl2Jut/B7WZUM+zcNfmW5eJsL9TUV/EZdM
	 UItLbWFmqcDC4tGfonQJ4NthQJvcY1E8j4qt+3zA=
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
Subject: [PATCH net-next v3 2/4] net: mana: Add support for net_shaper_ops
Date: Tue, 17 Jun 2025 00:17:34 -0700
Message-Id: <1750144656-2021-3-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1750144656-2021-1-git-send-email-ernis@linux.microsoft.com>
References: <1750144656-2021-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Introduce support for net_shaper_ops in the MANA driver,
enabling configuration of rate limiting on the MANA NIC.

To apply rate limiting, the driver issues a HWC command via
mana_set_bw_clamp() and updates the corresponding shaper object
in the net_shaper cache. If an error occurs during this process,
the driver restores the previous speed by querying the current link
configuration using mana_query_link_cfg().

The minimum supported bandwidth is 100 Mbps, and only values that are
exact multiples of 100 Mbps are allowed. Any other values are rejected.

To remove a shaper, the driver resets the bandwidth to the maximum
supported by the SKU using mana_set_bw_clamp() and clears the
associated cache entry. If an error occurs during this process,
the shaper details are retained.

On the hardware that does not support these APIs, the net-shaper
calls to set speed would fail.

Set the speed:
./tools/net/ynl/pyynl/cli.py \
 --spec Documentation/netlink/specs/net_shaper.yaml \
 --do set --json '{"ifindex":'$IFINDEX',
		   "handle":{"scope": "netdev", "id":'$ID' },
		   "bw-max": 200000000 }'

Get the shaper details:
./tools/net/ynl/pyynl/cli.py \
 --spec Documentation/netlink/specs/net_shaper.yaml \
 --do get --json '{"ifindex":'$IFINDEX',
		      "handle":{"scope": "netdev", "id":'$ID' }}'

> {'bw-max': 200000000,
> 'handle': {'scope': 'netdev'},
> 'ifindex': $IFINDEX,
> 'metric': 'bps'}

Delete the shaper object:
./tools/net/ynl/pyynl/cli.py \
 --spec Documentation/netlink/specs/net_shaper.yaml \
 --do delete --json '{"ifindex":'$IFINDEX',
		      "handle":{"scope": "netdev","id":'$ID' }}'

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Long Li <longli@microsoft.com>
---
Changes in v3:
* Rebase to latest net-next branch.
Changes in v2:
* No change.
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 155 ++++++++++++++++++
 include/net/mana/mana.h                       |  40 +++++
 2 files changed, 195 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index bcc33ea7aca3..547dff450b6d 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -719,6 +719,78 @@ static int mana_change_mtu(struct net_device *ndev, int new_mtu)
 	return err;
 }
 
+static int mana_shaper_set(struct net_shaper_binding *binding,
+			   const struct net_shaper *shaper,
+			   struct netlink_ext_ack *extack)
+{
+	struct mana_port_context *apc = netdev_priv(binding->netdev);
+	u32 old_speed, rate;
+	int err;
+
+	if (shaper->handle.scope != NET_SHAPER_SCOPE_NETDEV) {
+		NL_SET_ERR_MSG_MOD(extack, "net shaper scope should be netdev");
+		return -EINVAL;
+	}
+
+	if (apc->handle.id && shaper->handle.id != apc->handle.id) {
+		NL_SET_ERR_MSG_MOD(extack, "Cannot create multiple shapers");
+		return -EOPNOTSUPP;
+	}
+
+	if (!shaper->bw_max || (shaper->bw_max % 100000000)) {
+		NL_SET_ERR_MSG_MOD(extack, "Please use multiples of 100Mbps for bandwidth");
+		return -EINVAL;
+	}
+
+	rate = div_u64(shaper->bw_max, 1000); /* Convert bps to Kbps */
+	rate = div_u64(rate, 1000);	      /* Convert Kbps to Mbps */
+
+	/* Get current speed */
+	err = mana_query_link_cfg(apc);
+	old_speed = (err) ? SPEED_UNKNOWN : apc->speed;
+
+	if (!err) {
+		err = mana_set_bw_clamp(apc, rate, TRI_STATE_TRUE);
+		apc->speed = (err) ? old_speed : rate;
+		apc->handle = (err) ? apc->handle : shaper->handle;
+	}
+
+	return err;
+}
+
+static int mana_shaper_del(struct net_shaper_binding *binding,
+			   const struct net_shaper_handle *handle,
+			   struct netlink_ext_ack *extack)
+{
+	struct mana_port_context *apc = netdev_priv(binding->netdev);
+	int err;
+
+	err = mana_set_bw_clamp(apc, 0, TRI_STATE_FALSE);
+
+	if (!err) {
+		/* Reset mana port context parameters */
+		apc->handle.id = 0;
+		apc->handle.scope = NET_SHAPER_SCOPE_UNSPEC;
+		apc->speed = 0;
+	}
+
+	return err;
+}
+
+static void mana_shaper_cap(struct net_shaper_binding *binding,
+			    enum net_shaper_scope scope,
+			    unsigned long *flags)
+{
+	*flags = BIT(NET_SHAPER_A_CAPS_SUPPORT_BW_MAX) |
+		 BIT(NET_SHAPER_A_CAPS_SUPPORT_METRIC_BPS);
+}
+
+static const struct net_shaper_ops mana_shaper_ops = {
+	.set = mana_shaper_set,
+	.delete = mana_shaper_del,
+	.capabilities = mana_shaper_cap,
+};
+
 static const struct net_device_ops mana_devops = {
 	.ndo_open		= mana_open,
 	.ndo_stop		= mana_close,
@@ -729,6 +801,7 @@ static const struct net_device_ops mana_devops = {
 	.ndo_bpf		= mana_bpf,
 	.ndo_xdp_xmit		= mana_xdp_xmit,
 	.ndo_change_mtu		= mana_change_mtu,
+	.net_shaper_ops         = &mana_shaper_ops,
 };
 
 static void mana_cleanup_port_context(struct mana_port_context *apc)
@@ -1162,6 +1235,86 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
 	return err;
 }
 
+int mana_query_link_cfg(struct mana_port_context *apc)
+{
+	struct net_device *ndev = apc->ndev;
+	struct mana_query_link_config_resp resp = {};
+	struct mana_query_link_config_req req = {};
+	int err;
+
+	mana_gd_init_req_hdr(&req.hdr, MANA_QUERY_LINK_CONFIG,
+			     sizeof(req), sizeof(resp));
+
+	req.vport = apc->port_handle;
+	req.hdr.resp.msg_version = GDMA_MESSAGE_V2;
+
+	err = mana_send_request(apc->ac, &req, sizeof(req), &resp,
+				sizeof(resp));
+
+	if (err) {
+		netdev_err(ndev, "Failed to query link config: %d\n", err);
+		return err;
+	}
+
+	err = mana_verify_resp_hdr(&resp.hdr, MANA_QUERY_LINK_CONFIG,
+				   sizeof(resp));
+
+	if (err || resp.hdr.status) {
+		netdev_err(ndev, "Failed to query link config: %d, 0x%x\n", err,
+			   resp.hdr.status);
+		if (!err)
+			err = -EOPNOTSUPP;
+		return err;
+	}
+
+	if (resp.qos_unconfigured) {
+		err = -EINVAL;
+		return err;
+	}
+	apc->speed = resp.link_speed_mbps;
+	return 0;
+}
+
+int mana_set_bw_clamp(struct mana_port_context *apc, u32 speed,
+		      int enable_clamping)
+{
+	struct mana_set_bw_clamp_resp resp = {};
+	struct mana_set_bw_clamp_req req = {};
+	struct net_device *ndev = apc->ndev;
+	int err;
+
+	mana_gd_init_req_hdr(&req.hdr, MANA_SET_BW_CLAMP,
+			     sizeof(req), sizeof(resp));
+	req.vport = apc->port_handle;
+	req.link_speed_mbps = speed;
+	req.enable_clamping = enable_clamping;
+
+	err = mana_send_request(apc->ac, &req, sizeof(req), &resp,
+				sizeof(resp));
+
+	if (err) {
+		netdev_err(ndev, "Failed to set bandwidth clamp for speed %u, err = %d",
+			   speed, err);
+		return err;
+	}
+
+	err = mana_verify_resp_hdr(&resp.hdr, MANA_SET_BW_CLAMP,
+				   sizeof(resp));
+
+	if (err || resp.hdr.status) {
+		netdev_err(ndev, "Failed to set bandwidth clamp: %d, 0x%x\n", err,
+			   resp.hdr.status);
+		if (!err)
+			err = -EOPNOTSUPP;
+		return err;
+	}
+
+	if (resp.qos_unconfigured)
+		netdev_info(ndev, "QoS is unconfigured\n");
+
+	return 0;
+}
+
 int mana_create_wq_obj(struct mana_port_context *apc,
 		       mana_handle_t vport,
 		       u32 wq_type, struct mana_obj_spec *wq_spec,
@@ -3011,6 +3164,8 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 		goto free_indir;
 	}
 
+	debugfs_create_u32("current_speed", 0400, apc->mana_port_debugfs, &apc->speed);
+
 	return 0;
 
 free_indir:
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 4176edf1be71..038b18340e51 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -5,6 +5,7 @@
 #define _MANA_H
 
 #include <net/xdp.h>
+#include <net/net_shaper.h>
 
 #include "gdma.h"
 #include "hw_channel.h"
@@ -526,7 +527,12 @@ struct mana_port_context {
 	struct mutex vport_mutex;
 	int vport_use_count;
 
+	/* Net shaper handle*/
+	struct net_shaper_handle handle;
+
 	u16 port_idx;
+	/* Currently configured speed (mbps) */
+	u32 speed;
 
 	bool port_is_up;
 	bool port_st_save; /* Saved port state */
@@ -562,6 +568,9 @@ struct bpf_prog *mana_xdp_get(struct mana_port_context *apc);
 void mana_chn_setxdp(struct mana_port_context *apc, struct bpf_prog *prog);
 int mana_bpf(struct net_device *ndev, struct netdev_bpf *bpf);
 void mana_query_gf_stats(struct mana_port_context *apc);
+int mana_query_link_cfg(struct mana_port_context *apc);
+int mana_set_bw_clamp(struct mana_port_context *apc, u32 speed,
+		      int enable_clamping);
 void mana_query_phy_stats(struct mana_port_context *apc);
 int mana_pre_alloc_rxbufs(struct mana_port_context *apc, int mtu, int num_queues);
 void mana_pre_dealloc_rxbufs(struct mana_port_context *apc);
@@ -589,6 +598,8 @@ enum mana_command_code {
 	MANA_FENCE_RQ		= 0x20006,
 	MANA_CONFIG_VPORT_RX	= 0x20007,
 	MANA_QUERY_VPORT_CONFIG	= 0x20008,
+	MANA_QUERY_LINK_CONFIG	= 0x2000A,
+	MANA_SET_BW_CLAMP	= 0x2000B,
 	MANA_QUERY_PHY_STAT     = 0x2000c,
 
 	/* Privileged commands for the PF mode */
@@ -598,6 +609,35 @@ enum mana_command_code {
 	MANA_DEREGISTER_HW_PORT	= 0x28004,
 };
 
+/* Query Link Configuration*/
+struct mana_query_link_config_req {
+	struct gdma_req_hdr hdr;
+	mana_handle_t vport;
+}; /* HW DATA */
+
+struct mana_query_link_config_resp {
+	struct gdma_resp_hdr hdr;
+	u32 qos_speed_mbps;
+	u8 qos_unconfigured;
+	u8 reserved1[3];
+	u32 link_speed_mbps;
+	u8 reserved2[4];
+}; /* HW DATA */
+
+/* Set Bandwidth Clamp*/
+struct mana_set_bw_clamp_req {
+	struct gdma_req_hdr hdr;
+	mana_handle_t vport;
+	enum TRI_STATE enable_clamping;
+	u32 link_speed_mbps;
+}; /* HW DATA */
+
+struct mana_set_bw_clamp_resp {
+	struct gdma_resp_hdr hdr;
+	u8 qos_unconfigured;
+	u8 reserved[7];
+}; /* HW DATA */
+
 /* Query Device Configuration */
 struct mana_query_device_cfg_req {
 	struct gdma_req_hdr hdr;
-- 
2.34.1


