Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F0A6C102D
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Mar 2023 12:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjCTLFe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Mar 2023 07:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjCTLFB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Mar 2023 07:05:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881B37A80
        for <linux-rdma@vger.kernel.org>; Mon, 20 Mar 2023 04:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D85776146B
        for <linux-rdma@vger.kernel.org>; Mon, 20 Mar 2023 11:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B941C4339B;
        Mon, 20 Mar 2023 11:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679310001;
        bh=QwdrVWu7aRCD3mLmRJ0OkuyM3YfyvgGtSusVoGqPmAA=;
        h=From:To:Cc:Subject:Date:From;
        b=cm+jTc/UKfH4LUKCR06IX8IxhJNa5wHMvKGYAWz1SWNU/DgrAdCLNonccpe0tyLIv
         QnSf12F2OrpnS7t3YyxPG6REhnF4bi0HgoPJnqKdsN3F/cgpyM+bYKsOBeneoQZBBY
         2Zpepofk5Oil7GUM/zxAHHlvLgkWaDKXoo8UI0PLgVB2o6gELDZ63MYwwarx3eWNXh
         UO2ngSKKTcEfd1Y7h0no/UMwAOfzP9SYVK1XOUYACXJSNMvcoq/n48wF/C/lmuvfXs
         5eiRV+e0OUD4rBBtpK7VCLKqho3MoT4sWjbP3PsPgFQJHIiAIxJ1hgnhijMjC18wZ6
         EHINyUJyoulow==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org,
        syzbot+8fcbb77276d43cc8b693@syzkaller.appspotmail.com
Subject: [PATCH rdma-rc v1] RDMA/cma: Allow UD qp_type to join multicast only
Date:   Mon, 20 Mar 2023 12:59:55 +0200
Message-Id: <58a4a98323b5e6b1282e83f6b76960d06e43b9fa.1679309909.git.leon@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

As for multicast:
- The SIDR is the only mode that makes sense;
- Besides PS_UDP, other port spaces like PS_IB is also allowed, as it is
  UD compatible. In this case qkey also needs to be set [1].

This patch allows only UD qp_type to join multicast, and set qkey to
default if it's not set, to fix an uninit-value error: the ib->rec.qkey
field is accessed without being initialized.

=====================================================
BUG: KMSAN: uninit-value in cma_set_qkey drivers/infiniband/core/cma.c:510 [inline]
BUG: KMSAN: uninit-value in cma_make_mc_event+0xb73/0xe00 drivers/infiniband/core/cma.c:4570
 cma_set_qkey drivers/infiniband/core/cma.c:510 [inline]
 cma_make_mc_event+0xb73/0xe00 drivers/infiniband/core/cma.c:4570
 cma_iboe_join_multicast drivers/infiniband/core/cma.c:4782 [inline]
 rdma_join_multicast+0x2b83/0x30a0 drivers/infiniband/core/cma.c:4814
 ucma_process_join+0xa76/0xf60 drivers/infiniband/core/ucma.c:1479
 ucma_join_multicast+0x1e3/0x250 drivers/infiniband/core/ucma.c:1546
 ucma_write+0x639/0x6d0 drivers/infiniband/core/ucma.c:1732
 vfs_write+0x8ce/0x2030 fs/read_write.c:588
 ksys_write+0x28c/0x520 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __ia32_sys_write+0xdb/0x120 fs/read_write.c:652
 do_syscall_32_irqs_on arch/x86/entry/common.c:114 [inline]
 __do_fast_syscall_32+0x96/0xf0 arch/x86/entry/common.c:180
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Local variable ib.i created at:
cma_iboe_join_multicast drivers/infiniband/core/cma.c:4737 [inline]
rdma_join_multicast+0x586/0x30a0 drivers/infiniband/core/cma.c:4814
ucma_process_join+0xa76/0xf60 drivers/infiniband/core/ucma.c:1479

CPU: 0 PID: 29874 Comm: syz-executor.3 Not tainted 5.16.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
=====================================================

[1] https://lore.kernel.org/linux-rdma/20220117183832.GD84788@nvidia.com/

Fixes: b5de0c60cc30 ("RDMA/cma: Fix use after free race in roce multicast join")
Reported-by: syzbot+8fcbb77276d43cc8b693@syzkaller.appspotmail.com
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Changelog
v1:
 * Squashed Jason's changes.
v0: https://lore.kernel.org/all/236616934e3b6485428671d482d131175f5c1cdd.1672821452.git.leonro@nvidia.com
---
 drivers/infiniband/core/cma.c | 60 ++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 308155937713..6b9563d4f23c 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -624,22 +624,11 @@ static inline unsigned short cma_family(struct rdma_id_private *id_priv)
 	return id_priv->id.route.addr.src_addr.ss_family;
 }
 
-static int cma_set_qkey(struct rdma_id_private *id_priv, u32 qkey)
+static int cma_set_default_qkey(struct rdma_id_private *id_priv)
 {
 	struct ib_sa_mcmember_rec rec;
 	int ret = 0;
 
-	if (id_priv->qkey) {
-		if (qkey && id_priv->qkey != qkey)
-			return -EINVAL;
-		return 0;
-	}
-
-	if (qkey) {
-		id_priv->qkey = qkey;
-		return 0;
-	}
-
 	switch (id_priv->id.ps) {
 	case RDMA_PS_UDP:
 	case RDMA_PS_IB:
@@ -659,6 +648,16 @@ static int cma_set_qkey(struct rdma_id_private *id_priv, u32 qkey)
 	return ret;
 }
 
+static int cma_set_qkey(struct rdma_id_private *id_priv, u32 qkey)
+{
+	if (!qkey ||
+	    (id_priv->qkey && (id_priv->qkey != qkey)))
+		return -EINVAL;
+
+	id_priv->qkey = qkey;
+	return 0;
+}
+
 static void cma_translate_ib(struct sockaddr_ib *sib, struct rdma_dev_addr *dev_addr)
 {
 	dev_addr->dev_type = ARPHRD_INFINIBAND;
@@ -1229,7 +1228,7 @@ static int cma_ib_init_qp_attr(struct rdma_id_private *id_priv,
 	*qp_attr_mask = IB_QP_STATE | IB_QP_PKEY_INDEX | IB_QP_PORT;
 
 	if (id_priv->id.qp_type == IB_QPT_UD) {
-		ret = cma_set_qkey(id_priv, 0);
+		ret = cma_set_default_qkey(id_priv);
 		if (ret)
 			return ret;
 
@@ -4569,7 +4568,10 @@ static int cma_send_sidr_rep(struct rdma_id_private *id_priv,
 	memset(&rep, 0, sizeof rep);
 	rep.status = status;
 	if (status == IB_SIDR_SUCCESS) {
-		ret = cma_set_qkey(id_priv, qkey);
+		if (qkey)
+			ret = cma_set_qkey(id_priv, qkey);
+		else
+			ret = cma_set_default_qkey(id_priv);
 		if (ret)
 			return ret;
 		rep.qp_num = id_priv->qp_num;
@@ -4774,9 +4776,7 @@ static void cma_make_mc_event(int status, struct rdma_id_private *id_priv,
 	enum ib_gid_type gid_type;
 	struct net_device *ndev;
 
-	if (!status)
-		status = cma_set_qkey(id_priv, be32_to_cpu(multicast->rec.qkey));
-	else
+	if (status)
 		pr_debug_ratelimited("RDMA CM: MULTICAST_ERROR: failed to join multicast. status %d\n",
 				     status);
 
@@ -4804,7 +4804,7 @@ static void cma_make_mc_event(int status, struct rdma_id_private *id_priv,
 	}
 
 	event->param.ud.qp_num = 0xFFFFFF;
-	event->param.ud.qkey = be32_to_cpu(multicast->rec.qkey);
+	event->param.ud.qkey = id_priv->qkey;
 
 out:
 	if (ndev)
@@ -4823,8 +4823,11 @@ static int cma_ib_mc_handler(int status, struct ib_sa_multicast *multicast)
 	    READ_ONCE(id_priv->state) == RDMA_CM_DESTROYING)
 		goto out;
 
-	cma_make_mc_event(status, id_priv, multicast, &event, mc);
-	ret = cma_cm_event_handler(id_priv, &event);
+	ret = cma_set_qkey(id_priv, be32_to_cpu(multicast->rec.qkey));
+	if (!ret) {
+		cma_make_mc_event(status, id_priv, multicast, &event, mc);
+		ret = cma_cm_event_handler(id_priv, &event);
+	}
 	rdma_destroy_ah_attr(&event.param.ud.ah_attr);
 	WARN_ON(ret);
 
@@ -4877,9 +4880,11 @@ static int cma_join_ib_multicast(struct rdma_id_private *id_priv,
 	if (ret)
 		return ret;
 
-	ret = cma_set_qkey(id_priv, 0);
-	if (ret)
-		return ret;
+	if (!id_priv->qkey) {
+		ret = cma_set_default_qkey(id_priv);
+		if (ret)
+			return ret;
+	}
 
 	cma_set_mgid(id_priv, (struct sockaddr *) &mc->addr, &rec.mgid);
 	rec.qkey = cpu_to_be32(id_priv->qkey);
@@ -4956,9 +4961,6 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
 	cma_iboe_set_mgid(addr, &ib.rec.mgid, gid_type);
 
 	ib.rec.pkey = cpu_to_be16(0xffff);
-	if (id_priv->id.ps == RDMA_PS_UDP)
-		ib.rec.qkey = cpu_to_be32(RDMA_UDP_QKEY);
-
 	if (dev_addr->bound_dev_if)
 		ndev = dev_get_by_index(dev_addr->net, dev_addr->bound_dev_if);
 	if (!ndev)
@@ -4984,6 +4986,9 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
 	if (err || !ib.rec.mtu)
 		return err ?: -EINVAL;
 
+	if (!id_priv->qkey)
+		cma_set_default_qkey(id_priv);
+
 	rdma_ip2gid((struct sockaddr *)&id_priv->id.route.addr.src_addr,
 		    &ib.rec.port_gid);
 	INIT_WORK(&mc->iboe_join.work, cma_iboe_join_work_handler);
@@ -5009,6 +5014,9 @@ int rdma_join_multicast(struct rdma_cm_id *id, struct sockaddr *addr,
 			    READ_ONCE(id_priv->state) != RDMA_CM_ADDR_RESOLVED))
 		return -EINVAL;
 
+	if (id_priv->id.qp_type != IB_QPT_UD)
+		return -EINVAL;
+
 	mc = kzalloc(sizeof(*mc), GFP_KERNEL);
 	if (!mc)
 		return -ENOMEM;
-- 
2.39.2

