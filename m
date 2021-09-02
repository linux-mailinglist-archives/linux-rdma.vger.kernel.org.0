Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F533FEE5B
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Sep 2021 15:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344945AbhIBNIq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Sep 2021 09:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344895AbhIBNIm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Sep 2021 09:08:42 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A317BC061575
        for <linux-rdma@vger.kernel.org>; Thu,  2 Sep 2021 06:07:43 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id j2so1156310pll.1
        for <linux-rdma@vger.kernel.org>; Thu, 02 Sep 2021 06:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1+KQApy27Pwh7068h0D2zGaCRSkYzXO0P+waVXIyCeQ=;
        b=MUpIX6ppBPvVdPOfLWIkJl6ntbdlNu1GiL7WMrkCWr8BKk65bUq311FCcHbJ3R9X4L
         2AsR5gYCAuG33c2XKWtYU8Ykw5Z/s/2rZQij0cgcscxoBDVxgqjVah/edCdSugtZOVcz
         ZCOwLSaSiNk+tXO1XZdHmIctorGXdwMmFE1vd7MJrDBLZIsb2XZ4meLmbRMXV+i3z5WZ
         wXrXQDhoSy2FNuuhcWyEOr/y/3X9VVGUpowbXorqxnWeugMnvSuXP/EKQH1YCZjYb+Pp
         fAt0kW0b5spftaE9TEP37rhir28IJw68gvvk7OEh0G4Mb3cS5c7EWRyNP95HEvzhg6Jq
         Lozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1+KQApy27Pwh7068h0D2zGaCRSkYzXO0P+waVXIyCeQ=;
        b=GcdWVIwOFWONw1HJ06DR+JeCdaiPbTEWhNDKnvfypl9gIba89HyKvDIw6o+zQ8Npna
         4LOVr5mgwxsBRZefhHjbZTagcvu3JB2JDivJX/rsRCmxggsQYJu8i4/EhiBuQznhRA4N
         GGdyGn5dKXwU6YbWPaqqEr2qYC2kjFs9UjVkZ3aFb3dFu7RkXldkkxvdcjGYZlOu8F9E
         ZP+tBJnyhDsUnBIIMlFRLPk4d99Kx5y+eUcVE9cM8/dNN71ocPLTwFgGA5H/KK13oySL
         B0x9k+szLE0IC4UYacEX3DvhFdpfi8vlbrZakY3FJ+kufZY9sBc0nKNRpJcOXGFFpBt8
         GCyw==
X-Gm-Message-State: AOAM532ACenW1kd5iCzvcnJlDfp9fLeuIWxtURHO5yBjnqcCEI2MBywc
        WzUK91KsUmHgmaXieUgGfHyhTw==
X-Google-Smtp-Source: ABdhPJzXk5YzVIdD/wPxYI+0kFmEvMa+i4B89MvNEK7CEoXbjjmyKCfRO1C6RvAq4n6k7DAIU0bAfw==
X-Received: by 2002:a17:902:b48c:b0:139:eec4:737c with SMTP id y12-20020a170902b48c00b00139eec4737cmr2896262plr.11.1630588061634;
        Thu, 02 Sep 2021 06:07:41 -0700 (PDT)
Received: from C02FR1DUMD6V.bytedance.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id d6sm2307415pfa.135.2021.09.02.06.07.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Sep 2021 06:07:41 -0700 (PDT)
From:   Junji Wei <weijunji@bytedance.com>
To:     dledford@redhat.com, jgg@ziepe.ca, mst@redhat.com,
        jasowang@redhat.com, yuval.shaia.ml@gmail.com,
        marcel.apfelbaum@gmail.com, cohuck@redhat.com, hare@suse.de
Cc:     xieyongji@bytedance.com, chaiwen.cc@bytedance.com,
        weijunji@bytedance.com, linux-rdma@vger.kernel.org,
        virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
Subject: [RFC 1/5] RDMA/virtio-rdma Introduce a new core cap prot
Date:   Thu,  2 Sep 2021 21:06:21 +0800
Message-Id: <20210902130625.25277-2-weijunji@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210902130625.25277-1-weijunji@bytedance.com>
References: <20210902130625.25277-1-weijunji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Introduce a new core cap prot RDMA_CORE_CAP_PROT_VIRTIO
to support virtio-rdma

Currently RDMA_CORE_CAP_PROT_VIRTIO is as same as
RDMA_CORE_CAP_PROT_ROCE_UDP_ENCAP except rdma_query_gid,
we need to get get gid from host device.

Signed-off-by: Junji Wei <weijunji@bytedance.com>
---
 drivers/infiniband/core/cache.c         |  9 ++++++---
 drivers/infiniband/core/cm.c            |  4 ++--
 drivers/infiniband/core/cma.c           | 20 ++++++++++----------
 drivers/infiniband/core/device.c        |  4 ++--
 drivers/infiniband/core/multicast.c     |  2 +-
 drivers/infiniband/core/nldev.c         |  2 ++
 drivers/infiniband/core/roce_gid_mgmt.c |  3 ++-
 drivers/infiniband/core/ucma.c          |  2 +-
 drivers/infiniband/core/verbs.c         |  2 +-
 include/rdma/ib_verbs.h                 | 28 +++++++++++++++++++++++++---
 10 files changed, 52 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index c9e9fc81447e..3c0a0c9896b4 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -396,7 +396,7 @@ static void del_gid(struct ib_device *ib_dev, u32 port,
 	/*
 	 * For non RoCE protocol, GID entry slot is ready to use.
 	 */
-	if (!rdma_protocol_roce(ib_dev, port))
+	if (!rdma_protocol_virtio_or_roce(ib_dev, port))
 		table->data_vec[ix] = NULL;
 	write_unlock_irq(&table->rwlock);
 
@@ -448,7 +448,7 @@ static int add_modify_gid(struct ib_gid_table *table,
 	if (!entry)
 		return -ENOMEM;
 
-	if (rdma_protocol_roce(attr->device, attr->port_num)) {
+	if (rdma_protocol_virtio_or_roce(attr->device, attr->port_num)) {
 		ret = add_roce_gid(entry);
 		if (ret)
 			goto done;
@@ -960,6 +960,9 @@ int rdma_query_gid(struct ib_device *device, u32 port_num,
 	if (!rdma_is_port_valid(device, port_num))
 		return -EINVAL;
 
+	if (rdma_protocol_virtio(device, port_num))
+		return device->ops.query_gid(device, port_num, index, gid);
+
 	table = rdma_gid_table(device, port_num);
 	read_lock_irqsave(&table->rwlock, flags);
 
@@ -1482,7 +1485,7 @@ ib_cache_update(struct ib_device *device, u32 port, bool update_gids,
 		goto err;
 	}
 
-	if (!rdma_protocol_roce(device, port) && update_gids) {
+	if (!rdma_protocol_virtio_or_roce(device, port) && update_gids) {
 		ret = config_non_roce_gid_cache(device, port,
 						tprops->gid_tbl_len);
 		if (ret)
diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index c903b74f46a4..a707f5de1c2e 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -3288,7 +3288,7 @@ static int cm_lap_handler(struct cm_work *work)
 	/* Currently Alternate path messages are not supported for
 	 * RoCE link layer.
 	 */
-	if (rdma_protocol_roce(work->port->cm_dev->ib_device,
+	if (rdma_protocol_virtio_or_roce(work->port->cm_dev->ib_device,
 			       work->port->port_num))
 		return -EINVAL;
 
@@ -3381,7 +3381,7 @@ static int cm_apr_handler(struct cm_work *work)
 	/* Currently Alternate path messages are not supported for
 	 * RoCE link layer.
 	 */
-	if (rdma_protocol_roce(work->port->cm_dev->ib_device,
+	if (rdma_protocol_virtio_or_roce(work->port->cm_dev->ib_device,
 			       work->port->port_num))
 		return -EINVAL;
 
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 5d3b8b8d163d..5d29de352ed8 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -573,7 +573,7 @@ cma_validate_port(struct ib_device *device, u32 port,
 	if ((dev_type != ARPHRD_INFINIBAND) && rdma_protocol_ib(device, port))
 		return ERR_PTR(-ENODEV);
 
-	if (dev_type == ARPHRD_ETHER && rdma_protocol_roce(device, port)) {
+	if (dev_type == ARPHRD_ETHER && rdma_protocol_virtio_or_roce(device, port)) {
 		ndev = dev_get_by_index(dev_addr->net, bound_if_index);
 		if (!ndev)
 			return ERR_PTR(-ENODEV);
@@ -626,7 +626,7 @@ static int cma_acquire_dev_by_src_ip(struct rdma_id_private *id_priv)
 	mutex_lock(&lock);
 	list_for_each_entry(cma_dev, &dev_list, list) {
 		rdma_for_each_port (cma_dev->device, port) {
-			gidp = rdma_protocol_roce(cma_dev->device, port) ?
+			gidp = rdma_protocol_virtio_or_roce(cma_dev->device, port) ?
 			       &iboe_gid : &gid;
 			gid_type = cma_dev->default_gid_type[port - 1];
 			sgid_attr = cma_validate_port(cma_dev->device, port,
@@ -669,7 +669,7 @@ static int cma_ib_acquire_dev(struct rdma_id_private *id_priv,
 	    id_priv->id.ps == RDMA_PS_IPOIB)
 		return -EINVAL;
 
-	if (rdma_protocol_roce(req->device, req->port))
+	if (rdma_protocol_virtio_or_roce(req->device, req->port))
 		rdma_ip2gid((struct sockaddr *)&id_priv->id.route.addr.src_addr,
 			    &gid);
 	else
@@ -1525,7 +1525,7 @@ static struct net_device *cma_get_net_dev(const struct ib_cm_event *ib_event,
 	if (err)
 		return ERR_PTR(err);
 
-	if (rdma_protocol_roce(req->device, req->port))
+	if (rdma_protocol_virtio_or_roce(req->device, req->port))
 		net_dev = roce_get_net_dev_by_cm_event(ib_event);
 	else
 		net_dev = ib_get_net_dev_by_params(req->device, req->port,
@@ -1583,7 +1583,7 @@ static bool cma_protocol_roce(const struct rdma_cm_id *id)
 	struct ib_device *device = id->device;
 	const u32 port_num = id->port_num ?: rdma_start_port(device);
 
-	return rdma_protocol_roce(device, port_num);
+	return rdma_protocol_virtio_or_roce(device, port_num);
 }
 
 static bool cma_is_req_ipv6_ll(const struct cma_req_info *req)
@@ -1813,7 +1813,7 @@ static void destroy_mc(struct rdma_id_private *id_priv,
 	if (rdma_cap_ib_mcast(id_priv->id.device, id_priv->id.port_num))
 		ib_sa_free_multicast(mc->sa_mc);
 
-	if (rdma_protocol_roce(id_priv->id.device, id_priv->id.port_num)) {
+	if (rdma_protocol_virtio_or_roce(id_priv->id.device, id_priv->id.port_num)) {
 		struct rdma_dev_addr *dev_addr =
 			&id_priv->id.route.addr.dev_addr;
 		struct net_device *ndev = NULL;
@@ -2296,7 +2296,7 @@ void rdma_read_gids(struct rdma_cm_id *cm_id, union ib_gid *sgid,
 		return;
 	}
 
-	if (rdma_protocol_roce(cm_id->device, cm_id->port_num)) {
+	if (rdma_protocol_virtio_or_roce(cm_id->device, cm_id->port_num)) {
 		if (sgid)
 			rdma_ip2gid((struct sockaddr *)&addr->src_addr, sgid);
 		if (dgid)
@@ -2919,7 +2919,7 @@ int rdma_set_ib_path(struct rdma_cm_id *id,
 		goto err;
 	}
 
-	if (rdma_protocol_roce(id->device, id->port_num)) {
+	if (rdma_protocol_virtio_or_roce(id->device, id->port_num)) {
 		ndev = cma_iboe_set_path_rec_l2_fields(id_priv);
 		if (!ndev) {
 			ret = -ENODEV;
@@ -3139,7 +3139,7 @@ int rdma_resolve_route(struct rdma_cm_id *id, unsigned long timeout_ms)
 	cma_id_get(id_priv);
 	if (rdma_cap_ib_sa(id->device, id->port_num))
 		ret = cma_resolve_ib_route(id_priv, timeout_ms);
-	else if (rdma_protocol_roce(id->device, id->port_num))
+	else if (rdma_protocol_virtio_or_roce(id->device, id->port_num))
 		ret = cma_resolve_iboe_route(id_priv);
 	else if (rdma_protocol_iwarp(id->device, id->port_num))
 		ret = cma_resolve_iw_route(id_priv);
@@ -4766,7 +4766,7 @@ int rdma_join_multicast(struct rdma_cm_id *id, struct sockaddr *addr,
 	mc->id_priv = id_priv;
 	mc->join_state = join_state;
 
-	if (rdma_protocol_roce(id->device, id->port_num)) {
+	if (rdma_protocol_virtio_or_roce(id->device, id->port_num)) {
 		ret = cma_iboe_join_multicast(id_priv, mc);
 		if (ret)
 			goto out_err;
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index fa20b1824fb8..fadf17246574 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2297,7 +2297,7 @@ void ib_enum_roce_netdev(struct ib_device *ib_dev,
 	u32 port;
 
 	rdma_for_each_port (ib_dev, port)
-		if (rdma_protocol_roce(ib_dev, port)) {
+		if (rdma_protocol_virtio_or_roce(ib_dev, port)) {
 			struct net_device *idev =
 				ib_device_get_netdev(ib_dev, port);
 
@@ -2429,7 +2429,7 @@ int ib_modify_port(struct ib_device *device,
 		rc = device->ops.modify_port(device, port_num,
 					     port_modify_mask,
 					     port_modify);
-	else if (rdma_protocol_roce(device, port_num) &&
+	else if (rdma_protocol_virtio_or_roce(device, port_num) &&
 		 ((port_modify->set_port_cap_mask & ~IB_PORT_CM_SUP) == 0 ||
 		  (port_modify->clr_port_cap_mask & ~IB_PORT_CM_SUP) == 0))
 		rc = 0;
diff --git a/drivers/infiniband/core/multicast.c b/drivers/infiniband/core/multicast.c
index a236532a9026..eaeea1002177 100644
--- a/drivers/infiniband/core/multicast.c
+++ b/drivers/infiniband/core/multicast.c
@@ -745,7 +745,7 @@ int ib_init_ah_from_mcmember(struct ib_device *device, u32 port_num,
 	 */
 	if (rdma_protocol_ib(device, port_num))
 		ndev = NULL;
-	else if (!rdma_protocol_roce(device, port_num))
+	else if (!rdma_protocol_virtio_or_roce(device, port_num))
 		return -EINVAL;
 
 	sgid_attr = rdma_find_gid_by_port(device, &rec->port_gid,
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index e9b4b2cccaa0..e41cbf6bef0b 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -296,6 +296,8 @@ static int fill_dev_info(struct sk_buff *msg, struct ib_device *device)
 		ret = nla_put_string(msg, RDMA_NLDEV_ATTR_DEV_PROTOCOL, "iw");
 	else if (rdma_protocol_roce(device, port))
 		ret = nla_put_string(msg, RDMA_NLDEV_ATTR_DEV_PROTOCOL, "roce");
+	else if (rdma_protocol_virtio(device, port))
+		ret = nla_put_string(msg, RDMA_NLDEV_ATTR_DEV_PROTOCOL, "virtio");
 	else if (rdma_protocol_usnic(device, port))
 		ret = nla_put_string(msg, RDMA_NLDEV_ATTR_DEV_PROTOCOL,
 				     "usnic");
diff --git a/drivers/infiniband/core/roce_gid_mgmt.c b/drivers/infiniband/core/roce_gid_mgmt.c
index 68197e576433..5ea87b89dae6 100644
--- a/drivers/infiniband/core/roce_gid_mgmt.c
+++ b/drivers/infiniband/core/roce_gid_mgmt.c
@@ -75,6 +75,7 @@ static const struct {
 } PORT_CAP_TO_GID_TYPE[] = {
 	{rdma_protocol_roce_eth_encap, IB_GID_TYPE_ROCE},
 	{rdma_protocol_roce_udp_encap, IB_GID_TYPE_ROCE_UDP_ENCAP},
+	{rdma_protocol_virtio, IB_GID_TYPE_ROCE_UDP_ENCAP},
 };
 
 #define CAP_TO_GID_TABLE_SIZE	ARRAY_SIZE(PORT_CAP_TO_GID_TYPE)
@@ -84,7 +85,7 @@ unsigned long roce_gid_type_mask_support(struct ib_device *ib_dev, u32 port)
 	int i;
 	unsigned int ret_flags = 0;
 
-	if (!rdma_protocol_roce(ib_dev, port))
+	if (!rdma_protocol_virtio_or_roce(ib_dev, port))
 		return 1UL << IB_GID_TYPE_IB;
 
 	for (i = 0; i < CAP_TO_GID_TABLE_SIZE; i++)
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 2b72c4fa9550..f748db3f0414 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -849,7 +849,7 @@ static ssize_t ucma_query_route(struct ucma_file *file,
 
 	if (rdma_cap_ib_sa(ctx->cm_id->device, ctx->cm_id->port_num))
 		ucma_copy_ib_route(&resp, &ctx->cm_id->route);
-	else if (rdma_protocol_roce(ctx->cm_id->device, ctx->cm_id->port_num))
+	else if (rdma_protocol_virtio_or_roce(ctx->cm_id->device, ctx->cm_id->port_num))
 		ucma_copy_iboe_route(&resp, &ctx->cm_id->route);
 	else if (rdma_protocol_iwarp(ctx->cm_id->device, ctx->cm_id->port_num))
 		ucma_copy_iw_route(&resp, &ctx->cm_id->route);
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 7036967e4c0b..f5037ff0c2e5 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -822,7 +822,7 @@ int ib_init_ah_attr_from_wc(struct ib_device *device, u32 port_num,
 	rdma_ah_set_sl(ah_attr, wc->sl);
 	rdma_ah_set_port_num(ah_attr, port_num);
 
-	if (rdma_protocol_roce(device, port_num)) {
+	if (rdma_protocol_virtio_or_roce(device, port_num)) {
 		u16 vlan_id = wc->wc_flags & IB_WC_WITH_VLAN ?
 				wc->vlan_id : 0xffff;
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 371df1c80aeb..779d4d09aec1 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -623,6 +623,7 @@ static inline struct rdma_hw_stats *rdma_alloc_hw_stats_struct(
 #define RDMA_CORE_CAP_PROT_ROCE_UDP_ENCAP 0x00800000
 #define RDMA_CORE_CAP_PROT_RAW_PACKET   0x01000000
 #define RDMA_CORE_CAP_PROT_USNIC        0x02000000
+#define RDMA_CORE_CAP_PROT_VIRTIO		0x04000000
 
 #define RDMA_CORE_PORT_IB_GRH_REQUIRED (RDMA_CORE_CAP_IB_GRH_REQUIRED \
 					| RDMA_CORE_CAP_PROT_ROCE     \
@@ -654,6 +655,14 @@ static inline struct rdma_hw_stats *rdma_alloc_hw_stats_struct(
 
 #define RDMA_CORE_PORT_USNIC		(RDMA_CORE_CAP_PROT_USNIC)
 
+/* in most time, RDMA_CORE_PORT_VIRTIO is same as RDMA_CORE_PORT_IBA_ROCE_UDP_ENCAP */
+#define RDMA_CORE_PORT_VIRTIO    \
+                    (RDMA_CORE_CAP_PROT_VIRTIO \
+					| RDMA_CORE_CAP_IB_MAD  \
+					| RDMA_CORE_CAP_IB_CM   \
+					| RDMA_CORE_CAP_AF_IB   \
+					| RDMA_CORE_CAP_ETH_AH)
+
 struct ib_port_attr {
 	u64			subnet_prefix;
 	enum ib_port_state	state;
@@ -3031,6 +3040,18 @@ static inline bool rdma_protocol_ib(const struct ib_device *device,
 	       RDMA_CORE_CAP_PROT_IB;
 }
 
+static inline bool rdma_protocol_virtio(const struct ib_device *device, u8 port_num)
+{
+	return device->port_data[port_num].immutable.core_cap_flags &
+	       RDMA_CORE_CAP_PROT_VIRTIO;
+}
+
+static inline bool rdma_protocol_virtio_or_roce(const struct ib_device *device, u8 port_num)
+{
+	return device->port_data[port_num].immutable.core_cap_flags &
+	       (RDMA_CORE_CAP_PROT_VIRTIO | RDMA_CORE_CAP_PROT_ROCE | RDMA_CORE_CAP_PROT_ROCE_UDP_ENCAP);
+}
+
 static inline bool rdma_protocol_roce(const struct ib_device *device,
 				      u32 port_num)
 {
@@ -3063,7 +3084,8 @@ static inline bool rdma_ib_or_roce(const struct ib_device *device,
 				   u32 port_num)
 {
 	return rdma_protocol_ib(device, port_num) ||
-		rdma_protocol_roce(device, port_num);
+		rdma_protocol_roce(device, port_num) ||
+		rdma_protocol_virtio(device, port_num);
 }
 
 static inline bool rdma_protocol_raw_packet(const struct ib_device *device,
@@ -3322,7 +3344,7 @@ static inline size_t rdma_max_mad_size(const struct ib_device *device,
 static inline bool rdma_cap_roce_gid_table(const struct ib_device *device,
 					   u32 port_num)
 {
-	return rdma_protocol_roce(device, port_num) &&
+	return rdma_protocol_virtio_or_roce(device, port_num) &&
 		device->ops.add_gid && device->ops.del_gid;
 }
 
@@ -4502,7 +4524,7 @@ void rdma_move_ah_attr(struct rdma_ah_attr *dest, struct rdma_ah_attr *src);
 static inline enum rdma_ah_attr_type rdma_ah_find_type(struct ib_device *dev,
 						       u32 port_num)
 {
-	if (rdma_protocol_roce(dev, port_num))
+	if (rdma_protocol_virtio_or_roce(dev, port_num))
 		return RDMA_AH_ATTR_TYPE_ROCE;
 	if (rdma_protocol_ib(dev, port_num)) {
 		if (rdma_cap_opa_ah(dev, port_num))
-- 
2.11.0

