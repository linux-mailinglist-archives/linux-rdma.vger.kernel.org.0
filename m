Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BEB239F92
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Aug 2020 08:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgHCGUD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Aug 2020 02:20:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34132 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgHCGUD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Aug 2020 02:20:03 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0736HBcp142661;
        Mon, 3 Aug 2020 06:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=GZ5UXRh9FWih7sJ/lTmXSRFsZen8gkMAKWJ5EPzrzmY=;
 b=f+HuxbLrJz2SF++TxzipYxDDyMg8qcEV5sD8Z5nHosyuQzwL9iRtdxqe9YyODOCU0Dia
 zNDBMDb1EnG5shGaNYsgGm17HPzO61ajllUc+Tnis3hXH6Pmq2ScUmFUPZdO1gabOR05
 xKt53qFPqKjF1zSWDVA0SDoMNu+VofKOXxX+e3IsadwBhPFUUOa/g8IRgoAkt8q8Tffs
 S78NmVKF6nJwibWYCNX1pfoBJGvuMlYfUZmWZr+PeUw211Egb3oB2Qvc+PQOZiqv1hGh
 m/h3DfcqV00VLs9KC0qL4jB/ln/33S7hBuNHB54P3jDMUY4evkywc7Rg/MLQT5Pm7r7K IA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 32mytqvp94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 03 Aug 2020 06:19:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0736Hdpo168473;
        Mon, 3 Aug 2020 06:19:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 32njaugb6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Aug 2020 06:19:57 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0736JuOU006504;
        Mon, 3 Aug 2020 06:19:56 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 02 Aug 2020 23:19:56 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     jgg@mellanox.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, yishaih@mellanox.com,
        jackm@dev.mellanox.co.il, ranro@mellanox.com
Subject: [PATCH for-rc v2 3/6] IB/mlx4: Separate tunnel and wire bufs parameters
Date:   Mon,  3 Aug 2020 08:19:38 +0200
Message-Id: <20200803061941.1139994-4-haakon.bugge@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=2
 adultscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008030045
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Using CX-3 in virtualized mode, MAD packets are proxied through the PF
driver. The feed is N tunnel QPs, and what is received from the VFs is
multiplexed out on the wire QP. Since this is a many-to-one scenario,
it is better to have separate initialization parameters for the two
usages.

The number of wire and tunnel bufs are yanked up to 2K and 512
respectively. With this set of parameters, a system consisting of
eight physical servers, each with eight VMs and 14 I/O servers (BM),
can run switch fail-over without seeing:

mlx4_ib_demux_mad: failed sending GSI to slave 3 via tunnel qp (-11)

or

mlx4_ib_multiplex_mad: failed sending GSI to wire on behalf of slave 2 (-11)

Fixes: 3cf69cc8dbeb ("IB/mlx4: Add CM paravirtualization")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

---
    v1 -> v2:
	* Increased number of tunnel buffers to 512
---
 drivers/infiniband/hw/mlx4/mad.c     | 44 +++++++++++++++-------------
 drivers/infiniband/hw/mlx4/mlx4_ib.h |  3 +-
 2 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/mad.c b/drivers/infiniband/hw/mlx4/mad.c
index 932786b0689e..e1310820352e 100644
--- a/drivers/infiniband/hw/mlx4/mad.c
+++ b/drivers/infiniband/hw/mlx4/mad.c
@@ -1391,10 +1391,10 @@ int mlx4_ib_send_to_wire(struct mlx4_ib_dev *dev, int slave, u8 port,
 
 	spin_lock(&sqp->tx_lock);
 	if (sqp->tx_ix_head - sqp->tx_ix_tail >=
-	    (MLX4_NUM_TUNNEL_BUFS - 1))
+	    (MLX4_NUM_WIRE_BUFS - 1))
 		ret = -EAGAIN;
 	else
-		wire_tx_ix = (++sqp->tx_ix_head) & (MLX4_NUM_TUNNEL_BUFS - 1);
+		wire_tx_ix = (++sqp->tx_ix_head) & (MLX4_NUM_WIRE_BUFS - 1);
 	spin_unlock(&sqp->tx_lock);
 	if (ret)
 		goto out;
@@ -1590,19 +1590,20 @@ static int mlx4_ib_alloc_pv_bufs(struct mlx4_ib_demux_pv_ctx *ctx,
 	int i;
 	struct mlx4_ib_demux_pv_qp *tun_qp;
 	int rx_buf_size, tx_buf_size;
+	const int nmbr_bufs = is_tun ? MLX4_NUM_TUNNEL_BUFS : MLX4_NUM_WIRE_BUFS;
 
 	if (qp_type > IB_QPT_GSI)
 		return -EINVAL;
 
 	tun_qp = &ctx->qp[qp_type];
 
-	tun_qp->ring = kcalloc(MLX4_NUM_TUNNEL_BUFS,
+	tun_qp->ring = kcalloc(nmbr_bufs,
 			       sizeof(struct mlx4_ib_buf),
 			       GFP_KERNEL);
 	if (!tun_qp->ring)
 		return -ENOMEM;
 
-	tun_qp->tx_ring = kcalloc(MLX4_NUM_TUNNEL_BUFS,
+	tun_qp->tx_ring = kcalloc(nmbr_bufs,
 				  sizeof (struct mlx4_ib_tun_tx_buf),
 				  GFP_KERNEL);
 	if (!tun_qp->tx_ring) {
@@ -1619,7 +1620,7 @@ static int mlx4_ib_alloc_pv_bufs(struct mlx4_ib_demux_pv_ctx *ctx,
 		tx_buf_size = sizeof (struct mlx4_mad_snd_buf);
 	}
 
-	for (i = 0; i < MLX4_NUM_TUNNEL_BUFS; i++) {
+	for (i = 0; i < nmbr_bufs; i++) {
 		tun_qp->ring[i].addr = kmalloc(rx_buf_size, GFP_KERNEL);
 		if (!tun_qp->ring[i].addr)
 			goto err;
@@ -1633,7 +1634,7 @@ static int mlx4_ib_alloc_pv_bufs(struct mlx4_ib_demux_pv_ctx *ctx,
 		}
 	}
 
-	for (i = 0; i < MLX4_NUM_TUNNEL_BUFS; i++) {
+	for (i = 0; i < nmbr_bufs; i++) {
 		tun_qp->tx_ring[i].buf.addr =
 			kmalloc(tx_buf_size, GFP_KERNEL);
 		if (!tun_qp->tx_ring[i].buf.addr)
@@ -1664,7 +1665,7 @@ static int mlx4_ib_alloc_pv_bufs(struct mlx4_ib_demux_pv_ctx *ctx,
 				    tx_buf_size, DMA_TO_DEVICE);
 		kfree(tun_qp->tx_ring[i].buf.addr);
 	}
-	i = MLX4_NUM_TUNNEL_BUFS;
+	i = nmbr_bufs;
 err:
 	while (i > 0) {
 		--i;
@@ -1685,6 +1686,7 @@ static void mlx4_ib_free_pv_qp_bufs(struct mlx4_ib_demux_pv_ctx *ctx,
 	int i;
 	struct mlx4_ib_demux_pv_qp *tun_qp;
 	int rx_buf_size, tx_buf_size;
+	const int nmbr_bufs = is_tun ? MLX4_NUM_TUNNEL_BUFS : MLX4_NUM_WIRE_BUFS;
 
 	if (qp_type > IB_QPT_GSI)
 		return;
@@ -1699,13 +1701,13 @@ static void mlx4_ib_free_pv_qp_bufs(struct mlx4_ib_demux_pv_ctx *ctx,
 	}
 
 
-	for (i = 0; i < MLX4_NUM_TUNNEL_BUFS; i++) {
+	for (i = 0; i < nmbr_bufs; i++) {
 		ib_dma_unmap_single(ctx->ib_dev, tun_qp->ring[i].map,
 				    rx_buf_size, DMA_FROM_DEVICE);
 		kfree(tun_qp->ring[i].addr);
 	}
 
-	for (i = 0; i < MLX4_NUM_TUNNEL_BUFS; i++) {
+	for (i = 0; i < nmbr_bufs; i++) {
 		ib_dma_unmap_single(ctx->ib_dev, tun_qp->tx_ring[i].buf.map,
 				    tx_buf_size, DMA_TO_DEVICE);
 		kfree(tun_qp->tx_ring[i].buf.addr);
@@ -1785,6 +1787,7 @@ static int create_pv_sqp(struct mlx4_ib_demux_pv_ctx *ctx,
 	struct mlx4_ib_qp_tunnel_init_attr qp_init_attr;
 	struct ib_qp_attr attr;
 	int qp_attr_mask_INIT;
+	const int nmbr_bufs = create_tun ? MLX4_NUM_TUNNEL_BUFS : MLX4_NUM_WIRE_BUFS;
 
 	if (qp_type > IB_QPT_GSI)
 		return -EINVAL;
@@ -1795,8 +1798,8 @@ static int create_pv_sqp(struct mlx4_ib_demux_pv_ctx *ctx,
 	qp_init_attr.init_attr.send_cq = ctx->cq;
 	qp_init_attr.init_attr.recv_cq = ctx->cq;
 	qp_init_attr.init_attr.sq_sig_type = IB_SIGNAL_ALL_WR;
-	qp_init_attr.init_attr.cap.max_send_wr = MLX4_NUM_TUNNEL_BUFS;
-	qp_init_attr.init_attr.cap.max_recv_wr = MLX4_NUM_TUNNEL_BUFS;
+	qp_init_attr.init_attr.cap.max_send_wr = nmbr_bufs;
+	qp_init_attr.init_attr.cap.max_recv_wr = nmbr_bufs;
 	qp_init_attr.init_attr.cap.max_send_sge = 1;
 	qp_init_attr.init_attr.cap.max_recv_sge = 1;
 	if (create_tun) {
@@ -1858,7 +1861,7 @@ static int create_pv_sqp(struct mlx4_ib_demux_pv_ctx *ctx,
 		goto err_qp;
 	}
 
-	for (i = 0; i < MLX4_NUM_TUNNEL_BUFS; i++) {
+	for (i = 0; i < nmbr_bufs; i++) {
 		ret = mlx4_ib_post_pv_qp_buf(ctx, tun_qp, i);
 		if (ret) {
 			pr_err(" mlx4_ib_post_pv_buf error"
@@ -1894,8 +1897,8 @@ static void mlx4_ib_sqp_comp_worker(struct work_struct *work)
 			switch (wc.opcode) {
 			case IB_WC_SEND:
 				kfree(sqp->tx_ring[wc.wr_id &
-				      (MLX4_NUM_TUNNEL_BUFS - 1)].ah);
-				sqp->tx_ring[wc.wr_id & (MLX4_NUM_TUNNEL_BUFS - 1)].ah
+				      (MLX4_NUM_WIRE_BUFS - 1)].ah);
+				sqp->tx_ring[wc.wr_id & (MLX4_NUM_WIRE_BUFS - 1)].ah
 					= NULL;
 				spin_lock(&sqp->tx_lock);
 				sqp->tx_ix_tail++;
@@ -1904,13 +1907,13 @@ static void mlx4_ib_sqp_comp_worker(struct work_struct *work)
 			case IB_WC_RECV:
 				mad = (struct ib_mad *) &(((struct mlx4_mad_rcv_buf *)
 						(sqp->ring[wc.wr_id &
-						(MLX4_NUM_TUNNEL_BUFS - 1)].addr))->payload);
+						(MLX4_NUM_WIRE_BUFS - 1)].addr))->payload);
 				grh = &(((struct mlx4_mad_rcv_buf *)
 						(sqp->ring[wc.wr_id &
-						(MLX4_NUM_TUNNEL_BUFS - 1)].addr))->grh);
+						(MLX4_NUM_WIRE_BUFS - 1)].addr))->grh);
 				mlx4_ib_demux_mad(ctx->ib_dev, ctx->port, &wc, grh, mad);
 				if (mlx4_ib_post_pv_qp_buf(ctx, sqp, wc.wr_id &
-							   (MLX4_NUM_TUNNEL_BUFS - 1)))
+							   (MLX4_NUM_WIRE_BUFS - 1)))
 					pr_err("Failed reposting SQP "
 					       "buf:%lld\n", wc.wr_id);
 				break;
@@ -1923,8 +1926,8 @@ static void mlx4_ib_sqp_comp_worker(struct work_struct *work)
 				 ctx->slave, wc.status, wc.wr_id);
 			if (!MLX4_TUN_IS_RECV(wc.wr_id)) {
 				kfree(sqp->tx_ring[wc.wr_id &
-				      (MLX4_NUM_TUNNEL_BUFS - 1)].ah);
-				sqp->tx_ring[wc.wr_id & (MLX4_NUM_TUNNEL_BUFS - 1)].ah
+				      (MLX4_NUM_WIRE_BUFS - 1)].ah);
+				sqp->tx_ring[wc.wr_id & (MLX4_NUM_WIRE_BUFS - 1)].ah
 					= NULL;
 				spin_lock(&sqp->tx_lock);
 				sqp->tx_ix_tail++;
@@ -1964,6 +1967,7 @@ static int create_pv_resources(struct ib_device *ibdev, int slave, int port,
 {
 	int ret, cq_size;
 	struct ib_cq_init_attr cq_attr = {};
+	const int nmbr_bufs = create_tun ? MLX4_NUM_TUNNEL_BUFS : MLX4_NUM_WIRE_BUFS;
 
 	if (ctx->state != DEMUX_PV_STATE_DOWN)
 		return -EEXIST;
@@ -1988,7 +1992,7 @@ static int create_pv_resources(struct ib_device *ibdev, int slave, int port,
 		goto err_out_qp0;
 	}
 
-	cq_size = 2 * MLX4_NUM_TUNNEL_BUFS;
+	cq_size = 2 * nmbr_bufs;
 	if (ctx->has_smi)
 		cq_size *= 2;
 
diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
index 6f4ea1067095..a0b0fcb814d9 100644
--- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
+++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
@@ -233,7 +233,8 @@ enum mlx4_ib_mad_ifc_flags {
 };
 
 enum {
-	MLX4_NUM_TUNNEL_BUFS		= 256,
+	MLX4_NUM_TUNNEL_BUFS		= 512,
+	MLX4_NUM_WIRE_BUFS		= 2048,
 };
 
 struct mlx4_ib_tunnel_header {
-- 
2.20.1

