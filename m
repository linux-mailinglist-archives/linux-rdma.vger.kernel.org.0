Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED94D65CE6F
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jan 2023 09:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbjADIie (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Jan 2023 03:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbjADIiU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Jan 2023 03:38:20 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0385C300
        for <linux-rdma@vger.kernel.org>; Wed,  4 Jan 2023 00:38:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4ED54CE1298
        for <linux-rdma@vger.kernel.org>; Wed,  4 Jan 2023 08:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17332C433D2;
        Wed,  4 Jan 2023 08:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672821495;
        bh=nQG7kLpEciEzfWvg0b5TDb5KAajZYaL1eJaByq7aCqY=;
        h=From:To:Cc:Subject:Date:From;
        b=V9PIS2GmTjlkQaOGLgtA4qxCL8ehHlryQCPYIDg2ekXaSd8qB2a+pOxAP7Cyl+lCU
         pvEQAiTHbV/SLsAXykukLvhbhrk+peCjy6gFsdl6MBGwy8kxhOZSbtmaScpUGR45s8
         Am5meJ873+nerNBKA1W2dT0bXu2iM6uEO2I1vPJTnqwfxwqLE96KZtxNdBthYqwFVm
         aOz8KnQepfTkpKF6lwbls2x3CFcs3GWZHi/97vM2QElhgpxlC93x6FNyTRmncCPSno
         uddDj0lbRBSzqhqjfc1KFK6j+TNCOaih1VOWW1YLY1jzXztOX97svqtCzUUBcxN62/
         /h7YB8dMJ55gw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org,
        syzbot+8fcbb77276d43cc8b693@syzkaller.appspotmail.com
Subject: [PATCH rdma-rc] RDMA/cma: Allow UD qp_type to join multicast only
Date:   Wed,  4 Jan 2023 10:38:09 +0200
Message-Id: <236616934e3b6485428671d482d131175f5c1cdd.1672821452.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.38.1
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

Only UD qp_type is allowed to join multicast.

This patch also fixes an uninit-value error: the ib->rec.qkey field is
accessed without being initialized. This is because multicast join was
allowed for all port spaces, even these that omit qkey.

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

Fixes: b5de0c60cc30 ("RDMA/cma: Fix use after free race in roce multicast join")
Reported-by: syzbot+8fcbb77276d43cc8b693@syzkaller.appspotmail.com
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cma.c | 46 ++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 68721ff10255..02ab9f39a447 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -617,22 +617,11 @@ static inline unsigned short cma_family(struct rdma_id_private *id_priv)
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
@@ -649,9 +638,20 @@ static int cma_set_qkey(struct rdma_id_private *id_priv, u32 qkey)
 	default:
 		break;
 	}
+
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
@@ -1222,7 +1222,7 @@ static int cma_ib_init_qp_attr(struct rdma_id_private *id_priv,
 	*qp_attr_mask = IB_QP_STATE | IB_QP_PKEY_INDEX | IB_QP_PORT;
 
 	if (id_priv->id.qp_type == IB_QPT_UD) {
-		ret = cma_set_qkey(id_priv, 0);
+		ret = cma_set_default_qkey(id_priv);
 		if (ret)
 			return ret;
 
@@ -4551,7 +4551,10 @@ static int cma_send_sidr_rep(struct rdma_id_private *id_priv,
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
@@ -4859,9 +4862,11 @@ static int cma_join_ib_multicast(struct rdma_id_private *id_priv,
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
@@ -4938,8 +4943,8 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
 	cma_iboe_set_mgid(addr, &ib.rec.mgid, gid_type);
 
 	ib.rec.pkey = cpu_to_be16(0xffff);
-	if (id_priv->id.ps == RDMA_PS_UDP)
-		ib.rec.qkey = cpu_to_be32(RDMA_UDP_QKEY);
+	ib.rec.qkey = id_priv->qkey ?
+		cpu_to_be32(id_priv->qkey) : cpu_to_be32(RDMA_UDP_QKEY);
 
 	if (dev_addr->bound_dev_if)
 		ndev = dev_get_by_index(dev_addr->net, dev_addr->bound_dev_if);
@@ -4991,6 +4996,9 @@ int rdma_join_multicast(struct rdma_cm_id *id, struct sockaddr *addr,
 			    READ_ONCE(id_priv->state) != RDMA_CM_ADDR_RESOLVED))
 		return -EINVAL;
 
+	if (id_priv->id.qp_type != IB_QPT_UD)
+		return -EINVAL;
+
 	mc = kzalloc(sizeof(*mc), GFP_KERNEL);
 	if (!mc)
 		return -ENOMEM;
-- 
2.38.1

