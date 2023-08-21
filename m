Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC7F782A16
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Aug 2023 15:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjHUNMu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Aug 2023 09:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbjHUNMt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Aug 2023 09:12:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95867EC;
        Mon, 21 Aug 2023 06:12:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2A898206BC;
        Mon, 21 Aug 2023 13:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692623561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qC3K0GntmmvyP3SrhZ2T0PGnlm8nlXrEXp8klJKww5Y=;
        b=eJ6keGmk7KFTwVWC0WrQXvCLMbdFvCEquWf8JquFX5hkXP/OkWKMzPfhYxBtUoKyFHuhiQ
        c63h+7kf6KJ3Rf82jkPuJxKw1HJWVbkLmDXG+Ckbu5eMr0LWMTm+NWk65nEbGQP6le6pNs
        DJ3LSqpzcfNfcaqxjFRJ4O21VX6u/1s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD232139BC;
        Mon, 21 Aug 2023 13:12:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6P4kNchi42QUVgAAMHmgww
        (envelope-from <petr.pavlu@suse.com>); Mon, 21 Aug 2023 13:12:40 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     tariqt@nvidia.com, yishaih@nvidia.com, leon@kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jgg@ziepe.ca, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH net-next v3 03/11] mlx4: Use 'void *' as the event param of mlx4_dispatch_event()
Date:   Mon, 21 Aug 2023 15:12:17 +0200
Message-Id: <20230821131225.11290-4-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230821131225.11290-1-petr.pavlu@suse.com>
References: <20230821131225.11290-1-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Function mlx4_dispatch_event() takes an 'unsigned long' as its event
parameter. The actual value is none (MLX4_DEV_EVENT_CATASTROPHIC_ERROR),
a pointer to mlx4_eqe (MLX4_DEV_EVENT_PORT_MGMT_CHANGE), or a 32-bit
integer (remaining events).

In preparation to switch mlx4_en and mlx4_ib to be an auxiliary device,
the mlx4_interface.event callback is replaced with a notifier and
function mlx4_dispatch_event() gets updated to invoke
atomic_notifier_call_chain(). This requires forwarding the input 'param'
value from the former function to the latter. A problem is that the
notifier call takes 'void *' as its 'param' value, compared to
'unsigned long' used by mlx4_dispatch_event(). Re-passing the value
would need either punning it to 'void *' or passing down the address of
the input 'param'. Both approaches create a number of unnecessary casts.

Change instead the input 'param' of mlx4_dispatch_event() from
'unsigned long' to 'void *'. A mlx4_eqe pointer can be passed directly,
callers using an int value are adjusted to pass its address.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 drivers/infiniband/hw/mlx4/main.c            | 14 ++++++++++----
 drivers/net/ethernet/mellanox/mlx4/catas.c   |  2 +-
 drivers/net/ethernet/mellanox/mlx4/cmd.c     |  4 ++--
 drivers/net/ethernet/mellanox/mlx4/en_main.c | 17 +++++++++++++++--
 drivers/net/ethernet/mellanox/mlx4/eq.c      | 15 ++++++++-------
 drivers/net/ethernet/mellanox/mlx4/intf.c    |  2 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4.h    |  2 +-
 include/linux/mlx4/driver.h                  |  2 +-
 8 files changed, 39 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 7dd70d778b6b..2c5fd8174b3c 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -3174,7 +3174,7 @@ void mlx4_sched_ib_sl2vl_update_work(struct mlx4_ib_dev *ibdev,
 }
 
 static void mlx4_ib_event(struct mlx4_dev *dev, void *ibdev_ptr,
-			  enum mlx4_dev_event event, unsigned long param)
+			  enum mlx4_dev_event event, void *param)
 {
 	struct ib_event ibev;
 	struct mlx4_ib_dev *ibdev = to_mdev((struct ib_device *) ibdev_ptr);
@@ -3194,10 +3194,16 @@ static void mlx4_ib_event(struct mlx4_dev *dev, void *ibdev_ptr,
 		return;
 	}
 
-	if (event == MLX4_DEV_EVENT_PORT_MGMT_CHANGE)
+	switch (event) {
+	case MLX4_DEV_EVENT_CATASTROPHIC_ERROR:
+		break;
+	case MLX4_DEV_EVENT_PORT_MGMT_CHANGE:
 		eqe = (struct mlx4_eqe *)param;
-	else
-		p = (int) param;
+		break;
+	default:
+		p = *(int *)param;
+		break;
+	}
 
 	switch (event) {
 	case MLX4_DEV_EVENT_PORT_UP:
diff --git a/drivers/net/ethernet/mellanox/mlx4/catas.c b/drivers/net/ethernet/mellanox/mlx4/catas.c
index 0eb7b83637d8..0d8a362c2673 100644
--- a/drivers/net/ethernet/mellanox/mlx4/catas.c
+++ b/drivers/net/ethernet/mellanox/mlx4/catas.c
@@ -194,7 +194,7 @@ void mlx4_enter_error_state(struct mlx4_dev_persistent *persist)
 	mutex_unlock(&persist->device_state_mutex);
 
 	/* At that step HW was already reset, now notify clients */
-	mlx4_dispatch_event(dev, MLX4_DEV_EVENT_CATASTROPHIC_ERROR, 0);
+	mlx4_dispatch_event(dev, MLX4_DEV_EVENT_CATASTROPHIC_ERROR, NULL);
 	mlx4_cmd_wake_completions(dev);
 	return;
 
diff --git a/drivers/net/ethernet/mellanox/mlx4/cmd.c b/drivers/net/ethernet/mellanox/mlx4/cmd.c
index c56d2194cbfc..f5b1f8c7834f 100644
--- a/drivers/net/ethernet/mellanox/mlx4/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx4/cmd.c
@@ -2113,7 +2113,7 @@ static void mlx4_master_do_cmd(struct mlx4_dev *dev, int slave, u8 cmd,
 		if (MLX4_COMM_CMD_FLR == slave_state[slave].last_cmd)
 			goto inform_slave_state;
 
-		mlx4_dispatch_event(dev, MLX4_DEV_EVENT_SLAVE_SHUTDOWN, slave);
+		mlx4_dispatch_event(dev, MLX4_DEV_EVENT_SLAVE_SHUTDOWN, &slave);
 
 		/* write the version in the event field */
 		reply |= mlx4_comm_get_version();
@@ -2152,7 +2152,7 @@ static void mlx4_master_do_cmd(struct mlx4_dev *dev, int slave, u8 cmd,
 		if (mlx4_master_activate_admin_state(priv, slave))
 				goto reset_slave;
 		slave_state[slave].active = true;
-		mlx4_dispatch_event(dev, MLX4_DEV_EVENT_SLAVE_INIT, slave);
+		mlx4_dispatch_event(dev, MLX4_DEV_EVENT_SLAVE_INIT, &slave);
 		break;
 	case MLX4_COMM_CMD_VHCR_POST:
 		if ((slave_state[slave].last_cmd != MLX4_COMM_CMD_VHCR_EN) &&
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_main.c b/drivers/net/ethernet/mellanox/mlx4/en_main.c
index be8ba34c9025..83dae886ade6 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_main.c
@@ -184,10 +184,22 @@ static void mlx4_en_get_profile(struct mlx4_en_dev *mdev)
 }
 
 static void mlx4_en_event(struct mlx4_dev *dev, void *endev_ptr,
-			  enum mlx4_dev_event event, unsigned long port)
+			  enum mlx4_dev_event event, void *param)
 {
 	struct mlx4_en_dev *mdev = (struct mlx4_en_dev *) endev_ptr;
 	struct mlx4_en_priv *priv;
+	int port;
+
+	switch (event) {
+	case MLX4_DEV_EVENT_CATASTROPHIC_ERROR:
+	case MLX4_DEV_EVENT_PORT_MGMT_CHANGE:
+	case MLX4_DEV_EVENT_SLAVE_INIT:
+	case MLX4_DEV_EVENT_SLAVE_SHUTDOWN:
+		break;
+	default:
+		port = *(int *)param;
+		break;
+	}
 
 	switch (event) {
 	case MLX4_DEV_EVENT_PORT_UP:
@@ -205,6 +217,7 @@ static void mlx4_en_event(struct mlx4_dev *dev, void *endev_ptr,
 		mlx4_err(mdev, "Internal error detected, restarting device\n");
 		break;
 
+	case MLX4_DEV_EVENT_PORT_MGMT_CHANGE:
 	case MLX4_DEV_EVENT_SLAVE_INIT:
 	case MLX4_DEV_EVENT_SLAVE_SHUTDOWN:
 		break;
@@ -213,7 +226,7 @@ static void mlx4_en_event(struct mlx4_dev *dev, void *endev_ptr,
 		    !mdev->pndev[port])
 			return;
 		mlx4_warn(mdev, "Unhandled event %d for port %d\n", event,
-			  (int) port);
+			  port);
 	}
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx4/eq.c b/drivers/net/ethernet/mellanox/mlx4/eq.c
index 414e390e6b48..6598b10a9ff4 100644
--- a/drivers/net/ethernet/mellanox/mlx4/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx4/eq.c
@@ -501,7 +501,7 @@ static int mlx4_eq_int(struct mlx4_dev *dev, struct mlx4_eq *eq)
 	int port;
 	int slave = 0;
 	int ret;
-	u32 flr_slave;
+	int flr_slave;
 	u8 update_slave_state;
 	int i;
 	enum slave_port_gen_event gen_event;
@@ -606,8 +606,8 @@ static int mlx4_eq_int(struct mlx4_dev *dev, struct mlx4_eq *eq)
 			port = be32_to_cpu(eqe->event.port_change.port) >> 28;
 			slaves_port = mlx4_phys_to_slaves_pport(dev, port);
 			if (eqe->subtype == MLX4_PORT_CHANGE_SUBTYPE_DOWN) {
-				mlx4_dispatch_event(dev, MLX4_DEV_EVENT_PORT_DOWN,
-						    port);
+				mlx4_dispatch_event(
+					dev, MLX4_DEV_EVENT_PORT_DOWN, &port);
 				mlx4_priv(dev)->sense.do_sense_port[port] = 1;
 				if (!mlx4_is_master(dev))
 					break;
@@ -647,7 +647,8 @@ static int mlx4_eq_int(struct mlx4_dev *dev, struct mlx4_eq *eq)
 					}
 				}
 			} else {
-				mlx4_dispatch_event(dev, MLX4_DEV_EVENT_PORT_UP, port);
+				mlx4_dispatch_event(dev, MLX4_DEV_EVENT_PORT_UP,
+						    &port);
 
 				mlx4_priv(dev)->sense.do_sense_port[port] = 0;
 
@@ -758,7 +759,7 @@ static int mlx4_eq_int(struct mlx4_dev *dev, struct mlx4_eq *eq)
 			}
 			spin_unlock_irqrestore(&priv->mfunc.master.slave_state_lock, flags);
 			mlx4_dispatch_event(dev, MLX4_DEV_EVENT_SLAVE_SHUTDOWN,
-					    flr_slave);
+					    &flr_slave);
 			queue_work(priv->mfunc.master.comm_wq,
 				   &priv->mfunc.master.slave_flr_event_work);
 			break;
@@ -787,8 +788,8 @@ static int mlx4_eq_int(struct mlx4_dev *dev, struct mlx4_eq *eq)
 			break;
 
 		case MLX4_EVENT_TYPE_PORT_MNG_CHG_EVENT:
-			mlx4_dispatch_event(dev, MLX4_DEV_EVENT_PORT_MGMT_CHANGE,
-					    (unsigned long) eqe);
+			mlx4_dispatch_event(
+				dev, MLX4_DEV_EVENT_PORT_MGMT_CHANGE, eqe);
 			break;
 
 		case MLX4_EVENT_TYPE_RECOVERABLE_ERROR_EVENT:
diff --git a/drivers/net/ethernet/mellanox/mlx4/intf.c b/drivers/net/ethernet/mellanox/mlx4/intf.c
index 28d7da925d36..a761971cd0c4 100644
--- a/drivers/net/ethernet/mellanox/mlx4/intf.c
+++ b/drivers/net/ethernet/mellanox/mlx4/intf.c
@@ -180,7 +180,7 @@ int mlx4_do_bond(struct mlx4_dev *dev, bool enable)
 }
 
 void mlx4_dispatch_event(struct mlx4_dev *dev, enum mlx4_dev_event type,
-			 unsigned long param)
+			 void *param)
 {
 	struct mlx4_priv *priv = mlx4_priv(dev);
 	struct mlx4_device_context *dev_ctx;
diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4.h b/drivers/net/ethernet/mellanox/mlx4/mlx4.h
index 6ccf340660d9..de5699a4ddaa 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4.h
@@ -1048,7 +1048,7 @@ int mlx4_restart_one(struct pci_dev *pdev);
 int mlx4_register_device(struct mlx4_dev *dev);
 void mlx4_unregister_device(struct mlx4_dev *dev);
 void mlx4_dispatch_event(struct mlx4_dev *dev, enum mlx4_dev_event type,
-			 unsigned long param);
+			 void *param);
 
 struct mlx4_dev_cap;
 struct mlx4_init_hca_param;
diff --git a/include/linux/mlx4/driver.h b/include/linux/mlx4/driver.h
index 923951e19300..032d7f5bfef6 100644
--- a/include/linux/mlx4/driver.h
+++ b/include/linux/mlx4/driver.h
@@ -58,7 +58,7 @@ struct mlx4_interface {
 	void *			(*add)	 (struct mlx4_dev *dev);
 	void			(*remove)(struct mlx4_dev *dev, void *context);
 	void			(*event) (struct mlx4_dev *dev, void *context,
-					  enum mlx4_dev_event event, unsigned long param);
+					  enum mlx4_dev_event event, void *param);
 	void			(*activate)(struct mlx4_dev *dev, void *context);
 	struct list_head	list;
 	enum mlx4_protocol	protocol;
-- 
2.35.3

