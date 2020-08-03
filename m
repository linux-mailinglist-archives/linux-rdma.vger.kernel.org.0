Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2B2239F93
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Aug 2020 08:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgHCGUG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Aug 2020 02:20:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44856 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgHCGUG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Aug 2020 02:20:06 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0736I47w004664;
        Mon, 3 Aug 2020 06:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=qOfCULXg8ocNmXtj7NefGKgAIkens8RDoKbqhlKMFbg=;
 b=mPg55YcAkhAX4YqTQrnSRDnQz7tP0EYoW8AY2JySH0x7fjY5hiBNOPz2b/BjfOjkFKH5
 e2EkaoaT7lxd8aYXc02W6wbnkwkeE8s1Q5ymCldd7p7ZevH/2DN3yvF1zENrDqSAq14e
 PgA74gTNPTVsaxqKsu9p7ZyzFrCeA9Ojo7Y7gfVszzEreyVAL7gv8m4FaWZ6WJ8YMj85
 HAZrIW6F9qgyoYkcViEOHUmNNUH3/A0BRzgOrVRPQUwZy9urAY3sgSTn9I9AWkB5aqo/
 JUPGFo7JaCsanZRwrIgLtuetB03aH4xAWhRqL6d3d/XR/0Q9KmtO0UT/NfqEC44WBV5f DQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 32nc9yb6qy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 03 Aug 2020 06:20:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0736HdZX168500;
        Mon, 3 Aug 2020 06:19:59 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 32njaugb7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Aug 2020 06:19:59 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0736JwgH006114;
        Mon, 3 Aug 2020 06:19:58 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 02 Aug 2020 23:19:58 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     jgg@mellanox.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, yishaih@mellanox.com,
        jackm@dev.mellanox.co.il, ranro@mellanox.com
Subject: [PATCH for-rc v2 4/6] IB/mlx4: Fix starvation in paravirt mux/demux
Date:   Mon,  3 Aug 2020 08:19:39 +0200
Message-Id: <20200803061941.1139994-5-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200803061941.1139994-1-haakon.bugge@oracle.com>
References: <20200803061941.1139994-1-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9701 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008030045
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9701 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 suspectscore=2 phishscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030045
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The mlx4 driver will proxy MAD packets through the PF driver. A VM or
an instantiated VF will send its MAD packets to the PF driver using
loop-back. The PF driver will be informed by an interrupt, but defer
the handling and polling of CQEs to a worker thread running on an
ordered work-queue.

Consider the following scenario: the VMs will in short proximity in
time, for example due to a network event, send many MAD packets to the
PF driver. Lets say there are K VMs, each sending N packets.

The interrupt from the first VM will start the worker thread, which
will poll N CQEs. A common case here is where the PF driver will
multiplex the packets received from the VMs out on the wire QP.

But before the wire QP has returned a send CQE and associated interrupt,
the other K - 1 VMs have sent their N packets as well.

The PF driver has to multiplex K * N packets out on the wire QP. But
the send-queue on the wire QP has a finite capacity.

So, in this scenario, if K * N is larger than the send-queue capacity
of the wire QP, we will get MAD packets dropped on the floor with this
dynamic debug message:

mlx4_ib_multiplex_mad: failed sending GSI to wire on behalf of slave 2 (-11)

and this despite the fact that the wire send-queue could have
capacity, but the PF driver isn't aware, because the wire send CQEs
have not yet been polled.

We can also have a similar scenario inbound, with a wire recv-queue
larger than the tunnel QP's send-queue. If many remote peers send MAD
packets to the very same VM, the tunnel send-queue destined to the VM
could allegedly be construed to be full by the PF driver.

This starvation is fixed by introducing separate work queues for the
wire QPs vs. the tunnel QPs.

With this fix, using a dual ported HCA, 8 VFs instantiated, we could
run cmtime on each of the 18 interfaces towards a similar configured
peer, each cmtime instance with 800 QPs (all in all 14400 QPs) without
a single CM packet getting lost.

Fixes: 3cf69cc8dbeb ("IB/mlx4: Add CM paravirtualization")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

---
    v1->v2:
	* Massaged commit message
---
 drivers/infiniband/hw/mlx4/mad.c     | 34 +++++++++++++++++++++++++---
 drivers/infiniband/hw/mlx4/mlx4_ib.h |  2 ++
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/mad.c b/drivers/infiniband/hw/mlx4/mad.c
index e1310820352e..8bd16474708f 100644
--- a/drivers/infiniband/hw/mlx4/mad.c
+++ b/drivers/infiniband/hw/mlx4/mad.c
@@ -1297,6 +1297,18 @@ static void mlx4_ib_tunnel_comp_handler(struct ib_cq *cq, void *arg)
 	spin_unlock_irqrestore(&dev->sriov.going_down_lock, flags);
 }
 
+static void mlx4_ib_wire_comp_handler(struct ib_cq *cq, void *arg)
+{
+	unsigned long flags;
+	struct mlx4_ib_demux_pv_ctx *ctx = cq->cq_context;
+	struct mlx4_ib_dev *dev = to_mdev(ctx->ib_dev);
+
+	spin_lock_irqsave(&dev->sriov.going_down_lock, flags);
+	if (!dev->sriov.is_going_down && ctx->state == DEMUX_PV_STATE_ACTIVE)
+		queue_work(ctx->wi_wq, &ctx->work);
+	spin_unlock_irqrestore(&dev->sriov.going_down_lock, flags);
+}
+
 static int mlx4_ib_post_pv_qp_buf(struct mlx4_ib_demux_pv_ctx *ctx,
 				  struct mlx4_ib_demux_pv_qp *tun_qp,
 				  int index)
@@ -1997,7 +2009,8 @@ static int create_pv_resources(struct ib_device *ibdev, int slave, int port,
 		cq_size *= 2;
 
 	cq_attr.cqe = cq_size;
-	ctx->cq = ib_create_cq(ctx->ib_dev, mlx4_ib_tunnel_comp_handler,
+	ctx->cq = ib_create_cq(ctx->ib_dev,
+			       create_tun ? mlx4_ib_tunnel_comp_handler : mlx4_ib_wire_comp_handler,
 			       NULL, ctx, &cq_attr);
 	if (IS_ERR(ctx->cq)) {
 		ret = PTR_ERR(ctx->cq);
@@ -2034,6 +2047,7 @@ static int create_pv_resources(struct ib_device *ibdev, int slave, int port,
 		INIT_WORK(&ctx->work, mlx4_ib_sqp_comp_worker);
 
 	ctx->wq = to_mdev(ibdev)->sriov.demux[port - 1].wq;
+	ctx->wi_wq = to_mdev(ibdev)->sriov.demux[port - 1].wi_wq;
 
 	ret = ib_req_notify_cq(ctx->cq, IB_CQ_NEXT_COMP);
 	if (ret) {
@@ -2177,7 +2191,7 @@ static int mlx4_ib_alloc_demux_ctx(struct mlx4_ib_dev *dev,
 		goto err_mcg;
 	}
 
-	snprintf(name, sizeof name, "mlx4_ibt%d", port);
+	snprintf(name, sizeof(name), "mlx4_ibt%d", port);
 	ctx->wq = alloc_ordered_workqueue(name, WQ_MEM_RECLAIM);
 	if (!ctx->wq) {
 		pr_err("Failed to create tunnelling WQ for port %d\n", port);
@@ -2185,7 +2199,15 @@ static int mlx4_ib_alloc_demux_ctx(struct mlx4_ib_dev *dev,
 		goto err_wq;
 	}
 
-	snprintf(name, sizeof name, "mlx4_ibud%d", port);
+	snprintf(name, sizeof(name), "mlx4_ibwi%d", port);
+	ctx->wi_wq = alloc_ordered_workqueue(name, WQ_MEM_RECLAIM);
+	if (!ctx->wi_wq) {
+		pr_err("Failed to create wire WQ for port %d\n", port);
+		ret = -ENOMEM;
+		goto err_wiwq;
+	}
+
+	snprintf(name, sizeof(name), "mlx4_ibud%d", port);
 	ctx->ud_wq = alloc_ordered_workqueue(name, WQ_MEM_RECLAIM);
 	if (!ctx->ud_wq) {
 		pr_err("Failed to create up/down WQ for port %d\n", port);
@@ -2196,6 +2218,10 @@ static int mlx4_ib_alloc_demux_ctx(struct mlx4_ib_dev *dev,
 	return 0;
 
 err_udwq:
+	destroy_workqueue(ctx->wi_wq);
+	ctx->wi_wq = NULL;
+
+err_wiwq:
 	destroy_workqueue(ctx->wq);
 	ctx->wq = NULL;
 
@@ -2243,12 +2269,14 @@ static void mlx4_ib_free_demux_ctx(struct mlx4_ib_demux_ctx *ctx)
 				ctx->tun[i]->state = DEMUX_PV_STATE_DOWNING;
 		}
 		flush_workqueue(ctx->wq);
+		flush_workqueue(ctx->wi_wq);
 		for (i = 0; i < dev->dev->caps.sqp_demux; i++) {
 			destroy_pv_resources(dev, i, ctx->port, ctx->tun[i], 0);
 			free_pv_object(dev, i, ctx->port);
 		}
 		kfree(ctx->tun);
 		destroy_workqueue(ctx->ud_wq);
+		destroy_workqueue(ctx->wi_wq);
 		destroy_workqueue(ctx->wq);
 	}
 }
diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
index a0b0fcb814d9..8686f8ce7529 100644
--- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
+++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
@@ -455,6 +455,7 @@ struct mlx4_ib_demux_pv_ctx {
 	struct ib_pd *pd;
 	struct work_struct work;
 	struct workqueue_struct *wq;
+	struct workqueue_struct *wi_wq;
 	struct mlx4_ib_demux_pv_qp qp[2];
 };
 
@@ -462,6 +463,7 @@ struct mlx4_ib_demux_ctx {
 	struct ib_device *ib_dev;
 	int port;
 	struct workqueue_struct *wq;
+	struct workqueue_struct *wi_wq;
 	struct workqueue_struct *ud_wq;
 	spinlock_t ud_lock;
 	atomic64_t subnet_prefix;
-- 
2.20.1

