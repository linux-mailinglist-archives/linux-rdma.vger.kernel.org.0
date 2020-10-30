Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A722A0191
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Oct 2020 10:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbgJ3JiZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Oct 2020 05:38:25 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:10106 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgJ3JiZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Oct 2020 05:38:25 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9bdf130000>; Fri, 30 Oct 2020 02:38:27 -0700
Received: from sw-mtx-036.mtx.labs.mlnx (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 30 Oct
 2020 09:38:23 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     <dennis.dalessandro@cornelisnetworks.com>,
        <mike.marciniszyn@cornelisnetworks.com>, <dledford@redhat.com>,
        <jgg@ziepe.ca>, <yanjunz@nvidia.com>, <bmt@zurich.ibm.com>,
        <linux-rdma@vger.kernel.org>
CC:     <hch@lst.de>, Parav Pandit <parav@nvidia.com>,
        <syzbot+34dc2fea3478e659af01@syzkaller.appspotmail.com>
Subject: [PATCH] RDMA: Fix software RDMA drivers for dma mapping error
Date:   Fri, 30 Oct 2020 11:38:03 +0200
Message-ID: <20201030093803.278830-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604050707; bh=D7cUV9bu2QNlHEg/WWDQCoEyg4LG34+8Z5Z86Mq3jEE=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         Content-Transfer-Encoding:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=mgJBUqo/vUTQ3aulX86qxewGQVwwdkIzmUAyjF814tgISI+2FGj26Ih0yJeWf1QQq
         w0cYcJQAuJGtJHX7g9HuI8jZcccLrZpRE+SkdS6mmljg4WCL8zq/MgBDYcU/VHkSFy
         iuCyimCUOtmNYgu4S3c7F4CNOndCDUVCF891xlggetcA76OXK5AUYoSNtBBDzrVhVw
         4qPXQ7NYb+cJMZvoYworDP2A5QLQdDZ+RMylHUVYFrAqXAURoXyEUciBAO0N5dDAwL
         Y7ZWbOkabvymfQ0u/rP/9brhiDWdSmjzBTJ+cP/DAIYmHxp0OLPJBozAkHlaOYMlgR
         7dpANg3mhht3A==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

A cited commit in fixes tag avoided setting dma_mask of the ib_device.
Commit [1] made dma_mask as mandetory field to be setup even for
dma_virt_ops based dma devices. Due to which below call trace occurred.

Fix it by setting empty DMA MASK for software based RDMA devices.

WARNING: CPU: 1 PID: 8488 at kernel/dma/mapping.c:149
dma_map_page_attrs+0x493/0x700 kernel/dma/mapping.c:149 Modules linked in:
CPU: 1 PID: 8488 Comm: syz-executor144 Not tainted 5.9.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 01/01/2011
RIP: 0010:dma_map_page_attrs+0x493/0x700 kernel/dma/mapping.c:149
Trace:
 dma_map_single_attrs include/linux/dma-mapping.h:279 [inline]
ib_dma_map_single include/rdma/ib_verbs.h:3967 [inline]
 ib_mad_post_receive_mads+0x23f/0xd60
drivers/infiniband/core/mad.c:2715
 ib_mad_port_start drivers/infiniband/core/mad.c:2862 [inline]
ib_mad_port_open drivers/infiniband/core/mad.c:3016 [inline]
 ib_mad_init_device+0x72b/0x1400 drivers/infiniband/core/mad.c:3092
 add_client_context+0x405/0x5e0 drivers/infiniband/core/device.c:680
 enable_device_and_get+0x1d5/0x3c0
drivers/infiniband/core/device.c:1301
 ib_register_device drivers/infiniband/core/device.c:1376 [inline]
 ib_register_device+0x7a7/0xa40 drivers/infiniband/core/device.c:1335
 rxe_register_device+0x46d/0x570
drivers/infiniband/sw/rxe/rxe_verbs.c:1182
 rxe_add+0x12fe/0x16d0 drivers/infiniband/sw/rxe/rxe.c:247
 rxe_net_add+0x8c/0xe0 drivers/infiniband/sw/rxe/rxe_net.c:507
 rxe_newlink drivers/infiniband/sw/rxe/rxe.c:269 [inline]
 rxe_newlink+0xb7/0xe0 drivers/infiniband/sw/rxe/rxe.c:250
 nldev_newlink+0x30e/0x540 drivers/infiniband/core/nldev.c:1555
 rdma_nl_rcv_msg+0x367/0x690 drivers/infiniband/core/netlink.c:195
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x2f2/0x440 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1330
 netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1919
sock_sendmsg_nosec net/socket.c:651 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:671
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2353
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2407
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2440
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x443699

[1] commit f959dcd6ddfd ("dma-direct: Fix potential NULL pointer dereferenc=
e")

Reported-by: syzbot+34dc2fea3478e659af01@syzkaller.appspotmail.com
Fixes: e0477b34d9d1 ("RDMA: Explicitly pass in the dma_device to ib_registe=
r_device")
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 drivers/infiniband/sw/rdmavt/vt.c     | 7 +++++--
 drivers/infiniband/sw/rxe/rxe_verbs.c | 6 +++++-
 drivers/infiniband/sw/siw/siw_main.c  | 7 +++++--
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/vt.c b/drivers/infiniband/sw/rdma=
vt/vt.c
index 43fbc4e54edf..5bd817490b1f 100644
--- a/drivers/infiniband/sw/rdmavt/vt.c
+++ b/drivers/infiniband/sw/rdmavt/vt.c
@@ -525,6 +525,7 @@ static noinline int check_support(struct rvt_dev_info *=
rdi, int verb)
 int rvt_register_device(struct rvt_dev_info *rdi)
 {
 	int ret =3D 0, i;
+	u64 dma_mask;
=20
 	if (!rdi)
 		return -EINVAL;
@@ -581,8 +582,10 @@ int rvt_register_device(struct rvt_dev_info *rdi)
=20
 	/* DMA Operations */
 	rdi->ibdev.dev.dma_parms =3D rdi->ibdev.dev.parent->dma_parms;
-	dma_set_coherent_mask(&rdi->ibdev.dev,
-			      rdi->ibdev.dev.parent->coherent_dma_mask);
+	dma_mask =3D IS_ENABLED(CONFIG_64BIT) ? DMA_BIT_MASK(64) : DMA_BIT_MASK(3=
2);
+	ret =3D dma_coerce_mask_and_coherent(&rdi->ibdev.dev, dma_mask);
+	if (ret)
+		goto bail_wss;
=20
 	/* Protection Domain */
 	spin_lock_init(&rdi->n_pds_lock);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/=
rxe/rxe_verbs.c
index 7652d53af2c1..50ad3dded786 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1128,6 +1128,7 @@ int rxe_register_device(struct rxe_dev *rxe, const ch=
ar *ibdev_name)
 	int err;
 	struct ib_device *dev =3D &rxe->ib_dev;
 	struct crypto_shash *tfm;
+	u64 dma_mask;
=20
 	strlcpy(dev->node_desc, "rxe", sizeof(dev->node_desc));
=20
@@ -1140,7 +1141,10 @@ int rxe_register_device(struct rxe_dev *rxe, const c=
har *ibdev_name)
 			    rxe->ndev->dev_addr);
 	dev->dev.dma_parms =3D &rxe->dma_parms;
 	dma_set_max_seg_size(&dev->dev, UINT_MAX);
-	dma_set_coherent_mask(&dev->dev, dma_get_required_mask(&dev->dev));
+	dma_mask =3D IS_ENABLED(CONFIG_64BIT) ? DMA_BIT_MASK(64) : DMA_BIT_MASK(3=
2);
+	err =3D dma_coerce_mask_and_coherent(&dev->dev, dma_mask);
+	if (err)
+		return err;
=20
 	dev->uverbs_cmd_mask |=3D BIT_ULL(IB_USER_VERBS_CMD_REQ_NOTIFY_CQ);
=20
diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/s=
iw/siw_main.c
index e49faefdee92..6fe120187238 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -306,6 +306,7 @@ static struct siw_device *siw_device_create(struct net_=
device *netdev)
 	struct siw_device *sdev =3D NULL;
 	struct ib_device *base_dev;
 	struct device *parent =3D netdev->dev.parent;
+	u64 dma_mask;
 	int rv;
=20
 	if (!parent) {
@@ -360,8 +361,10 @@ static struct siw_device *siw_device_create(struct net=
_device *netdev)
 	base_dev->dev.parent =3D parent;
 	base_dev->dev.dma_parms =3D &sdev->dma_parms;
 	dma_set_max_seg_size(&base_dev->dev, UINT_MAX);
-	dma_set_coherent_mask(&base_dev->dev,
-			      dma_get_required_mask(&base_dev->dev));
+	dma_mask =3D IS_ENABLED(CONFIG_64BIT) ? DMA_BIT_MASK(64) : DMA_BIT_MASK(3=
2);
+	if (dma_coerce_mask_and_coherent(&base_dev->dev, dma_mask))
+		goto error;
+
 	base_dev->num_comp_vectors =3D num_possible_cpus();
=20
 	xa_init_flags(&sdev->qp_xa, XA_FLAGS_ALLOC1);
--=20
2.26.2

