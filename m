Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E645225E75
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jul 2020 14:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgGTMXN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jul 2020 08:23:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52928 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbgGTMXN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Jul 2020 08:23:13 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06KCIWVO138268;
        Mon, 20 Jul 2020 12:23:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=nJUPegOSWINxuKUWZYKo4l3zNYLMoxhXPpc+tGkChwc=;
 b=CxSphOvM3zxxDXD7pFkjGn9dzfTYzbIxsSFgNrlHmHsbP3hpL6zdoCVg8iusxCdpTvvk
 ojw/HtQHmK/MWwDxLDDYuZFNFh7Tr5qw4lr7Rq/Os8nJjvgvzzxwo5nZmTsADFZUYOT7
 1D56R75Wp31e/lSxbsmazQnX5SvP2/xePUmlxtNK8Tc+l+DwaEdTkO3Te3bRMyRCPI7p
 t4AVFTLUanpdsVeq5CYoi+odTNJ5FZgTXGBWX7Cm/7+wQi/cJ/GrfVGgt7iyZmL9t3U8
 1f8YQ125xlAC4hdaz7iK+wMWPAZHDqlO0jaDm3NmDAMZ7bE3i5avhxgzIXMghGf9vd5P xQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 32bs1m6jpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Jul 2020 12:23:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06KCDuFF027181;
        Mon, 20 Jul 2020 12:23:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 32d8kyqmp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jul 2020 12:23:06 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06KCN5oN007150;
        Mon, 20 Jul 2020 12:23:05 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Jul 2020 05:23:05 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Yishai Hadas <yishaih@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>
Subject: [PATCH for-rc 4/5] IB/mlx4: Fix starvation in paravirt mux/demux
Date:   Mon, 20 Jul 2020 14:22:48 +0200
Message-Id: <20200720122249.487086-5-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200720122249.487086-1-haakon.bugge@oracle.com>
References: <20200720122249.487086-1-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9687 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007200085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9687 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007200085
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
the other K - 1 VMs has sent their N packets.

The PF driver will have to multiplex K * N packets out on the wire
QP. But the send-queue on the wire QP has a finite capacity.

So, in this scenario, if K * N is larger that the send-queue capacity
of the wire QP, we will get MAD packets dropped on the floor with this
dynamic debug message:

mlx4_ib_multiplex_mad: failed sending GSI to wire on behalf of slave 2 (-11)

and this despite the fact that the wire send-queue could have
capacity, but the PF driver isn't aware, because the wire send CQEs
have not yet been polled.

We can also have a similar scenario inbound, with a wire recv-queue
larger than the tunnel QP's recv queue. If many remote peers sends MAD
packets to the very same VM, the tunnel send-queue destined to the VM
could overflow.

This starvation is fixed by introducing separate work queues for the
wire QPs vs. the tunnel QPs

With this fix, using a dual ported HCA, 8 VFs instantiated, we could
run cmtime on each of the 18 interfaces towards a similar configured
peer, each cmtime instance with 800 QPs (all in all 14400 QPs) without
a single CM packet getting lost.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/hw/mlx4/mad.c     | 34 +++++++++++++++++++++++++---
 drivers/infiniband/hw/mlx4/mlx4_ib.h |  2 ++
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/mad.c b/drivers/infiniband/hw/mlx4/mad.c
index 336b894de7cf..28bf8ddb019e 100644
--- a/drivers/infiniband/hw/mlx4/mad.c
+++ b/drivers/infiniband/hw/mlx4/mad.c
@@ -1278,6 +1278,18 @@ static void mlx4_ib_tunnel_comp_handler(struct ib_cq *cq, void *arg)
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
@@ -1986,7 +1998,8 @@ static int create_pv_resources(struct ib_device *ibdev, int slave, int port,
 		cq_size *= 2;
 
 	cq_attr.cqe = cq_size;
-	ctx->cq = ib_create_cq(ctx->ib_dev, mlx4_ib_tunnel_comp_handler,
+	ctx->cq = ib_create_cq(ctx->ib_dev,
+			       create_tun ? mlx4_ib_tunnel_comp_handler : mlx4_ib_wire_comp_handler,
 			       NULL, ctx, &cq_attr);
 	if (IS_ERR(ctx->cq)) {
 		ret = PTR_ERR(ctx->cq);
@@ -2023,6 +2036,7 @@ static int create_pv_resources(struct ib_device *ibdev, int slave, int port,
 		INIT_WORK(&ctx->work, mlx4_ib_sqp_comp_worker);
 
 	ctx->wq = to_mdev(ibdev)->sriov.demux[port - 1].wq;
+	ctx->wi_wq = to_mdev(ibdev)->sriov.demux[port - 1].wi_wq;
 
 	ret = ib_req_notify_cq(ctx->cq, IB_CQ_NEXT_COMP);
 	if (ret) {
@@ -2166,7 +2180,7 @@ static int mlx4_ib_alloc_demux_ctx(struct mlx4_ib_dev *dev,
 		goto err_mcg;
 	}
 
-	snprintf(name, sizeof name, "mlx4_ibt%d", port);
+	snprintf(name, sizeof(name), "mlx4_ibt%d", port);
 	ctx->wq = alloc_ordered_workqueue(name, WQ_MEM_RECLAIM);
 	if (!ctx->wq) {
 		pr_err("Failed to create tunnelling WQ for port %d\n", port);
@@ -2174,7 +2188,15 @@ static int mlx4_ib_alloc_demux_ctx(struct mlx4_ib_dev *dev,
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
@@ -2185,6 +2207,10 @@ static int mlx4_ib_alloc_demux_ctx(struct mlx4_ib_dev *dev,
 	return 0;
 
 err_udwq:
+	destroy_workqueue(ctx->wi_wq);
+	ctx->wi_wq = NULL;
+
+err_wiwq:
 	destroy_workqueue(ctx->wq);
 	ctx->wq = NULL;
 
@@ -2232,12 +2258,14 @@ static void mlx4_ib_free_demux_ctx(struct mlx4_ib_demux_ctx *ctx)
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
index 8999fecb045b..20cfa69d0aed 100644
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

