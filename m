Return-Path: <linux-rdma+bounces-910-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 861E584993D
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Feb 2024 12:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A6D32815AF
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Feb 2024 11:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB2B18EAF;
	Mon,  5 Feb 2024 11:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obEKWDma"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C9D18EAD;
	Mon,  5 Feb 2024 11:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707133933; cv=none; b=W1g0kkVOxLCHHlC4iBrOaVdk55aMysEM9GnrvQONZELeoGP+2ldpTLTzvtjTtb3REKeHw/WKYFb5Ox7I7haWtwdGjtE+rwioxzh1bCXOYb0mUuf12fvCLZ6x8XuErpH/skpuuJWFE+QX1WE7USWaBFBeNPmhbT4xq/TW9XWo89I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707133933; c=relaxed/simple;
	bh=8XmIsB+ZUPoKXn0VaHpI1ydb0f+Ah2hw3XmSjMY0xus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ipg4GHiXkifQrTnhi2c1rcX4HBS4EfKyD2hd4Sa/HcRoEvy6fOQbPY2XwF/2XscQJWb5933EF9ncNhVRNwXHiLflckcmaVHjaQTiq/5vVUGxLVKdIt+sTFWdT8ZBpoBWrxOFwe10Kx0DjI3+9phYBLjgMV3AL2u1GmSJMO0QiJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obEKWDma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FD0C433C7;
	Mon,  5 Feb 2024 11:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707133933;
	bh=8XmIsB+ZUPoKXn0VaHpI1ydb0f+Ah2hw3XmSjMY0xus=;
	h=From:Date:Subject:To:Cc:From;
	b=obEKWDmaIwKRPAm7bJdTzrT4JZwpdpii4beE3lTVswTBP/5p0C8BYrUrJ3A7l6t4l
	 251fMfyooTJqkqP3jigUYgkyeOP7xLvhIAR2/mmSHJudsT7bbylNIMoVLWZglQCldM
	 qtqU9hHgP93QCsN25HvPq/08tTHGvLRGrP8T9/CtRU1JI/wMkSPfzV5Ou4MroC08Z2
	 fPFYtLU+mlOL0FiegdZI5I6wpjPdgZhQoQM2mamT/wl4oZ3nluO4R49porOWOhlO2e
	 vSFPPt2e5o3ihHqQ3JPmZHfALOV6B+R4aQoCZX0Ec1FOGOOg2ubkjGAvVnBGYEB5xr
	 XgrVd/Yb8u7XQ==
From: Simon Horman <horms@kernel.org>
Date: Mon, 05 Feb 2024 11:51:57 +0000
Subject: [PATCH net-nex] mlx4: Address spelling errors
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240205-mlx5-codespell-v1-1-63b86dffbb61@kernel.org>
X-B4-Tracking: v=1; b=H4sIANzLwGUC/x3MwQqEIBRG4VeJu+6CShn0KtEi85+ZC2ahEUL07
 sksv8U5N2UkQaaxuSnhkix7rNBtQ+tviV+w+GoyynTKqJ63UHped498IAR2Vg3WGmjtHdXoSPh
 I+Q8nijg5otD8PC99PwI7aQAAAA==
To: Tariq Toukan <tariqt@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Colin Ian King <colin.i.king@gmail.com>, 
 Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org, 
 linux-rdma@vger.kernel.org
X-Mailer: b4 0.12.3

Address spelling errors flagged by codespell.

This patch follows-up on an earlier patch by Colin Ian King,
which addressed a spelling error in a user-visible log message [1].
This patch includes that change.

[1] https://lore.kernel.org/netdev/20231209225135.4055334-1-colin.i.king@gmail.com/

This patch is intended to cover all files under
drivers/net/ethernet/mellanox/mlx4

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx4/cmd.c        | 7 ++++---
 drivers/net/ethernet/mellanox/mlx4/cq.c         | 4 ++--
 drivers/net/ethernet/mellanox/mlx4/en_clock.c   | 4 ++--
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c  | 5 +++--
 drivers/net/ethernet/mellanox/mlx4/en_rx.c      | 2 +-
 drivers/net/ethernet/mellanox/mlx4/en_tx.c      | 2 +-
 drivers/net/ethernet/mellanox/mlx4/eq.c         | 2 +-
 drivers/net/ethernet/mellanox/mlx4/fw_qos.h     | 8 ++++----
 drivers/net/ethernet/mellanox/mlx4/main.c       | 4 ++--
 drivers/net/ethernet/mellanox/mlx4/mlx4_stats.h | 2 +-
 drivers/net/ethernet/mellanox/mlx4/port.c       | 2 +-
 11 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/cmd.c b/drivers/net/ethernet/mellanox/mlx4/cmd.c
index f5b1f8c7834f..7f20813456e2 100644
--- a/drivers/net/ethernet/mellanox/mlx4/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx4/cmd.c
@@ -2199,8 +2199,9 @@ static void mlx4_master_do_cmd(struct mlx4_dev *dev, int slave, u8 cmd,
 	if (cmd != MLX4_COMM_CMD_RESET) {
 		mlx4_warn(dev, "Turn on internal error to force reset, slave=%d, cmd=0x%x\n",
 			  slave, cmd);
-		/* Turn on internal error letting slave reset itself immeditaly,
-		 * otherwise it might take till timeout on command is passed
+		/* Turn on internal error letting slave reset itself
+		 * immediately, otherwise it might take till timeout on
+		 * command is passed
 		 */
 		reply |= ((u32)COMM_CHAN_EVENT_INTERNAL_ERR);
 	}
@@ -2954,7 +2955,7 @@ static bool mlx4_valid_vf_state_change(struct mlx4_dev *dev, int port,
 	dummy_admin.default_vlan = vlan;
 
 	/* VF wants to move to other VST state which is valid with current
-	 * rate limit. Either differnt default vlan in VST or other
+	 * rate limit. Either different default vlan in VST or other
 	 * supported QoS priority. Otherwise we don't allow this change when
 	 * the TX rate is still configured.
 	 */
diff --git a/drivers/net/ethernet/mellanox/mlx4/cq.c b/drivers/net/ethernet/mellanox/mlx4/cq.c
index 4d4f9cf9facb..e130e7259275 100644
--- a/drivers/net/ethernet/mellanox/mlx4/cq.c
+++ b/drivers/net/ethernet/mellanox/mlx4/cq.c
@@ -115,7 +115,7 @@ void mlx4_cq_completion(struct mlx4_dev *dev, u32 cqn)
 		return;
 	}
 
-	/* Acessing the CQ outside of rcu_read_lock is safe, because
+	/* Accessing the CQ outside of rcu_read_lock is safe, because
 	 * the CQ is freed only after interrupt handling is completed.
 	 */
 	++cq->arm_sn;
@@ -137,7 +137,7 @@ void mlx4_cq_event(struct mlx4_dev *dev, u32 cqn, int event_type)
 		return;
 	}
 
-	/* Acessing the CQ outside of rcu_read_lock is safe, because
+	/* Accessing the CQ outside of rcu_read_lock is safe, because
 	 * the CQ is freed only after interrupt handling is completed.
 	 */
 	cq->event(cq, event_type);
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_clock.c b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
index 9e3b76182088..cd754cd76bde 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_clock.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
@@ -96,8 +96,8 @@ void mlx4_en_remove_timestamp(struct mlx4_en_dev *mdev)
 
 #define MLX4_EN_WRAP_AROUND_SEC	10UL
 /* By scheduling the overflow check every 5 seconds, we have a reasonably
- * good chance we wont miss a wrap around.
- * TOTO: Use a timer instead of a work queue to increase the guarantee.
+ * good chance we won't miss a wrap around.
+ * TODO: Use a timer instead of a work queue to increase the guarantee.
  */
 #define MLX4_EN_OVERFLOW_PERIOD (MLX4_EN_WRAP_AROUND_SEC * HZ / 2)
 
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index 33bbcced8105..d7da62cda821 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -1072,7 +1072,8 @@ static void mlx4_en_do_multicast(struct mlx4_en_priv *priv,
 				    1, MLX4_MCAST_CONFIG);
 
 		/* Update multicast list - we cache all addresses so they won't
-		 * change while HW is updated holding the command semaphor */
+		 * change while HW is updated holding the command semaphore
+		 */
 		netif_addr_lock_bh(dev);
 		mlx4_en_cache_mclist(dev);
 		netif_addr_unlock_bh(dev);
@@ -1817,7 +1818,7 @@ int mlx4_en_start_port(struct net_device *dev)
 	    mlx4_en_set_rss_steer_rules(priv))
 		mlx4_warn(mdev, "Failed setting steering rules\n");
 
-	/* Attach rx QP to bradcast address */
+	/* Attach rx QP to broadcast address */
 	eth_broadcast_addr(&mc_list[10]);
 	mc_list[5] = priv->port; /* needed for B0 steering support */
 	if (mlx4_multicast_attach(mdev->dev, priv->rss_map.indir_qp, mc_list,
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index a09b6e05337d..eac49657bd07 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -762,7 +762,7 @@ int mlx4_en_process_rx_cq(struct net_device *dev, struct mlx4_en_cq *cq, int bud
 		/* Drop packet on bad receive or bad checksum */
 		if (unlikely((cqe->owner_sr_opcode & MLX4_CQE_OPCODE_MASK) ==
 						MLX4_CQE_OPCODE_ERROR)) {
-			en_err(priv, "CQE completed in error - vendor syndrom:%d syndrom:%d\n",
+			en_err(priv, "CQE completed in error - vendor syndrome:%d syndrome:%d\n",
 			       ((struct mlx4_err_cqe *)cqe)->vendor_err_syndrome,
 			       ((struct mlx4_err_cqe *)cqe)->syndrome);
 			goto next;
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_tx.c b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
index 65cb63f6c465..1ddb11cb25f9 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
@@ -992,7 +992,7 @@ netdev_tx_t mlx4_en_xmit(struct sk_buff *skb, struct net_device *dev)
 		tx_info->ts_requested = 1;
 	}
 
-	/* Prepare ctrl segement apart opcode+ownership, which depends on
+	/* Prepare ctrl segment apart opcode+ownership, which depends on
 	 * whether LSO is used */
 	tx_desc->ctrl.srcrb_flags = priv->ctrl_flags;
 	if (likely(skb->ip_summed == CHECKSUM_PARTIAL)) {
diff --git a/drivers/net/ethernet/mellanox/mlx4/eq.c b/drivers/net/ethernet/mellanox/mlx4/eq.c
index 6598b10a9ff4..9572a45f6143 100644
--- a/drivers/net/ethernet/mellanox/mlx4/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx4/eq.c
@@ -210,7 +210,7 @@ static void slave_event(struct mlx4_dev *dev, u8 slave, struct mlx4_eqe *eqe)
 
 	memcpy(s_eqe, eqe, sizeof(struct mlx4_eqe) - 1);
 	s_eqe->slave_id = slave;
-	/* ensure all information is written before setting the ownersip bit */
+	/* ensure all information is written before setting the ownership bit */
 	dma_wmb();
 	s_eqe->owner = !!(slave_eq->prod & SLAVE_EVENT_EQ_SIZE) ? 0x0 : 0x80;
 	++slave_eq->prod;
diff --git a/drivers/net/ethernet/mellanox/mlx4/fw_qos.h b/drivers/net/ethernet/mellanox/mlx4/fw_qos.h
index 954b86faac29..40ca29bb928c 100644
--- a/drivers/net/ethernet/mellanox/mlx4/fw_qos.h
+++ b/drivers/net/ethernet/mellanox/mlx4/fw_qos.h
@@ -44,7 +44,7 @@
 /* Default supported priorities for VPP allocation */
 #define MLX4_DEFAULT_QOS_PRIO (0)
 
-/* Derived from FW feature definition, 0 is the default vport fo all QPs */
+/* Derived from FW feature definition, 0 is the default vport for all QPs */
 #define MLX4_VPP_DEFAULT_VPORT (0)
 
 struct mlx4_vport_qos_param {
@@ -98,7 +98,7 @@ int mlx4_SET_PORT_SCHEDULER(struct mlx4_dev *dev, u8 port, u8 *tc_tx_bw,
 int mlx4_ALLOCATE_VPP_get(struct mlx4_dev *dev, u8 port,
 			  u16 *available_vpp, u8 *vpp_p_up);
 /**
- * mlx4_ALLOCATE_VPP_set - Distribution of VPPs among differnt priorities.
+ * mlx4_ALLOCATE_VPP_set - Distribution of VPPs among different priorities.
  * The total number of VPPs assigned to all for a port must not exceed
  * the value reported by available_vpp in mlx4_ALLOCATE_VPP_get.
  * VPP allocation is allowed only after the port type has been set,
@@ -113,7 +113,7 @@ int mlx4_ALLOCATE_VPP_get(struct mlx4_dev *dev, u8 port,
 int mlx4_ALLOCATE_VPP_set(struct mlx4_dev *dev, u8 port, u8 *vpp_p_up);
 
 /**
- * mlx4_SET_VPORT_QOS_get - Query QoS proporties of a Vport.
+ * mlx4_SET_VPORT_QOS_get - Query QoS properties of a Vport.
  * Each priority allowed for the Vport is assigned with a share of the BW,
  * and a BW limitation. This commands query the current QoS values.
  *
@@ -128,7 +128,7 @@ int mlx4_SET_VPORT_QOS_get(struct mlx4_dev *dev, u8 port, u8 vport,
 			   struct mlx4_vport_qos_param *out_param);
 
 /**
- * mlx4_SET_VPORT_QOS_set - Set QoS proporties of a Vport.
+ * mlx4_SET_VPORT_QOS_set - Set QoS properties of a Vport.
  * QoS parameters can be modified at any time, but must be initialized
  * before any QP is associated with the VPort.
  *
diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
index 2581226836b5..7b02ff61126d 100644
--- a/drivers/net/ethernet/mellanox/mlx4/main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/main.c
@@ -129,7 +129,7 @@ static const struct mlx4_profile default_profile = {
 	.num_cq		= 1 << 16,
 	.num_mcg	= 1 << 13,
 	.num_mpt	= 1 << 19,
-	.num_mtt	= 1 << 20, /* It is really num mtt segements */
+	.num_mtt	= 1 << 20, /* It is really num mtt segments */
 };
 
 static const struct mlx4_profile low_mem_profile = {
@@ -1508,7 +1508,7 @@ static int mlx4_port_map_set(struct mlx4_dev *dev, struct mlx4_port_map *v2p)
 			priv->v2p.port1 = port1;
 			priv->v2p.port2 = port2;
 		} else {
-			mlx4_err(dev, "Failed to change port mape: %d\n", err);
+			mlx4_err(dev, "Failed to change port map: %d\n", err);
 		}
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_stats.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_stats.h
index e9cd4bb6f83d..d3d9ec042d2c 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_stats.h
@@ -112,7 +112,7 @@ struct mlx4_en_stat_out_flow_control_mbox {
 	__be64 tx_pause_duration;
 	/* Number of transmitter transitions from XOFF state to XON state */
 	__be64 tx_pause_transition;
-	/* Reserverd */
+	/* Reserved */
 	__be64 reserved[2];
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlx4/port.c b/drivers/net/ethernet/mellanox/mlx4/port.c
index 256a06b3c096..4e43f4a7d246 100644
--- a/drivers/net/ethernet/mellanox/mlx4/port.c
+++ b/drivers/net/ethernet/mellanox/mlx4/port.c
@@ -2118,7 +2118,7 @@ static void mlx4_qsfp_eeprom_params_set(u8 *i2c_addr, u8 *page_num, u16 *offset)
  * @data: output buffer to put the requested data into.
  *
  * Reads cable module eeprom data, puts the outcome data into
- * data pointer paramer.
+ * data pointer parameter.
  * Returns num of read bytes on success or a negative error
  * code.
  */


